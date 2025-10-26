unit uFullReCfg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TfFullReCfg = class(TForm)
    Timer1: TTimer;
    Label1: TLabel;
    Panel1: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uGlobals;

{$R *.DFM}

procedure TfFullReCfg.Timer1Timer(Sender: TObject);
begin
  if label3.Color = clBlack then
  begin
    label3.Color := clYellow;
    label3.Font.Color := clBlack;
  end
  else
  begin
    label3.Color := clBlack;
    label3.Font.Color := clYellow;
  end;
end;

procedure TfFullReCfg.Edit1Change(Sender: TObject);
begin
  if upperCase(edit1.Text) = upperCase(CurrentUser.UserName) then
    bitbtn1.Enabled := True
  else
    bitbtn1.Enabled := False;
end;

procedure TfFullReCfg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled := False;
  Application.ProcessMessages;
end;

procedure TfFullReCfg.FormCreate(Sender: TObject);
begin
  if purchHelpExists then
    setHelpContextID(self, HLP_FULL_RECONFIGURE);
end;

end.
