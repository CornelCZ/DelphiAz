{ Mike Palmer
  (c) Copyright Zonal Retail Data Systems Ltd. All Rights Reserved }

unit uAztecButton;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TDrawButtonEvent=procedure(AControl:TWinControl;ARect:TRect;AState:TOwnerDrawState) of object;

  TAztecColourButton = class(TBitBtn)
  private
    FCanvas:TCanvas;
    IsFocused:Boolean;
    FOnDrawButton:TDrawButtonEvent;
    FTempColor:TColor;
    procedure ConvertBitmapToGreyScale(ABitmap:TBitmap;ADepth:Integer);
  protected
    procedure CreateParams(var Params:TCreateParams); override;
    procedure SetButtonStyle(ADefault:Boolean); override;
    procedure CMEnabledChanged(var AMessage:TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var AMessage:TMessage); message CM_FONTCHANGED;
    procedure CNMeasureItem(var AMessage:TWMMeasureItem); message CN_MEASUREITEM;
    procedure CNDrawItem(var AMessage:TWMDrawItem); message CN_DRAWITEM;
    procedure WMLButtonDblClk(var AMessage:TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure CMMouseEnter(var AMessage:TMessage);message CM_MOUSEENTER;
    procedure CMMouseLeave(var AMessage:TMessage);message CM_MOUSELEAVE;
    procedure DrawButton(ARect:TRect;AState:UINT);
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    property Canvas:TCanvas read FCanvas;
  published
    property OnDrawButton:TDrawButtonEvent read FOnDrawButton write FOnDrawButton;
    property Color;
  end;

procedure Register;

implementation

uses ShellAPI, Math;

procedure Register;
begin
  RegisterComponents('Aztec Components', [TAztecColourButton]);
end;

constructor TAztecColourButton.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FCanvas:=TCanvas.Create;
  Color:=clBtnFace;
  Width:=100;
  Height:=30;
  ParentFont:=TRUE;
end;

destructor TAztecColourButton.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FCanvas);
end;

procedure TAztecColourButton.CreateParams(var Params:TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    Style:=Style or BS_OWNERDRAW;
end;

procedure TAztecColourButton.SetButtonStyle(ADefault:Boolean);
begin
  if ADefault<>IsFocused then
  begin
    IsFocused:=ADefault;
    Refresh;
  end;
end;

procedure TAztecColourButton.CNMeasureItem(var AMessage:TWMMeasureItem);
begin
  with AMessage.MeasureItemStruct^ do
  begin
    itemWidth:=Width;
    itemHeight:=Height;
  end;
end;

procedure TAztecColourButton.CNDrawItem(var AMessage:TWMDrawItem);
var
  SaveIndex:integer;
begin
  with AMessage.DrawItemStruct^ do
  begin
    SaveIndex:=SaveDC(hDC);
    FCanvas.Lock;
    try
      FCanvas.Handle:=hDC;
      FCanvas.Font:=Font;
      FCanvas.Brush:=Brush;
      DrawButton(rcItem, itemState);
    finally
      FCanvas.Handle:=0;
      FCanvas.Unlock;
      RestoreDC(hDC, SaveIndex);
    end;
  end;
  AMessage.Result:=1;
end;

procedure TAztecColourButton.CMEnabledChanged(var AMessage:TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TAztecColourButton.CMFontChanged(var AMessage:TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TAztecColourButton.WMLButtonDblClk(var AMessage:TWMLButtonDblClk);
begin
  Perform(WM_LBUTTONDOWN, AMessage.Keys, Longint(AMessage.Pos));
end;

procedure TAztecColourButton.DrawButton(ARect:TRect;AState:UINT);
var
  Flags,OldMode:Longint;
  IsDown,IsDefault,IsDisabled:Boolean;
  OldColor:TColor;
  OrgRect:TRect;
  TextRect:TRect;
  TempGlyph:TBitmap;
begin
  OrgRect:=ARect;
  Flags:=DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
  IsDown:=AState and ODS_SELECTED <> 0;
  IsDefault:=AState and ODS_FOCUS <> 0;
  IsDisabled:=AState and ODS_DISABLED <> 0;
  if IsDown then Flags:=Flags or DFCS_PUSHED;
  if IsDisabled then Flags:=Flags or DFCS_INACTIVE;
  FCanvas.Font.Color:=clBtnText;
  if IsFocused or IsDefault then
  begin
    FCanvas.Pen.Color:=clWindowFrame;
    FCanvas.Pen.Width:=1;
    FCanvas.Brush.Style:=bsClear;
    FCanvas.Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
    InflateRect(ARect,-1,-1);
  end;
  if IsDown then
  begin
    FCanvas.Pen.Color:=clBtnShadow;
    FCanvas.Pen.Width:=1;
    FCanvas.Brush.Color:=clBtnShadow;
    FCanvas.Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
    InflateRect(ARect,-1,-1);
  end
  else
    DrawFrameControl(FCanvas.Handle, ARect, DFC_BUTTON, Flags);
  if IsDown then
  begin
    OffsetRect(ARect, 1, 1);
    InflateRect(ARect,-1,-1);
  end;
  OldColor:=FCanvas.Brush.Color;
  FCanvas.Brush.Color:=Color;
  FCanvas.FillRect(ARect);
  FCanvas.Brush.Color:=OldColor;
  OldMode:=SetBkMode(FCanvas.Handle, TRANSPARENT);
  if Assigned(Glyph) then
     ARect.Left:=ARect.Left+Glyph.Width+5;
  TempGlyph:=TBitmap.Create;
  TempGlyph.Width:=Glyph.Width;
  TempGlyph.Height:=Glyph.Height;
  TempGlyph.Assign(Glyph);
  if IsDisabled then
  begin
    TextRect:=ARect;
    FCanvas.Font.Color:=clBtnShadow;
    DrawText(FCanvas.Handle,PChar(Caption),-1,ARect,DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    FCanvas.Font.Color:=Color;
    OffsetRect(TextRect,-1,-1);
    DrawText(FCanvas.Handle,PChar(Caption),-1,TextRect,DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    ConvertBitmapToGreyScale(TempGlyph,25);
  end
  else
     DrawText(FCanvas.Handle,PChar(Caption),-1,ARect,DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  SetBkMode(FCanvas.Handle,OldMode);
  if Assigned(FOnDrawButton) then
     FOnDrawButton(Self,ARect,TOwnerDrawState(LongRec(AState).Lo));
  if IsDown then
     BitBlt(FCanvas.Handle,6,((Height-Glyph.Height) div 2)+1,Glyph.Width,Glyph.Height,TempGlyph.Canvas.Handle,0,0,SRCCOPY)
  else
     BitBlt(FCanvas.Handle,5,(Height-Glyph.Height) div 2,Glyph.Width,Glyph.Height,TempGlyph.Canvas.Handle,0,0,SRCCOPY);
  if IsFocused and IsDefault then
  begin
    ARect:=OrgRect;
    InflateRect(ARect,-4,-4);
    FCanvas.Pen.Color:=clBtnShadow;
    FCanvas.Brush.Color:=clBtnShadow;
  end;
  FreeAndNil(TempGlyph);
end;

procedure TAztecColourButton.ConvertBitmapToGreyScale(ABitmap: TBitmap;ADepth:integer);
var
  AColor,AColor2:longint;
  Red,Green,Blue:byte;
  i,j:integer;
begin
  for j:=0 to ABitmap.Height do
    for i:=0 to ABitmap.width do
    begin
      AColor:=ColorToRGB(Abitmap.Canvas.pixels[i,j]);
      Red:=GetRValue(AColor);
      Green:=GetGValue(Acolor);
      Blue:=GetBValue(Acolor);
      Acolor2:=(Red+Green+Blue) div 3;
      ABitmap.Canvas.Pixels[i,j]:=RGB(Acolor2,Acolor2,Acolor2);
    end;
end;

procedure TAztecColourButton.CMMouseEnter(var AMessage: TMessage);
begin
  FTempColor:=Color;
  Color:=clBtnShadow;
  Invalidate;
end;

procedure TAztecColourButton.CMMouseLeave(var AMessage: TMessage);
begin
  Color:=FTempColor;
  Invalidate;
end;

end.

