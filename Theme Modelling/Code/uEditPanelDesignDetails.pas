unit uEditPanelDesignDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB;

type
  TEditingMode = (emAdd, emEdit, emCopy);

  TInt64Obj = class(TObject)
  public
    value: int64;
    constructor create(value: int64);
  end;

  TEditPanelDesignDetails = class(TForm)
    Label1: TLabel;
    edName: TEdit;
    Label2: TLabel;
    mmDescription: TMemo;
    Button1: TButton;
    Button2: TButton;
    cbPanelDesignType: TComboBox;
    Label3: TLabel;
    cbUseForcedSelection: TCheckBox;
    cbPayPanel: TComboBox;
    lblPayPanel: TLabel;
    lblScreenSize: TLabel;
    cbxScreenSize: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure cbPayPanelSelect(Sender: TObject);
    procedure cbPanelDesignTypeChange(Sender: TObject);
  private
    { Private declarations }
    ShowForcedSelectionWarning : boolean;
    PayPanelName : String;
    FEditingMode: TEditingMode;
    procedure SetMinSiteVersion;
    function LoadDefaultPayPanels: TStrings;
    function hasPanelVariations: Boolean;
    function SharedPositionValid: Boolean;
  public
    { Public declarations }
    PayPanelList : TStringList;
    PanelDesignID, ThemeID, DefaultPayPanel : integer;
    procedure SetScreenSizes;
    constructor Create(EditingMode: TEditingMode); reintroduce;
  end;

const
  FORCEDSELECTION_VERSION = '2.9.0.0';

var
  EditPanelDesignDetails: TEditPanelDesignDetails;

implementation

uses uDMThemeData, uAztecLog, uDatabaseVersion;

{$R *.dfm}

constructor TInt64Obj.create(value: int64);
begin
  self.value := value;
end;

procedure TEditPanelDesignDetails.FormCreate(Sender: TObject);
begin
  with dmThemedata do
  begin
    AccessDataset('qPanelDesignType');
    cbPanelDesignType.Clear;
    qPanelDesignType.First;
    while not qPanelDesignType.eof do
    begin
      cbPanelDesignType.Items.AddObject(
        qPanelDesignType.fieldbyname('DisplayName').asstring,
        TObject(integer(qPanelDesignType.FieldByName('PanelDesignTypeID').asinteger))
      );
      qPanelDesignType.next;
    end;
    DeAccessDataset('qPanelDesignType');
  end;
  cbPanelDesignType.Itemindex := 0;
  
  ShowForcedSelectionWarning := False;
end;

procedure TEditPanelDesignDetails.Button1Click(Sender: TObject);
begin
  ButtonClicked(Sender);
  if trim(edName.Text) = '' then
    raise Exception.create('Please specify a name');

  with dmThemeData do
  begin
    if FEditingMode in [emAdd, emEdit] then
      adoQRun.SQL.Text := Format(
        'if exists(select * from ThemePanelDesign where Name = %s and PanelDesignID <> %d and ThemeID = %d) select 1 else select 0',
        [QuotedStr(edName.Text), PanelDesignID, ThemeID]
      )
    else
      adoQRun.SQL.Text := Format(
        'if exists(select * from ThemePanelDesign where Name = %s and ThemeID = %d) select 1 else select 0',
        [QuotedStr(edName.Text), ThemeID]
      );
    adoQRun.Open;
    if adoQRun.Fields[0].AsInteger = 1 then
    begin
      adoQRun.Close;
      raise Exception.Create(Format('The name %s is already in use by another Panel Design', [QuotedStr(edName.Text)]));
    end;
    adoQRun.Close;
  end;

  if cbUseForcedSelection.Checked and ShowForcedSelectionWarning then
  begin
    MessageDlg('Only sites at Aztec version ' + FORCEDSELECTION_VERSION +
      ' or above will be able to use the Forced Item Selection feature.', mtInformation, [mbOK], 0);
  end;

  if (self.caption = 'Edit Panel Design') and
     (dmThemeData.GetForcedSelectionPanelID(
                      dmThemeData.qPanelDesigns.fieldbyname('PanelDesignID').asinteger) <> -1) and
     (not cbUseForcedSelection.Checked) then
  begin
    if MessageDlg('This Panel Design is currently set up to use a Forced Items Selection Panel.'+
        #13+#10+' You have chosen to uncheck the "Use Forced Item Selection" checkbox.'+
        #13+#10+''+#13+#10+
        'If you continue the Forced Items Selection Panel and all the objects set up on it will be deleted.',
        mtWarning, [mbOK, mbCancel], 0) = mrCancel then
      exit;
  end;

  if (hasPanelVariations) and (cbPayPanel.ItemIndex <> 0) then
     MessageDlg('The selected Default Pay Panel has variations.' + #10#13 +
                'Please ensure that a variation has been selected and that it''s position within the Panel Design is valid.', mtWarning, [mbOK], 0)
  else
  if (not SharedPositionValid) and (cbPayPanel.ItemIndex <> 0) then
     MessageDlg('Please ensure that the selected Default Pay Panel has a valid position within the Panel Design.', mtWarning, [mbOK], 0);


  modalresult := mrOk;
end;

function TEditPanelDesignDetails.hasPanelVariations : Boolean;
begin
  result := False;
  with dmThemeData.adoqRun do
    begin
      Close;
      SQL.Text := Format('SELECT * FROM ThemePanelVariation WHERE PanelID = %d', [TInt64Obj(cbPayPanel.items.Objects[cbPayPanel.ItemIndex]).value]);
      Open;

      if RecordCount > 0 then
         Result := True;
    end;
end;

function TEditPanelDesignDetails.SharedPositionValid : Boolean;
begin
  result := False;
  with dmThemeData.adoqRun do
    begin
      Close;
      SQL.Text := Format('SELECT * FROM ThemePanelSharedPos WHERE PanelID = %d AND PanelDesignID = %d ', [TInt64Obj(cbPayPanel.items.Objects[cbPayPanel.ItemIndex]).value, PanelDesignID]);
      Open;

      if RecordCount > 0 then
         Result := True;
    end;
end;

procedure TEditPanelDesignDetails.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  log('Form Close ' + Caption);
end;

procedure TEditPanelDesignDetails.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
  // set the min Aztec version in use for this PanelDesign but only in Edit mode...
  if (self.caption = 'Edit Panel Design') then
    SetMinSiteVersion;

  PayPanelList := TStringList.Create;

  cbPayPanel.Items.Assign(LoadDefaultPayPanels);

  if DefaultPayPanel > 0 then
     cbPayPanel.ItemIndex := PayPanelList.IndexOf(PayPanelName)
    else
       cbPayPanel.ItemIndex := 0;

end;

procedure TEditPanelDesignDetails.Button2Click(Sender: TObject);
begin
  ButtonClicked(Sender);
end;

procedure TEditPanelDesignDetails.SetMinSiteVersion;
var
  NextVersion, CurrentVersion, ForcedSelectionVersion : TDatabaseVersion;
begin
  ForcedSelectionVersion := nil;
  NextVersion := nil;
  CurrentVersion := nil;
  with dmThemeData.adoqRun do
  begin
    Close;
    sql.Clear;
    SQL.Add(' Select Distinct c.DBVersion ');
    SQL.Add(' From ThemeEposDesign b ');
    SQL.Add(' Join CommsVersions c on c.SiteCode = b.SiteCode ');
    SQL.Add(' Where b.PanelDesignID = ' + dmThemeData.qPanelDesigns.fieldbyname('PanelDesignID').asstring);
    SQL.Add(' And c.DBVersion IS NOT NULL ');

    Open;

    if Bof and EOF then
    begin
      ShowForcedSelectionWarning := False;
    end
    else
    begin
      try
        ForcedSelectionVersion := TDataBaseVersion.Create;
        NextVersion := TDatabaseVersion.Create;
        CurrentVersion := TDataBaseVersion.Create;

        if FieldByName('DBVersion').AsString = '' then
          CurrentVersion.VersionText := FORCEDSELECTION_VERSION
        else
          CurrentVersion.VersionText := FieldByName('DBVersion').AsString;

        Next;
        while not Eof do
        begin
          if FieldByName('DBVersion').AsString <> '' then
          begin
            NextVersion.VersionText := FieldByName('DBVersion').AsString;
            if CurrentVersion.IsHigherThan(NextVersion) then
              CurrentVersion.VersionText := NextVersion.VersionText;
          end;
          Next;
        end;

        ForcedSelectionVersion.VersionText := FORCEDSELECTION_VERSION;

        ShowForcedSelectionWarning := ForcedSelectionVersion.IsHigherThan(CurrentVersion);
        Log('Min Sites Version ' + CurrentVersion.VersionText);
      finally
        NextVersion.Free;
        CurrentVersion.Free;
        ForcedSelectionVersion.Free;
      end;
    end;

    close;
  end;
end;

function TEditPanelDesignDetails.LoadDefaultPayPanels : TStrings;
var i : integer;
begin
  with dmThemeData.adoqRun do
    begin
      for i := 0 to pred(cbPayPanel.items.count) do
          cbPayPanel.Items.Objects[i].Free;

      cbPayPanel.items.clear;

      SQL.Text := Format(' SELECT Pay AS PanelID, ''Pay (Default)'' AS Name '+
                         '        FROM ThemePanelDesign '+
                         '  WHERE PanelDesignID = %d ', [PanelDesignID]);
      Open;
      if RecordCount > 0 then
         begin
           PayPanelList.AddObject(FieldByName('Name').AsString, TInt64Obj.create((FieldByName('PanelID').AsInteger)));
           if FieldByName('PanelID').AsInteger = DefaultPayPanel then
              PayPanelName := FieldByName('Name').AsString;
              
           Close;

           SQL.Text := Format('SELECT tp.PanelID, tp.Name '+
                              '       FROM ThemePanel tp '+
                              '            INNER JOIN (SELECT DISTINCT(PanelID) '+
                              '                               FROM ThemePanelButton '+
                              '                        WHERE ButtonTypeChoiceID = 6) tpb  ON tpb.PanelID = tp.PanelID '+
                              ' WHERE tp.PanelType = %d ORDER BY tp.Name ',[2]);
           Open;
           First;
           while not EOF do
           begin
             if FieldByName('PanelID').AsInteger = DefaultPayPanel then
                PayPanelName := FieldByName('Name').AsString;

             PayPanelList.AddObject(fieldbyname('Name').asstring, TInt64Obj.create((fieldbyname('PanelID').asInteger)));
             Next;
           end;
           close;
         end
      else
         PayPanelList.AddObject('Pay (Default)', TInt64Obj.create(0));

    end;
  Result := PayPanelList;
end;


procedure TEditPanelDesignDetails.cbPayPanelSelect(Sender: TObject);
begin
  if DefaultPayPanel <> TInt64Obj(cbPayPanel.Items.Objects[cbPayPanel.ItemIndex]).value then
       DefaultPayPanel := TInt64Obj(cbPayPanel.Items.Objects[cbPayPanel.ItemIndex]).value;
end;

procedure TEditPanelDesignDetails.cbPanelDesignTypeChange(Sender: TObject);
begin
  SetScreenSizes;
  cbxScreenSize.ItemIndex := 0;
end;

procedure TEditPanelDesignDetails.SetScreenSizes;
begin
  with dmThemedata.adoqRun do
  begin
    SQL.Text := Format('SELECT Name, ScreenInterfaceID FROM ThemePanelDesignType '+
                '       WHERE PanelDesignTypeID = %d', [integer(cbPanelDesignType.items.Objects[cbPanelDesignType.ItemIndex])]);
    Open;

    cbxScreenSize.Enabled := RecordCount > 1;

    cbxScreenSize.Clear;

    First;
    while not eof do
    begin
      cbxScreenSize.Items.AddObject(fieldbyname('Name').asstring,
      TObject(integer(FieldByName('ScreenInterfaceID').asinteger)));
      next;
    end;
   end;
end;

constructor TEditPanelDesignDetails.Create(EditingMode: TEditingMode);
begin
  inherited Create(nil);
    FEditingMode := EditingMode;
end;

end.
