unit uADO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dADOAbstract, ADODB, DB, udmThemeData, DBClient, StrUtils;

const
  MAX_VIRTUAL_DEVICE_LIMIT = 30;
  MIN_VIRTUAL_DEVICE_LIMIT = 3;
  BAD_REPORT_PRINTERS = '(10007, 10030, 10031, 10032)'; //10007 = Vx670 printer, 10030 = VX670 printer, 10031 = VX810 duet, 10032 =VX670 PRINTER (PAY AT TABLE)
  REPORT_LINE_LENGTH = 40;
  REPORT_LINE_LENGTH_DOUBLE_WIDE = 20;

type
  TdmADO = class(TdmADOAbstract)
    qRun: TADOQuery;
    dsPrinterTypes: TDataSource;
    qPrinterTypes: TADOQuery;
    qPrinterTypesPrinterTypeName: TStringField;
    qPrinterTypesPaperCut: TStringField;
    qPrinterTypesDoubleWidth: TStringField;
    qPrinterTypesNewLine: TStringField;
    qPrinterTypesBold: TStringField;
    qPrinterTypesNormal: TStringField;
    qPrinterTypesLine: TStringField;
    qPrinterTypesResetPrinter: TStringField;
    qPrinterTypesAlternateColour: TStringField;
    qPrinterTypesPrinterTypeID: TIntegerField;
    dsAllPrinters: TDataSource;
    dsTerminalPrinters: TDataSource;
    dsGetTerminals: TDataSource;
    qGetTerminals: TADOQuery;
    qGetTerminalsName: TStringField;
    qGetTerminalsIPAddress: TStringField;
    qTerminalPrinters: TADOQuery;
    qAllPrinters: TADOQuery;
    dsEditStreams: TDataSource;
    dsPrintStreams: TDataSource;
    qPrintStreams: TADOQuery;
    qPrinters2: TADOQuery;
    qPrinters2printeraddressid: TStringField;
    qPrinters2name: TStringField;
    qSeed: TADOQuery;
    qTerminalPrintersPrinterID: TLargeintField;
    qTerminalPrintersSiteCode: TIntegerField;
    qTerminalPrintersEposDeviceID: TWordField;
    qTerminalPrintersRedirectionPrinterId: TLargeintField;
    qTerminalPrintersName: TStringField;
    qTerminalPrintersPrinterType: TIntegerField;
    qTerminalPrintersPortNumber: TWordField;
    qTerminalPrintersEposName1: TStringField;
    qTerminalPrintersEposName2: TStringField;
    qTerminalPrintersEposName3: TStringField;
    qPrintStreamsPrinterStreamName: TStringField;
    qPrintStreamsIndexNo: TSmallintField;
    qPrintStreamsAltered: TStringField;
    qPrintStreamsDeleted: TStringField;
    qEditStreams: TADOQuery;
    qEditStreamsTerminalName: TStringField;
    qEditStreamsPrintStream: TStringField;
    qEditStreamsprinterlookup: TStringField;
    qEditStreamsprinteraddress: TStringField;
    qEditStreamsprintstreamid: TIntegerField;
    qGetTerminalsSiteCode: TIntegerField;
    qGetTerminalsPOSCode: TIntegerField;
    dsPrinters2: TDataSource;
    qGetTerminalsEPoSDeviceID: TWordField;
    qEditStreamsTerminal: TSmallintField;
    qPrinters2printerID: TLargeintField;
    qRedirectPrinterLookup: TADOQuery;
    StringField1: TStringField;
    StringField2: TStringField;
    LargeintField1: TLargeintField;
    dsRedirectPrinterLookUp: TDataSource;
    qTerminalPrintersReDirectLkUp: TStringField;
    qOutletPrintConfigs: TADOQuery;
    dsOutletPrintConfigs: TDataSource;
    qOutletPrintConfigsSiteCode: TIntegerField;
    qOutletPrintConfigsBillReceiptPrintStream: TLargeintField;
    qOutletPrintConfigsReportPrintStream: TLargeintField;
    qOutletPrintConfigsEFTPrintStream: TLargeintField;
    qOutletPrintConfigsPrintHeader1: TStringField;
    qOutletPrintConfigsPrintHeader2: TStringField;
    qOutletPrintConfigsPrintHeader3: TStringField;
    qOutletPrintConfigsPrintFooter1: TStringField;
    qOutletPrintConfigsPrintFooter2: TStringField;
    qOutletPrintConfigsPrintFooter3: TStringField;
    qOutletPrintConfigsVATNumber: TStringField;
    qOutletPrintConfigsPrintQrCodeSize: TIntegerField;
    qEditStreamsprinteraddress2: TStringField;
    qEditStreamsprinter2lookup: TStringField;
    qGetTerminalsScrollingMessage: TStringField;
    qPrinterTypesBaudRate: TIntegerField;
    qPrinterTypesTimeout: TIntegerField;
    qPrinterTypesDoublePly: TBooleanField;
    qOutletPrintConfigsEFTHeader1: TStringField;
    qOutletPrintConfigsEFTHeader2: TStringField;
    qOutletPrintConfigsEFTHeader3: TStringField;
    qGetTerminalsCustomerDisplayType: TIntegerField;
    qTerminalPrintersPrinterTypeName: TStringField;
    qGetTerminalsConfigSetID: TIntegerField;
    qGetPoses: TADOQuery;
    qGetPosesPoscode: TFloatField;
    qGetPosesposname: TStringField;
    dsGetPoses: TDataSource;
    qTerminalPrintersChangePaperTimeout: TIntegerField;
    qDiscounts: TADOQuery;
    dsDiscounts: TDataSource;
    qDiscountsDiscountID: TLargeintField;
    qDiscountsName: TStringField;
    qDiscountsEposName1: TStringField;
    qDiscountsEposName2: TStringField;
    qDiscountsEposName3: TStringField;
    qDiscountsDiscountType: TSmallintField;
    qDiscountsDivisionList: TIntegerField;
    qDiscountsMinimumSpend: TBCDField;
    qDiscountsMinimumSpendDivisional: TBooleanField;
    qDiscountsCalcDiscountType: TStringField;
    qCurrencies: TADOQuery;
    qCurrenciesCurrCode: TStringField;
    qCurrenciesName: TStringField;
    qCurrenciesSymbol: TStringField;
    qCurrenciesExchangeRate: TBCDField;
    qCurrenciesShowDecimal: TBooleanField;
    qCurrenciesCurrencyID: TIntegerField;
    dsCurrencies: TDataSource;
    qOutletPrintConfigsCloakroomPrintStream: TLargeintField;
    qOutletPrintConfigsCloakroomTicketHeader: TStringField;
    qOutletPrintConfigsPrintFooter4: TStringField;
    qOutletPrintConfigsPrintFooter5: TStringField;
    qOutletPrintConfigsPrintFooter6: TStringField;
    qGetTerminalsIsServer: TBooleanField;
    qGetTerminalsServerID: TSmallintField;
    qDiscountsOpensCashDrawer: TBooleanField;
    qTerminalPrintersIPAddress: TStringField;
    qTerminalPrintersIPPort: TIntegerField;
    qOutletPrintConfigsCorrectionTicketFooter1: TStringField;
    qOutletPrintConfigsCorrectionTicketFooter2: TStringField;
    qOutletPrintConfigsCorrectionTicketFooter3: TStringField;
    qOutletPrintConfigsCorrectionTicketFooter4: TStringField;
    qOutletPrintConfigsCorrectionTicketFooter5: TStringField;
    qOutletPrintConfigsCorrectionTicketFooter6: TStringField;
    qGetTerminalsHardwareType: TIntegerField;
    qGetTerminalsSubnetMask: TStringField;
    qGetTerminalsGatewayIP: TStringField;
    qTerminalPrintersCompactOrderLines: TBooleanField;
    qTerminalPrintersShowSeatHeader: TBooleanField;
    qOutletPrintConfigsCompactBillLines: TBooleanField;
    qDiscountsCardSecurityDefined: TBooleanField;
    qryGiftCardTypes: TADOQuery;
    dsGiftCardTypes: TDataSource;
    qDiscountsAutoPrintReceipt: TBooleanField;
    qOutletConfigs: TADOQuery;
    qOutletConfigsSiteCode: TIntegerField;
    qOutletConfigsDeclareTips: TBooleanField;
    qOutletConfigsWarnIfAccountsOpen: TBooleanField;
    qOutletConfigsCashbackAllowed: TBooleanField;
    qOutletConfigsICCFallbackAllowed: TBooleanField;
    qOutletConfigsSessionChangeWarnIfAccountsOpen: TBooleanField;
    qOutletConfigsTipValidationPercentage: TWordField;
    qOutletConfigsIPAddress: TStringField;
    qOutletConfigsUseScheduling: TBooleanField;
    qOutletConfigsUseDefaultDutySecurity: TBooleanField;
    qOutletConfigsCardCharge: TFloatField;
    qOutletConfigsHouseTipOut: TFloatField;
    qOutletConfigsAutoDeductTip: TBooleanField;
    qOutletConfigsPromptedSpotCheck: TBooleanField;
    qOutletConfigsEFTRequestIPPort: TIntegerField;
    qOutletConfigsEFTResponseIPPort: TIntegerField;
    qOutletConfigsGiftRequestIPPort: TIntegerField;
    qOutletConfigsGiftResponseIPPort: TIntegerField;
    qOutletConfigsGiftCardType: TIntegerField;
    qOutletConfigsShowAccountInformationOnVoucher: TBooleanField;
    qOutletConfigsCommideaServerIPAddress: TStringField;
    qOutletConfigsCommideaServerIPPort: TIntegerField;
    qOutletConfigsSendAllBarcodedProducts: TBooleanField;
    dsOutletConfigs: TDataSource;
    qDivision: TADOQuery;
    qCategories: TADOQuery;
    qSubCategories: TADOQuery;
    qDivisionDivisionName: TStringField;
    qDivisionIndexNo: TSmallintField;
    qCategoriesCategoryName: TStringField;
    qCategoriesIndexNo: TSmallintField;
    qSubCategoriesSubCategoryName: TStringField;
    qSubCategoriesIndexNo: TSmallintField;
    qDiscountsIncludeAllProducts: TBooleanField;
    qDiscountsMaximumDiscount: TFloatField;
    BaseDataTable: TADODataSet;
    qPrinterTypesIsKitchenScreen: TBooleanField;
    qOutletConfigsCommideaPinPadLogin: TStringField;
    qOutletConfigsCommideaPinPadPIN: TStringField;
    qOutletConfigsCommideaMainMenuOptions: TStringField;
    qOutletConfigsCommideaSubMenuOptions: TStringField;
    qOutletConfigsCommideaTransactionTimeout: TIntegerField;
    qOutletConfigsEFTPreAuthAmount: TBCDField;
    qThemeTerminalEFTTimeouts: TADOQuery;
    dsThemeTerminalEFTTimouts: TDataSource;
    qThemeTerminalEFTTimeoutsName: TStringField;
    qThemeTerminalEFTTimeoutsTimeoutRetryCount: TIntegerField;
    qThemeTerminalEFTTimeoutsSiteCode: TIntegerField;
    qThemeTerminalEFTTimeoutsID: TIntegerField;
    qThemeTerminalEFTTimeoutsTimeoutTime: TIntegerField;
    qThemeTerminalEFTTimeoutsTotalTimeout: TStringField;
    qOutletConfigsAllowEnhancedTipAdjust: TBooleanField;
    qOutletConfigsUseAutoDecimalEntry: TBooleanField;
    qOutletConfigsAutoFillValue: TBooleanField;
    qOutletConfigsFastEFTAmount: TBCDField;
    qGetTerminalsResetAccountNumber: TBooleanField;
    qOutletConfigsPrintClockINTicket: TBooleanField;
    qOutletConfigsPrintClockOUTTicket: TBooleanField;
    qOutletConfigsAbbreviatedClockOutTicket: TBooleanField;
    qOutletPrintConfigsSOAPServerTicketPrintStream: TLargeintField;
    qOutletConfigsScaleDecimalPlaces: TIntegerField;
    qOutletConfigsScaleDisplayUnit: TStringField;
    qGetTerminalsScreenInterfaceID: TSmallintField;
    qDiscountsProductGroupID: TIntegerField;
    qDiscountsMinSpendProdGroupID: TIntegerField;
    qOutletConfigsEFTMode: TWordField;
    qThemeOutletEftModeLookup: TADOQuery;
    qOutletConfigsPayoutTipsOnClockout: TBooleanField;
    qGetTerminalsKiosk_SEC: TLargeintField;
    qGetEmployees: TADOQuery;
    qGetEmployeesRegisterName: TStringField;
    qGetEmployeesKiosk_SEC: TLargeintField;
    qSMOverride: TADOQuery;
    qPFOverride: TADOQuery;
    dsSMOverride: TDataSource;
    dsPFOverride: TDataSource;
    qOutletPrintConfigsStandardFooterOverrideId: TIntegerField;
    qGetTerminalsScrollingMessageOverrideId: TIntegerField;
    qTerminalPrintersEFTPay: TBooleanField;
    qTerminalPrintersHasCashDrawer: TBooleanField;
    qGetTerminalsPoundCode: TIntegerField;
    qGetMoaDetails: TADOQuery;
    qGetMoaDetailsSalesArea: TStringField;
    qGetMoaDetailsMOACount: TIntegerField;
    qGetMoaDetailsMOAUser: TStringField;
    qOutletConfigsServiceChargeCoverThreshold: TWordField;
    qOutletConfigsZcpsApplyPreAuthCreditLimit: TBooleanField;
    qOutletConfigsAdMarginConnectionString: TWideStringField;
    qDiscountsDisablesPromotions: TBooleanField;
    qOutletPrintConfigsPromotionSavingsOnBill: TBooleanField;
    qOutletConfigsQSRShowAztecCoursesSeparately: TBooleanField;
    qDiscountsDeleted: TBooleanField;
    qBFOverride: TADOQuery;
    dsBFOverride: TDataSource;
    qClockoutTicketFooterOverride: TADOQuery;
    dsClockoutTicketFooterOverride: TDataSource;
    qClockoutTicketFooterOverrideID: TIntegerField;
    qClockoutTicketFooterOverrideName: TStringField;
    qClockoutTicketFooterOverrideDescription: TStringField;
    qClockoutticketFooterTextOverride: TADOQuery;
    dsClockoutTicketFooterTextOverride: TDataSource;
    qClockoutticketFooterTextOverrideLineNumber: TSmallintField;
    qClockoutticketFooterTextOverrideLineType: TWordField;
    qClockoutticketFooterTextOverrideText: TWideStringField;
    qClockoutticketFooterTextOverrideBold: TBooleanField;
    qClockoutticketFooterTextOverrideDoubleSize: TBooleanField;
    qClockoutticketFooterTextOverrideLineNumberSeq: TIntegerField;
    qOutletConfigsKMSPrimaryServerIPAddress: TStringField;
    qOutletConfigsKMSPrimaryServerPort: TIntegerField;
    qOutletConfigsKMSBackupServerIPAddress: TStringField;
    qOutletConfigsKMSBackupServerPort: TIntegerField;
    qOutletPrintConfigsBillFooterOverrideId: TIntegerField;
    qOutletSuggestedTip: TADOQuery;
    dsOutletSuggestedTip: TDataSource;
    qOutletSuggestedTipSiteCode: TIntegerField;
    qOutletSuggestedTipText1: TStringField;
    qOutletSuggestedTipText2: TStringField;
    qOutletSuggestedTipText3: TStringField;
    qOutletSuggestedTipLeadingLines: TIntegerField;
    qOutletSuggestedTipTrailingLines: TIntegerField;
    qOutletSuggestedTipShowForBills: TBooleanField;
    qOutletSuggestedTipShowForSOAPPayments: TBooleanField;
    qOutletSuggestedTipTitle1: TStringField;
    qOutletSuggestedTipTitle2: TStringField;
    qOutletSuggestedTipTitle3: TStringField;
    qDiscountsPreventFurtherSales: TBooleanField;
    qOutletConfigsSessionChangeWarnIfAccountsOpenLastTerminalOnly: TBooleanField;
    qOutletConfigsSessionChangeWarnIfAccountsOpenInSalesArea: TBooleanField;
    qDiscountsReasonRequired: TBooleanField;
    adoqReasons: TADOQuery;
    adoqCorrectionMethods: TADOQuery;
    qDiscountsReferenceRequired: TBooleanField;
    qBFOverrideId: TIntegerField;
    qBFOverrideName: TStringField;
    qBFOverrideDescription: TStringField;
    qBillFooterTextOverride: TADOQuery;
    dsBillFooterTextOverride: TDataSource;
    qBillFooterTextOverrideLineNumber: TSmallintField;
    qBillFooterTextOverrideAlignment: TSmallintField;
    qBillFooterTextOverrideText: TWideStringField;
    qBillFooterTextOverrideBold: TBooleanField;
    qBillFooterTextOverrideDoubleWidth: TBooleanField;
    qBillFooterTextOverrideDoubleHeight: TBooleanField;
    qBillFooterAlignmentLookup: TADOQuery;
    qBillFooterTextOverrideAlignmentName: TStringField;
    qOutletBillFooter: TADOQuery;
    qOutletBillFooterLineNumber: TSmallintField;
    qOutletBillFooterText: TWideStringField;
    qOutletBillFooterBold: TBooleanField;
    qOutletBillFooterDoubleWidth: TBooleanField;
    qOutletBillFooterDoubleHeight: TBooleanField;
    qOutletBillFooterAlignmentName: TStringField;
    qOutletBillFooterAlignment: TSmallintField;
    qLoadOutletBillFooter: TADOQuery;
    SmallintField3: TSmallintField;
    WideStringField2: TWideStringField;
    BooleanField4: TBooleanField;
    BooleanField5: TBooleanField;
    BooleanField6: TBooleanField;
    StringField4: TStringField;
    SmallintField4: TSmallintField;
    qSaveOutletBillFooterData: TADOQuery;
    SmallintField5: TSmallintField;
    WideStringField3: TWideStringField;
    BooleanField7: TBooleanField;
    BooleanField8: TBooleanField;
    BooleanField9: TBooleanField;
    StringField5: TStringField;
    SmallintField6: TSmallintField;
    dsOutletBillFooter: TDataSource;
    qGetOutletBillFooterText: TADOQuery;
    dsSurveyCodeSupplier: TDataSource;
    qSurveyCodeSupplier: TADOQuery;
    qSurveyCodeSupplierId: TIntegerField;
    qSurveyCodeSupplierValue: TStringField;
    qSurveyCodeSupplierMaximumCodeLength: TIntegerField;
    qSurveyCodeSupplierAztecName: TStringField;
    qOutletConfigsSurveyCodeSupplier: TIntegerField;
    qCLMDiscount: TADOQuery;
    qDiscountType: TADOQuery;
    qDiscountTypeId: TIntegerField;
    qDiscountTypevalue: TStringField;
    qDiscountsDiscountTypeName: TStringField;
    qDiscountsMaximumRate: TIntegerField;
    adoqSaveButtonSecurity: TADOQuery;
    adoqFoHRoles: TADOQuery;
    adoqFoHRolesSecurityTypeId: TSmallintField;
    adoqFoHRolesRoleId: TIntegerField;
    qOutletPrintConfigsDiscountSavingsOnBill: TBooleanField;
    qOutletPrintConfigsTotalSavingsOnBill: TBooleanField;
    qOutletConfigsOciusPinPadLoginId: TStringField;
    qOutletConfigsOciusPinPadPassword: TStringField;
    qOutletConfigsIPToSerialMapperStartPort: TIntegerField;
    qDiscountsAppliesToOrderLineFamily: TBooleanField;
    qGetTerminalsMultiDrawerMode: TBooleanField;
    qOutletSuggestedTipPercentage1: TBCDField;
    qOutletSuggestedTipPercentage2: TBCDField;
    qOutletSuggestedTipPercentage3: TBCDField;
    qTerminalPrintersOrderTicketsToPrint: TIntegerField;
    qGetTerminalsSoloMode: TBooleanField;
    qDiscountsDoNotDiscountNonServiceChargeExclusiveTaxes: TBooleanField;
    qDiscountsConfirmForfeit: TBooleanField;
    qDiscountsConfirmForfeitThresholdAmount: TCurrencyField;
    qDiscountsAmount: TBCDField;
    qOutletConfigsReconfirmTipEntry: TBooleanField;
    qOutletConfigsConfirmReversePaymentOfAnother: TBooleanField;
    dsQrCodeHeaderText: TDataSource;
    dsQrCodeFooterText: TDataSource;
    qCreateQrCodeTempTables: TADOQuery;
    TmpQrCodeHeaderText: TADOTable;
    TmpQrCodeHeaderTextLineNumber: TSmallintField;
    TmpQrCodeHeaderTextText: TWideStringField;
    TmpQrCodeHeaderTextBold: TBooleanField;
    TmpQrCodeHeaderTextDoubleWidth: TBooleanField;
    TmpQrCodeHeaderTextDoubleHeight: TBooleanField;
    TmpQrCodeHeaderTextAlignmentName: TStringField;
    TmpQrCodeHeaderTextAlignment: TSmallintField;
    qSaveQrCodeText: TADOQuery;
    TmpQrCodeFooterText: TADOTable;
    SmallintField1: TSmallintField;
    TmpQrCodeFooterTextText: TWideStringField;
    BooleanField1: TBooleanField;
    TmpQrCodeFooterTextDoubleWidth: TBooleanField;
    BooleanField3: TBooleanField;
    StringField3: TStringField;
    SmallintField2: TSmallintField;
    qOutletPrintConfigsPrintQrCode: TBooleanField;
    qOutletPrintConfigsCustomerVoucherWhenPay: TIntegerField;
    qSaveQrCodeOnReceiptText: TADOQuery;
    qCreateQrCodeOnReceiptTempTables: TADOQuery;
    TmpQrCodeOnReceiptFooterText: TADOTable;
    dsQrCodeOnReceiptFooterText: TDataSource;
    TmpQrCodeOnReceiptFooterTextPosition: TSmallintField;
    TmpQrCodeOnReceiptFooterTextLineNumber: TSmallintField;
    TmpQrCodeOnReceiptFooterTextAlignment: TSmallintField;
    TmpQrCodeOnReceiptFooterTextBold: TBooleanField;
    TmpQrCodeOnReceiptFooterTextDoubleHeight: TBooleanField;
    qOutletPrintConfigsQrCodeUrlForReceipt: TStringField;
    qOutletPrintConfigsPrintQrCodeOnReceipt: TBooleanField;
    qLoadQrCodeReceiptText: TADOQuery;
    TmpQrCodeOnReceiptFooterTextAlignmentName: TStringField;
    TmpQrCodeOnReceiptFooterTextText: TWideStringField;
    qTerminalDynamicFields: TADOQuery;
    qTerminalDynamicFieldsId: TIntegerField;
    qTerminalDynamicFieldsDisplayName: TStringField;
    qTerminalDynamicFieldsAztecPlaceHolderText: TStringField;
    qTerminalDynamicFieldsEposPlaceHolderText: TStringField;
    qTerminalDynamicFieldsReplacedBy: TIntegerField;
    qTerminalDynamicFieldsVisible: TBooleanField;
    TmpBarcodeHeaderText: TADOTable;
    TmpBarcodeHeaderTextLineNumber: TSmallintField;
    TmpBarcodeHeaderTextText: TWideStringField;
    TmpBarcodeHeaderTextAlignmentName: TStringField;
    TmpBarcodeHeaderTextBold: TBooleanField;
    TmpBarcodeHeaderTextDoubleWidth: TBooleanField;
    TmpBarcodeHeaderTextDoubleHeight: TBooleanField;
    TmpBarcodeHeaderTextAlignment: TSmallintField;
    TmpBarcodeFooterText: TADOTable;
    TmpBarcodeFooterTextLineNumber: TSmallintField;
    TmpBarcodeFooterTextText: TWideStringField;
    TmpBarcodeFooterTextAlignmentName: TStringField;
    TmpBarcodeFooterTextBold: TBooleanField;
    TmpBarcodeFooterTextDoubleWidth: TBooleanField;
    TmpBarcodeFooterTextDoubleHeight: TBooleanField;
    TmpBarcodeFooterTextAlignment: TSmallintField;
    dsBarcodeHeaderText: TDataSource;
    dsBarcodeFooterText: TDataSource;
    qCreateBarcodeTempTables: TADOQuery;
    qSaveBarcodeText: TADOQuery;
    qTerminalPrintersCustomDeviceID: TStringField;
    qOutletPrintConfigsAppendRefundData: TBooleanField;
    procedure DataModuleCreate(Sender: TObject); override;
    procedure qEditStreamsBeforeClose(DataSet: TDataSet);
    procedure qEditStreamsBeforePost(DataSet: TDataSet);
    procedure qEditStreamsprinteraddress2Validate(Sender: TField);
    procedure ValidateIPAddress(Sender: TField);
    procedure ValidateIPPort(Sender: TField);
    procedure qOutletConfigsIPAddressChange(Sender: TField);
    procedure qThemeTerminalEFTTimeoutsCalcFields(DataSet: TDataSet);
    procedure qThemeTerminalEFTTimeoutsBeforePost(DataSet: TDataSet);
    procedure qOutletConfigsScaleDisplayUnitSetText(Sender: TField;
      const Text: String);
    procedure qOutletConfigsScaleDecimalPlacesValidate(Sender: TField);
    procedure qOutletConfigsScaleDecimalPlacesSetText(Sender: TField;
      const Text: String);
    procedure qOutletConfigsScaleDisplayUnitValidate(Sender: TField);
    procedure qOutletPrintConfigsReportPrintStreamValidate(Sender: TField);
    procedure qOutletConfigsBeforePost(DataSet: TDataSet);
    procedure qGetTerminalsEPoSDeviceIDValidate(Sender: TField);
    procedure qGetTerminalsEPoSDeviceIDSetText(Sender: TField;
      const Text: String);
    procedure qClockoutticketFooterTextOverrideTextValidate(
      Sender: TField);
    procedure qClockoutticketFooterTextOverrideDoubleSizeValidate(
      Sender: TField);
    procedure qOutletConfigsKMSPrimaryServerIPAddressValidate(
      Sender: TField);
    procedure qOutletConfigsKMSBackupServerIPAddressValidate(
      Sender: TField);
    procedure qOutletConfigsKMSPrimaryServerPortValidate(Sender: TField);
    procedure qOutletConfigsKMSBackupServerPortValidate(Sender: TField);
    procedure NullableFieldSetText(Sender: TField; const Text: String);
    procedure qDiscountsMaximumDiscountGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure qBillFooterTextOverrideBeforeInsert(DataSet: TDataSet);
    procedure qBillFooterTextOverrideBeforePost(DataSet: TDataSet);
    procedure FooterTextDoubleSizeValidate(Sender: TField; TotalLength: Integer; ErrorFieldString: String);
    procedure qBillFooterTextOverrideDoubleWidthValidate(Sender: TField);
    procedure qOutletBillFooterDoubleWidthValidate(Sender: TField);
    procedure qBillFooterTextOverrideTextValidate(Sender: TField);
    procedure qOutletBillFooterTextValidate(Sender: TField);
    procedure qOutletConfigsSurveyCodeSupplierValidate(Sender: TField);
    procedure qOutletBillFooterTextSetText(Sender: TField;
      const Text: String);
    procedure qDiscountsMaximumRateGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure qOutletConfigsIPToSerialMapperStartPortValidate(
      Sender: TField);
    procedure TmpQrCodeFooterTextBeforePost(DataSet: TDataSet);
    procedure TmpQrCodeHeaderTextTextValidate(Sender: TField);
    procedure TmpQrCodeHeaderTextDoubleWidthValidate(Sender: TField);
    procedure TmpQrCodeFooterTextTextValidate(Sender: TField);
    procedure TmpQrCodeFooterTextDoubleWidthValidate(Sender: TField);
    procedure TmpQrCodeOnReceiptHeaderTextBeforePost(DataSet: TDataSet);
    procedure TmpQrCodeOnReceiptFooterTextDoubleWidthValidate(
      Sender: TField);
    procedure TmpQrCodeOnReceiptFooterTextTextValidate(Sender: TField);
    procedure TmpBarcodeHeaderTextBeforePost(DataSet: TDataSet);
    procedure TmpBarcodeFooterTextBeforePost(DataSet: TDataSet);
    procedure TmpBarcodeHeaderTextTextValidate(Sender: TField);
    procedure TmpBarcodeHeaderTextDoubleWidthValidate(Sender: TField);
    procedure TmpBarcodeFooterTextTextValidate(Sender: TField);
    procedure TmpBarcodeFooterTextDoubleWidthValidate(Sender: TField);
  private
    { Private declarations }
    //Fdivisionlistid : Integer;
    FVirtualServerDeviceLimit: smallint;
    function ScaleConfigValid(Target: TField): boolean;
    function ReportPrintStreamValid(Sender: TField): Boolean;
    function isValidEPoSDEviceID(const Text: String): Boolean;
    procedure RaisePortRangeException(ErrorMessage, PortRange: String);
    function GetSurveyCodeID(SupplierName: String): Integer;
    procedure CheckSupplierCodeVersionOK(ChosenSupplierCode, SupplierCodeID: Integer;
      SupplierCodeName, LowSiteVersion: String);
  public
    { Public declarations }
    debugNewMethod: integer;
    Logon_Name: string;
    NoDiscAdmissions, NoDiscDonations : boolean;
    logTime1: TDateTime;
    procedure LogDuration(const what: String);

    function GetSiteCode : Integer;
    function GetGatewayIPForTerminal(ASiteCode: Integer): String;
    procedure updateDiscountPanelButton(DiscountId: Integer);
    procedure updateVirtualServerDeviceLimit(SiteCode: Integer);
    function ISSiteVersionOK(version : string) : boolean;
    property VirtualServerDeviceLimit : smallint read FVirtualServerDeviceLimit;
    function GetSiteScrollingMessageOverride(ASiteCode: integer): Integer;
    function isLowVersionSite(ReqDBVer: String;
      SiteCode: Integer): Boolean;
    function ParentHasIP_printerWithCashDrawer(SiteCode, ParentDeviceID: Integer; IPPrinterID: LargeInt): Boolean;
    function IsMatchDayStockEnabled(): Boolean;
  end;

function ValidIPv4Address(IPAddress: String;
                          out ErrorMessage: String): Boolean;

function ValidIPPort(IPPort: Integer;
                     out ErrorMessage: String): Boolean;

var
  dmADO: TdmADO;
  MutexHandle: THandle;

implementation

uses useful, uSimpleLocalise, uAztecLog,
  uUpdateTerminals, uDatabaseVersion, uGlobals;

{$R *.dfm}

procedure BatchExecute(batch: TStrings; query: TADOQuery);
var
  line_no, p: integer;
  curline: string;
  DBDestination: string;
begin
  query.SQL.clear;
  for line_no := 1 to pred(batch.count) do
  begin
    curline := batch.Strings[line_no];

    p := pos('FILENAME = ', CurLine);

    if p > 0 then
      CurLine := Copy(CurLine, 1, 15) + DBDestination + Copy(CurLine, 65, 15);

    if lowercase(trim(curline)) = 'go' then
    begin
      query.ExecSQL;
      query.sql.clear;
    end
    else
      query.sql.add(curline);
  end;
  if query.SQL.Count > 0 then
    query.ExecSQL;
end;

procedure TdmADO.DataModuleCreate(Sender: TObject);
var
  ModuleVersion, MinDBVersion: array[0..25] of char;
begin
  inherited;

  if LoadString(hInstance, 12, ModuleVersion, sizeof(ModuleVersion)) = 0 then
  begin
    ShowMessage('Unable to load version information.' + #13 +
      'Aztec Theme Modelling will now terminate');
    Halt;
  end;

  if LoadString(hInstance, 13, MinDBVersion, sizeof(MinDBVersion)) = 0 then
  begin
    ShowMessage('Unable to load version information.' + #13 +
      'Aztec Theme Modelling will now terminate');
    Halt;
  end;

  sleep(10);

end;

procedure TdmADO.qEditStreamsBeforeClose(DataSet: TDataSet);
var
  SiteCode : Integer;
begin
  inherited;
  with dmADO do
  begin
    if qEditStreams.State = dsEdit then
      qEditStreams.post;
    qEditStreams.UpdateBatch;

    SiteCode := qGetTerminals.DataSource.DataSet.FieldByName('SiteCode').AsInteger;
    qRun.SQL.text :=
    'Delete From ThemeEposPrinterStream where SiteCode = ' +IntToStr(SiteCode) +
    'Insert Into ThemeEposPrinterStream '+
    'SELECT ' + IntToStr(SiteCOde)+ ' ,terminal ,printstreamid, 1, printeraddress '+
    'FROM #tmpstreams '+
    'WHERE PrinterAddress <> ' + IntToStr(-1)+
    ' UNION '+
    'SELECT ' + IntToStr(SiteCOde)+ ' ,terminal ,printstreamid, 2, printeraddress2 '+
    'FROM #tmpstreams '+
    'WHERE PrinterAddress2 <> ' + IntToStr(-1);
    qRun.execsql;
//** This should do exactly the same as the SQL above it is just seperated to debug
//** any problems that do not get raised when you use a command with multiple statements
//** such as primary/foreign key violations these
//**    qRun.SQL.text :=
//**    'Delete From ThemeEposPrinterStream where SiteCode = ' +IntToStr(SiteCode) ;
//**    qRun.execsql;
//**
//**    qRun.SQL.text :=
//**    'Insert Into ThemeEposPrinterStream '+
//**    'SELECT ' + IntToStr(SiteCOde)+ ' ,terminal ,printstreamid, 1, printeraddress '+
//**    'FROM #tmpstreams '+
//**    'WHERE PrinterAddress <> ' + IntToStr(-1);
//**    qRun.execsql;
//**
//**    qRun.SQL.text :=
//**    'Insert Into ThemeEposPrinterStream '+
//**    'SELECT ' + IntToStr(SiteCOde)+ ' ,terminal ,printstreamid, 2, printeraddress2 '+
//**    'FROM #tmpstreams '+
//**    'WHERE PrinterAddress2 <> ' + IntToStr(-1);
//**    qRun.execsql;
//**
  end;
end;

procedure TdmADO.qEditStreamsBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (DataSet.FieldByName('PrinterAddress').AsString = DataSet.FieldByName('PrinterAddress2').AsString ) and
     (DataSet.FieldByName('PrinterAddress').AsString <> '-1') then
  begin
    MessageDlg('Printer and Printer 2 cannot be the same', mtError, [mbOK], 0);
    Abort;
  end;
end;

procedure TdmADO.qEditStreamsprinteraddress2Validate(Sender: TField);
begin
  inherited;
  if (qEditStreams.FieldByName('PrinterAddress').AsString = '-1') and (Sender.AsString <> '-1' ) then
    Raise Exception.Create('Printer must be defined before specifying second printer')
  else if (Sender.AsString = qEditStreams.FieldByName('PrinterAddress').AsString) and (Sender.AsString <> '-1' ) then
    Raise Exception.Create('Printer 2 cannot be the same as Printer1');
end;

function TdmADO.GetSiteCode: Integer;
begin
  Result := dmThemeData.qOutlets.FieldByName('SiteCode').AsInteger;
end;

function TdmADO.GetGatewayIPForTerminal(ASiteCode: Integer): String;
// Returns the ServerIP address that a terminal is assigned to.
// This is used as the gateway IP for the terminal.
begin
  Result := '127.0.0.1';
  with dmADO.adoqRun do
  begin
    Close;
    SQL.Text := 'select IPAddress from ThemeOutletConfigs where SiteCode = '+
      IntToStr(ASiteCode);
    Open;
    if Recordcount > 0 then
      Result := FieldByName('IPAddress').AsString;
    Close;
  end;
end;

procedure TdmADO.ValidateIPAddress(Sender: TField);
var
  ipAddress: string;
  ErrorMessage: String;
begin
  inherited;

  if not Sender.IsNull then
  begin
    ipAddress := sender.AsString;

    if not ValidIPv4Address(ipAddress, ErrorMessage) then
      raise Exception.Create(ErrorMessage);
  end;
end;

procedure TdmADO.updateDiscountPanelButton(DiscountId: Integer);
begin
   with qRun do
      begin
        close;
        SQL.Clear;
        SQL.Add('UPDATE [dbo].[ThemePanelButton_repl] SET LMDT = GETDATE()');
        SQL.Add('WHERE [ButtonTypeChoiceID] = ');
        SQL.Add('(');
        SQL.Add('   SELECT [ID]');
        SQL.Add('   FROM [dbo].[ThemeButtonTypeChoiceLookup]');
        SQL.Add('   WHERE [Name] = ''ApplyBillDiscount''');
        SQL.Add(')');
        SQL.Add('AND [ButtonTypeChoiceAttr01] = ' + QuotedStr(IntToStr(DiscountId)));
        ExecSQL;
     end;
end;

procedure TdmADO.qOutletConfigsIPAddressChange(Sender: TField);
begin
  inherited;
  if Trim(Sender.OldValue) <> Trim(Sender.NewValue) then
  begin
    // ensure that Mobile Ordering Terminals have their IPAddress updated
    ADOqRun.SQL.Text := Format('update ThemeEposDevice set IPAddress = %s '+
      'where IPAddress = %s and SiteCode = %d and IsServer = 0 and HardwareType = 10',
      [QuotedStr(Sender.NewValue), QuotedStr(Sender.OldValue), qOutletConfigs.FieldByName('Sitecode').AsInteger]);
    adoqRun.ExecSQL;

    // check whether servers can be updated
    ADOqRun.SQL.Text := Format(
      'declare @SiteCode int '+
      'set @Sitecode = %d '+
      'select * from ThemeEposDevice a '+
      'join ( '+
      '  select ServerID from ThemeEposDevice '+
      '  where SiteCode = @SiteCode '+
      '  group by ServerID having count(*) > %d and ServerID is not null '+
      '  union '+
      '  select distinct EposDeviceID from ThemeEposPrinter where SiteCode = @SiteCode '+
      '  group by EposDeviceID '+
      ') sub on a.EPOSDeviceID = sub.ServerID '+
      'where IsServer = 1 and IPAddress = %s and SiteCode = @SiteCode',
      [qOutletConfigs.FieldByName('Sitecode').AsInteger,
      VirtualServerDeviceLimit,
      QuotedStr(Sender.NewValue)]
    );
    ADOqRun.open;
    if ADOqRun.RecordCount > 0 then
    begin
      ADOqRun.Close;
      raise Exception.Create('Cannot change servers on site to Virtual servers as they have printers or too many terminals.' + #13#10#10 +
           'The limit for virtual server terminals on this site is ' + IntToStr(VirtualServerDeviceLimit) + '.');
    end;
    ADOqRun.Close;
    // update "Virtual" EPOS servers when site PC address changed
    ADOqRun.SQL.Text := Format('update ThemeEposDevice set IPAddress = %s '+
      'where IPAddress = %s and SiteCode = %d and IsServer = 1 and HardwareType in '+
      '(select HardwareType from TerminalHardware where ClassName like ''%%AztecEposDevice%%'')',
      [QuotedStr(Sender.NewValue), QuotedStr(Sender.OldValue), qOutletConfigs.FieldByName('Sitecode').AsInteger]);
    ADOqRun.ExecSQL;
    qGetTerminals.Requery();
  end;
end;

procedure TdmADO.qThemeTerminalEFTTimeoutsCalcFields(DataSet: TDataSet);
var
  TotalTimeout : integer;
  mins, secs : word;
begin
  TotalTimeout := Dataset.FieldByName('TimeoutTime').AsInteger *
                Dataset.FieldByName('TimeoutRetryCount').Asinteger;

  secs := TotalTimeout mod 60;
  mins := TotalTimeout div 60;

  Dataset.FieldByName('TotalTimeout').AsString :=
        formatDateTime('hh:mm:ss',(EncodeTime(0, mins, secs, 0)));

end;

function TdmADO.ISSiteVersionOK(version: string): boolean;
var
  versionOK : boolean;
begin
  with qRun do
  begin
    close;
    SQL.Clear;
    SQL.Add('DECLARE @Sitecode int ');
    SQL.Add('DECLARE @Version varchar(50) ');
    SQL.Add('SET @SiteCode = '+IntToStr(GetSiteCode));
    SQL.Add('SET @Version = '+QuotedStr(version));
    SQL.Add('SELECT Count(*) AS VersionCount ');
    SQL.Add('FROM ');
    SQL.Add('	commsversions HOVersion ');
    SQL.Add('		JOIN commsversions SiteVersion ON HOVersion.SiteCode = 0 and SiteVersion.sitecode = @SiteCode ');
    SQL.Add('WHERE ');
    SQL.Add('	(dbo.fn_strVerToInt64(HOVersion.[DBVersion]) > dbo.fn_strVerToInt64(SiteVersion.[DBVersion])) ');
    SQL.Add('	AND (dbo.fn_strVerToInt64(SiteVersion.[DBVersion]) < dbo.fn_strVerToInt64(@Version)) ');
    Open;
    versionOK := FieldByName('VersionCount').AsInteger <= 0;
    result := versionOK;
  end;
end;

procedure TdmADO.qThemeTerminalEFTTimeoutsBeforePost(DataSet: TDataSet);
var
  TimeoutTime : integer;
  TimeOutCount : integer;
begin
    TimeoutTime := Dataset.FieldByName('TimeoutTime').AsInteger;
    TimeOutCount := Dataset.FieldByName('TimeoutRetryCount').AsInteger;
    if (TimeoutTime < 1) or (timeoutTime > 59) then
    begin
      MessageDlg('Timeout Interval must be between 1 and 59', mtError, [mbOK], 0);
      Abort;
    end;

    if (TimeOutCount < 1) or (TimeOutCount > 9) then
    begin
      MessageDlg('Timeout Attempts must be between 1 and 9', mtError, [mbOK], 0);
      Abort;
    end;
end;

function ValidIPv4Address(IPAddress: String;
                          out ErrorMessage: String): Boolean;
var
  i: integer;
  octets: TStringList;
  octet: Integer;
begin
  ErrorMessage := '';
  if Length(ipAddress) > 0 then
  begin
    octets := TStringList.Create;
    try
      octets.Delimiter := '.';
      octets.DelimitedText := ipAddress;

      if Pos(' ',ipAddress) <> 0 then
        ErrorMessage := 'IP Address contains spaces.'
      else if octets.Count <> 4 then
        ErrorMessage := 'IP Address is not complete.'
      else begin
        i := 0;
        while (i <= (octets.Count - 1)) and (ErrorMessage = '') do
        begin
          if octets[i] = '' then
            ErrorMessage := 'IP Address is not complete'
          else begin
            try
              octet := StrToInt(octets[i]);
              if not (octet in [0..255]) then
                ErrorMessage := 'IP Address contains invalid octets.';
            except
              on e: EConvertError do
                ErrorMessage := 'IP Address contains invalid characters.';
            end;
          end;
          Inc(i)
        end;
      end;
    finally
      octets.Free;
    end;
  end;
  Result := ErrorMessage = '';
end;

function ValidIPPort(IPPort: Integer;
                     out ErrorMessage: String): Boolean;
begin
  ErrorMessage := '';

  if not ((IPPort >= 0) and (IPPort <= 65535)) then
    ErrorMessage := 'IP port is out of range.  Port must be between 0 and 65535.';

  Result := ErrorMessage = '';
end;

function TdmADO.GetSiteScrollingMessageOverride(
  ASiteCode: integer): Integer;
var
  qry: TAdoQuery;
begin
  qry := TAdoQuery.Create(nil);
  qry.Connection := AztecConn;
  qry.SQL.Text := Format(
    'select top 1 ScrollingMessageOverrideId from ThemeEposDevice '+
    'where SiteCode = %d and ScrollingMessageOverrideId is not null', [ASiteCode]);
  qry.Open;
  if qry.RecordCount < 1 then
    Result := -1
  else
    Result := qry.Fields[0].AsInteger;
  qry.Close;
  qry.Free;
end;

procedure TdmADO.qOutletConfigsScaleDisplayUnitSetText(Sender: TField;
  const Text: String);
begin
  inherited;
  if Text = '' then
    qOutletConfigsScaleDisplayUnit.AsVariant := null
  else
    qOutletConfigsScaleDisplayUnit.Value := Text;
end;

procedure TdmADO.qOutletConfigsScaleDecimalPlacesValidate(Sender: TField);
begin
  inherited;
  if not ScaleConfigValid(dmADO.qOutletConfigsScaleDecimalPlaces) then
  begin
    MessageDlg('Cannot remove the scale decimal places unit as there exists terminals with scale devices attached.',
      mtError,[mbOK],0);
    Abort;
  end;
end;

procedure TdmADO.qOutletConfigsScaleDecimalPlacesSetText(Sender: TField;
  const Text: String);
begin
  inherited;
  if Text = '' then
    qOutletConfigsScaleDecimalPlaces.AsVariant := null
  else
    qOutletConfigsScaleDecimalPlaces.AsString := Text;
end;

procedure TdmADO.qOutletConfigsScaleDisplayUnitValidate(Sender: TField);
begin
  inherited;
  if not ScaleConfigValid(dmADO.qOutletConfigsScaleDisplayUnit) then
  begin
    MessageDlg('Cannot remove the scale display unit as there exists terminals with scale devices attached.',
      mtError,[mbOK],0);
    Abort;
  end;
end;

function TdmADO.ScaleConfigValid(Target: TField): boolean;
begin
  inherited;
  Result := True;
  if VarisNull(Target.AsVariant) then
  begin
    dmADO.adoqRun.Close;
    dmADO.adoqRun.SQL.Text := Format(
      'declare @SiteCode int '+
      'set @Sitecode = %d '+
      'select * from ThemeEposDevice ted '+
      'join ThemeEPoSPrinter tep '+
      'on ted.EpoSDeviceID = tep.EPoSDeviceID '+
      'join ThemePrinterType tpt '+
      'on tpt.PrinterTypeID = tep.PrinterType '+
      'where ted.SiteCode = @SiteCode and tpt.IsScale = 1',
      [dmADO.qOutletConfigs.FieldByName('Sitecode').AsInteger]);
    dmADO.adoqRun.open;
    if dmADO.adoqRun.RecordCount > 0 then
    begin
      Result := False;
    end;
    dmADO.adoqRun.Close;
  end;
end;


function TdmADO.ReportPrintStreamValid(Sender: TField): Boolean;
var
  PStreamName: String;
  tmpstr: String;
begin

  with adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select ps.Name as PSName, tep.name as PName, tep.PortNumber as PortNumber, ted.Name as TName');
    SQL.Add('from ThemeEposPrinterStream teps');
    SQL.Add('join ThemeEposPrinter tep');
    SQL.Add('on tep.PrinterID = teps.PrinterID and tep.SiteCode = teps.SiteCode');
    SQL.Add('join ThemeEposDevice ted');
    SQL.Add('on ted.EPoSDeviceID = tep.EposDeviceID');
    SQL.Add('join ac_PrintStream ps');
    SQL.Add('on teps.PrintStreamID = ps.ID');
    SQL.Add('where ted.SiteCode = ' + IntToStr(GetSiteCode));
    SQL.Add('and tep.PrinterType in ' + BAD_REPORT_PRINTERS);
    SQL.Add('and teps.PrintStreamID = ' + Sender.AsString);
    Open;

    Result := RecordCount = 0;

    tmpstr := '';
    while not EOF do
    begin
      PStreamName := FieldByName('PSName').AsString;
      tmpstr := tmpstr + #13#10 + Format('''%s'' attached to ''%s''',[FieldByName('PName').AsString,FieldByName('TName').AsString]);
      if not FieldByName('PortNumber').IsNull then
        tmpstr := tmpstr + Format(' on port %d',[FieldByName('PortNumber').AsInteger]);
      Next;
    end
  end;

  if not Result then
    MessageDlg(Format('Print stream %s uses printers that are incompatible with report printing:'
              + #13#10 + tmpstr + #13#10 + #13#10 +
              'Choose another ''Report Print Group'' print stream or remove the printers from the print stream.',
              [QuotedStr(StringReplace(PStreamName,'&','&&',[rfReplaceAll])), tmpstr]),
              mtError,
              [mbOK],
              0);
end;

procedure TdmADO.qOutletPrintConfigsReportPrintStreamValidate(
  Sender: TField);
begin
  inherited;
  if not ReportPrintStreamValid(Sender) then
    Abort;
end;

procedure TdmADO.qOutletConfigsBeforePost(DataSet: TDataSet);
begin
  inherited;
  with qOutletConfigs do
    begin
      if FieldByName('FastEFTAmount').Value = NULL then
         FieldByName('FastEFTAmount').Value := 0;

      if FieldByName('EFTPreAuthAmount').Value = NULL then
         FieldByName('EFTPreAuthAmount').Value := 0;
    end;
end;

function TdmADO.isLowVersionSite(ReqDBVer : String; SiteCode: Integer) : Boolean;
var
  DBVer, DBRequiredVer : TDatabaseVersion;
begin
  Result := False;
  with dmADO.qRun do
  begin
    Close;
    SQL.Text:= Format('SELECT DBVersion FROM CommsVersions WHERE SiteCode = %d', [SiteCode]);
    Open;

    // if DBVersion is blank, its probably because the site has just been added and there
    // has been no comms yet and therefore no record in CommsVersions.  In this case it
    // is likely that the Site version will be the same as the Head Office version and at least
    // at the required version.
    if (FieldByName('DBVersion').AsString = '') then
    begin
      Result := FALSE;
      Exit;
    end;

    DBRequiredVer := TDatabaseVersion.Create(ReqDBVer);
    DBVer := TDataBaseVersion.Create(FieldByName('DBVersion').AsString);
    // if the returned DBVersion is less than the required version then the result will
    // return true.

    if DBVer.IsLowerThan(DBRequiredVer) then
       Result := TRUE;

    DBVer.Free;
  end;
end;

procedure TdmADO.qGetTerminalsEPoSDeviceIDValidate(Sender: TField);
begin
  inherited;
  if not isValidEPoSDEviceID((Sender as TField).AsString) then
    ABORT;
end;

procedure TdmADO.qGetTerminalsEPoSDeviceIDSetText(Sender: TField;
  const Text: String);
begin
  inherited;
  if not isValidEPoSDEviceID(Text) then
    ABORT
  else
    (Sender as TField).AsString := Text;
end;

function TdmADO.isValidEPoSDEviceID(const Text: String): Boolean;
var
  maxEPoSDEviceID: Integer;
begin
  Result := True;

  if Text = '' then
    Exit;

  if isLowVersionSite('3.5.8.0', qGetTerminalsSiteCode.AsInteger) then
     maxEPoSDEviceID := 9999
  else
     maxEPoSDEviceID := 32767;

  if StrToIntDef(Text,MaxInt) > maxEPoSDEviceID then
  begin
    MessageDlg('Device ID cannot be greater than '+IntToStr(maxEposDeviceID)+'.', mtError, [mbOK], 0);
    Result := False;
  end;
end;

procedure TdmADO.qClockoutticketFooterTextOverrideTextValidate(
  Sender: TField);
var
  TotalLength: Integer;
begin
  TotalLength := Length(Sender.AsString);
  if (TotalLength > REPORT_LINE_LENGTH_DOUBLE_WIDE) and qClockoutTicketFooterTextOverride.FieldByName('DoubleSize').AsBoolean  then
    raise Exception.Create(Format('Only %d characters can be entered when ''Double Size'' is checked.',[REPORT_LINE_LENGTH_DOUBLE_WIDE]));
end;

procedure TdmADO.qClockoutticketFooterTextOverrideDoubleSizeValidate(
  Sender: TField);
begin
  FooterTextDoubleSizeValidate(Sender, Length(qClockoutticketFooterTextOverrideText.AsString), 'Double Size');
end;

procedure TdmADO.qBillFooterTextOverrideDoubleWidthValidate(
  Sender: TField);
begin
  FooterTextDoubleSizeValidate(Sender, Length(qBillFooterTextOverrideText.AsString), 'Double Width');
end;

procedure TdmADO.FooterTextDoubleSizeValidate(Sender: TField; TotalLength: Integer; ErrorFieldString: String);
begin
  if (Sender.AsBoolean = TRUE) and (TotalLength > REPORT_LINE_LENGTH_DOUBLE_WIDE) then
    raise Exception.Create(Format(QuotedStr(ErrorFieldString) + ' can only be checked if there are %d or less characters in the text.',[REPORT_LINE_LENGTH_DOUBLE_WIDE]));
end;

procedure TdmADO.qOutletConfigsKMSPrimaryServerIPAddressValidate(
  Sender: TField);
begin
  inherited;

  ValidateIPAddress(Sender);
end;

procedure TdmADO.qOutletConfigsKMSBackupServerIPAddressValidate(
  Sender: TField);
begin
  inherited;

  ValidateIPAddress(Sender);
end;

procedure TdmADO.ValidateIPPort(Sender: TField);
var
  IPPort: Integer;
  ErrorMessage: String;
begin
  inherited;

  if not Sender.IsNull then
  begin

    IPPort := sender.AsInteger;

    if not ValidIPPort(IPPort, ErrorMessage) then
      raise Exception.Create(ErrorMessage);
  end;
end;

procedure TdmADO.qOutletConfigsKMSPrimaryServerPortValidate(
  Sender: TField);
begin
  inherited;

  ValidateIPPort(Sender);
end;

procedure TdmADO.qOutletConfigsKMSBackupServerPortValidate(Sender: TField);
begin
  inherited;

  ValidateIPPort(Sender);
end;

procedure TdmADO.NullableFieldSetText(Sender: TField;
  const Text: String);
begin
  inherited;
  if Text = '' then
    Sender.Value := null
  else
    Sender.Value := Text;
end;

procedure TdmADO.qDiscountsMaximumDiscountGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if VarIsNull(Sender.Value) or (Sender.Value = 0) then
    Text := ''
  else
    Text := Format('%f',[(Sender.AsFloat)/100]);
end;


procedure TdmADO.qBillFooterTextOverrideBeforeInsert(DataSet: TDataSet);
begin
  if (qBillFooterTextOverride.RecordCount > 14) then
     abort;
end;

procedure TdmADO.qBillFooterTextOverrideBeforePost(DataSet: TDataSet);
begin
 if (qBillFooterTextOverrideText.AsString = '') then
 begin
   qBillFooterTextOverrideBold.AsBoolean := FALSE;
   qBillFooterTextOverrideDoubleWidth.AsBoolean := FALSE;
   qBillFooterTextOverrideDoubleHeight.AsBoolean := FALSE;
   qBillFooterTextOverrideAlignment.AsInteger := 1;  // default to centre alignment
 end;
end;

procedure TdmADO.qOutletBillFooterDoubleWidthValidate(Sender: TField);
begin
  FooterTextDoubleSizeValidate(Sender, Length(qOutletBillFooterText.AsString), 'Double Width');
end;

procedure TdmADO.qBillFooterTextOverrideTextValidate(Sender: TField);
var
  TotalLength: Integer;
begin
  TotalLength := Length(Sender.AsString);
  if (TotalLength > REPORT_LINE_LENGTH_DOUBLE_WIDE) and qBillFooterTextOverride.FieldByName('DoubleWidth').AsBoolean  then
    raise Exception.Create(Format('Only %d characters can be entered when ''Double Width'' is checked.',[REPORT_LINE_LENGTH_DOUBLE_WIDE]));
end;

procedure TdmADO.qOutletBillFooterTextSetText(Sender: TField;
  const Text: String);
begin
  inherited;
  Sender.AsString := Trim(Text);
end;

procedure TdmADO.qOutletBillFooterTextValidate(Sender: TField);
var
  TotalLength: Integer;
begin
  TotalLength := Length(Sender.AsString);
  if (TotalLength > REPORT_LINE_LENGTH_DOUBLE_WIDE) and qOutletBillFooter.FieldByName('DoubleWidth').AsBoolean  then
    raise Exception.Create(Format('Only %d characters can be entered when ''Double Width'' is checked.',[REPORT_LINE_LENGTH_DOUBLE_WIDE]));
end;

procedure TdmADO.qOutletConfigsSurveyCodeSupplierValidate(Sender: TField);
var
  ChosenSurveySupplierCode: Integer;
begin
  inherited;
  ChosenSurveySupplierCode := (Sender as TField).AsInteger;

  CheckSupplierCodeVersionOK(ChosenSurveySupplierCode, GetSurveyCodeID('MarketForce'), 'Market Force', '3.7.0.0' );
  CheckSupplierCodeVersionOK(ChosenSurveySupplierCode, GetSurveyCodeID('Clarabridge'), 'Clarabridge', '3.8.3.0' );
  CheckSupplierCodeVersionOK(ChosenSurveySupplierCode, GetSurveyCodeID('Feeditback'), 'Feeditback', '3.8.3.0');
end;

procedure TdmADO.CheckSupplierCodeVersionOK(ChosenSupplierCode, SupplierCodeID : Integer;
                                                SupplierCodeName, LowSiteVersion : String);
begin
  if (ChosenSupplierCode = SupplierCodeID)and not dmThemeData.SiteVersionAtLeast(LowSiteVersion) then   // dmADO.ISSiteVersionOK
  begin
    MessageDlg(SupplierCodeName + ' may not be chosen as a survey code supplier'#13#10 +
               'for sites using an Aztec version lower than ' + LowSiteVersion,
               mtInformation,
               [mbOK],
               0);
    Abort;
  end;
end;

function TdmADO.GetSurveyCodeID(SupplierName: String) : Integer;
begin
  with adoqRun do
  begin
    SQL.Clear;
    SQL.Add('select Id from ThemeAppendSurveyNumberTypeLookup where Value = ' + QuotedStr(SupplierName) );
    Open;
    result := FieldByName('Id').AsInteger;
    Close;
  end;
end;

procedure TdmADO.qDiscountsMaximumRateGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if VarIsNull(Sender.Value) or (Sender.Value = 0) then
    Text := ''
  else
    Text := Format('%d',[Sender.AsInteger]);
end;

procedure TdmADO.updateVirtualServerDeviceLimit(SiteCode: Integer);
begin
  // default value is 3 for when VirtualServerDeviceList is not defined globally or for site
  with adoqRun do
  try
    SQL.Clear;
    SQL.Add('DECLARE @Result varchar(10) ');
    SQL.Add(Format('exec sp_GetConfigurationResult %d,%s,@Result output', [SiteCode, QuotedStr('VirtualServerDeviceLimit')]));
    SQL.Add(' SELECT ' +
            '   CASE ');
    SQL.Add(Format(' WHEN @Result IS NULL THEN CAST(%d AS smallint) ', [MIN_VIRTUAL_DEVICE_LIMIT]));
    SQL.Add(Format(' WHEN (CAST(@Result AS smallint) > %d) THEN CAST(%d AS smallint) ', [MAX_VIRTUAL_DEVICE_LIMIT, MAX_VIRTUAL_DEVICE_LIMIT]));
    SQL.Add(Format(' WHEN (CAST(@Result AS smallint) < %d) THEN CAST(%d AS smallint) ', [MIN_VIRTUAL_DEVICE_LIMIT, MIN_VIRTUAL_DEVICE_LIMIT]));
    SQL.Add('        ELSE CAST(@Result AS smallint) ' +
            '   END AS Setting ');
     try
      Open;
      FVirtualServerDeviceLimit := FieldByName('Setting').AsInteger;
    except
      FVirtualServerDeviceLimit := MIN_VIRTUAL_DEVICE_LIMIT;
    end;
  finally
    Close;
    SQL.Clear;
  end;
end;

function TdmADO.ParentHasIP_printerWithCashDrawer(SiteCode, ParentDeviceID: Integer; IPPrinterID: LargeInt): Boolean;
begin
  with adoqRun do
  try
    Close;
    SQL.Text :=
      Format('SELECT CAST(CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END AS bit) AS HasIPPrinterWithCashDrawer ' +
             'FROM ThemeEposPrinter ' +
             'WHERE SiteCode = %d ' +
             'AND EPoSDeviceID = %d ' +
             'AND PrinterID <> %d ' +
             'AND HasCashDrawer = 1 ' +
             'AND PrinterType IN ' +
             '  (SELECT PrinterTypeID FROM ThemePrinterType ' +
             '   WHERE IPComms = 1 AND IsPrinter = 1 AND ISNULL(CashDrawerCommand, '''') <> '''')',
             [SiteCode, ParentDeviceID, IPPrinterID]);
    Open;
    First;
    Result := FieldByName('HasIPPrinterWithCashDrawer').AsBoolean;
  finally
    Close;
    SQL.Clear;
  end
end;

procedure TdmADO.qOutletConfigsIPToSerialMapperStartPortValidate(
  Sender: TField);
var
  PortNumber : Integer;
begin
  inherited;
  PortNumber := Sender.AsInteger;
  ValidateIPPort(Sender);
  if (PortNumber >= 1014) and (PortNumber <= 5000) then
    RaisePortRangeException('Ports %s are reserved for OS functions and cannot be used - ' +
        'please select a start port which leaves the used ports outside of this range.', '1024-5000')
  else if (PortNumber >= 15190) and (PortNumber <= 16500) then
    RaisePortRangeException('Ports %s are reserved for till communications and cannot be used - ' +
        'please select a start port which leaves the used ports outside of this range.', '15200-16500')
  else if (PortNumber > 65526) then
    RaisePortRangeException('Cannot select a port above %s, as the end of the port range would be ' +
        'higher than the maximum port of 65536. Please select a lower port.', '65526');
end;

procedure TdmADO.RaisePortRangeException(ErrorMessage, PortRange : String);
begin
  Raise Exception.Create(Format(ErrorMessage, [PortRange]))
end;

function TdmADO.IsMatchDayStockEnabled(): Boolean;
begin
  with adoqRun do
  begin
    SQL.Clear;
    SQL.Add('SELECT dbo.fn_GetConfigurationSetting(''EnableMatchDayStock'') AS EnableMatchDayStock');
    Open;
    Result := FieldByName('EnableMatchDayStock').AsString = '1';
    Close;
  end;
end;

procedure TdmADO.TmpQrCodeFooterTextBeforePost(DataSet: TDataSet);
var
        errorLine : integer;
        errorLocation: string;
begin
  inherited;
  if (Length(DataSet.FieldByName('Text').AsString) > REPORT_LINE_LENGTH_DOUBLE_WIDE) AND DataSet.FieldByName('DoubleWidth').AsBoolean then
  begin
        errorLocation := 'Header';
        if Dataset.Name = 'TmpQrCodeFooterText' then
                errorLocation := 'Footer';
        errorLine := DataSet.FieldByName('LineNumber').AsInteger;

        raise EParserError.Create(Format('%s Line %d' + #13#10 + 'Text cannot be greater than %d characters if Double Width is selected.',[errorLocation, errorLine, REPORT_LINE_LENGTH_DOUBLE_WIDE]));
  end;
end;

procedure TdmADO.TmpQrCodeHeaderTextTextValidate(Sender: TField);
var
  TotalLength: Integer;
begin
  TotalLength := Length(Sender.AsString);
  if (TotalLength > REPORT_LINE_LENGTH_DOUBLE_WIDE) and TmpQrCodeHeaderText.FieldByName('DoubleWidth').AsBoolean  then
    raise Exception.Create(Format('Only %d characters can be entered when ''Double Width'' is checked.',[REPORT_LINE_LENGTH_DOUBLE_WIDE]));
end;

procedure TdmADO.TmpQrCodeHeaderTextDoubleWidthValidate(Sender: TField);
begin
  FooterTextDoubleSizeValidate(Sender, Length(TmpQrCodeHeaderTextText.AsString), 'Double Width');
end;

procedure TdmADO.TmpQrCodeFooterTextTextValidate(Sender: TField);
var
  TotalLength: Integer;
begin
  TotalLength := Length(Sender.AsString);
  if (TotalLength > REPORT_LINE_LENGTH_DOUBLE_WIDE) and TmpQrCodeFooterText.FieldByName('DoubleWidth').AsBoolean  then
    raise Exception.Create(Format('Only %d characters can be entered when ''Double Width'' is checked.',[REPORT_LINE_LENGTH_DOUBLE_WIDE]));
end;

procedure TdmADO.TmpQrCodeFooterTextDoubleWidthValidate(Sender: TField);
begin
  FooterTextDoubleSizeValidate(Sender, Length(TmpQrCodeFooterTextText.AsString), 'Double Width');
end;

procedure TdmADO.TmpQrCodeOnReceiptHeaderTextBeforePost(DataSet: TDataSet);
var
  errorLine : integer;
  errorLocation: string;
begin
  inherited;
  if (Length(DataSet.FieldByName('Text').AsString) > REPORT_LINE_LENGTH_DOUBLE_WIDE) AND DataSet.FieldByName('DoubleWidth').AsBoolean then
  begin
        errorLocation := 'Header';
        if Dataset.Name = 'TmpQrCodeOnReceiptFooterText' then
                errorLocation := 'Footer';
        errorLine := DataSet.FieldByName('LineNumber').AsInteger;

        raise EParserError.Create(Format('%s Line %d' + #13#10 + 'Text cannot be greater than %d characters if Double Width is selected.',[errorLocation, errorLine, REPORT_LINE_LENGTH_DOUBLE_WIDE]));
  end;
end;

procedure TdmADO.TmpQrCodeOnReceiptFooterTextDoubleWidthValidate(
  Sender: TField);
begin
  inherited;
  FooterTextDoubleSizeValidate(Sender, Length(TmpQrCodeOnReceiptFooterTextText.AsString), 'Double Width');
end;

procedure TdmADO.TmpQrCodeOnReceiptFooterTextTextValidate(Sender: TField);
var
  TotalLength: Integer;
begin
  TotalLength := Length(Sender.AsString);
  if (TotalLength > REPORT_LINE_LENGTH_DOUBLE_WIDE) and TmpQrCodeOnReceiptFooterText.FieldByName('DoubleWidth').AsBoolean  then
    raise Exception.Create(Format('Only %d characters can be entered when ''Double Width'' is checked.',[REPORT_LINE_LENGTH_DOUBLE_WIDE]));
end;

procedure TdmADO.TmpBarcodeHeaderTextBeforePost(DataSet: TDataSet);
var
  errorLine: Integer;
  errorLocation: String;
begin
  inherited;
  if (Length(DataSet.FieldByName('Text').AsString) > REPORT_LINE_LENGTH_DOUBLE_WIDE) AND DataSet.FieldByName('DoubleWidth').AsBoolean then
  begin
        errorLocation := 'Header';
        errorLine := DataSet.FieldByName('LineNumber').AsInteger;

        raise EParserError.Create(Format('%s Line %d' + #13#10 + 'Text cannot be greater than %d characters if Double Width is selected.',[errorLocation, errorLine, REPORT_LINE_LENGTH_DOUBLE_WIDE]));
  end;
end;

procedure TdmADO.TmpBarcodeFooterTextBeforePost(DataSet: TDataSet);
var
  errorLine: Integer;
  errorLocation: String;
begin
  inherited;
  if (Length(DataSet.FieldByName('Text').AsString) > REPORT_LINE_LENGTH_DOUBLE_WIDE) AND DataSet.FieldByName('DoubleWidth').AsBoolean then
  begin
        errorLocation := 'Footer';
        errorLine := DataSet.FieldByName('LineNumber').AsInteger;

        raise EParserError.Create(Format('%s Line %d' + #13#10 + 'Text cannot be greater than %d characters if Double Width is selected.',[errorLocation, errorLine, REPORT_LINE_LENGTH_DOUBLE_WIDE]));
  end;
end;

procedure TdmADO.TmpBarcodeHeaderTextTextValidate(Sender: TField);
var
  TotalLength: Integer;
begin
  TotalLength := Length(Sender.AsString);
  if (TotalLength > REPORT_LINE_LENGTH_DOUBLE_WIDE) and TmpBarcodeHeaderText.FieldByName('DoubleWidth').AsBoolean  then
    raise Exception.Create(Format('Only %d characters can be entered when ''Double Width'' is checked.',[REPORT_LINE_LENGTH_DOUBLE_WIDE]));
end;

procedure TdmADO.TmpBarcodeHeaderTextDoubleWidthValidate(Sender: TField);
begin
  FooterTextDoubleSizeValidate(Sender, Length(TmpBarcodeHeaderTextText.AsString), 'Double Width');
end;

procedure TdmADO.TmpBarcodeFooterTextTextValidate(Sender: TField);
var
  TotalLength: Integer;
begin
  TotalLength := Length(Sender.AsString);
  if (TotalLength > REPORT_LINE_LENGTH_DOUBLE_WIDE) and TmpBarcodeFooterText.FieldByName('DoubleWidth').AsBoolean  then
    raise Exception.Create(Format('Only %d characters can be entered when ''Double Width'' is checked.',[REPORT_LINE_LENGTH_DOUBLE_WIDE]));
end;

procedure TdmADO.TmpBarcodeFooterTextDoubleWidthValidate(Sender: TField);
begin
  FooterTextDoubleSizeValidate(Sender, Length(TmpBarcodeFooterTextText.AsString), 'Double Width');
end;

procedure TdmADO.LogDuration(const what: String);
begin
    Log('  ' + FormatDateTime('nn:ss:zzz', Now - logTime1) + ' - ' + what);
    logTime1 := Now;
end;

end.
