unit uADO;

interface

{$R Version.RES}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dADOAbstract, ADODB, DB, INIFiles;

type
  TdmADO = class(TdmADOAbstract)
  private
    { Private declarations }
  public
    { Public declarations }
    function ADOUpdatesPending (ADODataSet: TCustomADODataSet): boolean;
    function CheckAztecDatabase: boolean;
    function CheckRequiredData: boolean;
    function SubDivisionOrSuperCategoryUsed: boolean;
    function ProductTagsUsed: boolean;
    function CheckGAid_FlagUsage: boolean;
  end;

var
  dmADO: TdmADO;

implementation

uses uLog, uGlobals, uLocalisedText;

{$R *.dfm}

function TdmADO.ADOUpdatesPending (ADODataSet: TCustomADODataSet): boolean;
//Returns true if the given ADODataset has changes which have not yet been applied to the database i.e.
//this is equivalent to the UpdatesPending property of a TClientDataSet.
//This only only relevant when the ADODataSet is used in batch update mode i.e. LockType=ltBatchOptimistic.
var
  Clone : TADODataSet;
begin
  if not ADODataSet.Active then
  begin
    Result := false;
    exit;
  end;

  Clone := TADODataSet.Create(nil);
  try
    Clone.Clone(ADODataSet);
    Clone.FilterGroup := fgPendingRecords;
    Clone.Filter := '';
    Clone.Filtered := true;
    Result := not (Clone.Bof and Clone.Eof);
    Clone.Close;
  finally
    Clone.Free;
  end;
end;

function TdmADO.CheckAztecDatabase: boolean;
var
  ModuleVersion, MinDBVersion: array[0..25] of char;
begin
  if LoadString(hInstance, 12, ModuleVersion, sizeof(ModuleVersion)) = 0 then
  begin
    ShowMessage('Unable to load version information.' + #13 +
      'Aztec ' + ProductModellingTextName + ' will now terminate');
    Log.event('Unable to load version information.');
    Halt;
  end;

  if LoadString(hInstance, 13, MinDBVersion, sizeof(MinDBVersion)) = 0 then
  begin
    ShowMessage('Unable to load version information.' + #13 +
      'Aztec ' + ProductModellingTextName + ' will now terminate');
    Log.event('Unable to load version information.');
    Halt;
  end;

  Result := True;
end;

function TdmADO.CheckRequiredData: boolean;
begin
  with adoqRun do
  try
    Close;
    SQL.Text := 'SELECT * FROM ac_supplier';
    Open;
    Result := (RecordCount > 0);
    if not Result then
    begin
      ShowMessage('There are no suppliers in the database and' + #13 +
        'Aztec Product Modelling will now terminate.' + #13#10#10 +
        'Please use Base Data to add at least one supplier.' + #10#10);
      Log.Event('There are no suppliers in the database.');
    end;
  finally
    Close;
    SQL.Clear;
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

function TdmADO.ProductTagsUsed: boolean;
begin
  with adoqRun do
  try
    SQL.Text :=
        'IF EXISTS ' +
        '( select t.Id  ' +
        'from ac_Tag t ' +
        'where IsProductTag = 1' +
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


function TdmADO.CheckGAid_FlagUsage: boolean;
begin
  // check configuration if NTFlags should be visible
  with adoqRun do
  try
    SQL.Text :=
        'select [StringValue] ' +
        'from [dbo].[GlobalConfiguration]  ' +
        'where [KeyName] = ''GiftAidCryptoService'' ';
    Open;

    if RecordCount = 0 then
      Result := false
    else
      Result := StrToIntDef(FieldByName('StringValue').AsString, 0) <> 0
  finally
    Close;
  end;
end;

end.
