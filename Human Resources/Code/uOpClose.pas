unit uOpClose;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Mask, Dialogs, DB, //DBTables, Wwtable,
  Messages, ADODB;

type
  TfOpClose = class(TForm)
    Label1: TLabel;
    EditMonOpen: TMaskEdit;
    EditMonClose: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EditTueOpen: TMaskEdit;
    EditTueClose: TMaskEdit;
    Label5: TLabel;
    EditWedOpen: TMaskEdit;
    EditWedClose: TMaskEdit;
    Label6: TLabel;
    EditThuOpen: TMaskEdit;
    EditThuClose: TMaskEdit;
    Label7: TLabel;
    EditFriOpen: TMaskEdit;
    EditFriClose: TMaskEdit;
    Label8: TLabel;
    EditSatOpen: TMaskEdit;
    EditSatClose: TMaskEdit;
    Label9: TLabel;
    EditSunOpen: TMaskEdit;
    EditSunClose: TMaskEdit;
    Shape1: TShape;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    wwTable1: TADOTable;
    procedure EditMonOpenKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function ValidateTime(ATime: string): String;
    function ValidateAllEditControls: boolean;
    function ValidateTimeInEditControl(editControl: TCustomEdit): boolean;
  public
    { Public declarations }
  end;

var
  fOpClose: TfOpClose;

implementation

uses uADO, uGlobals;

const Sun = 1; Mon = 2; Tue = 3; Wed = 4; Thu = 5; Fri = 6; Sat = 7;

{$R *.DFM}

procedure TfOpClose.EditMonOpenKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key = VK_Return) then
     Perform(wm_NextDlgCtl, 0, 0);
end;

procedure TfOpClose.FormShow(Sender: TObject);
begin
  with wwtable1 do
  begin
    Open;
    if locate('tday', Sun, []) then
    begin
      if fieldbyname('Open').asstring <> '' then EditSunOpen.text := fieldbyname('Open').asstring;
      if fieldbyname('Close').asstring <> '' then EditSunClose.text := fieldbyname('Close').asstring;
    end;
    if locate('tday', Mon, []) then
    begin
      if fieldbyname('Open').asstring <> '' then EditMonOpen.text := fieldbyname('Open').asstring;
      if fieldbyname('Close').asstring <> '' then EditMonClose.text := fieldbyname('Close').asstring;
    end;
    if locate('tday', Tue, []) then
    begin
      if fieldbyname('Open').asstring <> '' then EditTueOpen.text := fieldbyname('Open').asstring;
      if fieldbyname('Close').asstring <> '' then EditTueClose.text := fieldbyname('Close').asstring;
    end;
    if locate('tday', Wed, []) then
    begin
      if fieldbyname('Open').asstring <> '' then EditWedOpen.text := fieldbyname('Open').asstring;
      if fieldbyname('Close').asstring <> '' then EditWedClose.text := fieldbyname('Close').asstring;
    end;
    if locate('tday', Thu, []) then
    begin
      if fieldbyname('Open').asstring <> '' then EditThuOpen.text := fieldbyname('Open').asstring;
      if fieldbyname('Close').asstring <> '' then EditThuClose.text := fieldbyname('Close').asstring;
    end;
    if locate('tday', Fri, []) then
    begin
      if fieldbyname('Open').asstring <> '' then EditFriOpen.text := fieldbyname('Open').asstring;
      if fieldbyname('Close').asstring <> '' then EditFriClose.text := fieldbyname('Close').asstring;
    end;
    if locate('tday', Sat, []) then
    begin
      if fieldbyname('Open').asstring <> '' then EditSatOpen.text := fieldbyname('Open').asstring;
      if fieldbyname('Close').asstring <> '' then EditSatClose.text := fieldbyname('Close').asstring;
    end;
    close;
  end;
end;

procedure TfOpClose.BitBtn1Click(Sender: TObject);
begin
  with TADOCommand.Create(nil) do
  try
    if not ValidateAllEditControls then
      exit;
  
    Connection := dmADO.AztecConn;
    CommandText :=
      'DELETE FROM OpenTime '+

      'INSERT INTO OpenTime ([TDay], [Open], [Close]) ' +
      'VALUES (' + IntToStr(Sun) + ',' + QuotedStr(ValidateTime(EditSunOpen.text)) + ',' + QuotedStr(ValidateTime(EditSunClose.text)) + ') ' +

      'INSERT INTO OpenTime ([TDay], [Open], [Close]) ' +
      'VALUES (' + IntToStr(Mon) + ',' + QuotedStr(ValidateTime(EditMonOpen.text)) + ',' + QuotedStr(ValidateTime(EditMonClose.text)) + ') ' +

      'INSERT INTO OpenTime ([TDay], [Open], [Close]) ' +
      'VALUES (' + IntToStr(Tue) + ',' + QuotedStr(ValidateTime(EditTueOpen.text)) + ',' + QuotedStr(ValidateTime(EditTueClose.text)) + ') ' +

      'INSERT INTO OpenTime ([TDay], [Open], [Close]) ' +
      'VALUES (' + IntToStr(Wed) + ',' + QuotedStr(ValidateTime(EditWedOpen.text)) + ',' + QuotedStr(ValidateTime(EditWedClose.text)) + ') ' +

      'INSERT INTO OpenTime ([TDay], [Open], [Close]) ' +
      'VALUES (' + IntToStr(Thu) + ',' + QuotedStr(ValidateTime(EditThuOpen.text)) + ',' + QuotedStr(ValidateTime(EditThuClose.text)) + ') ' +

      'INSERT INTO OpenTime ([TDay], [Open], [Close]) ' +
      'VALUES (' + IntToStr(Fri) + ',' + QuotedStr(ValidateTime(EditFriOpen.text)) + ',' + QuotedStr(ValidateTime(EditFriClose.text)) + ') ' +

      'INSERT INTO OpenTime ([TDay], [Open], [Close]) ' +
      'VALUES (' + IntToStr(Sat) + ',' + QuotedStr(ValidateTime(EditSatOpen.text)) + ',' + QuotedStr(ValidateTime(EditSatClose.text)) + ') ';
    Execute;
  finally
    free;
  end;

  ModalResult := mrOK;
end;

procedure TfOpClose.BitBtn2Click(Sender: TObject);
begin
  modalresult := mrCancel;
end;

procedure TfOpClose.FormCreate(Sender: TObject);
begin
  if HelpExists then
    setHelpContextID(self, EMP_OPEN_CLOSE);
end;

function TfOpClose.ValidateTime(ATime: string): String;
begin
  ATime := StringReplace(ATime, ' ', '', [rfReplaceAll]);

  while Length(ATime) < 5 do
  begin
    if pos(':', ATime) <> 3 then
      ATime := '0' + ATime
    else
      ATime := ATime + '0';
  end;

  Result := ATime;
end;

function TfOpClose.ValidateTimeInEditControl(editControl: TCustomEdit): boolean;
var
  t: TDateTime;
begin
  if not(TryStrToTime(editControl.Text, t)) then
  begin
    ShowMessage(editControl.Text + ' is not a valid time');
    editControl.SetFocus;
    result := false;
  end
  else
    result := true;
end;

function TfOpClose.ValidateAllEditControls : boolean;
begin
  result := (ValidateTimeInEditControl(EditMonOpen) and
    ValidateTimeInEditControl(EditMonClose) and
    ValidateTimeInEditControl(EditTueOpen) and
    ValidateTimeInEditControl(EditTueClose) and
    ValidateTimeInEditControl(EditWedOpen) and
    ValidateTimeInEditControl(EditWedClose) and
    ValidateTimeInEditControl(EditThuOpen) and
    ValidateTimeInEditControl(EditThuClose) and
    ValidateTimeInEditControl(EditFriOpen) and
    ValidateTimeInEditControl(EditFriClose) and
    ValidateTimeInEditControl(EditSatOpen) and
    ValidateTimeInEditControl(EditSatClose) and
    ValidateTimeInEditControl(EditSunOpen) and
    ValidateTimeInEditControl(EditSunClose));
end;


end.
