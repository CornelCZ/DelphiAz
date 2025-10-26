unit uSiteMatrix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, Wwdbigrd, Wwdbgrid, StdCtrls, Buttons,
  wwdblook, DBCtrls, wwdbdatetimepicker, ExtCtrls,
  uCompanyStructureFilterFrame, ActnList;

type
  TfSiteMatrix = class(TForm)
    grdSiteMatrix: TwwDBGrid;
    dsSiteMatrix: TDataSource;
    GroupBox1: TGroupBox;
    btnLoad: TBitBtn;
    tblSiteMatrix: TADOTable;
    qryLoadSiteMatrix: TADOQuery;
    DataSource1: TDataSource;
    qryMatrixName: TADOQuery;
    tblSiteMatrixSiteName: TStringField;
    tblSiteMatrixSiteCode: TSmallintField;
    tblSiteMatrixDateOfChange: TDateTimeField;
    tblSiteMatrixLMDT: TDateTimeField;
    tblSiteMatrixLMBy: TStringField;
    tblSiteMatrixDeleted: TBooleanField;
    tblSiteMatrixRecModified: TBooleanField;
    tblSiteMatrixCurrentMatrix: TStringField;
    Panel1: TPanel;
    btnClose: TBitBtn;
    btnUndo: TBitBtn;
    btnSave: TBitBtn;
    qrySave: TADOQuery;
    CompanyStructureFilterFrame: TCompanyStructureFilterFrame;
    alSitematrix: TActionList;
    actImport: TAction;
    actExport: TAction;
    bitbtnExport: TBitBtn;
    bitbtnImport: TBitBtn;
    tblSiteMatrixFutureMatrixID: TSmallintField;
    tblSiteMatrixFutureMatrix: TStringField;
    tblSiteMatrixLookupFutureMatrixID: TStringField;
    dtGridPick: TwwDBDateTimePicker;
    cmbbxFutureMatrix: TDBLookupComboBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLoadClick(Sender: TObject);
    procedure tblSiteMatrixFutureMatrixIDGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure grdSiteMatrixCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure grdSiteMatrixColExit(Sender: TObject);
    procedure grdSiteMatrixExit(Sender: TObject);
    procedure tblSiteMatrixBeforePost(DataSet: TDataSet);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnSaveClick(Sender: TObject);
    procedure btnUndoClick(Sender: TObject);
    procedure dtGridPickChange(Sender: TObject);
    procedure grdSiteMatrixKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure actExportUpdate(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
    procedure actImportUpdate(Sender: TObject);
    procedure actImportExecute(Sender: TObject);
    procedure tblSiteMatrixFutureMatrixIDChange(Sender: TField);
    procedure CompanyStructureFilterFramebtnSiteTagsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function FindMatrixName(MatrixID: integer): string;
    procedure ToggleLoad(Status: Boolean);
    function ChangesExist: boolean;
    procedure LoadSiteMatrix;
  end;

  TIntObject = class(TObject)
    Value: Integer;
  end;

const
  ModuleName = 'Site Matrix';

implementation

uses uADO, uPricinglog, uGlobals, uMainMenu, uExcelExportImport, Clipbrd, uImportErrorLog;

{$R *.dfm}

  function GetLocaleDateFormat() : string;
  var
    Buff: array[0..255] of Char;
    localeDateFormat: integer;
    localeDateFormatStr: string;
  begin
    if GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_IDATE, @Buff[0], SizeOf(Buff)) > 0 then
        localeDateFormat := StrToInt(Buff)
    else
        localeDateFormat := -1;

    Case localeDateFormat of
        0 : localeDateFormatStr := 'mdy';
        1 : localeDateFormatStr := 'dmy';
        2 : localeDateFormatStr := 'ymd';
    else
        localeDateFormatStr := 'ymd';
    end;

    result := localeDateFormatStr;
  end;

procedure TfSiteMatrix.FormShow(Sender: TObject);
begin
  CompanyStructureFilterFrame.Initialise;
  CompanyStructureFilterFrame.DialogOwner := Self;

  dtGridPick.MinDate := Date;
  
end;


procedure TfSiteMatrix.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Log.Event(ModuleName, 'Closed Site Matrix Form');
end;


procedure TfSiteMatrix.btnLoadClick(Sender: TObject);
begin
  LoadSiteMatrix;
end;

procedure TfSiteMatrix.tblSiteMatrixFutureMatrixIDGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  Text := FindMatrixName(TField(Sender).AsInteger);
end;

function TfSiteMatrix.FindMatrixName(MatrixID: integer): string;
begin
  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select MatrixName from PriceMatrix');
    SQL.Add('where MatrixID = ' + inttostr(MatrixID));
    Open;

    if FieldByName('MatrixName').IsNull then
      Result := ''
    else
    Result := FieldByName('MatrixName').AsString;
    Close;
  end;
end;

procedure TfSiteMatrix.grdSiteMatrixCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  if tblSiteMatrix.RecordCount > 0 then
  begin
    if tblSiteMatrix.FieldByName('RecModified').AsBoolean and not Field.ReadOnly then
      AFont.Color := clBlue // edited record
    else
      AFont.Color := clBlack; // non edited record
  end;
end;

procedure TfSiteMatrix.grdSiteMatrixColExit(Sender: TObject);
begin
  with tblSiteMatrix do
  begin
    if State = dsEdit then
    begin
      if ((FieldByName('FutureMatrixID').IsNull) and (FieldByName('DateOfChange').IsNull)) or
        ((not FieldByName('FutureMatrixID').IsNull) and (not FieldByName('DateOfChange').IsNull)) then
        Post;
    end;
  end;
end;

procedure TfSiteMatrix.grdSiteMatrixExit(Sender: TObject);
begin
  if tblSiteMatrix.State = dsEdit then
    tblSiteMatrix.Post;
end;

procedure TfSiteMatrix.tblSiteMatrixBeforePost(DataSet: TDataSet);
begin
  with tblSiteMatrix do
  begin
    // Do not update if record is unchanged
    if (FieldByName('FutureMatrixID').NewValue = FieldByName('FutureMatrixID').OldValue)
      and (FieldByName('DateOfChange').NewValue = FieldByName('DateOfChange').OldValue) then
    begin
      Cancel;
      Abort;
    end;

    if (FieldByName('FutureMatrixID').IsNull) then // Future Matrix is invalid
    begin
      // Check if Date of Change specified but no Future Matrix
      if not FieldByName('DateOfChange').isNull then
        FieldByName('DateOfChange').Clear;   // set to null value
    end
    else
    begin // Non blank future band
      if FieldByName('DateOfChange').isNull then
      begin //Ask whether the user wishes to enter a future date or cancel the change
        if MessageDlg('A Date Of Change must be entered!' + #10 + #13 +
                         'Press OK to enter a Future Date or' + #10 + #13 +
                         'press Cancel to discard changes to this record.',
                         mtError, [mbOK, mbCancel], 0) = mrOK then
          grdSiteMatrix.SelectedField := FieldByName('DateOfChange')
        else
          FieldByName('FutureMatrixID').Value := NULL;

        Abort;
      end;
    end;

    FieldByName('RecModified').AsBoolean := True;
    FieldByName('LMDT').AsDateTime := Now;
    FieldByName('LMBy').AsString := CurrentUser.UserName;
  end;

  // Disable load button and filters
  ToggleLoad(False);
end;

procedure TfSiteMatrix.ToggleLoad(Status: Boolean);
begin
  btnSave.Enabled := not Status;
  btnUndo.Enabled := not Status;

  btnLoad.Enabled := Status;
  CompanyStructureFilterFrame.FrameEnabled := Status;
end;

procedure TfSiteMatrix.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfSiteMatrix.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  // Post unsaved changes to grid.
  if tblSiteMatrix.State = dsEdit then
    tblSiteMatrix.Post;

  CanClose := False;

  if ( not fMainMenu.IsTerminatingFromInactivity ) and ChangesExist then
  begin
    case MessageDlg('Changes have been made to the Site Matrix View.' +
      #10 + #13 + 'Do you want to save all changes you made before Closing?',
      mtWarning, [mbYes, mbNo, mbCancel], 0) of
    mrYes:
      begin
          btnSaveClick(Sender); // save bands before closing
          CanClose := True;
      end;
    mrNo:
      begin
        if MessageDlg('This action will discard all changes you' + #10 + #13 +
            'have made since the last Save operation.' + #10 + #13 +
            'Are you sure you want to continue?',
            mtWarning, [mbYes, mbNo], 0) = mrYes then
        begin
          CanClose := True;
        end;
      end;
    end;
  end
  else
    CanClose := True;
end;

function TfSiteMatrix.ChangesExist: boolean;
begin
  if tblSiteMatrix.Active then
  begin
    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from #tmpSiteMatrix');
      SQL.Add('where RecModified = 1');
      Open;

      Result := RecordCount > 0;

      Close;
    end;
  end
  else
    Result := False;
end;

procedure TfSiteMatrix.btnSaveClick(Sender: TObject);
begin
  // Post any outstanding grid edits
  if tblSiteMatrix.State = dsEdit then
    tblSiteMatrix.Post;

  // Save changes to SiteMatrix table
  with qrySave do
  begin
    Close;
    SQL.Clear;
    SQL.Add('update SiteMatrix');
    SQL.Add('set FutureMatrix = t.FutureMatrixID,');
    SQL.Add('  DateOfChange = t.DateOfChange, LMDT = getDate(), ');
    SQL.Add('  LMBy = ' + QuotedStr(CurrentUser.UserName));
    SQL.Add('from');
    SQL.Add('SiteMatrix a, #tmpSiteMatrix t');
    SQL.Add('where a.SiteCode = t.SiteCode');
    ExecSQL;
    Close;
  end;

  // Re-load records
  LoadSiteMatrix;

  // Re-enable load button and filters
  ToggleLoad(True);
end;

procedure TfSiteMatrix.btnUndoClick(Sender: TObject);
begin
  Log.Event(ModuleName, 'Undo button pressed.');

  Screen.Cursor := crHourglass;
  try
    try
      // open revert dialog
      if (MessageDlg('This action will discard all changes you' +
        #10 + #13 + 'have made since the last Save operation.' +
        #10 + #13 + 'Are you sure you want to continue?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
      begin
        LoadSiteMatrix;
        // Re-enable load button and filters
        ToggleLoad(True);
      end;
    except
      on E: Exception do
        ShowMessage('Error undoing changes - ' + E.Message);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfSiteMatrix.grdSiteMatrixKeyPress(Sender: TObject;
  var Key: Char);
begin
  If Key = #9 Then
    if btnSave.Enabled then
      btnSave.SetFocus
    else
      btnClose.SetFocus;
end;


procedure TfSiteMatrix.dtGridPickChange(Sender: TObject);
begin
  { Update the screen controls to show a change has been made but only if
    the date picker was changed by the user. It may have changed simply
    because the underlying record in the grid changed }
  if dtGridPick.Focused then
    ToggleLoad(FALSE);
end;

procedure TfSiteMatrix.FormCreate(Sender: TObject);
begin
  if HelpExists then
    setHelpContextID(self, PRC_SITE_MATRIX);

  dtGridPick.CalendarAttributes.PopupYearOptions.StartYear := CurrentYear;
end;

procedure TfSiteMatrix.actExportUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := tblSiteMatrix.Active;
end;

procedure TfSiteMatrix.actExportExecute(Sender: TObject);
var
  OldCursor: TCursor;
  ExportImport: TExcelExportImport;
begin
  Log.Event(ModuleName, 'Starting Export To Clipboard');

  if tblSiteMatrix.State in [dsInsert, dsEdit] then
    tblSiteMatrix.Post;

  ExportImport := TExcelExportImport.Create;
  OldCursor := Screen.Cursor;

  //Excel doesn't play nicely with our date formats :-(
  //and we also don't want to show the time portion
  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select [Company Code], SiteCode, [Company Name], [Area Code], [Area Name], [Site Ref],');
    SQL.Add('[Site Name], CurrentMatrix, FutureMatrix,');
    SQL.Add('convert(varchar(10),DateOfChange,111) as DateOfChangeStr');
    SQL.Add('into #TmpSiteMatrix_Export from #TmpSiteMatrix ');
    ExecSQL;
  end;

  try
    Screen.Cursor := crHourglass;
    ExportImport.CopyToClipBoard(dmAdo.AztecConn,
                                '#TmpSiteMatrix_Export',
                                '[Company Code], [Area Code], SiteCode',
                                '[Company Name], [Area Name], [Site Ref], [Site Name], CurrentMatrix, FutureMatrix, DateOfChangeStr',
                                '[Site Name]');

    MessageDlg(Format('%s copied to clipboard.',[ModuleName]),
                mtInformation,
                [mbOK],
                0);
  finally
    dmADO.DelSQLTable('#TmpSiteMatrix_Export');
    ExportImport.Free;
    Screen.Cursor := OldCursor;
    Log.Event(ModuleName, 'Completed Export to Clipboard');
  end;
end;

procedure TfSiteMatrix.actImportUpdate(Sender: TObject);
begin
  try
    if (not tblSiteMatrix.Active) or (grdSiteMatrix.ReadOnly) then
      TAction(Sender).Enabled := False
    else
    begin
      TAction(Sender).Enabled := Clipboard.HasFormat(CF_TEXT);
    end;
  except
    TAction(Sender).Enabled := False;
  end;
end;

procedure TfSiteMatrix.actImportExecute(Sender: TObject);
var
  i: integer;
  StartRecNo, RecordsAffected: integer;
  ErrorList, TempErrors: TStringList;
  ExportImport: TExcelExportImport;
  OldCursor: TCursor;
  ErrorDialog: TfImportErrorLog;

  procedure UpdateFuturematrixIDs;
  begin
    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('update #tmpSiteMatrix');
      SQL.Add('set FuturematrixID = p.MatrixID');
      SQL.Add('from #tmpSiteMatrix t');
      SQL.Add('left join PriceMatrix p');
      SQL.Add('on p.MatrixName = t.FutureMatrix');
      SQL.Add('where t.RecModified = 1');
      ExecSQL;
    end;
  end;

  function SiteMatrixImportHasErrors(_ErrorList: TStringList): Boolean;
  var
    localeDateFormat: string;
  begin
    localeDateFormat := GetLocaleDateFormat();

    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('update #tmpSiteMatrix set DateOfChange = NULL');

      SQL.Add('set dateformat ' + localeDateFormat);
      SQL.Add('update #tmpSiteMatrix set DateOfChange = DateOfChangeStr');
      SQL.Add('where (DateOfChangeStr is not null) and isdate(DateOfChangeStr) = 1');

      if UKUSMode = 'UK' then
        SQL.Add('set dateformat dmy')
      else
        SQL.Add('set dateformat mdy');

      ExecSql;

      Close;
      SQL.Clear;
      SQL.Add('select t.[Site Name], ''future matrix is invalid.'' as ErrorText');
      SQl.Add('from #tmpSiteMatrix t');
      SQL.Add('left join PriceMatrix p');
      SQL.Add('on t.Futurematrix = p.MatrixName');
      SQL.Add('where t.RecModified = 1');
      SQL.Add('and (p.MatrixID is null) and (t.FutureMatrix is not null)');
      SQL.Add('union');
      SQL.Add('select t.[Site Name],');
      SQL.Add('case when dateofchange < dbo.fn_DateFromDateTime(getDate()) then ''date of change is in the past.''');
      SQL.Add('when t.FutureMatrix is not null and dateofchange <> dbo.fn_DateFromDateTime(dateofchange) then ''date of change may not include a time.''');
      SQL.Add('when t.FutureMatrix is not null and dateofchangestr is null then ''missing date of change.''');
      SQL.Add('when t.FutureMatrix is not null and dateofchangestr is not null and dateofchange is null then ''invalid date format.''');
      SQL.Add('when t.FutureMatrix is null and dateofchange is not null then ''missing future matrix.'' end as ErrorText');
      SQL.Add('from #tmpSiteMatrix t');
      SQL.Add('where (dateofchange <> dbo.fn_DateFromDateTime(dateofchange)) or (dateofchange < dbo.fn_DateFromDateTime(getDate()))');
      SQL.Add('or (t.FutureMatrix is not null and dateofchange is null)');
      SQL.Add('or (t.FutureMatrix is not null and dateofchangestr is not null and dateofchange is null)');
      SQl.Add('or (t.FutureMatrix is null and dateofchange is not null)');
      Open;

      while not EOF do
      begin
        Errorlist.Add(Format('Import error: "%s" - %s',[FieldbyName('Site Name').AsString, FieldbyName('ErrorText').AsString]));
        Next;
      end;
    end;

    Result := ErrorList.Count > 0;
  end;

begin
  Log.Event(ModuleName, 'Starting Import from Clipboard');
  if tblSiteMatrix.State in [dsInsert, dsEdit] then
    tblSiteMatrix.Post;

  StartRecNo := tblSiteMatrix.RecNo;
  tblSiteMatrix.DisableControls;
  ExportImport := TExcelExportImport.Create;
  OldCursor := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;
    ErrorList := TStringList.Create;
    RecordsAffected := ExportImport.PasteFromClipBoard(dmAdo.AztecConn, '#TmpSiteMatrix',
                                                      '[Company Code], [Area Code], SiteCode',
                                                      '[Company Name], [Area Name], [Site Ref], [Site Name], CurrentMatrix',
                                                      'FutureMatrix, DateOfChangeStr',
                                                      'RecModified:1{FutureMatrix, DateOfChangeStr}',
                                                      ErrorList,
                                                      [],
                                                      'FutureMatrix, DateOfChangeStr');
    if (RecordsAffected > 0) and SiteMatrixImportHasErrors(ErrorList) then
    begin
      for i := 0 to ErrorList.Count-1 do
        Log.Event(ModuleName, ErrorList.Strings [i]);
      ErrorDialog := TfImportErrorLog.Create(self);
      TempErrors := TStringList.Create;
      TempErrors.Assign(ErrorList);
      try
        //TempErrors will be freed on the dialog free(?!)
        ErrorDialog.ErrorList := TempErrors;
        ErrorDialog.ShowModal
      finally
        ErrorDialog.Free;
      end;
      LoadSiteMatrix;
    end
    else begin
      //Unfortunately the PriceMatrix table does the correct thing and stores
      //the matrix id rather than the name: this means we have to remap the id
      //after we import (since the user only edits the matrix name).
      UpdateFutureMatrixIDs;

      tblSiteMatrix.Requery;
      tblSiteMatrix.RecNo := StartRecNo;
      ToggleLoad(False);
    end;
  finally
    ExportImport.Free;
    tblSiteMatrix.EnableControls;
    Screen.Cursor := OldCursor;
    ErrorList.Free;
    Log.Event(ModuleName, 'Completed Import from Clipboard');
  end;
end;

procedure TfSiteMatrix.tblSiteMatrixFutureMatrixIDChange(Sender: TField);
begin
  tblSiteMatrixFutureMatrix.Value := tblSiteMatrixLookupFutureMatrixID.Value;
end;

procedure TfSiteMatrix.LoadSiteMatrix;
var
  i: integer;
  localeDateFormat: string;
  sqlDateConversionFormat: string;
begin
  Log.Event(ModuleName, 'Changed Filter to - ');
  Log.Event(ModuleName, '       Company: ' + CompanyStructureFilterFrame.SelectedCompanyName);
  Log.Event(ModuleName, '          Area: ' + CompanyStructureFilterFrame.SelectedAreaName);
  Log.Event(ModuleName, '          Site: ' + CompanyStructureFilterFrame.SelectedSiteName);
  if CompanyStructureFilterFrame.chkbxFilterBySiteTag.Checked then
    Log.Event(ModuleName, '     Site Tags: ' + CompanyStructureFilterFrame.TagList.CommaText);

  tblSiteMatrix.DisableControls;

  dmADO.DelSQLTable('#TmpSiteMatrix');

  tblSiteMatrix.Active := False;
  qryMatrixName.Active := False;

  // use the appropriate date format code (mdy = 101, dmy = 103, ymd = 111)
  localeDateFormat := GetLocaleDateFormat();
  if(localeDateFormat = 'dmy') then
    sqlDateConversionFormat := '103'
  else if (localeDateFormat = 'mdy') then
    sqlDateConversionFormat := '101'
  else
    sqlDateConversionFormat := '111';

  with qryLoadSiteMatrix do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select c.[Company Code], c.[Area Code], c.[Company Name], c.[Area Name], s.[Site Ref], s.[Site Name],');
    SQl.Add('m.SiteCode, p.MatrixName as CurrentMatrix,');
    SQL.Add('m.FutureMatrix as FutureMatrixID, p2.MatrixName as FutureMatrix,');
    SQL.Add('m.DateOfChange, convert(varchar(10),m.DateOfChange,'+sqlDateConversionFormat+') as DateOfChangeStr,');
    SQL.Add('m.LMDT, m.LMBy, m.Deleted, convert(bit, 0) as RecModified');
    SQL.Add('into #TmpSiteMatrix');
    SQL.Add('from SiteMatrix m');
    SQL.Add('join SiteAztec s');
    SQL.Add('on m.SiteCode = s.[Site Code]');
    SQL.Add('join PriceMatrix p');
    SQL.Add('on m.CurrentMatrix = p.MatrixID');
    SQL.Add('left join PriceMatrix p2');
    SQL.Add('on m.FutureMatrix = p2.MatrixID');
    SQL.Add('join (select distinct [Company Code], [Company Name], [Area Code], [Area Name], [Site Code] from Config where Deleted is NULL or Deleted <> ''Y'') c');
    SQL.Add('on s.[Site Code] = c.[Site Code]');
    SQL.Add('where s.[Aztec Pricing] is not NULL and s.Deleted is NULL and s.[Aztec Pricing] = ''Y''');
    SQL.Add('and m.Deleted = 0');

    if CompanyStructureFilterFrame.SelectedSiteCode <> -1 then // User has not selected <all values>
      SQL.Add('and s.[Site Code] = ' + inttostr(CompanyStructureFilterFrame.SelectedSiteCode));

    if CompanyStructureFilterFrame.SelectedAreaCode <> -1 then // User has not selected <all values>
      SQL.Add('and c.[Area Code] = ' + inttostr(CompanyStructureFilterFrame.SelectedAreaCode));

    if CompanyStructureFilterFrame.SelectedCompanyCode <> -1 then // User has not selected <all values>
      SQL.Add('and c.[Company Code] = ' + inttostr(CompanyStructureFilterFrame.SelectedCompanyCode));

    SQL.Add('order by [Site Name]');


    if    CompanyStructureFilterFrame.chkbxFilterBySiteTag.Checked
      and (CompanyStructureFilterFrame.TagList.Count > 0) then
    begin
      //Relational division with a remainder: we want any site whose tag set
      //is a superset of the tags contained in @Tags
      SQL.Add('delete #TmpSiteMatrix');
      SQL.Add('where SiteCode not in (');
      SQL.Add(' select st.SiteID');
      SQL.Add(' from ac_SiteTag st');
      SQL.Add(' join #Tags t');
      SQL.Add(' on st.TagId = t.TagId');
      SQL.Add(' group by st.SiteID');
      SQL.Add(' having count(st.TagId) = (select count(TagId) from #Tags))');
    end;

    i := ExecSQL;

    Log.Event(ModuleName, inttostr(i) + ' Records Loaded');
  end;

  tblSiteMatrix.EnableControls;
  tblSiteMatrix.Active := True;
  qryMatrixName.Active := True;

  grdSiteMatrix.Enabled := tblSiteMatrix.RecordCount > 0;
end;

procedure TfSiteMatrix.CompanyStructureFilterFramebtnSiteTagsClick(
  Sender: TObject);
begin
  CompanyStructureFilterFrame.btnSiteTagsClick(Sender);

end;

procedure TfSiteMatrix.FormDestroy(Sender: TObject);
begin
  dmADO.DelSQLTable('#Tags');
end;

end.
