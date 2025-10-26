unit uGlobals;

interface

uses Useful, StdCtrls, SysUtils, Forms, Dialogs, DBTables, Registry, Windows, controls,
  classes, ADODB, Math, StrUtils, uUser;

var
  LogonUserName: string;
  LogonFailedNames: string;
  LogonFailedTimes: smallint;
  LogonErrorString: string;
  
  // Sitecode is 0 if PC is a master PC.
  // IsSite and IsMaster may both be true!!
  SiteCode, DiallingPCNo: integer;
  SiteName, SiteManager, AreaName: string;
  HOIPAddress: string;
  IsSite, IsMaster: boolean;
  RolloverTime: TDateTime;
  RollOverString: string;
  TillVer: String[4];
  repPaperName: string;
  zcfHeadOfficeUrl: string;

  // To control access to various parts of employee system
  EmpEdit,EmpHrs,EmpSched,EmpReps: Boolean;
  // Job 16222 - variables holding access rights for Purchase system.
  PurEdit, PurAdd, PurAudit, PurViewCurrent, PurViewAccepted, PurReps: Boolean;
  CurrentUser:TUser;

  // Job 16623 - Access rights for Finance.
  FinCashUp, FinSkim, FinIncome, FinExpenses, FinBanking, FinBankCol,
  FinLedger, FinReview, FinReport, FinEOW: Boolean;

  // Jobs config variables - read from SysVar.db in the AfterOpen handler
  // of wwtSysVar in dmodule1.
  PayMode: string[1]; // F- free entry, S-pay schemes >> set per site now, per job in future
  // M- Master control, S- Site Control
  JobControl, WarControl, AttControl, UDFControl, TermControl : string[1];

  // Master (system wide) options
  curUserRank : integer; // 20019 - added curUserRank
  EIN: string[15];
  tipsrep: integer;
  stweek: integer;
  leeway1: string = '00:00';
  leeway2: string = '00:00';
  grace: string = '00:00';
  UKUSmode: string;
  HoSite: String;
  theDateFormat: string;
  CurrSym: string; // Currency symbol (£ or $).

  //String used for display purposes i.e. 'Purchase' Reports or 'Delivery' Reports
  appGUIString: String;
  purchHelpExists: boolean;
  HelpExists: boolean;

  CurrentConnection: TADOConnection;

  function ZonalDevPass: string;
  function ZonalQAPass: string;
  function ZonalHCPass: string;
  function GetBlankDateTimePicker: string;

{$R Icons\AztecIcons.RES}

type
  LanguageStrings = (lsOrders, lsInvoice, lsSalesTax, lsSalesArea, lsInventory, IsQRCodePrintOn, IsQRCodeFormCaption);
  TPricingValues = (AllValues, Priced, UnPriced);

const
  //In US locale the short date format 'dd-mmm-yy' is not compatable witht the
  //Delphi StrToDate function and has to be manually encoded. The 9 character
  //length is unique in the context of UK and US date formats.
  INCOMPATABLE_USA_SHORTDATE_LENGTH = 9;

  // The id and name the 'Standard' portion in the PortionTypes table
  STANDARD_PORTION_TYPE_ID = 1;
  STANDARD_PORTION_TYPE_NAME = 'Standard';

  // BASE DATA PROFILES
  BDM_PROFILE_UNKNOWN = -1;
  BDM_PROFILE_AZTEC = 0;     // This will be the default Profile ID and shows ALL base data
  BDM_PROFILE_ENGINEER = 1;  // This is the same as AZTEC plus hidden engineer options
  BDM_PROFILE_COMPANY_STRUCTURE = 2;
  BDM_PROFILE_PRODUCT_STRUCTURE = 3;
  BDM_PROFILE_TAX_RULES = 4;
  BDM_PROFILE_PRINTER_STREAMS = 5;
  BDM_PROFILE_UNITS = 6;
  BDM_PROFILE_PORTIONS = 7;
  BDM_PROFILE_COURSES = 8;
  BDM_PROFILE_SUPPLIERS = 9;
  BDM_PROFILE_PAYLINES = 10;
  BDM_PROFILE_PAYMENTS = 11;
  BDM_PROFILE_SESSIONS = 12;
  BDM_PROFILE_ACCOUNTING_PERIODS = 13;
  BDM_PROFILE_EXCHANGE_RATES = 14;
  BDM_PROFILE_CORRECTION_METHODS = 15;
  BDM_PROFILE_TAX_TABLES = 16;


  //// PURCHASE HELP CONTEXT IDS /////
  PURCH_HELP_FILE_UKHO            = 'ds_ho_UK.HLP';
  PURCH_HELP_FILE_UKSITE          = 'ds_site_UK.hlp';
  PURCH_HELP_FILE_UKSITEMASTER    = 'ds_sitemaster_UK.hlp';
  PURCH_HELP_FILE_USHO            = 'ds_ho_US.HLP';
  PURCH_HELP_FILE_USSITE          = 'ds_site_US.hlp';
  PURCH_HELP_FILE_USSITEMASTER    = 'ds_sitemaster_US.hlp';
  HLP_MAIN_MENU                   = 2001;
  HLP_DELIVERY_NOTE_ENTRY         = 2002;
  HLP_ADD_DELIVERY_NOTE           = 2003;
  HLP_EDIT_DELIVERY_NOTE          = 2004;
  HLP_VIEW_CURRENT_DELIVERY_NOTE  = 2005;
  HLP_VIEW_ACCEPTED_DELIVERY_NOTE = 2006;
  HLP_AUDIT_DELIVERY_NOTE         = 2007;
  HLP_REPORTS_MENU                = 2008;
  HLP_PERIOD_REPORT               = 2009;
  HLP_WEEKLY_REPORT               = 2010;
  HLP_CONFIGURE_UK                = 2011;
  HLP_CONFIGURE_US                = 2012;
  HLP_MISC_UK                     = 2013;
  HLP_MISC_US                     = 2014;
  HLP_PRODUCT_ANALYSIS            = 2015;
  HLP_ALLIANT_LINK                = 2016;
  HLP_HO_CONFIGURATION            = 2017;
  HLP_PASSWORD_FORM               = 2018;
  HLP_DELIVERY_NOTE_SELECTION     = 2019;
  HLP_DELIVERY_NOTE_SUMMARY       = 2020;
  HLP_ADD_ITEM                    = 2021;
  HLP_SITE_SELECTION              = 2022;
  HLP_ADD_DELIVERY_NOTE_DLG       = 2023;
  HLP_FULL_RECONFIGURE            = 2024;
  HLP_VIEW_COST_PRICES            = 2025;
  HLP_UPDATE_COST_PRICES          = 2026;
  HLP_ADD_FREE_ITEMS              = 2027;
  HLP_SEND_DELIVERIES_TO_TILL     = 2028;
  HLP_WEEKLY_PURCH_REPORT_CONFIG  = 2029;
  HLP_WKLY_REPORT_CONFIG_ADD_PRIMARY_CATEGORY = 2030;
  HLP_WKLY_REPORT_CONFIG_ADD_CODED_CATEGORY   = 2031;
  HLP_VIEW_ALL_SUPPLIERS_PRODUCTS = 2032;
  HLP_EDIT_INVOICE_MASK           = 2033;
  HLP_CHOOSE_INVOICE_MASK         = 2034;
  HLP_INTERNAL_TRANSFER_MENU        = 2048;
  HLP_INTERNAL_TRANSFER_SITE_SELECT = 2049;
  HLP_INTERNAL_TRANSFER_NEW         = 2050;
  HLP_INTERNAL_TRANSFER_UNACCEPTED  = 2051;
  HLP_INTERNAL_TRANSFER_DETAIL      = 2052;

  HLP_HH_DELIVERY_NOTE_VALIDATION   = 2054;
  HLP_HANDHELD_IMPORT_CORRECTIONS   = 2055;


  //***********************************//
  //* Stock Ordering Help Constants   *//
  //***********************************//
  HLP_STOCK_ORDER_MENU            = 2035; {Stock Ordering Menu}
  HLP_STOCK_ORDER_SUMMARY         = 2036; {Current Stock Orders}
  HLP_CREATE_STOCK_ORDER          = 2037; {Create Stock Order}
  HLP_STOCK_ORDER_PRODUCTS        = 2038; {Product Pick List For Supplier :}
  HLP_EDIT_STOCK_ORDER            = 2039; {Create Stock Order}
  HLP_STOCK_ORDER_SCHEDULE        = 2040; {Aztec Stock Orderin Schedule}
  HLP_STOCK_ORDER_WEEK_INFO       = 2041; {Week Order/Delivery Info}
  HLP_STOCK_ORDER_COPY_PROFILE    = 2042; {Copy Profile}
  HLP_STOCK_ORDER_SUPPLIER_SETTINGS = 2043; {Supplier Configurations}
  HLP_CREATE_STOCK_ORDER_FLAVOURS = 2044; {}
  HLP_EDIT_STOCK_ORDER_FLAVOURS   = 2045; {}

  //***********************************//

  // Finance help context ID's //
  FINANCE_SITE_UK_HELP_FILE        = 'Fi_Site_UK.hlp';
  FINANCE_HO_UK_HELP_FILE          = 'Fi_HO_UK.hlp';
  FINANCE_SITEMASTER_UK_HELP_FILE  = 'Fi_SiteMaster_UK.hlp';
  FINANCE_SITE_US_HELP_FILE        = 'Fi_Site_US.hlp';
  FINANCE_HO_US_HELP_FILE          = 'Fi_HO_US.hlp';
  FINANCE_SITEMASTER_US_HELP_FILE  = 'Fi_SiteMaster_US.hlp';
  FIN_MAIN_MENU                    = 3001;
  FIN_PASSWORD_FORM                = 3002;
  FIN_DAY_MENU                     = 3003;
  FIN_DAY_FORM                     = 3004;
  FIN_DAY_REPORT                   = 3005;
  FIN_GRAPH_MENU                   = 3006;
  FIN_CHART_FORM                   = 3007;
  FIN_DAY_CCARDS                   = 3008;
  FIN_DAY_LEDGER                   = 3009;
  FIN_DAY_LEDGERS_PAID             = 3010;
  FIN_DAY_CHOOSE_PAYOUT_TYPE       = 3011;
  FIN_DAY_EDIT_MISC_PAYOUTS        = 3012;
  FIN_DAY_NEW_SINGLE_PAYOUT        = 3013;
  FIN_DAY_NEW_SPLIT_PAYOUT         = 3014;
  FIN_DAY_MISC_INCOME              = 3015;
  FIN_DAY_NEW_NON_TAX_INCOME       = 3016;
  FIN_DAY_NEW_TAX_INCOME           = 3017;
  FIN_DAY_VIEW_CARRIED_FORWARD     = 3018;
  FIN_DAY_VIEW_BROUGHT_FORWARD     = 3019;
  FIN_DAY_BANKING                  = 3020;
  FIN_DAY_EDIT_BANKING             = 3021;
  FIN_DAY_CASHUP_STATUS            = 3022;
  FIN_DAY_CASHUP_DECLARATION       = 3023;
  FIN_WEEK_MENU                    = 3024;
  FIN_WEEK_REPORTS                 = 3025;
  FIN_PERIOD_REPORTS               = 3026;
  FIN_WEEK_FINANCE_CONTROL         = 3027;
  FIN_WEEK_CONTROL_MAP             = 3028;
  FIN_WEEK_REVIEW_WFC              = 3029;
  FIN_CONFIG_MENU                  = 3030;
  FIN_CONFIG_DAILY                 = 3031;
  FIN_CONFIG_WEEKLY                = 3032;
  FIN_DAY_PAYOUT_ADD_CATEGORY      = 3033;
  FIN_WEEK_REPORT_MENU_MIX         = 3034;
  FIN_DAY_EDIT_MISC_EX             = 3035;
  FIN_DAY_EDIT_LEDGER_PAID         = 3036;
  FIN_WEEK_FINANCE_CONTROL_STOCK   = 3037;
  FIN_YEARLY_REPORT                = 3038;
  FIN_DAY_EDIT_BANKING_UK          = 3039;
  FIN_DAY_EDIT_DEPOSITS            = 3040;
  FIN_DAY_EDIT_ACCOUNTS            = 3041;
  FIN_DAY_EDIT_TAX                 = 3042;
  FIN_DAY_CHANGE                   = 3043;
  FIN_DAY_EDIT_CHANGE              = 3044;
  FIN_AZTEC_PAYMENTS               = 3045;
  FIN_EDIT_AZTEC_PAYMENTS          = 3046;
  FIN_SKIMMING                     = 3047;
  FIN_INS_SKIMMING                 = 3048;
  FIN_EDIT_SKIMMING                = 3049;
  FIN_DEL_SKIMMING                 = 3050;
  FIN_DAY_CASHUP_DECLARATION_BLIND = 3051;
  FIN_DAY_CASHUP_DECLARATION_SKIM  = 3023;
  FIN_DAY_CASHUP_STATUS_BLIND      = 3053;
  FIN_DAY_CASHUP_STATUS_SKIM       = 3022;
  FIN_DAY_BANK_COLLECTION          = 3055;
  FIN_DAY_CASHUP_CASH_BREAKDOWN    = 3056;
  FIN_DAY_BANK_UK_CASH_BREAKDOWN   = 3057;
  FIN_PICK_SITE                    = 3058;
  FIN_PICK_DATE                    = 3059;
  FIN_SALES_AREA_CASHUP            = 3060;
  FIN_SALES_AREA_CASHUP_BLIND      = 3061;
  FIN_SALES_AREA_CASHUP_SKIM       = 3062;

  // Human Resource help context ID's //
  EMPLOYEE_SITE_UK_HELP_FILE        = 'HR_Site_UK.hlp';
  EMPLOYEE_HO_UK_HELP_FILE          = 'HR_HO_UK.hlp';
  EMPLOYEE_SITEMASTER_UK_HELP_FILE  = 'HR_SiteMaster_UK.hlp';
  EMPLOYEE_SITE_US_HELP_FILE        = 'HR_Site_US.hlp';
  EMPLOYEE_HO_US_HELP_FILE          = 'HR_HO_US.hlp';
  EMPLOYEE_SITEMASTER_US_HELP_FILE  = 'HR_SiteMaster_US.hlp';
  EMP_MAIN_MENU                     = 4001;
  EMP_PASSWORD_FORM                 = 4002;
  EMP_SITE_EMPLOYEES                = 4003;
  EMP_ALLOCATE_JOB                  = 4004;
  EMP_CHANGE_DEF_JOB                = 4005;
  EMP_NEW_EMPLOYEE                  = 4006;
  EMP_TERMINATED_EMPLOYEES          = 4007;
  EMP_RESTORE_EMPLOYEE              = 4008;
  EMP_JOB_SETUP                     = 4009;
  EMP_INSERT_DIVISION               = 4010;
  EMP_INSERT_SECTION                = 4011;
  EMP_INSERT_JOB                    = 4012;
  EMP_ACCESS_RIGHTS                 = 4013;
  EMP_COPY_ACCESS                   = 4014;
  EMP_MAN_ACCESS                    = 4015;
  EMP_BASE_DATA                     = 4016;
  EMP_TERM_CODE                     = 4017;
  EMP_SCHEDULE_TOTALS               = 4018;
  EMP_OPEN_CLOSE                    = 4019;
  EMP_REORDER_COLUMNS               = 4020;
  EMP_PAYTYPES                      = 4021;
  EMP_NEW_UDF                       = 4022;
  EMP_FULL_RECONFIGURE              = 4023;
  EMP_PICK_WEEK                     = 4024;
  EMP_WEEK_SCHEDULE                 = 4025;
  EMP_INS_EMPLOYEE                  = 4026;
  EMP_VERIFY                        = 4027;
  EMP_REPORTS                       = 4028;
  EMP_SIGN_OFF                      = 4029;
  EMP_WARNING_CONTROLS              = 4030;
  EMP_EXTRA_PAYMENT                 = 4031;
  EMP_NEW_HEADOFFICE_EMPLOYEE       = 4033;
  EMP_EMPLOYEE_GROUP                = 4034;
  EMP_SELECT_GROUPS_FOR_SITE        = 4035;


  // Basic Pricing help context ID's //
  PRICING_HO_UK_HELP_FILE         = 'BP_HO_UK.hlp';
  PRICING_HO_US_HELP_FILE         = 'BP_HO_US.hlp';
  PRC_MAIN_MENU                   = 6001;
  PRC_PASSWORD_FORM               = 6002;
  PRC_SALES_AREA_BANDS            = 6003;
  PRC_SUPPLEMENT_BANDS            = 6004;
  PRC_PRICE_MATRIX                = 6005;
  PRC_SITE_MATRIX                 = 6006;
  PRC_OFF_BAND_PRICES             = 6007;

  // Promotional Pricing help context ID's //
  PROMO_HO_UK_HELP_FILE           = 'PP_HO_UK.hlp';
  PROMO_HO_US_HELP_FILE           = 'PP_HO_US.hlp';
  PROM_MAIN_FORM                  = 7001;
  PROM_PASSWORD_FORM              = 7002;
  PROM_DETAILS                    = 7003;
  PROM_WIZARD                     = 7004;

  // Product Modelling help context IDs //
  AZPM_HO_UK_HELP_FILE           = 'PM_ho_UK.hlp';
  AZPM_HO_US_HELP_FILE           = 'PM_ho_US.hlp';
  AZPM_PASSWORD_FORM              = 8001;
  AZPM_SELECT_SITE_FORM           = 8002; // Site lines only
  AZPM_CHOOSE_DATE_FORM           = 8003;
  AZPM_MAIN_FORM_INSTRUCT         = 8004;
  AZPM_MAIN_FORM_CHOICE           = 8005;
  AZPM_MAIN_FORM_ORDERMENU        = 8006;
  AZPM_MAIN_FORM_PREPITEM         = 8007;
  AZPM_MAIN_FORM_PURCHLINE        = 8008;
  AZPM_MAIN_FORM_RECIPE           = 8009;
  AZPM_MAIN_FORM_STRDLINE         = 8010;
  AZPM_MAIN_FORM_VAROMENU         = 8011;
  AZPM_MAIN_FORM_MULTIPURCH       = 8012;
  AZPM_MAIN_FORM_NO_ITEMS_VISIBLE = 8013;
  AZPM_FILTER_FORM                = 8014;
  AZPM_AUTO_LINE_CHANGE_FORM      = 8015;
  AZPM_NEW_CATEGORY_FORM         = 8016;
  AZPM_NEW_COURSE_FORM            = 8017;
  AZPM_NEW_DIVISION_FORM          = 8018;
  AZPM_NEW_PORTIONTYPE_FORM       = 8019;
  AZPM_NEW_PRINTSTREAM_FORM       = 8020;
  AZPM_NEW_SUBCATEGORY_FORM       = 8021;
  AZPM_NEW_UNIT_FORM              = 8022;
  AZPM_NEW_VATBAND_FORM           = 8023;
  AZPM_ADD_EDIT_AZTEC_INGREDIENT  = 8024;
  AZPM_RECIPE_OR_MENU_OVERVIEW    = 8025;
  // 8026 no longer used.
  AZPM_ADD_PORTION_INGRED_FORM	  = 8027;
  AZPM_ADD_RECIPE_ITEM_FORM	  = 8028;
  AZPM_ADD_MENU_ITEM_FORM	  = 8029; // var.o.menus & order menus
  AZPM_ADD_VAROMENU_CHOICE_FORM	  = 8030;
  AZPM_ADD_CHOICE_ITEM_FORM	  = 8031;
  AZPM_ADD_MULTI_PURCH_ITEM_FORM  = 8032;
  AZPM_ADD_PREPAREDITEM_INGRED_FORM = 8033;

  // Access Control help context IDs //
  AZAA_HELP_FILE                  = 'AA.hlp';
  AZAA_PASSWORD_FORM              = 9001;
  AZAA_MAINFORM_GENERAL           = 9002;
  AZAA_MAINFORM_JOBTYPES          = 9003;
  AZAA_MAINFORM_USERLOG           = 9004;
  AZAA_MAINFORM_USERLIST_ALL      = 9005;
  AZAA_MAINFORM_USERLIST_LOCATION = 9006;
  AZAA_MAINFORM_USERLIST_LEVEL    = 9007;
  AZAA_MAINFORM_USERLIST_JOBTYPE  = 9008;
  AZAA_MAINFORM_NO_JOBTYPE_WARNING= 9009;
  AZAA_EDIT_ACCESS_RIGHTS         = 9010;
  AZAA_COPY_ACCESS_RIGHTS         = 9011;
  AZAA_ACCESS_RIGHTS_KEY          = 9012;
  AZAA_SET_PASSWORD               = 9013;
  AZAA_USERLOG_FILTER             = 9014;
  AZAA_USERLIST_PICK_LOCATION     = 9015;

  // Restricted Stock help context IDs
  RSTOCK_SITE_HELP_FILE           = 'RE_Site.hlp';
  RSTOCK_MAIN_FORM                = 10001;
  RSTOCK_PASSWORD_FORM            = 10002;

  // Communications help context IDs
  COMMS_SITE_HELP_FILE           = 'CM_Site.hlp';
  COMMS_HO_HELP_FILE             = 'CM_HO.hlp';
  COMMS_SITEMASTER_HELP_FILE     = 'CM_SiteMaster.hlp';
  COMMS_MAIN_FORM                = 11001;
  COMMS_PASSWORD_FORM            = 11002;
  COMMS_ADD_FORM                 = 11003;
  COMMS_CANCEL_FORM              = 11004;
  COMMS_SELECT_DATE              = 11005;
  COMMS_DISPLAY_FORM             = 11006;
  COMMS_EXECUTE_FORM             = 11007;
  COMMS_SUSPEND_FORM             = 11008;
  COMMS_SELECT_TIME              = 11009;

  // Site Select help context IDs
  AZSL_HO_UK_HELP_FILE           = 'SL_HO_UK.hlp';
  AZSL_HO_US_HELP_FILE           = 'SL_HO_US.hlp';
  AZSL_MAIN_FORM                 = 12001;
  AZSL_PASSWORD_FORM             = 12002;
  AZSL_CATEGORY_FILTER_FORM      = 12003;
  AZSL_COPY_LINES_FORM           = 12004;
  AZSL_SELECT_DATE               = 12005;
  AZSL_RECIPE_OVERVIEW_FORM      = 12006;

  // Base Data help context IDs
  AZBD_HO_UK_HELP_FILE           = 'BD_HO_UK.hlp';
  AZBD_HO_US_HELP_FILE           = 'BD_HO_US.hlp';
  AZBD_MAIN_FORM                 = 13001;
  AZBD_PASSWORD_FORM             = 13002;
  AZBD_ACCOUNTING_PERIODS        = 13003;
  AZBD_AREA_CONFIG               = 13004;
  AZBD_CATEGORY                  = 13005;
  AZBD_COMPANY_CONFIG            = 13006;
  AZBD_CORRECTION_METHOD         = 13007;
  AZBD_COURSE                    = 13008;
  AZBD_DIVISION                  = 13009;
  AZBD_EXCHANGE_RATE             = 13010;
  AZBD_PAYLINES                  = 13011;
  AZBD_PAYMENTS                  = 13012;
  AZBD_PORTIONS                  = 13013;
  AZBD_POS                       = 13014;
  AZBD_PRINTER_STREAM            = 13015;
  AZBD_SALES_AREA                = 13016;
  AZBD_SESSION                   = 13017;
  AZBD_SITE                      = 13018;
  AZBD_SUB_CATEGORY              = 13019;
  AZBD_SUPPLIER                  = 13020;
  AZBD_UNITS                     = 13021;
  AZBD_VAT_BAND                  = 13022;
  AZBD_CURRENCY_ATTRIBUTES       = 13023;
  AZBD_EDIT_CURRENCY             = 13024;
  AZBD_POS_FEATURES              = 13025;
  AZBD_REPORT_GROUP              = 13026;
  AZBD_FINANCIAL_YEAR            = 13027;
  AZBD_ALTERNATIVE               = 13028;
  AZBD_SYSTEM_VARIABLES          = 13029;
  AZBD_TAX_TABLE                 = 13030;

  // Shelf Labels help context IDs
  SHELF_LABELS_SITE_UK_HELP_FILE = 'SH_Site_UK.hlp';
  SHELF_LABELS_MAIN_FORM_HELPID = 14001;
  SHELF_LABELS_LOAD_HELPID      = 14002;
  SHELF_LABELS_SAVE_HELPID      = 14003;

  XML_IMPORT_SITE_UK_HELP_FILE         = 'XML_Site_UK.hlp';
  XML_IMPORT_MAIN_FORM_HELPID          = 15001;
  XML_IMPORT_CONFIGURATION_FORM_HELPID = 15002;

  // Theme Modelling help constants
  AZTM_SITE_HELP_FILE             = 'TM_Site_UK.hlp';
  AZTM_HO_HELP_FILE               = 'TM_HO_UK.hlp';
  AZTM_SITEMASTER_HELP_FILE       = 'TM_SSM_UK.hlp';
  AZTM_EDIT_PANEL                 = 5007;
  AZTM_EDIT_SITE_PANEL            = 5042;
  AZTM_SITE_PANEL                 = 5043;
  AZTM_DESIGN_SITE_PANEL          = 5044;
  AZTM_TERMINAL_GRAPHICS          = 5051;
  AZTM_EDIT_FORCED_ITEM_SELECTION = 5052;
  AZTM_EDIT_ROOT_PANEL            = 5054;
  AZTM_ADD_EDIT_TERMINAL_GRAPHICS = 5055;
  AZTM_EDIT_ORDER_DISPLAY         = 5056;

function GetLocalisedName(StringType: LanguageStrings): string;
function GetLocalisedItemTax(ACost, theTax: real; UKTaxed: Boolean): real;

procedure GetGlobalData(AConnection: TADOConnection);
procedure PopulatePricngList(AcomboBox: TComboBox);

function GetLocale: string;

function setHelpContextID(theControl: TControl; theContextID: THelpContext): boolean;
function assignHelpFile(filename: string): boolean;
function getHelpFileDir: string;
function StandardPortionTypeExists(AdoConnection: TADOConnection): boolean;
function GetEnableSiteLines: boolean;
function StrToDateConversion(dateString: string): TDate;
function UsaLocaleShortDateStrToDate(dateAsString: string): TDate;

implementation

uses DB, uSystemUtils;

procedure PopulatePricngList(AcomboBox: TComboBox);
begin
  AcomboBox.Items.Add('<all values>');
  AcomboBox.Items.Add('Priced only');
  AcomboBox.Items.Add('Unpriced only');
  AcomboBox.ItemIndex := 0;
end;

// Return the UK/US equivalent terms for label captions.
function GetLocalisedName(StringType: LanguageStrings): string;
begin
  case StringType of
  lsOrders:
    begin
      if UKUSMode = 'UK' then
        Result := 'Delivery Notes'
      else
        Result := 'Orders';
    end;
  lsInvoice:
    begin
      if UKUSMode = 'UK' then
        Result := 'Delivery Note'
      else
        Result := 'Invoice';
    end;
  lsSalesTax:
    begin
      if UKUSMode = 'UK' then
        Result := 'VAT'
      else
        Result := 'Sales Tax';
    end;
  lsSalesArea:
    begin
      if UKUSMode = 'UK' then
        Result := 'Sales Area'
      else
        Result := 'Profit Center';
    end;
  lsInventory:
    begin
      if UKUSMode = 'UK' then
        Result := 'Stock Order'
      else
        Result := 'Inventory Number';
    end;
  IsQRCodeFormCaption:
    begin
      if UKUSMode = 'UK' then
        Result := 'Configure QR Code for Bills and Receipts'
      else
        Result := 'Configure QR Code for Checks and Receipts';
    end;
  IsQRCodePrintOn:
    begin
      if UKUSMode = 'UK' then
        Result := 'Bill footer'
      else
        Result := 'Check footer';
    end;
  end;
end;

// Apply Sales Tax or VAT, depending on the country.
function GetLocalisedItemTax(ACost, theTax: real; UKTaxed: Boolean): real;
const
  VAT       = 17.5;
var
  Rounded, MaxTo: Integer;
  MainTax, RemainderTax, LowBand, HighBand: real;
  qryTemp: TADOQuery;
begin
  if UKUSMode = 'US' then
  begin
    qryTemp := TADOQuery.Create(nil);

    try
      qryTemp.Connection := CurrentConnection;

      with qryTemp do
      begin
        SQL.Add('select max ([To])  as MaxTo');
        SQL.Add('from USTaxes');
        SQL.Add('where band = ' + format('%f', [theTax]));
        Open;
        MaxTo := Round(FieldByName('MaxTo').AsFloat);
        Close;
      end;
    finally
      FreeAndNil(qryTemp);
    end;

    if MaxTo > 0 then
    begin
      // Apply tax to the main part of the value.
      Rounded := ((trunc(ACost)) div MaxTo) * MaxTo;
      MainTax := (Rounded * theTax) / 100;

      // Find Tax and Rounding amount for the remainder.
      LowBand := (ACost - Rounded) - 0.01;
      HighBand := (ACost - Rounded) + 0.01;

      qryTemp := TADOQuery.Create(nil);

      try
        qryTemp.Connection := CurrentConnection;

        with qryTemp do
        begin
          SQL.Add('select tax from ustaxes');
          SQL.Add('where band = ' + format('%f', [theTax]));
          SQL.Add('and [from] <= ' + format('%f', [HighBand]));
          SQL.Add('and [to] > ' + format('%f', [LowBand]));

          Open;
          RemainderTax := FieldByName('tax').asfloat;
          Close;
        end;
      finally
        FreeAndNil(qryTemp);
      end;

      // Tax amount is the sum of both values.
      Result := MainTax + RemainderTax;
    end
    else
      Result := 0;
  end
  else
  begin
    if UKTaxed then
      Result := RoundTo((ACost * VAT) / 100, -2)
    else
      Result := 0;
  end;
end;

function GetLocale: string;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;

  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey('Control Panel\International', False);

    if Reg.ReadString('Locale') = '00000409' then
      Result := 'US'
    else
      Result := 'UK';
  finally
    Reg.Free;
  end;
end;

function fixed_strtotime(timestr: string): TDateTime;
{fixed strtotime, format must be hh:mm}
var
  hours, mins: integer;
begin
  try
    hours := strtoint(copy(timestr, 1, pred(pos(':', timestr))));
    mins := strtoint(copy(timestr, succ(pos(':', timestr)), 2));
    result := (hours * 1.0 / 24.00) + (mins * 1.0 / 24.00 / 60.00);
  except
    result := strtotime(timestr);
  end;
end;

procedure GetGlobalData(AConnection: TADOConnection);
var
  GraceTM: string;
  qryRun: TADOQuery;

begin
  CurrentConnection := AConnection;

  qryRun := TADOQuery.Create(nil);

  try
    qryRun.Connection := CurrentConnection;

    with qryRun do
    begin
      Close;
      SQL.Text := 'SELECT [Master], [Site] FROM dbo.SystemDefinition';
      Open;
      Assert(RecordCount = 1,
             'SystemDefinition Aztec SQL table contains invalid data. Expected one row but found ' + IntToStr(RecordCount));
      Assert(FieldByName('Master').AsBoolean OR FieldByName('Site').AsBoolean,
             'SystemDefinition Aztec SQL table contains invalid data. Both [Master] and [Site] colums are set to false');
      IsMaster := FieldByName('Master').AsBoolean;
      IsSite := FieldByName('Site').AsBoolean;
      Close;

      // moved from below becuse rollover is needed to calculate grace
      SQL.Text := 'select t."Rollover Time" as RollTime from timeout t';
      Open;
      RollOverString := FieldByName('Rolltime').AsString;
      Close;

      if RollOverString = '' then
        RollOverString := '00:00';

      RollOverTime := fixed_strtotime(RollOverString);

      if IsSite then
      begin
        SQL.Text := 'select si.[Site Code] as SiteCode, si.[Site Name], si.[Dialling PC Num] ' +
          'from SiteAztec si ' +
          'WHERE si."Site Code" > 0 ' +
          'and IsNull(Deleted, ''N'') = ''N''';
        Open;
        SiteCode := fieldbyname('SiteCode').asinteger;
        SiteName := fieldbyname('Site Name').asstring;
        DiallingPCNo := FieldByName('Dialling PC Num').AsInteger;
        Close;
      end
      else
      begin
        SiteCode := 0;
        SiteName := 'Head Office';
        DiallingPCNo := 1;
      end;
    end;

    if IsSite then
    begin
      with qryRun do
      begin
        Close;
        SQL.Clear;
        SQL.Add('select a."grace", a."leeway1", a."leeway2", a."schedule"');
        SQL.Add('from "sysvar" a where a."sitecode" = ' + inttostr(SiteCode));
        Open;

        GraceTm := FieldByName('grace').AsString;
        Leeway1 := FieldByName('leeway1').AsString;
        Leeway2 := FieldByName('leeway2').AsString;

        if GraceTm = '' then
          GraceTm := '00:00';

        if Leeway1 = '' then
          Leeway1 := '00:00';

        if Leeway2 = '' then
          Leeway2 := '00:00';

        Grace := formatDateTime('hh:nn', RolloverTime - fixed_strtotime(GraceTm));

        Close;
      end;
    end;
    with qryRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('DECLARE @Result Varchar(255)');

      if IsSite then
      begin
        SQL.Add('EXEC sp_GetConfigurationResult ' + IntToStr(SiteCode) + ', ''MobileOrderingProxyBaseUrl'', @Result OUTPUT');
      end else begin
        SQL.Add('EXEC sp_GetConfigurationResult ' + IntToStr(SiteCode) + ', ''MobileOrderingProxyBaseUrlFromHo'', @Result OUTPUT');
      end;

      SQL.Add('Select ISNULL(@Result, '''') as Result');
      Open;
      zcfHeadOfficeUrl := FieldByName('Result').Value
    end;

    // get UKUS mode
    UKUSMode := GetLocale;

    // Store application title for purchase system.
    if UKUSmode = 'UK' then
    begin
      appGUIString := 'Delivery';
      theDateFormat := 'dd-MM-yyyy';
      CurrSym := '£';
    end
    else
    begin
      appGUIString := 'Purchase';
      theDateFormat := 'MM-dd-yyyy';
      CurrSym := '$';
    end;

    //TODO: Remove this once know what to with the HR Job access rights code which is
    // the only part of Aztec which uses it.
    TillVer := 'T99A';

    with qryRun do
    begin
      SQL.Clear;
      SQL.Add('select * from Genervar');
      SQL.Add('where VarName = ''RPaperName''');
      Open;

      if RecordCount = 0 then // create it first
      begin
        Close;
        SQL.Clear;
        SQL.Add('insert GenerVar(VarName)');
        SQL.Add('Values(''RPaperName'')');
        ExecSQL;

        repPaperName := '';
      end
      else
      begin
        repPaperName := FieldByName('VarString').AsString;
        Close;
      end;

      // if papername not set, set default values...
      if repPaperName = '' then
      begin
        if UKUSmode = 'UK' then
        begin
          repPaperName := 'A4';
        end
        else
        begin
          repPaperName := 'Letter';
        end;

        Close;
        SQL.Clear;
        SQL.Add('update GenerVar');
        SQL.Add('set VarString = ' + QuotedStr(repPaperName));
        SQL.Add('where VarName = ''RPaperName''');
        ExecSQL;
      end;

      Close;
      SQL.Clear;
      SQL.Add('select * from GenerVar');
      SQL.Add('where VarName = ''HOIPAddr''');
      SQL.Add('and VarInt = ' + inttostr(DiallingPCNo));
      Open;

      if RecordCount = 0 then
      begin
        Close;
        SQL.Clear;
        SQL.Add('insert Genervar(VarName, VarInt, VarString)');
        SQL.Add('values(''HOIPAddr'', ' + inttostr(DiallingPCNo) + ', ''127.0.0.1'')');
        ExecSQL;

        HOIPAddress := '127.0.0.1';
      end
      else
        HOIPAddress := FieldByName('VarString').AsString;

      Close;
    end;
  finally
    FreeAndNil(qryRun);
  end;
end;

function setHelpContextID(theControl: TControl; theContextID: THelpContext): boolean;
begin
  if Application.HelpFile = '' then
  begin
    result := false;
    exit;
  end;
  theControl.HelpType := htContext;
  theControl.HelpContext := theContextID;
  result := true;
end;

function assignHelpFile(filename: String): boolean;
var
  gidFile: String;
begin
  if not FileExists(EnsureTrailingSlash(getHelpFileDir) + filename) then
  begin
    result := false;
    purchHelpExists := False;
    HelpExists := False;
    exit;
  end;
  Application.HelpFile := EnsureTrailingSlash(getHelpFileDir) + filename;
  result := true;
  purchHelpExists := True;
  HelpExists := True;
  gidFile := EnsureTrailingSlash(getHelpFileDir) + copy(filename, 0, length(filename)-3) + 'GID';
  SysUtils.DeleteFile(gidFile);
end;

function getHelpFileDir: string;
begin
  result := EnsureTrailingSlash(ExtractFileDir(Application.ExeName)) + 'help';
end;

{ Returns true if the 'Standard' portion type exists in the PortionType table }
function StandardPortionTypeExists (AdoConnection: TADOConnection) : boolean;
var
  qryCheckPortionType: TADOQuery;
begin
  qryCheckPortionType := TADOQuery.Create(nil);

  with qryCheckPortionType do
  try
    Connection := AdoConnection;

    SQL.Clear;
    SQL.Add('SELECT count(*) AS Count');
    SQL.Add('FROM PortionType');
    SQL.Add('WHERE PortionTypeID = ' + IntToStr(STANDARD_PORTION_TYPE_ID) + ' AND');
    SQL.Add('      PortionTypeName = ' + QuotedStr(STANDARD_PORTION_TYPE_NAME));
    Open;
    Result := FieldByName('Count').Value = 1;
    Close;
  finally
    FreeAndNil(qryCheckPortionType);
  end;
end;

{ Job 19870 - get EnableSiteLines value for Aztec Toolbar
  on Master Only system  }
function GetEnableSiteLines: boolean;
var
  slQry: TADOQuery;
begin
  Result := false;
  slQry := TADOQuery.Create(nil);
  try
    slQry.Connection := CurrentConnection;

    if (not IsSite) then
      with slQry do
      begin
        Close;
        SQL.Clear;
        SQL.Add('select [VarString] from GenerVar');
        SQL.Add('where [VarName] = ''SiteLines''');
        Open;
        if RecordCount < 1 then
        begin
          Close;
          SQL.Clear;
          SQL.Add('insert GenerVar ([VarName], [VarString])');
          SQL.Add('values (''SiteLines'', ''N'')');
          ExecSQL;
          Result := false;
        end
        else
        begin
          Result := (FieldByName('VarString').Value = 'Y');
        end;
        Close;
      end;
  finally
    FreeAndNil(slQry);
  end;
end;

// The dateAsString param is expected to be in the US short date format: dd-mmm-yy
function UsaLocaleShortDateStrToDate(dateAsString: string): TDate;
var
  year, month, day: Word;

  function GetMonthAsInteger(month: string): Word;
  begin
    if (month = 'Jan') then Result := 1
    else
    if (month = 'Feb') then Result := 2
    else
    if (month = 'Mar') then Result := 3
    else
    if (month = 'Apr') then Result := 4
    else
    if (month = 'May') then Result := 5
    else
    if (month = 'Jun') then Result := 6
    else
    if (month = 'Jul') then Result := 7
    else
    if (month = 'Aug') then Result := 8
    else
    if (month = 'Sep') then Result := 9
    else
    if (month = 'Oct') then Result := 10
    else
    if (month = 'Nov') then Result := 11
    else
    if (month = 'Dec') then Result := 12
    else Result := 0;
  end;

  function GetYear(yearAsString: string): Word;
  var
    yearFirstTwoDigits: string;
  begin
    yearFirstTwoDigits := Copy(IntToStr(CurrentYear), 1, 2);
    Result := StrToInt(yearFirstTwoDigits + yearAsString);
  end;
  
begin
  try
    day := StrToInt(Copy(dateAsString, 1, 2));
    month := GetMonthAsInteger(Copy(dateAsString, 4, 3));
    year := GetYear(Copy(dateAsString, 8, 2));

    Result := EncodeDate(year, month, day);
  except
    on E : Exception do
        raise Exception.Create(E.Message + ': Invalid date format. Expected: dd-mmm-yy, Recieved: ' + dateAsString);
  end;
end;

function StrToDateConversion(dateString: string): TDate;
begin
    if (Length(dateString) = INCOMPATABLE_USA_SHORTDATE_LENGTH) then  // in the short date, the month is represented with 3 letters.  Format DD-MMM-YY  example 11-Dec-2023
        result := UsaLocaleShortDateStrToDate(dateString)
    else
        result := StrToDate(dateString);
end;

function MapToString(ANumber: integer): string;
const
  CharArray: array [0..9] of char = ('E', 'P', 'S', 'B', 'A', 'L', 'O', 'Y', 'E', 'W');
var
  i: integer;
  tmp: string;
begin
  Result := '';
  tmp := inttostr(ANumber);

  for i := 1 to Length(tmp) do
  begin
    Result := Result + CharArray[StrToInt(Copy(tmp, i, 1))];
  end;
end;

function ZonalDevPass: string;
var
  Number: integer;
begin
  try
    Number := ((Floor(Date) * 7) + 56830) * 13;
    Number := Number mod 12590161;

    Result := MapToString(Number);
  except
    Result := '';
  end;
end;

function ZonalQAPass: string;
var
  Number: integer;
begin
  try
    Number := ((Floor(Date) * 9) + 55) * 74;
    Number := Number mod 42590861;

    Result := MapToString(Number);
  except
    Result := '';
  end;
end;

function ZonalHCPass: string;
var
  Number: integer;
begin
  try
    Number := ((Floor(Date) * 13) + 58741) * 49;
    Number := Number mod 92570851;

    Result := MapToString(Number);
  except
    Result := '';
  end;
end;

function GetBlankDateTimePicker: string;
begin
  Result := ' ';
end;

begin
 CurrentUser := TUser.Create(-1, '','');
end.
