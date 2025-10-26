unit uExceptionWizard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ImgList, Buttons, Grids, DBGrids,
  uDataTree, wwdbdatetimepicker, CheckLst, ActnList, DB, ADODB, Wwdbigrd,
  Wwdbgrid, Mask, wwdbedit, Wwdotdot, Wwdbcomb, wwdblook, uPromoCommon,
  wwcheckbox, uAztecLog, uSiteTagFilterFrame,     //  uPromotionFilterFrame,
  uBaseTagFilterFrame, uWizardManager, uPromotionFilterFrame;

const
  TIMAGE_TAG_ZONAL_Z_BIG = 101;
  TIMAGE_TAG_ZONAL_Z_SMALL = 102;
  UM_INITFOCUS = WM_USER;
  ACTION_KEEP = 0;
  ACTION_REMOVE = 1;

  FINISH_TEXT = 'You have entered all required details for the Exception.' + #13#10 +
                'Click ''Back'' to review details, or click Finish to save the Exception.';
  READONLY_FINISH_TEXT = 'You have reviewed all details for the Exception.' + #13#10 +
                         'Click ''Back'' to review details or click ''Finish'' to exit the Exception.';

  PANE_RESIZE_LEFT_OFFSET = -27;
  RIGHT_PANE_RESIZE_LEFT_OFFSET = -40;
  PANE_RESIZE_MIDDLE_OFFSET = -12;
  PANE_RESIZE_RIGHT_OFFSET = 20;

type
  TExceptionWizard = class(TForm)
    pcWizard: TPageControl;
    tsFirstPage: TTabSheet;
    tsSAException: TTabSheet;
    btnBack: TButton;
    btnNext: TButton;
    btClose: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    imZonalBig: TImage;
    lbWizardTitle: TLabel;
    lbWizardDescription: TLabel;
    Label3: TLabel;
    edName: TEdit;
    Label4: TLabel;
    edDescription: TMemo;
    Panel3: TPanel;
    Label8: TLabel;
    Bevel1: TBevel;
    Label7: TLabel;
    Image2: TImage;
    tvAvailableSAs: TTreeView;
    Label9: TLabel;
    tvSelectedSAs: TTreeView;
    sbExcludeAllSalesAreas: TButton;
    sbExcludeSalesAea: TButton;
    sbIncludeSalesArea: TButton;
    sbIncludeAllSalesAreas: TButton;
    Label10: TLabel;
    tsActivationException: TTabSheet;
    Panel10: TPanel;
    Bevel8: TBevel;
    Image8: TImage;
    tsValidateOverlap: TTabSheet;
    Panel4: TPanel;
    Label1: TLabel;
    Bevel2: TBevel;
    Label2: TLabel;
    Image1: TImage;
    Label15: TLabel;
    Label16: TLabel;
    tsProductException: TTabSheet;
    Panel5: TPanel;
    Label13: TLabel;
    Bevel3: TBevel;
    Label14: TLabel;
    Image4: TImage;
    Label11: TLabel;
    tvAvailableProducts: TTreeView;
    sbIncludeProduct: TButton;
    sbIncludeAllProducts: TButton;
    sbExcludeAllProducts: TButton;
    sbExcludeProduct: TButton;
    tcProductGroups: TTabControl;
    lbSelectedProducts: TLabel;
    tsFinalPage: TTabSheet;
    Label12: TLabel;
    Panel6: TPanel;
    Label17: TLabel;
    Bevel4: TBevel;
    Label18: TLabel;
    Image3: TImage;
    Label19: TLabel;
    dbgExceptionOverlap: TwwDBGrid;
    dblActionID: TwwDBLookupCombo;
    ExceptionActions: TActionList;
    NextPage: TAction;
    PrevPage: TAction;
    SetRewardPriceMode: TAction;
    RewardPriceExport: TAction;
    RewardPriceImport: TAction;
    tsEventActionException: TTabSheet;
    Panel12: TPanel;
    Label35: TLabel;
    Bevel10: TBevel;
    Label36: TLabel;
    Image10: TImage;
    Label37: TLabel;
    dbgPromotionActions: TwwDBGrid;
    btActivateAllPromotions: TButton;
    btActivateNoPromotions: TButton;
    btSAFindNext: TButton;
    btSAFindPrev: TButton;
    edSASearchTerm: TEdit;
    edProductSearchTerm: TEdit;
    btProductFindPrev: TButton;
    btProductFindNext: TButton;
    SATreeFindPrev: TAction;
    SATreeFindNext: TAction;
    ProductTreeFindPrev: TAction;
    ProductTreeFindNext: TAction;
    chkbxAllTimes: TCheckBox;
    gbxActiveTimes: TGroupBox;
    btnNewTimePeriod: TButton;
    btnDeleteTimePeriod: TButton;
    pnlTimePeriodEdit: TPanel;
    Label45: TLabel;
    lblStartTime: TLabel;
    lblEndTime: TLabel;
    dtStartTime: TDateTimePicker;
    dtEndTime: TDateTimePicker;
    clbValidDays: TCheckListBox;
    dbgridValidTimes: TwwDBGrid;
    dstValidTimes: TADODataSet;
    dstValidTimesValidDaysDisplay: TStringField;
    dstValidTimesStartTime: TDateTimeField;
    dstValidTimesEndTime: TDateTimeField;
    dstValidTimesValidDays: TStringField;
    dsValidTimes: TDataSource;
    cbHideDisabledPromotions: TCheckBox;
    PromotionFilterFrame: TPromotionFilterFrame;
    SiteTagFilterFrame: TSiteTagFilterFrame;
    Label6: TLabel;
    Label31: TLabel;
    dtStartDate: TDateTimePicker;
    dtEndDate: TDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure sbIncludeSalesAreaClick(Sender: TObject);
    procedure sbIncludeAllSalesAreasClick(Sender: TObject);
    procedure sbExcludeAllSalesAreasClick(Sender: TObject);
    procedure sbExcludeSalesAeaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure HandleOverlapRowChange(Sender: TObject);
    procedure NextPageExecute(Sender: TObject);
    procedure PrevPageExecute(Sender: TObject);
    procedure edNameChange(Sender: TObject);
    procedure btActivateAllPromotionsClick(Sender: TObject);
    procedure btActivateNoPromotionsClick(Sender: TObject);
    procedure SearchTermEnter(Sender: TObject);
    procedure SearchTermExit(Sender: TObject);
    procedure edSASearchTermChange(Sender: TObject);
    procedure ProductTreeFindUpdate(Sender: TObject);
    procedure ProductTreeFindPrevExecute(Sender: TObject);
    procedure ProductTreeFindNextExecute(Sender: TObject);
    procedure chkbxAllTimesClick(Sender: TObject);
    procedure dstValidTimesCalcFields(DataSet: TDataSet);
    procedure dstValidTimesAfterScroll(DataSet: TDataSet);
    procedure clbValidDaysClickCheck(Sender: TObject);
    procedure btnNewTimePeriodClick(Sender: TObject);
    function AlreadyHasEmptyPeriod : boolean;
    procedure btnDeleteTimePeriodClick(Sender: TObject);
    procedure dtStartTimeChange(Sender: TObject);
    procedure dtEndTimeChange(Sender: TObject);
    procedure cbHideDisabledPromotionsClick(Sender: TObject);
    procedure tsFirstPageShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SelectSitesSAResize(Sender: TObject);
    procedure dtEndDateClick(Sender: TObject);
  private
    { Private declarations }
    ExistingID, ExceptionID: Int64;  // The exception ID will now be allocated as soon as this wizard starts
    EventPricing: boolean; // True if the parent Promotion is an Event Pricing one
    SalesAreaDataTree: TDataTree;
    ProductDataTree: TDataTree;
    PromoID: Int64;
    WizardSiteCode: Integer;
    DataModified: TDataModified;
    NameChecked : Boolean;

    SASearchTerm: string;
    SASearchTermChanged: boolean;
    FReadOnly: Boolean;
    WizardManager: TWizardManager;
    procedure LoadData;
    procedure SaveData;
    procedure OnEnterPage(Page: TTabSheet; Direction : TWizardDirection);
    procedure OnLeavePage(Page: TTabSheet; Direction : TWizardDirection);
    procedure ProcessSalesAreaSelection;
    procedure GetSalesAreaSelection(TableName: string);
    function CalcOverlaps : Integer;
    procedure UpdateException (ExceptionID : Int64; SalesAreaID : Integer; Keep : Boolean);
    procedure LoadSelectedSalesAreas;
    procedure BackupInProgressData;
    function ActiveTimesSameAsParentPromotion: boolean;
    procedure ConfigureActivationDetailsGUI(PromoRunsAllTimes: boolean);
  public
    { Public declarations }
    class function ShowWizard(SiteCode: Integer; PromotionID : Int64; AExistingID: Int64 = -1; Copy : Boolean = False; AReadOnly: Boolean = True) : TModalResult;
    procedure HandleInitFocus(var Msg: TMsg); message UM_INITFOCUS;
    property ReadOnly: Boolean read FReadonly;
  end;

var
  ExceptionWizard: TExceptionWizard;

implementation

uses
  DateUtils, udmPromotions, dADOAbstract, useful, uSimpleLocalise, uPromotionWizard, uGlobals;

{$R *.dfm}

procedure TExceptionWizard.FormCreate(Sender: TObject);
var
  i: integer;
begin
  WizardManager := TWizardManager.Create(pcWizard, btnNext, btnBack, OnEnterPage, OnLeavePage);
  WizardManager.WizardName := 'Exception Wizard';
  
  for i := 0 to Pred(ComponentCount) do
  begin
    // Hacky use of tags to bind images to TImage instances
    // Avoids clogging up the form with identical images
    // TODO: load from resources
    if (Components[i] is TImage) then
      case TImage(Components[i]).Tag of
        TIMAGE_TAG_ZONAL_Z_BIG:
          TImage(Components[i]).Picture.Bitmap.LoadFromResourceName(HInstance, 'ZonalZWhiteBk100x100');
        TIMAGE_TAG_ZONAL_Z_SMALL:
          TImage(Components[i]).Picture.Bitmap.LoadFromResourceName(HInstance, 'ZonalZWhiteBk50x50');
      end;
  end;
  LocaliseForm(self);

  // Hook up the promotion list filter to the Promotions datamodule.
  PromotionFilterFrame.ApplyFilter := dmPromotions.SetEventPromotionListFilter;
  PromotionFilterFrame.ClearFilter := dmPromotions.ClearEventPromotionListFilter;

  cbHideDisabledPromotions.Checked := True;
  dmPromotions.EventPromotionsHideDisabled := True;

  SiteTagFilterFrame.ADOConnection := dmPromotions.AztecConn;

  dtStartDate.Format := uGlobals.theDateFormat;
  dtEndDate.Format := uGlobals.theDateFormat;

{ VV
  dtStartDate.DisplayFormat := uGlobals.theDateFormat;
  dtEndDate.DisplayFormat := uGlobals.theDateFormat;
}
end;

procedure TExceptionWizard.SelectSitesSAResize(Sender: TObject);
begin
  tvAvailableSAs.Width := TTabSheet(Sender).width div 2 + PANE_RESIZE_LEFT_OFFSET;
  tvSelectedSAs.Width := TTabSheet(Sender).width div 2 + RIGHT_PANE_RESIZE_LEFT_OFFSET;
  sbIncludeSalesArea.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  sbIncludeAllSalesAreas.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  sbExcludeAllSalesAreas.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  sbExcludeSalesAea.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  tvSelectedSAs.Left := TTabSheet(Sender).width div 2 + PANE_RESIZE_RIGHT_OFFSET;
  label10.Left := TTabSheet(Sender).width div 2 + PANE_RESIZE_RIGHT_OFFSET;
end;

procedure TExceptionWizard.btCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TExceptionWizard.BackupInProgressData;
begin
end;

class function TExceptionWizard.ShowWizard(SiteCode: integer; PromotionID : Int64; AExistingID: Int64 = -1; Copy : Boolean = False; AReadOnly: Boolean = True) : TModalResult;
var
  WizardInstance: TExceptionWizard;
begin
  Log('Exception Wizard', 'Creating Instance...');
  Log('  PromotionID - ',inttostr(PromotionID));
  Log('  ExistingID  - ',inttostr(AExistingID));

  WizardInstance := TExceptionWizard.Create(nil);
  with WizardInstance do
  begin
    WizardSiteCode := SiteCode;

    NameChecked := False;

    ExistingID := AExistingID;
    if Copy then
      ExceptionID := -1
    else
      ExceptionID := AExistingID;

    PromoID := PromotionID;
    FReadOnly := AReadOnly;

    BackupInProgressData;
    PostMessage(Handle, UM_INITFOCUS, 0, 0);
    LoadData;
    if (ExistingID = -1) and not Copy then
    begin
      lbWizardTitle.Caption := 'New Exception Wizard';
      lbWizardDescription.Caption := 'This wizard will guide you through the process of setting up a new Exception';
    end else if Copy then
    begin
      lbWizardTitle.Caption := 'Copy Exception Wizard';
      lbWizardDescription.Caption := 'This wizard allows you to review and/or edit all parts of the selected copied Exception';
    end
    else
    begin
      lbWizardTitle.Caption := 'Edit Exception Wizard';
      lbWizardDescription.Caption := 'This wizard allows you to review and/or edit all parts of the selected Exception';
    end;
    Log('  Exception Wizard',lbWizardTitle.Caption);

    Result := ShowModal;
    if Result <> mrOk then
    begin
      Log('  Exception Wizard','Cancelled');
    end;
    Free;
  end;
end;

procedure TExceptionWizard.HandleInitFocus(var Msg: TMsg);
begin
  if not ReadOnly then
    FocusControl(edName);
end;

procedure TExceptionWizard.LoadData;
var
  savedEventHandler: TNotifyEvent;
  startDate, endDate: TDate;
begin
  Log('Exception Wizard', 'Load Data');

  with dmPromotions do
  begin

    with adoqRun do
    begin
      SQL.Text := 'select Name, PromoTypeID from #Promotion';
      Open;
      self.Caption := Format('Exception Wizard (%s)', [FieldByName('Name').AsString]);
      EventPricing := (FieldByName('PromoTypeID').AsInteger = 4);
      Close;
    end;

    adoqRun.SQL.Text :=
      'select top 0 * into #TmpPromotionException from #PromotionException '+
      'select top 0 * into #TmpPromotionExceptionSalesArea from #PromotionExceptionSalesArea '+
      'select top 0 * into #TmpPromotionExceptionEventStatus from #PromotionExceptionEventStatus '+
      'select top 0 SiteCode, ExceptionId, DisplayOrder, ValidDays, StartTime, EndTime, TimeCicleId into #TmpPromotionExceptionTimeCycles_saved from #PromotionExceptionTimeCycles '+
      //Note: Can't use the "select top 0" for this table because I want the DisplayOrder column to be an Identity column
      'create table #TmpPromotionExceptionTimeCycles ( '+
      '  SiteCode int, '+
      '  ExceptionId bigint, '+
      '  DisplayOrder int identity(1,1), '+
      '  ValidDays varchar(7), '+
      '  StartTime datetime, '+
      '  EndTime datetime, '+
      '  TimeCicleId bigint ' +
      ' )';
    adoqRun.ExecSQL;

    adoqRun.SQL.Text := 'SET IDENTITY_INSERT #TmpPromotionExceptionTimeCycles ON';
    adoqRun.ExecSQL;

    try
      if ExceptionID = -1 then
      begin
        // Generate new exception ID and update temporary tables with it
        adoqRun.SQL.Clear;
        adoqRun.SQL.Add('declare @newid bigint');
        adoqRun.SQL.Add(Format('exec ac_spGetTableIdNextValue %s, %s output',['PromotionException_Repl','@newid']));
        adoqRun.SQL.Add('select @newid as Output');
        adoqRun.Open;
        ExceptionID := TLargeIntField(adoqrun.fieldbyname('Output')).AsLargeInt;
        Log('  Exception Wizard',inttostr(ExceptionID));
        adoqrun.Close;
      end;

      if ExistingID = -1 then
      begin
        adoqRun.SQL.Clear;
        adoqRun.SQL.Add ('INSERT INTO #TmpPromotionException');
        adoqRun.SQL.Add ('(SiteCode, PromotionID, ExceptionID, Name, Description, Status, ChangeEndDate)');
        adoqRun.SQL.Add (Format ('VALUES (%d, %d, %d, '''', '''', 0, 0)', [WizardSiteCode, PromoID, ExceptionID]));
        Log('  Exception Wizard',adoqRun.SQL.Text);
        adoqrun.ExecSQL;

        if EventPricing then
        begin
          adoqRun.SQL.Text := Format(
            'insert #TmpPromotionExceptionEventStatus select %d, %d, EnabledPromotionID from #PromotionEventStatus',
            [WizardSiteCode, ExceptionID]
          );
          adoqRun.ExecSQL;
        end;
      end
      else
      begin
        adoqRun.SQL.Text := Format(
          'insert #TmpPromotionException select * from #PromotionException where ExceptionID = %0:d '+
          'insert #TmpPromotionExceptionSalesArea select * from #PromotionExceptionSalesArea where ExceptionID = %0:d '+
          'insert #TmpPromotionExceptionEventStatus select * from #PromotionExceptionEventStatus where ExceptionID = %0:d '+
          'insert #TmpPromotionExceptionTimeCycles (SiteCode, ExceptionId, DisplayOrder, ValidDays, StartTime, EndTime) select SiteCode, ExceptionId, DisplayOrder, ValidDays, StartTime, EndTime from #PromotionExceptionTimeCycles where ExceptionID = %0:d ',
          [ExistingID]
        );
        
        adoqRun.ExecSQL;
        if ExistingID <> ExceptionID then
        begin
          adoqRun.SQL.Text := Format(
            'update #TmpPromotionException set ExceptionID = %0:d '+
            'update #TmpPromotionExceptionSalesArea set ExceptionID = %0:d '+
            'update #TmpPromotionExceptionEventStatus set ExceptionID = %0:d '+
            'update #TmpPromotionExceptionTimeCycles set ExceptionID = %0:d ',
            [ExceptionID]
          );
          adoqRun.ExecSQL;
        end;
      end;

      //If the temp time cycles table is still empty (new exception, or Copy/Edit exception has no time cycles) then
      //give it the same time cycles as the parent promotion.
      try
        with adoqrun do
        begin
          SQL.Text := Format(
            'if (select count(*) from #TmpPromotionExceptionTimeCycles) = 0 '+
            '  insert #TmpPromotionExceptionTimeCycles (SiteCode, ExceptionId, DisplayOrder, ValidDays, StartTime, EndTime)'+
            '  select %0:d, %1:d, DisplayOrder, ValidDays, StartTime, EndTime '+
            '  from #PromotionTimeCycles ', [WizardSiteCode, ExceptionID]);
          ExecSQL;
        end;
      except
        on e:exception do showmessage(e.Message);
      end;

    finally
      adoqRun.SQL.Text := 'SET IDENTITY_INSERT #TmpPromotionExceptionTimeCycles OFF';
      adoqRun.ExecSQL;
    end;

    //Get the start and end dates, again taking these from the parent promotion if none are specified for
    //the exception.
    with adoqrun do
    begin
      SQL.Text := Format(
        'SELECT ISNULL(e.StartDate, p.StartDate) as StartDate, ' +
        '  CASE e.ChangeEndDate when 1 then e.EndDate else p.EndDate END as EndDate, ' +
        '  p.StartDate as LowerBound, p.EndDate as UpperBound ' +
        'FROM #TmpPromotionException e INNER JOIN #Promotion p on e.promotionid = p.promotionid ' +
        'WHERE e.ExceptionID = %d ', [ExceptionID]);
      Open;

{
  ---------------------------------------
      This commented code below blocks TDateTimePicker navigation [left and right arrows  to select dates, monts and years]
      dtStartDate.MinDate := adoqRun.FieldByName('LowerBound').AsDateTime;
      dtStartDate.MaxDate := adoqRun.FieldByName('UpperBound').AsDateTime;
      dtEndDate.MinDate := adoqRun.FieldByName('LowerBound').AsDateTime;
      dtEndDate.MaxDate := adoqRun.FieldByName('UpperBound').AsDateTime;
  ---------------------------------------
}

      startDate := adoqRun.FieldByName('StartDate').AsDateTime;
      endDate := adoqRun.FieldByName('EndDate').AsDateTime;

      dtStartDate.Date := startDate;

      if endDate = 0 then
      begin
        dtEndDate.Date := Trunc(now);
        dtEndDate.Format := GetBlankDateTimePicker;  // set EndDate TDateTimePicker to blank
      end
      else
        dtEndDate.Date := endDate;
      Close;
    end;


    dstValidTimes.Active := True;
    btnDeleteTimePeriod.Enabled := (dstValidTimes.RecordCount > 1);

    //If there is only one time cycle defined on this promotion exception and it starts at rollover and ends at RollOver - 1 min
    //then check the 'Promotion runs at all times' box.
    savedEventHandler := chkbxAllTimes.OnClick;  //Disable this event handler while we set this checkbox state.
    chkbxAllTimes.OnClick := nil;

    if (dstValidTimes.RecordCount = 1) and
       SameTime(dstValidTimesStartTime.Value, dmPromotions.RolloverTime) and
       SameTime(dstValidTimesEndTime.Value, IncMinute(dmPromotions.RolloverTime, -1)) then
    begin
      chkbxAllTimes.Checked := True;
      ConfigureActivationDetailsGUI(True);
    end
    else
    begin
      chkbxAllTimes.Checked := False;
      ConfigureActivationDetailsGUI(False);
    end;

    chkbxAllTimes.OnClick := savedEventHandler;


    adoqRun.SQL.Clear;
    adoqRun.SQL.Add ('SELECT *');
    adoqRun.SQL.Add ('INTO #ExceptionSATree_Data');
    adoqRun.SQL.Add ('FROM ##ConfigTree_Data a');
    adoqRun.SQL.Add ('JOIN #PromotionSalesArea b');
    adoqRun.SQL.Add ('ON a.Level4ID = b.SalesAreaID');
    adoqRun.SQL.Add(Format ('WHERE b.PromotionID = %d', [PromoID]));
    adoqRun.ExecSQL;

    SalesAreaDataTree := TDataTree.Create(tvAvailableSAs, dmPromotions.AztecConn, '#ExceptionSATree_Data', ConfigNamesArray, True);
    SalesAreaDataTree.AddLevel('Company', '');
    SalesAreaDataTree.AddLevel('Area', '');
    SalesAreaDataTree.AddLevel('Site', '');
    SalesAreaDataTree.AddLevel('Sales Area', '');
    SalesAreaDataTree.Initialise;
    LoadSelectedSalesAreas;

    SiteTagFilterFrame.DataTreeToFilter := SalesAreaDataTree;

    // AK Fix for bug 335228
    if ExistingID <> - 1 then
    begin
      edName.Text := qEditPromotionExceptions.fieldbyname('name').AsString;
      edDescription.Text := qEditPromotionExceptions.fieldbyname('description').asstring;
    end;
    ProductDataTree := TDataTree.Create(tvAvailableProducts, dmPromotions.AztecConn, '##ProductTree_Data', ProductNamesArray);
    ProductDataTree.AddLevel('Division', '');
    ProductDataTree.AddLevel('Category', '');
    ProductDataTree.AddLevel('Subcategory', '');
    ProductDataTree.AddLevel('Product', '');
    ProductDataTree.AddLevel('Portion', '');
    ProductDataTree.Initialise;
  end;

  tsActivationException.Enabled := not EventPricing;
  tsEventActionException.Enabled := EventPricing;
  tsProductException.Enabled := false;
end;

procedure TExceptionWizard.SaveData;
begin
  with dmPromotions do
  begin
    adoqRun.SQL.Text := Format(
      'delete #PromotionException where ExceptionID = %0:d '+
      'delete #PromotionExceptionSalesArea where ExceptionID = %0:d '+
      'delete #PromotionExceptionEventStatus where ExceptionID = %0:d '+
      'delete #PromotionExceptionTimeCycles where ExceptionID = %0:d '+
      'insert #PromotionException select * from #TmpPromotionException '+
      'insert #PromotionExceptionSalesArea select * from #TmpPromotionExceptionSalesArea '+
      'insert #PromotionExceptionEventStatus select * from #TmpPromotionExceptionEventStatus ',
      [ExceptionID]
    );
    adoqRun.ExecSQL;

    if not ActiveTimesSameAsParentPromotion then
    begin
      adoqRun.SQL.Text := Format(
        'INSERT #PromotionExceptionTimeCycles (SiteCode, ExceptionId, DisplayOrder, ValidDays, StartTime, EndTime) ' +
        'SELECT %0:d, %1:d, DisplayOrder, ValidDays, StartTime, EndTime FROM #TmpPromotionExceptionTimeCycles ',
        [WizardSiteCode, ExceptionID]
      );
      adoqRun.ExecSQL;
    end;
  end;
end;

procedure TExceptionWizard.sbIncludeSalesAreaClick(Sender: TObject);
begin
  Log('  Exception Select Sites', 'Include Sales Area (>) Clicked');
  SalesAreaDataTree.SelectItem(tvSelectedSAs);
  DataModified.SalesAreaSelectionChanged := True;
end;

procedure TExceptionWizard.sbIncludeAllSalesAreasClick(Sender: TObject);
begin
  Log('  Exception Select Sites', 'Include All Sales Areas (>>) Clicked');
  SalesAreaDataTree.SelectAll(tvSelectedSAs);
  DataModified.SalesAreaSelectionChanged := True;
end;

procedure TExceptionWizard.sbExcludeAllSalesAreasClick(Sender: TObject);
begin
  Log('  Exception Select Sites', 'Exclude All Sales Areas (<<) Clicked');
  SalesAreaDataTree.DeselectAll(tvSelectedSAs);
  DataModified.SalesAreaSelectionChanged := True;
end;

procedure TExceptionWizard.sbExcludeSalesAeaClick(Sender: TObject);
begin
  Log('  Exception Select Sites', 'Exclude Sales Area (<) Clicked');
  SalesAreaDataTree.DeselectItem(tvSelectedSAs);
  DataModified.SalesAreaSelectionChanged := True;
end;

procedure TExceptionWizard.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Exception Wizard', 'FormClose');
  with dmPromotions.adoqrun do
  begin
    dmPromotions.qEditEventStatus.active := false;
    SQL.Text :=
      'IF OBJECT_ID(''tempdb..#ExceptionSATree_Data'') IS NOT NULL DROP TABLE #ExceptionSATree_Data '+
      'IF OBJECT_ID(''tempdb..#SinglePromotionExceptionSalesArea'') IS NOT NULL DROP TABLE #SinglePromotionExceptionSalesArea '+
      'IF OBJECT_ID(''tempdb..#TmpPromotionException'') IS NOT NULL DROP TABLE #TmpPromotionException '+
      'IF OBJECT_ID(''tempdb..#TmpPromotionExceptionSalesArea'') IS NOT NULL DROP TABLE #TmpPromotionExceptionSalesArea '+
      'IF OBJECT_ID(''tempdb..#TmpPromotionExceptionEventStatus'') IS NOT NULL DROP TABLE #TmpPromotionExceptionEventStatus '+
      'IF OBJECT_ID(''tempdb..#TmpPromotionExceptionTimeCycles'') IS NOT NULL DROP TABLE #TmpPromotionExceptionTimeCycles '+
      'IF OBJECT_ID(''tempdb..#TmpPromotionExceptionTimeCycles_saved'') IS NOT NULL DROP TABLE #TmpPromotionExceptionTimeCycles_saved ';
    ExecSQL;

  end;
end;

procedure TExceptionWizard.chkbxAllTimesClick(Sender: TObject);
begin
  if chkbxAllTimes.Checked then
  begin
    //Save current active time settings so can restore them if the "Promotion runs at all times" checkbox in unchecked,
    //and insert a rollover to rollover record instead.
    dstValidTimes.DisableControls;
    dstValidTimes.Active := False;
    dmPromotions.adoqrun.SQL.Text :=
      'TRUNCATE TABLE #TmpPromotionExceptionTimeCycles_saved ' +
      'INSERT #TmpPromotionExceptionTimeCycles_saved SELECT * FROM #TmpPromotionExceptionTimeCycles ' +

      'TRUNCATE TABLE #TmpPromotionExceptionTimeCycles ' +
      'INSERT #TmpPromotionExceptionTimeCycles (SiteCode, ExceptionId, ValidDays, StartTime, EndTime) ' +
      'VALUES (' + IntToStr(WizardSiteCode) + ',' +
                   IntToStr(ExceptionId) + ',' +
                   QuotedStr(ValidDaysStrFromCheckboxes(clbValidDays)) + ',' +
                   QuotedStr(FormatDateTime('hh:mm', dmPromotions.RolloverTime)) + ',' +
                   QuotedStr(FormatDateTime('hh:mm', IncMinute(dmPromotions.RolloverTime, -1))) + ')';
    dmPromotions.SafeExecSQL;
    dstValidTimes.Active := True;
    dstValidTimes.EnableControls;

    ConfigureActivationDetailsGUI(True);

    Log('  Activation Details', 'Promotion runs at all times checked')
  end
  else
  begin
    //Restore any active time settings that were saved when the user checked the "Promotion runs at all times" checkbox.
    dstValidTimes.DisableControls;
    dstValidTimes.Active := False;
    dmPromotions.adoqrun.SQL.Text :=
      'IF EXISTS(SELECT * FROM #TmpPromotionExceptionTimeCycles_saved) '+
      'BEGIN '+
      '  SET IDENTITY_INSERT #TmpPromotionExceptionTimeCycles ON '+

      '  TRUNCATE TABLE #TmpPromotionExceptionTimeCycles ' +
      '  INSERT #TmpPromotionExceptionTimeCycles (SiteCode, ExceptionId, DisplayOrder, ValidDays, StartTime, EndTime) '+
      '  SELECT SiteCode, ExceptionId, DisplayOrder, ValidDays, StartTime, EndTime FROM #TmpPromotionExceptionTimeCycles_saved ' +

      '  SET IDENTITY_INSERT #TmpPromotionExceptionTimeCycles OFF '+
      'END';
    dmPromotions.SafeExecSQL;
    dstValidTimes.Active := True;
    dstValidTimes.EnableControls;

    ConfigureActivationDetailsGUI(False);

    Log('  Activation Details', 'Promotion runs at all times unchecked');
  end;
end;

procedure TExceptionWizard.ConfigureActivationDetailsGUI(PromoRunsAllTimes: boolean);
begin
  if PromoRunsAllTimes then
  begin
    lblStartTime.Visible        := False;
    lblEndTime.Visible          := False;
    dtStartTime.Visible         := False;
    dtEndTime.Visible           := False;

    dbgridValidTimes.Visible    := False;
    btnNewTimePeriod.Visible    := False;
    btnDeleteTimePeriod.Visible := False;
  end
  else
  begin
    lblStartTime.Visible        := True;
    lblEndTime.Visible          := True;
    dtStartTime.Visible         := True;
    dtEndTime.Visible           := True;

    dbgridValidTimes.Visible    := True;
    btnNewTimePeriod.Visible    := True;
    btnDeleteTimePeriod.Visible := True;
  end;
end;

procedure TExceptionWizard.HandleOverlapRowChange(Sender: TObject);
begin
{
  with TwwDBGrid(Sender) do
  begin
    Hint := 'Source Exception: '+DataSource.DataSet.FieldByName('ExceptionName').AsString;
  end;
}
end;

procedure TExceptionWizard.OnEnterPage(Page: TTabSheet; Direction: TWizardDirection);
begin
  if Assigned(Page) then
    Log('Exception Wizard', 'OnEnterPage: ' + Page.Name);
  if Page = tsFirstPage then
  begin
  end
  else
  if Page = tsSAException then
  begin
    LoadSelectedSalesAreas;
  end
  else
  if Page = tsActivationException then
  begin
  end
  else
  if Page = tsValidateOverlap then
  begin
  end
  else
  if Page = tsProductException then
  begin
  end
  else
  if Page = tsEventActionException then
  begin
    dmPromotions.LoadTmpEventStatus('#TmpPromotionExceptionEventStatus');
    PromotionFilterFrame.ApplyFilterSettings(self); //Apply any existing filter settings
  end
  else
  if Page = tsFinalPage then
  begin
    if ReadOnly then
      Label12.Caption := READONLY_FINISH_TEXT
    else
      Label12.Caption := FINISH_TEXT;
  end;
  if ReadOnly and Assigned(Page) then
  begin
    DisablePromotionControls(Page);
  end;
  if Page = tsFinalPage then
    Label12.Enabled := True;
end;

function TExceptionWizard.ActiveTimesSameAsParentPromotion: boolean;
begin
  with dmPromotions.adoqRun do
  try
    SQL.Text :=
      'SELECT SUM(DiffCount) AS DiffCount '+
      'FROM '+
      '  ( '+
      '  SELECT COUNT(*) AS DiffCount FROM #TmpPromotionExceptionTimeCycles a '+
      '  WHERE NOT EXISTS '+
      '    (SELECT * FROM #PromotionTimeCycles '+
      '     WHERE ValidDays = a.ValidDays AND StartTime = a.StartTime AND EndTime = a.EndTime) '+
      '  UNION ALL '+
      '  SELECT COUNT(*) AS DiffCount FROM #PromotionTimeCycles a '+
      '  WHERE NOT EXISTS '+
      '    (SELECT * FROM #TmpPromotionExceptionTimeCycles '+
      '     WHERE ValidDays = a.ValidDays AND StartTime = a.StartTime AND EndTime = a.EndTime) '+
      '  ) x ';
    Open;
    Result := (FieldByName('DiffCount').AsInteger = 0);
  finally
    Close;
  end;
end;

procedure TExceptionWizard.OnLeavePage(Page: TTabSheet; Direction: TWizardDirection);
var
  StartChanged: Boolean;
  EndChanged: Boolean;
  currRecNo: integer;
begin
  if Assigned(Page) then
    Log('Exception Wizard', 'OnLeavePage: ' + Page.Name);
  if (Page = tsFirstPage) and (Direction = wdNext) then
  begin
    if edName.Text = '' then
    begin
      MessageDlg('Please enter a value for Name.', mtCustom, [mbOK], 0);
      edName.SetFocus;
      Abort;
    end;
    // (ExistingID <> ExceptionID) only true for new or copied exceptions
    if (ExistingID <> ExceptionID) and not NameChecked then begin
      with dmPromotions.adoqRun do
      begin
        SQL.Clear;
        SQL.Add (Format ('SELECT Name FROM #PromotionException where Name = %s and ExceptionId <> %d ', [QuotedStr(edName.Text), ExceptionID]));
        Open;
        if (not Eof) then begin
          MessageDlg(Format ('Exception name %s already exists. Please enter a unique name.', [edName.Text]), mtInformation, [mbOK], 0);
          Abort;
        end
        else
          NameChecked := True;

      end;
    end;

    with dmPromotions.adoqRun do
    begin
      // Save Exception data
      SQL.Clear;
      SQL.Add(Format('UPDATE #TmpPromotionException SET ExceptionID = %d, PromotionID = %d, Name = %s,', [ExceptionID, PromoID, QuotedStr(edName.Text)]));
      SQL.Add(Format('Description = %s, Status = %d, ChangeEndDate = %d', [QuotedStr(edDescription.Text), 0, 0]));
      SQL.Add(Format('WHERE ExceptionID = %d', [ExceptionID]));
      ExecSQL;
    end;
    Log('  Exception Name', edName.Text);
    Log('  Exception Description', edDescription.Text);

  end
  else
  if (Page = tsSAException) and (Direction = wdNext) then
  begin
    if tvSelectedSAs.Items.Count = 0 then
    begin
      MessageDlg(LocaliseString('Please select a Site/Sales area before continuing.'), mtCustom, [mbOK], 0);
      Abort;
    end;
    if DataModified.SalesAreaSelectionChanged then
    begin
      GetSalesAreaSelection(SalesAreaDataTree.SaveToTempTable(tvSelectedSAs));
      DataModified.SalesAreaSelectionChanged := False;
      DataModified.SalesAreaSelectionUnProcessed := False;
    end;
    if not(DataModified.SalesAreaSelectionUnProcessed) then
    begin
      ProcessSalesAreaSelection;
      DataModified.SalesAreaSelectionUnProcessed := True;
    end;

  end
  else
  if (Page = tsActivationException) and (Direction = wdNext) then
  begin
    with dmPromotions do
    begin
      if DateToStr(dtStartDate.Date) = '' then
      begin
        MessageDlg('Please enter a value for start date.', mtCustom, [mbOK], 0);
        Abort;
      end;
      if dtEndDate.Format <> GetBlankDateTimePicker then
      begin
        if Trunc(dtStartDate.Date) > Trunc(dtEndDate.Date) then
        begin
          MessageDlg ('Please select an end date that is after the start date.', mtCustom, [mbOK], 0);
          Abort;
        end;
      end;

      //Check that at least one day has been selected as an active day for the promotion exception.
      if chkbxAllTimes.Checked then
      begin
        if ValidDaysStrFromCheckboxes(clbValidDays) = '' then
        begin
          MessageDlg ('Please select active day(s)', mtCustom, [mbOK], 0);
          abort;
        end;
      end
      else
        with dstvalidTimes do
        begin
          currRecNo := RecNo;
          First;
          while not(Eof) do
          begin
            if dstValidTimesValidDays.AsString = '' then
            begin
              MessageDlg ('Please select active day(s)', mtInformation, [mbOK], 0);
              abort;
            end;
            Next;
          end;
          RecNo := currRecNo;
        end;

      // Compare for changes in the exception
      with adoqrun do
      begin
        SQL.text :=
          Format('select StartDate, EndDate from #Promotion where PromotionID = %d', [PromoID]);
        Open;
        StartChanged := FieldByName('StartDate').AsDateTime <> dtStartDate.Date;
        EndChanged := dtEndDate.Format <> GetBlankDateTimePicker;
//        EndChanged := FieldByName('EndDate').AsDateTime <> dtEndDate.Date;
        Close;
      end;

      if StartChanged or EndChanged then
      begin
        // User has changed the times on this Exception so we need to save it
        adoqrun.SQL.Clear;
        adoqrun.SQL.Add('UPDATE #TmpPromotionException SET');
        if StartChanged then
          adoqrun.SQL.Add(Format('StartDate = %s,', [GetSQLDate(dtStartDate.Date)]))
        else
          adoqrun.SQL.Add('StartDate = null,');
        if EndChanged then
        begin
          if dtEndDate.Format = GetBlankDateTimePicker then
            adoqrun.SQL.Add(Format('EndDate = %s, ChangeEndDate = 1', [GetSQLDate(0)]))
          else
            adoqrun.SQL.Add(Format('EndDate = %s, ChangeEndDate = 1', [GetSQLDate(dtEndDate.Date)]))
        end
        else
        begin
          if dtEndDate.Format = GetBlankDateTimePicker then
            adoqrun.SQL.Add(Format('EndDate = null, ChangeEndDate = 0', [GetSQLDate(0)]))
          else
            adoqrun.SQL.Add(Format('EndDate = null, ChangeEndDate = 0', [GetSQLDate(dtEndDate.Date)]));
        end;
        adoqrun.ExecSQL;
      end;

      if not(StartChanged or EndChanged) and ActiveTimesSameAsParentPromotion then
      begin
        MessageDlg ('Exception activation details cannot be identical' + #13#10 +
                    'to the promotion activation details.', mtInformation, [mbOK], 0);
        Abort;
      end;
    end;

    tsValidateOverlap.Enabled := not (CalcOverlaps = 0);
    Log('  Exception Start Date', DateToStr(dtStartDate.Date));
    Log('  Exception Stop Date', DateToStr(dtEndDate.Date));
    Log('  Exception Start Time', TimeToStr(dtStartTime.Time));
    Log('  Exception Stop Time', TimeToStr(dtEndTime.Time));

  end
  else
  if (Page = tsValidateOverlap) and (Direction = wdNext) then
  begin
    // We need to process the exceptions and perform the user selected tasks
    with dmPromotions.qTempExceptionOverlap do begin
      First;
      while not Eof do begin
        if FieldByName ('ActionID').AsInteger = ACTION_KEEP then
          UpdateException (ExceptionID, FieldByName ('SalesAreaID').AsInteger, True)
        else
          UpdateException (ExceptionID, FieldByName ('SalesAreaID').AsInteger, False);
        Next;
      end;
    end;
  end
  else
  if (Page = tsProductException) and (Direction = wdNext) then
  begin
  end
  else
  if Page = tsEventActionException then
  begin
    dmPromotions.SaveTmpEventStatus(WizardSiteCode, '#TmpPromotionExceptionEventStatus', ExceptionID);
    if Direction = wdNext then
    begin
      with dmPromotions.adoqrun do
      begin
        SQL.Text := 'select count(*) from #TmpPromotionExceptionEventStatus a full outer join #PromotionEventStatus b on a.EnabledPromotionID = b.EnabledPromotionID where a.EnabledPromotionID is null or b.EnabledPromotionID is null';
        Open;
        if Fields[0].AsInteger = 0 then
        begin
          Close;
          MessageDlg ('Exception event promotion details cannot be identical' + #13#10 +
                      'to those in the main promotion.', mtInformation, [mbOK], 0);
          Abort;
        end
        else
          Close;
      end;
      tsValidateOverlap.Enabled := not (CalcOverlaps = 0);
    end;
    dmPromotions.qEditEventStatus.Active := false;
  end
  else
  if (Page = tsFinalPage) then
  begin
    if (Direction = wdNext) and not ReadOnly then
    begin
      SaveData;
    end
    else
    begin
      tsValidateOverlap.Enabled := not (CalcOverlaps = 0);
    end;
  end;
end;

procedure TExceptionWizard.ProcessSalesAreaSelection;
begin
end;

procedure TExceptionWizard.NextPageExecute(Sender: TObject);
begin
  ModalResult := WizardManager.NextPageExecute(Sender);
  if (ModalResult = mrOK) and not ReadOnly then
    SaveData;
end;

procedure TExceptionWizard.PrevPageExecute(Sender: TObject);
begin
  WizardManager.PrevPageExecute(Sender);
end;

procedure TExceptionWizard.GetSalesAreaSelection(TableName: string);
begin
  Log('Exception Wizard', 'GetSalesAreaSelection');
  with dmPromotions.adoqRun do
  begin
    SQL.Clear;
    SQL.Add (Format ('DELETE #TmpPromotionExceptionSalesArea WHERE ExceptionID = %d', [ExceptionID]));
    ExecSQL;
    SQL.Clear;
    SQL.Add('INSERT #TmpPromotionExceptionSalesArea (SiteCode, ExceptionID, SalesAreaID)');
    SQL.Add(Format('SELECT %d, %d, Level4ID FROM %s ', [WizardSiteCode, ExceptionID, TableName]));
    ExecSQL;

    SQL.Text := Format('DROP TABLE %s', [TableName]);
    ExecSQL;
  end;
end;

function TExceptionWizard.CalcOverlaps : Integer;
begin
  with dmPromotions.adoqRun do
  begin
    SQL.Clear;
    SQL.Add ('IF OBJECT_ID(''tempdb..#OverLap'') IS NOT NULL DROP TABLE #OverLap');
    ExecSQL;

    if EventPricing then
    begin
      SQL.Text :=
        'SELECT SANames.SiteName, SANames.SalesAreaName, SANames.SiteRef, 0 as PromotionID, '+
        '  sub.SalesAreaID, ''Event Promotions'' as OverlapData, 0 AS ActionID '+
        'INTO #Overlap '+
        'FROM ( '+
        '  select a.SalesAreaID '+
        '  from #PromotionExceptionSalesArea a '+
        '  join #TmpPromotionExceptionSalesArea b '+
        '    on a.SalesAreaID = b.SalesAreaID '+
        '  where a.ExceptionID <> '+IntToStr(ExceptionID)+' '+
        '  group by a.SalesAreaID '+
        ') SUB '+
        'JOIN ( '+
        '  SELECT DISTINCT '+
        '    CAST(config.[Sales Area Code] AS SMALLINT) AS SalesAreaID, '+
        '    siteaztec.[Site Ref] AS SiteRef, '+
        '    siteaztec.[Site Name] AS SiteName, '+
        '    config.[Sales Area Name] AS SalesAreaName '+
        '  FROM config '+
        '  join siteaztec ON config.[site code] = siteaztec.[site code] '+
        '  WHERE (config.deleted IS NULL OR config.deleted = ''N'') '+
        '     AND config.[Sales Area Code] IS NOT NULL '+
        ') SANames ON Sub.SalesAreaID = SANames.SalesAreaID';
      ExecSQL;
    end
    else
    begin
      SQL.Clear;
      SQL.Add('SELECT SANames.SiteName, SANames.SalesAreaName, SANames.SiteRef, PromotionID, sub.SalesAreaID,');
      SQL.Add('SUBSTRING( '+
        '(CASE StartDateDefined WHEN 0 THEN '''' WHEN 1 THEN '''' ELSE ''Start Date, '' END + '+
        'CASE EndDateDefined WHEN 0 THEN '''' WHEN 1 THEN '''' ELSE ''End Date, '' END + '+
        'CASE TimeCycleDefined WHEN 0 THEN '''' WHEN 1 THEN '''' ELSE ''Times/Days, '' END), 1, '+
        'LEN(CASE StartDateDefined WHEN 0 THEN '''' WHEN 1 THEN '''' ELSE ''Start Date, '' END + '+
        'CASE EndDateDefined WHEN 0 THEN '''' WHEN 1 THEN '''' ELSE ''End Date, '' END + '+
        'CASE TimeCycleDefined WHEN 0 THEN '''' WHEN 1 THEN '''' ELSE ''Times/Days, '' END)-1 ) as OverlapData,');

      SQL.Add('  0 AS ActionID');
      SQL.Add('INTO #Overlap');
      SQL.Add('FROM (');
      SQL.Add('  SELECT PromotionID, SalesAreaID,');
      SQL.Add('    SUM(CASE IsNull(StartDate, 0) WHEN 0 THEN 0 ELSE 1 END) AS StartDateDefined,');
      SQL.Add('    SUM(CASE ChangeEndDate WHEN 1 THEN 1 ELSE 0 END) AS EndDateDefined,');
      SQL.Add('    SUM(TimeCycleDefined) AS TimeCycleDefined');
      SQL.Add('  FROM ( '+
              '    SELECT PromotionID, SalesAreaID, StartDate, ChangeEndDate, ' +
              '       CASE WHEN c.ExceptionId IS NULL THEN 0 ELSE 1 END AS TimeCycleDefined '+
              '    FROM #PromotionException a '+
              '      INNER JOIN #PromotionExceptionSalesArea b ON a.ExceptionID = b.ExceptionID '+
              '      LEFT OUTER JOIN (SELECT DISTINCT ExceptionId FROM #PromotionExceptionTimeCycles) c ' +
              '        ON a.ExceptionId = c.ExceptionId ' +
              '    WHERE a.ExceptionID <> ' + IntToStr(ExceptionID) + ' ' +
              '    UNION ALL '+
              '    SELECT PromotionID, SalesAreaID, StartDate, ChangeEndDate, '+
              '       CASE WHEN c.ExceptionId IS NULL THEN 0 ELSE 1 END AS TimeCycleDefined '+
              '    FROM #TmpPromotionException a '+
              '      INNER JOIN #TmpPromotionExceptionSalesArea b ON a.ExceptionId = b.ExceptionID '+
              '      LEFT OUTER JOIN (SELECT DISTINCT ExceptionId FROM #TmpPromotionExceptionTimeCycles) c ' +
              '        ON a.ExceptionId = c.ExceptionId ' +
              '  ) CurrentExceptions ');
      SQL.Add('  GROUP BY SalesAreaID, PromotionID');
      SQL.Add(') Sub');
      SQL.Add('JOIN (');
      SQL.Add('  SELECT DISTINCT');
      SQL.Add('    CAST(config.[Sales Area Code] AS SMALLINT) AS SalesAreaID,');
      SQL.Add('    siteaztec.[Site Ref] AS SiteRef,');
      SQL.Add('    siteaztec.[Site Name] AS SiteName,');
      SQL.Add('    config.[Sales Area Name] AS SalesAreaName');
      SQL.Add('  FROM config');
      SQL.Add('  JOIN SiteAztec ON config.[site code] = SiteAztec.[Site Code]');
      SQL.Add('  WHERE (config.Deleted IS NULL OR config.Deleted = ''N'')');
      SQL.Add('  AND config.[Sales Area Code] IS NOT NULL');
      SQL.Add(') SANames ON Sub.SalesAreaID = SANames.SalesAreaID');
      SQL.Add('WHERE StartDateDefined>1 or EndDateDefined>1 or TimeCycleDefined>1');
      ExecSQL;
    end;
  end;

  with dmPromotions do begin
    qTempExceptionOverlap.SQL.Clear;
    qTempExceptionOverlap.SQL.Add('SELECT * FROM #Overlap');
    qTempExceptionOverlap.Active := true;
    Result := qTempExceptionOverlap.RecordCount;
  end;
  Log('Exception Wizard', 'CalcOverlaps ' + inttostr(result));

end;

procedure TExceptionWizard.UpdateException (ExceptionID : Int64; SalesAreaID : Integer; Keep : Boolean);
begin
  Log('Exception Wizard', 'UpdateException');
  with dmPromotions.adoqRun do
  begin
    if Keep then
      SQL.Text := Format(
        'delete #PromotionExceptionSalesArea where ExceptionID <> %d and SalesAreaID = %d', [ExceptionID, SalesAreaID]
      )
    else
      SQL.Text := Format(
        'delete #TmpPromotionExceptionSalesArea where SalesAreaID = %d', [SalesAreaID]
      );
    ExecSQL;
  end;
end;

procedure TExceptionWizard.LoadSelectedSalesAreas;
begin
  Log('Exception Wizard', 'LoadSelectedSalesAreas');
  tvSelectedSAs.Items.Clear;
  with dmPromotions.adoqRun do
  begin
    SQL.Clear;
    SQL.Add ('IF OBJECT_ID(''tempdb..#SinglePromotionExceptionSalesArea'') IS NOT NULL DROP TABLE #SinglePromotionExceptionSalesArea');
    ExecSQL;

    SQL.Clear;
    SQL.Add ('SELECT *');
    SQL.Add ('INTO #SinglePromotionExceptionSalesArea');
    SQL.Add ('FROM ##ConfigTree_Data a');
    SQL.Add ('JOIN #TmpPromotionExceptionSalesArea b');
    SQL.Add ('ON a.Level4ID = b.SalesAreaID');
    SQL.Add(Format ('WHERE b.ExceptionID = %d', [ExceptionID]));
    ExecSQL;
  end;
  SalesAreaDataTree.LoadFromTempTable(tvSelectedSAs, '#SinglePromotionExceptionSalesArea', 'SalesAreaID');
end;

procedure TExceptionWizard.edNameChange(Sender: TObject);
begin
   NameChecked := False;
end;

procedure TExceptionWizard.btActivateAllPromotionsClick(Sender: TObject);
begin
  with dbgPromotionActions do
  begin
    with DataSource.DataSet do
    begin
      DisableControls;
      First;
      while not EOF do
      begin
        Edit;
        FieldByName('Activate').AsBoolean := true;
        Post;
        Next;
      end;
      First;
      EnableControls;
    end;
  end;
  dbgPromotionActions.SetFocus;
end;

procedure TExceptionWizard.btActivateNoPromotionsClick(Sender: TObject);
begin
  with dbgPromotionActions do
  begin
    with DataSource.DataSet do
    begin
      DisableControls;
      First;
      while not EOF do
      begin
        Edit;
        FieldByName('Activate').AsBoolean := false;
        Post;
        Next;
      end;
      First;
      EnableControls;
    end;
  end;
  dbgPromotionActions.SetFocus;
end;

procedure TExceptionWizard.SearchTermEnter(Sender: TObject);
begin
  if TEdit(Sender).Tag = 1 then
  begin
    TEdit(Sender).Font.Color := clWindowText;
    TEdit(Sender).Text := '';
    TEdit(Sender).Tag := 0;
  end;
end;

procedure TExceptionWizard.SearchTermExit(Sender: TObject);
begin
  if Length(TEdit(Sender).Text) = 0 then
  begin
    TEdit(Sender).Tag := 1;
    TEdit(Sender).Font.Color := clGrayText;
    TEdit(Sender).Text := '<Type keywords to search>';
  end;
end;

procedure TExceptionWizard.edSASearchTermChange(Sender: TObject);
begin
  if TEdit(Sender).Tag = 0 then
  begin
    if SASearchTerm <> TEdit(Sender).Text then
    begin
      SASearchTermChanged := true;
      SATreeFindPrev.Enabled := true;
      SATreeFindNext.Enabled := true;
      SASearchTerm := TEdit(Sender).Text;
    end;
  end;
end;

procedure TExceptionWizard.ProductTreeFindUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Length(SASearchTerm) <> 0;
end;

procedure TExceptionWizard.ProductTreeFindPrevExecute(Sender: TObject);
begin
  with SalesAreaDataTree do
  begin
    if SASearchTermChanged then
    begin
      SASearchTermChanged := false;
      FindNodes(SASearchTerm, '##ConfigTree_Names', 0, GetMaxLevel);
      FindPrev;
    end
    else
      FindPrev;
  end;
  tvAvailableSAs.SetFocus;
end;

procedure TExceptionWizard.ProductTreeFindNextExecute(Sender: TObject);
begin
  with SalesAreaDataTree do
  begin
    if SASearchTermChanged then
    begin
      SASearchTermChanged := false;
      FindNodes(SASearchTerm, '##ConfigTree_Names', 0, GetMaxLevel);
      FindNext;
    end
    else
      FindNext;
  end;
  tvAvailableSAs.SetFocus;
end;

procedure TExceptionWizard.dstValidTimesCalcFields(DataSet: TDataSet);
begin
  dstValidTimesValidDaysDisplay.Value := ValidDaysDisplay(dstValidTimesValidDays.Value);
end;

procedure TExceptionWizard.dstValidTimesAfterScroll(DataSet: TDataSet);
var i: integer;
begin
  for i := 1 to 7 do
    clbValidDays.Checked[i - 1] := Pos(IntToStr(i), dstValidTimesValidDays.Value) <> 0;

  dtStartTime.Time := dstValidTimesStartTime.Value;
  dtEndTime.Time := dstValidTimesEndTime.Value;
end;

procedure TExceptionWizard.clbValidDaysClickCheck(Sender: TObject);
begin
  Log('Exception Wizard', 'User has changed an active day');

  dstValidTimes.Edit;
  dstValidTimesValidDays.Value := ValidDaysStrFromCheckboxes(clbValidDays);
  dstValidTimes.Post;
end;

function TExceptionWizard.AlreadyHasEmptyPeriod : boolean;
 var  currRecNo: integer;
begin
   result := false;
   with dstvalidTimes do
        begin
          currRecNo := RecNo;
          First;
          while not(Eof) do
          begin
            if dstValidTimesValidDays.AsString = '' then
            begin
              result := true;
              MessageDlg ('Please select active day(s)', mtInformation, [mbOK], 0);
              abort;
            end;
            Next;
          end;
          RecNo := currRecNo;
        end;
end;

procedure TExceptionWizard.btnNewTimePeriodClick(Sender: TObject);
begin
  // 502749
  if AlreadyHasEmptyPeriod() then
     exit;
  Log('Exception Wizard', 'User is adding a new time period');

  dstValidTimes.Append;
  dstValidTimesStartTime.Value := StrToDateTime('00:00');
  dstValidTimesEndTime.Value := StrToDateTime('00:00');
  dstValidTimes.Post;
  btnDeleteTimePeriod.Enabled := True;
end;

procedure TExceptionWizard.btnDeleteTimePeriodClick(Sender: TObject);
begin
  if MessageDlg('Are you sure you wish to delete the current Time Period?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    dstValidTimes.Delete;

  Log('Exception Wizard', 'User is deleting a time period');

  if dstValidTimes.RecordCount = 1 then
    btnDeleteTimePeriod.Enabled := False;
end;

procedure TExceptionWizard.dtStartTimeChange(Sender: TObject);
begin
  Log('Exception Wizard', 'User has changed a start time');

  dstValidTimes.Edit;
  dstValidTimesStartTime.Value := dtStartTime.Time;
  dstValidTimes.Post;
end;

procedure TExceptionWizard.dtEndTimeChange(Sender: TObject);
begin
  Log('Exception Wizard', 'User has changed an end time');

  dstValidTimes.Edit;
  dstValidTimesEndTime.Value := dtEndTime.Time;
  dstValidTimes.Post;
end;

procedure TExceptionWizard.cbHideDisabledPromotionsClick(Sender: TObject);
begin
  dmPromotions.EventPromotionsHideDisabled := cbHideDisabledPromotions.Checked;
end;

procedure TExceptionWizard.tsFirstPageShow(Sender: TObject);
begin
  if ReadOnly then
    DisablePromotionControls(tsFirstPage);
end;

procedure TExceptionWizard.FormDestroy(Sender: TObject);
begin
  WizardManager.Free;
end;

procedure TExceptionWizard.dtEndDateClick(Sender: TObject);
begin
  dtEndDate.Format := uGlobals.theDateFormat;
end;

end.
