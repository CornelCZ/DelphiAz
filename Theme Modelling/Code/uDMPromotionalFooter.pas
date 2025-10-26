unit uDMPromotionalFooter;

interface

uses
  SysUtils, Classes, uDMThemeData, DB, ADODB, uDataTree, CheckLst;

const
  BACKGROUND_THREAD_COMPLETE = 100;
  RECEIPT_LINE_LENGTH = 40;
  RECEIPT_LINE_LENGTH_DOUBLE_WIDE = 20;

type
  TFooterStatus = (fsEnabled, fsDisabled);

  TPreloadCompleteFlags = record
    ProductTree, ConfigTree: boolean;
  end;

  TReadNamesThread = class(TThread)
  public
    Connection: TADOConnection;
    RecordSet: _Recordset;
    NamesArray: PNamesArray;
    CompletionStatus: PBoolean;
    procedure Execute; override;
  end;

  TGetProductsAndConfigThread = class(TThread)
  public
    Connection: TADOConnection;
    Command: TADOCommand;
    ConfigNamesThread: TReadNamesThread;
    ProductNamesThread: TReadNamesThread;
    procedure Execute; override;
    procedure Cancel;
    property ReturnValue;
  end;

  TdmPromotionalFooter = class(TDataModule)
    qPromotionalFooter: TADOQuery;
    dsPromotionalFooter: TDataSource;
    qPromotionalFooterId: TIntegerField;
    qPromotionalFooterName: TStringField;
    qPromotionalFooterDescription: TStringField;
    qPromotionalFooterPriority: TIntegerField;
    qPromotionalFooterSeparateFromReceipt: TBooleanField;
    qPromotionalFooterPrintFrequency: TIntegerField;
    qFooterStatus: TADOQuery;
    qFooterStatusId: TIntegerField;
    qFooterStatusName: TStringField;
    qPromotionalFooterStatus: TIntegerField;
    qPromotionalFooterStatusLookup: TStringField;
    qPromotionalFooterStartDate: TDateTimeField;
    qPromotionalFooterEndDate: TDateTimeField;
    qEditFooterSaleGroups: TADOQuery;
    dsEditFooterSaleGroups: TDataSource;
    qEditFooterSaleGroupsPromotionalFooterId: TIntegerField;
    qEditFooterSaleGroupsSaleGroupId: TSmallintField;
    qEditFooterSaleGroupsSaleGroupType: TWordField;
    dsFooterText: TDataSource;
    qFooterText: TADOQuery;
    qFooterTextLineNumber: TSmallintField;
    qFooterTextText: TWideStringField;
    qFooterTextBold: TBooleanField;
    qFooterTextDoubleSize: TBooleanField;
    qFooterSaleGroupType: TADOQuery;
    DataSource1: TDataSource;
    qEditFooterSaleGroupsSaleGrouptypeLookup: TStringField;
    qProcessSaleGroupDetail: TADOQuery;
    qEditFooterSaleGroupsProductGroupingId: TIntegerField;
    qProductBarcodes: TADOQuery;
    dsProductBarcodes: TDataSource;
    qProductBarcodesExtendedRTLName: TStringField;
    qProductBarcodesBarcode: TStringField;
    qPromotionalFooterBarcode: TStringField;
    qEditPromotionalFooter: TADOQuery;
    dsEditPromotionalFooter: TDataSource;
    qEditPromotionalFooterId: TIntegerField;
    qEditPromotionalFooterName: TStringField;
    qEditPromotionalFooterDescription: TStringField;
    qEditPromotionalFooterPriority: TIntegerField;
    qEditPromotionalFooterSeparateFromReceipt: TBooleanField;
    qEditPromotionalFooterPrintFrequency: TIntegerField;
    qEditPromotionalFooterStatus: TIntegerField;
    qEditPromotionalFooterStartDate: TDateTimeField;
    qEditPromotionalFooterEndDate: TDateTimeField;
    qEditPromotionalFooterBarcode: TStringField;
    qEditPromotionalFooterEPoSNotificationText: TStringField;
    qPromotions: TADOQuery;
    dsPromotions: TDataSource;
    qPromotionsPromotionID: TIntegerField;
    qPromotionsName: TStringField;
    qPromotionsDescription: TStringField;
    qPromotionsPromotionalFooterID: TIntegerField;
    qPromotionsStatus: TIntegerField;
    qPromotionsPromotionalFooterName: TStringField;
    qSiteFooterOverride: TADOQuery;
    dsSiteFooterOverride: TDataSource;
    qSiteFooterOverrideOverrideID: TIntegerField;
    qSiteFooterOverrideOverrideName: TStringField;
    qSiteFooterTextOverride: TADOQuery;
    dsSiteFooterTextOverride: TDataSource;
    qSiteFooterTextOverrideOverrideID: TIntegerField;
    qSiteFooterTextOverrideLineNumber: TSmallintField;
    qSiteFooterTextOverrideText: TWideStringField;
    qSiteFooterTextOverrideBold: TBooleanField;
    qSiteFooterTextOverrideDoubleSize: TBooleanField;
    qFootersWithOverrides: TADOQuery;
    qFooterOverrides: TADOQuery;
    dsFootersWithOverrides: TDataSource;
    qSalesAreaFooterOverride: TADOQuery;
    dsSalesAreaFooterOverride: TDataSource;
    qFootersWithOverridesPromotionalFooterId: TIntegerField;
    qFootersWithOverridesFooterName: TStringField;
    qFooterOverridesPromotionalFooterID: TIntegerField;
    qFooterOverridesOverrideID: TIntegerField;
    qFooterOverridesOverrideName: TStringField;
    qSalesAreaFooterOverridePromotionalFooterID: TIntegerField;
    qSalesAreaFooterOverrideSalesAreaID: TIntegerField;
    qSalesAreaFooterOverrideOverrideID: TIntegerField;
    qSalesAreaFooterOverrideSalesAreaName: TStringField;
    qSalesAreaFooterOverrideOverrideName: TStringField;
    qProductBarcodesCanSelect: TBooleanField;
    qEditFooterSaleGroupsValue: TFloatField;
    qCanOverridePromotionalFooter: TADOQuery;
    qAllOverrideSalesAreas: TADOQuery;
    qSiteFooterOverrideSiteCode: TIntegerField;
    qFooterTextAppendSurveyCode: TBooleanField;
    qSiteFooterTextOverrideAppendSurveyCode: TBooleanField;
    qPromotionalFooterPrintMultipleFooters: TBooleanField;
    qEditPromotionalFooterPrintMultipleFooters: TBooleanField;
    qPromotionalFooterPrintWithSlipType: TIntegerField;
    qPromotionalFooterCampaignID: TIntegerField;
    qEditPromotionalFooterCampaignID: TIntegerField;
    qSlipType: TADOQuery;
    dsSlipType: TDataSource;
    qSlipTypeId: TIntegerField;
    qSlipTypevalue: TStringField;
    qEditPromotionalFooterPrintWithSlipType: TIntegerField;
    qEditPromotionalFooterPrintVoucherCode: TBooleanField;
    qFooterTextAppendVoucherCode: TBooleanField;
    qSiteFooterTextOverrideAppendVoucherCode: TBooleanField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure qFooterTextDoubleSizeValidate(Sender: TField);
    procedure qFooterTextBeforeInsert(DataSet: TDataSet);
    procedure qFooterTextBeforePost(DataSet: TDataSet);
    procedure qFootersWithOverridesAfterScroll(DataSet: TDataSet);
    procedure qSiteFooterTextOverrideDoubleSizeValidate(Sender: TField);
    procedure qFooterTextTextValidate(Sender: TField);
    procedure qFooterTextAppendSurveyCodeValidate(Sender: TField);
    procedure qSiteFooterTextOverrideAppendSurveyCodeValidate(
      Sender: TField);
    procedure qSiteFooterTextOverrideTextValidate(Sender: TField);
    procedure qSlipTypevalueGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure qEditPromotionalFooterPrintWithSlipTypeChange(
      Sender: TField);
    procedure qFooterTextAppendVoucherCodeValidate(Sender: TField);
    procedure qSiteFooterTextOverrideAppendVoucherCodeValidate(
      Sender: TField);
  private
    { Private declarations }
    FHideDisabledPromotionalFooters: Boolean;

    FMainPromotionalFooterListFilter: string;
    FMainPromotionalFooterListFilterMidword: boolean;

    FHourglassOperationCount: integer;
    SurveyCodeLength : integer;

    procedure SetHideDisabledPromotionalFooters(const Value: Boolean);
    procedure LoadUserPreferences;
    procedure ApplyPromotionalFooterListFilter(Dataset: TDataset;
      filterText: string; midWordSearch,
      HideDisabledPromotionalFooters: boolean);
    procedure SaveUserSettings;
    function GetFilterText(text: string; MidwordSearch: boolean): string;
  public
    { Public declarations }
    GetProductsAndConfigThread: TGetProductsAndConfigThread;
    procedure AwaitPreload;
    procedure BeginHourglass;
    procedure EndHourglass;
    procedure DeleteDataForSaleGroup(SaleGroupID: integer);
    function ValidDaysDisplay(ValidDays: string): string;
    function ValidDaysStrFromCheckboxes(
      ValidDaysCheckboxes: TCheckListBox): string;
    procedure UpdatePromotionalFooterQuery;
    procedure DeleteDataForSiteFooterOverride(OverrideID: integer);
    procedure AddDataForSiteFooterOverride(OverrideID: integer);
    procedure ClearMainPromotionalFooterListFilter;
    procedure SetMainPromotionalFooterListFilter(const FilterText: string;
      MidwordSearch: boolean);
    procedure BackUpConfigTreeData;
    procedure FilterConfigTreeDataForSiteTags;
    procedure RemoveConfigTreeDataFilter;
    procedure updateMaxSurveyCodeLength;
    property HideDisabledPromotionalFooters: Boolean read  FHideDisabledPromotionalFooters
                                                     write SetHideDisabledPromotionalFooters;
  end;

var
  dmPromotionalFooter: TdmPromotionalFooter;
  PreloadStatus: TPreloadCompleteFlags;
  ProductNamesArray: TNamesArray;
  ConfigNamesArray: TNamesArray;

implementation

uses
  Registry, Windows, Forms, Controls, uPreloadWaitScreen, uAztecDatabaseUtils, useful,
  ComObj, StrUtils, Dialogs;

{$R *.dfm}

{ TdmPromotionalFooter }

procedure TdmPromotionalFooter.SetHideDisabledPromotionalFooters(
  const Value: Boolean);
begin
  if FHideDisabledPromotionalFooters <> Value then
  begin
    FHideDisabledPromotionalFooters := Value;
    ApplyPromotionalFooterListFilter(qPromotionalFooter, FMainPromotionalFooterListFilter, FMainPromotionalFooterListFilterMidword, FHideDisabledPromotionalFooters);
  end;
end;

procedure TdmPromotionalFooter.LoadUserPreferences;
begin
  // Load the hide disabled/sorting settings
  HideDisabledPromotionalFooters := True;
  try
    with TRegistry.Create do try
      RootKey := HKEY_CURRENT_USER;
      if OpenKeyReadOnly('Software\Zonal\Aztec\AZTM') then
      begin
        HideDisabledPromotionalFooters := ReadBool('HideDisabledPromotionalFooters');

        CloseKey;
      end;
    finally
      Free;
    end;
  except
  end;
end;

procedure TdmPromotionalFooter.SaveUserSettings;
begin
  // Save hide disabled/sorting settings for promotion list and exceptions list
  // within the promotion wizard
  try
    with TRegistry.Create do try
      RootKey := HKEY_CURRENT_USER;
      OpenKey('Software\Zonal\Aztec\AZTM', True);
      WriteBool('HideDisabledPromotionalFooters', FHideDisabledPromotionalFooters);

      CloseKey;
    finally
      Free;
    end;
  except
  end;
end;

//searching functionality might never be used, but leave for now
procedure TdmPromotionalFooter.ApplyPromotionalFooterListFilter(
  Dataset: TDataset;
  filterText: string;
  midWordSearch: boolean;
  HideDisabledPromotionalFooters: boolean);
var
  bkMark: integer;
  FilterTextModded: String;
begin
  bkMark := 0;

  with Dataset do
  begin
    if Active then
      bkMark := FieldByName('Id').AsInteger;

    Filtered := False;
    Filter := '';
    FilterTextModded := GetFilterText(filterText, midWordSearch);

    if (FilterTextModded <> '') and HideDisabledPromotionalFooters then
      Filter := '([Name] LIKE ' + FilterTextModded + ' AND [Status] = ' + IntToStr(Ord(fsEnabled)) + ') OR  ' +
                '([Description] LIKE ' + FilterTextModded + ' AND [Status] = ' + IntToStr(Ord(fsEnabled)) + ')'
    else if FilterTextModded <> '' then
      Filter := '[Name] LIKE ' + FilterTextModded + ' OR [Description] LIKE ' + FilterTextModded
    else if HideDisabledPromotionalFooters then
      Filter := '[Status] = ' + IntToStr(Ord(fsEnabled));

    if Filter <> '' then
      Filtered := True;

    if Active and not(Eof and Bof) then
      Locate('Id', bkMark, []);
  end;
end;

procedure TdmPromotionalFooter.DataModuleCreate(Sender: TObject);
const NAR_VAT = 1;
begin
  inherited;

  GetProductsAndConfigThread := TGetProductsAndConfigThread.Create(True);
  GetProductsAndConfigThread.Connection :=  TADOConnection.Create(nil);
  SetUpAztecADOConnection(GetProductsAndConfigThread.Connection);
  GetProductsAndConfigThread.Connection.OnWillExecute := dmThemeData.AztecConn.OnWillExecute;
  GetProductsAndConfigThread.Resume;

  LoadUserPreferences;

  //Initialise filters on promotion datasets.
  ApplyPromotionalFooterListFilter(qPromotionAlFooter, FMainPromotionalFooterListFilter, FMainPromotionalFooterListFilterMidword, FHideDisabledPromotionalFooters);

  qSlipType.Active := True;
end;

procedure TdmPromotionalFooter.DataModuleDestroy(Sender: TObject);
begin
  SaveUserSettings;
end;

procedure TdmPromotionalFooter.BeginHourglass;
begin
  if FHourglassOperationCount = 0 then
  begin
    Screen.Cursor := crHourglass;
  end;
  Inc(FHourglassOperationCount);
end;

procedure TdmPromotionalFooter.EndHourglass;
begin
  Dec(FHourglassOperationCount);
  if FHourglassOperationCount = 0 then
    Screen.Cursor := crDefault;
end;

procedure TdmPromotionalFooter.AwaitPreload;
var
  WindowList: pointer;
  TableExists : boolean;
  function PreloadComplete: boolean;
  begin
    Result := PreloadStatus.ProductTree and PreloadStatus.ConfigTree;
  end;

  function ProductTableExists : boolean;
  begin
    Result := False;
    with dmThemeData.adoqRun do
       begin
          SQL.Clear;
          SQL.Text := 'SELECT COUNT(*) AS TableCount ' +
                      '      FROM tempdb.sys.tables ' +
                      ' WHERE OBJECT_ID = OBJECT_ID(''tempdb..##ProductTree_Names'') ';
          Open;
          if FieldByName('TableCount').AsInteger > 0 then
             Result := True;
       end;
  end;
begin
  if not (PreloadComplete) then
  begin
    BeginHourglass;
    WindowList := nil;
    TableExists := ProductTableExists;
    with TPreloadWaitScreen.Create(nil) do try
      // Show form as a modal-style window
      WindowList := DisableTaskWindows(Handle);
      if TableExists and not PreloadStatus.ProductTree then
         lbLoadingMessage.Caption := 'Theme Modelling is currently in use by another user.' + #13#10 +
                                     'Promotional Footers is not available at this time.' + #13#10 +
                                     'Please try again later.'
      else
      if not TableExists and not PreloadStatus.ProductTree then
         lbLoadingMessage.Caption := 'Error loading Promotional Footers' + #13#10 +
                                     'Please restart Theme Modelling.'
      else
         lbLoadingMessage.Caption := 'Please wait while Site and Product data are pre-loaded';
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

procedure TdmPromotionalFooter.qFooterTextDoubleSizeValidate(Sender: TField);
var
  TotalLength: Integer;
begin
  TotalLength := Length(qFooterTextText.AsString);
  if qFooterTextAppendSurveyCode.AsBoolean then
    TotalLength := TotalLength + SurveyCodeLength;
  if (Sender.AsBoolean = TRUE) and (TotalLength > RECEIPT_LINE_LENGTH_DOUBLE_WIDE) then
  begin
    if qFooterTextAppendSurveyCode.AsBoolean then
      raise Exception.Create(Format('''Double Size'' can only be checked if there are %d or less characters in the text (inc. the %d character survey code).',[RECEIPT_LINE_LENGTH_DOUBLE_WIDE, SurveyCodeLength]))
    else
      raise Exception.Create(Format('''Double Size'' can only be checked if there are %d or less characters in the text.',[RECEIPT_LINE_LENGTH_DOUBLE_WIDE]));
  end
end;


//TReadNamesThread
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

//TGetProductsAndConfigThread
procedure TGetProductsAndConfigThread.Execute;
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
    if Pos('operation has been cancelled', LowerCase(E.Message)) = 0 then
      raise;
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

  while (PreloadStatus.ProductTree = False) or (PreloadStatus.ConfigTree = False) do
    Sleep(20);

  FreeAndNil(ProductNamesThread);
  FreeAndNil(ConfigNamesThread);

  FreeAndNil(Command);
  //FreeAndNil(Connection);
  ReturnValue := BACKGROUND_THREAD_COMPLETE
end;

procedure TGetProductsAndConfigThread.Cancel;
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

procedure TdmPromotionalFooter.qFooterTextBeforeInsert(DataSet: TDataSet);
begin
  if (qFooterText.RecordCount > 29) then
     abort;
end;

procedure TdmPromotionalFooter.DeleteDataForSaleGroup(SaleGroupID: integer);
begin
  with TADOQuery.Create(nil) do
  begin
    Connection := dmThemeData.AztecConn;
    SQL.Text := Format(
      'DELETE #PromotionalFooterSaleGroup where SaleGroupID = %0:d '+
      'DELETE #PromotionalFooterSaleGroupDetail where SaleGroupID = %0:d '+
      'UPDATE #PromotionalFooterSaleGroup set SaleGroupID = SaleGroupID -1 where SaleGroupID > %0:d '+
      'UPDATE #PromotionalFooterSaleGroupDetail set SaleGroupID = SaleGroupID -1 where SaleGroupID > %0:d'
      , [SaleGroupID]);
    ExecSQL;
    Free;
  end;
end;

// Return a string representation that corresponds to the days of the week that are
// selected on the 'Activation Details' page of the promotion wizards.
// '1' = Monday,... '7' = Sunday. E.g. if Monday and Friday are selected this function will return '15'
function TdmPromotionalFooter.ValidDaysStrFromCheckboxes(ValidDaysCheckboxes: TCheckListBox): string;
var day: integer;
begin
  Result := '';
  for day := 1 to 7 do
    if ValidDaysCheckboxes.Checked[day-1] then
    begin
      Result := Result + IntToStr(day);
    end;
end;

function TdmPromotionalFooter.ValidDaysDisplay(ValidDays: string): string;
const DAY_NAME: array[1..7] of string = ('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun');
var
  ValidDaysDisplay: string;
  i: integer;
  MaxIndex: integer;
begin
  ValidDaysDisplay := '';

  i := 1;
  while i < 8 do
  begin
    if Pos(IntToStr(i), ValidDays) <> 0 then
    begin
      MaxIndex := i;
      while MaxIndex < 8 do
      begin
        if Pos(InttoStr(MaxIndex+1), ValidDays) = 0 then
          break;
        inc(MaxIndex);
      end;

      if (i <> MaxIndex) then
      begin
        ValidDaysDisplay := ValidDaysDisplay +
          Format('%s-%s,', [DAY_NAME[i], DAY_NAME[MaxIndex]]);
        i := MaxIndex+1;
      end
      else
        ValidDaysDisplay := ValidDaysDisplay + Format('%s,', [DAY_NAME[i]]);
    end;
    i := i + 1;
  end;

  Result := Copy(ValidDaysDisplay, 1, Length(ValidDaysDisplay)-1);
end;

procedure TdmPromotionalFooter.UpdatePromotionalFooterQuery;
var
  BMark: integer;
begin
  BMark := qPromotionalFooter.FieldByName('Id').AsInteger;
  qPromotionalFooter.Requery;
  qPromotionalFooter.Locate('Id', BMark, []);
end;

procedure TdmPromotionalFooter.qFooterTextBeforePost(DataSet: TDataSet);
begin
 if (qFooterTextText.AsString = '') and not (qFooterTextAppendSurveyCode.AsBoolean or qFooterTextAppendVoucherCode.AsBoolean) then
 begin
   qFooterTextBold.AsBoolean := FALSE;
   qFooterTextDoubleSize.AsBoolean := FALSE;
 end;
end;

procedure TdmPromotionalFooter.DeleteDataForSiteFooterOverride(OverrideID: integer);
begin
  with TADOQuery.Create(nil) do
  begin
    Connection := dmThemeData.AztecConn;
    SQL.Text := Format(
      'DELETE #SitePromotionalFooterOverride where OverrideID = %0:d '+
      'DELETE #SitePromotionalFooterTextOverride where OverrideID = %0:d '
//      'DELETE #SitePromotionalFooterOverrideSAMap where OverrideID = %0:d '+
//      'UPDATE #SitePromotionalFooterOverride set OverrideID = OverrideID -1 where OverrideID > %0:d '+
//      'UPDATE #SitePromotionalFooterTextOverride set OverrideID = OverrideID -1 where OverrideID > %0:d '+
//      'UPDATE #SitePromotionalFooterOverrideSAMap set OverrideID = OverrideID -1 where OverrideID > %0:d'
      , [OverrideID]);
    ExecSQL;
    Free;
  end;
end;

procedure TdmPromotionalFooter.AddDataForSiteFooterOverride(OverrideID: integer);
begin
  with dmThemeData.adoqRun do
  begin
    SQL.Clear;
    SQL.Add('insert #SitePromotionalFooterTextOverride (SiteCode, OverrideID, LineNumber, [Text], Bold, DoubleSize, AppendSurveyCode, AppendVoucherCode)');
    SQL.Add(Format('select -1, %d, Linenumber, [Text], Bold, DoubleSize, AppendSurveyCode, AppendVoucherCode',[OverrideID]));
    SQL.Add('from #PromotionalFooterText');
    ExecSQL;
  end;
end;

procedure TdmPromotionalFooter.qFootersWithOverridesAfterScroll(
  DataSet: TDataSet);
begin
  qSalesAreaFooterOverride.Active := False;
  qFooterOverrides.Active := False;
  qFooterOverrides.SQL[1] :=
    Format('SET @PromotionalFooterID = %d', [qFootersWithOverrides.FieldByName('PromotionalFooterId').AsInteger]);
  qFooterOverrides.Active := TRUE;
  qSalesAreaFooterOverride.Active := TRUE;
end;

procedure TdmPromotionalFooter.qSiteFooterTextOverrideDoubleSizeValidate(
  Sender: TField);
var
  TotalLength: Integer;
begin
  TotalLength := Length(qSiteFooterTextOverrideText.AsString);
  if qSiteFooterTextOverrideAppendSurveyCode.AsBoolean then
    TotalLength := TotalLength + SurveyCodeLength;
  if (Sender.AsBoolean = TRUE) and (TotalLength > RECEIPT_LINE_LENGTH_DOUBLE_WIDE) then
  begin
    if qSiteFooterTextOverrideAppendSurveyCode.AsBoolean then
      raise Exception.Create(Format('''Double Size'' can only be checked if there are %d or less characters in the text (inc. the %d character survey code).',[RECEIPT_LINE_LENGTH_DOUBLE_WIDE, SurveyCodeLength]))
    else
      raise Exception.Create(Format('''Double Size'' can only be checked if there are %d or less characters in the text.',[RECEIPT_LINE_LENGTH_DOUBLE_WIDE]));
  end
end;

procedure TdmPromotionalFooter.SetMainPromotionalFooterListFilter(const FilterText: string; MidwordSearch: boolean);
begin
  if (FMainPromotionalFooterListFilter <> FilterText) or (FMainPromotionalFooterListFilterMidword <> MidwordSearch) then
  begin
    FMainPromotionalFooterListFilter := FilterText;
    FMainPromotionalFooterListFilterMidword := MidwordSearch;
    ApplyPromotionalFooterListFilter(qPromotionalFooter, FMainPromotionalFooterListFilter, FMainPromotionalFooterListFilterMidword, FHideDisabledPromotionalFooters);
  end;
end;

procedure TdmPromotionalFooter.ClearMainPromotionalFooterListFilter;
begin
  if FMainPromotionalFooterListFilter <> '' then
  begin
    FMainPromotionalFooterListFilter := '';
    ApplyPromotionalFooterListFilter(qPromotionalFooter, FMainPromotionalFooterListFilter, FMainPromotionalFooterListFilterMidword, FHideDisabledPromotionalFooters);
  end;
end;

function TdmPromotionalFooter.GetFilterText(text: string; MidwordSearch: boolean): string;
begin
  if text = '' then
  begin
    Result := ''
  end
  else
  begin
    //Filtering for text beginning with either of the wildcard characters (i.e. Filter = '%%' or '*%') results in an error.
    //Instead prefix with a '%' which results in a midword search for the character (i.e. Filter = '%%%' or '%*%') so
    //at least it doesn't crash.
    //if not(MidwordSearch) and ((text = '*') or (text = '%')) then
    //  text := '%' + text;

    //Filtering with text that contains apostrophes will fail unless we escape them properly
    text := StringReplace(text,'''','''''',[rfReplaceAll, rfIgnoreCase]);

    Result := '''' + IfThen(MidwordSearch, '%') + text + '%''';
  end;
end;

procedure TdmPromotionalFooter.qFooterTextTextValidate(Sender: TField);
var
  TotalLength: Integer;
begin
  TotalLength := Length(Sender.AsString);
  if qFooterTextAppendSurveyCode.AsBoolean then
    TotalLength := TotalLength + SurveyCodeLength;
  if (TotalLength > RECEIPT_LINE_LENGTH_DOUBLE_WIDE) and qFooterText.FieldByName('DoubleSize').AsBoolean  then
  begin
    if qFooterTextAppendSurveyCode.AsBoolean then
      raise Exception.Create(Format('Only %d characters can be entered when ''Double Size'' is checked (inc. the %d character survey code).',[RECEIPT_LINE_LENGTH_DOUBLE_WIDE, SurveyCodeLength]))
    else
      raise Exception.Create(Format('Only %d characters can be entered when ''Double Size'' is checked.',[RECEIPT_LINE_LENGTH_DOUBLE_WIDE]));
  end;
end;

procedure TdmPromotionalFooter.qFooterTextAppendSurveyCodeValidate(
  Sender: TField);
var
  LineLimit: Integer;
  AvailableSpaces: Integer;
begin
  if qFooterTextAppendVoucherCode.AsBoolean then
  begin
      raise Exception.Create('A voucher code has already been assigned to this line.'#13#10
        + 'Survey codes may not be appended to lines containing voucher codes.');
  end
  else begin
    LineLimit := RECEIPT_LINE_LENGTH;
    if qFooterTextDoubleSize.AsBoolean then
      Linelimit := RECEIPT_LINE_LENGTH_DOUBLE_WIDE;

    AvailableSpaces := LineLimit - Length(qFooterTextText.AsString);

    if (Sender.AsBoolean = TRUE) and ((SurveyCodeLength > AvailableSpaces)) then
      raise Exception.Create(Format('Insufficient space to append the survey code.  Required: %d. Available: %d.',[SurveyCodeLength,AvailableSpaces]));
  end;
end;

procedure TdmPromotionalFooter.qSiteFooterTextOverrideAppendSurveyCodeValidate(
  Sender: TField);
var
  LineLimit: Integer;
  AvailableSpaces: Integer;
begin
  if qSiteFooterTextOverrideAppendVoucherCode.AsBoolean then
  begin
      raise Exception.Create('A voucher code has already been assigned to this line.'#13#10
        + 'Survey codes may not be appended to lines containing voucher codes.');
  end
  else begin
    LineLimit := RECEIPT_LINE_LENGTH;
    if qSiteFooterTextOverrideDoubleSize.AsBoolean then
      Linelimit := RECEIPT_LINE_LENGTH_DOUBLE_WIDE;

    AvailableSpaces := LineLimit - Length(qSiteFooterTextOverrideText.AsString);

    if (Sender.AsBoolean = TRUE) and (SurveyCodeLength > AvailableSpaces) then
      raise Exception.Create(Format('Insufficient space to append the survey code.  Required: %d. Available: %d.',[SurveyCodeLength,AvailableSpaces]));
  end;
end;

procedure TdmPromotionalFooter.qSiteFooterTextOverrideTextValidate(
  Sender: TField);
var
  TotalLength: Integer;
begin
  TotalLength := Length(Sender.AsString);
  if qSiteFooterTextOverrideAppendSurveyCode.AsBoolean then
    TotalLength := TotalLength + SurveyCodeLength;
  if (TotalLength > RECEIPT_LINE_LENGTH_DOUBLE_WIDE) and qSiteFooterTextOverride.FieldByName('DoubleSize').AsBoolean  then
  begin
    if qSiteFooterTextOverrideAppendSurveyCode.AsBoolean then
      raise Exception.Create(Format('Only %d characters can be entered when ''Double Size'' is checked (inc. the %d character survey code).',[RECEIPT_LINE_LENGTH_DOUBLE_WIDE,SurveyCodeLength]))
    else
      raise Exception.Create(Format('Only %d characters can be entered when ''Double Size'' is checked.',[RECEIPT_LINE_LENGTH_DOUBLE_WIDE]));
  end;
end;

procedure TdmPromotionalFooter.BackUpConfigTreeData;
begin
  with dmThemeData.adoqRun do
  begin
    SQL.Text :=
      'IF OBJECT_ID(''tempdb..#BkConfigTreeData'') IS NOT NULL DROP TABLE dbo.#BkConfigTreeData ' +
      'SELECT * INTO #BkConfigTreeData FROM ##ConfigTree_data';
    ExecSQL;
  end;
end;

procedure TdmPromotionalFooter.FilterConfigTreeDataForSiteTags;
begin
  with dmThemeData.adoqRun do
  begin
    SQL.Text := 'DELETE ##ConfigTree_data ';
    ExecSQL;
    SQL.Text :=
      'INSERT ##ConfigTree_data ' +
      'SELECT DISTINCT a.* ' +
      'FROM ' +
      '  #BkConfigTreeData a ' +
      'INNER JOIN ' +
      '  (SELECT b.SiteId ' +
      '   FROM ac_SiteTag b ' +
      '   INNER JOIN ' +
      '     #Tags t on t.TagId = b.TagId) c ' +
      '  ON c.SiteId = a.Level3ID ';
    ExecSQL;
  end;
end;

procedure TdmPromotionalFooter.RemoveConfigTreeDataFilter;
begin
  with dmThemeData.adoqRun do
  begin
    SQL.Text :=
      'DELETE ##ConfigTree_data ' +
      'INSERT ##ConfigTree_data ' +
      'SELECT * FROM #BkConfigTreeData';
    ExecSQL;
  end;
end;

procedure TdmPromotionalFooter.updateMaxSurveyCodeLength;
begin
  with dmThemeData.adoqRun do
  begin
    Close;
    SQL.Text :=
      'select MAX(snt.MaximumCodeLength) as LongestCode ' +
      'from #PromotionalFooterSalesArea pfsa ' +
      'inner join ac_SalesArea sa ' +
      'on pfsa.SalesAreaId = sa.Id ' +
      'inner join ThemeOutletConfigs oc ' +
      'on sa.SiteId = oc.SiteCode ' +
      'inner join ThemeAppendSurveyNumberTypeLookup snt ' +
      'on oc.SurveyCodeSupplier = snt.Id';
    Open;
    SurveyCodeLength := FieldByName('LongestCode').AsInteger;
  end;
end;

procedure TdmPromotionalFooter.qSlipTypevalueGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if DisplayText then
  begin
    Text := LowerCase((Sender as TField).AsString);
    Text[1] := UpCase(Text[1]);
  end;
end;

procedure TdmPromotionalFooter.qEditPromotionalFooterPrintWithSlipTypeChange(
  Sender: TField);
begin
  if (Sender as TField).Value = 0 then
  begin
    MessageDlg('Selecting ''Bill'' will result in the promotional footer printing on every print and reprint of the bill.',
      mtWarning, [mbOK], 0); 
  end;
end;

procedure TdmPromotionalFooter.qFooterTextAppendVoucherCodeValidate(
  Sender: TField);
var
  UsedSpaces: Integer;
begin
  UsedSpaces := Length(qFooterTextText.AsString);

  if qFooterTextAppendSurveyCode.AsBoolean or (UsedSpaces > 0) then
    raise Exception.Create('Insufficient space to append the voucher code.  Voucher codes should occupy a line exclusively.');
end;

procedure TdmPromotionalFooter.qSiteFooterTextOverrideAppendVoucherCodeValidate(
  Sender: TField);
var
  UsedSpaces: Integer;
begin
  UsedSpaces := Length(qSiteFooterTextOverrideText.AsString);

  if qSiteFooterTextOverrideAppendSurveyCode.AsBoolean or (UsedSpaces > 0) then
    raise Exception.Create('Insufficient space to append the voucher code.  Voucher codes should occupy a line exclusively.');
end;

end.
