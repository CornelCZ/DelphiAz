unit uPreloadWaitScreen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TPreloadWaitScreen = class(TForm)
    lbLoadingMessage: TLabel;
    Button1: TButton;
    Timer1: TTimer;
    Image1: TImage;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer1Timer(Sender: TObject);
  private
    AnimFrame: integer;
    { Private declarations }
  public
    { Public declarations }

  end;

var
  PreloadWaitScreen: TPreloadWaitScreen;

implementation

{$R *.dfm}

procedure TPreloadWaitScreen.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := False;
end;

procedure TPreloadWaitScreen.Timer1Timer(Sender: TObject);
begin
  TTimer(SendeR).interval := 80;
  Image1.Picture.Bitmap.LoadFromResourceName(HInstance, Format('AztecProgressAnimFrame%2.2d', [AnimFrame]));
  AnimFrame := (AnimFrame + 1) mod 25;
end;

end.
