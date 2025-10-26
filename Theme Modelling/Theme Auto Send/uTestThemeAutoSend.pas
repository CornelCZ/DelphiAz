unit uTestThemeAutoSend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, useful;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

type TUpdateResult = (urNoDevicesToUpdate, urAllDevicesUpdated, urNotAllDevicesUpdated);

procedure TForm1.Button1Click(Sender: TObject);
var
  hdll: cardinal;
  dllfn: function: TUpdateResult;
  result: TUpdateResult;
begin
  hdll := loadlibrary( 'C:\Program Files\Zonal\Aztec\ThemeAutoSend.dll');
  dllfn := getprocaddress(hdll, 'UpdateTerminals');
  result := dllfn;
  case result of
    urNoDevicesToUpdate: showmessage('No tills to update');
    urNotAllDevicesUpdated: showmessage('Not all tills updated - run update through theme modelling');
  end;
  freelibrary(hdll);
end;

end.
