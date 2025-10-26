unit uADO;

interface

uses
  SysUtils, Classes, DB, ADODB, DBTables, dADOAbstract, ppReport, ppViewr, Forms, Math, Dialogs;

type
  TdmADO = class(TdmADOAbstract)
    cmdPrunePurchase: TADOCommand;
    qryLastStockDate: TADOQuery;
    qryUnstockedDiv: TADOQuery;
    adoSupplierMask: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure BatchMove(theSource, theDestination: TDataSet; Mappings: TStrings;
      Mode: TBatchMode = batAppend);
    procedure ReportPreviewFormCreate(Sender: TObject);
    function RemoveQuotes(AString: string): string;
    procedure GetCurrentSupplierMask(supplier: string; var maskID: SmallInt; var theMask: String);
    function GetSupplierMask(supplier: string; maskID: Smallint): String;
    function DeliveryDateValid(DeliveryDate: TDateTime): Boolean;
  end;

var
  dmADO: TdmADO;

implementation

uses uADOUtils, uGlobals, uLog, uSetupRBuilderPreview;

{$R *.dfm}

{ TdmADO }

procedure TdmADO.BatchMove(theSource, theDestination: TDataSet; Mappings: TStrings;
  Mode: TBatchMode);
var
  BatchMove: TADOBatchMove;
begin
  BatchMove := TADOBatchMove.Create(nil);

  try
    BatchMove.Source := theSource;
    BatchMove.Destination := theDestination;
    BatchMove.Mappings := Mappings;
    BatchMove.Mode := Mode;
    BatchMove.Execute;
  finally
    BatchMove.Free;
  end;
end;

function TdmADO.RemoveQuotes(AString: string): string;
begin
  Result := StringReplace(AString, '''', '''''', [rfReplaceAll]);
end;

procedure TdmADO.ReportPreviewFormCreate(Sender: TObject);
var
  papNames : TStringList;
  s1, s2 : string;
  i : integer;
begin
  papNames := TStringList.Create;

  papNames.Text := TppReport(sender).PrinterSetup.PaperNames.Text;
  if UKUSMode ='UK' then
    s2:='A4'
  else
    s2:='Letter';

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

  TppReport(sender).PrinterSetup.PaperName := s2;
  papNames.Free;

  SetupRBuilderPreview(TppReport(Sender));
end;

procedure TdmADO.GetCurrentSupplierMask(supplier: string; var maskID: SmallInt; var theMask: String);
var
  ParamCheck_Old: Boolean;
begin
  with adoSupplierMask do
  begin
    ParamCheck_Old := ParamCheck;
    ParamCheck := False;
    try
      Close;
      SQL.Clear;
      SQL.Add('SELECT MaskID, Mask FROM [SupplierMask]');
      SQL.Add('WHERE [Supplier Name] = ' + QuotedStr(supplier));
      SQL.Add('AND CurrentMask = 1');
      Open;
      if (RecordCount > 0) then
      begin
        theMask := FieldByName('Mask').Value;
        maskID := FieldByName('MaskID').Value;
      end
      else
      begin
        theMask := '';
        maskID := 0;
      end;
    finally
      ParamCheck := ParamCheck_Old;
    end;
  end;
end;

function TdmADO.GetSupplierMask(supplier: string; maskID: Smallint): String;
begin
  if ( maskID = 0 ) then
    Result := ''
  else
    with adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT Mask FROM [SupplierMask]');
      SQL.Add('WHERE [Supplier Name] = ' + QuotedStr(supplier));
      SQL.Add('AND MaskID = ' + IntToStr(maskID));
      Open;
      Result := FieldByName('Mask').Value;
    end;
end;

function TdmADO.DeliveryDateValid (DeliveryDate : TDateTime): Boolean;
var
  UKUSDateFormat: string;
  LastStockDate: TDateTime;
begin
  Result := True;

  if UKUSmode = 'UK' then
    UKUSDateFormat := 'dd/mm/yyyy'
  else
    UKUSDateFormat := 'mm/dd/yyyy';

  with qryLastStockDate do
  begin
    try
      Open;
      LastStockDate := FieldByName('LastStock').AsDateTime;
      Close;
    except
      on E: Exception do
      begin
        log.Event('fnewinvdlg; DateValid: getting last stocktake date. ' + E.Message + '; ' + qryLastStockDate.SQL.Text);
        raise;
      end;
    end;
  end;

  // Compare dates, but strip off time part.
  if floor(DeliveryDate) <= floor(LastStockDate) then
  begin
    // if unstocked divisions exist then allow the new invoice to be created.
    try
      qryUnstockedDiv.Open;
      if qryUnstockedDiv.RecordCount = 0 then
      begin
        ShowMessage('Date entered must be after last stocktake (' +
          FormatDateTime(UKUSDateFormat, LastStockDate) + ')');
        Result := false;
      end;
      qryUnstockedDiv.Close;
    except
      on E: Exception do
      begin
        log.Event('fnewinvdlg; DateValid: checking against last stocktake date. ' + E.Message + '; ' + qryUnstockedDiv.SQL.Text);
        raise;
      end;
    end;
  end;

  if floor(DeliveryDate) > floor(date) then
  begin
    ShowMessage('Date cannot be in the future.');
    result := false;
  end;
end;
// End Job 16273

end.
