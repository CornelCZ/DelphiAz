unit uBaseEditReconfigurePinPads;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TBaseEditReconfigurePinPads = class(TForm)
    Label1: TLabel;
    btFixLater: TButton;
    btFixNow: TButton;
    mmWarnings: TMemo;
    cbEnableEftPay: TCheckBox;
    cbVx670PayAtTable: TCheckBox;
    procedure btFixLaterClick(Sender: TObject);
    procedure btFixNowClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BaseEditReconfigurePinPads: TBaseEditReconfigurePinPads;

implementation

{$R *.dfm}

procedure TBaseEditReconfigurePinPads.btFixLaterClick(Sender: TObject);
begin
  self.ModalResult := mrCancel;
end;

procedure TBaseEditReconfigurePinPads.btFixNowClick(Sender: TObject);
begin
  self.ModalResult := mrOk;
end;

end.
