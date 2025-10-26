unit uUpdateTerminals;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ComCtrls, ImgList, ExtCtrls, adodb, uAztecDatabaseUtils, uWideStringUtils,
  DB, uXMLSave, uMutexControl, uAuditReadControl, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, uPosAesKeysService;

const
  AZTECDIR = 'zonal\aztec\';
  CACHE_XML_IN_MEMORY = FALSE;

  UPDATING_STATUS_MESSAGE = 'Processing';
  ADDENDUMBUFFERSIZE = 199999;

  WM_DOSEND = WM_USER + 1000;
  WM_EMPTYPOSSEND = WM_USER + 1001;

  WAIT_INTERVAL = 300000; //5 min
  CALL_INTERVAL = 10;

  MAX_RETRIES = 10;

//Added by Alank 03/03/08 - Update Conqueror
  ConqDll = 'zonal\aztec\QTImportExport.dll';

type
  ECannotSend = class(Exception);
  TTerminalState = (tsError, tsCheckingServer, tsGeneratingXML, tsParsingXML, tsSendingXML,
                    tsRollback, tsCheckingState, tsComplete);
  TTerminalSendStatus = (tssSucceeded, tssXMLGenerationFail, tssXMLParseFail, tssContactFailure, tssXMLSendFail);
  TEPOSStatus = (esParseNotDone, esParseFailed, esParseOK, esRevisionMismatch);
  TAddendumBuffer = array[0..ADDENDUMBUFFERSIZE] of widechar;

  TReloadConfigPhase = (rcp0, rcp1);

  TTerminalObj = class(TObject)
  protected
    FEposModel: widestring;
    FConn: TADOConnection;
    {Peter Phillips, PM264 ---->}
    FUsePartialThemeSend : boolean;
    function GetRequiresReset: boolean;
    {<---- Peter Phillips, PM264}
    procedure SetEposModel(const Value: widestring);
    function GetEposModel: widestring;
  private
    function  XMLModelCompatibleWith(otherTerminal: TTerminalObj): boolean;
    function GetGeneratedXML : Boolean;
  public
    XMLGenerated: boolean;
    EposDeviceID: integer;
    IPAddress: string;
    ServerIPAddress: string;
    ConfigSetID : integer;
    SiteCode: integer;
    ThemeID: integer;
    SalesAreaCode: integer;
    PanelDesignID:integer;
    HasDefaultPanel:boolean;
    PosCode: integer;
    PanelDesignType: integer;
    HardwareType: integer;
    TerminalName: string;
    State: TTerminalState;
    EPOSStatus: TEPOSStatus;
    SendStatus: TTerminalSendStatus;
    SkipParsing: boolean;
    MoaTerminal: boolean;
    SoloMode: boolean;
    {Peter Phillips, PM264 ---->}
    FAddendumBuffer : TAddendumBuffer;
    {<---- Peter Phillips, PM264}
    function GetModelRevsion: Integer;
    Function ResendRequiresReset : Boolean;
    procedure Reset;
    function ThemeHasMoaPayMethodButton(var MOAPayMethod: String): Boolean;

    property Conn: TADOConnection read FConn write FConn;
    property EposModel: widestring read GetEposModel write SetEposModel;
    property RequiresReset : boolean read GetRequiresReset;

    constructor Create(AEposDeviceID: integer; AIPAddress: string; AServerIPAddress: string;
      ASiteCode, AConfigSetID, AThemeID, APanelDesignID, APOSCode, ASalesAreaCode, APanelDesignType, AHardwareType: integer;
      ATerminalName: string; AState: TTerminalState; AEPOSStatus: TEPOSStatus;
      ASendStatus: TTerminalSendStatus; AMOATerminal, AHasDefaultPanel, ASoloMode: Boolean);
  end;

  TMOARemoteOrderingTerminalObj = Class(TTerminalObj)
    MainMOAEposDeviceID: integer;
    procedure CopyMoaXML(MainMOATerminal: TTerminalObj);
    constructor Create(AEposDeviceID: integer; AIPAddress: string; AServerIPAddress: string;
      ASiteCode, AConfigSetID, AThemeID, APanelDesignID, APOSCode, ASalesAreaCode, APanelDesignType, AHardwareType: integer;
      ATerminalName: string; AState: TTerminalState; AEPOSStatus: TEPOSStatus;
      ASendStatus: TTerminalSendStatus; AMOATerminal: Boolean; AHasDefaultPanel: boolean; AMainMOAEposDeviceID: integer; ASoloMode: Boolean);
  end;


  {Peter Phillips PM264. Base thread functionality refactored out to this class}
  TBaseThemeThread = class(TThread)
    Conn: TADOConnection;
    FStatusText: String;
    procedure Cancel; virtual; Abstract;
    procedure SetConn(Connection: TADOConnection); virtual;
    procedure UpdateState(CurrentTerminal: integer; State: TTerminalState);
  end;

  TUpdateThread = class(TBaseThemeThread)
  Private
    XMLOK, FailedToParse: boolean;
    XMLStreamAsync : TXMLStreamAsync;
    StartingRevision: Integer;
    XMLRevision: Integer;
    PosAesKeysService: TPosAesKeysService;
    Procedure UpdateTerminal(ATerminalID : integer);
    procedure GenerateXML(ATerminal : integer);
    procedure ParseEposModel(ATerminal : integer);
    procedure GetParseError(ATerminal : integer);
    procedure SendModel(ATerminalIndex : integer);
    procedure SendAesKey(TerminalId: integer);
    procedure CheckTerminals;
    function  AllTerminalsOKAfterSend: Boolean;
    procedure LogError(Text: string);
    procedure Log(Text: string);
    procedure UpdateEPOSStatus(CurrentTerminal: integer; AEPOSStatus: TEPOSStatus);
    procedure UpdateSendStatus(CurrentTerminal: integer; ASendStatus: TTerminalSendStatus);
    procedure RollbackTerminals;
    procedure RollbackTerminal(ATerminalID: Integer);
    procedure RollbackModel(ATerminalIndex : integer);
    function  DetermineStartingRevision: Integer;
    procedure PartialSendCallback(msg: String);
    procedure UpdateThemeSiteAutoSendToEPoS;
    procedure UpdateConqueror;
    procedure UpdateZCPS;
    procedure UpdateZcpsXmlConfiguration(XmlPath: string);
  public
    ResendRunning: boolean;
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
    procedure SetConn(Connection : TADOConnection); override;
    procedure Execute; override;
    procedure Cancel; Override;
    procedure ShowStatus;
    procedure SetXMLRevision(_XMLRevision: Integer);
    function  GetGeneratedXML(ATerminal : TTerminalObj):Boolean;
  end;

  {Peter Phillips, PM264. The following class performs a check to
   see if the terminal can accept a partial model}
  TTerminalCheckCompleteEvent = procedure (Sender   : TBaseThemeThread) of Object;
  TTerminalRequiresResetEvent = procedure (Terminal : TTerminalObj) of Object;

  TTerminalResetThread = Class(TBaseThemeThread)
  private
      FOnTerminalResetCheckComplete : TTerminalCheckCompleteEvent;
      FOnTerminalRequiresReset      : TTerminalRequiresResetEvent;
      FTerminalObj                  : TTerminalObj; // for resend selected functionallity

  public
      procedure Execute; override;
      procedure Cancel;  override;
      property  TerminalObj                  : TTerminalObj read FTerminalObj write FTerminalObj;
      property  OnTerminalResetCheckComplete : TTerminalCheckCompleteEvent read FOnTerminalResetCheckComplete
                                                                           write FOnTerminalResetCheckComplete;
      property  OnTerminalRequiresReset      : TTerminalRequiresResetEvent read FOnTerminalRequiresReset
                                                                           write FOnTerminalRequiresReset;
  end;

  TUpdateTerminals = class(TForm)
    ilTerminalTypes: TImageList;
    ilStateImages: TImageList;
    tmrUpdate: TTimer;
    pnlButtons: TPanel;
    btnPreview: TButton;
    btnReSendSelected: TButton;
    btnSend: TButton;
    btnClose: TButton;
    lbTerminals: TListView;
    mmErrors: TMemo;
    chk_allowreset: TCheckBox;
    IdHTTP1: TIdHTTP;
    procedure FormShow(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPreviewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnReSendSelectedClick(Sender: TObject);
    function UpdateXML(APosCode, ASiteCode : integer ; AXMLFile : String):WideString;
    procedure chk_allowresetClick(Sender: TObject);
    procedure lbTerminalsClick(Sender: TObject);
    procedure ThreadDone(Sender: TObject);
  private
    { Private declarations }
    FTicks: cardinal;
    AuditReaderPausedOk: boolean;
    AuditReaderControl: TAuditReadControl;
    SingleSelectedTerminal: TTerminalObj;
    SingleSelectedIndex: integer;
    UpdateThread: TUpdateThread;
    FUpdateRunning: boolean;
    XMLRevision: Integer;
    {Peter Phillips, PM264 ---->}
    FAllowTerminalReset : boolean;
    FTerminalsRequiringReset : TStringlist;
    AllResetChecksComplete : Boolean;
    FTerminalResetThread : TTerminalResetThread;
    FCancelled : Boolean;
    MoaRemoteOrderingTerminalsExist: Boolean;
    procedure TerminalRequiresReset(Terminal : TTerminalObj);
    procedure TerminalResetCheckComplete(Sender : TBaseThemeThread);
    procedure TerminalResetThreadTerminate(Sender : TObject);
    {<---- Peter Phillips, PM264}
    function PreSendChecksOk: Boolean;
    procedure DoPreview(aTerminalObject: TTerminalObj);
    procedure SetUpdateRunning(const Value: boolean);
    procedure AutoSend(var msg: TMessage); message WM_DOSEND;
    procedure SendThemeToEmptyPos(var msg: TMessage); message WM_EMPTYPOSSEND;
    function GenerateXMLRevision: Boolean;
    procedure BackupTerminalModels;
    procedure ArchiveModels(SearchPattern, DestinationFile: String);
    procedure SendAll;
    Function TerminalsRequireReset(Obj : TTerminalObj = nil) : Boolean;
    procedure ResetTerminalStates;
    function checkFileExclusive(filename : string) : boolean;
    procedure GetMOARemoteOrderingTerminals;
    procedure ReloadMOATerminals(Phase: TReloadConfigPhase);
    procedure UpdateZoeDataVersion;
    function MoaDevicesExist: Boolean;
    function MOAHostIsRunning: Boolean;
    procedure CloseSendToPosDatabaseEntry(ErrorCount: Integer);
    function GetLogonName: String;
 public
    { Public declarations }
    ErrorCount: integer;
    UpdateState_CurrentTerminal: integer;
    UpdateState_State: TTerminalState;
    LogText: string;
    ErrorText: string;
    SelectedServers: TStringList;
    programfiles : string;
    property Cancelled: boolean read FCancelled;
    property UpdateRunning: boolean read FUpdateRunning write SetUpdateRunning;
    procedure UpdateState;
    procedure Log;
    procedure LogError;
    procedure OnSendComplete;
    procedure OnSendInComplete;
    procedure RestoreTerminalModels;
    procedure ArchiveFailedModels;
    procedure SendTheme;
    procedure CancelSend;
//Added by Alank 03/03/08 - Update Conqueror

    procedure CancelManualSend(var Msg:TMessage);message WM_CANCELMANUALSEND;

  end;

//Added by Alank 03/03/08 - Update Conqueror
type
  TPluginLogFunction = procedure(text: string); stdcall;
// Dynamic Link
  TQTExport = procedure;stdcall;
// Static Link
//  procedure QTExport(LogFunction:TPEPluginLogFunction);stdcall;external ConqDll;


var
  UpdateTerminals: TUpdateTerminals;
  Terminals: array[0..255] of TTerminalObj;
  MOATerminals: array[0..255] of TMOARemoteOrderingTerminalObj;
  TerminalCount: integer;
  MOATerminalCount: integer;
  XMLTempDir: string;
  XMLBackupDir: string;
  XMLFailedDir: string;
  InDLL: boolean;
//Added by AK 05/02/08 - Allow multiple theme send
  DoingThemeAutoSend: Boolean;
  SendingThemeToEmptyPos: Boolean;
  TerminalIDForThemeAutoSend: Integer;
  PreventResetOnAutoSend: Boolean;

implementation

uses
  uDMThemeData, uAztecZoeComms, useful, uAztecLog, dADOAbstract, uXMLModify,
  msxml, AztecResourceStrings, SHFolder,uZip32,DateUtils, uSimpleLocalise, uEposDevice,
  uGenerateThemeIDs, TlHelp32, uPreviewManager, uADO;

{$R *.dfm}

//Added by Alank 03/03/08 - Update Conqueror
procedure LogFunction(text: string);stdcall;
begin
  UpdateTerminals.Logtext := text;
  UpdateTerminals.Log;
end;

procedure TUpdateTerminals.FormShow(Sender: TObject);
var
  i: integer;
  BaseDir: String;
  HardwareType_ : integer;
  terminalName : string;
  terminalItemsCount : integer;
  terminalTypesCount : integer;
begin
  Sleep(random(20));
  FTicks := GetTickCount();
  FAllowTerminalReset := chk_allowreset.checked;
  MoaRemoteOrderingTerminalsExist := FALSE;

  UpdateZoeDataVersion;

  uAztecLog.Log('Form Show ' + Caption);
  UpdateTerminals := Self;

  lbTerminals.Clear;

  with dmThemeData.adoqRun do
  begin
    BaseDir := AZTECDIR;
    XMLTempDir := programfiles + EnsureTrailingSlash(BaseDir) + 'EPoSModels\';
    XMLBackupDir := XMLTempDir + 'Backup\';
    XMLFailedDir := XMLTempDir + 'Failed\';
    ForceDirectories(XMLTempDir);
    ForceDirectories(XMLBackupDir);
    ForceDirectories(XMLFailedDir);

    SQL.Clear;
    SQL.Add('select a.Name, a.EposDeviceID, a.IPAddress, a.ConfigSetID, a.SiteCode, b.ThemeID, ' +
      'c.PanelDesignID, c.[DefaultPanelId], d.[Sales Area Code] as SalesAreaCode, a.PosCode, ' +
      'e.PanelDesignType, a.HardwareType, s.IPAddress as ServerIPAddress, a.MOATerminal, a.SoloMode');
    SQL.Add('from (select EposDeviceID, IPAddress from ThemeEposDevice where IsServer = 1) s,');
    SQL.Add('  (  ');
    SQL.Add('    select Name, EPoSDeviceID, IPAddress, ConfigSetID, SiteCode, POSCode, HardwareType, IsServer, ServerID, ');
    SQL.Add('        CAST(0 AS Bit) as MOATerminal, SoloMode');
    SQL.Add('    from ThemeEposDevice where HardwareType <> 10 ');
    SQL.Add('    union ');
    SQL.Add('    select ''MOA '' + sa.Name as Name, m.EposDeviceID, d.IPAddress, d.ConfigSetID, d.SiteCode, d.POSCode, d.HardwareType, ');
    SQL.Add('      d.IsServer, d.ServerID, CAST(1 AS Bit) AS MOATerminal, SoloMode');
    SQL.Add('    from ');
    SQL.Add('      (select MIN(d.EposDeviceID) as EposDeviceID, p.SalesAreaId ');
    SQL.Add('       from ThemeEposDevice d ');
    SQL.Add('         join ac_Pos p on p.Id = d.POSCode ');
    SQL.Add('       where d.HardwareType = 10 and d.IsServer = 0 ');
    SQL.Add('       group by p.SalesAreaId) m ');
    SQL.Add('     join ThemeEposDevice d on d.EPoSDeviceID = m.EposDeviceID ');
    SQL.Add('     join ac_SalesArea sa on sa.Id = m.SalesAreaId  ');
    SQL.Add('   ) a ');
    SQL.Add('join ThemeSites b on a.SiteCode = b.SiteCode ');
    SQL.Add('join ThemeEposDesign c on a.PosCode = c.PosCode ');
    SQL.Add('join Config d on a.PosCode = d.[Pos Code] and d.Deleted is null ');
    SQL.Add('join ThemePanelDesign e on c.PanelDesignID = e.PanelDesignID ');
    SQL.Add('where a.SiteCode = (select top 1 [Site Code] from SiteAztec)');
    SQL.Add('and a.IsServer = 0 and not (a.PosCode is null)');
    SQL.Add('and a.ServerID = s.EposDeviceID ');

    if not InDLL then
    begin
      SQL.Add('and a.ServerID in (');

      for i := 0 to SelectedServers.Count - 1 do
      begin
        if i = SelectedServers.Count - 1 then
          SQL.Add(SelectedServers[i] + ')')
        else
          SQL.Add(SelectedServers[i] + ',');
      end;
    end;
    SQL.Add('order by a.Name');

    Open;
    TerminalCount := RecordCount;

    if RecordCount = 0 then
    begin
      LogText := 'No terminals to update.';
      Log;
      mmErrors.Lines.Add('No terminals to update.');
      mmErrors.Visible := TRUE;
    end;

    btnPreview.Enabled := RecordCount > 0;
    btnSend.Enabled := RecordCount > 0;

    First;
    for i := 0 to pred(TerminalCount)do
    begin
      Terminals[i] :=
        TTerminalObj.Create(
        FieldByName('EposDeviceID').AsInteger, FieldByName('IPAddress').AsString,
        FieldByName('ServerIPAddress').AsString,
        FieldByName('SiteCode').AsInteger, FieldByName('ConfigSetID').AsInteger,
        FieldByName('ThemeID').AsInteger,
        FieldByName('PanelDesignID').AsInteger,
        FieldByName('PosCode').AsInteger,
        FieldByName('SalesAreaCode').AsInteger, FieldByName('PanelDesignType').AsInteger,
        FieldByName('HardwareType').AsInteger,
        FieldByName('Name').AsString,
        tsGeneratingXML,
        esParseNotDone,
        tssSucceeded,
        FieldByName('MOATerminal').AsBoolean,
        not(FieldByName('DefaultPanelId').IsNull), // HasDefaultPanel
        FieldByName('SoloMode').AsBoolean);

        if Terminals[i].MoaTerminal then
          MoaRemoteOrderingTerminalsExist := TRUE;

        lbTerminals.AddItem(FieldByName('Name').AsString, Terminals[i]);

      Next;
    end;

    Close;
  end;

 terminalItemsCount := lbTerminals.Items.Count;
 terminalTypesCount := ilTerminalTypes.Count;
  for i := 0 to pred(terminalItemsCount) do
  begin
     // for debug
     terminalName := TTerminalObj(lbTerminals.Items[i].Data).TerminalName;
     HardwareType_ :=  TTerminalObj(lbTerminals.Items[i].Data).HardwareType;
     if HardwareType_ >= 1000 then
      lbTerminals.Items[i].ImageIndex := terminalItemsCount //Last terminal image is the generic one
    else
      if (HardwareType_ < terminalTypesCount) then
         lbTerminals.Items[i].ImageIndex := HardwareType_
      else
         lbTerminals.Items[i].ImageIndex := terminalTypesCount - 1;
  end;

  // save array of hidden MOA terminals
  MOATerminalCount := 0;
  if MoaRemoteOrderingTerminalsExist then
    GetMOARemoteOrderingTerminals;

  //Start and stop virtual EPoS devices to match any new configuration.
  ReloadMOATerminals(rcp0);

  if (DoingThemeAutoSend or SendingThemeToEmptyPos) then
  begin
    //Autosends override the 'reset allowed checkbox'
    FAllowTerminalReset := not PreventResetOnAutoSend;
    chk_allowreset.checked := FAllowTerminalReset;
  end;

  if (DoingThemeAutoSend) then
  begin
    PostMessage(handle, WM_DOSEND, 0, 0);
    exit;
  end;

  if (SendingThemeToEmptyPos) then
  begin
    PostMessage(handle, WM_EMPTYPOSSEND, 0, 0);
    exit;
  end;
end;


procedure TUpdateTerminals.GetMOARemoteOrderingTerminals;
var
  i: Integer;
begin
  with dmThemeData.adoqRun do
  try
    Close;
    SQL.Text := 'select a.Name, a.EposDeviceID, a.IPAddress, a.ConfigSetID, a.SiteCode, b.ThemeID, c.PanelDesignID, c.DefaultPanelId, ' +
       'd.[Sales Area Code] as SalesAreaCode, a.PosCode, e.PanelDesignType, a.HardwareType, s.IPAddress as ServerIPAddress, ' +
       'a.MOATerminal, a.MainMOADeviceID, a.SoloMode ' +
       'from (select EposDeviceID, IPAddress from ThemeEposDevice where IsServer = 1) s,  ' +
       '  (   ' +
       '    select ''MOA'' as Name, d.EposDeviceID, d.IPAddress, d.ConfigSetID, d.SiteCode, d.POSCode, d.HardwareType,  ' +
       '      d.IsServer, d.ServerID, CAST(1 AS bit) AS MOATerminal, m.EposDeviceID as MainMOADeviceID, SoloMode  ' +
       '    from  ThemeEposDevice d  ' +
       '      join ac_Pos p on p.Id = d.POSCode  ' +
       '    join  ' +
       '      (select MIN(d.EposDeviceID) as EposDeviceID, p.SalesAreaId   ' +
       '       from ThemeEposDevice d   ' +
       '         join ac_Pos p on p.Id = d.POSCode   ' +
       '       where d.HardwareType = 10  ' +
       '       and d.IsServer = 0  ' +
       '       group by p.SalesAreaId) m on m.SalesAreaId = p.SalesAreaId  ' +
       '    where d.HardwareType = 10  ' +
       '      ) a  ' +
       '    join ThemeSites b on a.SiteCode = b.SiteCode  ' +
       '    join ThemeEposDesign c on a.PosCode = c.PosCode  ' +
       '    join Config d on a.PosCode = d.[Pos Code] and d.Deleted is null  ' +
       '    join ThemePanelDesign e on c.PanelDesignID = e.PanelDesignID  ' +
       'where a.SiteCode = (select top 1 [Site Code] from SiteAztec)  ' +
       'and a.IsServer = 0 and not (a.PosCode is null)  ' +
       'and a.ServerID = s.EposDeviceID ' ;

    if not InDLL then
    begin
      SQL.Add('and a.ServerID in (');

      for i := 0 to SelectedServers.Count - 1 do
      begin
        if i = SelectedServers.Count - 1 then
          SQL.Add(SelectedServers[i] + ')')
        else
          SQL.Add(SelectedServers[i] + ',');
      end;
    end;
    SQL.Add('order by a.Name');

    Open;
    MOATerminalCount := RecordCount;

    if RecordCount = 0 then
    begin
      LogText := 'No MOA terminals to update.';
      Log;
    end;

    First;
    for i := 0 to pred(MOATerminalCount)do
    begin
      MOATerminals[i] :=
        TMOARemoteOrderingTerminalObj.Create(
        FieldByName('EposDeviceID').AsInteger, FieldByName('IPAddress').AsString,
        FieldByName('ServerIPAddress').AsString,
        FieldByName('SiteCode').AsInteger, FieldByName('ConfigSetID').AsInteger,
        FieldByName('ThemeID').AsInteger,
        FieldByName('PanelDesignID').AsInteger, FieldByName('PosCode').AsInteger,
        FieldByName('SalesAreaCode').AsInteger, FieldByName('PanelDesignType').AsInteger,
        FieldByName('HardwareType').AsInteger,
        FieldByName('Name').AsString,
        tsGeneratingXML,
        esParseNotDone,
        tssSucceeded,
        FieldByName('MOATerminal').AsBoolean,
        FieldByName('DefaultPanelId').IsNull,
        FieldByName('MainMOADeviceID').AsInteger,
        FieldByName('SoloMode').AsBoolean);
      Next;
    end;
  finally
    Close;
  end;
end;

//The "p" parameter is for "phase", so "/reloadconfig?p=0" is phase 0 and "/reloadconfig?p=1" is phase 1.
//Phase 0: starts and stops virtual EPoS devices to match any new configuration.
//Phase 1: clears any cached values in the Site Proxy and sets the theme's LMDT to "now".
procedure TUpdateTerminals.ReloadMOATerminals(Phase: TReloadConfigPhase);
var
  dummyStrings: TStringList;
  dummyStream: TStringStream;
  URLString: String;
begin
  if MoaDevicesExist or MoaHostIsRunning then
  begin
    with dmThemeData.adoqRun do
    try
      Close;
      SQL.Text := 'DECLARE @SiteIPAddress VARCHAR(100)' + #13#10 +
                  'SELECT @SiteIPAddress = IPAddress FROM ThemeOutletConfigs WHERE SiteCode = dbo.fnGetSiteCode()' + #13#10 +
                  'SELECT ' +
                  '  CASE ISNULL(dbo.fn_GetConfigurationSetting(''MoaHostURL''),'''')' +
                  '    WHEN '''' THEN ''http://'' + @SiteIPAddress + '':50001/reloadconfig''' +
                  '    ELSE dbo.fn_GetConfigurationSetting(''MoaHostURL'')' +
                  '  END AS MoaHostURL ';
      Open;
      URLString := FieldByName('MoaHostURL').AsString;
      if Phase = rcp1 then
        URLString := URLString + '?p=1'
      else
        URLString := URLString + '?p=0';
    finally
      Close;
    end;

    // only need these to prevent 411 length error being returned by MOA_Host;
    dummyStream  := TStringStream.Create('');
    dummyStrings := TStringList.Create;
    dummyStrings.Add(' ');

    LogText := 'About to restart MOA Host.  Call to reload config: URL = ' + URLString;
    Log;
    LogText := '    ' + URLString;
    Log;
    try
      with IdHTTP1.Request do
      begin
        Username := 'ZonalRestart';
        Password := 'r3st4r7';
      end;
      try
        IdHTTP1.Post(URLString, dummyStrings, dummyStream);
        if (IdHTTP1.ResponseCode >= 200) and (IdHTTP1.ResponseCode <= 299) then
        begin
          LogText := 'Successfully called MOA_Host ReloadConfig';
          Log;
        end
        else
        begin
          ErrorText := 'There has been an error calling MOA_Host ReloadConfig: ' + IdHTTP1.ResponseText;
          LogError;
        end;
      except
        on e: Exception do
        begin
          ErrorText := 'Error calling MOA_Host ReloadConfig: ' + e.Message;
          LogError;
        end;
      end;
    finally
      dummyStream.Destroy;
      dummyStrings.Destroy;
    end;
  end;
end;

procedure TUpdateTerminals.UpdateZoeDataVersion;
var
  qry: TADOQuery;
  ZoeDataVersion: WideString;
begin
  // get the till data version (same data version applies to all tills)
  // and check it against the version saved in Aztec DB, update in DB
  // if different from actual ZoeDll data version
  if not uAztecZoeComms.GetDataVersion(ZoeDataVersion) then
    raise Exception.Create('Error getting till data version');

  qry := TADOQuery.Create(nil);
  qry.Connection := dmThemeData.AztecConn;
  try
    qry.SQL.Text :=
      ' DECLARE @ZoeDataVersion varchar(100), @KeyName varchar(20), @SiteCode int  ' +
      ' SET @ZoeDataVersion = ' + QuotedStr(ZoeDataVersion) +
      ' SET @KeyName = ''ZoeDataVersion'' ' +
      ' SET @SiteCode = dbo.fnGetSiteCode() ' +
      ' ' +
      ' IF EXISTS (SELECT StringValue FROM LocalConfiguration WHERE KeyName = @KeyName) ' +
      '   UPDATE LocalConfiguration ' +
      '     SET StringValue = @ZoeDataVersion, ' +
      '         Deleted = 0, ' +
      '         LMDT = GETDATE() ' +
      '   WHERE KeyName = @KeyName ' +
      ' ELSE ' +
      '   INSERT LocalConfiguration ' +
      '   VALUES(@SiteCode, @KeyName, @ZoeDataVersion, 0, GETDATE()) ';
    qry.execSQL;
    uAztecLog.Log('Till Data Version = ' + ZoeDataVersion);
  finally
    qry.free;
  end;
end;

{ TTerminalObj }

constructor TTerminalObj.Create(AEposDeviceID: integer; AIPAddress: string; AServerIPAddress: string;
  ASiteCode, AConfigSetID, AThemeID, APanelDesignID, APosCode, ASalesAreaCode, APanelDesignType, AHardwareType: integer;
  ATerminalName: string; AState: TTerminalState; AEPOSStatus: TEPOSStatus;
  ASendStatus: TTerminalSendStatus; AMOATerminal, AHasDefaultPanel, ASoloMode: Boolean);


begin
  inherited Create;

  EposDeviceID    := AEposDeviceID;
  IPAddress       := AIPAddress;
  ServerIPAddress := AServerIPAddress;
  SiteCode        := ASiteCode;
  ConfigSetID     := AConfigSetID;
  ThemeID         := AThemeID;
  PanelDesignID   := APanelDesignID;
  PosCode         := APosCode;
  SalesAreaCode   := ASalesAreaCode;
  PanelDesignType := APanelDesignType;
  HardwareType	  := AHardwareType;
  TerminalName    := ATerminalName;
  State           := AState;
  EPOSStatus      := AEPOSStatus;
  SendStatus      := ASendStatus;
  MOATerminal     := AMOATerminal;
  HasDefaultPanel := AHasDefaultPanel;
  SkipParsing     := False;
  SoloMode        := ASoloMode;

  FEposModel := '';

  Log('EposDeviceID    := ' + inttostr(AEposDeviceID));
  Log('IPAddress       := ' + AIPAddress);
  Log('ServerIPAddress := ' + AServerIPAddress);
  Log('SiteCode        := ' + inttostr(ASiteCode));
  Log('ConfigSetID     := ' + inttostr(AConfigSetID));
  Log('ThemeID         := ' + inttostr(AThemeID));
  Log('PanelDesignID   := ' + inttostr(APanelDesignID));
  Log('HasDefaultPanel := ' + booltostr(AHasDefaultPanel));
  Log('PosCode         := ' + inttostr(APosCode));
  Log('SalesAreaCode   := ' + inttostr(ASalesAreaCode));
  Log('PanelDesignType := ' + inttostr(APanelDesignType));
  Log('HardwareType    := ' + inttostr(AHardwareType));
  Log('TerminalName    := ' + ATerminalName);
end;

procedure TUpdateTerminals.updatestate;
var
  i, FoundIndex: integer;
begin
  // MOA: This only needs to be done for the Displayed MOA till
  if (UpdateState_State = tsSendingXML) then
    UpdateTerminals.btnClose.Enabled := false;

  FoundIndex := -1;
  for i := 0 to pred(lbTerminals.Items.Count) do
  begin
    if lbTerminals.Items[i].Data = Terminals[UpdateState_CurrentTerminal] then
      foundindex := i;
  end;
  if FoundIndex <> -1 then
    lbTerminals.Items[FoundIndex].StateIndex := ord(UpdateState_State);
end;

procedure Log(Text: string);
begin
  useful.TextLog(UpdateTerminals.getLogonName + ' - ' + Text, 'log\ThemeSend.log');
  useful.DoRipple(UpdateTerminals.programfiles + AztecDir + 'log\ThemeSend.log', 40960, 2);
end;

function TUpdateTerminals.PreSendChecksOk : Boolean;
var
  i: integer;
  ServersOK : Boolean;
  msgString: string;
  qryServerCheck: TADOQuery;
begin
   // TODO:  MOA - need to test this somehow
  Result := TRUE;

  qryServerCheck := TADOQuery.Create(nil);

  with qryServerCheck do
  try
    Connection := dmThemeData.AztecConn;
    SQL.Add('select * from ThemeEposDevice a');
    SQL.Add('where a.SiteCode = (select top 1 [Site Code] from SiteAztec) and (a.IsServer = 1)');
    SQL.Add('and a.EPosDeviceID in (');

    for i := 0 to SelectedServers.Count - 1 do
    begin
      if i = SelectedServers.Count - 1 then
        SQL.Add(SelectedServers[i] + ')')
      else
        SQL.Add(SelectedServers[i] + ',');
    end;

    // check all servers are up and running, and their IDs are configured correctly
    Open;

    ServersOK := TRUE;

    while not EOF do
    begin
      if not uAztecZoeComms.CheckServer(fieldbyname('ipaddress').asstring, fieldbyname('eposdeviceid').AsInteger) then
      begin
        ServersOK := FALSE;
        msgString := msgString + FieldByName('Name').AsString + '; '
      end;

      Next;
    end;

    Close;

    if not (InDLL or DoingThemeAutoSend or SendingThemeToEmptyPos) and not ServersOK then
      Result := MessageDlg('Could not connect to the following POS servers:' + #13#10#10 +
        msgString + '- check server status and configuration. Are you sure you want to continue?',
        mtError, [mbYes, mbNo], 0) = mrYes;

  finally
    FreeAndNil(qryServerCheck);
  end;
end;
{Peter Phillips, PM264 ---->}
procedure TUpdateTerminals.TerminalRequiresReset(Terminal : TTerminalObj);
begin
  // TODO: MOA - need to test this somehow
  FTerminalsRequiringReset.add(Terminal.TerminalName);
end;

procedure TUpdateTerminals.TerminalResetCheckComplete(Sender : TBaseThemeThread);
begin
     AllResetChecksComplete := true;
     sender.Terminate;
end;

procedure TUpdateTerminals.TerminalResetThreadTerminate(Sender : TObject);
begin

end;


{<---- Peter Phillips, PM264}



procedure TUpdateTerminals.btnSendClick(Sender: TObject);
begin
  SingleSelectedTerminal := nil;
  ButtonClicked(Sender);
  mmErrors.Visible := false;
  SendAll;
end;


function TUpdateTerminals.TerminalsRequireReset(Obj : TTerminalObj = nil) : Boolean;
begin
  AllResetChecksComplete := TerminalCount = 0;
  FTerminalsRequiringReset := TStringlist.create;
  UpdateRunning := TRUE;

  If Assigned(FTerminalResetThread) then
     FreeAndNil(FTerminalResetThread);

  FTerminalResetThread := TTerminalResetThread.Create(TRUE);
  FTerminalResetThread.TerminalObj := Obj;
  FTerminalResetThread.SetConn(dmThemeData.AztecConn);
  FTerminalResetThread.OnTerminalResetCheckComplete := TerminalResetCheckComplete;
  FTerminalResetThread.OnTerminalRequiresReset := TerminalRequiresReset;

  FTerminalResetThread.OnTerminate := TerminalResetThreadTerminate;
  FTerminalResetThread.Resume;

  while not FTerminalResetThread.Terminated do
  begin
      sleep(20);
      Application.ProcessMessages;
  end;
  sleep(20);
  FreeAndNil(FTerminalResetThread);
  result := FTerminalsRequiringReset.Count > 0;
end;

procedure TUpdateTerminals.ResetTerminalStates;
var
   i : Integer;
begin
     For i := 0 to Pred(TerminalCount) do
       lbTerminals.Items[i].StateIndex := -1;
end;


procedure TUpdateTerminals.SendAll;
var
   i : integer;
   msg : String;
   ContinueWithSend: Boolean;
   TmpCount: integer;
begin
  mmErrors.Lines.Clear;
  FCancelled := false;
  lbTerminals.ClearSelection;
  {Peter Phillips, PM264 ---->}

  if not checkFileExclusive(XMLBackupDir + '\modelarchive.zip') or
     not checkFileExclusive(XMLFailedDir + '\modelarchive_failed.zip') then
     exit;

  for i := 0 to Pred(TerminalCount) do
      if not checkFileExclusive(XMLTempDir + 'xml' + IntToStr(Terminals[i].EposDeviceID) + '.xml') then
         exit;

  // MOA: do the file check for all the hidden MOA terminals
  if MoaRemoteOrderingTerminalsExist then
  begin
    for i := 0 to Pred(MOATerminalCount) do
      if (MOATerminals[i].EposDeviceID <> MOATerminals[i].MainMOAEposDeviceID) then
        if not checkFileExclusive(XMLTempDir + 'xml' + IntToStr(MOATerminals[i].EposDeviceID) + '.xml') then
          Exit;
  end;

  if btnSend.Caption <> 'Resend All' then
  begin
    //Generate the new xml revision here.  This is necessary
    //because the routine to generate the addendum portion
    //will build full xml models on disk for later use.

    LogText := Format('Thread %d ready to start', [GetCurrentThreadId()]);
    Log();
    UpdateRunning := true;

    LogText := Format('Thread %d generating xml revision', [GetCurrentThreadId()]);
    Log();
    if not GenerateXMLRevision then
    begin
      UpdateRunning := False;
      raise Exception.Create('Unable to generate unique id for xml revision');
    end;
    For i := 0 to Pred(TerminalCount) do
    begin
      Terminals[i].Reset;
      if assigned(lbTerminals.Items[i]) then
        lbTerminals.Items[i].StateIndex := -1;
    end;

  end;

  if TerminalsRequireReset then
  begin
      If FCancelled then
      begin
             freeandnil(FTerminalsRequiringReset);
             ResetTerminalStates;
             UpdateRunning := False;
             exit;
      end;

      LogText := 'Terminals require reset';
      Log();

      if DoingThemeAutoSend or SendingThemeToEmptyPos then
        ContinueWithSend := FAllowTerminalReset
      else begin
        msg := 'The following terminal(s) could not be updated without resetting them:'#10#13#10#13+FTerminalsRequiringReset.Text+#10#13;
        msg := msg + 'Do you wish to continue and update all the terminals? ';
        msg := msg + 'This will cause a temporary stopping of the terminals requiring reset which may affect business.';
        ContinueWithSend := (FAllowTerminalReset) or (MessageDlg(msg, mtConfirmation,[mbYes, mbNo],0) = mrYes);
      end;

      if not ContinueWithSend then
      begin
         LogText := 'Aborting send because reset required';
         Log();

         UpdateRunning := FALSE;
         freeandnil(FTerminalsRequiringReset);

          For i := 0 to Pred(TerminalCount) do
            if assigned(lbTerminals.Items[i]) then
              lbTerminals.Items[i].StateIndex := -1;
          exit;
      end;
  end;

  freeandnil(FTerminalsRequiringReset);
 {<---- Peter Phillips, PM264}
  If FCancelled then
  begin
     ResetTerminalStates;
     UpdateRunning := False;
     exit;
  end;
  // How many terminals did not error at the  TerminalsRequireReset stage?
  TmpCount := 0;
  for i := 0 to Pred(TerminalCount) do
    if Terminals[i].State <> tsError then
       inc(TmpCount);

  UpdateTerminals.LogText := IntToStr(TmpCount) + ' Terminals did not generate errors - sending theme if > 0';
  UpdateTerminals.Log;
  if ((DoingThemeAutoSend or (btnSend.Caption = 'Send All')) and
    ((TmpCount > 0) and PreSendChecksOk)) or (btnSend.Caption = 'Resend All') then
  begin
    UpdateRunning := TRUE;
    SendTheme;
  end
  else
    UpdateRunning := FALSE;
end;

procedure TUpdateTerminals.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  if Assigned(UpdateThread) then
    FreeAndNil(UpdateThread);
  {Peter Phillips, PM264 ---->}
  if Assigned(FTerminalResetThread) then
    FreeAndNil(FTerminalResetThread);
  {<---- Peter Phillips, PM264}
  for i := 0 to pred(TerminalCount) do
  begin
    if Assigned(Terminals[i]) then
      Terminals[i].Free;
  end;

  for i := 0 to pred(MOATerminalCount) do
  begin
    if Assigned(MOATerminals[i]) then
      MOATerminals[i].Free;
  end;

  SelectedServers.Free;
  AuditReaderControl.Free;
end;

function TTerminalObj.GetEposModel: widestring;
begin
  try
    FEposModel := ReadWidestringFromFile(XMLTempDir + 'xml' + IntToStr(EposDeviceID) + '.xml');
  except
    FEposModel := '';
  end;
  Result := FEposModel;
end;

procedure TTerminalObj.Reset;
begin
  FEposModel := '';
  XMLGenerated := FALSE;
  State := tsGeneratingXML;
  SendStatus := tssSucceeded;
  EPOSStatus := esParseNotDone;
  if FileExists(XMLTempDir + 'xml' + IntToStr(EposDeviceID) + '.xml') then
    DeleteFile(XMLTempDir + 'xml' + IntToStr(EposDeviceID) + '.xml');
end;

// Returns true if the XML data model produced for otherTerminal will be suitable for use as a "base" model
// for creating the XML data model for this terminal.
function TTerminalObj.XMLModelCompatibleWith(otherTerminal: TTerminalObj): boolean;
begin
   result :=
      (SalesAreaCode   = otherTerminal.SalesAreaCode) and
      (ServerIPAddress = otherTerminal.ServerIPAddress) and
      (ConFigSetID     = otherTerminal.ConFigSetID) and
      (PanelDesignID   = otherTerminal.PanelDesignID) and
      (HasDefaultPanel = otherTerminal.HasDefaultPanel) and
      (ThemeID         = otherTerminal.ThemeID) and
      (HardwareType    = otherTerminal.HardwareType);
end;


{Peter Phillips, PM264 ---->}
function TTerminalObj.GetRequiresReset: boolean;
var
  SQLQuery: string;
  Buf : TAddendumBuffer;
  ErrorMessage, TmpError: string;
  i: integer;
begin
  //UpdateTerminals.LogText := 'Checking if terminal requires reset';
  //UpdateTerminals.Log;
  if not GetGeneratedXML then
  begin
    SQLQuery := format('theme_generateeposmodel %d, %d, %d, %d',
      [SiteCode, SalesAreaCode, PanelDesignID, PosCode] );
    //UpdateTerminals.LogText := 'executing "' + SQLQuery + '" from GetRequiresReset';
    //UpdateTerminals.Log;
    try
      EposModel := uXMLSave.GetXMLStream(Conn, SQLQuery);
    except on E:Exception do
      begin
        ErrorMessage := '';
        for i := 0 to pred(Conn.Errors.Count) do
        begin
          TmpError := Conn.Errors[i].Description;
          // Ignore normal status reports from the s.p. and SQL warnings
          if (Length(TmpError) > 0) and (Pos('Warning: ', TmpError) = 0)
            and (Pos(FormatDateTime('yyyy-mm-', now), TmpError) = 0) then
            begin
              if Length(ErrorMessage) > 0 then
                ErrorMessage := ErrorMessage + '; ';
              ErrorMessage := ErrorMessage + TmpError;
            end;
        end;
        raise Exception.Create('Error Executing command : '+ErrorMessage);
      end;
    end;
  end;
  // PW: Always update XML, this is slightly wasteful but the XML update
  // needs to be separated from GetGeneratedXML and the "resend" mode
  // should skip it.
  EposModel := UpdateTerminals.UpdateXML(PosCode,SiteCode,XMLTempDir + 'xml'+
    inttostr(EposdeviceID)+ '.xml');

  Fillchar(buf,ADDENDUMBUFFERSIZE,#0);
  Result := ModelRequiresTerminalReset(IPAddress, EposDeviceID, EposModel,AddendumBufferSize, @buf);
  FAddendumBuffer := buf;
  FUsePartialThemeSend := not (result);
end;

Function TTerminalObj.ResendRequiresReset : Boolean;
var
  Buf : TAddendumBuffer;
begin
  Fillchar(buf,ADDENDUMBUFFERSIZE,#0);
  result := ModelRequiresTerminalReset(IPAddress, EposDeviceID, EposModel,AddendumBufferSize, @buf);
  FAddendumBuffer := buf;
  FUsePartialThemeSend := not (result);
end;

procedure TTerminalObj.SetEposModel(const Value: widestring);
begin
  FEposModel := Value;
  WriteWidestringToFile(Value, XMLTempDir + 'xml' + IntToStr(EposDeviceID) + '.xml');
end;

{Peter Phillips, PM264 ---->}
function TTerminalObj.GetGeneratedXML : Boolean;
var
  i : integer;
begin
  Result := XMLGenerated;

  for i := 0 to pred(TerminalCount) do
  begin
    if (EposDeviceID <> Terminals[i].EposDeviceID) and XMLModelCompatibleWith(Terminals[i]) then
    begin
      if (FileExists(XMLTempDir + 'xml'+ inttostr(Terminals[i].EposDeviceID) +'.xml')) then
      begin
        uXMLModify.Open(XMLTempDir + 'xml'+ inttostr(Terminals[i].EposDeviceID) +'.xml');
        try
          if uXMLModify.NodesExist(Format('//EPoSModel/EPoSDevices/Terminal[@GUIDO=''%d'']', [EposDeviceID])) then
          begin
            EposModel := Terminals[i].EposModel;
            Result := TRUE;
            Break;
          end;
        finally
          uXMLModify.Close;
        end;
      end;
    end;
  end;
end;

function TTerminalObj.GetModelRevsion: Integer;
var
  dom: IXMLDOMDocument;
  Revision: OleVariant;
begin
  Revision := Null;

  dom := CoDOMDocument.Create;
  dom.loadXML(EposModel);
  if dom.parseError.errorCode = 0 then
  begin
    Revision := dom.documentElement.getAttribute('Revision');
  end;
  if not varIsNull(Revision) then
    Result := Revision
  else
    Result := 0;
end;

function TTerminalObj.ThemeHasMoaPayMethodButton(var MOAPayMethod: String): Boolean;
var
  qry: TADOQuery;
begin
  MOAPayMethod := '';
  qry := TADOQuery.Create(nil);

  with qry do
  try
    Connection := Conn;

    //The below query has been shown to run exceptionally slowly on some datasets
    //and thus we push the timeout out to allow completion (default is 30s).
    CommandTimeout := 150;

    SQL.Text :=
      'DECLARE @MOAPaymentId smallint, @MOAPayMethod varchar(12) ' +
      ' ' +
      'SELECT @MOAPaymentId = ISNULL(c.KioskPaymentMethod, -1) ' +
      'FROM ThemeGlobalConfigs c ' +
      ' ' +
      'IF @MOAPaymentId = -1 ' +
      '  SELECT CAST(0 AS bit) AS TheResult, '''' AS MOAPaymethod ' +
      'ELSE ' +
      '  IF EXISTS ' +
      '  ( ' +
      '    SELECT * ' +
      '    FROM ' +
      '      ThemePanelButton b ' +
      '        INNER JOIN ' +
      '      ThemePanel p ON p.PanelID = b.PanelID ' +
      '        INNER JOIN ' +
      '      ThemeEposDesign d ON d.PanelDesignID = p.PanelDesignID ' +
      '    WHERE d.POSCode =  ' + IntToStr(PosCode) +
      '      AND b.ButtonTypeChoiceID = 6 ' +
      '      AND b.ButtonTypeChoiceAttr01 = @MOAPaymentId ' +
      '  ) ' +
      '    SELECT CAST(1 AS bit) AS TheResult, Name as MOAPayMethod ' +
      '    FROM ac_PaymentMethod ' +
      '    WHERE Id = @MOAPaymentId ' +
      '  ELSE ' +
      '    SELECT CAST(0 AS bit) AS TheResult, '''' as MOAPaymethod ';

    try
      Open;
      Result := FieldByName('TheResult').AsBoolean;
      MOAPayMethod := FieldByName('MOAPaymethod').AsString;
    except
      on E: Exception do
      begin
        Result := TRUE;
        raise;
      end;
    end;
  finally
    Close;
    FreeAndNil(qry);
  end;
end;


{ TBaseThemeThread }
procedure TBaseThemeThread.UpdateState(CurrentTerminal: integer; State: TTerminalState);
begin
  //Don't throw the exception if tsError is the state we are moving to - tsError
  //state is being set in exception handlers.
  if Terminated and not (State = tsError) then
    raise Exception.Create('Terminated');

  Terminals[CurrentTerminal].State := State;
  UpdateTerminals.UpdateState_CurrentTerminal := CurrentTerminal;
  UpdateTerminals.UpdateState_State := State;

  if not InDLL then
    Synchronize(UpdateTerminals.UpdateState);
end;

procedure TBaseThemeThread.SetConn(Connection : TADOConnection);
begin
    Conn := TADOConnection.Create(nil);
    SetUpAztecADOConnection(Conn);
end;

function TerminalIndex(Obj : TTerminalObj) : Integer;
var
   i : integer;
begin
     for i := 0 to pred(TerminalCount)do
     begin
         if Terminals[i] = Obj then
         begin
             result := i;
             exit;
         end;
     end;
     result := -1;
end;

{ TTerminalResetThread }
procedure TTerminalResetThread.Execute;
var
   i, j : Integer;
begin
  if not assigned(FTerminalObj) then
  // performing a full send to pos
  begin
    For i := 0 to Pred(TerminalCount) do
    begin
      if Terminated then Exit;

      Terminals[i].Conn := Conn;
      try
        UpdateState(i,tsGeneratingXML);
        if Terminals[i].RequiresReset then
        begin
          //UpdateTerminals.LogText := 'Attempting to reset terminal' + IntToStr(i);
          //Synchronize(UpdateTerminals.Log);
          if Assigned(FOnTerminalRequiresReset) then
            FOnTerminalRequiresReset(Terminals[i]);

          // MOA: Ensure that RequiresReset is set for all the hidden MOA terminals
          if Terminals[i].MoaTerminal then
            for j := 0 to pred(MOATerminalCount) do
            begin
              if (MOATerminals[j].MainMOAEposDeviceID = Terminals[i].EposDeviceID)
              and (MOATerminals[j].EposDeviceID <> MOATerminals[j].MainMOAEposDeviceID) then
                if Assigned(FOnTerminalRequiresReset) then
                  FOnTerminalRequiresReset(MOATerminals[j]);
            end;
        end;
      (*except
        UpdateState(i, tsError);
      end; *)
      except on E: Exception do
        begin
          UpdateTerminals.ErrorText := Terminals[i].TerminalName + ' : '+ E.Message;
          synchronize(UpdateTerminals.LogError);
          Sleep(20);
          UpdateState(i, tsError);
          Terminals[i].SendStatus := tssXMLSendFail;
        end;
      end;
    end;
  end
  else
  begin
  // performing a resend selected on a single terminal
    //if FTerminalObj.FAddendumBuffer = '' then
    FTerminalObj.Conn := Conn;
    try
      UpdateState(TerminalIndex(FTerminalObj),tsGeneratingXML);
      If FTerminalObj.ResendRequiresReset then
      begin
        if Assigned(FOnTerminalRequiresReset) then
          FOnTerminalRequiresReset(FTerminalObj);

        if FTerminalObj.MoaTerminal then
          for j := 0 to pred(MOATerminalCount) do
          begin
            if (MOATerminals[j].MainMOAEposDeviceID = FTerminalObj.EposDeviceID)
            and (MOATerminals[j].EposDeviceID <> MOATerminals[j].MainMOAEposDeviceID) then
              if Assigned(FOnTerminalRequiresReset) then
                FOnTerminalRequiresReset(MOATerminals[j]);
          end;
      end
      else
        if (FTerminalObj.FAddendumBuffer = '') then
          UpdateState(TerminalIndex(FTerminalObj),tsCheckingState);
    except on E: Exception do
      begin
        UpdateTerminals.ErrorText := FTerminalObj.TerminalName + ' : '+ E.Message;
        synchronize(UpdateTerminals.LogError);
        Sleep(20);
        UpdateState(TerminalIndex(FTerminalObj), tsError);
        FTerminalObj.SendStatus := tssXMLSendFail;
      end;
    end;
  end;
  if Assigned(FOnTerminalResetCheckComplete) then
     FOnTerminalResetCheckComplete(self);
end;

procedure TTerminalResetThread.Cancel;
begin
  UpdateTerminals.FCancelled := true;
  self.OnTerminate := UpdateTerminals.ThreadDone;
  Terminate;
end;

{<---- Peter Phillips, PM264}

{ TUpdateThread }

constructor TUpdateThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  PosAesKeysService := TPosAesKeysService.Create(nil);
end;

destructor TUpdateThread.Destroy;
begin
  FreeAndNil(PosAesKeysService);
  inherited Destroy;
end;

procedure TUpdateThread.SetConn(Connection: TADOConnection);
begin
  inherited SetConn(Connection);
  PosAesKeysService.Initialise(Conn, Log);
end;

procedure TUpdateThread.UpdateTerminal(ATerminalID: integer);
begin
  if not (Terminals[ATerminalID].State in [tsError, tsCheckingState]) then
  begin
    UpdateState(ATerminalID,tsCheckingServer);
    XMLOK := FALSE;

    if Terminated then
      Exit;

    ParseEposModel(ATerminalID);

    if Terminated then
      Exit;

    FailedToParse := FALSE;

    GetParseError(ATerminalID);

    XMLOK := TRUE;
  end;

  // MOA: the hidden MOA terminals are dealt with in SendModel
  if Terminals[ATerminalID].State < tsCheckingState then
  begin
    SendModel(ATerminalID);
  end;
  // Real Check of terminal parse status not performed for resend selected
  if Terminals[ATerminalID].State = tsCheckingState then
    UpdateState(ATerminalID, tsComplete);
//  CheckTerminals;
end;

procedure TUpdateThread.Execute;
var
  i, j: integer;
begin
  try
    XMLOK := FALSE;
    XMLStreamAsync := TXMLStreamAsync.Create;
    try
      // build list of terminals
      // parse and generate model for all terminals
      // send model to each terminal
      conn.Open;
      if Assigned(UpdateTerminals.SingleSelectedTerminal) then
      begin
        i := UpdateTerminals.SingleSelectedIndex;
        // MOA: the hidden MOA terminals will be dealt with in SendModel which is called by UpdateTerminal
        UpdateTerminal(i);
      end
      else
      begin
        //Check the revision of the models on the terminals
        StartingRevision := DetermineStartingRevision;

        for i := 0 to pred(TerminalCount) do
          if not (Terminals[i].State = tsError) then
          begin
            GenerateXML(i);
            // MOA : ensure that all the hidden MOA terminals get the updated model
            if Terminals[i].MoaTerminal then
              for j := 0 to pred(MOATerminalCount) do
              begin
                if (MOATerminals[j].MainMOAEposDeviceID = Terminals[i].EposDeviceID)
                and (MOATerminals[j].EposDeviceID <> MOATerminals[j].MainMOAEposDeviceID) then
                  MOATerminals[j].CopyMoaXML(Terminals[i]);
              end;
          end;

        if Terminated then
          Exit;

         // MOA TODO:  need to do the same for the MOA terminals
         // or do we, maybe it's enough to parse the main MOA terminal
         // - it is enough but should be tested
        for i := 0 to pred(TerminalCount) do
           if not (Terminals[i].State = tsError) then
             ParseEposModel(i);

        if Terminated then
          Exit;

        // MOA: the parse result only needs to be checked for the displayed MOA terminal
        for i := 0 to pred(TerminalCount) do
          if not Terminals[i].FUsePartialThemeSend and
            not (Terminals[i].State = tsError) then
            GetParseError(i);

        XMLOK := TRUE;

        // MOA:  the hidden MOA terminals are dealt with in SendModel
        for i := 0 to pred(TerminalCount) do
          if not (Terminals[i].State = tsError) then
            SendModel(i);

        CheckTerminals;
      end;

    finally
      //Only do the OnSendComplete and hence stock map update
      //if all the terminals have been updated successfully
      //Previously we would update the stock map irrespective
      //of how many terminals actually processed their files
      if AllTerminalsOKAfterSend then
      begin
        if not ResendRunning then
        begin
          if not Terminated then
            UpdateThemeSiteAutoSendToEPoS;
          if not Terminated then
            UpdateConqueror;
          if not Terminated then
            UpdateZCPS;
        end
        else
          ResendRunning := false;

        if InDLL then
          UpdateTerminals.OnSendComplete
        else
          Synchronize(UpdateTerminals.OnSendComplete);
      end
      else begin
        if InDLL then
          UpdateTerminals.RestoreTerminalModels
        else
          Synchronize(UpdateTerminals.RestoreTerminalModels);

        RollbackTerminals;

        if not ResendRunning then
        begin
          if not Terminated then
            UpdateZCPS;
        end
        else
          ResendRunning := false;

        if InDLL then
          UpdateTerminals.OnSendIncomplete
        else
          Synchronize(UpdateTerminals.OnSendInComplete);
      end;

      Conn.Close;
      FreeAndNil(Conn);
      XMLStreamAsync.Free;
    end;
  except on E: Exception do
    begin
      try
        Log('Error while generating XML: ' + E.Message);
        LogError('Error while generating XML: ' + E.Message);
      except
      end;
    end;
  end;
end;

procedure TUpdateThread.UpdateZcpsXmlConfiguration(XmlPath: string);
  function BoolToLowerStr(input: boolean):string;
  begin
    if input then
      result := 'true'
    else
      result := 'false';
  end;
var
  Aztec_MaskRetailerPan: boolean;
  Aztec_MaskRetailerExpiry: boolean;
  Aztec_FastPayThreshold: integer;
  qry: TAdoQuery;
  XmlDoc, XmlDocOriginal:IXMLDOMDocument;
  TmpNode: IXmlDomNode;
begin
  qry := TADOQuery.Create(nil);
  qry.Connection := dmThemeData.AztecConn;
  try
    qry.SQL.Text :=
'declare @SiteCode int '+
'set @SiteCode = dbo.fnGetSiteCode() '+
'declare @UseFastEFT bit '+
'select @UseFastEFT = case COUNT(*) when 0 then 0 else 1 end  from ThemeEposDevice a '+
'join ThemeConfigSet b on a.ConfigSetID = b.ConfigSetID '+
'where a.SiteCode = @SiteCode and a.IsServer = 0 and b.UseFastEFT = 1 '+
'declare @MaskRetailerExpiry bit '+
'declare @MaskRetailerPan bit '+
'select @MaskRetailerExpiry = case varstring when ''UK'' then 0 else 1 end from genervar where varname = ''ukusmode'' '+
'select @MaskRetailerPan = case coalesce(b.StringValue, c.StringValue) when ''1'' then 1 else 0 end '+
'    from (select ''MaskRetailerPAN'' as KeyName) a '+
'    left outer join LocalConfiguration b on b.SiteCode = @SiteCode and b.Deleted = 0 and b.KeyName = a.KeyName '+
'    left outer join GlobalConfiguration c on a.KeyName = c.KeyName '+
'select @MaskRetailerExpiry as MaskRetailerExpiry, @MaskRetailerPan as MaskRetailerPan, '+
'    (select cast(@UseFastEFT * 100 * FastEFTAmount as Int) from ThemeOutletConfigs where SiteCode = @SiteCode) as FastPayThreshold';

    qry.Open;
    Aztec_MaskRetailerPan := qry.FieldByName('MaskRetailerPan').AsBoolean;
    Aztec_MaskRetailerExpiry := qry.FieldByName('MaskRetailerExpiry').AsBoolean;
    Aztec_FastPayThreshold := qry.FieldByName('FastPayThreshold').AsInteger;
    qry.Close;
  finally
    qry.free;
  end;
  XmlDoc := CoDOMDocument.Create;
  XmlDoc.load(XmlPath);
  XmlDocOriginal := CoDOMDocument.Create;
  XmlDocOriginal.loadXML(XmlDoc.xml);

  TmpNode := XmlDoc.selectSingleNode('ZcpsConfiguration/Sections/Section[@name=''ZcpsCommon'']/SectionItem[@key=''MaskRetailerPan'']');
  if Assigned(TmpNode) then
    TmpNode.attributes.getNamedItem('value').text := BoolToLowerStr(Aztec_MaskRetailerPan);

  TmpNode := XmlDoc.selectSingleNode('ZcpsConfiguration/Sections/Section[@name=''ZcpsCommon'']/SectionItem[@key=''MaskRetailerExpiry'']');
  if Assigned(TmpNode) then
    TmpNode.attributes.getNamedItem('value').text := BoolToLowerStr(Aztec_MaskRetailerExpiry);

  TmpNode := XmlDoc.selectSingleNode('ZcpsConfiguration/Sections/Section[@name=''ZcpsCommon'']/SectionItem[@key=''FastPayThreshold'']');
  if Assigned(TmpNode) then
    TmpNode.attributes.getNamedItem('value').text := IntToStr(Aztec_FastPayThreshold);

  if (XmlDoc.xml <> XmlDocOriginal.xml) then
    XmlDoc.save(XmlPath);
end;

procedure TUpdateThread.UpdateZCPS;
  function IsWOW64: Boolean;
  type
    TIsWow64Process = function(
      Handle: THandle;
      var Res: BOOL
    ): BOOL; stdcall;
  var
    IsWow64Result: BOOL;
    IsWow64Process: TIsWow64Process;
  begin
    IsWow64Process := GetProcAddress(
      GetModuleHandle('kernel32'), 'IsWow64Process'
    );
    if Assigned(IsWow64Process) then
    begin
      if not IsWow64Process(GetCurrentProcess, IsWow64Result) then
        raise Exception.Create('Bad process handle');
      Result := IsWow64Result;
    end
    else
      Result := False;
  end;
var
  ZcpsProgramSearchFolders: TStrings;
  ZcpsDataSearchFolders: TStrings;
  FoundFiles: TStrings;
  PluginFolders: TStrings;
  TempConfigPlugin: string;
  i: integer;
  PluginBaseName: string;
  AztecDatabaseMachine, AztecDatabase: string;
begin
  if IsSite then
  begin
    // Update ATS configurations if Aztec and ATS installed on the same pc.
    GetAztecDatabaseParameters(AztecDatabaseMachine, AztecDatabase);
    ZcpsProgramSearchFolders := TStringList.Create;
    ZcpsDataSearchFolders := TStringList.Create;
    FoundFiles := TStringList.Create;
    PluginFolders := TStringList.Create;

    ZcpsProgramSearchFolders.Add(GetEnvironmentVariable('ProgramFiles'));
    if IsWOW64 then
      ZcpsProgramSearchFolders.Add(GetEnvironmentVariable('ProgramW6432'));
    useful.FindFiles(useful.EnsureTrailingSlash(GetEnvironmentVariable('Allusersprofile')) + 'Zonal\ZCPS', ffstLimitToDirs, ZcpsDataSearchFolders);
    // Search for ATS plugin configuration utility and run it
    for i := 0 to ZcpsProgramSearchFolders.Count-1 do
    begin
      useful.FindFiles(useful.EnsureTrailingSlash(ZcpsProgramSearchFolders[i]) +  'Zonal\ZCPS\Plugins\*' , ffstLimitToDirs, PluginFolders);
      useful.FindFiles(useful.EnsureTrailingSlash(ZcpsProgramSearchFolders[i]) +  'Zonal\ZCPS' , ffstLimitToDirs, PluginFolders);
      useful.FindFiles(useful.EnsureTrailingSlash(ZcpsProgramSearchFolders[i]) +  'Zonal\ZCPS' , ffstLimitToDirs, ZcpsDataSearchFolders);
    end;

    // Give precedence to the ATS configuration plugin
    for i := 0 to pred(PluginFolders.Count) do
    begin
      TempConfigPlugin := useful.EnsureTrailingSlash(PluginFolders[i]) + 'AtsConfiguration.exe';
      if FileExists(TempConfigPlugin) then
        FoundFiles.Add(TempConfigPlugin);
    end;

    for i := 0 to pred(PluginFolders.Count) do
    begin
      PluginBaseName := ExtractFileName(Extractfilebasename(PluginFolders[i]));
      if (LowerCase(PluginBaseName) = 'paywarepc') then
        continue;
      TempConfigPlugin := useful.EnsureTrailingSlash(PluginFolders[i]) + PluginBaseName + 'Configuration.exe';
      if FileExists(TempConfigPlugin) then
        FoundFiles.Add(TempConfigPlugin);
    end;

    // Run the first found configuration plugin
    if FoundFiles.Count > 0 then
    begin
      Log('Running ZCPS configuration update');
      useful.ExecuteBatchFileAndWait(foundfiles[0],
        Format('/AztecDatabaseMachine "%s" /AztecDatabase "%s"', [AztecDatabaseMachine, AztecDatabase]),
        ExtractFileDir(foundfiles[0]), SW_HIDE);
      Log('ZCPS configuration update successful');
    end;

    // Search for ZCPS XML configuration file and update it
    FoundFiles.Clear;
    for i := 0 to ZcpsDataSearchFolders.Count-1 do
      useful.FindFiles(useful.EnsureTrailingSlash(ZcpsDataSearchFolders[i]) + 'ZcpsConfiguration.xml', ffstNameMatch, FoundFiles);
    if FoundFiles.Count > 0 then
    begin
      UpdateZcpsXmlConfiguration(FoundFiles[0]);
    end;

    ZcpsProgramSearchFolders.Free;
    ZcpsDataSearchFolders.Free;
    FoundFiles.Free;
    PluginFolders.Free;
  end;
end;

//Added by Alank 03/03/08 - Update Conqueror
procedure TUpdateThread.UpdateConqueror;
var
  ConqInst:HWND;
  QTExport:TQTExport;
begin
  ConqInst := 0;
  with TADOQuery.Create(nil) do
  try
    Connection := dmThemeData.AztecConn;
    SQL.Clear;
    SQL.Append('select * from ThemeEposDevice_Repl ');
    SQL.Append('where HardwareType = 5 and Deleted = 0 and IsServer = 0');
    Open;
    if RecordCount > 0 then
    begin
      Log('Conqueror Tills found - Starting Update');
      if FileExists(updateterminals.programfiles + ConqDll) then
      begin
        Log('Found Conqueror Plugin - Loading..');
        ConqInst := LoadLibrary(PChar(updateterminals.programfiles + ConqDll));
        if ConqInst <> 0 then
        begin
          @QTExport := GetProcAddress(ConqInst,'QTExport');
          Log('Plugin Loaded - Calling QTExport');
          QTExport;
        end
        else
        begin
          Log('Could not load Conqueror Plugin! - Update Failed');
        end
      end
      else
      begin
        Log('Could not find Conqueror Plugin - Update Failed');
      end;
    end
    else
    begin
      Log('No Conqueror Terminals Found in Database.');
    end
  finally
    if ConqInst <> 0 then
      FreeLibrary(ConqInst);
    Free;
  end;
end;

procedure TUpdateTerminals.OnSendComplete;
var
  i: integer;
begin
  // TODO:  MOA - don't think we need worry about the hidden MOA Terminals but this
  //        should be tested somehow

  Screen.Cursor := crDefault;
  ErrorCount := 0;

  for i := 0 to pred(TerminalCount) do
  begin
    if Terminals[i].State = tsError then
      inc(ErrorCount);
  end;

  if TerminalCount > 0 then
  begin
    if ErrorCount = 0 then
      LogText := 'All terminals were updated'
    else
    begin
      LogText := Format('%d terminals were not updated', [ErrorCount]);

      if not (InDLL or DoingThemeAutoSend or SendingThemeToEmptyPos) then
        btnSend.Caption := 'Resend All';
    end;

    Log;
  end;

  //Clear any cached values in the Site Proxy and sets the theme's LMDT to "now".
  ReloadMOATerminals(rcp1);

  LogText := '</ThemeSend>';
  Log;

  if SendingThemeToEmptyPos then
  begin
    CloseSendToPosDatabaseEntry(ErrorCount);
  end;

  Self.UpdateRunning := FALSE;
end;

procedure TUpdateTerminals.CloseSendToPosDatabaseEntry(ErrorCount : Integer);
var
  UpdateSuccessful : Integer;
begin
  if ErrorCount > 0 then
    UpdateSuccessful := 0
  else
    UpdateSuccessful := 1;

  with dmThemeData.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE ThemeSendToEmptyPoS');
    SQL.Add('SET UpdateSuccessful = ' + IntToStr(UpdateSuccessful) + ', Completed = GETDATE(), LMDT = GETDATE()' );
    SQL.Add('WHERE Requested = (SELECT MAX(Requested) FROM ThemeSendToEmptyPoS)');
    ExecSQL;
  end;

  LogText := 'ThemeSendToEmptyPos database entry closed - Update Successful is ' + IntToStr(UpdateSuccessful);
  Log;
end;

procedure TUpdateThread.GenerateXML(ATerminal: integer);
var
  SQLQuery: string;
  tmpEposModel: widestring;
  ModelFile : String;
begin
  // MOA:  This only needs to be done for the Displayed MOA terminal as the hidden
  //       MOA terminals get the same model but with a different MOA Employee ID
  ModelFile := XMLTempDir + 'xml' + IntToStr(Terminals[ATerminal].EposDeviceID) + '.xml';
  //UpdateTerminals.LogText := 'XML File Name : ' + ModelFile;
  //Synchronize(UpdateTerminals.Log);
  //UpdateTerminals.LogText := 'Checking if file exists...';
  //Synchronize(UpdateTerminals.Log);
  if fileexists (ModelFile) then
  begin
       Terminals[ATerminal].eposmodel := ReadWidestringFromFile(ModelFile);
       Terminals[ATerminal].XMLGenerated := TRUE;
  end
  else
  with Terminals[ATerminal] do
  begin
    //UpdateTerminals.LogText :=  'Generating XML...';
    //Synchronize(UpdateTerminals.Log);

    if not self.GetGeneratedXML(terminals[ATerminal])then
    begin
      if State <> tsComplete then
      begin
        try
          UpdateState(ATerminal, tsGeneratingXML);

          SQLQuery := format('theme_generateeposmodel %d, %d, %d, %d',
              [SiteCode, SalesAreaCode, PanelDesignID, PosCode] );
          UpdateTerminals.LogText := 'executing "' + SQLQuery + '"';
          Synchronize(UpdateTerminals.Log);

          with XMLStreamAsync do
          begin
            Initialise(Conn, SQLQuery);
            while not IsFinished do
              Sleep(20);
            if IsFinished and not IsCancelled then
              tmpEposModel := StreamResult
            else
              exit;
          end;
//          tmpEposModel := uXMLSave.GetXMLStream(Conn, SQLQuery);
          EposModel := tmpEposModel;
          tmpEposModel := '';
          XMLGenerated := TRUE;
        except on E: Exception do
          begin
            LogError(TerminalName + ' : '+ E.Message);
            Sleep(20);
            UpdateState(ATerminal,tsError);
            UpdateSendStatus(ATerminal,tssXMLGenerationFail);
          end;
        end;
      end;
    end;
    UpdateTerminals.UpdateXML(Terminals[ATerminal].PosCode,Terminals[ATerminal].SiteCode,XMLTempDir + 'xml'+ inttostr(Terminals[ATerminal].EposdeviceID)+ '.xml')
  end;
end;

procedure TUpdateThread.GetParseError(ATerminal: integer);
var
  ActualServerIPAddress: string;
  CommsMode: TZoeCommsMode;
begin
  // MOA: This doesn't need to be done for the hidden MOA terminals as it will be done
  //      for the displayed MOA terminal
  FailedToParse := FALSE;
  if Terminals[ATerminal].State = tsError then
    FailedToParse := TRUE;

  if FailedToParse then
    LogError('Terminal ' + Terminals[ATerminal].TerminalName +' is not ready to be updated - update cancelled')
  else
  begin
    // update the tills
    if Terminated then
      Exit;
    begin
      with Terminals[ATerminal] do
      begin
        if not (State in [tsError, tsComplete]) then
        try
          UpdateState(ATerminal, tsCheckingServer);
          ActualServerIPAddress := uAztecZoeComms.GetServerIPAddress(IPAddress, EposDeviceID);

          CommsMode := uAztecZoeComms.GetTerminalCommsMode(IPAddress, EPoSDeviceID);

          if (ActualServerIPAddress <> ServerIPAddress) and not (CommsMode = zcmSoloMode)  then
            raise Exception.Create('The Theme Server IPAddress is ' + ServerIPAddress +
              ' but the server IPAddress retrieved from the terminal is ' + ActualServerIPAddress);
        except on E:Exception do
          begin
            LogError(TerminalName + ' : ' + E.Message);
            Sleep(20);
            UpdateState(ATerminal, tsError);
            UpdateSendStatus(ATerminal,tssContactFailure);
          end;
        end;
      end;
    end;
  end;
end;

procedure TUpdateThread.Log(Text: string);
begin
  UpdateTerminals.LogText := Text;

  if not InDLL then
    Synchronize(UpdateTerminals.Log);
end;

procedure TUpdateThread.LogError(Text: string);
begin
  UpdateTerminals.ErrorText := Text;

  if not InDLL then
    Synchronize(UpdateTerminals.LogError);
end;

procedure TUpdateThread.ParseEposModel(ATerminal: integer);
var
  MOAPayMethod: String;
begin
  // MOA : all the hidden MOA terminals get the same model so it only needs
  //       to be parsed for the Displayed MOA terminal
  with Terminals[ATerminal] do
  begin
    if not (State in [tsError, tsComplete]) then
    try
      UpdateState(ATerminal, tsParsingXML);
      if TTerminalObj(Terminals[ATerminal]).ThemeHasMoaPayMethodButton(MOAPayMethod) then
          raise Exception.Create('The theme design has a button for the MOA payment method "' +
                     MOAPayMethod + '".');
      uAztecZoeComms.ParseModel(IPAddress, EposDeviceID, EposModel);
    except on E:Exception do
      begin
        LogError(TerminalName + ' : '+ E.Message);
        Sleep(20);
        UpdateState(ATerminal, tsError);
        UpdateSendStatus(ATerminal,tssXMLParseFail);
      end;
    end;
  end;
end;

procedure TUPdateThread.PartialSendCallback(msg: String);
begin
     Log(msg);
end;

procedure TUpdateThread.SendModel(ATerminalIndex: Integer);
var
  i: integer;
begin
  if not (ATerminalIndex in [Low(Terminals)..High(Terminals)]) then
  begin
    Log(Format('The terminal index supplied %d is out of bounds of the Terminals array', [ATerminalIndex]));
    Exit;
  end;

  with Terminals[ATerminalIndex] do
  begin
    if not (State in [tsError, tsComplete]) then
    try
      UpdateState(ATerminalIndex, tsSendingXML);
      {Peter Phillips, PM264 ---->}
      if FUsePartialThemeSend then
      begin
        if FAddendumBuffer <> '' then
        begin
          Log(Format('Performing partial theme send for terminal %d', [EposDeviceID]));

          uAztecZoeComms.SendPartialModel(IPAddress,EposDeviceID,EPoSModel,FAddendumBuffer,PartialSendCallback);

          // MOA: ensure that all the hidden MOA terminals get the partial send
          if MoaTerminal then
          begin
            for i := 0 to pred(MOATerminalCount) do
            begin
              if (MOATerminals[i].MainMOAEposDeviceID = Terminals[ATerminalIndex].EposDeviceID)
                 and (MOATerminals[i].EposDeviceID <> MOATerminals[i].MainMOAEposDeviceID) then
              begin
                uAztecZoeComms.SendPartialModel(MOATerminals[i].IPAddress,
                     MOATerminals[i].EposDeviceID, MOATerminals[i].EposModel,
                     MOATerminals[i].FAddendumBuffer, PartialSendCallback);
              end;
            end;
           end;
        end;
      end
      else
      begin
        //UpdateTerminals.LogText := 'Attempting to send model for ' + IntToStr(EposDeviceID);
        //Synchronize(UpdateTerminals.Log);
        uAztecZoeComms.SendModel(IPAddress, EposDeviceID, EposModel);
        // MOA: ensure that all the hidden MOA terminals get the full send
        if MoaTerminal then
        begin
          for i := 0 to pred(MOATerminalCount) do
          begin
            if (MOATerminals[i].MainMOAEposDeviceID = Terminals[ATerminalIndex].EposDeviceID)
            and (MOATerminals[i].EposDeviceID <> MOATerminals[i].MainMOAEposDeviceID) then
            begin
              uAztecZoeComms.SendModel(MOATerminals[i].IPAddress,
                   MOATerminals[i].EposDeviceID, MOATerminals[i].EposModel);
            end;
          end;
         end;
      end;

      SendAesKey(EposDeviceID);

      {<---- Peter Phillips, PM264}
      UpdateState(ATerminalIndex, tsCheckingState);
      UpdateSendStatus(ATerminalIndex, tssSucceeded);

    except on E: Exception do
      begin
        LogError(TerminalName + ' : '+ E.Message);
        Sleep(20);
        UpdateState(ATerminalIndex, tsError);
        UpdateSendStatus(ATerminalIndex,tssXMLSendFail);
      end;
    end;
  end;
end;

procedure TUpdateThread.SendAesKey(TerminalId: integer);
begin
  try
    Log(Format('Sending AES key to terminal %d', [TerminalId]));
    PosAesKeysService.SendAesKeyToPos(TerminalId);
    Log(Format('Finished sending AES key to terminal %d', [TerminalId]));
  except on E: Exception do
    begin
      //Deliberately swallowing the exception here so that a failure to send the AES key does not cause an error to be reported
      //in the user interface of the Send-to-Pos operation. Torn as to whether this is the right thing to do. Greg 05/04/2024
      Log(Format('Failed to ask BoH service to send AES key to terminal %d : %s', [TerminalId, E.Message]));
    end;
  end;
end;

procedure TUpdateThread.ShowStatus;
begin
  ShowMessage(FStatusText);
end;

//EPOSStatusCode values:
// 0 = Not parsed
// 1 = Parse failed
// 2 = Parse succeeded
procedure TUpdateThread.CheckTerminals;

var
  EPOSStatusCode: Integer;
  Revision: WideString;
  AnswersReceived: Boolean;
  TryCount: Integer;
  StartTime: TDateTime;
  TerminalChecked: array of Boolean;
  i: Integer;
  ZoeReturnCode: TZoeReturnCode;

  procedure ProcessResponse(_ReturnCode: Integer;_Revision: String; TerminalIndex: Integer);
  var
    ErrText: String;
  begin
    case _ReturnCode of
      0: //Model not parsed, not attempted,in progress etc.
      begin
        UpdateEPOSStatus(TerminalIndex,esParseNotDone);
      end;
      1: //Terminal failed to parse the model it was sent
      begin
        ErrText := Format('%s failed to parse model.',[Terminals[TerminalIndex].TerminalName]);
        LogError(ErrText);
        Log(ErrText);
        UpdateState(TerminalIndex,tsError);
        UpdateEPOSStatus(TerminalIndex,esParseFailed);
        TerminalChecked[TerminalIndex] := True;
      end;
      2: //Terminal has parsed the model it has.  Is it the model we sent?
      begin
        if _Revision = '' then
          _Revision := '<unknown>';
        //First time a terminal is used it will return no
        //revison - let these cases through
        if ((_Revision <> IntToStr(XMLRevision)) and (_Revision <> '<unknown>'))
        and not (Terminals[TerminalIndex].FUsePartialThemeSend and (Terminals[TerminalIndex].FAddendumBuffer = '')) then
        begin
          ErrText := Format('%s returned unexpected revision.  Expected: %d Received: %s',
                            [Terminals[TerminalIndex].TerminalName,XMLRevision,_Revision]);
          LogError(ErrText);
          Log(ErrText);
          UpdateState(TerminalIndex,tsError);
          UpdateEPOSStatus(TerminalIndex,esRevisionMismatch);
        end
        else begin
          UpdateEPOSStatus(TerminalIndex,esParseOK);
          UpdateState(TerminalIndex,tsComplete);
        end;
        TerminalChecked[TerminalIndex] := True;
      end;
    end;
  end;

begin
  // TODO:  MOA - would be nice to check the status of all the hidden MOA terminals
  //        and update the Displayed MOA terminal status accordingly
  SetLength(TerminalChecked,Length(Terminals));
  for i := 0 to pred(TerminalCount) do
//    TerminalChecked[i] := False;
// PW: Check all terminals based on their state
    TerminalChecked[i] := Terminals[i].State <> tsCheckingState;

  try
    StartTime := Now;
    TryCount := 1;
    AnswersReceived := False;

    //After a send the terminal may not be able to respond to this
    //call for a short period.  Retry for at most WAIT_INTERVAL
    //milliseconds and try each till at least MAX_RETRIES times.
    //Drop out if we receive a definitive answer (EPoSStatusCode = 1,2)
    //for each till we have interest in.
    while (not AnswersReceived)
    and (    (MilliSecondsBetween(StartTime,Now) < WAIT_INTERVAL)
          or (TryCount < MAX_RETRIES)) do
    begin
      AnswersReceived := True;
      for i := 0 to pred(TerminalCount) do
      begin
        //Don't recheck a terminal we already had a valid response from
        if not TerminalChecked[i] then
        begin
          if Terminals[i].SendStatus <> tssSucceeded then
          begin
            //A previous stage failed i.e. model not generated, failed to parse
            //terminal could not be contacted.  Do not try and interrogate the
            //EPoS status in these cases - it makes no sense
            TerminalChecked[i] := True;
            UpdateEPOSStatus(i,esParseNotDone);
          end
          else begin
                 // MOA TODO:  need to do the same for the MOA terminals
                 // i.e. should we do a CheckEPoSStatus for all the MOA terminals?
                 if not uAztecZoeComms.CheckEPoSStatus(Terminals[i].IPAddress,
                   Terminals[i].EposDeviceID,
                   EPOSStatusCode,
                   Revision,
                   ZoeReturnCode) then
                 begin
                     //Some other error - setting EPOSStatusCode = 0
                     //forces multiple attempts to retrieve the EPoS status
                     EPOSStatusCode := 0;
                 end;

                 ProcessResponse(EPOSStatusCode,Revision,i);
          end;

          AnswersReceived := AnswersReceived and TerminalChecked[i];
        end;

        Sleep(CALL_INTERVAL);
      end;
      Inc(TryCount);
    end;
  except on E: Exception do
    begin
      LogError('Failure checking terminals : '+ E.Message);
      Sleep(20);
    end;
  end;
end;

function TUpdateThread.AllTerminalsOKAfterSend: Boolean;
var
  i,j: Integer;
  TerminalOK: Boolean;
  BoHParseFailuresExist: Boolean;
begin
  // MOA:  the hidden MOA terminals are not in the Terminals array so don't need
  //       to be dealt with here
  BoHParseFailuresExist := False;
  Result := True;
  if (Assigned(UpdateTerminals.SingleSelectedTerminal))   then
  begin
    if (UpdateTerminals.SingleSelectedTerminal.SendStatus = tssSucceeded) then
    begin
      with dmThemeData.ADOqryUpdateLastThemeSend do
      begin
        Parameters.ParamByName('TerminalID').Value := UpdateTerminals.SingleSelectedTerminal.EposDeviceID;
        ExecSQL;
        // ensure that all the hidden MOA terminals have the LastThemeSend updated
        if UpdateTerminals.SingleSelectedTerminal.MoaTerminal then
          for j := 0 to pred(MOATerminalCount) do
          begin
            if (MOATerminals[j].MainMOAEposDeviceID = UpdateTerminals.SingleSelectedTerminal.EposDeviceID)
              and (MOATerminals[j].EposDeviceID <> MOATerminals[j].MainMOAEposDeviceID) then
            begin
              Parameters.ParamByName('TerminalID').Value := MOATerminals[j].EposDeviceID;
              ExecSQL;
            end;
          end;
      end;
    end;
    
    //One model selected for 'resend selected': we don't want to trigger roll-back in this case
    Result := True;
  end
  else begin
    for i := 0 to pred(TerminalCount) do
    begin
      //Terminals are ok if either the model was not sent or they parsed ok
      TerminalOK :=    (Terminals[i].EPOSStatus = esParseOK)
                    or (Terminals[i].SendStatus <> tssSucceeded);

      //Check for parse failures
      BoHParseFailuresExist := BoHParseFailuresExist
                               or (Terminals[i].SendStatus = tssXMLParseFail);

      Result := Result and TerminalOK;

      if not TerminalOK then
        Log(Format('Terminal %s not ok after Send to EPoS',[Terminals[i].TerminalName]));
    end;

    if BoHParseFailuresExist or not Result then
    begin
      //Archive the failed models
      if InDLL then
        UpdateTerminals.ArchiveFailedModels
      else
        Synchronize(UpdateTerminals.ArchiveFailedModels);
    end
    else if Result and not BoHParseFailuresExist then
    begin
      //Don't backup a set of files if there were parse errors either on the
      //till or at BoH
      if InDLL then
        //Backup the terminal models for the next Send to EPoS
        UpdateTerminals.BackupTerminalModels
      else
        Synchronize(UpdateTerminals.BackupTerminalModels);
    end;

    if Result then
    begin
      //We've had to look ahead to determine that we can go ahead
      //and now we have to reloop to set the last send dates.  Better done
      //with a transaction on the ADOqryUpdateLastThemeSend.Connection?
      for i := 0 to pred(TerminalCount) do
      begin
        if (Terminals[i].EPOSStatus = esParseOK) then
          with dmThemeData.ADOqryUpdateLastThemeSend do
          begin
            Parameters.ParamByName('TerminalID').Value := Terminals[i].EposDeviceID;
            ExecSQL;
            // ensure that all the hidden MOA terminals have the LastThemeSend updated
            if Terminals[i].MoaTerminal then
              for j := 0 to pred(MOATerminalCount) do
              begin
                if (MOATerminals[j].MainMOAEposDeviceID = Terminals[i].EposDeviceID)
                  and (MOATerminals[j].EposDeviceID <> MOATerminals[j].MainMOAEposDeviceID) then
                begin
                  Parameters.ParamByName('TerminalID').Value := MOATerminals[j].EposDeviceID;
                  ExecSQL;
                end;
              end;
          end;
      end;
    end;
  end;
end;

procedure TUpdateThread.UpdateEPOSStatus(CurrentTerminal: integer; AEPOSStatus: TEPOSStatus);
begin
  // MOA: the hidden MOA terminals are not in the Terminals array so can't have their status changed
  if Terminated then
    raise Exception.Create('Send terminated');

  Terminals[CurrentTerminal].EPOSStatus := AEPOSStatus;
end;

procedure TUpdateThread.UpdateSendStatus(CurrentTerminal: integer; ASendStatus: TTerminalSendStatus);
begin
  // MOA: the hidden MOA terminals are not in the Terminals array so can't have their status changed
  if Terminated then
    raise Exception.Create('Send terminated');

  Terminals[CurrentTerminal].SendStatus := ASendStatus;
end;

procedure TUpdateTerminals.Log;
begin
  try
    useful.TextLog(GetLogonName + ' - ' + LogText, programfiles + AZTECDIR + 'log\ThemeSend.log');
    useful.DoRipple(programfiles + AztecDIR + 'log\ThemeSend.log', 40960, 2);
  except
  end;
end;

function TUpdateTerminals.GetLogonName : String;
begin
  if DoingThemeAutoSend then
    result := 'CommsAutoSend'
  else if SendingThemeToEmptyPos then
    result := 'EmptyPosAutoSend'
  else
    result := dmADO.Logon_Name;
end;

procedure TUpdateTerminals.logerror;
begin
  LogText := ErrorText;
  Log;
  UpdateTerminals.mmErrors.Lines.Add(ErrorText);
end;

procedure TUpdateTerminals.SendTheme;
begin
  LogText := '<ThemeSend>';
  Log;

  Screen.Cursor := crAppStart;

  if Assigned(UpdateThread) then
    FreeAndNil(UpdateThread);

  UpdateThread := TUpdateThread.Create(TRUE);
  UpdateThread.SetXMLRevision(XMLRevision);
  UpdateThread.SetConn(dmThemeData.AztecConn);
  UpdateThread.Resume;
end;

procedure TUpdateTerminals.btnCloseClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  if UpdateRunning then
  begin
    if InDLL or DoingThemeAutoSend or SendingThemeToEmptyPos or
      (MessageDlg('Are you sure you want to cancel the send?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      btnClose.Enabled := FALSE;

      try
        If assigned(UpdateThread) then
          UpdateThread.Cancel;
        {Peter Phillips, PM264 ---->}
        If assigned(FTerminalResetThread) then
          FTerminalResetThread.Cancel;
        {<---- Peter Phillips, PM264}

        while UpdateRunning do
        begin
          Application.ProcessMessages;
          Sleep(20);
        end;
      finally
        btnClose.Enabled := TRUE;
      end;
    end;
  end
  else
    Close;
end;

procedure TUpdateTerminals.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  uAztecLog.Log('Form Close ' + Caption);
end;

//------------------------------------------------------------------------------
procedure TUpdateTerminals.DoPreview(ATerminalObject : TTerminalObj);
begin
  PreviewManager.AddPreviewRequest(
    ATerminalObject.SiteCode,
    ATerminalObject.SalesAreaCode,
    ATerminalObject.POSCode,
    ATerminalObject.PanelDesignID
  );
end;

//------------------------------------------------------------------------------
procedure TUpdateTerminals.btnPreviewClick(Sender: TObject);
begin
  ButtonClicked(Sender);

  if Assigned(lbTerminals.Selected) then
  begin
    SingleSelectedTerminal := TTerminalObj(lbTerminals.Selected.Data);
    SingleSelectedIndex := lbTerminals.Selected.Index;
  end
  else
  begin
    SingleSelectedTerminal := nil;
    SingleSelectedIndex := -1;
  end;

  if Assigned(SingleSelectedTerminal) then
  with SingleSelectedTerminal do
  begin
    uAztecLog.Log(Format('Previewing PanelDesign  %d For terminal ID %d in Sales Area ID %d',
      [PanelDesignID, EposDeviceID, SalesAreaCode]));
    DoPreview(SingleSelectedTerminal);
  end
  else
  begin
    ShowMessage('Please select a terminal to preview');
    uAztecLog.Log('No Terminal selected from the list');
  end;
end;

//------------------------------------------------------------------------------
procedure TUpdateTerminals.FormCreate(Sender: TObject);
  procedure LoadBitmaps(AnImageList: TImageList; BitmapResourceNames: array of string);
  var
    TempBitmap: TBitmap;
    i: integer;
  begin
    TempBitmap := TBitmap.Create;
    for i := Low(BitmapResourceNames) to High(BitmapResourceNames) do
    begin
      TempBitmap.LoadFromResourceName(HInstance, BitmapResourceNames[i]);
      ilTerminalTypes.Add(TempBitmap, TempBitmap);
    end;
    TempBitmap.Free;
  end;
begin
  programfiles := EnsureTrailingSlash(GetProgramFilesDir);
  AuditReaderControl := TAuditReadControl.Create(dmThemeData.AztecConn);
  SelectedServers := TStringList.Create;
  // Load hardware icons
  if not InDll then
  begin
    ilTerminalTypes.clear;
    // This list is synchronised to the contents of table TerminalHardware
    // Note 1:  32x32_ExternalAPIAccess is an empty bitmap which is never used but was necessary here because ExternalAPIAccess
    //   is in the TerminalHardware table with HardwareType 12 so is only there to get the right array position for
    //   MOAOrderPad which has HardwareType 13 and also for any future terminal hardware types
    // Note 2:  The third party bitmap must ALWAYS be at the end!
    LoadBitmaps(ilTerminalTypes, ['32x32_Z500', '32x32_Z400', '32x32_Z300', '32x32_HandHeld', '32x32_IBM551',
                                  '32x32_Conqueror', '32x32_HotelSystem', '32x32_i700', '32x32_Kiosk', '32x32_XPPOS',
                                  '32x32_MOA', '32x32_ExternalAPIAccess', '32x32_MOAOrderPad', '32x32_MOAPayAtTable',
                                  '32x32_iZoneTables', '32x32_IBMSurePOS500', '32x32_IBMSurePOS514P126', '32x32_IBMSurePOS532P126',
                                  '32x32_SharpUPV5500', '32x32_SharpRZX750', '32x32_ToshibaTECSTA10', '32x32_ToshibaTECSTA12',
                                  '32x32_IBMSurePOS532P1238', '32x32_IBMSurePOS514P1238', '32x32_ToshibaTECSTA20', '32x32_AzOne',
                                  '32x32_AzTab', '32x32_ZonalToshibaA12', '32x32_ZonalToshibaA20', '32x32_ZonalToshibaA30',
                                  '32x32_ZonalToshibaA10', '32x32_ThirdParty', '32x32_Z9']);
  end;
end;
                                                                                                                                                                                                                                  
procedure TUpdateTerminals.SetUpdateRunning(const Value: boolean);
var
  AuditReaderResumedOk: boolean;
begin
  if Value <> FUpdateRunning then
  begin
    if Value then
    begin
      if not CreateEPOSMutex(self.handle, self.FCancelled, FTicks) then
      begin
        LogText := 'Failed to claim epos mutex';
        Log();
        if SendingThemeToEmptyPos then
          CloseSendToPosDatabaseEntry(1);
        raise ECannotSend.Create('Another process may be running a Theme Send, please try again later.');
      end;
      try
        AuditReaderControl.Pause;
        AuditReaderPausedOk := true;
      except on E:Exception do
        begin
          AuditReaderPausedOk := false;
          LogText := 'Error pausing Audit Read for send: '+E.Message;
          Log;
        end;
      end;
    end
    else
    begin
      try
        ReleaseEPOSMutex;
      except on e:exception do
        begin
          LogText := 'Failed to release epos mutex '+e.message;
          Log();
        end;
      end;
      try
        AuditReaderControl.Resume;
        AuditReaderResumedOk := true;
      except on E:Exception do
        begin
          AuditReaderResumedOk := false;
          LogText := 'Error resuming Audit Read after send: '+E.Message;
          Log;
        end;
      end;

      if not(AuditReaderPausedOk and AuditReaderResumedOk) then
      begin
        // Fall back to manually updating recipe map.
        try
          LogText := 'Updating stock recipe map..';
          Log;
          dmThemeData.adoqRun.SQL.Text := 'if object_id(''stksp_make121rcp'') is not null '+
            'exec stksp_make121rcp';
          dmThemeData.adoqRun.CommandTimeout := 0;
          dmThemeData.AztecConn.CommandTimeout := 0;
          dmThemeData.SafeExecSQL;
          LogText := 'Completed.';
          Log;
        except on E: Exception do
          begin
            LogText := 'Error updating stock recipe map:' + E.Message;
            Log;

            if not (InDLL or DoingThemeAutoSend or SendingThemeToEmptyPos) then
              MessageDlg('Error updating Stock Recipe Map! ' + #13 +
                'This is a serious error, there may be problems with recent changes to Product data.',
                mtError, [mbOk], 0);
          end;
        end;
      end;

      if (DoingThemeAutoSend or SendingThemeToEmptyPos) then
        ModalResult := mrOk;
    end;
  end;


  FUpdateRunning := Value;

  tmrUpdate.Enabled := FUpdateRunning;

  btnSend.Enabled := not FUpdateRunning;
  btnPreview.Enabled := not FUpdateRunning;
  btnReSendSelected.Enabled := not FUpdateRunning;
  chk_allowreset.Enabled := not FUpdateRunning;

  if FUpdateRunning then
  begin
    btnClose.Caption := 'Cancel';
  end
  else
  begin
    btnClose.Caption := 'Close';
    btnClose.Enabled := true;
    mmErrors.Visible := mmErrors.Lines.Count > 0;
  end;
end;



procedure TUpdateTerminals.btnReSendSelectedClick(Sender: TObject);
  //The villain of the piece here is the blocking call to
  //TerminalsRequireReset which instanciates its own thread to
  //do the work :-(  Because of that bad decision we need to
  //check for cancellation of the process from the thread and thus
  //we get the follwing routine...
  procedure CleanUp;
  begin
    FreeAndNil(UpdateThread);
    FreeAndNil(FTerminalsRequiringReset);
    ResetTerminalStates;
    UpdateRunning := FALSE;
  end;
var
  FXMLFile :  String;
  Msg : String;
  i: integer;
begin
  ButtonClicked(Sender);

  mmErrors.Visible := false;

  if Assigned(lbTerminals.Selected) then
  begin
    SingleSelectedTerminal := TTerminalObj(lbTerminals.Selected.Data);
    SingleSelectedIndex := lbTerminals.Selected.Index;
  end
  else
  begin
    SingleSelectedTerminal := nil;
    SingleSelectedIndex := -1;
  end;

  Fcancelled := false;
  mmErrors.Lines.Clear;

  UpdateRunning := TRUE;

  msg := 'The following terminal could not be updated without resetting them:'#10#13#10#13+'%s'+#10#13;
  msg := msg + 'Do you wish to continue and update all the terminals? ';
  msg := msg + 'This will cause a temporary stopping of the terminal requiring reset which may affect business.';

  if Assigned(SingleSelectedTerminal) then
  with SingleSelectedTerminal do
  begin

    if not checkFileExclusive(XMLBackupDir + '\modelarchive.zip') or
       not checkFileExclusive(XMLFailedDir + '\modelarchive_failed.zip') or
       not checkFileExclusive(XMLTempDir + 'xml' + IntToStr(SingleSelectedTerminal.EposDeviceID) + '.xml') then
       begin
         UpdateRunning := false;
         Exit;
       end;

    // MOA: if the selected terminal is MOA then do the file checks for all the hidden MOA terminals
    if MoaTerminal then
    begin
      for i := 0 to Pred(MOATerminalCount) do
        if (MOATerminals[i].MainMOAEposDeviceID = SingleSelectedTerminal.EposDeviceID)
           and (MOATerminals[i].EposDeviceID <> MOATerminals[i].MainMOAEposDeviceID) then
        begin
          if not checkFileExclusive(XMLBackupDir + '\modelarchive.zip') or
            not checkFileExclusive(XMLFailedDir + '\modelarchive_failed.zip') or
            not checkFileExclusive(XMLTempDir + 'xml' + IntToStr(MOATerminals[i].EposDeviceID) + '.xml') then
          begin
            UpdateRunning := false;
            Break;
          end
        end;
      if not UpdateRunning then
        Exit;
    end;

    uAztecLog.Log(Format('Sending PanelDesign  %d For terminal ID %d in Sales Area ID %d',
                                             [PanelDesignID, EposDeviceID, SalesAreaCode]));
    if Assigned(UpdateThread) then
      FreeAndNil(UpdateThread);

    UpdateThread := TUpdateThread.Create(TRUE);
    UpdateThread.SetConn(dmThemeData.AztecConn);
    UpdateThread.ResendRunning := true;

    FXMLFile := XMLTempDir + 'xml' + IntToStr(EposDeviceID) + '.xml';
    if FileExists(FXMLFile) then
    begin
      SingleSelectedTerminal.EposModel :=  UpdateXML(PosCode, SiteCode, FXMLFile);
      SingleSelectedTerminal.XMLGenerated := TRUE;
      // MOA: ensure that all the hidden MOA terminals get the same model as the selected MOA terminal
      if SingleSelectedTerminal.MoaTerminal then
        for i := 0 to pred(MOATerminalCount) do
        begin
          if (MOATerminals[i].MainMOAEposDeviceID = SingleSelectedTerminal.EposDeviceID)
          and (MOATerminals[i].EposDeviceID <> MOATerminals[i].MainMOAEposDeviceID) then
            MOATerminals[i].CopyMoaXML(SingleSelectedTerminal);
        end;

      if TerminalsRequireReset(SingleSelectedTerminal) then
      begin
        if Fcancelled then
        begin
          CleanUp;
          exit;
        end;
        if (FAllowTerminalReset) or (MessageDlg(Format(msg,[FTerminalsRequiringReset.Text]), mtConfirmation,[mbYes, mbNo],0) = mrYes) then
          UpdateThread.Resume
        else
           FreeAndNil(UpdateThread);

        freeandnil(FTerminalsRequiringReset);
      end
      else
      begin
        if Fcancelled then
        begin
          CleanUp;
          exit;
        end;
        UpdateThread.Resume
      end;
    end
    else
    begin
      try
        if UpdateThread.GetGeneratedXML(SingleSelectedTerminal) then
        begin
          SingleSelectedTerminal.EposModel :=  UpdateXML(PosCode, SiteCode, FXMLFile);
          SingleSelectedTerminal.XMLGenerated := TRUE;
           // MOA: ensure that all the hidden MOA terminals get the same model as the selected MOA terminal
          if SingleSelectedTerminal.MoaTerminal then
            for i := 0 to pred(MOATerminalCount) do
            begin
              if (MOATerminals[i].MainMOAEposDeviceID = SingleSelectedTerminal.EposDeviceID)
              and (MOATerminals[i].EposDeviceID <> MOATerminals[i].MainMOAEposDeviceID) then
                MOATerminals[i].CopyMoaXML(SingleSelectedTerminal);
            end;

          if TerminalsRequireReset(SingleSelectedTerminal) then
          begin
            if Fcancelled then
            begin
              CleanUp;
              exit;
            end;
            if (FAllowTerminalReset) or (MessageDlg(Format(msg,[FTerminalsRequiringReset.Text]), mtConfirmation,[mbYes, mbNo],0) = mrYes) then
              UpdateThread.Resume
            else
               FreeAndNil(UpdateThread);
            freeandnil(FTerminalsRequiringReset);
          end
          else if Fcancelled then
          begin
            CleanUp;
            exit;
          end;
        end
        else begin
          MessageDlg('There is no valid theme generated for this terminal,'+#10#13+
                                      'Please press "Send All"', mtInformation, [mbOk], 0);
          CleanUp;
        end;
      except
        MessageDlg('There is no valid theme generated for this terminal,'+#10#13+
                                      'Please press "Send All"', mtInformation, [mbOk], 0);
        CleanUp;
      end;
    end;
  end
  else
  begin
    uAztecLog.Log('No Terminal selected from the list');
    ShowMessage('Please Select a Terminal to Update');
    UpdateRunning := False;
  end;
end;

Function TUpdateTerminals.UpdateXML(APosCode, ASiteCode: integer ; AXMLFile : String):WideString;
var
  XMLText : WideString;
  FromPath,FromAttribute,
  ToPath,ToAttribute: String;
begin
  // MOA: the hidden MOA terminals are dealt with in the CopyMOAXml procedure
  XMLText := '';
  with dmThemeData.adoqRun do
  begin
    SQL.Text := Format('Theme_GenerateXMLTerminalchanges %d, %d', [APOSCode, ASiteCode]);

    Open;
    uXMLModify.Open(AXMLFile);
    while not Eof do
    begin
      if lowercase(FieldByName('Action').AsString) = 'delete' then
        uXMLModify.DeleteNode(FieldByName('Path').AsString)
      else if lowercase(FieldByName('Action').AsString) = 'update' then
        uXMLModify.UpdateNode(FieldByName('Path').AsString, FieldByName('Attribute').AsString)
      else if lowercase(FieldByName('Action').AsString) = 'update2' then
      begin
        FromPath := copy(FieldByName('Path').AsString, 1, pred(pos('!', FieldByName('Path').AsString)));
        ToPath := copy(FieldByName('Path').AsString, succ(pos('!', FieldByName('Path').AsString)),
                                Length(FieldByName('Path').AsString)-1);
        FromAttribute := copy(FieldByName('Attribute').AsString, 1, pred(pos('!', FieldByName('Attribute').AsString)));
        ToAttribute := copy(FieldByName('Attribute').AsString, succ(pos('!', FieldByName('Attribute').AsString)),
                                Length(FieldByName('Attribute').AsString)-1);
        uXMLModify.CopyNodeAttributeValue(FromPath, FromAttribute, ToPath, ToAttribute);
      end;

      Next;
    end;

    uXMLModify.Close;
    XMLText := ReadWidestringFromFile(AXMLFile);
    result := XMLText;
    WriteWidestringToFile(XMLText,AXMLFile);
  end;
end;


function TUpdateThread.GetGeneratedXML(ATerminal: TTerminalObj): Boolean;
var
  FConfigSetId : integer;
  FServerIP : string;
  FSalesArea : integer;
  FPanelDesignID : integer;
  FThemeID       : integer;
  i : integer;
begin
  // MOA: this only needs to be done for the displayed MOA terminal
  Result := ATerminal.XMLGenerated;

  for i := 0 to pred(TerminalCount) do
  begin
    FConfigSetId :=  Terminals[i].ConFigSetID;
    FServerIP := Terminals[i].ServerIPAddress;
    FSalesArea := Terminals[i].SalesAreaCode;
    FPanelDesignID := Terminals[i].PanelDesignID;
    FThemeID := Terminals[i].ThemeID;
    if ((ATerminal.SalesAreaCode = FSalesArea) and
      (ATerminal.ServerIPAddress = FServerIP) and
      (ATerminal.ConFigSetID = FConfigSetId) and
      (ATerminal.PanelDesignID = FPanelDesignID) and
      (ATerminal.ThemeID = FThemeID)) then
    begin
      if (FileExists(XMLTempDir + 'xml'+ inttostr(Terminals[i].EposDeviceID) +'.xml'))and
         (ATerminal.EposDeviceID <> Terminals[i].EposDeviceID) then
      begin
        //UpdateTerminals.LogText := Format('Checking if model for terminal %d can be used', [Terminals[i].EposDeviceID] );
        //Synchronize(UpdateTerminals.Log);
        uXMLModify.Open(XMLTempDir + 'xml'+ inttostr(Terminals[i].EposDeviceID) +'.xml');
        try
          if uXMLModify.NodesExist(
            Format('//EPoSModel/EPoSDevices/Terminal[@GUIDO=''%d'']',
              [ATerminal.EposDeviceID])
          ) then
          begin
            //UpdateTerminals.LogText := Format('Model from terminal %d ok, setting on terminal %d',
            //                                    [Terminals[i].EposDeviceID, ATerminal.EposDeviceID]);
            //Synchronize(UpdateTerminals.Log);
            ATerminal.EposModel := Terminals[i].EposModel;
            Result := TRUE;
            Break;
          end;
        finally
          uXMLModify.Close;
        end;
      end;
    end;
  end;
end;

procedure TUpdateTerminals.BackupTerminalModels;
begin
  //Ripple the previous modelarchive.zip file.  We want to keep the
  //previous 30 *successfull* send to EPoS operations.
  useful.DoRipple(XMLBackupDir + '\modelarchive.zip',0,30);
  ArchiveModels(ensuretrailingslash(XMLTempDir) + '*.*',
    ensuretrailingslash(XMLBackupDir) + 'modelarchive.zip');
end;

procedure TUpdateTerminals.RestoreTerminalModels;
begin
  //Restore the last known good models
  useful.deletefiles(ensuretrailingslash(XMLTempDir) + '*.*');
  UnArchive(ensuretrailingslash(XMLBackupDir) + 'modelarchive.zip',ensuretrailingslash(XMLTempDir),nil);
end;

procedure TUpdateTerminals.ArchiveFailedModels;
begin
  //Delete the previous failed xml files
  //Move the failed files to the 'failed' dir
  useful.DoRipple(XMLFailedDir + '\modelarchive_failed.zip',0,30);
  ArchiveModels(ensuretrailingslash(XMLTempDir) + '*.*',
    ensuretrailingslash(XMLFailedDir) + 'modelarchive_failed.zip');
end;

procedure TUpdateTerminals.ArchiveModels(SearchPattern: String; DestinationFile: String);
var
  FilesToArchive: TStringList;
  Succeeded: Boolean;
begin
  FilesToArchive := TStringList.Create;
  try
    useful.FindFiles(SearchPattern,ffstNameMatch,TStrings(FilesToArchive));

    //Archive the failed models
    Succeeded := ArchiveFiles(FilesToArchive, DestinationFile,nil);
    if Succeeded then
      LogText := Format('Successfully archived files %s as %s',[SearchPattern,DestinationFile])
    else
      LogText := Format('Failed to archive files %s as %s',[SearchPattern,DestinationFile]);
    Log;
  finally
    FilesToArchive.Free;
  end;
end;

procedure TUpdateThread.Cancel;
begin
  if Assigned(XMLStreamAsync) then
    XMLStreamAsync.Cancel;
  self.OnTerminate := UpdateTerminals.ThreadDone;
  Terminate;
end;

procedure TUpdateTerminals.chk_allowresetClick(Sender: TObject);
begin
  FAllowTerminalReset := TCheckBox(Sender).Checked;
end;

procedure TUpdateTerminals.AutoSend(var msg: TMessage);
begin
  try
    SendAll;
  except
    on ECannotSend do
    begin
      Self.FCancelled := true;
      Self.ModalResult := mrCancel;
    end;
    on e:Exception do
    begin
      LogText := 'Unhandled exception during auto send: '+e.message;
      Log();
      Self.FCancelled := true;
      Self.ModalResult := mrCancel;
    end;
  end;
end;

procedure TUpdateTerminals.SendThemeToEmptyPos(var msg: TMessage);

  procedure AddNewSendToEmptyPosDatabaseRecord;
  begin
    LogText := 'Adding ThemeSendToEmptyPos record';
    Log;
    try
      with dmThemeData.adoqRun do
      begin
        close;
        SQL.Clear;
        SQL.Add('IF NOT EXISTS (SELECT * FROM ThemeSendToEmptyPoS WHERE Completed IS NULL) ');
        SQL.Add('BEGIN');
        SQL.Add('  INSERT ThemeSendToEmptyPoS (SiteCode, Requested, LMDT) ');
        SQL.Add('  VALUES ([dbo].fnGetSiteCode(), GETDATE(), GETDATE()) ');
        SQL.Add('END');
        ExecSQL;
      end;
    except on e: Exception do
      begin
        LogText := 'Error updating database record : ' + e.Message;
        Log;
      end;
    end;
  end;

  function TerminalHasPreviousTheme(TerminalID : Integer) : Boolean;
  begin
    with dmThemeData.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT TerminalID, LastThemeSend');
      SQL.Add('FROM AztecPOS');
      SQL.Add('WHERE TerminalID = ' + IntToStr(TerminalID));
      Open;
      result := not(FieldByName('LastThemeSend').IsNull);
    end;
  end;

var
  i : Integer;
begin
  AddNewSendToEmptyPosDatabaseRecord;
  // if terminal has previously had theme, send to one terminal only
  if TerminalHasPreviousTheme(TerminalIDForThemeAutoSend) then
  begin
    LogText := 'Previous theme detected, sending theme to device ' + IntToStr(TerminalIDForThemeAutoSend);
    Log;
    for i := 0 to lbTerminals.Items.Count - 1 do
    begin
      if TTerminalObj(lbTerminals.Items[i].Data).EposDeviceID = TerminalIDForThemeAutoSend then
      begin
        lbTerminals.Selected := nil;
        lbTerminals.Selected := lbTerminals.Items[i];
        break;
      end;
    end;
    btnReSendSelected.Click;
  end
  // otherwise do full send all
  else
  begin
    LogText := Format('No previous theme detected for device %d, performing Send All action', [TerminalIDForThemeAutoSend]);
    Log;
    SendAll;
  end;
end;

function TUpdateTerminals.GenerateXMLRevision: Boolean;
begin
  //Update ThemeSiteAutoSendToEPoS with the new revison and clear the
  //actioned field to allow determination that a send failed
  Result := false;
  try
    with TADOQuery.Create(nil) do try
      Connection := dmThemeData.AztecConn;
      SQL.Clear;

      //Get the next unique revision number
      XMLRevision := uGenerateThemeIDs.GetNewId(scThemeSiteAutoSendToEPoS);
      LogText := Format('Assigned model revision: %d',[XMLRevision]);
      Log;
      SQL.Add('DECLARE @sitecode integer');
      SQL.Add('DECLARE @revision integer');
      SQL.Add('SET @sitecode = dbo.fnGetSiteCode()');
      SQL.Add('SET @revision = '+inttostr(XmlRevision));
      SQL.Add('Update ThemeSiteAutoSendToEPoS set Actioned = null, Revision = @Revision where SiteCode = @SiteCode');
      SQL.Add('if @@rowcount = 0 insert ThemeSiteAutoSendToEPos (SiteCode, Revision) VALUES (@sitecode,@revision)');
      ExecSQL;
      Result := true;
    finally
      Free;
    end;
  except on e: Exception do
    begin
      LogText := 'Unable to generate model revision '+e.message;
      Log();
    end;
   end;
end;

Procedure TUpdateThread.RollbackTerminals;
var
  i, j: Integer;
  ModelExistsForEachTerminal: Boolean;
  ModelRevision: Integer;
  OverallRevision: Integer;
  InconsistentRevisions: Boolean;
begin
  LogError('Terminal update failure.  Rolling back terminals...');
  Log('Terminal update failure.  Rolling back terminals...');

  ModelExistsForEachTerminal := True;
  InconsistentRevisions := False;

  OverallRevision := -1;

  //Check that we have a backup model for all the terminals and that the backup
  //set is for the correct revison.
  for i := 0 to pred(TerminalCount) do
  begin
    if FileExists(XMLTempDir + 'xml' + IntToStr(Terminals[i].EposDeviceID) + '.xml') then
    begin
      Terminals[i].EposModel := ReadWidestringFromFile(XMLTempDir + 'xml' + IntToStr(Terminals[i].EposDeviceID) + '.xml');
      ModelRevision := Terminals[i].GetModelRevsion;

      if OverallRevision = -1 then
        OverallRevision := ModelRevision;
      InconsistentRevisions := OverallRevision <> ModelRevision;

      if InconsistentRevisions then
        Break;

      // MOA: ensure that all the hidden MOA terminals in the same sales area will be rolled back
      //      with the correct model
      if Terminals[i].MoaTerminal then
        for j := 0 to pred(MOATerminalCount) do
          if (MOATerminals[j].MainMOAEposDeviceID = Terminals[i].EposDeviceID)
          and (MOATerminals[j].EposDeviceID <> MOATerminals[j].MainMOAEposDeviceID) then
            MOATerminals[j].EposModel := ReadWideStringFromFile(XMLTempDir + 'xml' + IntToStr(MoaTerminals[i].EposDeviceID) + '.xml');
    end
    else begin
      //No model exists for the terminal - it must have been newly added since the last send
      ModelExistsForEachTerminal := False;
      Break;
    end;
  end;

  {if not (ModelExistsForEachTerminal or InconsistentRevisions) then
  begin
    //We have an overall consistent revision for the existing models, but we have
    //terminals for which we have no model.  Reset the extra models to have a
    //blank model with the latest revsion number.
    for i := 0 to pred(TerminalCount) do
    begin
      if not FileExists(XMLTempDir + 'xml' + IntToStr(Terminals[i].EposDeviceID) + '.xml') then
      begin
        Log(Format('No backup model for terminal %d.  Creating blank rollback model.',
                  [Terminals[i].EposDeviceID]));
        Terminals[i].EposModel := Format('<EPoSModel Revision="%d"></EPoSModel>',[OverallRevision]);

        //This model has no backup, so to prevent it from undergoing zoe parsing
        //when we send the 'stub' model (which is fundamentally invalid)
        Terminals[i].SkipParsing := True;
      end
    end;
    ModelExistsForEachTerminal := True;
  end;   }

  if (not ModelExistsForEachTerminal) or InconsistentRevisions then
  begin
    LogError('...rollback failed.');
    Log('...rollback failed.');
    Exit;
  end
  else begin
    for i := 0 to pred(TerminalCount) do
    begin
      RollbackTerminal(i);
    end;
    LogError('...rollback completed successfully.');
    Log('...rollback completed successfully.');
  end;
end;

procedure TUpdateTerminals.OnSendInComplete;

begin
  LogText := 'Not Completed.';
  Log;

  Screen.Cursor := crDefault;

  //EDCOM: Need to determine if this was done successfully or not
  //LogText := 'Terminal update failure.  Terminals rolled back.';
  //Log;

  //ErrorText := 'Terminal update failure.  Terminals rolled back.';
  //LogError;

  //Clear any cached values in the Site Proxy and sets the theme's LMDT to "now".
  ReloadMOATerminals(rcp1);

  LogText := '</ThemeSend>';
  Log;

  Self.UpdateRunning := FALSE;
end;

function TUpdateThread.DetermineStartingRevision: Integer;
var
  EPOSStatusCode: Integer;
  Revision: WideString;
  i: Integer;
  OverallRevision: Integer;
  CurrentRevision: Integer;
  InconsistentRevisions: Boolean;
  ZoeReturnCode: TZoeReturnCode;
begin
  // MOA: the same revision will be used for all the hidden MOA terminals
  //      so no changes needed here
  OverallRevision := -1;
  InconsistentRevisions := False;
  for i := 0 to pred(TerminalCount) do
  begin
    CurrentRevision := -1;
    with Terminals[i] do
    begin
      try
        if uAztecZoeComms.CheckEPoSStatus(IPAddress,
          EposDeviceID,
          EPOSStatusCode,
          Revision,
          ZoeReturnCode) then
        begin
          CurrentRevision := StrToIntDef(Revision,-1);
        end;

        if OverallRevision = -1 then
          OverallRevision := CurrentRevision;

        InconsistentRevisions := (OverallRevision <> CurrentRevision);

        if InconsistentRevisions then
          Break;
      except on E: Exception do
        begin
          LogError(TerminalName + ' : '+ E.Message);
          Sleep(20);
          UpdateState(i, tsError);
        end;
      end;
    end;
  end;
  if InconsistentRevisions then
    Result := -1
  else
    Result := OverallRevision;
end;

procedure TUpdateThread.SetXMLRevision(_XMLRevision: Integer);
begin
  XMLRevision := _XMLRevision;
end;

procedure TUpdateThread.UpdateThemeSiteAutoSendToEPoS;
begin
  with TADOQUery.Create(nil) do
    try
      Connection := dmThemeData.AztecConn;

      //Touch all sites to get an automatic Send to EPoS.
      SQL.Add('DECLARE @sitecode integer');
      SQL.Add('SET @sitecode = dbo.fnGetSiteCode()');

      SQL.Add('UPDATE ThemeSiteAutoSendToEPoS');
      SQL.Add('SET Actioned = GetDate()');
      SQL.Add('WHERE SiteCode = @sitecode');
      ExecSQL;
    finally
     Free;
    end;
end;

procedure TUpdateThread.RollbackTerminal(ATerminalID: Integer);
begin
  // MOA: the hidden MOA tills will be dealt with in RollbackModel
  UpdateState(ATerminalID,tsCheckingServer);
  XMLOK := FALSE;

  if Terminated then
    Exit;

  if not Terminals[ATerminalID].SkipParsing then
    ParseEposModel(ATerminalID)
  else
    UpdateState(ATerminalID, tsParsingXML);

  if Terminated then
    Exit;

  FailedToParse := FALSE;

  if not Terminals[ATerminalID].SkipParsing then
    GetParseError(ATerminalID)
  else
    UpdateState(ATerminalID, tsCheckingServer);

  XMLOK := TRUE;

  RollbackModel(ATerminalID);
end;

procedure TUpdateThread.RollbackModel(ATerminalIndex: integer);
var
  j: integer;
begin
  with Terminals[ATerminalIndex] do
  begin
    if not (State in [tsError, tsComplete]) then
    try
      UpdateState(ATerminalIndex, tsSendingXML);
      uAztecZoeComms.SendModel(IPAddress, EposDeviceID, EposModel);
      // MOA: have to rollback all the hidden MOA terminals too
      if MoaTerminal then
        for j := 0 to pred(MOATerminalCount) do
        begin
          if (MOATerminals[j].MainMOAEposDeviceID = Terminals[ATerminalIndex].EposDeviceID)
          and (MOATerminals[j].EposDeviceID <> MOATerminals[j].MainMOAEposDeviceID) then
            uAztecZoeComms.SendModel(MOATerminals[j].IPAddress, MOATerminals[j].EposDeviceID, MOATerminals[j].EposModel);
        end;
      UpdateState(ATerminalIndex, tsRollback);
    except on E: Exception do
      begin
        LogError(TerminalName + ' : '+ E.Message);
        Sleep(20);
        UpdateState(ATerminalIndex, tsError);
      end;
    end;
  end;
end;

procedure TUpdateTerminals.CancelSend;
begin
  if UpdateRunning then
  begin
    If assigned(UpdateThread) and not UpdateThread.Terminated then
       UpdateThread.Cancel;
    {Peter Phillips, PM264 ---->}
    If assigned(FTerminalResetThread) and not FTerminalResetThread.Terminated then
       FTerminalResetThread.Cancel;
    {<---- Peter Phillips, PM264}
    while UpdateRunning do
    begin
      Application.ProcessMessages;
      Sleep(20);
    end;
  end;
end;

procedure TUpdateTerminals.CancelManualSend(var Msg: TMessage);
begin
  // PW Use ticks send via message to ignore cancels from TM instances
  // which were started earlier than this one.
  if FTicks < Cardinal(Msg.LParam) then
    CancelSend;
end;

procedure TUpdateTerminals.lbTerminalsClick(Sender: TObject);
begin
  if Assigned(lbTerminals.Selected) then
      begin
        if TTerminalObj(lbTerminals.Selected.Data).HardwareType in [Ord(ehtKiosk), Ord(ehtMobileOrdering), Ord(ehtMOAOrderPad), Ord(ehtiZoneTables)] then
           btnPreview.Enabled := False
        else
           btnPreview.Enabled := True;
      end;

end;

function TUpdateTerminals.checkFileExclusive(filename : string) : boolean;
begin
  result := false;
  try
  if FileExists(filename) then
     begin
       with TFileStream.Create(filename, fmOpenRead, fmShareExclusive) do
            try
               result := true;
               UpdateTerminals.LogText := 'File '+ filename +' is not locked by another process.  Continue Theme Send.';
               UpdateTerminals.Log;
               finally
                  free;
            end;
     end
  else
     begin
       // if the file does not exist, assume that exclusive access can be made and allow theme modelling to handle creation of files.
       result := True;
       UpdateTerminals.LogText := 'File '+ filename +' does not exist.  Exclusive access could not be made.  Continue Theme Send.';
       UpdateTerminals.Log;
     end;
  except on E: Exception do
  begin
     try
       UpdateTerminals.LogText := 'File Error: ' + E.Message + '. File appears to be in use.  Send To POS aborted.';
       UpdateTerminals.Log;
       UpdateTerminals.ErrorText := 'File Error: ' + E.Message + '. File appears to be in use.  Send To POS aborted.';
       UpdateTerminals.LogError;
       mmErrors.Visible := true;
       finally
       end;
  end;
  end;
end;

{ MOARemoteOrderingTerminalObj }

constructor TMOARemoteOrderingTerminalObj.Create(AEposDeviceID: integer; AIPAddress: string; AServerIPAddress: string;
  ASiteCode, AConfigSetID, AThemeID, APanelDesignID, APosCode, ASalesAreaCode, APanelDesignType, AHardwareType: integer;
  ATerminalName: string; AState: TTerminalState; AEPOSStatus: TEPOSStatus;
  ASendStatus: TTerminalSendStatus; AMOATerminal: Boolean; AHasDefaultPanel: boolean; AMainMOAEposDeviceID: integer; ASoloMode: Boolean);
begin
  inherited Create(AEposDeviceID, AIPAddress, AServerIPAddress, ASiteCode, AConfigSetID, AThemeID, APanelDesignID, APosCode,
    ASalesAreaCode, APanelDesignType, AHardwareType, ATerminalName, AState, AEPOSStatus, ASendStatus, AMOATerminal, AHasDefaultPanel, ASoloMode);

  MainMOAEposDeviceID := AMainMOAEposDeviceID;
end;


procedure TMOARemoteOrderingTerminalObj.CopyMoaXML(MainMOATerminal: TTerminalObj);
begin
  EposModel := MainMOATerminal.EposModel;
  UpdateTerminals.UpdateXML(PosCode, SiteCode, XMLTempDir + 'xml'+ inttostr(EposdeviceID)+ '.xml');
  FAddendumBuffer := MainMOATerminal.FAddendumBuffer;
end;

procedure TUpdateTerminals.ThreadDone(Sender: TObject);
begin
  UpdateRunning := false;
end;

function TUpdateTerminals.MoaDevicesExist: Boolean;
begin
  with dmThemeData.adoqRun do
  try
    Close;
    SQL.Text := Format(
      'select EposDeviceId from ThemeEposDevice '+
      'where HardwareType in (%d, %d, %d) and IsServer = 0 and SiteCode = dbo.fnGetSiteCode()',
      [ord(ehtMobileOrdering), ord(ehtMOAOrderPad), ord(ehtMOAPayAtTable)]);
    Open;
    Result := RecordCount > 0;
  finally
    Close;
    SQL.Clear;
  end;
end;

function TUpdateTerminals.MOAHostIsRunning: Boolean;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
  exeFileName: string;
begin
  exeFileName := 'MOA_Host.exe';
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  try
    FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
    Result := False;
    while Integer(ContinueLoop) <> 0 do
    begin
      if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
        UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
        UpperCase(ExeFileName))) then
      begin
        Result := True;
        break;
      end;
      ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    end;
  finally
    CloseHandle(FSnapshotHandle);
  end;
end;

end.
