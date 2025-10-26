{ Mike Palmer
  (c) Copyright Zonal Retail Data Systems Ltd. All Rights Reserved }
  
unit uAztecMainMenu;

interface

uses
  Windows, Messages, SysUtils, Classes, Menus, Graphics, Controls;

type
  TAztecMainMenu = class(TMainMenu)
  private
    FFont:TFont;
    FColor:TColor;
    FSelectedColor:TColor;
    FSeperatorColor:TColor;
    FGradient:boolean;
    FColorBlendTo:TColor;
    FDropShadow:boolean;
    FOldDropShadowSetting:boolean;
    FOldFlatMenuSetting:boolean;
    procedure DrawMenuItem(Sender:TObject; ACanvas:TCanvas; ARect:TRect; State:TOwnerDrawState);
    procedure MeasureMenuItem(Sender:TObject; ACanvas:TCanvas; var Width, Height:Integer);
    procedure AssignDrawMethods(MenuItem:TMenuItem);
    procedure MenuChange(Sender: TObject; Source: TMenuItem;Rebuild: Boolean);
    procedure SetFont(const AFont:TFont);
  protected
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy; override;
  published
    property Font:TFont read FFont write SetFont;
    property Color:TColor read FColor write FColor default $00EDD0BC;
    property ColorSelected:TColor read FSelectedColor write FSelectedColor default $00E2B99B;
    property ColorSeperator:TColor read FSeperatorColor write FSeperatorColor default $00F2EAE4;
    property Gradient:boolean read FGradient write FGradient default TRUE;
    property ColorBlendTo:TColor read FColorBlendTo write FColorBlendTo default clWhite;
    property DropShadow:boolean read FDropShadow write FDropShadow default TRUE;
  end;

procedure Register;

implementation

uses uCommon;

procedure Register;
begin
  RegisterComponents('Aztec Controls', [TAztecMainMenu]);
end;

{ TAztecMainMenu }

procedure TAztecMainMenu.AssignDrawMethods(MenuItem:TMenuItem);
var
  Index:integer;
begin
  try
    for Index:=0 to MenuItem.Count-1 do
    begin
      MenuItem[Index].OnAdvancedDrawItem:=DrawMenuItem;
      MenuItem[Index].OnMeasureItem:=MeasureMenuItem;
      if MenuItem[Index].Count > 0 then
         AssignDrawMethods(MenuItem[Index]);
    end;
  except
  end;
end;

constructor TAztecMainMenu.Create(AOwner: TComponent);
begin
  inherited;
  FFont:=TFont.Create;
  FFont.Name:='Arial';
  FFont.Size:=8;
  FFont.Style:=[fsBold];
  FFont.Color:=clBlack;
  OwnerDraw:=TRUE;
  OnChange:=MenuChange;
  FColor:=$00EDD0BC;
  FSelectedColor:=$00E2B99B;
  FSeperatorColor:=$00F2EAE4;
  FGradient:=TRUE;
  FColorBlendTo:=clWhite;
  FOldDropShadowSetting:=GetDropShadowStatus;
  FOldFlatMenuSetting:=GetFlatMenuStatus;
  SetFlatMenuStatus(TRUE);
  SetDropShadowStatus(TRUE);
end;

destructor TAztecMainMenu.Destroy;
begin
  SetFlatMenuStatus(FOldFlatMenuSetting);
  SetDropShadowStatus(FOldDropShadowSetting);
  FreeAndNil(FFont);
  inherited;
end;

procedure TAztecMainMenu.DrawMenuItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; State: TOwnerDrawState);
var
  MenuText:string;
begin
  MenuText:=TMenuItem(Sender).Caption;
  with ACanvas do
  begin
    Font.Assign(FFont);
    if not TMenuItem(Sender).Enabled then
         Font.Color:=clBtnShadow;;
    if (odSelected in State) and ( TMenuItem(Sender).Enabled) then
    begin
      Pen.Width:=1;
      Brush.Color:=FSelectedColor;
      Pen.Color:=FColor;
    end
    else
    begin
      Pen.Width:=1;
      Brush.Color:=FColor;
      Pen.Color:=FColor;
    end;
    Rectangle(ARect);
    if (not (odSelected in State)) and (FGradient) then
       DrawGradient(ACanvas,ARect,[FColor,FColorBlendTo]);
    Brush.Style:=bsClear;
    if MenuText = '-' then
    begin
      Pen.Color:=FSeperatorColor;
      MoveTo(ARect.Left, ARect.Top + ((ARect.Bottom - ARect.Top) div 2));
      LineTo(ARect.Right, ARect.Top + ((ARect.Bottom - ARect.Top) div 2));
    end
    else
    begin
      Inc(ARect.Left, 12);
      DrawText(Handle,PChar(MenuText),Length(MenuText),ARect,DT_LEFT or DT_VCENTER or DT_SINGLELINE);
    end;
  end;
 // MenuWindowHandle:=WindowFromDC(ACanvas.Handle);
//  if MenuWindowHandle <> Self.Handle then
//  begin
//    TempCanvas:=TCanvas.Create;
//    try
//      TempCanvas.Handle:=GetDC(0);
//      Windows.GetWindowRect(MenuWindowHandle, MenuItemRect);
//      TempCanvas.Brush.Color:=FColor;
//      TempCanvas.FrameRect(MenuItemRect);
//      InflateRect(MenuItemRect, -1, -1);
//      TempCanvas.Brush.Color:=FSeperatorColor;
//      TempCanvas.FrameRect(MenuItemRect);
//      InflateRect(MenuItemRect, -1, -1);
//      TempCanvas.FrameRect(MenuItemRect);
//      ReleaseDC(0,TempCanvas.Handle);
//    finally
//      FreeAndNil(TempCanvas);
//    end;
//  end;
end;

procedure TAztecMainMenu.MeasureMenuItem(Sender: TObject;
  ACanvas: TCanvas; var Width, Height: Integer);
begin
  Inc(Width, ACanvas.TextWidth(TMenuItem(Sender).Caption));
end;

procedure TAztecMainMenu.MenuChange(Sender: TObject; Source: TMenuItem;
  Rebuild: Boolean);
begin
  AssignDrawMethods(Items);
end;


procedure TAztecMainMenu.SetFont(const AFont: TFont);
begin
  FFont.Assign(AFont);
end;

end.
