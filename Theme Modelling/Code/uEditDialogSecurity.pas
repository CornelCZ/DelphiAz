unit uEditDialogSecurity;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB,
  uTillButton, ExtCtrls, ActnList, ActnMan, ToolWin, ActnCtrls, ImgList,
  ComCtrls;

type
  TInt64Obj = class(TObject)
  public
    value: int64;
    constructor create(value: int64);
  end;
  TEditDialogSecurity = class(TForm)
    ADOConnection1: TADOConnection;
    pnToolBar: TPanel;
    ImageList1: TImageList;
    Panel2: TPanel;
    ActionManager1: TActionManager;
    SavePanel: TAction;
    RevertPanel: TAction;
    ADOStoredProc1: TADOStoredProc;
    ADOStoredProc2: TADOStoredProc;
    ADOStoredProc2PanelID: TLargeintField;
    ADOStoredProc2PanelType: TWordField;
    ADOStoredProc2PanelName: TStringField;
    ADOStoredProc2Left: TSmallintField;
    ADOStoredProc2Right: TSmallintField;
    ADOStoredProc2Top: TSmallintField;
    ADOStoredProc2Bottom: TSmallintField;
    ADOStoredProc3: TADOStoredProc;
    btClose: TButton;
    Panel1: TPanel;
    cbPickPanel: TComboBox;
    Label1: TLabel;
    PageScroller1: TPageScroller;
    ActionToolBar1: TActionToolBar;
    procedure FormCreate(Sender: TObject);
    procedure cbPickPanelChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SavePanelExecute(Sender: TObject);
    procedure RevertPanelExecute(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure SavePanelUpdate(Sender: TObject);
    procedure RevertPanelUpdate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    themeid: integer;
    procedure CheckSaveChanges;
    procedure LoadSecurity;
    procedure SaveSecurity;
    function GetStaticPanelButtonSecurityID(Button : TTillButton): int64;
//    procedure SetSecurity(button : TTillButton);
   { Private declarations }
  public
    PanelManager: TPanelManager;
    { Public declarations }
    procedure OnObjectDblClick(obj: TTillObject);
    procedure OnObjectContextEvent(obj: TTillObject);
    procedure LoadThemeDialogs(theme_id: integer);
  end;

var
  EditDialogSecurity: TEditDialogSecurity;

implementation

uses uDMThemeData, uGenerateThemeIDs, uStdGrid, dADOAbstract, uThemeModellingMenu,
     uEditJobSecurity, uAztecLog, uEditTimedJobSecurity, uAztecDatabaseUtils,
  uThemes, uFormNavigate;


{$R *.dfm}

//------------------------------------------------------------------------------
procedure TEditDialogSecurity.OnObjectContextEvent(obj: TTillObject);
begin
end;

//------------------------------------------------------------------------------
function TEditDialogSecurity.GetStaticPanelButtonSecurityID(Button : TTillButton) : int64;
var
  qryTimedSecurity : TADOQuery;
begin
  { Static Panel Button IDs change per release of THeme modelling but they are always
    uniquely identifiable by Name, ElemAttrName01, ElemAttrName02 from table
    ThemeButtonTypeChoiceLookup.
    ThemeDialogSecurity_repl uses these three columns to assign a ButtonSecurityId to static panel
    buttons per theme and assigns a unique Integer ID (SecurityID) per
    Theme|Static Button instead of the 4 Key composite key. This security ID
    can be used to identify a static panel button per theme}
  RESULT := 0;
  qryTimedSecurity := TADOQuery.Create(nil);

  with qryTimedSecurity do
  try
    Connection := dmThemeData.AztecConn;
    SQL.Add('SELECT b.SecurityID');
    SQL.Add('FROM ThemeButtonTypeChoiceLookup a ');
    SQL.Add('INNER JOIN ThemeDialogSecurity b ON b.ButtonType = a.Name');
    SQL.Add('INNER JOIN ThemeDialogPanelSet c ON c.PanelID = ' + IntToStr(PanelManager.PanelID) +
      ' AND b.DialogName = c.DialogPanelName');
    SQL.Add('WHERE a.ID = ' + IntToStr(Button.ButtonTypeID));
    SQL.Add('AND b.ButtonParamFilter1 = ' + QuotedStr(Button.ButtonTypeData));
    SQL.Add('AND b.ButtonParamFilter2 = ' + QuotedStr(Button.ButtonTypeData2));
    SQL.Add('AND ThemeID = ' + IntToStr(ThemeID));

    try
      Open;

      if RecordCount = 0 then
        Result := 0
      else
        Result := FieldByName('SecurityID').AsInteger;
    except
      Raise Exception.Create('There was an exception retrieving Security Info for a static panel button')
    end;
  finally
    FreeAndNil(qryTimedSecurity);
  end;
end;

//------------------------------------------------------------------------------
procedure TEditDialogSecurity.OnObjectDblClick(obj: TTillObject);
var
  SecurityID : int64;
begin
  if obj is TTillButton then
  begin
    SecurityID := GetStaticPanelButtonSecurityID(TTillButton(obj));
    ShowSecurityDlg_FixedPanel(Themeid, SecurityID, TTillButton(obj));
  end;
end;

//------------------------------------------------------------------------------
procedure TEditDialogSecurity.LoadThemeDialogs(Theme_ID: integer);
var
  i: integer;
  function CapsToSpaces(Input: string): string;
  var
    i: integer;
    function IsCaps(StringToCheck: string; Index: integer): boolean;
    begin
      if (Index > 0) and (Index <= Length(StringToCheck)) then
        Result := (Ord(StringToCheck[Index]) >= Ord('A'))
          and (Ord(StringToCheck[Index]) <= Ord('Z'))
      else
        Result := FALSE
    end;
  begin
    // Make an exception for TLAs- prevent adding spaces
    Input := StringReplace(Input, 'EFT', 'Eft', [rfReplaceAll]);
    for i := Length(input) downto 1 do
    begin
      if (i <> 1) and IsCaps(Input, i) then
        Insert(' ', Input, i);
    end;
    // Capitalise only first letter
    Input := LowerCase(Input);
    if Length(Input) > 0 then
      Input[1] := UpperCase(Input[1])[1];
    // Make an exception for TLAs- convert back to upper case
    Input := StringReplace(Input, 'Eft', 'EFT', [rfReplaceAll]);
    Input := StringReplace(Input, ' pin ', ' Pin ', [rfReplaceAll]);
    Input := StringReplace(Input, ' p a n ', ' PAN ', [rfReplaceAll]);
    Result := Input;
  end;
begin
  self.themeid := theme_id;
  with dmThemeData.adoqRun do
  begin
    sql.text := 'select * from themepaneldesigntype '+
      'where paneldesigntypeid = 2 ';
    open;
    panelmanager.readonly := true;
    panelmanager.pd.LoadFromDataset(dmThemeData.adoqRun);
    clientwidth := panelmanager.pd.GetScreenRect.Right;
    clientheight := panelmanager.pd.GetScreenRect.Bottom + pnToolbar.height;
    PanelManager.PanelDesign := -1;
    close;
    sql.text := 'select PanelID, DialogPanelName from themedialogpanelset where paneldesigntype = 2 and CanSetSecurity = 1 order by DialogPanelName';
    open;
    for i := 0 to pred(cbPickPanel.items.count) do
      cbPickPanel.Items.Objects[i].Free;
    cbPickPanel.items.clear;
    while not EOF do
    begin
      cbPickPanel.Items.addobject(capstospaces(fieldbyname('DialogPanelName').asstring), TInt64Obj.create(TLargeIntField(fieldbyname('PanelID')).aslargeint));
      next;
    end;
    close;
  end;
  panelmanager.DetailsModified := false;
  panelmanager.PanelModified := false;
  cbPickPanel.ItemIndex := 0;
  cbPickPanel.OnChange(cbPickPanel);

end;

procedure TEditDialogSecurity.FormCreate(Sender: TObject);
begin
  SetUpAztecADOConnection(ADOConnection1);
  ReadFixedLookups(dmThemeData.AztecConn);
  if not assigned(panelmanager) then
    panelmanager := TPanelManager.create(self);
  with panelmanager do
  begin
    pd.LoadFromValues(64, 48, 640, 480, 0, 0);
    ObjectContextEvent := OnObjectContextEvent;
    ObjectDblClickEvent := OnObjectDblClick;
    OnAddOpenPanelButton := nil
  end;
end;

{ TInt64Obj }

constructor TInt64Obj.create(value: int64);
begin
  self.value := value;
end;

procedure TEditDialogSecurity.cbPickPanelChange(Sender: TObject);
var
  panel_id: int64;
begin
  CheckSaveChanges;
  with TCombobox(sender) do
  begin
    if itemindex >= 0 then
    begin
      panel_id := TInt64Obj(items.objects[itemindex]).value;
      Log('Loading Panel ID : ' + IntToStr(panel_id) + ' - ' + cbPickPanel.Text);
      PanelManager.LoadPanel(dmThemeData.AztecConn, panel_id);
      LoadSecurity;
    end;
  end;
end;

procedure TEditDialogSecurity.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Closed ' + Caption);
  with dmThemeData do
  begin
    StoreMetrics(self, true);
  end;
  Nav.MoveBack;
end;

procedure TEditDialogSecurity.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
  with dmThemeData do
  begin
    if not GetStoredMetrics(self, true) then
    begin
      top := (screen.Height - height) div 2 ;
      left := (screen.Width - width) div 2 ;
    end;
  end;
end;

procedure TEditDialogSecurity.SavePanelExecute(Sender: TObject);
begin
  Log('Save Panel Security Clicked');
  //PanelManager.SavePanel(dmThemeData.AztecConn);
  SaveSecurity;
end;

procedure TEditDialogSecurity.RevertPanelExecute(Sender: TObject);
var
  i: integer;
begin
  Log('Revert Button Clicked');
  PanelManager.LoadPanel(dmThemeData.AztecConn, PanelManager.PanelID);
  // fix - make sure panel name is reverted as this is not a panelmgr. property
  for i := 0 to pred(cbPickPanel.items.count) do
    if TInt64obj(cbPickpanel.items.objects[i]).value = panelmanager.PanelID then
    begin
      cbPickpanel.items[i] := panelmanager.panelname;
      cbPickPanel.itemindex := i;
    end;
  LoadSecurity;
end;

procedure TEditDialogSecurity.btCloseClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  close;
end;

procedure TEditDialogSecurity.CheckSaveChanges;
begin
  if PanelManager.panelmodified or PanelManager.detailsmodified then
    if messagedlg('Do you want to save changes?', mtConfirmation, [mbYes, mbNo], 0) =
      mrYes then SavePanel.Execute;
end;

procedure TEditDialogSecurity.SavePanelUpdate(Sender: TObject);
begin
  //** if user saves form without specifing spanel position generated XML is invalid
  TAction(sender).Enabled := (PanelManager.DetailsModified or PanelManager.PanelModified) and (PanelManager.AddingSharedPanel = False);
end;

procedure TEditDialogSecurity.RevertPanelUpdate(Sender: TObject);
begin
  //** if user reverts while adding sp access violates as tries to reference invalid button
  TAction(sender).Enabled := (PanelManager.DetailsModified or PanelManager.PanelModified) and (PanelManager.AddingSharedPanel = False);
end;

procedure TEditDialogSecurity.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not (ThemeModellingMenu.ApplicationClosing) then
    CheckSaveChanges;
end;

procedure TEditDialogSecurity.LoadSecurity;
var
  qry: TADOQuery;
  btn: TTillButton;
  i: integer;
begin
  Log(Format('Loading Security for Panel ID : %d, Theme ID : %d',[panelmanager.panelid, self.themeid]));
  qry := dmthemedata.adoqrun;
  qry.Close;

  qry.sql.text :=
    format('SELECT b.id AS ButtonTypeChoiceID, ISNULL(x.ButtonParamFilter1, '''') AS ButtonTypeChoiceAttr01, ' +
    ' ISNULL(x.ButtonParamFilter2, '''') AS ButtonTypeChoiceAttr02, ' +
    ' MAX(x.ButtonSecurityId) AS ButtonSecurityId, MAX(CAST(RequestWitness AS INT)) AS RequestWitness' +
    ' FROM   (SELECT ThemeID, DialogName, ButtonType, ButtonParamFilter1, ButtonParamFilter2, ISNULL(ButtonSecurityId, 0) AS ButtonSecurityId, RequestWitness' +
    '                FROM ThemeDialogSecurity ' +
    '         UNION ALL ' +
    '         SELECT %d AS ThemeID, DialogName, ButtonType, ButtonParamFilter1, ButtonParamFilter2, ButtonSecurityId, RequestWitness' +
    '                FROM ThemeDialogDefaultSecurity) x' +
    ' JOIN ThemeButtonTypeChoiceLookup b ON x.ButtonType = b.[Name]' +
    ' JOIN ThemeDialogPanelSet c ON c.panelid = %d and x.dialogname = c.dialogpanelname' +
    ' WHERE x.themeid = %d ' +
    ' GROUP BY b.ID, x.ButtonParamFilter1, x.ButtonParamFilter2', [self.themeid, panelmanager.panelid, self.themeid]);
  qry.open;

  with panelmanager do
  begin
    for i := 0 to pred(controlcount) do
      if controls[i] is TTillButton then
      begin
        btn := TTillButton(controls[i]);
        if qry.Locate('ButtonTypeChoiceID;buttontypechoiceattr01;buttontypechoiceattr02',
          vararrayof([btn.ButtonTypeID, btn.buttontypedata, btn.buttontypedata2]), [loCaseInsensitive]) then
        begin
          if (qry.fieldbyname('ButtonSecurityId').isNull) or (qry.fieldbyname('ButtonSecurityId').AsInteger = 0) then
            btn.ButtonSecurityId := -2
          else
            btn.ButtonSecurityId := qry.fieldbyname('ButtonSecurityId').AsInteger;
          btn.RequestWitness := (qry.fieldbyname('RequestWitness').AsInteger = 1);
        end;
      end;
    detailsmodified := false;
  end;

  qry.close;
end;

procedure TEditDialogSecurity.SaveSecurity;
var
  i: integer;
begin
  with panelmanager do
  begin
    for i := 0 to pred(controlcount) do
      if controls[i] is TTillbutton and TTillobject(controls[i]).upd then
      begin
        SetStaticPanelSecurity(ThemeID, TTillbutton(controls[i]));
        TTillobject(controls[i]).upd := false;
      end;
    detailsmodified := false;
  end;
end;

end.
