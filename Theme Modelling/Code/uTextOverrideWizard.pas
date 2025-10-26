unit uTextOverrideWizard;

interface

{$R 'ClockoutTicketFooterSQL.res' 'ClockoutTicketFooterSQL.rc'}
{$R 'BillFooterSQL.res' 'BillFooterSQL.rc'}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Mask, wwdbedit, Wwdbspin, ActnList,
  Spin, uDataTree, Grids, Wwdbigrd, Wwdbgrid, uFooterPreview, DB, wwdblook,
  Wwkeycb, wwDialog, Wwlocate, StrUtils, CheckLst, wwdbdatetimepicker,
  ADODB, DBCtrls, uTagSelection, uBaseTagFilterFrame, uSiteTagFilterFrame;

const
  TIMAGE_TAG_ZONAL_Z_BIG = 101;
  TIMAGE_TAG_ZONAL_Z_SMALL = 102;
  UM_INITFOCUS = WM_USER;
  PANE_RESIZE_LEFT_OFFSET = -27;
  PANE_RESIZE_MIDDLE_OFFSET = -12;
  PANE_RESIZE_RIGHT_OFFSET = 20;
  MAX_USER_CONFIGURABLE_LINES = 30;

  TextOverride_CreateTabs = 'if object_id(''tempdb..#OverrideSites'') is null create table #OverrideSites (SiteId int not null, primary key (SiteId))';

  TextOverride_LoadScrollingMessageDetails = 'select * from ThemeScrollingMessageOverride where Id = %d';
  TextOverride_LoadStandardFooterDetails = 'select * from ThemeReceiptFooterOverride where Id = %d';

  TextOverride_LoadStandardFooterSites = 'delete #OverrideSites insert #OverrideSites select distinct SiteCode from ThemeOutletStandardPrintConfigs where StandardFooterOverrideId = %d';
  TextOverride_LoadScrollingMessageSites = 'delete #OverrideSites insert #OverrideSites select distinct SiteCode from ThemeEposDevice where ScrollingMessageOverrideId = %d';
  TextOverride_LoadBillFooterSites = 'delete #OverrideSites insert #OverrideSites select distinct SiteCode from ThemeOutletStandardPrintConfigs where BillFooterOverrideId = %d';

  TextOverride_SaveStandardFooterSites =
    'declare @FooterID int set @FooterID = %d '+
    'update ThemeOutletStandardPrintConfigs set StandardFooterOverrideId = @FooterID '+
    'from ThemeOutletStandardPrintConfigs a join #overridesites b on a.SiteCode = b.SiteId '+
    'update ThemeOutletStandardPrintConfigs set StandardFooterOverrideId = null '+
    'from ThemeOutletStandardPrintConfigs a left outer join #overridesites b on a.SiteCode = b.SiteId '+
    'where a.StandardFooterOverrideId = @FooterID and b.SiteId is null ';

//  'declare @FooterID int set @FooterId = %d update ThemeOutletStandardPrintConfigs set StandardFooterOverrideID = null where StandardFooterOverrideID = @FooterID and SiteCode not in  update ThemeOutletStandardPrintConfigs set StandardFooterOverrideID = @FooterId where SiteCode in (select SiteID from #OverrideSites)';
  TextOverride_SaveScrollingMessageSites =
    'declare @FooterID int set @FooterID = %d '+
    'update ThemeEposDevice set ScrollingMessageOverrideId = @FooterID '+
    'from ThemeEposDevice a join #overridesites b on a.SiteCode = b.SiteId '+
    'update ThemeEposDevice set ScrollingMessageOverrideId = null '+
    'from ThemeEposDevice a left outer join #overridesites b on a.SiteCode = b.SiteId '+
    'where a.ScrollingMessageOverrideId = @FooterID and b.SiteId is null';

// TODO:  Should replace this with SQL in SaveBillFooterData.sql but can't because the sites/sales area data
// has to be loaded by dmThemeData because the Site/Sales Area tree is connected to that data module.  Unfortunately
// the other queries in the wizard are created by dmADO which doesn't have access to #overridesites.
  TextOverride_SaveBillFooterSites =
    'declare @FooterID int set @FooterID = %d '+
    'update ThemeOutletStandardPrintConfigs set BillFooterOverrideId = @FooterID '+
    'from ThemeOutletStandardPrintConfigs a join #overridesites b on a.SiteCode = b.SiteId '+
    'update ThemeOutletStandardPrintConfigs set BillFooterOverrideId = null '+
    'from ThemeOutletStandardPrintConfigs a left outer join #overridesites b on a.SiteCode = b.SiteId '+
    'where a.BillFooterOverrideId = @FooterID and b.SiteId is null ';


  //'declare @FooterID int set @FooterId = %d update ThemeEposDevice set ScrollingMessageOverrideId = @FooterId where SiteCode in (select SiteID from #OverrideSites)';

  TextOverride_StandardFooterChangedAssignment =
    'select d.Name as SiteName, c.Name as OverrideName  from #overridesites a '+
    'join ThemeOutletStandardPrintConfigs b on a.SiteId = b.SiteCode '+
    'join ThemeReceiptFooterOverride c on b.StandardFooterOverrideId = c.Id '+
    'join ac_Site d on b.SiteCode = d.Id '+
    'where b.StandardFooterOverrideId <> %d '+
    'and c.IsBillFooter = 0 ';
  TextOverride_ScrollingMessageChangedAssignment =
    'select distinct d.Name as SiteName, c.Name as OverrideName  from #overridesites a '+
    'join ThemeEposDevice b on a.SiteId = b.SiteCode '+
    'join ThemeScrollingMessageOverride c on b.ScrollingMessageOverrideId = c.Id '+
    'join ac_Site d on b.SiteCode = d.Id '+
    'where b.ScrollingMessageOverrideId <> %d';

  TextOverride_BillFooterChangedAssignment =
    'select d.Name as SiteName, c.Name as OverrideName  from #overridesites a '+
    'join ThemeOutletStandardPrintConfigs b on a.SiteId = b.SiteCode '+
    'join ThemeBillFooterOverride c on b.BillFooterOverrideId = c.Id '+
    'join ac_Site d on b.SiteCode = d.Id '+
    'where b.BillFooterOverrideId <> %d ';

  TextOverride_DropTabs = 'if object_id(''tempdb..#OverrideSites'') is not null drop table #OverrideSites';

type

  TWizardDirection = (wdNext, wdBack);

  TOverrideWizardMode = (wmStandardFooterOverride, wmScrollingMessageOverride, wmBillFooterOverride,wmClockoutTicketFooterOverride);

  TTextOverrideWizard = class(TForm)
    pcFooterWizard: TPageControl;
    btnBack: TButton;
    btnNext: TButton;
    btnClose: TButton;
    pnlBottom: TPanel;
    actlPromotionalFooter: TActionList;
    actNext: TAction;
    actBack: TAction;
    tsSelectSites: TTabSheet;
    pnlSalesAreaTop: TPanel;
    bvlSelectSites: TBevel;
    imgSelectSites: TImage;
    lblSelectSites: TLabel;
    lblSelectSitesDesc: TLabel;
    tvAvailableSA: TTreeView;
    tvSelectedSA: TTreeView;
    edtSASearch: TEdit;
    btnFindPrevSA: TButton;
    btnIncludeSA: TButton;
    btnIncludeAllSA: TButton;
    btnRemoveAllSA: TButton;
    btnRemoveSA: TButton;
    btnFindNextSA: TButton;
    actFindNextSA: TAction;
    actFindPrevSA: TAction;
    actIncludeSA: TAction;
    actRemoveSA: TAction;
    actIncludeAllSA: TAction;
    actRemoveAllSA: TAction;
    lblAvailableSA: TLabel;
    lblSelectedSA: TLabel;
    tsFinish: TTabSheet;
    pnlFinishTop: TPanel;
    imgFinished: TImage;
    lblFinish: TLabel;
    bvlFinished: TBevel;
    lblFinishedMessage: TLabel;
    actShowPreview: TAction;
    tsStandardFooterOverride: TTabSheet;
    pnlSiteLogo: TPanel;
    imgSiteZonalLogo: TImage;
    lblPFOverrideName: TLabel;
    lblPFOverrideDescription: TLabel;
    tsScrollingMessageOverride: TTabSheet;
    lblName: TLabel;
    lblDescription: TLabel;
    lblSMOverrideName: TLabel;
    lblSMOverrideDescription: TLabel;
    pnlLogo: TPanel;
    imZonalLogo: TImage;
    edScrollingMessageOverrideName: TEdit;
    edScrollingMessageOverrideText: TEdit;
    Label4: TLabel;
    edStandardFooterOverrideName: TEdit;
    Label5: TLabel;
    mmStandardFooterOverrideText: TMemo;
    lbNoSitesAssignedWarning: TLabel;
    lbChangeAssignmentWarning: TLabel;
    sgChangeAssignmentWarning: TStringGrid;
    tsClockoutTicketFooterOverride: TTabSheet;
    lblClockOutFooterOverrideName: TLabel;
    lblClockOutFooterOverrideHeader: TLabel;
    lblClockOutFooterOverrideWizardDesc: TLabel;
    pnlZonalLogo: TPanel;
    imgZonalLogo: TImage;
    edtClockOutFooterOverrideName: TEdit;
    tsClockoutTicketFooterOverrideText: TTabSheet;
    pnllockOutTicketFooterOverrideText: TPanel;
    imgClockOutTicketFooterOverrideText: TImage;
    bvlClockOutTicketFooterOverrideText: TBevel;
    lblClockOutTicketFooterOverrideTextDescription: TLabel;
    lblClockOutTicketFooterOverrideText: TLabel;
    dbgrdClockoutTicketFooterOverride: TwwDBGrid;
    btnPreview: TButton;
    lblClockOutFooterOverrideDescription: TLabel;
    mClockOutFooterOverrideDescription: TMemo;
    btnInsert: TButton;
    btnDelete: TButton;
    actInsertClockoutTicketFooterLine: TAction;
    actDeleteClockoutTicketFooterLine: TAction;
    SiteTagFilterFrame: TSiteTagFilterFrame;
    tsBillFooterOverride: TTabSheet;
    pnlBillZonalLogo: TPanel;
    imgBillZonalLogo: TImage;
    lblBillFooterOverrideHeader: TLabel;
    lblBillFooterOverrideWizardDesc: TLabel;
    lblBillFooterOverrideName: TLabel;
    edtBillFooterOverrideName: TEdit;
    lblBillFooterOverrideDescription: TLabel;
    mBillFooterOverrideDescription: TMemo;
    tsBillFooterOverrideText: TTabSheet;
    dbgrdBillFooterOverride: TwwDBGrid;
    btnPreviewBill: TButton;
    pnlBillFooterOverrideText: TPanel;
    imgBillFooterOverrideText: TImage;
    lblBillFooterOverrideTextDescription: TLabel;
    lblBillFooterOverrideText: TLabel;
    actPreviewBillFooter: TAction;
    luAlignment: TwwDBLookupCombo;
    procedure FormCreate(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure actBackExecute(Sender: TObject);
    procedure SearchEnter(Sender: TObject);
    procedure SearchExit(Sender: TObject);
    procedure actIncludeSAExecute(Sender: TObject);
    procedure actRemoveSAExecute(Sender: TObject);
    procedure actIncludeAllSAExecute(Sender: TObject);
    procedure actRemoveAllSAExecute(Sender: TObject);
    procedure actFindNextSAExecute(Sender: TObject);
    procedure actFindPrevSAExecute(Sender: TObject);
    procedure edtSASearchChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure tsSelectSitesResize(Sender: TObject);
    procedure mmStandardFooterOverrideTextKeyPress(Sender: TObject;
      var Key: Char);
    procedure mmStandardFooterOverrideTextChange(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure dbgrdClockoutTicketFooterOverrideCalcCellColors(
      Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure dbgrdClockoutTicketFooterOverrideKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure dbgrdClockoutTicketFooterOverrideCellChanged(
      Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure actInsertClockoutTicketFooterLineExecute(Sender: TObject);
    procedure actDeleteClockoutTicketFooterLineExecute(Sender: TObject);
    procedure dbgrdClockoutTicketFooterOverrideKeyPress(Sender: TObject;
      var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actPreviewBillFooterExecute(Sender: TObject);
  private
    { Private declarations }
    FCurrentPage: integer;
    FOverrideID: Integer;
    FExistingID: integer;
    FSalesAreaDataTree: TDataTree;
    FSASearchTerm: string;
    FSASearchTermChanged: boolean;
    SalesAreaSelectionChanged: boolean;
    FWizardMode: TOverrideWizardMode;

    FooterSavedText: string;

    procedure OnEnterPage(Page: TTabSheet; Direction : TWizardDirection);
    procedure OnLeavePage(Page: TTabSheet; Direction : TWizardDirection);
    function FindTab(PageControl: TPageControl; CurrentTabIndex: integer;
      GoForward: boolean): integer;
    procedure MoveToPage(PageIndex: integer);
    procedure UpdateNavigationButtons;
    procedure LoadData;
    procedure SaveData;
    function CheckTextValue(Value, Error: String): Boolean;
    procedure GetSalesAreaSelection(TableName: string);
    procedure ClockoutTicketFooterInsert;
    procedure ClockoutTicketFooterDelete;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; WizardMode: TOverrideWizardMode); reintroduce;
    class function ShowWizard(AOverrideID, AExistingID: integer; WizardMode: TOverrideWizardMode): boolean;
    property OverrideID: Integer read FOverrideID write FOverrideID;
    property ExistingID: Integer read FExistingID write FExistingID;
    property WizardMode: TOverrideWizardMode read FWizardMode write FWizardMode;
  end;

implementation

uses
  useful, udmThemeData, uAztecLog, uSimplelocalise, math,
  DateUtils, uADO, Clipbrd, uDMPromotionalFooter, uGenerateThemeIDs,
  uThemeModellingMenu;

{$R *.dfm}

class function TTextOverrideWizard.ShowWizard(AOverrideID, AExistingID: integer; WizardMode: TOverrideWizardMode): boolean;
var
  WizardInstance: TTextOverrideWizard;
begin
  Log('Text override Wizard - Creating - Id= ' + inttostr(AOverrideID) + ', ExistingId=' + inttostr(AExistingID));
  dmPromotionalFooter.AwaitPreload;
  WizardInstance := TTextOverrideWizard.Create(nil, WizardMode);
  with WizardInstance do
  begin
    OverrideId := AOverrideID;
    ExistingID := AExistingID;
    PostMessage(Handle, UM_INITFOCUS, 0, 0);
    LoadData;
    Result := ShowModal = mrOk;
    Free;
  end;
end;

procedure TTextOverrideWizard.FormCreate(Sender: TObject);

  procedure DisableControls(Control: TWinControl);
  var
    i: Integer;
  begin
    for i := 0 to Control.ControlCount - 1 do
    begin
      if Control.Controls[i] is TWinControl then
        if TWinControl(Control.Controls[i]).ControlCount > 0 then
          DisableControls(TWinControl(Control.Controls[i]));
      Control.Controls[i].Enabled := False;
    end;
  end;

var
  i: Integer;
begin
//  if (WizardMode = wmStandardFooterOverride) then
//  begin
//    tsScrollingMessageOverride.Enabled := False;
//    tsStandardFooterOverride.Enabled := True;
//    tsBillFooterOverride.Enabled := False;
//    tsClockoutTicketFooterOverride.Enabled := False;
//  end
//  else if (WizardMode = wmBillFooterOverride) then
//  begin
//    tsScrollingMessageOverride.Enabled := False;
//    tsStandardFooterOverride.Enabled := False;
//    tsBillFooterOverride.Enabled := True;
//    tsBillFooterOverrideText.Enabled := True;
//    tsClockoutTicketFooterOverride.Enabled := False;
//  end
//  else if (WizardMode = wmScrollingMessageOverride) then
//  begin
//    tsScrollingMessageOverride.Enabled := True;
//    tsStandardFooterOverride.Enabled := False;
//    tsBillFooterOverride.Enabled := False;
//    tsClockoutTicketFooterOverride.Enabled := False;
//  end
//  else if (WizardMode = wmClockoutTicketFooterOverride) then
//  begin
//    tsScrollingMessageOverride.Enabled := False;
//    tsStandardFooterOverride.Enabled := False;
//    tsBillFooterOverride.Enabled := False;
//    tsSelectSites.Enabled := False;
//    tsClockoutTicketFooterOverride.Enabled := True;
//    tsClockoutTicketFooterOverrideText.Enabled := True;
//  end;

  case WizardMode of
    wmStandardFooterOverride:
      tsStandardFooterOverride.Enabled := True;
    wmBillFooterOverride:
      begin
        tsBillFooterOverride.Enabled := True;
        tsBillFooterOverrideText.Enabled := True;
      end;
    wmScrollingMessageOverride:
      tsScrollingMessageOverride.Enabled := True;
    wmClockoutTicketFooterOverride:
      begin
        tsSelectSites.Enabled := False;
        tsClockoutTicketFooterOverride.Enabled := True;
        tsClockoutTicketFooterOverrideText.Enabled := True;
      end;
  end;

  // Ensure the correct start tab sheet.
  pcFooterWizard.ActivePage := nil;
  for i := 0 to Pred(pcFooterWizard.PageCount) do
    pcFooterWizard.Pages[i].TabVisible := False;

  MoveToPage(FindTab(pcFooterWizard, -1, True));

  //Side/top bar images loaded from compiled resource.
  for i := 0 to Pred(ComponentCount) do
  begin
    if (Components[i] is TImage) then
      case TImage(Components[i]).Tag of
        TIMAGE_TAG_ZONAL_Z_BIG:
          TImage(Components[i]).Picture.Bitmap.LoadFromResourceName(HInstance, 'ZonalZWhiteBk100x100');
        TIMAGE_TAG_ZONAL_Z_SMALL:
          TImage(Components[i]).Picture.Bitmap.LoadFromResourceName(HInstance, 'ZonalZWhiteBk50x50');
      end;
  end;

    // Initialise sales area selection page
  FSalesAreaDataTree := TDataTree.Create(tvAvailableSA, dmThemeData.AztecConn, '##ConfigTree_Data', ConfigNamesArray, True);
  FSalesAreaDataTree.AddLevel('Company', '');
  FSalesAreaDataTree.AddLevel('Area', '');
  FSalesAreaDataTree.AddLevel('Site', '');
  FSalesAreaDataTree.Initialise;

  tvSelectedSA.ShowHint := True;
  tvSelectedSA.ReadOnly := True;

  dmPromotionalFooter.BackUpConfigTreeData;
  SiteTagFilterFrame.ADOConnection := dmThemeData.AztecConn;
  SiteTagFilterFrame.DataTreeToFilter := FSalesAreaDataTree;
end;

procedure TTextOverrideWizard.OnEnterPage(Page: TTabSheet;
  Direction: TWizardDirection);
var
  i: integer;
begin
  if Assigned(Page) then
    Log('Text override Wizard - OnEnterPage: ' + Page.Name);

  if Page = tsFinish then
  begin
    if WizardMode = wmClockoutTicketFooterOverride then
    begin
      lbChangeAssignmentWarning.Visible := false;
      sgChangeAssignmentWarning.Visible := false;
      lbNoSitesAssignedWarning.Visible := false;
    end
    else
    begin
      lbChangeAssignmentWarning.Top := lbNoSitesAssignedWarning.Top;
      lbChangeAssignmentWarning.Left := lbNoSitesAssignedWarning.Left;
      if tvSelectedSA.Items.Count = 0 then
      begin
       lbChangeAssignmentWarning.Visible := false;
       sgChangeAssignmentWarning.Visible := false;
       lbNoSitesAssignedWarning.Visible := true;
      end
      else
      begin
        lbNoSitesAssignedWarning.Visible := false;
        with dmThemeData.adoqRun do
        begin
          if (WizardMode = wmStandardFooterOverride) then
            SQL.Text := Format(TextOverride_StandardFooterChangedAssignment, [OverrideId])
          else if (WizardMode = wmBillFooterOverride) then
            SQL.Text := Format(TextOverride_BillFooterChangedAssignment, [OverrideId])
          else if (WizardMode = wmScrollingMessageOverride) then
            SQL.Text := Format(TextOverride_ScrollingMessageChangedAssignment, [OverrideId]);

          Open;
          lbChangeAssignmentWarning.Visible := RecordCount > 0;
          sgChangeAssignmentWarning.Visible := RecordCount > 0;
          if RecordCount > 0 then
          begin
            sgChangeAssignmentWarning.RowCount := RecordCount +1;
            sgChangeAssignmentWarning.FixedRows := 1;
            sgChangeAssignmentWarning.Cells[0, 0] := 'Site Name';
            sgChangeAssignmentWarning.Cells[1, 0] := 'Old Override';
            for i := 1 to RecordCount do
            begin
              sgChangeAssignmentWarning.Cells[0, i] := FieldByName('SiteName').AsString;
              sgChangeAssignmentWarning.Cells[1, i] := FieldByName('OverrideName').AsString;
              next;
            end;
          end;
          Close;
        end;
      end;
    end;
  end;
end;

procedure TTextOverrideWizard.OnLeavePage(Page: TTabSheet;
  Direction: TWizardDirection);
var
  OldParamCheck: Boolean;
begin
  if Assigned(Page) then
    Log('Footer Wizard OnLeavePage: ' + Page.Name);

  OldParamCheck := dmAdo.adoqRun.ParamCheck;
  dmAdo.adoqRun.ParamCheck := False;
  try
    if (Page = tsStandardFooterOverride) and (Direction = wdNext) then
    begin
      if not CheckTextValue(edStandardFooterOverrideName.Text, 'Please enter a name before continuing') then abort;
      if not CheckTextValue(mmStandardFooterOverrideText.Text, 'Please enter some override text before continuing') then abort;

      // check for duplicate names
      dmAdo.adoqRun.SQL.Text :=
        Format('SELECT Name FROM ThemeReceiptFooterOverride where Name = %s and Id <> %d',
        [QuotedStr(edStandardFooterOverrideName.Text), FOverrideID]);

      dmAdo.adoqRun.Open;
      if (not dmAdo.adoqRun.Eof) then begin
        MessageDlg(Format('An override named %s already exists.'#13#10+
          'Please enter a unique name.', [edStandardFooterOverrideName.Text]), mtInformation, [mbOK], 0);
        abort;
      end;
    end
    else
    if (Page = tsBillFooterOverride) and (Direction = wdNext) then
    begin
      if not CheckTextValue(edtBillFooterOverrideName.Text, 'Please enter a name before continuing') then abort;

      // check for duplicate names
      dmAdo.adoqRun.SQL.Text :=
        Format('SELECT Name FROM ThemeBillFooterOverride where Name = %s and Id <> %d',
        [QuotedStr(edtBillFooterOverrideName.Text), FOverrideID]);

      dmAdo.adoqRun.Open;
      if (not dmAdo.adoqRun.Eof) then
      begin
        MessageDlg(Format('An override named %s already exists.'#13#10+
          'Please enter a unique name.', [edtBillFooterOverrideName.Text]), mtInformation, [mbOK], 0);
        abort;
      end;
      dmAdo.adoqRun.Close;
      dmAdo.adoqRun.SQL.Text :=
        Format('UPDATE #BillFooterOverride SET Name = %s, Description = %s', [QuotedStr(edtBillFooterOverrideName.Text),  QuotedStr(mBillFooterOverrideDescription.Text)]);
      dmAdo.adoqRun.ExecSQL;
    end
    else if (Page = tsBillFooterOverrideText) then 
    begin
      if dmADO.qBillFooterTextOverride.State in [dsEdit, dsInsert] then
        dmADO.qBillFooterTextOverride.Post;

      if (Direction = wdNext) then
      begin
        dmADO.adoqRun.Close;
        dmADO.adoqRun.SQL.Text := 'SELECT COUNT(*) as LineCount from #BillFooterTextOverride where ISNULL([Text],'''') <> ''''';
        dmADO.adoqRun.Open;
        if (dmADO.adoqRun.FieldByName('LineCount').Value = 0) then
        begin
          MessageDlg('Please enter at least one text line before continuing.', mtInformation, [mbOK], 0);
          Abort;
        end;
      end;
    end
    else
    if (Page = tsScrollingMessageOverride) and (Direction = wdNext) then
    begin
      if not CheckTextValue(edScrollingMessageOverrideName.Text, 'Please enter a name before continuing') then abort;
      if not CheckTextValue(edScrollingMessageOverrideText.Text, 'Please enter some override text before continuing') then abort;

      // check for duplicate names
      dmAdo.adoqRun.SQL.Text :=
        Format('SELECT Name FROM ThemeScrollingMessageOverride where Name = %s and Id <> %d',
        [QuotedStr(edScrollingMessageOverrideName.Text), FOverrideID]);

      dmAdo.adoqRun.Open;
      if (not dmAdo.adoqRun.Eof) then begin
        MessageDlg(Format('An override named %s already exists.'#13#10+
          'Please enter a unique name.', [edScrollingMessageOverrideName.Text]), mtInformation, [mbOK], 0);
        abort;
      end;
    end
    else if (Page = tsSelectSites) and (Direction = wdNext) then
    begin
      if SalesAreaSelectionChanged then
      begin
        GetSalesAreaSelection(FSalesAreaDataTree.SaveToTempTable(tvSelectedSA));
        SalesAreaSelectionChanged := False;
      end;
    end
    else if (Page = tsClockoutTicketFooterOverride) and (Direction = wdNext) then
    begin
      if not CheckTextValue(edtClockOutFooterOverrideName.Text, 'Please enter a name before continuing') then abort;

      // check for duplicate names
      dmAdo.adoqRun.SQL.Text :=
        Format('SELECT Name FROM ThemeClockoutTicketFooterOverride where Name = %s and Id <> %d',
        [QuotedStr(edtClockOutFooterOverrideName.Text), FOverrideID]);
      dmAdo.adoqRun.Open;

      if (not dmAdo.adoqRun.Eof) then begin
        MessageDlg(Format('An override named %s already exists.'#13#10+
          'Please enter a unique name.', [edStandardFooterOverrideName.Text]), mtInformation, [mbOK], 0);
        abort;
      end;

      dmAdo.adoqRun.SQL.Text :=
        Format('UPDATE #ClockoutTicketFooterOverride SET Name = %s, Description = %s', [QuotedStr(edtClockOutFooterOverrideName.Text),  QuotedStr(mClockOutFooterOverrideDescription.Text)]);
      dmAdo.adoqRun.ExecSQL;
    end
    else if (Page = tsClockoutTicketFooterOverrideText) and (Direction = wdNext) then
    begin
      if dmADO.qClockoutticketFooterTextOverride.State in [dsEdit, dsInsert] then
        dmADO.qClockoutticketFooterTextOverride.Post;
    end;
  finally
    dmAdo.adoqRun.ParamCheck := OldParamCheck;
  end;
end;

procedure TTextOverrideWizard.MoveToPage(PageIndex: integer);
begin
  FCurrentPage := PageIndex;
  pcFooterWizard.ActivePageIndex := PageIndex;
  if PageIndex = -1 then
  begin
    // Wizard is now finished
    SaveData;
    ModalResult := mrOk;
  end
  else
    UpdateNavigationButtons;
end;

procedure TTextOverrideWizard.UpdateNavigationButtons;
var
  PrevTabIndex, NextTabIndex: integer;
begin
  // Find the previous and next tab numbers, tells us what the state of the
  // back and next/finish buttons should be
  PrevTabIndex := FindTab(pcFooterWizard, FCurrentPage, False);
  NextTabIndex := FindTab(pcFooterWizard, FCurrentPage, True);

  if PrevTabIndex <> -1 then
    btnBack.Enabled := True
  else
    btnBack.Enabled := False;

  if NextTabIndex <> -1 then
    btnNext.Caption := 'Next'
  else
    btnNext.Caption := 'Finish';
end;

procedure TTextOverrideWizard.btnCloseClick(Sender: TObject);
begin
  Log('Text override Wizard - Close button pressed');
  Close;
end;

procedure TTextOverrideWizard.actBackExecute(Sender: TObject);
var
  ActivePageIndex: integer;
begin
  // Save and clear the current active page
  // This is so it can change the available pages and have this
  // affect the FindTab call
  ActivePageIndex := pcFooterWizard.ActivePageIndex;
  dmPromotionalFooter.BeginHourglass;
  try
    OnLeavePage(pcFooterWizard.ActivePage, wdBack);
    pcFooterWizard.ActivePageIndex := -1;
    MoveToPage(FindTab(pcFooterWizard, ActivePageIndex, False));
    // Cheat, as we are not handling the page entry via events
    if Visible then
      useful.ProcessPaintMessages;
    OnEnterPage(pcFooterWizard.ActivePage, wdBack);
  finally
    dmPromotionalFooter.EndHourglass;
  end;
end;

procedure TTextOverrideWizard.actNextExecute(Sender: TObject);
var
  ActivePageIndex: integer;
begin
  ActivePageIndex := pcFooterWizard.ActivePageIndex;
  dmPromotionalFooter.BeginHourglass;
  try
    // NB:on leave page needs direction added to it
    OnLeavePage(pcFooterWizard.ActivePage, wdNext);
    // Force TabSheet hide event to fire before the new one shows
    pcFooterWizard.ActivePageIndex := -1;
    MoveToPage(FindTab(pcFooterWizard, ActivePageIndex, True));
    if Visible then
      useful.ProcessPaintMessages;
    OnEnterPage(pcFooterWizard.ActivePage, wdNext);
  finally
    dmPromotionalFooter.EndHourglass;
  end;
end;

function TTextOverrideWizard.FindTab(PageControl: TPageControl;
  CurrentTabIndex: integer; GoForward: boolean): integer;
var
  i: integer;
begin
  // Navigate through the page list - pages with enabled set to false
  // are ignored.
  // PageControl has similar functionality but uses the TabVisible property,
  // therefore it is limited to having tabs in use when functioning in a
  // Wizard-like manner. In effect this code replaces the PageControl management
  // of the active page.
  Result := -1;
  if GoForward then
  begin
    for i := CurrentTabIndex+1 to Pred(PageControl.PageCount) do
      if PageControl.Pages[i].Enabled then
      begin
        Result := i;
        break;
      end;
  end
  else
  begin
    for i := CurrentTabIndex-1 downto 0 do
      if PageControl.Pages[i].Enabled then
      begin
        Result := i;
        break;
      end;
  end;
end;

procedure TTextOverrideWizard.LoadData;
var
  i: integer;
  MaxLine: integer;
  FooterString: string;
begin
  Log('Text override Wizard - LoadData - started');
  MaxLine := 0;

  with dmPromotionalFooter do
  begin
    // load data depending on which type of override is being created.
    if (WizardMode = wmScrollingMessageOverride)
        or (WizardMode = wmStandardFooterOverride)
        or (WizardMode = wmBillFooterOverride)  then
    begin
      dmThemeData.AdoqRun.SQL.Text := TextOverride_CreateTabs;
      dmThemeData.AdoqRun.ExecSQL;
    end;

    // load GUI with existing values
    if ExistingID <> -1 then
    begin
      if WizardMode = wmScrollingMessageOverride then
      begin
        dmAdo.qRun.SQL.Text := Format(TextOverride_LoadScrollingMessageDetails, [ExistingId]);
        dmAdo.qRun.Open;
        edScrollingMessageOverrideName.Text := dmAdo.qRun.FieldByName('Name').AsString;
        edScrollingMessageOverrideText.Text := dmAdo.qRun.FieldByName('ScrollingMessage').AsString;
        dmThemeData.AdoqRun.Close;
        dmThemeData.AdoqRun.SQL.Text := Format(TextOverride_LoadScrollingMessageSites, [ExistingId]);
        dmThemeData.AdoqRun.ExecSql;
        FSalesAreaDataTree.LoadFromTempTable(tvSelectedSA, '#OverrideSites', 'SiteId');
      end
      else if (WizardMode = wmStandardFooterOverride) then
      begin
        dmAdo.qRun.SQL.Text := Format(TextOverride_LoadStandardFooterDetails, [ExistingId]);
        dmAdo.qRun.Open;
        edStandardFooterOverrideName.Text := dmAdo.qRun.FieldByName('Name').AsString;
        for i := 1 to 6 do
        begin
          if dmAdo.qRun.FieldByName(Format('PrintFooter%d', [i])).AsString <> '' then
            MaxLine := i;
        end;

        for i := 1 to MaxLine do
        begin
          if FooterString <> '' then
            FooterString := FooterString + #13#10;
          FooterString := FooterString + dmAdo.qRun.FieldByName(Format('PrintFooter%d', [i])).AsString;
        end;
        mmStandardFooterOverrideText.Lines.Text := FooterString;
        dmAdo.qRun.Close;
        dmThemeData.AdoqRun.SQL.Text := Format(TextOverride_LoadStandardFooterSites, [ExistingId]);
        dmThemeData.AdoqRun.ExecSql;
        FSalesAreaDataTree.LoadFromTempTable(tvSelectedSA, '#OverrideSites', 'SiteId');
      end;
    end;
    if (WizardMode = wmClockoutTicketFooterOverride) then
    begin
      if ExistingID <> -1 then
      begin
        edtClockOutFooterOverrideName.Text := dmADO.qClockoutTicketFooterOverrideName.AsString;
        mClockOutFooterOverrideDescription.Text := dmADO.qClockoutTicketFooterOverrideDescription.AsString;
      end;

      dmAdo.adoqRun.Close;
      dmADO.adoqRun.SQL.Text := StringReplace(GetStringResource('LoadClockoutTicketFooterData', 'TEXT'), '@ClockoutTicketFooterID_in', IntToStr(ExistingID), [rfReplaceAll, rfIgnoreCase]);
      dmADO.adoqRun.ExecSQL;
      dmADO.qClockoutTicketFooterTextOverride.Close;
      dmADO.qClockoutTicketFooterTextOverride.Open;
    end;
    if (WizardMode = wmBillFooterOverride) then
    begin
      if ExistingID <> -1 then
      begin
        edtBillFooterOverrideName.Text := dmAdo.qBFOverrideName.AsString;
        mBillFooterOverrideDescription.Text := dmADO.qBFOverrideDescription.AsString;
      end;

      dmADO.adoqRun.Close;
      dmADO.adoqRun.SQL.Text := StringReplace(GetStringResource('LoadBillFooterData', 'TEXT'), '@BillFooterID_in', IntToStr(ExistingID), [rfReplaceAll, rfIgnoreCase]);;
      dmADO.adoqRun.ExecSql;
      dmThemeData.AdoqRun.SQL.Text := Format(TextOverride_LoadBillFooterSites, [ExistingId]);
      dmThemeData.AdoqRun.ExecSQL;
      dmADO.qBillFooterTextOverride.Close;
      dmADO.qBillFooterTextOverride.Open;
      FSalesAreaDataTree.LoadFromTempTable(tvSelectedSA, '#OverrideSites', 'SiteId');
    end;

  end;
  Log('Text override Wizard - LoadData - finished');
end;

procedure TTextOverrideWizard.SaveData;
var
  i: Integer;
begin
  Log('Text override Wizard - SaveData - started');
  if WizardMode = wmScrollingMessageOverride then
  begin
    if OverrideID = -1 then
      OverrideID := GetNewId(scThemeScrollingMessageOverride);
    dmAdo.qRun.SQL.Text := Format(TextOverride_LoadScrollingMessageDetails, [OverrideId]);
    dmAdo.qRun.Open;
    if ExistingID <> -1 then
      dmAdo.qRun.Edit
    else
    begin
      dmAdo.qRun.Insert;
      dmAdo.qRun.FieldByName('Id').AsInteger := OverrideId;
    end;
    dmAdo.qRun.FieldByName('Name').AsString := edScrollingMessageOverrideName.Text;
    dmAdo.qRun.FieldByName('ScrollingMessage').AsString := edScrollingMessageOverrideText.Text;
    dmAdo.qRun.Post;
    dmAdo.qRun.Close;
    dmThemeData.adoqRun.SQL.Text := Format(TextOverride_SaveScrollingMessageSites, [OverrideId]);
    dmThemeData.AdoqRun.ExecSQL;
  end
  else if (WizardMode = wmStandardFooterOverride) then
  begin
    if OverrideID = -1 then
      OverrideID := GetNewId(scThemeStandardFooterOverride);
    dmAdo.qRun.SQL.Text := Format(TextOverride_LoadStandardFooterDetails, [OverrideId]);
    dmAdo.qRun.Open;
    if ExistingID <> -1 then
      dmAdo.qRun.Edit
    else
    begin
      dmAdo.qRun.Insert;
      dmAdo.qRun.FieldByName('Id').AsInteger := OverrideId;
    end;
    dmAdo.qRun.FieldByName('Name').AsString := edStandardFooterOverrideName.Text;
    for i := 0 to 5 do
    begin
      if i < mmStandardFooterOverrideText.Lines.Count then
        dmAdo.qRun.FieldByName(Format('PrintFooter%d', [i+1])).AsString := mmStandardFooterOverrideText.Lines[i]
      else
        dmAdo.qRun.FieldByName(Format('PrintFooter%d', [i+1])).AsString := '';
    end;
    dmAdo.qRun.Post;
    dmAdo.qRun.Close;

    dmThemeData.adoqRun.SQL.Text := Format(TextOverride_SaveStandardFooterSites, [OverrideId]);

    dmThemeData.AdoqRun.ExecSql;
  end
  else if (WizardMode = wmBillFooterOverride) then
  begin
    with dmADO.adoqRun do
    begin
      if OverrideID = -1 then
      begin
        // Generate new promotion ID and update temporary tables with it
        SQL.Text := StringReplace(GetStringResource('GetUniqueID', 'TEXT'), '@InputTableName', 'ThemeBillFooterOverride_repl', [rfReplaceAll, rfIgnoreCase]);
        Open;
        OverrideID := TLargeIntField(fieldbyname('Output')).Asinteger;
        Close;
        dmADO.SafeExecSQL;
      end;

      SQL.Text := StringReplace(GetStringResource('SaveBillFooterData', 'TEXT'), '@BillFooterID_in', IntToStr(OverrideID), [rfReplaceAll, rfIgnoreCase]);
      dmado.SafeExecSQL;
    end;
    dmThemeData.adoqRun.SQL.Text := Format(TextOverride_SaveBillFooterSites, [OverrideId]);
    dmThemeData.AdoqRun.ExecSql;
  end
  else if WizardMode = wmClockoutTicketFooterOverride then
  begin
    with dmADO.adoqRun do
    begin
      if FExistingID = -1 then
      begin
        // Generate new promotion ID and update temporary tables with it
        SQL.Text := StringReplace(GetStringResource('GetUniqueID', 'TEXT'), '@InputTableName', 'ThemeClockoutTicketFooterOverride_repl', [rfReplaceAll, rfIgnoreCase]);
        Open;
        FExistingID := TLargeIntField(fieldbyname('Output')).Asinteger;
        Close;
        dmADO.SafeExecSQL;
      end;

      SQL.Text := StringReplace(GetStringResource('SaveClockoutTicketFooterData', 'TEXT'), '@ClockoutTicketFooterID_in', IntToStr(FExistingID), [rfReplaceAll, rfIgnoreCase]);
      dmado.SafeExecSQL;
    end;
  end;

  Log('Text override Wizard - SaveData - finished');
end;

procedure TTextOverrideWizard.actIncludeSAExecute(Sender: TObject);
begin
  Log('Text override Wizard - Select Sites - Include Sales Area (>) Clicked');
  FSalesAreaDataTree.SelectItem(tvSelectedSA);
  SalesAreaSelectionChanged := True;
end;

procedure TTextOverrideWizard.actRemoveSAExecute(Sender: TObject);
begin
  Log('Text override Wizard - Select Sites - Exclude Sales Area (<) Clicked');
  FSalesAreaDataTree.DeselectItem(tvSelectedSA);
  SalesAreaSelectionChanged := True;
end;

procedure TTextOverrideWizard.actIncludeAllSAExecute(Sender: TObject);
begin
  Log('Text override Wizard - Select Sites - Include All Sales Areas (>>) Clicked');
  FSalesAreaDataTree.SelectAll(tvSelectedSA);
  SalesAreaSelectionChanged := True;
end;

procedure TTextOverrideWizard.actRemoveAllSAExecute(Sender: TObject);
begin
  Log('Text override Wizard - Select Sites - Exclude All Sales Areas (<<) Clicked');
  FSalesAreaDataTree.DeselectAll(tvSelectedSA);
  SalesAreaSelectionChanged := True;
end;

procedure TTextOverrideWizard.actFindNextSAExecute(Sender: TObject);
begin
  with FSalesAreaDataTree do
  begin
    if FSASearchTermChanged then
    begin
      FSASearchTermChanged := false;
      FindNodes(FSASearchTerm, '##ConfigTree_Names', 0, GetMaxLevel);
      FindNext;
    end
    else
      FindNext;
  end;
  tvAvailableSA.SetFocus;
end;

procedure TTextOverrideWizard.actFindPrevSAExecute(Sender: TObject);
begin
 with FSalesAreaDataTree do
  begin
    if FSASearchTermChanged then
    begin
      FSASearchTermChanged := false;
      FindNodes(FSASearchTerm, '##ConfigTree_Names', 0, GetMaxLevel);
      FindPrev;
    end
    else
      FindPrev;
  end;
  tvAvailableSA.SetFocus;
end;

procedure TTextOverrideWizard.edtSASearchChange(Sender: TObject);
begin
  if TEdit(Sender).Tag = 0 then
  begin
    if FSASearchTerm <> TEdit(Sender).Text then
    begin
      FSASearchTermChanged := true;
      actFindNextSA.Enabled := true;
      actFindPrevSA.Enabled := true;
      FSASearchTerm := TEdit(Sender).Text;
    end;
  end;
end;

procedure TTextOverrideWizard.SearchEnter(Sender: TObject);
begin
  if TEdit(Sender).Tag = 1 then
  begin
    TEdit(Sender).Font.Color := clWindowText;
    TEdit(Sender).Text := '';
    TEdit(Sender).Tag := 0;
  end;
end;

procedure TTextOverrideWizard.SearchExit(Sender: TObject);
begin
  if Length(TEdit(Sender).Text) = 0 then
  begin
    TEdit(Sender).Tag := 1;
    TEdit(Sender).Font.Color := clGrayText;
    TEdit(Sender).Text := '<Type keywords to search>';
  end;
end;

procedure TTextOverrideWizard.GetSalesAreaSelection(TableName: string);
begin
  with dmThemeData.adoqRun do
  try
    SQL.Text := 'delete #OverrideSites';
    ExecSQL;

    SQL.Text := Format('insert #OverrideSites (SiteID) '+
      'select distinct Level3ID from %s ', [TableName]);
    ExecSQL;

    SQL.Text := Format('drop table %s', [TableName]);
    ExecSQL;
  finally
    Close;
  end;
end;

function TTextOverrideWizard.CheckTextValue (Value : String; Error : String) : Boolean;
begin
  if Trim(Value) = '' then
  begin
    MessageDlg(Error, mtCustom, [mbOK], 0);
    Result := False;
  end
  else
  begin
    Result := True;
  end;
end;

procedure TTextOverrideWizard.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Text override Wizard - Form Close');
  try
    with dmAdo do
    begin
      try
        adoqRun.SQL.Text := TextOverride_DropTabs;
        adoqrun.ExecSQL;
      except on E:Exception do
        if Pos('cannot drop', LowerCase(E.Message)) = 0 then
          raise;
      end;
    end;
  finally
    dmPromotionalFooter.RemoveConfigTreeDataFilter;
  end;

  with dmADO do
  begin
    try
      if (WizardMode = wmClockoutTicketFooterOverride) then
        adoqRun.SQL.Text := GetStringResource('DropClockoutTicketFooterData', 'TEXT')
      else if (WizardMode = wmBillFooterOverride) then
        adoqRun.SQL.Text := GetStringResource('DropBillFooterData', 'TEXT')
      else
        Exit;
      adoqrun.ExecSQL;
    except on E:Exception do
      if Pos('cannot drop', LowerCase(E.Message)) = 0 then
        raise;
    end;
  end;
end;

procedure TTextOverrideWizard.FormShow(Sender: TObject);
var
  WizType: string;
begin
  if (WizardMode = wmStandardFooterOverride) then
    edStandardFooterOverrideName.SetFocus
  else if (WizardMode = wmBillFooterOverride) then
    edtBillFooterOverrideName.SetFocus
  else if (WizardMode = wmScrollingMessageOverride) then
    edScrollingMessageOverrideName.SetFocus
  else if (WizardMode = wmClockoutTicketFooterOverride ) then
    edtClockOutFooterOverrideName.SetFocus;

  if WizardMode = wmStandardFooterOverride then
    WizType := 'Receipt Footer override'
  else if WizardMode = wmBillFooterOverride then
    WizType := LocaliseString('Bill Footer override')
  else
  if WizardMode = wmScrollingMessageOverride then
    WizType := 'Scrolling Message override';

  if (FOverrideId = -1) and (FExistingID = -1) then
  begin
    lblSMOverrideName.Caption := 'New '+WizType;//+' Wizard';
    lblSMOverrideDescription.Caption := 'This wizard will guide you through the process of setting up a new '+WizType+'.';
  end
  else
  if (FOverrideId = ExistingID) then
  begin
    lblSMOverrideName.Caption := 'Edit '+WizType;//+' Wizard';
    lblSMOverrideDescription.Caption := 'This wizard allows you to review and/or edit all parts of the selected '+WizType+'.';
  end;
  lblPFOverrideName.Caption := lblSMOverrideName.Caption;
  lblPFOverrideDescription.Caption := lblSMOverrideDescription.Caption;

  Log('Promotional Footer - FormShow ' + lblPFOverrideName.Caption);
end;


constructor TTextOverrideWizard.Create(AOwner: TComponent;
  WizardMode: TOverrideWizardMode);
begin
  FWizardMode := WizardMode;
  inherited Create(AOwner);
end;


procedure TTextOverrideWizard.tsSelectSitesResize(Sender: TObject);
begin
  tvAvailableSA.Width := TTabSheet(Sender).width div 2 + PANE_RESIZE_LEFT_OFFSET;
  tvSelectedSA.Width := TTabSheet(Sender).width div 2 + PANE_RESIZE_LEFT_OFFSET;
  btnIncludeSA.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  btnIncludeAllSA.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  btnRemoveSA.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  btnRemoveAllSA.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  tvSelectedSA.Left := TTabSheet(Sender).width div 2 + PANE_RESIZE_RIGHT_OFFSET;
  lblSelectedSA.Left := TTabSheet(Sender).width div 2 + PANE_RESIZE_RIGHT_OFFSET;
end;

procedure TTextOverrideWizard.mmStandardFooterOverrideTextKeyPress(
  Sender: TObject; var Key: Char);
var
  i, linecount: integer;
  tmpstr: string;
begin
  linecount := 0;
  tmpstr := TMemo(sender).lines.text;
  for i := 1 to length(tmpstr) do
    if (tmpstr[i] = #13) then inc(linecount);
  if ((key = #13) or (Key = #10)) and (linecount >= 5) then abort;
end;

procedure TTextOverrideWizard.mmStandardFooterOverrideTextChange(
  Sender: TObject);
var
  i: integer;
  pos: integer;
  OverLimit: boolean;
begin
  OverLimit := FALSE;

  if tmemo(sender).modified then
  begin
    for i := 0 to pred(tmemo(Sender).Lines.Count) do
      if length(tmemo(sender).lines[i]) > 40 then
        OverLimit := TRUE;

    if OverLimit then
    begin
      pos := tmemo(sender).SelStart;
      tmemo(sender).text := FooterSavedText;
      tmemo(Sender).SelStart := pos;
    end
    else
      FooterSavedText := tmemo(Sender).text;

    tmemo(sender).modified := false;
  end;
end;

procedure TTextOverrideWizard.btnPreviewClick(Sender: TObject);
var
  FooterPreview: TFooterPreview;
  pbTop: Integer;
  LineCount: Integer;
begin
  Log('Text override Wizard - Clockout Footer - preview clicked');
  if dmADO.qClockoutticketFooterTextOverride.State in [dsEdit, dsInsert] then
    dmADO.qClockoutticketFooterTextOverride.Post;

  with dmADO.adoqRun do
  try
    SQL.Clear;
    SQL.Add(';with cte as (');
    SQL.Add(' select LineNumber, LineType, rank() over (order by LineType, LineNumber) as LineNumberSequential');
    SQL.Add(' from #ClockoutTicketFooterTextOverride');
    SQL.Add(')');
    SQL.Add('update f');
    SQL.Add('set f.LineNumberSeq = cte.LineNumberSequential');
    SQL.Add('from #ClockoutTicketFooterTextOverride f join cte on f.LineNumber = cte.LineNumber and f.LineType = cte.LineType');
    SQL.Add('select * from #ClockoutTicketFooterTextOverride order by LineNumberSeq');
    Open;
    LineCount := RecordCount;

    dmADO.qClockoutticketFooterTextOverride.Requery;

    FooterPreview := TFooterPreview.Create(nil, LineCount, faLeft);
    try
      First;
      pbTop := 50;
      while not Eof do
      begin
        FooterPreview.ConfigurePaintBox(FieldByName('LineNumberSeq').AsInteger, pbTop,
                  FieldByName('Text').AsString, FieldByName('Bold').AsBoolean, FieldByName('DoubleSize').AsBoolean);
        pbTop := pbTop + 17;
        Next;
      end;
      FooterPreview.CreateTopAndBottomPaintBoxes;
      FooterPreview.ShowModal;
    finally
      FooterPreview.Free;
    end;
  finally
    Close;
    SQL.Clear;
  end;
end;

procedure TTextOverrideWizard.dbgrdClockoutTicketFooterOverrideCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if dbgrdClockoutTicketFooterOverride.DataSource.DataSet.FieldByName('LineType').AsInteger = 1 then
  begin
    ABrush.Color := clBtnFace;
    AFont.Color := clGrayText;
  end;
end;

procedure TTextOverrideWizard.dbgrdClockoutTicketFooterOverrideKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = vk_Insert then
  begin
    actInsertClockoutTicketFooterLine.Execute;
  end
  else if (key = vk_delete) and not (dbgrdClockoutTicketFooterOverride.EditorMode) then
  begin
    actDeleteClockoutTicketFooterLine.Execute;
    Abort;
  end;
end;

procedure TTextoverrideWizard.ClockoutTicketFooterInsert;
var
  CurrLineType, TargetType: integer;
  CurrLineNumber, TargetLineNumber: integer;
  ShiftRequired: Boolean;
  {MinType0,} MaxType0, MinType1, MaxType1, MinType2, MaxType2: Integer;
begin
  Log('Text override Wizard - Clockout Footer - insert line clicked');
  if dmado.qClockoutticketFooterTextOverride.State in [dsedit, dsinsert] then dmado.qClockoutticketFooterTextOverride.Post;

  dmADO.qClockoutticketFooterTextOverride.DisableControls;
  try
    CurrLineType := dbgrdClockoutTicketFooterOverride.DataSource.Dataset.FieldByName('LineType').AsInteger;
    CurrLineNumber := dbgrdClockoutTicketFooterOverride.DataSource.Dataset.FieldByName('LineNumber').AsInteger;

    with dmADO.adoqRun do
    begin
      SQL.Clear;
      SQL.Add('select LineType, isnull(max(linenumber),0) as MaxLineNumber, isnull(min(LineNumber),0) as MinLineNumber');
      SQL.Add('from #ClockoutTicketFooterTextOverride group by LineType');
      Open;

      //MinType0 := 0;
      MaxType0 := 0;
      MinType1 := 0;
      MaxType1 := 0;
      MinType2 := 0;
      MaxType2 := 0;
      while not EOF do
      begin
        case FieldByName('LineType').AsInteger of
          0:
          begin
            //MinType0 := FieldByName('MinLineNumber').AsInteger;
            MaxType0 := FieldByName('MaxLineNumber').AsInteger;
          end;
          1:
          begin
            MinType1 := FieldByName('MinLineNumber').AsInteger;
            MaxType1 := FieldByName('MaxLineNumber').AsInteger;
          end;
          2:
          begin
            MinType2 := FieldByName('MinLineNumber').AsInteger;
            MaxType2 := FieldByName('MaxLineNumber').AsInteger;
          end;
        end;
        Next;
      end;

      ShiftRequired := false;
      TargetType := 0;
      TargetLineNumber := 0;
      if ((CurrLineType = 1) and (CurrLineNumber = MinType1)) or ((CurrLineType = 0) and (CurrLineNumber = MaxType0))  then
      begin
        TargetType := 0;
        TargetLineNumber := MaxType0 + 1;
      end
      else if ((CurrLineType = 1) and (CurrLineNumber = MaxType1)) or ((CurrLineType = 2) and (CurrLineNumber = MinType2))  then
      begin
        TargetType := 2;
        TargetLineNumber := 1;
        ShiftRequired := true;
      end
      else if (CurrLineType = 0) and (CurrLineNumber = 1) then
      begin
        TargetType := 0;
        TargetLineNumber := 1;
        ShiftRequired := True;
      end
      else if (CurrLineType = 2) and (CurrLineNumber = MaxType2) then
      begin
        TargetType := 2;
        TargetLineNumber := MaxType2 + 1;
      end
      else if CurrLineType in [0,2] then
      begin
        TargetType := CurrLineType;
        TargetLineNumber := CurrLineNumber;
        ShiftRequired := True;
      end;
    end;

    if ((TargetType = 0) and (MaxType0 >= MAX_USER_CONFIGURABLE_LINES)) or ((TargetType = 2) and (MaxType2 >= MAX_USER_CONFIGURABLE_LINES)) then
    begin
      MessageDlg(Format('Unable to insert.  User configurable portions are limited to %d lines.',[MAX_USER_CONFIGURABLE_LINES]), mtInformation, [mbOK], 0);
    end
    else if not ((CurrLineType = 1) and (CurrLineNumber <> MinType1) and (CurrLineNumber <> MaxType1)) then
    begin
      with dmADO.adoqRun do
        if ShiftRequired then
        begin
          SQL.Clear;
          SQL.Add('update #ClockoutTicketFooterTextOverride set LineNumber = LineNumber +1');
          SQL.Add(Format('where LineNumber >= %d and LineType = %d',[TargetLineNumber, TargetType]));
          ExecSQL;
        end;

      dmADO.qClockoutticketFooterTextOverride.Insert;
      dmADO.qClockoutticketFooterTextOverrideLineNumber.AsInteger := TargetLineNumber;
      dmADO.qClockoutticketFooterTextOverrideLineType.AsInteger := TargetType;
      dmADO.qClockoutticketFooterTextOverride.Post;
      dmADO.qClockoutticketFooterTextOverride.Requery;
      dmADO.qClockoutticketFooterTextOverride.Locate('LineNumber;Linetype',VarArrayOf([TargetLineNumber, TargetType]),[]);
    end
    else
      MessageDlg('Unable to insert into the standard portion of the footer.', mtInformation, [mbOK], 0);
  finally
      dmADO.qClockoutticketFooterTextOverride.EnableControls;
  end;
end;

procedure TTextOverrideWizard.ClockoutTicketFooterDelete;
var
  CurrLineType, TargetLineType, CurrLineNumber, TargetLineNumber: Integer;
  {MinType0,} MaxType0, {MinType1, MaxType1,} MinType2, MaxType2: Integer;
  ShiftRequired: Boolean;
begin
  Log('Text override Wizard - Clockout Footer - delete line clicked');
  if dmado.qClockoutticketFooterTextOverride.State in [dsedit, dsinsert] then dmado.qClockoutticketFooterTextOverride.Post;

  dmADO.qClockoutticketFooterTextOverride.DisableControls;
  try
    CurrLineType := dbgrdClockoutTicketFooterOverride.DataSource.Dataset.FieldByName('LineType').AsInteger;
    CurrLineNumber := dbgrdClockoutTicketFooterOverride.DataSource.Dataset.FieldByName('LineNumber').AsInteger;

    with dmADO.adoqRun do
    begin
      SQL.Clear;
      SQL.Add('select LineType, isnull(max(linenumber),0) as MaxLineNumber, isnull(min(LineNumber),0) as MinLineNumber');
      SQL.Add('from #ClockoutTicketFooterTextOverride group by LineType');
      Open;

      //MinType0 := 0;
      MaxType0 := 0;
      //MinType1 := 0;
      //MaxType1 := 0;
      MinType2 := 0;
      MaxType2 := 0;
      while not EOF do
      begin
        case FieldByName('LineType').AsInteger of
          0:
          begin
            //MinType0 := FieldByName('MinLineNumber').AsInteger;
            MaxType0 := FieldByName('MaxLineNumber').AsInteger;
          end;
          1:
          begin
            //MinType1 := FieldByName('MinLineNumber').AsInteger;
            //MaxType1 := FieldByName('MaxLineNumber').AsInteger;
          end;
          2:
          begin
            MinType2 := FieldByName('MinLineNumber').AsInteger;
            MaxType2 := FieldByName('MaxLineNumber').AsInteger;
          end;
        end;
        Next;
      end;

      ShiftRequired := false;
      TargetLineType := 0;
      TargetLineNumber := 0;
      if (CurrLineType = 0) and (CurrLineNumber = MaxType0)  then
      begin
        TargetLineType := 0;
        TargetLineNumber := MaxType0 - 1;
      end
      else if (CurrLineType = 2) and (CurrLineNumber = MinType2)  then
      begin
        TargetLineType := 2;
        TargetLineNumber := 1;
        ShiftRequired := true;
      end
      else if (CurrLineType = 0) and (CurrLineNumber = 1) then
      begin
        TargetLineType := 0;
        TargetLineNumber := 1;
        ShiftRequired := True;
      end
      else if (CurrLineType = 2) and (CurrLineNumber = MaxType2) then
      begin
        TargetLineType := 2;
        TargetLineNumber := MaxType2 - 1;
      end
      else if CurrLineType in [0,2] then
      begin
        TargetLineType := CurrLineType;
        TargetLineNumber := CurrLineNumber;
        ShiftRequired := True;
      end;
    end;

    if CurrLineType <> 1 then
    begin
      dmADO.qClockoutticketFooterTextOverride.Delete;

      if ShiftRequired then
        with dmADO.qRun do
        begin
          Close;
          SQL.Clear;
          SQL.Add('update #ClockoutTicketFooterTextOverride set LineNumber = LineNumber -1');
          SQL.Add(Format('where LineNumber >= %d and LineType = %d',[TargetLineNumber, TargetLineType]));
          ExecSQL;
        end;

      dmADO.qClockoutticketFooterTextOverride.requery;

      dmADO.qClockoutticketFooterTextOverride.Locate('LineNumber;Linetype',VarArrayOf([TargetLineNumber, TargetLineType]),[]);
      dbgrdClockoutTicketFooterOverride.EditorMode := False;
    end
    else
      MessageDlg('Unable to delete a line form the standard portion of the footer.', mtInformation, [mbOK], 0);
  finally
    dmADO.qClockoutticketFooterTextOverride.EnableControls;
  end;
end;

procedure TTextOverrideWizard.dbgrdClockoutTicketFooterOverrideCellChanged(
  Sender: TObject);
begin
  if dbgrdClockoutTicketFooterOverride.DataSource.dataset.FieldByName('LineType').AsInteger = 1 then
    dbgrdClockoutTicketFooterOverride.Options := dbgrdClockoutTicketFooterOverride.Options - [dgEditing]
  else
    dbgrdClockoutTicketFooterOverride.Options := dbgrdClockoutTicketFooterOverride.Options + [dgEditing];
end;

procedure TTextOverrideWizard.btnInsertClick(Sender: TObject);
begin
  ClockoutTicketFooterInsert;
end;

procedure TTextOverrideWizard.actInsertClockoutTicketFooterLineExecute(
  Sender: TObject);
begin
  ClockoutTicketFooterInsert;
end;

procedure TTextOverrideWizard.actDeleteClockoutTicketFooterLineExecute(
  Sender: TObject);
begin
  ClockoutTicketFooterDelete;
end;

procedure TTextOverrideWizard.dbgrdClockoutTicketFooterOverrideKeyPress(
  Sender: TObject; var Key: Char);

  function isValidNonAlphaChar: Boolean;
  begin
    //Key press is valid, but not alphanumeric
    result :=    (HiWord(GetKeyState(VK_ESCAPE)) <> 0)
              or (HiWord(GetKeyState(VK_BACK)) <> 0)
              or (HiWord(getKeyState(VK_INSERT)) <> 0)
              or (Key in [^C]);
  end;

var
  CharInsertionCount: Integer;
  Clpbrd: TClipboard;
  ErrorMessage: String;
  ErrorFieldName: String;
begin
  if isValidNonAlphaChar then
    Exit;



  with (Sender as TwwDBGrid) do
  begin
    if (Name = 'dbgrdBillFooterOverride') then
      ErrorFieldName := 'Double Width'
    else
      ErrorFieldName := 'Double Size';

    if (GetActiveField.FieldName = 'Text') then
    begin
      if ((Name = 'dbgrdClockoutTicketFooterOverride') and (datasource.DataSet.FieldByName('DoubleSize').AsBoolean))
      or ((Name = 'dbgrdBillFooterOverride') and (DataSource.DataSet.FieldByName('DoubleWidth').AsBoolean)) then
      begin
        if (InplaceEditor <> nil) then
        begin
          if (key in [^V]) then
          begin
            Clpbrd := Clipboard;
            CharInsertionCount := Length(Clpbrd.Astext);
          end
          else
            CharInsertionCount := 1;

          if ((Length(InplaceEditor.Text) + CharInsertionCount) > 20) then
          begin
            ErrorMessage := 'Only 20 characters can be entered when ' + QuotedStr(ErrorFieldName) + ' is checked.';
            if (CharInsertionCount > 1) then
              ErrorMessage := ErrorMessage + '  Input would be truncated.';
            ShowMessage(ErrorMessage);
            abort;
          end;
        end;
      end;
    end;
  end;
end;

procedure TTextOverrideWizard.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  // -1 => we have pressed 'Finish' and saved the data.
  if pcFooterWizard.ActivePageIndex <> -1 then
    CanClose := ThemeModellingMenu.ApplicationClosing or
     (MessageDlg('Close wizard and abandon changes?', mtConfirmation, [mbYes, mbNO], 0) = mrYes)
  else
    CanClose := True;
end;

procedure TTextOverrideWizard.actPreviewBillFooterExecute(Sender: TObject);
var
  FooterPreview: TFooterPreview;
  pbTop: Integer;
  LineCount: Integer;
begin
  Log('Text override Wizard - Bill Footer - preview clicked');
  if dmADO.qBillFooterTextOverride.State in [dsEdit, dsInsert] then
    dmADO.qBillFooterTextOverride.Post;

  with dmADO.adoqRun do
  try
    SQL.Clear;
    SQL.Add('select * from #BillFooterTextOverride order by LineNumber');
    Open;
    LineCount := RecordCount;

    dmADO.qBillFooterTextOverride.Requery;
    FooterPreview := TFooterPreview.Create(nil, LineCount);
    try
      First;
      pbTop := 50;
      while not Eof do
      begin
        FooterPreview.ConfigurePaintBox(FieldByName('LineNumber').AsInteger, pbTop, FieldByName('Text').AsString,
              FieldByName('Alignment').AsInteger, FieldByName('Bold').AsBoolean, FieldByName('DoubleWidth').AsBoolean,
              FieldByName('DoubleHeight').AsBoolean);
        pbTop := pbTop + 17;
        Next;
      end;
      FooterPreview.CreateTopAndBottomPaintBoxes;
      FooterPreview.ShowModal;
    finally
      FooterPreview.Free;
    end;
  finally
    Close;
    SQL.Clear;
  end;

end;

end.
