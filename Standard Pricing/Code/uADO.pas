unit uADO;

interface

uses
  SysUtils, Classes, DB, ADODB, Forms, dADOAbstract, DBTables, Controls, ppReport;

type
  TdmADO = class(TdmADOAbstract)
  public
    procedure LogError(Error: string); override;
    procedure DoPaper(var Rep: TppReport; Country: string);
    function GetAllADOErrors(Connection: TADOConnection):string;
    function SubDivisionOrSuperCategoryUsed: boolean;
  end;

var
  dmADO: TdmADO;

const
  MAX_PRICE = 99999.99;

implementation

uses uPricinglog, uGlobals, ADOInt, uSetupRBuilderPreview;

{$R *.dfm}

procedure TdmADO.DoPaper(var Rep: TppReport; Country: string);
var
  papNames: TStringList;
  s1, s2: string;
  i: integer;
begin
  papNames := TStringList.Create;

  papNames.Text := rep.PrinterSetup.PaperNames.Text;
  if uppercase(Country) = 'UK' then
    s2 := 'A4'
  else
    s2 := 'Letter';

  //s2 := data1.repPaperName;
  for i := 0 to (papnames.Count - 1) do
  begin
    s1 := papnames[i];

    if pos(uppercase(s2), uppercase(s1)) > 0 then
    begin
      s2 := s1;
      break;
    end;

  end; // for..

  rep.PrinterSetup.PaperName := s2;
  papNames.Free;

  SetupRBuilderPreview(rep);
end;

procedure TdmADO.LogError(Error: string);
begin
  Log.event('Data', Error);
end;

function TdmADO.GetAllADOErrors(Connection: TADOConnection):string;
var
  Index: Integer;
  ADOError: ADOInt.Errors;
begin
  ADOError := Connection.ConnectionObject.Errors;
  for Index:= 0 to ADOError.Count-1 do
  begin
    Result := Result + Format('#%d %s'#13, [ADOError.Item[Index].Number,
      ADOError.Item[Index].Source]) + #13 +
      ADOError.Item[Index].Description + #13 +
      ADOError.Item[Index].SQLState + #13;
  end;
end;


function TdmADO.SubDivisionOrSuperCategoryUsed: boolean;
begin
  with adoqRun do
  try
    SQL.Text :=
      'IF EXISTS ' +
      '( ' +
      '  SELECT a.Id ' +
      '  FROM ac_ProductDivision a LEFT OUTER JOIN ac_ProductSubdivision b ON a.Id = b.ProductDivisionId AND a.Deleted = 0 AND b.Deleted = 0 ' +
      '  GROUP BY a.Id ' +
      '  HAVING COUNT(*) > 1 ' +
      ') ' +
      'OR EXISTS ' +
      '( ' +
      '  SELECT a.Id ' +
      '  FROM ac_ProductDivision a INNER JOIN ac_ProductSubDivision b ON a.Id = b.ProductDivisionId AND a.Deleted = 0 AND b.Deleted = 0 ' +
      '  WHERE a.Name <> b.Name ' +
      ') ' +
      'OR EXISTS ' +
      '( ' +
      '  SELECT a.Id ' +
      '  FROM ac_ProductSuperCategory a LEFT OUTER JOIN ac_ProductCategory b ON a.Id = b.ProductSuperCategoryId AND a.Deleted = 0 AND b.Deleted = 0 ' +
      '  GROUP BY a.Id ' +
      '  HAVING COUNT(*) > 1 ' +
      ') ' +
      'OR EXISTS ' +
      '( ' +
      '  SELECT a.Id ' +
      '  FROM ac_ProductSuperCategory a INNER JOIN ac_ProductCategory b ON a.Id = b.ProductSuperCategoryId AND a.Deleted = 0 AND b.Deleted = 0 ' +
      '  WHERE a.Name <> b.Name ' +
      ') ' +
      '  SELECT CONVERT(bit, 1) AS Result ' + // Sub divisions and/or super categories are used
      'ELSE ' +
      '  SELECT CONVERT(bit, 0) AS Result '; // Sub divisions and super categories are not used
    Open;
    Result := FieldByName('Result').AsBoolean;
  finally
    Close;
  end;

end;

end.
