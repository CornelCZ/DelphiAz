unit FrmEditBinaryU;

interface
{$I define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  {$IFDEF Delphi6} Variants, {$ENDIF} 
  Dialogs, StdCtrls, Grids, ExtCtrls;

type
  TFrmEditBinaryValue = class(TForm)
    lblValueName: TLabel;
    edtValueName: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    lblValueData: TLabel;
    dgData: TDrawGrid;
    procedure FormCreate(Sender: TObject);
    procedure dgDataDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure dgDataGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
  private
    FValueData: OleVariant;
    function GetCellText(ACol, ARow: integer): string;
    procedure SetValueData(const Value: OleVariant);
    { Private declarations }
  public
    { Public declarations }
    property ValueData: OleVariant read FValueData write SetValueData;
  end;

implementation

{$R *.dfm}

type
  TMyCharSet = set of char;

const
  HexCharSet: TMyCharSet = ['0'..'9', 'A'..'F', 'a'..'f', Char(VK_BACK),  Char(VK_DELETE),
                            Char(VK_LEFT), Char(VK_RIGHT), Char(VK_TAB)];

  HexChars: TMyCharSet = ['0'..'9', 'A'..'F', 'a'..'f', ',', ';'];

function ByteToChar(AByte: byte): char;
begin
  if Char(AByte) in HexChars then Result := Char(AByte)
    else Result := '.';  
end;


procedure TFrmEditBinaryValue.FormCreate(Sender: TObject);
var
  i: integer;
begin
   for i := 0 to dgData.ColCount - 1 do
     dgData.ColWidths[i] := 20;
   dgData.ColWidths[0] := 60;
   dgData.ColWidths[dgData.ColCount - 1] := 80;

end;

function TFrmEditBinaryValue.GetCellText(ACol, ARow: integer): string;
var
  vIndex, i: integer;
  vStr: string;
begin
  Result := '';

  if ACol = 0 then
  begin
    Result := IntToHex(ARow * 8, 4);
  end else
  if ACol = dgData.ColCount - 1 then
  begin
    vStr := '';
    for i := 0 to 7 do
    begin
      vIndex := ARow * 8 + i;
      if vIndex < VarArrayHighBound(FValueData, 1) then
        vStr := vStr + ByteToChar(FValueData[vIndex]);
    end;
    Result := vStr;
  end else
  begin
    vIndex := ARow * 8 + ACol;
    if vIndex < VarArrayHighBound(FValueData, 1) then
      Result := IntToHex(FValueData[vIndex], 2);
  end;
end;

procedure TFrmEditBinaryValue.dgDataDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  dgData.Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 2, GetCellText(ACol, ARow));
end;

procedure TFrmEditBinaryValue.dgDataGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  if (ACol = 0) or (ACol = dgData.ColCount - 1) then dgData.EditorMode := false;
  Value := GetCellText(ACol, ARow);
end;

procedure TFrmEditBinaryValue.SetValueData(const Value: OleVariant);
begin
  FValueData := Value;
  dgData.RowCount := (VarArrayHighBound(FValueData, 1) div 8) + 1;
end;

end.
