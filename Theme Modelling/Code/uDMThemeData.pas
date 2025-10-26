unit uDMThemeData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dADOAbstract, ADODB, DB, useful;

type
  TSnapToType = (sttNone, sttLeft, sttTop, sttRight, sttBottom, sttLeftRight, sttCentreScreen);

  TdmThemeData = class(TdmADOAbstract)
    qThemes: TADOQuery;
    dsThemes: TDataSource;
    qPanelDesigns: TADOQuery;
    dsPanelDesigns: TDataSource;
    qPanelDesignType: TADOQuery;
    qPanelDesignsPanelDesignID: TIntegerField;
    qPanelDesignsThemeId: TIntegerField;
    qPanelDesignsPanelDesignType: TWordField;
    qPanelDesignsName: TStringField;
    qPanelDesignsDescription: TStringField;
    qPanelDesignsRoot: TLargeintField;
    qPanelDesignsCorrectAccount: TLargeintField;
    qPanelDesignsPay: TLargeintField;
    qPanelDesignsDesignType: TStringField;
    qThemeTablePlans: TADOQuery;
    dsThemeTablePlans: TDataSource;
    qOutlets: TADOQuery;
    dsOutlets: TDataSource;
    qOutletTablePlans: TADOQuery;
    dsOutletTablePlans: TDataSource;
    qSharedPanels: TADOQuery;
    dsSharedPanels: TDataSource;
    qSitesInTheme: TADOQuery;
    qSitesNotInTheme: TADOQuery;
    dsSitesInTheme: TDataSource;
    dsSitesNotInTheme: TDataSource;
    qSitesNotInThemeSiteCode: TSmallintField;
    qSitesNotInThemeSiteName: TStringField;
    qSitesInThemeSiteCode: TSmallintField;
    qSitesInThemeSiteName: TStringField;
    qThemesThemeId: TIntegerField;
    qThemesName: TStringField;
    qThemesDescription: TStringField;
    tThemeSites: TADOTable;
    qClearOutletMappings: TADOQuery;
    qOutletsSiteCode: TSmallintField;
    qOutletsReferenceCode: TStringField;
    qOutletsName: TStringField;
    qOutletTerminals: TADOQuery;
    qOutletTerminalsname: TStringField;
    qOutletTerminalspaneldesignid: TIntegerField;
    qOutletTerminalsdefaultpanelid: TIntegerField;
    qOutletTerminalspd_displayname: TStringField;
    qPanelNames: TADOQuery;
    qOutletTerminalsdefault_panel_name: TStringField;
    dsOutletTerminals: TDataSource;
    qSharedPanelDims: TADOQuery;
    sp_SharedPanelDimensionsOK: TADOStoredProc;
    qOutletTerminalsSetDefs: TADOQuery;
    StringField1: TStringField;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    StringField2: TStringField;
    StringField3: TStringField;
    qThemesIdleTime: TIntegerField;
    qUpdateNewSiteConfigs: TADOQuery;
    qConfigSets: TADOQuery;
    dsConfigSets: TDataSource;
    qConfigSetDivisions: TADOQuery;
    dsConfigSetDivisions: TDataSource;
    qConfigSetCheckDivisions: TADOQuery;
    dsDivisionNames: TDataSource;
    qDivisionNames: TADOQuery;
    qConfigSetDivisionsConfigSetID: TIntegerField;
    qConfigSetDivisionsDivisionID: TIntegerField;
    qConfigSetDivisionsCanPayOnBarAccount: TBooleanField;
    qConfigSetDivisionsCanSaveOnBarAccount: TBooleanField;
    qConfigSetDivisionsDivisionName: TStringField;
    qConfigSetDivisionsAutoPrintReceipt: TBooleanField;
    qConfigSetSubcat: TADOQuery;
    dsConfigSetSubcat: TDataSource;
    qConfigSetSubcatConfigSetID: TIntegerField;
    qConfigSetSubcatSubcategoryID: TIntegerField;
    qConfigSetSubcatHotelDivision: TIntegerField;
    qHotelDivisions: TADOQuery;
    qSubcategories: TADOQuery;
    dsHotelDivisions: TDataSource;
    qConfigSetSubcatSubCategoryName: TStringField;
    qConfigSetSubcatHotelDivisionName: TStringField;
    qHotelDivisionsHotelDivisionID: TIntegerField;
    qHotelDivisionsName: TStringField;
    qHotelDivsCombo: TADOQuery;
    IntegerField3: TIntegerField;
    StringField4: TStringField;
    ADOqryUpdateLastThemeSend: TADOQuery;
    qKitchenScreenType: TADOQuery;
    qConfigSetsConfigSetID: TIntegerField;
    qConfigSetsName: TStringField;
    qConfigSetsAutoClose: TBooleanField;
    qConfigSetsAutoCloseTime: TStringField;
    qConfigSetsAutoDeclare: TBooleanField;
    qConfigSetsUseLogOnPassword: TBooleanField;
    qConfigSetsPrintSplitBillOnSave: TBooleanField;
    qConfigSetsBarUseCoverCount: TBooleanField;
    qConfigSetsBarUseCustomerName: TBooleanField;
    qConfigSetsPrintReceiptByDefault: TBooleanField;
    qConfigSetsValidateBarAccounts: TBooleanField;
    qConfigSetsValidateNonPerSeatTableAccounts: TBooleanField;
    qConfigSetsPrintTipLineOnEFTReceipt: TBooleanField;
    qConfigSetsUseDrawerAssignment: TBooleanField;
    qConfigSetsShowChangeAndTip: TBooleanField;
    qConfigSetsShowProductNameIfSerial: TBooleanField;
    qConfigSetsCashbackAllowedOnBarAccounts: TBooleanField;
    qConfigSetsCashbackAllowedOnPerSeatTableAccounts: TBooleanField;
    qConfigSetsCashbackAllowedOnNonPerSeatTableAccounts: TBooleanField;
    qConfigSetsValidateCustomerAge: TBooleanField;
    qConfigSetsKitchenScreenType: TSmallintField;
    qConfigSetsKitchenScreenTypeName: TStringField;
    qConfigSetsGraphicID: TIntegerField;
    qConfigSetsForcedSelection: TBooleanField;
    qTerminalGraphicsWithDefault: TADOQuery;
    qConfigSetsGraphicIDDisplay: TStringField;
    qSharedPanelVariations: TADOQuery;
    dsSharedPanelVariations: TDataSource;
    qEditSiteVariations: TADOQuery;
    dsEditSiteVariations: TDataSource;
    qEditSiteVariationsSiteCode: TIntegerField;
    qEditSiteVariationsSiteName: TStringField;
    qEditSiteVariationsSiteRef: TStringField;
    qEditSiteVariationsAreaName: TStringField;
    qSetDefaultEposDesign: TADOQuery;
    StringField5: TStringField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    StringField6: TStringField;
    StringField7: TStringField;
    qSharedPanelDefault: TADOQuery;
    dsSharedPanelDefault: TDataSource;
    qDefaultChoices: TADOQuery;
    qSetDefaultSPPos: TADOQuery;
    StringField8: TStringField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    StringField9: TStringField;
    StringField10: TStringField;
    dsConfigSetDestinations: TDataSource;
    qConfigSetDestinations: TADOQuery;
    qConfigSetDestinationsConfigSetID: TIntegerField;
    qConfigSetDestinationsUseDestination: TBooleanField;
    qConfigSetDestinationsIsDefault: TBooleanField;
    qDestinations: TADOQuery;
    qConfigSetDestinationsDestinationName: TStringField;
    qConfigSetCheckOrderDestinations: TADOQuery;
    qConfigSetDestinationsOrderDestination: TIntegerField;
    qConfigSetsDisplayDestinations: TBooleanField;
    qConfigSetsSendAllBarcodedProducts: TBooleanField;
    qConfigSetsDriveThruAllowCashBack: TBooleanField;
    qConfigSetsPrintValidationSlip: TBooleanField;
    qConfigSetsValidatePerSeatTableAccounts: TBooleanField;
    qMacros: TADOQuery;
    qMacrosMacroID: TIntegerField;
    qMacrosPanelDesignID: TIntegerField;
    qMacrosName: TStringField;
    qMacrosDescription: TStringField;
    qMacrosEposName1: TStringField;
    qMacrosEposName2: TStringField;
    qMacrosEposName3: TStringField;
    dsMacros: TDataSource;
    qConfigSetsPerSeatTableUseCoverCount: TBooleanField;
    qConfigSetsPerSeatTableUseCustomerName: TBooleanField;
    qConfigSetsNonPerSeatTableUseCustomerName: TBooleanField;
    qConfigSetsNonPerSeatTableUseCoverCount: TBooleanField;
    qConfigSetsUseLargeChangePrompt: TBooleanField;
    qConfigSetsUseFastEFT: TBooleanField;
    qConfigSetsKitchenScreenRedirectToBillReceiptPrinter: TBooleanField;
    qHotelDivisionsDescription: TStringField;
    qHotelAnalysisCodes: TADOQuery;
    dsHotelAnalysisCodes: TDataSource;
    qHotelAnalysisCodesID: TIntegerField;
    qHotelAnalysisCodesCode: TStringField;
    qHotelAnalysisCodesSiteID: TIntegerField;
    qHotelAnalysisCodesPackage: TStringField;
    qConfigSetsConversationalRecipesEnabled: TBooleanField;
    qConfigSetsConversationalRecipesAutoAdvance: TBooleanField;
    qPanelDesignsDefaultPay: TLargeintField;
    qConfigSetsHighlightAccountNumber: TBooleanField;
    qConfigSetsUseAccountNumber: TBooleanField;
    qCheckConvWidth: TADOQuery;
    qConfigSetsRemoveChoiceAnd: TBooleanField;
    qConfigSetsRemoveChoiceMessage: TBooleanField;
    qThemeCloakroomImage: TADOQuery;
    qThemeCloakroomImageCloakroomImageID: TIntegerField;
    qThemeCloakroomImageThemeID: TIntegerField;
    qThemeCloakroomImageName: TStringField;
    qThemeCloakroomImageBitmap: TBlobField;
    qThemeCloakroomImageBitmapSize: TIntegerField;
    dsThemeCloakroomImage: TDataSource;
    dsTotalImageSize: TDataSource;
    qTotalImageSize: TADOQuery;
    qTotalImageSizeTotalImageSize: TLargeintField;
    qThemeCloakroomImageThemeImageIndex: TIntegerField;
    qThemeCloakroomImageImageControlCode: TStringField;
    qConfigSetsOnlyDisplayDrawerChange: TBooleanField;
    qScaleContainer: TADOQuery;
    dsScaleContainer: TDataSource;
    qScaleContainerContainerId: TIntegerField;
    qScaleContainerName: TStringField;
    qScaleContainerDescription: TStringField;
    qScaleContainerTareWeight: TFloatField;
    qPanelDesignsScreenInterfaceID: TSmallintField;
    qConfigSetsAllowReopeningOfYesterdaysAccounts: TBooleanField;
    qConfigSetsRecordBarcodeUsage: TBooleanField;
    qConfigSetsLookUp: TADOQuery;
    qConfigSetsLookUpConfigSetID: TIntegerField;
    qConfigSetsLookUpName: TStringField;
    qKitchenScreenMessageSentWhenOrderSaved: TADOQuery;
    qConfigSetsPerSeatTableAutoServiceCharge: TBooleanField;
    qConfigSetsBarAutoServiceCharge: TBooleanField;
    qConfigSetsNonPerSeatTableAutoServiceCharge: TBooleanField;
    qConfigSetsEnableAdMargin: TBooleanField;
    qConfigSetsReceiptBreakdownByHotelDivision: TBooleanField;
    qConfigSetsOpenDrawerOnFinalPayOnly: TBooleanField;
    qInitZcpsConfigs: TADOQuery;
    qEditZcpsConfigs: TADOQuery;
    IntegerField8: TIntegerField;
    StringField11: TStringField;
    StringField12: TStringField;
    StringField13: TStringField;
    dsEditZcpsConfigs: TDataSource;
    qInitZcpsConfigsGetSummary: TADOQuery;
    qConfigSetsDisableAllButtonsWhenDrawerOpen: TBooleanField;
    qCustomerInformationPrompts: TADOQuery;
    dsCustomerInformationPrompts: TDataSource;
    qConfigSetsCustomerInformationPrompt: TIntegerField;
    qConfigSetsCustomerInformationPromptText: TStringField;
    qCustomerInformationPromptsid: TIntegerField;
    qCustomerInformationPromptsPromptText: TStringField;
    qCustomerInformationPromptsMaximumEntryLength: TIntegerField;
    qCustomerInformationPromptLookup: TADOQuery;
    dsCustomerInformationPromptLookup: TDataSource;
    qCustomerInformationPromptLookupid: TIntegerField;
    qCustomerInformationPromptLookupPromptText: TStringField;
    qConfigSetsUsesPosPrinting: TBooleanField;
    qConfigSetsPrintPriceEmbeddedBarcode: TBooleanField;
    qConfigSetsEnableKeyboardSupport: TBooleanField;
    qConfigSetsAutoThemeSendToBlankTerminals: TBooleanField;
    qConfigSetsAllowCharityDonations: TBooleanField;
    qConfigSetsShowExchangeRateOnReceipt: TBooleanField;
    qConfigSetsPromptForReasonOnTableMove: TBooleanField;
    qConfigSetsPromptForReasonOnTableMerge: TBooleanField;
    qConfigSetsPromptForReasonOnAccountMove: TBooleanField;
    qConfigSetsPromptForReasonOnAccountMerge: TBooleanField;
    qConfigSetsShowExchangeRateOnBill: TBooleanField;
    qConfigSetsEnableTillCameraScanning: TBooleanField;
    qConfigSetsPrintAllOrderLinesOnBillAndReceipt: TBooleanField;
    qConfigSetsPromptToRedeemBookingOnStartTable: TBooleanField;
    qConfigSetsi700CheckDrawerStatusBeforeOpening: TBooleanField;
    procedure qOutletTerminalspaneldesignidChange(Sender: TField);
    procedure qOutletTerminalsBeforeInsert(DataSet: TDataSet);
    procedure qOutletTerminalsBeforeDelete(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject); override;
    procedure qThemesAfterOpen(DataSet: TDataSet);
    procedure qConfigSetsAfterOpen(DataSet: TDataSet);
    procedure qConfigSetsConversationalRecipesEnabledChange(
      Sender: TField);
    procedure qConfigSetsDisableAllButtonsWhenDrawerOpenChange(
      Sender: TField);
    procedure qConfigSetsUseDrawerAssignmentEnabledChange(
      Sender: TField);
    procedure qConfigSetsAfterScroll(DataSet: TDataSet);
    procedure qThemeCloakroomImageCalcFields(DataSet: TDataSet);
    procedure qConfigSetsBeforeEdit(DataSet: TDataSet);
    procedure qConfigSetsBeforePost(DataSet: TDataSet);
    procedure dsEditZcpsConfigsDataChange(Sender: TObject; Field: TField);
    procedure qCustomerInformationPromptsMaximumEntryLengthSetText(
      Sender: TField; const Text: String);
    procedure qCustomerInformationPromptsPromptTextSetText(Sender: TField;
      const Text: String);
    procedure updateCustomerInformationPromptLookup(DataSet: TDataSet);
  private
    { Private declarations }
    HourglassOperationCount: integer;
    oldConfigSetName : string;
    CongfigSetIdMultiDrawerModeList: TStringList;
    procedure CloseTimeValidate(Sender: TField);
  public
    { Public declarations }
    RolloverTime: TDateTime;
    SiteVersionString: string;
    SiteVersionArray: array[0..3] of Integer;

    procedure SetBaseEditSiteVersion;
    function SiteVersionAtLeast(version: string): boolean;

    procedure AccessDataset(datasetname: string); overload;
    procedure AccessDataset(dset: TDataSet); overload;

    procedure DeAccessDataset(datasetname: string; postDataset : boolean = false); overload;
    procedure DeAccessDataset(dset: TDataSet; postDataset : boolean = false); overload;
    procedure InsertThemeSite;
    function GetStoredMetrics(form: TForm; positiononly: boolean): boolean; overload;
    function GetStoredMetrics(form: TForm; positiononly: boolean; SnapToType: TSnapToType): boolean; overload;
    function GetStoredMetrics(form: TForm; positiononly: boolean; SnapToForm: TForm; SnapToType: TSnapToType): boolean; overload;
    procedure StoreMetrics(form: TForm; positiononly: boolean);
    procedure InsertDefaultSharedPanelPos(PanelID : Int64);
    procedure NewForcedSelectionPanel(PanelDesignID : Integer);
    procedure DeleteForcedSelectionPanel(PanelDesignID: Integer);
    function GetForcedSelectionPanelID(PanelDesignID: Integer): LongInt;
    function IsForcedSelectionPanel(PanelID: Integer): Boolean;
    function CheckPanelNameUnique(PanelID: integer; NewName: string; IsVariation: boolean; LocalPanelDesignOrVariationGroupID: integer = -1): boolean;
    procedure BeginHourglass;
    procedure EndHourglass;
    procedure GetPreviewDetails(SiteCode, SalesAreaCode, POSCode, PanelDesignID: integer;
      var SiteName, SalesAreaName, POSName, PanelDesignName: string; var PanelDesignType, EPOSDeviceID, ScreenInterfaceID, HardwareType: integer);
    procedure GetSalesAreaAndPOSCode(SiteCode, EposDeviceID: integer; var SalesAreaCode, POSCode: integer);
    procedure GetPanelDesignExampleSite(const PanelDesignID: integer; var SiteCode, SalesAreaCode, POSCode: integer);
    function CheckAnalysisCodeUnique(ID: integer; NewCode: string): boolean;
    procedure PopulateTicketImageList(ThemeId: integer; Items: TStrings);
    function GetNextTicketThemeImageIndex(ThemeId: integer): integer;
    function CharityDonationsEnabledForTheEstate: boolean;
    function PriceEmbeddedBarcodePrefixSpecified: boolean;
    procedure LoadTerminalsMultiDrawerModeConfigSet;
    function RedeemDepositPaymentMethodExists: boolean;
    function IsMultiDrawerModeInUseForConfigSet(configSetId: integer): boolean;
  end;

var
  dmThemeData: TdmThemeData;
  IsSite, IsMaster, OrderDestinationsEnabled: boolean;

const
  GLOBAL_TABLES_TO_RENAME : Array[0..5] of String = ('ConfigTree_Names', 'ProductTree_Names', 'SelectTerminal_Names',
                'ConfigTree_Data', 'ProductTree_Data', 'SelectTerminal_Data');

implementation

uses Registry, uGlobals, uGenerateThemeIDs, Math;

{$R *.dfm}

procedure ParseVersion(const myVersion: string; out parts: array of Integer);
var
  i, count: Integer;
  versionStr: string;
begin
  // Initialize the array to zero
  for i := 0 to 3 do
    parts[i] := 0;

  // Split the version string into parts
  count := 0;
  versionStr := myVersion;
  while (Pos('.', versionStr) > 0) and (count < 4) do
  begin
    parts[count] := StrToInt(Copy(versionStr, 1, Pos('.', versionStr) - 1));
    Delete(versionStr, 1, Pos('.', versionStr));
    Inc(count);
  end;
  if versionStr <> '' then
    parts[count] := StrToInt(versionStr);
end;

function CompareVersionArrays(siteParts, compareParts: array of Integer): Boolean;
var
  i: Integer;
begin
  for i := 0 to 3 do
  begin
    if siteParts[i] > compareParts[i] then
    begin
      Result := True;
      exit;
    end
    else if siteParts[i] < compareParts[i] then
    begin
      Result := False;
      exit;
    end;
  end;

  Result := True;  // If all parts are equal
end;

procedure TdmThemeData.SetBaseEditSiteVersion;
begin
  with adoqrun do
  begin
    close;
    SQL.Text := 'SELECT DBVersion FROM commsversions where sitecode = ' + qOutlets.FieldByName('SiteCode').AsString;
    Open;
    SiteVersionString := FieldByName('DBVersion').AsString;
    Close;
  end;
  if (SiteVersionString = '') then SiteVersionString := '0.0.0.0';

  ParseVersion(SiteVersionString, SiteVersionArray);
end;

function TdmThemeData.SiteVersionAtLeast(version: string): boolean;
var
  compareArray: array[0..3] of Integer;
begin
  ParseVersion(version, compareArray);
  result := CompareVersionArrays(SiteVersionArray, compareArray);
end;

procedure TdmThemeData.AccessDataset(datasetname: string);
var
  dset: TComponent;
begin
  dset := findcomponent(datasetname);
  if dset = nil then raise exception.create('Accessdataset: could not find component');
  AccessDataset(Tdataset(dset));
end;


procedure TdmThemeData.AccessDataset(dset: TDataSet);
begin
  dset.tag := dset.tag + 1;
  dset.open;
end;

procedure TdmThemeData.DeAccessDataset(datasetname: string; postDataset : boolean = false);
var
  dset: TComponent;
begin
  dset := findcomponent(datasetname);
  if dset = nil then raise exception.create('DeAccessdataset: could not find component');
  DeAccessDataset(TDataset(dset), postDataset);
end;


procedure TdmThemeData.DeAccessDataset(dset: TDataSet; postDataset : boolean = false);
begin
  if postDataset and (dset.State in [dsInsert,dsEdit]) then
    dset.Post;
  dset.tag := dset.tag - 1;
  if dset.tag < 1 then dset.close;
end;


Procedure TdmThemeData.InsertThemeSite;
begin
  AccessDataset('tThemeSites');
  dmThemeData.tThemeSites.InsertRecord([qOutlets.FieldByName('SiteCode').Value, qThemes.FieldByName('ThemeID').Value]);
  deAccessDataset('tThemeSites');
end;

// procs to store position, size of panels (for button picker and panel edit screens)

procedure TdmThemeData.StoreMetrics(form: TForm; positiononly: boolean);
begin
  with TRegistry.create do try
    // store in per-user section of registry, which is writable
    rootkey := HKEY_CURRENT_USER;
    openkey('software\Zonal\Aztec\AZTM', true);
    writeinteger(form.ClassName+'.Top', form.top);
    writeinteger(form.ClassName+'.Left', form.left);
    if not (positiononly) then
    begin
      writeinteger(form.ClassName+'.Width', form.width);
      writeinteger(form.ClassName+'.Height', form.height);
    end;
    closekey;
  finally
    free;
  end;
end;

function TdmThemeData.GetStoredMetrics(form: TForm; positiononly: boolean): boolean;
begin
  Result := GetStoredMetrics(form, positiononly, nil, sttNone);
end;

function TdmThemeData.GetStoredMetrics(form: TForm; positiononly: boolean; SnapToType: TSnapToType): boolean;
begin
  Result := GetStoredMetrics(form, positiononly, nil, SnapToType);
end;

function TdmThemeData.GetStoredMetrics(form: TForm; positiononly: boolean; SnapToForm: TForm; SnapToType: TSnapToType): boolean;
var
  WorkArea: TRect;
begin
  SystemParametersInfo(SPI_GETWORKAREA, 0, @WorkArea, 0);

  result := false;
  with TRegistry.create do try
    // store in per-user section of registry, which is writable
    rootkey := HKEY_CURRENT_USER;
    openkeyreadonly('software\Zonal\Aztec\AZTM');
    if valueexists(form.ClassName+'.Top') then
    begin
      form.top := readinteger(form.ClassName+'.Top');
      form.Left := readinteger(form.ClassName+'.Left');
      if not(positiononly) then
      begin
        form.width := readinteger(form.ClassName+'.Width');
        form.height := readinteger(form.ClassName+'.Height');
      end;
      // validate entries - make sure forms are on screen
      if (form.Top < 0) or (form.Top + Form.Height > WorkArea.Bottom) or (form.Left < 0) or (form.Left + form.Width > WorkArea.Right) then
      begin
        case SnapToType of
          sttLeft:
            begin
              form.Left := Max(SnapToForm.Left - form.Width, 0);
              form.top := SnapToForm.Top;
            end;
          sttRight:
            begin
              form.left := Min(SnapToForm.Left + SnapToForm.Width, WorkArea.Right - form.Width);
              form.top := SnapToForm.Top;
            end;
          sttTop:
            begin
              form.left := SnapToForm.Left;
              form.top := Max(SnapToForm.Top - form.Height, 0);
            end;
          sttBottom:
            begin
              form.left := SnapToForm.Left;
              form.top := Min(SnapToForm.top + SnapToForm.Height, WorkArea.Bottom - form.Height);
            end;
          sttLeftRight:
            begin
              if (form.Left + form.Width div 2 < SnapToForm.Left + SnapToForm.Width div 2) then
              begin
                form.Left := Max(SnapToForm.Left - form.Width, 0);
                form.top := SnapToForm.Top;
              end
              else
              begin
                form.left := Min(SnapToForm.Left + SnapToForm.Width, WorkArea.Right - form.Width);
                form.top := SnapToForm.Top;
              end
            end;
          sttCentreScreen:
            begin
              form.Left := WorkArea.Right div 2 - form.Width div 2;
              form.Top := WorkArea.Bottom div 2 - form.Height div 2;
            end
          else begin
            if (form.Top < 0) or (form.Top > WorkArea.Bottom) then form.top := 0;
            if (form.Left < 0) or (form.Left > WorkArea.Right) then form.Left := 0;
          end;
        end;
      end;
      result := true;
    end;
    closekey;
  finally
    free;
  end;
end;

//------------------------------------------------------------------------------
procedure TdmThemeData.qOutletTerminalspaneldesignidChange(Sender: TField);
begin
  inherited;
  Tfield(sender).DataSet.FieldByName('defaultpanelid').clear;
end;

//------------------------------------------------------------------------------
procedure TdmThemeData.InsertDefaultSharedPanelPos(PanelID : Int64);
begin
//** No Longer Required as the shared panel properties are designed when it gets added
//** to a design
end;

//------------------------------------------------------------------------------
procedure TdmThemeData.qOutletTerminalsBeforeInsert(DataSet: TDataSet);
begin
  abort;
end;

procedure TdmThemeData.qOutletTerminalsBeforeDelete(DataSet: TDataSet);
begin
  abort;
end;

procedure TdmThemeData.DataModuleCreate(Sender: TObject);
begin
  inherited;

  DefineTablesToRenameList(GLOBAL_TABLES_TO_RENAME);

  with adoqrun do
  begin
    SQL.Text := 'SELECT [Master], [Site] FROM dbo.SystemDefinition';
    Open;
    IsMaster := FieldByName('Master').AsBoolean;
    IsSite := FieldByName('Site').AsBoolean;
    Close;
  end;

  with adoqrun do
  begin
    SQL.Clear;
    SQL.Add('SELECT EnableOrderDestinations from ac_EstateProductSettings');
    Open;
    if not EOF then
    begin
      OrderDestinationsEnabled := FieldByName('EnableOrderDestinations').AsBoolean;
    end;
    Close;
  end;

  adoqrun.SQL.text := 'select [rollover time] from timeout';
  adoqrun.open;
  RolloverTime := useful.FixedStrToTime(adoqrun.fieldByName('Rollover time').AsString);
  adoqrun.close;

  qUpdateNewSiteConfigs.ExecSQL;

  if IsSite and IsMaster then
    AssignHelpFile(AZTM_SITEMASTER_HELP_FILE)
  else if IsSite then
    AssignHelpFile(AZTM_SITE_HELP_FILE)
  else
  if IsMaster then
    AssignHelpFile(AZTM_HO_HELP_FILE);

  if not fileexists(application.helpfile) then
    application.helpfile := '';
end;

procedure TdmThemeData.qThemesAfterOpen(DataSet: TDataSet);
var
  themeid: integer;
begin
  inherited;
  if issite then
  begin
    // if single site master or site, scroll to the theme selected
    // for the current site
    adoqrun.SQL.text := 'select themeid from themesites '+
      'where sitecode = (select top 1 [site code] from siteaztec)';
    adoqrun.Open;
    themeid := adoqrun.Fieldbyname('themeid').AsInteger;
    adoqrun.close;
    dataset.Locate('themeid', themeid, []);
  end;
end;

procedure TdmThemeData.qConfigSetsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  // set edit mask for auto close time: hh:mm
  dataset.FieldByName('autoclosetime').EditMask := '!90:00;1;_';
  dataset.FieldByName('autoclosetime').OnValidate := CloseTimeValidate;

end;

procedure TdmThemeData.CloseTimeValidate(Sender: TField);
begin
  try
  sender.AsDateTime;
  except
  else
    Raise exception.create(format('%s is not a valid time', [sender.asstring]));
  end;
end;

procedure TdmThemeData.NewForcedSelectionPanel(PanelDesignID: Integer);
var
  newPanelID, ObjectID : longint;
  panelHeight, panelTop : integer;
begin
  with TADOQuery.create(nil) do try
    connection := dmthemedata.AztecConn;

    sql.text := format('select paneldesigntype from themepaneldesign '+
      ' where paneldesignid = %d ', [paneldesignid]);

    open;

    if fieldbyname('paneldesigntype').AsInteger = 3 then
      begin
        panelHeight := 10;
        panelTop := 1;
      end
    else
      begin
        panelHeight := 6;
        panelTop := 0;
      end;

    close;

    newPanelID := uGenerateThemeIDs.GetNewId(scThemePanel);

    // Create Forced Item Selection panel
    sql.text := format('insert into themepanel select '+
        '%d, 3, %d, %s, %s, %.18f, %.18f, %d, %d, %d, null, null, null, null',
        [newPanelID, PanelDesignID, QuotedStr('Forced Items Selection'),
          QuotedStr('Special Panel, not fully configurable'), 0.5, 0.5, 6,panelHeight, 1]);

    execsql;

    // Now add it to the ThemePanelDesign_Repl table...
    sql.text := format('update themepaneldesign set [ForcedSelection] = '+
      '%d where [PanelDesignID] = %d',
      [newPanelID, PanelDesignID]);
    execsql;

    // create the 2 "read-only" top labels one by one
    ObjectID := uGenerateThemeIDs.GetNewId(scThemePanelLabel);
    sql.text := format('insert into ThemePanelLabel ([PanelID], [LabelID], '+
      ' [Left], [Top], [Width], [Height], [Text], [Font], [Border], ' +
      ' [FontColourR], [FontColourG], [FontColourB], ' +
      ' [BackgroundColourR], [BackgroundColourG], [BackgroundColourB])' +
      ' select %d, %d, %d, %d, %d, %d, %s, %d, %d, %d, %d, %d, %d, %d, %d',
      [newPanelID, ObjectID, 0,panelTop,6,1, QuotedStr('Reserved for Terminal (Table no.)'), 0,0,
        255,255,255,0,0,0]);

    execsql;

    // and the second...
    ObjectID := uGenerateThemeIDs.GetNewId(scThemePanelLabel);
    sql.text := format('insert into ThemePanelLabel ([PanelID], [LabelID], '+
      ' [Left], [Top], [Width], [Height], [Text], [Font], [Border], ' +
      ' [FontColourR], [FontColourG], [FontColourB], ' +
      ' [BackgroundColourR], [BackgroundColourG], [BackgroundColourB])' +
      ' select %d, %d, %d, %d, %d, %d, %s, %d, %d, %d, %d, %d, %d, %d, %d',
      [newPanelID, ObjectID, 0,(panelTop + 1),6,1, QuotedStr('Reserved for Terminal (Items to select)'), 0,0,
        255,255,255,0,0,0]);

    execsql;


    // insert Bypass button
    ObjectID := uGenerateThemeIDs.GetNewId(scThemePanelButton);
    sql.text := format('insert into ThemePanelButton ([PanelID], [ButtonID], ' +
      ' [Left], [Top], [Width], [Height], [Backdrop], [Font], ' +
      ' [FontColourR], [FontColourG], [FontColourB], [ButtonTypeChoiceID], [RequestWitness])' +
      ' select %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d',
      [newPanelID, ObjectID, 5,panelHeight - 1,1,1,0,1,255,255,255,139,0]);

    execsql;

  finally
    free;
  end;

end;

procedure TdmThemeData.DeleteForcedSelectionPanel(PanelDesignID: Integer);
begin
  with TADOQuery.create(nil) do try
    connection := dmthemedata.AztecConn;

    // get the Forced Item Panel's PanelID of the PanelDesign
    // rely on the [ThemePanel_Repl] delete trigger
    sql.text := format('delete themepanel where PanelID = %d',
      [GetForcedSelectionPanelID(PanelDesignID)]);
    execsql;

    // Now delete it from the ThemePanelDesign_Repl table...
    sql.text := format('update themepaneldesign set [ForcedSelection] = NULL'+
      ' where [PanelDesignID] = %d',
      [PanelDesignID]);
    execsql;


  finally
    free;
  end;
end;

function TdmThemeData.GetForcedSelectionPanelID(PanelDesignID: Integer): LongInt;
begin
  with TADOQuery.create(nil) do try
    connection := dmthemedata.AztecConn;

    // get the Forced Item Panel's PanelID of the PanelDesign
    sql.text := format('select [ForcedSelection] from themepaneldesign where [PanelDesignID] = %d',
      [PanelDesignID]);
    open;

    if FieldByName('ForcedSelection').IsNull then
      Result := -1
    else
      Result := TLargeintfield(FieldByName('ForcedSelection')).aslargeint;

    close;
  finally
    free;
  end;
end;

function TdmThemeData.IsForcedSelectionPanel(PanelID: Integer): Boolean;
begin
  with TADOQuery.create(nil) do try
    connection := dmthemedata.AztecConn;

    sql.text := format('select [PanelDesignID] from themepaneldesign where [ForcedSelection] = %d',
      [PanelID]);
    open;

    if RecordCount = 0 then
      Result := FALSE
    else
      Result := TRUE;

    close;
  finally
    free;
  end;
end;


function TdmThemeData.CheckPanelNameUnique(PanelID: integer; NewName: string; IsVariation: boolean; LocalPanelDesignOrVariationGroupID: integer = -1): boolean;
begin
  with TADOQuery.Create(nil) do try
    Connection := AztecConn;
    if (LocalPanelDesignOrVariationGroupID = -1) or IsVariation then
    begin
      if IsVariation then
        // Variation names must be unique within the variation group, including the "group" or "default shared panel" name
        SQL.Text := Format(
          'SELECT COUNT(*) as Result FROM ThemePanel WHERE PanelID <> %d and Name = %s '+
          'and PanelDesignID is null and (PanelID = %d or PanelID in (SELECT VariationPanelID FROM ThemePanelVariation WHERE PanelID = %d))',
          [PanelID, QuotedStr(NewName), LocalPanelDesignOrVariationGroupID, LocalPanelDesignOrVariationGroupID]
        )
      else
        // Check shared panels
        SQL.Text := Format(
          'SELECT COUNT(*) as Result FROM ThemePanel WHERE PanelID <> %d and Name = %s '+
          'and PanelDesignID is null and PanelType = 2',
          [PanelID, QuotedStr(NewName), PanelID]
        );
    end
    else
    begin
      // Check panels within specified panel design
      SQL.Text := Format(
        'SELECT COUNT(*) as Result FROM ThemePanel WHERE PanelID <> %d and PanelDesignID = %d and Name = %s ',
        [PanelID, LocalPanelDesignOrVariationGroupID, QuotedStr(NewName)]
      )
    end;
    Open;
    Result := FieldByName('Result').AsInteger = 0;
    Close;
  finally
    Free;
  end;
end;

procedure TdmThemeData.BeginHourglass;
begin
  if HourglassOperationCount = 0 then
  begin
    Screen.Cursor := crHourglass;
  end;
  Inc(HourglassOperationCount);
end;

procedure TdmThemeData.EndHourglass;
begin
  Dec(HourglassOperationCount);
  if HourglassOperationCount = 0 then
    Screen.Cursor := crDefault;
end;

procedure TdmThemeData.GetPreviewDetails(SiteCode, SalesAreaCode, POSCode,
  PanelDesignID: integer; var SiteName, SalesAreaName, POSName,
  PanelDesignName: string; var PanelDesignType, EposDeviceID, ScreenInterfaceID, HardwareType : integer);
var
  qry: TADOQuery;
begin
  qry := TADOQuery.create(nil);
  qry.Connection := AztecConn;

  with qry do
  begin
    SQL.Text := Format('select Name from ac_Site where Id = %d', [SiteCode]);
    Open;
    SiteName := qry.Fields[0].AsString;

    SQL.Text := Format('select Name from ac_SalesArea where Id = %d', [SalesAreaCode]);
    Open;
    SalesAreaName := Fields[0].AsString;

    SQL.Text := Format('select Name from ac_Pos where Id = %d', [POSCode]);
    Open;
    POSName := Fields[0].AsString;

    SQL.Text := Format('select Name, Description, PanelDesignType, ScreenInterfaceID from ThemePanelDesign where PanelDesignID = %d', [PanelDesignID]);
    Open;
    PanelDesignName := Fields[0].AsString;
    PanelDesignType := Fields[2].AsInteger;
    ScreenInterfaceID := Fields[3].AsInteger;

    SQL.Text := Format('select EposDeviceID from ThemeEposDevice '+
      'where Sitecode = %d and POSCode = %d', [SiteCode, POSCode]);
    Open;
    if RecordCount = 0 then
      EPOSDeviceID := -1
    else
      EPOSDeviceID := Fields[0].AsInteger;

    SQL.Text := Format('select EposDeviceID, HardwareType from ThemeEposDevice '+
      'where Sitecode = %d and POSCode = %d', [SiteCode, POSCode]);
    Open;
    if RecordCount = 0 then
    begin
      EPOSDeviceID := -1;
      HardwareType := -1;
    end
    else begin
      EPOSDeviceID := FieldByName('EposDeviceID').AsInteger;
      HardwareType := FieldByName('HardwareType').AsInteger;
    end;

    Close;
    Free;
  end;
end;

procedure TdmThemeData.GetSalesAreaAndPOSCode(SiteCode, EposDeviceID: integer;
  var SalesAreaCode, POSCode: integer);
var
  qry: TADOQuery;
begin
  qry := TADOQuery.create(nil);
  qry.Connection := AztecConn;

  with qry do
  begin
    SQL.Text := Format('select SalesAreaId, POSCode '+
      'from themeeposdevice '+
      'join ac_Pos on POSCode = Id '+
      'where EPoSDeviceID = %d and SiteCode = %d',
      [EposDeviceID, SiteCode]);
    Open;
    SalesAreaCode := Fields[0].AsInteger;
    POSCode := Fields[1].AsInteger;
    Close;
    Free;
  end;

end;

procedure TdmThemeData.GetPanelDesignExampleSite(
  const PanelDesignID: integer; var SiteCode, SalesAreaCode,
  POSCode: integer);
var
  qry: TADOQuery;
begin
  qry := TADOQuery.create(nil);
  qry.Connection := AztecConn;

  with qry do
  begin
    SQL.Text := Format('select a.SiteCode, SalesAreaId, a.POSCode from ThemeEposDesign a '+
      'join ac_Pos on a.POSCode = Id '+
      'join ThemeEposDevice b on a.Sitecode = b.SiteCode and a.POSCode = b.POSCode '+
      'where a.PanelDesignID = %d '+
      '  and b.HardwareType in '+
      '   (select HardwareType from TerminalHardware ' +
      '    where ClassName like ''%%AztecEPoS%%'' ' +
      '    and HardwareType not in (10, 11, 12, 13, 14)) '+
      'order by NEWID()', [PanelDesignID]);
    Open;
    if RecordCount = 0 then
    begin
      Close;
      Free;
      Raise Exception.Create('No terminals are using this Panel Design.');
    end;
    SiteCode := Fields[0].AsInteger;
    SalesAreaCode := Fields[1].AsInteger;
    POSCode := Fields[2].AsInteger;

    Close;
    Free;
  end;

end;

function TdmThemeData.CheckAnalysisCodeUnique(ID: integer; NewCode: string): boolean;
begin
  // check includes "deleted" codes
  with TADOQuery.Create(nil) do try
    Connection := AztecConn;
    SQL.Text := Format(
      'SELECT COUNT(*) AS Result FROM HotelCodes WHERE ID <> %d AND Code = %s',
      [ID, QuotedStr(NewCode)]);
    Open;
    Result := FieldByName('Result').AsInteger = 0;
    Close;
  finally
    Free;
  end;
end;

function TdmThemeData.IsMultiDrawerModeInUseForConfigSet(configSetId: integer): boolean;
begin
    LoadTerminalsMultiDrawerModeConfigSet;

  result := CongfigSetIdMultiDrawerModeList.Values[IntToStr(configSetId)] = 'True';
end;

procedure TdmThemeData.LoadTerminalsMultiDrawerModeConfigSet;
begin
  CongfigSetIdMultiDrawerModeList := TStringList.Create;
  adoqRun.Close;
  adoqRun.SQL.Clear;
  adoqRun.sql.Text := 'select a.ConfigSetID, b.MultiDrawerMode '+
                      'from ThemeConfigSet a ' +
	                    'join themeeposdevice b on a.ConfigSetID = b.ConfigSetID '+
                      'where IsServer = 0 '+
                      'and HardwareType in (0, 7) ' + //Z500 & i700
                      'and b.MultiDrawerMode = 1 ' +
                      'Group by a.ConfigSetID, b.MultiDrawerMode';
  adoqRun.Open;

  while not adoqRun.Eof do
  begin
    CongfigSetIdMultiDrawerModeList.Add(adoqRun.FieldByName('ConfigSetId').AsString +
    '=' + adoqRun.FieldByName('MultiDrawerMode').AsString);
    adoqRun.Next;
  end;

  adoqRun.Close;
end;

procedure TdmThemeData.qConfigSetsUseDrawerAssignmentEnabledChange(Sender: TField);
begin
  if (Sender.Dataset.RecordCount = 0) OR (VarIsNull(Sender.NewValue)) then
    Exit;

  if IsMultiDrawerModeInUseForConfigSet(Sender.DataSet.FieldByName('ConfigSetId').AsInteger) then
    qConfigSetsUseDrawerAssignment.ReadOnly := True
  else
    qConfigSetsUseDrawerAssignment.ReadOnly := False;

end;

procedure TdmThemeData.qConfigSetsDisableAllButtonsWhenDrawerOpenChange(Sender: TField);
begin
  if (Sender.Dataset.RecordCount = 0) OR (VarIsNull(Sender.NewValue)) then
    Exit;

  if not(qConfigSets.State in [dsEdit, dsInsert]) then
    qConfigSets.Edit; 

  if (not Sender.Value) then
  begin
    qConfigSetsi700CheckDrawerStatusBeforeOpening.ReadOnly := False;
  end
  else if (Sender.Value) and not (qConfigSetsi700CheckDrawerStatusBeforeOpening.ReadOnly) then
  begin
    qConfigSetsi700CheckDrawerStatusBeforeOpening.AsBoolean := True;
    qConfigSetsi700CheckDrawerStatusBeforeOpening.ReadOnly := True;
  end;  

end;

procedure TdmThemeData.qConfigSetsConversationalRecipesEnabledChange(
  Sender: TField);
var
  ConvWidthExceeded: boolean;
begin
  if (Sender.Dataset.RecordCount = 0) then
    Exit;

  if VarIsNull(Sender.NewValue) then
    Exit;

  if ((not Sender.NewValue) and (sender.OldValue)) or ((not Sender.NewValue) and (qConfigSets.State in [dsEdit, dsInsert])) then
  begin
    if not(qConfigSets.State in [dsEdit, dsInsert]) then
      qConfigSets.Edit;
    qConfigSetsConversationalRecipesAutoAdvance.AsBoolean := false;
  end
  else if (Sender.NewValue and (not Sender.OldValue)) or ((Sender.NewValue) and (qConfigSets.State in [dsEdit, dsInsert]))then
  begin
    // check width of the conversation ordering panel against top level
    // recipes
    qCheckConvWidth.SQL[1] := Format('set @ConfigSetID = %d', [qConfigSets.FieldByName('ConfigSetId').AsInteger ]);
    try
      screen.Cursor := crAppStart;
      qCheckConvWidth.Open;
      ConvWidthExceeded := qCheckConvWidth.RecordCount > 0;
    finally
      screen.Cursor := crDefault;
      qCheckConvWidth.Close;
    end;
    if ConvWidthExceeded then
      MessageDlg('Some products have more top-level choices than will fit on Terminals using this Config Set.'+#13+
        'These may need to be changed to move some choices to a nested choice.', mtWarning, [mbOk], 0);
  end;

  if (not Sender.Value) and not qConfigSetsConversationalRecipesAutoAdvance.ReadOnly then
    qConfigSetsConversationalRecipesAutoAdvance.ReadOnly := True
  else if (Sender.Value) and qConfigSetsConversationalRecipesAutoAdvance.ReadOnly then
    qConfigSetsConversationalRecipesAutoAdvance.ReadOnly := False;
end;

procedure TdmThemeData.qConfigSetsAfterScroll(DataSet: TDataSet);
begin
  qConfigSetsConversationalRecipesEnabledChange(DataSet.FieldByName('ConversationalRecipesEnabled'));
  qConfigSetsUseDrawerAssignmentEnabledChange(DataSet.FieldByName('ConfigSetID'));
  qConfigSetsDisableAllButtonsWhenDrawerOpenChange(DataSet.FieldByName('DisableAllButtonsWhenDrawerOpen'));
end;

procedure TdmThemeData.qThemeCloakroomImageCalcFields(DataSet: TDataSet);
begin
  qThemeCloakroomImageBitmapSize.AsInteger := (TBlobField(Dataset.FieldByName('Bitmap')).BlobSize+1023) div 1024;
end;

procedure TdmThemeData.PopulateTicketImageList(ThemeID: integer; Items: TStrings);
begin
  adoqRun.SQL.Text := Format('select * from ThemeCloakroomImage where ThemeID = %d order by Name', [ThemeID]);
  adoqRun.Open;
  items.Clear;
  adoqRun.first;
  Items.AddObject('(None)', nil);
  while not adoqRun.Eof do
  begin
    Items.AddObject(adoqRun.FieldByName('Name').AsString, TObject(adoqRun.FieldByName('CloakroomImageId').AsInteger));
    adoqRun.Next;
  end;
  adoqRun.Close;
end;

function TdmThemeData.GetNextTicketThemeImageIndex(
  ThemeId: integer): integer;
begin
  adoqRun.SQL.Text := Format('select IsNull(max(ThemeImageIndex)+1, 1) from ThemeCloakroomImage where ThemeId = %d', [ThemeId]);
  adoqRun.Open;
  result := adoqRun.Fields[0].AsInteger;
  adoqRun.Close;
end;

function TdmThemeData.CharityDonationsEnabledForTheEstate: boolean;
begin
  with adoqRun do
  try
    SQL.Text := 'SELECT TOP 1 AllowCharityDonations FROM ac_EstateFinanceSettings';
    Open;
    Result := not(eof) and FieldByName('AllowCharityDonations').AsBoolean = true;
  finally
    Close;
  end;
end;

function TdmThemeData.PriceEmbeddedBarcodePrefixSpecified: boolean;
begin
  with adoqRun do
  try
    SQL.Clear;
    SQL.Add('DECLARE @Result varchar(13)');
    SQL.Add(Format('exec sp_GetConfigurationResult null,%s,@Result output', [QuotedStr('PriceEmbeddedBarcodePrefix')]));
    SQL.Add('select @Result as Setting');
    Open;
    Result := not VarIsNull(FieldByName('Setting').Value);
  finally
    Close;
  end;
end;

function TdmThemeData.RedeemDepositPaymentMethodExists: boolean;
begin
  with adoqRun do
  try
    SQL.Text :=
      'IF EXISTS(SELECT * FROM ac_PaymentMethod WHERE PaymentMethodType = 10 /* RedeemDeposit */) SELECT 1 ELSE SELECT 0';
    Open;
    Result := Fields[0].AsInteger = 1;
  finally
    Close;
  end;
end;

procedure TdmThemeData.qConfigSetsBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  oldConfigSetName := qConfigSets.fieldByName('Name').asstring;
end;

procedure TdmThemeData.qConfigSetsBeforePost(DataSet: TDataSet);
begin
  inherited;

  if oldConfigSetName <> qConfigSets.fieldByName('Name').asstring then
    with adoqRun do
    begin
      // ensure Name uniqueness
      Close;
      sql.Clear;
      sql.Add('select * from themeconfigset');
      sql.Add('where [name] = ' + QuotedStr(qConfigSets.fieldByName('Name').asstring));
      open;

      if recordcount > 0 then
      begin
        showMessage(Format('The name %s is already in use by another Config Set; the previous name will be restored',
           [QuotedStr(qConfigSets.fieldByName('Name').asstring)]));
        qConfigSets.fieldByName('Name').asstring := oldConfigSetName;
      end;

      close;
    end;

end;

procedure TdmThemeData.dsEditZcpsConfigsDataChange(Sender: TObject;
  Field: TField);
var
  Bmk: TBookmark;
  DataSet: TDataSet;
  OldValue, NewValue: integer;
begin
  inherited;
  DataSet := TDataSource(sender).DataSet;
  if (DataSet.FieldByName('SiteCode').AsInteger = 0) and Assigned(Field) and not VarIsNull(Field.NewValue) then
  begin
    OldValue := Field.OldValue;
    NewValue := Field.NewValue;
    if (OldValue <> NewValue) then
    begin
      Bmk := DataSet.GetBookmark;
      DataSet.DisableControls;
      with DataSet do try
        Next;
        while not (EOF) do
        begin
          if Field.AsInteger = OldValue then
          begin
            Edit;
            Field.AsInteger := newValue;
            Post;
          end;
          Next;
        end;
      finally
        try
          DataSet.EnableControls;
          DataSet.GotoBookmark(Bmk);
        finally
          DataSet.FreeBookmark(Bmk);
        end;
      end;
    end;
  end;
end;

procedure TdmThemeData.qCustomerInformationPromptsMaximumEntryLengthSetText(
  Sender: TField; const Text: String);
begin
  inherited;
  if Text = '' then
    Raise Exception.Create('Maximum entry length cannot be blank')
  else
    qCustomerInformationPromptsMaximumEntryLength.AsInteger := StrToInt(Text);
end;

procedure TdmThemeData.qCustomerInformationPromptsPromptTextSetText(
  Sender: TField; const Text: String);
var
  newString : String;
begin
  inherited;
  newString := Trim(Text);
  if newString = '' then
    Raise Exception.Create('Prompt text cannot be blank')
  else
    qCustomerInformationPromptsPromptText.AsString := newString;
end;

procedure TdmThemeData.updateCustomerInformationPromptLookup(
  DataSet: TDataSet);
begin
  inherited;
  qCustomerInformationPromptLookup.Requery([]);
end;

end.
