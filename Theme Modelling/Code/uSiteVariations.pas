unit uSiteVariations;

interface

// TODO: match export sort to grid sort, fall back to site ref sort?

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, StdCtrls, Grids, Wwdbigrd, Wwdbgrid, DBCtrls, Mask,
  wwdbedit, Wwdotdot, Wwdbcomb, adodb, db, wwdblook, uGridSortHelper,
  ExtCtrls;

const
  CurrentVariation = 0;
  CreateNewVariation = 1;
  DebugSiteVariations = false;

type
  TVariationSummary = packed record
    VarCount, VarChecksum, VarPanelCount, VarPanelChecksum: integer;
  end;

  TColumnLookupData = packed record
    ColumnID: integer;
    ColumnName: string;
    FieldName: string;
    DisplaySize: integer;
    DisplaySizePixels: integer;
    LookupQuery: TADOQuery;
    LookupControl: TwwDBLookupCombo;
    DataField: TStringField;
  end;

  TSiteVariations = class(TForm)
    dbgVariationGrid: TwwDBGrid;
    ActionList1: TActionList;
    cbPickEffectiveDate: TComboBox;
    Label1: TLabel;
    btClose: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ExportVariations: TAction;
    ImportVariations: TAction;
    RevertChanges: TAction;
    SaveChanges: TAction;
    CloseForm: TAction;
    ShowForm: TAction;
    CancelFutureChange: TAction;
    Button5: TButton;
    Image1: TImage;
    Label2: TLabel;
    lbVersionWarning: TLabel;
    adoqLiveSiteVariationsRowStats: TADOQuery;
    procedure CloseFormExecute(Sender: TObject);
    procedure ShowFormExecute(Sender: TObject);
    procedure ExportVariationsExecute(Sender: TObject);
    procedure ImportVariationsExecute(Sender: TObject);
    procedure SaveRevertDataUpdate(Sender: TObject);
    procedure RevertChangesExecute(Sender: TObject);
    procedure SaveChangesExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbPickEffectiveDateChange(Sender: TObject);
    procedure CancelFutureChangeUpdate(Sender: TObject);
    procedure CancelFutureChangeExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgVariationGridDrawDataCell(Sender: TObject;
      const Rect: TRect; Field: TField; State: TGridDrawState);
    procedure dbgVariationGridRowChanged(Sender: TObject);
    procedure dbgVariationGridMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure ActionList1Execute(Action: TBasicAction;
      var Handled: Boolean);
    procedure dbgVariationGridCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
  private
    LastHintGridPos: TGridCoord;
    TopRow: integer;
    FutureChangeCells: array of string;
    NonVariationSites: array of integer;
    GridSortHelper: TGridSortHelper;
    // Effective date as integer, may also be "CurrentVariation" (0), the default
    CurrentEffectiveDate, LastEffectiveDate: integer;
    OldItemIndex: integer;
    DataModified: boolean;
    VariationSummary: TVariationSummary;

    CrosstabColumnCreateList,
    CrosstabColumnList,
    CrosstabColumnSelectList,
    CrosstabColumnSafeNameList,
    CrosstabColumnSelectSafeNameList,
    CrosstabColumnPanelIdEqualsSafeNameList: String;

    ColumnLookupData: array of TColumnLookupData;

    InitialiseSQL,
    CreateTempTablesSQL,
    LoadDataSQL,
    CreateImportExportTableSQL,
    ImportErrorsSQL,
    SaveSQL: string;

    ADOCmd: TADOCommand;

    OriginalCaption: String;

    procedure StartStopWatch;
    procedure StopStopWatch;
    procedure PostChanges;
    procedure PromptSaveChanges;
    procedure CreateTempTables;
    procedure LoadTempTables;
    procedure LoadData;
    procedure SaveData;
    procedure ClearLookupData;
    procedure HandleDatasetAfterEdit(Sender: TDataset);
    procedure BuildEffectiveDateCombo;
		function GetEffectiveDateIndex(input: integer): integer;
    procedure SetEffectiveDateIndex(input: integer; UpdateGUI: boolean);
    procedure HandleDatasetAfterOpen(Sender: TDataset);
    procedure HandleWillExecute(Connection: TADOConnection;
      var CommandText: WideString; var CursorType: TCursorType;
      var LockType: TADOLockType; var CommandType: TCommandType;
      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
    const Command: _Command; const Recordset: _Recordset);
    procedure SetCurrentEffectiveDate(Input: integer);
    procedure BuildImportExportTable(tableName: String);
    function CheckImportedData(importTable: string): boolean;
    procedure SetVariationCellText(Sender: TField; const Text: String);
    procedure GetLiveSiteVariationsRowStats(out MaxLength: Integer; out AvgLength: Integer);
    procedure UpdateRowSizeWarningIfRequired;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

const USE_DEFAULT = '<n/a>';


var
  SiteVariations: TSiteVariations;

implementation

uses udmThemeData, math, uExcelExportImport, useful, uPickFutureDate,
  uSiteVariationsImportErrors, uAztecLog, uFormNavigate, StrUtils;

{$R *.dfm}

function GetSQLDateOrZero(Input: integer): string;
begin
  if Input = 0 then
    Result := '0'
  else
    Result := GetSQLDate(Input);
end;


function GetNearestEffectiveDate(tablename: string; effectivedate: integer): integer;
begin
  // Treats TDates as integers
  with dmThemeData.adoqRun do
  begin
    SQL.Text := Format(
      'SELECT MAX(EffectiveDate) as Result FROM %s WHERE EffectiveDate <= %s',
      [TableName, GetSQLDateOrZero(EffectiveDate)]
    );
    Open;
    // Will return 0 for a null result
    Result := Round(FieldByName('Result').AsDateTime);
    Close;
  end;
end;


// </MoveToCommonCode>

type
  TwwDBGridHack = class(TwwDBGrid)
  end;

procedure TSiteVariations.ClearLookupData;
var
  i: integer;
begin
  // TwwDBGrid is missing the required notifications for it
  // to successfully free up the CurrentCustomEdit - was obviously
  // only written to support design time setting of custom edit controls.
  TwwDBGridHack(dbgVariationGrid).currentcustomedit := nil;

  dbgVariationGrid.DataSource.DataSet.Cancel;
  dbgVariationGrid.Selected.Clear;
  for i := Low(ColumnLookupData) to high(ColumnLookupData) do
  with ColumnLookupData[i] do
  begin
    if ColumnID <> 0 then
    begin
      ColumnID := 0;
      LookupControl.Parent := nil;
      Self.RemoveControl(LookupControl);
      dbgVariationGrid.DataSource.DataSet.Fields.Remove(DataField);
      DataField.Free;
      LookupQuery.Free;
      LookupControl.Free;
    end;
  end;
end;

procedure TSiteVariations.CloseFormExecute(Sender: TObject);
begin
  Close;
end;

constructor TSiteVariations.Create(AOwner: TComponent);
begin
  inherited;
  VariationSummary.VarCount := -1;
  VariationSummary.VarPanelCount := -1;

  InitialiseSQL := GetStringResource('Initialise', 'TEXT');
  LoadDataSQL := GetStringResource('LoadData', 'TEXT');
  CreateTempTablesSQL := GetStringResource('CreateTempTables', 'TEXT');
  CreateImportExportTableSQL := GetStringResource('CreateImportExportTable', 'TEXT');
  ImportErrorsSQL := GetStringResource('ImportErrors', 'TEXT');
  SaveSQL := GetStringResource('Save', 'TEXT');

  ADOCmd := TADOCommand.Create(nil);
  ADOCmd.Connection := dmThemeData.AztecConn;
  ADOCmd.CommandTimeout := 0;
  ADOCmd.ExecuteOptions := [eoExecuteNoRecords];

  OriginalCaption := Self.Caption;
end;

destructor TSiteVariations.Destroy;
begin
  ADOCmd.Free;
  inherited;
end;

procedure TSiteVariations.LoadData;
var
  TmpSummary: TVariationSummary;
  i: integer;
  CWidth: integer;
  bmk: Pointer;
  columnName: string;
  safeColumnName: string;

  function DelimitColumnNameIfNeccesary(const columnName: string): string;
  begin
    if columnName[1] in ['0'..'9'] then
      Result := '[' + columnName + ']'
    else
      Result := columnName;
  end;

begin
  dmThemeData.BeginHourglass;
  bmk := dmThemeData.qEditSiteVariations.GetBookmark;
  dmThemeData.qEditSiteVariations.Active := false;

  with dmThemeData.adoqRun, TmpSummary do
  begin
    SQL.Text :=
      'select count(*) as VarCount, checksum_agg(panelid) as VarChecksum '+
      'from (select distinct checksum(themepanel.panelid, themepanel.name) as panelid from themepanelvariation join themepanel on themepanelvariation.panelid = themepanel.panelid) a ';

    Open;
    VarCount := FieldByName('VarCount').AsInteger;
    VarChecksum := FieldByName('VarChecksum').AsInteger;

    SQL.Text :=
      'select count(*) as VarPanelCount, checksum_agg(checksum(variationpanelid, name)) as VarPanelChecksum from themepanelvariation join themepanel on themepanelvariation.variationpanelid = themepanel.panelid';
    Open;
    VarPanelCount := FieldByName('VarPanelCount').AsInteger;
    VarPanelChecksum := FieldByName('VarPanelChecksum').AsInteger;
    Close;
  end;

  // Check for changes to variation data, prevents having to redo schema
  // manipulation of temporary editing table
  if (TmpSummary.VarCount <> VariationSummary.VarCount)
    or (TmpSummary.VarChecksum <> VariationSummary.VarChecksum)
    or (TmpSummary.VarPanelCount <> VariationSummary.VarPanelCount)
    or (TmpSummary.VarPanelChecksum <> VariationSummary.VarPanelChecksum) then
  begin
    ClearLookupData;

    ADOCmd.Commandtext := InitialiseSQL;
    ADOCmd.Execute;

    with dmThemeData.adoqRun do
    begin
      SQL.Text := 'select * from #CrossTabColumns order by ColumnID';
      Open;

      CrosstabColumnCreateList := '';
      CrosstabColumnList := '';
      CrosstabColumnSelectList := '';
      CrosstabColumnSafeNameList := '';
      CrosstabColumnSelectSafeNameList := '';
      CrosstabColumnPanelIdEqualsSafeNameList := '';

      while not (EOF) do
      begin
        columnName :=  '[' + FieldByName('ActualId').AsString + ']';
        safeColumnName := DelimitColumnNameIfNeccesary(FieldByName('SafeName').AsString);

        CrosstabColumnCreateList := CrosstabColumnCreateList + ',' + columnName + ' varchar(50)';
        CrosstabColumnList := CrosstabColumnList +  ',' + columnName;
        CrosstabColumnSelectList := CrosstabColumnSelectList + ',' + columnName + ' AS ' + columnName;
        CrosstabColumnSafeNameList := CrosstabColumnSafeNameList + ',' + safeColumnName;
        CrosstabColumnSelectSafeNameList :=  CrosstabColumnSelectSafeNameList + ',' + columnName + ' AS ' + safeColumnName;
        CrosstabColumnPanelIdEqualsSafeNameList :=  CrosstabColumnPanelIdEqualsSafeNameList + ' AND a.' + columnName + ' = b.' + safeColumnName;
        Next;
      end;
    end;

    delete(CrosstabColumnCreateList, 1, 1);  // Remove initial comma
    delete(CrosstabColumnList, 1, 1);
    delete(CrosstabColumnSelectList, 1, 1);
    delete(CrosstabColumnSafeNameList, 1, 1);
    delete(CrosstabColumnSelectSafeNameList, 1, 1);


    // setup display/pick lists in grid
    with dbgVariationGrid do
    begin
      CWidth := Canvas.TextWidth('0');
      Selected.Clear;
      Selected.Add('SiteName'+#9'20'#9+'Site Name');
      Selected.Add('SiteRef'#9'10'#9'Site Ref');
      Selected.Add('AreaName'#9'20'#9'Area Name');

      with dmThemeData.adoqRun do
      begin
        SQL.Text := 'select * from #CrossTabColumns order by ColumnID';
        Open;
        SetLength(ColumnLookupData, RecordCount);
        while not (EOF) do
        with ColumnLookupData[FieldByName('ColumnID').AsInteger-1] do
        begin
          ColumnID := FieldByName('ColumnID').AsInteger;
          ColumnName := FieldByName('Name').AsString;
          FieldName := FieldByName('ActualId').AsString;
          LookupQuery := TADOQuery.Create(self);
          LookupQuery.Name := 'LookupQuery' + FieldName;
          LookupQuery.Connection := dmThemeData.AztecConn;
          LookupQuery.SQL.Text :=
          Format('SELECT VariationPanelName AS Name FROM #VariationPanelLookup WHERE ParentPanelId = %1:s ORDER BY Name', [USE_DEFAULT, FieldName]);
          DisplaySizePixels := Canvas.TextWidth(ColumnName);
          LookupQuery.Open;
          while not LookupQuery.Eof do
          begin
            // Uses RowHeights[0] as an estimate of the combobox dropdown button width                                                   ;
            DisplaySizePixels := Max(DisplaysizePixels, RowHeights[0]+Canvas.TextWidth(LookupQuery.FieldByName('Name').AsString));
            LookupQuery.Next;
          end;
          DisplaySize := DisplaySizePixels div CWidth;

          LookupControl := TwwDBLookupCombo.Create(self);
          LookupControl.Name := 'LookupControl' + FieldName;
          LookupControl.Parent := self;
          LookupControl.Top := ColumnID * 30;
          LookupControl.Style := csDropDownList;
          LookupControl.DataSource := dbgVariationGrid.DataSource;
          LookupControl.DataField := FieldName;
          LookupControl.LookupTable := LookupQuery;
          LookupControl.LookupField := 'Name';
          LookupControl.Selected.Text := 'Name'#9'7'#9'Name';
          LookupControl.AllowClearKey := True;

          DataField := TStringField.Create(nil);
          DataField.Name := 'Field'+FieldName;
          DataField.Size := 50;
          DataField.FieldName := FieldName;
          DataField.FieldKind := fkData;
          DataField.Visible := True;
          DataField.DataSet := dbgVariationGrid.DataSource.DataSet;
          DataField.OnSetText := SetVariationCelltext;

          dbgVariationGrid.Selected.Add(DataField.FieldName+#9+IntToStr(DisplaySize)+#9+ColumnName);
          dbgVariationGrid.SetControlType(DataField.FieldName, fctCustom, LookupControl.Name);
          Next;
        end;
      end;

      ApplySelected;
      Invalidate;

      for i := low(ColumnLookupData) to high(ColumnLookupData) do
      with ColumnLookupData[i] do
      begin
        LookupControl.DropDownWidth :=
          dbgVariationGrid.ColWidthsPixels[i+3];
      end;
    end;
    CreateTempTables();
    VariationSummary := TmpSummary;
  end;

  LoadTempTables();
  dmThemeData.qEditSiteVariations.AfterEdit := HandleDatasetAfterEdit;
  DataModified := False;
  dmThemeData.qEditSiteVariations.Active := true;
  if dmThemeData.qEditSiteVariations.BookmarkValid(Bmk) then
    dmThemeData.qEditSiteVariations.GotoBookmark(Bmk);
  dmThemeData.qEditSiteVariations.FreeBookmark(bmk);
  dmThemeData.EndHourGlass;

  UpdateRowSizeWarningIfRequired;
end;

procedure TSiteVariations.CreateTempTables();
begin
  ADOCmd.CommandText := StringReplace(CreateTempTablesSQL, '<CrosstabColumnCreateList>', CrosstabColumnCreateList, [rfReplaceAll]);
  ADOCmd.Execute;
end;

procedure TSiteVariations.LoadTempTables();
begin
  //TODO Create a MultipleStringReplace() method
  with ADOCmd do
  begin
    CommandText := StringReplace(LoadDataSQL, '<LastEffectiveDate>', GetSQLDateOrZero(LastEffectiveDate), [rfReplaceAll]);
    CommandText := StringReplace(CommandText, '<CurrentEffectiveDate>', GetSQLDateOrZero(CurrentEffectiveDate), [rfReplaceAll]);
    CommandText := StringReplace(CommandText, '<CrosstabColumnList>', CrosstabColumnList, [rfReplaceAll]);
    CommandText := StringReplace(CommandText, '<CrosstabColumnSelectList>', CrosstabColumnSelectList, [rfReplaceAll]);
    Execute;
  end;
end;

procedure TSiteVariations.SaveData;
begin
  with ADOCmd do
  begin
    CommandText := StringReplace(SaveSQL, '<EffectiveDate>', GetSQLDateOrZero(CurrentEffectiveDate), [rfReplaceAll]);
    CommandText := StringReplace(CommandText, '<CrosstabColumnList>', CrosstabColumnList, [rfReplaceAll]);
    Execute;
  end;

  DataModified := False;
end;

procedure TSiteVariations.ShowFormExecute(Sender: TObject);
begin
  Log('Form Show ' + Caption);
  if DebugSiteVariations then
    dmthemedata.aztecconn.OnWillExecute := HandleWillExecute;
  dmThemeData.AztecConn.Execute('EXEC dbo.Theme_ApplyAnyFutureSiteVariations');
  BuildEffectiveDateCombo;
  SetEffectiveDateIndex(0, True);
  LastEffectiveDate := 0;
  LoadData;
  FocusControl(cbPickEffectiveDate);
  GridSortHelper.Reset;
end;

procedure TSiteVariations.ExportVariationsExecute(Sender: TObject);
var ExportTable: string;
begin
  Log('Export site variations started');

  ExportTable := Format('##%dSiteVariations_Export', [dmThemeData.AztecConnSPID]);
  dmThemeData.BeginHourglass;

  try
    PostChanges;
    BuildImportExportTable(ExportTable);
    with TExcelExportImport.Create do
    try
      HandleLogging := uAztecLog.Log;
      CopyToClipBoard(dmThemeData.AztecConn, ExportTable);
    finally
      Free;
    end;
  finally
    with dmThemeData.adoqRun do
    begin
      SQL.Text := Format('IF OBJECT_ID(''tempdb..%0:s'') IS NOT NULL DROP TABLE %0:s', [ExportTable]);
      ExecSQL;
    end;
    dmThemeData.EndHourglass;
  end;

  Log('Export site variations finished');
end;

procedure TSiteVariations.BuildImportExportTable(tableName: String);
begin
  with ADOCmd do
  begin
    CommandText := StringReplace(CreateImportExportTableSQL, '<TableName>', tableName, [rfReplaceAll]);
    CommandText := StringReplace(CommandText, '<CrosstabColumnSelectSafeNameList>', CrosstabColumnSelectSafeNameList, [rfReplaceAll]);;
    Execute;
  end;
end;

function TSiteVariations.CheckImportedData(importTable: string): boolean;
begin
  Result := True;

  try
    // Create table #ImportErrors (SiteCode, ColumnId, Name, VariationPanelName) containing any invalid VariationPanelNames
    with ADOCmd do
    begin
      CommandText := StringReplace(ImportErrorsSQL, '<USE_DEFAULT>', QuotedStr(USE_DEFAULT), [rfReplaceAll]);
      CommandText := StringReplace(CommandText, '<ImportTable>', importTable, [rfReplaceAll]);;
      CommandText := StringReplace(CommandText, '<CrosstabColumnSafeNameList>', CrosstabColumnSafeNameList, [rfReplaceAll]);;
      Execute;
    end;

    if dmThemeData.IsEmptyTable('#ImportErrors') then
      Exit;

    Result := False;
    Log('Invalid panel names found in site variations import');

    // Show message with options [View Details] and [Ok]
    // View Details brings up a report showing all "mistyped" values for each column, and all sites
    // that had at least one mistyped value.
    with TSiteVariationsImportErrors.Create(nil) do try
      ShowModal;
    finally
      Free;
    end;
  finally
    dmThemeData.DelSQLTable('#ImportErrors')
  end;
end;

procedure TSiteVariations.ImportVariationsExecute(Sender: TObject);
var
  ErrorList: TStringList;
  ImportTable: string;
  NumChangedSites: integer;
begin
  Log('Import site variations started');
  dmThemeData.BeginHourglass;
  try
    PostChanges;
    ImportTable := Format('##%dSiteVariations_Import', [dmThemeData.AztecConnSPID]);

    BuildImportExportTable(ImportTable);

    with TExcelExportImport.Create do try
      ErrorList := TStringList.Create;
      PasteFromClipBoard(dmThemeData.AztecConn, ImportTable, 'SiteCode', 'SiteRef,SiteName,AreaName', CrosstabColumnSafeNameList, '', ErrorList, [], CrosstabColumnSafeNameList);
      if ErrorList.Count > 0 then
      begin
        Log('Errors in Site Variations import:');
        Log(ErrorList.Text);
        Exit;
      end;
    finally
      ErrorList.Free;
      Free;
    end;

    if CheckImportedData(ImportTable) then
    begin
      with dmThemeData.adoqRun do
      try
        SQL.Clear;
        SQL.Add('SELECT count(*) as NumChanges from #EditSiteVariations a');
        SQL.Add('LEFT JOIN ' + ImportTable + ' b');
        SQL.Add('ON a.SiteCode = b.SiteCode ' + CrosstabColumnPanelIdEqualsSafeNameList);
        SQL.Add('WHERE b.SiteCode is null');
        Open;

        NumChangedSites := 0;
        DataModified := False;
        if not EOF then
          NumChangedSites := FieldByName('NumChanges').Asinteger;
      finally
        Close;
      end;

      if NumChangedSites > 0 then
      begin
        dmThemeData.adocRun.CommandText := Format(
          'DELETE #EditSiteVariations FROM #EditSiteVariations a JOIN %0:s b ON a.SiteCode = b.SiteCode ' +
          'INSERT #EditSiteVariations SELECT SiteCode,SiteName,SiteRef,AreaName, %1:s FROM %0:s',
          [ImportTable, CrosstabColumnSafeNameList]);
        dmThemeData.adocRun.Execute;

        DataModified := True;

        dmThemeData.qEditSiteVariations.Requery;
        Log(Format('Import site variations completed successfully (%d sites had changes)', [NumChangedSites]));
      end
      else
      begin
        MessageDlg('No changes to site variations were detected on import.',
          mtInformation,
          [mbOK],
          0);
        Log('No changes detected on import site variations.');
      end;
    end;
  finally
    dmThemeData.adocRun.CommandText := Format('IF OBJECT_ID(''tempdb..%0:s'') IS NOT NULL DROP TABLE %0:s', [ImportTable]);
    dmThemeData.adocRun.Execute;
    dmThemeData.EndHourglass;
  end;

end;

procedure TSiteVariations.HandleDatasetAfterEdit(Sender: TDataset);
begin
  DataModified := True;
end;

procedure TSiteVariations.SaveRevertDataUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := DataModified;
end;

procedure TSiteVariations.RevertChangesExecute(Sender: TObject);
var
  bmk: pointer;
begin
  dmThemeData.BeginHourglass;
  try
    if DebugSiteVariations then
      StartStopWatch;
    dmThemeData.BeginHourglass;
    bmk := dmThemeData.qEditSiteVariations.GetBookmark;
    dmThemeData.qEditSiteVariations.Active := false;
    dmThemeData.AztecConn.Execute('delete #EditSiteVariations insert #EditSiteVariations select * from #EditSiteVariations_Backup');
    DataModified := False;
    dmThemeData.qEditSiteVariations.Active := true;
    dmThemeData.qEditSiteVariations.GotoBookmark(bmk);
    dmThemeData.qEditSiteVariations.FreeBookmark(bmk);
    dmThemeData.EndHourglass;
    if DebugSiteVariations then
      StopStopWatch;
  finally
    dmThemeData.EndHourglass;
  end;
end;

procedure TSiteVariations.SaveChangesExecute(Sender: TObject);
begin
  dmThemeData.BeginHourglass;
  try
    if DebugSiteVariations then
      StartStopWatch;
    PostChanges;
    SaveData;
    if DebugSiteVariations then
      StopStopWatch;
  finally
    dmThemeData.EndHourglass;
  end;
end;

procedure TSiteVariations.PostChanges;
begin
  If dmThemeData.qEditSiteVariations.State in [dsInsert, dsEdit] then
    dmThemeData.qEditSiteVariations.Post;
end;

procedure TSiteVariations.PromptSaveChanges;
begin
  if DataModified then
    if MessageDlg('Save changes?', mtConfirmation, [mbYes, MbNo], 0) = mrYes then
      SaveChanges.Execute
    else
      RevertChanges.Execute;
end;

procedure TSiteVariations.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PromptSaveChanges;
  DataModified := false;
  if DebugSiteVariations then
    dmThemeData.AztecConn.OnWillExecute := nil;
  Log('Form Close ' + Caption);
  Nav.MoveBack;
end;

procedure TSiteVariations.BuildEffectiveDateCombo;
begin
  with dmThemeData.adoqRun do
  begin
    SQL.Text := 'select distinct EffectiveDate from ThemeSiteVariationFuture order by EffectiveDate asc';
    Open;
    cbPickEffectiveDate.Clear;
    cbPickEffectiveDate.Items.AddObject('Current', TObject(CurrentVariation));
    while not Eof do
    begin
      cbPickEffectiveDate.Items.AddObject(DateToStr(FieldByName('EffectiveDate').AsDateTime), TObject(Trunc(FieldByName('EffectiveDate').AsDateTime)));
      Next;
    end;
    Close;
    cbPickEffectiveDate.Items.AddObject('<Create New>', TObject(CreateNewVariation));
  end;
end;

procedure TSiteVariations.cbPickEffectiveDateChange(Sender: TObject);
var
  NewItemIndex: integer;
  NewEffectiveDate: integer;
begin
  if DebugSiteVariations then
    StartStopWatch;
  NewItemIndex := cbPickEffectiveDate.ItemIndex;
  if Integer(cbPickEffectiveDate.Items.Objects[NewItemIndex]) <> CurrentEffectiveDate then
  begin
    cbPickEffectiveDate.ItemIndex := OldItemIndex;
    NewEffectiveDate := Integer(cbPickEffectiveDate.Items.Objects[NewItemIndex]);
    PromptSaveChanges;
    if NewEffectiveDate = CreateNewVariation then
    begin
      // Prompt for date
      with TPickFutureDate.Create(nil) do try
        dtpFutureDate.MinDate := Trunc(Date) + 1;
        case ShowModal of
          mrOk:
            NewEffectiveDate := Trunc(dtpFutureDate.date);
        else
          abort;
        end;
      finally
        free;
      end;
      if DebugSiteVariations then
        StartStopWatch;

      // Find nearest "snapshot" prior to effective date, or 0 for current
      // If the new snapshot is identical, no need to reload

      SetCurrentEffectiveDate(GetNearestEffectiveDate('ThemeSiteVariationFuture', NewEffectiveDate));
      LoadData;
      SetCurrentEffectiveDate(NewEffectiveDate);

      Log('Create new Site Variations snapshot for '+DateToStr(NewEffectiveDate));

      dmThemeData.AztecConn.Execute(
        Format('if not exists(select * from ThemeSiteVariationFuture where EffectiveDate = %s) '+
          'insert ThemeSiteVariationFuture (EffectiveDate) '+
          'select %s',
          [GetSQLDateOrZero(NewEffectiveDate), GetSQLDateOrZero(NewEffectiveDate)]
        )
      );

      // Add to combo box, by rebuilding it then scanning for our change
      BuildEffectiveDateCombo;
      NewItemIndex := GetEffectiveDateIndex(NewEffectiveDate);
    end
    else
    begin
      Log('Load Site Variations snapshot for '+DateToStr(NewEffectiveDate));
      SetCurrentEffectiveDate(NewEffectiveDate);
      LoadData;
    end;
  end;
  cbPickEffectiveDate.ItemIndex := NewItemIndex;
  OldItemIndex := NewItemIndex;
  if DebugSiteVariations then
    StopStopWatch;
end;

procedure TSiteVariations.CancelFutureChangeUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := CurrentEffectiveDate <> 0;
end;

procedure TSiteVariations.CancelFutureChangeExecute(Sender: TObject);
var
  TmpSelectedDate: integer;
begin
  if MessageDlg(Format('This action will cancel the scheduled change for %s.'#13#10+
    'Are you sure?', [DateToStr(CurrentEffectiveDate)]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if CurrentEffectiveDate = 0 then
      raise Exception.Create('Bad current date selection in CancelFutureChangeExecute');
    TmpSelectedDate := CurrentEffectiveDate;
    DataModified := False;
    dmThemeData.adoqRun.SQL.Text :=
      Format(
        'declare @PivotDate datetime '+
        'set @PivotDate = %s '+
        'begin transaction '+
        'delete themesitevariation '+
        'where effectivedate = @pivotdate '+
        'delete themesitevariationfuture '+
        'where effectivedate = @pivotdate '+
        'delete themesitevariation '+
        'from themesitevariation tsvmain '+
        'join ( '+
        '  select post.* '+
        '  from  ( '+
        '    select sitecode, panelid, min(effectivedate) as effectivedate '+
        '    from themesitevariation tsv '+
        '    where effectivedate > @pivotdate '+
        '    group by sitecode, panelid '+
        '  ) post '+
        '  join themesitevariation a '+
        '    on a.sitecode = post.sitecode and a.panelid = post.panelid and a.effectivedate = post.effectivedate '+
        '  join ( '+
        '    select sitecode, panelid, max(effectivedate) as effectivedate '+
        '    from themesitevariation tsv '+
        '    where effectivedate < @pivotdate '+
        '    group by sitecode, panelid '+
        '  ) pre on post.sitecode = pre.sitecode and post.panelid = pre.panelid '+
        '  join themesitevariation b '+
        '    on pre.sitecode = b.sitecode and pre.panelid = b.panelid and pre.effectivedate = b.effectivedate '+
        '  where b.variationpanelid = a.variationpanelid '+
        ') sub '+
        '  on tsvmain.sitecode = sub.sitecode and tsvmain.panelid = sub.panelid and tsvmain.effectivedate = sub.effectivedate '+
        'commit transaction ', [GetSQLDate(TmpSelectedDate)]);
    dmThemeData.adoqrun.ExecSQL;
    BuildEffectiveDateCombo;
    SetEffectiveDateIndex(GetEffectiveDateIndex(GetNearestEffectiveDate('ThemeSiteVariationFuture', TmpSelectedDate)), False);
    SetCurrentEffectiveDate(GetNearestEffectiveDate('ThemeSiteVariationFuture', TmpSelectedDate));
    LoadData;
  end;
end;

function TSiteVariations.GetEffectiveDateIndex(input: integer): integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to Pred(cbPickEffectiveDate.Items.Count) do
  if Integer(cbPickEffectiveDate.Items.Objects[i]) = input then
  begin
    Result := i;
    break;
  end;

end;

procedure TSiteVariations.SetEffectiveDateIndex(input: integer;
  UpdateGUI: boolean);
begin
  cbPickEffectiveDate.ItemIndex := input;
  if UpdateGUI then
    cbPickEffectiveDate.OnChange(cbPickEffectiveDate)
  else
    OldItemIndex := input;
end;

procedure TSiteVariations.FormCreate(Sender: TObject);
var
  TmpCount: integer;
begin
  GridSortHelper := TGridSortHelper.Create;
  GridsortHelper.Initialise(dbgVariationGrid);
  dmThemeData.qEditSiteVariations.AfterOpen := Self.HandleDatasetAfterOpen;
  with dmThemeData.adoqRun do
  begin
    SQL.Text := 'select SiteCode from commsversions where dbo.fn_strVerToInt64(DBVersion) < dbo.fn_strVerToInt64(''2.9.3.0'')';
    Open;
    SetLength(NonVariationSites, RecordCount);
    if RecordCount > 0 then
      lbVersionWarning.Visible := True;
    TmpCount := Low(NonVariationSites);
    while not(EOF) do
    begin
      NonVariationSites[TmpCount] := FieldByName('SiteCode').AsInteger;
      Inc(TmpCount);
      Next;
    end;
    Close;
  end;
end;

procedure TSiteVariations.FormDestroy(Sender: TObject);
begin
  GridSortHelper.Free;
end;

procedure TSiteVariations.dbgVariationGridDrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
var
  gridpos: TGridCoord;
  TmpRect: TRect;
  GlyphRect: TRect;
  GlyphBitmap: TBitmap;
begin
  // Find the column and row ID in the grid.
  gridpos := TwwdbGrid(sender).MouseCoord(rect.left, rect.top);

  // Translate to table-wise coordinates, i.e. row and column numbers
  gridpos.X := gridpos.x - TwwdbGrid(sender).FixedCols;
  gridpos.Y := gridpos.y - 1; // FixedRows
  gridpos.Y := gridpos.Y + TopRow;

  if (gridpos.Y >= Low(FutureChangeCells))
    and (gridpos.Y <= High(FutureChangecells)) then
  begin
    if Pos(Field.FieldName, FutureChangeCells[gridpos.y]) <> 0 then
    with TwwdbGrid(sender) do
    begin
      GlyphRect := image1.Picture.Bitmap.Canvas.ClipRect;
      Glyphbitmap := image1.Picture.Bitmap;

      TmpRect := Rect;
      TmpRect.Left := TmpRect.Right - (GlyphRect.Right - GlyphRect.Left);
      TmpRect.Top := TmpRect.top +  (
        (tmprect.Bottom - tmprect.Top) -
        (GlyphRect.Bottom - GlyphRect.Top)
      ) div 2;

      TmpRect.Top := TmpRect.Top + 1;
      TmpRect.Left := TmpRect.left - 2;

      TmpRect.Right := TmpRect.Left + (GlyphRect.Right - GlyphRect.Left);
      TmpRect.Bottom := TmpRect.Top + (GlyphRect.Bottom - GlyphRect.Top);
      Canvas.BrushCopy(TmpRect, GlyphBitmap, GlyphRect, clWhite);

    end;
  end;
end;

procedure TSiteVariations.HandleDatasetAfterOpen(Sender: TDataset);
var
  i: integer;
  VariationsOrder: string;
  GetFutureChangeColumns: string;
begin
  // This is not nice.
  // TODO: Investigate dataset access during drawdatacell to prevent need for
  //   synchronisation on site code - means that this load can be done in LoadData instead
  //   as it doesn't have to pinch the sort order from the dataset.
  //
  // Initally the best solution seemed to be to incoporate the check for future
  // changes into the crosstab process. However this would necessitate a separate
  // field for every cell in the GUI to show the "future change" icon, which prove
  // to be quite hard. The current code avoids this by using its own data structure
  // that is synchronised to the view.
  // Because the data is sparse and crosstabbed, a separate data structure should
  // be a bit quicker than the "separate field" approach. But the code is pretty ugly.
  SetLength(FutureChangeCells, 0);
  SetLength(FutureChangeCells, dmThemeData.qEditSiteVariations.RecordCount);
  for i := Low(FutureChangeCells) to High(FutureChangeCells) do
    FutureChangeCells[i] := '';

  with dmThemeData.adoqRun do
  begin
    for i := 0 to pred(dmThemeData.qEditSiteVariations.SQL.Count) do
    begin
      if copy(dmThemeData.qEditSiteVariations.SQL[i], 1, 8) = 'order by' then
        VariationsOrder := dmThemeData.qEditSiteVariations.SQL[i]
    end;


    GetFutureChangeColumns := Format(
      'select PanelId, min(effectivedate) as EffectiveDate '+
      'from ThemeSiteVariation '+
      'where Sitecode = @SiteCode and EffectiveDate > %s '+
      'group by PanelId',
      [GetSQLDateOrZero(CurrentEffectiveDate)]
    );

    SQL.Text := Format(
      'declare @FutureChangeList table (SiteCode int, FutureChangeList varchar(8000)) '+
      'declare @SiteCode int '+
      'declare @TmpList varchar(8000) '+
      'declare VariationList cursor for '+
      'select sitecode from #editsitevariations '+
      '%s '+
      'open VariationList '+
      'fetch next from VariationList into @SiteCode '+
      'while @@fetch_status = 0  '+
      'begin '+
      '  set @TmpList = '''' '+
      '  select @TmpList = @TmpList + ''[''+cast(PanelID as varchar(10))+'']'' '+
      '  + Convert(varchar(50), EffectiveDate, 112) + '';'' '+
      '  from ( '+
      GetFutureChangeColumns+
      '  ) sub '+
      '  insert @FutureChangeList select @SiteCode, @TmpList '+
      '  fetch next from VariationList into @SiteCode '+
      'end '+
      'close VariationList '+
      'deallocate VariationList '+
      'select FutureChangeList from @FutureChangeList ', [VariationsOrder]);
    Open;
    First;
    i := 0;
    while not Eof do
    begin
      FutureChangeCells[i] := FieldByName('FutureChangeList').AsString;
      inc(i);
      Next;
    end;
    Close;
  end;
end;

procedure TSiteVariations.dbgVariationGridRowChanged(Sender: TObject);
begin
  // Need to keep a note of the zero-based record sequence number.
  // We have our own cache of the cells with future changes defined which is
  // syncronised to the view.
  TopRow := TwwDBGrid(Sender).DataSource.DataSet.RecNo - TwwDbGrid(Sender).GetActiveRow -1;
end;

procedure TSiteVariations.dbgVariationGridMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  gridpos: TGridCoord;
  TmpDate: string;
  CellFieldName: string;
  TmpDateVal: TDateTime;
  TmpYear, TmpMonth, TmpDay: word;
begin
  // Find the column and row ID in the grid.
  gridpos := TwwdbGrid(sender).MouseCoord(X, Y);

  // Translate to table-wise coordinates, i.e. row and column numbers
  //gridpos.X := gridpos.x - TwwdbGrid(sender).FixedCols;
  gridpos.Y := gridpos.y - 1; // FixedRows
  gridpos.Y := gridpos.Y + TopRow;

  if (gridpos.x = LastHintGridPos.x) and (gridpos.y = LastHintGridPos.y) then
    exit;
  LastHintGridPos := GridPos;

  with TwwdbGrid(sender) do
  begin
    ShowHint := False;
    Hint := '';

    if (GridPos.Y >= Low(FutureChangeCells))
      and (GridPos.Y <= High(FutureChangecells)) and (GridPos.x <> -1) then
    begin
      CellFieldName := '['+Copy(TwwDBGrid(sender).Selected[GridPos.x], 1, Pos(#9, TwwDBGrid(sender).Selected[GridPos.x])-1) + ']';
      if Pos(CellFieldName, FutureChangeCells[GridPos.y]) <> 0 then
      begin
        // Extract the "next future change" date
        TmpDate := Copy(
          FutureChangeCells[GridPos.y],
          Pos(CellFieldName, FutureChangeCells[GridPos.y]) + Length(CellFieldName),
          8
        );
        TmpYear := StrToInt(Copy(TmpDate, 1, 4));
        TmpMonth := StrToInt(Copy(TmpDate, 5, 2));
        TmpDay := StrToInt(Copy(TmpDate, 7, 2));
        TmpDateVal := EncodeDate(TmpYear, TmpMonth, TmpDay);
        ShowHint := True;
        Hint := 'Next change on '+DateToStr(TmpDateVal);
      end;
    end;
  end;
end;

procedure TSiteVariations.HandleWillExecute(Connection: TADOConnection;
  var CommandText: WideString; var CursorType: TCursorType;
  var LockType: TADOLockType; var CommandType: TCommandType;
  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
  const Command: _Command; const Recordset: _Recordset);

  procedure TextLog(text: string; filename: string);
  var
    LFile: Textfile;
  begin
    assignfile(LFile, filename);
    if fileexists(filename) then
      append(LFile)
    else
      rewrite(LFile);
    writeln(LFile, text);
    closefile(LFile);
  end;

begin
  TextLog(CommandText, 'c:\SiteVariationsLog.txt');
  TextLog('GO', 'c:\SiteVariationsLog.txt');
end;

var
  TickCount: int64;

procedure TSiteVariations.StartStopWatch;
begin
  QueryPerformanceCounter(tickcount);
end;

procedure TSiteVariations.StopStopWatch;
var
  TmpTicks: int64;
  TickFreq: int64;
begin
  QueryPerformanceCounter(tmpticks);
  QueryPerformanceFrequency(TickFreq);
  label2.caption := inttostr( (1000  * (TmpTicks-TickCount)) div TickFreq);
end;

procedure TSiteVariations.SetCurrentEffectiveDate(Input: integer);
begin
  if Input <> CurrentEffectiveDate then
  begin
    LastEffectiveDate := CurrentEffectiveDate;
    CurrentEffectiveDate := Input;
  end;
end;

procedure TSiteVariations.ActionList1Execute(Action: TBasicAction;
  var Handled: Boolean);
begin
  if Action is TCustomAction then
  Log('User action: ' + TCustomAction(Action).Caption);
end;

procedure TSiteVariations.dbgVariationGridCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
var
  i: integer;
begin
  if High(NonVariationSites) <> -1 then
  begin
    if (Field.FieldName = 'SiteName') or (Field.FieldName = 'SiteRef') or
      (Field.FieldName = 'AreaName') then
    begin
      for i := Low(NonVariationSites) to High(NonVariationSites) do
      begin
        if NonVariationSites[i] =
          TwwDBGrid(Sender).DataSource.DataSet.FieldByName('SiteCode').AsInteger then
        begin
          AFont.Color := clDkGray;
          break;
        end;
      end
    end;
  end;
end;

procedure TSiteVariations.GetLiveSiteVariationsRowStats(out MaxLength: Integer; out AvgLength: Integer);
begin
  MaxLength := -1;
  AvgLength := -1;
  try
    with adoqLiveSiteVariationsRowStats do
    begin
      Open;
      if not EOF then
      begin
        MaxLength := FieldByName('MaxBytes').AsInteger;
        AvgLength := FieldByName('AvgBytes').AsInteger;
      end;
    end;
  except
    on E:Exception do
    begin
      Log(Format('Unable to determine maximum row size for the grid.  Error: %s', [e.message]));
    end;
  end;
end;

procedure TSiteVariations.UpdateRowSizeWarningIfRequired;
var
  ShowWarning: Boolean;
  MaxRowSize: Integer;
  AvgRowSize: Integer;
  Stats: String;
begin
  with dmThemeData.adoqRun do
  begin
    SQL.Text := Format(
    'declare @SiteCode int '+
    'set @SiteCode = dbo.fnGetSiteCode() '+
    'exec sp_GetConfiguration @SiteCode,%s', [QuotedStr('ShowSiteVariationRowSize')]);
    Open;
    if VarIsNull(FieldByName('Setting').Value) then
      ShowWarning := False
    else
      ShowWarning := (FieldByName('Setting').AsInteger = 1);
    Close;
  end;

  GetLiveSiteVariationsRowStats(MaxRowSize, AvgRowSize);

  if ShowWarning and (MaxRowSize <> -1) and (AvgRowSize <> -1) then
  begin
    Stats := Format(' (Largest row: %d bytes.  Average row: %d bytes.  Maximum 8060 bytes.)',[MaxRowSize, AvgRowSize]);
    Self.Caption := OriginalCaption + Stats;
    Log(Self.Caption);
  end;
end;

procedure TSiteVariations.SetVariationCellText(Sender: TField;
  const Text: String);
begin
  if (Text = USE_DEFAULT) or (text = '') then
    Sender.Clear;
end;

end.
