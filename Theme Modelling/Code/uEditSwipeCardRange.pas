unit uEditSwipeCardRange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Mask, wwdbedit, Wwdbspin, wwdblook,
  ExtCtrls, ActnList;

type
  TDisableControlsProc = procedure(ParentControl: TWinControl);

  TLoyaltyMethod = class
    private
      FID: Integer;
      FLoyaltyMethodName: String;
    public
      constructor Create(_ID: Integer; _LoyaltyMethodName: String);
      property ID: integer read FID;
      property LoyaltyMethodName: string read FLoyaltyMethodName;
  end;

  TRangeEditDisplayType = (EditRange, AddRange);

  TfrmEditSwipeCardRange = class(TForm)
    dsSwipeCardRange: TDataSource;
    qrySwipeCardRange: TADOQuery;
    qrySwipeCardRangeDescription: TStringField;
    qrySwipeCardRangeTrack: TSmallintField;
    lblDescription: TLabel;
    lblRangeStart: TLabel;
    lblCardTrack: TLabel;
    cmbCardTrack: TComboBox;
    edtDescription: TEdit;
    lblRangeEnd: TLabel;
    btOk: TButton;
    btCancel: TButton;
    edtRangeStart: TEdit;
    edtRangeEnd: TEdit;
    qrySwipeCardRangeStartValue: TStringField;
    qrySwipeCardRangeEndValue: TStringField;
    qrySwipeCardRangeSwipeCardRangeID: TLargeintField;
    qrySwipeCardRangePromotional: TBooleanField;
    qrySwipeCardRangeLoyalty: TBooleanField;
    qrySwipeCardRangeURL: TSmallintField;
    qryThemeButtonURL: TADOQuery;
    alSwipeCardRange: TActionList;
    actLoyalty: TAction;
    pnlLoyalty: TPanel;
    cmbbxName: TComboBox;
    lblLoyaltyName: TLabel;
    bvlLoyalty: TBevel;
    cbxLoyaltyCardRange: TCheckBox;
    procedure btOkClick(Sender: TObject);
    procedure edtRangeStartKeyPress(Sender: TObject; var Key: Char);
    procedure edtRangeStartChange(Sender: TObject);
    procedure edtRangeStartEnter(Sender: TObject);
    procedure cbxLoyaltyCardRangeClick(Sender: TObject);
    procedure actLoyaltyExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    SwipeCardRangeID : Integer;
    FisPromotional : Boolean;
    FReadOnly: Boolean;
    FDisableControls: TDisableControlsProc;
    tTempRange : String;
    function overlapsExistingRange(vStart, vEnd : String) : Boolean;
    function hasExceptionsOutSideRange(vStart, vEnd : String) : Boolean;
    function assignedToPromoGroup : boolean;
    procedure BuildLoyaltyURLList;
    procedure SetURL(URLID: Integer);
    procedure SetupGUI;
  public
    { Public declarations }
  end;

procedure ShowSwipeCardRange(aDataSet: TDataSet; DisplayType : TRangeEditDisplayType; ExceptionValue : Variant; isPromotional : Boolean; ReadOnly: Boolean = False; DisableControls: TDisableControlsProc = nil);

implementation

uses uGenerateThemeIDs, useful, uADO_SwipeRange;

{$R *.dfm}

procedure ShowSwipeCardRange(aDataSet: TDataSet; DisplayType : TRangeEditDisplayType; ExceptionValue : Variant; isPromotional : Boolean; ReadOnly: Boolean; DisableControls: TDisableControlsProc);
var
  Dlg : TfrmEditSwipeCardRange;
  StartValueChanged: Boolean;
  EndValueChanged: Boolean;
  DescriptionChanged: Boolean;
  TrackChanged: Boolean;
  LoyaltyChanged: Boolean;
  URLChanged: Boolean;

  procedure addValidationConfig(SwipeCardRangeID : integer);
  begin
    with dmADO_SwipeRange.qRun do
      begin
        SQL.Text := Format(' INSERT INTO CardRangeValidationConfig (RangeID, NoSoapRating, NoSoapMsg, PresentMsg, AbsentMsg) '+
                                                          ' VALUES(%d, 0, NULL, NULL, NULL) ', [SwipeCardRangeID]);
        ExecSQL;
      end;
  end;

  procedure generateExceptionRange(SwipeCardRangeID : Integer);
  var
    originalParam, newParam: String;
  begin
    originalParam := ':SwipeCardRangeID -- IDParam';
    newParam := IntToStr(SwipeCardRangeID) + ' -- IDParam';

    with dmADO_SwipeRange.qGenerateRanges do
    begin
      SQL.Text := StringReplace(SQL.Text, originalParam, newParam, [rfReplaceAll, rfIgnoreCase]);
      ExecSQL;
      SQL.Text := StringReplace(SQL.Text, newParam, originalParam, [rfReplaceAll, rfIgnoreCase]);
    end;
  end;

begin
  Dlg := nil;
  try
    Dlg := TfrmEditSwipeCardRange.Create(nil);

    Dlg.FisPromotional := isPromotional;
    Dlg.FReadOnly := ReadOnly;
    Dlg.FDisableControls := DisableControls;

    Dlg.SetupGUI;

    if DisplayType = AddRange then
    begin
      Dlg.Caption := 'Add Security Card Range';
      if Dlg.ShowModal = mrOk then
      with aDataSet do
      begin
        Insert;
        FieldByName('SwipeCardRangeID').AsInteger := GetNewId(scThemeSwipeCardRange);
        FieldByName('Description').AsString := Dlg.edtDescription.Text;
        FieldByName('StartValue').AsString := Dlg.edtRangeStart.Text;
        FieldByName('EndValue').AsString := Dlg.edtRangeEnd.Text;
        FieldByName('Track').AsInteger := Dlg.cmbCardTrack.ItemIndex + 1;
        FieldByName('Promotional').AsBoolean := isPromotional;
        FieldByName('Loyalty').AsBoolean := Dlg.actLoyalty.Checked;
        if Dlg.actLoyalty.Checked and (Dlg.cmbbxName.ItemIndex <> 0) then
          FieldByName('URL').AsInteger := TLoyaltyMethod(Dlg.cmbbxName.Items.Objects[Dlg.cmbbxName.ItemIndex]).ID
        else if not Dlg.actLoyalty.Checked then
          FieldByName('URL').value := null;
        Post;
        if isPromotional then
           addValidationConfig(FieldByName('SwipeCardRangeID').AsInteger);
      end;
    end
    else
    if DisplayType = EditRange then
    begin
      Dlg.Caption := 'Edit Security Card Range';
      with aDataSet do
      begin
        Dlg.SwipeCardRangeID := FieldByName('SwipeCardRangeID').AsInteger;
        Dlg.edtDescription.Text := FieldByName('Description').AsString;
        Dlg.edtRangeStart.Text := FieldByName('StartValue').AsString;
        Dlg.edtRangeEnd.Text := FieldByName('EndValue').AsString;
        Dlg.cmbCardTrack.ItemIndex := FieldByName('Track').AsInteger - 1;
        Dlg.cbxLoyaltyCardRange.Checked := FieldByName('Loyalty').AsBoolean;
        if Dlg.actLoyalty.Checked then
          Dlg.SetURL(FieldByName('URL').AsInteger);
      end;
      if Dlg.ShowModal = mrOk then
      with aDataSet do
      begin
        DescriptionChanged := FieldByName('Description').AsString <> Dlg.edtDescription.Text;
        StartValueChanged := FieldByName('StartValue').AsString <> Dlg.edtRangeStart.Text;
        EndValueChanged := FieldByName('EndValue').AsString <> Dlg.edtRangeEnd.Text;
        TrackChanged := FieldByName('Track').AsInteger <> Dlg.cmbCardTrack.ItemIndex + 1;
        LoyaltyChanged := FieldByName('Loyalty').AsBoolean <> Dlg.actLoyalty.Checked;
        if Dlg.actLoyalty.Checked  and (Dlg.cmbbxName.ItemIndex <> 0) then
          URLChanged :=  FieldByName('URL').AsInteger <> TLoyaltyMethod(Dlg.cmbbxName.Items.Objects[Dlg.cmbbxName.ItemIndex]).ID
        else
          URLChanged := (not VarIsNull(FieldByName('URL').Value)) and (Dlg.cmbbxName.ItemIndex = 0);

        if DescriptionChanged or StartValueChanged or EndValueChanged or TrackChanged or LoyaltyChanged or URLChanged then
        begin
          Edit;
          FieldByName('Description').AsString := Dlg.edtDescription.Text;
          FieldByName('StartValue').AsString := Dlg.edtRangeStart.Text;
          FieldByName('EndValue').AsString := Dlg.edtRangeEnd.Text;
          FieldByName('Track').AsInteger := Dlg.cmbCardTrack.ItemIndex + 1;
          FieldByName('Loyalty').AsBoolean := Dlg.actLoyalty.Checked;
          if Dlg.actLoyalty.Checked and (Dlg.cmbbxName.ItemIndex <> 0) then
            FieldByName('URL').AsInteger := TLoyaltyMethod(Dlg.cmbbxName.Items.Objects[Dlg.cmbbxName.ItemIndex]).ID
          else if not Dlg.actLoyalty.Checked then
            FieldByName('URL').value := null;
          Post;
          if StartValueChanged or EndValueChanged then
            generateExceptionRange(FieldByName('SwipeCardRangeID').AsInteger);
        end;
      end;
    end;
  finally
    Dlg.Free;
  end;
end;

procedure TfrmEditSwipeCardRange.btOkClick(Sender: TObject);
begin
  if edtDescription.Text = '' then
    raise Exception.Create('Description cannot be blank');

  edtRangeStart.Text := Trim(edtRangeStart.Text);
  edtRangeEnd.Text := Trim(edtRangeEnd.Text);

  if not IsNumeric(edtRangeStart.Text) then
    raise Exception.Create('Range start is invalid');
  if not IsNumeric(edtRangeEnd.Text) then
    raise Exception.Create('Range end is invalid');

  if not StringGreaterThan(edtRangeStart.Text, '0') then
    raise Exception.Create('Range start must be greater than 0');

  if StringGreaterThan(edtRangeStart.Text, edtRangeEnd.Text) then
    raise Exception.Create('Range start cannot be greater than range end');

  if hasExceptionsOutSideRange(Trim(edtRangeStart.Text), Trim(edtRangeEnd.Text)) then
     raise Exception.Create('There are exceptions outside the new card range.');

  // Overlap check
  if overlapsExistingRange(Trim(edtRangeStart.Text), Trim(edtRangeEnd.Text)) then
    raise Exception.Create('New range would overlap an existing range.');

  if assignedToPromoGroup and cbxLoyaltyCardRange.Checked then
     raise Exception.Create('Range is already assigned to a promotional group.');

  if actLoyalty.Checked and (cmbbxName.ItemIndex = 0) then
    raise Exception.Create('Loyalty ranges must have an associated URL.');

  ModalResult := mrOk;
end;

function TfrmEditSwipeCardRange.overlapsExistingRange(vStart, vEnd : String) : Boolean;
var
  RangeId: integer;
begin
  RangeId := SwipeCardRangeID;
  with dmADO_SwipeRange.qRun do
  begin
    SQL.Text := Format(
      'declare @NewRangeStart Numeric(25,0), @NewRangeEnd Numeric(25,0) ' + #13#10 +
      'declare @NewRangeId int ' + #13#10 +
      'set @NewRangeStart = CAST(%s AS numeric(25,0))' + #13#10 +
      'set @NewRangeEnd = CAST(%s AS numeric(25,0))' + #13#10 +
      'set @NewRangeId = %d ' + #13#10 +
      'select * ' + #13#10 +
      'from ThemeSwipeCardRange ' + #13#10 +
      'where SwipeCardRangeID <> @NewRangeID and Promotional = %d ' + #13#10 +
      'and ((@NewRangeStart between CAST(StartValue as numeric(25,0)) and CAST(EndValue as numeric(25,0)))' + #13#10 +
      '     or (@NewRangeEnd between CAST(StartValue as numeric(25,0)) and CAST(EndValue as numeric(25,0)))' + #13#10 +
      '     or (@NewRangeStart <= CAST(StartValue as numeric(25,0)) and @NewRangeEnd >= CAST(EndValue as numeric(25,0))))',
      [QuotedStr(vStart), QuotedStr(vEnd), RangeID, Integer(FisPromotional)]
    );
    Open;
    result := RecordCount > 0;
    Close;
  end;
end;

function TfrmEditSwipeCardRange.hasExceptionsOutSideRange(vStart, vEnd : String) : Boolean;
begin
  result := false;
  if SwipeCardRangeId <> 0 then
  begin
    result := False;
    with dmADO_SwipeRange.qRun do
    begin
      Close;
      SQL.Text := Format('SELECT Value FROM ThemeSwipeCardExceptions ' +
                        ' WHERE SwipeCardRangeID = %d ', [SwipeCardRangeID]);
      Open;

      first;

      while not eof do
        begin
          if (StringGreaterThan(vStart, FieldByName('Value').AsString)) or (StringGreaterThan(FieldByName('Value').AsString, vEnd)) then
             begin
               Result := True;
               Exit;
             end;
          Next;
        end;
    end;
  end;
end;

procedure TfrmEditSwipeCardRange.edtRangeStartKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not((Ord(Key) >= Ord('0')) and (Ord(Key) <= Ord('9'))) and (Key <> #8)
     and (Key <> #3) and (Key <> #22) and (Key <> #24) then
    Abort;
  if (Key = '0') and ((Length(TEdit(Sender).Text) = 0) or (TEdit(Sender).SelStart = 0)) then
    Abort;
  tTempRange := TEdit(Sender).Text;
end;

procedure TfrmEditSwipeCardRange.edtRangeStartChange(Sender: TObject);
begin
   if Length(TEdit(Sender).Text) > 0 then
      begin
       if (TEdit(Sender).Text[1] = '0') then
          begin
            TEdit(Sender).Text := tTempRange;
            Raise Exception.Create('Range cannot begin with zero(0).');
          end
       else
       if not IsNumeric(TEdit(Sender).Text) then
          begin
            TEdit(Sender).Text := tTempRange;
            Raise Exception.Create('Range must be numeric.');
          end;
    end;
end;

procedure TfrmEditSwipeCardRange.edtRangeStartEnter(Sender: TObject);
begin
  tTempRange := TEdit(Sender).Text;
end;

function TfrmEditSwipeCardRange.assignedToPromoGroup : boolean;
begin
  result := false;
  with dmADO_SwipeRange.qRun do
    begin
      SQL.Clear;
      SQL.Text := format('SELECT * FROM ThemeSwipeCardGroupRange WHERE SwipeCardRangeID = %d', [SwipeCardRangeID]);
      Open;

      if RecordCount > 0 then
         result := True;
    end

end;

procedure TfrmEditSwipeCardRange.BuildLoyaltyURLList;
var
  ID: integer;
  LoyaltyMethodName: String;
begin
  with qryThemeButtonURL do
  begin
    Open;
    while not EOF do
    begin
      ID := FieldByName('id').AsInteger;
      LoyaltyMethodName := FieldByName('Name').asString;

      cmbbxName.Items.AddObject(LoyaltyMethodName,TLoyaltyMethod.Create(ID,LoyaltyMethodName));
      Next;
    end;
  end;
end;

{ TLoyaltyURL }
constructor TLoyaltyMethod.Create(_ID: Integer; _LoyaltyMethodName: String);
begin
  inherited Create;
  FID := _ID;
  FLoyaltyMethodName := _LoyaltyMethodName;
end;

procedure TfrmEditSwipeCardRange.cbxLoyaltyCardRangeClick(Sender: TObject);
begin
  if not (Sender as TCheckBox).Checked then
    cmbbxName.ItemIndex := 0;
  lblLoyaltyName.Enabled := (Sender as TCheckBox).Checked;
  cmbbxName.Enabled := (Sender as TCheckBox).Checked;
end;

procedure TfrmEditSwipeCardRange.actLoyaltyExecute(Sender: TObject);
begin
  if not (Sender as TAction).Checked then
    cmbbxName.ItemIndex := 0;
  lblLoyaltyName.Enabled := (Sender as TAction).Checked;
  cmbbxName.Enabled := (Sender as TAction).Checked;
end;


procedure TfrmEditSwipeCardRange.SetURL(URLID: Integer);
var
  i: Integer;
begin
  for i := 1 to cmbbxName.Items.Count - 1 do
  begin
    if TLoyaltyMethod(cmbbxName.Items.Objects[i]).id = URLID then
    begin
      cmbbxName.ItemIndex := i;
      Break;
    end;
  end;
end;

procedure TfrmEditSwipeCardRange.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to cmbbxName.items.Count - 1 do
    TLoyaltyMethod(cmbbxName.items.Objects[i]).Free;
end;

procedure TfrmEditSwipeCardRange.SetupGUI;
begin
  if FisPromotional then
  begin
    BuildLoyaltyURLList;

    HelpContext := 7104
  end
  else begin
    pnlLoyalty.Visible := False;

    ClientHeight := ClientHeight - pnlLoyalty.ClientHeight;

    HelpContext := 5049;
  end;
end;

procedure TfrmEditSwipeCardRange.FormShow(Sender: TObject);
begin
  if FReadOnly and Assigned(FDisableControls) then
  begin
    FDisableControls(Self);
    btCancel.Enabled := True;
    cmbCardTrack.Enabled := False;
  end;
end;

end.
