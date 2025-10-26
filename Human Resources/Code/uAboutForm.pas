unit uAboutForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, DBTables;

type
  TAboutForm = class(TForm)
    Button1: TButton;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    lblVersion: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    procedure SetVersionText(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property VersionText : string write SetVersionText;
  end;

var
  AboutForm: TAboutForm;

implementation

uses ADODB, uADO;

{$R *.DFM}

procedure TAboutForm.FormCreate(Sender: TObject);
var
  Yr,Mt,Dy : Word;
begin
  DecodeDate(Now,Yr,Mt,Dy);
  if Yr = 2001 then
    Label1.Caption := '© 2001 Zonal Retail Data Systems'
  else
    Label1.Caption := '© 2001-'+IntToStr(Yr)+' Zonal Retail Data Systems';
end;

procedure TAboutForm.SetVersionText(const Value: string);
begin
  lblVersion.Caption := Value;
end;

end.
