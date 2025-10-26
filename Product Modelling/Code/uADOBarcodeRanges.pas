unit uADOBarcodeRanges;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uADO, DB, ADODB;

type

  TBarcodeRangeSource = (brsNone, brsProduct);     // added this in case barcode ranges to be applied to more than just products

  TdmBarcodeRanges = class(TdmADO)
    qSeedID: TADOQuery;
    qAllBarcodeRanges: TADOQuery;
    dsBarcodeRanges: TDataSource;
    qGenerateRanges: TADOQuery;
    dsBarcodeExceptions: TDataSource;
    dstBarcodeExceptions: TADODataSet;
    qAllBarcodeRangesBarcodeRangeID: TLargeintField;
    qAllBarcodeRangesDescription: TStringField;
    qAllBarcodeRangesStartValue: TStringField;
    qAllBarcodeRangesEndValue: TStringField;
    qProductBarcodeRanges: TADOQuery;
    qAllBarcodeRangesSource: TSmallintField;
    qProductBarcodeRangesSource: TSmallintField;
    qInsertProductBarcodeRange: TADOQuery;
    qInsertBarcodeRange: TADOQuery;
    qDeleteSelectedBarcodeRange: TADOQuery;
    qDeleteProductBarcodeRanges: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetNewID(TableName, FieldName: string): int64;
    function GetBarcodeRangeSourceAsInt(source: TBarcodeRangeSource): smallint;
    function GetBarcodeRangeSourceType(sourceValue: SmallInt): TBarcodeRangeSource;
  end;


var
  dmBarcodeRanges: TdmBarcodeRanges;

implementation

{$R *.dfm}

function TdmBarcodeRanges.GetNewId(TableName, FieldName: string): int64;
var
  MinRange, MaxRange: int64;
begin
  // bigints have range 0 to 9223372036854775807
  MaxRange := 9223372036854775807;
  MinRange := 1;

  dmBarcodeRanges.qSeedID.SQL.Text :=
    format(
      'declare @output bigint '+
      'exec getnextuniqueid  %s, %s, %d, %d, @NextID = @output OUTPUT '+
      'select @output as Output', [quotedstr(TableName), quotedstr(FieldName), MinRange, MaxRange]);
  try
    dmBarcodeRanges.qSeedID.Open;
  except on E:Exception do
    raise Exception.create('Could not generate unique ID for save operation');
  end;
  result := TLargeIntField(dmBarcodeRanges.qSeedID.fieldbyname('Output')).aslargeint;
  dmBarcodeRanges.qSeedID.close;
end;


function TdmBarcodeRanges.GetBarcodeRangeSourceAsInt(source: TBarcodeRangeSource): smallint;
begin
  case source of
    brsNone : Result := 0;
    brsProduct : Result := 1;
  else
    Result := 0;
  end;
end;

function TdmBarcodeRanges.GetBarcodeRangeSourceType(sourceValue: SmallInt): TBarcodeRangeSource;
begin
  case sourceValue of
    0: Result := brsNone;
    1: Result := brsProduct;
  else
    Result := brsNone;
  end;
end;

end.
