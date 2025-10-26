unit uAboutForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, DBTables;

type
  TAboutForm = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Bevel1: TBevel;
    Label4: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.DFM}

procedure TAboutForm.FormCreate(Sender: TObject);
var
  Yr,Mt,Dy : Word;
begin
  DecodeDate(Now,Yr,Mt,Dy);
  if Yr = 2002 then
    Label1.Caption := '© 2002 Zonal Retail Data Systems'
  else
    Label1.Caption := '© 2002-'+IntToStr(Yr)+' Zonal Retail Data Systems';

  Label2.Caption := 'Version 5.1.1.A';
end;

end.
