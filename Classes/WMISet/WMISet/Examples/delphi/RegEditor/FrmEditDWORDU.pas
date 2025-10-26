unit FrmEditDWORDU;

interface
{$I define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  {$IFDEF Delphi6} Variants, {$ENDIF}
  Dialogs, StdCtrls, ExtCtrls;

type
  TFrmEditDWORD = class(TForm)
    lblValueName: TLabel;
    edtValueName: TEdit;
    lblValueData: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    edtValueData: TEdit;
    rgBase: TRadioGroup;
    procedure edtValueDataKeyPress(Sender: TObject; var Key: Char);
    procedure rgBaseClick(Sender: TObject);
  private
    function  GetValueData: integer;
    procedure SetValueData(const Value: integer);
    { Private declarations }
  public
    { Public declarations }
    property ValueData: integer read GetValueData write SetValueData;
  end;

implementation

{$R *.dfm}

type
  TMyCharSet = set of char;

const
  HexCharSet: TMyCharSet = ['0'..'9', 'A'..'F', 'a'..'f', Char(VK_BACK),  Char(VK_DELETE),
                            Char(VK_LEFT), Char(VK_RIGHT), Char(VK_TAB)];
  DecCharSet: TMyCharSet = ['0'..'9', Char(VK_BACK),  Char(VK_DELETE),
                            Char(VK_LEFT), Char(VK_RIGHT), Char(VK_TAB)];

function HexToInt(AHexaDecimal: string): integer;
var
  vHex: string;
begin
  while Length(AHexaDecimal) < 8 do AHexaDecimal := '0' + AHexaDecimal;
  // convert hexadecimal to hex
  vHex := Copy(AHexaDecimal, 7, 2) +
          Copy(AHexaDecimal, 5, 2) +
          Copy(AHexaDecimal, 3, 2) +
          Copy(AHexaDecimal, 1, 2);
  HexToBin(PChar(vHex), PChar(@Result), SizeOf(Result));
end;

procedure TFrmEditDWORD.edtValueDataKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (rgBase.ItemIndex = 0) and not (Key in HexCharSet) then Key := #0;
  if (rgBase.ItemIndex = 1) and not (Key in DecCharSet) then Key := #0;
end;

function TFrmEditDWORD.GetValueData: integer;
begin
  if (rgBase.ItemIndex = 0) then
    Result := HexToInt(edtValueData.Text)
    else Result := StrToInt(edtValueData.Text);
end;

procedure TFrmEditDWORD.rgBaseClick(Sender: TObject);
begin
  if (rgBase.ItemIndex = 0) then
  begin
    edtValueData.Text := IntToHex(StrToInt(edtValueData.Text), 1);
    edtValueData.MaxLength := 8;
  end else
  begin
    edtValueData.Text := IntToStr(HexToInt(edtValueData.Text));
    edtValueData.MaxLength := 10;
  end;
end;

procedure TFrmEditDWORD.SetValueData(const Value: integer);
begin
  if (rgBase.ItemIndex = 0) then
    edtValueData.Text := IntToHex(Value, 1)
    else edtValueData.Text := IntToStr(Value);
end;

end.
