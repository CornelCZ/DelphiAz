unit uEditThemeDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TThemeDetails = class(TForm)
    lbName: TLabel;
    edName: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    mmDescription: TMemo;
    seIdleTime: TSpinEdit;
    Label3: TLabel;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    ThemeID: integer;
  end;

var
  ThemeDetails: TThemeDetails;

implementation

uses
 uAztecLog, uDMThemeData;

{$R *.dfm}

procedure TThemeDetails.Button1Click(Sender: TObject);
begin
  ButtonClicked(sender);
  if trim(edName.Text) = '' then
    raise Exception.create('Please specify a name');
  with dmThemeData do
  begin
    adoQRun.SQL.Text := Format(
      'if exists(select * from Theme where Name = %s and ThemeID <> %d) select 1 else select 0',
      [QuotedStr(edName.Text), ThemeID]
    );
    adoQRun.Open;
    if adoQRun.Fields[0].AsInteger = 1 then
    begin
      adoQRun.Close;
      raise Exception.Create(Format('The name %s is already in use by another Theme', [QuotedStr(edName.Text)]));
    end;
    adoQRun.Close;
  end;
  modalresult := mrOk;
end;

procedure TThemeDetails.Button2Click(Sender: TObject);
begin
  buttonClicked(Sender);
end;

procedure TThemeDetails.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
end;

procedure TThemeDetails.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
end;

end.
