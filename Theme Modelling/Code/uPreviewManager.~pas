unit uPreviewManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ActnList, Menus, adodb, uRunProcess;

type
  // Waiting -> GeneratingXML +-> *GenerationFailed,
  //                          |-> *ParseFailed
  //                          `-> PreviewReady
  // PreviewReady +-> *ExecuteFailed
  //              `-> PreviewRunning +-> PreviewFinished +-> *ExecuteFailed
  //                                 |                   `-> PreviewRunning
  //                                 |-> DefiningMacro +-> PreviewRunning
  //                                 |                 |-> PreviewFinished
  //                                 |                 `-> *ConnectToRunningPreviewFailed
  //                                 |-> PreviewClosing -> PreviewReady
  //                                 `-> *ConnectToRunningPreviewFailed
  //
  // PreStates for close request:
  //   PreviewRunning, DefiningMacro

  TPreviewParams = packed record
    SiteCode, SalesAreaCode, POSCode: integer;
    PanelDesignID: integer;
  end;

  TPreviewStatus = (tsWaiting, tsGeneratingXML, tsParsingXML,
    tsPreviewReady, tsPreviewRunning, tsPreviewFinished,
    tsDefiningMacro, tsClosingPreview,
    tsGenericError, tsXMLGenerationError, tsParseError, tsExecutePreviewError,
    tsConnectToRunningPreviewError);

  TPreviewHardwareType = class(TObject)
  private
    FEPOSTerminalNTCommandSwitch, FDoubleBufferedSwitch: string;
    FPreviewScreenHeight, FPreviewScreenWidth, FGridOffsetX, FGridOffsetY: integer;
    constructor Create(EPOSTerminalCommandSwitch : String; PreviewScreenWidth, PreviewScreenHeight,
       GridOffsetX, GridOffsetY: integer; DoubleBufferedSwitch: String);
  end;

const
  ErrorStates: set of TPreviewStatus = [tsGenericError, tsXMLGenerationError,
    tsParseError, tsExecutePreviewError, tsConnectToRunningPreviewError];
  ReadyStates: set of TPreviewStatus = [tsPreviewReady, tsPreviewFinished];
  RunningStates: set of TPreviewStatus = [tsPreviewRunning, tsDefiningMacro];
  IdleStates: set of TPreviewStatus =
  [tsGenericError, tsXMLGenerationError, tsParseError, tsExecutePreviewError,
    tsConnectToRunningPreviewError, tsWaiting, tsPreviewReady, tsPreviewFinished];
  AnimStates: set of TPreviewStatus = [tsGeneratingXML, tsParsingXML, tsClosingPreview];
  Log_File_Path = 'Zonal\Aztec\Log\ThemeSend.log';
type

  TPreviewRequest = class(TObject)
    FParentList: TStrings;
    ErrorMessage: string;
    FStatus: TPreviewStatus;
    DateRecieved: TDateTime;
    PreviewParams: TPreviewParams;
    EposDeviceID: integer;
    SiteName, SalesAreaName, POSName, PanelDesignName: string;
    OutputFileName: string;
    PreviewProcess: TRunProcess;
    Port: integer;
    EposScreenWidth: integer;
    EposScreenHeight: integer;
    PreviewScreenWidth: integer;
    PreviewScreenHeight: integer;
    PreviewGridOffsetX: integer;
    PreviewGridOffsetY: integer;
    procedure Cleanup;
    procedure ProcessMacro(MacroXML: widestring);
    function GetPreviewHardwareTypeToUse(HardwareType : Integer) : TPreviewHardwareType;
  private
    PreviewHardwareTypes : TStringList;
    procedure FreePreviewHardwareTypeList;
    procedure InitialisePreviewHardwareTypeList;
  public
    LastSQLText: string;
    StatusRect: TRect;
    PanelDesignType: integer;
    ScreenInterfaceID : integer;
    HardwareType: Integer;
    GenericPreview: boolean;
    HasMacros: boolean;
    procedure SetStatus(Value: TPreviewStatus);
    property Status: TPreviewStatus read FStatus write SetStatus;
    function GetDateText: string;
    function GetDescription: string;
    function GetStatusText: string;
    constructor Create(ParentList: TStrings; Params: TPreviewParams);
    destructor Destroy; override;
    procedure StartStopPreview;
    procedure StartStopMacro(Cancel: boolean = false);
    procedure Remove;
    function PollPreviewProcess: boolean;
    procedure BringToFront;
    function GetModel: string;
  end;


  TPreviewBackgroundGenerationThread = class(TThread)
  private
    Connection: TADOConnection;
  public
    XMLGenerated: boolean;
    SQLText: string;
    ErrorMessage: string;
    ConnectionString: string;
    Parameters: TPreviewParams;
    OutputFileName: string;
    constructor Create;
    destructor Destroy; override;
    procedure Execute; override;
  end;

  TPreviewBackgroundParseThread = class(TThread)
  private
  public
    EposDeviceID: integer;
    FileIsValid: boolean;
    HasMacros: boolean;
    ScreenSizeX: integer;
    ScreenSizeY: integer;
    ErrorMessage: string;
    XMLFileName: string;
    procedure Execute; override;
  end;


  TPreviewManager = class(TForm)
    btClearList: TButton;
    sbScrollContainer: TScrollBox;
    lbPreviewRequests: TListBox;
    Bevel1: TBevel;
    btRecordSaveMacro: TButton;
    PopupMenu1: TPopupMenu;
    ActionList1: TActionList;
    ClearPreviewList: TAction;
    StartStopMacro: TAction;
    StartStopPreview: TAction;
    RemoveRequest: TAction;
    StartPreview1: TMenuItem;
    RecordMacro1: TMenuItem;
    RemoveFromList1: TMenuItem;
    btStartStopPreview: TButton;
    AnimRedrawTimer: TTimer;
    PollPreviewProcess: TTimer;
    btClose: TButton;
    CloseForm: TAction;
    lbNoItemsWarning: TLabel;
    CancelMacro: TAction;
    btCancelMacro: TButton;
    CancelMacro1: TMenuItem;
    BringPreviewToFront: TAction;
    Bringtofront1: TMenuItem;
    procedure lbPreviewRequestsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormResize(Sender: TObject);
    procedure ClearPreviewListExecute(Sender: TObject);
    procedure ClearPreviewListUpdate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure AnimRedrawTimerTimer(Sender: TObject);
    procedure RemoveRequestExecute(Sender: TObject);
    procedure RemoveRequestUpdate(Sender: TObject);
    procedure StartStopPreviewUpdate(Sender: TObject);
    procedure StartStopMacroUpdate(Sender: TObject);
    procedure StartStopMacroExecute(Sender: TObject);
    procedure StartStopPreviewExecute(Sender: TObject);
    procedure PollPreviewProcessTimer(Sender: TObject);
    procedure CloseFormExecute(Sender: TObject);
    procedure lbPreviewRequestsDblClick(Sender: TObject);
    procedure CancelMacroUpdate(Sender: TObject);
    procedure CancelMacroExecute(Sender: TObject);
    procedure lbPreviewRequestsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BringPreviewToFrontUpdate(Sender: TObject);
    procedure BringPreviewToFrontExecute(Sender: TObject);
  private
    { Private declarations }
    BackgroundGenerationThread: TPreviewBackgroundGenerationThread;
    BackgroundParseThread: TPreviewBackgroundParseThread;
    GeneratingRequest: TPreviewRequest;
    RecordingRequest: TPreviewRequest;
    procedure RedrawStatus(RequestID: integer);
    procedure SaveFormPosition;
    procedure LoadFormPosition;
    procedure StartGeneration;
    procedure UpdateListGUI;
  public
    { Public declarations }
    PreviewRunning : Boolean;
    procedure AddPreviewRequest(SiteCode, SalesAreaCode, POSCode, PanelDesignID: integer);
    procedure HandleGenerationFinished(Sender: TObject);
    procedure HandleParseFinished(Sender: TObject);

  protected
    procedure CreateParams(var Params: TCreateParams) ; override;
  end;

var
  PreviewManager: TPreviewManager;

implementation

uses Math, registry, uDMThemeData, typinfo, uXMLSave, uAztecDatabaseUtils,
  useful, uAztecZoeComms, uWidestringUtils, msxml, winsock, clipbrd, uSystemUtils;

{$R *.dfm}

function GetProgressWheelFrame: integer;
begin
  Result := (gettickcount div 80) mod 26;
end;

function LogFilePath(): String;
begin
  Result := EnsureTrailingSlash(GetProgramFilesDir) + Log_File_Path;
end;

procedure TPreviewManager.lbPreviewRequestsDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  ControlRect: TRect;
  ControlCanvas: TCanvas;
  Bitmap: TBitmap;
  img: hicon;
  Canvas: TCanvas;
  svs: integer;
  TimeText: string;
  Request: TPreviewRequest;
  FrameID: string;
  MainImageName: string;
  DescRect: TRect;
  TimeX: integer;
  Str1, Str2: string;
begin
  if TListBox(Control).Count = 0 then exit;
  Request := TPreviewRequest(TListBox(Control).Items.Objects[Index]);
  ControlCanvas := TListBox(Control).Canvas;
  ControlRect := Rect;

  Bitmap := TBitmap.Create;
  Bitmap.Width := rect.Right-rect.left;
  Bitmap.Height := rect.bottom-rect.Top;
  Canvas := bitmap.Canvas;
  Canvas.Font.Assign(ControlCanvas.Font);
  Canvas.Pen.Assign(ControlCanvas.Pen);
  Canvas.Brush.Assign(ControlCanvas.Brush);

  rect := Classes.Rect(0, 0, Bitmap.width, bitmap.height);

  Canvas.Lock;
  Canvas.Brush.Style := bsSolid;
  Canvas.FillRect(Rect);
  FrameID := Format('ProgressWheel16_Frame%2.2d', [GetProgressWheelFrame()]);

  case Request.PanelDesignType of
    2: MainImageName := 'Z32x32_Z500_Icon';
    3: MainImageNAme := 'Z32x32_HandHeld_Icon';
    4: MainImageName := 'Z32x32_I700_Icon';
    5: MainImageName := 'Z32x32_XPPOS_Icon';
    7: MainImageName := 'Z32x32_7500_Icon';
  else
    MainImageName := 'Z32x32_Z300_Icon';
  end;

  img := LoadImage(HInstance, PChar(MainImageName), IMAGE_ICON, 0, 0, LR_SHARED);

  DrawIconEx(canvas.Handle, Rect.Left+8, Rect.Top+8,
    img,
    32, 32, 0, 0, DI_Normal
  );

  svs := canvas.Font.Size;
  canvas.Font.Size := (canvas.Font.Size * 8) div 9;
  canvas.Font.Style := [fsItalic];
  canvas.Brush.Style := bsClear;
  timetext := Request.GetDateText;
  TimeX := rect.Right - canvas.TextWidth(TimeText)-4;
  canvas.Textout(TimeX, rect.Top+2, TimeText);
  canvas.Font.Style := [];
  Canvas.Font.Size := svs;

  Canvas.Font.Style := [];

  DescRect.Left := Rect.Left+lbPreviewRequests.ItemHeight;
  DescRect.Right := TimeX;
  Request.StatusRect.Left := Rect.Left+lbPreviewRequests.ItemHeight+4;
  Request.StatusRect.Right := Rect.Right-2;

  if Canvas.TextWidth(Request.GetDescription) <= (TimeX-lbPreviewRequests.ItemHeight) then
  begin
    DescRect.Top := Rect.Top+7;
    DescRect.Bottom := Rect.Top+21;
    Request.StatusRect.Top := Rect.Top+21;
    Request.StatusRect.Bottom := Rect.Bottom-2;
  end
  else
  begin
    DescRect.Top := Rect.Top+3;
    DescRect.Bottom := Rect.Top+31;
    Request.StatusRect.Top := Rect.Top+31;
    Request.StatusRect.Bottom := Rect.Bottom-2;
  end;

  Str1 := Request.GetDescription;
  while (Canvas.TextWidth(Str1) > (DescRect.Right-DescRect.Left)) and (pos(' ', Str1) <> 0) do
  begin
    SetLength(Str1, RevPos(' ', Str1)-1);
  end;
  Str2 := trim(copy(Request.GetDescription, Length(Str1)+1, Length(Request.GetDescription)));

  DrawTextEx(Canvas.Handle, PChar(Str1), -1, DescRect,
    DT_NOPREFIX or DT_END_ELLIPSIS, nil);
  DescRect.top := DescRect.top + 15;
  DrawTextEx(Canvas.Handle, PChar(Str2), -1, DescRect,
    DT_NOPREFIX or DT_PATH_ELLIPSIS, nil);

  Canvas.Font.Style := [fsBold];

  if (Request.StatusRect.Bottom - Request.StatusRect.Top) > 20 then
    DrawTextEx(Canvas.Handle, PChar(Request.GetStatusText), -1, Request.StatusRect,
      DT_WORDBREAK or DT_END_ELLIPSIS or DT_WORD_ELLIPSIS, nil)
  else
    DrawTextEx(Canvas.Handle, PChar(Request.GetStatusText), -1, Request.StatusRect,
      DT_SINGLELINE or DT_END_ELLIPSIS or DT_WORD_ELLIPSIS, nil);

  if Request.Status in AnimStates then
  begin
    img := LoadImage(HInstance, PChar(FrameID), IMAGE_ICON, 0, 0, LR_SHARED);
    DrawIconEx(canvas.Handle, Request.StatusRect.Left + 6 + Canvas.TextWidth(Request.GetStatusText), Request.StatusRect.top,
      img,
      16, 16, 0, 0, DI_NORMAL
    );
  end;

  canvas.Pen.Color := cl3DLight;
  canvas.MoveTo(Rect.Left, Rect.Bottom-1);
  canvas.LineTo(rect.Right, rect.Bottom-1);

  Canvas.Unlock;

  ControlCanvas.Lock;
  BitBlt(ControlCanvas.Handle, ControlRect.Left, ControlRect.Top, Bitmap.Width, Bitmap.Height,
    Bitmap.Canvas.Handle, 0, 0, SRCCOPY);
  ControlCanvas.Unlock;
  Bitmap.Free;
end;

procedure TPreviewManager.RedrawStatus(RequestID: integer);
var
  BoundsRect, StatusRect: TRect;
  Request: TPreviewRequest;
  Canvas: TCanvas;
  img: THandle;
  FrameID: string;
begin
  Canvas := lbPreviewRequests.Canvas;
  with Canvas do
    if RequestID = lbPreviewRequests.ItemIndex then
    begin
      Brush.Color := clHighlight;
      Font.Color := clHighlightText;
    end
    else
    begin
      Brush.Color := clWindow;
      Font.Color := clWindowText;
    end;

  BoundsRect := lbPreviewRequests.ItemRect(RequestID);
  Request := TPreviewRequest(lbPreviewRequests.Items.Objects[RequestID]);
  StatusRect := Request.StatusRect;
  StatusRect.Top := StatusRect.Top + boundsrect.top;
  StatusRect.Bottom := StatusRect.Bottom + boundsrect.top;
  canvas.Brush.Style := bsSolid;
  Canvas.Font.Style := [fsBold];

  Canvas.Lock;
  Canvas.FillRect(StatusRect);
  if (Request.StatusRect.Bottom - Request.StatusRect.Top) > 20 then
    DrawTextEx(Canvas.Handle, PChar(Request.GetStatusText), -1, StatusRect,
      DT_WORDBREAK or DT_END_ELLIPSIS or DT_WORD_ELLIPSIS, nil)
  else
    DrawTextEx(Canvas.Handle, PChar(Request.GetStatusText), -1, StatusRect,
      DT_SINGLELINE or DT_END_ELLIPSIS or DT_WORD_ELLIPSIS, nil);

  if Request.Status in AnimStates then
  begin
    FrameID := Format('ProgressWheel16_Frame%2.2d', [GetProgressWheelFrame()]);
    img := LoadImage(HInstance, PChar(FrameID), IMAGE_ICON, 0, 0, LR_SHARED);
    DrawIconEx(canvas.Handle, StatusRect.Left + 6 + Canvas.TextWidth(Request.GetStatusText), StatusRect.Top,
      img,
      16, 16, 0, 0, DI_NORMAL
    );
  end;
  Canvas.Unlock;
  Canvas.Font.Style := [];
end;

procedure TPreviewManager.FormResize(Sender: TObject);
var
  i: integer;
begin
  with lbPreviewRequests.Canvas do
  begin
    font.Color := clWindowText;
    pen.Color := clWindowText;
    brush.Color := clWindow;
  end;
  for i := 0 to pred(lbPreviewRequests.Count) do
  begin
    if i <> lbPreviewRequests.ItemIndex then
      lbPreviewRequests.OnDrawItem(lbPreviewRequests, i, lbPreviewRequests.ItemRect(i), []);
  end;
end;

{ TPreviewRequest }

procedure TPreviewRequest.BringToFront;
begin
  PreviewProcess.BringToFront;
end;

procedure TPreviewRequest.Cleanup;
begin
  if FileExists(OutputFileName) then
    DeleteFile(OutputFileName);
end;

constructor TPreviewRequest.Create(ParentList: TStrings; Params: TPreviewParams);
begin
  inherited Create;
  PreviewProcess := TRunProcess.Create;
  FParentList := PArentList;
  DateRecieved := now;
  PreviewParams := Params;
  with Params do
  begin
    HasMacros := false;
    GenericPreview := (SiteCode = -1) and (SalesAreaCode = -1) and (POSCode = -1);
    dmThemeData.GetPreviewDetails(SiteCode, SalesAreaCode, POSCode, PanelDesignID,
      SiteName, SalesAreaName, POSName, PanelDesignName, PanelDesignType, EposDeviceID,
      ScreenInterfaceID, HardwareType);
  end;
  InitialisePreviewHardwareTypeList;
  FStatus := tsWaiting;
end;

// TODO: Load this from data somewhere rather than hard coding
procedure TPreviewRequest.InitialisePreviewHardwareTypeList;
begin
  PreviewHardwareTypes := TStringList.Create;
  PreviewHardwareTypes.AddObject('0', TPreviewHardwareType.Create('Z500',800,600,1,6,''));
  PreviewHardwareTypes.AddObject('3', TPreviewHardwareType.Create('Hand',240,320,0,0,''));
  PreviewHardwareTypes.AddObject('7', TPreviewHardwareType.Create('i700',1024,768,1,6,'/A'));
  PreviewHardwareTypes.AddObject('9', TPreviewHardwareType.Create('WIN10POS',1024,768,1,6,'/A')); // for 'XP POS' type tills to take Large model
  PreviewHardwareTypes.AddObject('33', TPreviewHardwareType.Create('WIN10POS',1024,768,1,6,'/A'));
end;

destructor TPreviewRequest.Destroy;
begin
  FreePreviewHardwareTypeList;
  PreviewProcess.Destroy;
  inherited;
end;

procedure TPreviewRequest.FreePreviewHardwareTypeList;
var
  i : Integer;
begin
  for i := 0 to PreviewHardwareTypes.Count - 1 do
    PreviewHardwareTypes.Objects[i].Free;
  PreviewHardwareTypes.Free;
end;

function TPreviewRequest.GetDateText: string;
begin
  if (DateRecieved < floor(now)) then
  begin
    if floor(DateRecieved) = floor(now)-1 then
      result := 'Yesterday'
    else
      result := Format('%d days ago', [floor(now)-floor(DateRecieved)]);
  end
  else
    result := FormatDateTime('hh:mm:ss', DateRecieved);
end;

function TPreviewRequest.GetDescription: string;
var
  DescriptionText: string;
begin
  if GenericPreview then
    DescriptionText := Format('Panel Design Preview of "%s"', [PanelDesignName])
  else
    DescriptionText := Format('Preview of "%s" for %s\%s\%s',
      [PanelDesignName, SiteName, SalesAreaName, POSName]);
  Result := DescriptionText;
end;

function TPreviewRequest.GetModel: string;
var
  Model: string;
  Dom, StyleSheet: IXMLDOMDocument;
begin
  if FileExists(OutputFileName) then
  begin
    Model := uWideStringUtils.ReadWidestringFromFile(OutputFileName);
    // pretty print XML model
    StyleSheet := CoDOMDocument.create;
    StyleSheet.loadXML(
      '<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> '+
      '<xsl:output method="xml"/> '+
      '<xsl:param name="indent-increment" select="''&#x9;''" /> '+
      '<xsl:template match="*"> '+
      '   <xsl:param name="indent" select="''&#xA;''"/> '+
      '   <xsl:value-of select="$indent"/> '+
      '   <xsl:copy> '+
      '     <xsl:copy-of select="@*" /> '+
      '     <xsl:apply-templates> '+
      '       <xsl:with-param name="indent" '+
      '            select="concat($indent, $indent-increment)"/> '+
      '     </xsl:apply-templates> '+
      '     <xsl:if test="*"> '+
      '       <xsl:value-of select="$indent"/> '+
      '     </xsl:if> '+
      '   </xsl:copy> '+
      '</xsl:template> '+
      '<xsl:template match="comment()|processing-instruction()"> '+
      '  <xsl:copy /> '+
      '</xsl:template> '+
      '<xsl:template match="text()[normalize-space(.)='''']"/> '+
      '</xsl:stylesheet>'
    );
    Dom := CoDOMDocument.Create;
    Dom.loadXML(Model);
    result := Dom.firstChild.transformNode(StyleSheet);
  end;
end;

function TPreviewRequest.GetStatusText: string;
var
  StatusText: string;
  i: integer;
begin
  StatusText := GetEnumName(TypeInfo(TPreviewStatus), Integer(Status));
  StatusText := Copy(StatusText, 3, Length(StatusText));
  for i := Length(StatusText)-1 downto 2 do
    if ((StatusText[i+1] > 'Z') and (StatusText[i] <= 'Z')) or
      ((StatusText[i-1] > 'Z') and (StatusText[i] <= 'Z')) then
      Insert(' ', StatusText, i);

  Result := StatusText;
  if (Status in ErrorStates) and (Length(ErrorMessage) > 0) then
    Result := Result + ' : ' + ErrorMessage;
end;

procedure TPreviewManager.AddPreviewRequest(SiteCode, SalesAreaCode, POSCode,
  PanelDesignID: integer);
var
  PreviewParams: TPreviewParams;
  PreviewRequest: TPreviewRequest;
  MoveAmount: integer;
begin
  PreviewParams.SiteCode := SiteCode;
  PreviewParams.SalesAreaCode := SalesAreaCode;
  PreviewParams.POSCode := POSCode;
  PreviewParams.PanelDesignID := PanelDesignID;

  PreviewRequest := TPreviewRequest.Create(lbPreviewRequests.Items, PreviewParams);
  lbPreviewRequests.Items.AddObject(PreviewRequest.GetDescription, PreviewRequest);
  UpdateListGUI;
  MoveAmount := lbPreviewRequests.Height - (sbScrollContainer.ClientHeight + sbScrollContainer.VertScrollBar.Position);
  if MoveAmount > 0 then
    sbScrollContainer.VertScrollBar.Position := sbScrollContainer.VertScrollBar.Range - sbScrollContainer.ClientHeight;

  if GeneratingRequest = nil then
    StartGeneration;
  self.Visible := true;
  self.BringToFront;
end;

procedure TPreviewManager.LoadFormPosition;
var
  NewLeft, NewTop, NewWidth, NewHeight: integer;
begin
  NewLeft := Screen.DesktopLeft;
  NewTop := Screen.DesktopTop;
  NewWidth := ClientWidth;
  NewHeight := ClientHeight;
  with TRegistry.create do
  begin
    RootKey := HKEY_CURRENT_USER;
    if OpenKeyReadOnly('Software\Zonal\Aztec\AZTM') then
    begin
      if ValueExists('ThemePreviewManager.Left') then
        NewLeft := ReadInteger('ThemePreviewManager.Left');
      if ValueExists('ThemePreviewManager.Top') then
        NewTop := ReadInteger('ThemePreviewManager.Top');
      if ValueExists('ThemePreviewManager.Width') then
        NewWidth := ReadInteger('ThemePreviewManager.Width');
      if ValueExists('ThemePreviewManager.Height') then
        NewHeight := ReadInteger('ThemePreviewManager.Height');

      CloseKey;
    end;
    Free;
  end;
  Left := Min(Screen.DesktopWidth, NewLeft);
  Top := Min(Screen.DesktopHeight, NewTop);
  ClientWidth := NewWidth;
  ClientHeight := NewHeight;
end;

procedure TPreviewManager.SaveFormPosition;
begin
  with TRegistry.Create do
  begin
    RootKey := HKEY_CURRENT_USER;
    if OpenKey('Software\Zonal\Aztec\AZTM', True) then
    begin
      WriteInteger('ThemePreviewManager.Left', Left);
      WriteInteger('ThemePreviewManager.Top', Top);
      WriteInteger('ThemePreviewManager.Width', ClientWidth);
      WriteInteger('ThemePreviewManager.Height', ClientHeight);
      CloseKey;
    end;
    Free;
  end;
end;

procedure TPreviewManager.ClearPreviewListExecute(Sender: TObject);
var
  i: integer;
begin
  for i := pred(lbPreviewRequests.count) downto 0 do
    TPreviewRequest(lbPreviewRequests.items.Objects[i]).Remove;
  UpdateListGUI;
end;

procedure TPreviewManager.ClearPreviewListUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := lbPreviewRequests.Count > 0;
end;

procedure TPreviewManager.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := GetDesktopWindow;
  GeneratingRequest := nil;
  RecordingRequest := nil;
end;

procedure TPreviewManager.FormDestroy(Sender: TObject);
begin
  SaveFormPosition;
  ClearPreviewList.Execute;
end;

procedure TPreviewManager.FormShow(Sender: TObject);
begin
  LoadFormPosition;
  UpdateListGUI;

  if not (IsMaster) then
  begin
    btRecordSaveMacro.Visible := false;
    btCancelMacro.Visible := false;
  end;
end;

procedure TPreviewManager.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SaveFormPosition;
end;

procedure TPreviewManager.PopupMenu1Popup(Sender: TObject);
var
  CursorPos: TPoint;
begin
  GetCursorPos(CursorPos);
  lbPreviewRequests.ItemIndex :=
    lbPreviewRequests.ItemAtPos(lbPreviewRequests.ScreenToClient(CursorPos), true)
end;

function TPreviewRequest.PollPreviewProcess: boolean;
begin
  if (Status in RunningStates + [tsClosingPreview]) and PreviewProcess.HasExited then
  begin
    Status := tsPreviewFinished;
    PreviewManager.PreviewRunning := False;
    if PreviewManager.RecordingRequest = self then
    begin
      PreviewManager.RecordingRequest := nil;
    end;
    Result := true;
  end
  else
    Result := false;
end;

procedure TPreviewRequest.ProcessMacro(MacroXML: widestring);
type
  TMacroItem = packed record
    Descriptor: string; X,Y: integer;
  end;
var
  UpdateDoc: IXMLDOMDocument;
  UpdateMacroNode: IXMLDOMNode;
  UpdateMacroClicks: IXMLDOMNodeList;

  ModelDoc: IXMLDOMDocument;
  ModelDocMacroNode: IXMLDOMNode;
  i: integer;
  MacroID: integer;
  MacroClicks: array of TMacroItem;
begin
  UpdateDoc := CoDOMDocument.Create;
  UpdateDoc.loadXML(MacroXML);
  if UpdateDoc.parseError.errorCode = 0 then
  begin
    // Find macro XML
    UpdateMacroNode := UpdateDoc.selectSingleNode('//Macro');
    if UpdateMacroNode = nil then
      raise Exception.Create('Preview terminal did not return a macro.');
    MacroID := UpdateMacroNode.attributes.getNamedItem('GUIDO').nodeValue;
    UpdateMacroClicks := UpdateDoc.selectNodes('//Macro/ZealScript/ClickGUI');
    SetLength(MacroClicks, UpdateMacroClicks.length);
    for i := 0 to pred(UpdateMacroClicks.length) do
    begin
      with MacroClicks[i] do
      begin
        Descriptor := UpdateMacroClicks[i].attributes.getNamedItem('Descriptor').nodeValue;
        X := UpdateMacroClicks[i].attributes.getNamedItem('X').nodeValue;
        Y := UpdateMacroClicks[i].attributes.getNamedItem('Y').nodeValue;
        // TODO: remove this shim when the POS can scale macros
        if (PreviewScreenWidth <> EposScreenWidth) then
        begin
          // fix up pos coordinates due to preview shown via "squished" z500
          // n.b. border sizes are the same for both resolutions
          X := Round(PreviewGridOffsetX+((x-PreviewGridOffsetX) * (EposScreenWidth-(2 * PreviewGridOffsetX)))
                / ((PreviewScreenWidth-(2 * PreviewGridOffsetX))*1.0));
          Y := Round(PreviewGridOffsetY+((y-PreviewGridOffsetY) * (EposScreenHeight-(2 * PreviewGridOffsetY)))
                / ((PreviewScreenHeight-(2* PreviewGridOffsetY))*1.0));
          UpdateMacroClicks[i].attributes.getNamedItem('X').nodeValue := X;
          UpdateMacroClicks[i].attributes.getNamedItem('Y').nodeValue := Y;
        end;
      end;
    end;
    dmThemeData.adoqRun.SQL.Text := Format(
      'delete ThemePanelDesignMacroClick where MacroID = %d', [MacroID]
    );
    dmThemeData.adoqRun.ExecSQL;

    for i := 0 to pred(UpdateMacroClicks.length) do
    begin
      with MacroClicks[i] do
      begin
        dmThemeData.adoqRun.SQL.Text := format(
          'insert ThemePanelDesignMacroClick (MacroID, ClickID, Descriptor, X, Y) values (%d, %d, %s, %d, %d)',
          [MacroID, i, QuotedStr(Descriptor), X, Y]
        );
        dmThemeData.adoqRun.ExecSQL;
      end;
    end;

    // Update EPOS model
    ModelDoc := CoDOMDocument.Create;
    ModelDoc.load(OutputFileName);
    if ModelDoc.parseError.errorCode = 0 then
    begin
      ModelDocMacroNode := ModelDoc.selectSingleNode(Format('//EPoSModel/Macros/Macro[@GUIDO=%d]', [MacroID]));
      if ModelDocMacroNode = nil then
        raise Exception.create('Could not find macro to update in EPOS Model.');
      ModelDocMacroNode.parentNode.replaceChild(UpdateMacroNode, ModelDocMacroNode);
      ModelDoc.save(OutputFileName);
    end;
  end
  else
    raise Exception.Create('Preview terminal returned invalid Macro XML.');
end;

procedure TPreviewRequest.Remove;
begin
  if Status in RunningStates then
    Status := tsWaiting;
  if Status in IdleStates then
  begin
    Cleanup;
    FParentList.Delete(FParentList.IndexOfObject(self));
    Free;
  end;
end;

procedure TPreviewRequest.SetStatus(Value: TPreviewStatus);
begin
  FStatus := Value;
  PreviewManager.RedrawStatus(PreviewManager.lbPreviewRequests.Items.IndexOfObject(Self));
end;

{ TPreviewBackgroundThread }

constructor TPreviewBackgroundGenerationThread.Create;
begin
  inherited Create(True);
  Connection := TADOConnection.create(nil);
  OutputFileName := Format('%sThemePreview_%u%u.xml', [useful.GetTempDir, GetCurrentThreadID, GetTickCount]);
end;

destructor TPreviewBackgroundGenerationThread.Destroy;
begin
  Connection.Free;
  inherited;
end;

procedure TPreviewBackgroundGenerationThread.Execute;
var
  i: integer;
  TmpError: string;
begin
  inherited;
  Connection.LoginPrompt := false;
  SetupAztecADOConnection(Connection);

  Connection.Open();
  SQLText := Format('Theme_GenerateEposModel %d, %d, %d, %d, %d',
    [Parameters.SiteCode, Parameters.SalesAreaCode, Parameters.PanelDesignID, Parameters.POSCode, 1]);
  XMLGenerated := false;
  ErrorMessage := '';
  try
    uWideStringUtils.WriteWidestringToFile(
      uXMLSave.GetXMLStream(Connection, SQLText),
      OutputFileName
    );
    XMLGenerated := true;
  except on E:Exception do
    begin
      for i := 0 to pred(Connection.Errors.Count) do
      begin
        TmpError := Connection.Errors[i].Description;
        // Ignore normal status reports from the s.p. and SQL warnings
        if (Length(TmpError) > 0) and (Pos('Warning: ', TmpError) = 0)
          and (Pos(FormatDateTime('yyyy-mm-', now), TmpError) = 0) then
          begin
            if Length(ErrorMessage) > 0 then
              ErrorMessage := ErrorMessage + '; ';
            ErrorMessage := ErrorMessage + TmpError;
          end;
      end;
    end;
  end;
end;

procedure TPreviewManager.HandleGenerationFinished;
var
  XMLGenerated: boolean;
begin
  with GeneratingRequest do
  begin
    ErrorMessage := BackgroundGenerationThread.ErrorMessage;
    OutputFileName := BackgroundGenerationThread.OutputFileName;
    XMLGenerated := BackgroundGenerationThread.XMLGenerated;
    LastSQLText := BackgroundGenerationThread.SQLText;
    useful.TextLog('Preview XML generation executed: '+BackgroundGenerationThread.SQLText, LogFilePath);
    if XMLGenerated then
      useful.TextLog('Preview XML generation successful.', LogFilePath)
    else
    begin
      useful.TextLog('Preview XML generation failed: '+ErrorMessage, LogFilePath);
    end;

    if XMLGenerated then
    begin
      Status := tsParsingXML;
      BackgroundParseThread := TPreviewBackgroundParseThread.Create(true);
      BackgroundParseThread.EposDeviceID := EposDeviceID;
      BackgroundParseThread.FreeOnTerminate := true;
      BackgroundParseThread.XMLFileName := OutputFileName;
      BackgroundParseThread.OnTerminate := HandleParseFinished;
      BackgroundParseThread.Priority :=tpLowest;
      BackgroundParseThread.Resume;
    end
    else
    begin
      Status := tsXMLGenerationError;
      StartGeneration;
    end;
  end;
end;

procedure TPreviewManager.StartGeneration;
var
  i: integer;
begin
  GeneratingRequest := nil;
  for i := 0 to pred(lbPreviewRequests.Count) do
  begin
    with TPreviewRequest(lbPreviewRequests.Items.Objects[i]) do
    begin
      if (Status = tsWaiting) then
      begin
        GeneratingRequest := TPreviewRequest(lbPreviewRequests.Items.Objects[i]);
        break;
      end;
    end;
  end;
  if GeneratingRequest <> nil then
  begin
    useful.TextLog('Starting preview', LogFilePath);
    GeneratingRequest.Status := tsGeneratingXML;
    BackgroundGenerationThread := TPreviewBackgroundGenerationThread.create;
    BackgroundGenerationThread.FreeOnTerminate := true;
    BackgroundGenerationThread.Priority :=tpLowest;
    BackgroundGenerationThread.ConnectionString := dmThemeData.AztecConn.ConnectionString;
    BackgroundGenerationThread.Parameters := GeneratingRequest.PreviewParams;
    BackgroundGenerationThread.OnTerminate := HandleGenerationFinished;
    BackgroundGenerationThread.Resume;
  end;
end;



procedure TPreviewManager.AnimRedrawTimerTimer(Sender: TObject);
begin
  if GeneratingRequest <> nil then
    RedrawStatus(lbPreviewRequests.Items.IndexOfObject(GeneratingRequest));
end;

procedure TPreviewRequest.StartStopMacro(Cancel: boolean = false);
type
  Zoe_EPoSTerminalProxy_startRecordingMacro = function (ipAddress : pWideChar; id{,port} : integer; returnMessage : pWideChar; var returnCode : integer) : WORDBOOL; cdecl;
  Zoe_EPoSTerminalProxy_stopRecordingMacro = function (ipAddress : pWideChar; id{,port} : integer; buffer : pWideChar; bufferSize : integer; returnMessage : pWideChar; var returnCode : integer) : WORDBOOL; cdecl;
var
  hZoeDll : cardinal;
  ZoeStartMacro: Zoe_EPoSTerminalProxy_startRecordingMacro;
  ZoeStopMacro: Zoe_EPoSTerminalProxy_stopRecordingMacro;
  ReturnMessage: array[0..511] of widechar;
  XML: array[0..20000] of widechar;
  ReturnCode: integer;
  Ticks: cardinal;
begin
  if Assigned(PreviewManager.RecordingRequest) and (PreviewManager.RecordingRequest <> Self) then
    raise Exception.Create('Attempt to record more then one macro at a time.');
  hZoeDll := SafeLoadLibrary(uSystemUtils.GetZOEDLLPath, SEM_FAILCRITICALERRORS or SEM_NOOPENFILEERRORBOX);
  ZoeStartMacro := GetProcAddress(hZoeDll, 'Zoe_EPoSTerminalProxy_startRecordingMacro');
  ZoeStopMacro := GetProcAddress(hZoeDll, 'Zoe_EPoSTerminalProxy_stopRecordingMacro');

  BringToFront;
  if Status = tsPreviewRunning then
  begin
    // Start Macro
    if ZoeStartMacro('127.0.0.1', {EposDeviceID, Port}Port-(16000), ReturnMessage, ReturnCode) then
    begin
      Status := tsDefiningMacro;
      PreviewManager.RecordingRequest := self;
    end;
  end
  else
  begin
    // Stop Macro
    if ZoeStopMacro('127.0.0.1', {EposDeviceID, Port}Port-(16000), XML, 20000, ReturnMessage, ReturnCode) then
    begin
      if (Length(widestring(XML)) = 0) and not Cancel then
      begin
        MessageDlg('Please select the macro to record on the EPOS preview, then click one or more buttons to record the steps of the macro.', mtError, [mbOk], 0);
        Status := tsPreviewRunning;
        StartStopMacro(false);
      end
      else
      begin
        PreviewManager.RecordingRequest := nil;
        Status := tsPreviewRunning;
        if not Cancel then
        begin
          ProcessMacro(widestring(XML));
          // Restart the preview with the new XML
          StartStopPreview;
          Ticks := GetTickCount;
          while (Status <> tsPreviewFinished) and (GetTickCount < Ticks + 2000) do
          begin
            PollPreviewProcess;
            Sleep(50);
          end;
          if Status = tsPreviewFinished then
            StartStopPreview
          else
            raise Exception.Create('Failed to restart preview after macro record. Please start it manually.');
        end;
      end;
    end;
  end;
  FreeLibrary(hZoeDll);
end;

var WinSockStarted: boolean = false;

procedure CheckWinSock;
var
  WSData: TWSAData;
begin
  if not(WinsockStarted) then
    if WSAStartup($101, wsData) = SOCKET_ERROR then
      raise Exception.create('TNMReceiveStream: Could not initialise winsock')
    else
      WinsockStarted := true;
end;

procedure SockCheck(returncode: integer);
var
  iErr: integer;
begin
  if returncode = SOCKET_ERROR then
  begin
    iErr := WSAGetLastError;
    Raise Exception.Create('Socket error #'+inttostr(iErr));
  end;
end;

function GetPreviewPort: cardinal;
var
  TempSocket: TSocket;
  SockAddr: TSockAddr;
  Port: integer;
  socketok: boolean;
begin
  // Port scan for a free local port in the standard EPOS range
  CheckWinSock;
  Port := 16000;
  ZeroMemory(@SockAddr, SizeOf(SockAddr));
  SocketOK := false;
  while (SocketOK = false) and (Port < (16000+32000)) do
  begin
    TempSocket := winsock.Socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
    if TempSocket = INVALID_SOCKET then
      Raise Exception.create('Could not allocate socket');
    try
      SockAddr.sin_family := PF_INET;
      SockAddr.sin_port := htons(Port);
      SockAddr.sin_addr.S_addr :=  INADDR_ANY;
      SockCheck(Bind(TempSocket, SockAddr, SizeOf(TSockAddr)));
      SocketOk := True;
    except
      inc(port);
    end;
    CloseSocket(TempSocket);
  end;
  result:=port;
end;


procedure TPreviewRequest.StartStopPreview;
var
  Params, DeviceType, IdentifySwitch, DoubleBufferedSwitch: string;
  PreviewHardwareType : TPreviewHardwareType;
begin
  if Status in RunningStates then
  begin
    PreviewProcess.Stop;
    Status := tsClosingPreview;
  end
  else
  if Status in ReadyStates then
  begin
    Port := GetPreviewPort;

    PreviewHardwareType := GetPreviewHardwareTypeToUse(HardwareType);

    DeviceType := PreviewHardwareType.FEPOSTerminalNTCommandSwitch;
    PreviewScreenWidth := PreviewHardwareType.FPreviewScreenWidth;
    PreviewScreenHeight := PreviewHardwareType.FPreviewScreenHeight;
    PreviewGridOffsetX := PreviewHardwareType.FGridOffsetX;
    PreviewGridOffsetY := PreviewHardwareType.FGridOffsetY;
    DoubleBufferedSwitch := PreviewHardwareType.FDoubleBufferedSwitch;

    if EPOSDeviceID = -1 then
      IdentifySwitch := '/E '
    else
      IdentifySwitch := '';

    Params := Format('/P /H %s/N"%s" /O"%d" /M"%s" /D"%s" %s', [
      IdentifySwitch,
      StringReplace(GetDescription, '"', '''', [rfReplaceAll]),
      Port,
      OutputFileName,
      DeviceType,
      DoubleBufferedSwitch
    ]);

    if EposDeviceID <> -1 then
      Params := Params + Format(' /I"%d"', [EposDeviceID]);

    useful.TextLog('Executing preview: '+Params, LogFilePath);

    try
      PreviewProcess.Start(
        ExtractFilePath(Application_Exename)+'EPOSTerminalNT\EPOSTerminalNT.exe',
        Params,
        ExtractFilePath(Application_Exename)+'EPOSTerminalNT',
        true
        );
      Status := tsPreviewRunning;
      PreviewManager.PreviewRunning := True;
    except on E:Exception do
      begin
        ErrorMessage := E.Message;
        Status := tsExecutePreviewError;
        useful.TextLog('Error executing preview: '+ErrorMessage, LogFilePath);
      end;
    end;
  end;
end;

function TPreviewRequest.GetPreviewHardwareTypeToUse(HardwareType: Integer) : TPreviewHardwareType;
var
  index : Integer;
  PreviewHardwareType : TPreviewHardwareType;
begin
  index := -1;
  if HardwareType >= 0 then
    index := PreviewHardwareTypes.IndexOf(IntToStr(HardwareType));
  if index >= 0 then
    PreviewHardwareType := TPreviewHardwareType(PreviewHardwareTypes.Objects[index])
  else
    PreviewHardwareType := TPreviewHardwareType(PreviewHardwareTypes.Objects[0]);   // use Z500 by default

  result := PreviewHardwareType;
end;

{ TPreviewBackgroundParseThread }

procedure TPreviewBackgroundParseThread.Execute;
var
  hZoeDll: THandle;
  fnParseModel : function(ID:integer; Model : pWideChar; returnMessage : pWideChar; var returnCode : integer) : WORDBOOL; cdecl;
  EposModel: widestring;
  ReturnMessage: array[0..511] of widechar;
  ReturnCode: integer;
  TempErrorMessage: TStrings;
  i: integer;
  DOM: IXMLDOMDocument;
  MacroNodeList: IXMLDOMNodeList;
  ScreenLayoutNode: IXMLDOMNode;
begin
  inherited;
  FileIsValid := false;
  HasMacros := false;
  ErrorMessage := 'Could not load ZoeDLL';
  hZoeDll := SafeLoadLibrary(uSystemUtils.GetZOEDLLPath, SEM_FAILCRITICALERRORS or SEM_NOOPENFILEERRORBOX);
  if hZoeDLL <> 0 then try
    fnParseModel := GetProcAddress(hZoeDll, 'Zoe_parse');
    if assigned(fnParseModel) then
    begin
      EposModel := uWideStringUtils.ReadWidestringFromFile(XMLFileName);
      if fnParseModel(EposDeviceID, PWideChar(EposModel), ReturnMessage, ReturnCode) then
      begin
        FileIsValid := true;
        ErrorMessage := '';
        DOM := CoDOMDocument.Create;
        DOM.loadXML(EposModel);
        if dom.parseError.errorCode = 0 then
        begin
          ScreenLayoutNode := DOM.selectSingleNode('//EPoSModel/Touchscreen/ScreenLayout');
          ScreenSizeX := ScreenLayoutNode.attributes.GetNamedItem('Width').nodeValue;
          ScreenSizeY := ScreenLayoutNode.attributes.GetNamedItem('Height').nodeValue;
          MacroNodeList := DOM.selectNodes('//EPoSModel/Macros/Macro');
          HasMacros := Assigned(MacroNodeList) and (MacroNodeList.length > 0);
        end;
        DOM := nil;
      end
      else
      begin
        FileIsValid := false;
        ErrorMessage := '';
        TempErrorMessage := TStringlist.create;
        TempErrorMessage.Text := WideCharToString(ReturnMessage);
        for i := pred(TempErrorMessage.Count) downto 0 do
        begin
          if Pos('XML_PARSE_ERROR', TempErrorMessage[i]) = 0 then
          begin
            if ErrorMessage <> '' then
              ErrorMessage := ErrorMessage + '; ';
            if POS('Message: ', TempErrorMessage[i]) > 0 then
              ErrorMessage := ErrorMessage +
                StringReplace(TempErrorMessage[i], 'Message: ', '', [rfReplaceAll, rfIgnoreCase])
            else
              ErrorMessage := ErrorMessage + TempErrorMessage[i];
          end;
        end;
        TempErrorMessage.Free;
      end;
    end;
  finally
    FreeLibrary(hZoeDLL);
  end;
end;

procedure TPreviewManager.HandleParseFinished(Sender: TObject);
var
  FileIsValid: boolean;
begin
  with GeneratingRequest do
  begin
    ErrorMessage := BackgroundParseThread.ErrorMessage;
    FileIsValid :=  BackgroundParseThread.FileIsValid;
    HasMacros := BackgroundParseThread.HasMacros;
    EposScreenWidth := BackgroundParseThread.ScreenSizeX;
    EposScreenHeight := BackgroundParseThread.ScreenSizeY;

    if FileIsValid then
      useful.TextLog('Preview XML parsed successfully.', LogFilePath)
    else
      useful.TextLog('Preview XML parse error: '+ErrorMessage, LogFilePath);

    if FileIsValid then
      Status := tsPreviewReady
    else
    begin
      Status := tsParseError;
    end;
    StartGeneration;
  end;
end;

procedure TPreviewManager.RemoveRequestExecute(Sender: TObject);
begin
  TPreviewRequest(lbPreviewRequests.Items.Objects[lbPreviewRequests.ItemIndex]).Remove;
  UpdateListGUI;
end;

procedure TPreviewManager.RemoveRequestUpdate(Sender: TObject);
begin
  // todo: support cancel of running preview
  TAction(Sender).Enabled := (lbPreviewRequests.ItemIndex <> -1) and
    (TPreviewRequest(lbPreviewRequests.Items.Objects[lbPreviewRequests.ItemIndex]).Status in
      (IdleStates + RunningStates));
end;

procedure TPreviewManager.StartStopPreviewUpdate(Sender: TObject);
var
  Request: TPreviewRequest;
begin
  if lbPreviewRequests.ItemIndex = -1 then
    TAction(Sender).Enabled := false
  else
  begin
    Request := TPreviewRequest(lbPreviewRequests.Items.Objects[lbPreviewRequests.ItemIndex]);
    TAction(Sender).Enabled := Request.Status in (ReadyStates + RunningStates);
    if TAction(Sender).Enabled then
    begin
      if Request.Status in RunningStates then
        TAction(Sender).Caption := 'Stop Preview'
      else
        TAction(Sender).Caption := 'Start Preview';
    end;
  end;
end;

procedure TPreviewManager.StartStopMacroUpdate(Sender: TObject);
var
  Request: TPreviewRequest;
begin
  if lbPreviewRequests.ItemIndex = -1 then
    TAction(Sender).Enabled := false
  else
  begin
    Request := TPreviewRequest(lbPreviewRequests.Items.Objects[lbPreviewRequests.ItemIndex]);
    TAction(Sender).Enabled := Request.HasMacros and (Request.Status in RunningStates)
      and (not Assigned(RecordingRequest) or (RecordingRequest = Request));
    if TAction(Sender).Enabled then
    begin
      if Request.Status = tsDefiningMacro then
        TAction(Sender).Caption := 'Save Macro'
      else
        TAction(Sender).Caption := 'Record Macro';
    end;
  end;
end;

procedure TPreviewManager.StartStopMacroExecute(Sender: TObject);
begin
  try
    TPreviewRequest(lbPreviewRequests.Items.Objects[lbPreviewRequests.ItemIndex]).StartStopMacro;
  except on E:Exception do
    begin
      useful.TextLog('Error in '+StartStopMacro.Caption+' : '+E.Message, LogFilePath);
      raise;
    end;
  end;
end;

procedure TPreviewManager.StartStopPreviewExecute(Sender: TObject);
begin
  TPreviewRequest(lbPreviewRequests.Items.Objects[lbPreviewRequests.ItemIndex]).StartStopPreview;
end;

procedure TPreviewManager.PollPreviewProcessTimer(Sender: TObject);
var
  Request: TPreviewRequest;
  PollPreviewProcessID: integer;
begin
  if lbPreviewRequests.Count = 0 then exit;
  for PollPreviewProcessID := 0 to pred(lbPreviewRequests.Items.Count) do
  begin
    Request := TPreviewRequest(lbPreviewRequests.Items.Objects[PollPreviewProcessID]);
    if Request.Status in RunningStates + [tsClosingPreview] then
      if Request.PollPreviewProcess then
        RedrawStatus(PollPreviewProcessID);
  end;
end;

procedure TPreviewManager.CloseFormExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TPreviewManager.lbPreviewRequestsDblClick(Sender: TObject);
begin
  if StartStopPreview.Enabled then
    StartStopPreview.Execute;
end;

procedure TPreviewManager.UpdateListGUI;
begin
  lbPreviewRequests.Height := lbPreviewRequests.ItemHeight * lbPReviewRequests.Items.Count;
  lbPreviewRequests.Width := sbScrollContainer.ClientWidth;
  lbNoItemsWarning.visible := lbPReviewRequests.Items.Count = 0;
end;

procedure TPreviewManager.CancelMacroUpdate(Sender: TObject);
var
  Request: TPreviewRequest;
begin
  if lbPreviewRequests.ItemIndex = -1 then
    TAction(Sender).Enabled := false
  else
  begin
    Request := TPreviewRequest(lbPreviewRequests.Items.Objects[lbPreviewRequests.ItemIndex]);
    TAction(Sender).Enabled := (Request.Status = tsDefiningMacro)
      and (not Assigned(RecordingRequest) or (RecordingRequest = Request));
  end;
end;

procedure TPreviewManager.CancelMacroExecute(Sender: TObject);
begin
  TPreviewRequest(lbPreviewRequests.Items.Objects[lbPreviewRequests.ItemIndex]).StartStopMacro(True);
end;

procedure TPreviewManager.lbPreviewRequestsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  Request: TPreviewRequest;
begin
  if (key = ord('C')) and (ssctrl in shift) then
  begin
    if (lbPreviewRequests.ItemIndex <> -1) then
    begin
      Request := TPreviewRequest(lbPreviewRequests.Items.Objects[lbPreviewRequests.ItemIndex]);
      clipboard.SetTextBuf(pchar(
        '<!-- TGEM command: '+Request.LastSQLText + '-->'+ #13#10+
        '<!-- EposModel status: '+Request.GetStatusText + '-->'+ #13#10+
        Request.GetModel));
    end;
  end;
end;

procedure TPreviewManager.BringPreviewToFrontUpdate(Sender: TObject);
var
  Request: TPreviewRequest;
begin
  if lbPreviewRequests.ItemIndex = -1 then
    TAction(Sender).Enabled := false
  else
  begin
    Request := TPreviewRequest(lbPreviewRequests.Items.Objects[lbPreviewRequests.ItemIndex]);
    TAction(Sender).Enabled := Request.Status in RunningStates;
  end;
end;

procedure TPreviewManager.BringPreviewToFrontExecute(Sender: TObject);
var
  Request: TPreviewRequest;
begin
  Request := TPreviewRequest(lbPreviewRequests.Items.Objects[lbPreviewRequests.ItemIndex]);
  Request.BringToFront;
end;

{ TPreviewHardwareType }

constructor TPreviewHardwareType.Create(EPOSTerminalCommandSwitch: String;
  PreviewScreenWidth, PreviewScreenHeight, GridOffsetX, GridOffsetY: integer;
  DoubleBufferedSwitch: String);
begin
  inherited Create();
  FEPOSTerminalNTCommandSwitch := EPOSTerminalCommandSwitch;
  FPreviewScreenWidth := PreviewScreenWidth;
  FPreviewScreenHeight := PreviewScreenHeight;
  FGridOffsetX := GridOffsetX;
  FGridOffsetY := GridOffsetY;
  FDoubleBufferedSwitch := DoubleBufferedSwitch;
end;

end.
