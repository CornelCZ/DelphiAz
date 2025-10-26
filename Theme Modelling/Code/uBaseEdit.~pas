//{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
//{$MINSTACKSIZE $00004000}
//{$MAXSTACKSIZE $00100000}
//{$IMAGEBASE $00400000}
//{$APPTYPE GUI}
unit uBaseEdit;
// Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initial Catalog=Aztec

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DB, ADODB, ComCtrls, Wwdbigrd,
  Wwdbgrid, DBCtrls, Mask, ExtCtrls, wwdblook,
  wwrcdpnl, ToolWin, Menus, ImgList, ActnList, Wwdatsrc, 
  Buttons, wwdbedit, uDatabaseVersion, wwcheckbox, wwdbdatetimepicker,
  Wwdotdot, Wwdbcomb, Wwdbspin, wwcommon;

const
  DELETE_TERMINAL_AREYOUSURE =
    'You must make sure any live terminals have been read up to date,'#13+
    'closed down and declared before deleting them. '#13#13+
    'Are you sure you want to delete %s?';

  DELETE_SERVER_AREYOUSURE =
    'Deleting a server will cause all attached terminals to be deleted.'#13#13+
    DELETE_TERMINAL_AREYOUSURE;

  MAX_FOOTER_LINE_LENGTH = 40;

type
  TDeviceObjectType = (doRoot, doServer, doTerminal, doPrinter, doConquerorServer,
                       doConquerorTerminal, doHotelSystemServer, doMOARemoteOrdering,
                       doMOAOrderPad, doiZoneTables, doQueueBuster);

  TBaseEdit = class(TForm)
    pcBaseData: TPageControl;
    Label1: TLabel;
    tabSheet_Printing: TTabSheet;
    Label2: TLabel;
    Label4: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    DBEdtHeader1: TDBEdit;
    DBEdtHeader2: TDBEdit;
    DBEdtHeader3: TDBEdit;
    Label17: TLabel;
    wwlkcxBillPS: TwwDBLookupCombo;
    wwlkcxReportPS: TwwDBLookupCombo;
    wwlkcxEFTPS: TwwDBLookupCombo;
    DBEditEFTHeader3: TDBEdit;
    DBEditEFTHeader2: TDBEdit;
    DBEditEFTHeader1: TDBEdit;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblVatNo: TLabel;
    dbEdtVatNo: TDBEdit;
    tsPrintGroupGrid: TTabSheet;
    qEditPrintStreams: TADOQuery;
    qLoadPrintStreams: TADOQuery;
    qSavePrintStreams: TADOQuery;
    qClearPrintStreamsTable: TADOQuery;
    btSortByTill: TButton;
    btsortbystream: TButton;
    dsPstreams: TDataSource;
    cmTicketPrintStream: TwwDBLookupCombo;
    Label26: TLabel;
    DBEdit3: TDBEdit;
    Label27: TLabel;
    mmPrinterFooter: TMemo;
    Label18: TLabel;
    TabDeviceSetUp: TTabSheet;
    pnlDevices: TPanel;
    tvServerDevices: TTreeView;
    pnlPeripherals: TPanel;
    ilDevices: TImageList;
    grdDeviceList: TwwDBGrid;
    qryServers: TADOQuery;
    qryServerTerminals: TADOQuery;
    qryServerPrinters: TADOQuery;
    qryTerminalDeviceList: TADOQuery;
    dsDeviceList: TDataSource;
    qryServerDeviceList: TADOQuery;
    qryServerDeviceListName: TStringField;
    qryServerDeviceListDeviceType: TStringField;
    qryServerDeviceListPortNumber: TWordField;
    qryServerDeviceListIPAddress: TStringField;
    qryServerDeviceListIPPort: TWordField;
    qryServerDeviceListEposName1: TStringField;
    qryServerDeviceListEposName2: TStringField;
    qryServerDeviceListEposName3: TStringField;
    qryTerminalDeviceListName: TStringField;
    qryTerminalDeviceListPortNumber: TWordField;
    qryTerminalDeviceListPrinterTypeName: TStringField;
    pmServer: TPopupMenu;
    AddTerminal: TMenuItem;
    AddPrinter: TMenuItem;
    EditServer: TMenuItem;
    DeleteServer: TMenuItem;
    pmNodeServerTerminal: TPopupMenu;
    AddPeripheral: TMenuItem;
    MoveTerminal: TMenuItem;
    EditTerminal: TMenuItem;
    DeleteTerminal: TMenuItem;
    pmNodeServerPrinter: TPopupMenu;
    MoveNodeServerPrinter: TMenuItem;
    EditServerPrinter: TMenuItem;
    DeleteServerPrinter: TMenuItem;
    qryServersSiteCode: TIntegerField;
    qryServersEPoSDeviceID: TSmallintField;
    qryServersPOSCode: TIntegerField;
    qryServersName: TStringField;
    qryServersIPAddress: TStringField;
    qryServersCustomerDisplayType: TIntegerField;
    qryServersScrollingMessage: TStringField;
    qryServersConfigSetID: TIntegerField;
    qryServersIsServer: TBooleanField;
    qryServerTerminalsSiteCode: TIntegerField;
    qryServerTerminalsEPoSDeviceID: TSmallintField;
    qryServerTerminalsPOSCode: TIntegerField;
    qryServerTerminalsName: TStringField;
    qryServerTerminalsIPAddress: TStringField;
    qryServerTerminalsCustomerDisplayType: TIntegerField;
    qryServerTerminalsScrollingMessage: TStringField;
    qryServerTerminalsConfigSetID: TIntegerField;
    qryServerTerminalsIsServer: TBooleanField;
    qryServerDeviceListDeviceID: TLargeintField;
    qryTerminalDeviceListDeviceID: TLargeintField;
    pmRecordTerminalPrinter: TPopupMenu;
    MoveRecordTerminalPrinter: TMenuItem;
    DeleteRecordTerminalPrinter: TMenuItem;
    ActionList1: TActionList;
    actDeleteNodeServerPrinter: TAction;
    actDeleteRecordTerminalPrinter: TAction;
    actMoveTerminal: TAction;
    actDeleteNodeTerminal: TAction;
    actMovePrinter: TAction;
    actDeleteRecordServerPrinter: TAction;
    actDeleteRecordTerminal: TAction;
    pmRecordServerPrinter: TPopupMenu;
    pmRecordTerminal: TPopupMenu;
    MoveRecordServerPrinter: TMenuItem;
    DeleteRecordServerPrinter: TMenuItem;
    MoveRecordServerTerminal: TMenuItem;
    DeleteRecordServerTerminal: TMenuItem;
    qryServerDeviceListTypeOfDevice: TStringField;
    qryTerminalDeviceListTypeOfDevice: TStringField;
    actAddNodeServerPrinter: TAction;
    AddPeripheralFromGrid: TMenuItem;
    actEditNodeTerminal: TAction;
    actEditNodeServerPrinter: TAction;
    actAddRecordTerminalPrinter: TAction;
    qryServersServerID: TSmallintField;
    qryServerTerminalsServerID: TSmallintField;
    lbPrintGroupsSelectServer: TLabel;
    cbxServerName: TwwDBLookupCombo;
    qryServersForCbx: TADOQuery;
    IntegerField1: TIntegerField;
    SmallintField1: TSmallintField;
    IntegerField2: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField3: TIntegerField;
    StringField3: TStringField;
    IntegerField4: TIntegerField;
    BooleanField1: TBooleanField;
    SmallintField2: TSmallintField;
    mmCorrectionTicket: TMemo;
    lblCorrectionticket: TLabel;
    qryTerminalDeviceListIPAddress: TStringField;
    qryTerminalDeviceListIPPort: TIntegerField;
    ilGridIcons: TImageList;
    qrySiteServers: TADOQuery;
    qrySelectedServerDetails: TADOQuery;
    pnlSelectedDetail: TPanel;
    lblIPAddress: TLabel;
    lblName: TLabel;
    lblHardwaretype: TLabel;
    lblDeviceID: TLabel;
    lblDeviceIdLabel: TLabel;
    lblHardWareTypeLabel: TLabel;
    lblIPAddressLabel: TLabel;
    lblNameLabel: TLabel;
    qrySelectTerminal: TADOQuery;
    qrySelectPeripheralDevice: TADOQuery;
    qrySelectRoot: TADOQuery;
    pmRecordServer: TPopupMenu;
    miAddTerminal: TMenuItem;
    miAddPrinter: TMenuItem;
    miEditServer: TMenuItem;
    miDeleteServer: TMenuItem;
    DBCbxCompactBillLines: TDBCheckBox;
    qryServersHardwareType: TIntegerField;
    tsPinPadGrid: TTabSheet;
    dbgPinPadGrid: TwwDBGrid;
    lbPinPadGroupsSelectServer: TLabel;
    cbxPinPadGridServer: TwwDBLookupCombo;
    qryPinPadGrid: TADOQuery;
    dsPinPadGrid: TDataSource;
    qryServersForCbx2: TADOQuery;
    IntegerField5: TIntegerField;
    SmallintField3: TSmallintField;
    IntegerField6: TIntegerField;
    StringField4: TStringField;
    StringField5: TStringField;
    IntegerField7: TIntegerField;
    StringField6: TStringField;
    IntegerField8: TIntegerField;
    BooleanField2: TBooleanField;
    SmallintField4: TSmallintField;
    qryTerminalDeviceListPrinterType: TIntegerField;
    qryServerTerminalsHardwareType: TIntegerField;
    btnClose: TButton;
    tabSheet_ConfigurationSettings: TTabSheet;
    lblEFTPorts: TLabel;
    dbEdtEFTRequestPort: TDBEdit;
    dbEdtEFTResponsePort: TDBEdit;
    lblGiftPorts: TLabel;
    dbEdtGiftRequestPort: TDBEdit;
    dbEdtGiftResponsePort: TDBEdit;
    lblGiftCardType: TLabel;
    cmbbxGiftCardType: TwwDBLookupCombo;
    Label9: TLabel;
    EFTSettingsGroup: TGroupBox;
    EFTTimeoutGrid: TwwDBGrid;
    DBEditIPAddress: TDBEdit;
    lblTerminalAddress: TLabel;
    lblEFTAddress: TLabel;
    lblGiftCardAddress: TLabel;
    EditGiftAddress: TEdit;
    EditEFTAddress: TEdit;
    qIPAddresses: TADOQuery;
    btnHotelCodeAllocation: TButton;
    cmSOAPServerTicketPrintStream: TwwDBLookupCombo;
    Label7: TLabel;
    Label8: TLabel;
    cbEftMode: TwwDBLookupCombo;
    pnDynamicEFTSettings: TPanel;
    EFTPreAuthLabel: TLabel;
    DBEditEFTPreAuthAmount: TDBEdit;
    lblFastEFTThreshold: TLabel;
    DBEditFastEFTAmount: TDBEdit;
    CommideaPinPadLoginLabel: TLabel;
    DBEditCommideaPinPadLogin: TDBEdit;
    CommideaPinPadPINLabel: TLabel;
    DBEditCommideaPinPadPIN: TDBEdit;
    CommideaTransactionTimeoutLabel: TLabel;
    DBEditCommideaTransactionTimeout: TDBEdit;
    cbEnhancedTipAdjustments: TDBCheckBox;
    dbchkPromptForCashback: TDBCheckBox;
    cbShowAccountDetailsOnEFTVoucher: TDBCheckBox;
    btSetLocalEFTServer: TButton;
    btSetLocalGiftServer: TButton;
    lbPeripheralWarnings: TLabel;
    lbStandardFooterOverrideWarning: TLabel;
    qServiceSettings: TADOQuery;
    ServerSettingsBox: TGroupBox;
    Label10: TLabel;
    edtLedgersServerIP: TEdit;
    Label19: TLabel;
    edtLedgersServerIPPort: TEdit;
    Label21: TLabel;
    edtBookingsServerIP: TEdit;
    Label22: TLabel;
    edtBookingsServerIPPort: TEdit;
    btnSetDefaultLedgersSettings: TButton;
    btnSetDefaultBookingsSettings: TButton;
    ScaleSettingsGroup: TGroupBox;
    lblDecimalPlaces: TLabel;
    lblDisplayUnit: TLabel;
    cmbbxDecimalPlaces: TDBComboBox;
    cmbbxDisplayUnit: TDBComboBox;
    Bevel1: TBevel;
    pmNodeMobileOrdering: TPopupMenu;
    ViewMobileOrderingTerminal: TMenuItem;
    cbSetCreditLimitAfterPreAuth: TDBCheckBox;
    PeripheralWarningsTimer: TTimer;
    gbAdMarginProxy: TGroupBox;
    lblAdMarginProxy: TLabel;
    DBEditAdMarginProxy: TDBEdit;
    DBcbxPromotionSavingsOnBill: TDBCheckBox;
    KMSServerSettingsBox: TGroupBox;
    lblKMSPrimaryServer: TLabel;
    lblKMSPrimaryServerPort: TLabel;
    Bevel2: TBevel;
    lblKMSBackupServer: TLabel;
    lblKMSBackupServerPort: TLabel;
    wwDBEditKMSPrimaryServer: TwwDBEdit;
    wwDBEditKMSPrimaryServerPort: TwwDBEdit;
    wwDBEditKMSBackupServer: TwwDBEdit;
    wwDBEditKMSBackupServerPort: TwwDBEdit;
    lbBillFooterOverrideWarning: TLabel;
    tabSheet_Misc: TTabSheet;
    lblTipValidationPct: TLabel;
    DBEditTipValidationPercentage: TDBEdit;
    Label13: TLabel;
    DBEdit1: TDBEdit;
    Label20: TLabel;
    DBEdit2: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    cbAutoPayoutTips: TDBCheckBox;
    cbOnClockOut: TDBCheckBox;
    SuggestedTipRangeGroup: TGroupBox;
    gbSuggestedTipTitle: TGroupBox;
    dbedSuggestedTipTitle1: TDBEdit;
    dbedSuggestedTipTitle2: TDBEdit;
    dbedSuggestedTipTitle3: TDBEdit;
    gbSuggestedTips: TGroupBox;
    dbedText1: TDBEdit;
    dbedText2: TDBEdit;
    dbedText3: TDBEdit;
    lblPC: TLabel;
    gbLines: TGroupBox;
    lblLeadingLines: TLabel;
    dbSpinLeadingLines: TwwDBSpinEdit;
    lblTrailingLInes: TLabel;
    dbSpinTrailingLines: TwwDBSpinEdit;
    gbShowSuggestedTips: TGroupBox;
    dbcbShowForBills: TDBCheckBox;
    dbcbShowForSOAPPayments: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    cbAutoDecimalEntry: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox13: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    cbAutoFillValue: TDBCheckBox;
    DBCheckBoxPrintClockOutTicket: TDBCheckBox;
    DBCheckBoxAbbreviateClockOutReport: TDBCheckBox;
    DBcbxQSRShowAztecCoursesSeparately: TDBCheckBox;
    blAutoServiceChargeCoverThreshold: TLabel;
    wwDBSpinEditAutoServiceCharge: TwwDBSpinEdit;
    lblSuggestedTipWarning: TLabel;
    lblPCName: TLabel;
    dbedPercentage1: TDBEdit;
    dbedPercentage3: TDBEdit;
    dbedPercentage2: TDBEdit;
    FakeContextMenu: TPopupMenu;
    dsPStreams2: TDataSource;
    qEditPrintStreamsAggregate: TADOQuery;
    pcPrintGroupSettings: TPageControl;
    tsGlobalPrintGroupSettings: TTabSheet;
    tsPerTerminalPrintGroupSettings: TTabSheet;
    dbgPStreams2: TwwDBGrid;
    dbgPstreams: TwwDBGrid;
    qSavePrintStreamsAggregate: TADOQuery;
    qLoadprintStreamsAggregate: TADOQuery;
    lblFilterType: TLabel;
    cbxTerminalFilterTypeName: TwwDBLookupCombo;
    adoqThemeTerminalFilterTypeLookup: TADOQuery;
    pnlWarnIfAccountOpenOnSessionChange: TPanel;
    dbchkbxLastTerminalOnly: TDBCheckBox;
    dbchkbxRestrictToSalesArea: TDBCheckBox;
    btnEditBillFooter: TButton;
    cmbbxSurveyCodeSupplier: TDBLookupComboBox;
    lblSurveyCodeSupplier: TLabel;
    disableMemoPanel: TPanel;
    mmBillFooter: TMemo;
    qryTerminalDeviceListHasCashDrawer: TBooleanField;
    DBcbxDiscountSavingsOnBill: TDBCheckBox;
    DBcbxTotalSavingsOnBill: TDBCheckBox;
    OciusPinPadLoginLabel: TLabel;
    OciusPinPadPasswordLabel: TLabel;
    OciusPinPadLoginIdDBEdit: TDBEdit;
    OciusPinPadPasswordDBEdit: TDBEdit;
    gbIPToSerialMapperPorts: TGroupBox;
    dbedtIPToSerialMapperStartPort: TDBEdit;
    lblIPToSerialMapperStart: TLabel;
    lblPortsUsedTitle: TLabel;
    lblPortsUsedLabel: TLabel;
    lblDefaultStartPort: TLabel;
    qValidateMultiDrawerMode: TADOQuery;
    cbReconfirmTipEntry: TDBCheckBox;
    cbReversePaymentDialogue: TDBCheckBox;
    DBCheckBoxPrintQrCode: TDBCheckBox;
    DBrgPrintEftVoucher: TDBRadioGroup;
    btnConfigureQRCode: TButton;
    procedure btEditCurrencyClick(Sender: TObject);
    procedure FixedDBLookupCombo2Enter(Sender: TObject);
    procedure tsPrintGroupGridHide(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tabSheet_PrintingShow(Sender: TObject);
    procedure tabSheet_PrintingHide(Sender: TObject);
    procedure EditTerminalClick(Sender: TObject);
    procedure EditTerminalPrinter1Click(Sender: TObject);
    procedure AddTerminalClick(Sender: TObject);
    procedure EditServerClick(Sender: TObject);
    procedure DeleteServerClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btSortByTillClick(Sender: TObject);
    procedure btsortbystreamClick(Sender: TObject);
    procedure tsPrintGroupGridShow(Sender: TObject);
    procedure PStreamGridDrawTitleCell(Sender: TObject; Canvas: TCanvas;
      Field: TField; Rect: TRect; var DefaultDrawing: Boolean);
    procedure DBEditPercentageChange(Sender: TObject);
    procedure PStreamGridRowChanged(Sender: TObject);
    procedure mmPrinterFooterKeyPress(Sender: TObject; var Key: Char);
    procedure pcBaseDataChange(Sender: TObject);
    procedure DBCheckBoxClick(Sender: TObject);
    procedure TabDeviceSetUpShow(Sender: TObject);
    procedure tvServerDevicesChange(Sender: TObject; Node: TTreeNode);
    procedure tvServerDevicesMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure tvServerDevicesExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure tvServerDevicesCollapsing(Sender: TObject; Node: TTreeNode;
      var AllowCollapse: Boolean);
    procedure grdDeviceListRowChanged(Sender: TObject);
    procedure grdDeviceListMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TabDeviceSetUpHide(Sender: TObject);
    procedure actMoveTerminalExecute(Sender: TObject);
    procedure actDeleteNodeTerminalExecute(Sender: TObject);
    procedure actDeleteNodeServerPrinterExecute(Sender: TObject);
    procedure actDeleteRecordTerminalExecute(Sender: TObject);
    procedure actMovePrinterExecute(Sender: TObject);
    procedure actDeleteRecordServerPrinterExecute(Sender: TObject);
    procedure actDeleteRecordTerminalPrinterExecute(Sender: TObject);
    procedure actAddNodeServerPrinterExecute(Sender: TObject);
    procedure actEditNodeTerminalExecute(Sender: TObject);
    procedure actEditNodeServerPrinterExecute(Sender: TObject);
    procedure actAddRecordTerminalPrinterExecute(Sender: TObject);
    procedure grdDeviceListDblClick(Sender: TObject);
    procedure cbxServerNameChange(Sender: TObject);
    procedure pcBaseDataChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure miAddTerminalClick(Sender: TObject);
    procedure miAddPrinterClick(Sender: TObject);
    procedure miEditServerClick(Sender: TObject);
    procedure miDeleteServerClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure dbEdtEFTRequestPortExit(Sender: TObject);
    procedure dbEdtGiftRequestPortKeyPress(Sender: TObject; var Key: Char);
    procedure tsPinPadGridShow(Sender: TObject);
    procedure tsPinPadGridHide(Sender: TObject);
    procedure cbxPinPadGridServerChange(Sender: TObject);
    procedure cbxPinPadGridServerBeforeDropDown(Sender: TObject);
    procedure cbxServerNameBeforeDropDown(Sender: TObject);
    procedure dbgPstreamsFieldChanged(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure tabSheet_ConfigurationSettingsShow(Sender: TObject);
    procedure tabSheet_ConfigurationSettingsHide(Sender: TObject);
    procedure EFTTimeoutGridFieldChanged(Sender: TObject; Field: TField);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBCheckBoxAbbreviateClockOutReportClick(Sender: TObject);
    procedure DBCheckBoxPrintClockOutTicketClick(Sender: TObject);
    procedure DBEditIPAddressChange(Sender: TObject);
    procedure useFastEFTClick(Sender: TObject);
    procedure btnHotelCodeAllocationClick(Sender: TObject);
    procedure PStreamGridCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure EditGiftAddressExit(Sender: TObject);
    procedure EditEFTAddressExit(Sender: TObject);
    procedure cbEftModeChange(Sender: TObject);
    procedure cmbbxGiftCardTypeChange(Sender: TObject);
    procedure btSetLocalEFTServerClick(Sender: TObject);
    procedure btSetLocalGiftServerClick(Sender: TObject);
    procedure cbAutoPayoutTipsClick(Sender: TObject);
    procedure cbOnClockOutClick(Sender: TObject);
    procedure btnSetDefaultLedgersSettingsClick(Sender: TObject);
    procedure btnSetDefaultBookingsSettingsClick(Sender: TObject);
    procedure edtLedgersServerIPExit(Sender: TObject);
    procedure edtBookingsServerIPExit(Sender: TObject);
    procedure edtLedgersServerIPPortKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtBookingsServerIPPortKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtLedgersServerIPPortExit(Sender: TObject);
    procedure edtBookingsServerIPPortExit(Sender: TObject);
    procedure PStreamGridMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure mmPrinterFooterKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ViewMobileOrderingTerminalClick(Sender: TObject);
    procedure PeripheralWarningsTimerTimer(Sender: TObject);
    procedure DBcbxPromotionSavingsOnBillClick(Sender: TObject);
    procedure wwDBEditKMSPrimaryServerPortKeyPress(Sender: TObject;
      var Key: Char);
    procedure wwDBEditKMSBackupServerPortKeyPress(Sender: TObject;
      var Key: Char);
    procedure wwDBEditKMSPrimaryServerKeyPress(Sender: TObject;
      var Key: Char);
    procedure wwDBEditKMSBackupServerKeyPress(Sender: TObject;
      var Key: Char);
    procedure dbgPstreamsCellChanged(Sender: TObject);
    procedure tabSheet_MiscShow(Sender: TObject);
    procedure tabSheet_MiscHide(Sender: TObject);
    procedure dbSuggestedTipTextChange(Sender: TObject);
    procedure dbSuggestedTipPercentageChange(Sender: TObject);
    procedure FakeContextMenuPopup(Sender: TObject);
    procedure pcPrintGroupSettingsChange(Sender: TObject);
    procedure dbgPStreams2CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure dbgPStreams2FieldChanged(Sender: TObject; Field: TField);
    procedure tsPerTerminalPrintGroupSettingsHide(Sender: TObject);
    procedure tsGlobalPrintGroupSettingsHide(Sender: TObject);
    procedure PStreamGridDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure PStreamGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tsPerTerminalPrintGroupSettingsShow(Sender: TObject);
    procedure tsGlobalPrintGroupSettingsShow(Sender: TObject);
    procedure cbxTerminalFilterTypeNameChange(Sender: TObject);
    procedure cbxTerminalFilterTypeNameBeforeDropDown(Sender: TObject);
    procedure PStreamGridKeyPress(Sender: TObject; var Key: Char);
    procedure DBCheckBox13Click(Sender: TObject);
    procedure btnEditBillFooterClick(Sender: TObject);
    procedure dbedtIPToSerialMapperStartPortExit(Sender: TObject);
    procedure MemoBoxOnExit(Sender: TObject);
    procedure cbReconfirmTipEntryClick(Sender: TObject);
    procedure cbReversePaymentDialogueClick(Sender: TObject);
    procedure btnQRTestClick(Sender: TObject);
    procedure btnConfigureQRCodeClick(Sender: TObject);
  private
    sIPAddress : String;
    bill_ps, report_ps, eft_ps: integer;
    load_printfooter: string;
    load_CorrectionReasonFooter: string;
    SelectedNode, RecordNode: TTreeNode;
    OldEftMode: string;
    function CheckForEftPeripheralWarnings(EftMode: string; var PeripheralWarnings: string): Boolean; overload;
    function CheckForEftPeripheralWarnings(EftMode: string; WarningsList: TStrings): Boolean; overload;
    procedure FormatDynamicEFTSettings;
    procedure ReadPStreamCodes;
    procedure CreatePinPadAccess(PrinterType, SiteCode, EposDeviceID, PeripheralID: integer);
    procedure RefreshServerCombos;
    procedure ShowTerminalPrinterDialog(fromNodeMenu: Boolean; mode: Integer);
    procedure ShowTerminalDialog(fromNodeMenu: Boolean; mode: Integer);
    procedure PStreamLoad;
    procedure PStreamSave;
    procedure LoadPinPadGrid;
    procedure SavePinPadGrid;
    procedure FormatPStreamTable;
    function CheckOtherSetups(var WarningsString: string): Boolean;
    procedure CheckPrintStreams(var WarningsList: TStrings);
    procedure CheckPayAtTableVersion(var WarningsList: TStrings);
    procedure BuildServerDevicesTree;
    procedure FindNodeForRecord(ObjectType: TDeviceObjectType; ObjectName: String);
    procedure DeleteTheServer(fromNodeMenu: Boolean);
    procedure DeleteTheTerminal(fromNodeMenu: Boolean);
    procedure DeleteThePrinter(fromNodeMenu: Boolean);
    procedure DestroyPreviousSubMenuItems(aMenuItem: TMenuItem);
    procedure AddMovePeripheralSubMenuItems(FromNode: Boolean; aMenuItem: TMenuItem; aDeviceID, aPeripheralTypeID, currentParentID: Integer);
    procedure AddMoveTerminalSubMenuItems(FromNode: Boolean; aMenuItem: TMenuItem; aTerminalID, currentServerID: Integer);
    function EFTConfigurationFieldsValid: Boolean;
    procedure RefreshSelectedDetailPanel;
    procedure RefreshDeviceListGrid;
    function isConquerorDevice ( EPoSDeviceID : Integer ) : Boolean;
    procedure SetCommideaUsage(Enabled : boolean);
    //function getSiteAztecVersion : Boolean;
    //function upgradeRequired(ReqDBVer : String) : Boolean;
    procedure SetIPAddresses;
    procedure SetServerSettings;
    procedure GetIPAddress;
    procedure LogDBCheckBoxClick(DBCheckBox: TDBCheckBox);
    procedure ValidateIPAddress(IPAddress: String; Sender: TObject);
    procedure ValidateIPPort(IPPort: String; Sender: TObject);
    procedure GetOptionalPrintingStreams;
    procedure SetOptionalPrintingStreams(PrintStreamID, EPoSDeviceID : LargeInt; SiteCode : Integer);
    procedure SetSuggestedTipWarning;
    function VX670PrintStreamSetupOK(ShowError: Boolean): Boolean;
    procedure ValidateIntegerKeyPress(var Key: Char);
    function KMSConfigurationFieldsValid: Boolean;
    procedure FormatPStreamTable2;
    procedure PStreamSaveAggregate;
    procedure BuildAggregatePrintStreamView;
    procedure TogglePrintTabFilterFilters;
    procedure RefreshBillFooterMemoText;
    function ShouldDisableOciusControls: Boolean;
    procedure UpdateIPToSerialMapperPortRange(StartPortNumber: Integer);
    procedure UpdateTipsTransferredToTipPoolSetting(siteId: Integer);
    procedure UpdateDelayedOrderTipsAutoAssignedToUserServingSetting(siteId: Integer);
    procedure DisableBaseDataIOrderTipSettingsIfRequired(siteId: Integer);
    procedure UpdateEftRecallSlipState();
  public
    FSiteCode : Integer;
    PStreamSortMode: integer;
    constructor Create(AOwner: TComponent); override;
  end;


  TDeviceObject = class(TObject)
  private
    FDeviceType: integer;
    FPeripheralType: integer;
    FTreeNode: TTreeNode;
    procedure SetDeviceType(const Value: integer);
    procedure SetPeripheralType(const Value: integer);
    function GetIcon: integer;
    function GetIsVirtual: boolean;
    function GetTerminalCount: integer;
    //
  public
    deviceObjectType: TDeviceObjectType;
    deviceID: Integer;
    Expanded: Boolean;
    Collapsed: Boolean;
    DialogWasDisplayed: Boolean;
    constructor Create(TreeNode: TTreeNode; aDeviceObjectType: TDeviceObjectType; ADeviceType, APeripheralType, aDeviceID: Integer);
    property DeviceType: integer read FDeviceType write SetDeviceType;
    property PeripheralType: integer read FPeripheralType write SetPeripheralType;
    property IsVirtual: boolean read GetIsVirtual;
    property TerminalCount: Integer read GetTerminalCount;
  end;

  TMoveAction = class(TAction)
  public
    DeviceID: Integer;
    MoveToDeviceID: Integer;
    MoveToDeviceName: String;
    CurrentServerID: Integer;
    NewServerID: Integer;
    PortNumber: Integer;
    CalledFromNode: Boolean;
    PrinterType: String;
  end;


type TwwHintGrid = class(TwwDBGrid);




implementation

uses uADO, uAddEditPrinter, uAddEditTerminal, uAddEditConquerorTerminal, dADOAbstract, uDMThemeData,
  uGenerateThemeIDs, uAztecLog, uSelectPort,
  uEditGenericDetails, uAztecDatabaseUtils, uSwipeCardRanges, AztecResourceStrings, uAddEdit, uEposDevice,
  uHardwareIcons, uTerminalGraphics, uSimpleLocalise, uGLobals,
  uFormNavigate, uHotelCodeAllocation, uEditHotelAnalysisCode, uEditSCaleContainer,
  uScaleContainerDeletionDialog, uEditDiscount, uViewMOATerminal,
  uBaseEditReconfigurePinPads, uThemeModellingMenu, uEditOutletBillFooter, uConfigureQRCode;


const
  ROOT_IMAGE = 0;
  SERVER_IMAGE = 1;
  TERMINAL_IMAGE = 2;
  PRINTER_IMAGE = 3;  //TODO:  Change value when till printer icon becomes available
  BARCODE_READER = 4;
  PINPAD = 5;

{$R *.dfm}

function TreeSortProc(Node1, Node2: TTreeNode; Data: Longint): Integer; stdcall;
begin
  Result := 0;

  if (TDeviceObject(Node1.Data).deviceType = TDeviceObject(Node2.Data).deviceType) then
    Result := AnsiStrIComp(PChar(Node1.Text), PChar(Node2.Text))
  else if (TDeviceObject(Node1.Data).deviceObjectType = doTerminal) and
          (TDeviceObject(Node2.Data).deviceObjectType = doPrinter) then
    Result := -1;
end;

{ TDeviceObject implementation }

constructor TDeviceObject.Create(TreeNode: TTreeNode; aDeviceObjectType: TDeviceObjectType; ADeviceType, APeripheralType, aDeviceID: Integer);
begin
  inherited create;
  FTreeNode := TreeNode;
  deviceObjectType := aDeviceObjectType;
  deviceID := aDeviceID;
  DeviceType := ADeviceType;
  PeripheralType := APeripheralType;
end;


{ TBaseEdit implementation }

procedure TBaseEdit.AddTerminalClick(Sender: TObject);
begin
  Log('Pop Up menu, Add Terminal button clicked');


  if TDeviceObject(tvServerDevices.Selected.Data).deviceObjectType = doConquerorServer then
  begin
    ShowTerminalDialog(True,ADD_CONQUEROR_TERMINAL);
  end else
    ShowTerminalDialog(True,ADD_TERMINAL);
end;

//------------------------------------------------------------------------------
procedure TBaseEdit.EditTerminalClick(Sender: TObject);
begin
  Log('Pop Up menu, Edit Terminal button clicked');
  if TDeviceObject(tvServerDevices.Selected.Data).deviceObjectType = doConquerorTerminal then
    ShowTerminalDialog(True,EDIT_CONQUEROR_TERMINAL)
  else if TDeviceObject(tvServerDevices.Selected.Data).deviceObjectType = doMOAOrderPad then
    ShowTerminalDialog(TRUE, EDIT_MOA_ORDER_PAD)
  else if TDeviceObject(tvServerDevices.Selected.Data).deviceObjectType = doiZoneTables then
    ShowTerminalDialog(TRUE, SHOW_IZONE_TABLES)
  else
    ShowTerminalDialog(TRUE,EDIT_TERMINAL);
end;

procedure TBaseEdit.DeleteTheTerminal(fromNodeMenu: Boolean);
var
  SQLStr : string;
  SiteCode, EposDeviceID : Integer;
begin

  if fromNodeMenu then
    EposDeviceID := dmado.qGetTerminals.FieldByName('EposDeviceID').AsInteger
  else
    EposDeviceID := grdDeviceList.DataSource.DataSet.FieldByName('DeviceID').AsInteger;

  //** As with terminal Printers it doesnt like it when we delete form the dataset
  //** directly so need to do it using another query

  //There is a trigger in Aztec DB that deletes peripherals attached to
  //a deleted terminal so we don't need to do this here
  Log('Pop Up menu, Delete Terminal button clicked');

  SQlStr := 'DELETE FROM ThemeEposDevice Where SiteCode = %d and EposDeviceID = %d';
  SiteCode := FSiteCode;
  dmADO.qRun.SQL.Text := format(SQLStr,[SiteCode,EposDeviceID]);
  Log(Format('Deleting Device Code %d',[EposDeviceID]));
  dmADO.qRun.ExecSQL;

  if isConquerorDevice (EPoSDeviceID) then
  begin
    with dmADO.qRun do
    begin
      close;
      sql.clear;
      sql.add ('DELETE FROM ConquerorEPoSDeviceDetails WHERE EposDeviceID = :EposDeviceID');
      parameters.parambyname('EposDeviceID').Value :=  EposDeviceID;
      execsql;
    end;
  end;

  dmADO.qGetTerminals.Close;
  dmADO.qGetTerminals.Open;

  if fromNodeMenu then
  begin
    tvServerDevices.Items.Delete(selectedNode);
    SelectedNode := nil;
  end
  else
  begin
    tvServerDevices.Items.Delete(RecordNode);
    RecordNode := nil;
    RefreshDeviceListGrid;
  end;
end;

//------------------------------------------------------------------------------
procedure TBaseEdit.EditServerClick(Sender: TObject);
begin
  Log('Pop Up menu, Edit Server button clicked');

  if TDeviceObject(tvServerDevices.Selected.Data).deviceObjectType = doConquerorServer then
    ShowTerminalDialog(TRUE,EDIT_CONQUEROR_SERVER)
  else
    ShowTerminalDialog(TRUE,EDIT_SERVER)
end;

//------------------------------------------------------------------------------
procedure TBaseEdit.DeleteServerClick(Sender: TObject);
begin
  if MessageDlg(
    Format(DELETE_SERVER_AREYOUSURE, [QuotedStr(SelectedNode.Text)]),
    mtConfirmation,[mbYes, mbNo], 0
  ) = mrYes then
  begin
    Log('Pop up menu, Delete Node Server Menu Item clicked and confirmed');
    DeleteTheServer(TRUE);
  end;
end;


//------------------------------------------------------------------------------
procedure TBaseEdit.FixedDBLookupCombo2Enter(Sender: TObject);
begin
end;

//------------------------------------------------------------------------------
procedure TBaseEdit.tsPrintGroupGridHide(Sender: TObject);
begin
  //If the global print setting page was the last one visible save it prior to
  //saving the underlying master data.
  if pcPrintGroupSettings.ActivePage = tsGlobalPrintGroupSettings then
    PStreamSaveAggregate;
  PStreamSave;
  if not VX670PrintStreamSetupOK(true) then abort;
end;

//------------------------------------------------------------------------------
procedure TBaseEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Log('Form Closed ' + Caption);
  Nav.MoveBack;
end;

procedure TBaseEdit.tabSheet_PrintingShow(Sender: TObject);
begin
  with dmADO do
  begin
    dmThemeData.AccessDataset(qryGiftCardTypes);
    dmThemeData.AccessDataset(qOutletPrintConfigs);
    dmThemeData.AccessDataset(qOutletConfigs);
    dmThemeData.AccessDataset(qGetOutletBillFooterText);
    load_printfooter := qOutletPrintConfigs.fieldbyname('PrintFooter1').asstring + #13#10 +
      qOutletPrintConfigs.fieldbyname('PrintFooter2').asstring + #13#10 +
      qOutletPrintConfigs.fieldbyname('PrintFooter3').asstring + #13#10 +
      qOutletPrintConfigs.fieldbyname('PrintFooter4').asstring + #13#10 +
      qOutletPrintConfigs.fieldbyname('PrintFooter5').asstring + #13#10 +
      qOutletPrintConfigs.fieldbyname('PrintFooter6').asstring;

    RefreshBillFooterMemoText;

    load_CorrectionReasonFooter := qOutletPrintConfigs.fieldbyname('CorrectionTicketFooter1').asstring + #13#10 +
      qOutletPrintConfigs.fieldbyname('CorrectionTicketFooter2').asstring + #13#10 +
      qOutletPrintConfigs.fieldbyname('CorrectionTicketFooter3').asstring + #13#10 +
      qOutletPrintConfigs.fieldbyname('CorrectionTicketFooter4').asstring + #13#10 +
      qOutletPrintConfigs.fieldbyname('CorrectionTicketFooter5').asstring + #13#10 +
      qOutletPrintConfigs.fieldbyname('CorrectionTicketFooter6').asstring;
    mmPrinterFooter.Text := load_printfooter;
    mmCorrectionTicket.Text := load_CorrectionReasonFooter;
    SetCommideaUsage(qOutletConfigs.FieldByName('EFTMode').Value = 1);
    lbStandardFooterOverrideWarning.Visible := not qOutletPrintConfigs.FieldByName('StandardFooterOverrideId').IsNull;
    lbBillFooterOverrideWarning.Visible := not qOutletPrintConfigs.FieldByName('BillFooterOverrideId').IsNull;
  end;
  DBCheckBoxAbbreviateClockOutReport.Enabled := DBCheckBoxPrintClockOutTicket.Checked;
end;

procedure TBaseEdit.tabSheet_PrintingHide(Sender: TObject);
var
  i: integer;
begin
  if dmADO.qOutletPrintConfigs.state in [dsEdit, dsInsert] then
    dmADO.qOutletPrintconfigs.Post;
  if dmADO.qOutletBillFooter.state in [dsEdit, dsInsert] then
    dmADO.qOutletBillFooter.Post;

  if not VX670PrintStreamSetupOK(true) then abort;
  // If called in "validation" mode and valid, exit before datasets are closed
  if Sender = nil then exit;

  with dmADO do
  begin
    for i := 6 downto 1 do
      if (mmPrinterFooter.Lines.count >= i) then
      begin
        if (mmPrinterFooter.lines[i] = '') then
          mmPrinterFooter.Lines.Delete(i)
        else
         break;
      end;
    for i := 1 to 6 do
      if (mmCorrectionTicket.Lines.Count >= i) then
      begin
        if (mmCorrectionTicket.Lines[i] = '') then
          mmCorrectionTicket.Lines.Delete(i)
        else
          Break;
      end;
    if (mmPrinterFooter.Text <> load_printfooter) then
    begin
      qOutletPrintConfigs.Edit;
      for i := 1 to 6 do
      begin
        if mmPrinterFooter.Lines.count >= i then
          qOutletPrintConfigs.fieldbyname('PrintFooter'+inttostr(i)).asstring := mmPrinterFooter.lines[i-1]
        else
          qOutletPrintConfigs.fieldbyname('PrintFooter'+inttostr(i)).clear;
      end;
      load_printfooter := mmprinterfooter.text;
    end;
    //Correction Reasons Ticket
    if mmCorrectionTicket.Text <> load_CorrectionReasonFooter then
    begin
      qOutletPrintConfigs.Edit;
      for i := 1 to 6 do
      begin
        if mmCorrectionTicket.Lines.Count >= i then
           qOutletPrintConfigs.fieldbyname('CorrectionTicketFooter'+inttostr(i)).asstring := mmCorrectionTicket.lines[i-1]
        else
           qOutletPrintConfigs.fieldbyname('CorrectionTicketFooter'+inttostr(i)).clear;
      end;
      load_CorrectionReasonFooter := mmCorrectionTicket.Text;
    end;
    dmThemeData.DeAccessDataset(qOutletConfigs, true);
    dmThemeData.DeAccessDataset(qOutletPrintConfigs, true);
    dmThemeData.DeAccessDataset(qryGiftCardTypes);
    dmThemeData.DeAccessDataset(qGetOutletBillFooterText);
  end;
  ReadPStreamCodes;
end;

//------------------------------------------------------------------------------
// Mode 0 = edit terminal, Mode 1 = add terminal, Mode 2 = edit server, Mode 3 = add server,
// Mode 4 = edit conqueror terminal, Mode 5 = add conqueror terminal, Mode 6 = edit conqueror server,
// Mode 7 = edit MOA Order Pad
procedure TBaseEdit.ShowTerminalDialog(fromNodeMenu: Boolean; mode : Integer);
var
  CurrentForm : TfrmAddEdit;
  newNode, TempNode: TTreeNode;
  TmpDeviceType: TDeviceObjectType;
begin
  if dmADO.qGetTerminals.State in [dsInsert, dsEdit] then
    dmADO.qGetTerminals.Post;

  if mode in [EDIT_CONQUEROR_TERMINAL, ADD_CONQUEROR_TERMINAL] then
    CurrentForm := TfrmAddEditConquerorTerminal.Create(nil)
  else
    CurrentForm := TfrmAddEditTerminal.Create(nil);

  try
    CurrentForm.FSiteCode := FSiteCode;
    CurrentForm.FMode := Mode;
    CurrentForm.dsEditRec.DataSet := dmado.qGetTerminals;

    if mode in [EDIT_TERMINAL, ADD_TERMINAL] then
    begin
      qValidateMultiDrawerMode.Close;
      qValidateMultiDrawerMode.Parameters.ParamByName('SiteId').Value:= FSiteCode;
      qValidateMultiDrawerMode.Parameters.ParamByName('EposDeviceId').Value:= TDeviceObject(SelectedNode.Data).DeviceID;
      qValidateMultiDrawerMode.Open;

      //TODO: This seems like the wrong place for FCanSetMultiDrawerMode as it
      //      is a property of an abstract class that is used as the basis for
      //      both uAddEditPrinter and uAddEditTerminal.
      //      EB 21/4/'17
      CurrentForm.FCanSetMultiDrawerMode := (qValidateMultiDrawerMode.RecordCount > 0) OR (mode in [ADD_TERMINAL]);
    end;
    
    qValidateMultiDrawerMode.Close;

    if fromNodeMenu then
      CurrentForm.FParentDeviceID := TDeviceObject(SelectedNode.Data).DeviceID
    else
      CurrentForm.FParentDeviceID := grdDeviceList.DataSource.DataSet.FieldByName('DeviceID').AsInteger;

    case Mode of
      EDIT_TERMINAL:           CurrentForm.Caption := 'Edit Site Terminal Configuration';
      ADD_TERMINAL:            CurrentForm.Caption := 'Add Site Terminal Configuration';
      EDIT_SERVER:             CurrentForm.Caption := 'Edit Site Server Configuration';
      ADD_SERVER:              CurrentForm.Caption := 'Add Site Server Configuration';
      EDIT_CONQUEROR_TERMINAL: CurrentForm.Caption := 'Edit Conqueror Terminal Configuration';
      ADD_CONQUEROR_TERMINAL:  CurrentForm.Caption := 'Add Conqueror Terminal Configuration';
      EDIT_CONQUEROR_SERVER:   CurrentForm.Caption := 'Edit Conqueror Server Configuration';
      EDIT_MOA_ORDER_PAD:      CurrentForm.Caption := 'Edit MOA Order Pad Configuration';
      SHOW_IZONE_TABLES:       Currentform.Caption := 'Show iZone Tables Configuration';
    end;

    if CurrentForm.ShowModal = mrOK then
    begin
      TDeviceObject(SelectedNode.Data).DeviceType :=
        CurrentForm.dsEditRec.DataSet.FieldByName('HardwareType').AsInteger;
      // Correct a display glitch when a node is selected, moved, then has icon changed
      SelectedNode.TreeView.Invalidate;
      case Mode of
        EDIT_TERMINAL, EDIT_MOA_ORDER_PAD:
          begin
            // ensure that node is updated with any name change
            if fromNodeMenu then
            begin
              SelectedNode.Text := CurrentForm.dsEditRec.DataSet.FieldByName('Name').Value;
              RefreshSelectedDetailPanel;
            end
            else
            begin
              RecordNode.Text := CurrentForm.dsEditRec.DataSet.FieldByName('Name').Value;
              RefreshDeviceListGrid;
            end;
          end;
        ADD_TERMINAL:
          begin
            if fromNodeMenu then
              newNode := tvServerDevices.Items.AddChild(SelectedNode, CurrentForm.dsEditRec.DataSet.FieldByName('Name').Value)
            else
              newNode := tvServerDevices.Items.AddChild(RecordNode, CurrentForm.dsEditRec.DataSet.FieldByName('Name').Value);

            newNode.ImageIndex := TERMINAL_IMAGE;
            newNode.SelectedIndex := TERMINAL_IMAGE;
            newNode.Data := TDeviceObject.Create(newNode, doTerminal, CurrentForm.dsEditRec.DataSet.FieldByName('HardwareType').AsInteger, -1,  CurrentForm.dsEditRec.DataSet.FieldByName('EPoSDeviceID').Value);

            RefreshDeviceListGrid;
          end;
        EDIT_SERVER, EDIT_CONQUEROR_SERVER:
           begin
            // ensure that node is updated with any name change
            if TDeviceObject(SelectedNode.Data).IsVirtual then
            begin
              with dmADO.adoqRun do
              begin
                SQL.Text := Format('delete ThemeEposPrinter where SiteCode = %d and EPOSDeviceId = %d',
                  [FSiteCode, TDeviceObject(SelectedNode.Data).DeviceID]);
                if ExecSQL > 0 then
                begin
                  TempNode := SelectedNode.getFirstChild;
                  while Assigned(TempNode) do
                  begin
                    if TDeviceObject(TempNode.Data).PeripheralType > 0 then
                    begin
                      TempNode.Delete;
                      TempNode := nil;
                    end;
                    if Assigned(TempNode) then
                      TempNode := SelectedNode.GetNextChild(TempNode)
                    else
                      TempNode := SelectedNode.getFirstChild;
                  end;

                  MessageDlg(
                    Format('As %s is now a virtual device, its peripherals are invalid and have been removed.',
                      [SelectedNode.Text]),
                    mtWarning, [mbOk], 0);
                end;
              end;
            end;
            if fromNodeMenu then
            begin
              SelectedNode.Text := CurrentForm.dsEditRec.DataSet.FieldByName('Name').Value;
              RefreshSelectedDetailPanel;
            end
            else
            begin
              RecordNode.Text := CurrentForm.dsEditRec.DataSet.FieldByName('Name').Value;
              RefreshDeviceListGrid;
            end;
          end;
        ADD_SERVER:
          begin
            newNode := tvServerDevices.Items.AddChild(selectedNode, CurrentForm.dsEditRec.DataSet.FieldByName('Name').Value);
            newNode.ImageIndex := SERVER_IMAGE;
            newNode.SelectedIndex := SERVER_IMAGE;

            case TEPOSHardwareType(CurrentForm.dsEditRec.DataSet.FieldByName('HardwareType').AsInteger) of
            ehtConqueror:
              TmpDeviceType := doConquerorServer;
            ehtHotelSystem:
              TmpDeviceType := doHotelSystemServer;
            else
              TmpDeviceType := doServer;
            end;

            newNode.Data := TDeviceObject.Create(newNode, TmpDeviceType, CurrentForm.dsEditRec.DataSet.FieldByName('HardwareType').AsInteger, -1, CurrentForm.dsEditRec.DataSet.FieldByName('EPoSDeviceID').Value);
            RefreshDeviceListGrid;
          end;
        ADD_CONQUEROR_TERMINAL:
          begin

            if fromNodeMenu then
              newNode := tvServerDevices.Items.AddChild(SelectedNode, CurrentForm.dsEditRec.DataSet.FieldByName('Name').Value)
            else
              newNode := tvServerDevices.Items.AddChild(RecordNode, CurrentForm.dsEditRec.DataSet.FieldByName('Name').Value);
            newNode.ImageIndex := TERMINAL_IMAGE;
            newNode.SelectedIndex := TERMINAL_IMAGE;
            newNode.Data := TDeviceObject.Create(newNode, doConquerorTerminal, CurrentForm.dsEditRec.DataSet.FieldByName('HardwareType').AsInteger, -1, CurrentForm.dsEditRec.DataSet.FieldByName('EPoSDeviceID').Value);
            RefreshDeviceListGrid;
          end;
      end;
      tvServerDevices.CustomSort(@TreeSortProc,0);
    end;
  finally
    FreeAndNil(CurrentForm);
  end;
end;

//------------------------------------------------------------------------------
// Mode 0 = Edit Peripheral, Mode 1 = Add Peripheral
procedure TBaseEdit.ShowTerminalPrinterDialog(fromNodeMenu: Boolean; mode : Integer);
var
  dlg : TfrmAddEditPrinter;
  newNode: TTreeNode;
  deviceID: integer;
begin
  if dmADO.qGetTerminals.State in [dsEdit, dsInsert] then
    dmADO.qGetTerminals.post;

  if (TDeviceObject(SelectedNode.Data).FDeviceType = 12)
  and (dmADO.qTerminalPrinters.RecordCount = 2)
  and (Mode = ADD_PERIPHERAL) then
  begin
    MessageDlg('MOA Orderpads may have a maximum of two IP devices defined.', mtInformation, [mbOK], 0);
    Exit;
  end;

  if (TDeviceObject(SelectedNode.Data).FDeviceType = 25)
  and (dmADO.qTerminalPrinters.RecordCount = 5)
  and (Mode = ADD_PERIPHERAL) then
  begin
    MessageDlg('AzOne terminal may have a maximum of five IP devices defined.', mtInformation, [mbOK], 0);
    Exit;
  end;

  dlg := nil;
  try
    dlg := TfrmAddEditPrinter.Create(nil);
    dlg.FMode := Mode;
    dlg.FSiteCode := FSiteCode;
    dlg.dsEditRec.DataSet := dmado.qTerminalPrinters;    // doesnt matter if its a server printer or terminal printer

    if (Mode = ADD_PERIPHERAL) then
    begin
      if fromNodeMenu then
        dlg.FParentDeviceID := TDeviceObject(SelectedNode.Data).deviceID
      else
        dlg.FParentDeviceID := TDeviceObject(RecordNode.Data).deviceID;
    end
    else              //Edit mode
    begin
      if fromNodeMenu then
        dlg.FParentDeviceID := TDeviceObject(SelectedNode.Parent.Data).deviceID
      else
        dlg.FParentDeviceID := TDeviceObject(RecordNode.Parent.Data).deviceID;
    end;

    if dlg.ShowModal = mrOK then
    begin
      TDeviceObject(SelectedNode.Data).PeripheralType :=
        dlg.dsEditRec.DataSet.fieldbyname('PrinterType').AsInteger;
      // Correct a display glitch when a node is selected, moved, then has icon changed
      SelectedNode.TreeView.Invalidate;
      case Mode of
        EDIT_PERIPHERAL:
          begin
            // ensure that node and detail panel are updated with any changes
            if fromNodeMenu then
            begin
              SelectedNode.Text := dlg.dsEditRec.DataSet.FieldByName('Name').Value;
              RefreshSelectedDetailPanel;
            end
            else
            begin
              deviceID := dlg.dsEditRec.DataSet.FieldByName('PrinterID').Value;
              RecordNode.Text := dlg.dsEditRec.DataSet.FieldByName('Name').Value;
              RefreshDeviceListGrid;
              grdDeviceList.DataSource.DataSet.Locate('DeviceID',deviceID,[]);
            end;
          end;
        ADD_PERIPHERAL:
          begin
            // Create Pin pad access grid entry if required
            CreatePinPadAccess(
              dlg.dsEditRec.DataSet.FieldByName('PrinterType').AsInteger,
              dlg.dsEditRec.DataSet.FieldByName('SiteCode').AsInteger,
              dlg.dsEditRec.DataSet.FieldByName('EposDeviceID').AsInteger,
              dlg.dsEditRec.DataSet.FieldByName('PrinterID').AsInteger
            );

            if fromNodeMenu then
              NewNode := tvServerDevices.Items.AddChild(SelectedNode, dlg.dsEditRec.DataSet.FieldByName('Name').Value)
            else
              NewNode := tvServerDevices.Items.AddChild(RecordNode, dlg.dsEditRec.DataSet.FieldByName('Name').Value);

            NewNode.ImageIndex := PRINTER_IMAGE;
            NewNode.SelectedIndex := PRINTER_IMAGE;
            NewNode.Data := TDeviceObject.Create(newNode, doPrinter, -1, dlg.dsEditRec.DataSet.FieldByName('PrinterType').AsInteger, dlg.dsEditRec.DataSet.FieldByName('PrinterID').Value);

            RefreshDeviceListGrid;
          end;
      end;
      tvServerDevices.CustomSort(@TreeSortProc,0);
    end;
  finally
    dlg.Free;
  end;
end;

procedure TBaseEdit.GetOptionalPrintingStreams;
begin
  with dmADO.qRun do
    begin
      Close;
      SQL.Text := Format('SELECT tep.EPosDeviceID, PrintStreamID, COUNT(DISTINCT PrinterID) AS OptionalCount '+
                         '       FROM ThemeEposPrinterStream tep '+
                         '            INNER JOIN ThemeEposDevice ted ON tep.EposDeviceID = ted.EposDeviceID AND tep.SiteCode = ted.SiteCode '+
                         ' WHERE tep.SiteCode = %d '+
                         ' GROUP BY tep.EPoSDeviceID, PrintStreamID', [FSiteCode]);
      Open;
      First;
      while not EOF do
         begin
           // set minus one to capture pending deletion of printer.
           if (FieldByName('OptionalCount').AsInteger - 1) <= 1 then
              SetOptionalPrintingStreams(FieldByName('PrintStreamID').AsInteger, FieldByName('EPosDeviceID').AsInteger, FSiteCode);
           Next;
         end;
    end;
end;

procedure TBaseEdit.SetOptionalPrintingStreams(PrintStreamID, EPoSDeviceID : LargeInt; SiteCode : Integer);
begin
  with dmThemeData.adoqRun do
     begin
       Close;
       SQL.Text := Format('UPDATE ThemeEposPrinterStream SET Optional = 0 '+
                          ' WHERE PrintStreamID = %d AND EPoSDeviceID = %d AND SiteCode = %d', [PrintStreamID, EPoSDeviceID, SiteCode]);
       ExecSQL;
    end;
end;

//------------------------------------------------------------------------------
procedure TBaseEdit.EditTerminalPrinter1Click(Sender: TObject);
begin
  Log('Pop Up Menu, Edit Device clicked');
  ShowTerminalPrinterDialog(TRUE,0);
end;

procedure TBaseEdit.DeleteThePrinter(fromNodeMenu: Boolean);
var
  printerID: LargeInt;
begin
  Log('Pop Up Menu, Delete Device clicked');

  if fromNodeMenu then
    printerID := TLargeIntField(dmADO.qTerminalPrinters.FieldByName('PrinterID')).AsLargeInt
  else
    printerID := TLargeIntField(grdDeviceList.DataSource.DataSet.FieldByName('DeviceID')).AsLargeInt;

  if (dmADO.qTerminalPrinters.recordcount > 0) then
  begin
    dmADO.AztecConn.BeginTrans;
    try
      //** Redirection Printers accessing this printer are Nulled via a trigger
      //** Print Streams are deleted using cascading delete on Foreign Key.

      //** The deletion of the Record is not very elegant. But just deleteing form the
      //** gTerminalPrinters dataset causes problems such as cannot locate row in dataset blah blah blah
      //** so I could either do the dataset delete and then use a query to correct
      //** the referential integrity . Or just use a query to delete from the table
      //** directly and allow the database to do the rest
      Log('Deleting Device ID - ' + IntToStr(printerID));

      GetOptionalPrintingStreams;

      dmADO.qRun.SQL.Text := format('Delete FROM ThemeEposPrinter Where PrinterID = %d', [printerID]);
      dmADO.qRun.ExecSQL;
      dmADO.qTerminalPrinters.Close;
      dmADO.qTerminalPrinters.Open;
      dmADO.AztecConn.CommitTrans;
      // remove node
      if fromNodeMenu then
      begin
        tvServerDevices.Items.Delete(selectedNode);
        SelectedNode := nil;
      end
      else
      begin
        if Assigned(RecordNode) then
        begin
          tvServerDevices.Items.Delete(RecordNode);
          RecordNode := nil;
        end;
        RefreshDeviceListGrid;
      end;
    except
      if dmADO.AztecConn.InTransaction then
        dmADO.AztecConn.RollbackTrans;
    end;
  end;
end;

procedure TBaseEdit.btEditCurrencyClick(Sender: TObject);
begin
end;

//------------------------------------------------------------------------------
procedure TBaseEdit.FormShow(Sender: TObject);
begin
  dmADO.LogDuration('Form Show ' + Caption);

  dmThemeData.SetBaseEditSiteVersion;
  Log('Loading Data for Site Code ' + dmthemedata.qOutlets.fieldbyname('SiteCode').asString +
    ', v. ' + dmThemeData.SiteVersionString);
  pcBaseData.ActivePage := TabDeviceSetUp;  //** because I keep forgetting to set it when I am working in the designer!!!
  RefreshServerCombos;
  dmThemeData.qConfigSetsUseFastEFT.ReadOnly := not CurrentUser.IsZonalUser;
  DBEditEFTPreAuthAmount.Visible := uGlobals.UKUSmode = 'US';
  DBEditFastEFTAmount.Visible := CurrentUser.IsZonalUser;
  EFTPreAuthLabel.Visible := uGlobals.UKUSmode = 'US';
  cbEnhancedTipAdjustments.Visible :=uGlobals.UKUSmode = 'US';
  if (not cbEnhancedTipAdjustments.Visible) then
  begin
    cbSetCreditLimitAfterPreAuth.Left := cbEnhancedTipAdjustments.Left;
  end;
  cbSetCreditLimitAfterPreAuth.Visible := not cbEnhancedTipAdjustments.Visible;
  EFTSettingsGroup.Visible := uGlobals.UKUSmode = 'US';
  cbEnhancedTipAdjustments.Enabled := dmThemeData.SiteVersionAtLeast('3.3.0.0'); // dmADO.ISSiteVersionOK('3.3.0.0');
  EFTTimeoutGrid.Enabled := dmThemeData.SiteVersionAtLeast('3.3.0.0');
  btnHotelCodeAllocation.Visible := dmThemeData.SiteVersionAtLeast('3.4.0.0');

  if not dmThemeData.SiteVersionAtLeast('3.5.8.40401') then
  begin
    DBEditAdMarginProxy.Enabled := False;
    gbAdMarginProxy.Hint := 'Only available on sites at version 3.5.8 and higher.';
    gbAdMarginProxy.ShowHint := True;
  end;

  if not dmThemeData.SiteVersionAtLeast('3.5.12.45677') then
  begin
    wwDBEditKMSPrimaryServer.Enabled := False;
    wwDBEditKMSPrimaryServerPort.Enabled := False;
    wwDBEditKMSBackupServer.Enabled := False;
    wwDBEditKMSBackupServerPort.Enabled := False;
    KMSServerSettingsBox.Hint := 'Only available on sites at version 3.5.12 and higher.';
    KMSServerSettingsBox.ShowHint := True;
  end;

  FormatDynamicEFTSettings();

  with qIPAddresses do
  begin
    Close;
    Parameters.ParamByName('SiteCode').Value := FSiteCode;
    Open;

    if RecordCount > 0 then
       begin
         EditGiftAddress.Text := FieldByName('GiftAddress').AsString;
         EditEFTAddress.Text := FieldByName('EFTAddress').AsString;
       end;
  end;

  with dmADO do
  begin
    dmThemeData.AccessDataset(qOutletConfigs);
    sIPAddress := qOutletConfigs.FieldByName('IPAddress').AsString;
    if dmThemeData.SiteVersionAtLeast('3.5.1.0') then
    begin
      if not qOutletConfigs.FieldByName('AutoDeductTip').AsBoolean then
        cbOnClockOut.Enabled := FALSE;
    end
    else
    begin
      cbOnClockOut.Checked := cbAutoPayoutTips.Checked;
      cbOnClockOut.Enabled := FALSE;
    end;

    dbchkbxLastTerminalOnly.Enabled := qOutletConfigs.FieldByName('SessionChangeWarnIfAccountsOpen').AsBoolean;
    dbchkbxRestrictToSalesArea.Enabled := dbchkbxLastTerminalOnly.Enabled;

    DBEditTipValidationPercentage.Enabled := not qOutletConfigs.FieldByName('ReconfirmTipEntry').AsBoolean ;
    lblTipValidationPct.Enabled := DBEditTipValidationPercentage.Enabled;

  end;

  with qServiceSettings do
  begin
    Close;
    Parameters.ParamByName('SiteCode').Value := FSiteCode;
    dmThemeData.AccessDataset(qServiceSettings);

    Filter := ('SoapServerId = 6');
    Filtered := True;

    if RecordCount > 0 then
    begin
      edtLedgersServerIP.Text := FieldByName('IPAddress').AsString;
      edtLedgersServerIPPort.Text := FieldByName('IPPortNumber').AsString;
    end;

    Filter := ('SoapServerId = 7');
    Filtered := True;
    if RecordCount > 0 then
    begin
      edtBookingsServerIP.Text := FieldByName('IPAddress').AsString;
      edtBookingsServerIPPort.Text := FieldByName('IPPortNumber').AsString;
    end;
  end;

  cmbbxDecimalPlaces.Enabled := dmThemeData.SiteVersionAtLeast('3.5.1.0');
  cmbbxDisplayUnit.Enabled := cmbbxDecimalPlaces.Enabled;
  dmADO.qSurveyCodeSupplier.Active := cmbbxSurveyCodeSupplier.Enabled;
  dmADO.qOutletConfigs.Requery([]);
  if UKUSmode = 'US' then
  begin
    DBCheckBoxPrintQrCode.Caption := 'Print QR code for Check Payment';
    DBCheckBoxPrintQrCode.Hint := 'When Print QR code for Check Payment is enabled,' + #13#10 +
    'QRCode header text and QRCode Footer text can be edited for an estate in:' + #13#10 +
    'Theme Modelling - Estate Setup - Message Display'+#13#10+'''Edit QR code text for Check Payment''';
  end;
  UpdateEftRecallSlipState();
  dmADO.LogDuration('BaseEdit - Form Show done');
end;

//------------------------------------------------------------------------------
procedure TBaseEdit.btSortByTillClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  Pstreamsave;
  pstreamsortmode := 0;
  Pstreamload;
end;

procedure TBaseEdit.PStreamLoad;
begin
  if qryServersForCbx.Active = FALSE then
    RefreshServerCombos;
  qEditPrintStreams.close;
  qEditPrintStreamsAggregate.close;
  qClearPrintStreamsTable.ExecSQL;
  if qryServersForCbx.fieldByName('EPOSDeviceID').IsNull then
    exit;
  qLoadPrintStreams.Parameters.ParamByName('sitecode').value := fsitecode;
  qLoadPrintStreams.Parameters.ParamByName('sortmode').Value := pstreamsortmode;
  qLoadPrintStreams.Parameters.ParamByName('serverID').Value :=
                               qryServersForCbx.fieldByName('EPOSDeviceID').Value;
  qLoadPrintStreams.Open;
  qLoadPrintStreams.Close;

  if qEditPrintStreams.active = false then
    qEditPrintStreams.open
  else
    qEditPrintStreams.Requery;
  FormatPStreamTable;

  BuildAggregatePrintStreamView;
end;

procedure TBaseEdit.PStreamSave;
begin
  if qEditPrintStreams.Active then
  begin
    if qEditPrintStreams.State in [dsEdit, dsInsert] then
      qEditPrintStreams.post;
    qEditPrintStreams.UpdateBatch;
    qSavePrintStreams.parameters.parambyname('outletid').value := fsitecode;
    qSavePrintStreams.Parameters.ParamByName('serverID').Value :=
      qryServersForCbx.fieldByName('EPOSDeviceID').Value;
    qSavePrintStreams.ExecSQL;
  end;
end;

procedure TBaseEdit.btsortbystreamClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  Pstreamsave;
  pstreamsortmode := 1;
  Pstreamload;
end;

procedure TBaseEdit.tsPrintGroupGridShow(Sender: TObject);
begin
  TogglePrintTabFilterFilters;
  ReadPStreamCodes;
  PStreamLoad;
  BuildAggregatePrintStreamView;
end;

procedure TBaseEdit.PStreamGridDrawTitleCell(Sender: TObject;
  Canvas: TCanvas; Field: TField; Rect: TRect;
  var DefaultDrawing: Boolean);
var
  lgfont: TLogfont;
begin
  strpcopy(lgfont.lfFaceName, 'MS Shell Dlg 2');
  lgfont.lfWeight := 0;
  lgfont.lfItalic := 0;
  lgfont.lfUnderline := 0;
  lgfont.lfStrikeOut :=  0;
  lgfont.lfOutPrecision := OUT_OUTLINE_PRECIS;
  lgfont.lfClipPrecision := CLIP_DEFAULT_PRECIS;
  lgfont.lfQuality := PROOF_QUALITY;
  lgfont.lfPitchAndFamily := FF_DONTCARE;
  lgfont.lfCharSet := canvas.font.Charset;
  if field.Index > Pred(TwwDBGrid(sender).FixedCols) then
  begin
    lgfont.lfEscapement := 900;
    lgfont.lfHeight := 13;
    lgfont.lfWidth := 5;
  end
  else
  begin
    lgfont.lfEscapement := 0;
    lgfont.lfHeight := 15;
    lgfont.lfWidth := 5;
  end;
  lgfont.lfOrientation := 0;
  Canvas.Font.Handle := CreateFontIndirect(lgFont);
  if field.Index > Pred(TwwDBGrid(sender).FixedCols) then
    canvas.TextOut(rect.Left + 2, rect.bottom  - 2, field.DisplayName)
  else
    canvas.TextOut(rect.Left + 2,-1 + rect.bottom - lgfont.lfHeight, field.DisplayName);
  DeleteObject(Canvas.Font.Handle);
  defaultdrawing := false;
end;

procedure TBaseEdit.FormatPStreamTable;
var
  i: integer;
begin
  with dbgPstreams do
  begin
    Selected.Clear;
    if pstreamsortmode = 0 then
    begin
      Selected.Add('sort1' + #9 + '20' + #9 + 'Terminal');
      Selected.Add('sort2' + #9 + '20' + #9 + 'Print Group');
    end
    else
    begin
      Selected.Add('sort1' + #9 + '20' + #9 + 'Print Group');
      Selected.Add('sort2' + #9 + '20' + #9 + 'Terminal');
    end;
    for i := 0 to pred(datasource.dataset.fields.count) do
    if (datasource.dataset.Fields[i].fieldname <> 'eposdeviceid') and
      (datasource.dataset.fields[i].FieldName <> 'printstreamid') and
      (datasource.dataset.fields[i].fieldname <> 'sort1') and
      (datasource.dataset.fields[i].fieldname <> 'sort2') and
      (datasource.dataset.fields[i].fieldname <> 'ReadOnly') then
    begin
      if datasource.dataset.fields[i].FieldName = 'optional' then
        selected.add(datasource.dataset.fields[i].FieldName +#9'3'#9 +
          'Optional Printing')
      else
        selected.add(datasource.dataset.fields[i].FieldName +#9'3'#9 +
          datasource.dataset.fields[i].FieldName);
      //setcontroltype(datasource.dataset.fields[i].FieldName, fctCheckBox, 'True;False');
    end;
    applyselected;
    invalidate;
    OnRowChanged(dbgPstreams);
  end;
end;

procedure TBaseEdit.FormatPStreamTable2;
var
  i: integer;
  CurrFieldName: String;
begin
  with dbgPstreams2 do
  begin
    Datasource.dataset.DisableControls;

    Selected.Clear;
    ApplySelected;

    Selected.Add('PrintStreamName' + #9 + '20' + #9 + 'Print Group');
    for i := 0 to pred(datasource.dataset.fields.count) do
    begin
      CurrFieldName := LowerCase(datasource.dataset.fields[i].FieldName);

      if (CurrFieldName <> 'printstreamid') and
         (CurrFieldName <> 'printstreamname') and
         (CurrFieldName <> 'readonly') then
      begin
        if datasource.dataset.fields[i].FieldName = 'optional' then
          selected.add(datasource.dataset.fields[i].FieldName +#9'3'#9 +
            'Optional Printing')
        else
          selected.add(datasource.dataset.fields[i].FieldName +#9'3'#9 +
            datasource.dataset.fields[i].FieldName);
      end;
    end;
    applyselected;
    invalidate;
    datasource.dataset.enablecontrols;
    OnRowChanged(dbgPstreams2);
  end;
end;

procedure TBaseEdit.DBEditPercentageChange(Sender: TObject);
begin
  if TDBEdit(sender).Text = '' then
    TDBEdit(sender).Text := '0';
end;

function TBaseEdit.CheckOtherSetups(var WarningsString: string): Boolean;
var
  WarningsList: TStrings;
begin
  WarningsList := TStringList.Create;
  try
    CheckPrintStreams(WarningsList);
    if (WarningsList.Count > 0) then
    begin
      WarningsList.Add(' ');
    end;
    CheckPayAtTableVersion(WarningsList);
    WarningsString := StringReplace(WarningsList.Text, ',', ', ', [rfReplaceAll]);
    Result := (WarningsList.Count > 0);
  finally
    WarningsList.Free;
  end;
end;

procedure TBaseEdit.CheckPrintStreams(var WarningsList: TStrings);
begin
  // check that at least one printer is assigned to the EFT, report and Bill print streams
  // excluding Hotel System, Kiosk, Mobile Ordering, MOA OrderPad, MOA Pay At Table and iZone Tables
  // from the results
  with dmado.adoqrun do
  try
    sql.text := format('declare @sitecode integer '+#13+
    'set @sitecode = %d '+#13+
    'select ''Device '' + svr.Name + ''/''+a.name +'' has no Bill/Receipt print group defined'' as theText '+#13+
    'from themeeposdevice a, (select * from themeeposdevice where IsServer = 1) svr '+#13+
    'where a.sitecode = @sitecode and a.IsServer = 0 and not '+#13+
    'exists(select * from themeeposprinterstream b,'+#13+
    '         (select billreceiptprintstream as StreamID from ThemeOutletStandardPrintConfigs where sitecode = @sitecode) c '+#13+
    '       where b.sitecode = @sitecode and b.printstreamid = c.streamid and b.eposdeviceid = a.eposdeviceid) '+#13+
    'and a.ServerID = svr.EPosDeviceID '+#13+
    'and not a.HardwareType in (6,8,10,12,13,14) '+#13+
    'union all '+#13+
    'select ''Device '' + svr.Name + ''/''+a.name +'' has no Report print group defined'' as theText '+#13+
    'from themeeposdevice a, (select * from themeeposdevice where IsServer = 1) svr '+#13+
    'where a.sitecode = @sitecode and a.IsServer = 0 and not '+#13+
    'exists(select * from themeeposprinterstream b,'+#13+
    '         (select reportprintstream as StreamID from ThemeOutletStandardPrintConfigs where sitecode = @sitecode) c '+#13+
    '       where b.sitecode = @sitecode and b.printstreamid = c.streamid and b.eposdeviceid = a.eposdeviceid) '+#13+
    'and a.ServerID = svr.EPosDeviceID '+#13+
    'and not a.HardwareType in (6,8,10,12,13,14) '+#13+
    'union all '+#13+
    'select ''Device '' + svr.Name + ''/''+a.name +'' has no EFT print group defined'' as theText '+#13+
    'from themeeposdevice a, (select * from themeeposdevice where IsServer = 1) svr '+#13+
    'where a.sitecode = @sitecode and a.IsServer = 0 and not '+#13+
    'exists(select * from themeeposprinterstream b, '+#13+
    '         (select eftprintstream as StreamID from ThemeOutletStandardPrintConfigs where sitecode = @sitecode) c '+#13+
    '       where b.sitecode = @sitecode and b.printstreamid = c.streamid and b.eposdeviceid = a.eposdeviceid) '+#13+
    'and a.ServerID = svr.EPosDeviceID '+#13+
    'and not a.HardwareType in (6,8,10,12,13,14) '+#13+
    'order by theText', [fsitecode]);
    open;
    if RecordCount > 0 then
    begin
      first;
      WarningsList.Add('There are problems with the print group assignments:');
      while not EOF do
      begin
        WarningsList.Add('  ' + fields[0].asstring);
        next;
      end;
    end;
  finally
    close;
    SQL.Clear;
  end;
end;

procedure TBaseEdit.CheckPayAtTableVersion(var WarningsList: TStrings);
var
  Names: Tstrings;
begin
  Names := TStringList.Create;
  with dmADO.adoqRun do
  try
    Close;
    SQL.Text := Format('SELECT p.Name, c.SiteCode, c.DBVersion ' +
      'FROM ' +
      '  ThemeEposPrinter p ' +
      'JOIN ' +
      '  CommsVersions c ON p.SiteCode = c.SiteCode ' +
      'WHERE p.SiteCode = %d ' +
      'AND dbo.fn_strVerToInt64(c.DBVersion) < dbo.fn_strVerToInt64(''3.5.3.38304'') ' +
      'AND PrinterType = 10032 ', [FSiteCode]);
    Open;
    if RecordCount > 0 then
    begin
      First;
      WarningsList.Add('Pay at Table devices are incompatible with site version ' + FieldByName('DBVersion').AsString + ':');
      while not Eof do
      begin
        Names.Add(FieldByName('Name').AsString);
        Next;
      end;
      Names.Delimiter := ',';
      WarningsList.Add('  ' + Names.DelimitedText);
    end;
  finally
    close;
    SQL.Clear;
    Names.Free;
  end;
end;

procedure TBaseEdit.mmPrinterFooterKeyPress(Sender: TObject;
  var Key: Char);
var
  line, col: Integer;
begin
  with Sender as TMemo do
  begin
    line := Perform(EM_LINEFROMCHAR, SelStart, 0);
    col := SelStart - Perform(EM_LINEINDEX, line, 0);
    if key = #8 then
    begin
      //Do not allow backspace if caret is on first column and deleting the
      //linebreak of the line before would result in a line of more than allowed
      //characters.
      if (col = 0) and (line > 0) then
      begin
        if (Length(lines[line]) + Length(lines[line - 1])) > MAX_FOOTER_LINE_LENGTH then
          Key := #0;
      end;
    end
    else if key in [#13, #10] then
    begin
      //Handle hard linebreaks via Enter or Ctrl-Enter
      if lines.count >= 6 then
      begin
        //Max number of lines reached or exceeded. Set caret to start of next
        //line or if this the last line the start of this line.
        key := #0;
        if line = 5 then
          SelStart := Perform(EM_LINEINDEX, line, 0)
        else
          SelStart := Perform(EM_LINEINDEX, line + 1, 0);
      end;
    end
    else if Key >= ' ' then
    begin
      //Ignore key if current line has reached limit
      if Length(lines[line]) >= MAX_FOOTER_LINE_LENGTH then
        Key := #0;
    end;
  end;
end;

procedure TBaseEdit.mmPrinterFooterKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  line, col: Integer;
begin
  //Do not allow delete key if caret is on the last column and deleting the
  //linebreak front would result in a line of more than allowed number of characters.
  if Key = VK_DELETE then
  with Sender as TMemo do
  begin
    line := Perform(EM_LINEFROMCHAR, SelStart, 0);
    col := SelStart - Perform(EM_LINEINDEX, line, 0);
    if col = Length(lines[line]) then
      if (line < 5) and ((Length(lines[line]) + Length(lines[line + 1])) > MAX_FOOTER_LINE_LENGTH) then
      begin
        key := 0;
      end;
  end;
end;

procedure TBaseEdit.pcBaseDataChange(Sender: TObject);
begin
  Log(pcBaseData.ActivePage.Caption + ' Tab Selected');
end;

procedure TBaseEdit.DBCheckBoxClick(Sender: TObject);
begin
  LogDBCheckBoxClick(Sender as TDBCheckBox);
end;

procedure TBaseEdit.TabDeviceSetUpShow(Sender: TObject);
begin
  BuildServerDevicesTree;
  with dmADO do
  begin
    qrySiteServers.Parameters.ParamByName('SiteCode').Value := FSiteCode;
    qGetTerminals.Parameters.ParamValues['SiteCode'] := FSiteCode;
    qGetTerminals.active := true;
    qTerminalPrinters.active := true;
    qPrintStreams.Active := true;
    qPrinterTypes.active := true;
  end;
end;


procedure TBaseEdit.TabDeviceSetUpHide(Sender: TObject);
begin
  with dmADO do
  begin
    if qGetTerminals.State in [dsEdit, dsInsert] then qGetTerminals.post;
    if qTerminalPrinters.State in [dsEdit, dsInsert] then qTerminalPrinters.post;
    if qPrintStreams.State in [dsEdit, dsInsert] then qPrintStreams.post;
    if qPrinterTypes.State in [dsEdit, dsInsert] then qPrinterTypes.Post;
  end;
  grdDeviceList.Hide;
  DestroyPreviousSubMenuItems(MoveTerminal);
  DestroyPreviousSubMenuItems(MoveNodeServerPrinter);
  DestroyPreviousSubMenuItems(MoveRecordTerminalPrinter);
  DestroyPreviousSubMenuItems(MoveRecordServerTerminal);
end;

procedure TBaseEdit.BuildServerDevicesTree;
var
  rootNode, serverNode, serverDeviceNode, TerminalDeviceNode: TTreeNode;
  TmpDeviceType: TDeviceObjectType;
begin
  SelectedNode := nil;
  RecordNode := nil;
  tvServerDevices.Items.Clear;
  rootNode := tvServerDevices.Items.Add(nil, '[Right click to add Server]');
  rootNode.ImageIndex := 0;
  rootNode.Data := TDeviceObject.Create(rootNode, doRoot, -1, -1, 0);

  qryServers.Close;
  qryServers.Parameters.ParamByName('siteCode').Value := FSiteCode;
  qryServers.Open;
  while not qryServers.Eof do
  begin
    serverNode := tvServerDevices.Items.AddChild(rootNode, qryServers.FieldByName('Name').Value);
    serverNode.ImageIndex := SERVER_IMAGE;
    serverNode.SelectedIndex := SERVER_IMAGE;

    case TEPOSHardwareType(qryServers.FieldByName('HardwareType').AsInteger) of
    ehtConqueror:
      TmpDeviceType := doConquerorServer;
    ehtHotelSystem:
      TmpDeviceType := doHotelSystemServer;
    else
      TmpDeviceType := doServer;
    end;

    ServerNode.Data := TDeviceObject.Create(serverNode, TmpDeviceType, qryServers.FieldByName('HardwareType').AsInteger, -1, qryServers.FieldByName('EPoSDeviceID').Value);

    // add nodes for terminals attached to the server
    qryServerTerminals.Close;
    qryServerTerminals.Parameters.ParamByName('serverID').Value := qryServers.FieldByName('EPoSDeviceID').Value;
    qryServerTerminals.Parameters.ParamByName('siteCode').Value := FSiteCode;
    qryServerTerminals.Open;
    while not qryServerTerminals.Eof do
    begin
      serverDeviceNode := tvServerDevices.Items.AddChild(serverNode, qryServerTerminals.FieldByName('Name').Value);
      serverDeviceNode.ImageIndex := TERMINAL_IMAGE;
      serverDeviceNode.SelectedIndex := TERMINAL_IMAGE;
      if (qryServers.FieldByName('HardwareType').AsInteger = ord(ehtConqueror)) then
        serverDeviceNode.Data := TDeviceObject.Create(serverDeviceNode, doConquerorTerminal, qryServerTerminals.FieldByName('HardwareType').AsInteger, -1, qryServerTerminals.FieldByName('EPoSDeviceID').Value)
      else if (qryServerTerminals.FieldByName('HardwareType').AsInteger = ord(ehtMobileOrdering)) then
        serverDeviceNode.Data := TDeviceObject.Create(serverDeviceNode, doMOARemoteOrdering, qryServerTerminals.FieldByName('HardwareType').AsInteger, -1,
                                           qryServerTerminals.FieldByName('EPoSDeviceID').Value)
      else if (qryServerTerminals.FieldByName('HardwareType').AsInteger = ord(ehtMOAOrderPad)) then
        serverDeviceNode.Data := TDeviceObject.Create(serverDeviceNode, doMOAOrderPad, qryServerTerminals.FieldByName('HardwareType').AsInteger, -1,
                                           qryServerTerminals.FieldByName('EPoSDeviceID').Value)
      else if (qryServerTerminals.FieldByName('HardwareType').AsInteger = ord(ehtiZoneTables)) then
        serverDeviceNode.Data := TDeviceObject.Create(serverDeviceNode, doiZoneTables, qryServerTerminals.FieldByName('HardwareType').AsInteger, -1,
                                           qryServerTerminals.FieldByName('EPoSDeviceID').Value)
      else
        serverDeviceNode.Data := TDeviceObject.Create(serverDeviceNode, doTerminal, qryServerTerminals.FieldByName('HardwareType').AsInteger, -1, qryServerTerminals.FieldByName('EPoSDeviceID').Value);

      //add nodes for Peripheral devices to Terminal
      qryTerminalDeviceList.Close;
      qryTerminalDeviceList.Parameters.ParamByName('terminalID').Value := qryServerTerminals.FieldByName('EposDeviceID').Value;
      qryTerminalDeviceList.Parameters.ParamByName('siteCode1').Value := FSiteCode;
      qryTerminalDeviceList.Parameters.ParamByName('siteCode2').Value := FSiteCode;
      qryTerminalDeviceList.Open;
      While not qryTerminalDeviceList.Eof do
      begin
        TerminalDeviceNode := tvServerDevices.Items.AddChild(serverDeviceNode,qryTerminalDeviceList.FieldByName('Name').Value);
        TerminalDeviceNode.ImageIndex := PRINTER_IMAGE;
        TerminalDeviceNode.SelectedIndex := PRINTER_IMAGE;
        TerminalDeviceNode.Data := TDeviceObject.Create(TerminalDeviceNode, doPrinter, -1, qryTerminalDeviceList.FieldByName('PrinterType').AsInteger, qryTerminalDeviceList.FieldByName('DeviceID').Value);
        qryTerminalDeviceList.Next;
      end;
      //end add nodes for peripheral devices
      qryServerTerminals.Next;
    end;

    // add nodes for printers directly linked to Servers
    qryServerPrinters.Close;
    qryServerPrinters.Parameters.ParamByName('serverID').Value := qryServers.FieldByName('EPoSDeviceID').Value;
    qryServerPrinters.Parameters.ParamByName('siteCode').Value := FSiteCode;
    qryServerPrinters.Open;

    // add nodes for terminals attached to the server
    while not qryServerPrinters.Eof do
    begin
      serverDeviceNode := tvServerDevices.Items.AddChild(serverNode, qryServerPrinters.FieldByName('Name').Value);
      serverDeviceNode.ImageIndex := PRINTER_IMAGE;
      serverDeviceNode.SelectedIndex := PRINTER_IMAGE;
      serverDeviceNode.Data := TDeviceObject.Create(serverDeviceNode, doPrinter, -1, qryServerPrinters.FieldByName('PrinterType').AsInteger, qryServerPrinters.FieldByName('PrinterID').Value);
      qryServerPrinters.Next;
    end;

    qryServers.Next;
  end;
  rootNode.Expand(TRUE);
end;


procedure TBaseEdit.tvServerDevicesChange(Sender: TObject;
  Node: TTreeNode);
begin
  SelectedNode := Node;
  case TDeviceObject(Node.Data).deviceObjectType of
    doPrinter :
    begin
      dmADO.qGetTerminals.Locate('SiteCode;EPOSDeviceID',VarArrayOf([FSiteCode,TDeviceObject(SelectedNode.Parent.Data).deviceID]),[]);
      dmADO.qTerminalPrinters.Locate('PrinterID;SiteCode',VarArrayOf([TDeviceObject(SelectedNode.Data).deviceID,FSiteCode]),[]);
      RefreshSelectedDetailPanel;
      RefreshDeviceListGrid;
    end;
    else
    begin
      dmADO.qGetTerminals.Locate('SiteCode;EPOSDeviceID',VarArrayOf([FSiteCode,TDeviceObject(SelectedNode.Data).deviceID]),[]);
      RefreshSelectedDetailPanel;
      RefreshDeviceListGrid;
    end;
  end;
end;

procedure TBaseEdit.AddMoveTerminalSubMenuItems(FromNode: Boolean; aMenuItem: TMenuItem; aTerminalID, currentServerID: Integer);
var
  NewItem: TMenuItem;
  NewAction: TMoveAction;
begin
  // get all servers except the one that the terminal is currently associated with
  with dmADO.qRun do
  begin
    SQL.Clear;
    SQL.Add('select [name], EposDeviceID');
    SQL.Add('from ThemeEposDevice a');
    SQL.Add('join TerminalHardware b on a.HardwareType = b.HardwareType and ClassName like ''%.AztecEPoSDevice''');
    SQL.Add('where IsServer = 1');
    SQL.Add('and EposDeviceID <> ' + InttoStr(currentServerID));
    SQL.Add('and EposDeviceID not in (');
    // Exclude virtual servers that cannot accept another terminal
    SQL.Add(
      'select a.EPOSDeviceID from ThemeEposDevice a '+
      'join ThemeOutletConfigs a2 on a.Sitecode = a2.SiteCode and a.IPAddress = a2.IPAddress '+
      'join ThemeEposDevice b on a.SiteCode = b.Sitecode and a.EPOSDeviceID = b.ServerID '+
      'where a.IsServer = 1 and a.SiteCode = '+IntToStr(FSiteCode)+' '+
      'group by a.EPOSDeviceID '+
      'having count(*) >= '+IntToStr(dmADO.VirtualServerDeviceLimit)
    );
    SQL.Add(')');
    SQL.Add('and sitecode = ' + IntToStr(FSiteCode));
    SQL.Add('order by [name]');
    Open;
    while not Eof do
    begin
      NewAction := TMoveAction.Create(nil);
      NewAction.OnExecute := actMoveTerminalExecute;
      NewAction.Caption := FieldByName('Name').AsString;
      NewAction.DeviceID := aTerminalID;
      NewAction.MoveToDeviceID := FieldByName('EposDeviceID').Value;
      NewAction.CalledFromNode := FromNode;
      NewItem := TMenuItem.Create(nil);
      NewItem.Action := NewAction;
      aMenuItem.Add(NewItem);
      next;
    end;
    Close;
    SQL.Clear;
  end;
end;

procedure TBaseEdit.AddMovePeripheralSubMenuItems(FromNode: Boolean; aMenuItem: TMenuItem;
                                                  aDeviceID, aPeripheralTypeID, currentParentID: Integer);
var
  ServerListItem, ServerItem, NewItem, NewSubItem: TMenuItem;
  NewAction, NewSubAction: TMoveAction;
  NewItemCaption: String;
  NewPrinterType: String;
  currentServerID, NewServerID: Integer;
  qryGetServerID: TADOQuery;
begin

  // if the selected node is directly linked to a server then ServerID = ParentID
  // else ServerID = Parent's ServerID
  qryGetServerID := TADOQuery.Create(nil);
  with qryGetServerID do
  try
    Connection := dmADO.AztecConn;
    SQL.Add('Select');
    SQL.Add('  case');
    SQL.Add('    when IsServer = 1 then EposDeviceID');
    SQL.Add('    else ServerID');
    SQL.Add('  end as TheServerID');
    SQL.Add('from ThemeEposDevice');
    SQL.Add('where EposDeviceID = '+ IntToStr(currentParentID));
    SQL.Add('and SiteCode = ' + IntToStr(FSiteCode));
    Open;
    currentServerID := FieldByName('TheServerID').AsInteger;
    Close;
  finally
    FreeAndNil(qryGetServerID);
  end;

  // Add selectable menu items for servers if device can be associated to a server
  // i.e. is a printer not a barcode reader.  The printer's current server is
  // excluded

  dmADO.qRun.SQL.Text := 'select * from ThemePrinterType where IsPinPad = 0 and '+
    'IsPrinter = 1 and PrinterTypeID = '+dmADO.qTerminalPrinters.FieldByName('PrinterType').asstring;
  dmADO.qRun.Open;
  if dmADO.qRun.RecordCount > 0 then
  begin
    NewPrinterType := 'Printer';
    ServerListItem := TMenuItem.Create(nil);
    ServerListItem.Caption := 'Servers...';
    aMenuItem.Add(ServerListItem);
    with dmADO.qRun do
    begin
      SQL.Clear;
      SQL.Add('select [name], EposDeviceID');
      SQL.Add('from ThemeEposDevice a');
      SQL.Add('join TerminalHardware b on a.HardwareType = b.HardwareType and ClassName like ''%.AztecEPoSDevice''');
      SQL.Add('where isServer = 1');
      SQL.Add('and EposDeviceID <> ' + InttoStr(currentParentID));
      // Exclude virtual servers
      SQL.Add('and EposDeviceID not in (');
      SQL.Add(
        'select a.EPOSDeviceID from ThemeEposDevice a '+
        'join ThemeOutletConfigs a2 on a.Sitecode = a2.SiteCode and a.IPAddress = a2.IPAddress '+
        'where a.IsServer = 1 and a.SiteCode = '+IntToStr(FSiteCode)
      );
      SQL.Add(')');
      // Exclude all servers if the device is an IP Printer and it has a cash drawer
      SQL.Add('and not exists (select HasCashDrawer');
      SQL.Add('from ThemeEposPrinter tep');
      SQL.Add('join ThemePrinterType tpp on tep.PrinterType = tpp.PrinterTypeID');
      SQL.Add('where tpp.IPComms = 1 and tpp.IsPrinter = 1');
      SQL.Add('and tep.PrinterID = ' + IntToStr(aDeviceID) + ' and tep.printertype = ' + IntToStr(aPeripheralTypeID) + ' and tep.HasCashDrawer = 1)');
      SQL.Add('and sitecode = ' + IntToStr(FSiteCode));
      SQL.Add('order by [name]');
      Open;
      while not Eof do
      begin
        NewAction := TMoveAction.Create(nil);
        NewAction.OnExecute := actMovePrinterExecute;
        NewAction.Caption := FieldByName('Name').AsString;
        NewAction.DeviceID := aDeviceID;
        NewAction.MoveToDeviceID := FieldByName('EposDeviceID').Value;
        NewAction.MoveToDeviceName := FieldByName('Name').Value;
        NewAction.CurrentServerID := currentServerID;
        NewAction.NewServerID := FieldByName('EposDeviceID').Value;
        NewAction.CalledFromNode := FromNode;
        NewAction.PrinterType := 'Printer';
        // add selectable menu item for the server
        ServerItem := TMenuItem.Create(nil);
        ServerItem.Action := NewAction;
        ServerListItem.Add(ServerItem);
        Next;
      end;
      Close;
      SQL.Clear;
    end;
  end
  else
    NewPrinterType := 'Peripheral';
  dmADO.qRun.Close;

  // Add menu items for servers with submenus of terminals
  // (only terminal menu items can be selected)
  with dmADO.qRun do
  begin
    SQL.Clear;
    SQL.Add('select [name], EposDeviceID');
    SQL.Add('from ThemeEposDevice a');
    SQL.Add('join TerminalHardware b on a.HardwareType = b.HardwareType and ClassName like ''%.AztecEPoSDevice''');
    SQL.Add('where isServer = 1');
    SQL.Add('and sitecode = ' + IntToStr(FSiteCode));
    SQL.Add('order by [name]');
    Open;
    while not Eof do
    begin
      NewItemCaption := FieldByName('Name').AsString + ' terminals';
      NewServerID := FieldByName('EposDeviceID').AsInteger;
      with TADOQuery.Create(Nil) do
      try
        //exclude MOA/iZone Tables, but include Orderpad is the device is an IP printer and the order pad
        //has at most one IP printer already attached.
        Connection := dmADO.AztecConn;
        SQL.Add('select [name], EposDeviceID');
        SQL.Add('from ThemeEposDevice a');
        SQL.Add('join TerminalHardware b on a.HardwareType = b.HardwareType and ClassName like ''%.AztecEPoSDevice''');
        SQL.Add('where ServerID = ' + IntToStr(NewServerID));
        SQL.Add('and EposDeviceID <> ' + IntToStr(currentParentID));
        SQL.Add('and SiteCode = ' + IntToStr(FSiteCode));
        SQL.Add('and ((a.HardwareType not in (10,12,13,14,25, 26))');
        //MOA Orderpad can have 2 IP printers assigned.
        SQL.Add('     or (((a.HardwareType in (12)) and ' + InttoStr(aPeripheralTypeID) + ' in (select PrinterTypeID from ThemePrinterType where IPComms = 1 and IsPrinter = 1))');
        SQL.Add('         and (select count(*) from ThemeEposPrinter where EPoSDeviceID = a.EposDeviceID) < 2)');
        //AzOne can have 5 IP devices.
        SQL.Add('     or (((a.HardwareType in (25)) and ' + InttoStr(aPeripheralTypeID) + ' in (select PrinterTypeID from ThemePrinterType where IPComms = 1))');
        SQL.Add('         and (select count(*) from ThemeEposPrinter where EPoSDeviceID = a.EposDeviceID) < 5))');
        //Terminals can only have 1 IPPrinter with a cash drawer assigned
        SQL.Add('and ((select HasCashDrawer from ThemeEposPrinter where PrinterID = ' + IntToStr(aDeviceID) + ') = 0');
        SQL.Add('     or ((select count(*) from ThemeEposPrinter where EposDeviceID = a.EposDeviceID and HasCashDrawer = 1) = 0)');
        SQL.Add('          and a.MultiDrawerMode = 0)');
        SQL.Add('order by [name]');
        Open;
        // create server menu item that will open submenu of terminals attached
        // to the server
        if RecordCount > 0 then
        begin
          NewItem := TMenuItem.Create(nil);
          NewItem.Caption := NewItemCaption;
          aMenuItem.Add(NewItem);

          while not Eof do
          begin
            NewSubAction := TMoveAction.Create(nil);
            NewSubAction.OnExecute := actMovePrinterExecute;
            NewSubAction.Caption := FieldByName('Name').Value;
            NewSubAction.DeviceID := aDeviceID;
            NewSubAction.MoveToDeviceID := FieldByName('EPosDeviceID').Value;
            NewSubAction.MoveToDeviceName := FieldByName('Name').Value;
            NewSubAction.CurrentServerID := currentServerID;
            NewSubAction.NewServerID := NewServerID;
            NewSubAction.CalledFromNode := FromNode;
            NewSubAction.PrinterType := NewPrinterType;
            NewSubItem := TMenuItem.Create(nil);
            NewSubItem.Action := NewSubAction;
            NewItem.Add(NewSubItem);
            Next;
          end;
        end;
      finally
        Close;
        Free;
      end;
      Next;
    end;
    Close;
    SQL.Clear;
  end;
end;


procedure TBaseEdit.DestroyPreviousSubMenuItems(aMenuItem: TMenuItem);
var
  i, j: integer;
begin
  for i := aMenuItem.Count-1 downto 0 do
  begin
    for j := aMenuItem.Items[i].Count-1 downto 0 do
    begin
      aMenuItem.Items[i].Items[j].Action.Destroy;
      aMenuItem.Items[i].Items[j].Destroy;
    end;
    aMenuItem.Items[i].Clear;
    if assigned(aMenuItem.Items[i].Action) then aMenuItem.Items[i].Action.Destroy;
    aMenuItem.Items[i].Destroy;
  end;
end;


{ if the root node is already selected the OnChange handler is not triggered
  when the user clicks on the root node again which means that the
  terminal dialog was not displayed as expected.  The workaround is to display
  the terminal dialog here if it has not already been displayed by the
  OnChange handler
}
procedure TBaseEdit.tvServerDevicesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  theNode: TTreeNode;
  thePoint: TPoint;
begin
  theNode := tvServerDevices.GetNodeAt(X,Y);
  if Assigned(theNode) then
  begin
    if Button = mbRight then
    begin
      // Right click - move selection to clicked item, then popup context menu
      tvServerDevices.Select(theNode);
      SelectedNode := theNode;
      thePoint.X := X;
      thePoint.Y := Y;
      thePoint := tvServerDevices.ClientToScreen( thePoint );
      case TDeviceObject(theNode.Data).deviceObjectType of
        doRoot :
          begin
            ShowTerminalDialog(TRUE,ADD_SERVER);
          end;
        doServer :
          begin
            //need to relocate the server record as the GridDeviceRowChange procedure
            //locates the last terminal in the grid so it has to be reset back
            //to the server here
            dmado.qGetTerminals.Locate('SiteCode;EPOSDeviceID',VarArrayOf([FSiteCode,TDeviceObject(theNode.Data).deviceID]),[]);
            EditServer.Caption := 'Edit ' + theNode.Text;
            DeleteServer.Caption := 'Delete ' + theNode.Text;
            AddPrinter.Enabled := not TDeviceObject(theNode.Data).IsVirtual;
            AddTerminal.Enabled := (not TDeviceObject(theNode.Data).IsVirtual)
              or (TDeviceObject(theNode.Data).TerminalCount < dmADO.VirtualServerDeviceLimit);
            pmServer.Popup(thePoint.X, thePoint.Y);
          end;
        doConquerorServer, doHotelSystemServer, doQueueBuster :
          begin
            dmado.qGetTerminals.Locate('SiteCode;EPOSDeviceID',VarArrayOf([FSiteCode,TDeviceObject(theNode.Data).deviceID]),[]);
            EditServer.Caption := 'Edit ' + theNode.Text;
            DeleteServer.Caption := 'Delete ' + theNode.Text;
            AddPrinter.Enabled := false;
            AddTerminal.Enabled := TDeviceObject(theNode.Data).deviceObjectType = doConquerorServer;
            pmServer.Popup(thePoint.X, thePoint.Y);
          end;
        doTerminal :
          begin
            MoveTerminal.Visible := true;
            AddPeripheral.Visible := not (TDeviceObject(theNode.Data).DeviceType in [ord(ehtKiosk), ord(ehtAzTab)]);
            MoveTerminal.Caption := 'Move ' + theNode.Text + ' to...';
            DestroyPreviousSubMenuItems(MoveTerminal);
            MoveTerminal.Clear;
            AddMoveTerminalSubMenuItems(TRUE, MoveTerminal,TDeviceObject(theNode.Data).deviceID, TDeviceObject(theNode.Parent.Data).deviceID);
            MoveTerminal.Visible := MoveTerminal.Count <> 0;
            EditTerminal.Caption := 'Edit ' + theNode.Text;
            actDeleteNodeTerminal.Caption := 'Delete ' + theNode.Text;
            DeleteTerminal.Visible := True;
            pmNodeServerTerminal.Popup(thePoint.X, thePoint.Y);
          end;
        doConquerorTerminal :
          begin
            AddPeripheral.Visible := false;
            MoveTerminal.Visible := false;
            EditTerminal.Caption := 'Edit ' + theNode.Text;
            actDeleteNodeTerminal.Caption := 'Delete ' + theNode.Text;
            DeleteTerminal.Visible := True;
            pmNodeServerTerminal.Popup(thePoint.X, thePoint.Y);
          end;
        doMOARemoteOrdering :
          begin
            ViewMobileOrderingTerminal.Caption := 'View ' + theNode.Text;
            pmNodeMobileOrdering.Popup(thePoint.X, thePoint.Y);
          end;
        doMOAOrderPad:
          begin
            MoveTerminal.Visible := false;
            AddPeripheral.Visible := True;
            EditTerminal.Caption := 'Edit ' + theNode.Text;
            DeleteTerminal.Visible := false;
            pmNodeServerTerminal.Popup(thePoint.X, thePoint.Y);
          end;
        doiZoneTables :
          begin
            MoveTerminal.Visible := false;
            AddPeripheral.Visible := false;
            EditTerminal.Caption := 'View ' + theNode.Text;
            DeleteTerminal.Visible := false;
            pmNodeServerTerminal.Popup(thePoint.X, thePoint.Y);
          end;
        doPrinter :
          begin
            MoveNodeServerPrinter.Caption := 'Move ' + theNode.Text+ ' to...';
            DestroyPreviousSubMenuItems(MoveNodeServerPrinter);
            MoveNodeServerPrinter.Clear;
            AddMovePeripheralSubMenuItems(TRUE,MoveNodeServerPrinter,
                                          TDeviceObject(theNode.Data).deviceID,
                                          TDeviceObject(theNode.Data).PeripheralType,
                                          TDeviceObject(theNode.Parent.Data).deviceID);
            MoveNodeServerPrinter.Visible := MoveNodeServerPrinter.Count <> 0;
            EditServerPrinter.Caption := 'Edit ' + theNode.Text;
            actDeleteNodeServerPrinter.Caption := 'Delete ' + theNode.Text;
            pmNodeServerPrinter.Popup(thePoint.X, thePoint.Y);
          end;
      end;
    end
    else if Button = mbLeft then
    begin
      if (TDeviceObject(theNode.Data).deviceObjectType = doRoot) then
      begin
        // don't show terminal dialog if mouse click was on Expand or Collapse
        if (TDeviceObject(theNode.Data).Expanded or
            TDeviceObject(theNode.Data).Collapsed) then
        begin
          TDeviceObject(theNode.Data).Expanded := FALSE;
          TDeviceObject(theNode.Data).Collapsed := FALSE;
          Exit;
        end;
      end;
    end;
  end;

end;


procedure TBaseEdit.tvServerDevicesExpanding(Sender: TObject;
  Node: TTreeNode; var AllowExpansion: Boolean);
begin
  // Dodgy way to prevent ShowTerminalDialog being displayed by the treeview change
  // handler when the user has only expanded the Click To Add Server node
  // (i.e. not selected)
  if TDeviceObject(Node.Data).deviceObjectType = doRoot then
    TDeviceObject(Node.Data).Expanded := TRUE;
end;


procedure TBaseEdit.tvServerDevicesCollapsing(Sender: TObject;
  Node: TTreeNode; var AllowCollapse: Boolean);
begin
  if TDeviceObject(Node.Data).deviceObjectType = doRoot then
    TDeviceObject(Node.Data).Collapsed := TRUE;
end;


procedure TBaseEdit.grdDeviceListDblClick(Sender: TObject);
var
  typeOfDevice: String;
begin
  typeOfDevice := grdDeviceList.DataSource.DataSet.FieldByName('TypeOfDevice').Value;

  if (typeOfDevice = 'ServerPrinter') or
     (typeOfDevice = 'TerminalPrinter') then
  begin
    dmADO.qGetTerminals.Locate('SiteCode;EPOSDeviceID',VarArrayOf([FSiteCode,TDeviceObject(SelectedNode.Data).deviceID]),[]);
    dmado.qTerminalPrinters.Locate('PrinterID;SiteCode',
                               VarArrayOf([grdDeviceList.DataSource.DataSet.FieldByName('DeviceID').Value,FSiteCode]),[]);
    FindNodeForRecord(doPrinter, grdDeviceList.DataSource.DataSet.FieldByName('Name').Value);
    ShowTerminalPrinterDialog(FALSE,0);
  end
  else if (typeOfDevice = 'ServerTerminal')
       or (typeOfDevice = 'Conqueror')  then
  begin
    dmado.qGetTerminals.Locate('SiteCode;EPOSDeviceID',
                               VarArrayOf([FSiteCode,grdDeviceList.DataSource.DataSet.FieldByName('DeviceID').Value]),[]);
    FindNodeForRecord(doTerminal, grdDeviceList.DataSource.DataSet.FieldByName('Name').Value);
    if TDeviceObject(tvServerDevices.Selected.Data).deviceObjectType = doConquerorServer then
      ShowTerminalDialog(FALSE,EDIT_CONQUEROR_TERMINAL)
    else
      ShowTerminalDialog(FALSE,EDIT_TERMINAL);
  end
  else if (typeOfDevice = 'MOAOrderPad') then
  begin
    dmado.qGetTerminals.Locate('SiteCode;EPOSDeviceID',
                               VarArrayOf([FSiteCode,grdDeviceList.DataSource.DataSet.FieldByName('DeviceID').Value]),[]);
    FindNodeForRecord(doMOAOrderPad, grdDeviceList.DataSource.DataSet.FieldByName('Name').Value);
    ShowTerminalDialog(FALSE, EDIT_MOA_ORDER_PAD);
  end
  else if (typeOfDevice = 'MobileOrdering') then
  begin
    dmado.qGetTerminals.Locate('SiteCode;EPOSDeviceID',
                               VarArrayOf([FSiteCode,grdDeviceList.DataSource.DataSet.FieldByName('DeviceID').Value]),[]);
    FindNodeForRecord(doMOARemoteOrdering, grdDeviceList.DataSource.DataSet.FieldByName('Name').Value);
    TViewMOATerminal.ShowMOATerminal(grdDeviceList.DataSource.DataSet.FieldByName('DeviceID').Value, FSiteCode);
  end
  else if (typeOfDevice = 'iZoneTables') then
  begin
    dmado.qGetTerminals.Locate('SiteCode;EPOSDeviceID',
                               VarArrayOf([FSiteCode,grdDeviceList.DataSource.DataSet.FieldByName('DeviceID').Value]),[]);
    FindNodeForRecord(doiZoneTables, grdDeviceList.DataSource.DataSet.FieldByName('Name').Value);
    ShowTerminalDialog(FALSE, SHOW_IZONE_TABLES);
  end;
end;


// locate record in main edit dataset based on selected grid record
procedure TBaseEdit.grdDeviceListRowChanged(Sender: TObject);
var
  typeOfDevice: String;
begin
  if not assigned(selectednode) then
    exit;
  try
    typeOfDevice := grdDeviceList.DataSource.DataSet.FieldByName('TypeOfDevice').AsString;
    if (typeOfDevice = 'ServerPrinter') or
       (typeOfDevice = 'TerminalPrinter')then
    begin
      dmADO.qGetTerminals.Locate('SiteCode;EPOSDeviceID',VarArrayOf([FSiteCode,TDeviceObject(SelectedNode.Data).deviceID]),[]);
      dmado.qTerminalPrinters.Locate('PrinterID;SiteCode',
                                 VarArrayOf([grdDeviceList.DataSource.DataSet.FieldByName('DeviceID').Value,FSiteCode]),[]);
    end
    else if (typeOfDevice = 'ServerTerminal') or
            (typeOfDevice = 'Server') or
            (typeofDevice = 'MobileOrdering') or
            (typeofDevice = 'MOAOrderPad') then
    begin
      dmado.qGetTerminals.Locate('SiteCode;EPOSDeviceID',
                                 VarArrayOf([FSiteCode,grdDeviceList.DataSource.DataSet.FieldByName('DeviceID').Value]),[]);
    end;
  except
  end;
end;


// locate the node that represents the selected grid record - only for terminals
// and printers directly associated to servers
procedure TBaseEdit.FindNodeForRecord(ObjectType: TDeviceObjectType; ObjectName: String);
var
  i: integer;
begin
  for i := 0 to tvServerDevices.Items.Count-1 do
  begin
    if (TDeviceObject(tvServerDevices.Items[i].Data).deviceObjectType = ObjectType) and
       (tvServerDevices.Items[i].Text = ObjectName) then
    begin
      RecordNode := tvServerDevices.Items[i];
      break;
    end;
  end;
end;

procedure TBaseEdit.grdDeviceListMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  thePoint: TPoint;
  typeOfDevice, deviceName, moveCaption, deleteCaption: String;
begin
  typeOfDevice := grdDeviceList.DataSource.DataSet.FieldByName('TypeOfDevice').Value;
  deviceName := grdDeviceList.DataSource.DataSet.FieldByName('Name').Value;
  moveCaption := 'Move ' + deviceName + ' to...';
  deleteCaption := 'Delete ' + deviceName;

  if Button = mbRight then
  begin
    thePoint.X := X;
    thePoint.Y := Y;
    thePoint := grdDeviceList.ClientToScreen( thePoint );
    MoveRecordServerTerminal.Visible := true;
    AddPeripheralFromGrid.Visible := true;
    miAddPrinter.Enabled := true;
    miAddTerminal.Enabled := true;
    if typeOfDevice = 'ServerPrinter' then
    begin
      FindNodeForRecord(doPrinter, deviceName);
      MoveRecordServerPrinter.Caption := moveCaption;
      DestroyPreviousSubMenuItems(MoveRecordServerPrinter);
      AddMovePeripheralSubMenuItems(FALSE,MoveRecordServerPrinter,
                                    TDeviceObject(RecordNode.Data).deviceID,
                                    TDeviceObject(RecordNode.Data).PeripheralType,
                                    TDeviceObject(RecordNode.Parent.Data).deviceID);
      actDeleteRecordServerPrinter.Caption := deleteCaption;
      pmRecordServerPrinter.Popup(thePoint.X, thePoint.Y);
    end
    else if typeOfDevice = 'TerminalPrinter' then
    begin
      FindNodeForRecord(doPrinter, deviceName);
      MoveRecordTerminalPrinter.Caption := moveCaption;
      DestroyPreviousSubMenuItems(MoveRecordTerminalPrinter);
      AddMovePeripheralSubMenuItems(FALSE,MoveRecordTerminalPrinter,
                                    grdDeviceList.DataSource.DataSet.FieldByName('DeviceID').AsInteger,
                                    grdDeviceList.DataSource.DataSet.FieldByName('PrinterType').AsInteger,
                                    TDeviceObject(RecordNode.Parent.Data).deviceID);
      actDeleteRecordTerminalPrinter.Caption := deleteCaption;
      pmRecordTerminalPrinter.Popup(thePoint.X, thePoint.Y);
    end
    else if typeOfDevice = 'ServerTerminal' then
    begin
      FindNodeForRecord(doTerminal, deviceName);
      MoveRecordServerTerminal.Caption := moveCaption;
      DestroyPreviousSubMenuItems(MoveRecordServerTerminal);
      AddMoveTerminalSubMenuItems(FALSE, MoveRecordServerTerminal,TDeviceObject(RecordNode.Data).deviceID,
                                    TDeviceObject(RecordNode.Parent.Data).deviceID);
      actDeleteRecordTerminal.Caption := deleteCaption;
      pmRecordTerminal.Popup(thePoint.X, thePoint.Y) ;
    end
    else if typeOfDevice = 'Conqueror' then
    begin
      FindNodeForRecord(doConquerorTerminal, deviceName);
      MoveRecordServerTerminal.Visible := false;
      DestroyPreviousSubMenuItems(MoveRecordServerTerminal);
      AddMoveTerminalSubMenuItems(FALSE, MoveRecordServerTerminal,TDeviceObject(RecordNode.Data).deviceID,
                                    TDeviceObject(RecordNode.Parent.Data).deviceID);
      actDeleteRecordTerminal.Caption := deleteCaption;
      AddPeripheralFromGrid.Visible := false;
      pmRecordTerminal.Popup(thePoint.X, thePoint.Y) ;
    end
    else if typeOfDevice = 'Server' then
    begin
      dmado.qGetTerminals.Locate('SiteCode;EPOSDeviceID',VarArrayOf([FSiteCode,grdDeviceList.DataSource.DataSet.FieldByName('DeviceID').AsInteger]),[]);
      FindNodeForRecord(doServer, deviceName);
      miEditServer.Caption := 'Edit ' + grdDeviceList.DataSource.DataSet.FieldByName('Name').AsString;
      miDeleteServer.Caption := 'Delete ' + grdDeviceList.DataSource.DataSet.FieldByName('Name').AsString;
      miAddPrinter.Enabled := not TDeviceObject(RecordNode.Data).IsVirtual;
      miAddTerminal.Enabled := (not TDeviceObject(RecordNode.Data).IsVirtual) or (TDeviceObject(RecordNode.Data).TerminalCount < dmADO.VirtualServerDeviceLimit);
      pmRecordServer.Popup(thePoint.X, thePoint.Y);
    end
    else if typeOfDevice = 'ConquerorServ' then
    begin
      dmado.qGetTerminals.Locate('SiteCode;EPOSDeviceID',VarArrayOf([FSiteCode,grdDeviceList.DataSource.DataSet.FieldByName('DeviceID').AsInteger]),[]);
      FindNodeForRecord(doServer, deviceName);
      miEditServer.Caption := 'Edit ' + grdDeviceList.DataSource.DataSet.FieldByName('Name').AsString;
      miDeleteServer.Caption := 'Delete ' + grdDeviceList.DataSource.DataSet.FieldByName('Name').AsString;
      miAddPrinter.Enabled := false;
      pmRecordServer.Popup(thePoint.X, thePoint.Y);
    end;
  end;
end;



// move terminal by selecting node or grid menu move option
procedure TBaseEdit.actMoveTerminalExecute(Sender: TObject);
var
  i: integer;
  itemName: String;
begin
  with Sender as TMoveAction do
  begin
    if CalledFromNode then
      itemName := SelectedNode.Text
    else
      itemName := RecordNode.Text;

    if MessageDlg('Do you really want to move Terminal ' + itemName +
                  ' to Server ' + Caption + '?',mtConfirmation,[mbYes, mbNo], 0) = mrYes then
    begin
      Log('Pop Up Menu, Move Terminal clicked and confirmed');
      with TADOQuery.Create(nil) do
      try
        Connection := dmADO.AztecConn;

        Close;
        SQL.Clear;
        SQL.Add('update ThemeEposDevice');
        SQL.Add('  set ServerID = ' + IntToStr(MoveToDeviceID));
        SQL.Add('where EposDeviceID = ' + IntToStr(DeviceID));
        SQL.Add('and SiteCode = ' + IntToStr(FSiteCode));
        ExecSQL;
        SQL.Clear;
        SQL.Add('delete from ThemeEposPrinterStream');
        SQL.Add('WHERE EposDeviceID = ' + IntToStr(DeviceID));
        SQL.Add('AND SiteCode = ' + IntToStr(FSiteCode));
        ExecSQL;
      finally
        dmADO.qGetTerminals.Requery;
        tvServerDevicesChange(tvServerDevices, tvServerDevices.Selected);
        Free;
      end;

      // Find the new server node and move the terminal node to it
      for i := 0 to tvServerDevices.Items.Count-1 do
      begin
        if (TDeviceObject(tvServerDevices.Items[i].Data).deviceID = MoveToDeviceID) and
           (TDeviceObject(tvServerDevices.Items[i].Data).deviceObjectType = doServer) then
        begin
          if CalledFromNode then
            SelectedNode.MoveTo(tvServerDevices.Items[i],naAddChild)
          else
            RecordNode.MoveTo(tvServerDevices.Items[i],naAddChild);
          break;
        end;
      end;
      tvServerDevices.CustomSort(@TreeSortProc,0);

      MessageDlg('Please note that all print groups previously' + #13#10 +
                 'set up for ' + itemName + ' have been deleted and' + #13#10 +
                 'new print groups will have to be added.',mtWarning,[mbOK],0);

      if not CalledFromNode then
        tvServerDevices.Selected := RecordNode;
    end;
  end;
end;


// delete terminal by selecting node menu delete option
procedure TBaseEdit.actDeleteNodeTerminalExecute(Sender: TObject);
begin
  if MessageDlg(
    Format(DELETE_TERMINAL_AREYOUSURE, [QuotedStr(SelectedNode.Text)]),
    mtConfirmation,[mbYes, mbNo], 0
  ) = mrYes then
  begin
    Log('Pop Up Menu, Delete terminal clicked and confirmed');
    DeleteTheTerminal(TRUE);
  end;
end;


// move Printer by selecting node or grid record menu move option
procedure TBaseEdit.actMovePrinterExecute(Sender: TObject);
var
  i: integer;
  itemName: String;
  FPrinterTypeID : integer;
  FIsKitchenScreen: Boolean;
begin
  with Sender as TMoveAction do
  begin
    if CalledFromNode then
      itemName := SelectedNode.Text
    else
      itemName := RecordNode.Text;

    if MessageDlg('Do you really want to move Peripheral Device ' + itemName +
                  ' to ' + Caption + '?',mtConfirmation,[mbYes, mbNo], 0) = mrYes then
    begin
      Log('Pop Up Menu, Move Peripheral device clicked and confirmed');

      with TADOQuery.Create(nil) do
      try
        Connection := dmADO.AztecConn;

        FPrinterTypeID := dmADO.qTerminalPrinters.FieldByName('PrinterType').AsInteger;

        SQL.Text := 'select * from ThemePrinterType where IsTextInserter = 1 ' +
                    'and PrinterTypeID = ' + IntToStr(FPrinterTypeID);
        Open;
        if RecordCount > 0 then
        begin
          Close;
          if TerminalHasTextInserter(FSiteCode, MoveToDeviceID, TRUE) then
            Exit;
        end;
        Close;

        SQL.Text := 'select * from ThemePrinterType where IsCoinDispenser = 1 ' +
                    'and PrinterTypeID = ' + IntToStr(FPrinterTypeID);
        Open;
        if RecordCount > 0 then
        begin
          Close;
          if TerminalHasPeripheralType(FSiteCode, MoveToDeviceID, FPrinterTypeID, TRUE) then
            Exit;
        end;
        Close;

        SQL.Text := 'select * from ThemePrinterType where IsScale = 1 ' +
                    'and PrinterTypeID = ' + IntToStr(FPrinterTypeID);
        Open;
        if RecordCount > 0 then
        begin
          Close;
          if TerminalHasPeripheralType(FSiteCode, MoveToDeviceID, FPrinterTypeID, TRUE) then
            Exit;
        end;
        Close;

        SQL.Text := 'SELECT IsKitchenScreen FROM ThemePrinterType WHERE PrinterTypeID = ' + IntToStr(FPrinterTypeID);
        Open;
        FIsKitchenScreen := FieldByName('IsKitchenScreen').AsBoolean;
        Close;
        SQL.Clear;

        if CheckThePort(portNumber,FSitecode, deviceID, MoveToDeviceID, itemName,
                        MoveToDeviceName, FIsKitchenScreen) = mrCancel then
          Exit;

        if not ValidatePeripheralPorts(FSiteCode, MoveToDeviceID, FPrinterTypeID, PortNumber ) then
        begin
          raise exception.Create('This device is not configured to work with the terminal it is being moved to.' +
                                       #10#13 + ' If you wish to move it, you must delete it and re-add it'+ #10#13+
                                       'to the device you wish to move it to.');
          exit;
        end;

        SQL.Clear;
        SQL.Add('update ThemeEposPrinter');
        SQL.Add('  set EPosDeviceID = ' + IntToStr(MoveToDeviceID) + ',');
        SQL.Add('      PortNumber = (select');
        SQL.Add('                      case IPComms');
        SQL.Add('                        when 1 then null');
        SQL.Add('                        else ' + IntToStr(portNumber));
        SQL.Add('                      end');
        SQL.Add('                    from ThemePrinterType');
        SQL.Add('                    where PrinterTypeID = ThemeEposPrinter.PrinterType)');
        SQL.Add('where PrinterID = ' + IntToStr(DeviceID));
        SQL.Add('and SiteCode = ' + IntToStr(FSiteCode));
        ExecSQL;
        if (NewServerID <> CurrentServerID) and (PrinterType = 'Printer') then
        begin
          SQL.Clear;
          SQL.Add('Delete from ThemeEposPrinterStream');
          SQL.Add('where SiteCode = ' + IntToStr(FSiteCode));
          SQL.Add('and EPoSDeviceID in');
          SQL.Add(' (select EPosDeviceID from ThemeEposDevice where ServerID = ' + IntToStr(CurrentServerID) +')');
          SQL.Add('and PrinterID = ' + IntToStr(DeviceID));
          ExecSQL;
        end;
      finally
        Free;
      end;

      // Find the new server or terminal node and move the printer node to it
      for i := 0 to tvServerDevices.Items.Count-1 do
      begin
        if (TDeviceObject(tvServerDevices.Items[i].Data).deviceID = MoveToDeviceID)  and
            not (TDeviceObject(tvServerDevices.Items[i].Data).deviceObjectType = doPrinter) then
        begin
          if CalledFromNode then
          begin
            SelectedNode.MoveTo(tvServerDevices.Items[i],naAddChild);
            tvServerDevices.Selected := SelectedNode;
            RefreshSelectedDetailPanel;
          end
          else
          begin
            RecordNode.MoveTo(tvServerDevices.Items[i],naAddChild);
            tvServerDevices.Selected := RecordNode;
          end;
          tvServerDevices.CustomSort(@TreeSortProc,0);
          break;
        end;
      end;
      if (NewServerID <> CurrentServerID) and (PrinterType = 'Printer') then
        with TADOQuery.Create(nil) do
        try
          Connection := dmADO.AztecConn;
          SQL.Add('Select [Name] from ThemeEposDevice');
          SQL.Add('where SiteCode = ' + IntToStr(FSiteCode) + ' and EPosDeviceID = ' + IntToStr(CurrentServerID));
          Open;
          MessageDlg('Please note that print groups previously targeted to ' + #13#10 +
                     ItemName + ' by terminals associated to server ' + FieldByName('Name').AsString + #13#10 +
                     'have been deleted.',mtWarning,[mbOK],0);
        finally
          Close;
          Free;
        end;
    end;
  end;
end;


// delete Server Printer by selecting node menu delete option
procedure TBaseEdit.actDeleteNodeServerPrinterExecute(Sender: TObject);
begin
  if MessageDlg('Do you really want to delete Peripheral Device ' + SelectedNode.Text + '?',
                mtConfirmation,[mbYes, mbNo], 0) = mrYes then
  begin
    Log('Pop Up Menu, Delete Server Printer clicked and confirmed');
    DeleteThePrinter(TRUE);
  end;
end;


// delete terminal by selecting grid record menu delete option
procedure TBaseEdit.actDeleteRecordTerminalExecute(Sender: TObject);
begin
  if MessageDlg(
    Format(DELETE_TERMINAL_AREYOUSURE, [QuotedStr(RecordNode.Text)]),
    mtConfirmation,[mbYes, mbNo], 0
  ) = mrYes then
  begin
    Log('Pop Up Menu, Delete Terminal clicked and confirmed');
    DeleteTheTerminal(FALSE);
  end;
end;


// delete Server Printer by selecting grid record menu delete option
procedure TBaseEdit.actDeleteRecordServerPrinterExecute(Sender: TObject);
begin
  if MessageDlg('Do you really want to delete Peripheral Device ' + RecordNode.Text + '?',
                mtConfirmation,[mbYes, mbNo], 0) = mrYes then
  begin
    Log('Pop Up Menu, Delete Server Printer clicked and confirmed');
    DeleteThePrinter(FALSE);
  end;
end;


// delete Terminal printer by selecting grid record menu delete option
procedure TBaseEdit.actDeleteRecordTerminalPrinterExecute(Sender: TObject);
begin
  if MessageDlg('Do you really want to delete Peripheral Device ' +
                qryTerminalDeviceList.FieldByName('Name').AsString + '?',
                mtConfirmation,[mbYes, mbNo], 0) = mrYes then
  begin
    Log('Pop Up Menu, Delete Terminal Peripheral Device clicked and confirmed');
    FindNodeForRecord(doPrinter, qryTerminalDeviceList.FieldByName('Name').AsString);
    DeleteThePrinter(FALSE);
  end;
end;


// add Server printer by selecting server node menu add printer option
procedure TBaseEdit.actAddNodeServerPrinterExecute(Sender: TObject);
begin
  Log('Pop Up Menu, Add Server Printer clicked');
  ShowTerminalPrinterDialog(TRUE,1);
end;


// edit Terminal by selecting terminal node popup menu edit option
procedure TBaseEdit.actEditNodeTerminalExecute(Sender: TObject);
begin
  Log('Pop Up Menu, Edit Terminal clicked');
  ShowTerminalDialog(TRUE,EDIT_TERMINAL);
end;


// edit Server Printer by selecting printer node menu edit option
procedure TBaseEdit.actEditNodeServerPrinterExecute(Sender: TObject);
begin
  Log('Pop Up Menu, Edit Server Printer clicked');
  ShowTerminalPrinterDialog(TRUE,0);
end;


// add Terminal printer by selecting grid menu option add
procedure TBaseEdit.actAddRecordTerminalPrinterExecute(Sender: TObject);
begin
  Log('Pop Up Menu, Add Terminal Peripheral Device clicked');
  ShowTerminalPrinterDialog(FALSE,1);
end;


procedure TBaseEdit.cbxServerNameChange(Sender: TObject);
begin
  if pcBaseData.ActivePage = tsPrintGroupGrid then
  begin
    PStreamLoad;
    BuildAggregatePrintStreamView;
  end;
end;


procedure TBaseEdit.pcBaseDataChanging(Sender: TObject;
  var AllowChange: Boolean);
begin

  if pcBaseData.ActivePage = TabDeviceSetup then
  begin
    RefreshServerCombos;
  end
  else if pcBaseData.ActivePage = tabSheet_ConfigurationSettings then
  begin
     AllowChange := EFTConfigurationFieldsValid and KMSConfigurationFieldsValid;
  end;

  try
    if AllowChange and Assigned(pcBaseData.ActivePage.OnHide) then pcBaseData.ActivePage.OnHide(nil);
  except
    AllowChange := false;
  end;
end;


procedure TBaseEdit.miAddTerminalClick(Sender: TObject);
begin
  Log('Pop Up menu, Add Terminal button clicked');

  if grdDeviceList.DataSource.DataSet.FieldByName('TypeOfDevice').Value = 'ConquerorServ' then
    ShowTerminalDialog(FALSE,ADD_CONQUEROR_TERMINAL)
  else
    ShowTerminalDialog(False,ADD_TERMINAL);
end;


procedure TBaseEdit.miAddPrinterClick(Sender: TObject);
begin
  Log('Pop Up Menu, Add Server Printer clicked');
  ShowTerminalPrinterDialog(FALSE,1);
end;

procedure TBaseEdit.miEditServerClick(Sender: TObject);
begin
  Log('Pop Up menu, Edit Server button clicked');
  ShowTerminalDialog(FALSE,EDIT_SERVER);
end;

procedure TBaseEdit.miDeleteServerClick(Sender: TObject);
begin
  if MessageDlg(
    Format(DELETE_SERVER_AREYOUSURE, [QuotedStr(RecordNode.Text)]),
    mtConfirmation,[mbYes, mbNo], 0
  ) = mrYes then
  begin
    Log('Pop up menu, Delete Record Server Menu Item clicked');
    DeleteTheServer(FALSE);
  end;
end;


procedure TBaseEdit.DeleteTheServer(fromNodeMenu: Boolean);
var
  SQLStr : string;
  SiteCode, ServerID : Integer;
begin
  if not fromNodeMenu then
    qryServerDeviceList.Open;

  // delete all terminals associated to server
  SQlStr := 'DELETE FROM ThemeEposDevice WHERE IsServer = 0 AND SiteCode = %d AND ServerID = %d';
  SiteCode := FSiteCode;

  if fromNodeMenu then
    ServerID := TDeviceObject(SelectedNode.Data).DeviceID
  else
    ServerID := grdDeviceList.DataSource.DataSet.FieldByName('DeviceID').AsInteger;

  dmADO.qRun.SQL.Text := format(SQLStr,[SiteCode,ServerID]);

  Log(Format('Deleting Terminals attached to Server Device Code %d',[ServerID]));
  dmADO.qRun.ExecSQL;
  // delete server (which will trigger deletion of printers directly associated to it)
  SQLStr := 'DELETE FROM ThemeEposDevice WHERE IsServer = 1 AND SiteCode = %d  AND EPoSDeviceID = %d';
  dmADO.qRun.SQL.Text := format(SQLStr,[SiteCode,ServerID]);
  Log(Format('Deleting Server Device Code %d',[ServerID]));
  dmADO.qRun.ExecSQL;



  // remove node and subnodes
  if fromNodeMenu then
  begin
    tvServerDevices.Items.Delete(SelectedNode);
    SelectedNode := nil;
  end
  else
  begin
    tvServerDevices.Items.Delete(RecordNode);
    RecordNode := nil;
    RefreshDeviceListGrid;
  end;
end;


function TBaseEdit.EFTConfigurationFieldsValid: Boolean;
var
  InvalidFieldName: String;
begin
  Result := TRUE;
  //with dmADO.qOutletConfigs do
  //begin
    if dbEdtEFTRequestPort.Text = '' then
    begin
      Result := FALSE;
      InvalidFieldName := 'EFT IP Ports (Req)';
      tabSheet_ConfigurationSettings.Show;
      dbEdtEFTRequestPort.SetFocus;
    end
    else if dbEdtEFTResponsePort.Text = '' then
    begin
      Result := FALSE;
      InvalidFieldName := 'EFT IP Ports (Rsp)';
      tabSheet_ConfigurationSettings.Show;
      dbEdtEFTResponsePort.SetFocus;
    end
    else if dbEdtGiftRequestPort.Text = '' then
    begin
      Result := FALSE;
      InvalidFieldName := 'Loyalty/Gift IP Port (Req)';
      tabSheet_ConfigurationSettings.Show;
      dbEdtGiftRequestPort.SetFocus;
    end
    else if dbEdtGiftResponsePort.Text = '' then
    begin
      Result := FALSE;
      InvalidFieldName := 'Loyalty/Gift IP Port (Rsp)';
      tabSheet_ConfigurationSettings.Show;
      dbEdtGiftResponsePort.SetFocus;
    end
    else if (cbEFTMode.Text = 'Commidea') and (DBEditCommideaPinPadLogin.Text = '') then
    begin
      Result := FALSE;
      InvalidFieldName := 'Commidea Pin Pad Login';
      tabSheet_ConfigurationSettings.Show;
      DBEditCommideaPinPadLogin.SetFocus;
    end
    else if (cbEFTMode.Text = 'Commidea') and (DBEditCommideaPinPadPIN.Text = '') then
    begin
      Result := FALSE;
      InvalidFieldName := 'Commidea Pin Pad PIN';
      tabSheet_ConfigurationSettings.Show;
      DBEditCommideaPinPadPIN.SetFocus;
    end;
    if not Result then
      MessageDlg(Format('The "%s" field must be completed before continuing', [InvalidFieldName]), mtError, [mbOK], 0);
  //end;
end;

function TBaseEdit.KMSConfigurationFieldsValid: Boolean;
var
  InvalidFieldName: String;
  MissingString: String;
  ErrorMessage: String;
begin
  Result := TRUE;
  MissingString := 'The %s must be completed before continuing.';
  if (wwDBEditKMSPrimaryServer.Text <> '') and (wwDBEditKMSPrimaryServerPort.Text = '') then
  begin
    Result := FALSE;
    InvalidFieldName := '"KMS Primary Server Port" field';
    ErrorMessage := MissingString;
    tabSheet_ConfigurationSettings.Show;
    wwDBEditKMSPrimaryServerPort.SetFocus;
  end
  else if (wwDBEditKMSPrimaryServer.Text = '') and (wwDBEditKMSPrimaryServerPort.Text <> '') then
  begin
    Result := FALSE;
    InvalidFieldName := '"KMS Primary Server" field';
    ErrorMessage := MissingString;
    tabSheet_ConfigurationSettings.Show;
    wwDBEditKMSPrimaryServer.SetFocus;
  end
  else if (wwDBEditKMSPrimaryServer.Text = '') and (wwDBEditKMSPrimaryServerPort.Text = '')
     and ((wwDBEditKMSBackupServer.Text <> '') or (wwDBEditKMSBackupServerPort.Text <> '')) then
  begin
    Result := FALSE;
    InvalidFieldName := 'KMS Primary Server settings';
    ErrorMessage := MissingString;
    tabSheet_ConfigurationSettings.Show;
    wwDBEditKMSPrimaryServer.SetFocus;
  end
  else if (wwDBEditKMSPrimaryServer.Text <> '') and (wwDBEditKMSPrimaryServerPort.Text <> '')
      and (wwDBEditKMSBackupServer.Text <> '') and (wwDBEditKMSBackupServerPort.Text = '') then
  begin
    Result := FALSE;
    InvalidFieldName := '"KMS Backup Server Port" field';
    ErrorMessage := MissingString;
    tabSheet_ConfigurationSettings.Show;
    wwDBEditKMSBackupServerPort.SetFocus;
  end
  else if (wwDBEditKMSPrimaryServer.Text <> '') and (wwDBEditKMSPrimaryServerPort.Text <> '')
      and (wwDBEditKMSBackupServer.Text = '') and (wwDBEditKMSBackupServerPort.Text <> '') then
  begin
    Result := FALSE;
    InvalidFieldName := '"KMS Backup Server" field';
    ErrorMessage := MissingString;
    tabSheet_ConfigurationSettings.Show;
    wwDBEditKMSBackupServer.SetFocus;
  end
  else if (ANSICompareText(wwDBEditKMSPrimaryServer.Text, wwDBEditKMSBackupServer.Text) = 0) and (wwDBEditKMSPrimaryServer.Text <> '') then
  begin
    Result := FALSE;
    InvalidFieldName := '';
    ErrorMessage := 'Primary and backup KMS servers must not be the same.';
    tabSheet_ConfigurationSettings.Show;
    wwDBEditKMSPrimaryServer.SetFocus;
  end;

  if not Result then
    MessageDlg(Format(ErrorMessage, [InvalidFieldName]), mtError, [mbOK],0);
end;

procedure TBaseEdit.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TBaseEdit.dbEdtEFTRequestPortExit(Sender: TObject);
begin
  EFTConfigurationFieldsValid;
end;

procedure TBaseEdit.dbEdtGiftRequestPortKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TBaseEdit.RefreshSelectedDetailPanel;
var
  SelectedObject: TDeviceObject;
  ScreenInterfaceType : String;
begin
  SelectedObject := TDeviceObject(SelectedNode.Data);

  case SelectedObject.deviceObjectType of
    doRoot :
      begin
        qrySelectRoot.Close;
        qrySelectRoot.Parameters.ParamByName('SiteCode').Value := FSiteCode;
        qrySelectRoot.Open;
        if qrySelectRoot.RecordCount > 0 then
        begin
          pnlSelectedDetail.Show;
          lblNameLabel.Caption := 'Company Name';
          lblName.Caption := qrySelectRoot.fieldByName('Company Name').AsString;

          lblIPAddressLabel.Caption := 'Site Name';
          lblIPAddress.Caption := qrySelectRoot.fieldByName('Site Name').AsString;

          lblHardWareTypeLabel.Caption := 'Site Manager';
          lblHardwaretype.Caption := qrySelectRoot.fieldByName('Site Manager').AsString;

          lblDeviceIdLabel.Caption := 'Telephone';
          lblDeviceID.Caption := qrySelectRoot.fieldByName('Phone').AsString;
        end;
      end;
    doServer:
      begin
        qrySelectedServerDetails.Close;
        qrySelectedServerDetails.Parameters.ParamByName('SiteCode').Value := FSiteCode;
        qrySelectedServerDetails.Parameters.ParamByName('TerminalID').Value := SelectedObject.deviceID;
        qrySelectedServerDetails.Open;
        pnlSelectedDetail.Show;
        if qrySelectedServerDetails.RecordCount > 0 then
        begin
          lblHardWareTypeLabel.Caption := 'Hardware Type';
          lblNameLabel.Caption := 'Name';
          lblDeviceIdLabel.Caption := 'Device ID:';
          lblIPAddressLabel.Caption := 'IP Address:';

          lblName.Caption := qrySelectedServerDetails.fieldByName('Name').AsString;
          lblIPAddress.Caption := qrySelectedServerDetails.fieldByName('IPAddress').AsString;
          lblHardwaretype.Caption := qrySelectedServerDetails.fieldByName('HardwareName').AsString;
          lblDeviceID.Caption := qrySelectedServerDetails.fieldByName('DeviceID').AsString;
        end;
      end;
    doConquerorServer, doHotelSystemServer, doQueueBuster:
      begin
        qrySelectedServerDetails.Close;
        qrySelectedServerDetails.Parameters.ParamByName('SiteCode').Value := FSiteCode;
        qrySelectedServerDetails.Parameters.ParamByName('TerminalID').Value := SelectedObject.deviceID;
        qrySelectedServerDetails.Open;
        pnlSelectedDetail.Show;
        if qrySelectedServerDetails.RecordCount > 0 then
        begin
          lblHardWareTypeLabel.Caption := 'Hardware Type';
          lblNameLabel.Caption := 'Name';
          lblDeviceIdLabel.Caption := 'Device ID:';
          lblIPAddressLabel.Caption := 'IP Address:';

          lblName.Caption := qrySelectedServerDetails.fieldByName('Name').AsString;
          lblIPAddress.Caption := 'N/A';
          lblHardwaretype.Caption := qrySelectedServerDetails.fieldByName('HardwareName').AsString;
          lblDeviceID.Caption := qrySelectedServerDetails.fieldByName('DeviceID').AsString;
        end;
      end;
    doTerminal, doMOAOrderPad, doiZoneTables:
      begin
        ScreenInterfaceType := '';

        qrySelectTerminal.Close;
        qrySelectTerminal.Parameters.ParamByName('DeviceID').Value := SelectedObject.deviceID;
        qrySelectTerminal.Parameters.ParamByName('SiteCode').Value := FSiteCode;
        qrySelectTerminal.Open;

        if qrySelectTerminal.RecordCount > 0 then
        begin
          pnlSelectedDetail.Show;

          if qrySelectTerminal.FieldByName('HardwareName').AsString = 'Z500' then
             begin
               if qrySelectTerminal.FieldByName('ScreenInterfaceID').AsInteger = 1 then
                  ScreenInterfaceType := ' (15" Screen)'
             end;

          lblIPAddressLabel.Caption := 'IP Address:';
          lblDeviceIdLabel.Caption := 'Device ID:';
          lblHardWareTypeLabel.Caption := 'Hardware Type';
          lblNameLabel.Caption := 'Name';

          lblName.Caption := qrySelectTerminal.fieldByName('Name').AsString;
          lblIPAddress.Caption := qrySelectTerminal.fieldByName('IPAddress').AsString;
          lblHardwaretype.Caption := qrySelectTerminal.fieldByName('HardwareName').AsString + ScreenInterfaceType;
          lblDeviceID.Caption := qrySelectTerminal.fieldByName('EposDeviceID').AsString;

          if qrySelectTerminal.fieldByName('MultiDrawerMode').AsBoolean then
            lblHardwaretype.Caption := lblHardwaretype.Caption + ' (Two drawer mode)';
        end;
      end;
    doConquerorTerminal:
      begin
        qrySelectTerminal.Close;
        qrySelectTerminal.Parameters.ParamByName('DeviceID').Value := SelectedObject.deviceID;
        qrySelectTerminal.Parameters.ParamByName('SiteCode').Value := FSiteCode;
        qrySelectTerminal.Open;

        if qrySelectTerminal.RecordCount > 0 then
        begin
          pnlSelectedDetail.Show;

          lblIPAddressLabel.Caption := 'Conqueror Device ID:';
          lblDeviceIdLabel.Caption := 'Device ID:';
          lblHardWareTypeLabel.Caption := 'Hardware Type';
          lblNameLabel.Caption := 'Name';

          lblName.Caption := qrySelectTerminal.fieldByName('Name').AsString;
          with dmADO.qRun do
          begin
            Close;
            Sql.Clear;
            Sql.Add('Select ConquerorDeviceID from ConquerorEposDeviceDetails where EposDeviceID = ' + qrySelectTerminal.fieldByName('EposDeviceID').AsString);
            open;
          end;
          lblIPAddress.Caption := dmADO.qRun.fieldByName('ConquerorDeviceID').AsString;
          lblHardwaretype.Caption := qrySelectTerminal.fieldByName('HardwareName').AsString;
          lblDeviceID.Caption := qrySelectTerminal.fieldByName('EposDeviceID').AsString;
        end;
      end;
    doMOARemoteOrdering:
      begin
        dmADO.qGetMoaDetails.Close;
        dmADO.qGetMoaDetails.Parameters[0].Value := FSiteCode;
        dmADO.qGetMoaDetails.Parameters[1].Value := SelectedObject.deviceID;
        try
          dmADO.qGetMoaDetails.Open;
          if dmADO.qGetMoaDetails.RecordCount > 0 then
          begin
            pnlSelectedDetail.Show;
            lblNameLabel.Caption :=  'Sales Area:';
            lblIPAddressLabel.Caption := 'No. of MOA Terminals:';
            lblDeviceIdLabel.Caption := 'MOA Employee:';
            lblHardWareTypeLabel.Caption := 'Hardware Type:';

            lblName.Caption := dmADO.qGetMoaDetailsSalesArea.AsString;
            lblIPAddress.Caption := IntToStr(dmADO.qGetMoaDetailsMOACount.AsInteger);
            lblHardwaretype.Caption := 'Mobile Ordering Terminal';
            lblDeviceID.Caption := dmADO.qGetMoaDetailsMOAUser.AsString;
          end;
        finally
          dmADO.qGetMoaDetails.Close;
        end;
      end;
    doPrinter:
      begin
        qrySelectPeripheralDevice.Close;
        qrySelectPeripheralDevice.Parameters.ParamByName('SiteCode').Value := FSiteCode;
        qrySelectPeripheralDevice.Parameters.ParamByName('DeviceID').Value := SelectedObject.deviceID;
        qrySelectPeripheralDevice.Open;
        if qrySelectPeripheralDevice.RecordCount > 0 then
        begin
          pnlSelectedDetail.Show;

          lblHardWareTypeLabel.Caption := 'Hardware Type';
          lblNameLabel.Caption := 'Name';
          lblIPAddressLabel.Caption := 'Device:';
          lblDeviceIdLabel.Caption := 'Port Number:';

          lblName.Caption := qrySelectPeripheralDevice.fieldByName('Name').AsString;
          lblHardwaretype.Caption := qrySelectPeripheralDevice.fieldByName('PeripheralDevice').AsString;
          lblIPAddress.Caption := qrySelectPeripheralDevice.fieldByName('PrintertypeName').AsString;
          lblDeviceID.Caption := qrySelectPeripheralDevice.fieldByName('PortNumber').AsString;

          if qrySelectPeripheralDevice.FieldByName('IPAddress').AsString <> '' then
          begin
            lblDeviceIdLabel.Caption := 'IP Address / Port Number:';
            lblDeviceID.Caption := qrySelectPeripheralDevice.fieldByName('IPAddress').AsString +' / '+
                                   qrySelectPeripheralDevice.fieldByName('IPPort').AsString;
          end
        end;
      end;
  end; // end of case statement
end;

procedure TBaseEdit.RefreshDeviceListGrid;
var
  SelectedObject: TDeviceObject;
begin
  SelectedObject := TDeviceObject(SelectedNode.Data);

  grdDeviceList.Hide;
  qrySiteServers.Close;
  qryServerDeviceList.Close;
  qryTerminalDeviceList.Close;
  grdDeviceList.Selected.Clear;
  dsDeviceList.DataSet := nil;

  if (SelectedObject.deviceObjectType = doPrinter) then
    Exit;

  case SelectedObject.deviceObjectType of
    doRoot :
      begin
        grdDeviceList.Selected.Add('Name'#9'20'#9'Name');
        grdDeviceList.Selected.Add('DeviceType'#9'14'#9'Device Type');
        grdDeviceList.Selected.Add('IPAddress'#9'14'#9'IP Address');
        qrySiteServers.Open;
        if qrySiteServers.RecordCount > 0 then
        begin
          dsDeviceList.DataSet := qrySiteServers;
          grdDeviceList.Show;
          grdDeviceList.Refresh;
        end;
      end;
    doServer :
      begin
        qryServerDeviceList.Parameters.ParamByName('serverID').Value := SelectedObject.deviceID;
        qryServerDeviceList.Parameters.ParamByName('eposDeviceID').Value := SelectedObject.deviceID;
        qryServerDeviceList.Parameters.ParamByName('siteCode').Value := FSiteCode;
        grdDeviceList.Selected.Add('Name'#9'20'#9'Name');
        grdDeviceList.Selected.Add('DeviceType'#9'39'#9'Device Type');
        grdDeviceList.Selected.Add('IPAddress'#9'14'#9'IP Address');
        grdDeviceList.Selected.Add('IPPort'#9'5'#9'IP~Port~No.');
        grdDeviceList.Selected.Add('PortNumber'#9'5'#9'Serial~Port~No.');
        qryServerDeviceList.Open;
        if qryServerDeviceList.RecordCount > 0 then
        begin
          dsDeviceList.DataSet := qryServerDeviceList;
          grdDeviceList.Show;
          grdDeviceList.Refresh;
        end;
      end;
    doConquerorServer :
      begin
        qryServerDeviceList.Parameters.ParamByName('serverID').Value := SelectedObject.deviceID;
        qryServerDeviceList.Parameters.ParamByName('eposDeviceID').Value := SelectedObject.deviceID;
        qryServerDeviceList.Parameters.ParamByName('siteCode').Value := FSiteCode;
        grdDeviceList.Selected.Add('Name'#9'12'#9'Name');
        grdDeviceList.Selected.Add('DeviceType'#9'14'#9'Device Type');
        qryServerDeviceList.Open;
        if qryServerDeviceList.RecordCount > 0 then
        begin
          dsDeviceList.DataSet := qryServerDeviceList;
          grdDeviceList.Show;
          grdDeviceList.Refresh;
        end;
      end;
    doTerminal, doMOAOrderPad:
      begin
        qryTerminalDeviceList.Parameters.ParamByName('terminalID').Value := SelectedObject.deviceID;
        qryTerminalDeviceList.Parameters.ParamByName('siteCode1').Value := FSiteCode;
        qryTerminalDeviceList.Parameters.ParamByName('siteCode2').Value := FSiteCode;
        grdDeviceList.ControlType.Add('HasCashDrawer;CheckBox;True;False');
        grdDeviceList.Selected.Add('Name'#9'20'#9'Name');
        grdDeviceList.Selected.Add('PrinterTypeName'#9'39'#9'Device Type');
        grdDeviceList.Selected.Add('IPAddress'#9'14'#9'IP Address');
        grdDeviceList.Selected.Add('IPPort'#9'5'#9'IP~Port~No.');
        grdDeviceList.Selected.Add('PortNumber'#9'5'#9'Serial~Port~No.');
        grdDeviceList.Selected.Add('HasCashDrawer'#9'5'#9'Has~Cash~Drawer');
        qryTerminalDeviceList.Open;
        if qryTerminalDeviceList.RecordCount > 0 then
        begin
          dsDeviceList.DataSet := qryTerminalDeviceList;
          grdDeviceList.Show;
          grdDeviceList.Refresh;
        end;
      end;
  end; // end of case statement
end;


constructor TBaseEdit.Create(AOwner: TComponent);
begin
  inherited;
  PStreamSortMode := 1;
end;

function TBaseEdit.isConquerorDevice(EPoSDeviceID: Integer): Boolean;
begin
  with dmADO.qRun do
  begin
    close;
    sql.clear;
    sql.add ('Select HardwareType from ThemeEposDevice where EposDeviceID = :EposDeviceID');
    parameters.parambyname('EposDeviceID').Value :=  EposDeviceID;
    open;
    result := (fieldbyname('HardwareType').AsInteger = ord(ehtConqueror));
  end;
end;

procedure TBaseEdit.tsPinPadGridShow(Sender: TObject);
begin
  LoadPinPadGrid;
end;

procedure TBaseEdit.tsPinPadGridHide(Sender: TObject);
begin
  SavePinPadGrid;
end;

procedure TBaseEdit.cbxPinPadGridServerChange(Sender: TObject);
begin
  if pcBaseData.ActivePage = tsPinPadGrid then
    LoadPinPadGrid;
end;

procedure TBaseEdit.cbxPinPadGridServerBeforeDropDown(Sender: TObject);
begin
  SavePinPadGrid;
end;

procedure TBaseEdit.cbxServerNameBeforeDropDown(Sender: TObject);
begin
  PStreamSaveAggregate;
  PStreamSave;
end;

procedure TBaseEdit.LoadPinPadGrid;
var
  i: integer;
begin
  if qryServersForCbx2.Active = FALSE then
    RefreshServerCombos;
  with dmADO.qRun do
  begin
    // Create temp table to edit pin pad groups, then load data.
    SQL.Text := 'IF object_id(''tempdb..#EditPinPadGrid'') IS NOT NULL DROP TABLE dbo.#EditPinPadGrid';
    ExecSQL;
    SQL.Text := 'CREATE TABLE #EditPinPadGrid '+#13+
      '( '+#13+
      '  DeviceID BIGINT, DeviceName VARCHAR(50) '+#13+
      '  PRIMARY KEY (DeviceID) '+#13+
      ')';
    ExecSQL;
    SQL.Text := 'DECLARE @OutletID INT, @ServerID INT '+#13+
      'SET @OutletID = <SiteCode> '+#13+
      'SET @ServerID = <ServerID> '+#13+

      'INSERT #EditPinPadGrid '+#13+
      '(DeviceID, DeviceName) '+#13+
      'SELECT EposDeviceID, [Name]  '+#13+
      'FROM ThemeEposDevice  '+#13+
      'WHERE '+#13+
      '  (SiteCode = @OutletID) AND '+#13+
      '  (IsServer = 0) AND '+#13+
      '  (ServerID = @ServerID) AND '+#13+
      '  (HardwareType not in (10, 14)) '+#13+    // Mobile Ordering
      'ORDER BY [Name] '+#13+

      'DECLARE Printers CURSOR FAST_FORWARD FOR '+#13+
      'SELECT a.PrinterID, REPLACE(REPLACE(b.[name]+'':'' + ISNULL(CAST(a.PortNumber AS VARCHAR(50)),'''') + '' - '' + a.[name], ''['', ''''), '']'', '''') '+#13+
      'FROM ThemeEposPrinter a '+#13+
      'JOIN ThemePrinterType ON (a.PrinterType = ThemePrinterType.PrinterTypeID) AND (ThemePrinterType.IsPinPad = 1) '+#13+
      'JOIN ThemeEposDevice b ON a.EposDeviceID = b.EposDeviceID AND b.SiteCode = @OutletID AND a.SiteCode = @OutletID '+#13+
      '       AND ((b.IsServer = 0 AND b.ServerID = @ServerID) OR (b.IsServer = 1 AND b.EposDeviceID = @ServerID)) '+#13+
      'ORDER BY b.Name, a.portnumber '+#13+

      'DECLARE @PeripheralID BIGINT, @PeripheralName VARCHAR(50) '+#13+

      'OPEN Printers '+#13+

      'FETCH NEXT FROM Printers INTO @PeripheralID, @PeripheralName '+#13+
      'WHILE @@FETCH_STATUS = 0 '+#13+
      'BEGIN '+#13+
      '  EXEC(''ALTER TABLE #EditPinPadGrid ADD  [''+@PeripheralName+''] BIT'') '+#13+
      '  EXEC(''UPDATE #EditPinPadGrid SET [''+@PeripheralName+''] = 0'') '+#13+
      '  EXEC(''UPDATE #EditPinPadGrid SET [''+@PeripheralName+''] = 1 WHERE ''+ '+#13+
      '    ''EXISTS(SELECT * FROM ThemeEposPeripheralAccess b WHERE b.SiteCode = ''+@OutletID+'' ''+ '+#13+
      '    ''AND #EditPinPadGrid.DeviceID = b.EposDeviceID ''+ '+#13+
      '    ''AND b.PeripheralID = ''+@PeripheralID+'')'') '+#13+
      '  FETCH NEXT FROM Printers INTO @PeripheralID, @PeripheralName '+#13+
      'END '+#13+

      'CLOSE Printers '+#13+
      'DEALLOCATE Printers '+#13+
      'SELECT 1';
    SQL.Text := StringReplace(SQL.Text, '<SiteCode>', IntToStr(FSiteCode), [rfReplaceAll]);
    SQL.Text := StringReplace(SQL.Text, '<ServerID>', IntToStr(qryServersForCbx2.fieldByName('EPOSDeviceID').AsInteger), [rfReplaceAll]);
    Open;
    Close;
    if qryPinPadGrid.Active = FALSE then
      qryPinPadGrid.Open
    else
    begin
      qryPinPadGrid.Close;
      qryPinPadGrid.Open;
    end;
  end;
  // Work around strange bug that fixed columns of the pin pad group grid
  // disappear when there are no pin pads.
  qryPinPadGrid.FieldByName('DeviceName').ReadOnly := TRUE;
  // Format grid at runtime - can't be done at design time due to fields added
  // to temp table at runtime.
  with dbgPinPadGrid do
  begin
    Selected.Clear;
    Selected.Add('DeviceName'#9'20'#9'Terminal');
    for i := 0 to Pred(DataSource.DataSet.Fields.Count) do
    if (DataSource.DataSet.Fields[i].Fieldname <> 'DeviceID') and
      (DataSource.DataSet.Fields[i].FieldName <> 'DeviceName') then
    begin
      Selected.Add(DataSource.DataSet.Fields[i].FieldName +#9'3'#9 +
        DataSource.DataSet.Fields[i].FieldName);
      SetControlType(DataSource.DataSet.Fields[i].FieldName, fctCheckBox, 'True;False');
    end;
    ApplySelected;
    Invalidate;
  end;
end;

procedure TBaseEdit.SavePinPadGrid;
begin
  if qryPinPadGrid.Active then
  begin
    if qryPinPadGrid.State in [dsEdit, dsInsert] then
      qryPinPadGrid.post;
    qryPinPadGrid.UpdateBatch;
    with dmADO.qRun do
    begin
      dmADO.BeginTransaction;
      // Save pin pad group data.
      SQL.Text := 'SET NOCOUNT ON '+#13+
        'DECLARE @outletid INT, @serverID INT '+#13+
        'SET @outletid = <SiteCode> '+#13+
        'SET @serverID = <ServerID> '+#13+

        'DELETE FROM ThemeEposPeripheralAccess '+#13+
        'WHERE EposDeviceID IN '+#13+
        '  (SELECT EposDeviceID '+#13+
        '   FROM ThemeEposDevice '+#13+
        '   WHERE IsServer = 0 '+#13+
        '   AND ServerID = @serverID '+#13+
        '   AND HardwareType NOT IN (10, 14))'+#13+
        'AND SiteCode = @outletid '+#13+

        'DECLARE Printers CURSOR FAST_FORWARD FOR '+#13+
        'SELECT a.PrinterID, REPLACE(REPLACE(b.[name]+'':'' + ISNULL(CAST(a.PortNumber AS VARCHAR(50)),'''') + '' - '' + a.[name], ''['', ''''), '']'', '''') '+#13+
        'FROM themeeposprinter a  '+#13+
        'JOIN ThemePrinterType ON (a.PrinterType = ThemePrinterType.PrinterTypeID) AND (ThemePrinterType.IsPinPad = 1) '+#13+
        'JOIN themeeposdevice b ON a.eposdeviceid = b.eposdeviceid AND b.sitecode = @outletid AND a.sitecode = @outletid '+#13+
        '       AND ((b.IsServer = 0 AND b.ServerID = @serverID) OR (b.IsServer = 1 AND b.EPoSDeviceID = @serverID)) '+#13+
        'ORDER BY b.name, a.portnumber '+#13+

        'DECLARE @Peripheralid BIGINT, @Peripheralname VARCHAR(50) '+#13+

        'OPEN Printers '+#13+
        'FETCH NEXT FROM printers INTO @Peripheralid, @Peripheralname '+#13+
        'WHILE @@FETCH_STATUS = 0 '+#13+
        'BEGIN '+#13+
        '  EXEC(''INSERT ThemeEposPeripheralAccess ''+ '+#13+
        '    ''(SiteCode, EposDeviceID, PeripheralID) ''+ '+#13+
        '    ''SELECT ''+@outletid+'', DeviceID, ''+@Peripheralid+'' ''+ '+#13+
        '    ''FROM #EditPinPadGrid WHERE [''+@Peripheralname+''] = 1''); '+#13+
        '  FETCH NEXT FROM Printers INTO @Peripheralid, @Peripheralname '+#13+
        'END '+#13+

        'CLOSE Printers '+#13+
        'DEALLOCATE Printers'+#13+
        'SET NOCOUNT OFF';
      SQL.Text := StringReplace(SQL.Text, '<SiteCode>', IntToStr(FSiteCode), [rfReplaceAll]);
      SQL.Text := StringReplace(SQL.Text, '<ServerID>', IntToStr(qryServersForCbx2.fieldByName('EPOSDeviceID').AsInteger), [rfReplaceAll]);
      try
        ExecSQL;
        dmADO.CommitTransaction;
      except
        begin
          dmADO.RollbackTransaction;
          raise;
        end;
      end;
    end;
  end;
end;


procedure TBaseEdit.RefreshServerCombos;
begin
  qryServersForCbx.Close;
  qryServersForCbx.Parameters.ParamByName('siteCode').Value := FSiteCode;
  qryServersForCbx.Open;
  cbxServerName.Text := qryServersForCbx.FieldByName('Name').AsString;
  cbxServerName.PerformSearch;

  qryServersForCbx2.Close;
  qryServersForCbx2.Parameters.ParamByName('siteCode').Value := FSiteCode;
  qryServersForCbx2.Open;
  cbxPinPadGridServer.Text := qryServersForCbx2.FieldByName('Name').AsString;
  cbxPinPadGridServer.PerformSearch;

  adoqThemeTerminalFilterTypeLookup.Close;
  adoqThemeTerminalFilterTypeLookup.Open;
  cbxTerminalFilterTypeName.Text := adoqThemeTerminalFilterTypeLookup.FieldByName('Value').AsString;
  cbxTerminalFilterTypeName.PerformSearch;
end;

procedure TBaseEdit.CreatePinPadAccess(PrinterType, SiteCode, EposDeviceID,
  PeripheralID: integer);
var
  IsPinPad: boolean;
begin
  dmADO.adoqRun.SQL.Text := Format(
    'select IsPinPad from ThemePrinterType where PrinterTypeID = %d and PinPadType = (select id from ThemePinPadTypeLookup where value = ''DataCash'')',
    [PrinterType]
  );
  dmADO.adoqRun.Open;
  IsPinPad := dmADO.adoqRun.FieldByName('IsPinPad').AsBoolean;
  dmADO.adoqRun.Close;
  if IsPinPad then
  begin
    try
      dmADO.adoqRun.SQL.Text := Format(
        'INSERT ThemeEposPeripheralAccess (SiteCode, EposDeviceID, PeripheralID) '+
        'VALUES (%d, %d, %d)', [Sitecode, EposDeviceID, PeripheralID]);
      dmADO.adoqRun.ExecSQL;
    except on E:Exception do
      begin
        if Pos('Violation of PRIMARY KEY', E.message) = 0 then
          raise;
      end;
    end;
  end;
end;

procedure TBaseEdit.dbgPstreamsFieldChanged(Sender: TObject;
  Field: TField);
var
  i: integer;
  PrintersDefined: boolean;
  QualifiedPrinterName: String;
  TerminalName: String;
  PortNumber: String;
  PrinterName: String;
  PStreamID: String;
  PStreamName: String;
begin
  if (TwwDBGrid(sender).DataSource.DataSet.State = dsEdit)
    and (LowerCase(Field.FieldName) = 'optional')
    and (Field.NewValue = True) then
  begin
    PrintersDefined := False;
    for i := Field.Index+1 to Pred(TwwDBGrid(Sender).DataSource.DataSet.FieldCount-3) do
      PrintersDefined := PrintersDefined or TwwDBGrid(Sender).DataSource.DataSet.Fields[i].AsBoolean;
    if not(PrintersDefined) then
      for i := Field.Index+1 to Pred(TwwDBGrid(Sender).DataSource.DataSet.FieldCount-3) do
        TwwDBGrid(Sender).DataSource.DataSet.Fields[i].AsBoolean := True;
  end
  else if (TwwDBGrid(sender).DataSource.DataSet.State = dsEdit)
    and (LowerCase(Field.FieldName) <> 'optional')
    and (Field.NewValue = True) then
  begin
    //String chopping of the unique name generated for the cross-tab...
    QualifiedPrinterName := Field.FieldName;
    TerminalName := Copy(QualifiedPrinterName, 1, Pos(':',QualifiedPrinterName) - 1);
    Delete(QualifiedPrinterName,1,Pos(':',QualifiedPrinterName));
    PortNumber := Trim(Copy(QualifiedPrinterName,1,Pos('-',QualifiedPrinterName)-2));
    Delete(QualifiedPrinterName,1,Pos('-',QualifiedPrinterName)+1);
    PrinterName := QualifiedPrinterName;
    PStreamID := dbgPstreams.DataSource.DataSet.FieldByName('printstreamid').AsString;
    PStreamName := QuotedStr(StringReplace(dbgPstreams.DataSource.DataSet.FieldByName('sort2').AsString,'&','&&',[rfReplaceAll]));
    with dmThemeData.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select 1 as Disallowed from');
      SQL.Add('themeeposprinter tep');
      SQL.Add('join ThemeEposDevice ted');
      SQL.Add('on ted.EPoSDeviceID = tep.EposDeviceID');
      SQL.Add('where tep.SiteCode = ' + IntToStr(FSiteCode));
      if PortNumber <> '' then
        SQL.Add('and tep.PortNumber = ' + PortNumber);
      SQL.Add('and tep.Name = ' + QuotedStr(PrinterName));
      SQL.Add('and ted.Name = ' + QuotedStr(TerminalName));
      SQL.Add('and tep.Printertype in (10030,10031,10033)');
      SQL.Add('and (select ReportPrintStream from ThemeOutletStandardPrintConfigs where SiteCode = ' + IntToStr(FSiteCode) + ') = ' + PStreamID);
      Open;

      if RecordCount > 0 then
      begin
        MessageDlg(Format('''Report Print Group'' is assigned print stream %s and cannot print to this printer type.' +#13#10 +
                  'Either change the ''Report Print Group'' or assign this printer to another print stream.',
                  [PStreamName]),
                  mtError,
                  [mbOK],
                  0);
        Field.NewValue := false;
      end;
    end
  end;
end;

procedure TBaseEdit.PStreamGridCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);

  function CommonBrushColor: TColor;
  var
    currps: integer;
  begin
    if LowerCase(Field.FieldName) = 'optional' then
    begin
      currps := twwdbgrid(sender).DataSource.DataSet.Fieldbyname('printstreamid').asinteger;
      if not((currps = bill_ps) or (currps = report_ps) or (currps = eft_ps)) then
      begin
        Result := clBtnFace;
      end
      else
        Result := ABrush.Color;
    end
    else
      Result := ABrush.Color;
  end;

var
  ReadOnlyRecord: Boolean;
begin
  ReadOnlyRecord := False;
  if Assigned(TwwDBGrid(sender).DataSource.DataSet.FindField('ReadOnly')) then
    ReadOnlyRecord := TwwDBGrid(sender).DataSource.DataSet.Fieldbyname('ReadOnly').AsBoolean;

  if ReadOnlyRecord then
  begin
      ABrush.Color := clBtnFace;
      AFont.Color := clGrayText;
  end
  else
    ABrush.Color := CommonBrushColor;
end;

procedure TBaseEdit.PStreamGridRowChanged(Sender: TObject);
var
  currps: integer;
  ReadOnlyRecord: Boolean;
  i: Integer;
begin
  currps := twwdbgrid(sender).DataSource.DataSet.Fieldbyname('printstreamid').asinteger;
  ReadOnlyRecord := False;
  if Assigned(TwwDbGrid(sender).DataSource.DataSet.FindField('ReadOnly')) then
    ReadOnlyRecord := TwwDbGrid(sender).DataSource.DataSet.FindField('ReadOnly').AsBoolean;

  if ReadOnlyRecord then
    for i := 0 to twwdbgrid(sender).DataSource.DataSet.FieldCount - 1 do
      twwdbgrid(sender).DataSource.DataSet.Fields[i].ReadOnly := True
  else begin
    for i := 0 to twwdbgrid(sender).DataSource.DataSet.FieldCount - 1 do
      twwdbgrid(sender).DataSource.DataSet.Fields[i].ReadOnly := False;
    if ((currps = bill_ps) or (currps = report_ps) or (currps = eft_ps)) then
      twwdbgrid(sender).DataSource.DataSet.Fieldbyname('optional').ReadOnly := false
    else
    begin
      if twwdbgrid(sender).DataSource.DataSet.Fieldbyname('optional').asboolean = true then
      begin
        twwdbgrid(sender).DataSource.DataSet.edit;
        twwdbgrid(sender).DataSource.DataSet.Fieldbyname('optional').ReadOnly := false;
        twwdbgrid(sender).DataSource.DataSet.Fieldbyname('optional').asboolean := false;
      end;
      twwdbgrid(sender).DataSource.DataSet.Fieldbyname('optional').ReadOnly := true;
    end;
  end;
end;


function TDeviceObject.GetIcon: integer;
begin
  Result := -1;

  if deviceObjectType in [doRoot, doServer, doConquerorServer] then
    Result := uHardwareIcons.GetIcon(ikServerGroup)

  else if deviceObjectType = doQueueBuster then
    Result := uHardwareIcons.GetIcon(ikDevice, 3) // QB device icon to look like a handheld..

  else if FDeviceType <> -1 then
    Result := uHardwareIcons.GetIcon(ikDevice, FDeviceType)
  else if FPeripheralType <> -1 then
    Result := uHardwareIcons.GetIcon(ikPeripheral, FPeripheralType);
end;

function TDeviceObject.GetIsVirtual: boolean;
begin
  with TADOQuery.create(nil) do try
    Connection := dmADO.AztecConn;
    SQL.Text := Format('select a.IPAddress from ThemeOutletConfigs a '+
      'join ThemeEposDevice b on a.SiteCode = b.SiteCode and a.IPAddress = b.IPAddress '+
      'where a.SiteCode = %d and b.EPOSDeviceID = %d',
      [dmthemedata.qOutlets.fieldbyname('SiteCode').AsInteger, self.deviceID]);
    Open;
    Result := (RecordCount > 0);
    Close;
  finally
    free;
  end;
end;

function TDeviceObject.GetTerminalCount: integer;
begin
  with TADOQuery.create(nil) do try
    Connection := dmADO.AztecConn;
    SQL.Text := Format('select EPOSDeviceID from ThemeEposDevice '+
      'where SiteCode = %d and IsServer = 0 and ServerID = %d',
      [dmthemedata.qOutlets.fieldbyname('SiteCode').AsInteger, self.deviceID]);
    Open;
    Result := RecordCount;
    Close;
  finally
    free;
  end;
end;

procedure TDeviceObject.SetDeviceType(const Value: integer);
begin
  FDeviceType := Value;
  if FDeviceType <> -1 then
  begin
    FTreeNode.ImageIndex := GetIcon;
    FTreeNode.SelectedIndex := GetIcon;
  end;
end;

procedure TDeviceObject.SetPeripheralType(const Value: integer);
begin
  FPeripheralType := Value;
  if FPeripheralType <> -1 then
  begin
    FTreeNode.ImageIndex := GetIcon;
    FTreeNode.SelectedIndex := GetIcon;
  end;
end;

procedure TBaseEdit.FormCreate(Sender: TObject);
const
  IconSize = 16;
begin
  Application.HintHidePause := 5000; // hint disappears after 5 secs
  LocaliseForm(self);
  uHardwareIcons.SetupIconList(dmADO.AztecConn);
  uHardwareIcons.LoadIconImageList(ilDevices, IconSize);
  // pnlDevices.width := 136 + (IconSize) * 4;
  tvServerDevices.Images := ilDevices;
  pcBaseData.ActivePage := TabDeviceSetUp;

  if not dmThemeData.SiteVersionAtLeast('3.5.1.0') then
  begin
    cbAutoPayoutTips.ShowHint := True;
    cbAutoPayoutTips.Hint := 'Auto payout of tips only possible on clock out at sites on Aztec versions lower than 3.5.1.';
  end;
end;

procedure TBaseEdit.SetCommideaUsage(Enabled: boolean);
begin

  CommideaPinPadLoginLabel.Enabled := Enabled;
  CommideaPinPadPINLabel.Enabled := Enabled;
  DBEditCommideaPinPadLogin.Enabled := Enabled;
  DBEditCommideaPinPadPIN.Enabled := Enabled;
  DBEditCommideaTransactionTimeout.Enabled := Enabled;
  CommideaTransactionTimeoutlabel.Enabled := Enabled;
  // PW: This routine was failing on my test system so I've corrected the problem
  // What I can't explain is that the OnClick handler of useCommideaEFT was
  // being called when the form is closed, or when the misc tab loses focus.
  // Bug was that the qOutletConfigs dataset is closed at that time.
  if dmADO.qOutletConfigs.Active = false then
    exit;
  if cbEFTMode.Text <> 'Commidea' then
  begin
  (*
    DBEditCommideaPinPadLogin.Text := '';

    if dmADO.qOutletConfigs.State <> dsEdit then
       dmADO.qOutletConfigs.Edit;

    dmADO.qOutletConfigs.FieldByName('CommideaServerIPAddress').Clear;
    dmADO.qOutletConfigs.FieldByName('CommideaPinPadLogin').Clear;
    dmADO.qOutletConfigs.FieldByName('CommideaPinPadPIN').Clear;
    dmADO.qOutletConfigs.FieldByName('CommideaTransactionTimeout').Clear;
    DBEditCommideaPinPadPIN.Text := '';
    DBEditCommideaTransactionTimeout.Text := '';  *)
  end
  else
  begin

  end;
end;

procedure TBaseEdit.tabSheet_ConfigurationSettingsShow(Sender: TObject);
begin
  with dmADO do
  begin
    dmThemeData.AccessDataset(qryGiftCardTypes);
    dmThemeData.AccessDataset(qOutletConfigs);
    dmThemeData.AccessDataset(qThemeTerminalEFTTimeouts);
    dmThemeData.AccessDataset(qThemeOutletEftModeLookup);
    SetCommideaUsage(qOutletConfigs.FieldByName('EFTMode').Value = 1);
    if DBEditCommideaTransactionTimeout.Field.AsString = '' then
    begin
      qOutletConfigs.Edit;
      DBEditCommideaTransactionTimeout.Field.Value := '180';
    end;
  end;
  cbEftMode.OnChange(TObject(cbEftMode));
  UpdateIPToSerialMapperPortRange(StrToInt(dbedtIPToSerialMapperStartPort.Text));
end;

procedure TBaseEdit.tabSheet_ConfigurationSettingsHide(Sender: TObject);
begin
  if Sender = nil then exit;

  with dmADO do
  begin
    dmThemeData.DeAccessDataset(qOutletConfigs, true);
    dmThemeData.DeAccessDataset(qryGiftCardTypes, true);
    dmThemeData.DeAccessDataset(qThemeTerminalEFTTimeouts, true);
    dmThemeData.DeAccessDataset(qThemeOutletEftModeLookup, true);
    SetIPAddresses;
    SetServerSettings;
  end;
end;

procedure TBaseEdit.EFTTimeoutGridFieldChanged(Sender: TObject; Field: TField);
begin
  EFTTimeoutGrid.Repaint;
end;


procedure TBaseEdit.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  EftMode, PeripheralWarnings: string;
begin

  if dmADO.qOutletConfigs.Active then
  begin
    if not EFTConfigurationFieldsValid then
      CanClose := false
    else if not KMSConfigurationFieldsValid then
      CanClose := false;
  end;

  dmAdo.qRun.SQL.Text := Format('select b.value '+
    'from ThemeOutletConfigs a '+
    'join ThemeOutletEftModeLookup b on a.EFTMode = b.Id '+
    'where a.SiteCode = %d', [FsiteCode]);
  dmAdo.qRun.Open;
  if dmAdo.qRun.RecordCount > 0 then
    EftMode := dmAdo.qRun.Fields[0].AsString
  else
    EftMode := 'Standard';
  dmAdo.qRun.Close;

  if CheckForEftPeripheralWarnings(EftMode, PeripheralWarnings) then
    MessageDlg('There are EFT mode peripheral warnings:'+#13+PeripheralWarnings,
      mtWarning, [mbOk], 0);

  PeripheralWarnings := '';
  if CheckOtherSetups(PeripheralWarnings) then
    MessageDlg(PeripheralWarnings, mtWarning, [mbOK], 0);

  //update aztec printer types and aztec pos details to eposmodel
  if Assigned(pcBaseData.ActivePage) then
  begin
    if not (pcBaseData.ActivePageIndex in [tsPrintGroupGrid.PageIndex, tabSheet_Printing.PageIndex]) then
      CanClose := CanClose and VX670PrintStreamSetupOK(true);
    if Assigned(pcBaseData.ActivePage.OnHide) and CanClose then
    begin
      try
        pcBaseData.ActivePage.OnHide(Self);
      except
        on e:EAbort do
        begin
          CanClose := False;
        end
      end;
    end;
  end;
end;

procedure TBaseEdit.DBEditIPAddressChange(Sender: TObject);
begin
  GetIPAddress;
end;

procedure TBaseEdit.LogDBCheckBoxClick(DBCheckBox: TDBCheckBox);
begin
  if DBCheckBox.Checked then
    Log( DBCheckBox.Caption + ' : Checked')
  else
    Log( DBCheckBox.Caption + ' : UnChecked')
end;

procedure TBaseEdit.DBCheckBoxAbbreviateClockOutReportClick(
  Sender: TObject);
begin
  LogDBCheckBoxClick(DBCheckBoxAbbreviateClockOutReport);
end;

procedure TBaseEdit.DBCheckBoxPrintClockOutTicketClick(Sender: TObject);
begin
  DBCheckBoxAbbreviateClockOutReport.Enabled := DBCheckBoxPrintClockOutTicket.Checked;

  LogDBCheckBoxClick(DBCheckBoxPrintClockOutTicket);
end;

procedure TBaseEdit.GetIPAddress;
begin

  if (EditEFTAddress.Text = '') or (EditEFTAddress.Text = sIPAddress) then
      EditEFTAddress.Text := DBEditIPAddress.Text;

  if (EditGiftAddress.Enabled = false) or (EditGiftAddress.Text = '') or (EditGiftAddress.Text = sIPAddress) then
      EditGiftAddress.Text := EditEFTAddress.Text;

  sIPAddress := DBEditIPAddress.Text;

end;

procedure TBaseEdit.SetIPAddresses;
begin
  GetIPAddress;
  with qIPAddresses do
    begin
      if RecordCount > 0 then
         Edit
      else
         begin
           Insert;
           FieldByName('SiteCode').AsInteger := fsitecode;
         end;
      FieldByName('EFTAddress').AsString := EditEFTAddress.Text;
      FieldByName('GiftAddress').AsString := EditGiftAddress.Text;
      Post;
    end;
end;

procedure TBaseEdit.useFastEFTClick(Sender: TObject);
begin
  DBEditFastEFTAmount.Enabled := CurrentUser.IsZonalUser;
end;

procedure TBaseEdit.btnHotelCodeAllocationClick(Sender: TObject);
begin
  if not assigned(HotelCodeAllocation) then
  begin
    HotelCodeAllocation := THotelCodeAllocation.Create(nil);
    HotelCodeAllocation.FSiteCode := FSiteCode;
    HotelCodeAllocation.FSiteName := dmThemeData.qOutlets.FieldByName('Name').AsString;
    HotelCodeAllocation.ShowModal;
    FreeAndNil(HotelCodeAllocation);
  end;
end;

procedure TBaseEdit.ReadPStreamCodes;
begin
  with dmADO.qRun do
  begin
    SQL.text :=
      'select billreceiptprintstream, reportprintstream, eftprintstream '+
      'from ThemeOutletStandardPrintConfigs '+
      'where SiteCode = '+inttostr(FSiteCode);
    Open;
    self.bill_ps := fieldbyname('billreceiptprintstream').asinteger;
    self.report_ps := fieldbyname('reportprintstream').asinteger;
    self.eft_ps := fieldbyname('eftprintstream').asinteger;
    close;
  end;
end;


procedure TBaseEdit.EditGiftAddressExit(Sender: TObject);
begin
  ValidateIPAddress(EditGiftAddress.Text, Sender);
end;

procedure TBaseEdit.EditEFTAddressExit(Sender: TObject);
begin
  ValidateIPAddress(EditEFTAddress.Text, Sender);
end;

procedure TBaseEdit.ValidateIPAddress(IPAddress: String;
                                      Sender: TObject);
var
  ErrorMessage: String;
begin
  if not ValidIPv4Address(IPAddress, ErrorMessage) then
  begin
    if Sender is TWinControl then
      (Sender as TWinControl).SetFocus;
    MessageDlg(ErrorMessage, mtError, [mbOK], 0);
  end
end;

procedure TBaseEdit.ValidateIPPort(IPPort: String;
                                   Sender: TObject);
var
  IPPortNumber: Integer;
begin
  try
    IPPortNumber := StrToInt(IPPort);
    if (IPPortNumber < 0) or (IPPortNumber > 65535) then
    begin
      if Sender is TWinControl then
        (Sender as TWinControl).SetFocus;
      MessageDlg('IP port is out of range.  Port must be between 0 and 65535', mtError, [mbOK], 0);
    end;
  except
  on E:EConvertError do
    begin
      if Sender is TWinControl then
        (Sender as TWinControl).SetFocus;
      MessageDlg('IP port is out of range.  Port must be between 0 and 65535', mtError, [mbOK], 0);
    end
  end;
end;

// Note: if adding a new lable + edit control to the pnDynamicEFTSettings panel,
// ensure the label.Top property is [edit control].Top +3. 
procedure TBaseEdit.FormatDynamicEFTSettings;
var
  TmpControls: TList;
  i: integer;
  NewTop, RowHeight, MinTop: integer;
  function GetMinTop: integer;
  var
    i: integer;
  begin
    result := 9999;
    for i := 0 to pred(TmpControls.Count) do
      if TControl(TmpControls[i]).Top < result then
        result := TControl(TmpControls[i]).Top;
  end;
begin
  TmpControls := TList.Create;
  for i := 0 to pred(pnDynamicEFTSettings.ControlCount) do
  begin
    if pnDynamicEFTSettings.Controls[i].visible then
    TmpControls.Add(pnDynamicEFTSettings.Controls[i]);
  end;
  NewTop := 0;
  while TmpControls.Count > 0 do
  begin
    MinTop := GetMinTop;
    RowHeight := 21;
    for i := pred(TmpControls.Count) downto 0 do
    begin
      if TControl(TmpControls[i]).Top = MinTop then
      begin
        RowHeight := TControl(TmpControls[i]).Height;
        TControl(TmpControls[i]).Top := NewTop;
        TmpControls.Delete(i);
      end
      else if TControl(TmpControls[i]).Top = MinTop+3 then
      begin
        TControl(TmpControls[i]).Top := NewTop+3;
        TmpControls.Delete(i);
      end
    end;
    NewTop := NewTop + RowHeight+3;
  end;
end;

procedure DisableControlsIf(IsDisabled: boolean; ControlsList: array of TControl);
var
  i: integer;
begin
  for i := low(ControlsList) to high(ControlsList) do
  begin
    ControlsList[i].Enabled := not IsDisabled;
  end;
end;

function TBaseEdit.ShouldDisableOciusControls: Boolean;
begin
  With dmThemeData.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select b.* ');
    SQL.Add('from ThemeEposDevice a join ThemeEposPrinter b ');
    SQL.Add('on a.SiteCode = b.SiteCode and a.EposDeviceId = b.EposDeviceId ');
    SQL.Add('join ThemePrinterType c on b.PrinterType = c.PrinterTypeID and ');
    SQL.Add('(IsPinPad = 1 and PinPadType = 5) ');
    SQL.Add('where a.SiteCode = '+IntToStr(FSiteCode));
    Open;
    Result := (cbEFTMode.Text <> 'ZCPS') OR (dmThemeData.adoqRun.RecordCount = 0);
  end;
end;

procedure TBaseEdit.cbEftModeChange(Sender: TObject);
var
  EftMode: string;
  PeripheralWarnings: string;
  EftModeWasChanged: boolean;
begin
  EftMode := TwwDBLookupcombo(sender).Text;
  if (EftMode <> 'ZCPS') and (EftMode <> 'Commidea') and (EftMode <> 'Standard') then exit;
  EftModeWasChanged := (OldEftMode <> '') and (OldEftMode <> EftMode);
  if EftModeWasChanged or (OldEftMode = '') then
    OldEftMode := EftMode;
  DisableControlsIf(EftMode = 'ZCPS', [dbEdtEFTRequestPort, dbEdtEFTResponsePort]);
  DisableControlsIf(ShouldDisableOciusControls, [OciusPinPadLoginLabel, OciusPinPadLoginIdDBEdit, OciusPinPadPasswordLabel, OciusPinPadPasswordDBEdit]);
  DisableControlsIf(EftMode <> 'ZCPS', [cbSetCreditLimitAfterPreAuth]);
  SetCommideaUsage(EFTMode = 'Commidea');

  lbPeripheralWarnings.Visible := CheckForEftPeripheralWarnings(EftMode, PeripheralWarnings);
  if lbPeripheralWarnings.Visible then
    lbPeripheralWarnings.Hint := PeripheralWarnings;
  if lbPeripheralWarnings.Visible and EftModeWasChanged then
  begin
    PeripheralWarningsTimer.Enabled := true;
  end;
end;

procedure TBaseEdit.PeripheralWarningsTimerTimer(Sender: TObject);
var
  ReconfigurePinPads: TBaseEditReconfigurePinPads;
  PeripheralWarnings: string;
  EftMode: string;
  Vx670ConvertDeviceType: integer;
  EnableEftPaySetting: integer;
begin
  TTimer(Sender).Enabled := false;
  EftMode := cbEftMode.Text;
  ReconfigurePinPads := TBaseEditReconfigurePinPads.Create(nil);
  if EftMode <> 'ZCPS' then
  with ReconfigurePinPads do
  begin
    cbEnableEftPay.Checked := false;
    cbEnableEftPay.Enabled := false;
    cbVx670PayAtTable.Enabled := false;
  end;
  CheckForEftPeripheralWarnings(EftMode, ReconfigurePinPads.mmWarnings.Lines);
  if ReconfigurePinPads.ShowModal = mrOk then
  begin
    if dmADO.dsOutletConfigs.State in [dsEdit, dsInsert] then
      dmADO.dsOutletConfigs.DataSet.Post;

    if ReconfigurePinPads.cbVx670PayAtTable.Checked then
      Vx670ConvertDeviceType := 10032
    else
      Vx670ConvertDeviceType := 10030;

    dmADO.qRun.SQL.Text :=  Format(
      'declare @Mode varchar(20) = %s '+
      'declare @SiteCode int = %d '+
      'declare @Vx670DefaultDevice int = %d '+
      'if @Mode = ''ZCPS'' '+
      'begin '+
      '  update ThemeEposPrinter '+
      '  set PrinterType = NewPrinterType'+
      '  from ThemeEposPrinter a join ( '+
      '    select 10001 as OldPrinterType, 10010 as NewPrinterType '+
      '    union select 10003, 10010 '+
      '    union select 10004, 10010 '+
      '    union select 32518, 10010 '+
      '    union select 10005, 10011 '+
      '    union select 10006, 10012 '+
      '    union select 10007, @Vx670DefaultDevice '+
      '  ) Mapping on a.PrinterType = Mapping.OldPrinterType '+
      '  where SiteCode = @SiteCode '+
      'end '+
      'else if @Mode = ''Standard'' '+
      'begin '+
      '  update ThemeEposPrinter '+
      '  set PrinterType = NewPrinterType'+
      '  from ThemeEposPrinter a join ( '+
      '    select 10010 as OldPrinterType, 10001 as NewPrinterType '+
      '    union select 10011, 10005 '+
      '    union select 10012, 10006 '+
      '    union select 10030, 10007 '+
      '    union select 10032, 10007 '+
      '  ) Mapping on a.PrinterType = Mapping.OldPrinterType '+
      '  where SiteCode = @SiteCode '+
      'end',
      [QuotedStr(cbEftMode.Text), FSiteCode, Vx670ConvertDeviceType]);
    dmADO.qRun.ExecSQL;

    if ReconfigurePinPads.cbEnableEftPay.Checked and (EftMode = 'ZCPS') then
      EnableEftPaySetting := 1
    else
      EnableEftPaySetting := 0;

    dmADO.qRun.SQL.Text := Format(
      'update ThemeEposPrinter set EnableEftPay = %d '+
      'from ThemeEposPrinter a '+
      'join ThemePrinterType b on a.PrinterType = b.PrinterTypeID '+
      '  and b.IsPinPad = 1 '+
      'where SiteCode = %d ', [EnableEftPaySetting, FSitecode]);
    dmADO.qRun.ExecSQL;


    lbPeripheralWarnings.Visible := CheckForEftPeripheralWarnings(EftMode, PeripheralWarnings);
    if lbPeripheralWarnings.Visible then
    begin
      lbPeripheralWarnings.Hint := PeripheralWarnings;
      ReconfigurePinPads.mmWarnings.Clear;
      CheckForEftPeripheralWarnings(EftMode, ReconfigurePinPads.mmWarnings.Lines);
      ReconfigurePinPAds.Label1.Caption := 'The following warnings could not be fixed automatically:';
      ReconfigurePinPads.btFixNow.Enabled := false;
      ReconfigurePinPads.ShowModal;
    end;
  end;
  ReconfigurePinPads.Release;
end;

type TDeviceCheckMode = (dcmAll, dcmServerOnly, dcmTerminalOnly);

function TBaseEdit.CheckForEftPeripheralWarnings(Eftmode: string; var PeripheralWarnings: string): Boolean;
var
  WarningsList: TStrings;
begin
  WarningsList := TStringList.Create;
  result := CheckForEftPeripheralWarnings(EftMode, WarningsList);
  PeripheralWarnings := WarningsList.Text;
  if (Length(PeripheralWarnings) > 2) and (PeripheralWarnings[Length(PeripheralWarnings)] = #10) then
    SetLength(PeripheralWarnings, Length(PeripheralWarnings)-2);
  WarningsList.Free;
end;

function TBaseEdit.CheckForEftPeripheralWarnings(EftMode: string; WarningsList: TStrings): Boolean;
  procedure AddWarningBasedOnRowCount(SqlQuery: string; RowCountCheck: integer; WarningText: string);
  var
    qry: TADOQuery;
    Names: TStrings;
  begin
    Names := TStringList.Create;
    qry := TADOQuery.Create(nil);
    qry.Connection := dmAdo.AztecConn;
    qry.SQL.Text := SqlQuery;
    try
      qry.Open;

      while not qry.Eof do
      begin
        Names.Add(qry.Fields[0].AsString);
        qry.Next;
      end;
      Names.Delimiter := ',';
      if qry.RecordCount > RowCountCheck then
      begin
        WarningsList.Add(WarningText + ': ');
        WarningsList.Add('  '+Names.DelimitedText);
      end;

      qry.Close;
    except on E:Exception do
      WarningsList.Add('Error checking pin pad configuration: '+E.message);
    end;
    qry.free;
    Names.free;
  end;

  procedure AddWarningForPinPadTypes(CheckMode: TDeviceCheckMode; PinPadTypeClause: string; WarningText: string);
  var
    DeviceRestriction: string;
    SqlQuery: string;
  begin
    if CheckMode = dcmServerOnly then DeviceRestriction := 'and IsServer = 1'
    else if CheckMode = dcmTerminalOnly then DeviceRestriction := 'and IsTerminal = 1'
    else DeviceRestriction := '';
    SqlQuery := Format('select a.Name + ''/'' + b.Name from ThemeEposDevice a '+
      'join ThemeEposPrinter b on a.SiteCode = b.SiteCode and a.EposDeviceId = b.EposDeviceId '+
      'join ThemePrinterType c on b.PrinterType = c.PrinterTypeID and (%s) '+
      'where a.SiteCode = %d '+
      '  %s', [PinPadTypeClause, FSiteCode, DeviceRestriction]);
    AddWarningBasedOnRowCount(SqlQuery, 0, WarningText);
  end;

  procedure AddWarningForDuplicateRoamingServers();
  var
    SqlQuery: string;
  begin
    SqlQuery := Format('select a.Name + ''/'' + b.Name from ThemeEposDevice a '+
      'join ThemeEposPrinter b on a.SiteCode = b.SiteCode and a.EposDeviceId = b.EposDeviceId '+
      'join ThemePrinterType c on b.PrinterType = c.PrinterTypeID and (%s) '+
      'where a.SiteCode = %d ', ['PrinterTypeName like ''%roaming%''', FSiteCode]);
    AddWarningBasedOnRowCount(SqlQuery, 1, 'There is more than one Roaming base pinpad set up');
  end;


begin
  if EftMode = 'ZCPS' then
  begin
    AddWarningForPinPadTypes(dcmServerOnly, 'IsPinPad = 1 and IpToSerialMapped = 1', 'IP Mapped serial devices not valid on EPOS Server');
    AddWarningForPinPadTypes(dcmAll, 'IsPinPad = 1 and PinPadType = 1 and IpToSerialMapped = 0 and IpComms = 0', 'Non IP Mapped serial devices not valid with ZCPS');
    AddWarningForPinPadTypes(dcmAll, 'IsPinPad = 1 and PinPadType = 2', 'Non IP Mapped serial devices not valid with ZCPS');
    AddWarningForDuplicateRoamingServers();
  end
  else if EftMode = 'Standard' then
  begin
    AddWarningForPinPadTypes(dcmAll, 'IsPinPad = 1 and (IpToSerialMapped = 1 or IpComms = 1)', 'IP Mapped/IP devices not valid with Standard EFT');
    AddWarningForPinPadTypes(dcmAll, 'IsPinPad = 1 and PinPadType = 3', 'eSocket.POS devices not valid with Standard EFT');
  end
  else if EftMode = 'Commidea' then
  begin
    AddWarningForPinPadTypes(dcmAll, 'IsPinPad = 1 and PinPadType <> 2', 'Non-Commidea devices not valid with Commidea EFT');
  end;

  Result := WarningsList.Count > 0;
end;

procedure TBaseEdit.cmbbxGiftCardTypeChange(Sender: TObject);
var
  GiftMode: string;
begin
  GiftMode := TwwDBLookupcombo(sender).text;
  DisableControlsIf(GiftMode = 'Via EFT Server', [EditGiftAddress,  dbEdtGiftRequestPort, dbEdtGiftResponsePort, btSetLocalGiftServer]);
end;

procedure TBaseEdit.btSetLocalEFTServerClick(Sender: TObject);
begin
  EditEFTAddress.Text := dmAdo.qOutletConfigs.FieldByName('IPAddress').AsString;
end;

procedure TBaseEdit.btSetLocalGiftServerClick(Sender: TObject);
begin
  EditGiftAddress.Text := dmAdo.qOutletConfigs.FieldByName('IPAddress').AsString;
end;

procedure TBaseEdit.cbAutoPayoutTipsClick(Sender: TObject);
begin
  LogDBCheckBoxClick(Sender as TDBCheckBox);
  if dmThemeData.SiteVersionAtLeast('3.5.1.0') then
  begin
    if (Sender as TDBCheckBox).Checked then
    begin
      cbOnClockOut.Enabled := TRUE;
      if not (dmADO.qOutletConfigs.State in [dsEdit, dsInsert]) then
        exit;
      cbOnClockOut.Checked := TRUE;
      dmAdo.qOutletConfigsPayoutTipsOnClockout.AsBoolean := TRUE;
    end
    else begin
      cbOnClockOut.Enabled := FALSE;
    end;
  end
  else begin
     cbOnClockOut.Enabled := FALSE;
     cbOnClockOut.Checked := (Sender as TDBCheckBox).Checked;
  end;
end;

procedure TBaseEdit.cbOnClockOutClick(Sender: TObject);
begin
  if not dmADO.qOutletConfigs.Active then
    exit
  else if not (dmADO.qOutletConfigs.State in [dsInsert, dsEdit]) then
    exit;

  LogDBCheckBoxClick(Sender as TDBCheckBox);
  dmADO.qOutletConfigsPayoutTipsOnClockout.AsBoolean := (Sender as TDBCheckBox).Checked;
end;

procedure TBaseEdit.btnSetDefaultLedgersSettingsClick(Sender: TObject);
begin
  qServiceSettings.Filter := 'SoapServerID = 6';
  qServiceSettings.Filtered := True;
  edtLedgersServerIP.Text := qServiceSettings.FieldByName('IPAddressDefault').AsString;
  edtLedgersServerIPPort.Text := qServiceSettings.FieldByName('IPPortNumberDefault').AsString;
end;

procedure TBaseEdit.btnSetDefaultBookingsSettingsClick(Sender: TObject);
begin
  qServiceSettings.Filter := 'SoapServerID = 7';
  qServiceSettings.Filtered := True;
  edtBookingsServerIP.Text := qServiceSettings.FieldByName('IPAddressDefault').AsString;
  edtBookingsServerIPPort.Text := qServiceSettings.FieldByName('IPPortNumberDefault').AsString;
end;

procedure TBaseEdit.SetServerSettings;

  procedure SaveSettings(IPAddress, IPPort: String;  SOAPServerID: Integer);
  begin
    qServiceSettings.Filter := 'SoapServerID = ' + IntToStr(SOAPServerID);
    qServiceSettings.Filtered := True;
    //If reset to defaults then nuke the overrides that were stored.
    if (qServiceSettings.FieldByName('IPAddressDefault').AsString = Trim(IPAddress))
    and (qServiceSettings.FieldByName('IPPortNumberDefault').AsString = Trim(IPPort)) then
    begin
      with dmADO.qRun do
      begin
        Close;
        SQL.CLear;
        SQL.Add('delete SiteServiceSettingsOverrides');
        SQL.Add(Format('where SiteCode = %d and ServiceId = %d',[FSiteCode,SoapServerID]));
        ExecSQL;
      end;
    end
    else begin
      with dmADO.qRun do
      begin
        Close;
        SQL.CLear;
        SQL.Text := Format('if Exists(select * from SiteServiceSettingsOverrides' + #13#10 +
                           '          where SiteCode = %1:d and ServiceId = %0:d)' + #13#10 +
                           '  update SiteServiceSettingsOverrides' + #13#10 +
                           '  set IPAddress = NULLIF(%2:s,''''), IPPortNumber = %3:s' + #13#10 +
                           '  where SiteCode = %1:d and ServiceId = %0:d' + #13#10 +
                           'else' + #13#10 +
                           '  insert SiteServiceSettingsOverrides' + #13#10 +
                           '  select %0:d, %1:d, NULLIF(%2:s,''''), %3:s, ''http''',[SoapServerID, FSiteCode, QuotedStr(IPAddress), IPPort]);
        ExecSQL;
      end;
    end;
  end;

begin
  SaveSettings(edtLedgersServerIP.Text, edtLedgersServerIPPort.Text, 6);
  SaveSettings(edtBookingsServerIP.Text, edtBookingsServerIPPort.Text, 7);
end;

procedure TBaseEdit.edtLedgersServerIPExit(Sender: TObject);
begin
  ValidateIPAddress(edtLedgersServerIP.Text, Sender);
end;

procedure TBaseEdit.edtBookingsServerIPExit(Sender: TObject);
begin
  ValidateIPAddress(edtBookingsServerIP.Text, Sender);
end;

procedure TBaseEdit.edtLedgersServerIPPortKeyPress(Sender: TObject;
  var Key: Char);
begin
  ValidateIntegerKeyPress(Key);
end;

procedure TBaseEdit.edtBookingsServerIPPortKeyPress(Sender: TObject;
  var Key: Char);
begin
  ValidateIntegerKeyPress(Key);
end;

procedure TBaseEdit.edtLedgersServerIPPortExit(Sender: TObject);
begin
  ValidateIPPort(edtLedgersServerIPPort.Text, Sender);
end;

procedure TBaseEdit.edtBookingsServerIPPortExit(Sender: TObject);
begin
  ValidateIPPort(edtBookingsServerIPPort.Text, Sender);
end;

function TBaseEdit.VX670PrintStreamSetupOK(ShowError: Boolean): Boolean;
var
  PStreamName: String;
  tmpstr: String;
begin
  with dmThemeData.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select ps.Name as PSName, tep.name as PName, tep.PortNumber as PortNumber, ted.Name as TName');
    SQL.Add('from ThemeOutletStandardPrintConfigs topc');
    SQL.Add('join ThemeEposPrinterStream teps');
    SQL.Add('on topc.ReportPrintStream = teps.PrintStreamID and topc.SiteCode = teps.SiteCode');
    SQL.Add('join ThemeEposPrinter tep');
    SQL.Add('on tep.PrinterID = teps.PrinterID and tep.SiteCode = teps.SiteCode');
    SQL.Add('join ThemeEposDevice ted');
    SQL.Add('on ted.EPoSDeviceID = tep.EposDeviceID');
    SQL.Add('join ac_PrintStream ps');
    SQL.Add('on topc.ReportPrintStream = ps.Id');
    SQL.Add('where topc.SiteCode = ' + IntToStr(FSiteCode));
    SQL.Add('and tep.PrinterType in ' + uADO.BAD_REPORT_PRINTERS);
    Open;

    Result := RecordCount = 0;

    tmpstr := '';
    while not EOF do
    begin
      PStreamName := QuotedStr(StringReplace(FieldByName('PSName').AsString,'&','&&',[rfReplaceAll]));
      tmpstr := tmpstr + #13#10 + Format('''%s'' attached to ''%s''',[FieldByName('PName').AsString,FieldByName('TName').AsString]);
      if not FieldByName('PortNumber').IsNull then
        tmpstr := tmpstr + Format(' on port %d',[FieldByName('PortNumber').AsInteger]);
      Next;
    end
  end;

  if ShowError and not Result then
    MessageDlg(Format('''Report Print Group'' uses print stream %s which uses incompatible printers:'
              + #13#10 + tmpstr + #13#10 + #13#10 +
              'Either change the ''Report Print Group'' print stream or remove the printers from the print stream.',
              [PStreamName, tmpstr]),
              mtError,
              [mbOK],
              0);
end;

procedure TBaseEdit.PStreamGridMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  gridpos : TGridCoord;
begin
  gridpos := TwwdbGrid(Sender).MouseCoord(X,Y);
  if (gridpos.Y = 0) and (gridpos.X > TwwDbgrid(Sender).FixedCols - 1) then
     TwwdbGrid(Sender).Hint := TwwdbGrid(Sender).Columns[gridpos.X].DisplayLabel
  else
     TwwdbGrid(Sender).Hint := '';
end;

procedure TBaseEdit.ViewMobileOrderingTerminalClick(Sender: TObject);
var
  MoaDeviceID: integer;
begin
  MOADeviceID := TDeviceObject(tvServerDevices.Selected.Data).deviceID;
  TViewMOATerminal.ShowMOATerminal(MoaDeviceID, FSiteCode);
end;

procedure TBaseEdit.DBcbxPromotionSavingsOnBillClick(Sender: TObject);
begin
  LogDBCheckBoxClick(Sender as TDBCheckBox);
end;

procedure TBaseEdit.ValidateIntegerKeyPress(var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TBaseEdit.wwDBEditKMSPrimaryServerPortKeyPress(Sender: TObject;
  var Key: Char);
begin
  ValidateIntegerKeyPress(Key);
end;

procedure TBaseEdit.wwDBEditKMSBackupServerPortKeyPress(Sender: TObject;
  var Key: Char);
begin
  ValidateIntegerKeyPress(Key);
end;

procedure TBaseEdit.wwDBEditKMSPrimaryServerKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', #8, '.']) then
    Key := #0;
end;

procedure TBaseEdit.wwDBEditKMSBackupServerKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', #8, '.']) then
    Key := #0;
end;

procedure TBaseEdit.dbgPstreamsCellChanged(Sender: TObject);
begin
  //todo: handle this now we aren;ty using the inplace editor
  {if dbgPstreams.DataSource.dataset.FieldByName('ReadOnly').AsBoolean then
    dbgPstreams.Options := dbgPstreams.Options - [dgEditing]
  else
    dbgPstreams.Options := dbgPstreams.Options + [dgEditing];}
end;

procedure TBaseEdit.tabSheet_MiscShow(Sender: TObject);
begin
  with dmADO do
  begin
    dmThemeData.AccessDataset(qOutletConfigs);
    dmThemeData.AccessDataset(qOutletSuggestedTip);
  end;
end;


procedure TBaseEdit.tabSheet_MiscHide(Sender: TObject);
var
  errMessage: String;

  function WithinRange(var comp: TDBEdit; LowRange, HighRange: smallint; errText: string): Boolean;
  begin
    Result := ((StrToFloat(comp.Text) >= LowRange) and (StrToFloat(comp.Text) <= HighRange));
    if not Result then
    begin
      comp.SetFocus;
      errMessage := errText + ' must be in the range ' + IntToStr(LowRange) + ' to ' + IntToStr(HighRange);
    end;
  end;

begin
  if not WithinRange(dbEdPercentage1, 0, 99, 'Suggested tips') or
     not WithinRange(dbEdPercentage2, 0, 99, 'Suggested tips') or
     not WithinRange(dbEdPercentage3, 0, 99, 'Suggested tips') or
     not WithinRange(DBEditTipValidationPercentage, 0, 100, 'Tip Validation') or
     not WithinRange(DBEdit1, 0, 100, 'Card charge') or
     not WithinRange(DBEdit2, 0, 100, 'House tip out') then
  begin
    MessageDlg(errMessage, mtError, [mbOK], 0);
    Abort;
  end;

  if Sender = nil then exit;

  with dmADO do
  begin
    dmThemeData.DeAccessDataset(qOutletConfigs, true);
    dmThemeData.DeAccessDataset(qOutletSuggestedTip, true);
    DisableBaseDataIOrderTipSettingsIfRequired(FSiteCode);
  end;
end;

procedure TBaseEdit.SetSuggestedTipWarning;
begin
  lblSuggestedTipWarning.Visible :=
    ((TrimLeft(TrimRight(dbedText1.Text)) = '') and (dbedPercentage1.Text <> '0')) or
    ((TrimLeft(TrimRight(dbedText2.Text)) = '') and (dbedPercentage2.Text <> '0')) or
    ((TrimLeft(TrimRight(dbedText3.Text)) = '') and (dbedPercentage3.Text <> '0')) or
    ((TrimLeft(TrimRight(dbedText1.Text)) <> '') and (dbedPercentage1.Text = '0')) or
    ((TrimLeft(TrimRight(dbedText2.Text)) <> '') and (dbedPercentage2.Text = '0')) or
    ((TrimLeft(TrimRight(dbedText3.Text)) <> '') and (dbedPercentage3.Text = '0'));
end;

procedure TBaseEdit.dbSuggestedTipTextChange(Sender: TObject);
begin
  SetSuggestedTipWarning;
end;

procedure TBaseEdit.dbSuggestedTipPercentageChange(Sender: TObject);
begin
  if TwwDBEdit(sender).Text = '' then
    TwwDBEdit(sender).Text := '0';
  SetSuggestedTipWarning;
end;

procedure TBaseEdit.FakeContextMenuPopup(Sender: TObject);
begin
// do nothing, this is only here so that the context menu
// for dbSpinLeadingLines and dbSpinTrailingLines is not displayed
// when the user does a right-click in the control which allowed
// them to delete the value even though the EditorEnabled property
// is set to false, Thank you Woll2Woll!
end;

procedure TBaseEdit.pcPrintGroupSettingsChange(Sender: TObject);
begin
  PStreamSaveAggregate;
  TogglePrintTabFilterFilters;
end;

procedure TBaseEdit.dbgPStreams2CalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
var
  currps: integer;
begin
  if LowerCase(Field.FieldName) = 'optional' then
  begin
    ABrush.Color := clWindow;
    currps := twwdbgrid(sender).DataSource.DataSet.Fieldbyname('printstreamid').asinteger;
    if not(currps in [bill_ps, report_ps, eft_ps]) then// and (Twwdbgrid(sender).DataSource.DataSet.Fields.Count > 6)) then
      ABrush.Color := clBtnFace;
  end;
end;

procedure TBaseEdit.dbgPStreams2FieldChanged(Sender: TObject;
  Field: TField);
var
  i: integer;
  PrintersDefined: boolean;
  QualifiedPrinterName: String;
  TerminalName: String;
  PortNumber: String;
  PrinterName: String;
  PStreamID: String;
  PStreamName: String;
begin
  if (TwwDBGrid(sender).DataSource.DataSet.State = dsEdit)
    and (LowerCase(Field.FieldName) = 'optional')
    and (Field.NewValue = True) then
  begin
    PrintersDefined := False;
    for i := Field.Index+1 to Pred(TwwDBGrid(Sender).DataSource.DataSet.FieldCount-1) do
      if TwwDBGrid(Sender).DataSource.DataSet.Fields[i].DataType = ftBoolean then
        if TwwDBGrid(Sender).DataSource.DataSet.Fields[i].IsNull or TwwDBGrid(Sender).DataSource.DataSet.Fields[i].AsBoolean then
        begin
          PrintersDefined := True;
          Break;
        end;
    if not(PrintersDefined) then
      for i := Field.Index+1 to Pred(TwwDBGrid(Sender).DataSource.DataSet.FieldCount-1) do
        if TwwDBGrid(Sender).DataSource.DataSet.Fields[i].DataType = ftBoolean then
          TwwDBGrid(Sender).DataSource.DataSet.Fields[i].AsBoolean := True;
  end
  else if (TwwDBGrid(sender).DataSource.DataSet.State = dsEdit)
    and (LowerCase(Field.FieldName) <> 'optional')
    and (Field.NewValue = True) then
  begin
    //String chopping of the unique name generated for the cross-tab...
    QualifiedPrinterName := Field.FieldName;
    TerminalName := Copy(QualifiedPrinterName, 1, Pos(':',QualifiedPrinterName) - 1);
    Delete(QualifiedPrinterName,1,Pos(':',QualifiedPrinterName));
    PortNumber := Trim(Copy(QualifiedPrinterName,1,Pos('-',QualifiedPrinterName)-2));
    Delete(QualifiedPrinterName,1,Pos('-',QualifiedPrinterName)+1);
    PrinterName := QualifiedPrinterName;
    PStreamID := TwwDBGrid(Sender).DataSource.DataSet.FieldByName('printstreamid').AsString;
    PStreamName := QuotedStr(StringReplace(TwwDBGrid(Sender).DataSource.DataSet.FieldByName('PrintStreamName').AsString,'&','&&',[rfReplaceAll]));
    with dmThemeData.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select 1 as Disallowed from');
      SQL.Add('themeeposprinter tep');
      SQL.Add('join ThemeEposDevice ted');
      SQL.Add('on ted.EPoSDeviceID = tep.EposDeviceID');
      SQL.Add('where tep.SiteCode = ' + IntToStr(FSiteCode));
      if PortNumber <> '' then
        SQL.Add('and tep.PortNumber = ' + PortNumber);
      SQL.Add('and tep.Name = ' + QuotedStr(PrinterName));
      SQL.Add('and ted.Name = ' + QuotedStr(TerminalName));
      SQL.Add('and tep.Printertype in (10030,10031,10033)');
      SQL.Add('and (select ReportPrintStream from ThemeOutletStandardPrintConfigs where SiteCode = ' + IntToStr(FSiteCode) + ') = ' + PStreamID);
      Open;

      if RecordCount > 0 then
      begin
        MessageDlg(Format('''Report Print Group'' is assigned print stream %s and cannot print to this printer type.' +#13#10 +
                  'Either change the ''Report Print Group'' or assign this printer to another print stream.',
                  [PStreamName]),
                  mtError,
                  [mbOK],
                  0);
        Field.NewValue := false;
      end;
    end
  end;
end;

procedure TBaseEdit.tsPerTerminalPrintGroupSettingsHide(Sender: TObject);
begin
  pstreamsave;
  BuildAggregatePrintStreamView;
  if not VX670PrintStreamSetupOK(true) then abort;
end;

procedure TBaseEdit.tsGlobalPrintGroupSettingsHide(Sender: TObject);
begin
  PStreamSaveAggregate;
  if qEditPrintStreams.Active then
    qEditPrintStreams.Requery();
  dbgPStreams.OnRowChanged(dbgPstreams);
end;

procedure TBaseEdit.PStreamSaveAggregate;
begin
  if qEditPrintStreamsAggregate.Active then
  begin
    if qEditPrintStreamsAggregate.State in [dsEdit, dsInsert] then
      qEditPrintStreamsAggregate.post;
    qEditPrintStreamsAggregate.UpdateBatch;
    qSavePrintStreamsAggregate.Parameters.ParamByName('FilterID').Value := adoqThemeTerminalFilterTypeLookup.FieldByName('Id').Value;
    qSavePrintStreamsAggregate.ExecSQL;
  end;
end;

procedure TBaseEdit.BuildAggregatePrintStreamView;
begin
  qLoadprintStreamsAggregate.Parameters.ParamByName('FilterID').Value := adoqThemeTerminalFilterTypeLookup.FieldByName('Id').Value;
  qLoadPrintStreamsAggregate.ExecSQL;
  qEditPrintStreamsAggregate.DisableControls;
  if qEditPrintStreamsAggregate.active = false then
    qEditPrintStreamsAggregate.open
  else begin
    qEditPrintStreamsAggregate.Close;
    qEditPrintStreamsAggregate.Open;
  end;
  FormatPStreamTable2;
  qEditPrintStreamsAggregate.EnableControls;
end;

procedure TBaseEdit.PStreamGridDrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
const
   CtrlState: array[Boolean] of integer = (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED) ;
var
   fixrect: TRect;
   currps: Integer;
   ReadonlyRecord: Boolean;
   DrawFrameControlType: Integer;
   CheckboxWidth: Integer;
   CheckboxHeight: Integer;
begin
  FixRect := Rect;

  if TwwDbGrid(Sender).DataSource.DataSet.RecordCount = 0 then
  begin
    TwwDbGrid(Sender).Canvas.Brush.Color := clBtnFace;
    TwwDbGrid(Sender).Canvas.FillRect(FixRect);
    Exit;
  end;

  //The system metric produces a difference in GUI between WinXP/Win7 etc
  //so just use a sensible proportion of the row height.
  CheckboxWidth := Rect.Bottom - Rect.Top - 2; //GetSystemMetrics(SM_CYMENUCHECK);
  CheckboxHeight := CheckboxWidth; //GetSystemMetrics(SM_CXMENUCHECK);

  FixRect.Left := Rect.Left + (Rect.Right - Rect.Left - CheckboxWidth) div 2;
  FixRect.Top := Rect.Top + (Rect.Bottom - Rect.Top - CheckboxHeight) div 2;
  FixRect.Right := FixRect.Left + CheckboxWidth;
  FixRect.Bottom := FixRect.Top + CheckboxHeight;
  FixRect.Left := FixRect.Left + 1;
  FixRect.Top := FixRect.Top + 1;

  if (Field.DataType=ftBoolean) then
  begin
    (Sender as TwwDbGrid).Canvas.FillRect(Rect);

    currps := twwdbgrid(sender).DataSource.DataSet.Fieldbyname('printstreamid').asinteger;

    if (not(currps in [bill_ps, report_ps, eft_ps]) and (Lowercase(Field.FieldName) = 'optional')) then
      DrawFrameControlType := DFCS_BUTTONCHECK or DFCS_INACTIVE
    else if (VarIsNull(Field.Value)) then
      DrawFrameControlType := DFCS_BUTTONCHECK or DFCS_CHECKED or DFCS_BUTTON3STATE
    else
      DrawFrameControlType := CtrlState[Field.AsBoolean];

    ReadonlyRecord := False;
    if Assigned(twwdbgrid(sender).DataSource.DataSet.FindField('ReadOnly')) then
      ReadonlyRecord := TwwDBGrid(sender).DataSource.DataSet.FieldByName('ReadOnly').AsBoolean;

    if ReadonlyRecord then
      DrawFrameControlType := DrawFrameControlType or DFCS_INACTIVE;

    DrawFrameControl((Sender as TwwDbGrid).Canvas.Handle, FixRect, DFC_BUTTON, DrawFrameControlType);
  end;
end;

procedure TBaseEdit.PStreamGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  coord: TGridCoord;
  Field: TField;
begin
  //If we have no records then don't process the MouseDown: setting
  //Field.Dataset.Edit moves the Dataset.State to dsInsert and we
  //don't want to be inserting here.
  if (Sender as TwwDBGrid).DataSource.DataSet.RecordCount = 0 then Exit;

  coord := (Sender as TwwDBGrid).MouseCoord(X,Y);
  if (button = mbLeft) and (coord.X > (Sender as TwwDBGrid).FixedCols - 1) and (coord.Y >0) then
  begin
    (Sender as TwwDBGrid).SetActiveRow(coord.y -1);
    Field := (Sender as TwwDBGrid).Fields[coord.x];
    if not Field.ReadOnly then
    begin
      Field.DataSet.Edit;
      if Field.AsBoolean = True then
        Field.Value := False
      else
        Field.Value := True;
    end;
  end;
end;

procedure TBaseEdit.tsPerTerminalPrintGroupSettingsShow(Sender: TObject);
begin
  dbgPStreams.SetActiveRow(0);
  TogglePrintTabFilterFilters;
end;

procedure TBaseEdit.tsGlobalPrintGroupSettingsShow(Sender: TObject);
begin
  dbgPStreams2.SetActiveRow(0);
  TogglePrintTabFilterFilters;
end;

procedure TBaseEdit.TogglePrintTabFilterFilters;
  procedure TogglTerminalFilter(_Enabled: Boolean);
  begin
    lblFilterType.Enabled := _Enabled;
    cbxTerminalFilterTypeName.Enabled := _Enabled;
    if _Enabled then
      cbxTerminalFilterTypeName.Text := adoqThemeTerminalFilterTypeLookup.FieldByName('Value').Value
    else
      cbxTerminalFilterTypeName.Text := '';
  end;

  procedure ToggleSortByButtons(_Enabled: Boolean);
  begin
    btSortByTill.Enabled := _Enabled;
    btsortbystream.Enabled := _Enabled;
  end;
begin
  ToggleSortByButtons(pcPrintGroupSettings.ActivePage <> tsGlobalPrintGroupSettings);
  TogglTerminalFilter(pcPrintGroupSettings.ActivePage = tsGlobalPrintGroupSettings);
end;


procedure TBaseEdit.cbxTerminalFilterTypeNameChange(Sender: TObject);
var
  OldCur: TCursor;
begin
  if pcBaseData.ActivePage = tsPrintGroupGrid then
  begin
    OldCur := Screen.Cursor;
    try
      Screen.Cursor := crHourGlass;
      cbxTerminalFilterTypeName.Hint := adoqThemeTerminalFilterTypeLookup.FieldByName('Description').AsString;

      BuildAggregatePrintStreamView;
    finally
      Screen.Cursor := OldCur;
    end;
  end;
end;

procedure TBaseEdit.cbxTerminalFilterTypeNameBeforeDropDown(
  Sender: TObject);
var
  OldCur: TCursor;
begin
  if pcBaseData.ActivePage = tsPrintGroupGrid then
  begin
    OldCur := Screen.Cursor;
    try
      PStreamSaveAggregate;
    finally
      Screen.Cursor := OldCur;
    end;
  end;
end;

procedure TBaseEdit.PStreamGridKeyPress(Sender: TObject; var Key: Char);
var
  Field: TField;
begin
  if Key = Chr(VK_SPACE) then
  begin
    Field := (Sender as TwwDBGrid).GetActiveField;
    if not Field.ReadOnly then
    begin
      Field.DataSet.Edit;
      if Field.AsBoolean = True then
        Field.Value := False
      else
        Field.Value := True;
    end;
  end;
end;

procedure TBaseEdit.DBCheckBox13Click(Sender: TObject);
begin
  LogDBCheckBoxClick(Sender as TDBCheckBox);
  if (Sender as TDBCheckBox).Checked then
  begin
    dbchkbxLastTerminalOnly.Enabled := True;
    dbchkbxRestrictToSalesArea.Enabled := True;
  end
  else
  begin
    dbchkbxLastTerminalOnly.Enabled := False;
    dbchkbxRestrictToSalesArea.Enabled := False;
  end;
end;

procedure TBaseEdit.btnEditBillFooterClick(Sender: TObject);
var
  OldLoadSQL : TStringList;
  OldSaveSQL : TStringList;
begin
  with dmAdo do
  begin
    OldLoadSQL := TStringList.Create;
    OldSaveSQL := TStringList.Create;
    try
      qOutletBillFooter.Close;
      OldLoadSQL.Assign(qLoadOutletBillFooter.SQL);
      qLoadOutletBillFooter.SQL.Text :=
        StringReplace(qLoadOutletBillFooter.SQL.Text, ':siteCode', IntToStr(FSiteCode), [rfReplaceAll, rfIgnoreCase]);
      qLoadOutletBillFooter.ExecSQL;
      qOutletBillFooter.Open;
      if TEditOutletBillFooter.ShowOutletBillFooter(FSiteCode) then
      begin
        OldSaveSQL.Assign(qSaveOutletBillFooterData.SQL);
        qSaveOutletBillFooterData.SQL.Text :=
          StringReplace(qSaveOutletBillFooterData.SQL.Text, ':siteCode', IntToStr(FSiteCode), [rfReplaceAll, rfIgnoreCase]);
        qSaveOutletBillFooterData.ExecSQL;
        RefreshBillFooterMemoText;
        qSaveOutletBillFooterData.SQL.Assign(OldSaveSQL);
      end;
      qOutletBillFooter.Close;
      qLoadOutletBillFooter.SQL.Assign(OldLoadSQL);
    finally
      OldLoadSQL.Free;
      OldSaveSQL.Free;
    end;
  end;
end;

procedure TBaseEdit.RefreshBillFooterMemoText;
var
  billFooterString: String;
begin
  mmBillFooter.Lines.Clear;
  with dmAdo.qGetOutletBillFooterText do
  try
    Open;
    First;
    billFooterString := FieldByName('Text').asstring;
    Next;
    while not Eof do
    begin
      billFooterString := billFooterString + #13#10 + FieldByName('Text').asstring;
      Next;
    end;
  finally
    Close;
  end;
  mmBillFooter.Text := billFooterString;
end;

procedure TBaseEdit.UpdateIPToSerialMapperPortRange(StartPortNumber : Integer);
begin
  lblPortsUsedLabel.Caption := IntToStr(StartPortNumber) + ' - ' + IntToStr(StartPortNumber + 10);
end;

procedure TBaseEdit.DisableBaseDataIOrderTipSettingsIfRequired(siteId: Integer);
begin
  UpdateTipsTransferredToTipPoolSetting(siteId);
  UpdateDelayedOrderTipsAutoAssignedToUserServingSetting(siteId);
end;

procedure TBaseEdit.UpdateTipsTransferredToTipPoolSetting(siteId: Integer);
begin
  // Switch off the base data TipsTransferredToTipPool setting if 'Auto Payout Tips' is disabled
  // or auto pay out tips and its sub-config, On Clock Out are enabled.
  if not cbAutoPayoutTips.Checked or (cbAutoPayoutTips.Checked AND cbOnClockOut.Checked)then
    begin
      with dmADO.adoqRun do
      begin
        SQL.Text := Format('UPDATE ac_MoaSiteSettings '+
                           'SET TipsTransferredToTipPool = 0 '+
                           'WHERE SiteId = %d '+
                           'AND TipsTransferredToTipPool = 1', [siteId]);
        ExecSQL;
      end;
    end;
end;

procedure TBaseEdit.UpdateDelayedOrderTipsAutoAssignedToUserServingSetting(siteId: Integer);
begin
  // Switch off the base data "Delayed order tips auto-assigned to user serving"
  // setting if 'Auto Payout Tips' is disabled or auto pay out tips
  // and its sub-config, On Clock Out are enabled.
  if not cbAutoPayoutTips.Checked or (cbAutoPayoutTips.Checked AND cbOnClockOut.Checked)then
    begin
      with dmADO.adoqRun do
      begin
        SQL.Text := Format('UPDATE ac_SiteDelayedOrderSettings '+
                           'SET AutoAssignTipToServingUser = 0 '+
                           'WHERE SiteId = %d '+
                           'AND AutoAssignTipToServingUser = 1', [siteId]);
        ExecSQL;
      end;
    end;
end;

procedure TBaseEdit.dbedtIPToSerialMapperStartPortExit(Sender: TObject);
begin
  UpdateIPToSerialMapperPortRange(StrToInt(dbedtIPToSerialMapperStartPort.Text));
end;

procedure TBaseEdit.MemoBoxOnExit(Sender: TObject);
var
  i : Integer;
  MemoBox : TMemo;
  InputTruncated : Boolean;
begin
  MemoBox := TMemo(Sender);
  InputTruncated := FALSE;
  for i := 0 to MemoBox.Lines.Count - 1 do
  begin
    if Length(MemoBox.Lines[i]) > MAX_FOOTER_LINE_LENGTH then
    begin
      MemoBox.Lines[i] := Copy(MemoBox.Lines[i], 1, MAX_FOOTER_LINE_LENGTH);
      InputTruncated := TRUE;
    end;
  end;
  if InputTruncated then
    ShowMessage('The maximum length of each line of footer text is ' + IntToStr(MAX_FOOTER_LINE_LENGTH) +
         ' characters. Some lines have been truncated.');
end;

procedure TBaseEdit.cbReconfirmTipEntryClick(Sender: TObject);
begin
  LogDBCheckBoxClick(Sender as TDBCheckBox);

  DBEditTipValidationPercentage.Enabled := not cbReconfirmTipEntry.Checked;
  lblTipValidationPct.Enabled := DBEditTipValidationPercentage.Enabled;
end;


procedure TBaseEdit.cbReversePaymentDialogueClick(Sender: TObject);
begin
  LogDBCheckBoxClick(Sender as TDBCheckBox);
end;

procedure TBaseEdit.UpdateEftRecallSlipState();
begin
  // Update the checkbox UI states and set expected db values based on site version
  if dmThemeData.SiteVersionAtLeast('3.25.0.0') then
  begin
    TRadioButton(DBrgPrintEftVoucher.Controls[1]).Enabled := true;
  end
  else
  begin
    TRadioButton(DBrgPrintEftVoucher.Controls[1]).Enabled := False;
  end;
end;

procedure TBaseEdit.btnQRTestClick(Sender: TObject);
begin
  // vk test
  {*Log('Edit QR Code Text On Receipt button clicked');
  try
        dmADO.qCreateQrCodeOnReceiptTempTables.ExecSQL;
        dmAdo.TmpQrCodeOnReceiptHeaderText.Open;
        dmAdo.TmpQrCodeOnReceiptFooterText.Open;

        if TEditQrCodeOnReceiptText.ShowQrCodeOnReceiptTextFrm(FSiteCode) then
        begin
          dmADO.qSaveQrCodeOnReceiptText.Parameters.ParamByName('siteCode').Value := FSiteCode;
          dmADO.qSaveQrCodeOnReceiptText.ExecSQL;
        end;

  finally
  begin
        dmADO.qSaveQrCodeOnReceiptText.Close;
        dmADO.qCreateQrCodeOnReceiptTempTables.Close;
        dmAdo.TmpQrCodeOnReceiptHeaderText.Close;
        dmAdo.TmpQrCodeOnReceiptFooterText.Close;
  end;
  end; *}

end;

procedure TBaseEdit.btnConfigureQRCodeClick(Sender: TObject);
begin
  Log('Configure Footer QR Code button clicked');
  TConfigureFooterQRCode.ShowConfigureFooterQRCode(FSiteCode)

{

  Log('Edit QR Code Text On Receipt button clicked');

  try
        dmADO.qCreateQrCodeOnReceiptTempTables.ExecSQL;
        dmADO.qLoadQrCodeReceiptText.Parameters.ParamByName('SiteCode').Value := FSiteCode;
        dmADO.qLoadQrCodeReceiptText.ExecSQL;
        dmAdo.TmpQrCodeOnReceiptFooterText.Open;

        if TEditQrCodeOnReceiptText.ShowQrCodeOnReceiptTextFrm(FSiteCode) then
        begin
          dmADO.qSaveQrCodeOnReceiptText.Parameters.ParamByName('SiteCode').Value := FSiteCode;
          dmADO.qSaveQrCodeOnReceiptText.ExecSQL;
        end;

  finally
  begin
        dmADO.qSaveQrCodeOnReceiptText.Close;
        dmADO.qCreateQrCodeOnReceiptTempTables.Close;
        dmAdo.TmpQrCodeOnReceiptFooterText.Close;
  end;
  end;
}
end;

end.





