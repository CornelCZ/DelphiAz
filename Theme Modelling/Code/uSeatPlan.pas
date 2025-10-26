unit uSeatPlan;

interface


uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, DBCtrls, Dialogs, DB,
  ADODB, math;

const


  LineWidth = 3;
  //** Constants Table Shapes
  tsRound = 0;
  tsSquare = 1;
  tsDiamond = 2;
  //** What Type of line is the path needed to calculate mid points etc
  ltHorizontal = 0;
  ltVertical = 1;
  ltCircle = 2;
  ltDiagonalAsc = 3;  //**  /  \
  ltDiagonalDesc = 4; //**  \  /
  //** Following constants used to define a path used to calc Seat Number
  asLeftToRight = 0;
  asRightToLeft = 1;
  asTopToBottom = 2;
  AsBottomToTop = 3;
  TblImgMaxSize = 200;
  TblImgMinSize = 75;
  TblDiamondImgMinSize = 75;



  FTableShapeStr : Array[tsRound..tsDiamond] of string = ('Round','Square', 'Diamond');

  FResourceNames : Array[tsRound..tsDiamond] of string = ('AZTEC_CIRCLE','AZTEC_SQUARE','AZTEC_Diamond');
  NinetyDegreesInRad = (pi/2);
  ClearSeatSQl = 'Delete from %s where SiteCode = %d and TableNumber = %d';
  AddSeatSQL = 'Insert Into %S (SiteCode, TableNumber, SeatNumber, X,Y) VAlues (:SiteCode,:TblNo,:SeatNo,:X,:Y)';

var
  DBShape : Array[tsRound..tsDiamond] of Integer;

type
  TSeatPlanResize = procedure(x,y : Integer) of object;
  TDragHandleType = (dhtTop, dhtRight, dhtBottom, dhtLeft);

  TDragHandle = class(TCustomControl)
  private
    FHandleType : TDragHandleType;
    Start : Tpoint;
    FDoResize : TSeatPlanResize;
    procedure SetHAndleType(Htype : TDragHandleTYpe);
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  public
    Constructor Create(Aowner : TComponent); override;
    property DragHandleType : TDragHandleType read FHAndleType write SetHandleType;
    property OnResize: TSeatPlanResize read FDoResize write FDoResize;
  end;

//  TPathLine = class(TCustomSeatControl)
  TPathLine = class(TCustomControl)
  private
    LineType : Integer;
    Pattern : Integer;
    SeatHeight, SeatWidth : Integer;
    procedure AddSeat;
    procedure DoClick(Sender : TObject);
  protected
    colour : TColor;
    procedure Paint; override;
    procedure AlignPathSeats; virtual;

  public
    procedure DoDragDrop(Sender,Source: TObject; X, Y: Integer);
    procedure DoDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean);
    procedure DoDblClick(Sender :TObject); virtual;
    constructor Create(AOwner : TComponent); override;
  end;

  TDiamondPathLine = class(TPathLine)
  private
    IsLoaded: Boolean;
    FRgn, FRgn2: HRGN;
    RgnBrush: TBrush;
    FImgTop, FImgLeft, FImgRight, FImgBottom : Integer;
    FStartPoint, FEndPoint: Tpoint;
    Roof, Floor : Integer;
    procedure MakeRegion;
    procedure WMSize(var Message: TMessage); message WM_SIZE;
    procedure SetPathColour(Value : TColor);
    function GetLineY(Newx: single): Integer;
  protected
    procedure Paint; override;
    procedure CreateWnd; override;
    procedure AlignPathSeats; override;
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
    constructor Create(AOwner: TComponent; Acolour : TColor); reintroduce; overload;

    destructor Destroy; override;
    property PathColour : TColor read Colour write SetPathColour;
  end;

  TShapedPanel = class(TCustomControl)
  private
    { Private declarations }
    FBorderColor: TColor;
    IsLoaded: Boolean;
    FBorderWidth: Integer;
    FRgn, FRgn2: HRGN;
    RgnBrush: TBrush;
    FFIlLColor: TColor;
    FPattern : Integer;
    FLineType : Integer;
    procedure SetFillColor(const Value: TColor);
    function GetFillColor: TColor;
    procedure MakeRegion;
    procedure SetBorderColor(Value: TColor);
    procedure SetPattern(Value : Integer);
    procedure SetLineType(Value : Integer);
    procedure WMSize(var Message: TMessage); message WM_SIZE;
  protected
    { Protected declarations }
    procedure Paint; override;
    procedure CreateWnd; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property BorderColor: TColor read FBorderColor write SetBorderColor default clBlack;
    property BorderWidth: Integer read FBorderWidth write FBorderWidth default 2;
    property FillColor: TColor read GetFillColor write SetFillColor;
    property Pattern : Integer Read FPattern write SetPattern;
    property LineType : Integer Read FlineTYpe write SetLineType;

    property Height default 200;
    property Width default 200;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
    property OnDragOver;
  end;


  TSeat = class(TGraphicControl)
  private
    FSeatImage : TBitMap;
    FSeatMask : TBitMap;
    FSeatNo : Integer;
    function  GetAbsoluteLeft : Single;
    function  GetAbsoluteTop : Single;
    procedure DoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    { Private declarations }
  protected
    { Protected declarations }
    procedure Paint; override;
    procedure RelayDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure relayDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean);
    procedure RelayDblClick(Sender : TObject);
    procedure DoDblClick(Sender : TObject);
    procedure DoClick(Sender : TObject);

  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    property SeatNo : Integer read FSeatNo write FSeatNo;
    property RelativeX : single read GetAbsoluteLeft;
    property RelativeY : single read GetAbsoluteTop;
  published
    property DragMode;
    property OnClick;
    //** Seating plans need to be drawn on 320 * 336 and 480 * 640 screens so
    //** all values will be saved to the database in a fraction of the width/Height
    //** of the component
    { Published declarations }
  end;

//  TSeatPlan = class(TCustomSeatControl)
  TSeatPlan = class(TCustomControl)
  private
    { Private declarations }
    FSeats : TList;
    FPathLines : TList;
    DragHandles : Array[1..4] of TDragHandle;
    FTableImages : Array[tsRound..tsDiamond] of TBitmap;
    FTableShape : Integer;
    Centre : TPoint;
    FSeatPosDS : TdataSource;
    FTblImgTop, FTblImgLeft, FTblImgHeight, FTblImgWidth, FTblImgMaxSize, FTblImgMinSize : Integer;
    FImgOffSet : Integer; //dictates how far the paths float from the Image
    FImgRoundOffSet : Single; {No of pixels by which to offset my path images from the Table Image}
    FStandardStartPoint : Boolean;
    FDatalink: TFieldDataLink;
    FLoading : Boolean;
    FRotation : Integer;
    FSiteCode : Integer;
    FTableNumber : Integer;
    FTableName : string;
    FCancelChanges: Boolean;
    procedure SetTableWidth(TblWidth : Integer);
    procedure SetTableHeight(TblHeight : Integer);
    procedure SetTableShape(TblShape : Integer);
    procedure ReSizeBy(X,Y : Integer);
    procedure InitPaths;
    procedure AlignDragHandles;
    procedure InitDragHAndles;
    function  NextPath: TWinControl;
    procedure ClearAllSeats;
    procedure UpdateDataSet(NewFieldName: string; Value: variant);
    function ValidDataSet: Boolean;
    procedure EditingChange(Sender: TObject);

    function GetDataField: string;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetReadOnly(const Value: Boolean);
    procedure SPKeyPress(Sender: TObject; var Key: Char);
    procedure RemoveSeatDS(Path: Integer);
    procedure AddSeatDS(Path : Integer);

  protected
    procedure Paint; override;
    procedure UpdateSeatNumbers;
    function GetSeat(Index : Integer) : TSeat;
    function GetSeatCount : Integer;
    procedure AlignRoundTableSeats;
    function GetAbsoulteWidth : single;
    function GetAbsoulteHeight : single;
    procedure SetDatasource(const Value: TDatasource);
    function GetDatasource: TDataSource;
    procedure Click; override;
    procedure SetRotation(value : Integer);
    procedure ResetRotation; //** Required after a seat is moved or added as the Seats list will get reset
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    property DataField : string read GetDataField write SetDataField;

    { Protected declarations }
  public
    procedure DoDragDrop(Sender,Source: TObject; X, Y: Integer);
    procedure DoDragOver(Sender,Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean);
    procedure DoDblCLick(Sender : TObject);
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure Rotate(CLockwise: Boolean);
    procedure AddSeat; overload;
    procedure AddSeat(Seat : TSeat; Path : Integer); overload;
    procedure RemoveSeat(Seat: TSeat);
    procedure DataChange(sender: TObject); virtual;
    procedure UpdateData(Sender : TObject);
    procedure Load;
    procedure Save;
    procedure SaveSeatPosition;
    procedure New(Site : Integer; TableNo : Integer);
    procedure InitBackDropIDs(Round, Square,Diamond : Integer);


    property Seat[index : Integer] : TSeat read GetSeat;  default;
    property SeatCount : Integer read GetSeatCount;
    { Public declarations }
    published
    Property OnClick;
    property TableWidth : Integer read FTblImgWidth write SetTableWidth;
    property TableHeight : Integer read FTblImgWidth write SetTableHeight;
    property TableShape : Integer read FTableShape write SetTableShape default tsSquare;
    property RelativeWidth : single read GetAbsoulteWidth;
    property RelativeHeight : single read GetAbsoulteHeight;
    property Datasource: TDatasource read GetDatasource write SetDatasource;
    property Rotation : Integer read FRotation write SetRotation;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property SiteCode : Integer read FSiteCOde write FSiteCOde;
    property TableNumber : Integer read FTableNumber write FTableNumber;
    property AztecTableName : string read FTableName write FTableName;
    property SeatCoordsSource : TDataSource read FSeatPosDS write FSeatPosDS;
    property CancelChanges: Boolean read FCancelChanges write FCancelChanges;

    { Published declarations }
  end;



procedure Register;

implementation

var
  gTextColour : TColor;



procedure Register;
begin
  RegisterComponents('Standard', [TSeatPlan]);
  RegisterComponents('Standard', [TSeat]);
  RegisterComponents('Standard', [TShapedPanel]);


end;

{ TSeatPlan }
//------------------------------------------------------------------------------
constructor TSeatPlan.Create(AOwner: TComponent);
var
  TmpBitMap : TBitmap;
  index : Integer;
begin
  inherited;
  Tag := 1;
  SetEnabled(True);
  gTextColour := clWhite;
  FDatalink := TFieldDataLink.Create;
  FDataLink.control := self;
  //** THis is Important! It also took me an age to work out. If a default fieldname is
  //** Not Specifed then it does not invoke the OnEditingChange which the component
  //** Needs to know when it has saved the table results and needs to save the
  //** Chair Coords.
  FDataLink.FieldName := 'NumSeats1';
  FDataLink.ondatachange := self.datachange;
  FDataLink.onUpdateData := self.UpDateData;
  FDataLink.OnEditingChange := EditingChange;

  OnKeyPress :=   SPKeyPress;
  OnDragDrop := DoDragDrop;
  OnDragOver := DoDragOver;
  OnDblClick := DoDblClick;

//F  OnDragOver := DoDr
  FSeats := TList.Create;
  FPathLines := TList.Create;
  FStandardStartPoint := True;

  FTblImgMaxSize := 200;
  FTblImgMinSize := 75;
  FTableShape := tsSquare;
  width := 320;
  Height := 336;
  Centre.X := Width div 2;
  Centre.Y := Height div 2;
  FImgOffSet := 5;

  TableWidth := 100;
  TableHeight := 100;
  FTableShape := tsSquare;
  for index := tsRound to tsDiamond do
  begin
    TmpBitMap := TBitmap.Create;
    TmpBitMap.LoadFromResourceName(Hinstance, FResourceNames[index]);
    FTableImages[index] := TmpBitmap;  //** Remember to free the bitmaps!
  end;
  InitPaths;
  InitDragHandles;
  FCancelChanges := FALSE;
end;

//------------------------------------------------------------------------------
destructor TSeatPlan.Destroy;
var
  index : Integer;
begin
  FSeats.Free;
  FPathLines.Free;
  FDataLink.OnDataChange := nil;
  FDataLink.OnEditingChange := nil;
  FDataLink.OnUpdateData := nil;
  FDataLink.Free;
  for index := tsRound to tsDiamond do //-1 as I dont want diamond yet as not in res file
    TBitmap(FTableImages[index]).Free; //** Yes Ok Ive freed the bitmaps!
  inherited;
end;

procedure TseatPlan.EditingChange(Sender : TObject);
begin
  if FDatalink.DataSource.State in [dsBrowse] then
  begin
    SaveSeatPosition;
    if Assigned(FSeatPosDS) then
    begin
      TdataSource(FSeatPosDS).DataSet.Close;
      TdataSource(FSeatPosDS).DataSet.Open;

    end;
  end;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.InitPaths;
var
  PathLine : TPathLine;
  dPathLine : TDiamondPathLine;
  index : Integer;
begin
  for index := FSeats.Count-1 downto 0 do
    RemoveSeat(TSeat(FSeats.Items[index]));

  for index := FPathLines.Count -1 downto 0 do
  begin
    PathLine := TPathLine(FPathLines.Items[index]);
    PathLine.Parent := nil;
    FPathLines.Remove(PathLine);
    PathLine.Free;
  end;

  //** Slight change to the prototype circular table will not have a path as it
  //** will bedragging and dropping on the main seatplan canvas directly.
  if FTableShape = tsSquare then
  begin
    PathLine := TPathLine.Create(Self);
    PathLine.Name := 'PathLine1';
    PathLine.PArent := self;
    PathLine.LineType := ltHorizontal;
    PathLine.Pattern := asLeftToRight;
    PathLine.colour := clWhite;
    PathLine.Width := FTblImgWidth;
    PathLine.Height := PathLine.SeatHeight + 2*LineWidth ;
    PathLine.Top := FTblImgTop - PathLine.Height - FImgOffSet;
    PathLine.Left := FTblImgLeft;
    PathLine.Tag := 1;

    FPathLines.Add(PathLine);
    PathLine := TPathLine.Create(Self);
    PathLine.Name := 'PathLine2';
    PathLine.PArent := self;
    PathLine.LineType := ltVertical;
    PathLine.Pattern := asTopToBottom;
    PathLine.colour := clYellow;
    PathLine.Top := FTblImgTop;
    PathLine.Width := PathLine.SeatHeight + 2*LineWidth ;
    PathLine.Height := FTblImgHeight;
    PathLine.Left := FTblImgLeft + FTblImgWidth + FImgOffSet ;
    PathLine.Tag := 2;
    FPathLines.Add(PathLine);

    PathLine := TPathLine.Create(Self);
    PathLine.Name := 'PathLine3';
    PathLine.PArent := self;
    PathLine.colour := clLime;
    PathLine.LineType := ltHorizontal;
    PathLine.Pattern := asRightToLeft;
    PathLine.Top := FTblImgTop + FTblImgHeight + FImgOffSet;
    PathLine.Left := FTblImgLeft;
    PathLine.Width := FTblImgWidth;
    PathLine.Height := PathLine.SeatHeight + 2*LineWidth ;
    PathLine.Tag := 3;
    FPathLines.Add(PathLine);

    PathLine := TPathLine.Create(Self);
    PathLine.Name := 'PathLine4';
    PathLine.PArent := self;
    PathLine.LineType := ltVertical;
    PathLine.Pattern := asBottomToTop;
    PathLine.colour := clBlue;
    PathLine.Width := PathLine.SeatHeight + 2*LineWidth ;
    PathLine.Height := FTblImgHeight;
    PathLine.Top := FTblImgTop;
    PathLine.Left := FTblImgLeft - FImgOffSet - PathLine.Width;
    PathLine.Tag := 4;
    FPathLines.Add(PathLine);
  end
  else if FTableShape = tsDiamond then
  begin
    dPathLine := TDiamondPathLine.Create(Self);
    dPathLine.Name := 'dPathLine1';
    dPathLine.PArent := self;
    dPathLine.LineType := ltDiagonalAsc;
    dPathLine.Pattern := asLeftToRight;
    dPathLine.colour := clWhite;
    dPathLine.Top := 0 ;
    dPathLine.Left := 0 ;
    dPathLine.Width := 160 ;
    dPathLine.Height := 168;
    dPathLine.FImgTop := FTblImgTop;
    dPathLine.FImgLeft := FTblImgleft;
    dPathLine.FImgRight := FTblImgleft + FTblImgWidth;
    dPathLine.FImgBottom := FTblImgTop + FTblImgHeight;
    dPAthLine.MakeRegion;
    dPathLine.Tag := 1;
    FPathLines.Add(dPathLine);


    dPathLine := TDiamondPathLine.Create(Self);
    dPathLine.Name := 'dPathLine2';
    dPathLine.PArent := self;
    dPathLine.LineType := ltDiagonalDesc;
    dPathLine.Pattern := asLeftToRight;
    dPathLine.colour := clYellow;
    dPathLine.Top := 0 ;
    dPathLine.Left := Centre.X ;
    dPathLine.Width := 160 ;
    dPathLine.Height := 168;
    dPathLine.FImgTop := FTblImgTop;
    dPathLine.FImgLeft := FTblImgleft;
    dPathLine.FImgRight := FTblImgWidth div 2 ;
    dPathLine.FImgBottom := FTblImgHeight div 2;
    dPAthLine.MakeRegion;
    dPathLine.Tag := 2;
    FPathLines.Add(dPathLine);

    dPathLine := TDiamondPathLine.Create(Self);
    dPathLine.Name := 'dPathLine3';
    dPathLine.PArent := self;
    dPathLine.LineType := ltDiagonalDesc;
    dPathLine.Pattern := asRightToLeft;
    dPathLine.colour := clLime;
    dPathLine.Top := Centre.Y;
    dPathLine.Left := Centre.X ;
    dPathLine.Width := 160 ;
    dPathLine.Height := 168;
    dPathLine.FImgTop := FTblImgTop;
    dPathLine.FImgLeft := FTblImgleft;
    dPathLine.FImgRight := FTblImgWidth div 2 ;
    dPathLine.FImgBottom := FTblImgHeight div 2;
    dPAthLine.MakeRegion;
    dPathLine.Tag := 3;
    FPathLines.Add(dPathLine);

    dPathLine := TDiamondPathLine.Create(Self);
    dPathLine.Name := 'dPathLine4';
    dPathLine.PArent := self;
    dPathLine.LineType := ltDiagonalAsc;
    dPathLine.Pattern := asRightToLeft;
    dPathLine.colour := clBlue;
    dPathLine.Top := Centre.Y;
    dPathLine.Left := 0;
    dPathLine.Width := 160 ;
    dPathLine.Height := 168;
    dPathLine.FImgTop := FTblImgTop;
    dPathLine.FImgLeft := FTblImgleft;
    dPathLine.FImgRight := FTblImgWidth div 2 ;
    dPathLine.FImgBottom := FTblImgHeight div 2;
    dPAthLine.MakeRegion;
    dPathLine.Tag := 4;
    FPathLines.Add(dPathLine);


{
    dPathLine := TDiamondPathLine.Create(Self, clYellow);
    dPathLine.Name := 'dPathLine2';
    dPathLine.PArent := self;
    dPathLine.LineType := ltDiagonalaSC;
    dPathLine.Pattern := asLeftToRight;
    dPathLine.colour := clYellow;
    dPathLine.Width := FTblImgWidth;
    dPathLine.Height := FTblImgHeight ;
    dPathLine.Top := Centre.Y - (FTblImgHeight div 2) - 48;
    dPathLine.Left := Centre.X;
    dPathLine.Tag := 2;

    dPathLine := TDiamondPathLine.Create(Self, clLime);
    dPathLine.Name := 'dPathLine3';
    dPathLine.PArent := self;
    dPathLine.LineType := ltDiagonalAsc;
    dPathLine.Pattern := asRightToLeft;
    dPathLine.colour := clYellow;
    dPathLine.Width := FTblImgWidth;
    dPathLine.Height := FTblImgHeight ;
    dPathLine.Top := Centre.Y;
    dPathLine.Left := Centre.X + (FTblImgWidth div 2) + 48 ;
    dPathLine.Tag := 3;

    dPathLine := TDiamondPathLine.Create(Self, clBlue);
    dPathLine.Name := 'dPathLine4';
    dPathLine.PArent := self;
    dPathLine.LineType := ltDiagonalDesc;
    dPathLine.Pattern := asLeftToRight;
    dPathLine.colour := clYellow;
    dPathLine.Width := FTblImgWidth;
    dPathLine.Height := FTblImgHeight ;
    dPathLine.Top := Centre.Y;
    dPathLine.Left := Centre.X - (FTblImgWidth div 2) - 48 ;
    dPathLine.Tag := 4;
}
  end
  else
  begin
    for index := FPathLines.Count -1 downto 0 do
    begin
      PathLine := TPathLine(FPathLines.Items[index]);
      PathLine.Parent := nil;
      FPathLines.Remove(PathLine);
      PathLine.Free;
    end;
  end;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.InitDragHAndles;
begin
  DragHandles[1] := TDragHandle.Create(Self);
  DragHandles[1].name := 'DragHandle1';
  DragHandles[1].Parent := self;
  DragHandles[1].DragHandleType := dhtTop;
  DragHandles[1].OnResize := ReSizeBy;

  DragHandles[2] := TDragHandle.Create(Self);
  DragHandles[2].name := 'DragHandle2';
  DragHandles[2].Parent := self;
  DragHandles[2].DragHandleType := dhtRight;
  DragHandles[2].OnResize := ReSizeBy;

  DragHandles[3] := TDragHandle.Create(Self);
  DragHandles[3].name := 'DragHandle3';
  DragHandles[3].Parent := self;
  DragHandles[3].DragHandleType := dhtBottom;
  DragHandles[3].OnResize := ReSizeBy;

  DragHandles[4] := TDragHandle.Create(Self);
  DragHandles[4].name := 'DragHandle4';
  DragHandles[4].Parent := self;
  DragHandles[4].DragHandleType := dhtLeft;
  DragHandles[4].OnResize := ReSizeBy;
  AlignDragHandles;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.AlignDragHandles;
begin
  DragHandles[1].Top := FTblImgTop - 3;
  DragHandles[1].Left := FTblImgLeft + (FTblImgWidth div 2);
  DragHandles[2].Top := FTblImgTop + (FTblImgHeight div 2);
  DragHandles[2].Left := FTblImgLeft + FTblImgWidth - 3;
  DragHandles[3].Top := FTblImgTop + FTblImgHeight - 3;
  DragHandles[3].Left := FTblImgLeft + (FTblImgWidth div 2);
  DragHandles[4].Top := FTblImgTop + (FTblImgHeight div 2);
  DragHandles[4].Left := FTblImgLeft - 3;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.RemoveSeatDS(Path : Integer);
var
  NumSeats : Integer;
begin
  if ValidDataSet then
  begin
    if not FLoading then
    begin
      with FDatalink.DataSource.DataSet as TDataSet do
      begin
        NumSeats := FieldByName('NumSeats' + IntToStr(Path)).AsInteger;
        UpdateDataSet('NumSeats' + IntToStr(Path), NumSeats-1);
        UpdateDataSet('HasSeatPlan', (FSeats.Count > 0) );
      end;
    end;
    ResetRotation
  end;
end;


//------------------------------------------------------------------------------
procedure TSeatPlan.RemoveSeat(Seat : TSeat);
begin
  FSeats.Remove(Seat);
  RemoveSeatDS(TGraphicControl(Seat.Parent).Tag);
  TWinControl(Seat.Parent).RemoveComponent(TComponent(Seat));
  Seat.Parent := nil;
  UpdateSeatNumbers;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.DoDragDrop(Sender,Source: TObject; X, Y: Integer);
var
  OldPath : TPathLine;
begin
  if TableShape = tsRound then
    RemoveSeat(FSeats.Last)
  else
  begin
    OldPath := TPathLine(TGraphicControl(Source).Parent);
    RemoveSeat(TSeat(Source));
    OldPath.AlignPathSeats;
  end;
end;

procedure TSeatPlan.DoDragOver(Sender,Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if Source is TSeat then
  begin
    Accept := True;
  end;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.UpdateSeatNumbers;
var
  index, SeatIdx : Integer;
  SeatNo : Integer;
  Seat : TSeat;
begin
  SeatNo := 1;
  case TableShape of
    tsSquare, tsDiamond  :
    begin
      for index := 0 to FPathLines.Count -1 do
      begin
        if TPathLine(FPathLines[index]).Pattern in [asLeftToRight, asTopToBottom] then
        begin
          for SeatIdx := 0 to TPathLine(FPathLines[index]).ComponentCount -1 do
          begin
            Seat := TSeat(TPathLine(FPathLines[index]).Components[Seatidx]);
            Seat.SeatNo := SeatNo;
            FSeats.Move(FSeats.indexof(Seat),Seat.SeatNo-1);
            Seat.SeatNo := FSeats.Indexof(Seat)+1;
            Seat.Invalidate;
            Inc(SeatNo);
          end;
        end
        else
        begin
          for SeatIdx := TPathLine(FPathLines[index]).ComponentCount -1 downto 0 do
          begin
            Seat := TSeat(TPathLine(FPathLines[index]).Components[Seatidx]);
            Seat.SeatNo := SeatNo;
            FSeats.Move(FSeats.indexof(Seat),Seat.SeatNo-1);
            Seat.SeatNo := FSeats.Indexof(Seat)+1;
            Seat.Invalidate;
            Inc(SeatNo);
          end;
        end;
        TPathLine(FPathLines[index]).AlignPathSeats;
        TPathLine(FPathLines[index]).Invalidate;
      end;
    end; //case
    tsRound : AlignRoundTableSeats;
  end; //case
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.Paint;
var
  hdc : THandle;
  ImgWidth, ImgHeight : Integer;
  left, Top : Integer;
begin
  inherited;
  AlignDragHandles;
  Canvas.Brush.Color := clBlack;
  Canvas.Rectangle(0,0,Width,Height);
  hdc := FTableImages[FTableShape].Canvas.Handle;
  ImgWidth := FTableImages[FTableShape].Width;
  ImgHeight := FTableImages[FTableShape].Height;
//** Center the table in the middle of the seat plan
//** Then move any paths appropriately
  Left := (Width div 2) - (FTblImgWidth div 2);
  Top := (Height div 2) - (FTblImgHeight div 2);
  stretchblt(Canvas.Handle,Left,Top, FTblImgWidth, FTblImgHeight, hdc, 0, 0, ImgWidth,ImgHeight , SRCCOPY);
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.ReSizeBy(X, Y: Integer);
begin
  TableWidth := FTblImgWidth + X;
  TableHeight := FTblImgHeight + y;
  if TableShape = tsRound then
    AlignRoundTableSeats
  else
    AlignDragHandles;
  Invalidate;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.SetTableHeight(TblHeight : Integer);
var
  PLine : TPathLine;
  dPathLine : TDiamondPathLine;
begin
  if TblHeight > FTblImgMaxSize then
    FTblImgHeight := FTblImgMaxSize
  else if TblHeight < FTblImgMinSize then
    FTblImgHeight := FTblImgMinSize
  else
    FTblImgHeight := TblHeight;

  if not FLoading then
    UpdateDataSet('VertSize',RelativeHeight);
  FTblImgTop := Centre.Y - FTblImgHeight div 2;
  case FTableShape of
    tsSquare :
               begin
                 PLine := TPathLIne(FindChildControl('PathLine1'));
                 if Pline <> nil then
                 begin
                   PLine.Top := FTblImgTop - PLine.Height - FImgOffSet;
                   PLine.AlignPathSeats;
                 end;
                 PLine := TPathLIne(FindChildControl('PathLine2'));
                 if Pline <> nil then
                 begin
                   Pline.Top := FTblImgTop;
                   Pline.Height := FTblImgHeight;
                   PLine.AlignPathSeats;
                 end;
                 PLine := TPathLIne(FindChildControl('PathLine3'));
                 if Pline <> nil then
                 begin
                   Pline.Top := FTblImgTop + FTblImgHeight + FImgOffSet;
                   PLine.AlignPathSeats;
                 end;
                 PLine := TPathLIne(FindChildControl('PathLine4'));
                 if Pline <> nil then
                 begin
                   Pline.Top := FTblImgTop;
                   Pline.Height := FTblImgHeight;
                   PLine.AlignPathSeats;
                 end;
               end;

    tsDiamond : begin
                  dPathLine := TDiamondPathLIne(FindChildControl('dPathLine1'));
                  dPathLine.FImgTop := FTblImgTop;
                  dPathLine.FImgLeft := FTblImgleft;
                  dPathLine.FImgRight := FTblImgleft + FTblImgWidth;
                  dPathLine.FImgBottom := FTblImgTop + FTblImgHeight;
                  dPAthLine.MakeRegion;
                  dPAthLine.AlignPathSeats;


                  dPathLine := TDiamondPathLIne(FindChildControl('dPathLine2'));
                  dPathLine.FImgTop := FTblImgTop;
                  dPathLine.FImgLeft := FTblImgleft;
                  dPathLine.FImgRight := FTblImgWidth div 2 ;
                  dPathLine.FImgBottom := FTblImgHeight div 2;
                  dPAthLine.MakeRegion;
                  dPAthLine.AlignPathSeats;

                  dPathLine := TDiamondPathLIne(FindChildControl('dPathLine3'));
                  dPathLine.FImgTop := FTblImgTop;
                  dPathLine.FImgLeft := FTblImgleft;
                  dPathLine.FImgRight := FTblImgWidth div 2 ;
                  dPathLine.FImgBottom := FTblImgHeight div 2;
                  dPAthLine.MakeRegion;
                  dPAthLine.AlignPathSeats;

                  dPathLine := TDiamondPathLIne(FindChildControl('dPathLine4'));
                  dPathLine.FImgTop := FTblImgTop;
                  dPathLine.FImgLeft := FTblImgleft;
                  dPathLine.FImgRight := FTblImgWidth div 2 ;
                  dPathLine.FImgBottom := FTblImgHeight div 2;
                  dPAthLine.MakeRegion;
                  dPAthLine.AlignPathSeats;
                end;

  end;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.ClearAllSeats;
var
  index : Integer;
begin
  for index := FSeats.Count -1 downto 0 do
  begin
    RemoveSeat(TSeat(FSeats.Items[Index]));
  end;


end;

//------------------------------------------------------------------------------
procedure TSeatPlan.SetTableShape(TblShape: Integer);
begin

  if FTableShape <> TblShape then
  begin
    FTableShape := TblShape;
    //Essentiallyresetting;
    if not FLoading then
      UpdateDataSet('BackDrop', DBShape[TableShape]);
    InitPaths;
  end;
  Invalidate;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.SetTableWidth(TblWidth : Integer);
var
  PLine : TPathLine;
  dPathLine : TDiamondPathLine;
begin
  if TblWidth > FTblImgMaxSize then
    FTblImgWidth := FTblImgMaxSize
  else if TblWidth < FTblImgMinSize then
    FTblImgWidth := FTblImgMinSize
  else
    FTblImgWidth := TblWidth;

  if not FLoading then
    UpdateDataSet('HorizSize',RelativeWidth);

  FTblImgLeft := Centre.X - FTblImgWidth div 2;
  case FTableShape of
    tsSquare:
               begin
                 PLine := TPathLIne(FindChildControl('PathLine1'));
                 if Pline <> nil then
                 begin
                   PLine.Left := FtblImgLeft;
                   PLine.Width := FtblImgWidth;
                   PLine.AlignPathSeats;
                 end;
                 PLine := TPathLIne(FindChildControl('PathLine2'));
                 if Pline <> nil then
                 begin
                   Pline.Left := FTblImgLeft + FTblImgWidth + FImgOffSet;
                   PLine.AlignPathSeats;
                 end;
                 PLine := TPathLIne(FindChildControl('PathLine3'));
                 if Pline <> nil then
                 begin
                   PLine.Width := FTblImgWidth ;
                   PLine.Left  := FTblImgLeft ;
//                   Pline.Top := FTblImgTop + FTblImgHeight + FImgOffSet;
                   PLine.AlignPathSeats;
                 end;
                 PLine := TPathLIne(FindChildControl('PathLine4'));
                 if Pline <> nil then
                 begin
                   Pline.Left := FTblImgLeft - FImgOffSet - PLine.Width;
                   PLine.AlignPathSeats;
                 end;
               end;
    tsDiamond : begin
                  dPathLine := TDiamondPathLIne(FindChildControl('dPathLine1'));
                  dPathLine.FImgTop := FTblImgTop;
                  dPathLine.FImgLeft := FTblImgleft;
                  dPathLine.FImgRight := FTblImgleft + FTblImgWidth;
                  dPathLine.FImgBottom := FTblImgTop + FTblImgHeight;
                  dPAthLine.MakeRegion;
                  dPAthLine.AlignPathSeats;

                  dPathLine := TDiamondPathLIne(FindChildControl('dPathLine2'));
                  dPathLine.FImgTop := FTblImgTop;
                  dPathLine.FImgLeft := FTblImgleft;
                  dPathLine.FImgRight := FTblImgWidth div 2 ;
                  dPathLine.FImgBottom := FTblImgHeight div 2;
                  dPAthLine.MakeRegion;
                  dPAthLine.AlignPathSeats;

                  dPathLine := TDiamondPathLIne(FindChildControl('dPathLine3'));
                  dPathLine.FImgTop := FTblImgTop;
                  dPathLine.FImgLeft := FTblImgleft;
                  dPathLine.FImgRight := FTblImgWidth div 2 ;
                  dPathLine.FImgBottom := FTblImgHeight div 2;
                  dPAthLine.MakeRegion;
                  dPAthLine.AlignPathSeats;

                  dPathLine := TDiamondPathLIne(FindChildControl('dPathLine4'));
                  dPathLine.FImgTop := FTblImgTop;
                  dPathLine.FImgLeft := FTblImgleft;
                  dPathLine.FImgRight := FTblImgWidth div 2 ;
                  dPathLine.FImgBottom := FTblImgHeight div 2;
                  dPAthLine.MakeRegion;
                  dPAthLine.AlignPathSeats;
                end;

  end;
end;
//------------------------------------------------------------------------------
function TSeatPlan.GetSeat(Index: Integer): TSeat;
begin
  Result := TSeat(FSeats.Items[index]);
end;

//------------------------------------------------------------------------------
function TSeatPlan.GetSeatCount: Integer;
begin
  Result := FSeats.Count;
end;

//------------------------------------------------------------------------------
function TSeatPlan.NextPath: TWinControl;
var
  PathLine : Integer;
begin
  if (FSeats.Count mod FPathLines.Count) = 0 then
    PathLine := 0
  else
  begin
    PathLine :=  (FSeats.Count mod FPathLines.Count);
  end;
  Result := FPathLines.Items[PathLine];
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.AddSeat;
var
  NewSeat : TSeat;
begin
  if tableShape = tsRound then
  begin
    NewSeat := TSeat.Create(Self);
    NewSeat.Parent := TWinControl(Self);
    AddSeat(NewSeat,1);
  end
  else
    TPAthLine(NextPAth).AddSeat;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.UpdateDataSet(NewFieldName : string; Value : variant);
var
  index : Integer;
begin
  if (FDataLink <> nil) and (FDataLink.DataSet <> nil) then
  begin
    FDataLink.ondatachange := nil;
    FDataLink.DataSet.Edit;
    gTextColour := clSilver; //just a nicety show the user we are editing
    //** I wanted to put this colour cahnge on the OnEditingChange event of the
    //** datalink but it wasnt getting called.
    for index := 0 to FSeats.Count -1 do
      TSeat(FSeats.Items[index]).Invalidate;
    FDataLink.DataSet.FieldByName(NewFieldName).Value := Value;
    FDataLink.ondatachange := DataChange;
  end;
end;

//------------------------------------------------------------------------------
function TSeatPlan.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TSeatPlan.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;



//------------------------------------------------------------------------------
function TSeatPlan.ValidDataSet : Boolean;
begin
  Result := False;
  if FDatalink.DataSet <> nil then
  begin
    with FDatalink.DataSet do
    begin
      Result := (FDatalink.DataSet.Active) and (FDatalink.RecordCount > 0) ;
    end;
  end;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.AddSeatDS(Path : Integer);
var
  NumSeats : Integer;
begin
  if not FLoading then
  begin
    if ValidDataSet then
    begin
      with FDatalink.DataSource.DataSet as TDataSet do
      begin
        NumSeats := FieldByName('NumSeats' + IntToStr(Path)).AsInteger;
        UpdateDataSet('NumSeats' + IntToStr(Path), NumSeats+1);
        UpdateDataSet('HasSeatPlan', True );

      end;
    end;
  end;
end;


//------------------------------------------------------------------------------
procedure TSeatPlan.AddSeat(Seat: TSeat; Path : Integer);
begin
  Seat.Tag := FSeats.Count;
  Fseats.Add(Seat);
  ResetRotation;
  UpdateSeatNumbers;
  AddSeatDS(Path);
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.Rotate(CLockwise : Boolean);
var
  index : Integer;
begin
  begin
    if FSeats.Count > 1 then
    begin
      if Clockwise then
      begin
        FSeats.move(FSeats.indexof(FSeats.First),FSeats.Count-1);
        FRotation := FRotation + 1;
        if FRotation = FSeats.Count then
          FRotation := 0;
      end
      else
      begin
        FSeats.move(FSeats.indexof(FSeats.last),0);
        FRotation := FRotation - 1;
        if FRotation = -1 then
          FRotation := Fseats.Count -1;
      end;
      for index := 0 to Fseats.Count-1 do
      begin
        TSeat(FSeats.Items[Index]).SeatNo := index+1;
        TSeat(FSeats.Items[Index]).Invalidate;
      end;
    end;
  end;
  if not FLoading then
    UpdateDataSet('SeatRotation', FRotation);
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.AlignRoundTableSeats;
var
  index : Integer;
  stPoint : TPoint;
  SeatWidth, SeatHeight : Integer;

  function get_circle_peri_point2(Degrees : single) : TPoint;
  var
    YR, XR : single; //Radious;
    Rads : Single;
  begin
    //** X = R Cos T  + Centre X -- where t = Angle in Radians
    //** Y = R Sin T  + Centre Y -- where t = Angle in Radians
    Rads := (pi / 180) * Degrees;
    if FStandardStartPoint then
      Rads := rads - NinetyDegreesInRad;
    XR := (FTblImgWidth/2)+30;
    YR := (FTblImgHeight/2)+30;
    result.X := Round(XR * (Cos(Rads)) );
    result.Y := Round(YR * (Sin(Rads)) );
  end;

  function get_circle_peri_point(xrad, yrad, range: double): TPoint;
  begin
    result.y := round(-cos(range * pi * 2) * yrad);
    result.x := round(sin(range * pi * 2) * xrad);
  end;

begin
  SeatWidth := 48;
  SeatHeight := 48;
  FImgRoundOffSet := 0.7;

  for index := 0 to FSeats.Count -1 do
  begin
    stpoint := get_circle_peri_point2((360/FSeats.Count) * index);
    TSeat(FSeats.Items[index]).Top :=  Centre.Y + stPoint.Y- (SeatHeight div 2);
    TSeat(FSeats.Items[index]).Left := Centre.X + stPoint.X - (SeatWidth div 2);
    TSeat(FSeats.Items[index]).SeatNo := Index+1;
  end;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  Centre.X := AWidth div 2;
  Centre.Y := AHeight div 2;
  inherited;
end;

//------------------------------------------------------------------------------
function TSeatPlan.GetAbsoulteHeight: single;
begin
  if Height = 0 then
    Result := 0
  else
    Result := FTblImgHeight/Height;
end;

//------------------------------------------------------------------------------
function TSeatPlan.GetAbsoulteWidth: single;
begin
  if Width = 0 then
    Result := 0
  else
    Result := FTblImgWidth/Width;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.SetDatasource(const Value: TDatasource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

//------------------------------------------------------------------------------
function TSeatPlan.GetDatasource: TDataSource;
begin
  if not assigned(FDataLink) then
    result := nil
  else
    result := FDataLink.DataSource;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.DataChange(sender: TObject);
begin
  Load;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.Load;
var
  index, j  : Integer;
  clockWise : Boolean;
begin
  FLoading := True;
  ClearAllSeats;
  FRotation := 0;
  gTextColour := clWhite;
  if (FDatalink.DataSource <> nil)  and (FDatalink.DataSource.DataSet <> nil) then
  begin
    with FDatalink.DataSource.DataSet do
    begin
      if (Active) and (RecordCount > 0) then
      begin
        FSiteCode := FieldByName('SiteCode').AsInteger;
        FTableNumber := FieldByName('TableNumber').AsInteger;
        TableWidth := Round (FieldByName('HorizSize').AsFloat * Width);
        TableHeight := Round (FieldByName('VertSize').AsFloat * Height);
        if FieldByName('BackDrop').AsInteger = DBShape[tsRound] then
        begin
          TableShape := tsRound;
          for index := 1 to FieldByName('NumSeats1').AsInteger do
          begin
            AddSeat;
          end;
        end
        else if FieldByName('BackDrop').AsInteger = DBShape[tsSquare] then
        begin
          TableShape := tsSquare;
          for index := 0 to 3 do
          begin
            for j := 1 to FieldByName('NumSeats' + IntToStr(Index+1)).AsInteger do
            begin
              TPathLine(FPathLines.Items[index]).AddSeat;
            end;
          end;
        end
        else if FieldByName('BackDrop').AsInteger in [DBShape[tsDiamond]] then
        begin
          TableShape := tsDiamond;
          for index := 0 to 3 do
          begin
            for j := 1 to FieldByName('NumSeats' + IntToStr(Index+1)).AsInteger do
            begin
              TPathLine(FPathLines.Items[index]).AddSeat;
            end;
          end;
        end

        else
          Exit;

        ClockWise :=  FieldByName('ClockWise').AsBoolean;
        for index := 0 to FieldByName('SeatRotation').AsInteger -1 do
        begin
          Rotate(ClockWise);
        end;
      end;
    end; //with
  end;
  Invalidate;
  FLoading := False;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.New(Site : Integer; TableNo : Integer);
begin
  TableNumber := TableNO;
  SiteCode := Site;
  if (Datasource <> nil) and (Datasource.DataSet <> nil) then
  begin
    With Datasource.DataSet do
    begin
      //**[SiteCode,TableNumber, BackDrop, HAsSeatPlan, HorizSize, vertSize, NumSeats, NumSeats2
      //** NumSeats3, NuMSeats4, SeatRotation, ClockWise, CircleOffset]
      InsertRecord([SiteCode,TableNumber,dbShape[tsRound],'False',0.2,0.2,0,0,0,0,1,'True',0]);
    end;
  end;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.Save;
begin
  if (ValidDataSet) and (FDatalink.DataSource.State in [dsEdit,dsInsert]) then
    FDatalink.DataSet.Post;
  SaveSeatPosition;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.SetRotation(value: Integer);
var
  index : Integer;
  ClockWise : Boolean;
begin
  Clockwise := (FRotation < Value);
  for index := 0 to Abs(FRotation-Value) do
  if FRotation <> Value then
  begin
    Rotate(ClockWise);
  end;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.UpdateData(Sender : TObject);
begin
  FDataLink.Field.Text := '1';
end;

//------------------------------------------------------------------------------
function TSeatPlan.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.SetReadOnly(const Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.SPKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = '-') and (FSeats.Count > 0) then
    RemoveSeat(FSeats.Last)
  else if key = '+' then
    AddSeat
  else if key = #13 then
    Save
  else if key = '6' then
    Rotate(True)
  else if Key = '4' then
    Rotate(False)
  else if Key = #27 then
    FDatalink.DataSet.Cancel
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.Click;
begin
  inherited;
  SetFocus;
end;

{ TSeat }

//------------------------------------------------------------------------------
constructor TSeat.Create(AOwner: TComponent);
var
  refpalette: PMaxLogPalette;
  rasterline: PByteArray;
  i,j : Integer;
begin
  inherited;
  FSeatImage := TBitmap.Create;
  FSeatImage.LoadFromResourceName(HInstance, 'AZTEC_SEAT');
  Width := FSeatImage.Width;
  Height := FSeatImage.Height;
  FSeatMask := TBitMap.Create;
  FSeatMask.Width := FseatImage.Width;
  Fseatmask.Height := FseatImage.Height;
  OnDragOver := relayDragOver;
  OnDragDrop := RelayDragDrop;
  OnDblClick := RelayDblClick;
  OnMouseDown := DoMouseDown;
  with Fseatmask do
  begin
    monochrome := true;
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
    if Palette <> 0 then DeleteObject(Palette);
    Palette := createpalette(plogpalette(refpalette)^);
    dispose(refpalette);
  end;
  for j := 0 to pred(Fseatmask.height) do
  begin
    rasterline := Fseatmask.scanline[j];
    for i := 0 to pred(Fseatmask.Width) do
    begin
      if FSeatImage.Canvas.Pixels[i,j] = 0 then
        rasterline[i div 8] := rasterline[i div 8] or (128 shr (i mod 8))
      else
        rasterline[i div 8] := rasterline[i div 8] and not(128 shr (i mod 8));
    end;
  end;

//  DragMode := dmAutomatic;
end;


//------------------------------------------------------------------------------
destructor TSeat.Destroy;
begin
  FSeatImage.Free;
  FSeatMask.Free;
  inherited;
end;

//------------------------------------------------------------------------------
procedure TSeat.DoClick(Sender: TObject);
begin
end;

//------------------------------------------------------------------------------
procedure TSeat.DoDblClick(Sender: TObject);
begin

end;

//------------------------------------------------------------------------------
function TSeat.GetAbsoluteLeft: Single;
var
  absLeft : Integer;
  multiplier : single;
begin
//** 0 = -1 || max width = 1
//** soooo  2/width will give us our multiplier We start at -1 so we have to offset this
//** multiplication by -1
  multiplier := 2/320;
  if Parent is TSeatPlan then
    AbsLeft := Left + (FSeatImage.Width div 2)
//    AbsLeft := Parent.Left + Left + (FSeatImage.Width div 2)
  else
    AbsLeft := Parent.Left + Left + (FSeatImage.Width div 2);
//    AbsLeft := Parent.Left + Parent.Parent.Left + Left + (FSeatImage.Width div 2);

  Result := (AbsLeft * multiplier) - 1;
end;

//------------------------------------------------------------------------------
function TSeat.GetAbsoluteTop: Single;
var
  absTop : Integer;
  multiplier : single;
begin
//** 0 = -1 || max width = 1
//** soooo  2/width will give us our multiplier We start at -1 so we have to offset this
//** multiplication by -1

  multiplier := 2/336;
  if Parent is TSeatPlan then
    AbsTop :=  Top + (FSeatImage.Height div 2)
//    AbsTop := Parent.Top + Top + (FSeatImage.Height div 2)
  else
    AbsTop := Parent.Top + Top +  (FSeatImage.Height div 2);
//    AbsTop := Parent.Top + Parent.Parent.Top + Top +  (FSeatImage.Height div 2);

  Result := (AbsTop * multiplier) - 1;
end;

procedure TSeat.Paint;
begin
  inherited;
  Windows.bitblt(canvas.Handle,0,0, Width, Height, Fseatmask.Canvas.Handle, 0, 0, SRCAND);
  Windows.bitblt(canvas.Handle,0,0, Width, Height, FseatImage.Canvas.Handle, 0, 0, SRCPAINT);
  Canvas.Font.Name := 'Arial';
  canvas.Font.Size := 16;
  Canvas.Font.Color := gTextColour;
  canvas.brush.color := clRed;
  canvas.pen.color := clGreen;
  Canvas.Brush.Style := bsClear;
  canvas.pen.style := psClear;
  Canvas.TextOut(18 ,12,IntToStr(SeatNo));
end;

{ TPathLine }

//------------------------------------------------------------------------------
procedure TPathLine.AddSeat;
var
  Seat : TSeat;
begin
  Seat := TSeat.Create(TComponent(Self));
  Seat.Top := LineWidth;
  Seat.Left := LineWidth;
  TSeatPlan(Parent).AddSeat(Seat, Tag); {This Function will set the Component name & Tag}
  Seat.Parent := TWinControl(Self);
  AlignPathSeats;
end;

//------------------------------------------------------------------------------
constructor TPathLine.Create(AOwner: TComponent);
begin
  inherited;
  LineType := ltHorizontal;
  Pattern := asLeftToRight;
  OnDragDrop := DoDragDrop;
  OnDragOver := DoDragOver;
  OnDblClick := DoDblClick;
  OnClick := DoClick;
  SeatWidth := 48;
  SeatHeight := 48;
end;

//------------------------------------------------------------------------------
procedure TPathLine.Paint;
begin
  inherited;
  Canvas.pen.style := psSolid;
  Canvas.Pen.Color := Colour;
  CAnvas.Pen.Width := LineWidth;
  Canvas.Brush.Color := clBlack;
  case LineType of
    ltHorizontal,ltVertical : CAnvas.Rectangle(0, 0, Width, Height);
  end;
end;

//------------------------------------------------------------------------------
procedure TPathLine.DoDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean);
begin
  inherited;
  if Source is TSeat then
  begin
    if TGraphicControl(Source).Parent = Self then
      Accept := False
    else
      Accept := True;
  end
  else
    Accept := False;
end;

//------------------------------------------------------------------------------
procedure TPathLine.DoDragDrop(Sender,Source: TObject; X, Y: Integer);
begin
  inherited;
  TSeatPlan(Parent).RemoveSeatDS(TPathLine(TControl(Source).Parent).Tag);
  TWinControl(TGraphicControl(Source).Parent).RemoveComponent(TComponent(Source));
  TGraphicControl(Source).Parent := Self;
  TWinControl(Self).InsertComponent(TComponent(Source));
  TSeatPlan(Parent).UpdateSeatNumbers;
  TSeatPlan(Parent).AddSeatDS(Tag);
end;

//------------------------------------------------------------------------------
procedure TPathLine.AlignPathSeats;
var
  index : Integer;
  XInc, YInc : Integer;
begin
  if LineType = ltHorizontal then
  begin
    //** Use XCoords
//1    xInc := Width div (ComponentCount + 1);
    xInc := (Width - (ComponentCount * SeatWidth)) div (ComponentCount + 1);

    for index := 0 to ComponentCount -1 do
    begin
//1      TSeat(Components[index]).LEft :=  (xInc*(Index+1)) - (SeatWidth div 2);
      TSeat(Components[index]).LEft :=  (XInc * (index + 1)) + (SeatWidth * Index );
      TSeat(Components[index]).Top :=  Linewidth;
    end;
  end
  else if LineType = ltVertical then
  begin
//1    yInc := Height div (ComponentCount + 1);
    yInc := (Height - (ComponentCount * SeatHeight)) div (ComponentCount + 1);

    for index := 0 to ComponentCount -1 do
    begin
//1      TSeat(Components[index]).Top := (yInc*(Index+1))- (SeatHeight div 2);;
      TSeat(Components[index]).Top :=  (yInc * (index + 1)) + (SeatHeight * Index);
      TSeat(Components[index]).Left :=  LineWidth;
    end;
  end
end;




{ TDragHandle }

constructor TDragHandle.Create(Aowner: TComponent);
begin
  inherited;
  width := 5;
  Height := 5;
end;

//------------------------------------------------------------------------------
procedure TDragHandle.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if Button = mbLeft then
  begin
    Start.X := X;
    Start.Y := Y;
  end;
end;

//------------------------------------------------------------------------------
procedure TDragHandle.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  if Button = mbLeft then
  begin
    if (X <> start.X) or (Y <> Start.Y) then
    begin
      if Assigned(FDoResize) then
      begin
        if name = 'DragHandle1' then
          FDoResize(0,-y)
        else if name = 'DragHandle2' then
          FDoResize(X,0)
        else if name = 'DragHandle3' then
          FDoResize(0,Y)
        else if name = 'DragHandle4' then
          FDoResize(-X,0)
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------
procedure TDragHandle.Paint;
var
 Rect : TRect;
begin
  inherited;
  Rect.Top := 0;
  Rect.Bottom := Height;
  Rect.Left := 0;
  Rect.Right := Width;
  Canvas.Brush.Color := clBtnFace;
  Canvas.FillRect(Rect);
end;

//------------------------------------------------------------------------------
procedure TDragHandle.SetHAndleType(Htype: TDragHandleTYpe);
begin
  if HType in [ dhtTop, dhtBottom ] then
    Cursor := crSizeNS
  else
    Cursor := crSizeWE
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.ResetRotation;
begin
  if not FLoading then
  begin
    FRotation := 0;
    UpdateDataSet('SeatRotation',0);
  end;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.SaveSeatPosition;
var
  Qry : TADOQuery;
  index : Integer;
begin
  Qry := nil;

  if FCancelChanges then
    Exit;

  try
    Qry := TADOQuery.Create(Self);
    Qry.Connection := TADOQuery(FDatalink.DataSet).Connection;
    Qry.SQL.Add(Format(ClearSeatSQl,[AztecTableName,FSiteCode,FTableNumber]));
    Qry.ExecSQL;
    Qry.SQL.Clear;
    Qry.SQL.Add(Format(AddSeatSQL,[AztecTableName]));
    for index := 0 to FSeats.Count -1 do
    begin
      Qry.Parameters.ParamByName('SiteCode').Value := FSiteCode;
      Qry.Parameters.ParamByName('TblNo').Value := FTableNumber;
      Qry.Parameters.ParamByName('SeatNo').Value := TSeat(FSeats.Items[index]).SeatNo;
      Qry.Parameters.ParamByName('X').Value := TSeat(FSeats.Items[index]).RelativeX;
      Qry.Parameters.ParamByName('Y').Value := TSeat(FSeats.Items[index]).RelativeY;
      Qry.ExecSQL;
    end;
  finally
    Qry.Free;
  end;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

{ TCustomSeatControl }

//------------------------------------------------------------------------------
//procedure TCustomSeatControl.DragOver(Source: TObject; X, Y: Integer;
//  State: TDragState; var Accept: Boolean);
//begin
//  inherited; DragOver(Source, X,Y, State, Accept);
//end;

//------------------------------------------------------------------------------
procedure TSeat.RelayDblClick(Sender: TObject);
begin
  if Parent is TSeatPlan then
    TSeatPlan(PArent).doDblClick(Sender)
  else if Parent is TPathLine then
    TPathLine(PArent).doDblClick(Sender);
end;

//------------------------------------------------------------------------------
procedure TSeat.RelayDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if Parent is TSeatPlan then
  begin
    if sender <> Source then
      TSeatPlan(Parent).DoDragDrop(Sender, Source, X,Y)
  end
  else if Parent is TPathLine then
    TPathLine(Parent).DoDragDrop(Sender, Source, X,Y);
end;

//------------------------------------------------------------------------------
procedure TSeat.relayDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  Pos : Tpoint;
begin
  pos.X := x;
  pos.Y := y;
  pos := parent.screentoclient(ClientToScreen(pos));
  if Parent is TSeatPlan then
    TSeatPlan(Parent).DoDragOver(Sender, Source, Pos.X,POs.Y, State, Accept)
  else if Parent is TPathLine then
    TPathLine(Parent).DoDragOver(Sender, Source, Pos.X,POs.Y, State, Accept);
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.DoDblCLick(Sender: TObject);
begin
  AddSeat;
end;

//------------------------------------------------------------------------------
procedure TPathLine.DoDblClick(Sender: TObject);
begin
  AddSeat;
end;

//------------------------------------------------------------------------------
procedure TPathLine.DoClick(Sender: TObject);
begin
end;


//------------------------------------------------------------------------------
procedure TSeat.DoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //** StartDragging manually or else we loose clicks and double clicks.
  TControl(Sender).BeginDrag(False,10);
end;

//------------------------------------------------------------------------------
constructor TShapedPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csClickEvents,
                   csOpaque, csDoubleClicks, csAcceptsControls];
  Width := 200;
  Height := 200;
  RgnBrush := TBrush.Create;
  RgnBrush.Color := clLime; //** This changes the out line colour
//  FFillColor := clBlack;
  IsLoaded := False;
  FBorderWidth := 2;
  FBorderColor := clBlack;
  FRgn := 0;
  FRgn2 := 0;
end;

//------------------------------------------------------------------------------
destructor TShapedPanel.Destroy;
begin
  DeleteObject(FRgn);
  DeleteObject(FRgn2);
  inherited;
end;

procedure TShapedPanel.CreateWnd;
begin
  inherited;
  MakeRegion;
  IsLoaded := True;
  {IsLoaded is to make sure MakeRegion is not called before there is a
  Handle for this control, but it may not be nessary}
end;


procedure TShapedPanel.MakeRegion;
var
  FPoints: array[0..3] of TPoint;
begin
  //**I moved the Region creation to this procedure so it
  //**can be called for WM_SIZE
  SetWindowRgn(Handle, 0, False);
  //**this clears the window region

  if FRgn <> 0 then
  begin
    //**Make sure to Always DeleteObject for a Region
    DeleteObject(FRgn);
    DeleteObject(FRgn2);
    FRgn := 0;
    FRgn2 := 0;
   end;

   if FLineType = ltDiagonalAsc then
   begin
     FPoints[0] := Point(0,Height-48);
     FPoints[1] := Point(Width-48,0);
     FPoints[2] := Point(Width,48);
     FPoints[3] := Point(48,Height);
   end
   else
   begin
     FPoints[0] := Point(0,48);
     FPoints[1] := Point(48,0);
     FPoints[2] := Point(Width, Height-48);
     FPoints[3] := Point(Width-48, Height);
   end;
   FRgn := CreatePolygonRgn(FPoints,4,WINDING);
   SetWindowRGN(Handle, FRgn, True);
   FRgn2 := CreatePolygonRgn(FPoints,4,WINDING);
   //**FRgn2 is used for FrameRgn in Paint
end;


{
procedure TShapedPanel.MakeRegion;
var
  x4, y2: Integer;
  FPoints: array[0..5] of TPoint;
begin
  //** I moved the Region creation to this procedure so it
  //** can be called for WM_SIZE
  SetWindowRgn(Handle, 0, False);
  //**this clears the window region

  if FRgn <> 0 then
  begin
    //** Make sure to Always DeleteObject for a Region
    DeleteObject(FRgn);
    DeleteObject(FRgn2);
    FRgn := 0;
    FRgn2 := 0;
   end;
   x4 := Width div 4;
   y2 := Height div 2;
   FPoints[0] := Point(x4,0);
   FPoints[1] := Point(Width-x4,0);
   FPoints[2] := Point(Width,y2);
   FPoints[3] := Point(Width-x4,Height);
   FPoints[4] := Point(x4,Height);
   FPoints[5] := Point(0,y2);
   FRgn := CreatePolygonRgn(FPoints,6,WINDING);
   SetWindowRGN(Handle, FRgn, True);
   FRgn2 := CreatePolygonRgn(FPoints,6,WINDING);
   //** FRgn2 is used for FrameRgn in Paint

end;
}

procedure TShapedPanel.WMSize(var Message: TMessage);
var
  TmpClr: TColor;
begin
  inherited;
  if IsLoaded then
  begin
    TmpClr := Canvas.Brush.Color;
//    Canvas.Brush.Color := FFillColor;
    Canvas.Brush.Color := clBlack;
    MakeRegion;
    FillRgn(Canvas.Handle, FRgn2, Canvas.Brush.Handle);
    Paint;
    Canvas.Brush.Color := TmpClr;
  end;
end;

procedure TShapedPanel.Paint;
var
  TmpClr: TColor;
begin
  inherited;
  if IsLoaded then
  begin
    TmpClr := Canvas.Brush.Color;
    MakeRegion;
//    Canvas.Brush.Color := FillColor;
    Canvas.Brush.Color := clblack;
    FillRgn(Canvas.Handle, FRgn2, Canvas.Brush.Handle); //**Need to call fill region here!
    FrameRgn(Canvas.Handle, FRgn2, RgnBrush.Handle, FBorderWidth,FBorderWidth);
    Canvas.Brush.Color := TmpClr;
  end;
end;

procedure TShapedPanel.SetBorderColor(Value: TColor);
begin
  if FBorderColor <> Value then
  begin
    FBorderColor := Value;
    RgnBrush.Color := FBorderColor;
    Paint;
  end;
end;

//------------------------------------------------------------------------------
procedure TShapedPanel.SetFillColor(const Value: TColor);
begin
  if FFillColor <> Value then
  begin
    FFillColor := Value;
    Paint;
  end
end;

function TShapedPanel.GetFillColor: TColor;
begin
  Result := FFillColor;
end;


//------------------------------------------------------------------------------
procedure TShapedPanel.SetPattern(Value: Integer);
begin
  FPattern := Value;
  MakeRegion;
end;

//------------------------------------------------------------------------------
procedure TShapedPanel.SetLineType(Value: Integer);
begin
  FLineType := Value;
  MakeRegion;
end;


//------------------------------------------------------------------------------
{ TDiamondPathLine }

constructor TDiamondPathLine.Create(AOwner: TComponent);
begin
  inherited;
  Width := 200;
  Height := 200;
  RgnBrush := TBrush.Create;
  RgnBrush.Color := clWhite; //** This changes the out line colour
  IsLoaded := False;
  FRgn := 0;
  FRgn2 := 0;
end;

procedure TDiamondPathLine.AlignPathSeats;
var
  XInc : single;
  YCoord : Integer;
  index : Integer;
  W : Integer;
begin
  W := FEndPoint.X - FStartPoint.X;
// Original equation
//xInc := (Width - (ComponentCount * SeatWidth)) div (ComponentCount + 1);
  xInc := (W - (ComponentCount * 48)) / (ComponentCount + 1);

  if ((Pattern = asLeftToRight) and (LineType = ltDiagonalAsc)) or
     ((Pattern = asRightToLeft) and (LineType = ltDiagonalDesc))then
  begin
    //** Find the X OffSet as you would do for a straight line using the adjasent
    //** side of the triangle. THen calculate the y using the equation of the line
    //** y = mx
    for index := 0 to ComponentCount -1 do
    begin
      //** THis formula will draw them at the correct angle but I need some sort of
      //** of offset according to the height and Width.
      TSeat(Components[index]).Left := FStartPoint.X + Round((XInc * (index + 1)) + (48 * Index )) + 24  ;
      YCOord := GetLineY((XInc * (index + 1)) + (48 * Index ) + 24) ;
      TSeat(Components[index]).Top := FStartPoint.Y - YCoord;
   end;
  end
  else
  begin
    for index := 0 to ComponentCount -1 do
    begin
      //** THis formula will draw them at the correct angle but I need some sort of
      //** of offset according to the height and Width.
      TSeat(Components[index]).Left := FStartPoint.X + Round((XInc * (index + 1)) + (48 * Index )) + 24 ;
      YCOord := GetLineY((XInc * (index + 1)) + (48 * Index ) + 24) ;
      TSeat(Components[index]).Top := FStartPoint.Y - YCoord;
   end;
  end;
end;

constructor TDiamondPathLine.Create(AOwner: TComponent; Acolour: TColor);
begin
  Create(AOwner);
  Colour := AColour;
end;

//------------------------------------------------------------------------------
procedure TDiamondPathLine.CreateWnd;
begin
  inherited;
  MakeRegion;
  IsLoaded := True;
end;

destructor TDiamondPathLine.Destroy;
begin
  DeleteObject(FRgn);
  DeleteObject(FRgn2);
  inherited;
end;

procedure TDiamondPathLine.MakeRegion;
var
  FPoints: array[0..5] of TPoint;
begin
  //**I moved the Region creation to this procedure so it
  //**can be called for WM_SIZE
  SetWindowRgn(Handle, 0, False);
  //**this clears the window region

  if FRgn <> 0 then
  begin
    //**Make sure to Always DeleteObject for a Region
    DeleteObject(FRgn);
    DeleteObject(FRgn2);
    FRgn := 0;
    FRgn2 := 0;
   end;

   if (pattern = asLeftToRight)  and (LineType = ltDiagonalAsc) then
   begin
     FPoints[0] := Point(Width -10,FImgTop-10);
     Roof := FImgTop-58;
     FPoints[1] := Point(Width - 10, FImgTop-58);
     FEndPoint.X := Width - 58;
     FEndPoint.Y := FImgTop-58;
     FPoints[2] := Point(Width - 58 ,FImgTop-58);
     FstartPoint.X := FImgLeft - 58;
     FstartPoint.Y := Height - 58;
     FPoints[3] := Point(FStartPoint.X ,FStartPoint.Y);
     Floor := FStartPoint.Y;
     FPoints[4] := Point(FImgLeft - 58 ,Height-10);
     FPoints[5] := Point(FImgLeft - 10, Height-10);
   end
   else if (pattern = asLeftToRight) and (LineType = ltDiagonalDesc) then
   begin
     FPoints[0] := Point(10,FImgTop-10);
     FstartPoint.X := 10;
     FstartPoint.Y := FImgTop-58;
     FPoints[1] := Point(FStartPoint.X,FStartPoint.Y);
     FPoints[2] := Point(58,FImgTop-58);
     FEndPoint.X := FImgRight + 10;
     FEndPoint.Y := Height -58;
     FPoints[3] := Point(FImgRight + 58, Height -58);
     FPoints[4] := Point(FImgRight + 58, Height -10);
     FPoints[5] := Point(FImgRight + 10, Height -10);
   end
   else if (pattern = asRightToLeft) and (LineType = ltDiagonalDesc) then
   begin
     FstartPoint.X := 10;
     FstartPoint.Y := FImgBottom + 10;
     FPoints[0] := Point(FstartPoint.X,FstartPoint.Y);
     FPoints[1] := Point(10,FImgBottom + 58);
     FPoints[2] := Point(58, FImgBottom + 58);
     FPoints[3] := Point(FImgRight + 58, 58);
     FPoints[4] := Point(FImgRight + 58, 10);
     FEndPoint.X := FImgRight + 10;
     FEndPoint.Y := 10;
     FPoints[5] := Point(FImgRight + 10, 10);
   end
   else if (pattern = asRightToLeft) and (LineType = ltDiagonalAsc) then
   begin
//     path4
     FEndPoint.X := Width -58;
     FEndPoint.Y := FImgBottom+10;
     FPoints[0] := Point(Width -10,FImgBottom+10);
     FPoints[1] := Point(Width -10,FImgBottom+58);
     FPoints[2] := Point(Width -58,FImgBottom+58);
     FPoints[3] := Point(FImgLeft - 58, 58);
     FstartPoint.X := FImgLeft - 58;
     FstartPoint.Y := 10;
     FPoints[4] := Point(FStartPoint.X, FStartPoint.Y);
     FPoints[5] := Point(FImgLeft - 10, 10);
   end
   else
   begin
     FPoints[0] := Point(0,Height-48);
     FPoints[1] := Point(Width-48,0);
     FPoints[2] := Point(Width,48);
     FPoints[3] := Point(48,Height);
     FPoints[4] := Point(48,Height);
     FPoints[5] := Point(48,Height);
   end;
   FRgn := CreatePolygonRgn(FPoints,6,WINDING);
   SetWindowRGN(Handle, FRgn, True);
   FRgn2 := CreatePolygonRgn(FPoints,6,WINDING);
   //**FRgn2 is used for FrameRgn in Paint
end;

//------------------------------------------------------------------------------
function TDiamondPathLine.GetLineY(Newx: Single) : Integer;
var
  m : single;
  Y, X : Integer;
begin
  Y := FStartPoint.Y - FEndPoint.Y;
  X := FEndPoint.X - FStartPoint.X;
  m := Y / X;
  Result := Round(m * Newx);
end;

procedure TDiamondPathLine.Paint;
var
  TmpClr: TColor;
begin
  inherited;
  if IsLoaded then
  begin
    TmpClr := Canvas.Brush.Color;
    MakeRegion;
    Canvas.Brush.Color := clblack;
    FillRgn(Canvas.Handle, FRgn2, Canvas.Brush.Handle); //**Need to call fill region here!
    RgnBrush.Color := Colour;
    FrameRgn(Canvas.Handle, FRgn2, RgnBrush.Handle, 2,2);
    Canvas.Brush.Color := TmpClr;
  end;
end;

procedure TDiamondPathLine.SetPathColour(Value: TColor);
begin
  RgnBrush.Color := Value;
  FrameRgn(Canvas.Handle, FRgn2, RgnBrush.Handle, 2,2);

end;

procedure TDiamondPathLine.WMSize(var Message: TMessage);
var
  TmpClr: TColor;
begin
  inherited;
  if IsLoaded then
  begin
    TmpClr := Canvas.Brush.Color;
//    Canvas.Brush.Color := FFillColor;
    Canvas.Brush.Color := clBlack;
    MakeRegion;
    FillRgn(Canvas.Handle, FRgn2, Canvas.Brush.Handle);
    Paint;
    Canvas.Brush.Color := TmpClr;
  end;
end;

//------------------------------------------------------------------------------
procedure TSeatPlan.InitBackDropIDs(Round, Square,Diamond : Integer);
begin
  DBShape[tsRound] := Round;
  DBShape[tsSquare] := Square;
  DBShape[tsDiamond] := Diamond;
end;

//------------------------------------------------------------------------------
end.
