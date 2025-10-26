unit uCommsBusy;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, ComCtrls;

type
  TCommsBusyDlg = class(TForm)
    Animate: TAnimate;
    Text: TStaticText;
    btnCanceled: TBitBtn;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnCanceledClick(Sender: TObject);
  private
    { Private declarations }
  public
    Canceled: Boolean;
    procedure start(txt: String; ShowCanceled: boolean = False);
    procedure step(txt: String);
    procedure stop;
    { Public declarations }
  end;

var
  CommsBusyDlg: TCommsBusyDlg;

implementation

{$R *.dfm}

uses uGuiUtils;

procedure TCommsBusyDlg.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := false;
end;

procedure TCommsBusyDlg.start(txt:String; ShowCanceled: boolean);
begin
  Text.Caption  := txt;

  btnCanceled.Visible := ShowCanceled;
  Canceled := False;

  Show;
end;

procedure TCommsBusyDlg.step(txt:String);
begin
  Text.Caption  := txt;
end;

procedure TCommsBusyDlg.stop;
begin
  Hide;
end;

procedure TCommsBusyDlg.FormShow(Sender: TObject);
begin
  // position our window nicely
  CentreForm(Self);
end;

procedure TCommsBusyDlg.btnCanceledClick(Sender: TObject);
begin
  Canceled := True;
end;

end.
