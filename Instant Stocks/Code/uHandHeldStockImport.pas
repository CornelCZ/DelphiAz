unit uHandHeldStockImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, ExtCtrls, Grids, DBGrids, uData1, ADODB, uADO,
  Wwdbigrd, Wwdbgrid, uLog;

type
  TfrmHandHeldStockCountImport = class(TForm)
    lblHandHeldStockHeader: TLabel;
    rgImportMethods: TRadioGroup;
    btnImport: TButton;
    btnCancel: TButton;
    dsHandHeldImports: TDataSource;
    ADOqHandHeldSessions: TADOQuery;
    wwDBGridHandHeldSessions: TwwDBGrid;
    ADOqRun: TADOQuery;
    lblHint: TLabel;
    ADOqHandHeldSessionsSessionID: TLargeintField;
    ADOqHandHeldSessionsThreadName: TStringField;
    ADOqHandHeldSessionsHoldingZone: TStringField;
    ADOqHandHeldSessionsStartTime: TDateTimeField;
    ADOqHandHeldSessionsEndTime: TDateTimeField;
    ADOqHandHeldSessionsHoldingZone2: TIntegerField;
    procedure btnImportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Procedure ShowValidHandHeldSessions;
    procedure ProcessSelectedImports;
    function  GetSelectedSessionIDs: String;
    Procedure SumSessionStockCounts(ASelectedSessionIDs: String);
    procedure UpdateStockCountsFromImport;
    procedure FormatStockCountsForDisplayGrid;
  public
    { Public declarations }
  end;

Const
  IMPORT_METHOD_OVERWRITE       = 0;
  IMPORT_METHOD_ADD_TO_EXISTING = 1;
  IMPORT_METHOD_UNAUDITED_ONLY  = 2;


procedure DisplayHandHeldImportForm;

implementation

{$R *.dfm}

procedure DisplayHandHeldImportForm;
var
  HandHeldStockImportForm: TfrmHandHeldStockCountImport;
begin
  HandHeldStockImportForm := TfrmHandHeldStockCountImport.Create(nil);

  try
    HandHeldStockImportForm.ShowModal;
  finally
    FreeAndNil(HandHeldStockImportForm);
  end;
end;

procedure TfrmHandHeldStockCountImport.btnImportClick(Sender: TObject);
begin
  log.event('Hand Held Import: Begin - btnImportClick');

  if wwDBGridHandHeldSessions.SelectedList.Count = 0 then
  begin
    ShowMessage('No Hand Held Stock sessions were selected.'+#13+
                'Use the Ctrl + Left mouse button click to select one or more records');
    ModalResult := mrNone;
    Exit;
  end;

  ADOqHandHeldSessions.DisableControls;
  Screen.Cursor := crHourGlass;
  try
    try
      ProcessSelectedImports;
      ShowMessage('Hand Held Import Complete');
    except
      on E: Exception do
      begin
        log.event('Hand Held Import: An exception occurred during import:');
        log.event('    EXCEPTION: '+E.Message);
        ShowMessage('A problem occurred during the Hand Held Import: '+E.Message);
      end;
    end;
  finally
    ADOqHandHeldSessions.EnableControls;
    Screen.Cursor := crDefault;
  end;
  log.event('Hand Held Import: End - btnImportClick');
end;

procedure TfrmHandHeldStockCountImport.ProcessSelectedImports;
begin
  log.event('Hand Held Import: Begin - ProcessSelectedImports');
  SumSessionStockCounts(GetSelectedSessionIDs);
  UpdateStockCountsFromImport;
  FormatStockCountsForDisplayGrid;
  log.event('Hand Held Import: End - ProcessSelectedImports');
end;

function TfrmHandHeldStockCountImport.GetSelectedSessionIDs: String;
var
  i: Integer;
begin
  log.event('Hand Held Import: Begin - GetSelectedSessionIDs');
  Result := '';

  with wwDBGridHandHeldSessions do
  begin
    for i := 0 to SelectedList.Count - 1 do
    begin
      ADOqHandHeldSessions.GotoBookmark(SelectedList.items[i]);
      if i = SelectedList.Count - 1 then
        Result := Result + ADOqHandHeldSessions.FieldByName('SessionID').AsString
      else
        Result := Result + ADOqHandHeldSessions.FieldByName('SessionID').AsString +', ';
    end;
  end;
  log.event('Hand Held Import: End - GetSelectedSessionIDs');
end;

procedure TfrmHandHeldStockCountImport.FormatStockCountsForDisplayGrid;
begin
  log.event('Hand Held Import: Begin - FormatStockCountsForDisplayGrid');

  with ADOqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from AuditCur');
    Open;

    while not Eof do
    begin
      Edit;
      if FieldByName('ActCloseStk').AsString = '' then
        FieldByName('ACount').AsString := ''
      else
        FieldByName('ACount').AsString :=
          data1.dozGallFloatToStr(FieldByName('PurchUnit').AsString, FieldByName('ActCloseStk').AsFloat);
      Post;
      Next;
    end;
    Close;
  end;
  log.event('Hand Held Import: End - FormatStockCountsForDisplayGrid');
end;

procedure TfrmHandHeldStockCountImport.UpdateStockCountsFromImport;
begin
  log.event('Hand Held Import: Begin - UpdateStockCountsFromImport');

  with ADOqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE AuditCur');

    if (rgImportMethods.ItemIndex = IMPORT_METHOD_OVERWRITE)
       or (rgImportMethods.ItemIndex = IMPORT_METHOD_UNAUDITED_ONLY) then
      SQL.Add('SET ActCloseStk = S.StockCount')
    else
      SQL.Add('SET ActCloseStk = ISNULL(ActCloseStk, 0) + S.StockCount');

    SQL.Add('FROM Auditcur A, #TempHandHeldImportCount S');
    SQL.Add('WHERE ((S.HoldingZone = A.HzID) OR (S.HoldingZone = -1 AND A.HzID = 0))');
    SQL.Add('AND A.EntityCode = S.ProductID');

    if rgImportMethods.ItemIndex = IMPORT_METHOD_UNAUDITED_ONLY then
      SQl.Add('AND ISNULL(A.ActCloseStk, 0) = 0');

    ExecSQL;
  end;

  log.event('Hand Held Import: End - UpdateStockCountsFromImport');
end;

procedure TfrmHandHeldStockCountImport.SumSessionStockCounts(
  ASelectedSessionIDs: String);
begin
  log.event('Hand Held Import: Begin - SumSessionStockCounts');
  dmADO.DelSQLTable('#TempHandHeldImportCount');

  with ADOqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT A.HoldingZone, B.ProductID, SUM(B.Count * U.[Base Units] / AC.PurchBaseU) AS StockCount');
    SQL.Add('INTO #TempHandHeldImportCount');
    SQL.Add('FROM StockHandHeldSessions A, StockHandHeldCounts B, ');
    SQL.Add('AuditCur AC, Units U');
    SQL.Add('WHERE A.SessionID = B.SessionID');
    SQL.Add('AND A.SessionID IN ('+ASelectedSessionIDs+')');
    SQL.Add('AND B.UnitName = U.[unit Name]');
    SQL.ADD('AND B.ProductID = AC.EntityCode');
    SQL.Add('AND ((A.HoldingZone = AC.HzID) OR (A.HoldingZone = -1 AND AC.HzID = 0))');
    SQL.Add('GROUP BY A.HoldingZone, B.ProductID');
    ExecSQL;
  end;

  log.event('Hand Held Import: End - SumSessionStockCounts');
end;

procedure TfrmHandHeldStockCountImport.ShowValidHandHeldSessions;
var
  StockRollEndDate: String; //Stock rollover end date
  StockEndDate: String; //Stock end date
begin
  log.event('Hand Held Import: Begin - ShowValidHandHeldSessions');
  StockEndDate     := FormatDateTime('yyyy-mm-dd hh:nn:ss', data1.EDT - 1);
  StockRollEndDate := FormatDateTime('yyyy-mm-dd hh:nn:ss', data1.EDT + 1);

  with ADOqHandHeldSessions do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT S.SessionID, S.HoldingZone , T.TName AS [Thread Name], ');
    SQL.Add('CASE WHEN H.hzName IS NULL THEN ''-'' ELSE H.hzName END AS [Holding Zone], S.StartTime AS [Start Time], ');
    SQL.Add('S.EndTime AS [End Time]');
    SQL.Add('FROM StockHandHeldSessions S');
    SQL.Add(' JOIN Threads T on S.StockThread = T.Tid');
	  SQL.Add(' LEFT OUTER JOIN stkHZs H on S.HoldingZone = H.hzID');
    SQL.Add('WHERE S.StockThread = '   + IntToStr(data1.CurTid));
    SQL.Add('AND S.StartTime > '     + QuotedStr(StockEndDate));
    SQL.Add('AND S.StartTime <= '    + QuotedStr(StockRollEndDate));
    SQL.Add('AND S.EndTime > '       + QuotedStr(StockEndDate));
    SQL.Add('AND S.EndTime <= '      + QuotedStr(StockRollEndDate));

    if data1.curByHZ then
      SQL.Add('AND S.HoldingZone > 0')
    else
      SQL.Add('AND (S.HoldingZone <= 0)');

    Open;
  end;
  log.event('Hand Held Import: End - ShowValidHandHeldSessions');
end;

procedure TfrmHandHeldStockCountImport.FormShow(Sender: TObject);
begin
  log.event('Hand Held Import: Begin - FormShow');
  try
    ShowValidHandHeldSessions;
  except
    on E: exception do
    begin
      log.event('An exception occurred retreiving the HandHeld sessions: ' + E.Message);
      ShowMessage('Could not retreive Hand Held Stock Counts: ' + E.Message);
      Exit;
    end;
  end;
  log.event('Hand Held Import: End - FormShow');
end;

end.
