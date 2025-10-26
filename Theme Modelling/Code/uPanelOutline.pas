unit uPanelOutline;

interface

uses
Classes, Graphics, Controls, SysUtils, windows, messages;
Type

  TNotifyResize = procedure(Top,Left, Width,Height : Integer) of object;
  TNotifyDimsChange = procedure of object;

  TDragHandleType = (dhtTopLeft, dhtTopCentre, dhtTopRight, dhtMiddleRight ,
                     dhtBottomRight , dhtBottomCentre, dhtBottomLeft, dhtMiddleLeft);

  TDragHandle = class(TCustomControl)
  private
    FHandleType : TDragHandleType;
    Start : Tpoint;
    FDoResize : TNotifyResize;
    procedure SetHAndleType(Htype : TDragHandleTYpe);
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
    Constructor Create(Aowner : TComponent); override;
    property DragHandleType : TDragHandleType read FHAndleType write SetHandleType;
    property OnResize: TNotifyResize read FDoResize write FDoResize;
  end;

  TpanelOutline = class(TCustomControl)
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
    FUseDragHandles : Boolean;
    FOnDimsChange : TNotifyDimsChange;
    FHideOrderDisplay : Boolean;
    FRepositionHintVisible : Boolean;

    procedure SetFillColor(const Value: TColor);
    function  GetFillColor: TColor;
    procedure MakeRegion;
    procedure SetBorderColor(Value: TColor);
    procedure SetPattern(Value : Integer);
    procedure SetLineType(Value : Integer);
    procedure WMSize(var Message: TMessage); message WM_SIZE;
    procedure InitDragHandles;
    procedure AlignDragHandles;
    procedure doResize(Top, Left, Width, Height: Integer);
    procedure SetDragHandlesVisible(Value : Boolean);
    procedure SetRepositionHintVisible(const Value: Boolean);
  protected
    { Protected declarations }
    FDragHandles : TList;

    procedure Paint; override;
    procedure CreateWnd; override;
    procedure Resize; override;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;

  public
    { Public declarations }
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property BorderColor: TColor read FBorderColor write SetBorderColor default clBlack;
    property BorderWidth: Integer read FBorderWidth write FBorderWidth default 2;
    property FillColor: TColor read GetFillColor write SetFillColor;
    property Pattern : Integer Read FPattern write SetPattern;
    property LineType : Integer Read FlineTYpe write SetLineType;
    property DragHandlesVisible : Boolean read FuseDragHandles write SetDragHandlesVisible;
    property HideOrderDisplay : Boolean read FHideOrderDisplay write FHideOrderDisplay;
    property RepositionHintVisible : Boolean read FRepositionHintVisible write SetRepositionHintVisible;

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
    property OnDimsChange :TNotifyDimsChange read FOnDimsChange write FOnDimsChange;

  end;

implementation

uses
  utillButton;


//------------------------------------------------------------------------------
procedure TpanelOutline.doResize(Top, Left, Width, Height : Integer);
begin
  TPanelManager(Owner).PanelTop := Top;
  TPanelManager(Owner).PanelLeft := Left;
  TPanelManager(Owner).PanelWidth := Width;
  TPanelManager(Owner).PAnelHeight := Height;
//  AlignDragHandles;
end;

//------------------------------------------------------------------------------
procedure TpanelOutline.AlignDragHandles;
var
  index : Integer;
  tmpDH : TDragHandle;
begin
  for index := 0 to Integer(dhtMiddleLeft) do
  begin
    tmpDH := TDragHandle(FDragHandles.Items[index]);

    case TmpDH.DragHandleType of
     dhtTopLeft : begin
                    TmpDH.Top := 0;
                    TmpDH.Left := 0;
                  end;
     dhtTopCentre : begin
                      TmpDH.Top := 0;
                      TmpDH.Left := (width div 2) - 2;
                    end;
     dhtTopRight : begin
                      TmpDH.Top := 0;
                      TmpDH.Left := width - 5;
                   end;
     dhtMiddleRight : begin
                        TmpDH.Top := (Height div 2) - 3;
                        TmpDH.Left := width - 5;
                      end;
     dhtBottomRight : begin
                        TmpDH.Top := Height  - 5;
                        TmpDH.Left := width - 5;
                      end;
     dhtBottomCentre : begin
                        TmpDH.Top := Height  - 5;
                        TmpDH.Left :=(width div 2) - 2;
                       end;
     dhtBottomLeft : begin
                       TmpDH.Top := Height  - 5;
                       TmpDH.Left := 0;
                     end;
     dhtMiddleLeft : begin
                       TmpDH.Top := (Height div 2) - 3;
                       TmpDH.Left := 0;
                     end;
    end;
  end;
end;

//------------------------------------------------------------------------------
procedure TpanelOutline.InitDragHandles;
var
  index : Integer;
  NewDH : TDragHandle;
begin
  FDragHandles := TList.Create;
  for index := 0 to Integer(dhtMiddleLeft) do
  begin
    NewDH := TDragHandle.Create(self);
    NewDH.Parent := Self;
    NewDH.DragHandleType := TDragHandleType(index);
    NewDH.OnResize := doResize;
    FDragHandles.Add(NewDH);
  end;
  AlignDragHandles;
end;

//------------------------------------------------------------------------------
constructor TpanelOutline.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csClickEvents,
                   csOpaque, csDoubleClicks, csAcceptsControls];
  Hint := 'Left click and drag to reposition.';
  RepositionHintVisible := True;
  Width := 200;
  Height := 200;
  RgnBrush := TBrush.Create;
  if Tag = 0 then
    RgnBrush.Color := $00E9BCC5
  else
    RgnBrush.Color := clBlue;

   //** This changes the out line colour
//  FFillColor := clBlack;
  IsLoaded := False;
  FBorderWidth := 4;
  FBorderColor := clBlack;
  FRgn := 0;
  FRgn2 := 0;
  InitDragHandles;
end;

//------------------------------------------------------------------------------
destructor TpanelOutline.Destroy;
begin
  DeleteObject(FRgn);
  DeleteObject(FRgn2);
  inherited;
end;

procedure TpanelOutline.CreateWnd;
begin
  inherited;
  MakeRegion;
  IsLoaded := True;
  {IsLoaded is to make sure MakeRegion is not called before there is a
  Handle for this control, but it may not be nessary}
end;


procedure TpanelOutline.MakeRegion;
var
  FPoints: array[0..12] of TPoint;
  Linewidth : Integer;
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
   Linewidth := BorderWidth;
   FPoints[0] := Point((width div 2),LineWidth);
   FPoints[1] := Point((width div 2),0);
   FPoints[2] := Point(Width,0);
   FPoints[3] := Point(Width,Height);
   FPoints[4] := Point(0,Height);
   FPoints[5] := Point(0,0);
   FPoints[6] := Point((width div 2),0);
   FPoints[7] := Point((width div 2),LineWidth);
   FPoints[8] := Point(LineWidth,LineWidth);
   FPoints[9] := Point(LineWidth,Height -LineWidth);
   FPoints[10] := Point(Width-LineWidth,Height-LineWidth);
   FPoints[11] := Point(width-LineWidth,LineWidth);
   FPoints[12] := Point((width div 2),LineWidth);

   FRgn := CreatePolygonRgn(FPoints,13,WINDING);
   SetWindowRGN(Handle, FRgn, True);
   FRgn2 := CreatePolygonRgn(FPoints,13,WINDING);
   //**FRgn2 is used for FrameRgn in Paint
end;


procedure TpanelOutline.WMSize(var Message: TMessage);
var
  TmpClr: TColor;
begin
  inherited;
  if IsLoaded then
  begin
    TmpClr := Canvas.Brush.Color;
//    Canvas.Brush.Color := FFillColor;
    Canvas.Brush.Color := clBlack;
    if Tag = 0 then
      Canvas.Brush.Color := $00E9BCC5
    else
      Canvas.Brush.Color := clBlue;

    MakeRegion;
    FillRgn(Canvas.Handle, FRgn2, Canvas.Brush.Handle);
    Paint;
    Canvas.Brush.Color := TmpClr;
  end;
end;

procedure TpanelOutline.Paint;
var
  TmpClr: TColor;
begin
  inherited;
  if IsLoaded then
  begin
    TmpClr := Canvas.Brush.Color;
//    MakeRegion;
//** Removing call to make region fro paint as it causes the panel manager to flicker 
//    Canvas.Brush.Color := FillColor;
    Canvas.Brush.Color := $00E9BCC5;
    FillRgn(Canvas.Handle, FRgn2, Canvas.Brush.Handle); //**Need to call fill region here!
    FrameRgn(Canvas.Handle, FRgn2, RgnBrush.Handle, FBorderWidth,FBorderWidth);
    Canvas.Brush.Color := TmpClr;
  end;
end;

procedure TpanelOutline.SetBorderColor(Value: TColor);
begin
  if FBorderColor <> Value then
  begin
    FBorderColor := Value;
    RgnBrush.Color := FBorderColor;
    Paint;
  end;
end;

//------------------------------------------------------------------------------
procedure TpanelOutline.SetFillColor(const Value: TColor);
begin
  if FFillColor <> Value then
  begin
    FFillColor := Value;
    Paint;
  end
end;

function TpanelOutline.GetFillColor: TColor;
begin
  Result := FFillColor;
end;


//------------------------------------------------------------------------------
procedure TpanelOutline.SetPattern(Value: Integer);
begin
  FPattern := Value;
  MakeRegion;
end;

//------------------------------------------------------------------------------
procedure TpanelOutline.SetLineType(Value: Integer);
begin
  FLineType := Value;
  MakeRegion;
end;


constructor TDragHandle.Create(Aowner: TComponent);
begin
  inherited;
  Hint := 'Click and drag to resize.';
  ShowHint := True;
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
procedure TDragHandle.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;

end;

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
        if DragHandleType = dhtTopLeft then
        begin
          FDoResize(Parent.Top - (Start.Y -Y),
                    Parent.left - (Start.X -X),
                    Parent.Width + (Start.X -X),
                    Parent.Height + (Start.Y -Y))
        end;
{
        if name = 'DragHandle1' then
          FDoResize(0,-y)
        else if name = 'DragHandle2' then
          FDoResize(X,0)
        else if name = 'DragHandle3' then
          FDoResize(0,Y)
        else if name = 'DragHandle4' then
          FDoResize(-X,0)
}
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
  Canvas.Brush.Color := clWhite;
  Canvas.FillRect(Rect);
end;

procedure TDragHandle.SetHAndleType(Htype: TDragHandleTYpe);
begin
  case Htype of
    dhtBottomLeft, dhtTopRight : Cursor := crSizeNESW;
    dhtBottomRight, dhtTopLeft : Cursor := crSizeNWSE;
    dhtBottomCentre, dhtTopCentre : Cursor := crSizeNS;
    dhtMiddleLeft, dhtMiddleRight : Cursor := crSizeWE;
  end;
  FHandleType := HType;
end;


procedure TpanelOutline.SetDragHandlesVisible(Value: Boolean);
var
  index : Integer;
begin
  for index := 0 to FDragHandles.Count-1 do
  begin
    TDragHandle(FDragHandles.Items[index]).Visible := Value;
  end;
end;

//------------------------------------------------------------------------------
procedure TpanelOutline.Resize;
begin
  inherited;
  AlignDragHandles;
end;

//------------------------------------------------------------------------------
procedure TpanelOutline.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  pos : TPoint;
begin
  if TPanelManager(Owner).ReadOnly then
    exit;
  inherited;
  if (button = mbLeft) then
  begin
    pos.x := x;
    pos.y := y;
    TPanelManager(Owner).DragInitialClick(self, pos, shift);
  end
end;

procedure TpanelOutline.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  pos : TPoint;
begin
  inherited;
  pos.x := x;
  pos.y := y;
  TPanelManager(Owner).DragMove(pos);
end;

procedure TpanelOutline.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  pos : TPoint;
begin
  inherited;
  if (button = mbLeft) then
  begin
    pos.x := x;
    pos.y := y;
    TPanelManager(Owner).DragFinalClick(self, pos, shift);
  end;
end;

procedure TpanelOutline.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  if Assigned(FOnDimsChange) then
    FOnDimsChange;

end;

procedure TpanelOutline.SetRepositionHintVisible(const Value: Boolean);
begin
  FRepositionHintVisible := Value;
  ShowHint := Value;
  if Value = True then
    Cursor := crSizeAll
  else
    Cursor := crDefault;
end;

end.
