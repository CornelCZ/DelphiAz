unit uButtonTypeDropDown;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ImgList;

type
  TButtonMenuCombo = class(TForm)
    Tree: TTreeView;
    ImageList1: TImageList;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TreeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    OnCloseUp: procedure of Object;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure VisibleChanging; override;
    procedure CMMouseLeave(var msg: TMsg); message CM_Mouseleave;
    procedure CMMouseEnter(var msg: TMsg); message CM_MouseEnter;
    procedure WMActivateApp(var msg: TMsg); message WM_ActivateApp;
  end;

implementation

uses commctrl;

{$R *.dfm}

procedure TButtonMenuCombo.CMMouseEnter(var msg: TMsg);
begin
  ReleaseCapture;
end;

procedure TButtonMenuCombo.CMMouseLeave(var msg: TMsg);
begin
  if Visible then
    if assigned(ActiveControl) then
      SetCapture(ActiveControl.Handle)
    else
      SetCapture(Handle);
end;

procedure TButtonMenuCombo.WMActivateApp(var msg: TMsg);
begin
  if (msg.wParam)= 0 then close;
end;

procedure TButtonMenuCombo.CreateParams(var Params: TCreateParams);
begin
  inherited;
// Removing WS_CAPTION and WS_SIZEBOX means no title bar or sizing.
// Adding WS_CHILD makes the form a true child window.
// Adding WS_BORDER gives a thin non-3d border.
// WS_POPUP can't be used with WS_CHILD style so is removed.
// Adding WS_EX_PALETTEWINDOW makes the form top-most (it stays on top) and
// a tool window (it doesn't appear in the task list).
  Params.Style := Params.Style and not(WS_CAPTION or WS_SIZEBOX or WS_POPUP);
  Params.Style := Params.Style or (WS_CHILD or WS_BORDER);
  Params.ExStyle := Params.ExStyle or WS_EX_PALETTEWINDOW;
end;

procedure TButtonMenuCombo.CreateWnd;
begin
  inherited;
  // set the desktop as our parent
  Windows.SetParent(handle, getdesktopwindow);

end;

procedure TButtonMenuCombo.VisibleChanging;
begin
  inherited;
  if Visible then
  begin
    ReleaseCapture();
    if assigned(OnCloseUp) then
      OnCloseUp;
  end
  else
    if assigned(ActiveControl) then
      SetCapture(ActiveControl.Handle)
    else SetCapture(Handle);
end;

procedure TButtonMenuCombo.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (X < 0) or (X >= Width) or (Y < 0) or (Y >= Height) then
     Close;
end;

procedure TButtonMenuCombo.TreeMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ht: THitTests;
begin
  ht := tree.GetHitTestInfoAt(x, y);
  if htOnItem in ht then close;
end;

end.
