unit uSABands;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, ADODB, Grids, Wwdbigrd,
  Wwdbgrid, wwdbdatetimepicker, ComCtrls, ppDB, ppDBPipe, ppDBBDE, ppBands,
  ppClass, ppVar, ppCtrls, ppPrnabl, ppCache, ppComm, ppRelatv, ppProd,
  ppReport, ppViewr, uCompanyStructureFilterFrame, uProductStructureFilterFrame,
  Mask, wwdbedit, Wwdotdot, Wwdbcomb, wwdblook, uExcelExportImport,
  ActnList;

type
  TBandType = (btSalesArea, btSupplement);

  TfSABands = class(TForm)
    GroupBox1: TGroupBox;
    btnLoad: TBitBtn;
    Panel1: TPanel;
    btnCopy: TBitBtn;
    grdBands: TwwDBGrid;
    btnPreview: TBitBtn;
    btnSave: TBitBtn;
    btnUndo: TBitBtn;
    btnClose: TBitBtn;
    dsBands: TDataSource;
    qryLoadSABands: TADOQuery;
    tblSABands: TADOTable;
    rptBands: TppReport;
    ppTitleBand1: TppTitleBand;
    ppLine14: TppLine;
    ppLine15: TppLine;
    ppLine16: TppLine;
    ppLine17: TppLine;
    ppImage1: TppImage;
    ppLabel6: TppLabel;
    ppDetailBand1: TppDetailBand;
    FldSubCategory: TppDBText;
    FldCurrentBand: TppDBText;
    FldFutureBand: TppDBText;
    FldDateOfChange: TppDBText;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLine10: TppLine;
    ppLine11: TppLine;
    ppLine12: TppLine;
    BlockDividerLine: TppLine;
    ppFooterBand1: TppFooterBand;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppLine21: TppLine;
    ppLine25: TppLine;
    ppLine26: TppLine;
    ppLine27: TppLine;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppLabel2: TppLabel;
    ppLine2: TppLine;
    ppLine18: TppLine;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLine9: TppLine;
    ppLine8: TppLine;
    ppLine7: TppLine;
    ppLine20: TppLine;
    ppLine3: TppLine;
    ppLine19: TppLine;
    ppLine1: TppLine;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppLine4: TppLine;
    RptBDEPipeline: TppBDEPipeline;
    pplblTitle: TppLabel;
    ppSystemVariable3: TppSystemVariable;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    tblSABandsSiteName: TStringField;
    tblSABandsSalesAreaName: TStringField;
    tblSABandsSubCategoryName: TStringField;
    tblSABandsSalesAreaCode: TSmallintField;
    tblSABandsSubCategoryCode: TSmallintField;
    tblSABandsCurrentBand: TStringField;
    tblSABandsFutureBand: TStringField;
    tblSABandsDateOfChange: TDateTimeField;
    tblSABandsLMDT: TDateTimeField;
    tblSABandsModifiedBy: TStringField;
    tblSABandsPCNum: TSmallintField;
    tblSABandsRecModified: TBooleanField;
    qrySave: TADOQuery;
    ProductStructureFilterFrame: TProductStructureFilterFrame;
    ppSystemVariable4: TppSystemVariable;
    CompanyStructureFilterFrame: TCompanyStructureFilterFrame;
    dsPBN: TDataSource;
    qryPBN: TADOQuery;
    ActionList1: TActionList;
    actExportToClipboard: TAction;
    actImportFromClipboard: TAction;
    bitbtnImport: TBitBtn;
    bitbtnExport: TBitBtn;
    tblSABandsSiteCode: TSmallintField;
    dtGridPick: TwwDBDateTimePicker;
    cbxPBN: TwwDBLookupCombo;
    procedure FormShow(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure grdBandsCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure tblSABandsBeforePost(DataSet: TDataSet);
    procedure grdBandsKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPreviewClick(Sender: TObject);
    procedure rptBandsPreviewFormCreate(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnUndoClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grdBandsExit(Sender: TObject);
    procedure grdBandsColExit(Sender: TObject);
    procedure grdBandsFieldChanged(Sender: TObject; Field: TField);
    procedure actExportToClipboardExecute(Sender: TObject);
    procedure actExportToClipboardUpdate(Sender: TObject);
    procedure actImportFromClipboardUpdate(Sender: TObject);
    procedure actImportFromClipboardExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbxPBNBeforeDropDown(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    ModuleName, BandTable: string;
    procedure ToggleLoad(Status: Boolean);
    function ChangesExist: boolean;
    procedure LoadSABands;
    procedure HideSubDivisionAndSuperCategoryFilters;
  public
    procedure Setup(BandType: TBandType);
  end;

  procedure DisplaySalesAreaBandings;
  procedure DisplaySupplementBandings;

implementation

uses uPricinglog, uGlobals, uADO, uBandParser, uMainMenu, Clipbrd, uImportErrorLog;

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

procedure DisplaySalesAreaBandings;
var
  fSABands: TfSABands;
begin
  fSABands := TfSABands.Create(nil);

  try
    fSABands.Setup(btSalesArea);
    fSABands.ShowModal;
  finally
    fSABands.Free;
  end;
end;

procedure DisplaySupplementBandings;
var
  fSABands: TfSABands;
begin
  fSABands := TfSABands.Create(nil);

  try
    fSABands.Setup(btSupplement);
    fSABands.ShowModal;
  finally
    fSABands.Free;
  end;
end;

procedure TfSABands.FormCreate(Sender: TObject);
begin
  if not(dmADO.SubDivisionOrSuperCategoryUsed) then
    HideSubDivisionAndSuperCategoryFilters;

  dtGridPick.CalendarAttributes.PopupYearOptions.StartYear := CurrentYear;  
end;

procedure TfSABands.FormShow(Sender: TObject);
begin
  CompanyStructureFilterFrame.Initialise;

  dtGridPick.MinDate := Date;
end;


procedure TfSABands.btnLoadClick(Sender: TObject);
begin
  LoadSABands;
end;

procedure TfSABands.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfSABands.grdBandsCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if tblSABands.RecordCount > 0 then
  begin
    if tblSABands.FieldByName('RecModified').AsBoolean and not Field.ReadOnly then
      AFont.Color := clBlue // edited record
    else
      AFont.Color := clBlack; // non edited record
  end;
end;

procedure TfSABands.tblSABandsBeforePost(DataSet: TDataSet);
begin
  with tblSABands do
  begin
    if FieldByName('FutureBand').NewValue = '' then
      FieldByName('FutureBand').NewValue := Null;

    if (FieldByName('FutureBand').NewValue = FieldByName('FutureBand').OldValue)
      and (FieldByName('DateOfChange').NewValue = FieldByName('DateOfChange').OldValue) then
      Exit;

    if (FieldByName('FutureBand').AsString = '') and (not FieldByName('DateOfChange').IsNull) then
    begin
      if MessageDlg('A Future Band must be entered!' + #10 + #13 +
                    'Press OK to enter a Future Band or' + #10 + #13 +
                     'press Cancel to discard changes to this record.',
                     mtError, [mbOK, mbCancel], 0) = mrOK then
        grdBands.SelectedField := FieldByName('FutureBand')
      else
        Cancel;

      Abort;
    end
    else if FieldByName('FutureBand').AsString <> '' then
    begin
      if ValidBandNameForSite(FieldByName('FutureBand').AsString, tblSABandsSiteCode.AsInteger) then
      begin
        if FieldByName('DateOfChange').IsNull then
        begin
          if MessageDlg('A Date Of Change must be entered!' + #10 + #13 +
                           'Press OK to enter a Future Date or' + #10 + #13 +
                           'press Cancel to discard changes to this record.',
                           mtError, [mbOK, mbCancel], 0) = mrOK then
            grdBands.SelectedField := FieldByName('DateOfChange')
          else
            Cancel;

          Abort;
        end;
      end
      else
      begin
        ShowMessage(FieldByName('FutureBand').AsString + ' is not a valid band.');
        Abort;
      end;
    end;

    FieldByName('RecModified').AsBoolean := TRUE;
    FieldByName('LMDT').AsDateTime := Now;
    FieldByName('ModifiedBy').AsString := CurrentUser.UserName;
  end;

  // Disable load button and filters
  ToggleLoad(False);
end;

procedure TfSABands.grdBandsKeyPress(Sender: TObject; var Key: Char);
begin
  if (grdBands.GetActiveField <> nil) and (grdBands.GetActiveField.FieldName = 'FutureBand') then
  begin
    Key := UpCase(Key);

    if not (Key in ['A'..'Z', Chr(VK_BACK), Chr(VK_LEFT), Chr(VK_RIGHT), Chr(VK_UP),
      Chr(VK_DOWN), Chr(VK_TAB)]) then
      Key := #0;
  end;

  if Ord(Key) = VK_TAB then
  begin
    if btnCopy.Enabled then
      btnCopy.SetFocus
    else if btnClose.Enabled then
      btnClose.SetFocus;
  end;
end;

procedure TfSABands.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Log.Event(ModuleName, 'Closed Sales Area Banding Form');
end;

procedure TfSABands.btnPreviewClick(Sender: TObject);
begin
  if tblSABands.State in [dsEdit, dsInsert] then
    tblSABands.Post;

  tblSABands.DisableControls;

  try
    rptBands.Print;
  finally
    tblSABands.EnableControls;
  end;
end;

procedure TfSABands.rptBandsPreviewFormCreate(Sender: TObject);
begin
  dmADO.DoPaper(TppReport(Sender), UKUSMode);
end;

procedure TfSABands.btnCopyClick(Sender: TObject);
var
  tmpDateStr, SAProfit: string;
  i: integer;
begin
  Log.Event(ModuleName, 'Copy button pressed.');

  i := 0;

  if tblSABands.State = dsEdit then
    tblSABands.Post;

  if UKUSMode = 'UK' then
    SAProfit := 'Sales Area'
  else
    SAProfit := 'Profit Center';

  Screen.Cursor := crHourglass;
  try
    try
      if tblSABands.FieldByName('FutureBand').AsString <> '' then // ensure a valid band
      begin
        if (MessageDlg('This action will duplicate the current "Future Band"' +
          #10 + #13 + 'to ALL records in the ' + SAProfit + ' Bandings View.' +
          #10 + #13 + 'Are you sure you want to continue?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
        begin

          if tblSABands.FieldByName('DateOfChange').IsNull then
            tmpDateStr := dmADO.FormatDateForSQL(Date)
          else
            tmpDateStr := dmADO.FormatDateForSQL(tblSABands.FieldByName('DateOfChange').AsDateTime);

          with dmADO.adoqRun do
          begin
            Close;
            SQL.Clear;
            SQL.Add('update #TmpSABands');
            SQL.Add('set FutureBand = ' + QuotedStr(tblSABands.FieldByName('FutureBand').AsString));
            SQL.Add(', DateOfChange = ' + tmpDateStr);
            SQL.Add(', RecModified = 1');
            SQL.Add(', LMDT = getDate()');
            SQL.Add(', ModifiedBy = ' + QuotedStr(CurrentUser.UserName));
            SQL.Add('where FutureBand <> ' + QuotedStr(tblSABands.FieldByName('FutureBand').AsString));
            SQL.Add('or FutureBand is NULL');
            SQL.Add('or DateOfChange <> ' + tmpDateStr);
            SQL.Add('or DateOfChange is NULL');
            i := ExecSQL;
            Close;  
          end;

          tblSABands.Close;
          tblSABands.Open;
        end;
      end;

      grdBands.SetFocus;
      grdBands.SetActiveField('FutureBand');
    except
      on E: Exception do
        ShowMessage('Error copying bands - ' + E.Message);
    end;
  finally
    Screen.Cursor := crDefault;
  end;

  if i <> 0 then
    ToggleLoad(False); // Disable load button and filters
end;

procedure TfSABands.btnUndoClick(Sender: TObject);
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
        LoadSABands;
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

procedure TfSABands.ToggleLoad(Status: Boolean);
begin
  btnSave.Enabled := not Status;
  btnUndo.Enabled := not Status;

  btnLoad.Enabled := Status;
  ProductStructureFilterFrame.FrameEnabled := Status;
  CompanyStructureFilterFrame.FrameEnabled := Status;
end;

procedure TfSABands.btnSaveClick(Sender: TObject);
var
    ExceptionMessage: String;
begin
  // Post any outstanding grid edits
  if tblSABands.State = dsEdit then
    tblSABands.Post;

  // Save changes to SABands table
  try
    with qrySave do
    begin
      Close;
      SQL.Clear;
      SQL.Append('update ' + BandTable + ' ' +
                'set CurrentBand = coalesce(cp.Band,t.CurrentBand), ' +
                    'FutureBand = coalesce(fp.Band,t.FutureBand), ' +
                    'DateOfChange = t.DateOfChange, ' +
                    'LMDT = getDate(), ' +
                    'ModifiedBy = ' + QuotedStr(CurrentUser.UserName) + ' ' +
                'from ' + BandTable + ' a, #TmpSABands t ' +
                   ' join SiteMatrix sm on sm.SiteCode = t.SiteCode ' +
                   'left outer join PriceBandNames cp ' +
                     'on t.CurrentBand = cp.DisplayName and cp.MatrixID = sm.CurrentMatrix ' +
                   'left outer join PriceBandNames fp ' +
                     'on t.FutureBand = fp.DisplayName and fp.MatrixID = sm.CurrentMatrix ' +
                'where a.SubCategoryCode = t.SubCategoryCode ' +
                'and a.SalesAreaCode = t.SalesAreaCode ' +
                'and t.RecModified = 1');
      ExecSQL;
      Close;
    end;
  except
    on E:Exception do
    begin
      ExceptionMessage := 'The "FutureBand" field should not be more then two symbols!';
      MessageDlg (ExceptionMessage, mtError, [mbOK], 0);
    end;
  end;

  // Re-load records
  LoadSABands;

  // Re-enable load button and filters
  ToggleLoad(True);
end;

procedure TfSABands.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  SAProfit: string;
begin
  // Post unsaved changes to grid.
  if tblSABands.State = dsEdit then
    tblSABands.Post;

  CanClose := False;

  if UKUSMode = 'UK' then
    SAProfit := 'Sales Area'
  else
    SAProfit := 'Profit Center';

  if ( not fMainMenu.IsTerminatingFromInactivity ) and ChangesExist then
  begin
    case MessageDlg('Changes have been made to the ' + SAProfit + ' Bandings View.' +
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

function TfSABands.ChangesExist: boolean;
begin
  if tblSABands.Active then
  begin
    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from #TmpSABands');
      SQL.Add('where RecModified = 1');
      Open;

      Result := RecordCount > 0;

      Close;
    end;
  end
  else
    Result := False;
end;

procedure TfSABands.Setup(BandType: TBandType);
begin
  case BandType of
  btSalesArea:
    begin
      if HelpExists then
        setHelpContextID(self, PRC_SALES_AREA_BANDS);

        ModuleName := 'Sales Area Banding';
        BandTable := 'SABands';

        Log.Event(ModuleName, 'Entered Sales Area Banding');

        if UKUSMode = 'UK' then
        begin
          Caption := 'Sales Area Banding';
          grdBands.Selected.Strings[1] := 'Sales Area Name'#9'20'#9'Sales Area'#9#9;

          pplblTitle.Caption := 'Sales Area Bands Report';
        end
        else
        begin
          Caption := 'Profit Center Banding';
          grdBands.Selected.Strings[1] := 'Sales Area Name'#9'20'#9'Profit Center'#9#9;

          pplblTitle.Caption := 'Profit Center Bands Report';
        end;
    end;
  btSupplement:
    begin
      if HelpExists then
        setHelpContextID(self, PRC_SUPPLEMENT_BANDS);

      ModuleName := 'Supplement Banding';
      BandTable := 'SupplementBands';

      Log.Event(ModuleName, 'Entered Supplement Banding');
      Caption := 'Supplement Banding';

      pplblTitle.Caption := 'Supplement Bands Report';

      if UKUSMode = 'UK' then
        grdBands.Selected.Strings[1] := 'Sales Area Name'#9'20'#9'Sales Area'#9#9
      else
        grdBands.Selected.Strings[1] := 'Sales Area Name'#9'20'#9'Profit Center'#9#9;
    end;
  end;
end;

procedure TfSABands.grdBandsExit(Sender: TObject);
begin
//  if tblSABands.State = dsEdit then
//    tblSABands.Post;
end;

procedure TfSABands.grdBandsColExit(Sender: TObject);
begin
  with tblSABands do
  begin
    if State = dsEdit then
    begin
      if ((FieldByName('FutureBand').AsString = '') and (FieldByName('DateOfChange').IsNull)) or
        ((FieldByName('FutureBand').AsString <> '') and (not FieldByName('DateOfChange').IsNull)) then
        Post;
    end;
  end;
end;

procedure TfSABands.grdBandsFieldChanged(Sender: TObject; Field: TField);
begin
  if (Field.FieldName = 'FutureBand') and (not (Field.Value = '')) and (not ValidBandNameForSite(Field.Value,tblSABandsSiteCode.AsInteger)) then
  begin
    ShowMessage(''''+Field.Value+''''+' Is Not A Valid Price Band Name');
    Abort
  end;
end;

procedure TfSABands.LoadSABands;
var
  i: integer;
  FilterClause: String;
  localeDateFormat: string;
  sqlDateConversionFormat: string;
begin
  Log.Event(ModuleName, 'Changed Filter to - ');
  Log.Event(ModuleName, '          Site: ' + CompanyStructureFilterFrame.SelectedSiteName);
  Log.Event(ModuleName, '    Sales Area: ' + CompanyStructureFilterFrame.SelectedSalesAreaName);
  if CompanyStructureFilterFrame.chkbxFilterBySiteTag.Checked then
    Log.Event(ModuleName, '     Site Tags: ' + CompanyStructureFilterFrame.TagList.CommaText);
  Log.Event(ModuleName, '      Division: ' + ProductStructureFilterFrame.cmbbxDivision.Text);
  Log.Event(ModuleName, '  Sub-Division: ' + ProductStructureFilterFrame.cmbbxSubDivision.Text);
  Log.Event(ModuleName, 'Super-Category: ' + ProductStructureFilterFrame.cmbbxSuperCategory.Text);
  Log.Event(ModuleName, '      Category: ' + ProductStructureFilterFrame.cmbbxCategory.Text);
  Log.Event(ModuleName, '  Sub-Category: ' + ProductStructureFilterFrame.cmbbxSubCat.Text);

  btnPreview.Enabled := False;
  btnCopy.Enabled := False;

  tblSABands.DisableControls;

  tblSABands.Active := False;
  qryPBN.Active := False;

  dmADO.DelSQLTable('#TmpSABands');

  // use the appropriate date format code (mdy = 101, dmy = 103, ymd = 111)
  localeDateFormat := GetLocaleDateFormat();
  if(localeDateFormat = 'dmy') then
    sqlDateConversionFormat := '103'
  else if (localeDateFormat = 'mdy') then
    sqlDateConversionFormat := '101'
  else
    sqlDateConversionFormat := '111';

  with qryLoadSABands do
  begin
    Close;
    SQL.Clear;
    SQL.Append('select c.[Site Code] as SiteCode, ' +
                      'c.[Site Ref], ' +
                      'c.[Site Name], ' +
                      'c.[Sales Area Name], ' +
                      'c.[Sales Area Code], ' +
                      'c.[Company Name], ' +
                      'c.[Company Code], ' +
                      'c.[Area Name], ' +
                      'c.[Area Code], ' +
                      'sc.Id as SubCategoryID, '+
                      'sc.Name as [Sub-Category Name], ' +
                      'ISNULL(cp.DisplayName,b.CurrentBand) as CurrentBand, '+
                      'ISNULL(fp.DisplayName,b.FutureBand) as FutureBand, '+
                      'b.SalesAreaCode, ' +
                      'b.SubCategoryCode, ' +
                      'b.DateOfChange, ' +
                      'convert(varchar(10),b.DateOfChange,'+sqlDateConversionFormat+') as DateOfChangeStr, ' +
                      'b.LMDT, ' +
                      'b.ModifiedBy, ' +
                      'b.PCNum, ' +
                      'b.SentToTills, ' +
                      'convert(bit, 0) as RecModified ' +
                'into #TmpSABands ' +
                'from '+
                  '(select s.SalesAreaCode, ' +
                  's.SubCategoryCode, ' +
                  's.CurrentBand, ' +
                  's.FutureBand, ' +
                  's.DateOfChange, ' +
                  's.LMDT, ' +
                  's.ModifiedBy, ' +
                  's.PCNum, ' +
                  's.SentToTills ' +
                  'from ' + BandTable + ' s ' +
                  'where s.SalesAreaCode not in ' +
                  '  (select id from #BookingsOnlySalesAreas) ' +
                  ') b ' +
                'inner join '+
                  '(select distinct cf.[Company Code], cf.[Area Code], cf.[Site Code], ' +
                  'sa.[Site Ref], cf.[Sales Area Code], cf.[Company Name], ' +
                  'cf.[Area Name], cf.[Site Name], cf.[Sales Area Name] ' +
                  'from Config cf ' +
                  'join SiteAztec sa ' +
                  'on sa.[Site Code] = cf.[Site Code] ' +
                  'where cf.Deleted is NULL) c ' +
                '  on b.SalesAreaCode = c.[Sales Area Code] '+
                'inner join ac_ProductSubCategory sc ' +
                '  on b.SubCategoryCode = sc.Id '+
                'inner join ac_ProductCategory ctg ' +
                '  on sc.ProductCategoryId = ctg.Id '+
                'inner join ac_ProductSuperCategory supc ' +
                '  on ctg.ProductSuperCategoryId = supc.Id ' +
                'inner join ac_ProductSubDivision sd ' +
                '  on supc.ProductSubDivisionId = sd.Id ' +
                'inner join ac_ProductDivision d ' +
                '  on sd.ProductDivisionId = d.Id ' +
                'inner join SiteMatrix sm ' +
                '  on sm.SiteCode = c.[Site Code] '+
                'left outer join PriceBandNames cp ' +
                '  on b.CurrentBand = cp.Band and cp.MatrixID = sm.CurrentMatrix '+
                'left outer join PriceBandNames fp '+
                '  on b.FutureBand = fp.Band and fp.MatrixID = sm.CurrentMatrix');

    FilterClause := '';
    if CompanyStructureFilterFrame.SelectedSiteCode <> -1 then // User has not selected <all values>
      FilterClause := FilterClause + 'c.[Site Code] = ' + IntToStr(CompanyStructureFilterFrame.SelectedSiteCode) + ' and ';
    if CompanyStructureFilterFrame.SelectedSalesAreaCode <> -1 then // User has not selected <all values>
      FilterClause := FilterClause + 'c.[Sales Area Code] = ' + IntToStr(CompanyStructureFilterFrame.SelectedSalesAreaCode) + ' and ';
    if ProductStructureFilterFrame.cmbbxDivision.ItemIndex > 0 then // User has not selected <all values>
      FilterClause := FilterClause + 'd.[Name] = ' + QuotedStr(ProductStructureFilterFrame.cmbbxDivision.Text) + ' and ';
    if ProductStructureFilterFrame.cmbbxSubDivision.ItemIndex > 0 then // User has not selected <all values>
      FilterClause := FilterClause + 'sd.[Name] = ' + QuotedStr(ProductStructureFilterFrame.cmbbxSubDivision.Text) + ' and ';
    if ProductStructureFilterFrame.cmbbxSuperCategory.ItemIndex > 0 then // User has not selected <all values>
      FilterClause := FilterClause + 'supc.[Name] = ' + QuotedStr(ProductStructureFilterFrame.cmbbxSuperCategory.Text) + ' and ';
    if ProductStructureFilterFrame.cmbbxCategory.ItemIndex > 0 then // User has not selected <all values>
      FilterClause := FilterClause + 'ctg.[Name] = ' + QuotedStr(ProductStructureFilterFrame.cmbbxCategory.Text) + ' and ';
    if ProductStructureFilterFrame.cmbbxSubCat.ItemIndex > 0 then // User has not selected <all values>
      FilterClause := FilterClause + 'sc.[Name] = ' + QuotedStr(ProductStructureFilterFrame.cmbbxSubCat.Text) + ' and ';
    if FilterClause <> '' then
      SQL.Add('where ' + Copy(FilterClause,1,Length(FilterClause) - Length(' and ')));

    SQL.Add('order by [Site Name], [Sales Area Name], [Sub-Category Name] ');

    SQL.Add('alter table #tmpsabands add primary key (SalesAreaCode, SubCategoryCode)');

    if    CompanyStructureFilterFrame.chkbxFilterBySiteTag.Checked
      and (CompanyStructureFilterFrame.TagList.Count > 0) then
    begin
      //Relational division with a remainder: we want any site whose tag set
      //is a superset of the tags contained in @Tags
      SQL.Add('delete #TmpSABands');
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

  tblSABands.EnableControls;
  tblSABands.Active := True;

  qryPBN.Prepared := True;
  qryPBN.Active := True;

  grdBands.Enabled := tblSABands.RecordCount > 0;
  btnPreview.Enabled := tblSABands.RecordCount > 0;
  btnCopy.Enabled := tblSABands.RecordCount > 0;
end;

procedure TfSABands.actExportToClipboardExecute(Sender: TObject);
var
  OldCursor: TCursor;
  ExportImport: TExcelExportImport;
begin
  Log.Event(ModuleName, 'Starting Export To Clipboard');

  if tblSABands.State in [dsInsert, dsEdit] then
    tblSABands.Post;

  ExportImport := TExcelExportImport.Create;
  OldCursor := Screen.Cursor;

  //Excel doesn't play nicely with our date formats :-(
  //and we also don't want to show the time portion
  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select [Company Code], [Area Code], [SiteCode], [SalesAreaCode],');
    SQL.Add('[SubCategoryID], [Company Name], [Area Name], [Site Ref],');
    SQL.Add('[Site Name], [Sales Area Name], [Sub-Category Name], CurrentBand, FutureBand,');
    SQL.Add('convert(varchar(10),DateOfChange,111) as DateOfChangeStr');
    SQL.Add('into #TmpSABands_Export from #TmpSABands ');
    ExecSQL;
  end;
  try
    Screen.Cursor := crHourglass;
    ExportImport.CopyToClipBoard(dmAdo.AztecConn,
                                '#TmpSABands_Export',
                                '[Company Code], [Area Code], [SiteCode], [SalesAreaCode], [SubCategoryID]',
                                '[Company Name], [Area Name], [Site Ref], [Site Name], [Sales Area Name], [Sub-Category Name], CurrentBand, FutureBand, DateOfChangeStr',
                                '[Site name],[Sales Area Name], [Sub-Category Name]');

    MessageDlg(Format('%s copied to clipboard.',[ModuleName]),
                mtInformation,
                [mbOK],
                0);
  finally
    dmADO.DelSQLTable('#TmpSABands_Export');
    ExportImport.Free;
    Screen.Cursor := OldCursor;
    Log.Event(ModuleName, 'Completed Export to Clipboard');
  end;
end;

procedure TfSABands.actExportToClipboardUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := tblSABands.Active;
end;

procedure TfSABands.actImportFromClipboardUpdate(Sender: TObject);
begin
  try
    if (not tblSABands.Active) or (grdBands.ReadOnly) then
      TAction(Sender).Enabled := False
    else
    begin
      TAction(Sender).Enabled := Clipboard.HasFormat(CF_TEXT);
    end;
  except
    TAction(Sender).Enabled := False;
  end;
end;

procedure TfSABands.actImportFromClipboardExecute(Sender: TObject);
var
  i: integer;
  StartRecNo, RecordsAffected: integer;
  ErrorList, TempErrors: TStringList;
  ExportImport: TExcelExportImport;
  OldCursor: TCursor;
  ErrorDialog: TfImportErrorLog;

  function SABandsImportHasErrors(_ErrorList: TStringList): Boolean;
  var
    localeDateFormat: string;
  begin
    localeDateFormat := GetLocaleDateFormat();
    Log.Event(ModuleName, 'Using locale Date Format: ' + localeDateFormat);
    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('update #tmpSABands set DateOfChange = NULL');

      SQL.Add('set dateformat ' + localeDateFormat);
      SQL.Add('update #tmpSABands set DateOfChange = DateOfChangeStr');
      SQL.Add('where (DateOfChangeStr is not null) and isdate(DateOfChangeStr) = 1');

      if UKUSMode = 'UK' then
        SQL.Add('set dateformat dmy')
      else
        SQL.Add('set dateformat mdy');
      ExecSql;

      Close;
      SQL.Clear;
      SQL.Add('select t.[Sub-Category Name], ''future band is invalid.'' as ErrorText');
      SQL.Add('from #tmpSABands t');
      SQL.Add('where (len(t.FutureBand) = 2 and (NullIf(t.FutureBand,'''') not like ''%[a-z][a-z]%''))');
      SQL.Add('or    (len(t.FutureBand) = 1 and (NullIf(t.FutureBand,'''') not like ''%[a-z]%''))');
      SQL.Add('or    t.FutureBand = '' '' or t.FutureBand = ''  ''');
      SQL.Add('union');
      SQL.Add('select t.[Sub-Category Name],');
      SQL.Add('case when dateofchange < dbo.fn_DateFromDateTime(getDate()) then ''date of change is in the past.''');
      SQL.Add('when t.FutureBand is not null and dateofchange <> dbo.fn_DateFromDateTime(dateofchange) then ''date of change may not include a time.''');
      SQL.Add('when t.FutureBand is not null and dateofchangestr is null then ''missing date of change.''');
      SQL.Add('when t.FutureBand is not null and dateofchangestr is not null and dateofchange is null then ''invalid date format.''');
      SQL.Add('when t.FutureBand is null and dateofchange is not null then ''missing future band.'' end as ErrorText');
      SQL.Add('from #TmpSABands t');
      SQL.Add('where (dateofchange <> dbo.fn_DateFromDateTime(dateofchange)) or (dateofchange < dbo.fn_DateFromDateTime(getDate()))');
      SQL.Add('or (t.FutureBand is not null and dateofchangestr is null)');
      SQL.Add('or (t.FutureBand is not null and dateofchangestr is not null and dateofchange is null)');
      SQl.Add('or (t.FutureBand is null and dateofchange is not null)');
      Open;

      while not EOF do
      begin
        Errorlist.Add(Format('Import error: "%s" - %s',[FieldbyName('Sub-Category Name').AsString, FieldbyName('ErrorText').AsString]));
        Next;
      end;
    end;

    Result := ErrorList.Count > 0;
  end;

begin
  Log.Event(ModuleName, 'Starting Import from Clipboard');
  if tblSABands.State in [dsInsert, dsEdit] then
    tblSABands.Post;

  StartRecNo := tblSABands.RecNo;
  tblSABands.DisableControls;
  ExportImport := TExcelExportImport.Create;
  ErrorList := TStringList.Create;
  OldCursor := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;
    RecordsAffected := ExportImport.PasteFromClipBoard(dmAdo.AztecConn, '#TmpSABands',
                                                      '[Company Code], [Area Code], [SiteCode], [SalesAreaCode], [SubCategoryID]',
                                                      '[Company Name], [Area Name], [Site Ref], [Site Name], [Sales Area Name], [Sub-Category Name], CurrentBand',
                                                      'FutureBand, DateOfChangeStr',
                                                      'RecModified:1{FutureBand,DateOfChangeStr}',
                                                      ErrorList,
                                                      [],
                                                      'FutureBand, DateOfChangeStr');

    if (RecordsAffected > 0) and SABandsImportHasErrors(ErrorList) then
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
      LoadSABands;
    end
    else
    begin
      tblSAbands.Requery;
      tblSABands.RecNo := StartRecNo;
      ToggleLoad(False);
    end;
  finally
    ExportImport.Free;
    tblSABands.EnableControls;
    Screen.Cursor := OldCursor;
    ErrorList.Free;
    Log.Event(ModuleName, 'Completed Import from Clipboard');
  end;
end;

procedure TfSABands.FormDestroy(Sender: TObject);
begin
  dmADO.DelSQLTable('#Tags');
  //Note: It is necessary to explicitly call Free here. Otherwise when the Destroy method of ProductStructureFilterFrame
  //is called all of it's combo boxes are already cleared and the objects attached are therefore not Freed e.g.
  //the DisposeCmbbxPortion method finds no items to free.
  ProductStructureFilterFrame.Free;
end;

procedure TfSABands.cbxPBNBeforeDropDown(Sender: TObject);
begin
  //Linking qryPBN to tblSABands in master-child fashion by setting the datasource
  //property of qryPBN to dsBands results in a strange GUI effect where the item selected
  //via the TwwDbLookupCombo (driven by qryPBN) is not returned correctly to tblSABands:
  //the ordinal position of the selected item in the visible list is returned instead i.e.
  //if the list is 15 items long, 8 of which are visble in the drop down, then scrolling the list to
  //the end and selecting the second last entry (item 14) actually ends up selecting item 7
  //since that is the position of the second last item.  Fix the parameterisation
  //before dropdown instead as this doesn't suffer the side effect.
  qryPBN.Parameters.ParamByName('SiteCode').Value := dsBands.DataSet.FieldbyName('SiteCode').AsInteger;
  qryPBN.Requery();
end;

procedure TfSABands.HideSubDivisionAndSuperCategoryFilters;
var
  moveDistance: integer;
begin
  with ProductStructureFilterFrame do
  begin
    moveDistance := cmbbxCategory.Left - cmbbxSubDivision.Left;

    lblSubDivision.Visible := False;
    cmbbxSubDivision.Visible := False;
    cmbbxSuperCategory.Visible := False;
    lblSuperCategory.Visible := False;

    lblCategory.Left := lblCategory.Left - moveDistance;
    cmbbxCategory.Left := cmbbxCategory.Left - moveDistance;
    lblSubCat.Left := lblSubCat.Left - moveDistance;
    cmbbxSubCat.Left := cmbbxSubCat.Left - moveDistance;
  end;
end;

end.
