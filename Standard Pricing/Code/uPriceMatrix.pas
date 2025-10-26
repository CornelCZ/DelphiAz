unit uPriceMatrix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Wwdbigrd, Wwdbgrid, ExtCtrls, StdCtrls, Buttons, ADODB,
  DB, ComCtrls, AppEvnts, XLDBGrid, StdActns, StrUtils,
  ActnList, ClipBrd, uProgress, uProductStructureFilterFrame, Wwkeycb, Spin,
  ImgList, uIncDec, uProductSearchFrame;

type
  THackGrid = class(TwwCustomDBGrid);

  TSortOrder = (soAscending, soDescending);

  TPriceMatrixGridColumn = (gcProduct, gcDescription, gcImportExportRef, gcPortion, gcBand);

  TfPriceMatrix = class(TForm)
    TopPanel: TPanel;
    BottomPanel: TPanel;
    gbxFilter: TGroupBox;
    cmbbxMatrix: TComboBox;
    lblMatrix: TLabel;
    lblBands: TLabel;
    btnLoad: TBitBtn;
    edtBands: TEdit;
    ADOCommand: TADOCommand;
    ProductStructureFilterFrame: TProductStructureFilterFrame;
    dsCrossPrices: TDataSource;
    tblCrossPrices: TADODataSet;
    btnSave: TBitBtn;
    btnUndo: TBitBtn;
    btnClose: TBitBtn;
    ADOQuery: TADOQuery;
    btnCancelPriceChanges: TBitBtn;
    Bevel: TBevel;
    lblStartDate: TLabel;
    cmbbxStartDate: TComboBox;
    ApplicationEvents1: TApplicationEvents;
    tblHintLookup: TADODataSet;
    grdPriceMatrix: TXLDBGrid;
    btnIncDec: TBitBtn;
    btnCopy: TBitBtn;
    btnPaste: TBitBtn;
    alMain: TActionList;
    EditPaste1: TEditPaste;
    EditCopy1: TEditCopy;
    acIncDec: TAction;
    btnAddMatrix: TBitBtn;
    btnDelMatrix: TBitBtn;
    btnSelectAndCopyAll: TButton;
    ExportAllToClipboard: TAction;
    ImportFromClipboard: TAction;
    ImageList1: TImageList;
    bitbtnExport: TBitBtn;
    bitbtnImport: TBitBtn;
    lblGridReadOnly: TLabel;
    lblUnsavedChanges: TLabel;
    chkBoxShowImpExpRef: TCheckBox;
    ProductSearchFrame: TProductSearchFrame;
    procedure btnLoadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnCloseClick(Sender: TObject);
    procedure btnUndoClick(Sender: TObject);
    procedure grdPriceMatrixCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure cmbbxStartDateChange(Sender: TObject);
    procedure btnCancelPriceChangesClick(Sender: TObject);
    procedure grdPriceMatrixMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure ApplicationEvents1ShowHint(var HintStr: String;
      var CanShow: Boolean; var HintInfo: THintInfo);
    procedure EditCopy1Execute(Sender: TObject);
    procedure EditPaste1Execute(Sender: TObject);
    procedure HandleCopyUpdate(Sender: TObject);
    procedure HandlePasteUpdate(Sender: TObject);
    procedure acIncDecExecute(Sender: TObject);
    procedure acIncDecUpdate(Sender: TObject);
    procedure cmbbxMatrixChange(Sender: TObject);
    procedure btnAddMatrixClick(Sender: TObject);
    procedure btnDelMatrixClick(Sender: TObject);
    procedure btnSelectAndCopyAllClick(Sender: TObject);
    procedure tmrProgressTimer(Sender: TObject);
    procedure grdPriceMatrixKeyPress(Sender: TObject; var Key: Char);
    procedure ExportAllToClipboardExecute(Sender: TObject);
    procedure ImportFromClipboardExecute(Sender: TObject);
    procedure grdPriceMatrixDblClick(Sender: TObject);
    procedure grdPriceMatrixMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure grdPriceMatrixDrawTitleCell(Sender: TObject; Canvas: TCanvas;
      Field: TField; Rect: TRect; var DefaultDrawing: Boolean);
    procedure grdPriceMatrixKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdPriceMatrixCalcTitleImage(Sender: TObject; Field: TField;
      var TitleImageAttributes: TwwTitleImageAttributes);
    procedure chkBoxShowImpExpRefClick(Sender: TObject);
  private
    SelectedBands : TStringList;
    FUnsavedChangesExist: boolean;   //true if price changes have been made but not yet saved
    CurrentRow, OldCurrentRow: integer;
    TheMatrixID: integer;
    PriceChangeHandled: Boolean;
    ProgressForm: TProgressForm;
    FShowImportExportRef: boolean;

    OrderedByColumn: TPriceMatrixGridColumn;
    CurrentSortFieldName: String;
    CurrentSortOrder: TSortOrder;
    ExportFixedFields: string;

    procedure SetUnsavedChangesExist(const Value: boolean);

    procedure SetGridFieldProperties (const ExpectedBands : integer);
    procedure HandlePriceChanges (Sender : TField);
    procedure PopulateStartDateComboBox(KeepCurrent: Boolean);
    procedure PopulateMatrixTypes;
    function AddStartDate (NewDate : TDateTime) : integer;
    function PriceChangesExist : boolean;

    function getProductDesc: string;

    procedure AddNewMatrix(MatrixName: string);
    procedure MatrixDeleted(CurrentMatrix: Boolean);
    procedure FreeMatrixObjects;
    function PriceMatrixColumn(columnNumber: integer) : TPriceMatrixGridColumn;
    procedure HideSubDivisionAndSuperCategoryFilters;
    procedure RoundChangedPricesToTwoDecimalPlaces;
  public
    SelectedStartDate : String;
    property UnsavedChangesExist : boolean read FUnsavedChangesExist write SetUnsavedChangesExist;
  end;

  TIntObject = class(TObject)
    Value: integer;
  end;

implementation

uses  uPricinglog, uBandParser, uADO, uGlobals, uPriceStartDate, uAddMatrix,
  uDelMatrix, uExcelExportImport, uMainMenu, useful, uEditPriceBandName;

const
  MODULE_NAME = 'Price Matrix';
  MAX_FILTERED_BANDS = 250; //Restriction is due to the max fields a SQL table can have (1024).
  CREATE_NEW_TEXT = '<Create New...>';
{$R *.dfm}

procedure TfPriceMatrix.FormCreate(Sender: TObject);
begin
  if HelpExists then
    setHelpContextID(self, PRC_PRICE_MATRIX);

  SelectedBands := TStringList.Create;
  UnsavedChangesExist := FALSE;
  btnCancelPriceChanges.Enabled := FALSE;
  PriceChangeHandled := FALSE;
  OrderedByColumn := gcProduct;
  CurrentSortOrder := soAscending;
  CurrentSortFieldName := 'DisplayProductName';
  FShowImportExportRef := false;
  ProductSearchFrame.ProductDataset := tblCrossPrices;
  ProductSearchFrame.Enabled := False;

  PopulatePricngList(ProductStructureFilterFrame.cmbbxPricing);

  if dmADO.SubDivisionOrSuperCategoryUsed then
  begin
    ExportFixedFields := '[Division Name], [SubDivision Name], [SuperCategory Name], [Category Name], [Sub-Category Name], [Product Name], ' +
          '[Import/Export Reference], [ProductDescription], [PortionTypeName]';
  end
  else
  begin
    HideSubDivisionAndSuperCategoryFilters;
    ExportFixedFields := '[Division Name], [Category Name], [Sub-Category Name], [Product Name], ' +
          '[Import/Export Reference], [ProductDescription], [PortionTypeName]';
  end;

  with ADOCommand do
  begin
    CommandTimeout := 0;
    Connection.ConnectionTimeout := 0;
    Connection.CommandTimeout := 0;
    CommandType := cmdText;
  end;
end;

procedure TfPriceMatrix.FormDestroy(Sender: TObject);
begin
  FreeMatrixObjects;
  SelectedBands.Free;

  //Note: It is necessary to explicitly call Free here. Otherwise when the Destroy method of ProductStructureFilterFrame
  //is called all of it's combo boxes are already cleared and the objects attached are therefore not Freed e.g.
  //the DisposeCmbbxPortion method finds no items to free.
  ProductStructureFilterFrame.Free;
end;

procedure TfPriceMatrix.FormShow(Sender: TObject);
begin
  Log.Event(MODULE_NAME, 'Entered Price Matrix');
  ProductStructureFilterFrame.Initialise;
  PopulateMatrixTypes;
  SelectedStartDate := '';
  PopulateStartDateComboBox(False);
end;

procedure TfPriceMatrix.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Log.Event(MODULE_NAME, 'Form Closed');
end;

procedure TfPriceMatrix.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // Post unsaved changes to grid.
  if tblCrossPrices.State = dsEdit then
    tblCrossPrices.Post;

  CanClose := False;

  if UnsavedChangesExist and ( not fMainmenu.IsTerminatingFromInactivity ) then
  begin
    case MessageDlg('Changes have been made to the Price Matrix View' + #10 + #13 + #10 + #13 +
                    'Do you want to save all changes you made before closing?',
                    mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
    mrYes:
      begin
          btnSaveClick(Sender); //Save changes before closing.
          if not UnsavedChangesExist then //Only allow close to occur if save was successful.
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
          Log.Event(MODULE_NAME, IntToStr(dmADO.ADOUpdatesPending(tblCrossPrices)) +
                                    ' changed product portion price(s) abandoned on Exit');
        end;
      end;
    end;
  end
  else
    CanClose := True;
end;

procedure TfPriceMatrix.btnLoadClick(Sender: TObject);
var
  SelectedBandsList: string;
  SelectedDate: TDateTime;
  i: integer;
begin
  Screen.Cursor := crHourglass;

  ProgressForm := TProgressForm.Create('Loading Price Matrix Information');

  try
    ProgressForm.MoveOn(0);
    ProgressForm.Cursor := crHourGlass;
    ProgressForm.Show;
    EnableWindow(Handle, FALSE);

    try
      tblCrossprices.DisableControls;

      try
        Assert(cmbbxStartDate.ItemIndex >= 0, 'TfPriceMatrix.btnLoadClick: No date selected in ''Prices as of'' combo');

        SelectedDate := StrToDateConversion(cmbbxStartDate.Text);

        { Get the Bands selected by the user into SelectedBands }
        SelectedBands.Clear;
        if not ParseBands(edtBands.Text, SelectedBands, TheMatrixID) then
        begin
          MessageDlg('Please correctly define the bands you wish to load', mtInformation, [mbOK], 0);
          Exit;
        end;

        ProgressForm.MoveOn(25);
        ProcessPaintMessages;

        if SelectedBands.Count > MAX_FILTERED_BANDS then
        begin
          MessageDlg('You have chosen to filter '+IntToStr(SelectedBands.Count)+
                     ' bands but the limit is '+IntToStr(MAX_FILTERED_BANDS)+'.', mtInformation, [mbOK], 0);
          Exit;
        end;

        Log.Event(MODULE_NAME, 'Loading with filter settings - ');
        Log.Event(MODULE_NAME, '        Matrix: ' + cmbbxMatrix.Text);
        Log.Event(MODULE_NAME, '         Bands: ' + edtBands.Text);
        Log.Event(MODULE_NAME, '      Division: ' + ProductStructureFilterFrame.cmbbxDivision.Text);
        Log.Event(MODULE_NAME, '   SubDivision: ' + ProductStructureFilterFrame.cmbbxSubDivision.Text);
        Log.Event(MODULE_NAME, ' SuperCategory: ' + ProductStructureFilterFrame.cmbbxSuperCategory.Text);
        Log.Event(MODULE_NAME, '      Category: ' + ProductStructureFilterFrame.cmbbxCategory.Text);
        Log.Event(MODULE_NAME, '  Sub-Category: ' + ProductStructureFilterFrame.cmbbxSubCat.Text);
        Log.Event(MODULE_NAME, '       Product: ' + ProductStructureFilterFrame.cmbbxProduct.Text);
        Log.Event(MODULE_NAME, '  Prices as of: ' + cmbbxStartDate.Text);

        TheMatrixID := TIntObject(cmbbxMatrix.Items.Objects[cmbbxMatrix.ItemIndex]).Value;

        { Create the temporary table #CrossPrices which will hold the data to be displayed on the grid }
        tblCrossPrices.Active := false;
        tblHintLookup.Active := False;
        dmADO.DelSQLTable('#CrossPrices');

        for i := 0 to SelectedBands.Count-1 do
          SelectedBandsList := SelectedBandsList + ',[' + SelectedBands[i]+'],['+SelectedBands[i]+'DueNow]';

        with ADOCommand do
        begin
          CommandText :=
          {---- (1) Create a table variable containing the filtered products only. }

            'IF object_id(''tempdb..#PMSelectedProducts'') IS NULL ' +
              'CREATE TABLE #PMSelectedProducts ( '+
                '[ProductID] [bigint] NOT NULL, '+
                '[PortionTypeID] [int] NOT NULL, '+
                '[PortionTypeName] varchar(16) NOT NULL, '+
                '[Extended RTL Name] varchar(16) NULL, '+
                '[Retail Description] varchar(40) NULL, '+
                '[Import/Export Reference] varchar(20) NULL, '+
                '[Division Name] varchar(20) NOT NULL, '+
                '[SubDivision Name] varchar(20) NOT NULL, '+
                '[SuperCategory Name] varchar(20) NOT NULL, '+
                '[Category Name] varchar(20) NOT NULL, '+
                '[Sub-Category Name] varchar(20) NOT NULL, '+
                'PRIMARY KEY (ProductID, PortionTypeID) ) '+
            'ELSE '+
              'TRUNCATE TABLE #PMSelectedProducts '+

            'INSERT INTO #PMSelectedProducts (ProductID, PortionTypeID, PortionTypeName, [Extended RTL Name], [Retail Description], [Import/Export Reference], '+
                                           '[Division Name], [SubDivision Name], [SuperCategory Name], [Category Name], [Sub-Category Name]) '+
            'SELECT p.EntityCode, pt.Id, pt.Name, [Extended RTL Name], [Retail Description], [Import/Export Reference], pd.Name, psd.Name, psupc.Name, pc.Name, psc.Name  '+
            'FROM Products p '+
            'JOIN Portions po '+
            'ON p.EntityCode = po.EntityCode '+
            'JOIN ac_PortionType pt '+
            'ON pt.Id = po.PortionTypeID '+
            'JOIN ac_ProductSubCategory psc '+
            'ON psc.Name = p.[Sub-Category Name] '+
            'JOIN ac_ProductCategory pc '+
            'ON pc.Id = psc.ProductCategoryId '+
            'JOIN ac_ProductSuperCategory psupc '+
            'ON psupc.Id = pc.ProductSuperCategoryId '+
            'JOIN ac_ProductSubDivision psd '+
            'ON psd.Id = psupc.ProductSubDivisionId '+
            'JOIN ac_ProductDivision pd '+
            'ON pd.Id = psd.ProductDivisionId '+
            'WHERE '+ ProductStructureFilterFrame.SQLStatementForFilteredProducts + ' ';

          {---- (2) Create the temporary table #Crossprices used to hold the prices data for display in the grid }
          CommandText := CommandText +
              'CREATE TABLE #CrossPrices ( '+
              '[ProductID] [bigint] NOT NULL, '+
              '[PortionTypeID] [int] NOT NULL, '+
              '[Import/Export Reference] varchar(20) collate database_default NULL, '+
              '[Product Name] varchar(16) collate database_default NULL, '+
              '[DisplayProductName] varchar(16) collate database_default NULL, '+
              '[ProductDescription] varchar(40) collate database_default NULL, '+
              '[PortionTypeName] varchar(16) collate database_default NULL, '+
              '[Division Name] varchar(20) collate database_default NULL, '+
              '[SubDivision Name] varchar(20) collate database_default NULL, '+
              '[SuperCategory Name] varchar(20) collate database_default NULL, '+
              '[Category Name] varchar(20) collate database_default NULL, '+
              '[Sub-Category Name] varchar(20) collate database_default NULL';

          ProgressForm.MoveOn(50);
          ProcessPaintMessages;

          for i := 0 to SelectedBands.Count-1 do
            CommandText := CommandText +
            ', ['+SelectedBands[i]+'] [smallmoney] NULL, '+
            '['+SelectedBands[i]+'Mod] [bit] NOT NULL DEFAULT (0), '+
            '['+SelectedBands[i]+'Cancel] [bit] NOT NULL DEFAULT (0), '+
            '['+SelectedBands[i]+'DueNow] [bit] NULL';  //Used to colour prices due to take effect on the selected date.

          CommandText := CommandText + ') ';

          CommandText := CommandText +
            'CREATE UNIQUE CLUSTERED INDEX [pk_#CrossPrices] ON #CrossPrices '+
            '([ProductID], [PortionTypeID]) ';


          {---- (3) Populate #CrossPrices with the matrix prices from Pbandval which satisfy the filter
                    settings. This query therefore involves the crosstabulation of the PbandVal.Band
                    field into columns within #CrossPrices. }

          CommandText := CommandText +
            'INSERT INTO #CrossPrices (ProductID, PortionTypeID, [Product Name], [Import/Export Reference], '+
                                      '[DisplayProductName], [ProductDescription], [PortionTypeName] '+
                                      SelectedBandsList + ') '+
            'SELECT s.ProductID, s.PortionTypeID, s.[Extended RTL Name], s.[Import/Export Reference], '+
                   's.[Extended RTL Name], s.[Retail Description], s.[PortionTypeName]';

          for i := 0 to SelectedBands.Count-1 do
            CommandText := CommandText +
                   ', SUM(CASE v.Band when ' + QuotedStr(SelectedBands[i]) + ' then v.Price END) AS [' + SelectedBands[i] +'], '+
                     'SUM(CASE v.Band when ' + QuotedStr(SelectedBands[i]) + ' then v.DueNow END) AS [' + SelectedBands[i] +'DueNow]';

          CommandText := CommandText +
            ' FROM #PMSelectedProducts s ' +

                  'LEFT OUTER JOIN '+

                  '(SELECT b.*, CASE d.MaxDate when '''+formatdatetime('yyyymmdd', SelectedDate)+''' then 1 else 0 end AS DueNow '+
                   'FROM PbandVal b JOIN '+
                        '(SELECT MatrixID, ProductID, PortionTypeID, Band, max(StartDate) as MaxDate '+
                        'FROM PbandVal '+
                        'WHERE StartDate <= ''' + formatdatetime('yyyymmdd', SelectedDate) + ''' AND ' +
                              'Deleted = 0 and MatrixID = ' + inttostr(TheMatrixID) +
                        ' GROUP BY MatrixID, ProductID, PortionTypeID, Band) d '+
                     'ON b.MatrixID = d.MatrixID AND b.ProductID = d.ProductID AND '+
                        'b.PortionTypeID = d.PortionTypeID AND b.Band = d.Band AND '+
                        'b.StartDate = d.MaxDate) v '+
                  'ON s.ProductID = v.ProductID AND s.PortionTypeID = v.PortionTypeID '+

            'GROUP BY s.ProductID, s.PortionTypeID, s.[Import/Export Reference], s.[Extended RTL Name], s.[Retail Description], s.[PortionTypeName] '+
            'ORDER BY s.[Extended RTL Name], s.PortionTypeID';

          //Put in the description fields that we had to leave out during
          //the cross tabulation (due to the necessary SUM/GROUP BY pattern of the cross tab)
          CommandText := CommandText +
                         ' UPDATE #CrossPrices '+

                         'SET [Division Name] = s.[Division Name], '+
                         '[SubDivision Name] = s.[SubDivision Name], '+
                         '[SuperCategory Name] = s.[SuperCategory Name], '+
                         '[Category Name] = s.[Category Name], '+
                         '[Sub-Category Name] = s.[Sub-Category Name] '+
                         'FROM #CrossPrices cp '+
                         'JOIN #PMSelectedProducts s '+
                         'ON cp.ProductID = s.ProductID';

          //Only now do we consider the null price filter.
          //Rolling this query into the above one is deemed too risky
          //at the present time
          if (ProductStructureFilterFrame.cmbbxPricing.ItemIndex = Integer(UnPriced)) and (SelectedBands.Count >= 1) then
          begin
            CommandText := CommandText + ' DELETE FROM #CrossPrices WHERE ';

            for i := 0 to SelectedBands.Count-2 do
              CommandText := CommandText + '(['+ SelectedBands[i] + '] IS NOT NULL) OR ';
            CommandText := CommandText + '(['+ SelectedBands[SelectedBands.Count-1] + '] IS NOT NULL) ';
          end
          else
            if (ProductStructureFilterFrame.cmbbxPricing.ItemIndex = Integer(Priced)) and (SelectedBands.Count >= 1) then
            begin
              CommandText := CommandText + ' DELETE FROM #CrossPrices WHERE ';

              for i := 0 to SelectedBands.Count-2 do
                CommandText := CommandText + '(['+ SelectedBands[i] + '] IS NULL) AND ';
              CommandText := CommandText + '(['+ SelectedBands[SelectedBands.Count-1] + '] IS NULL) ';
            end;

          ProgressForm.MoveOn(75);
          ProcessPaintMessages;

          Execute;
        end;

        tblCrossPrices.Active := True;
        tblHintLookup.Active := True;

        SetGridFieldProperties (SelectedBands.Count);

        PopulateStartDateComboBox(True);
      finally
        tblCrossprices.EnableControls;
      end;

      btnCancelPriceChanges.Enabled := PriceChangesExist;
      grdPriceMatrix.ReadOnly := False;
      lblGridReadOnly.Visible := False;

      ProductSearchFrame.Enabled := True;
      ProductSearchFrame.Clear;
    finally
      EnableWindow(Handle, TRUE);
      SetForegroundWindow(Handle);
    end;
  finally
    ProgressForm.MoveOn(100);
    ProcessPaintMessages;
    Sleep(250);

    FreeAndNil(ProgressForm);
    Screen.Cursor := crDefault;
  end;
end;

//Added by AK for PM360
procedure TfPriceMatrix.grdPriceMatrixDblClick(Sender: TObject);
var
   P:TPoint;
   ACoord:TGridCoord;
   BandLetter: string;
   MatrixID: Integer;
   MatrixName: String;
begin
  grdPriceMatrix.XLSelecting := FALSE;
  P := grdPriceMatrix.ScreenToClient(Mouse.CursorPos);
  try
    grdPriceMatrix.Options := grdPriceMatrix.Options - [dgEditing];
    ACoord := grdPriceMatrix.MouseCoord(P.X,P.Y);
    if (ACoord.Y = 0) and (ACoord.X > grdPriceMatrix.FixedCols) then
    begin
      BandLetter := grdPriceMatrix.Columns[pred(ACoord.X)].FieldName;

      MatrixID := TIntObject(cmbbxMatrix.Items.Objects[cmbbxMatrix.ItemIndex]).Value;
      matrixName := cmbbxMatrix.Items[cmbbxMatrix.ItemIndex];

      EditPriceBandName(Self, BandLetter, MatrixID, MatrixName);

      SetGridFieldProperties(SelectedBands.Count);
    end;
  finally
    grdPriceMatrix.Options := grdPriceMatrix.Options + [dgEditing];
    grdPriceMatrix.SetFocus;
    ReleaseCapture;
  end;
end;

{ Set the grid display properties for the fields in the tblCrossPrices dataset }
procedure TfPriceMatrix.SetGridFieldProperties (const ExpectedBands : integer);
var
  i, BandCount : integer;
  BandName:string;
begin
  BandCount := 0;
  with tblCrossprices do
  begin
    { Set display options for all Price Band fields }
    for i := 0 to FieldCount -1 do
    begin
      if ValidBandNameForMatrix(Fields[i].FieldName, TheMatrixID) then
      begin
        Fields[i].DisplayWidth := 10;
        Fields[i].Visible := true;
        TBCDField(Fields[i]).Currency := true;
        Fields[i].OnChange := HandlePriceChanges;
        Fields[i].ValidChars := Fields[i].ValidChars - ['-'];
        BandName := uEditPriceBandName.GetDisplayLabel(Fields[i].FieldName,
                                                       TIntObject(cmbbxMatrix.Items.Objects[cmbbxMatrix.ItemIndex]).Value);
        if BandName <> Fields[i].FieldName then
          //IMPORTANT: Do not change the format of this without also changing TXLDBGrid.GetBandNameFromColumnName
          Fields[i].DisplayLabel := BandName + #13#10 + '(' + Fields[i].FieldName + ')'
        else
          Fields[i].DisplayLabel := '';

        BandCount := succ(BandCount);
      end else begin
        Fields[i].Visible := false;
      end;
    end;

    FieldByName('DisplayProductName').DisplayLabel := 'Product';
    FieldByName('ProductDescription').DisplayLabel := 'Retail Description';
    FieldByName('Import/Export Reference').DisplayLabel := 'Import/Export Ref';
    FieldByName('PortionTypeName').DisplayLabel := 'Portion';
    if CurrentSortFieldName <> '' then
      FieldByName(CurrentSortFieldName).DisplayLabel := FieldByName(CurrentSortFieldName).DisplayLabel +  #13#10 + '(Ordered)';

    FieldByName('Import/Export Reference').Visible := FShowImportExportRef;
    FieldByName('Import/Export Reference').DisplayWidth := 18;
    FieldByName('DisplayProductName').Visible := true;
    FieldByName('ProductDescription').DisplayWidth := 30;
    FieldByName('ProductDescription').Visible := true;
    FieldByName('PortionTypeName').Visible := true;
  end;
  assert(BandCount = ExpectedBands,
      'TfPriceMatrix.SetGridFieldProperties: Number of price band fields in #CrossPrices ('+inttostr(BandCount)+
      ') different from expected ('+inttostr(ExpectedBands)+')');
end;

procedure TfPriceMatrix.HandlePriceChanges (Sender : TField);
begin
  assert(Sender.DataSet = tblCrossPrices, 'TfPriceMatrix.HandlePriceChanges: Unexpected dataset.');

  if ValidBandNameformatrix(Sender.FieldName, TheMatrixID) then
  begin
    tblCrossPrices.FieldByName(Sender.FieldName + 'Mod').AsBoolean := true;
    tblCrossPrices.FieldByName(Sender.FieldName + 'DueNow').AsBoolean := true;

    // Ensure Prices do not get too large!
    // Boolean flag used to stop a stack overflow caused by recursively calling
    // the TField.OnChange handler within itself.
    if PriceChangeHandled then
      PriceChangeHandled := False
    else
    begin
      if not(Sender.IsNull) and (Sender.Value > MAX_PRICE) then
      begin
        PriceChangeHandled := True;
        Sender.Value := MAX_PRICE;
      end
      else if not(Sender.IsNull) and (Sender.Value < (-1 * MAX_PRICE)) then
      begin
        PriceChangeHandled := True;
        Sender.Value := -1 * MAX_PRICE;
      end;
    end;

    if not UnsavedChangesExist then UnsavedChangesExist := true;
  end;
end;

procedure TfPriceMatrix.btnSaveClick(Sender: TObject);
var
  i: integer;
  StartDate, band: string;
  PricesChangedOrInserted: boolean;
begin

  StartDate := quotedstr(formatdatetime('yyyymmdd', StrToDateConversion(cmbbxStartDate.Text)));

  if tblCrossPrices.State = dsEdit then tblCrossPrices.Post;

  Log.Event(MODULE_NAME, 'Save - About to save price changes for '+
                            IntToStr(dmADO.ADOUpdatesPending(tblCrossPrices))+
                            ' product portion(s) for '+StartDate);

  Screen.Cursor := crHourglass;

  ProgressForm := TProgressForm.Create(nil);
  ProgressForm.Caption := 'Saving Price Matrix Information';

  try
    ProgressForm.MoveOn(0);
    ProgressForm.Cursor := crHourGlass;
    ProgressForm.Show;
    ProcessPaintMessages;

    EnableWindow(Handle, FALSE);

    try
      try
      ProgressForm.MoveOn(10);
      ProcessPaintMessages;

      dmADO.DelSQLTable('#ChangedPrices');

      ProgressForm.MoveOn(15);
      ProcessPaintMessages;

      with ADOCommand do
      begin
        CommandText :=
          'CREATE TABLE #ChangedPrices ( '+
            '[ProductID] [bigint] NOT NULL, '+
            '[PortionTypeID] [int] NOT NULL, '+
            '[Band] [char] (2) collate database_default NOT NULL, '+
            '[Mod] [bit] NOT NULL DEFAULT(0),'+
            '[Cancel] [bit] NOT NULL DEFAULT(0),'+
            '[Price] [smallmoney] NULL)';
        Execute;
      end;

      RoundChangedPricesToTwoDecimalPlaces;

      ProgressForm.MoveOn(25);
      ProcessPaintMessages;

      for i := 0 to SelectedBands.Count-1 do
      begin
        with ADOQuery do
        begin
          band := SelectedBands[i];
          SQL.Text := Format(
            'INSERT INTO #ChangedPrices (ProductID, PortionTypeID, Band, Price, Mod, Cancel) '+
            'SELECT ProductID, PortionTypeID, ' +
            'IsNull((select pbn.Band from PriceBandNames pbn where pbn.DisplayName = %0:s and pbn.MatrixID = %2:d),%0:s),' +
            '[%1:s], [%1:sMod], [%1:sCancel] ' +
            'FROM #CrossPrices cp '+
            'WHERE ([%1:sMod] = 1) OR ([%1:sCancel] = 1)',
            [QuotedStr(band), band, TheMatrixID]);
          ExecSQL;
          if RowsAffected > 0 then
            Log.Event(MODULE_NAME, 'Save - '+ IntToStr(RowsAffected) + ' pending changes for band '+ SelectedBands[i]);
        end;
      end;



      ProgressForm.MoveOn(35);
      ProcessPaintMessages;

      with ADOCommand do
      begin
        CommandText :=
          'CREATE UNIQUE CLUSTERED INDEX [pk_ChangedPrices] ON #ChangedPrices '+
          '([ProductID], [PortionTypeID], [Band])';
        Execute;
      end;

      ProgressForm.MoveOn(50);
      ProcessPaintMessages;

      dmADO.BeginTransaction;

      with ADOQuery do
      begin
        SQL.Text :=
          'UPDATE PBandVal '+
          'SET Price = c.Price, '+
              'LMDT = GetDate(), '+
              'Deleted = 0, ' +
              'ModifiedBy = ' + QuotedStr(CurrentUser.UserName) + ',' +
              'SentToTill = 0 ' +
          'FROM PbandVal p join #ChangedPrices c '+
            'ON p.ProductID = c.ProductID AND '+
               'p.PortionTypeID = c.PortionTypeID AND '+
               'p.Band = c.Band '+
          'WHERE (p.StartDate = ' + StartDate + ') AND (c.Mod = 1) and (MatrixID = ' +
            inttostr(TheMatrixID) + ')';
        ExecSQL;
        PricesChangedOrInserted := (RowsAffected > 0);
        Log.Event(MODULE_NAME, 'Save - '+ IntToStr(RowsAffected) + ' PBandVal records updated');
      end;

      ProgressForm.MoveOn(65);
      ProcessPaintMessages;

      with ADOQuery do
      begin
        SQL.Text :=
          'INSERT INTO PBandVal(MatrixID, ProductID, PortionTypeID, Band, StartDate, Price, LMDT, Deleted, ModifiedBy, SentToTill) '+
          'SELECT ' + inttostr(TheMatrixID) + ', ProductID, PortionTypeID, Band, ' + StartDate + ', Price, GetDate(), 0, ' + QuotedStr(CurrentUser.UserName) + ', 0 ' +
          'FROM #ChangedPrices c '+
          'WHERE (c.Mod = 1) AND NOT EXISTS (SELECT * FROM PBandVal p '+
                                            'WHERE p.ProductID = c.ProductID AND '+
                                                  'p.PortionTypeID = c.PortionTypeID AND '+
                                                  'p.Band = c.Band AND '+
                                                  'p.StartDate = '+StartDate+ ' AND ' +
                                                  'p.MatrixID = ' + inttostr(TheMatrixID) + ')';
        ExecSQL;
        PricesChangedOrInserted := PricesChangedOrInserted or (RowsAffected > 0);
        Log.Event(MODULE_NAME, 'Save - '+ IntToStr(RowsAffected) + ' PBandVal records inserted');
      end;

      ProgressForm.MoveOn(70);
      ProcessPaintMessages;

      with ADOQuery do
      begin
        SQL.Text :=
        'UPDATE PBandVal '+
        'SET LMDT = GetDate(), '+
            'Deleted = 1, ' +
            'ModifiedBy = ' + QuotedStr(CurrentUser.UserName) + ',' +
            'SentToTill = 0 ' +
        'FROM PbandVal p join #ChangedPrices c '+
          'ON p.ProductID = c.ProductID AND '+
             'p.PortionTypeID = c.PortionTypeID AND '+
             'p.Band = c.Band '+
        'WHERE (p.StartDate = ' + StartDate + ') AND (c.Cancel = 1) AND (c.Mod = 0) ' +
          'and (MatrixID = ' + inttostr(TheMatrixID) + ')';
        ExecSQL;
        Log.Event(MODULE_NAME, 'Save - '+ IntToStr(RowsAffected) + ' PBandVal records marked as deleted');
        end;

      ProgressForm.MoveOn(75);
      ProcessPaintMessages;

      { Reset the <Band>Mod fields in the #CrossPrices table }
      for i := 0 to SelectedBands.Count-1 do
      begin
        with ADOCommand do
        begin
          CommandText :=
            'UPDATE #CrossPrices '+
            'SET [' + SelectedBands[i] + 'Mod] = 0, '+
            '    [' + SelectedBands[i] + 'Cancel] = 0';
          Execute;
        end;
      end;

      ProgressForm.MoveOn(80);
      ProcessPaintMessages;

      dmADO.CommitTransaction;

      ProgressForm.MoveOn(85);
      ProcessPaintMessages;

      btnCancelPriceChanges.Enabled := PricesChangedOrInserted; //Enable this button if there are now saved pending changes.
      UnsavedChangesExist := false;
    except
      on e: Exception do
        begin
          Log.Event(MODULE_NAME, 'Save - Failed to save price changes due to error: '+ E.ClassName + ' ' + E.Message);

          MessageDlg('Failed to save price changes due to an unexpected error.'#13#10#13#10 +
                      'Error message: (' + E.ClassName + ') ' + E.Message, mtError, [mbOK], 0);

          ShowMessage(dmADO.GetAllADOErrors(ADOCommand.Connection));
      end;
    end;

    finally
      Screen.Cursor := crDefault;

      { Make sure the transaction is aborted if an error occured during it }
      if dmADO.InTransaction then
      begin
        dmADO.RollbackTransaction;
        Log.Event(MODULE_NAME, 'Save - Transaction rolled back');
      end;

      tblCrossPrices.Requery;

      ProgressForm.MoveOn(100);
      ProcessPaintMessages;
      Sleep(1000);
    end;

  finally
    FreeAndNil(ProgressForm);
    EnableWindow(Handle, TRUE);
    SetForegroundWindow(Handle);
  end;

  if not UnsavedChangesExist then
    Log.Event(MODULE_NAME, 'Save successful');
end;

procedure TfPriceMatrix.SetUnsavedChangesExist(const Value: boolean);
begin
  if FUnsavedChangesExist = Value then Exit;

  FUnsavedChangesExist := Value;

  { Enable/Disable GUI components }
  btnSave.Enabled := Value;
  btnUndo.Enabled := Value;
  lblUnsavedChanges.Visible := Value;
  edtBands.Enabled := not Value;
  btnLoad.Enabled := not Value;
  ProductStructureFilterFrame.FrameEnabled := not Value;
  cmbbxStartDate.Enabled := not Value;
  cmbbxMatrix.Enabled := not Value;
  btnAddMatrix.Enabled := not Value;
  btnDelMatrix.Enabled := not Value;
end;

procedure TfPriceMatrix.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfPriceMatrix.btnUndoClick(Sender: TObject);
begin
  Screen.Cursor := crHourglass;

  try
    if (MessageDlg('This action will discard all changes you' +
      #10 + #13 + 'have made since the last Save operation.' +
      #10 + #13 + 'Are you sure you want to continue?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
    begin
      Log.Event(MODULE_NAME, 'Undo - '+IntToStr(dmADO.ADOUpdatesPending(tblCrossPrices))+
                                     ' product portion changes undone');
      { Note: Under most circumstances tblCrossprices.CancelBatch would be sufficient here. However if a
        previous save had failed then this will not work as the first thing a save does is to call
        tblCrossprices.UpdateBatch. A complete reload is therefore required. }
      btnLoadClick(nil);
      UnsavedChangesExist := false;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfPriceMatrix.grdPriceMatrixCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
var
  i: integer;
begin
  { Note: It would be more efficient to detect field changes by comparing Field.OldValue with
    Field.NewValue. However, if the Save operation fails this would cause the changed cells to
    revert to normal colour even though they weren't yet saved. }
  i := field.Index;
  {Set text to blue for changed prices, pink for price changes which take effect on the selected date }
  with field.dataset do
    if (Fields[i].datatype = ftBCD) then
    begin
      if (Fields[i + 1].asBoolean = True) or (Fields[i + 2].asBoolean = True) then
        AFont.Color := clBlue
      else if (Fields[i + 3].asBoolean = True) then
        AFont.Color := clFuchsia;
    end;
end;

procedure TfPriceMatrix.PopulateStartDateComboBox(KeepCurrent: Boolean);
var
  MatrixID: integer;
begin
  MatrixID := TIntObject(cmbbxMatrix.Items.Objects[cmbbxMatrix.ItemIndex]).Value;

  with ADOQuery do
  begin
    SQL.Text :=
      'SELECT DISTINCT StartDate '+
      'FROM PbandVal ' +
      'WHERE (StartDate > GetDate()) AND (Deleted = 0) and MatrixID = ' +
      inttostr(MatrixID) +
      ' ORDER BY StartDate';
    Open;
    Log.Event(MODULE_NAME, IntToStr(RecordCount) + ' start dates found in PBandVal');

    cmbbxStartDate.Items.Clear;
    cmbbxStartDate.Items.Add(DateToStr(Date()));

    while not EOF do
    begin
      cmbbxStartDate.Items.Add(DateToStr(FieldByName('StartDate').AsDateTime));
      Next;
    end;
    Close;

    cmbbxStartDate.Items.Add(CREATE_NEW_TEXT);

    if KeepCurrent then
    begin
      //A date is currently selected. Make sure this date is still in the list. It may not be if
      //it was just created using the <Create New...> option.
      AddStartDate(StrToDateConversion(SelectedStartDate));
    end
    else if (SelectedStartDate = '') or (cmbbxStartDate.Items.IndexOf(SelectedStartDate) = -1) then
      //No date selected by user yet, so default to todays date
      SelectedStartDate := DateToStr(Date());

    cmbbxStartDate.ItemIndex := cmbbxStartDate.Items.IndexOf(SelectedStartDate);
  end;
end;

function TfPriceMatrix.AddStartDate (NewDate : TDateTime) : integer;
var i : integer;
    CurrDate : TDateTime;
begin
  //Find the position in the combo box list in which to insert NewDate
  i := 0;
  while (i <= cmbbxStartDate.Items.Count - 2) do
  begin
    CurrDate := StrToDateConversion(cmbbxStartDate.Items[i]);

    if CurrDate = NewDate then
    begin
      Result := i;
      Exit; //NewDate is already in the list
    end else if CurrDate > NewDate then
      Break //NewDate must go in this position in the list
    else
      i := succ(i);
  end;

  cmbbxStartDate.Items.Insert(i, DateToStr(NewDate));

  Result := i;

end;

procedure TfPriceMatrix.cmbbxStartDateChange(Sender: TObject);
begin
  if cmbbxStartDate.Text = SelectedStartDate then Exit; //Selected date has simply been re-selected.

  if cmbbxStartDate.Text = CREATE_NEW_TEXT then
  begin
    with TfPriceStartDate.Create(self) do
    try
      if ShowModal = mrOK then
      begin
        SelectedStartDate := DateToStr(ChosenDate);
        cmbbxStartDate.ItemIndex := AddStartDate(ChosenDate);
      end else
      begin
        //Restore date which was selected before user picked <Create New...>
        cmbbxStartDate.ItemIndex := cmbbxStartDate.Items.IndexOf(SelectedStartDate);
        exit;
      end;
    finally
      Free;
    end;
  end else
  begin
    SelectedStartDate := cmbbxStartDate.Text;
  end;

  //We must ensure that the data in the grid always reflects the selected date. Therefore, reload data into
  //the grid now, but only if there is currently data in the grid.
  if tblCrossPrices.Active and (tblCrossPrices.RecordCount > 0) then btnLoadClick(nil);
end;

procedure TfPriceMatrix.btnCancelPriceChangesClick(Sender: TObject);
var
  NumPriceChangesCancelled, i: integer;
  SelectedDate : TDateTime;
begin
  if MessageDlg('Cancel all price changes for the selected date (shown in pink) ?'+#13+#10+
             '(The prices will revert to the previous price)', mtConfirmation, [mbOK,mbCancel], 0) = mrOK then
  begin
    Screen.Cursor := crHourglass;
    tblCrossPrices.Active := false;
    tblHintLookup.Active := False;

    try try
      {---------------------------------------------------------------------------------------}
      { In the loaded data (i.e. #CrossPrices) change all prices which are due to change      }
      { on the currently selected date to show the previous price. This is purely a visual    }
      { change for the user. Also set the <Band>Cancel field to 1 - This will be used by the  }
      { Save operation to set Deleted = 1 in the corresponding PBandVal record                }
      {---------------------------------------------------------------------------------------}

      dmADO.DelSQLTable('#PBandValTmp');

      //Create temporary table #PBandValTmp which will hold the Pbandval prices previous to the
      //ones being cancelled.
      with ADOCommand do
      begin
        CommandText :=
          'CREATE TABLE #PBandValTmp ( '+
          '[ProductID] [bigint] NOT NULL, '+
          '[PortionTypeID] [int] NOT NULL, '+
          '[Band] varchar(2) collate database_default NULL, '+
          '[Price] smallmoney NULL)';
        Execute;
      end;

      //Populate #PBandValTmp with the prices immediately prior to the selected date in the 'Prices as of' combo.

      SelectedDate := StrToDateConversion(cmbbxStartDate.Text);


      with ADOCommand do
      begin
        CommandText :=
          'INSERT INTO #PBandValTmp (ProductID, PortionTypeID, Band, Price) ' +
          'SELECT c.ProductID, c.PortionTypeID, v.Band, v.Price ' +
          'FROM #CrossPrices c '+

                'JOIN '+

                '(SELECT p.ProductID, p.PortionTypeID, p.Band, p.Price ' +
                 'FROM PbandVal p JOIN '+
                      '(SELECT MatrixID, ProductID, PortionTypeID, Band, max(StartDate) as MaxDate '+
                       'FROM PbandVal '+
                       'WHERE StartDate < ''' + formatdatetime('yyyymmdd', SelectedDate) + ''' AND Deleted = 0 ' +
                       'and MatrixID = ' + inttostr(theMatrixID) +
                       ' GROUP BY MatrixID, ProductID, PortionTypeID, Band) d '+
                      'ON p.MatrixID = d.MatrixID AND p.ProductID = d.ProductID AND '+
                         'p.PortionTypeID = d.PortionTypeID AND p.Band = d.Band AND '+
                         'p.StartDate = d.MaxDate) v '+

                'ON c.ProductID = v.ProductID AND c.PortionTypeID = v.PortionTypeID';
        Execute;
      end;

      //Update #CrossPrices with the prices in #PBandValTmp.
      NumPriceChangesCancelled := 0;

      dmADO.BeginTransaction;

      for i := 0 to SelectedBands.Count-1 do
      begin
        with ADOQuery do
        begin
          SQL.Text :=
            'UPDATE #CrossPrices ' +
            'SET [' + SelectedBands[i] + '] = p.[Price],' +
            '    [' + SelectedBands[i] + 'Cancel] = 1,' +
            '    [' + SelectedBands[i] + 'DueNow] = 0 ' +
            'FROM #CrossPrices c LEFT OUTER JOIN #PBandValTmp p ' +
              'ON c.[ProductID] = p.[ProductID] AND c.[PortionTypeID] = p.[PortionTypeID] AND ' +
                 'p.Band = ' + QuotedStr(SelectedBands[i]) + ' ' +
            'WHERE (c.[' + SelectedBands[i] + 'DueNow] = 1) AND (c.[' + SelectedBands[i] + 'Mod] = 0)';
          ExecSQL;
          NumPriceChangesCancelled := NumPriceChangesCancelled + RowsAffected;
        end;
      end;

      Log.Event(MODULE_NAME, 'Cancel Price Changes - '+ IntToStr(NumPriceChangesCancelled) + ' price changes cancelled');

      if (NumPriceChangesCancelled > 0) then UnsavedChangesExist := true;
      btnCancelPriceChanges.Enabled := false;

      dmADO.CommitTransaction;

    except
      on e: Exception do
        begin
          Log.Event(MODULE_NAME, 'Cancel Price Changes - Failed due to error: '+ E.ClassName + ' ' + E.Message);

          MessageDlg('Failed to cancel price changes due to an unexpected error.'#13#10#13#10 +
                      'Error message: (' + E.ClassName + ') ' + E.Message, mtError, [mbOK], 0);
      end;
    end;

    finally
      { Make sure the transaction is aborted if an error occured during it }
      if dmADO.InTransaction then
      begin
        dmADO.RollbackTransaction;
        Log.Event(MODULE_NAME, 'Cancel Price Changes - Transaction rolled back');
      end;

      tblCrossprices.DisableControls;
      tblCrossPrices.Active := true;
      tblHintLookup.Active := True;
      SetGridFieldProperties(SelectedBands.Count);
      tblCrossprices.EnableControls;
      Screen.Cursor := crDefault;
    end;

  end; { if MessageDlg... }
end;

{ Returns true if the currently loaded data contains saved changes for the selected date }
function TfPriceMatrix.PriceChangesExist : boolean;
var i : integer;
begin
  Result := false;

  for i := 0 to SelectedBands.Count-1 do
  begin
    with ADOQuery do
    begin
      Close;
      SQL.Text :=
        'SELECT COUNT(*) AS NumPriceChanges '+
        'FROM #CrossPrices '+
        'WHERE [' + SelectedBands[i] + 'DueNow] = 1';
      Open;

      if FieldByName('NumPriceChanges').Value > 0 then
      begin
        Close;
        Result := true;
        Exit;
      end;
    end;
  end;

  ADOQuery.Close;
end;

procedure TfPriceMatrix.grdPriceMatrixMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if tblCrossPrices.Active then
    CurrentRow := tblCrossPrices.RecNo - grdPriceMatrix.GetActiveRow + grdPriceMatrix.MouseCoord(X, Y).Y - 1
  else
    CurrentRow := -1;
end;

function TfPriceMatrix.getProductDesc: string;
var
  OldRecNo: integer;
begin
  with tblHintLookup do
  begin
    if (Active) and (CurrentRow > 0) then
    begin
      OldRecNo := RecNo;
      RecNo := CurrentRow;
      Result := FieldByName('ProductDescription').AsString;
      RecNo := OldRecNo;
    end
    else
      Result := '';
  end;
end;

procedure TfPriceMatrix.ApplicationEvents1ShowHint(var HintStr: String;
  var CanShow: Boolean; var HintInfo: THintInfo);
begin
  if HintInfo.HintControl <> grdPriceMatrix then
    exit;
  if CurrentRow = OldCurrentRow then
  begin
    HintStr := '';
    CanShow := True;
    HintInfo.ReshowTimeout := 0;
  end
  else
  begin
    HintStr := GetProductDesc;
    CanShow := True;
    HintInfo.ReshowTimeout := 2000;
    HintInfo.HideTimeout := 2000;
  end;

  OldCurrentRow := CurrentRow;
end;

procedure TfPriceMatrix.EditCopy1Execute(Sender: TObject);
begin
  if tblCrossPrices.State in [dsInsert, dsEdit] then
    tblCrossPrices.Post;

  Screen.Cursor := crHourglass;

  try
    grdPriceMatrix.XLCopySelection;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfPriceMatrix.EditPaste1Execute(Sender: TObject);
begin
  ProgressForm := TProgressForm.Create('Pasting Update Price Matrix Information');

  try
    ProgressForm.MoveOn(0);
    ProgressForm.Cursor := crHourGlass;

    ProgressForm.Show;

    if tblCrossPrices.Active then
    begin
      if tblCrossPrices.State in [dsInsert, dsEdit] then
        tblCrossPrices.Post;

      ProcessPaintMessages;
      Screen.Cursor := crHourglass;

      ProgressForm.MoveOn(50);
      ProcessPaintMessages;

      try
        ProgressForm.MoveOn(60);
        grdPriceMatrix.XLPasteToSelection(SelectedBands);
        ProgressForm.MoveOn(70);
      finally
        Screen.Cursor := crDefault;
      end;
    end;
  finally
    ProgressForm.MoveOn(100);
    Sleep(250);
    FreeAndNil(ProgressForm);
    SetForegroundWindow(Application.Handle);
  end;
end;

procedure TfPriceMatrix.HandleCopyUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := tblCrossPrices.Active;
end;

procedure TfPriceMatrix.HandlePasteUpdate(Sender: TObject);
begin
  try
    if (not tblCrossPrices.Active) or (grdPriceMatrix.ReadOnly) then
      TAction(Sender).Enabled := False
    else
    begin
      TAction(Sender).Enabled := Clipboard.HasFormat(CF_TEXT);
    end;
  except
    TAction(Sender).Enabled := False;
  end;
end;

procedure TfPriceMatrix.acIncDecExecute(Sender: TObject);
begin
  Log.Event('Price Matrix', ' +/- button clicked');
  TfIncDec.IncDecSelectedPrices(grdPriceMatrix, TRUE);
end;

procedure TfPriceMatrix.acIncDecUpdate(Sender: TObject);
begin
  acIncDec.Enabled := (tblCrossPrices.Active) and (not grdPriceMatrix.ReadOnly)
    and (grdPriceMatrix.XLSelected or (grdPriceMatrix.GetActiveField.Value <> NULL));
  btnSelectAndCopyAll.Enabled := (tblCrossPrices.Active);
end;

procedure TfPriceMatrix.PopulateMatrixTypes;
var
  AObject: TIntObject;
begin
  cmbbxMatrix.Clear;

  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select MatrixID, MatrixName from PriceMatrix');
    SQL.Add('where Deleted = 0');
    SQL.Add('order by MatrixID');
    Open;

    while not Eof do
    begin
      AObject := TIntObject.Create;
      AObject.Value := FIeldByName('MatrixID').AsInteger;

      cmbbxMatrix.Items.AddObject(FieldByName('MatrixName').AsString, AObject);

      Next;
    end;

    Close;
  end;

  if cmbbxMatrix.Items.Count > 0 then
    cmbbxMatrix.ItemIndex := 0;
end;

procedure TfPriceMatrix.cmbbxMatrixChange(Sender: TObject);
begin
  PopulateStartDateComboBox(False);

  if tblCrossPrices.Active then
  begin
    grdPriceMatrix.ReadOnly := True;
    btnCancelPriceChanges.Enabled := False;

    lblGridReadOnly.Visible := True;
  end;
end;

procedure TfPriceMatrix.btnAddMatrixClick(Sender: TObject);
var
  fAddMatrix: TfAddMatrix;
begin
  fAddMatrix := TfAddMatrix.Create(nil);

  try
    if fAddMatrix.ShowModal = mrOK then
      AddNewMatrix(fAddMatrix.MatrixName);
  finally
    fAddMatrix.Free;
  end;
end;

procedure TfPriceMatrix.AddNewMatrix(MatrixName: string);
begin
  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('declare @NextId int');
    SQL.Add('exec GetNextUniqueID  ''PriceMatrix'', ''MatrixID'', 1, 2147483647, @NextId out');
    SQL.Add('insert PriceMatrix(MatrixID, MatrixName, LMDT, LMBy)');
    SQL.Add('select @NextId, ' + QuotedStr(MatrixName) +
      ', getDate(), ' + QuotedStr(CurrentUser.UserName));
    ExecSQL;
    Close;
  end;

  FreeMatrixObjects;
  PopulateMatrixTypes;

  cmbbxMatrix.ItemIndex := cmbbxMatrix.Items.IndexOf(MatrixName);
  cmbbxMatrixChange(Self);
end;

procedure TfPriceMatrix.FreeMatrixObjects;
var
  i: integer;
begin
  for i := 0 to cmbbxMatrix.Items.Count - 1 do
    cmbbxMatrix.Items.Objects[i].Free;
end;

procedure TfPriceMatrix.btnDelMatrixClick(Sender: TObject);
var
  fDelMatrix: TfDelMatrix;
begin
  fDelMatrix := TfDelMatrix.Create(nil);

  try
    fDelMatrix.UnSavedChanges := UnsavedChangesExist;
    fDelMatrix.CurrentMatrixName := cmbbxMatrix.Text;

    if fDelMatrix.ShowModal = mrOK then
      MatrixDeleted(fDelMatrix.CurrentMatrixDeleted);
  finally
    fDelMatrix.Free;
  end;
end;

procedure TfPriceMatrix.MatrixDeleted(CurrentMatrix: Boolean);
var
  SelectedMatrix, i: integer;
begin
  SelectedMatrix := TIntObject(cmbbxMatrix.Items.Objects[cmbbxMatrix.ItemIndex]).Value;

  PopulateMatrixTypes;

  if CurrentMatrix then
  begin
    tblCrossPrices.Close;
    PopulateStartDateComboBox(False);
  end
  else
  begin
    for i := 0 to cmbbxMatrix.Items.Count - 1 do
    begin
      if TIntObject(cmbbxMatrix.Items.Objects[i]).Value = SelectedMatrix then
      begin
        cmbbxMatrix.ItemIndex := i;
        Break;
      end;
    end;
  end;
end;

procedure TfPriceMatrix.btnSelectAndCopyAllClick(Sender: TObject);
begin
  Screen.Cursor := crHourglass;
  try
    grdPriceMatrix.SelectAll;
    grdPriceMatrix.XLCopySelection;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfPriceMatrix.tmrProgressTimer(Sender: TObject);
begin
  ProgressForm.MoveOn(10);

  if(ProgressForm.ggProgress.Progress >= 90) then
    ProgressForm.MoveOn(0);

  ProcessPaintMessages;
end;

procedure TfPriceMatrix.grdPriceMatrixKeyPress(Sender: TObject;
  var Key: Char);
var
  CurrText: String;
  HackGrid: THackGrid;
  DecimalPos: Integer;
  SelPos: Integer;
  SelLength: Integer;
begin
  HackGrid := THackGrid(Sender);
  if HackGrid.EditorMode then
  begin
    CurrText := HackGrid.InplaceEditor.EditText;
    DecimalPos := Pos('.',CurrText);
    SelPos := HackGrid.InplaceEditor.SelStart;
    SelLength := HackGrid.InplaceEditor.SelLength;

    if not((Key in ['0'..'9', '.']) or (ord(Key) in [VK_BACK, VK_DELETE, VK_ESCAPE, VK_LEFT, VK_RIGHT])) then //valid numeric and edit keys only
      Key := #0
    else if (Key = '.') and (DecimalPos <> 0) then //no more than one decimal
      Key := #0
    else if (Key in ['0'..'9']) and (DecimalPos <> 0)
      and (DecimalPos = (Length(CurrText) - 2))
      and (SelLength = 0)
      and (DecimalPos < SelPos)  then //no more than 2 decimal places
      Key := #0
    else if (Key in ['0'..'9']) and (DecimalPos > 5) and (SelPos < DecimalPos) then //no more than 5 digits before the decimal
      Key := #0
    else if (Key in ['0'..'9']) and (DecimalPos = 0)
      and (Length(Currtext) >= 5) then //limit the number of digits before the decimal and auto insert the decimal if it isn't there
    begin
      HackGrid.InplaceEditor.EditText := CurrText + '.';
      HackGrid.InplaceEditor.SelStart := Length(HackGrid.InplaceEditor.EditText);
      //Key := #0;
    end;
  end;

  if Ord(Key) = VK_TAB then
    if btnAddMatrix.Enabled then
      btnAddMatrix.SetFocus
    else if btnIncDec.Enabled then
      btnIncDec.SetFocus
    else if btnCopy.Enabled then
      btnCopy.SetFocus
end;

procedure TfPriceMatrix.ExportAllToClipboardExecute(Sender: TObject);
var
  BandFields: string;
  HeaderFieldsNames: string;
  i: integer;
begin
  Log.Event(MODULE_NAME, 'Starting Export To Clipboard');

  // build up parameters for export method
  Screen.Cursor := crHourglass;
  with TExcelExportImport.Create do
  try
    BandFields := '';
    HeaderFieldsNames := '';
    for i := 0 to pred(SelectedBands.Count) do
    begin
      with ADOQuery do
      try
        SQL.Clear;
        SQL.Append('select DisplayName from PriceBandNames');
        SQL.Append('where Band = ' + QuotedStr(Selectedbands[i]));
        SQL.Append('and MatrixID = ' + IntToStr(TheMatrixID));
        Open;
        if Fields[0].AsString <> '' then
        begin
          HeaderFieldsNames := HeaderFieldsNames + '[' + SelectedBands[i] + ']' + ' as ['+ Fields[0].AsString + ']';
          BandFields := BandFields + '['+ Fields[0].AsString + ']';
        end
        else begin
          HeaderFieldsNames := HeaderFieldsNames + SelectedBands[i];
          BandFields := BandFields + SelectedBands[i];
        end;
      finally
        Close;
      end;

      if i <> pred(SelectedBands.Count) then
      begin
        HeaderFieldsNames := HeaderFieldsNames + ', ';
        BandFields := BandFields + ', ';
      end;
    end;

    RoundChangedPricesToTwoDecimalPlaces;

    CopyToClipBoard(dmAdo.AztecConn,
      '#CrossPrices',
      'ProductID, PortionTypeID',
      ExportFixedFields + ', ' + BandFields,
      '[Product Name], [ProductDescription], PortionTypeID',
      ExportFixedFields + ', ' + HeaderFieldsNames);

    MessageDlg(Format('%s copied to clipboard.',[MODULE_NAME]),
                mtInformation,
                [mbOK],
                0);
  finally
    Screen.Cursor := crDefault;
    Log.Event(MODULE_NAME, 'Completed Export to Clipboard');
    Free;
  end;
end;

procedure TfPriceMatrix.RoundChangedPricesToTwoDecimalPlaces;
var
  i:integer;
begin
  Log.Event(MODULE_NAME, 'Ensuring changed banded prices only 2dps');
  for i := 0 to SelectedBands.Count-1 do
  begin
    with ADOQuery do
    begin
      SQL.Text := Format(
        'UPDATE #CrossPrices SET [%0:s] = ROUND([%0:s], 2) '+
        'WHERE ([%0:sMod] = 1 OR [%0:sCancel] = 1) AND [%0:s] <> ROUND([%0:s], 2)',
        [SelectedBands[i]]);
      ExecSQL;
    end;
  end;
  Log.Event(MODULE_NAME, 'Finished ensuring changed banded prices only 2dps');
end;

procedure TfPriceMatrix.ImportFromClipboardExecute(Sender: TObject);
var
  BandFields, DependentFields, HeaderFieldsNames: string;
  i: integer;
  StartRecNo, RecordsAffected: integer;
  ErrorList : TStringList;
  FieldsToValidate: Integerset;
  KeyFields: String;
begin
  Log.Event(MODULE_NAME, 'Starting Import from Clipboard');
  RecordsAffected := -1;
  // build up parameters for import method
  if tblCrossPrices.State in [dsInsert, dsEdit] then
    tblCrossPrices.Post;

  StartRecNo := tblCrossPrices.RecNo;
  tblCrossPrices.DisableControls;

  Screen.Cursor := crHourglass;
  with TExcelExportImport.Create do
  try
    BandFields := '';
    DependentFields := '';
    HeaderFieldsNames := '';
    KeyFields := 'ProductID, PortionTypeID';
    for i := 0 to pred(SelectedBands.Count) do
    begin
      with ADOQuery do
      try
        SQL.Clear;
        SQL.Append('select DisplayName from PriceBandNames');
        SQL.Append('where Band = ' + QuotedStr(Selectedbands[i]));
        SQL.Append('and MatrixID = ' + IntToStr(TheMatrixID));
        Open;
        if Fields[0].AsString <> '' then
          HeaderFieldsNames := HeaderFieldsNames + Fields[0].AsString
        else
          HeaderFieldsNames := HeaderFieldsNames + SelectedBands[i];
        BandFields := BandFields + SelectedBands[i];
        DependentFields := DependentFields +
                          Selectedbands[i] + 'Mod:1{' + Selectedbands[i] + '};' +
                          Selectedbands[i] + 'Cancel:0{' + Selectedbands[i] + '};' +
                          Selectedbands[i] + 'DueNow:1{' + Selectedbands[i] + '}';
      finally
        ADOQuery.Close;
      end;
      if i <> pred(SelectedBands.Count) then
      begin
        HeaderFieldsNames := HeaderFieldsNames + ', ';
        BandFields := BandFields + ', ';
        DependentFields := DependentFields + ';';
      end;
    end;
    ErrorList := TStringList.Create;

    FieldsToValidate := [];
    for i := 0 to pred(SelectedBands.Count) do
      Include(FieldsToValidate, i+11);

    RecordsAffected := PasteFromClipBoard(dmAdo.AztecConn, '#CrossPrices',
                            KeyFields,
                            ExportFixedFields,
                            BandFields,
                            DependentFields,
                            ErrorList,
                            FieldsToValidate,
                            BandFields,
                            HeaderFieldsNames);
    Log.Event(MODULE_NAME, Format ('Records Affected %d', [RecordsAffected]));
  finally
    Free;
    tblCrossPrices.ReQuery;
    tblCrossPrices.RecNo := StartRecNo;
    tblCrossPrices.EnableControls;
    Screen.Cursor := crDefault;
    if RecordsAffected > 0 then
      SetUnsavedChangesExist(true);
    for i := 0 to ErrorList.Count-1 do
      Log.Event(MODULE_NAME, ErrorList.Strings [i]);
    ErrorList.Free;
    Log.Event(MODULE_NAME, 'Completed Import from Clipboard');
  end;
end;

procedure TfPriceMatrix.grdPriceMatrixMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ACoord: TGridCoord;
  clickedColumn: TPriceMatrixGridColumn;
begin
  ACoord := grdPriceMatrix.MouseCoord(X,Y);
  if (ACoord.X <= grdPriceMatrix.FixedCols) and (ACoord.Y < grdPriceMatrix.FixedRows)
  and (ACoord.X > 0) and (ACoord.Y >= 0) then
  begin
    if tblCrossPrices.State = dsEdit then
      tblCrossPrices.Post;

    clickedColumn := PriceMatrixColumn(ACoord.X);

    tblCrossPrices.DisableControls;
    tblCrossPrices.Active := FALSE;

    if OrderedByColumn = clickedColumn then
      if pos(' ASC',tblCrossPrices.CommandText) > 0 then
      begin
        tblCrossPrices.CommandText := StringReplace(tblCrossPrices.CommandText,' ASC',' DESC',[rfReplaceAll]);
        CurrentSortOrder := soDescending;
      end
      else
      begin
        tblCrossPrices.CommandText := StringReplace(tblCrossPrices.CommandText,' DESC',' ASC',[rfReplaceAll]);
        CurrentSortOrder := soAscending;
      end
    else
    begin
      OrderedByColumn := clickedColumn;
      case OrderedByColumn of
        gcProduct:
          begin
            tblCrossPrices.CommandText :='select * from #Crossprices ' +
                                         'order by [Product Name] ASC, ProductID ASC, PortionTypeID ASC';
            CurrentSortFieldName := 'DisplayProductName';
          end;
        gcDescription:
          begin
            tblCrossPrices.CommandText :='select * from #Crossprices ' +
                                         'order by [ProductDescription] ASC, ProductID ASC, PortionTypeID ASC';
            CurrentSortFieldName := 'ProductDescription';
          end;
        gcPortion:
          begin
            tblCrossPrices.CommandText :='select * from #Crossprices ' +
                                         'order by [PortionTypeName] ASC, ProductID ASC, PortionTypeID ASC';
            CurrentSortFieldName := 'PortionTypeName';
          end;
        gcImportExportRef:
          begin
            tblCrossPrices.CommandText :='select * from #Crossprices ' +
                                         'order by [Import/Export Reference] ASC, ProductID ASC, PortionTypeID ASC';
            CurrentSortFieldName := 'Import/Export Reference';
          end;
      end;
      CurrentSortOrder := soAscending;
    end;

    tblCrossPrices.Active := TRUE;
    SetGridFieldProperties(SelectedBands.Count);
    tblCrossPrices.EnableControls;
  end;
end;

procedure TfPriceMatrix.grdPriceMatrixDrawTitleCell(Sender: TObject;
  Canvas: TCanvas; Field: TField; Rect: TRect;
  var DefaultDrawing: Boolean);
begin
  if pos('Product',Field.DisplayLabel) > 0 then
    grdPriceMatrix.canvas.textrect(rect,0,0,inttostr(rect.Left) + '  ' + inttostr(rect.Top));

end;

procedure TfPriceMatrix.grdPriceMatrixKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = 67) then // Ctrl-C
  begin
    //Note: The call to Application.ProcessMessages makes windows perform its own Ctrl-C handling now. Without this
    // the windows handler is called *after* this procedure has executed and overwrites what EditCopy1Execute places
    // in the clipboard. It would obviously be better to disable the windows Ctr-C handler but I don't know how to do this.
    // GDM 09/08/2013.
    Application.ProcessMessages;
    EditCopy1Execute(Sender)
  end
  else if (ssCtrl in Shift) and (Key = 86) then  // Ctrl-V
  begin
    Application.ProcessMessages; //See comment above for reason why this is called.
    EditPaste1Execute(Sender);
  end;
end;

function TfPriceMatrix.PriceMatrixColumn(columnNumber: integer) : TPriceMatrixGridColumn;
begin
  if not tblCrossPrices.FieldByName('Import/Export Reference').Visible then
    columnNumber := columnNumber + 1;

  case columnNumber of
    1: Result := gcImportExportRef;
    2: Result := gcProduct;
    3: Result := gcDescription;
    4: Result := gcPortion;
    else Result := gcBand;
  end;
end;

procedure TfPriceMatrix.grdPriceMatrixCalcTitleImage(Sender: TObject;
  Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
begin
  TitleImageAttributes.ImageIndex := -1;
  if (Field.FieldName = CurrentSortFieldName) then
  begin
    if (CurrentSortOrder = soAscending) then
      TitleImageAttributes.ImageIndex := 0
    else if (CurrentSortOrder = soDescending) then
      TitleImageAttributes.ImageIndex := 1;

    TitleImageAttributes.margin := 0;
  end;
end;

procedure TfPriceMatrix.chkBoxShowImpExpRefClick(Sender: TObject);
begin
  FShowImportExportRef := chkBoxShowImpExpRef.Checked;

  if FShowImportExportRef then
    grdPriceMatrix.FixedCols := 4
  else
    grdPriceMatrix.FixedCols := 3;

  if tblCrossprices.Active then
    tblCrossprices.FieldByName('Import/Export Reference').Visible := FShowImportExportRef;
end;

procedure TfPriceMatrix.HideSubDivisionAndSuperCategoryFilters;
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
    lblProduct.Left := lblProduct.Left - moveDistance;
    cmbbxProduct.Left := cmbbxProduct.Left - moveDistance;
    lblPortion.Left := lblPortion.Left - moveDistance;
    cmbbxPortion.Left := cmbbxPortion.Left - moveDistance;
    lblPricing.Left := lblPricing.Left - moveDistance;
    cmbbxPricing.Left := cmbbxPricing.Left - moveDistance;
  end;
end;

end.

