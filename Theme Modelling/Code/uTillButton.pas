unit uTillButton;

interface


// ************************************************************************** //
// ************************************************************************** //
// **                                                                      ** //
// **  PEM 03/07/07 - Do not remove this comment!!!                        ** //
// **                                                                      ** //
// **  If any changes are made to this unit, then the Till Buttons         ** //
// **  package needs to be rebuilt to reflect them in the component        ** //
// **                                                                      ** //
// **  The TillButton Package currently resides in :                       ** //
// **    {$AZTEC_VER}\Common Files\TillButtonPackage\TillButtons.dpk       ** //
// **                                                                      ** //
// **    {$AZTEC_VER} = Environment Variable defined when setting up       ** //
// **                   Source control.                                    ** //
// **                                                                      ** //
// ************************************************************************** //
// ************************************************************************** //


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, forms,
  Dialogs, Grids, DBGrids, DB, ADODB, StdCtrls, Buttons, extctrls, ComCtrls,
  DBCtrls, dbcgrids, menus, uPanelOutline, uDatabaseVersion;

  // panels have a border if they are one of the listed system panels (panel
  // references in EPOSMODEL table) and they don't touch the sides of the screen

const
//  bt_height = 50; //button height in pixels
//  bt_width = 66; // button width
  CORNER_RADIUS = 22; // round corner radius
  BACKGROUND_COLOUR = 0;
  DRAG_HANDLE_WIDTH = 4;
  DRAG_HANDLE_SELECT_OFFSET = 1;
  DRAGCORNERS = true;
  EMPTY_SPACE = 0;
  PARKING_BAY = 3;
  ORDER_POINT = 5;
  EDITCHOICE_ID = 160;

type
  TLoadPanelMode = (lpmLocalSharedPanel, lpmTablePlan, lpmSitePanel, lpmVariationPanel, lpmDriveThru);

  TTillButtonDrawType = (tbdtButton, tbdtSquare, tbdtCircle, tbdtHorizRect, tbdtVertRect, tbdtSeat, tbdtDiamond);
  TLoadType = (ltGeneric, ltSpecific);
  TTillObject = class;
  TTillbutton = class;
  TTillSubPanel = class;

  TPanelManager = class;
  TObjectContextProc = procedure(Target: TTillObject) of object;
  TNewPanelPosOK = procedure(Top, Left, Width, Height : Integer; var PosOK : Boolean) of object;
  TPanelType = (ptFixed, ptDialog, ptShared, ptLocal, ptTablePlan, ptSitePanel, ptVariationPanel);
  TPanelOpenOK  = procedure(SharedPanelReferrer: TTillObject; Adding : Boolean) of Object;
  TPanelTopLeft = procedure(Top, Left : Integer) of Object;

  {$R Aztec_GUI.res}

  // <Dynamic Button Text>
  // Holds all the information needed to calculate the button text
  // and hint for each button function
  TButtonFunctionInfo = class(TObject)
  public
    ButtonTypeID: integer;
    FunctionName: string;
    Hint: string;
    HintNoData: string;
    Text: string;
    DataConditionals: TStringlist;
    Lookup: TDataset;
    VersionIntroduced : TDatabaseVersion;
    constructor Create;
    destructor Destroy; override;
    function ButtonText(Id: int64): string;
    function ButtonTextAvailable: boolean;
  end;

  TButtonFunctionInfoList = class(TObject)
  private
    ButtonFunctionInfoArray: array of TButtonFunctionInfo;
    ButtonFunctionInfoStringList: TStringList;
    procedure SetButtonFunctionInfoByIndex(Index: Integer; const _ButtonFunctionInfo: TButtonFunctionInfo);
    function GetButtonFunctionInfoByIndex(Index: Integer): TButtonFunctionInfo;
    function GetButtonFunctionInfoByName(Name: String): TButtonFunctionInfo;
    function GetButtonCount: Integer;
  public
    constructor Create;
    destructor destroy; override;
    procedure SetLength(NewLength: Integer);
    property ButtonFunctionInfoByIndex[Index: Integer]: TButtonFunctionInfo read  GetButtonFunctionInfoByIndex
                                                                            write SetButtonFunctionInfoByIndex; default;
    property ButtonFunctionInfoByName[Name: String]: TButtonFunctionInfo read  GetButtonFunctionInfoByName;
    property ButtonCount: Integer read GetButtonCount;
  end;
  // </Dynamic Button Text>

  PCacheNode = ^TCacheNode;
  TCacheNode = record
    tag: cardinal;
    item: TObject;
    left: PCacheNode;
    right: PCacheNode;
  end;

  TTagCache = class(TObject)
  private
    rootnode: PCacheNode;
    procedure AddItem(tag: cardinal;item:TObject);
    function Lookup(tag:cardinal):TObject;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TPictureCache = Class(TObject)
  Private
    CurrentPicture:TPicture;
  Public
    GraphicID:integer;
    Procedure SetPicture(GraphicID:integer);
    constructor Create;
    destructor Destroy; override;
  Published
    property Picture:TPicture READ CurrentPicture;
  end;

  TDragHandleType = (dhTop, dhTopRight, dhRight, dhBottomRight, dhBottom,
    dhBottomLeft, dhLeft, dhTopLeft);

  TDragHandle = class(TPanel)
  public
    constructor Create(AOwner: TComponent; Orientation: TDragHandleType; Draggable: boolean); reintroduce;
  end;

  TMultiItemSelection = class(TControl)
  private
    function GetHeight: integer;
    function GetLeft: integer;
    function GetTop: integer;
    function GetWidth: integer;
  public
    SelectedObjects: array of TControl;
    SelectHandleTop: array of TDragHandle;
    SelectHandleLeft: array of TDragHandle;
    SelectHandleBottom: array of TDragHandle;
    SelectHandleRight: array of TDragHandle;
    procedure ToggleSelection(SelectedObject: TControl);
    procedure Clear;
    procedure SetHandlesVisible(Value: boolean);
  published
  end;

  TTillButtonList = class (TList)
  private
  protected
    procedure Put(Index: Integer; Item: TTillButton);
    function Get(Index: Integer): TTillButton;
  public
    function IDCommaText: String;
    procedure Add(TillButton: TTillButton);
    property TillButtons[Index: Integer]: TTillButton read Get write Put; default;
  end;

  TTillObject = class(TGraphicControl)
  private
    PanelManager: TPanelmanager;
    FDatalink: TFieldDataLink;
    Fupd: boolean;
    FixedPos, FixedWidth, FixedHeight: boolean;
    FAllowDrag: boolean;
    procedure SetTop(value:integer);
    procedure SetLeft(value:integer);
    procedure SetWidth(value:integer);
    procedure SetHeight(value:integer);
    procedure SetDatasource(const Value: TDatasource);
    function GetDatasource: TDataSource;
    procedure Setupd(const Value: boolean);
    procedure SetAllowDrag(const Value: boolean);
  public
    // upd - object has been updated
    // kwp - object key was present in database after last load or save
    // kip - object key will be present in database after next save
    kwp, kip: boolean;
    constructor create(AOwner: TComponent); override;
    destructor destroy; override;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y:
      integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y:
      integer); override;
    procedure RelayDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure RelayDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DblClick; override;
    procedure Delete; virtual;

    procedure paint; override;
    procedure paintto(Canvas: TCanvas; paintpos: TPoint); virtual;


    procedure DataChange(sender: TObject); virtual;
    procedure LoadFromDataSet(loadtype: TLoadType; dataset: TDataSet); virtual;
    procedure SaveToDataSet(dataset: TDataSet); virtual;
  published
    property Top write SetTop;
    property Left write SetLeft;
    property Width write SetWidth;
    property Height write SetHeight;
    property Datasource: TDatasource read GetDatasource write SetDatasource;
    property upd: boolean read Fupd write Setupd;
    property AllowDrag: boolean read FAllowDrag write SetAllowDrag;
  end;

  TPopupMenuItem = (
    pmBackdropDarkBlue, pmBackdropDarkGreen, pmBackdropDarkPurple, pmBackdropDarkRed,
    pmBackdropLightBlue, pmBackdropLightGreen, pmBackdropLightPurple, pmBackdropLightRed,
    pmBackdropOrange, pmBackdropPink, pmBackdropTurquoise, pmBackdropYellow,
    pmBackdropClose, pmFontWhite, pmFontGrey, pmFontBlack,
    pmFunctionSecurity, pmFunctionLargeFont, pmFunctionSmallFont, pmFunctionSort
  );

  TPanelDisplayTransform = class
    // Control the transformation between button and pixel coordinates
  private
    FButtonWidth: integer;
    FButtonHeight: integer;
    FScreenWidth: integer;
    FScreenHeight: integer;
    FGridOffsetX: integer;
    FGridOffsetY: integer;
    FSmallFont: integer;
    FLargeFont: integer;

    procedure SetAutoZoom();

  public
    property ButtonWidth: integer read FButtonWidth;
    property ButtonHeight: integer read FButtonHeight;
    property ScreenWidth: integer read FScreenWidth;
    property ScreenHeight: integer read FScreenHeight;
    property GridOffsetX: integer read FGridOffsetX;
    property GridOffsetY: integer read FGridOffsetY;
    property SmallFont: integer read FSmallFont;
    property LargeFont: integer read FLargeFont;

    function GetScreenRect: TRect;
    function NumButtonsX: integer;
    function NumButtonsY: integer;
    function ButtonToPixelCoords(ButtonCoords: TRect; AbsoluteBounds: boolean = false): TRect;
    function PixelToButtonCoords(PixelCoords: TRect; AbsoluteBounds: boolean = false): TRect;
    procedure LoadFromDataset(data: TDataSet);
    procedure LoadFromValues(ButtonWidth: integer; ButtonHeight: Integer; ScreenWidth: integer; ScreenHeight: integer; GridOffsetX: integer; GridOffsetY: integer);
    procedure SetBoundsFromDataSet(control: TControl; data: TDataSet);

    constructor Create();

  end;

  TPanelManager = class(TComponent)
  private
    MultiSelect: TMultiItemSelection;
    PMConnection : TADOConnection;
    LoadPanelMode: TLoadPanelMode;
    OwnerForm: TForm;
    DragOk: boolean;
    FEditingCorrectionPanel: boolean;
    initialpos, initialoffset, lastbuttonpos: TPoint;
    draghandles: array[dhTop..dhTopLeft] of TDragHandle;
    FSelectedObject: TControl;
    FOpenPanelOK : TPanelOpenOK;
    FmoveSPOL :  TPanelTopLeft;
    FValidatingSharedPanel : Boolean;

    FPanelDesign : Integer;
    FHideOrderDisplay: boolean;
    FPanelHeight: integer;
    FPanelTop: integer;
    FPanelWidth: integer;
    FPanelLeft: integer;
    FEposName3: string;
    FEposName2: string;
    FPanelName: string;
    FPanelDescription: string;
    FEposName1: string;
    FScreenInterfaceID : integer;
    FCorrectionMethod : Integer; //**dimensions for the order display pos for this design
// AK PM303
    FOnByDefault:Boolean;
    FRootPanel : Boolean;
    FPanelOutLine : TPanelOutline;
    FSPOL : TPanelOutLine;
    FEnableSPEdit : Boolean;
    FModPanel: boolean;
    FMinSiteDBVersionUsingPanel : TDataBaseVersion;
    FFlagFunctionVersion : Boolean;

    //** Irrelevent if editing a root panel
    procedure PaintOutline;
    procedure SetSelectedObject(const Value: TControl);
    procedure AlignDragHandles(control: TControl); overload;
    procedure AlignDragHandles; overload;
    {DragHandle event handlers - respond to size drag handle mouse messages}
    procedure DragHandleMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DragHandleMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DragHandleMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    {checks if a button can be dragged by DELTA in the specified drag type}
    procedure DragCheck(dragtype: TDragHandleType; delta: TPoint; var buttondims: TRect);
    procedure DoDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DoDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure HandleContextClick;
    procedure HandleDoubleClick;
    procedure CancelDrag;
    procedure HandlePopupMeasure(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
    procedure HandlePopupDraw(Sender: TObject; ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
    procedure HandlePopupClick(sender: TObject);
    function CheckBtnMoveValid(left, top, width, height: integer; obj: TTillObject): boolean;
    procedure ClearPanel;
    // property sets
    procedure SetEposName1(const Value: string);
    procedure SetEposName2(const Value: string);
    procedure SetEposName3(const Value: string);
    procedure SetHideOrderDisplay(const Value: boolean);
    procedure SetPanelDescription(const Value: string);
    procedure SetPanelHeight(const Value: integer);
    procedure SetPanelLeft(const Value: integer);
    procedure SetPanelName(const Value: string);
    procedure SetPanelTop(const Value: integer);
    procedure SetPanelWidth(const Value: integer);
    procedure SetCorrectionMethod(const Value : Integer);
// AK PM303
    procedure SetOnByDefault(const Value:Boolean);
    // adjust all objects on panel due to adjustment of panel
    // top and left coordinates
    procedure RealignObjects(DeltaX, DeltaY: integer);
    // check that setting of new width and height values is ok
    procedure CheckSetWH(NewWidth, NewHeight: integer);
    procedure RecalculateGrid;
    function rect_overlaps_other_objects(rect: TRect; ignoreobject: TTillObject): boolean;
    function rect_fits_on_panel(rect: TRect): boolean;
    function SilentCheckSetWH(NewWidth, NewHeight: integer): Boolean;
    procedure SetAddIngPanelMode(Value : Boolean);
    procedure SetModPanel(const Value: boolean);
    function FunctionOnPanelAlready(TypeID: integer; Attr01: string):boolean;
// AK PM303
    function EditChoiceOnPanelAlready:boolean;
    procedure CheckFunctionVersionSupported(ButtonFunctionID: Integer);
    procedure SetMinSiteVersion;
    function DriveThruPlanExists : boolean;
    function isProductGroupPaymentType(PaymentMethodID : integer) : boolean;
    procedure CheckPaymentVersionSupported(PaymentMethdVersion : String);
    function PanelLabelCount: Integer;
    function IsSingleItemDiscount(ATillButton: TTillButton): Boolean;
  public
    pd: TPanelDisplayTransform;
    OrderDisplayBounds: TRect;
    FPanelDesignTypeID : Integer; //**dimensions for the order display pos for this design
    SitePanelAllowAppearanceEdits: boolean;
    SitePanelAllowSecurityEdits: boolean; // not supported yet
    SharedPanelHasVariations: boolean;
    ReadOnly: boolean;
    ButtonListDataSet: TDataSet;
    // dragging/sizing control variables
    DragPos: TPoint;
    DragDestRect: TRect;
    DragDestRectDrawn: boolean;
    DragButton: boolean;
    Dragging: boolean;
    Sizing: boolean;
    SizeDirection: TDragHandleType;
    SizeInitialPos: TPoint;
    // grid variables
    SnapToGrid: boolean;
    GridWidth: integer;
    GridHeight: integer;
    GridOffsetX: integer;
    GridOffsetY: integer;

    MinWidthInButtons: integer;
    MinHeightInButtons: integer;
    ForcedSelectionPanel : Boolean;

    ObjectContextEvent, ObjectDblClickEvent: TObjectContextProc;

    PanelDesignModified : Boolean;
    PanelModified: boolean;
    DetailsModified: boolean;

    BackdropMenu: TPopupmenu;
    BackdropColourList: TImageList;
    // Panel attributes
    PanelType: TPanelType;
    PanelID: int64;
    tp_sitecode: integer;

    procedure DoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DragInitialClick(obj: TControl; Pos: TPoint;shift: TShiftState);
    procedure DragMove(Pos: TPoint);
    procedure DragFinalClick(obj: TControl; Pos: TPoint;shift: TShiftState);
    procedure RemoveSelection;
    constructor Create(AOwner: TForm); reintroduce;
    destructor Destroy; override;
    property SelectedObject: TControl read FSelectedObject write SetSelectedObject;
    procedure move(vector: TPoint);
    procedure Delete;
    procedure SnapPointToGrid(var point: TPoint);
    procedure SaveObjectPosn(Source: TTillObject; dataset: TDataset);
    procedure LoadObjectPosn(Target: TTillObject; dataset: TDataset);
    procedure LoadPanel(theconnection: TADOConnection; panel_id: int64; mode: TLoadPanelMode = lpmLocalSharedPanel; tp_sitecode: integer = 0; tp_ScreenInterfaceID: integer = 0);
    procedure SavePanel(theconnection: TADOConnection);
    procedure New;
    procedure AddTable(x, y: smallint; tablenumber: integer; draw_type: TTillButtonDrawType);
    procedure AddLabel(x, y: smallint);
    procedure AddSpace(x, y: smallint; spacenumber, seqnum, DriveThruType: integer; draw_type: TTillButtonDrawType);
    procedure CancelOpenPanel;
    function  NewPanelPosValid(PanelTop, PanelLeft, panelBottom, PanelRight : Integer; HOD : Boolean) : Boolean;

    property PanelLeft: integer read FPanelLeft write SetPanelLeft;
    property PanelTop: integer read FPanelTop write SetPanelTop;
    property PanelWidth: integer read FPanelWidth write SetPanelWidth;
    property PanelHeight: integer read FPanelHeight write SetPanelHeight;
    property PanelName: string read FPanelName write SetPanelName;
    property PanelDescription: string read FPanelDescription write SetPanelDescription;
    property HideOrderDisplay: boolean read FHideOrderDisplay write SetHideOrderDisplay;
    property ModPanel: boolean read FModPanel write SetModPanel;
    property EposName1: string read FEposName1 write SetEposName1;
    property EposName2: string read FEposName2 write SetEposName2;
    property EposName3: string read FEposName3 write SetEposName3;
    property IsRoot : Boolean read FRootPanel write FRootPanel;
    property OnAddOpenPanelButton : TPanelOpenOK read FOpenPanelOK write FOpenPanelOK ;
    property AddingSharedPanel : Boolean read FValidatingSharedPanel write SetAddIngPanelMode;
    property PanelOutLine : TpanelOutline read FPanelOutline write FPanelOutline;
    property SPOL : TpanelOutline read FSPOL write FSPOL;
    property PanelDesign : Integer read FpanelDesign write FpanelDesign;
    property onMoveSPOL : TPanelTopLeft read FMoveSPOL write FMoveSPOL;
    property EnableSharedPanelEdit : Boolean read FEnableSPEdit write FEnableSPEdit;
    property DefaultCorrectionMethod : Integer read FCorrectionMethod write SetCorrectionMethod;
// AK PM303
    property OnByDefault:Boolean read FOnByDefault write SetOnByDefault;
    property ScreenInterfaceID : Integer read FScreenInterfaceID write FScreenInterfaceID;
    property EditingCorrectionPanel : Boolean read FEditingCorrectionPanel;
    function InvalidPanelPositionsInSubPanel(data: TDataSet): boolean;
  protected
    FPictureCache: TPictureCache;
  end;

  TTillButton = class(TTillObject)
  private
    bitmap: TBitmap;
    // background colours - set by backdrop
    BGColourRed: byte;
    BGColourBlue: byte;
    BGColourGreen: byte;
    Text: string;

    FPanelID: int64;
    FFGColourRed: byte;
    FFGColourBlue: byte;
    FFGColourGreen: byte;
    FButtonID: int64;
    FButtonTypeID: integer;
    FFontID: integer;
    FBackdropID: integer;
    FButtonTypeData: string;
    FEposName1: string;
    FEposName3: string;
    FEposName2: string;
    FButtonSecurityId: integer;
    FButtonTypeData2: string;
    FSequenceNumber: integer;
    FSpaceType: integer;
    FTerminalID: integer;
    FRequestWitness: Boolean;
    procedure CheckText;

    procedure SetBackdropID(const Value: integer);
    procedure SetButtonID(const Value: int64);
    procedure SetButtonTypeData(const Value: string);
    procedure SetButtonTypeID(const Value: integer);
    procedure SetEposName1(const Value: string);
    procedure SetEposName2(const Value: string);
    procedure SetEposName3(const Value: string);
    procedure SetFGColourBlue(const Value: byte);
    procedure SetFGColourGreen(const Value: byte);
    procedure SetFGColourRed(const Value: byte);
    procedure SetFontID(const Value: integer);
    procedure SetPanelID(const Value: int64);
    procedure SetButtonSecurityId(const Value: integer);
    procedure SetButtonTypeData2(const Value: string);
    procedure SetSequenceNumber(const Value: integer);
    procedure SetSpaceType(const Value: integer);
    procedure SetTerminalID(const Value: integer);
    function GetIsCorrection : Boolean;
    function GetIsValidForCorrectionPanel : Boolean;
    function GetIsClosePanelButton: Boolean;
    procedure SetRequestWitness(const Value: Boolean);
    function GetIsDiscount: Boolean;
    function IsButtonType(ButtonTypes: array of string): Boolean;
  public
    // hacking of colour menus outside these classes requires this to be public..
    drawtype: TTillButtonDrawType;
    constructor create(AOwner: TComponent); reintroduce;
    destructor destroy; override;
    procedure paint; override;
    procedure paintto(Canvas: TCanvas; paintpos: TPoint); override;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure DataChange(Sender: TObject); override;
    procedure LoadFromDataSet(loadtype: TLoadType; dataset: TDataSet); override;
    procedure SaveToDataSet(dataset: TDataSet); override;
    procedure Assign(source: TPersistent); override;
    procedure Delete; override;
    procedure AllocateID;

    property PanelID: int64 read FPanelID write SetPanelID;
    property ButtonID: int64 read FButtonID write SetButtonID;
    property BackdropID: integer read FBackdropID write SetBackdropID;
    property FontID: integer read FFontID write SetFontID;
    property ButtonSecurityId: integer read FButtonSecurityId write SetButtonSecurityId;
    property EposName1: string read FEposName1 write SetEposName1;
    property EposName2: string read FEposName2 write SetEposName2;
    property EposName3: string read FEposName3 write SetEposName3;
    property FGColourRed: byte read FFGColourRed write SetFGColourRed;
    property FGColourGreen: byte read FFGColourGreen write SetFGColourGreen;
    property FGColourBlue: byte read FFGColourBlue write SetFGColourBlue;
    property ButtonTypeID: integer read FButtonTypeID write SetButtonTypeID;
    property ButtonTypeData: string read FButtonTypeData write SetButtonTypeData;
    property ButtonTypeData2: string read FButtonTypeData2 write SetButtonTypeData2;
    property SequenceNumber: integer read FSequenceNumber write SetSequenceNumber;
    property SpaceType: integer read FSpaceType write SetSpaceType;
    property TerminalID: integer read FTerminalID write SetTerminalID;
    property GetButtonText:string read Text;
    property RequestWitness: Boolean read FRequestWitness write SetRequestWitness;
    property IsCorrectionMethod : Boolean read GetIsCorrection;
    property IsValidForCorrectionPanel: Boolean read GetIsValidForCorrectionPanel;
    property IsClosePanelButton: Boolean read GetIsClosePanelButton;
    property IsDiscount : Boolean read GetIsDiscount;
  published
    property showhint;
    property OnDragDrop;
    property OnDragOver;
    property OnMouseDown;
    property OnDblClick;
  end;

  TTillLabel = class(TTillObject)
  private
    FBorder: boolean;
    FBGColourBlue: byte;
    FFGColourBlue: byte;
    FFGColourRed: byte;
    FFGColourGreen: byte;
    FBGColourRed: byte;
    FBGColourGreen: byte;
    FPanelID: int64;
    FLabelID: int64;
    FFontID: integer;
    FText: string;
    procedure SetBGColourBlue(const Value: byte);
    procedure SetBGColourGreen(const Value: byte);
    procedure SetBGColourRed(const Value: byte);
    procedure SetBorder(const Value: boolean);
    procedure SetFGColourBlue(const Value: byte);
    procedure SetFGColourGreen(const Value: byte);
    procedure SetFGColourRed(const Value: byte);
    procedure SetFontID(const Value: integer);
    procedure SetLabelID(const Value: int64);
    procedure SetPanelID(const Value: int64);
    procedure SetText(const Value: string);
  public
    constructor create(AOwner: TPanelManager); reintroduce;
    destructor destroy; override;
    procedure paint; override;
    procedure paintto(Canvas: TCanvas; paintpos: TPoint); override;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure LoadFromDataSet(loadtype: TLoadType; dataset: TDataSet); override;
    procedure SaveToDataSet(dataset: TDataSet); override;
    function IsForcedItemHeader: boolean;

    property PanelID: int64 read FPanelID write SetPanelID;
    property LabelID: int64 read FLabelID write SetLabelID;
    property Text: string read FText write SetText;
    property FontID: integer read FFontID write SetFontID;
    property Border: boolean read FBorder write SetBorder;
    property FGColourRed: byte read FFGColourRed write SetFGColourRed;
    property FGColourGreen: byte read FFGColourGreen write SetFGColourGreen;
    property FGColourBlue: byte read FFGColourBlue write SetFGColourBlue;
    property BGColourRed: byte read FBGColourRed write SetBGColourRed;
    property BGColourGreen: byte read FBGColourGreen write SetBGColourGreen;
    property BGColourBlue: byte read FBGColourBlue write SetBGColourBlue;

  end;

  TTillHeader = class(TTillObject)
  private
    FPanelID: int64;
    FHeaderType: string;
    FGraphicID: integer;
    procedure SetHeaderType(const Value: string);
    procedure SetPanelID(const Value: int64);
    procedure SetGraphicID(const Value:integer);
    Procedure HandleDoubleclick(Sender: TObject);
    function PictureRect(DrawingArea:Trect; ImageHeight:integer; ImageWidth:integer):Trect;
  public
    constructor Create(AOwner: TPanelManager); reintroduce;
    destructor destroy; override;
    procedure paint; override;
    procedure paintto(Canvas: TCanvas; paintpos: TPoint); override;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure LoadFromDataSet(loadtype: TLoadType; dataset: TDataSet); override;
    procedure SaveToDataSet(dataset: TDataSet); override;

    property PanelID: int64 read FPanelID write SetPanelID;
    property HeaderType: string read FHeaderType write SetHeaderType;
    property GraphicID: Integer read FGraphicID write SetGraphicID;
  published
    property OnDblClick;
  end;

  TTillSubPanel = class(TTillObject)
  private
    FSiteEditAppearance: boolean;
    FSiteEditSecurity: boolean;
    FParentPanelID: int64;
    FSubPanelID: int64;
    FName: string;
    FDescription: string;
    procedure SetDescription(const Value: string);
    procedure SetName(const Value: string); reintroduce;
    procedure SetParentPanelID(const Value: int64);
    procedure SetSiteEditAppearance(const Value: boolean);
    procedure SetSiteEditSecurity(const Value: boolean);
    procedure SetSubPanelID(const Value: int64);
  public
    isSubPanelOnCorrectionPanel:Boolean;
    constructor create(AOwner: TPanelManager); reintroduce;
    destructor destroy; override;
    procedure paint; override;
    procedure paintto(Canvas: TCanvas; paintpos: TPoint); override;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure LoadFromDataSet(loadtype: TLoadType; dataset: TDataSet); override;
    procedure SaveToDataSet(dataset: TDataSet); override;
    procedure CheckFunctionValid(FunctionID: integer);

    property ParentPanelID: int64 read FParentPanelID write SetParentPanelID;
    property SubPanelID: int64 read FSubPanelID write SetSubPanelID;
    property Name: string read FName write SetName;
    property Description: string read FDescription write SetDescription;
    property SiteEditAppearance: boolean read FSiteEditAppearance write SetSiteEditAppearance;
    property SiteEditSecurity: boolean read FSiteEditSecurity write SetSiteEditSecurity;
  end;

  TButtonDrawHelper = class(TObject)
  private
    maskbm: TBitmap;
    BitmapCache: TTagCache;
    ButtonBorder: TBitmap;
    ButtonBorderStampSize: integer;
    PanelBorder: TBitmap;
    PanelBorderStampSize: integer;
    Square: TBitmap;
    Circle: TBitmap;
    HorizRect: TBitmap;
    VertRect: TBitmap;
    Seat: TBitmap;
    SecurityIcon: TBitmap;
    Diamond : TBitmap;
    function blend(c1, c2: TColor; phase: integer; fac1,fac2: double; BaseColour: TColor):TColor;
    procedure ButtonBlit(dest, source: TCanvas; pixl, pixt, pixw, pixh, stamp_size: integer; fill:boolean = true);
  public
    constructor create(AOwner: TPanelManager);
    destructor destroy; override;
    procedure draw(drawtype: TTillButtonDrawType; canvas: TCanvas; pixt, pixl, pixw, pixh: integer; colour: TColor);
    procedure paintbutton(canvas: TCanvas; pixt, pixl, pixw, pixh: integer; colour: TColor);
    procedure paintborder(canvas: TCanvas; pixl, pixt, pixw, pixh: integer);
  end;

  procedure SplitColour(input: TColor; var r, g, b: byte);
  function MakeColour(r, g, b: integer): TColor;

  procedure Register;

  procedure ReadFixedLookups(theconnection: TADOConnection);
  procedure ReadDynamicLookups(theconnection: TADOConnection; justpanels: boolean ;currentpanel: int64);

var
  Backdropcolourlookup: array[0..255] of TColor;
  Drawtypelookup: array[0..255] of TTillButtonDrawType;
  ButtonDrawHelper: TButtonDrawHelper;

  ThemeTablePlanLookup: TADODataSet;
  PanelLookup: TADODataSet;
  PaymentLookup: TADODataSet;
  InstructionLookup: TADODataSet;
  ProductLookup: TADODataSet;
  CorrectionLookup: TADODataSet;
  PortionTypeLookup: TADODataSet;
  TaxLookup: TADODataSet;
  DiscountLookup: TADODataSet;
  ReportLookup: TADODataSet;
  OrderDestinationLookup: TADODataSet;
  MacroLookup: TADODataSet;
  ButtonUrlLookup: TADODataSet;
  RemovePromotionsLookup: TADODataSet;
  EftRuleSoapOperationLookup: TADODataSet;
  OrderDestinationConversionLookup: TADODataSet;

  SelectCorrectionMethodFunctionID: integer;
  ApplyBillDiscountFunctionID: integer;
  RingUpInstructionFunctionID: integer;
  RingUpProductFunctionID: integer;
  SelectTableFunctionID: integer;
  OpenPanelFunctionID: integer;
  ApplyAndFunctionID: integer;
  SelectDrivethruFunctionID : integer;
  CreateDrivethruFunctionID : integer;
  EditChoiceFunctionID : integer;
  PayFunctionID : integer;

  // <Dynamic Button Text>
  ButtonFunctionInfoList: TButtonFunctionInfoList;
  // </Dynamic Button Text>

  LastExternalLookupTime: TDateTime;

implementation

uses math, TypInfo, UADO, commCtrl, uAztecLog, uTerminalGraphics, useful
  {$ifndef TILLBUTTON_COMP} , uGenerateThemeIDs , uFunctionVersionWarning, uEditOrderDisplay,
  uEditJobSecurity, uEditTimedJobSecurity{$endif};

function EposBGNameToColour(BGName: string): TColor;
var
  CurrColour: TColor;
begin
  if BGName = 'DarkBlue' then CurrColour := 10027008
  else if BGName = 'DarkRed' then CurrColour := 128
  else if BGName = 'DarkGreen' then CurrColour := 32768
  else if BGName = 'DarkPurple' then CurrColour := 8388736
  else if BGName = 'LightBlue' then CurrColour := 16711680
  else if BGName = 'LightRed' then CurrColour := 255
  else if BGName = 'LightGreen' then CurrColour := 65280
  else if BGName = 'LightPurple' then CurrColour := 16711884
  else if BGName = 'Pink' then CurrColour := 10027263
  else if BGName = 'Yellow' then CurrColour := 52428
  else if BGName = 'Turquoise' then CurrColour := 10066176
  else if BGName = 'Orange' then CurrColour := 26367
  else if BGName = 'Close' then CurrColour := 0
  else CurrColour := 0;
  Result := CurrColour;
end;

function EposBGNameToBackdropIndex(BGName: string): integer;
var
  i: integer;
  colour: TColor;
begin
  result := 0;
  colour := EposBGNameToColour(BGName);
  for i := low(drawtypelookup) to high(drawtypelookup) do
  begin
    if (Drawtypelookup[i] = tbdtButton) and (Backdropcolourlookup[i] = colour) then
    begin
      result := i;
      exit;
    end;
  end;
end;

function ConvertToButtonText(line1, line2, line3: string; DefaultToNoName: boolean = true): string;
begin
  line1 := trim(line1);
  line2 := trim(line2);
  line3 := trim(line3);
  Result := '';

  if line1 <> '' then
    Result := line1;

  if line2 <> '' then
    if Result <> '' then
      Result := Result + #10 + line2
    else
      Result := line2;

  if line3 <> '' then
    if Result <> '' then
      Result := Result + #10 + line3
    else
      Result := line3;

  if (trim(Result) = '') and DefaultToNoName then
    Result := 'No'+#10+'Name';
end;

function GetButtonTextFromLookupDataset(LookupDataset: TDataset; Id: int64): string;
var lookupResult: variant;
begin
  lookupResult := LookupDataset.Lookup('Id', Id, 'EposName1;EposName2;EposName3');
  if not(VarIsNull(lookupResult)) then
    Result := ConvertToButtonText(VarToStr(lookupResult[0]), VarToStr(lookupResult[1]), VarToStr(lookupResult[2]))
  else
    Result := '';
end;

procedure ReadFixedLookups(theconnection: TADOConnection);
var
  currname: string;
  currdrawtype: TTillButtonDrawType;
  currcolour: TColor;
  i: integer;
  SkimTerm: string;
  TempButtonFunctionInfo: TButtonFunctionInfo;
begin
  for i := low(drawtypelookup) to high(drawtypelookup) do
    drawtypelookup[i] := TTillButtonDrawType(-1);

  with TADOQuery.Create(nil) do try
    connection := theconnection;
    // default colour and button type (when no backdrop is assigned)
    backdropcolourlookup[0] := $ffffff;
    drawtypelookup[0] := tbdtButton;
    sql.text := 'select Id, Value from ThemeBackdropLookup';
    open;
    while not(Eof) do
    begin
      CurrName := fieldbyname('Value').asstring;
      if CurrName = 'SquareTable' then CurrDrawType := tbdtSquare
      else if CurrName = 'RoundTable' then CurrDrawType := tbdtCircle
      else if CurrName = 'HorizontalRectangleTable' then CurrDrawType := tbdtHorizRect
      else if CurrName = 'VerticalRectangleTable' then CurrDrawType := tbdtVertRect
      else if CurrName = 'DiamondTable' then CurrDrawType := tbdtDiamond
      else if CurrName = 'Seat' then CurrDrawType := tbdtSeat
      else CurrDrawType := tbdtButton;

      CurrColour := EposBGNameToColour(CurrName);
      backdropcolourlookup[fieldbyname('ID').asinteger] :=
        CurrColour;
      drawtypelookup[fieldbyname('ID').asinteger] := CurrDrawType;
      next;
    end;
    close;
    (*
    sql.text := 'select [touchscreen!orderdisplay!top] as odtop, '+
      '[touchscreen!orderdisplay!left] as odleft, '+
      '[touchscreen!orderdisplay!height] as odheight, '+
      '64*4 as odwidth '+
      'from eposmodel..[eposmodel]';
    open;
    OrderDisplayLeft := fieldbyname('odleft').asinteger;
    OrderDisplayTop := fieldbyname('odtop').asinteger;
    OrderDisplayWidth := fieldbyname('odwidth').asinteger;
    OrderDisplayHeight := fieldbyname('odheight').asinteger;
    close;
    *)
    sql.text := 'select id from themebuttontypechoicelookup where name = ''SelectCorrectionMethod''';
    open;
    SelectCorrectionMethodFunctionID := fieldbyname('id').asinteger;

    sql.text := 'select id from themebuttontypechoicelookup where name = ''ApplyBillDiscount''';
    open;
    ApplyBillDiscountFunctionID := fieldbyname('id').asinteger;

    sql.text := 'select id from themebuttontypechoicelookup where name = ''RingUpProduct''';
    open;
    RingUpProductFunctionID := fieldbyname('id').asinteger;

    sql.text := 'select id from themebuttontypechoicelookup where name = ''RingUpInstruction''';
    open;
    RingUpInstructionFunctionID := fieldbyname('id').asinteger;

    sql.text := 'select id from themebuttontypechoicelookup where name = ''SelectTable''';
    open;
    SelectTableFunctionId := fieldbyname('id').asinteger;
    sql.text := 'select id from themebuttontypechoicelookup where name = ''SelectDriveThruSpace''';
    open;
    SelectDrivethruFunctionID := fieldbyname('id').asinteger;
    sql.text := 'select id from themebuttontypechoicelookup where name = ''CreateDriveThruAccount''';
    open;
    CreateDrivethruFunctionID := fieldbyname('id').asinteger;
    sql.text := 'select id from themebuttontypechoicelookup where name = ''OpenPanel''';
    open;
    OpenPanelFunctionId := fieldbyname('id').asinteger;
    sql.text := 'select id from themebuttontypechoicelookup where name = ''ApplyAnd''';
    open;
    ApplyAndFunctionId := fieldbyname('id').asinteger;
    sql.text := 'select id from themebuttontypechoicelookup where name = ''EditChoice''';
    open;
    EditChoiceFunctionID := fieldbyname('id').asinteger;
    sql.text := 'select id from themebuttontypechoicelookup where name = ''Pay''';
    open;
    PayFunctionID := fieldbyname('id').asinteger;

    sql.text := 'select top 1 SkimTerminology from ac_CompanyFinanceSettings';
    open;
    SkimTerm := Fields[0].AsString;
    close;
    if SkimTerm = '' then SkimTerm := 'Skim';

    sql.text := 'select count(*) as MissingFunctionTextCount '+
      'from themebuttontypechoicelookup a '+
      'full outer join themefunctiontext b on a.name = b.buttonfunction '+
      'where (b.buttonfunction is null) or (a.name is null)';
    open;
    if not EOF then
      Assert(FieldByName('MissingFunctionTextCount').AsInteger = 0, 'Missing function text/type: ThemeButtontypeChoiceLookup and ThemeFunctionText disagree in number.');

    sql.text := 'select a.id,b.* '+
      'from themebuttontypechoicelookup a '+
      'join themefunctiontext b on a.name = b.buttonfunction';
    open;

    ButtonFunctionInfoList.setlength(recordcount+1); //The array is zero-relative
    while not(eof) do
    begin
      TempButtonFunctionInfo := TButtonFunctionInfo.create;

      TempButtonFunctionInfo.ButtonTypeID := fieldbyname('id').asinteger;
      TempButtonFunctionInfo.FunctionName := fieldbyname('buttonfunction').asstring;
      ButtonFunctionInfoList[TempButtonFunctionInfo.ButtonTypeID] := TempButtonFunctionInfo;
      with TempButtonFunctionInfo do
      begin
        hint := fieldbyname('hint').asstring;
        hintnodata := fieldbyname('hintnodata').asstring;
        text := StringReplace(fieldbyname('text').asstring, '/n', #13#10, [rfReplaceAll]);
        dataconditionals.Text := StringReplace(fieldbyname('dataconditionals').asstring, '|', #13#10, [rfReplaceAll]);
        if (LowerCase(functionname) = 'updatefloat') and (dataconditionals.count >= 2) then
        begin
          dataconditionals[1] := 'F='+SkimTerm;
        end;
        if lowercase(fieldbyname('lookup').asstring) = 'panel' then
          Lookup := PanelLookup
        else
        if lowercase(fieldbyname('lookup').asstring) = 'payment' then
          Lookup := PaymentLookup
        else
        if lowercase(fieldbyname('lookup').asstring) = 'instruction' then
          Lookup := InstructionLookup
        else
        if lowercase(fieldbyname('lookup').asstring) = 'product' then
          Lookup := ProductLookup
        else
        if lowercase(fieldbyname('lookup').asstring) = 'correction' then
          Lookup := CorrectionLookup
        else
        if lowercase(fieldbyname('lookup').asstring) = 'portiontype' then
          Lookup := PortionTypeLookup
        else
        if lowercase(fieldbyname('lookup').asstring) = 'tax' then
          Lookup := TaxLookup
        else
        if lowercase(fieldbyname('lookup').asstring) = 'discount' then
          Lookup := DiscountLookup
        else
        if lowercase(fieldbyname('lookup').asstring) = 'report' then
          Lookup := ReportLookup
        else
        if lowercase(fieldbyname('lookup').AsString) = 'orderdestination' then
          Lookup := OrderDestinationLookup
        else
        if lowercase(fieldbyname('lookup').AsString) = 'macro' then
          Lookup := MacroLookup
        else
        if lowercase(fieldbyname('lookup').AsString) = 'buttonurl' then
          Lookup := ButtonUrlLookup
        else
        if lowercase(fieldbyname('lookup').AsString) = 'removepromotions' then
          Lookup := RemovePromotionsLookup
        else
        if lowercase(fieldbyname('lookup').AsString) = 'eftrulesoapoperation' then
          Lookup := EftRuleSoapOperationLookup
        else
        if lowercase(fieldbyname('lookup').AsString) = 'changeorderdestination' then
          Lookup := OrderDestinationConversionLookup;


        if FieldByName('VersionIntroduced').AsString = '' then
          { Assume button was introduced in the oldest possible version, if not specified }
          VersionIntroduced.SetToMinimumPossibleVersion
        else
          VersionIntroduced.VersionText := FieldByName('VersionIntroduced').AsString;
      end;
      next;
    end;
    // </Dynamic Button Text>
    close;
  finally
    free;
  end;
end;

procedure ReadDynamicLookups(theconnection: TADOConnection; justpanels: boolean; currentpanel: int64);
{read lookups for user-changeable labels for buttons - panels, products, base data}
var
  themeid, paneldesignid: integer;
  theCommandTimeout: integer;

   procedure FillLookup(lookupDataset: TADODataset; sqlstmt: string);
  begin
     with lookupDataset do
      begin
       Close;
       Connection := theconnection;
       LockType := ltReadOnly;
       CommandTimeout := 0;
       CommandType := CmdText;
       CommandText :=sqlstmt;
       CursorLocation := clUseClient;
       IndexFieldNames := 'Id';
       Open;
       Assert(FindField('Id') <> nil, 'Id field was not retrieved by SQL in ReadDynamicLookups.FillLookup');
       Assert(FindField('EposName1') <> nil, 'EposName1 field was not retrieved by SQL in ReadDynamicLookups.FillLookup');
       Assert(FindField('EposName2') <> nil, 'EposName2 field was not retrieved by SQL in ReadDynamicLookups.FillLookup');
       Assert(FindField('EposName3') <> nil, 'EposName3 field was not retrieved by SQL in ReadDynamicLookups.FillLookup');
      end;
    end;

begin
//  TODO: this! (product lookups etc).
  with TADOQuery.create(nil) do try
    connection := theconnection;
    sql.text := format('select b.paneldesignid, b.themeid from themepanel a '+
      'join themepaneldesign b on a.paneldesignid = b.paneldesignid '+
      'where a.panelid = %d', [currentpanel]);
    open;
    if recordcount = 0 then
    begin
      themeid := -1;
      paneldesignid := -1;
    end
    else
    begin
      themeid := fieldbyname('themeid').asinteger;
      paneldesignid := fieldbyname('paneldesignid').asinteger;
    end;
    close;
  finally
    free;
  end;
  FillLookup(PanelLookup, format(
    'select panelid as id, [eposname1], [eposname2], [eposname3] from themepanel '+
    'where (paneldesignid = %d) or paneltype = 2', [paneldesignid]));
  FillLookup(ThemeTablePlanLookup, format(
    'select tableplanid as id, [eposname1], [eposname2], [eposname3] from themetableplan '+
    'where themeid = %d', [themeid]));

  FillLookup(MacroLookup, format(
    'select MacroID as id, [eposname1], [eposname2], [eposname3] from ThemePanelDesignMacro '+
    'where paneldesignid = %d', [paneldesignid]));

  FillLookup(ButtonUrlLookup, 'select id, [eposname1], [eposname2], [eposname3] from ThemeButtonUrl');

  FillLookup(EftRuleSoapOperationLookup, 'select EftRule as id, EPoSName1, EPoSName2, EPoSName3 from ThemeEftRuleSoapOperation');

  if (not JustPanels) and ((now-LastExternalLookupTime) > 1.0/24.0/24.0) then
  begin
    theCommandTimeout := theConnection.CommandTimeout;
    theconnection.CommandTimeout := 0;
    try
      theconnection.Execute(
        'if object_id(''tempdb..#portionheader'') is null '+
        'begin '+
        'create table #PortionHeader (PortionID int, EntityCode float, PortionTypeID smallint, '+
        '  DisplayOrder tinyint, ContainsChoice bit, iteration int, IsChoice bit, ContainerID int, MinChoice int, MaxChoice int, SuppChoice int, AllowPlain bit, primary key(PortionId)) '+
        'end '+
        'else '+
        '  truncate table #portionheader '+
        'if object_id(''tempdb..#portiondetail'') is null '+
        'begin '+
        'create table #PortionDetail (PortionID int, IngredientCode float, DisplayOrder tinyint, '+
        '  Quantity decimal (8, 2), UnitName varchar (10) collate database_default, PortionTypeID smallint, CalculationType tinyint, ContainsChoice bit, IsChoice bit, IncludeByDefault bit, primary key (portionid, ingredientcode, displayorder)) '+
        'end '+
        'else '+
        '  truncate table #portiondetail '+
        'exec theme_getproductinfo @PopulatePortionHeaderOnly = 1'
      );

      LastExternalLookupTime := now;

      FillLookup(InstructionLookup,
        'select cast(entitycode as bigint) as id, '+
        'AztecEposButton1 as eposname1, AztecEposButton2 as eposname2, AztecEposButton3 as eposname3 '+
        'from products '+
        'where [entity type] in (''Instruct.'')');

      FillLookup(ProductLookup,
        'select cast(entitycode as bigint) as id, '+
        'AztecEposButton1 as eposname1, AztecEposButton2 as eposname2, AztecEposButton3 as eposname3 '+
        'from products '+
        'where entitycode in (select entitycode from #portionheader) and [entity type] in (''Strd.Line'', ''Recipe'')');

      FillLookup(PaymentLookup, 'select paymentmethodid as id, [eposname1], [eposname2], [eposname3] from theme_paymentmethod');
      FillLookup(CorrectionLookup, 'select correctionmethodid as id, [eposname1], [eposname2], [eposname3] from theme_correctionmethod');
      FillLookup(PortionTypeLookup, 'select portionselectorid as id, [eposname1], [eposname2], [eposname3] from theme_portionselector');
      FillLookup(TaxLookup,
        'select Id, isnull(PosButtonTextLine1, '''') as eposname1, isnull(PosButtonTextLine2, '''') as eposname2,' +
        'isnull(PosButtonTextLine3, '''') as eposname3 from ac_TaxRule where Deleted = 0');
      FillLookup(DiscountLookup, 'select discountid as id, [eposname1], [eposname2], [eposname3] from discount');
      FillLookup(ReportLookup, 'select reportid as id, [eposname1], [eposname2], [eposname3] from themereport');
      // TODO use proper epos names once added to the ac_OrderDestination table
      FillLookup(OrderDestinationLookup, 'select id, IsNull(PosButtonTextLine1, '''') as [eposname1], IsNull(PosButtonTextLine2, '''') as [eposname2], IsNull(PosButtonTextLine3, '''') as [eposname3] from ac_orderdestination');
      FillLookup(RemovePromotionsLookup, 'select Id, ''Remove'' as [eposname1], Name as [eposname2], ''Promotions'' as [eposname3] from ac_ProductGroupHeader');
      FillLookup(OrderDestinationConversionLookup, 'select Id as Id, ''Change to '' as [eposName1], Name as [eposName2], '''' as [eposName3] from ac_OrderDestination');
    finally
      theConnection.CommandTimeout := theCommandTimeout;
    end;
  end;
end;



procedure Register;
begin
  RegisterComponents('Data Controls', [TTillButton]);
end;

function CreateColourBitmap(bmpcolour: TColor): TBitmap;
begin
  result := TBitmap.create;
  result.Width := 16;
  result.Height := 16;
  result.PixelFormat := pf24bit;
  result.Canvas.Pen.color := bmpcolour;
  result.Canvas.Brush.color := bmpcolour;
  result.Canvas.Rectangle(0, 0, 15, 15);
end;

function outofbounds(input, min, max: integer):boolean;
begin result := (input < min) or (input > max); end;

function MakeColour(r, g, b: integer): TColor;
begin
  result := b shl 16 + g shl 8 + r;
end;

procedure SplitColour(input: TColor; var r, g, b: byte);
begin
  r := input and $ff;
  g := (input shr 8) and $ff;
  b := (input shr 16) and $ff;
end;

procedure RGBtoHSV(r, g, b: double; var h, s, v: double);
var
  max, min, delta: double;
begin
  max := math.Max(r,g);
  max := math.max(max, b);
  min := math.min(r,g);
  min := math.min(min, b);
  v := max;
  if max <> 0 then
    s := (max - min) / max
  else
    s := 0;
  if s = 0 then
  begin
    h := -1;
    exit;
  end;
  delta := max-min;
  if r = max then h := (g-b)/delta
  else if g= max then h := 2 + (b - r)/delta
  else if b= max then h := 4 + (r-g)/delta;
  h := h * 60;
  if h < 0 then h := h + 360;
end;
procedure HSVtoRGB(h, s, v: double; var r, g, b: double);
var
  f, p, q, t: double;
  i: integer;
begin
  if s = 0 then
  begin
    //if h = -1 then raise exception.create('there is no hue');
    r := v;
    g := v;
    b := v;
    exit;
  end;
  if h = 360 then h := 0;
  h := h /60;
  i := floor(h);
  f := h - i;
  p := v * (1 - s);
  q := v * (1 - s * f);
  t := v * (1 - s * (1 - f));
  case i of
  0: begin r := v; g := t; b := p; end;
  1: begin r := q; g := v; b := p; end;
  2: begin r := p; g := v; b := t; end;
  3: begin r := p; g := q; b := v; end;
  4: begin r := t; g := p; b := v; end;
  5: begin r := v; g := p; b := q; end;
  end;
end;

{ TButtonDrawHelper }

function TButtonDrawHelper.blend(c1, c2: TColor; phase: integer; fac1, fac2: double; basecolour: TColor): TColor;
  // set result to pixel colour c2 using pixel saturation and intensity from colour c2
  // the result is "colourised" to colour c2
var
  h, s, v, r, g, b: double;
  h2, s2, v2: double;
begin
  // get HSV values of the colours
  RGBtoHSV(((c2 and $ff0000) shr 16)/255, ((c2 and $ff00) shr 8)/255, (c2 and $ff)/255,
    h, s, v);
  RGBtoHSV(((c1 and $ff0000) shr 16)/255, ((c1 and $ff00) shr 8)/255, (c1 and $ff)/255,
    h2, s2, v2);
  if basecolour = 0 then
  begin
    // a black button (so input c2 will always be black)
    // outputting a shade of grey based on the green level only
    // makes "colourless" button but still with highlights
    r := ((c1 and $ff00) shr 8)/255;
    g := ((c1 and $ff00) shr 8)/255;
    b := ((c1 and $ff00) shr 8)/255;
  end
  else
  if (h2 = -1) then
  begin
    // grey/white - so no output hue
    h := -1;
    s := s2;
    v := v2;
    HSVtoRGB(h,s,v,r,g,b);
  end
  else
  begin
    // we have a hue, hsv contains the colour to "colourise" with
    // h2s2v2 contains the variations in h and s, the centre values
    // (where the button is pure base colour) are S=240 and v=72
    // so we need to scale them so the base colour matches with the variations.
    // thats what fac1 and fac2 do.
    s := s2 * fac1;
    v := v2 * fac2;
    if s > 1 then s := 1;
    if v > 1 then v := 1;
    HSVtoRGB(h,s,v,r,g,b);
  end;
  result := (round(r*255) shl 16)+ (round(g * 255) shl 8) + round(b * 255)
end;

procedure TButtonDrawHelper.ButtonBlit(dest, source: TCanvas; pixl, pixt, pixw, pixh, stamp_size: integer; fill: boolean = true);
begin
  windows.BitBlt(dest.handle, pixl + 2, pixt + 2, STAMP_SIZE, STAMP_SIZE, source.Handle, 0, 0, SRCCOPY);
  // top
  windows.StretchBlt(dest.handle, pixl + 2 + pred(STAMP_SIZE), pixt + 2, (pixw - 4) - STAMP_SIZE * 2, STAMP_SIZE, source.Handle, pred(stamp_size), 0, 1, STAMP_SIZE, SRCCOPY);
  // top right
  windows.BitBlt(dest.handle, pred(pixl + pixw -2 - STAMP_SIZE), pixt + 2, STAMP_SIZE, STAMP_SIZE, source.Handle, STAMP_SIZE, 0, SRCCOPY);
  // right
  windows.StretchBlt(dest.handle, pred(pixl + pixw -2 - STAMP_SIZE), pixt + 2 + STAMP_SIZE, STAMP_SIZE, (pixh - 4) - succ(STAMP_SIZE * 2), source.Handle, STAMP_SIZE, pred(stamp_size), STAMP_SIZE, 1, SRCCOPY);
  // bottom right
  windows.BitBlt(dest.handle, pred(pixl + pixw -2 - STAMP_SIZE), pred((pixt + pixh - 2) - STAMP_SIZE), STAMP_SIZE, STAMP_SIZE, source.Handle, STAMP_SIZE, STAMP_SIZE, SRCCOPY);
  // bottom
  windows.StretchBlt(dest.handle, pixl + 2 + pred(STAMP_SIZE),pred((pixt + pixh - 2) - STAMP_SIZE), (pixw - 4) - (STAMP_SIZE * 2), STAMP_SIZE, source.Handle, pred(stamp_size), stamp_size, 1, STAMP_SIZE, SRCCOPY);
  // bottom left
  windows.BitBlt(dest.handle, pixl + 2, pred((pixt + pixh - 2) - STAMP_SIZE), STAMP_SIZE, STAMP_SIZE, source.Handle, 0, STAMP_SIZE, SRCCOPY);
  // left
  windows.StretchBlt(dest.handle, pixl+ 2, pixt + 2 + STAMP_SIZE, STAMP_SIZE, (pixh - 4) - succ(STAMP_SIZE * 2), source.Handle, 0, pred(stamp_size), STAMP_SIZE, 1, SRCCOPY);
  // middle bit
  if fill then
  begin
    dest.pen.style := psClear;
    dest.Rectangle(pixl+2+STAMP_SIZE, pixt+2+STAMP_SIZE, pixl+ (pixw - (STAMP_SIZE)),pixt+(pixh - (STAMP_SIZE)));
  end;
end;

constructor TButtonDrawHelper.create(AOwner: TPanelManager);
var
  i, j: integer;
  rasterline: PByteArray;
  refpalette: PMaxLogPalette;
begin
  inherited Create;
  BitmapCache := TTagCache.Create;
  ButtonBorder := TBitmap.create;
  PanelBorder := TBitmap.create;
  Square := TBitmap.create;
  Circle := TBitmap.create;
  HorizRect := TBitmap.create;
  VertRect := TBitmap.create;
  Diamond := TBitmap.create;
  Seat := TBitmap.create;
  SecurityIcon := TBitmap.create;
  try
    ButtonBorder.LoadFromResourceName(HInstance, 'AZTEC_BUTTON');
    ButtonBorderStampSize := ButtonBorder.width div 2;
    PanelBorder.LoadFromResourceName(Hinstance, 'AZTEC_BORDER');
    PanelBorderStampsize := PanelBorder.width div 2;
    Square.LoadFromResourceName(Hinstance, 'AZTEC_SQUARE');
    Circle.LoadFromResourceName(Hinstance, 'AZTEC_CIRCLE');
    HorizRect.LoadFromResourceName(Hinstance, 'AZTEC_HORIZRECT');
    VertRect.LoadFromResourceName(Hinstance, 'AZTEC_VERTRECT');
    Seat.LoadFromResourceName(Hinstance, 'AZTEC_SEAT');
    Diamond.LoadFromResourceName(Hinstance, 'AZTEC_DIAMOND');
    SecurityIcon.LoadFromResourceName(Hinstance, 'AZTEC_SECURITYICON');
  except
    raise Exception.create('Missing resources for TButtonDrawHelper');
  end;
  maskbm := TBitmap.create;
  with maskbm do
  begin
    Monochrome := true;
    PixelFormat := pf1bit;
    GetMem(refpalette, 4 * 4);
    refpalette.palVersion := 768;
    refpalette.palNumEntries := 2;
    //new(refpalette.palPalEntry)
    refpalette.palPalEntry[0].peRed := 0;
    refpalette.palPalEntry[0].peBlue := 0;
    refpalette.palPalEntry[0].peGreen := 0;
    refpalette.palPalEntry[0].peFlags := PC_EXPLICIT;
    refpalette.palPalEntry[1].peRed := 255;
    refpalette.palPalEntry[1].peBlue := 255;
    refpalette.palPalEntry[1].peGreen := 255;
    refpalette.palPalEntry[1].peFlags := PC_EXPLICIT;
    if maskbm.Palette <> 0 then DeleteObject(Palette);
    maskbm.Palette := createpalette(plogpalette(refpalette)^);
    dispose(refpalette);
    Width := 256;
    height := 256;
    for i := 0 to 255 do
    begin
      rasterline := scanline[i];
      if (i mod 2) = 0 then
        for j := 0 to 31 do
          rasterline[j] := 85
      else
        for j := 0 to 31 do
          rasterline[j] := 170;
    end;
  end;
end;

destructor TButtonDrawHelper.destroy;
begin
  BitmapCache.free;
  ButtonBorder.free;
  PanelBorder.free;
  Square.free;
  Circle.free;
  HorizRect.free;
  VertRect.free;
  Seat.free;
  SecurityIcon.free;
  inherited;
end;

procedure TButtonDrawHelper.paintbutton(canvas: TCanvas; pixt, pixl, pixw,
  pixh: integer; colour: TColor);
var
  stampbmp: TBitmap;
  x, y: integer;
  fac1, fac2, h,s,v, h2, s2, v2: double;
  tmpcol: Tcolor;
begin
  Canvas.Brush.Color := clblack;
  Canvas.Pen.Style := psClear;
  Canvas.Rectangle(pixl, pixt, 1+pixl+pixw, 1+pixt+pixh);
  Canvas.brush.color := colour;

  stampbmp := TBitmap(BitmapCache.lookup(colour));
  if stampbmp = nil then
  begin
    stampbmp := TBitmap.create;
    stampbmp.pixelformat := pf24bit;
    stampbmp.Width := buttonborderstampsize * 2;
    stampbmp.Height := buttonborderstampsize * 2;
    stampbmp.canvas.Pen.Style := psClear;
    stampbmp.Canvas.Brush.Color := clBlack;
    stampbmp.Canvas.Rectangle(0, 0, succ(buttonborderstampsize * 2), succ(buttonborderstampsize * 2));
    stampbmp.canvas.Brush.Color := colour;

    stampbmp.canvas.pen.style := psClear;
    stampbmp.canvas.brush.color := colour;
    stampbmp.Canvas.Rectangle(0 , 0, 1+(2 * buttonborderstampsize) , 1+(2 * buttonborderstampsize));

    tmpcol := 156;
    RGBtoHSV(((tmpcol and $ff0000) shr 16)/255, ((tmpcol and $ff00) shr 8)/255, (tmpcol and $ff)/255,
      h2, s2, v2);

    tmpcol := colour;
    RGBtoHSV(((tmpcol and $ff0000) shr 16)/255, ((tmpcol and $ff00) shr 8)/255, (tmpcol and $ff)/255,
      h, s, v);
    fac1 := s / s2;
    fac2 := v / v2;

    for x := 0 to pred(2 * buttonborderstampsize) do
      for y := 0 to pred(2 * buttonborderstampsize) do
      begin
        stampbmp.canvas.Pixels[x,y] := blend(buttonborder.canvas.Pixels[x,y],
           stampbmp.Canvas.pixels[x,y], x + y - (buttonborderstampsize*2), fac1, fac2, colour);
    end;
    bitmapcache.AddItem(colour, TObject(StampBmp));
  end;
  // stretch-blit the button
  ButtonBlit(canvas, stampbmp.canvas, pixl, pixt, pixw, pixh, buttonborderstampsize);
end;

procedure TButtonDrawHelper.paintborder(canvas: TCanvas; pixl, pixt,
  pixw, pixh: integer);
begin
  ButtonBlit(canvas, panelborder.canvas, pixl, pixt, pixw, pixh, panelborderstampsize, false);
end;

procedure TButtonDrawHelper.draw(drawtype: TTillButtonDrawType;
  canvas: TCanvas; pixt, pixl, pixw, pixh: integer; colour: TColor);
var
  srcbmp: TBitmap;
begin
  if drawtype = tbdtButton then
    paintbutton(canvas, pixt, pixl, pixw, pixh, colour)
  else
  begin
    case drawtype of
      tbdtSquare: srcbmp := Square;
      tbdtCircle: srcbmp := Circle;
      tbdtHorizRect: srcbmp := HorizRect;
      tbdtVertRect: srcbmp := VertRect;
      tbdtSeat: srcbmp := Seat;
      tbdtDiamond: srcbmp := Diamond;
    else
      raise Exception.create('TButtonDrawHelper: Invalid draw type specified');
    end;
    if drawtype = tbdtSeat then
      bitblt(canvas.Handle, pixl, pixt, pixw, pixh, srcbmp.Canvas.Handle, 0, 0,
        SRCCOPY)
    else
      stretchblt(canvas.Handle, pixl, pixt, pixw, pixh, srcbmp.Canvas.Handle, 0,
        0, srcbmp.Width, srcbmp.Height, SRCCOPY);
  end;
end;

{ TTagCache }

procedure TTagCache.AddItem(tag: cardinal; item: TObject);
  procedure RecInsert(var tree: PCachenode; node: PCachenode);
  begin
    if tree = nil then
    begin
      tree := node;
    end else
    begin
      // no duplicates
      if node.tag = tree.tag then exit;
      if node.tag < tree.tag then
        RecInsert(tree.left, node)
      else
      if node.tag > tree.tag then
        RecInsert(tree.right, node);
    end;
  end;
var
  newnode: PCacheNode;
begin
  newnode := allocmem(sizeof(TCacheNode));
  newnode.tag := tag;
  newnode.item := item;
  newnode.left := nil;
  newnode.right := nil;
  recinsert(rootnode, newnode);
end;

constructor TTagCache.Create;
begin
  inherited Create;
  rootnode := nil;
end;

destructor TTagCache.Destroy;
  procedure RecFree(node: PCacheNode);
  begin
    if node = nil then exit;
    if assigned(node.left) then RecFree(node.left);
    if assigned(node.right) then RecFree(node.right);
    FreeMem(node);
  end;
begin
  RecFree(rootnode);
end;

function TTagCache.Lookup(tag: cardinal): TObject;
var
  searchnode: PCacheNode;
begin
  searchnode := rootnode;
  result := nil;
  while assigned(searchnode) and (searchnode.tag <> tag) do
  begin
    if tag < searchnode.tag then searchnode := searchnode.left
    else if tag > searchnode.tag then searchnode := searchnode.right;
  end;
  if assigned(searchnode) then
    result := searchnode.item;
end;

{ TTillObject }

procedure TTillObject.SetTop(value: integer);
begin
  if fixedpos then exit;
  inherited top := value;
  upd := true;
end;

procedure TTillObject.SetLeft(value: integer);
begin
  if fixedpos then exit;
  inherited left := value;
  upd := true;
end;

procedure TTillObject.SetWidth(value: integer);
begin
  if fixedwidth then exit;
  inherited width := value;
  upd := true;
end;

procedure TTillObject.SetHeight(value: integer);
begin
  if fixedheight then exit;
  inherited height := value;
  upd := true;
end;

constructor TTillObject.create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Canvas.Font.Name := 'MS Shell Dlg 2';
  ControlStyle := ControlStyle + [csReplicatable];
  dragmode := dmManual;
  if Assigned(AOwner) then
  begin
    if AOwner.classname = 'TPanelManager' then
    begin
      parent := TPanelManager(AOwner).OwnerForm;
      panelmanager := TPanelManager(AOwner);
    end
    else
    begin
      panelmanager := nil;
    end;
    ControlStyle := ControlStyle + [csReplicatable];
    dragmode := dmManual;
    FDataLink := TFieldDataLink.create;
    FDataLink.control := self;
    FDataLink.ondatachange := self.datachange;
    OnDragDrop := RelayDragDrop;
    OnDragOver := RelayDragOver;
    kip := true;
  end;
end;

destructor TTillObject.destroy;
begin
  FDataLink.Free;
  inherited;
end;

procedure TTillObject.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TTillObject.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TTillObject.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
end;

procedure TTillObject.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: integer);
var
  pos: TPoint;
begin
  inherited;
  if assigned(panelmanager) and panelmanager.readonly then
  begin
    panelmanager.fselectedobject := self;
    exit;
  end;

  if (self is TTillLabel) then
    if TTillLabel(Self).IsForcedItemHeader then
    begin
      panelmanager.fselectedobject := self;
      exit;
    end;


  if not(csdesigning in componentstate) then
  begin
    if assigned(fdatalink) and fdatalink.active and fdatalink.dataset.active and allowdrag and assigned(fdatalink.dataset.fields[0]) and not fdatalink.dataset.fields[0].isnull then
      BeginDrag(false, 10)
    else
    if assigned(panelmanager) then
    begin
      if (button = mbLeft) then
      begin
        pos.x := x;
        pos.y := y;
        pos := clienttoscreen(pos);
        PanelManager.DragInitialClick(self, pos, shift);
      end
      else
      if (button = mbRight) then
      begin
        PanelManager.DragInitialClick(self, pos, shift);
        PanelManager.HandleContextClick;
      end;
    end;
  end;
end;

procedure TTillObject.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  pos: TPoint;
begin
  inherited;
  if not(csdesigning in componentstate) and assigned(panelmanager) then
  begin
    pos.x := x;
    pos.y := y;
    pos := clienttoscreen(pos);
    PanelManager.DragMove(pos);
  end;
end;

procedure TTillObject.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: integer);
var
  pos: TPoint;
begin
  inherited;
  if not(csdesigning in componentstate) and assigned(panelmanager) and (button = mbLeft) then
  begin
    pos.x := x;
    pos.y := y;
    pos := clienttoscreen(pos);
    PanelManager.DragFinalClick(self, pos, shift);
  end;
end;

procedure TTillObject.RelayDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  pos: TPoint;
begin
  if not(csdesigning in componentstate) and assigned(panelmanager) then
  begin
    pos.X := x;
    pos.Y := y;
    pos := parent.screentoclient(ClientToScreen(pos));
    PanelManager.DoDragDrop(Sender, Source, pos.x, pos.y);
  end;
end;

procedure TTillObject.RelayDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  pos: TPoint;
begin
  if assigned(fdatalink) and fdatalink.active then
    accept := false
  else
    if not(csdesigning in componentstate) and assigned(panelmanager) then
    begin
      pos.X := x;
      pos.Y := y;
      pos := parent.screentoclient(ClientToScreen(pos));
      PanelManager.DoDragOver(Sender, Source, pos.x, pos.y, state, accept);
    end;
end;


function TTillObject.GetDatasource: TDatasource;
begin
  if not assigned(FDataLink) then
    result := nil
  else
    result := FDataLink.DataSource;
end;

procedure TTillObject.SetDatasource(const Value: TDatasource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TTillObject.DataChange(sender: TObject);
begin
  //
end;

procedure TTillObject.DblClick;
begin
  inherited;
  if not(csdesigning in componentstate) and assigned(panelmanager) then
  begin
    if (Self is TTillLabel) then
      if TTillLabel(Self).IsForcedItemHeader then
        raise Exception.create('The top 2 labels on this panel are reserved for the Terminal and cannot be modified or deleted.')
      else if PanelManager.EditingCorrectionPanel then
        raise Exception.create('The labels on the correction panel are reserved for the Terminal and cannot be modified or deleted.');

    PanelManager.HandleDoubleClick;
  end;
end;

procedure TTillObject.Delete;
begin
  //parent := nil;
  if self is TTillHeader then
    if TTillHeader(self).HeaderType <> 'DriveThruPlan' then
    raise Exception.create('You may not delete a header control.');

  if (self is TTillLabel) then
    if TTillLabel(self).IsForcedItemHeader then
      raise Exception.create('The top 2 labels on this panel are reserved for the Terminal and cannot be modified or deleted.')
    else if PanelManager.EditingCorrectionPanel then
      raise Exception.create('The labels on the correction panel are reserved for the Terminal and cannot be modified or deleted.');
  visible := false;
  kip := false;
  upd := true;
  if panelmanager.selectedobject = self then panelmanager.selectedobject := nil;
end;


procedure TTillObject.LoadFromDataSet(loadtype: TLoadType;
  dataset: TDataSet);
begin
  //
end;

procedure TTillObject.SaveToDataSet(dataset: TDataSet);
begin
  //
end;

procedure TTillObject.Setupd(const Value: boolean);
begin
  Fupd := Value;
  if assigned(panelmanager) and not(assigned(fdatalink) and fdatalink.active) then
    panelmanager.detailsmodified := true;
end;

procedure TTillObject.SetAllowDrag(const Value: boolean);
begin
  FAllowDrag := Value;
end;

procedure TTillObject.paint;
begin
  // implemented in descendents
end;   

procedure TTillObject.paintto(Canvas: TCanvas; paintpos: TPoint);
begin
  // implemented in descendents
end;

{ TPanelManager }

procedure TPanelManager.AlignDragHandles(control: TControl);
var
  SingleSelectState, MultiSelectState: boolean;
  Position: TRect;
begin
  MultiSelectState := Assigned(Control) and (Control is TMultiItemSelection);
  SingleSelectState := not(MultiSelectState) and Assigned(Control);
  if MultiSelectState or SingleSelectState then
  begin
    Position.Top := Control.Top;
    Position.Left := Control.Left;
    Position.Right := Control.Width;
    Position.Bottom := Control.Height;
  end;

  MultiSelect.SetHandlesVisible(MultiSelectState);
  draghandles[dhTop].Top := Position.Top + 0;
  draghandles[dhTop].Left := Position.Left + (Position.Right -DRAG_HANDLE_WIDTH) div 2;
  draghandles[dhTopRight].Top := Position.Top + 0;
  draghandles[dhTopRight].Left := Position.Left + Position.Right - DRAG_HANDLE_WIDTH;
  draghandles[dhRight].Top := Position.Top + (Position.Bottom - DRAG_HANDLE_WIDTH) div 2;
  draghandles[dhRight].Left := Position.Left + Position.Right - DRAG_HANDLE_WIDTH;
  draghandles[dhBottomRight].Left := Position.Left + Position.Right - DRAG_HANDLE_WIDTH;
  draghandles[dhBottomRight].Top := Position.Top + Position.Bottom - DRAG_HANDLE_WIDTH;
  draghandles[dhBottom].Top := Position.Top + Position.Bottom - DRAG_HANDLE_WIDTH;
  draghandles[dhBottom].Left := Position.Left + (Position.Right -DRAG_HANDLE_WIDTH) div 2;
  draghandles[dhBottomLeft].Top := Position.Top + Position.Bottom - DRAG_HANDLE_WIDTH;
  draghandles[dhBottomLeft].Left := Position.Left + 0;
  draghandles[dhLeft].Top := Position.Top + (Position.Bottom - DRAG_HANDLE_WIDTH) div 2;
  draghandles[dhLeft].Left := Position.Left + 0;
  draghandles[dhTopLeft].Top := Position.Top + 0;
  draghandles[dhTopLeft].Left := Position.Left + 0;

  draghandles[dhTop].visible := SingleSelectState;
  draghandles[dhLeft].visible := SingleSelectState;
  draghandles[dhBottom].visible := SingleSelectState;
  draghandles[dhRight].visible := SingleSelectState;
  if DRAGCORNERS then
  begin
    draghandles[dhTopRight].visible := SingleSelectState;
    draghandles[dhBottomRight].visible := SingleSelectState;
    draghandles[dhBottomLeft].visible := SingleSelectState;
    draghandles[dhTopLeft].visible := SingleSelectState;
  end;
end;

constructor TPanelManager.Create(AOwner: TForm);
var
  i: integer;
  j: TPopupMenuItem;
  imageindex: integer;
  tempmenuitem: TMenuItem;
  TempIcon: TIcon;
  TempSize: TSize;
  TempBitmap: TBitmap;
  BGName: string;
begin
  pd := TPanelDisplayTransform.Create();
  MultiSelect := TMultiItemSelection.create(Self);
  ReadOnly := false;
  FPanelOutLine := TPanelOutline.Create(Self);
  FPanelOutLine.Tag := 0;
  FPanelOutLine.Parent := AOwner;
  FPanelOutLine.DragHandlesVisible := False;

  if not assigned(AOwner) then
    raise exception.create('TPanelManager: Attempt to construct with no owner');
  inherited Create(AOwner);
  OwnerForm := AOwner;
  OwnerForm.OnDragDrop := DoDragDrop;
  OwnerForm.OnDragOver := DoDragOver;
  OwnerForm.OnKeyUp := DoKeyUp;
  lastbuttonpos.x := -1;
  lastbuttonpos.y := -1;
  DragDestRectDrawn := false;
  for i := ord(dhTop) to ord(dhTopLeft)  do
    if DRAGCORNERS or not(TDragHandleType(i) in [dhTopRight, dhBottomRight, dhBottomLeft, dhTopLeft]) then
    begin
      // order top bottom left right edges
      DragHandles[TDragHandleType(i)] := TDragHandle.Create(AOwner, TDragHandleType(i), True);
      with draghandles[TDragHandleType(i)] do
      begin
        OnMouseMove := DragHandleMouseMove;
        OnMouseDown := DragHandleMouseDown;
        OnMouseUp := DragHandleMouseUp;
      end;
    end;
  // colour/draw type lookup tables are set up, use these to generate
  // the button context menu
  backdropmenu := TPopupmenu.create(nil);
  backdropcolourlist := TImagelist.create(nil);
  backdropmenu.Images := backdropcolourlist;

  for j := low(TPopupMenuItem) to high(TPopupMenuItem) do
  begin
    tempmenuitem := TMenuItem.create(nil);
    tempmenuitem.name := format('BackdropMenuItem%d', [ord(j)]);
    tempmenuitem.caption := '';
    BGName := GetEnumName(TypeInfo(TPopupMenuItem), Ord(j));
    if (j >= pmBackdropDarkBlue) and (j <= pmBackdropClose)  then
    begin
      ImageIndex := backdropcolourlist.Add(createcolourbitmap(EposBGNameToColour(Copy(BGName, 11, length(BGName)))), nil);
    end
    else
    if j in [pmFontWhite, pmFontGrey, pmFontBlack] then
    begin
      case j of
        pmFontWhite:
          TempBitmap := createcolourbitmap($404040);
        pmFontGrey:
          TempBitmap := createcolourbitmap($f0f0f0);
      else
        TempBitmap := createcolourbitmap($ffffff);
      end;

      TempSize := TempBitmap.Canvas.TextExtent('A');
      TempSize.cx := (TempBitmap.Canvas.ClipRect.right - tempsize.cx) div 2;
      TempSize.cy := (TempBitmap.Canvas.ClipRect.bottom - tempsize.cy) div 2;
      case j of
        pmFontWhite:
          TempBitmap.Canvas.Font.Color := clWhite;
        pmFontGrey:
          TempBitmap.Canvas.Font.Color := clDkGray;
        pmFontBlack:
          TempBitmap.Canvas.Font.Color := clBlack;
      end;
      TempBitmap.Canvas.TextRect(TempBitmap.Canvas.ClipRect, TempSize.cx, TempSize.cy, 'A');
      ImageIndex := backdropcolourlist.Add(TempBitmap, nil);
    end
    else
    begin
      TempIcon := TIcon.Create;
      case j of
      pmFunctionSecurity:
        begin
          TempIcon.Handle := LoadImage(HInstance, 'TM_MENU_SECURITY', IMAGE_ICON, 16, 16, LR_SHARED);
        end;
      pmFunctionLargeFont:
        begin
          TempIcon.Handle := LoadIcon(HInstance, 'TM_MENU_LARGEFONT');
        end;
      pmFunctionSmallFont:
        begin
          TempIcon.Handle := LoadIcon(HInstance, 'TM_MENU_SMALLFONT');
        end;
      pmFunctionSort:
        begin
          TempIcon.Handle := LoadIcon(HInstance, 'TM_MENU_SORT');
        end;
      end;
      imageindex := BackdropColourlist.AddIcon(TempIcon);
      //BackDropColourList.AddIcon(TempIcon);
      TempIcon.Free;
    end;
    tempmenuitem.imageindex := imageindex;
    if imageindex mod 4 = 0 then
      tempmenuitem.Break := mbBreak;
    tempmenuitem.Tag := ord(j);
    tempmenuitem.OnClick := HandlePopupClick;
    TempMenuItem.OnDrawItem := HandlePopupDraw;
    TempMenuItem.OnMeasureItem := HandlePopupMeasure;
    backdropmenu.items.add(tempmenuitem);
  end;

  FSPOL := TPanelOutline.Create(Self);
 //** This changes the out line colour
  FSPOL.Tag := 1;
  FSPOL.Parent := AOwner;
  FSPOL.DragHandlesVisible := False;
  FSPOL.OnDimsChange := AlignDragHandles;
  FSPOL.Visible := False;
  FMinSiteDBVersionUsingPanel := TDataBaseVersion.Create;
  FFlagFunctionVersion := True;
  FPictureCache := TPictureCache.Create;
end;

procedure TPanelManager.DragInitialClick(obj: TControl; Pos: TPoint;shift: TShiftState);
var
  tmp: TControl;
begin
  if (obj is TpanelOutline) and (Paneltype in [ptShared, ptVariationPanel]) then
    exit;

  dragok := false;
  if not(ssCtrl in Shift) then
  begin
    if (
      not(ssRight in Shift) or ((SelectedObject = nil) or (SelectedObject <> MultiSelect))
    ) then
    begin
      if Assigned(SelectedObject) then
      begin
        tmp := SelectedObject;
        SelectedObject := nil;
        tmp.repaint;
      end;
      SelectedObject := obj;
      obj.repaint;
    end;
  end
  else
  if assigned(SelectedObject) and (obj is TTillbutton) and (ssCtrl in Shift) then
  begin
    if (SelectedObject is TTillbutton) and (SelectedObject <> obj) then
    begin
      MultiSelect.Clear;
      MultiSelect.ToggleSelection(SelectedObject);
      SelectedObject := MultiSelect;
    end;
    if SelectedObject is TMultiItemSelection then
      TMultiItemSelection(SelectedObject).ToggleSelection(obj);
  end;

  pos := ownerform.screentoclient(pos);
  InitialPos.x := obj.Left;
  InitialPos.y := obj.Top;
  LastButtonPos := Point(-1, -1);
  InitialOffset.x := initialpos.x - pos.x;
  InitialOffset.y := initialpos.y - pos.y;
  if SnapToGrid then SnapPointToGrid(InitialPos);
  Dragging := true;
  DragDestRectDrawn := false;
end;

procedure TPanelManager.DragMove(Pos: TPoint);
var
  ButtonPos: TPoint;
begin
  if Dragging then
  begin
    if not assigned(selectedobject) then exit;
    pos := ownerform.screentoclient(pos);
    ButtonPos.x := pos.X + initialoffset.x; //(pos.x - panel.BorderSize) div bt_width;
    ButtonPos.y := pos.y + initialoffset.y; //(pos.y - panel.BorderSize) div bt_height;
    if SnapToGrid then SnapPointToGrid(ButtonPos);
    if (ButtonPos.x = LastButtonpos.x) and (Buttonpos.Y = lastbuttonpos.y) then
      exit;
    if DragDestRectDrawn then
    begin
      PaintOutline;
      DragDestRectDrawn := false;
    end;
    LastButtonPos := buttonpos;
    if (buttonpos.x = initialpos.x) and (buttonpos.y = initialpos.y) then
    begin
      DragPos := buttonpos;
      exit;
    end;
    screen.cursor := crSizeAll;
    DragDestRect.Left := buttonpos.x; //(buttonpos.x + initialoffset.x) * bt_width + panel.BorderSize;
    DragDestRect.Top := buttonpos.y; //(buttonpos.y + initialoffset.y) * bt_height + panel.BorderSize;
    DragDestRect.Right := buttonpos.x + selectedobject.width; //DragDestRect.Left + SelectedButton.Width;
    DragDestRect.Bottom := buttonpos.y + selectedobject.height; //DragDestRect.Top + SelectedButton.Height;
    PaintOutline;
    DragDestRectDrawn := true;
    if SelectedObject is TTillObject then
      dragok := CheckBtnMoveValid(buttonpos.x, buttonpos.y, (selectedobject.width),
        (selectedobject.height), TTillObject(selectedobject))
    else if SelectedObject is TPanelOutline then
      DragOK :=NewPanelPosValid(ButtonPos.Y,
                                 ButtonPos.X,
                                 ButtonPos.Y + TPanelOutline(selectedobject).Height,
                                 ButtonPos.X + TPanelOutline(selectedobject).Width,
                                 TPanelOutline(SelectedObject).HideOrderDisplay);

    if dragok then
    begin
      DragPos.x := ButtonPos.x;// + initialoffset.x;
      DragPos.y := ButtonPos.y;// + initialoffset.y;
    end;
    if not dragok then screen.cursor := crNo;
  end
  else
  begin
    // safety check
    if DragDestRectDrawn then
    begin
      PaintOutline;
      DragDestRectDrawn := false;
    end;
  end;
end;

//------------------------------------------------------------------------------
function TPanelManager.NewPanelPosValid(PanelTop, PanelLeft, panelBottom, PanelRight : Integer;  HOD : Boolean) : Boolean;
var
  PanelBounds: TRect;
  ScreenBounds: TRect;
  TmpRect: TRect;
begin
  PanelBounds := Rect(PanelLeft, PanelTop, PanelRight, PanelBottom);
  ScreenBounds := pd.GetScreenRect();
  // Above rect has width and height as right/bottom
  ScreenBounds.Right := ScreenBounds.Left + ScreenBounds.Right;
  ScreenBounds.Bottom := ScreenBounds.Top + ScreenBounds.Bottom;

  result := true;
  IntersectRect(TmpRect, PanelBounds, ScreenBounds);
  if (
    (TmpRect.Left <> PanelBounds.Left)
    or (TmpRect.Top <> PanelBounds.Top)
    or (TmpRect.Right <> PanelBounds.Right)
    or (TmpRect.Bottom <> PanelBounds.Bottom)
  ) then
    result := false;

  if not HOD then
  begin
    if IntersectRect(TmpRect, OrderDisplayBounds, PanelBounds) then
      result := false;
  end;
end;


procedure TPanelManager.DragFinalClick(obj: TControl; Pos: TPoint;
  shift: TShiftState);
var
  PosOK : Boolean;
begin
  if Dragging then
  begin
    RemoveSelection;
    if DragOk then
    begin
    //*************************************************************************
    //** Next two lines of code are not obvious and need explaining.
    //** The only situation where the below check can happen is when we are moving a shared panel.
    //** We do not allow the panelmanager to select any other till object while adding a shared panel
    //** so if a user clicks on a till button and starts to drag. the till button fires the move events.
    //** HOWEVER all the move validation routines use the selected object...the shared panel.
    //** so in this event again fired by the tillbutton set Obj to the Selected Obj.
    //** As we have been validating the position with respect to the Selected Obj this will be a valid position
    //** for the selected object ie the shared panel
      if obj <> SelectedObject then
        obj := SelectedObject;
    //*************************************************************************
      if (obj is TTillObject) or (obj is TMultiItemSelection) then
      begin
        if (dragpos.X < 0) or (dragpos.y < 0) or (dragpos.x > ownerform.clientwidth) or
          (dragpos.y > ownerform.clientheight) then
          // job 18048
            delete
        else
        begin
          if SelectedObject is TTillObject then
          begin
            TTillObject(selectedobject).left := dragpos.x;
            TTillObject(Selectedobject).top := dragpos.y;
          end
          else
          begin
            selectedobject.left := dragpos.x;
            selectedobject.top := dragpos.y;
          end;
          AlignDragHandles(selectedobject);
        end;
      end
      else if obj is TpanelOutline then
      begin
        if obj = FPanelOutLine then
        begin
          PosOk := NewPanelPosValid(DragPos.Y, dragPos.X, DragPos.Y + PanelHeight, dragPos.X + PanelWidth, TpanelOutline(obj).HideOrderDisplay);
          if PosOk then
          begin
            PanelLeft := dragpos.x;
            PanelTop := dragpos.y;
          end
        end
        else
        begin
          obj.Left := dragpos.x;
          obj.Top := dragpos.Y;
          AlignDragHandles(obj);
          if Assigned(FmoveSPOL) then
            FmoveSPOL(obj.Top, obj.Left);
        end;
      end;
    end;
    Dragging := false;
    Screen.cursor := crDefault;
  end;
end;

procedure TPanelManager.PaintOutline;
begin
  with OwnerForm do
  begin
    canvas.pen.mode := pmXor;
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Width := 2;
    canvas.pen.color := clWhite;
    canvas.brush.style := bsClear;
    Canvas.Rectangle(DragDestRect.Left + 2 , DragDestRect.Top +2 , DragDestRect.Right -1 , DragDestRect.Bottom -1);
  end;
end;

procedure TPanelManager.RemoveSelection;
begin
  if DragDestRectDrawn then
  begin
    paintoutline;
    DragDestRectDrawn := false;
  end;
end;

procedure TPanelManager.SetSelectedObject(const Value: TControl);
begin
  FEnableSPEdit := False;
  if FValidatingSharedPanel then
    exit;
  RemoveSelection;
  AlignDragHandles(value);
  
  FSelectedObject := Value;
  if assigned(value) then
  begin
    // order top bottom left right edges
    if ((Value is TTillButton) and (TTillButton(Value).ButtonTypeID = OpenPanelFunctionID)
        and (TTillButton(Value).ButtonTypeData <> ''))
      or (Value is TTillSubPanel) then
      if Assigned(FOpenPanelOK) then
        FOpenPanelOK(TTillObject(Value), False);
  end;

end;

procedure TPanelManager.move(vector: TPoint);
var
  initialpos, scanpos: TPoint;
  scanlength, i: integer;
begin
  // do a simple scan in direction indicated by xvec, yvec to find
  // the next button in that direction and select it
  if assigned(selectedobject) then
  begin
    initialpos.x := selectedobject.top;
    initialpos.y := selectedobject.left;
    // either vector x or y will be zero
    // TODO: Speedup scan if grid enabled
    if vector.x <> 0 then
      scanlength := (initialpos.X - panelwidth) div vector.x
    else
      scanlength := (initialpos.Y - panelwidth) div vector.y;
    scanpos := initialpos;
    for i := 1 to scanlength do
    begin
      scanpos.x := initialpos.x + vector.x;
      scanpos.y := initialpos.y + vector.y;
    end;
  end;
end;

procedure TPanelManager.Delete;
begin
  if assigned(selectedobject) and (SelectedObject is TTillObject) then
  begin
    if EditingCorrectionPanel and not (
      (SelectedObject is TTillSubPanel) or
      (SelectedObject is TTillLabel) or
      ((Selectedobject is TTillButton) and (TTillButton(selectedobject).IsValidForCorrectionPanel or IsSingleItemDiscount(TTillButton(selectedObject))))
    ) then
      raise Exception.create('This button may not be deleted from the correction panel.');

    if (SelectedObject is TTillButton) then
    begin
      with SelectedObject AS TTillButton do
      begin
        Log('Panel "' + PanelName + '" PanelID ' + IntToStr(PanelID) + ' - deleting button "' +
        Trim(StringReplace(StringReplace(GetButtonText,#10,' ',[rfReplaceAll]),#13,' ',[rfReplaceAll])) +
        '", Type ID ' + IntToStr(ButtonTypeID) + ', Data ' + ButtonTypeData + ', UserName ' + dmADO.Logon_Name);
      end;
    end;

    TTillObject(selectedobject).delete;
  end;
end;

procedure TPanelManager.DragHandleMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  pos, delta: TPoint;
  buttondims, NewDragDest: TRect;
  dragok: boolean;
begin
  if sizing then
  begin
    // TODO: Refactor completely!
    pos.x := x;
    pos.y := y;
    if SelectedObject is TTillObject then
    begin
      pos := TControl(sender).clienttoscreen(pos);
      pos := ownerform.ScreenToClient(pos);
    end;

    delta.x := pos.x - sizeinitialpos.x;
    delta.y := pos.y - sizeinitialpos.y;

    buttondims.Left := selectedobject.left;
    buttondims.Top := selectedobject.top;
    buttondims.Right := selectedobject.width;
    buttondims.Bottom := selectedobject.height;
    buttondims.right := buttondims.right + buttondims.left;
    buttondims.bottom := buttondims.bottom + buttondims.top;

    DragCheck(TDragHandleType(TControl(sender).Tag), delta, buttondims);
    buttondims.Right := buttondims.Right - buttondims.Left;
    buttondims.bottom := buttondims.bottom - buttondims.top;

    if SelectedObject is TPanelOutLine then
    begin
      buttondims.right := buttondims.right + buttondims.left; //** Right In Pixels
      buttondims.bottom := buttondims.bottom + buttondims.top; //** Bottom In Pixels
      SnapPointToGrid(buttondims.topleft);
      SnapPointToGrid(buttondims.bottomright);
      dragOK := SilentCheckSetWH(buttondims.right-buttondims.left , buttondims.Bottom-buttondims.Top) and
                (NewPanelPosValid(buttondims.Top, buttondims.Left, buttondims.Bottom,buttondims.right, HideOrderDisplay ));

      // further check for Min Size if Forced Selection Panel
      if dragOK and ForcedSelectionPanel then
      begin
        if ((((buttondims.right - buttondims.Left)) div pd.buttonwidth) < MinWidthInButtons) or
           (((buttondims.bottom - buttondims.top) div pd.buttonheight) < MinHeightInButtons) then
          dragOK := false;
      end;
    end
    else
    begin
      dragok := CheckBtnMoveValid(buttondims.Left, buttondims.Top, buttondims.Right,
                                  buttondims.Bottom, TTillObject(selectedobject));
      buttondims.right := buttondims.right + buttondims.left;
      buttondims.bottom := buttondims.bottom + buttondims.top;
    end;

    NewDragDest := ButtonDims;
    if SnapToGrid then SnapPointToGrid(NewDragDest.topleft);
    if SnapToGrid then SnapPointToGrid(NewDragDest.bottomright);
    // disallow zero width and height
    if dragok and ((newdragdest.right <= newdragdest.Left) or
      (newdragdest.bottom <= newdragdest.top)) then
      dragok := false;

    if ((NewDragDest.top <> DragDestRect.Top) or
      (NewDragDest.left <> DragDestRect.left) or
      (NewDragDest.right <> DragDestRect.right) or
      (NewDragDest.bottom <> DragDestRect.bottom)) then
    begin
      if DragOk then
      begin
        if DragDestRectDrawn then PaintOutline;
        DragDestRectDrawn := false;
      //DragDestRect := buttondims;
        DragDestRect.topleft := NewDragDest.TopLeft;
        DragDestRect.BottomRight := NewDragDest.BottomRight;
        PaintOutline;
        DragDestRectDrawn := true;
      end;
    end;
    if dragok then
    begin
      case TDragHandleType(TControl(sender).Tag) of
      dhTop, dhBottom: screen.Cursor := crSizeNS;
      dhLeft, dhRight: screen.Cursor := crSizeWE;
      dhTopLeft, dhBottomRight: screen.Cursor := crSizeNWSE;
      dhTopRight, dhBottomLeft: screen.Cursor := crsizeNESW;
      end
    end
    else
      screen.Cursor := crNo;
  end;
end;

procedure TPanelManager.DragHandleMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pos: TPoint;
begin
  if button = mbLeft then
  begin
    // sizing not allowed for these types of button

    pos.x := x;
    pos.y := y;
    if SelectedObject is TTillObject then
    begin
      pos := TControl(sender).clienttoscreen(pos);
      pos := ownerform.ScreenToClient(pos);
    end;
    setcapture(TForm(sender).Handle);
    sizedirection := TDragHandleType(TControl(sender).tag);
    sizeinitialpos := pos;

    if SelectedObject is TpanelOutline then
    begin
      sizing := True;
      Exit;
    end;

    if (SelectedObject is TTillButton) and (TTillButton(selectedobject).drawtype in
      [tbdtHorizRect, tbdtVertRect, tbdtSeat]) then
    begin
      sizing := false;
      exit;
    end;
    if (TTillObject(selectedobject).FixedWidth and
      not(TDragHandleType(TControl(sender).tag) in [dhTop, dhBottom])) or
      (TTillObject(selectedobject).FixedHeight and
      not(TDragHandleType(TControl(sender).tag) in [dhLeft, dhRight])) then
    begin
      sizing := false;
      exit;
    end;
    sizing := true;
  end;
  if button = mbRight then
  begin
    if assigned(ObjectContextEvent) then
    begin
      ObjectContextEvent(TTillObject(selectedobject));
    end;
  end;
end;

procedure TPanelManager.DragHandleMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pos: TPoint;
  delta: TPoint;
  buttondims: TRect;
  dragok: boolean;
begin
  if (button = mbLeft) and sizing then
  begin
    // TODO: refactor completely!
    pos.x := x;
    pos.y := y;
    if SelectedObject is TTillObject then
    begin
      pos := TControl(sender).clienttoscreen(pos);
      pos := ownerform.ScreenToClient(pos);
    end;
    releasecapture;
    delta.x := pos.x - sizeinitialpos.x;
    delta.y := pos.y - sizeinitialpos.y;
    buttondims.Left := selectedobject.left;
    buttondims.Top := selectedobject.top;
    buttondims.Right := selectedobject.width;// + buttondims.left;
    buttondims.Bottom := selectedobject.height;// + buttondims.top;

    buttondims.right := buttondims.right + buttondims.left;
    buttondims.bottom := buttondims.bottom + buttondims.top;
    DragCheck(TDragHandleType(TControl(sender).Tag), delta, buttondims);
    buttondims.Right := buttondims.Right - buttondims.Left;
    buttondims.bottom := buttondims.bottom - buttondims.top;


    if SelectedObject is TPanelOutline then
    begin
      buttondims.right := buttondims.right + buttondims.left; //** Right In Pixels
      buttondims.bottom := buttondims.bottom + buttondims.top; //** Bottom In Pixels
      SnapPointToGrid(buttondims.topleft);
      SnapPointToGrid(buttondims.bottomright);
      dragOK := SilentCheckSetWH(buttondims.right - buttondims.left, buttondims.Bottom - buttondims.top) and
                (NewPanelPosValid(buttondims.Top, buttondims.Left, buttondims.Bottom, buttondims.right,HideOrderDisplay));

      // further check for Min Size if Forced Selection Panel
      if dragOK and ForcedSelectionPanel then
      begin
        if ((((buttondims.right - buttondims.Left)) div pd.buttonwidth) < MinWidthInButtons) or
           (((buttondims.bottom - buttondims.top) div pd.buttonheight) < MinHeightInButtons) then
          dragOK := false;
      end;
    end
    else
    begin
      dragok := CheckBtnMoveValid(buttondims.Left, buttondims.Top, buttondims.Right,
                                  buttondims.Bottom, TTillObject(selectedobject));
      buttondims.right := buttondims.right + buttondims.left;
      buttondims.bottom := buttondims.bottom + buttondims.top;
      if SnapToGrid then SnapPointToGrid(buttondims.topleft);
      if SnapToGrid then SnapPointToGrid(buttondims.bottomright);
   end;

    // disallow zero width and height
    if dragok and ((buttondims.right <= buttondims.Left) or
    (buttondims.bottom <= buttondims.top)) then
      dragok := false;
    if dragok then
    begin
      if selectedobject is TTillObject then
      begin
        TTillObject(selectedobject).visible := false;
        TTillObject(selectedobject).left := buttondims.left;
        TTillObject(selectedobject).top := buttondims.Top;
        TTillObject(selectedobject).width := buttondims.right - buttondims.left;
        TTillObject(selectedobject).height := buttondims.bottom - buttondims.Top;
        self.AlignDragHandles(selectedobject);
        TTillObject(selectedobject).visible := true;
      end;
      if SelectedObject is TPanelOutline then
      begin
        if SelectedObject = FPanelOutLine then
        begin
          PanelTop := buttondims.Top;
          PanelLeft := buttondims.left;
          PanelWidth :=buttondims.right - buttondims.left;
          PanelHeight := buttondims.bottom - buttondims.Top;
          self.AlignDragHandles(selectedobject);
        end
        else
        begin
          selectedobject.left := buttondims.left;
          selectedobject.top := buttondims.Top;
          selectedobject.width := buttondims.right - buttondims.left;
          selectedobject.height := buttondims.bottom - buttondims.Top;
        end;
      end;
    end;
    if DragDestRectDrawn then
    begin
      PaintOutline;
      DragDestRectDrawn := false;
    end;
    sizing := false;
  end;
  screen.cursor := crDefault;
end;

procedure TPanelManager.DragCheck(dragtype: TDragHandleType; delta: TPoint; var buttondims: TRect);
begin
  with buttondims do
    case dragtype of
      dhTop:
        begin
          top := top + delta.y;
        end;
      dhTopRight:
        begin
          top := top + delta.y;
          right := right + delta.x;
        end;
      dhRight:
        right := right + delta.x;
      dhBottomRight:
        begin
          bottom := bottom + delta.Y;
          right := right + delta.x;
        end;
      dhBottom:
        bottom := bottom + delta.Y;
      dhBottomLeft:
        begin
          bottom := bottom + delta.Y;
          left := left + delta.X;
        end;
      dhLeft:
        begin
          left := left + delta.X;
        end;
      dhTopLeft:
        begin
          top := top + delta.y;
          left := left + delta.X;
        end;
    end;
end;


//------------------------------------------------------------------------------
procedure TPanelManager.CheckPaymentVersionSupported(PaymentMethdVersion : String);
var MethodIntroduced : TDatabaseVersion;
begin
  MethodIntroduced := TDatabaseVersion.Create;
  MethodIntroduced.VersionText := PaymentMethdVersion;
  if FFlagFunctionVersion then
  begin
      Log('checking Button Payment Method');
      Log('min Site Version supported is ' + FMinSiteDBVersionUsingPanel.VersionText);
      Log('Function Introduced  ' + MethodIntroduced.VersionText);

      {$IFNDEF TILLBUTTON_COMP}
      if MethodIntroduced.IsHigherThan(FMinSiteDBVersionUsingPanel) and
         FFlagFunctionVersion then
        FFlagFunctionVersion := ShowVersionWarning(OwnerForm);
      {$endif}
  end;
  MethodIntroduced.Free;
end;

//------------------------------------------------------------------------------
procedure TPanelManager.CheckFunctionVersionSupported(ButtonFunctionID : Integer);
begin
  if FFlagFunctionVersion then
  begin
    with ButtonFunctionInfoList[ButtonFunctionID] as TButtonFunctionInfo do
    begin
      Log('checking Button Function ' + FunctionName);
      Log('min Site Version supported is ' + FMinSiteDBVersionUsingPanel.VersionText);
      Log('Function Introduced  ' + VersionIntroduced.VersionText);
      {$IFNDEF TILLBUTTON_COMP}
      if VersionIntroduced.IsHigherThan(FMinSiteDBVersionUsingPanel) and
         FFlagFunctionVersion then
        FFlagFunctionVersion := ShowVersionWarning(OwnerForm);
      {$endif}
    end;
  end;
end;

function TPanelManager.isProductGroupPaymentType(PaymentMethodID : integer) : boolean;
begin
  Result := False;
  with dmADO.qRun do
     begin
        Close;
        SQL.Text := Format('SELECT ID FROM ad_PaymentMethod '+
                           '   WHERE ProductGroupHeaderID IS NOT NULL AND ID = %d ', [PaymentMethodID]);
        Open;

        if RecordCount > 0 then
           Result := True;
     end;
end;

//------------------------------------------------------------------------------
procedure TPanelManager.DoDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  pos: TPoint;
  bt_tmp: TTillButton;
  lb_tmp: TTillLabel;
  sp_tmp: TTillSubPanel;
  oqp_tmp: TTillHeader;
  FunctionID : Integer;
begin
  // todo move code to TTillPanel
  if (source is TTillObject) then
  begin
    // todo: implement with delegated functions
    //pos.x := x - initialoffset.x;
    //pos.y := y - initialoffset.y;
    pos.x := x;
    pos.y := y;
    if SnapToGrid then
    begin
      pos.X := (trunc((pos.x - GridOffsetX) / GridWidth) * GridWidth) + GridOffsetX;
      pos.Y := (trunc((pos.y - GridOffsetY) / GridHeight) * GridHeight) + GridOffsetY;
    end;

    if not CheckBtnMoveValid(pos.x, pos.y, pd.buttonwidth, pd.buttonheight, nil) then
      Raise Exception.create('Button does not fit on panel');

    if source is TTillButton and not(ttillbutton(source).datasource.dataset.active) then exit
    else
    if source is TTillButton and (ttillbutton(source).datasource.dataset.fieldbyname('ButtonTypeChoiceID').asinteger > 0) then
    begin
      // TODO: Assign code
      if EditingCorrectionPanel and (TTillbutton(source).IsDiscount and not IsSingleItemDiscount(TTillButton(Source))) then
        raise Exception.create('Only discounts that are of "single item" type may be added to the correction panel.');
      if EditingCorrectionPanel and not(TTillbutton(source).IsValidForCorrectionPanel or IsSingleItemDiscount(TTillButton(Source))) then
        raise Exception.create('This button type may not be added to the correction panel.');
      if IsRoot and TTillbutton(source).IsClosePanelButton then
        raise Exception.create('You may not add a close button to the root panel.');
      if (EditingCorrectionPanel) and
          FunctionOnPanelAlready(TTillButton(source).datasource.dataset.FieldByName('buttontypechoiceid').asinteger,
          TTillButton(source).datasource.dataset.FieldByName('buttontypechoiceattr01').asstring) then
      begin
        if TTillButton(source).datasource.dataset.FieldByName('buttontypechoiceid').asinteger = SelectCorrectionMethodFunctionID then
            raise Exception.create('This correction method is already on the panel')
        else if TTillButton(source).datasource.dataset.FieldByName('buttontypechoiceid').asinteger = ApplyBillDiscountFunctionID then
            raise Exception.create('This discount method is already on the panel');
      end;
      if TTillbutton(Source).FButtonTypeID = EDITCHOICE_ID then
         if EditChoiceOnPanelAlready then
            raise Exception.create('This correction method is already on the panel');
      if not EditingCorrectionPanel and (TTillbutton(source).IsValidForCorrectionPanel) then
        raise Exception.create('This button type can only be added to the correction panel.');
      if not EditingCorrectionPanel and (TTillbutton(source).IsDiscount and IsSingleItemDiscount(TTillButton(Source))) then
        raise Exception.create('Single item discounts can only be added to the correction panel.');

      //Version compatibility checks  
      FunctionID := ttillbutton(source).datasource.dataset.fieldbyname('ButtonTypeChoiceID').asinteger;
      if (FunctionID = PayFunctionID) and (isProductGroupPaymentType(TTillButton(source).datasource.dataset.FieldByName('buttontypechoiceattr01').AsInteger)) then
         CheckPaymentVersionSupported('3.5.1.29555');
      if (FunctionID = ApplyBillDiscountFunctionID) and (IsSingleItemDiscount(TTillButton(source))) then
         CheckPaymentVersionSupported('3.8.3.0');
      CheckFunctionVersionSupported(FunctionID);

      if (paneltype = ptSitePanel) and FunctionOnPanelAlready(
        ttillbutton(source).datasource.dataset.FieldByName('buttontypechoiceid').asinteger,
        ttillbutton(source).datasource.dataset.FieldByName('buttontypechoiceattr01').asstring
      ) then
        raise Exception.create('This button is already on the panel.');

      bt_tmp := TTillButton.create(self);
      with bt_tmp do
      begin
        //Assign(source as TTillButton);
        // ARGH, TDBCtrlGrid does not really support drag and drop properly, as
        // each DBCtrlgrid panel control is not actually a distinct component
        // Work around this by taking properties from the dataset that feeds the
        // dbctrlgird
        PanelID := self.PanelId;
        // allocate button id up-front, allows timed security to write detail records
        // that reference the button, before the button is actually saved
        AllocateID;
        //See the comment in uEditTimeSecurity for an explanation: search for H E R E   B E  D R A G O N S
        ButtonSecurityId := -2;
        RequestWitness := False;
        LoadFromDataSet(ltGeneric, ttillbutton(source).datasource.dataset);

        Log('Panel "' + PanelName + '" PanelID ' + IntToStr(PanelID) + ' - adding button "' +
        Trim(Trim(bt_tmp.EposName1) + ' ' + Trim(bt_tmp.EposName2) + ' ' + Trim(bt_tmp.EposName3)) +
        '", Type ID ' + IntToStr(ButtonTypeID) + ', Data ' + bt_tmp.ButtonTypeData + ', UserName ' + dmADO.Logon_Name);

        if (bt_Tmp.FButtonTypeID = OpenPanelFunctionID) and (bt_Tmp.ButtonTypeData <> '') then
        begin
          if Assigned(FOpenPanelOK) then
            FOpenPanelOK(bt_Tmp, True);
        end;
        width := pd.buttonwidth;
        height := pd.buttonheight;
        Parent := panelmanager.OwnerForm;
        fontid := 1;
        eposname1 := '';
        eposname2 := '';
        eposname3 := '';
        Left := pos.x;
        Top := pos.y;
        if PanelManager.PanelType = ptSitePanel then
        begin
          buttonid := ttillbutton(source).datasource.dataset.fieldbyname('ButtonID').asinteger;
          eposname1 := ttillbutton(source).datasource.dataset.fieldbyname('eposname1').asstring;
          eposname2 := ttillbutton(source).datasource.dataset.fieldbyname('eposname2').asstring;
          eposname3 := ttillbutton(source).datasource.dataset.fieldbyname('eposname3').asstring;
        end;
      end;
    end
    else
    // labels
    if source is TTillButton and (ttillbutton(source).datasource.dataset.fieldbyname('ButtonTypeChoiceID').asinteger = -1) then
    begin
      if EditingCorrectionPanel then
      begin
        if (FPanelDesignTypeID = 3) then  // Handheld
          raise Exception.Create('Labels cannot be added to a Handheld correct account panel.')
        else if (PanelLabelCount = 2) then
          raise Exception.create('The correct account panel cannot have more than two labels.');
      end;
      lb_tmp := TTillLabel.create(self);
      with lb_tmp do
      begin
        PanelID := self.PanelId;
        Parent := panelmanager.OwnerForm;
        fontid := 1;
        Left := pos.x;
        text := 'Text Label';
        Top := pos.y;
        // have to set "internal" properties because we're not loading
        // from an eposmodel "label" dataset
        Width := pd.buttonwidth;
        Height := pd.buttonheight;
        fgcolourred := 255;
        fgcolourgreen := 255;
        fgcolourblue := 255;
        bgcolourred := 0;
        bgcolourgreen := 0;
        bgcolourblue := 0;
        kip := true;
        kwp := false;
      end;
    end
    else
    // sub panels
    if source is TTillButton and (ttillbutton(source).datasource.dataset.fieldbyname('ButtonTypeChoiceID').asinteger = -2) then
    begin
      sp_tmp := TTillSubPanel.create(self);
      with sp_tmp do
      begin
        ParentPanelID := self.PanelID;
        FName := 'New Site panel';
{$ifndef TILLBUTTON_COMP}
        SubPanelID := uGenerateThemeIDs.GetNewId(scThemePanel);
{$endif}
        Parent := panelmanager.OwnerForm;
        Left := pos.x;
        Top := pos.y;
        // have to set "internal" properties because we're not loading
        // from an eposmodel "label" dataset
        Width := pd.buttonwidth;
        Height := pd.buttonheight;
        kip := true;
        kwp := false;
        isSubPanelOnCorrectionPanel := EditingCorrectionPanel;
      end;
    end
        else
    // Drive Thru Placeholder
    if source is TTillButton and (ttillbutton(source).datasource.dataset.fieldbyname('ButtonTypeChoiceID').asinteger = -3) then
    begin

      if DriveThruPlanExists then
        raise Exception.create('An Order Queue plan already exists on this panel.');
      oqp_tmp := TTillHeader.create(self);
      with oqp_tmp do
      begin
        HeaderType := 'DriveThruPlan';
        FPanelID := self.PanelId;
        Parent := panelmanager.OwnerForm;
        Left := pos.x;
        Top := pos.y;
        Width := pd.buttonwidth;
        Height := pd.buttonheight;
        kip := true;
        kwp := false;
      end;
    end
  end;
end;

procedure TPanelManager.DoDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  pos: TPoint;
begin
  accept := true;
  if (source is TTillObject) then
  begin
    pos.x := x;
    pos.y := y;
    if SnapToGrid then
    begin
      pos.X := (trunc((pos.x - GridOffsetX) / GridWidth) * GridWidth) + GridOffsetX;
      pos.Y := (trunc((pos.y - GridOffsetY) / GridHeight) * GridHeight) + GridOffsetY;
    end;

    if not CheckBtnMoveValid(pos.x, pos.y, pd.buttonwidth, pd.buttonheight, nil) then
      accept := false;
  end;
end;

procedure TPanelManager.DoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
  VK_LEFT:
    move(point(-1, 0));
  VK_RIGHT:
    move(point(1, 0));
  VK_UP:
    move(point(0, 1));
  VK_DOWN:
    move(point(0, -1));
  end;
end;

procedure TPanelManager.SnapPointToGrid(var point: TPoint);
begin
  point.X := (round((point.x - GridOffsetX) / GridWidth) * GridWidth) + GridOffsetX;
  point.Y := (round((point.y - GridOffsetY) / GridHeight) * GridHeight) + GridOffsetY;
end;


destructor TPanelManager.Destroy;
begin
  FreeAndNil(FPictureCache);
  backdropmenu.free;
  backdropcolourlist.free;
  FMinSiteDBVersionUsingPanel.Free;
  inherited destroy;
end;

procedure TPanelManager.HandleDoubleClick;
begin
  CancelDrag;
  if assigned(selectedobject) and (selectedobject is TTillObject) and
    not (TTillObject(selectedobject).fdatalink.active)
    and assigned(ObjectDblClickEvent) then
    ObjectDblClickEvent(TTillObject(selectedobject));
  // prevent further mousedown events
  abort;
end;

procedure TPanelManager.HandleContextClick;
begin
  CancelDrag;
  if assigned(ObjectContextEvent) and
    ((selectedobject is TTillObject) or (selectedobject is TMultiItemSelection)) then
    ObjectContextEvent(TTillObject(selectedobject));
end;

procedure TPanelManager.CancelDrag;
begin
  if sizing then ReleaseCapture;
  Dragging := false;
  sizing := false;
  if DragDestRectDrawn then
  begin
    PaintOutline;
    DragDestRectDrawn := false;
  end;
  Screen.Cursor := crDefault;
end;

function TPanelManager.CheckBtnMoveValid(left, top, width, height: integer;
  obj: TTillObject): boolean;
var
  MoveRect: TRect;
begin
  result := true;
  moverect.Top := top;
  moverect.Left := left;
  moverect.Right := width+left;
  moverect.Bottom := height+top;
  if not rect_fits_on_panel(moverect) then
    result := false;
  if result then
  // check moverect doesn't overlap any other buttons
  with Ownerform do
  begin
    if rect_overlaps_other_objects(moverect, obj) then
    begin
      result := false;
      exit;
    end;
  end;
end;


procedure TPanelManager.LoadObjectPosn(Target: TTillObject;
  dataset: TDataset);
var
  left, top: double;
  width, height: double;
begin
  left := dataset.fieldbyname('left').asfloat;
  top := dataset.fieldbyname('top').asfloat;
  width := dataset.fieldbyname('width').asfloat;
  height := dataset.fieldbyname('height').asfloat;
  // set object left, top, width and height from database

  case paneltype of
    ptFixed: raise exception.create('Attempt to load invalid panel');
    ptTablePlan:
    begin
      // button t l specify button centre in terms of screen width and height
      target.Width := round(width * pd.screenwidth);
      target.Height := round(height * pd.screenheight);
      target.Left := pd.gridoffsetx + round((left * pd.screenwidth) - (target.Width / 2));
      target.Top := pd.gridoffsety + round((top * pd.screenheight) - (target.Height / 2));
    end
    else
    begin
      // button t l in whole button widths, relative to parent's top left corner
      target.Left := self.panelleft + round(pd.buttonwidth * left);
      target.top := self.paneltop + round(pd.buttonheight * top);
      target.Width := round(width * pd.buttonwidth);
      target.Height := round(height * pd.buttonheight);
      target.upd := False;
    end;
  end;
end;

procedure TPanelManager.SaveObjectPosn(Source: TTillObject;
  dataset: TDataset);
var
  left, top: double;
  width, height: double;
begin
  // get left, top, width and height from object and panel details
  case paneltype of
    ptFixed: raise exception.create('Attempt to save invalid panel');
    ptTablePlan:
    begin
      // button t l specify button centre in terms of screen width and height
      left := ((source.left - pd.gridoffsetx) + (source.Width / 2)) / pd.screenwidth;
      top := ((source.top - pd.gridoffsety) + (source.Height / 2)) / pd.screenheight;
      width := source.width / pd.screenwidth;
      height := source.height / pd.screenheight;
    end;

    else
    begin
      // button t l in whole button widths, relative to parent's top left corner
      left := (source.Left - self.panelleft) / pd.buttonwidth;
      top := (source.top - self.paneltop) / pd.buttonheight;
      width := round(source.Width / pd.buttonwidth);
      height := round(source.Height / pd.buttonheight);
    end;
  end;

  if not(dataset.State in [dsEdit, dsInsert]) then
    raise exception.create('Error in save: dataset not in edit mode before saveobjectposn');
  dataset.FieldByName('left').asfloat := left;
  dataset.FieldByName('top').asfloat := top;
  dataset.FieldByName('width').asfloat := width;
  dataset.FieldByName('height').asfloat := height;
end;

//------------------------------------------------------------------------------
procedure TPanelManager.SetMinSiteVersion;
var
  qry : TADOQuery;
  NextVersion  : TDatabaseVersion;
begin
  log('Setting minimum version');
  qry := nil;
  try
    qry := TADOQuery.Create(nil);
    qry.Connection := PMConnection;
    case panelType of
      ptShared :
      begin
        Qry.SQL.Add(' CREATE TABLE #DesignsUsingSharedPanel (PanelDesignID bigint) ');
        Qry.SQL.Add(' Insert #DesignsUsingSharedPanel EXEC Theme_AllDesignsUsingSharedPanel  ');
        Qry.SQL.Add(' @SharedPanelID=:PanelID ');
        Qry.SQL.Add(' ');
        Qry.SQL.Add(' Select Distinct c.DBVersion ');
        Qry.SQL.Add(' From #DesignsUsingSharedPanel a ');
        Qry.SQL.Add(' Join ThemeEposDesign b on b.PanelDesignID = a.PanelDesignID ');
        Qry.SQL.Add(' Join CommsVersions c on c.SiteCode = b.SiteCode ');
        Qry.SQL.Add(' WHERE c.DBVersion IS NOT NULL ');
        Qry.SQL.Add(' ');
        Qry.SQL.Add(' Drop Table #DesignsUsingSharedPanel ');
        qry.Parameters.ParamByName('PanelID').Value := PanelID;
      end;
      ptLocal :
      begin
        Qry.SQL.Add(' Select Distinct c.DBVersion ');
        Qry.SQL.Add(' From ThemeEposDesign b ');
        Qry.SQL.Add(' Join CommsVersions c on c.SiteCode = b.SiteCode ');
        Qry.SQL.Add(' Where b.PanelDesignID = :PanelDesignID');
        Qry.SQL.Add(' And c.DBVersion IS NOT NULL ');
        qry.Parameters.ParamByName('PanelDesignID').Value := PanelDesign;
      end
      else
      begin
        { Set to version of this Head Office PC }
        FMinSiteDBVersionUsingPanel.SetToThisSystemVersion(PMConnection);
        Exit
      end;
    end; {case}
    qry.Open;
    if qry.Bof and qry.EOF then
    begin
      {No Sites use this Panel they can add whatever button the want}
      FMinSiteDBVersionUsingPanel.SetToThisSystemVersion(PMConnection);
      log('No Sites Currently use this panel');
    end
    else
    begin
      if qry.FieldByName('DBVersion').AsString = '' then
        FMinSiteDBVersionUsingPanel.SetToThisSystemVersion(PMConnection)
      else
        FMinSiteDBVersionUsingPanel.VersionText := qry.FieldByName('DBVersion').AsString;

      NextVersion := TDatabaseVersion.Create;
      try
        qry.Next;
        while not qry.Eof do
        begin
          if qry.FieldByName('DBVersion').AsString <> '' then
          begin
            NextVersion.VersionText := qry.FieldByName('DBVersion').AsString;
            if FMinSiteDBVersionUsingPanel.IsHigherThan(NextVersion) then
              FMinSiteDBVersionUsingPanel.VersionText := NextVersion.VersionText;
          end;
          qry.Next;
        end;
      finally
        NextVersion.Free;
      end;
      log('Minimum database version of site using this panel is : '+FMinSiteDBVersionUsingPanel.VersionText);
    end;
  finally
    qry.Free;
  end;
end;

//------------------------------------------------------------------------------
procedure TPanelManager.LoadPanel(theconnection: TADOConnection;
  panel_id: int64; mode: TLoadPanelMode = lpmLocalSharedPanel; tp_sitecode: integer = 0; tp_ScreenInterfaceID: integer = 0);
var
  qry: TADOQuery;
  tmpbt: TTillbutton;
  tmplb: TTillLabel;
  tmphd: TTillHeader;
  tmpsp: TTillSubPanel;
  tmprect, tmprect2: TRect;
  i: integer;
  numbuttons: integer;
  overlap: boolean;
begin
  tmprect := pd.GetScreenRect;
  ownerform.ClientWidth := tmprect.Right;
  ownerform.ClientHeight := tmprect.Bottom + 32;

  overlap := FALSE;
  numbuttons := 0;
  SelectedObject := nil;
  PMConnection := theconnection;
  LoadPanelMode := mode;
  clearpanel;
  PanelID := panel_id;
  self.tp_sitecode := tp_sitecode;
  RecalculateGrid;
  qry := TADOQuery.create(nil);
  qry.connection := theconnection;
  if (mode = lpmTablePlan) or (mode = lpmDriveThru) {isoutlettableplan} then
  begin
    FEditingCorrectionPanel := false;
    PanelType := ptTablePlan;
    PanelLeft := pd.gridoffsetx;
    PanelTop := pd.gridoffsety;
    PanelWidth := pd.screenwidth;
    PanelHeight := pd.screenheight;
  end
  else
  begin
    with qry do try
      // Check to see if the panel has an overrider version for larger panel displays.  Use override panelid if exists.
      SQL.Text := Format('SELECT PanelID FROM ThemeDialogPanelSet_Override WHERE SourcePanelID = %d AND ScreenInterfaceID = %d', [panel_id, tp_ScreenInterfaceID]);
      Open;

      if RecordCount > 0 then
         panel_id := FieldByName('PanelID').AsInteger;

      if mode = lpmSitePanel then
        sql.text := format('select count(*) as cnt from themepaneldesign join ThemePanelSubPanel on CorrectAccount = ParentPanelID where SubPanelID = %d', [panel_id])
      else
        sql.text := format('select count(*) as cnt from themepaneldesign where correctaccount = %d', [panel_id]);
      open;
      FEditingCorrectionPanel := fieldbyname('cnt').asinteger > 0;
      sql.text := 'select P.*, PD.PanelDesignID,PD.themeID, isNULL(PD.CorrectionMethod,-1) CorrectionMethod, '+
                  'Root.PanelID as RootID, PDT.PanelDesignTypeID, '+
                  'PD.OnByDefault, ' + // AK PM303
                  'OD.[Top] as ODTop, '+
                  'OD.[Left] as ODLeft, '+
                  'OD.[Width] as ODWidth, '+
                  'OD.[Height] as ODHeight '+
                  'FROM ThemePanel P '+
                  //** the below joins need to be left joins as PanelDesignID will be null for shared Panels
                  'left join themePanelDesign PD on PD.PanelDesignID = P.PanelDesignID '+
                  'left join ThemePanelDesignType PDT on PDT.PanelDesignTypeID = PD.PanelDesignType and PDT.ScreenInterfaceID = PD.ScreenInterfaceID '+
                  'left Join ThemePanel Root on Root.PanelID = PD.Root '+
                  'left Join ThemePanelHeader OD on OD.PanelID = Root.PAnelID and OD.HeaderType = '+ QuotedStr('OrderDisplay') +
                  ' WHERE P.PanelID = '+inttostr(panel_id);
      open;
      if recordcount <> 1 then raise exception.create('Attempt to load invalid panel id '+inttostr(panel_id));
      PanelType := TPanelType(fieldbyname('PanelType').AsInteger);
      PanelWidth := Round(FieldByName('Width').AsFloat * pd.ButtonWidth);
      PanelHeight := Round(FieldByName('Height').AsFloat * pd.ButtonHeight);

      OrderDisplayBounds := pd.ButtonToPixelCoords(
        Rect(
          FieldByName('ODLeft').AsInteger,
          FieldByName('ODTop').AsInteger,
          FieldByName('ODWidth').AsInteger,
          FieldByName('ODHeight').AsInteger
        ), true);

      FRootPanel := fieldbyname('RootID').value = fieldbyname('PanelID').value;
      FPanelDesignTypeID := FieldByName('PanelDesignTypeID').AsInteger;

      if mode = lpmSitePanel then
        FCorrectionMethod := -1
      else
        FCorrectionMethod := fieldbyname('CorrectionMethod').value;
      // AK PM303
      FOnByDefault := FieldByName('OnByDefault').AsBoolean;

      if TPanelType(fieldbyname('paneltype').asinteger) in [ptSitePanel, ptVariationPanel] then
      begin
        PanelTop := 0;
        PanelLeft := 0;
      end
      else
      begin
        // slight amendment to the code.  LEFT and TOP can be zero.  This gives a negative positional value
        // on the panel design.  If negative set to zero.  This should only affect shared/Sub panels.
        if round((fieldbyname('Left').asfloat * pd.screenwidth) - (panelwidth / 2)) < 0 then
           PanelLeft := 0 + pd.gridoffsetx
        else
           PanelLeft := round((fieldbyname('Left').asfloat * pd.screenwidth) - (panelwidth / 2)) + pd.gridoffsetx;

        if round((fieldbyname('Top').asfloat * pd.screenheight) - (panelheight / 2)) < 0 then
            PanelTop := 0 + pd.gridoffsety
        else
           PanelTop := round((fieldbyname('Top').asfloat * pd.screenheight) - (panelheight / 2)) + pd.gridoffsety;
      end;
      FPanelOutLine.Top := PanelTop;
      FPanelOutLine.Left :=  PanelLeft;
      FPanelOutLine.Width := PanelWidth;
      FPanelOutLine.Height := PanelHeight;

      PanelName := fieldbyname('Name').AsString;
      PanelDescription := fieldbyname('Description').asstring;
      HideOrderDisplay := fieldbyname('HideOrderDisplay').asboolean;
      ModPanel := fieldbyname('Mod').asboolean;
      FPanelOutLine.HideOrderDisplay := HideOrderDisplay;

      EposName1 := fieldbyname('EposName1').asstring;
      EposName2 := fieldbyname('EposName2').asstring;
      EposName3 := fieldbyname('EposName3').asstring;
      close;

      Log('Loading panel "' + PanelName + '", PanelID ' + IntToStr(PanelID) +
          ', UserName ' + dmADO.Logon_Name);

    finally
    end;
  end;
  with qry do try
    if mode = lpmTablePlan then
    begin
      SQL.Text :=
        'UPDATE ThemeOutletTablePlanButton SET Backdrop = t.Backdrop FROM ThemeOutletTablePlanButton b ' +
        'JOIN ThemeOutletTable t ON b.SiteCode = t.SiteCode AND b.ButtonTypeChoiceAttr01 = t.TableNumber AND b.Backdrop <> t.Backdrop ' +
        'WHERE b.Sitecode = ' + IntToStr(tp_sitecode) + ' AND b.OutletTablePlanID = ' + IntToStr(panel_id);
      ExecSQL;
      sql.text := 'select outlettableplanid as panelid, * from themeoutlettableplanbutton where outlettableplanid = '+inttostr(panel_id)+' and sitecode = '+inttostr(tp_sitecode);
    end
    else
    if mode = lpmDriveThru then
      sql.text :=  'select OutletDriveThruid as panelid, * from ThemeOutletDriveThruButton where OutletDriveThruid = '+inttostr(panel_id)+' and sitecode = '+inttostr(tp_sitecode)
    else
    if mode = lpmSitePanel then
    begin
      sql.text := 'select siteeditappearance from themepanelsubpanel where subpanelid = '+inttostr(panel_id);
      open;
      SitePanelAllowAppearanceEdits := fieldbyname('siteeditappearance').asboolean;
      close;
      if SitePanelAllowAppearanceEdits then
      begin
        sql.text := 'select a.subpanelid as panelid, a.buttonid, a.[left], a.[top], a.width, a.height, '+#13+
          ' isnull(a.overridebackdrop, b.backdrop) as backdrop, '+#13+
          ' isnull(a.overridefont, b.font) as font, '+#13+
          ' isnull(a.overridebuttonsecurityid, b.buttonsecurityid) as buttonsecurity, '+#13+
          ' b.eposname1,  '+#13+
          ' b.eposname2, '+#13+
          ' b.eposname3,  '+#13+
          ' isnull(a.overridefontcolourr, b.fontcolourr) as fontcolourr, '+#13+
          ' isnull(a.overridefontcolourg, b.fontcolourg) as fontcolourg, '+#13+
          ' isnull(a.overridefontcolourb, b.fontcolourb) as fontcolourb, '+#13+
          'b.buttontypechoiceid, '+#13+
          'b.buttontypechoiceattr01, '+#13+
          'b.buttontypechoiceattr02 '+#13+
          'from themepanelsubpanelbuttons a '+#13+
          'join themepanelbutton b on a.buttonid = b.buttonid '+#13+
          'where a.subpanelid = '+inttostr(panel_id)+' and a.sitecode = '+inttostr(tp_sitecode);
      end
      else
      begin
        sql.text := 'select a.subpanelid as panelid, a.buttonid, a.[left], a.[top], a.width, a.height, '+#13+
          ' b.backdrop, '+#13+
          ' b.font, '+#13+
          ' b.buttonsecurityid, '+#13+
          ' b.eposname1,  '+#13+
          ' b.eposname2, '+#13+
          ' b.eposname3,  '+#13+
          ' b.fontcolourr, '+#13+
          ' b.fontcolourg, '+#13+
          ' b.fontcolourb, '+#13+
          'b.buttontypechoiceid, '+#13+
          'b.buttontypechoiceattr01, '+#13+
          'b.buttontypechoiceattr02 '+#13+
          'from themepanelsubpanelbuttons a '+#13+
          'join themepanelbutton b on a.buttonid = b.buttonid '+#13+
          'where a.subpanelid = '+inttostr(panel_id)+' and a.sitecode = '+inttostr(tp_sitecode);
      end;
    end
    else
    if mode in [lpmLocalSharedPanel, lpmVariationPanel] then
      sql.text := 'select * from themepanelbutton where panelid = '+inttostr(panel_id);
    open;

    while not (EOF) do
    begin
      tmpbt := TTillButton.create(self);
      tmpbt.parent := Ownerform;
      tmpbt.LoadFromDataSet(ltSpecific, qry);
      next;
    end;
    close;
    if mode <> lpmSitePanel then
    // site panels cannot contain labels
    begin
      if mode = lpmTablePlan then
        sql.text := 'select outlettableplanid as panelid, * from themeoutlettableplanlabel where outlettableplanid = '+inttostr(panel_id)+' and sitecode = '+inttostr(tp_sitecode)
      else
      if mode = lpmDriveThru then
        sql.Text := 'SELECT OutletDriveThruid AS PanelID, * FROM ThemeOutletDriveThruLabel WHERE OutletDriveThruid = '+inttostr(panel_id)+' and sitecode = '+inttostr(tp_sitecode)
      else
        sql.text := 'select * from themepanellabel where panelid = '+inttostr(panel_id);
      open;
      while not (EOF) do
      begin
        tmplb := TTillLabel.create(self);
        tmplb.parent := Ownerform;
        tmplb.LoadFromDataSet(ltSpecific, qry);
        next;
      end;
      close;
    end;
    if mode in [lpmLocalSharedPanel, lpmVariationPanel] then
    // site panels and shared panels cannot contain headers
    begin
      sql.text := 'select * from themepanelheader where panelid = '+inttostr(panel_id);
      open;
      while not (EOF) do
      begin
        tmphd := TTillHeader.create(self);
        tmphd.parent := Ownerform;
        tmphd.LoadFromDataSet(ltSpecific, qry);
        next;
      end;
      close;
    end;
    if mode in [lpmLocalSharedPanel, lpmVariationPanel] then
    begin
      sql.text := 'select parentpanelid as panelid, * from themepanelsubpanel where parentpanelid = '+inttostr(panel_id);
      open;
      while not (EOF) do
      begin
        tmpsp := TTillSubPanel.create(self);
        tmpsp.parent := Ownerform;
        tmpsp.LoadFromDataSet(ltSpecific, qry);
        next;
      end;
      close;
    end;

    // add help and 'open panel' areas.. in site equivalent to 640x480 overlaid on 800x600
    if mode = lpmTablePlan then
    begin
      if mode = lpmTablePlan then
        begin
          qry.sql.text := format('declare @sitecode integer '+#13+
            'declare @outlettableplanid integer '+#13+
            'declare @numbuttons integer '+#13+
            'set @sitecode = %d '+#13+
            'set @outlettableplanid = %d '+#13+
            'set @numbuttons = 1 '+#13+
            'declare @themeid integer '+#13+
            'declare @themetableplanid integer '+#13+
            'select @themeid = themeid from themesites where sitecode = @sitecode '+#13+
            'select @themetableplanid = tableplanid from themeoutlettableplan where sitecode = @sitecode '+#13+
            'select @numbuttons = @numbuttons + 1  '+#13+
            'from themetableplan  '+#13+
            'where showsplittable = 1 and tableplanid = @themetableplanid '+#13+
            'select @numbuttons = @numbuttons + 1 from themetableplan '+#13+
            'where groupid = (select groupid from themetableplan where tableplanid = @themetableplanid) '+#13+
            'and not tableplanid = @themetableplanid '+#13+
            'select @numbuttons as NumButtons', [tp_sitecode, panel_id]);
          qry.open;
          numbuttons := qry.fieldbyname('numbuttons').asinteger;
          qry.close;
        end;

      tmphd := TTillHeader.create(self);

      // PW: Expand the upper reserved area if handheld paneldesigns
      // are present in the current theme (this means new designs created
      // will be compatible with handhelds, even if they are not in use at
      // site from day 1).
      // Check to see if new "expanded" reserved area for handheld
      // support will fit, i.e. check overlap with existing buttons in plan
      overlap := false;
      tmprect.Left := 0;
      tmprect.Top := 0;
      tmprect.right := 130;
      tmprect.bottom := 60;

      for i := pred(self.componentcount) downto 0  do
      begin
        if (self.components[i] is TTillButton) then
        with TTillbutton(self.components[i]) do
        begin
          tmprect2.Left := left;
          tmprect2.Top := Top;
          tmprect2.Right := Left + Width;
          tmprect2.Bottom := Top + Height;
          if intersectrect(tmprect2, tmprect, tmprect2) then
          begin
            overlap := true;
            break;
          end;
        end;
      end;
      if not overlap then
      begin
        qry.sql.text :=
            'select count(*) as result '+
            'from themepaneldesign '+
            'where paneldesigntype in '+
            '  (select paneldesigntypeid from themepaneldesigntype where screenwidth < 320) '+
            'and themeid = '+
            '  (select top 1 themeid from themesites)';
        qry.open;
        if qry.FieldByName('result').asinteger > 0 then
          tmphd.width := 130
        else
          tmphd.Width := 80;
        qry.close;
      end
      else
        tmphd.Width := 80;
      tmphd.name := 'TopReservedArea';
      tmphd.parent := Ownerform;
      tmphd.Left := 0;
      tmphd.Top := 0;
      tmphd.Height := 60;
      tmphd.HeaderType := 'Reserved';
      
      tmphd := TTillHeader.create(self);

      // add bottom "reserved" bar
      tmphd.name := 'BottomReservedArea';
      tmphd.parent := Ownerform;
      tmphd.Left := 800-(80 * numbuttons);
      tmphd.Top := 600-(60);
      tmphd.Width := 80 * numbuttons;
      tmphd.Height := 60;
      tmphd.HeaderType := 'Reserved';
      // check for buttons overlapping
      tmprect.Left := tmphd.left;
      tmprect.Top := tmphd.Top;
      tmprect.Right := tmphd.Left + tmphd.Width;
      tmprect.Bottom := tmphd.Top + tmphd.Height;
      overlap := false;
      for i := pred(self.componentcount) downto 0  do
      begin
        if (self.components[i] is TTillButton) then
        with TTillbutton(self.components[i]) do
        begin
          tmprect2.Left := left;
          tmprect2.Top := Top;
          tmprect2.Right := Left + Width;
          tmprect2.Bottom := Top + Height;
          if intersectrect(tmprect2, tmprect, tmprect2) then
          begin
            overlap := true;
            break;
          end;
        end;
      end;
      if overlap and (messagedlg('Some buttons overlap reserved areas!'+#13+
        'Select YES to have them removed right now.', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
      for i := pred(self.componentcount) downto 0  do
      begin
        if (self.components[i] is TTillButton) then
        with TTillbutton(self.components[i]) do
        begin
          tmprect2.Left := left;
          tmprect2.Top := Top;
          tmprect2.Right := Left + Width;
          tmprect2.Bottom := Top + Height;
          if intersectrect(tmprect2, tmprect, tmprect2) then
          begin
            delete;
          end;
        end;
      end
      else
        overlap := false;
    end;

    // For a shared panel, check if there are variations defined, which disallows
    // editing of panel dimensions. If we are editing a variation, that also
    // disallows panel dimensions.
    if (LoadPanelMode = lpmLocalSharedPanel) and (PanelType = ptShared) then
    begin
      SQL.Text := Format('select count(*) from ThemePanelVariation where PanelID = %d', [Panel_ID]);
      Open;
      SharedPanelHasVariations := Fields[0].AsInteger > 0;
      Close;
    end
    else
      SharedPanelHasVariations := false;

  finally
    qry.free;
  end;

  PanelModified := false;
  if not overlap then
  begin
    DetailsModified := false;
  end;
  // for a site panel, scan for buttons that are outside the panel, and delete them
  if loadpanelmode = lpmSitePanel then
  begin
    for i := pred(componentcount) downto 0  do
    begin
      if (components[i] is TTillButton) then
      with TTillbutton(components[i]) do
      begin
        if ((left > (fpaneloutline.Left + fpaneloutline.Width)) or
          (left+width > (fpaneloutline.Left + fpaneloutline.Width))) or
          ((top > (fpaneloutline.Top + fpaneloutline.Height)) or
          (top+height > (fpaneloutline.Top + fpaneloutline.Height))) then
        begin
          Delete;
        end;
      end;
    end;
  end;
  SetMinSiteVersion;
  for i := 0 to Pred(BackdropMenu.Items.Count) do
  begin
    with TMenuItem(BackdropMenu.Items[i]) do
    begin
      case tag of
        ord(pmFunctionSecurity):  Enabled := (PanelType <> ptSitePanel) or SitePanelAllowSecurityEdits;
        ord(pmFunctionLargeFont): Enabled := (PanelType <> ptSitePanel) or SitePanelAllowAppearanceEdits;
        ord(pmFunctionSmallFont): Enabled := (PanelType <> ptSitePanel) or SitePanelAllowAppearanceEdits;
        ord(pmFunctionSort): Enabled := true;
      else
        Enabled := (PanelType <> ptSitePanel) or SitePanelAllowAppearanceEdits
      end;
    end;
  end;
end;

procedure TPanelManager.SavePanel(theconnection: TADOConnection);
var
  qry: TADOQuery;
  i: integer;
begin
  if (LoadPanelMode in [lpmLocalSharedPanel, lpmVariationPanel]) and PanelDesignModified then
  begin
    qry := nil;
    try
      qry := TADOQuery.create(nil);
      qry.connection := theconnection;
      qry.sql.text := format('Update ThemePanelDesign set CorrectionMethod = %d Where PanelDesignID = %d',[FcorrectionMethod, PanelDesign]);
      qry.ExecSQL;
// AK PM303
      qry.SQL.Clear;
      if EditChoiceOnPanelAlready then
        qry.sql.text := format('Update ThemePanelDesign set OnByDefault = %d Where PanelDesignID = %d',[integer(FOnByDefault), PanelDesign])
      else
      begin
        qry.sql.text := format('Update ThemePanelDesign set OnByDefault = %d Where PanelDesignID = %d',[0, PanelDesign]);
        OnByDefault := FALSE;
      end;
      qry.ExecSQL;
    finally
      qry.Free;
    end;
  end;

  if PanelModified then
  begin
    if loadpanelmode in [lpmLocalSharedPanel, lpmVariationPanel] then
    // table plans, site sub panels don't need any panel details to be saved
    begin
      qry := TADOQuery.create(nil);
      try
        qry.connection := theconnection;
        qry.sql.text := 'select * from themepanel where panelid = '+inttostr(panelid);
        qry.open;
        if qry.recordcount <> 1 then
        begin
          qry.SQL.Text := 'insert themepanel (panelid) select '+inttostr(panelid);
          qry.ExecSQL;
          qry.sql.text := 'select * from themepanel where panelid = '+inttostr(panelid);
          qry.open;
        end;
        qry.edit;
        qry.fieldbyname('PanelType').asinteger := ord(PanelType);
        qry.fieldbyname('Width').asinteger := round(PanelWidth / pd.buttonwidth);
        qry.fieldbyname('Height').asinteger := round(PanelHeight / pd.buttonheight);
        qry.fieldbyname('Left').asfloat := (PanelLeft - pd.gridoffsetx + (panelwidth / 2)) / (pd.screenwidth-(pd.GridOffsetX*2));
        qry.fieldbyname('Top').asfloat := (PanelTop - pd.gridoffsety + (panelheight / 2)) / (pd.screenheight-(pd.GridOffsetY*2));
        qry.fieldbyname('Name').asstring := panelname;
        qry.fieldbyname('Description').asstring := paneldescription;
        qry.fieldbyname('HideOrderDisplay').asboolean := HideOrderDisplay;
        qry.fieldbyname('Mod').asboolean := ModPanel;
        qry.fieldbyname('EposName1').asstring := EposName1;
        qry.fieldbyname('EposName2').asstring := EposName2;
        qry.fieldbyname('EposName3').asstring := EposName3;
        qry.post;
        PanelModified := false;
      finally
        qry.free;
      end;
    end;
  end;
  if DetailsModified then
  begin
    qry := TADOQuery.create(nil);
    try
      qry.connection := theconnection;
      if loadpanelmode = lpmTablePlan then
        qry.sql.text := 'select outlettableplanid as panelid, * from themeoutlettableplanbutton where outlettableplanid = '+inttostr(panelid)
      else
      if loadpanelmode = lpmDriveThru then
        qry.sql.text := 'select OutletDriveThruid as panelid, * from themeOutletDriveThrubutton where OutletDriveThruid = '+inttostr(panelid)
      else
      if loadpanelmode in [lpmLocalSharedPanel, lpmVariationPanel] then
        qry.sql.text := 'select * from themepanelbutton where panelid = '+inttostr(panelid)
      else
      if loadpanelmode = lpmSitePanel then
        qry.sql.text := 'select a.sitecode, a.subpanelid as panelid, a.buttonid, a.[left], a.[top], a.width, a.height, '+#13+
          ' a.overridebackdrop as backdrop, '+#13+
          ' a.overridefont as font, '+#13+
          ' a.overridebuttonsecurityid as buttonsecurityid, '+#13+
          ' '''' as eposname1,  '+#13+
          ' '''' as eposname2, '+#13+
          ' '''' as eposname3,  '+#13+
          ' a.overridefontcolourr as fontcolourr, '+#13+
          ' a.overridefontcolourg as fontcolourg, '+#13+
          ' a.overridefontcolourb as fontcolourb, '+#13+
          ' 0 as buttontypechoiceid, '+#13+
          ' '''' as buttontypechoiceattr01, '+#13+
          ' '''' as buttontypechoiceattr02 '+#13+
          'from themepanelsubpanelbuttons a '+#13+
          'where a.subpanelid = '+inttostr(panelid)+' and a.sitecode = '+inttostr(tp_sitecode);
      qry.open;

      if loadpanelmode <> lpmSitePanel then
        for i := pred(componentcount) downto 0  do
        begin
          if (components[i] is TTillButton) and (TTillObject(components[i]).upd) then
            TTillObject(components[i]).SaveToDataSet(qry);
        end
      else
      begin
        // site panels re-use button id of master panel as their key, so we must delete/update first then
        // process new records
        for i := pred(componentcount) downto 0  do
        begin
          if (components[i] is TTillButton) and (TTillObject(components[i]).upd) and TTillObject(components[i]).kwp then
            TTillObject(components[i]).SaveToDataSet(qry);
        end;
        for i := pred(componentcount) downto 0  do
        begin
          if (components[i] is TTillButton) and (TTillObject(components[i]).upd) and not TTillObject(components[i]).kwp then
            TTillObject(components[i]).SaveToDataSet(qry);
        end;
      end;
      if loadpanelmode <> lpmSitePanel then
      begin
        if loadpanelmode = lpmTablePlan then
          qry.sql.text := 'select outlettableplanid as panelid, * from themeoutlettableplanlabel where outlettableplanid = '+inttostr(panelid)
        else
        if loadpanelmode = lpmDriveThru then
          qry.sql.text := 'select OutletDriveThruid as panelid, * from themeOutletDriveThrulabel where OutletDriveThruid = '+inttostr(panelid)
        else
          qry.sql.text := 'select * from themepanellabel where panelid = '+inttostr(panelid);
        qry.open;
        for i := pred(componentcount) downto 0  do
        begin
          if (components[i] is TTillLabel) and (TTillObject(components[i]).upd) then
            TTillObject(components[i]).SaveToDataSet(qry);
        end;
        if loadpanelmode <> lpmTablePlan then
        begin
          qry.sql.text := 'select * from themepanelheader where panelid = '+inttostr(panelid);
          qry.open;
          for i := pred(componentcount) downto 0  do
          begin
            if (components[i] is TTillHeader) and (TTillObject(components[i]).upd) and not TTillObject(components[i]).visible then
              TTillObject(components[i]).SaveToDataSet(qry);
          end;
          for i := pred(componentcount) downto 0  do
          begin
            if (components[i] is TTillHeader) and (TTillObject(components[i]).upd) and TTillObject(components[i]).visible then
              TTillObject(components[i]).SaveToDataSet(qry);
          end;
        end;
        if loadpanelmode <> lpmTablePlan then
        begin
          qry.sql.text := 'select parentpanelid as panelid, * from themepanelsubpanel where parentpanelid = '+inttostr(panelid);
          qry.open;
          for i := pred(componentcount) downto 0  do
          begin
            if (components[i] is TTillSubPanel) and (TTillObject(components[i]).upd) then
              TTillObject(components[i]).SaveToDataSet(qry);
          end;
        end;
      end;
      qry.close;

      DetailsModified := false;
    finally
      qry.free;
    end;
  end;

  Log('All panel "' + PanelName + '" Panel ID ' + IntToStr(PanelID) + ' changes have been saved, UserName ' + dmADO.Logon_Name);
end;

procedure TPanelManager.ClearPanel;
var
  i: integer;
begin
  SelectedObject := nil;
  for i := pred(componentcount) downto 0  do
  begin
    if components[i] is TTillObject then
      TTillObject(components[i]).free;
  end;
{  if assigned(ownerform) then
    ownerform.invalidate; }
end;

procedure TPanelManager.SetEposName1(const Value: string);
begin
  if Value = FEposName1 then exit;
  FEposName1 := Value;
  PanelModified := true;
end;

procedure TPanelManager.SetEposName2(const Value: string);
begin
  if Value = FEposName2 then exit;
  FEposName2 := Value;
  PanelModified := true;
end;

procedure TPanelManager.SetEposName3(const Value: string);
begin
  if Value = FEposName3 then exit;
  FEposName3 := Value;
  PanelModified := true;
end;

procedure TPanelManager.SetHideOrderDisplay(const Value: boolean);
begin
  if Value = FHideOrderDisplay then exit;
  FHideOrderDisplay := Value;
  PanelModified := true;
end;

procedure TPanelManager.SetPanelName(const Value: string);
begin
  if Value = FPanelName then exit;
  FPanelName := Value;
  PanelModified := true;
end;

procedure TPanelManager.SetPanelDescription(const Value: string);
begin
  if Value = FPanelDescription then exit;
  FPanelDescription := Value;
  PanelModified := true;
end;

procedure TPanelManager.SetPanelLeft(const Value: integer);
var
  delta: integer;
begin
  if Value = FPanelLeft then exit;
  delta := value - FPanelLeft;
  FPanelLeft := Value;
  FPanelOutLine.Left := Value;
  PanelModified := true;
  RealignObjects(delta, 0);
end;

procedure TPanelManager.SetPanelTop(const Value: integer);
var
  delta: integer;
begin
  if Value = FPanelTop then exit;
  delta := value - FPanelTop;
  FPanelTop := Value;
  FPanelOutLine.Top := Value;
  PanelModified := true;
  RealignObjects(0, delta);
end;

procedure TPanelManager.SetPanelWidth(const Value: integer);
var
  i: integer;
begin
  if Value = FPanelWidth then exit;
  CheckSetWH(value, FPanelHeight);
  FPanelWidth := Value;

  if self.ForcedSelectionPanel then // set top 2 labels width to panel width
  begin
    for i := pred(componentcount) downto 0  do
    begin
      if (components[i] is TTillLabel) then
        if TTillLabel(components[i]).IsForcedItemHeader then
        begin
          TTillLabel(components[i]).Width := Value;
        end;
    end;
  end;

  FPanelOutLine.Width := Value-1;
  AlignDragHandles;
  PanelModified := true;
end;

procedure TPanelManager.SetPanelHeight(const Value: integer);
begin
  if Value = FPanelHeight then exit;
  CheckSetWH(FPanelWidth, value);
  FPanelHeight := Value;
  FPanelOutLine.Height := Value-1;
  AlignDragHandles;
  PanelModified := true;
end;

procedure TPanelManager.CheckSetWH(NewWidth, NewHeight: integer);
var
  i, rightEdge: integer;
begin
  for i := pred(componentcount) downto 0  do
  begin
    if (components[i] is TTillObject) and (TTillObject(components[i]).kip) then
    begin
      if (TTillObject(components[i]).Top + TTillObject(components[i]).height) > PanelTop+NewHeight then
        raise Exception.create('The panel cannot be resized as some buttons would not fit vertically.');

      rightEdge := TTillObject(components[i]).Left + TTillObject(components[i]).width;

      if (components[i] is TTillLabel) then
        if TTillLabel(components[i]).IsForcedItemHeader then
          rightEdge := self.pd.buttonwidth * 6;

      if rightEdge > PanelLeft+NewWidth then
      begin
        raise Exception.create('The panel cannot be resized as some buttons would not fit horizontally.');
      end;
    end;
  end;
  ownerform.invalidate;
end;

function TPanelManager.SilentCheckSetWH(NewWidth, NewHeight: integer) : Boolean;
var
  i, rightEdge: integer;
begin
  Result := True;
  for i := pred(componentcount) downto 0  do
  begin
    if (components[i] is TTillObject) and (TTillObject(components[i]).kip) then
    begin
      if (TTillObject(components[i]).Top + TTillObject(components[i]).height) > PanelTop+NewHeight then
      begin
        Result := False;
        Exit;
      end;

      rightEdge := TTillObject(components[i]).Left + TTillObject(components[i]).width;

      if (components[i] is TTillLabel) then
        if TTillLabel(components[i]).IsForcedItemHeader then
          rightEdge := self.pd.buttonwidth * 6;

      if rightEdge > PanelLeft+NewWidth then
      begin
        Result := False;
        Exit;
      end;
    end;
  end;
end;


procedure TPanelManager.RealignObjects(DeltaX, DeltaY: integer);
var
  i: integer;
begin
  for i := pred(componentcount) downto 0  do
  begin
    if components[i] is TTillObject then
    begin
      TTillObject(components[i]).Left := TTillObject(components[i]).Left + DeltaX;
      TTillObject(components[i]).Top := TTillObject(components[i]).Top + DeltaY;
    end;
  end;
  ownerform.invalidate;
  if assigned(selectedobject) then
    AlignDragHandles(selectedobject);
  RecalculateGrid;
end;

procedure TPanelManager.RecalculateGrid;
begin
  if paneltype = pttableplan then
  begin
    snaptogrid := true;
    self.gridwidth := 8;
    self.gridheight := 8;
    self.gridoffsetx := 0;
    self.gridoffsety := 0;
  end
  else
  begin
    snaptogrid := true;
    self.GridWidth := pd.buttonwidth;
    self.GridHeight := pd.buttonheight;
    self.GridOffsetX := pd.gridoffsetx + (panelleft - pd.gridoffsetx) mod pd.buttonwidth;
    self.GridOffsetY := pd.gridoffsety + (paneltop - pd.gridoffsety) mod pd.buttonheight;
  end;
end;

procedure TPanelManager.New;
begin
  ClearPanel;
  //PanelID := getnewpanelseed;
  PanelType := ptLocal;
  PanelName := 'New panel';
  PanelDescription := 'New description';
end;

procedure TPanelManager.AddLabel(x, y: smallint);
var
  ObjRect: TRect;
  tmplb: TTillLabel;
  tmppoint: TPoint;
begin
  tmppoint.x := x - (48 div 2);
  tmppoint.Y := y - (48 div 2);
  snappointtogrid(tmppoint);

  objrect.left := tmppoint.x;
  objrect.Right := tmppoint.x + 48;
  objrect.Bottom := tmppoint.Y + 48;
  objrect.Top := tmppoint.y;

  if rect_overlaps_other_objects(objrect, nil) then
    raise exception.create('Cannot create a new label here - would overlap another object');
  if not rect_fits_on_panel(objrect) then
    raise exception.create('Cannot create a new label here - would go outside the panel boundary');
  tmplb := TTillLabel.create(self);
  with tmplb do
  begin
    parent := ownerform;
    width := 48;
    height := 48;
    left := tmppoint.X;
    top := tmppoint.Y;
    text := 'New Label';
    FGColourRed := 255;
    FGColourBlue := 255;
    FGColourGreen := 255;
  end;
end;

procedure TPanelManager.AddTable(x, y: smallint; tablenumber: integer; draw_type: TTillButtonDrawType);
var
  ObjRect: TRect;
  tmpbt: TTillButton;
  i: integer;
  tmppoint: TPoint;
begin
  tmppoint.x := x - (48 div 2);
  tmppoint.Y := y - (48 div 2);
  snappointtogrid(tmppoint);

  objrect.left := tmppoint.x;
  objrect.Right := tmppoint.x + 48;
  objrect.Bottom := tmppoint.Y + 48;
  objrect.Top := tmppoint.y;

  if rect_overlaps_other_objects(objrect, nil) then
    raise exception.create('Cannot create a new table here - would overlap another object');
  if not rect_fits_on_panel(objrect) then
    raise exception.create('Cannot create a new table here - would go outside the panel boundary');
  tmpbt := TTillbutton.create(self);
  with tmpbt do
  begin
    parent := ownerform;
    for i := low(drawtypelookup) to high(drawtypelookup) do
      if drawtypelookup[i] = draw_type then
        backdropid := i;
    width := 48;
    height := 48;
    left := tmppoint.X;
    top := tmppoint.Y;
    ButtonTypeID := selecttablefunctionid;
    ButtonTypeData := inttostr(tablenumber);
    fontid := 0;
    ButtonSecurityId := -2;
    RequestWitness := False;
  end;
end;

procedure TPanelManager.AddSpace(x, y: smallint; spacenumber, seqnum, DriveThruType: integer; draw_type: TTillButtonDrawType);
var
  ObjRect: TRect;
  tmpbt: TTillButton;
  i: integer;
  tmppoint: TPoint;
begin
  tmppoint.x := x - (48 div 2);
  tmppoint.Y := y - (48 div 2);
  snappointtogrid(tmppoint);

  objrect.left := tmppoint.x;
  objrect.Right := tmppoint.x + 48;
  objrect.Bottom := tmppoint.Y + 48;
  objrect.Top := tmppoint.y;

  if rect_overlaps_other_objects(objrect, nil) then
    raise exception.create('Cannot create a new drive thru space here - would overlap another object');
  if not rect_fits_on_panel(objrect) then
    raise exception.create('Cannot create a new drive thru space here - would go outside the panel boundary');
  tmpbt := TTillbutton.create(self);
  with tmpbt do
  begin
    parent := ownerform;
    for i := low(drawtypelookup) to high(drawtypelookup) do
      if drawtypelookup[i] = draw_type then
        backdropid := i;
    width := 48;
    height := 48;
    left := tmppoint.X;
    top := tmppoint.Y;
    ButtonID := spacenumber;
    TerminalID := 0;
    //See the comment in uEditTimeSecurity for an explanation: search for H E R E   B E  D R A G O N S
    ButtonSecurityId := -2;
    RequestWitness := False;

    case DriveThruType of
    ORDER_POINT : begin
                    ButtonTypeID := CreateDrivethruFunctionID;
                    EposName1 := 'Order';
                    EposName2 := 'Point';
                    ButtonTypeData := '0';
                    SpaceType := ORDER_POINT;
                    fontid := 1;
                    ButtonTypeData2 := IntToStr(ORDER_POINT);
                  end;
    PARKING_BAY : begin
                    ButtonTypeID := SelectDrivethruFunctionID;
                    EposName1 := 'Parking';
                    EposName2 := 'Bay';
                    SequenceNumber := seqnum;
                    ButtonTypeData := '0';
                    SpaceType := PARKING_BAY;
                    fontid := 1;
                    ButtonTypeData2 := IntToStr(PARKING_BAY);
                  end;
    EMPTY_SPACE : begin
                    ButtonTypeID := SelectDrivethruFunctionID;
                    EposName1 := IntToStr(seqnum);
                    SequenceNumber := seqnum;
                    ButtonTypeData := '0';
                    SpaceType := 0;
                    fontid := 0;
                    ButtonTypeData2 := IntToStr(EMPTY_SPACE);
                  end;
    end;   
  end;
end;


function TPanelManager.rect_overlaps_other_objects(rect: TRect;
  ignoreobject: TTillObject):boolean;
var
  i: integer;
  checkrect, tmprect: TRect;
begin
  result := false;
  for i := 0 to pred(componentcount) do
  begin
    {PW check deleted buttons don't get in the way}
    if assigned(components[i]) and (components[i] <> ignoreobject) and (components[i] is TTillObject)
      and TTillObject(components[i]).kip then
    with TTillObject(components[i]) do
    begin
      tmprect.left := left;
      tmprect.Top := top;
      tmprect.Right := width+left;
      tmprect.Bottom := height+top;
      if intersectrect(checkrect, rect, tmprect) then
        result := true;
    end;
  end;
end;

function TPanelManager.rect_fits_on_panel(rect: TRect): boolean;
var
  tmprect, checkrect: TRect;
begin
  result := true;
  // check moverect fits on the panel
  tmprect.Left := panelleft;
  tmprect.Top := paneltop;
  tmprect.right := panelleft+panelwidth;
  tmprect.Bottom := paneltop+panelheight;
  if intersectrect(checkrect, rect, tmprect) = false then
    // button does not fit on panel
    result := false
  else
  begin
    // check for object that is partly off the panel
    // works because a partial intersection of two squares must share at least one
    // co-ordinate
    if (rect.top <> checkrect.top) or
      (rect.left <> checkrect.left) or
      (rect.right <> checkrect.right) or
      (rect.bottom <> checkrect.bottom) then
    begin
      result := false;
    end;
  end;
end;


procedure TPanelManager.SetAddIngPanelMode(Value: Boolean);
begin
  //** THis function reads quite funnily it is because things have to be carried out in a particular order!
  FPanelOutline.Visible := not(value);

  FSPOL.Visible := Value;
//  FSPOL.BringToFront;
  if Value then
  begin
    SelectedObject := FSPOL;
    AlignDragHandles(FSPOL);
  end;

  FValidatingSharedPanel := Value;

  if not Value then
    SetSelectedObject(nil);
//** no other object can be selected until this is false
end;

procedure TPanelManager.CancelOpenPanel;
begin
  FValidatingSharedPanel := False;
end;

procedure TPanelManager.AlignDragHandles;
begin
  if SelectedObject <> nil then
    AlignDragHandles(SelectedObject);
end;

procedure TPanelManager.SetCorrectionMethod(const Value: Integer);
begin
  if FCorrectionMethod <> Value then
  begin
    PanelDesignModified := True;
    FCorrectionMethod := Value;
  end;
end;

// AK PM303
procedure TPanelManager.SetOnByDefault(const Value: Boolean);
begin
  if FOnByDefault <> Value then
  begin
    PanelDesignModified := True;
    FOnByDefault := Value;
  end;
end;

procedure TPanelManager.SetModPanel(const Value: boolean);
begin
  if Value = FModPanel then exit;
  FModPanel := Value;
  PanelModified := true;
end;

function TPanelManager.FunctionOnPanelAlready(TypeID: integer; Attr01: string):boolean;
var
  i: integer;
begin
  result := false;
  for i := 0 to pred(componentcount) do
    if (components[i] is TTillButton) then
    with TTillButton(components[i]) do
    begin
      if (kip) and (ButtonTypeID = TypeID) and (ButtonTypeData = Attr01) then
        result := true;
    end;
end;
// AK PM303
function TPanelManager.EditChoiceOnPanelAlready:boolean;
var
  i: integer;
begin
  result := false;

  for i := 0 to pred(componentcount) do
      if (components[i] is TTillButton) then
          with TTillButton(components[i]) do
               if kip and (ButtonTypeID = EDITCHOICE_ID) then
                  result := true;
end;

function TPanelManager.DriveThruPlanExists: boolean;
var
  i: integer;
begin
  result := false;
  for i := 0 to pred(componentcount) do
    if components[i] is TTillHeader then
    with TTillHeader(components[i]) do
      begin
        if (HeaderType = 'DriveThruPlan') and Visible then
           result := true;
      end;
end;

function TPanelManager.PanelLabelCount: Integer;
var
  i: integer;
begin
  result := 0;
  for i := 0  to pred(ComponentCount) do
    if (Components[i] is TTillLabel) then
    begin
      if TTillLabel(Components[i]).Visible then
        Result := Result + 1;
    end;
end;

procedure TPanelManager.HandlePopupClick(sender: TObject);
var
  TempObjects: array of TTillButton;
  i,j, ALength: integer;
  ListAlreadySorted: boolean;
  MenuItemType: TPopupMenuItem;
  BGName: string;

  function SortComparePos(ButtonA, ButtonB: TTillButton): boolean;
  begin
    result := ((ButtonA.Top > ButtonB.Top) or
      ((ButtonA.Top = ButtonB.Top) and (ButtonA.Left > ButtonB.Left)));
  end;

  procedure SortExchangePos(var ButtonA, ButtonB: TTillButton);
  var
    tmp: TTillButton;
  begin
    tmp := ButtonB;
    ButtonB := ButtonA;
    ButtonA := tmp;
  end;

  function SortCompareText(ButtonA, ButtonB: TTillButton): boolean;
  begin
    ButtonA.CheckText;
    ButtonB.CheckText;
    result := useful.CompareAlphaNumeric(ButtonA.Text, ButtonB.Text) = -1;
  end;

  procedure SortExchangeText(ButtonA, ButtonB: TTillButton);
  var
    tmp: TTillButton;
  begin
    tmp := TTillButton.create(nil);
    tmp.Assign(ButtonA);
    ButtonA.Assign(ButtonB);
    ButtonB.Assign(tmp);
    tmp.free;
  end;
begin
  if TMenuItem(Sender).Enabled then
  begin
    if (SelectedObject is TMultiItemSelection) then
    begin
      ALength := Length(MultiSelect.SelectedObjects);
      SetLength(TempObjects, ALength);
      for i := 0 to Pred(ALength) do
        TempObjects[i] := TTillButton(MultiSelect.SelectedObjects[i]);
    end
    else if SelectedObject is TTillButton then
    begin
      ALength := 1;
      SetLength(TempObjects, ALength);
      TempObjects[0] := TTillButton(SelectedObject);
    end
    else
      exit;

    MenuItemType := TPopupMenuItem(TMenuItem(sender).tag);

    if MenuItemType = pmFunctionSecurity then
    begin
      // Edit security
      {$ifndef TILLBUTTON_COMP}
      with TEditTimedJobSecurity.create(nil) do try
        ButtonSecurityId := TempObjects[0].ButtonSecurityId;
        for i := 0 to pred(ALength) do
           FButtonList.Add(TempObjects[i]);
        SetCommonWitnessRequiredState;
        if showmodal = mrOk then
        begin
          for i := 0 to pred(ALength) do
          begin
            TempObjects[i].ButtonSecurityId := ButtonSecurityId;
            TempObjects[i].RequestWitness := BooleanFromRequestWitnessState(FRequestWitness, TempObjects[i].RequestWitness);
            TempObjects[i].Invalidate;
          end
        end;
      finally
        free;
      end;
      {$endif}
    end
    else if MenuItemType = pmFunctionSort then
    begin
      // sort positions of the selection
      for i := Pred(ALength) downto 1 do
        for j := 0 to i-1 do
        begin
          if SortComparePos(TempObjects[j], TempObjects[j+1]) then
            SortExchangePos(TempObjects[j], TempObjects[j+1]);
        end;
      // then exchange parameters (all except key fields/existence and positions)
      ListAlreadySorted := true;
      for i := Pred(ALength) downto 1 do
        for j := 0 to i-1 do
        begin
          if SortCompareText(TempObjects[j], TempObjects[j+1]) then
          begin
            SortExchangeText(TempObjects[j], TempObjects[j+1]);
            ListAlreadySorted := false;
          end;
        end;
      if ListAlreadySorted then
      begin
        for i := 0 to pred(ALength) div 2 do
          SortExchangeText(TempObjects[i], TempObjects[pred(ALength)-i]);
      end;

      for i := 0 to pred(ALength) do
        TempObjects[i].Invalidate;
    end
    else
    begin
      for i := 0 to Pred(ALength) do
      begin
        case MenuItemType of
          pmFunctionLargeFont:
            TempObjects[i].FontID := 0;
          pmFunctionSmallFont:
            TempObjects[i].FontID := 1;
          pmFontWhite:
          begin
            TempObjects[i].FGColourRed := 255;
            TempObjects[i].FGColourGreen := 255;
            TempObjects[i].FGColourBlue := 255;
          end;
          pmFontBlack:
          begin
            TempObjects[i].FGColourRed := 0;
            TempObjects[i].FGColourGreen := 0;
            TempObjects[i].FGColourBlue := 0;
          end;
          pmfontGrey:
          begin
            TempObjects[i].FGColourRed := 128;
            TempObjects[i].FGColourGreen := 128;
            TempObjects[i].FGColourBlue := 128;
          end;
          else
          begin
            BGName := Copy(GetEnumName(TypeInfo(TPopupMenuItem), ord(MenuItemType)), 11, 20);
            TempObjects[i].BackdropID := EposBGNameToBackdropIndex(BGName);
          end
        end;
        TempObjects[i].Invalidate;
      end
    end;
  end;
end;

procedure TPanelManager.HandlePopupDraw(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
var
  DrawStyle: cardinal;
begin
  if TMenuItem(Sender).Enabled then
    DrawStyle := ILD_NORMAL
  else
    DrawStyle := ILD_BLEND50;

  ImageList_Draw(BackdropColourList.Handle, TMenuItem(Sender).ImageIndex,
    ACanvas.Handle, ARect.left, ARect.Top, DrawStyle);
end;

procedure TPanelManager.HandlePopupMeasure(Sender: TObject;
  ACanvas: TCanvas; var Width, Height: Integer);
begin
  if TMenuItem(Sender).ImageIndex >= 16 then
    width := 3
  else
    Width := 1;
  Height := 17;
end;


function TPanelManager.InvalidPanelPositionsInSubPanel(data: TDataSet): boolean;
var
  PanelRect: TRect;
begin
  result := false;
  with data do
  begin
    First;
    while not EOF do
    begin
      PanelRect := pd.ButtonToPixelCoords(
        Rect(
          FieldByName('Left').AsInteger,
          FieldByName('Top').AsInteger,
          FieldByName('Width').AsInteger,
          FieldByName('Height').AsInteger
        ), true);

      if not NewPanelPosValid(
        PanelRect.Top, PanelRect.Left, PanelRect.Bottom, PanelRect.Right,
        FieldByName('HideOrderDisplay').AsBoolean) then
      begin
        Result := true;
      end;
      Next;
    end;
  end;
end;

//TODO: On first glance this ought to be a property of the TTillButton class, but
//TTillButton has no DB connectivity (and neither should it) in order to establish
//the discount type.  Ideally we would have a new button action of ApplySingleItemBillDiscount
//to remove the need for the function below and relegate the check back to
//the TTillButton class.
//EB 14/11/'16
function TPanelManager.IsSingleItemDiscount(
  ATillButton: TTillButton): Boolean;
begin
  Result := false;
  if ATillButton.IsDiscount then
  begin
    with TADOQuery.Create(nil) do
    begin
      Connection := PMConnection;
      SQL.Add('select AppliesToOrderLineFamily');
      SQL.Add('from Discount d');
      SQL.Add(Format('where DiscountID = %s',[ATillButton.FButtonTypeData]));
      Open;

      if not EOF then
        Result := FieldByName('AppliesToOrderLineFamily').AsBoolean;
      Free;
    end;
  end;
end;

{ TTillButton }

constructor TTillButton.create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  bitmap:= TBitmap.Create;
  bitmap.PixelFormat := pf24bit;
  FontID := 1;
end;

procedure TTillButton.DataChange;
begin
  inherited;
  if assigned(FDataLink) and assigned(FDataLink.dataset) and FDataLink.DataSet.active then
  begin
    try
      LoadFromDataSet(ltGeneric, FDataLink.DataSet);
    except
    end;
  end;
end;

destructor TTillButton.destroy;
begin
  bitmap.free;
  inherited;
end;

procedure TTillButton.LoadFromDataSet(loadtype: TLoadType;
  dataset: TDataSet);
begin
  with dataset do
  begin
    BackdropID := fieldbyname('backdrop').asinteger;
    EposName1 := fieldbyname('eposname1').asstring;
    EposName2 := fieldbyname('eposname2').asstring;
    EposName3 := fieldbyname('eposname3').asstring;
    ButtonTypeID := fieldbyname('ButtonTypeChoiceID').asinteger;
    ButtonTypeData := fieldbyname('Buttontypechoiceattr01').Asstring;
    if assigned(findfield('Buttontypechoiceattr02')) then
      ButtonTypeData2 := fieldbyname('Buttontypechoiceattr02').Asstring;

    if assigned(findfield('SequenceNumber')) then
      SequenceNumber := fieldbyname('SequenceNumber').AsInteger;
    if assigned(findfield('SpaceType')) then
       SpaceType := FieldByName('SpaceType').AsInteger;
    if assigned(findfield('EposDeviceID')) then
       TerminalID := FieldByName('EposDeviceID').AsInteger;

    if assigned(findfield('FontColourR')) then
      begin
        FGColourRed := fieldbyname('FontColourR').AsInteger;
        FGColourGreen := fieldbyname('FontColourG').AsInteger;
        FGColourBlue := fieldbyname('FontColourB').AsInteger;
      end;
    // initialise "Generic" loaded components with kwp set to false, because
    // they will need to be inserted after they are added to a panel

    if assigned(findfield('Font')) and not fieldbyname('Font').isnull then
      FontID := fieldbyname('Font').AsInteger
    else
      FontID := 1;

    //See the comment in uEditTimeSecurity for an explanation: search for H E R E   B E  D R A G O N S
    if assigned(findfield('ButtonSecurityId')) then
    begin
      if fieldbyname('ButtonSecurityId').IsNull then
        ButtonSecurityId := -2
      else
        ButtonSecurityId := fieldbyname('ButtonSecurityId').AsInteger;
    end
    else
      ButtonSecurityId := -2;

    if assigned(findfield('RequestWitness')) and not fieldbyname('RequestWitness').isnull then
      RequestWitness := fieldbyname('RequestWitness').AsBoolean
    else
      RequestWitness := False;

    kwp := false;
    kip := true;
    if loadtype <> ltGeneric then
    begin
      PanelID := TLargeIntField(fieldbyname('PanelID')).aslargeint;
      ButtonID := TLargeIntField(fieldbyname('ButtonID')).aslargeint;
      panelmanager.LoadObjectPosn(self, dataset);
      kwp := true;
      kip := true;
    end;
    upd := false;
  end;
end;

procedure TTillButton.SaveToDataSet(dataset: TDataSet);
var
  keyfields: string;
  keyvalues: variant;
  procedure SetKeyFields;
  begin

    if panelmanager.PanelType in [ptTablePlan, ptSitePanel] then
    begin
      keyfields := 'SiteCode;PanelID;ButtonID';
      keyvalues := vararrayof([panelmanager.tp_sitecode, panelid, buttonid]);
    end
    else
    begin
      keyfields := 'PanelID;ButtonID';
      keyvalues := vararrayof([panelid, buttonid]);
    end;
  end;
begin
  // if no changes, nothing to save
  if not upd then exit;
  // if record was present and still needs to be, locate it for updating
  SetKeyFields;
  if kwp and kip then
  begin
    if not dataset.Locate(keyfields, keyvalues, []) then
      raise Exception.create('Could not update button');
    dataset.edit;
  end
  // if record was not present but needs to be, insert it
  else if not(kwp) and kip  then
  begin
    dataset.Insert;
    PanelID := PanelManager.panelid;
    {$ifndef TILLBUTTON_COMP}
    if (PanelManager.PanelType = ptTablePlan) or (PanelManager.PanelType = ptSitePanel) then
      dataset.fieldbyname('SiteCode').asinteger := panelmanager.tp_sitecode;
    {$endif}
    if buttonid < 1 then
      AllocateID;
    SetKeyFields;
  end
  else if kwp and not(kip) then
  begin
    if not dataset.Locate(keyfields, keyvalues, []) then
      raise exception.create('Could not delete button');
    dataset.delete;
    kwp := false;
  end;
  if kip then with dataset do
  begin
    // update all fields
    if not(kwp) then
    begin
      TLargeIntField(fieldbyname('ButtonID')).aslargeint := ButtonID;
      TLargeIntField(fieldbyname('PanelID')).aslargeint := PanelID;
      kwp := true;
    end;
    panelmanager.SaveObjectPosn(self, dataset);
    fieldbyname('Font').AsInteger := FontID;
    if Assigned(FindField('ButtonSecurityId')) then
    begin
       //See the comment in uEditTimeSecurity for an explanation: search for H E R E   B E  D R A G O N S
       if ButtonSecurityId = -2 then
          fieldbyname('ButtonSecurityId').value := null
       else
          fieldbyname('ButtonSecurityId').AsInteger := ButtonSecurityId;
    end;

    if Assigned(FindField('RequestWitness')) then
      fieldbyname('RequestWitness').AsBoolean := RequestWitness;

    if Assigned(FindField('fontcolourR')) then
      begin
        fieldbyname('fontcolourR').AsInteger := FGColourRed;
        fieldbyname('fontcolourg').AsInteger := FGColourGreen;
        fieldbyname('fontcolourb').AsInteger := FGColourBlue;
      end;
      
    fieldbyname('backdrop').asinteger := BackdropID;

    if panelmanager.PanelType <> ptSitePanel then
    begin
      if (eposname1 <> '') or (eposname2 <> '') or (eposname2 <> '') then
      begin
        fieldbyname('eposname1').asstring := EposName1;
        fieldbyname('eposname2').asstring := EposName2;
        fieldbyname('eposname3').asstring := EposName3;
      end
      else
      begin
        fieldbyname('eposname1').Clear;
        fieldbyname('eposname2').Clear;
        fieldbyname('eposname3').Clear;
      end;
      fieldbyname('ButtonTypeChoiceID').asinteger := ButtonTypeID;
      if ButtonTypeData <> '' then
        fieldbyname('Buttontypechoiceattr01').Asstring := ButtonTypeData
      else
        fieldbyname('Buttontypechoiceattr01').clear;
      if assigned(findfield('Buttontypechoiceattr02')) then
        if ButtonTypeData2 <> '' then
          fieldbyname('Buttontypechoiceattr02').Asstring := ButtonTypeData2
        else
          fieldbyname('Buttontypechoiceattr02').clear;

      if assigned(findfield('SequenceNumber')) then
         FieldByName('SequenceNumber').AsInteger := SequenceNumber;

      if Assigned(findfield('SpaceType')) then
         FieldByName('SpaceType').AsInteger := SpaceType;

      if assigned(findfield('EposDeviceID')) then
         FieldByName('EposDeviceID').AsInteger := TerminalID;

    end;
    post;
  end;
  upd := false;
end;

procedure TTillbutton.paint;
begin
  paintto(canvas, Point(0,0));
end;

procedure TTillbutton.paintto(canvas: TCanvas; paintpos: TPoint);
var
  tmp: THandle;
  i, textlines, lastlinestart: integer;
  line: array[1..3] of string;
  procedure RenderText;
  var
    theight, x, y: integer;
    i: integer;
  begin
    // decrese vertical space between lines of text from the "textheight" value
    // allows low reaching text to touch high reaching letters from below
    // but fits 3 lines of text on a button quite nicely
    theight := round(canvas.TextHeight('hy') * 0.8);
    y := -(canvas.TextHeight('hy') - theight) +
      (height - (textlines * theight)) div 2;
    for i := 1 to textlines do
    begin
      x := -1 + width div 2 - canvas.textwidth(line[i]) div 2;
      canvas.textout(paintpos.x + x, paintpos.y + y, line[i]);
      y := y + theight;
    end;
  end;
begin
  if Assigned(FDatalink) then
    if (fontid = 0) then
    begin
      // large font
      canvas.font.Name := 'Tahoma';
      if assigned(panelmanager) then
        canvas.font.Size := panelmanager.pd.largefont
      else
        canvas.font.Size := 16;
    end
    else
    begin
      // small font
      canvas.font.name := 'Tahoma';
      if assigned(panelmanager) then
        canvas.font.size := panelmanager.pd.smallfont
      else
        canvas.font.Size := 10;
    end;

  tmp := 0;

  if assigned(FDatalink) and assigned(Fdatalink.dataset) and assigned(fdatalink.DataSet.findfield('buttontypechoiceid')) and
    fdatalink.DataSet.FieldByName('buttontypechoiceid').IsNull then
    exit;
  checktext;
  if assigned(canvas) and assigned(bitmap) then
    tmp := windows.SelectObject(canvas.Handle, bitmap.Handle);
  // paint the button background
  ButtonDrawHelper.Draw(drawtype, canvas, paintpos.y, paintpos.x, width, height,
    makecolour(bgcolourred, bgcolourgreen, bgcolourblue));
  lastlinestart := 1;
  textlines := 0;
  line[1] := text;
  for i := 1 to succ(length(text)) do
    if (i > length(text)) or (text[i] = chr($0a)) then
    begin
      if textlines = 3 then break;
      inc(textlines);
      line[textlines] := trim(copy(text, lastlinestart, succ(i- lastlinestart)));
      lastlinestart := i+1;
    end;
  canvas.brush.style := bsClear;
  canvas.font.Color := makecolour(fgcolourred, fgcolourgreen, fgcolourblue);
  rendertext;

  //See the comment in uEditTimeSecurity for an explanation: search for H E R E   B E  D R A G O N S
  if (FButtonSecurityId <> -2) or FRequestWitness then
  begin
    with buttondrawhelper do
      bitblt(canvas.Handle, width-securityicon.width, 0, securityicon.width, securityicon.Height, securityicon.Canvas.Handle, 0, 0,
          SRCCOPY);
  end;
  windows.SelectObject(canvas.Handle, tmp);
end;

procedure TTillButton.SetBackdropID(const Value: integer);
begin
  FBackdropID := Value;
  Splitcolour(backdropcolourlookup[value], bgcolourred, bgcolourgreen, bgcolourblue);
  DrawType := drawtypelookup[value];
  upd := true;
  invalidate;
end;

procedure TTillButton.SetButtonID(const Value: int64);
begin
  FButtonID := Value;
end;

procedure TTillButton.SetButtonTypeData(const Value: string);
begin
  FButtonTypeData := Value;
  upd := true;
end;

procedure TTillButton.SetButtonTypeData2(const Value: string);
begin
  FButtonTypeData2 := Value;
  upd := true;
end;

procedure TTillButton.SetButtonTypeID(const Value: integer);
begin
  FButtonTypeID := Value;
  upd := true;
end;

procedure TTillButton.SetEposName1(const Value: string);
begin
  FEposName1 := Value;
  upd := true;
end;

procedure TTillButton.SetEposName2(const Value: string);
begin
  FEposName2 := Value;
  upd := true;
end;

procedure TTillButton.SetEposName3(const Value: string);
begin
  FEposName3 := Value;
  upd := true;
end;

procedure TTillButton.SetFGColourBlue(const Value: byte);
begin
  FFGColourBlue := Value;
  upd := true;
end;

procedure TTillButton.SetFGColourGreen(const Value: byte);
begin
  FFGColourGreen := Value;
  upd := true;
end;

procedure TTillButton.SetFGColourRed(const Value: byte);
begin
  FFGColourRed := Value;
  upd := true;
end;

procedure TTillButton.SetFontID(const Value: integer);
begin
  FFontID := Value;
  if (fontid = 0) then
  begin
    // large font
    canvas.font.Name := 'Tahoma';
    if assigned(panelmanager) then
      canvas.font.Size := panelmanager.pd.largefont
    else
      canvas.font.Size := 16;
  end
  else
  begin
    // small font
    canvas.font.name := 'Tahoma';
    if assigned(panelmanager) then
      canvas.font.size := panelmanager.pd.smallfont
    else
      canvas.font.Size := 10;
  end;
  upd := true;
end;


procedure TTillButton.SetButtonSecurityId(const Value: integer);
begin
  FButtonSecurityId := Value;
  upd := true;
end;

procedure TTillButton.SetPanelID(const Value: int64);
begin
  FPanelID := Value;
end;

procedure TTillButton.SetSequenceNumber(const Value: integer);
begin
  FSequenceNumber := Value;
  upd := true;
end;

procedure TTillButton.SetSpaceType(const Value: integer);
begin
  FSpaceType := Value;
  upd := true;
end;

procedure TTillButton.SetTerminalID(const Value: integer);
begin
  FTerminalID := Value;
  upd := true;
end;

procedure TTillButton.CheckText;
var
  OverrideText, EposText: string;
begin
  // PW: This is now data driven thanks to the till team changing around
  // all the function ids.
  if (buttontypeid > ButtonFunctionInfoList.ButtonCount)
    or not assigned(ButtonFunctionInfoList[buttontypeid])  then
  begin
    text := 'Unsupported'+#10+'Function';
    exit;
  end;

  OverrideText := ConvertToButtonText(EposName1, EposName2, EposName3, false);

  if not (assigned(fdatalink) and fdatalink.active) then
    showhint := true;

  if (buttontypeid = OpenPanelFunctionID) and (buttontypedata = '') then
  begin
    if buttontypedata2 <> '' then
      EposText := GetButtonTextFromLookupDataset(ThemeTablePlanLookup, strtoint64(buttontypedata2))
    else
      EposText := 'n/a';
  end
  else
    if buttontypeid > 0 then
    begin
      if buttontypedata = '' then
        hint := ButtonFunctionInfoList[buttontypeid].HintNoData
      else
        hint := ButtonFunctionInfoList[buttontypeid].Hint;

      EposText := ButtonFunctionInfoList[buttontypeid].Text;

      if ButtonFunctionInfoList[buttontypeid].ButtonTextAvailable and (buttontypedata <> '') then
      begin
        EposText := ButtonFunctionInfoList[buttontypeid].ButtonText(strtoint64(buttontypedata));
        if EposText = '' then
          EposText := 'Bad'+#10+ButtonFunctionInfoList[buttontypeid].FunctionName+#10+'ID:'+buttontypedata;
        hint := hint + EposText;
      end;

      if ButtonFunctionInfoList[buttontypeid].DataConditionals.Count > 0 then
      begin
        EposText := stringreplace(
          ButtonFunctionInfoList[buttontypeid].DataConditionals.Values[buttontypedata],
          '/n', #10#13, [rfReplaceAll]
        );
      end;
    end;

  if OverrideText <> '' then
    text := OverrideText
  else
    text := EposText;

  if text = '' then text := buttontypedata;

  if hint = '' then
    showhint := false;
end;

procedure TTillbutton.WMPaint(var Message: TWMPaint);
begin
  if Message.DC <> 0 then
  begin
    DataChange(self);
    Canvas.Lock;
    try
      Canvas.Handle := Message.DC;
      try
        Paint;
      finally
        Canvas.Handle := 0;
      end;
    finally
      Canvas.Unlock;
    end;
  end
  else
    Paint;
end;

procedure TTillButton.Assign(source: TPersistent);
var
  src, dest: TTillButton;
begin
  if source is TTillButton then
  begin
    Dest := self;
    src := source as TTillButton;
    dest.Backdropid := src.backdropid;
    dest.Fontid := src.fontid;
    dest.ButtonSecurityId := src.ButtonSecurityId;
    dest.EposName1 := src.eposname1;
    dest.EposName2 := src.eposname2;
    dest.EposName3 := src.eposname3;
    dest.FGColourRed := src.fgcolourred;
    dest.FGColourGreen := src.fgcolourgreen;
    dest.FGColourBlue := src.fgcolourblue;
    dest.ButtonTypeID := src.buttontypeid;
    dest.ButtonTypeData := src.buttontypedata;
    dest.ButtonTypeData2 := src.ButtonTypeData2;
    dest.upd := true;
  end
  else
    Raise Exception.createfmt('Cannot assign a %s to a %s', [source.classname,
      classname]);
end;


function TTillButton.GetIsCorrection: Boolean;
begin
  Result := IsButtonType(['SelectCorrectionMethod', 'EditChoice', 'RemoveGiftAidDetails', 'ReplaceGiftAidDetails']);
end;

procedure TTillButton.Delete;
begin
  if IsCorrectionMethod then
    if (buttontypedata <> '') and (StrToInt(ButtonTypeData) = panelmanager.FCorrectionMethod) then
      raise Exception.Create('This Button cannot be removed as it is marked as the default correction method')
    else
      inherited //** do the actual delete
  else
    inherited;
end;

function TTillButton.GetIsValidForCorrectionPanel: Boolean;

begin
  Result := IsButtonType(['SelectCorrectionMethod', 'SelectCorrectionMode', 'EditChoice', 'RemoveGiftAidDetails', 'ReplaceGiftAidDetails']);
end;

procedure TTillButton.AllocateID;
begin
  {$ifndef TILLBUTTON_COMP}
  if PanelManager.PanelType = ptTablePlan then
  begin
    ButtonID := uGenerateThemeIDs.GetNewId(scThemeOutletTablePlanButton);
  end
  else
  // keep buttonid of master panel for site sub panels
  if PanelManager.PanelType <> ptSitePanel then
    ButtonID := uGenerateThemeIDs.GetNewId(scThemePanelButton);
  {$endif}
end;

function TTillButton.GetIsClosePanelButton: Boolean;
begin
  Result := IsButtonType(['ClosePanel']);
end;

procedure TTillButton.SetRequestWitness(const Value: Boolean);
begin
  FRequestWitness := Value;
  upd := true;
end;

function TTillButton.GetIsDiscount: Boolean;
begin
  Result := IsButtonType(['ApplyBillDiscount']);
end;

function TTillButton.IsButtonType(ButtonTypes: array of string): Boolean;
var
  index: Integer;
  TempButtonInfo: TButtonFunctionInfo;
begin
  Result := False;
  for index := Low(ButtonTypes) to High(ButtonTypes) do
  begin
    TempButtonInfo := ButtonFunctionInfoList.ButtonFunctionInfoByName[ButtonTypes[index]];
    if Assigned(TempButtonInfo) then
      Result := TempButtonInfo.ButtonTypeID = self.ButtonTypeID;
    if Result then Break;
  end;
end;

{ TTillLabel }

constructor TTillLabel.create(AOwner: TPanelManager);
begin
  inherited Create(AOwner);
  parent := AOwner.OwnerForm;
  canvas.font.color := clBlack;
  canvas.font.name := 'Tahoma';
  canvas.font.size := panelmanager.pd.smallfont;
  canvas.Brush.Style := bsClear;
  fontid := 1;
end;

destructor TTillLabel.destroy;
begin
  inherited;
end;

procedure TTillLabel.LoadFromDataSet(loadtype: TLoadType;
  dataset: TDataSet);
begin
  with dataset do
  begin
    // generic/specific load types not used for labels..yet
    PanelID := TLargeIntField(fieldbyname('Panelid')).aslargeint;
    LabelID := TLargeIntField(fieldbyname('Labelid')).aslargeint;
    panelmanager.LoadObjectPosn(self, dataset);
    Text := fieldbyname('text').asstring;
    if fieldbyname('Font').isnull then
      FontID := 1
    else
      FontID := fieldbyname('Font').AsInteger;
    Border := (fieldbyname('Border').asinteger = 1);
    FGColourRed := fieldbyname('fontcolourr').AsInteger;
    FGColourGreen := fieldbyname('fontcolourg').AsInteger;
    FGColourBlue := fieldbyname('fontcolourb').AsInteger;
    BGColourRed := fieldbyname('backgroundcolourr').AsInteger;
    BGColourGreen := fieldbyname('backgroundcolourg').AsInteger;
    BGColourBlue := fieldbyname('backgroundcolourb').AsInteger;
    upd := false;
    kwp := true;
    kip := true; 
  end;
end;

procedure TTillLabel.SaveToDataSet(dataset: TDataSet);
var
  keyfields: string;
  keyvalues: variant;
  procedure SetKeyFields;
  begin
    if panelmanager.PanelType = ptTablePlan then
    begin
      keyfields := 'SiteCode;PanelID;LabelID';
      keyvalues := vararrayof([panelmanager.tp_sitecode, panelid, labelid]);
    end
    else
    begin
      keyfields := 'PanelID;LabelID';
      keyvalues := vararrayof([panelid, labelid]);
    end;
  end;
begin
  // if no changes, nothing to save
  if not upd then exit;
  // if record was present and still needs to be, locate it for updating
  SetKeyFields;
  if kwp and kip then
  begin
    if not dataset.Locate(keyfields, keyvalues, []) then
      raise Exception.create('Could not update label');
    dataset.edit;
  end
  // if record was not present but needs to be, insert it
  else if not(kwp) and kip then
  begin
    dataset.Insert;
    PanelID := PanelManager.panelid;
    {$ifndef TILLBUTTON_COMP}
    if PanelManager.PanelType = ptTablePlan then
    begin
      LabelID := uGenerateThemeIDs.GetNewId(scThemeOutletTablePlanLabel);
      dataset.fieldbyname('SiteCode').asinteger := panelmanager.tp_sitecode;
    end
    else
      LabelID := uGenerateThemeIDs.GetNewId(scThemePanelLabel);
    {$endif}
    SetKeyFields;
  end
  else if kwp and not(kip) then
  begin
    if not dataset.Locate(keyfields, keyvalues, []) then
      raise Exception.create('Could not delete label');
    dataset.delete;
    kwp := false;
  end;
  if kip then with dataset do
  begin
    // update all fields
    if not(kwp) then
    begin
      TLargeIntField(fieldbyname('Panelid')).aslargeint := PanelID;
      TLargeIntField(fieldbyname('Labelid')).aslargeint := LabelID;
      kwp := true;
    end;
    panelmanager.SaveObjectPosn(self, dataset);
    fieldbyname('text').asstring := Text;
    fieldbyname('Font').AsInteger := FontID;
    if border then
      fieldbyname('Border').asinteger := 1
    else
      fieldbyname('Border').asinteger := 0;
    fieldbyname('fontcolourr').AsInteger := FGColourRed;
    fieldbyname('fontcolourg').AsInteger := FGColourGreen;
    fieldbyname('fontcolourb').AsInteger := FGColourBlue;
    fieldbyname('backgroundcolourr').AsInteger := BGColourRed;
    fieldbyname('backgroundcolourg').AsInteger := BGColourGreen;
    fieldbyname('backgroundcolourb').AsInteger := BGColourBlue;
    post;
  end;
  upd := false;
end;

procedure TTillLabel.paint;
begin
  paintto(Canvas, Point(0,0));
end;

procedure TTillLabel.paintto(Canvas: TCanvas; paintpos: TPoint);
var
  rect: TRect;
  tmpint: integer;
  tmpstr: string;
begin
  if fontid = 0 then
  begin
    // large font
    canvas.font.Name := 'Tahoma';
    canvas.font.Size := panelmanager.pd.largefont;
  end
  else
  begin
    // small font
    canvas.font.name := 'Tahoma';
    canvas.font.size := panelmanager.pd.smallfont;
  end;

  tmpstr := text;
  if trim(tmpstr) = '' then
    tmpstr := '(no text)';
  rect.Left := 0;
  rect.Top := 0;
  rect.Right := width;
  rect.Bottom := 0;
  if border and assigned(panelmanager) then
    buttondrawhelper.paintborder(panelmanager.ownerform.canvas, left, top, width, height);
  canvas.Brush.Color := makecolour(bgcolourred, bgcolourgreen, bgcolourblue);
  canvas.Pen.style := psClear;
  if canvas.Brush.Color <> 0 then
    canvas.Rectangle(paintpos.x + 0, paintpos.y + 0, paintpos.x + width + 1, paintpos.y + height + 1);
  canvas.font.color := makecolour(fgcolourred, fgcolourgreen, fgcolourblue);
  DrawText(canvas.Handle, pchar(tmpstr), length(tmpstr), rect,
     DT_NOPREFIX or DT_WORDBREAK or DT_CALCRECT);
  tmpint := (height - rect.bottom) div 2;
  rect.top := tmpint;
  rect.Right := width;
  rect.bottom := rect.bottom + tmpint;

  rect.top := rect.top + paintpos.y;
  rect.bottom := rect.bottom + paintpos.y;
  rect.left := rect.left + paintpos.x;
  rect.right := rect.right + paintpos.x;
  DrawText(canvas.Handle, pchar(tmpstr), length(tmpstr), rect, DT_CENTER or
    DT_NOPREFIX or DT_WORDBREAK);
  canvas.pen.Color := clWhite;
  canvas.Pen.style := pssolid;
end;

procedure TTillLabel.SetBGColourBlue(const Value: byte);
begin
  FBGColourBlue := Value;
  upd := true;
end;

procedure TTillLabel.SetBGColourGreen(const Value: byte);
begin
  FBGColourGreen := Value;
  upd := true;
end;

procedure TTillLabel.SetBGColourRed(const Value: byte);
begin
  FBGColourRed := Value;
  upd := true;
end;

procedure TTillLabel.SetBorder(const Value: boolean);
begin
  FBorder := Value;
  upd := true;
end;

procedure TTillLabel.SetFGColourBlue(const Value: byte);
begin
  FFGColourBlue := Value;
  upd := true;
end;

procedure TTillLabel.SetFGColourGreen(const Value: byte);
begin
  FFGColourGreen := Value;
  upd := true;
end;

procedure TTillLabel.SetFGColourRed(const Value: byte);
begin
  FFGColourRed := Value;
  upd := true;
end;

procedure TTillLabel.SetFontID(const Value: integer);
begin
  FFontID := Value;
  upd := true;
end;

procedure TTillLabel.SetLabelID(const Value: int64);
begin
  FLabelID := Value;
end;

procedure TTillLabel.SetPanelID(const Value: int64);
begin
  FPanelID := Value;
end;

procedure TTillLabel.SetText(const Value: string);
begin
  FText := Value;
  upd := true;
end;

procedure TTillLabel.WMPaint(var Message: TWMPaint);
begin
  if Message.DC <> 0 then
  begin
    DataChange(self);
    Canvas.Lock;
    try
      Canvas.Handle := Message.DC;
      try
        Paint;
      finally
        Canvas.Handle := 0;
      end;
    finally
      Canvas.Unlock;
    end;
  end
  else
    Paint;
end;

function TTillLabel.IsForcedItemHeader: boolean;
begin
 if self.panelmanager.ForcedSelectionPanel then
 begin
   if ((self.Top - self.panelmanager.PanelTop) div self.panelmanager.pd.buttonheight) in [0, 1] then
     Result := True
   else
     Result := False;
 end
 else
 begin
   Result := False;
 end;
end;

{ TTillHeader }

constructor TTillHeader.create(AOwner: TPanelManager);
begin
  inherited Create(AOwner);
  parent := AOwner.OwnerForm;
  canvas.font.color := clBlack;
  canvas.font.size := panelmanager.pd.smallfont;
  canvas.Brush.Style := bsClear;
  kip := true;
end;

destructor TTillHeader.destroy;
begin

  inherited;
end;

procedure TTillHeader.paint;
begin
  paintto(Canvas, Point(0,0));
end;

procedure TTillHeader.paintto(Canvas: TCanvas; paintpos: TPoint);
var
  rect: TRect;
  tmpint: integer;
  text: string;
  i: integer;
begin
  text := self.FHeaderType;
  // insert spaces before capital letters after the first character
  for i := length(text) downto 2 do
    if (ord(text[i]) <= ord('Z')) and (ord(text[i]) >= ord('A')) then insert(' ', text, i);
  rect.Left := 0;
  rect.Top := 0;
  rect.Right := width;
  rect.Bottom := 0;
//  canvas.Brush.Color := makecolour(0, 0, 0);
  canvas.Brush.Style := bsClear;
  canvas.Pen.style := psClear;
  canvas.Rectangle(0, 0, width + 1, height + 1);
  buttondrawhelper.paintborder(canvas, paintpos.x, paintpos.y, width, height);
//  if canvas.Brush.Color <> 0 then
  // Do back ground Graphics
  if (not (PanelManager.FPictureCache.Picture = nil)) And (headertype='OrderDisplay') then
  begin
    rect.Top:=paintpos.y+10;
    rect.Left:=paintpos.x+10;
    Rect.Right:=width-20;
    Rect.Bottom:= height-20;
    Canvas.StretchDraw(PictureRect(Rect,PanelManager.FPictureCache.CurrentPicture.Height,PanelManager.FPictureCache.CurrentPicture.width)
                      ,PanelManager.FPictureCache.CurrentPicture.Bitmap);
  end;
  canvas.font.color := clWhite;

  rect.Left := 0;
  rect.Top := 0;
  rect.Right := width;
  rect.Bottom := 0;

  DrawText(canvas.Handle, pchar(text), length(text), rect,
    DT_NOPREFIX or DT_WORDBREAK or DT_CALCRECT);
  tmpint := (height - rect.bottom) div 2;
  rect.left := paintpos.x;
  rect.top := paintpos.y + tmpint;
  rect.Right := paintpos.x + width;
  rect.bottom := paintpos.y + rect.bottom + tmpint;

  DrawText(canvas.Handle, pchar(text), length(text), rect, DT_CENTER or
    DT_NOPREFIX or DT_WORDBREAK);
  canvas.pen.Color := clWhite;
  canvas.Pen.style := pssolid;
end;

function TTillHeader.PictureRect(DrawingArea:Trect; ImageHeight:Integer; ImageWidth:Integer):Trect;
var
  XScale, YScale, Stretch: Double;
  OutWidth, OutHeight: Integer;
begin
  XScale := ImageWidth / DrawingArea.Right;
  YScale := ImageHeight / DrawingArea.Bottom;

  Stretch := Max(Max(XScale, YScale), 1.0);

  OutWidth := Round(ImageWidth / Stretch);
  OutHeight := Round(ImageHeight / Stretch);

  Result.Left := DrawingArea.Left + (DrawingArea.Right - OutWidth) div 2;
  Result.Top := DrawingArea.Top + (DrawingArea.Bottom - OutHeight) div 2;
  Result.Right := OutWidth + Result.Left;
  Result.Bottom := OutHeight + Result.Top;
end;


procedure TTillHeader.LoadFromDataSet(loadtype: TLoadType;
  dataset: TDataSet);
begin
  PanelManager.LoadObjectPosn(self, dataset);
  PanelID := PanelManager.PanelID;
  Self.HeaderType := dataset.fieldbyname('HeaderType').asstring;
  if dataset.fieldbyname('GraphicID').IsNull then
    Self.FGraphicID:=-1
  else
    Self.FGraphicID:=dataset.fieldbyname('GraphicID').AsInteger;
  // only set up a doublt click handle for order display

  if self.HeaderType='OrderDisplay' then
  begin
    OnDblClick:=HandleDoubleclick;
    PanelManager.FPictureCache.SetPicture(FGraphicID);
  end;

  if self.HeaderType = 'DriveThruPlan' then
     kwp := true;
end;

Procedure TTillHeader.HandleDoubleclick(Sender: TObject);
begin
end;

procedure TTillHeader.SaveToDataSet(dataset: TDataSet);
var
  keyfields: string;
  keyvalues: variant;
  procedure SetKeyFields;
  begin

    if panelmanager.PanelType in [ptTablePlan, ptSitePanel] then
    begin
      keyfields := 'SiteCode;PanelID;HeaderType';
      keyvalues := vararrayof([panelmanager.tp_sitecode, panelid, headertype]);
    end
    else
    begin
      keyfields := 'PanelID;HeaderType';
      keyvalues := vararrayof([panelid, headertype]);
    end;
  end;

begin

  if HeaderType <> 'DriveThruPlan' then
    begin
      if not upd then exit;
      // if record was present and still needs to be, locate it for updating
      dataset.Locate('PanelID;HeaderType', vararrayof([panelid, headertype]), []);
      dataset.edit;
      // Only save for the order display
      if headertype='OrderDisplay' then
        if Self.FGraphicID=-1 then
          dataset.FieldByName('GraphicID').Value:=null
        else
          dataset.FieldByName('GraphicID').AsInteger:=Self.FGraphicID;

      panelmanager.SaveObjectPosn(self, dataset);
      dataset.post;
      upd := false;
  end
    else
  begin
    if not upd then exit;
       // if record was present and still needs to be, locate it for updating
       SetKeyFields;
       if kwp and kip then
       begin
         if not dataset.Locate(keyfields, keyvalues, []) then
            raise Exception.create('Could not update drive thru plan');
            dataset.edit;
         end
         // if record was not present but needs to be, insert it
         else if not(kwp) and kip  then
         begin
           dataset.Insert;
           PanelID := PanelManager.panelid;
           if (PanelManager.PanelType = ptSitePanel) then
             dataset.fieldbyname('SiteCode').asinteger := panelmanager.tp_sitecode;
           SetKeyFields;
         end
         else if kwp and not(kip) then
         begin
         if not dataset.Locate(keyfields, keyvalues, []) then
            raise exception.create('Could not delete button');
            dataset.delete;
            kwp := false;
         end;
         if kip then with dataset do
         begin
           // update all fields
           if not(kwp) then
           begin
             dataset.fieldbyname('Panelid').AsInteger := PanelID;
             dataset.fieldbyname('HeaderType').AsString := HeaderType;
             kwp := true;
           end;
           dataset.FieldByName('GraphicID').Value := null;
          
           panelmanager.SaveObjectPosn(self, dataset);
           dataset.post;
          end;
         upd := false;
      end;
end;

procedure TTillHeader.SetHeaderType(const Value: string);
begin
  FHeaderType := Value;
  if (Value = 'Reserved') or (Value = 'Help') then
  begin
    FixedPos := true;
    FixedWidth := true;
    FixedHeight := true;
  end
  else
  if (Value = 'AccountNumberRectangle') or (Value = 'SelectEmployeeRectangle') or (Value = 'SelectPrinterTestRectangle') or (Value = 'DriveThruPlan') then
  begin
    FixedWidth := false;
    FixedPos := false;
    FixedHeight := false;
  end
  else
  begin
    FixedWidth := true;
    FixedPos := false;
    FixedHeight := false;
  end;
end;

procedure TTillHeader.SetGraphicID(const Value: integer);
begin
  if Value <> FGraphicID then
  begin
    FGraphicID := Value;
    panelmanager.FPictureCache.SetPicture(FGraphicID);
    Invalidate;
    upd := true;
  end;
end;

procedure TTillHeader.SetPanelID(const Value: int64);
begin
  FPanelID := Value;
end;

procedure TTillHeader.WMPaint(var Message: TWMPaint);
begin
  if Message.DC <> 0 then
  begin
    DataChange(self);
    Canvas.Lock;
    try
      Canvas.Handle := Message.DC;
      try
        Paint;
      finally
        Canvas.Handle := 0;
      end;
    finally
      Canvas.Unlock;
    end;
  end
  else
    Paint;
end;

{ TButtonFunctionInfo }

constructor TButtonFunctionInfo.Create;
begin
  DataConditionals := TStringlist.create;
  VersionIntroduced := TDatabaseVersion.Create;
end;

destructor TButtonFunctionInfo.Destroy;
begin
  DataConditionals.Free;
  VersionIntroduced.Free;
  inherited;
end;

function TButtonFunctionInfo.ButtonTextAvailable: boolean;
begin
  Result := Assigned(Lookup);
end;

function TButtonFunctionInfo.ButtonText(Id: int64): string;
begin
  Result := '';

  if Assigned(Lookup) then
    Result := GetButtonTextFromLookupDataset(Lookup, Id);
end;

{ TSubPanel }

procedure TTillSubPanel.CheckFunctionValid(FunctionID: integer);
begin
  PanelManager.CheckFunctionVersionSupported(FunctionID);
end;

constructor TTillSubPanel.create(AOwner: TPanelManager);
begin
  inherited create(AOwner);
end;

destructor TTillSubPanel.destroy;
begin

  inherited;
end;

procedure TTillSubPanel.LoadFromDataSet(loadtype: TLoadType;
  dataset: TDataSet);
begin
  panelmanager.LoadObjectPosn(self, dataset);
  ParentPanelID := panelmanager.panelid;
  FSiteEditAppearance := dataset.FieldByName('SiteEditAppearance').AsBoolean;
  FSiteEditSecurity := dataset.FieldByName('SiteEditSecurity').asboolean;
  FSubPanelID := TLargeIntField(dataset.fieldbyname('SubPanelID')).aslargeint;
  FName := dataset.fieldbyname('Name').asstring;
  FDescription := dataset.fieldbyname('Description').asstring;
  kwp := true;
end;

procedure TTillSubPanel.paint;
begin
  paintto(Canvas, Point(0,0));
end;

procedure TTillSubPanel.paintto(Canvas: TCanvas; paintpos: TPoint);
var
  rect: TRect;
  tmpint: integer;
  text: string;
  i: integer;
begin
  text := 'Site panel: '+name;
  // insert spaces before capital letters after the first character
  for i := length(text) downto 2 do
    if (ord(text[i]) <= ord('Z')) and (ord(text[i]) >= ord('A')) then insert(' ', text, i);
  rect.Left := 4;
  rect.Top := 0;
  rect.Right := width-4;
  rect.Bottom := 0;
  buttondrawhelper.paintborder(canvas, 0, 0, width, height);
  canvas.Brush.Color := makecolour(0, 0, 0);
  canvas.Pen.style := psClear;
  if canvas.Brush.Color <> 0 then
    canvas.Rectangle(0, 0, width + 1, height + 1);
  canvas.font.color := clWhite;
  DrawText(canvas.Handle, pchar(text), length(text), rect,
    DT_NOPREFIX or DT_WORDBREAK or DT_CALCRECT);
  tmpint := (height - rect.bottom) div 2;
  rect.top := tmpint;
  rect.left := 4;
  rect.right := width - 4;
  rect.bottom := rect.bottom + tmpint;
  DrawText(canvas.Handle, pchar(text), length(text), rect, DT_CENTER or
    DT_NOPREFIX or DT_WORDBREAK);
  canvas.pen.Color := clWhite;
  canvas.Pen.style := pssolid;
end;

procedure TTillSubPanel.SaveToDataSet(dataset: TDataSet);
var
  updatequery: TADOQuery;
  procedure PanelHeader_Insert;
  begin
    updatequery := TADOQuery.create(nil);
    updatequery.Connection := tpanelmanager(owner).PMConnection;
    updatequery.SQL.text := format('insert themepanel '+
      '(panelid, paneltype, paneldesignid, [name], [description], [left], [top], [width], [height], [eposname1], [eposname2], [eposname3]) '+
      'values (%d, 5, %d, ''SubPanel'', '''', 0, 0, 0, 0, '''','''','''') ', [subpanelid, tpanelmanager(owner).paneldesign]);
    updatequery.execsql;
    updatequery.free;
  end;
  procedure PanelHeader_Delete;
  begin
    updatequery := TADOQuery.create(nil);
    updatequery.Connection := tpanelmanager(owner).PMConnection;
    updatequery.SQL.text := format('delete themepanel '+
      'where panelid = %d', [subpanelid]);
    updatequery.execsql;
    updatequery.free;
  end;
  procedure PanelHeader_Modify(width, height: integer);
  begin
    updatequery := TADOQuery.create(nil);
    updatequery.Connection := tpanelmanager(owner).PMConnection;
    updatequery.SQL.text := format('update themepanel '+
      'set width = %d, height = %d '+
      'where panelid = %d', [width, height, subpanelid]);
    updatequery.execsql;
    updatequery.free;
  end;
begin
  if not upd then exit;
  // if record was present and still needs to be, locate it for updating
  if kip then
  begin
    if not dataset.Locate('ParentPanelID;SubPanelID', vararrayof([parentpanelid, subpanelid]), []) then
    begin
      dataset.Insert;
      panelheader_insert;
    end
    else
      dataset.edit;
    panelmanager.SaveObjectPosn(self, dataset);
    PanelHeader_Modify(dataset.fieldbyname('width').asinteger, dataset.fieldbyname('height').asinteger);
    TLargeIntField(dataset.FieldByName('ParentPanelID')).aslargeint := self.parentpanelid;
    TLargeIntField(dataset.FieldByName('SubPanelID')).aslargeint := self.subpanelid;
    dataset.fieldbyname('Name').asstring := name;
    dataset.FieldByName('Description').AsString := description;
    dataset.FieldByName('SiteEditAppearance').AsBoolean := SiteEditAppearance;
    dataset.FieldByName('SiteEditSecurity').AsBoolean := SiteEditSecurity;
    dataset.post;
    upd := false;
    if not kwp then
      kwp := true;
  end
  else
  if kwp then
  begin
    if dataset.Locate('ParentPanelID;SubPanelID', vararrayof([parentpanelid, subpanelid]), []) then
    begin
      dataset.Delete;
      panelheader_delete;
    end;
    kip := false;
  end;
end;

procedure TTillSubPanel.SetDescription(const Value: string);
begin
  FDescription := Value;
  upd := true;
end;

procedure TTillSubPanel.SetName(const Value: string);
begin
  invalidate;
  FName := Value;
  upd := true;
end;

procedure TTillSubPanel.SetParentPanelID(const Value: int64);
begin
  FParentPanelID := Value;
  upd := true;
end;

procedure TTillSubPanel.SetSiteEditAppearance(const Value: boolean);
begin
  FSiteEditAppearance := Value;
  upd := true;
end;

procedure TTillSubPanel.SetSiteEditSecurity(const Value: boolean);
begin
  FSiteEditSecurity := Value;
  upd := true;
end;

procedure TTillSubPanel.SetSubPanelID(const Value: int64);
begin
  FSubPanelID := Value;
  upd := true;
end;

procedure TTillSubPanel.WMPaint(var Message: TWMPaint);
begin
  if Message.DC <> 0 then
  begin
    DataChange(self);
    Canvas.Lock;
    try
      Canvas.Handle := Message.DC;
      try
        Paint;
      finally
        Canvas.Handle := 0;
      end;
    finally
      Canvas.Unlock;
    end;
  end
  else
    Paint;
end;

Procedure TPictureCache.SetPicture(GraphicID:integer);
var
  ImageStream : TStream;
  ADOTTerminalGraphics: TADOTable;
  TerminalGraphics: TTerminalGraphics;
begin
  if GraphicID < 1 then
  begin
    if CurrentPicture=nil then
      CurrentPicture:=TPicture.Create;
    TerminalGraphics:=TTerminalGraphics.Create(nil);
    CurrentPicture.Bitmap:=TerminalGraphics.imDefaultImage.Picture.Bitmap;
    FreeAndNil(TerminalGraphics);
  end
  else
  begin
    ADOTTerminalGraphics:=TADOTable.Create(Nil);
    ADOTTerminalGraphics.Connection:=dmADO.AztecConn;
    ADOTTerminalGraphics.TableName:='TerminalGraphics';
    ADOTTerminalGraphics.Open;
    ADOTTerminalGraphics.Locate('ID',GraphicID,[]);
    if CurrentPicture=nil then
      CurrentPicture:=TPicture.Create;
    ImageStream:=ADOTTerminalGraphics.CreateBlobStream(ADOTTerminalGraphics.FieldByName('BitMap'),bmRead);
    CurrentPicture.Bitmap.LoadFromStream(ImageStream);
    FreeAndNil(ImageStream);
    FreeAndNil(ADOTTerminalGraphics);
  end;
end;
constructor TPictureCache.Create;
begin

end;

destructor TPictureCache.Destroy;
begin
  FreeAndNil(CurrentPicture);
end;

{ TMultiItemSelection }

procedure TMultiItemSelection.Clear;
var
  i: integer;
begin
  SetLength(SelectedObjects, 0);
  for i := 0 to Pred(Length(SelectHandleTop)) do
  begin
    SelectHandleTop[i].Free;
    SelectHandleLeft[i].Free;
    SelectHandleBottom[i].Free;
    SelectHandleRight[i].Free;
  end;
  SetLength(SelectHandleTop, 0);
  SetLength(SelectHandleLeft, 0);
  SetLength(SelectHandleBottom, 0);
  SetLength(SelectHandleRight, 0);
end;

function TMultiItemSelection.GetHeight: integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to Pred(Length(SelectedObjects)) do
    Result := Max(Result, SelectedObjects[i].Top+SelectedObjects[i].Height);
  Result := Result - GetTop;
end;

function TMultiItemSelection.GetLeft: integer;
var
  i: integer;
begin
  Result := 999999;
  for i := 0 to Pred(Length(SelectedObjects)) do
    result := min(Result, SelectedObjects[i].Left);
end;

function TMultiItemSelection.GetTop: integer;
var
  i: integer;
begin
  Result := 999999;
  for i := 0 to Pred(Length(SelectedObjects)) do
    result := min(Result, SelectedObjects[i].Top);
end;

function TMultiItemSelection.GetWidth: integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to Pred(Length(SelectedObjects)) do
    Result := Max(Result, SelectedObjects[i].Left+SelectedObjects[i].Width);
  Result := Result - GetLeft;
end;

procedure TMultiItemSelection.SetHandlesVisible(Value: boolean);
var
  i: integer;
begin
  for i := 0 to Pred(Length(SelectHandleTop)) do
  begin
    SelectHandleTop[i].Top := SelectedObjects[i].Top - (DRAG_HANDLE_SELECT_OFFSET);
    SelectHandleTop[i].Left := SelectedObjects[i].Left - (DRAG_HANDLE_SELECT_OFFSET);
    SelectHandleTop[i].Visible := Value;

    SelectHandleLeft[i].Top := SelectedObjects[i].Top + SelectedObjects[i].Height - DRAG_HANDLE_WIDTH + (DRAG_HANDLE_SELECT_OFFSET);
    SelectHandleLeft[i].Left := SelectedObjects[i].Left - (DRAG_HANDLE_SELECT_OFFSET);
    SelectHandleLeft[i].Visible := Value;

    SelectHandleBottom[i].Top := SelectedObjects[i].Top - (DRAG_HANDLE_SELECT_OFFSET);
    SelectHandleBottom[i].Left := SelectedObjects[i].Left + SelectedObjects[i].Width - DRAG_HANDLE_WIDTH + (DRAG_HANDLE_SELECT_OFFSET);
    SelectHandleBottom[i].Visible := Value;

    SelectHandleRight[i].Top := SelectedObjects[i].Top + SelectedObjects[i].Height - DRAG_HANDLE_WIDTH + (DRAG_HANDLE_SELECT_OFFSET);
    SelectHandleRight[i].Left := SelectedObjects[i].Left + SelectedObjects[i].Width - DRAG_HANDLE_WIDTH + (DRAG_HANDLE_SELECT_OFFSET);
    SelectHandleRight[i].Visible := Value;
  end;
end;

procedure TMultiItemSelection.ToggleSelection(SelectedObject: TControl);
var
  i: integer;
  DeleteIndex: integer;
begin
  DeleteIndex := -1;
  for i := 0 to Pred(Length(SelectedObjects)) do
    if SelectedObjects[i] = SelectedObject then
      DeleteIndex := i;

  if DeleteIndex <> -1 then
  begin
    for i := DeleteIndex+1 to Pred(Length(SelectedObjects)) do
    begin
      SelectedObjects[i-1] := SelectedObjects[i];
    end;
    SelectHandleTop[Pred(Length(SelectedObjects))].Free;
    SelectHandleLeft[Pred(Length(SelectedObjects))].Free;
    SelectHandleBottom[Pred(Length(SelectedObjects))].Free;
    SelectHandleRight[Pred(Length(SelectedObjects))].Free;

    SetLength(SelectedObjects, Pred(Length(SelectedObjects)));
    SetLength(SelectHandleTop, (Length(SelectedObjects)));
    SetLength(SelectHandleLeft, (Length(SelectedObjects)));
    SetLength(SelectHandleBottom, (Length(SelectedObjects)));
    SetLength(SelectHandleRight, (Length(SelectedObjects)));

  end
  else
  begin
    SetLength(SelectedObjects, Succ(Length(SelectedObjects)));
    SetLength(SelectHandleTop, (Length(SelectedObjects)));
    SetLength(SelectHandleLeft, (Length(SelectedObjects)));
    SetLength(SelectHandleBottom, (Length(SelectedObjects)));
    SetLength(SelectHandleRight, (Length(SelectedObjects)));

    SelectedObjects[Pred(Length(SelectedObjects))] := SelectedObject;
    SelectHandleTop[Pred(Length(SelectedObjects))] := TDragHandle.Create(TPanelManager(Owner).OwnerForm, dhTop, false);
    SelectHandleLeft[Pred(Length(SelectedObjects))] := TDragHandle.Create(TPanelManager(Owner).OwnerForm, dhLeft, false);
    SelectHandleBottom[Pred(Length(SelectedObjects))] := TDragHandle.Create(TPanelManager(Owner).OwnerForm, dhBottom, false);
    SelectHandleRight[Pred(Length(SelectedObjects))] := TDragHandle.Create(TPanelManager(Owner).OwnerForm, dhRight, false);
  end;
  Left := GetLeft;
  Top := GetTop;
  Width := GetWidth;
  Height := GetHeight;
  TPanelmanager(Owner).aligndraghandles(self);
end;

{ TDragHandle }

constructor TDragHandle.Create(AOwner: TComponent;
  Orientation: TDragHandleType; Draggable: boolean);
begin
  inherited Create(AOwner);
  visible := false;
  tag := Ord(Orientation);
  if Draggable then
  begin
    Color := clWhite
  end
  else
  begin
    Color := clSilver;
    BevelOuter := bvNone;
  end;
  Parent := TWinControl(AOwner);
  Width := DRAG_HANDLE_WIDTH;
  Height := DRAG_HANDLE_WIDTH;
  if Draggable then
    case TDragHandleType(Orientation) of
      dhTop, dhBottom: cursor := crSizeNS;
      dhLeft, dhRight: Cursor := crSizeWE;
      dhTopLeft, dhBottomRight: Cursor := crSizeNWSE;
      dhTopRight, dhBottomLeft: Cursor := crsizeNESW;
    end;
end;

{ TPanelDisplayTransform }

constructor TPanelDisplayTransform.Create;
begin
  fbuttonwidth := 64;
  fbuttonheight := 48;
  fscreenwidth := 640;
  fscreenheight := 480;
  fgridoffsetx := 0;
  fgridoffsety := 0;
  fsmallfont := 10;
  flargefont := 16;
end;


function TPanelDisplayTransform.GetScreenRect: TRect;
begin
  result.Left := 0;
  result.Top := 0;
  result.Right := self.FScreenWidth + self.GridOffsetX + self.GridOffsetX;
  result.Bottom := self.FScreenHeight + self.GridOffsetY + self.GridOffsetY;
end;

procedure TPanelDisplayTransform.LoadFromDataset(data: TDataSet);
begin
  with data do
  begin
    Fbuttonwidth := fieldbyname('Buttonwidth').asinteger;
    Fbuttonheight := fieldbyname('Buttonheight').asinteger;
    Fscreenwidth := fieldbyname('Screenwidth').asinteger;
    Fscreenheight := fieldbyname('Screenheight').asinteger;
    Fgridoffsetx := fieldbyname('GridOffsetX').asinteger;
    Fgridoffsety := fieldbyname('Gridoffsety').asinteger;

    SetAutoZoom();
  end;
end;

procedure TPanelDisplayTransform.LoadFromValues(ButtonWidth, ButtonHeight,
  ScreenWidth, ScreenHeight, GridOffsetX, GridOffsetY: integer);
begin
  FButtonWidth := ButtonWidth;
  FButtonHeight := ButtonHeight;
  FScreenWidth := ScreenWidth;
  FScreenHeight := ScreenHeight;
  FGridOffsetX := GridOffsetX;
  FGridOffsetY := GridOffsetY;
  
  SetAutoZoom();
end;

function TPanelDisplayTransform.NumButtonsX: integer;
begin
  result := round(FScreenWidth / FButtonWidth);
end;

function TPanelDisplayTransform.NumButtonsY: integer;
begin
  result := round(FScreenHeight / FButtonHeight);
end;

function TPanelDisplayTransform.PixelToButtonCoords(
  PixelCoords: TRect; AbsoluteBounds: boolean = false): TRect;
begin
  if AbsoluteBounds then
  begin
    PixelCoords.Right := PixelCoords.Right - PixelCoords.Left;
    PixelCoords.Bottom := PixelCoords.Bottom - PixelCoords.Top;
  end;
  result.Left := round((PixelCoords.Left - FGridOffsetX) / FButtonWidth);
  result.Top := round((PixelCoords.Top - FGridOffsetY) / FButtonHeight);
  result.Right := round(PixelCoords.Right / FButtonWidth);
  result.Bottom := round(PixelCoords.Bottom / FButtonHeight);
end;

function TPanelDisplayTransform.ButtonToPixelCoords(
  ButtonCoords: TRect; AbsoluteBounds: boolean = false): TRect;
begin
  result.Left := ButtonCoords.Left * FButtonWidth + FGridOffsetX;
  result.Top := ButtonCoords.Top * FButtonHeight + FGridOffsetY;
  result.Right := ButtonCoords.Right * FButtonWidth;
  result.Bottom := ButtonCoords.Bottom * FButtonHeight;
  if AbsoluteBounds then
  begin
    result.Right := result.Right + result.Left;
    result.Bottom := result.Bottom + result.Top;
  end;
end;

procedure TPanelDisplayTransform.SetAutoZoom;
begin
  if (Fbuttonwidth < 50) and (Fbuttonwidth > 20) then
  begin
    Fbuttonwidth := Fbuttonwidth * 2;
    Fbuttonheight := Fbuttonheight * 2;
    Fscreenwidth := Fscreenwidth * 2;
    Fscreenheight := Fscreenheight * 2;
    Fgridoffsetx := Fgridoffsetx * 2;
    Fgridoffsety := Fgridoffsety * 2;
  end
  else
  if ((screenwidth+2*gridoffsetx+8) >= Screen.DesktopWidth) or ((screenheight+2*gridoffsety+8) >= Screen.DesktopHeight) then
  begin
    Fbuttonwidth := trunc(Fbuttonwidth * 0.78125);
    Fbuttonheight := trunc(Fbuttonheight * 0.78125);
    Fscreenwidth := trunc(Fscreenwidth * 0.78125);
    Fscreenheight := trunc(Fscreenheight * 0.78125);
    Fgridoffsetx := trunc(Fgridoffsetx * 0.78125);
    Fgridoffsety := trunc(Fgridoffsety * 0.78125);
  end;

  FGridOffsetY := (FScreenHeight - (NumButtonsY * FButtonHeight)) div 2;
  FGridOffsetX := (FScreenWidth - (NumButtonsX * FButtonwidth)) div 2;


end;

procedure TPanelDisplayTransform.SetBoundsFromDataSet(control: TControl; data: TDataSet);
var
  top: integer;
  left: integer;
  width: integer;
  height: integer;
begin
  left :=   data.FieldByName('Left').AsInteger * FButtonWidth + FGridOffsetX;
  top :=   data.FieldByName('Top').AsInteger * FButtonHeight + FGridOffsetY;
  width :=   data.FieldByName('Width').AsInteger * FButtonWidth;
  height :=   data.FieldByName('Height').AsInteger * FButtonHeight;
  control.SetBounds(left, top, width, height);
end;

{ TTillButtonList }

procedure TTillButtonList.Add(TillButton: TTillButton);
begin
  inherited Add(TillButton);
end;

function TTillButtonList.IDCommaText: String;
var
  Index: Integer;
  Button: TTillButton;
begin
  Result := '';
  for Index := 0 to Count - 1 do
  begin
    Button := Get(Index);
    Result := Result + IntToStr(Button.ButtonID) + ',';
  end;
  System.Delete(Result, Length(Result), 1);
end;

function TTillButtonList.Get(Index: Integer): TTillButton;
begin
  Result := inherited Get(Index);
end;

procedure TTillButtonList.Put(Index: Integer; Item: TTillButton);
begin
  inherited Put(Index, Item);
end;

{ TButtonFunctionInfoList }
constructor TButtonFunctionInfoList.Create;
begin
  inherited;
  ButtonFunctionInfoStringList := TStringList.Create;
  ButtonFunctionInfoStringList.Sorted := True;
end;

destructor TButtonFunctionInfoList.destroy;
var
  Index: Integer;
begin
  for Index := Low(ButtonFunctionInfoArray) to High(ButtonFunctionInfoArray) do
  begin
    if Assigned(ButtonFunctionInfoArray[Index]) then
      ButtonFunctionInfoArray[Index].Free;
  end;
  ButtonFunctionInfoStringList.Free;
  inherited;
end;

function TButtonFunctionInfoList.GetButtonCount: Integer;
begin
  Result := High(ButtonFunctionInfoArray);
end;

function TButtonFunctionInfoList.GetButtonFunctionInfoByIndex(
  Index: Integer): TButtonFunctionInfo;
begin
  Result := ButtonFunctionInfoArray[Index];
end;

function TButtonFunctionInfoList.GetButtonFunctionInfoByName(
  Name: String): TButtonFunctionInfo;
var
  Index: Integer;
begin
  Result := nil;
  if ButtonFunctionInfoStringList.Find(Name, Index) then
    Result := TButtonFunctionInfo(ButtonFunctionInfoStringList.Objects[Index]);
end;

procedure TButtonFunctionInfoList.SetButtonFunctionInfoByIndex(
  Index: Integer; const _ButtonFunctionInfo: TButtonFunctionInfo);
begin
  ButtonFunctionInfoArray[Index] := _ButtonFunctionInfo;
  ButtonFunctionInfoStringList.AddObject(_ButtonFunctionInfo.FunctionName, _ButtonFunctionInfo);
end;

procedure TButtonFunctionInfoList.SetLength(NewLength: Integer);
begin
  System.SetLength(ButtonFunctionInfoArray, NewLength);
end;

initialization
  ButtonDrawHelper := TButtonDrawHelper.create(nil);
  PanelLookup := TADODataset.Create(nil);
  ButtonFunctionInfoList := TButtonFunctionInfoList.Create;

  ThemeTablePlanLookup := TADODataset.Create(nil);
  PaymentLookup := TADODataset.Create(nil);
  CorrectionLookup := TADODataset.Create(nil);
  PortionTypeLookup := TADODataset.Create(nil);
  TaxLookup := TADODataset.Create(nil);
  DiscountLookup := TADODataset.Create(nil);
  ReportLookup := TADODataset.Create(nil);
  InstructionLookup := TADODataset.Create(nil);
  ProductLookup := TADODataset.Create(nil);
  OrderDestinationLookup := TADODataset.Create(nil);
  MacroLookup := TADODataset.Create(nil);
  ButtonUrlLookup := TADODataset.Create(nil);
  RemovePromotionsLookup := TADODataset.Create(nil);
  EftRuleSoapOperationLookup := TADODataset.Create(nil);
  OrderDestinationConversionLookup := TADODataSet.Create(nil);


finalization
  ButtonDrawHelper.free;
  PanelLookup.Free;
  ThemeTablePlanLookup.Free;
  PaymentLookup.Free;
  CorrectionLookup.Free;
  PortionTypeLookup.Free;
  TaxLookup.Free;
  DiscountLookup.Free;
  ReportLookup.Free;
  InstructionLookup.Free;
  ProductLookup.Free;
  OrderDestinationLookup.Free;
  ButtonFunctionInfoList.Free;
  OrderDestinationConversionLookup.Free;
end.
