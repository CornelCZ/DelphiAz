unit udmPromotions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dADOAbstract, DB, ADODB, uDataTree, stdctrls, uPromoCommon,
  Wwdatsrc;

const
  BACKGROUND_THREAD_COMPLETE = 100;

  CalcType_PriceEntry       = 0;  // Saved as a calculationtype of NULL
  CalcType_ValueIncrease    = 1;
  CalcType_ValueDecrease    = 2;
  CalcType_PercentIncrease  = 3;
  CalcType_PercentDecrease  = 4;
  CalcType_BandedPrice      = 5;
  HIGH_PRICE_RANGE          = 99999.99;
  LOW_PRICE_RANGE           = -99999.99;
  VERY_HIGH_PERCENTAGE      = 999.00;  // used in PriceIncDec form Increase Percentage
  HIGH_PERCENTAGE           = 100.00;  // used in PriceIncDec Increase Percentage and GroupPriceMethodFrame
  LOW_PERCENTAGE            = 0.00;

  PromoType_Timed = 0;
  PromoType_MultiBuy = 1;
  PromoType_BOGOF = 2;
  PromoType_EventPricing = 3;
  PromoType_EnhancedBOGOF = 4;  // visual only, fake "Type", a Promo attribute saved as Promotion_Repl field ExtendedFlag

  // PW: NB, functions in this data module should not use adoqrun. This is
  // reserved for ad hoc queries from the forms, one of which may be in
  // progress at the time that a datamodule function is called.

type
  TPromotionStatus = (psEnabled, psDisabled, psUnpriced);

  TPreloadCompleteFlags = record
    TarrifPrices, ProductTree, ConfigTree: boolean;
  end;

  TPreloadWaitType = (pwSiteAndProductTree, pwTarrifPrices);

  TReadNamesThread = class(TThread)
  public
    Connection: TADOConnection;
    RecordSet: _Recordset;
    NamesArray: PNamesArray;
    CompletionStatus: PBoolean;
    procedure Execute; override;
  end;

  // remove tarrif prices execution to delayed version
  TGetInitTarrifPricesThread = class(TThread)
  public
    Connection: TADOConnection;
    Command: TADOCommand;
    ConfigNamesThread: TReadNamesThread;
    ProductNamesThread: TReadNamesThread;
    procedure Execute; override;
    procedure Cancel;
    property ReturnValue;
  end;

  TGetDelayTarrifPricesThread = class(TThread)
  public
    Connection: TADOConnection;
    Command: TADOCommand;
    procedure Execute; override;
    procedure Cancel;
    property ReturnValue;
  end;

  TdmPromotions = class(TdmADOAbstract)
    qPromotions: TADOQuery;
    dsPromotions: TDataSource;
    qPromotionTypes: TADOQuery;
    qPromotionsName: TStringField;
    qPromotionsDescription: TStringField;
    qPromotionsPromoTypeID: TSmallintField;
    qPromotionsStartDate: TDateTimeField;
    qPromotionsEndDate: TDateTimeField;
    qPromotionsStatus: TIntegerField;
    qPromotionStatus: TADOQuery;
    qPromotionsPromotionStatusLookup: TStringField;
    qEditPromotionGroups: TADOQuery;
    qEditPromotionExceptions: TADOQuery;
    dsEditPromotionGroups: TDataSource;
    dsEditPromotionExceptions: TDataSource;
    qEditSalesAreaRewardPrice: TADOQuery;
    dsEditSalesAreaRewardPrice: TDataSource;
    qSiteSANames: TADOQuery;
    qPromotionsSingleRewardPrice: TBCDField;
    qUsedBands: TADOQuery;
    qEditSalesAreaRewardPricePromotionID: TLargeintField;
    qEditSalesAreaRewardPriceSalesAreaID: TSmallintField;
    qEditSalesAreaRewardPriceRewardPrice: TBCDField;
    qEditSalesAreaRewardPriceSiteRef: TStringField;
    qEditSalesAreaRewardPriceSiteName: TStringField;
    qEditSalesAreaRewardPriceSalesAreaName: TStringField;
    qEditPromoPrice: TADOQuery;
    dsEditPromoPrice: TDataSource;
    qEditPromoPriceSalesAreaCode: TSmallintField;
    qEditPromoPriceSaleGroupID: TSmallintField;
    qEditPromoPriceProductID: TLargeintField;
    qEditPromoPricePortionTypeID: TSmallintField;
    qEditPromoPricePrice: TBCDField;
    qEditPromoPriceStringField: TStringField;
    qEditPromoPriceStringField2: TStringField;
    qEditPromoPriceStringField3: TStringField;
    qPortionNames: TADOQuery;
    qEditPromoPricePortionTypeName: TStringField;
    qProductNames: TADOQuery;
    qEditPromoPriceProductName: TStringField;
    qEditSingleRewardPrice: TADOQuery;
    dsEditSingleRewardPrice: TDataSource;
    dsTempExceptionOverlap: TDataSource;
    qTempExceptionOverlap: TADOQuery;
    qTempExceptionOverlapSiteName: TStringField;
    qTempExceptionOverlapSalesAreaName: TStringField;
    qTempExceptionOverlapSiteRef: TStringField;
    qTempExceptionOverlapActionType: TStringField;
    qTempExceptionOverlapActionID: TIntegerField;
    qTempExceptionOverlapAction: TADOQuery;
    qTempExceptionOverlapSalesAreaID: TSmallintField;
    qEditSingleRewardPriceSingleRewardPrice: TBCDField;
    qEditPromoPricePromotionID: TLargeintField;
    qPromotionsEventOnly: TBooleanField;
    qEditEventStatus: TADOQuery;
    dsEditEventStatus: TDataSource;
    qEditEventStatusPromotionID: TLargeintField;
    qEditEventStatusName: TStringField;
    qEditEventStatusDescription: TStringField;
    qEditEventStatusPromoTypeName: TStringField;
    qEditEventStatusActivate: TBooleanField;
    qGetSiteSANames: TADOQuery;
    qEditPromoPriceTariffPrice: TBCDField;
    qTempExceptionOverlapOverlapData: TStringField;
    qFixPriorities: TADOQuery;
    qEditEventStatusEnabled: TBooleanField;
    qEditPromoPortionPriceMapping: TADOQuery;
    dsEditPromoPortionPriceMapping: TDataSource;
    qEditPromoPortionPriceMappingSaleGroupId: TSmallintField;
    qEditPromoPortionPriceMappingSourcePortionTypeId: TSmallintField;
    qEditPromoPortionPriceMappingTargetPortionTypeId: TSmallintField;
    qEditPromoPortionPriceMappingCalculationType: TSmallintField;
    qPromoCalcType: TADOQuery;
    qEditPromoPortionPriceMappingCalculationTypeLookup: TStringField;
    qEditPromoPortionPriceMappingSourcePortionTypeLookup: TStringField;
    qEditPromoPortionPriceMappingTargetPortionTypeLookup: TStringField;
    qEditPromoPortionPriceMappingPromotionID: TLargeintField;
    qEditPromoPortionPriceMappingCalculationValue: TFloatField;
    qPromotionsSiteCode: TIntegerField;
    qPromotionsCreatedOnThisSite: TBooleanField;
    qSiteNameLookup: TADOQuery;
    qPromotionsCreatedAt: TStringField;
    qEditPromotionGroupsSiteCode: TIntegerField;
    qEditPromotionGroupsPromotionID: TLargeintField;
    qEditPromotionGroupsSaleGroupID: TSmallintField;
    qEditPromotionGroupsName: TStringField;
    qEditPromotionGroupsQuantity: TIntegerField;
    qEditPromotionGroupsCalculationType: TSmallintField;
    qEditPromotionGroupsCalculationValue: TFloatField;
    qEditPromotionGroupsCalculationBand: TStringField;
    qEditPromotionGroupsRememberCalculation: TBooleanField;
    qEditEventStatusSiteCode: TIntegerField;
    qEditPromoPortionPriceMappingSiteCode: TIntegerField;
    qPromotionPriorityTemplate: TADOQuery;
    qSitePriorityTemplate: TADOQuery;
    qPromotionPriorityTemplateId: TIntegerField;
    dsPromotionPriorityTemplate: TDataSource;
    dsSitePriorityTemplate: TDataSource;
    qPromotionPriorityTemplateName: TStringField;
    qSiteNameLookupId: TIntegerField;
    qSiteNameLookupSiteName: TStringField;
    qSitePriorityTemplateSiteId: TIntegerField;
    qSitePriorityTemplateReference: TStringField;
    qSitePriorityTemplateSiteName: TStringField;
    qSitePriorityTemplatePriorityTemplateId: TIntegerField;
    qSitePriorityTemplateTemplateName: TStringField;
    cmdAddMissingSitesDefaultTemplates: TADOCommand;
    qTempPriorityTemplate: TADOQuery;
    dsTempPriorityTemplate: TDataSource;
    qTempPriorityTemplateId: TIntegerField;
    qTempPriorityTemplateName: TStringField;
    cmdAddMissingPromotionPriorities: TADOCommand;
    qSitePriorityTemplateAreaName: TStringField;
    qSitePriorityTemplateCompanyName: TStringField;
    qTempPriorityTemplateAutoPriorityModeId: TIntegerField;
    qEditPromotionGroupsRecipeChildrenMode: TSmallintField;
    qEditPromotionGroupsMakeChildrenFree: TBooleanField;
    qPromotionsExtendedFlag: TBooleanField;
    qPromotionsPromoTypeName: TStringField;
    qPromotionsUserSelectsProducts: TBooleanField;
    dsViewDeleted: TwwDataSource;
    tViewDeleted: TADOTable;
    qPromotionsPromotionID: TLargeintField;
    procedure DataModuleCreate(Sender: TObject); override;
    procedure DataModuleDestroy(Sender: TObject);
    procedure qEditPromoPortionPriceMappingCalculationValueGetText(
      Sender: TField; var Text: String; DisplayText: Boolean);
    procedure qEditPromoPortionPriceMappingCalculationValueSetText(
      Sender: TField; const Text: String);
    procedure qPromotionsCalcFields(DataSet: TDataSet);
    procedure qEditPromotionGroupsAfterScroll(DataSet: TDataSet);
    procedure qEditPromotionGroupsRecipeChildrenModeChange(Sender: TField);
  private
    HourglassOperationCount: integer;
    CalculatedGroupList: array of integer;

    qPromotionsOrderColumns: TList;
    qPromotionsDescendingColumns: array[1..9] of boolean;
    qPromotionsHideDisabled: boolean;

    qEditPromotionExceptionsOrderColumns: TList;
    qEditPromotionExceptionsDescendingColumns: array[1..3] of boolean;
    qEditPromotionExceptionsHideDisabled: boolean;
    FNARVatEnabled: boolean;

    FEventPromotionListFilter: string;
    FEventPromotionListFilterMidword: boolean;
    FHideDisabledEventPromotions: boolean;

    FMainPromotionListFilter: string;
    FMainPromotionListFilterMidword: boolean;
    FMainPromotionListFilterSiteCode: Integer;
    FSiteCode: Integer;
    FPromotionMode: TPromotionMode;

    procedure SaveUserSettings;
    procedure LoadUserSettings;
    procedure HideDisabledPromotions(const Value: boolean);
    procedure HideDisabledEventPromotions(const Value: boolean);
    function GetFilterText(text: string; MidwordSearch: boolean): string;
    procedure ApplyPromotionListFilter(
      promotionDataset: TDataset;
      filterText: string;
      midWordSearch: boolean;
      SiteCode: Integer;
      hideDisabledPromotions: boolean);
    procedure SetupSiteCode;
  public
    RolloverTime: TDateTime;
    GetInitTariffPricesThread: TGetInitTarrifPricesThread;
    GetDelayTariffPricesThread: TGetDelayTarrifPricesThread;
    usePromoDeals : boolean;
    promoRetentionPeriod: smallint;

    procedure UpdatePromotionsQuery;
    procedure TogglePromotionsFieldOrder(Column: integer);
    procedure UpdateExceptionsQuery;
    procedure ToggleExceptionsFieldOrder(Column: integer);
    procedure HideDisabledExceptions(Value: boolean);

    procedure GetBandsList(List: TStrings);
    procedure AwaitPreload(PreloadType: TPreloadWaitType);
    function GetCalcType (calcName : String) : Integer;
    procedure DeleteDataForSaleGroup(SaleGroupID: integer);
    procedure BuildCalculatedGroupList;
    function IsCalculatedGroup(GroupID: integer): boolean;
    procedure BeginHourglass;
    procedure EndHourglass;
    function GetSiteNames : TStringList;
    function GetPromotions : TStringList;

    function GetAutoPriorityMode(TemplateID: Integer): integer;
    procedure SetAutoPriorityMode(Value: integer; TemplateID: Integer);

    procedure LoadTmpEventStatus(SourceTableName: string);
    procedure SaveTmpEventStatus(SiteCode: integer; DestTableName: string; DestID: Int64);

    procedure FixPriorities(SiteCode: Integer);
    procedure InsertMissingPromotionPriorities;
    
    procedure SetMainPromotionListFilter(const FilterText: string; MidwordSearch: boolean; SiteCode: Integer);
    procedure ClearMainPromotionListFilter;
    procedure SetEventPromotionListFilter(const FilterText: string; MidwordSearch: boolean; SiteCode: Integer);
    procedure ClearEventPromotionListFilter;

    procedure ArchiveOneDeletedPromotion(PromotionID: string);
    procedure RestoreArchivedPromotions;
    procedure EraseExpiredArchivedPromoDetails;
    procedure ArchivePromotions;

    property PromotionExceptionsHideDisabled: boolean read qEditPromotionExceptionsHideDisabled;
    property PromotionsHideDisabled: boolean read qPromotionsHideDisabled write HideDisabledPromotions;
    property EventPromotionsHideDisabled: boolean read FHideDisabledEventPromotions write HideDisabledEventPromotions;
    property NARVatEnabled: boolean read FNARVatEnabled;
    property SiteCode: integer read FSiteCode;
    property PromotionMode: TPromotionMode read FPromotionMode;
  end;

var
  dmPromotions: TdmPromotions;
  PreloadStatus: TPreloadCompleteFlags;
  ProductNamesArray: TNamesArray;
  ConfigNamesArray: TNamesArray;

const
  GLOBAL_TABLES_TO_RENAME : array[0..5] of String = ('TariffPriceCache', 'ConfigTree_Names', 'ProductTree_Names',
    'ConfigTree_Data', 'ProductTree_Data', 'ProductNameCache');


procedure ValidatePriceKeyPress(var Key:Char;
  CurrentText: String;
  SelectionStart: Integer;
  SelectionLength: Integer;
  DecimalPosition: Integer;
  AllowNegative: boolean = true);

implementation

uses ComObj, useful, uAztecDatabaseUtils, uPreloadWaitScreen, uGlobals,
  uPassword, uADO, registry, uSimpleLocalise, StrUtils, Math, uAztecLog;

{$R *.dfm}

{ TdmPromotions }

procedure TdmPromotions.TogglePromotionsFieldOrder(Column: integer);
begin
  if qPromotionsOrderColumns.IndexOf(pointer(Column)) <> 0 then
  begin
    qPromotionsOrderColumns.Delete(qPromotionsOrderColumns.IndexOf(pointer(Column)));
    qPromotionsOrderColumns.Insert(0, pointer(Column));
  end;
  qPromotionsDescendingColumns[Column] := not qPromotionsDescendingColumns[Column];
  UpdatePromotionsQuery;
end;

function GetTokenParam: string;
var
  i: integer;
begin
  Result := '';
  for i := 1 to ParamCount do
  begin
    if Copy(LowerCase(ParamStr(i)),1,6) = 'token=' then
      Result := Copy( ParamStr(i), 7, Length(ParamStr(i)) );
  end;
end;

procedure TdmPromotions.DataModuleCreate(Sender: TObject);
const NAR_VAT = 1;
var
  i: integer;
  helpFileName : string;
  AccessPermission: string;
  AccessDeniedMessage: String;
  tokenParam : string;
begin
  inherited;

  tokenParam := GetTokenParam;

  DefineTablesToRenameList(GLOBAL_TABLES_TO_RENAME);
  SetupSiteCode;

  GetGlobalData(AztecConn);

  if IsMaster then
    FPromotionMode := pmMaster
  else
    FPromotionMode := pmSite;

  adoqRun.SQL.text := 'SELECT TOP 1 VATMode FROM ThemeGlobalConfigs';
  adoqRun.Open;
  FNARVatEnabled := (adoqRun.FieldByName('VATMode').AsInteger = NAR_VAT);
  adoqRun.Close;

  adoqRun.SQL.text := 'SELECT [dbo].[fn_GetConfigurationSetting] (''UsePromoDeals'') as UseDeals';
  adoqRun.Open;
  usePromoDeals := (adoqRun.FieldByName('UseDeals').AsString = '1');
  adoqRun.Close;

  if usePromoDeals then
  begin
    qPromotions.SQL[5] := '  p.UserSelectsProducts, PromotionStatus.Name AS PromoStatus, ';
    qPromotions.SQL[7] := '    SingleRewardPrice, p.SiteCode, p.ExtendedFlag ';
    qPromotions.SQL[9] := 'join PromoType on p.PromoTypeID = PromoType.PromoTypeID'
  end
  else
  begin
    qPromotions.SQL[5] := '  PromotionStatus.Name AS PromoStatus,';
    qPromotions.SQL[7] := '    SingleRewardPrice, p.SiteCode, p.ExtendedFlag, p.UserSelectsProducts ';
    qPromotions.SQL[9] := 'join PromoType on p.PromoTypeID = PromoType.PromoTypeID AND p.UserSelectsProducts = 0';
  end;

  GetInitTariffPricesThread := TGetInitTarrifPricesThread.Create(True);

  GetInitTariffPricesThread.Connection := TADOConnection.Create(nil);
  SetUpAztecADOConnection(GetInitTariffPricesThread.Connection);
  GetInitTariffPricesThread.Connection.OnWillExecute := AztecConn.OnWillExecute;

  GetInitTariffPricesThread.Resume;

  // vk create delayd version of thread for tariff pricing
  // execute after product selection
  GetDelayTariffPricesThread := TGetDelayTarrifPricesThread.Create(True);

  GetDelayTariffPricesThread.Connection := TADOConnection.Create(nil);
  SetUpAztecADOConnection(GetDelayTariffPricesThread.Connection);
  GetDelayTariffPricesThread.Connection.OnWillExecute := AztecConn.OnWillExecute;

  qPromotionsOrderColumns := TList.Create;
  for i := 1 to 8 do
    qPromotionsOrderColumns.Add(pointer(i));

  if usePromoDeals then
    qPromotionsOrderColumns.Add(pointer(9));

  qEditPromotionExceptionsOrderColumns := TList.Create;
  for i := 1 to 3 do
    qEditPromotionExceptionsOrderColumns.Add(pointer(i));

  adoqrun.SQL.text := 'select [rollover time] from timeout';
  adoqrun.open;
  RolloverTime := useful.FixedStrToTime(adoqrun.fieldByName('Rollover time').AsString);
  adoqrun.close;

  if TfrmPassword.Login(tokenParam) then
  begin
    if uGlobals.LogonFailedTimes > 0 then
      Log('Logon', 'WARNING: ' + inttostr(uGlobals.LogonFailedTimes) + ' failed Logon attempts. Names: ' +
        copy(uGlobals.LogonFailedNames, 3, length(uGlobals.LogonFailedNames)) + '.');
    if uGlobals.LogonErrorString <> '' then
      Log('Logon', 'WARNING: Logon checking had one or more Errors: ' + uGlobals.LogonErrorString);
    if uGlobals.LogonUserName <> ''  then
      Log('Logon', 'Logon authenticated for User Name: ' + uGlobals.LogonUserName);

    if IsMaster then
    begin
      AccessPermission := 'action://Promotions/ModuleAccess';
      AccessDeniedMessage := 'Aztec Promotions';
    end
    else if IsSite then
    begin
      AccessPermission := 'action://Promotions/ModuleAccessSite';
      AccessDeniedMessage := 'Aztec Site Promotions';
    end;

    if not TfrmPassword.UserHasPermission(AccessPermission) then
    begin
      MessageDlg(Format('User has insufficient privileges to run %s' + #10 + #13 +
        #10 + #13 + 'The application will now terminate', [AccessDeniedMessage]), mtInformation, [mbOK], 0);
      Application.Terminate;
      Exit;
    end;
  end
  else
  begin
    if uGlobals.LogonFailedTimes > 0 then
      Log('Logon', 'WARNING: ' + inttostr(uGlobals.LogonFailedTimes) + ' failed Logon attempts. Names: ' +
        copy(uGlobals.LogonFailedNames, 3, length(uGlobals.LogonFailedNames)) + '.');
    if uGlobals.LogonErrorString <> '' then
      Log('Logon', 'WARNING: Logon checking had one or more Errors: ' + uGlobals.LogonErrorString);
    if uGlobals.LogonUserName <> ''  then
      Log('Logon', 'Logon authenticated for User Name: ' + uGlobals.LogonUserName);

    Application.Terminate;
    Exit;
  end;

  SetLogUserName(CurrentUser.UserName);
  
(*  spSetFutureToCurrent.Parameters.ParamByName('CurrDate').Value := formatDateTime('mm/dd/yyyy', theDate);
  spSetFutureToCurrent.Parameters.ParamByName('TableName').Value := 'SABands';
  spSetFutureToCurrent.ExecProc;

  UpdateSABands;

  spRefreshPromoPrices.Parameters.ParamByName('CurrDate').Value := formatDateTime('mm/dd/yyyy', theDate);
  spRefreshPromoPrices.ExecProc;    *)

  if uSimpleLocalise.NeedToLocalise then
    helpFileName := PROMO_HO_US_HELP_FILE
  else
    helpFileName := PROMO_HO_UK_HELP_FILE;

  AssignHelpFile( helpFileName );

  if not HelpExists then
  begin
    MessageDlg('Could not locate help file: ' + HelpFileName + '.' + #13 +
      'Help will not be available during this session.', mtInformation, [mbOK], 0);
  end;

  LoadUserSettings;

  qGetSiteSANames.ExecSQL;

  //Initialise filters on promotion datasets.
  FMainPromotionListFilterSiteCode := -1;
  ApplyPromotionListFilter(qPromotions, FMainPromotionListFilter, FMainPromotionListFilterMidword, FMainPromotionListFilterSiteCode, qPromotionsHideDisabled);
  ApplyPromotionListFilter(qEditEventStatus, FEventPromotionListFilter, FEventPromotionListFilterMidword, -1, FHideDisabledEventPromotions);

  // Archiving of Deleted Promo Details setup
  adoqrun.close;
  adoqrun.SQL.Clear;
  adoqRun.SQL.Add('declare @str varchar(20) select @str =  dbo.fn_GetConfigurationSetting(' +
    QuotedStr('DaysKeepArchPromo') + ')');
  adoqRun.SQL.Add('SELECT CASE WHEN ISNUMERIC(@str) > 0 THEN CAST(@str AS INT) ELSE 0 END as days');
  adoqRun.Open;

  promoRetentionPeriod := adoqrun.fieldbyname('days').AsInteger;
  if promoRetentionPeriod > 0 then
  begin
    if promoRetentionPeriod < 90 then
      promoRetentionPeriod := 90
    else if promoRetentionPeriod > 1096 then
      promoRetentionPeriod := 1096;
  end;
end;

procedure TdmPromotions.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  SaveUserSettings;
  qPromotionsOrderColumns.Free;
  qEditPromotionExceptionsOrderColumns.Free;
  GetInitTariffPricesThread.Cancel;
  GetInitTariffPricesThread.Connection.Free;
  GetInitTariffPricesThread.Free;
end;

procedure TdmPromotions.HideDisabledPromotions(const Value: boolean);
begin
  if qPromotionsHideDisabled <> Value then
  begin
    qPromotionsHideDisabled := Value;
    ApplyPromotionListFilter(qPromotions, FMainPromotionListFilter, FMainPromotionListFilterMidword, FMainPromotionListFilterSiteCode, qPromotionsHideDisabled);
  end;
end;

procedure TdmPromotions.HideDisabledEventPromotions(const Value: boolean);
begin
  if FHideDisabledEventPromotions <> Value then
  begin
    FHideDisabledEventPromotions := Value;
    ApplyPromotionListFilter(qEditEventStatus, FEventPromotionListFilter, FEventPromotionListFilterMidword, -1, FHideDisabledEventPromotions);
  end;
end;

procedure TdmPromotions.UpdatePromotionsQuery;
var
  OrderClause: string;
  i, j: integer;
  BMark: Int64;
begin
  BMark := TLargeIntField(qPromotions.FieldByName('PromotionID')).AsLargeInt;

  OrderClause := 'ORDER BY ';
  for i := 0 to Pred(qPromotionsOrderColumns.Count) do
  begin
    j := integer(qPromotionsOrderColumns[i]);
    if qPromotionsDescendingColumns[j] then
      OrderClause := OrderClause + Format('%d DESC, ', [j])
    else
      OrderClause := OrderClause + Format('%d ASC, ', [j]);
  end;
  OrderClause := Copy(OrderClause, 1, Length(OrderClause)-2);

  qPromotions.SQL[17] := OrderClause;

  //Log(' DEBUG ', 'qPromotions.SQL: ' + #10#13 + qPromotions.SQL.Text + #10#13) ;

  qPromotions.Open;
  qPromotions.Locate('PromotionID', BMark, []);
end;

procedure TdmPromotions.GetBandsList(List: TStrings);
begin
  // This operation takes a long time the first time it is run.
  // The qUsedBands dataset is deliberately kept open so it is faster
  // next time.
  BeginHourglass;
  List.Clear;
  with qUsedBands do
  begin
    Active := True;
    First;
    while not Eof do
    begin
      List.Add(FieldByName('Band').AsString);
      Next;
    end;
  end;
  EndHourglass;
end;

procedure TdmPromotions.AwaitPreload(PreloadType: TPreloadWaitType);
var
  WindowList: pointer;
  function PreloadComplete: boolean;
  begin
    case PreloadType of
      pwSiteAndProductTree:
        Result := PreloadStatus.ProductTree and PreloadStatus.ConfigTree;
      pwTarrifPrices:
        Result := PreloadStatus.TarrifPrices;
    else
      raise Exception.Create('Invalid preload type in TdmPromotions.AwaitPreload');
    end;
  end;
begin
  if not (PreloadComplete) then
  begin
    BeginHourglass;
    WindowList := nil;
    with TPreloadWaitScreen.Create(nil) do try
      // Show form as a modal-style window
      WindowList := DisableTaskWindows(Handle);
      case PreloadType of
        pwSiteAndProductTree:
          lbLoadingMessage.Caption := 'Please wait while Site and Product data are pre-loaded';
        pwTarrifPrices:
          lbLoadingMessage.Caption := 'Please wait while Site price information is pre-loaded';
      else
        raise Exception.Create('Invalid preload type in TdmPromotions.AwaitPreload');
      end;
      Show;
      repeat
        // If cancel button request, use a vcl abort exception
        // to silently cancel the calling action/button handler
        if ModalResult = mrCancel then
          Abort;
        Application.ProcessMessages;
      until PreloadComplete;
      Close;
    finally
      EnableTaskWindows(WindowList);
      Free;
      EndHourGlass;
    end;
  end;
end;

function TdmPromotions.GetCalcType(calcName: String): Integer;
var
  adoQuery  : TADOQuery;
begin
  adoQuery := TADOQuery.Create(nil);
  try
    adoQuery.Connection := AztecConn;
    Result := -1;
    adoQuery.SQL.Text := Format ('SELECT PromoCalcTypeID FROM PromoCalcType WHERE PromoCalcDesc = ''%s''', [calcName]);
    adoQuery.Open;
    if not adoQuery.Eof then begin
      Result := adoQuery.FieldByName ('PromoCalcTypeID').AsInteger;
    end;
  finally
    adoQuery.Close;
    adoQuery.Free;
  end;
end;

procedure TdmPromotions.DeleteDataForSaleGroup(SaleGroupID: integer);
begin
  with TADOQuery.Create(nil) do
  begin
    Connection := AztecConn;
    SQL.Text := Format(
      'DELETE #PromotionSaleGroup where SaleGroupID = %0:d '+
      'DELETE #PromotionSaleGroupDetail where SaleGroupID = %0:d '+
      'DELETE #PromotionPrices where SaleGroupID = %0:d '+
      'UPDATE #PromotionSaleGroup set SaleGroupID = SaleGroupID -1 where SaleGroupID > %0:d '+
      'UPDATE #PromotionSaleGroupDetail set SaleGroupID = SaleGroupID -1 where SaleGroupID > %0:d '+
      'UPDATE #PromotionPrices set SaleGroupID = SaleGroupID -1 where SaleGroupID > %0:d '
      , [SaleGroupID]);
    ExecSQL;
    Free;
  end;
end;

procedure TdmPromotions.BuildCalculatedGroupList;
var
  ListIndex: integer;
begin
  with TADOQuery.Create(nil) do try
    Connection := AztecConn;
    SQL.Text := 'select SaleGroupID from #PromotionSaleGroup where RememberCalculation = 1 order by SaleGroupID';
    Open;
    SetLength(CalculatedGroupList, RecordCount);
    First;
    ListIndex := 0;
    while not(EOF) do
    begin
      CalculatedGroupList[ListIndex] := FieldByName('SaleGroupID').AsInteger;
      Inc(ListIndex);
      Next;
    end;
    Close;
  finally
    Free;
  end;
end;

function TdmPromotions.IsCalculatedGroup(GroupID: integer): boolean;
var
  i: integer;
begin
  Result := false;
  for i := low(CalculatedGroupList) to high(CalculatedGroupList) do
    if CalculatedGroupList[i] = GroupID then
    begin
      Result := true;
      break;
    end
    else
    if CalculatedGroupList[i] > GroupID then
    begin
      Result := false;
      break;
    end;
end;

procedure TdmPromotions.BeginHourglass;
begin
  if HourglassOperationCount = 0 then
  begin
    Screen.Cursor := crHourglass;
  end;
  Inc(HourglassOperationCount);
end;

procedure TdmPromotions.EndHourglass;
begin
  Dec(HourglassOperationCount);
  if HourglassOperationCount = 0 then
    Screen.Cursor := crDefault;
end;

function TdmPromotions.GetPromotions: TStringList;
var
  adoQuery  : TADOQuery;
begin
  adoQuery := TADOQuery.Create(nil);
  try
    adoQuery.Connection := AztecConn;
    Result := TStringList.Create;
    adoQuery.SQL.Text := 'SELECT Name FROM Promotion';
    adoQuery.Open;
    while not adoQuery.Eof do
    begin
      Result.Add(adoQuery.FieldByName ('Name').AsString);
      adoQuery.Next;
    end;
  finally
    adoQuery.Close;
    adoQuery.Free;
  end;
end;

function TdmPromotions.GetSiteNames: TStringList;
var
  adoQuery  : TADOQuery;
begin
  adoQuery := TADOQuery.Create(nil);
  try
    adoQuery.Connection := AztecConn;
    Result := TStringList.Create;
    adoQuery.SQL.Text := 'SELECT [Site Name] FROM SiteAztec where Deleted is null or Deleted = ''N''';
    adoQuery.Open;
    while not adoQuery.Eof do
    begin
      Result.Add(adoQuery.FieldByName ('Site Name').AsString);
      adoQuery.Next;
    end;
  finally
    adoQuery.Close;
    adoQuery.Free;
  end;
end;

procedure TdmPromotions.HideDisabledExceptions(Value: boolean);
begin
  if qEditPromotionExceptionsHideDisabled <> Value then
  begin
    qEditPromotionExceptionsHideDisabled := Value;
    UpdateExceptionsQuery;
  end;
end;

procedure TdmPromotions.ToggleExceptionsFieldOrder(Column: integer);
begin
  if qEditPromotionExceptionsOrderColumns.IndexOf(pointer(Column)) <> 0 then
  begin
    qEditPromotionExceptionsOrderColumns.Delete(qEditPromotionExceptionsOrderColumns.IndexOf(pointer(Column)));
    qEditPromotionExceptionsOrderColumns.Insert(0, pointer(Column));
  end;
  qEditPromotionExceptionsDescendingColumns[Column] := not qEditPromotionExceptionsDescendingColumns[Column];
  UpdateExceptionsQuery;
end;

procedure TdmPromotions.UpdateExceptionsQuery;
var
  OrderClause, WhereClause: string;
  i, j: integer;
  BMark: integer;
begin
  if qEditPromotionExceptions.Active then
    BMark := qEditPromotionExceptions.FieldByName('ExceptionID').AsInteger
  else
    BMark := -1;

  if qEditPromotionExceptionsHideDisabled then
    WhereClause := 'WHERE a.Status <> '+IntToStr(Ord(psDisabled))
  else
    WhereClause := '';

  OrderClause := 'ORDER BY ';
  for i := 0 to Pred(qEditPromotionExceptionsOrderColumns.Count) do
  begin
    j := integer(qEditPromotionExceptionsOrderColumns[i]);
    if qEditPromotionExceptionsDescendingColumns[j] then
      OrderClause := OrderClause + Format('%d DESC, ', [j])
    else
      OrderClause := OrderClause + Format('%d ASC, ', [j]);
  end;
  OrderClause := Copy(OrderClause, 1, Length(OrderClause)-2);
  qEditPromotionExceptions.SQL.Text :=
    'select a.Name, a.Description, b.Name, a.ExceptionID, a.PromotionID, a.StartDate, a.EndDate, a.Status, ChangeEndDate '+
    'from #PromotionException a '+
    'join PromotionStatus b on a.Status = b.StatusID';
  qEditPromotionExceptions.SQL.Add(WhereClause);
  qEditPromotionExceptions.SQL.Add(OrderClause);
  qEditPromotionExceptions.Open;
  if BMark <> -1 then
    qEditPromotionExceptions.Locate('ExceptionID', BMark, []);
end;

procedure TdmPromotions.SaveUserSettings;
var
  TmpStr: string;
  i: integer;
begin
  // Save hide disabled/sorting settings for promotion list and exceptions list
  // within the promotion wizard
  try
    with TRegistry.Create do try
      RootKey := HKEY_CURRENT_USER;
      OpenKey('Software\Zonal\Aztec\AZPP', True);
      WriteBool('qPromotionsHideDisabled', qPromotionsHideDisabled);
      WriteBool('qEditPromotionExceptionsHideDisabled', qEditPromotionExceptionsHideDisabled);

      TmpStr := '';
      for i := low(qPromotionsDescendingColumns) to high(qPromotionsDescendingColumns) do
        TmpStr := TmpStr + IntToStr(integer(qPromotionsDescendingColumns[i]));
      WriteString('qPromotionsDescendingColumns', TmpStr);
      TmpStr := '';
      for i := low(qEditPromotionExceptionsDescendingColumns) to high(qEditPromotionExceptionsDescendingColumns) do
        TmpStr := TmpStr + IntToStr(integer(qEditPromotionExceptionsDescendingColumns[i]));
      WriteString('qEditPromotionExceptionsDescendingColumns', TmpStr);

      TmpStr := '';
      for i := 0 to Pred(qPromotionsOrderColumns.Count) do
        TmpStr := TmpStr + IntToStr(integer(qPromotionsOrderColumns[i]));
      WriteString('qPromotionsOrderColumns', TmpStr);
      TmpStr := '';
      for i := 0 to Pred(qEditPromotionExceptionsOrderColumns.Count) do
        TmpStr := TmpStr + IntToStr(integer(qEditPromotionExceptionsOrderColumns[i]));
      WriteString('qEditPromotionExceptionsOrderColumns', TmpStr);

      CloseKey;
    finally
      Free;
    end;
  except
  end;
end;

procedure TdmPromotions.LoadUserSettings;
var
  TmpStr: string;
  i: integer;
begin
  // Load the hide disabled/sorting settings
  qPromotionsHideDisabled := True;
  qEditPromotionExceptionsHideDisabled := True;
  try
    with TRegistry.Create do try
      RootKey := HKEY_CURRENT_USER;
      if OpenKeyReadOnly('Software\Zonal\Aztec\AZPP') then
      begin
        qPromotionsHideDisabled := ReadBool('qPromotionsHideDisabled');
        qEditPromotionExceptionsHideDisabled := ReadBool('qEditPromotionExceptionsHideDisabled');

        TmpStr := ReadString('qPromotionsDescendingColumns');
        if Length(tmpStr) = Length(qPromotionsDescendingColumns) then
          for i := low(qPromotionsDescendingColumns) to high(qPromotionsDescendingColumns) do
            qPromotionsDescendingColumns[i] :=  TmpStr[i] = '1';

        TmpStr := ReadString('qEditPromotionExceptionsDescendingColumns');
        if Length(tmpStr) = Length(qEditPromotionExceptionsDescendingColumns) then
          for i := low(qEditPromotionExceptionsDescendingColumns) to high(qEditPromotionExceptionsDescendingColumns) do
            qEditPromotionExceptionsDescendingColumns[i] :=  TmpStr[i] = '1';

        TmpStr := ReadString('qPromotionsOrderColumns');
        if Length(tmpStr) = qPromotionsOrderColumns.Count then
          for i := 0 to Pred(qPromotionsOrderColumns.Count) do
            qPromotionsOrderColumns[i] := Pointer(StrToInt(Tmpstr[i+1]));

        TmpStr := ReadString('qEditPromotionExceptionsOrderColumns');
        if Length(tmpStr) = qEditPromotionExceptionsOrderColumns.Count then
          for i := 0 to Pred(qEditPromotionExceptionsOrderColumns.Count) do
            qEditPromotionExceptionsOrderColumns[i] := Pointer(StrToInt(Tmpstr[i+1]));

        CloseKey;
      end;
    finally
      Free;
    end;
  except
  end;
end;

function TdmPromotions.GetAutoPriorityMode(TemplateID: Integer): integer;
var
  adoQuery  : TADOQuery;
begin
  adoQuery := TADOQuery.Create(nil);
  try
    adoQuery.Connection := AztecConn;
    Result := 0;
    adoQuery.SQL.Text := Format('select top 1 AutoPriorityModeId ' +
                                ' from ac_PromotionPriorityTemplate ' +
                                ' where Id = %d; ', [TemplateID]);
    adoQuery.Open;
    result := adoQuery.FieldByName('AutoPriorityModeId').AsInteger;
  finally
    adoQuery.Close;
    adoQuery.Free;
  end;
end;

procedure TdmPromotions.SetAutoPriorityMode(Value: integer; TemplateID: Integer);
var
  adoQuery  : TADOQuery;
begin
  adoQuery := TADOQuery.Create(nil);
  try
    adoQuery.Connection := AztecConn;
    adoQuery.SQL.Text := Format('Update #PriorityTemplate ' +
                                ' set AutoPriorityModeId = %d ' +
                                ' where Id = %d; ', [Value, TemplateID]);
    adoQuery.ExecSQL;
  finally
    adoQuery.Close;
    adoQuery.Free;
  end;
end;

procedure TdmPromotions.LoadTmpEventStatus(SourceTableName: string);
begin
  qEditEventStatus.Active := false;
  with TADOQuery.Create(nil) do try
    Connection := AztecConn;
    SQL.Text :=
      'if OBJECT_ID(''tempdb..#TmpPromotionEventStatus'') is not null drop table #TmpPromotionEventStatus '+
      'select a.SiteCode, a.PromotionID, a.Name, a.Description, b.PromoTypeName, a.Status, '+
      '  cast(case a.Status when 0 then 1 else 0 end as bit) as Enabled, '+
      '  cast(case IsNull(c.EnabledPromotionID, -1) when -1 then 0 else 1 end as bit) as Activate '+
      'into #TmpPromotionEventStatus '+
      'from Promotion a '+
      'join PromoType b on a.PromoTypeID = b.PromoTypeID '+
      'left outer join '+SourceTableName+' c on a.PromotionID = c.EnabledPromotionID '+
      'where a.PromoTypeID <> 4';
    ExecSQL;
    qEditEventStatus.Active := true;
  finally
    free;
  end;
end;

procedure TdmPromotions.SaveTmpEventStatus(SiteCode: integer; DestTableName: string; DestID: Int64);
begin
  if qEditEventStatus.State in [dsEdit, dsInsert] then
    qEditEventStatus.Post;

  with TADOQuery.Create(nil) do try
    Connection := AztecConn;
    SQL.Text := Format(
      'delete %1:s '+
      'insert %1:s '+
      'select %0:d, %2:s, PromotionID from #TmpPromotionEventStatus where Activate = 1 ',
      [SiteCode, DestTableName, IntToStr(DestID)]);
    ExecSQL;
  finally
    free;
  end;
end;

procedure TdmPromotions.FixPriorities(SiteCode: Integer);
begin
  qFixPriorities.Parameters.ParamByName('SiteCode').Value := SiteCode;
  qFixPriorities.ExecSQL;
end;

Procedure TdmPromotions.SetupSiteCode;
begin
  with adoqRun do
  begin
    SQL.Text := 'select dbo.fnGetSiteCode() as SiteCode';
    Open;

    if not EOF then
      FSiteCode := FieldByName('SiteCode').AsInteger;
  end;
end;

procedure TdmPromotions.ArchiveOneDeletedPromotion(PromotionID: string);
begin
  // archives one Promotion...
  with dmPromotions.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('IF OBJECT_ID(''tempdb..#PromoIds'') IS NOT NULL DROP TABLE #PromoIds');
    ExecSQL;

    SQL.Clear;
    SQL.Add('create table #PromoIds (pid bigint, lmdt datetime)');
    SQL.Add('insert #PromoIds values(' + PromotionID + ', GetDate())');
    ExecSQL;
  end;
  ArchivePromotions;
end;

procedure TdmPromotions.EraseExpiredArchivedPromoDetails;
begin
  // for all Archived Promotions where the Deleted DT earlier than Now - Retention Period.
  // Deletes one or more Promotions with Promo IDs from temp table #PromoIds
  with dmPromotions.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('DECLARE @ret int');
    sql.Add('exec @ret = sp_PromoEraseArchivedDetails ' + inttostr(uGlobals.SiteCode) + ', ' +
               QuotedStr(uGlobals.CurrentUser.UserName));
    sql.Add('SELECT @ret');
    // -1 #PromoIds not found; -2 #PromoIds empty; <= -24: Error Line; >= 1: no of archived Promos
    try
     Open;

     if fields[0].AsInteger = -1 then
     begin
       Log('Del Promo', 'ERROR Deleting details of Archived Promotion(s): #PromoIds not found');
       showMessage('ERROR Deleting details of Archived Promotion(s): ' +
        #10#13 + 'List of Promotion(s) to Delete not found.');
     end
     else if fields[0].AsInteger = -2 then
     begin
       Log('Del Promo', 'ERROR Deleting details of Archived Promotion(s): #PromoIds empty');
       showMessage('ERROR Deleting details of Archived Promotion(s): ' +
        #10#13 + 'List of Promotion(s) to Delete is empty.');
     end
     else if fields[0].AsInteger < -2 then
     begin
       Log('Del Promo', 'ERROR Deleting details of Archived Promotion(s), Line: ' + fields[0].asString);
       showMessage('ERROR Deleting details of Archived Promotion(s): ' +
        #10#13 + 'Error in Stored Procedure Line: ' + fields[0].asString);
     end;
    except
      on E:Exception do
      begin
        Log('Del Promo', 'ERROR Deleting details of Archived Promotion(s) "' + sql[1] + '"' +
        ' ERR MSG: ' + E.Message);
        showMessage('ERROR in Deleting details of Archived Promotion Stored Procedure' + #13 +
          'Error: "' + E.Message + '"' + #13 + #13 + 'Please contact Zonal.');
      end;
    end;
    Close;
  end;
end;

procedure TdmPromotions.ArchivePromotions;
begin
  // archives one or more Promotions from temp table #PromoIds
  with dmPromotions.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('DECLARE @ret int');
    sql.Add('exec @ret = sp_PromoArchiveDetails ' + inttostr(uGlobals.SiteCode) + ', ' +
               QuotedStr(uGlobals.CurrentUser.UserName));
    sql.Add('SELECT @ret');
    // -1 #PromoIds not found; -2 #PromoIds empty; <= -24: Error Line; >= 1: no of archived Promos
    try
     Open;

     if fields[0].AsInteger = -1 then
     begin
       Log('Del Promo', 'ERROR Archiving Promotion(s): #PromoIds not found');
       showMessage('ERROR Archiving details of Deleted Promotion(s): ' +
        #10#13 + 'List of Promotion(s) to archive not found.');
     end
     else if fields[0].AsInteger = -2 then
     begin
       Log('Del Promo', 'ERROR Archiving Promotion(s): #PromoIds empty');
       showMessage('ERROR Archiving details of Deleted Promotion(s): ' +
        #10#13 + 'List of Promotion(s) to archive is empty.');
     end
     else if fields[0].AsInteger < -2 then
     begin
       Log('Del Promo', 'ERROR Archiving Promotion(s), Line: ' + fields[0].asString);
       showMessage('ERROR Archiving details of Deleted Promotion(s): ' +
        #10#13 + 'Error in Stored Procedure Line: ' + fields[0].asString);
     end
     else
     begin
       Log('Del Promo', 'Archived ' + fields[0].asString + ' Promotion(s)');
     end;
    except
      on E:Exception do
      begin
        Log('Del Promo', 'ERROR Archiving Promotion(s) "' + sql[1] + '"' +
        ' ERR MSG: ' + E.Message);
        showMessage('ERROR in Archive Promotion Stored Procedure' + #13 +
          'Error: "' + E.Message + '"' + #13 + #13 + 'Please contact Zonal.');
      end;
    end;
    Close;
  end;
end;

procedure TdmPromotions.RestoreArchivedPromotions;
begin
  // restores one or more Promotions from temp table #PromoIds
  with dmPromotions.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('DECLARE @ret int');
    sql.Add('exec @ret = sp_PromoRestoreDetails ' + inttostr(uGlobals.SiteCode) + ', ' +
               QuotedStr(uGlobals.CurrentUser.UserName));
    sql.Add('SELECT @ret');
    // -1 #PromoIds not found; -2 #PromoIds empty; <= -24: Error Line; >= 1: no of archived Promos
    try
     Open;

     if fields[0].AsInteger = -1 then
     begin
       Log('Del Promo', 'ERROR Restoring Promotion(s): #PromoIds not found');
       showMessage('ERROR Restoring details of Deleted Promotion(s): ' +
        #10#13 + 'List of Promotion(s) to restore not found.');
     end
     else if fields[0].AsInteger = -2 then
     begin
       Log('Del Promo', 'ERROR Restoring Promotion(s): #PromoIds empty');
       showMessage('ERROR Restoring details of Deleted Promotion(s): ' +
        #10#13 + 'List of Promotion(s) to restore is empty.');
     end
     else if fields[0].AsInteger < -2 then
     begin
       Log('Del Promo', 'ERROR Restoring Promotion(s), Line: ' + fields[0].asString);
       showMessage('ERROR Restoring details of Deleted Promotion(s): ' +
        #10#13 + 'Error in Stored Procedure Line: ' + fields[0].asString);
     end
     else
     begin
       Log('Del Promo', 'Restored ' + fields[0].asString + ' Promotion(s)');
     end;
    except
      on E:Exception do
      begin
        Log('Del Promo', 'ERROR Restoring Promotion(s) "' + sql[1] + '"' +
        ' ERR MSG: ' + E.Message);
        showMessage('ERROR in Restore Promotion Stored Procedure' + #13 +
          'Error: "' + E.Message + '"' + #13 + #13 + 'Please contact Zonal.');
      end;
    end;
    Close;
  end;
end;


{ TGetInitTarrifPricesThread }

procedure TGetInitTarrifPricesThread.Execute;
var
  ConfigNamesRecordset: _Recordset;
  ProductNamesRecordset: _Recordset;
begin
  FreeOnTerminate := false;
  if not Assigned(Connection) then
  begin
    Connection := TADOConnection.Create(nil);
    SetUpAztecADOConnection(Connection);
  end;
  Command := TADOCommand.Create(nil);
  Command.Connection := Connection;
  Command.CommandTimeout := 0;

  Command.ExecuteOptions := [eoExecuteNoRecords];
  Command.CommandText := GetStringResource('ConfigTreeviewPreload', 'TEXT');
  try
    Command.Execute;
  except on E:EOLEException do
    begin
      Log('Error', LowerCase(E.Message));
      if Pos('operation has been cancelled', LowerCase(E.Message)) = 0 then
        raise;
    end;
  end;

  Command.ExecuteOptions := [];
  Command.CommandText := 'select * from ##ConfigTree_Names';
  ConfigNamesRecordSet := Command.Execute;

  ConfigNamesThread := TReadNamesThread.Create(True);
  with ConfigNamesThread do
  begin
    Connection := Self.Connection;
    RecordSet := ConfigNamesRecordSet;
    NamesArray := @ConfigNamesArray;
    CompletionStatus := @PreloadStatus.ConfigTree;
    Resume;
  end;

  Command.ExecuteOptions := [eoExecuteNoRecords];
  Command.CommandText := GetStringResource('ProductsTreeviewPreload', 'TEXT');
  try
    Command.Execute;
  except on E:EOLEException do
    if Pos('operation has been cancelled', LowerCase(E.Message)) = 0 then
      raise;
  end;

  Command.ExecuteOptions := [];
  Command.CommandText := 'select * from ##ProductTree_Names';
  ProductNamesRecordSet := Command.Execute;

  ProductNamesThread := TReadNamesThread.Create(True);
  with ProductNamesThread do
  begin
    Connection := Self.Connection;
    RecordSet := ProductNamesRecordSet;
    NamesArray := @ProductNamesArray;
    CompletionStatus := @PreloadStatus.ProductTree;
    Resume;
  end;

  // vk this block is executed in DelayXX version of thread
  {
  Command.ExecuteOptions := [eoAsyncExecute, eoExecuteNoRecords];
  Command.CommandText := GetStringResource('TariffPricesPreload', 'TEXT');
  try
    Command.Execute;
  except on E:EOLEException do
    // Use of AsyncExecute means no "cancel" exception gets raised
    // however the handling of this OLE exception has been left in, in case
    // we switch back to syncronous operation later.
    if Pos('operation has been cancelled', LowerCase(E.Message)) = 0 then
      raise;
  end;
  }

  while Command.States - [stConnecting, stExecuting, stFetching] = [] do
    Sleep(50);
  //PreloadStatus.TarrifPrices := True;

  while (PreloadStatus.ProductTree = False) or (PreloadStatus.ConfigTree = False) do
    Sleep(20);

  FreeAndNil(ProductNamesThread);
  FreeAndNil(ConfigNamesThread);

  FreeAndNil(Command);
  //FreeAndNil(Connection);
  ReturnValue := BACKGROUND_THREAD_COMPLETE
end;

procedure TGetInitTarrifPricesThread.Cancel;
begin
  if ReturnValue < BACKGROUND_THREAD_COMPLETE then
  begin
    Command.Cancel;
    if Assigned(ProductNamesThread) then
      ConfigNamesThread.Terminate;
    if Assigned(ProductNamesThread) then
      ProductNamesThread.Terminate;
  end;
end;

{ TReadNamesThread }

procedure TReadNamesThread.Execute;
begin
  FreeOnTerminate := False;
  with TADODataSet.Create(nil) do
  begin
    Recordset := Self.RecordSet;
    Open;
    SetLength(NamesArray^, RecordCount+1);
      First;
    while not EOF and not Terminated do
    begin
      NamesArray^[FieldByName('ID').AsInteger] := FieldByName('Name').AsString;
      Next;
    end;
    Close;
    Free;
  end;
  RecordSet := nil;
  CompletionStatus^ := True;
end;

procedure TdmPromotions.SetMainPromotionListFilter(const FilterText: string; MidwordSearch: boolean; SiteCode: Integer);
begin
  if (FMainPromotionListFilter <> FilterText)
  or (FMainPromotionListFilterMidword <> MidwordSearch)
  or (FMainPromotionListFilterSiteCode <> SiteCode) then
  begin
    FMainPromotionListFilter := FilterText;
    FMainPromotionListFilterMidword := MidwordSearch;
    FMainPromotionListFilterSiteCode := SiteCode;
    ApplyPromotionListFilter(qPromotions, FMainPromotionListFilter, FMainPromotionListFilterMidword, FMainPromotionListFilterSiteCode, qPromotionsHideDisabled);
  end;
end;

procedure TdmPromotions.ClearMainPromotionListFilter;
begin
  if (FMainPromotionListFilter <> '') or (FMainPromotionListFilterSiteCode <> -1) then
  begin
    FMainPromotionListFilter := '';
    FMainPromotionListFilterSiteCode := -1;
    ApplyPromotionListFilter(qPromotions, FMainPromotionListFilter, FMainPromotionListFilterMidword, FMainPromotionListFilterSiteCode, qPromotionsHideDisabled);
  end;
end;

procedure TdmPromotions.SetEventPromotionListFilter(const FilterText: string; MidwordSearch: boolean; SiteCode: Integer);
begin
  if (FEventPromotionListFilter <> FilterText) or (FEventPromotionListFilterMidword <> MidwordSearch) then
  begin
    FEventPromotionListFilter := FilterText;
    FEventPromotionListFilterMidword := MidwordSearch;
    ApplyPromotionListFilter(qEditEventStatus, FEventPromotionListFilter, FEventPromotionListFilterMidword, -1, FHideDisabledEventPromotions);
  end;
end;

procedure TdmPromotions.ClearEventPromotionListFilter;
begin
  if (FEventPromotionListFilter <> '') then
  begin
    FEventPromotionListFilter := '';
    ApplyPromotionListFilter(qEditEventStatus, FEventPromotionListFilter, FEventPromotionListFilterMidword, -1, FHideDisabledEventPromotions);
  end;
end;

function TdmPromotions.GetFilterText(text: string; MidwordSearch: boolean): string;
begin
  if text = '' then
  begin
    Result := ''
  end
  else
  begin
    //Filtering for text beginning with either of the wildcard characters (i.e. Filter = '%%' or '*%' or '_') results in an error.
    //Instead prefix with a '%' which results in a midword search for the character (i.e. Filter = '%%%' or '%*%') so
    //at least it doesn't crash.
    if not (MidwordSearch) and ((copy(text,1,1) = '*') or (copy(text,1,1) = '%') or (copy(text,1,1) = '_')) then
      text := '%' + text;

    //Filtering with text that contains apostrophes will fail unless we escape them properly
    text := StringReplace(text,'''','''''',[rfReplaceAll, rfIgnoreCase]);

    Result := '''' + IfThen(MidwordSearch, '%') + text + '%''';
  end;
end;

procedure TdmPromotions.ApplyPromotionListFilter(
  promotionDataset: TDataset;
  filterText: string;
  midWordSearch: boolean;
  SiteCode: Integer;
  hideDisabledPromotions: boolean);
var
  bkMarkPromoID: Int64;
  bkMarkSiteCode: integer;
  filterTextRegEx: string;
begin
  bkMarkPromoID := 0;
  bkMarkSiteCode := 0;

  with promotionDataset do
  begin
    if Active then
    begin
      bkMarkSiteCode := FieldByName('SiteCode').AsInteger;
      bkMarkPromoID := TLargeintField(FieldByName('PromotionId')).AsLargeInt;
    end;

    Filtered := False;
    Filter := '';
    filterTextRegEx := GetFilterText(filterText, midWordSearch);

    //Note: Here I'd hoped to use a filter expression like:
    //   ([Name] LIKE <blah> OR [Description] LIKE <blah>) AND [Status] = psEnabled
    // but the Dataset.Filter property won't accept this. You get an "Invalid argument..." exception.
    //For n filter conditions we need SUM(nCr) taken for r in the interval [1,..,n]
    //e.g. n = 3 => we need (3C1) + (3C2) + (3C3) = 3 + 3 + 1 = 7 clauses.
    if (filterTextRegEx <> '') and hideDisabledPromotions and (SiteCode <> -1) then
      Filter := '([Name] LIKE ' + filterTextRegEx + ' AND [Status] = ' + IntToStr(Ord(psEnabled)) + ' AND [SiteCode] = ' + IntToStr(SiteCode) + ') OR ' +
                '([Description] LIKE ' + filterTextRegEx + ' AND [Status] = ' + IntToStr(Ord(psEnabled)) + ' AND [SiteCode] = ' + IntToStr(SiteCode) + ')'
    else if (filterTextRegEx <> '') and hideDisabledPromotions then
      Filter := '([Name] LIKE ' + filterTextRegEx + ' AND [Status] = ' + IntToStr(Ord(psEnabled)) + ') OR ' +
                '([Description] LIKE ' + filterTextRegEx + ' AND [Status] = ' + IntToStr(Ord(psEnabled)) + ')'
    else if (filterTextRegEx <> '') and (SiteCode <> -1) then
      Filter := '([Name] LIKE ' + filterTextRegEx + ' AND [SiteCode] = ' + IntToStr(SiteCode) + ') OR ' +
                '([Description] LIKE ' + filterTextRegEx + ' AND [SiteCode] = ' + IntToStr(SiteCode) + ')'
    else if hideDisabledPromotions and (SiteCode <> -1) then
      Filter := '([Status] = ' + IntToStr(Ord(psEnabled)) + ' AND [SiteCode] = ' + IntToStr(SiteCode) + ')'
    else if filterTextRegEx <> '' then
      Filter := '[Name] LIKE ' + filterTextRegEx + ' OR [Description] LIKE ' + filterTextRegEx
    else if hideDisabledPromotions then
      Filter := '[Status] = ' + IntToStr(Ord(psEnabled))
    else if  (SiteCode <> -1) then
      Filter := '[SiteCode] = ' + IntToStr(SiteCode);

    if Filter <> '' then
      Filtered := True;

    if Active and not(Eof and Bof) then
      Locate('SiteCode;PromotionID', VarArrayOf([bkMarkSiteCode,bkMarkPromoID]), []);
  end;
end;

procedure TdmPromotions.qEditPromoPortionPriceMappingCalculationValueGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
  inherited;
  if not varIsNull((Sender as TField).Value) then
    if DisplayText then
    begin
      if dmPromotions.qEditPromoPortionPriceMapping.FieldByName('CalculationType').AsInteger in [CalcType_PercentIncrease, CalcType_PercentDecrease] then
      begin
        Text := (Sender as TField).AsString + '%';
      end
      else begin
        Text := FormatCurr(CurrencyString+'######0.00', (Sender as TField).AsCurrency);
      end;
    end
    else
      Text := FormatFloat('######0.00', (Sender as TField).AsCurrency);
end;

procedure TdmPromotions.qEditPromoPortionPriceMappingCalculationValueSetText(
  Sender: TField; const Text: String);
begin
  inherited;
  (Sender as TField).AsFloat := RoundTo(StrToFloat(Text),-2);
end;

procedure TdmPromotions.qPromotionsCalcFields(DataSet: TDataSet);
begin
  inherited;

  qPromotionsCreatedOnThisSite.AsBoolean := (qPromotionsSiteCode.AsInteger = dmPromotions.SiteCode);
end;

procedure ValidatePriceKeyPress(var Key:Char;
  CurrentText: String;
  SelectionStart: Integer;
  SelectionLength: Integer;
  DecimalPosition: Integer;
  AllowNegative: boolean = true);
begin
  //valid numeric and edit keys only
  if not((Key in ['0'..'9', '.', '-']) or (ord(Key) in [VK_BACK, VK_DELETE, VK_ESCAPE, VK_LEFT, VK_RIGHT])) then
    Key := #0
  //only allow one minus character at beginning, if negative allowed at all
  else if (Key = '-') and (not(AllowNegative) or (SelectionStart <> 0)) then
    Key := #0
  //no more than one decimal
  else if (Key = '.')
    and ((    DecimalPosition <> 0)
          and not (     (DecimalPosition >= SelectionStart)
                    and (DecimalPosition <= (SelectionStart + SelectionLength))
                    and (SelectionLength > 0))) then
    Key := #0
  //no more than 2 decimal places
  else if (Key in ['0'..'9']) and (DecimalPosition <> 0)
    and (DecimalPosition <= (Length(CurrentText) - 2))
    and (SelectionLength = 0)
    and (DecimalPosition <= SelectionStart)  then
    Key := #0
  //no more than 5 digits before the decimal
  else if (Key in ['0'..'9']) and (DecimalPosition > 5) and (SelectionStart < DecimalPosition) and (SelectionLength =0) then
    Key := #0
  //limit the number of digits before the decimal
  else if (Key in ['0'..'9']) and (DecimalPosition = 0)
    and (Length(CurrentText) >= 5) and (SelectionLength =0) then
  begin
    Key := #0;
  end;
end;

procedure TdmPromotions.InsertMissingPromotionPriorities;
var
  query: TADOQuery;
  id, rowCount: Integer;
  olePlaceholder: OleVariant;
  SQL: String;
begin
  Log('Priority Templates', 'Adding missing promo priorities to existing templates');
  SQL := cmdAddMissingPromotionPriorities.CommandText;
  query := qPromotionPriorityTemplate;
  query.Open;
  query.First;
  while not query.Eof do
  begin
    id := query.FieldByName('Id').AsInteger;
    cmdAddMissingPromotionPriorities.CommandText :=
                StringReplace(SQL, '@TemplateID', IntToStr(Id), [rfReplaceAll, rfIgnoreCase]);
    rowCount := 0;
    olePlaceholder := 0; // command doesn't need any parameters, but we need an oleVariant to run correct overload
    cmdAddMissingPromotionPriorities.Execute(rowCount, olePlaceholder);
    Log('Priority Templates', Format('Added %d rows for ID %d', [rowCount, id]));
    query.next;
  end;
  query.Close;
  cmdAddMissingPromotionPriorities.CommandText := SQL;
end;

procedure TdmPromotions.qEditPromotionGroupsAfterScroll(DataSet: TDataSet);
begin
  inherited;

  qEditPromotionGroupsMakeChildrenFree.ReadOnly := qEditPromotionGroupsRecipeChildrenMode.Value = 0;

end;

procedure TdmPromotions.qEditPromotionGroupsRecipeChildrenModeChange(
  Sender: TField);
begin
  inherited;

  if qEditPromotionGroupsRecipeChildrenMode.Value = 0 then
  begin
    if qEditPromotionGroupsMakeChildrenFree.value then
    begin
      if qEditPromotionGroupsMakeChildrenFree.ReadOnly then
        qEditPromotionGroupsMakeChildrenFree.ReadOnly := FALSE;
      qEditPromotionGroupsMakeChildrenFree.value := FALSE;
    end;
    qEditPromotionGroupsMakeChildrenFree.ReadOnly := TRUE;
  end
  else
  begin
    qEditPromotionGroupsMakeChildrenFree.ReadOnly := FALSE;
  end;
end;

{ TGetDelayTarrifPricesThread }

procedure TGetDelayTarrifPricesThread.Cancel;
begin
  if ReturnValue < BACKGROUND_THREAD_COMPLETE then
  begin
    if Assigned(Command) then
      Command.Cancel;
  end
  //else
  //  self.Suspend;
end;

procedure TGetDelayTarrifPricesThread.Execute;
begin
  FreeOnTerminate := false;
  if not Assigned(Connection) then
  begin
    Connection := TADOConnection.Create(nil);
    SetUpAztecADOConnection(Connection);
  end;
  Command := TADOCommand.Create(nil);
  Command.Connection := Connection;
  Command.CommandTimeout := 0;


  Command.ExecuteOptions := [eoAsyncExecute, eoExecuteNoRecords];
  Command.CommandText := GetStringResource('TariffPricesPreload', 'TEXT');

  try
    Command.Execute;

      while Command.States - [stConnecting, stExecuting, stFetching] = [] do
        Sleep(50);
      PreloadStatus.TarrifPrices := True;
  except on E:EOLEException do
    begin
      // Use of AsyncExecute means no "cancel" exception gets raised
      // however the handling of this OLE exception has been left in, in case
      // we switch back to syncronous operation later.
      Log('Error', LowerCase(E.Message));
      
      if Pos('operation has been cancelled', LowerCase(E.Message)) = 0 then
        raise;
    end;
  end;

  (*
  while Command.States - [stConnecting, stExecuting, stFetching] = [] do
    Sleep(50);
  PreloadStatus.TarrifPrices := True;
  *)

  FreeAndNil(Command);
  //FreeAndNil(Connection);
  ReturnValue := BACKGROUND_THREAD_COMPLETE
end;

end.
