unit uOffBandPricesForm;

interface

uses
  Windows, StdCtrls, Classes, ActnList, ADODB, DB, Wwdatsrc, Graphics, Dialogs,
  uProductStructureFilterFrame, Forms, uCompanyStructureFilterFrame, SysUtils,
  Controls, ExtCtrls, Buttons, Grids, Wwdbigrd, XLDBGrid, Variants, Wwkeycb,
  StrUtils, ImgList, uIncDec, Spin, uProductSearchFrame;

type
  THackGrid = class(TwwCustomDBGrid);
  
  TSortOrder = (soAscending, soDescending);

  TOffBandGridColumn = (gcProduct, gcDescription, gcImportExportRef, gcPortion, gcSiteRef, gcSiteName, gcSalesAreaName, gcStartDate,
                 gcOffBandPrice);

  TOffBandPricesForm = class(TForm)
    pnlBottom: TPanel;
    btnClose: TBitBtn;
    btnSave: TBitBtn;
    btnUndo: TBitBtn;

    ADODataSet: TADODataSet;
    ADOCommand: TADOCommand;
    XLGridOffBandPrices: TXLDBGrid;

    dsOffBandprices: TwwDataSource;

    tblOffbandPrices: TADODataSet;
    tblOffbandPricesStartDate: TDateTimeField;
    tblOffbandPricesPrice: TBCDField;
    tblOffbandPricesSiteName: TStringField;
    tblOffbandPricesSiteRef: TStringField;
    tblOffbandPricesSalesAreaName: TStringField;
    tblOffbandPricesProductDescription: TStringField;
    tblOffbandPricesPortionTypeName: TStringField;
    tblOffbandPricesModified: TBooleanField;
    tblOffbandPricesDueNow: TBooleanField;
    tblOffbandPricesDisplayProductName: TStringField;
    tblOffbandPricesImpExpRef: TStringField;
    btnCopy: TBitBtn;
    btnPaste: TBitBtn;
    alMain: TActionList;
    ActionCopy: TAction;
    ActionPaste: TAction;
    ExportAllToClipboard: TAction;
    ImportFromClipboard: TAction;
    TopPanel: TPanel;
    ImageList1: TImageList;
    btnIncDec: TBitBtn;
    ActionIncDec: TAction;
    bitbtnExport: TBitBtn;
    bitbtnImport: TBitBtn;
    tblOffbandPricesCurrentBandedPrice: TBCDField;
    pnlLeft: TPanel;
    GbFilters: TGroupBox;
    lblStartDate: TLabel;
    CbStartDate: TComboBox;
    CompanyStructureFilterFrame: TCompanyStructureFilterFrame;
    ProductStructureFilterFrame: TProductStructureFilterFrame;
    Bevel1: TBevel;
    lblUnsavedChanges: TLabel;
    btnLoad: TBitBtn;
    chkbxShowBandedPrice: TCheckBox;
    tblOffbandPricesProductID: TLargeintField;
    seVisibleRecordCount: TSpinEdit;
    lblRecCountRestriction: TLabel;
    lblRecCountRestriction2: TLabel;
    cbExtraColumnRestriction: TCheckBox;
    Bevel2: TBevel;
    lblVisibleCount: TLabel;
    Bevel3: TBevel;
    chkBoxShowImpExpRef: TCheckBox;
    ProductSearchFrame: TProductSearchFrame;
    bvlFrameIndicator: TBevel;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure CbStartDateChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btnUndoClick(Sender: TObject);
    procedure tblOffbandPricesPriceChange(Sender: TField);
    procedure XLGridOffBandPricesCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
    procedure ActionCopyExecute(Sender: TObject);
    procedure DataLoadedUpdate(Sender: TObject);
    procedure ActionPasteExecute(Sender: TObject);
    procedure ClipboardDataUpdate(Sender: TObject);
    procedure ExportAllToClipboardExecute(Sender: TObject);
    procedure ImportFromClipboardExecute(Sender: TObject);
    procedure XLGridOffBandPricesMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure XLGridOffBandPricesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure XLGridOffBandPricesKeyPress(Sender: TObject; var Key: Char);
    procedure XLGridOffBandPricesCalcTitleImage(Sender: TObject;
      Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
    procedure ActionIncDecExecute(Sender: TObject);
    procedure ActionIncDecUpdate(Sender: TObject);
    procedure CompanyStructureFilterFramebtnSiteTagsClick(Sender: TObject);
    procedure chkBoxShowImpExpRefClick(Sender: TObject);
    procedure seVisibleRecordCountChange(Sender: TObject);
    procedure seVisibleRecordCountKeyPress(Sender: TObject; var Key: Char);
  private
    FCompatibleSitesTable: string;
    FSelectedStartDate: string;
    FUnsavedChangesExist: boolean;   //true if price changes have been made but not yet saved
    FPriceChangeHandled: boolean;
    PassCount: integer;
    OrderedByColumn: TOffBandGridColumn;
    CurrentSortFieldName: String;
    CurrentSortOrder: TSortOrder;
    FShowingCurrentBandedPrice: Boolean;
    FShowImportExportRef: Boolean;
    ExportFixedFields: string;
    procedure SetUnsavedChangesExist(const Value: boolean);
    property UnsavedChangesExist : boolean read FUnsavedChangesExist write SetUnsavedChangesExist;
    procedure PopulateStartDateComboBox;
    function AddStartDate (NewDate : TDateTime) : integer;
    procedure SetGridFieldProperties;
    function OffBandPriceColumn(columnNumber: integer) : TOffBandGridColumn;
    procedure SetVariableFieldWidths;
    procedure HideSubDivisionAndSuperCategoryFilters;
    function GetRowCount(tableName: string): integer;
    procedure RoundChangedPricesToTwoDecimalPlaces;
  end;

procedure EditOffBandPrices;

implementation

uses
  uPricinglog, uAdo, uProgress, uPriceStartDate, dADOAbstract, uGlobals, ClipBrd,
  uExcelExportImport, uMainMenu, uAztecDatabaseUtils, Math;

const
  MODULE_NAME = 'Off-Band Pricing';
  CREATE_NEW_TEXT = '<Create New...>';

{$R *.dfm}

procedure EditOffBandPrices;
var
 OffBandPricesForm: TOffBandPricesForm;
begin
  OffBandPricesForm := TOffBandPricesForm.Create(nil);
  try
    OffBandPricesForm.ShowModal;
  finally
    OffBandPricesForm.Free;
  end;
end;

procedure TOffBandPricesForm.FormCreate(Sender: TObject);
begin
  if HelpExists then
    setHelpContextID(self, PRC_OFF_BAND_PRICES);

  Log.Event(MODULE_NAME, MODULE_NAME + ' Started');

  PopulatePricngList(ProductStructureFilterFrame.cmbbxPricing);

  with dmADO.adoqRun do
  begin
    // Check if we have any incompatible sites
    FCompatibleSitesTable := '#OffBandPricingCompatibleSites';
    SQL.Text :=
      'SELECT a.[SiteCode] FROM CommsVersions a '+
      'WHERE a.[SiteCode] <> 0 '+
      'AND dbo.fn_strVerToInt64(a.[DBVersion]) < dbo.fn_strVerToInt64(''2.8.2.0'') '+
      'SELECT @@RowCount as Output';
    Open;
    if Fields[0].AsInteger = 0 then
      FCompatibleSitesTable := ''
    else
    begin
      // build list of compatible sites
      SQL.Text := Format(
        'CREATE TABLE %0:s ([SiteCode] int, primary key ([SiteCode])) '+
        'INSERT %0:s ([SiteCode]) '+
        'SELECT a.[SiteCode] FROM CommsVersions a '+
        'WHERE a.[SiteCode] <> 0 '+
        'AND dbo.fn_strVerToInt64(a.[DBVersion]) >= dbo.fn_strVerToInt64(''2.8.2.0'')',
        [FCompatibleSitesTable]);
      ExecSQL;
    end;
    Close;
    tblOffbandPricesPrice.ValidChars :=     tblOffbandPricesPrice.ValidChars - ['-'];
  end;

  CompanyStructureFilterFrame.Initialise(FCompatibleSitesTable);
  CompanyStructureFilterFrame.DialogOwner := Self;

  ProductSearchFrame.ProductDataset := tblOffbandPrices;
  ProductSearchFrame.Enabled := false;

  FSelectedStartDate := '';
  PopulateStartDateComboBox;
  UnsavedChangesExist := FALSE;
  FPriceChangeHandled := FALSE;
  FShowImportExportRef := FALSE;
  XLGridOffBandPrices.ColumnHeadingsMismatchUserMessage := 'The Clipboard does not have a single OffBandPrice column.';

  if dmADO.SubDivisionOrSuperCategoryUsed then
  begin
    ExportFixedFields := 'CompanyName, AreaName, SiteRef, SiteName, SalesAreaName, [Division Name], [SubDivision Name], [SuperCategory Name], ' +
              '[Category Name], [Sub-Category Name], ProductName, [Import/Export Reference], ProductDescription, PortionTypeName';
  end
  else
  begin
    HideSubDivisionAndSuperCategoryFilters;
    ExportFixedFields := 'CompanyName, AreaName, SiteRef, SiteName, SalesAreaName, [Division Name], ' +
              '[Category Name], [Sub-Category Name], ProductName, [Import/Export Reference], ProductDescription, PortionTypeName';
  end;

  dmADO.DelSQLTable('#OffBandPrices');

  with ADOCommand do
  begin
    CommandText :=
      'CREATE TABLE #OffBandPrices ( ' +
      '[SalesAreaCode] [smallint] NOT NULL ,' +
      '[ProductID] [bigint] NOT NULL ,' +
      '[PortionTypeID] [int] NOT NULL ,' +
      '[SubCategoryID] int NOT NULL,' +
      '[StartDate] [smalldatetime],' +
      '[OffBandPrice] [smallmoney],' +
      '[CurrentBandedPrice] [smallmoney],' +
      '[Company Code] int,' +
      '[CompanyName] varchar(20) collate database_default,'+
      '[Area Code] int,'+
      '[AreaName] varchar(20) collate database_default,'+
      '[SalesAreaName] VarChar(20) collate database_default,' +
      '[SiteCode] [int] NOT NULL ,' +
      '[SiteRef] VarChar(10) collate database_default,' +
      '[SiteName] VarChar(20) collate database_default,' +
      '[Division Name] varchar(20) collate database_default NULL, '+
      '[SubDivision Name] varchar(20) collate database_default NULL, '+
      '[SuperCategory Name] varchar(20) collate database_default NULL, '+
      '[Category Name] varchar(20) collate database_default NULL, '+
      '[Sub-Category Name] varchar(20) collate database_default NULL, '+
      '[ProductName] VarChar(16) collate database_default,' +
      '[DisplayProductName] VarChar(16) collate database_default,' +
      '[ProductDescription] VarChar(40) collate database_default,' +
      '[Import/Export Reference] varchar(20) collate database_default NULL, '+
      '[PortionTypeName] VarChar(16) collate database_default,' +
      '[Modified] [bit] DEFAULT (0),' +
      '[DueNow] [bit] DEFAULT (0),'+
      'PRIMARY KEY (SiteCode,SalesAreaCode,ProductID,PortionTypeID))';
    Execute;
  end;
  if UKUSMode = 'US' then
    TblOffBandPrices.FieldByName('SalesAreaName').DisplayLabel := 'Profit Center';
  OrderedByColumn := gcSiteName;
  CurrentSortOrder := soAscending;
  CurrentSortFieldName := 'SiteName';
  PassCount := 0;
end;

procedure TOffBandPricesForm.FormDestroy(Sender: TObject);
begin
  dmADO.DelSQLTable('#Tags');
  dmADO.DelSQLTable('#OffBandPrices');
  if FCompatibleSitesTable <> '' then
    dmADO.DelSQLTable(FCompatibleSitesTable);

  //Note: It is necessary to explicitly call Free here. Otherwise when the Destroy method of ProductStructureFilterFrame
  //is called all of it's combo boxes are already cleared and the objects attached are therefore not Freed e.g.
  //the DisposeCmbbxPortion method finds no items to free.
  ProductStructureFilterFrame.Free;
end;

procedure TOffBandPricesForm.btnCloseClick(Sender: TObject);
begin
  Log.Event(MODULE_NAME, 'Close button pressed');
  Close;
end;

procedure TOffBandPricesForm.btnLoadClick(Sender: TObject);
var
  SelectedDate :String;
  ProgressForm :TProgressForm;
  totalFilteredRecords: integer;
begin
  try
    try
      Screen.Cursor := crHourGlass;
      ProgressForm := TProgressForm.Create('Loading Off-Band Price Information');
      ProgressForm.Show;

      Log.Event(MODULE_NAME, 'Loading with filter settings - ');
      Log.Event(MODULE_NAME, '          Site: ' + CompanyStructureFilterFrame.SelectedSiteName);
      Log.Event(MODULE_NAME, '    Sales Area: ' + CompanyStructureFilterFrame.SelectedSalesAreaName);
      if CompanyStructureFilterFrame.chkbxFilterBySiteTag.Checked then
        Log.Event(MODULE_NAME, '     Site Tags: ' + CompanyStructureFilterFrame.TagList.CommaText);
      Log.Event(MODULE_NAME, '      Division: ' + ProductStructureFilterFrame.cmbbxDivision.Text);
      Log.Event(MODULE_NAME, '   SubDivision: ' + ProductStructureFilterFrame.cmbbxSubDivision.Text);
      Log.Event(MODULE_NAME, '      Category: ' + ProductStructureFilterFrame.cmbbxCategory.Text);
      Log.Event(MODULE_NAME, ' SuperCategory: ' + ProductStructureFilterFrame.cmbbxSuperCategory.Text);
      Log.Event(MODULE_NAME, '  Sub-Category: ' + ProductStructureFilterFrame.cmbbxSubCat.Text);
      Log.Event(MODULE_NAME, '       Product: ' + ProductStructureFilterFrame.cmbbxProduct.Text);
      Log.Event(MODULE_NAME, '  Prices as of: ' + CbStartDate.Text);

      tblOffbandPrices.DisableControls;
      tblOffbandPrices.Active := FALSE;
      if seVisibleRecordCount.Text <> '' then
        tblOffBandPrices.MaxRecords := seVisibleRecordCount.Value;

      Assert(CbStartDate.ItemIndex >= 0, 'TOffBandPricesForm.btnLoadClick: No date selected in ''Prices as of'' combo');

      SelectedDate := dmADO.FormatDateForSQL(StrToDateConversion(CbStartDate.Text));

      with ADOCommand do
      begin
        ProgressForm.MoveOn(10);

        Log.Event(MODULE_NAME, '  ###load off band');

        {----  Create #OBSelectedProducts containing the filtered products only. }
        CommandText :=
          'IF object_id(''tempdb..#OBSelectedProducts'') IS NULL ' +
            'CREATE TABLE #OBSelectedProducts ( '+
              '[ProductID] [bigint] NOT NULL, '+
              '[PortionTypeID] int NOT NULL, '+
              '[PortionTypeName] varchar(16) NOT NULL, '+
              '[Extended RTL Name] varchar(16) NULL, '+
              '[Retail Description] varchar(40) NULL, '+
              '[Import/Export Reference] varchar(20) NULL, '+
              '[Division Name] varchar(20) NOT NULL, '+
              '[SubDivision Name] varchar(20) NOT NULL, '+
              '[SuperCategory Name] varchar(20) NOT NULL, '+
              '[Category Name] varchar(20) NOT NULL, '+
              '[Sub-Category Name] varchar(20) NOT NULL, '+
              '[SubCategoryID] int NOT NULL, '+
              'PRIMARY KEY (ProductID, PortionTypeID)) '+
          'ELSE ' +
            'TRUNCATE TABLE #OBSelectedProducts ' +

          'INSERT INTO #OBSelectedProducts ([ProductID], [PortionTypeID], [PortionTypeName], [Extended RTL Name], [Retail Description], [Import/Export Reference],'+
                                         '[Division Name], [SubDivision Name], [SuperCategory Name], [Category Name], [Sub-Category Name], [SubCategoryID]) '+
          'SELECT p.EntityCode, pt.Id, pt.Name, [Extended RTL Name], [Retail Description], [Import/Export Reference], pd.Name, psd.Name, psupc.Name, pc.Name, psc.Name, psc.Id '+
          'FROM Products p '+
            'JOIN Portions po '+
            '  ON p.EntityCode = po.EntityCode '+
            'JOIN ac_PortionType pt '+
            '  ON pt.Id = po.PortionTypeID '+
            'JOIN ac_ProductSubcategory psc '+
            '  ON psc.Name = p.[Sub-Category Name] '+
            'JOIN ac_ProductCategory pc '+
            '  ON pc.Id = psc.ProductCategoryId '+
            'JOIN ac_ProductSuperCategory psupc '+
            '  ON psupc.Id = pc.ProductSuperCategoryId '+
            'JOIN ac_ProductSubDivision psd '+
            '  ON psd.Id = psupc.ProductSubDivisionId '+
            'JOIN ac_ProductDivision pd '+
            '  ON pd.Id = psd.ProductDivisionId '+
          'WHERE '+ ProductStructureFilterFrame.SQLStatementForFilteredProducts;
        Execute;
        ProgressForm.MoveOn(20);

        Log.Event(MODULE_NAME, Format('  ### %d products loaded into #OBSelectedProducts',[GetRowCount('#OBSelectedProducts')]));

        {----  Create #SelectedSalesAreas containing the filtered sales areas only. }
        CommandText :=
          'IF object_id(''tempdb..#SelectedSalesAreas'') IS NULL ' +
            'CREATE TABLE #SelectedSalesAreas ( '+
              'CompanyId int NOT NULL,'+
              'CompanyName varchar(20) NOT NULL,' +
              'AreaId int NOT NULL,' +
              'AreaName varchar(20) NOT NULL,' +
              'SiteId int NOT NULL,' +
              'SiteName varchar(20) NOT NULL,' +
              'SiteRef varchar(10) NULL,'+
              'SalesAreaId int NOT NULL,' +
              'SalesAreaName varchar(20) NOT NULL) ' +
          'ELSE ' +
            'TRUNCATE TABLE #SelectedSalesAreas ' +

          'INSERT #SelectedSalesAreas (CompanyId, CompanyName, AreaId, AreaName, SiteId, SiteRef, SiteName, SalesAreaId, SalesAreaName) ' +
          'SELECT c.Id, c.Name, a.Id, a.Name, st.Id, st.Reference, st.Name, sa.Id, sa.Name ' +
          'FROM ac_SalesArea sa ' +
          '   JOIN ac_Site st ON st.Id = sa.SiteId ' +
          '   JOIN ac_Area a ON a.Id = st.AreaId ' +
          '   JOIN ac_Company c ON c.Id = a.CompanyId ';
        if FCompatibleSitesTable <> '' then
          CommandText := CommandText +
            Format(' JOIN %s ist ON st.id = ist.[SiteCode] ', [FCompatibleSitesTable]);

        CommandText := CommandText +
          'WHERE sa.Deleted = 0 AND st.Deleted = 0 AND a.Deleted = 0 AND c.Deleted = 0 ' +
          '  AND sa.Id NOT IN (SELECT Id FROM #BookingsOnlySalesAreas)';

        if CompanyStructureFilterFrame.SelectedSalesAreaCode <> -1 then
          CommandText := CommandText +
            ' AND sa.id = ' + IntToStr(CompanyStructureFilterFrame.SelectedSalesAreaCode)
        else
          if CompanyStructureFilterFrame.SelectedSiteCode <> -1 then
            CommandText := CommandText +
              ' AND st.id = ' + IntToStr(CompanyStructureFilterFrame.SelectedSiteCode);

        if CompanyStructureFilterFrame.chkbxFilterBySiteTag.Checked and (CompanyStructureFilterFrame.TagList.Count > 0) then
          //Include only sites whose tag set is a superset of the tags contained in #Tags
          CommandText := CommandText +
              ' AND st.id IN (' +
                  'SELECT st.SiteID ' +
                  'FROM ac_SiteTag st ' +
                  ' JOIN #Tags t ON st.TagId = t.TagId ' +
                  'GROUP by st.SiteID ' +
                  'HAVING COUNT(st.TagId) = (SELECT COUNT(TagId) FROM #Tags)) ';
        Execute;
        ProgressForm.MoveOn(25);
      end; //with ADOCommand do

      Log.Event(MODULE_NAME, Format('  ### %d sales areas loaded into #SelectedSalesAreas',[GetRowCount('#SelectedSalesAreas')]));

      with ADOCommand do
      begin
        CommandText :=
          {----  Populate #OffBandPrices with the sales areas and products which have been filtered. }

          'DELETE FROM #OffBandPrices ' +

          'INSERT INTO #OffBandPrices ([Company Code], [CompanyName], [Area Code], '+
                                      '[AreaName], [SalesAreaCode], [SalesAreaName], '+
                                      '[SiteCode], [SiteRef], [SiteName], [Division Name], [SubDivision Name], [SuperCategory Name],'+
                                      '[Category Name], [Sub-Category Name], [ProductID], [PortionTypeID], ' +
                                      '[ProductName], [DisplayProductName], [ProductDescription], [Import/Export Reference], ' +
                                      '[PortionTypeName], [SubCategoryID]) ' +

          'SELECT sa.CompanyId, sa.CompanyName, sa.AreaId, sa.AreaName, ' +
                 'sa.SalesAreaId, sa.SalesAreaName, sa.SiteId, ' +
                 'sa.SiteRef, sa.SiteName, sp.[Division Name], sp.[SubDivision Name], sp.[SuperCategory Name], sp.[Category Name], ' +
                 'sp.[Sub-Category Name], sp.[ProductID], sp.[PortionTypeID], ' +
                 'sp.[Extended RTL Name], sp.[Extended RTL Name], sp.[Retail Description], sp.[Import/Export Reference], ' +
                 'sp.[PortionTypeName], sp.[SubCategoryID] ' +
          'FROM #OBSelectedProducts sp ' +

               'CROSS JOIN #SelectedSalesAreas sa ';
        Execute;
        ProgressForm.MoveOn(50);

        Log.Event(MODULE_NAME, '  ###calculate off band');

        CommandText :=
          {---- (5) Update records in #OffBandPrices with the existing off band prices in OffBandPrices table which
                    are effective on the selected start date. }
          'UPDATE #OffBandPrices ' +
          'SET OffBandPrice     = p.Price, ' +
              'StartDate = p.StartDate, ' +
              'DueNow    = p.DueNow ' +
          'FROM #OffBandPrices t ' +

               'INNER JOIN ' +

               '(SELECT o.[SalesAreaCode], o.[ProductID], o.[PortionTypeID], o.[Price], o.[StartDate], ' +
                       'CASE x.[MaxStartDate] WHEN ' + SelectedDate + ' THEN 1 ELSE 0 END AS DueNow ' +
                'FROM OffBandPrices o ' +
                     'INNER JOIN ' +
                     '(SELECT o.[SalesAreaCode], o.[ProductID], o.[PortionTypeID], MAX(o.[StartDate]) as MaxStartDate ' +
                      'FROM OffBandPrices o ' +
                      'JOIN #OffBandPrices ot ON o.SalesAreaCode = ot.SalesAreaCode and o.productid = ot.productid and o.portiontypeid = ot.portiontypeid '+
                      'WHERE o.StartDate <= ' + SelectedDate + ' ' +
                      'GROUP BY o.[SalesAreaCode], o.[ProductID], o.[PortionTypeID]) x ' +
                     'ON o.SalesAreaCode = x.SalesAreaCode AND ' +
                        'o.ProductID     = x.ProductID     AND ' +
                        'o.PortionTypeID = x.PortionTypeID AND ' +
                        'o.[StartDate]   = x.[MaxStartDate]) p ' +

               'ON t.SalesAreaCode = p.SalesAreaCode AND ' +
                  't.ProductID     = p.ProductID AND ' +
                  't.PortionTypeID = p.PortionTypeID ';
        Execute;
        ProgressForm.MoveOn(70);

        FShowingCurrentBandedPrice := False;
        if chkbxShowBandedPrice.Checked then
        begin
          Log.Event(MODULE_NAME, '  ###calculate banded');

          CommandText :=
            {---- (6) Update records in #OffBandPrices with the current banded prices that
                      are effective on the selected start date. }
            'UPDATE #OffBandPrices ' +
            'SET CurrentBandedPrice = BandedPrices.Price ' +
            'FROM #OffBandPrices o ' +
            'INNER JOIN SiteMatrix sm ON sm.[SiteCode] = o.[SiteCode] ' +
            'INNER JOIN SABands sab ON sab.[SalesAreaCode] = o.[SalesAreaCode] and sab.SubCategoryCode = o.SubCategoryID '+
            'INNER JOIN (SELECT pbv.[MatrixID], pbv.[ProductID], pbv.[PortionTypeID], pbv.[Band], pbv.[Price] '+
            '            FROM [dbo].[Pbandval] pbv '+
            '            INNER JOIN (SELECT [MatrixID], [ProductID], [PortionTypeID], [Band], MAX([StartDate]) [StartDate] '+
            '                        FROM [dbo].[PBandVal] '+
            '                        WHERE [StartDate] <= ' + SelectedDate + ' AND [Deleted] = 0 '+
            '                        GROUP BY [MatrixID], [ProductID], [PortionTypeID], [Band]) vd '+
            '            ON pbv.[MatrixID]   = vd.[MatrixID] AND '+
            '            pbv.[ProductID] = vd.[ProductID] AND '+
            '            pbv.[PortionTypeID] = vd.[PortionTypeID] AND '+
            '            pbv.[Band]          = vd.[Band] AND '+
            '            pbv.[StartDate]     = vd.[StartDate] '+
            '            WHERE pbv.[StartDate] <= ' + SelectedDate + ') BandedPrices '+
            'ON BandedPrices.[ProductID] = o.ProductID AND '+
            'BandedPrices.portiontypeid = o.PortionTypeID AND '+
            'BandedPrices.MatrixID = sm.CurrentMatrix and '+
            'BandedPrices.Band = sab.CurrentBand ';
          FShowingCurrentBandedPrice := True;
        end;

        if (ProductStructureFilterFrame.cmbbxPricing.ItemIndex = Integer(UnPriced)) then
          CommandText := CommandText + 'DELETE FROM #OffBandPrices WHERE OffBandPrice IS NOT NULL'
        else
          if (ProductStructureFilterFrame.cmbbxPricing.ItemIndex = Integer(Priced)) then
            CommandText := CommandText + 'DELETE FROM #OffBandPrices WHERE OffBandPrice IS NULL';

        Execute;
        ProgressForm.MoveOn(80);

        Log.Event(MODULE_NAME, '  ###load ended');
      end;

      tblOffbandPrices.CommandText :=
        'SELECT [Import/Export Reference], SiteRef, SiteName, SalesAreaName, DisplayProductName, ProductDescription, PortionTypeName, StartDate, OffBandPrice,' +
        ' SalesAreaCode, ProductID,PortionTypeID, Modified,DueNow, CurrentBandedPrice ' +
        'FROM #OffBandPrices ' +
        'ORDER BY [SiteName] ASC, [SiteRef] ASC,  [SalesAreaName] ASC, [ProductName] ASC, [PortionTypeID] ASC';

      tblOffbandPrices.Active := TRUE;
      ProgressForm.MoveOn(90);

      totalFilteredRecords := GetRowCount('#OffBandPrices');

      Log.Event(MODULE_NAME, Format('%d of %d records loaded',[tblOffbandPrices.RecordCount, totalFilteredRecords]));
      lblVisibleCount.Caption := Format('[%d of %d records displayed]',[tblOffbandPrices.RecordCount, totalFilteredRecords]);
      lblVisibleCount.Visible := True;
      tblOffbandPrices.EnableControls;

      SetGridFieldProperties;

      if FShowingCurrentBandedPrice then
      begin
        tblOffbandPricesPrice.DisplayWidth := 12;
        tblOffbandPricesCurrentBandedPrice.DisplayWidth := 12;
        tblOffbandPricesCurrentBandedPrice.Visible := True;
        XLGridOffBandPrices.FixedCols := XLGridOffBandPrices.FixedCols + 1;
      end
      else begin
        tblOffbandPricesCurrentBandedPrice.Visible := False;
        tblOffbandPricesPrice.DisplayWidth := 25;
      end;

      ProductSearchFrame.Enabled := true;
      ProductSearchFrame.Clear;

      ProgressForm.MoveOn(100);
    except
       on e : Exception do
       begin
         Log.Event(MODULE_NAME, 'ERROR Failed to load prices: '+ E.ClassName + ' ' + E.Message);

         MessageDlg('Load failed due to an unexpected error.'#13#10#13#10 +
                      'Error message: (' + E.ClassName + ') ' + E.Message, mtError, [mbOK], 0);
       end;
    end;
  finally
    Screen.Cursor := crDefault;
    FreeAndNil(ProgressForm);
  end;
end;

function TOffBandPricesForm.GetRowCount(tableName: string): integer;
begin
  with ADODataset do
  try
    CommandText := 'SELECT COUNT(*) AS Count FROM ' + tableName;
    Open;
    Result := FieldByName('Count').AsInteger;
  finally
    Close;
  end;
end;

procedure TOffBandPricesForm.PopulateStartDateComboBox;
begin
  with ADODataset do
  try
    CommandText :=
      'SELECT DISTINCT StartDate '+
      'FROM OffBandPrices ' +
      'WHERE (StartDate > GetDate()) ' +
      'ORDER BY StartDate';
    Open;
    Log.Event(MODULE_NAME, IntToStr(RecordCount) + ' start dates found in OffBandPrices');

    CbStartDate.Items.Clear;
    CbStartDate.Items.Add(DateToStr(Date()));

    while not EOF do
    begin
      CbStartDate.Items.Add(DateToStr(FieldByName('StartDate').AsDateTime));
      Next;
    end;
  finally
    Close;
  end;

  CbStartDate.Items.Add(CREATE_NEW_TEXT);

  if FSelectedStartDate <> '' then
  begin
    //A date is currently selected. Make sure this date is still in the list. It may not be if
    //it was just created using the <Create New...> option.
    AddStartDate(StrToDateConversion(FSelectedStartDate));
  end
  else
    //No date selected by user yet, so default to todays date
    FSelectedStartDate := DateToStr(Date());

  CbStartDate.ItemIndex := CbStartDate.Items.IndexOf(FSelectedStartDate);
end;

procedure TOffBandPricesForm.CbStartDateChange(Sender: TObject);
begin
  if CbStartDate.Text = FSelectedStartDate then Exit; //Selected date has simply been re-selected.

  if CbStartDate.Text = CREATE_NEW_TEXT then
  begin
    with TfPriceStartDate.Create(self) do
    try
      if ShowModal = mrOK then
      begin
        FSelectedStartDate := DateToStr(ChosenDate);
        CbStartDate.ItemIndex := AddStartDate(ChosenDate);
      end else
      begin
        //Restore date which was selected before user picked <Create New...>
        CbStartDate.ItemIndex := CbStartDate.Items.IndexOf(FSelectedStartDate);
        Exit;
      end;
    finally
      Free;
    end;
  end else
  begin
    FSelectedStartDate := CbStartDate.Text;
  end;

  //We must ensure that the data in the grid always reflects the selected date. Therefore, reload data into
  //the grid now, but only if there is currently data in the grid.
  if tblOffBandPrices.Active and (tblOffBandPrices.RecordCount > 0) then btnLoadClick(nil);
end;


function TOffBandPricesForm.AddStartDate (NewDate : TDateTime) : integer;
var i : integer;
    CurrDate : TDateTime;
begin
  //Find the position in the combo box list in which to insert NewDate
  i := 0;
  while (i <= CbStartDate.Items.Count - 2) do
  begin
    CurrDate := StrToDateConversion(CbStartDate.Items[i]);

    if CurrDate = NewDate then
    begin
      Result := i;
      Exit; //NewDate is already in the list
    end else if CurrDate > NewDate then
      Break //NewDate must go in this position in the list
    else
      i := succ(i);
  end;

  CbStartDate.Items.Insert(i, DateToStr(NewDate));

  Result := i;
end;

procedure TOffBandPricesForm.SetUnsavedChangesExist(const Value: boolean);
begin
  if FUnsavedChangesExist = Value then Exit;

  FUnsavedChangesExist := Value;

  { Enable/Disable GUI components }
  btnSave.Enabled := Value;
  btnUndo.Enabled := Value;
  lblUnsavedChanges.Visible := Value;
  btnLoad.Enabled := not Value;
  CompanyStructureFilterFrame.FrameEnabled := not Value;
  ProductStructureFilterFrame.FrameEnabled := not Value;
  cbExtraColumnRestriction.Enabled := not Value;
  lblRecCountRestriction.Enabled := not Value;
  lblRecCountRestriction2.Enabled := not Value;
  seVisibleRecordCount.Enabled := not Value;
  CbStartDate.Enabled := not Value;
end;

procedure TOffBandPricesForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // Post unsaved changes to grid.
  if tblOffBandPrices.State = dsEdit then
    tblOffBandPrices.Post;

  CanClose := False;

  if UnsavedChangesExist and ( not fMainMenu.IsTerminatingFromInactivity ) then
  begin
    case MessageDlg('Changes have been made to the prices' + #10 + #13 + #10 + #13 +
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
          Log.Event(MODULE_NAME, 'Changed off-band prices abandoned on Exit');
        end;
      end;
    end;
  end
  else
    CanClose := True;
end;

procedure TOffBandPricesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Log.Event(MODULE_NAME, 'Form Closed');
end;

procedure TOffBandPricesForm.btnSaveClick(Sender: TObject);
var
  ProgressForm: TProgressForm;
  RecordsAffected: integer;
begin
  Log.Event(MODULE_NAME, 'Save button pressed');

  if tblOffbandPrices.State = dsEdit then tblOffbandPrices.Post;

  Screen.Cursor := crHourglass;
  ProgressForm := TProgressForm.Create('Saving off-band prices');
  ProgressForm.Show;

  RoundChangedPricesToTwoDecimalPlaces;

  try
    with ADOCommand do
    try
      dmADO.BeginTransaction;

      ProgressForm.MoveOn(10);

      CommandText :=
        'UPDATE OffBandPrices ' +
        'SET [Price] = t.[OffBandPrice], ' +
            '[StartDate] = t.[StartDate], ' +
            '[ModifiedBy] = ' + QuotedStr(CurrentUser.UserName) +
        'FROM OffbandPrices o INNER JOIN #OffBandPrices t ' +
          'ON o.[SalesAreaCode] = t.[SalesAreaCode] AND ' +
             'o.[ProductID] = t.[ProductID] AND ' +
             'o.[PortionTypeID] = t.[PortionTypeID] AND ' +
             'o.[StartDate] = t.[StartDate] ' +
        'WHERE t.[Modified] = 1';
      Execute(RecordsAffected, null);
      Log.Event(MODULE_NAME, IntToStr(RecordsAffected) + ' OffBandPrices records updated');

      ProgressForm.MoveOn(40);

      CommandText :=
        'INSERT INTO OffBandPrices ([SalesAreaCode], [ProductID], [PortionTypeID], [StartDate], [Price], [ModifiedBy]) ' +
        'SELECT [SalesAreaCode], [ProductID], [PortionTypeID], [StartDate], [OffBandPrice],'  + QuotedStr(CurrentUser.UserName) +
        'FROM #OffBandPrices t ' +
        'WHERE t.Modified = 1 AND ' +
              'NOT EXISTS (SELECT * FROM OffBandPrices o ' +
                          'WHERE  o.[SalesAreaCode] = t.[SalesAreaCode] AND ' +
                                 'o.[ProductID] = t.[ProductID] AND ' +
                                 'o.[PortionTypeID] = t.[PortionTypeID] AND ' +
                                 'o.[StartDate] = t.[StartDate])';
      Execute(RecordsAffected, null);
      Log.Event(MODULE_NAME, IntToStr(RecordsAffected) + ' OffBandPrices records inserted');

      ProgressForm.MoveOn(80);

      CommandText := 'UPDATE #OffBandPrices SET [Modified] = 0 WHERE [Modified] = 1';
      Execute;

      ProgressForm.MoveOn(90);

      dmADO.CommitTransaction;

      UnsavedChangesExist := FALSE;
      Log.Event(MODULE_NAME, 'Save successful');

      tblOffbandPrices.Requery;

      ProgressForm.MoveOn(100);
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
    { Make sure the transaction is aborted if an error occured during it }
    if dmADO.InTransaction then
    begin
      dmADO.RollbackTransaction;
      Log.Event(MODULE_NAME, 'Save - Transaction rolled back');
    end;

    Screen.Cursor := crDefault;
    FreeAndNil(ProgressForm);
  end;
end;

procedure TOffBandPricesForm.btnUndoClick(Sender: TObject);
begin
  Log.Event(MODULE_NAME, 'Undo button pressed');
  Screen.Cursor := crHourglass;

  try
    if (MessageDlg('This action will discard all changes you' +
      #10 + #13 + 'have made since the last Save operation.' +
      #10 + #13 + 'Are you sure you want to continue?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
    begin
      Log.Event(MODULE_NAME, 'Undo clicked');
      btnLoadClick(nil);
      UnsavedChangesExist := FALSE;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;


procedure TOffBandPricesForm.tblOffbandPricesPriceChange(Sender: TField);
begin
  tblOffbandPricesModified.AsBoolean := TRUE;
  tblOffbandPricesDueNow.AsBoolean := TRUE;
  tblOffbandPricesStartDate.AsString := FSelectedStartDate;

  // Ensure Prices do not get too large!
  // Boolean flag used to stop a stack overflow caused by recursively calling
  // the TField.OnChange handler within itself.
  if FPriceChangeHandled then
    FPriceChangeHandled := False
  else
  begin
    if not(Sender.IsNull) and (Sender.Value > MAX_PRICE) then
    begin
      FPriceChangeHandled := True;
      Sender.Value := MAX_PRICE;
    end
    else if not(Sender.IsNull) and (Sender.Value < (-1 * MAX_PRICE)) then
    begin
      FPriceChangeHandled := True;
      Sender.Value := -1 * MAX_PRICE;
    end;
  end;

  if not UnsavedChangesExist then UnsavedChangesExist := TRUE;
end;

procedure TOffBandPricesForm.XLGridOffBandPricesCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if Field = tblOffbandPricesPrice then
  begin
    if tblOffbandPricesModified.AsBoolean then
      AFont.Color := clBlue
    else if tblOffbandPricesDueNow.AsBoolean then
      AFont.Color := clFuchsia;
  end;
end;

procedure TOffBandPricesForm.ActionCopyExecute(Sender: TObject);
begin
  if tblOffBandPrices.State in [dsInsert, dsEdit] then
    tblOffBandPrices.Post;

  Screen.Cursor := crHourglass;

  try
    XLGridOffBandPrices.XLCopySelection;
  finally
    Screen.Cursor := crDefault;
  end;

end;

procedure TOffBandPricesForm.DataLoadedUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := tblOffbandPrices.Active;
end;

procedure TOffBandPricesForm.ClipboardDataUpdate(Sender: TObject);
begin
  try
    if (not tblOffbandPrices.Active) or (XLGridOffBandPrices.ReadOnly) then
      TAction(Sender).Enabled := False
    else
    begin
      TAction(Sender).Enabled := Clipboard.HasFormat(CF_TEXT);
    end;
  except
    TAction(Sender).Enabled := False;
  end;
end;

procedure TOffBandPricesForm.ActionPasteExecute(Sender: TObject);
var
  PriceColumnList : TStrings;
  ProgressForm: TProgressForm;
begin
  ProgressForm := TProgressForm.Create('Pasting Off Band Price Information');
  PriceColumnList := nil;

  try
    ProgressForm.MoveOn(0);
    ProgressForm.Cursor := crHourGlass;

    ProgressForm.Show;

    if tblOffBandPrices.Active then
    begin
      if tblOffBandPrices.State in [dsInsert, dsEdit] then
        tblOffBandPrices.Post;

      Application.ProcessMessages;
      Screen.Cursor := crHourglass;

      ProgressForm.MoveOn(50);
      Application.ProcessMessages;

      ProgressForm.MoveOn(60);
      PriceColumnList := TStringList.Create;
      PriceColumnList.Add('OffBandPrice');
      XLGridOffBandPrices.XLPasteToSelection(PriceColumnList);
      ProgressForm.MoveOn(70);
    end;
  finally
    PriceColumnList.Free;
    Screen.Cursor := crDefault;
    ProgressForm.MoveOn(100);
    Sleep(250);
    FreeAndNil(ProgressForm);
    SetForegroundWindow(Application.Handle);
  end;

end;

procedure TOffBandPricesForm.RoundChangedPricesToTwoDecimalPlaces;
begin
  Log.Event(MODULE_NAME, 'Ensuring changed offband prices only 2dps');
  with ADOCommand do
  begin
    CommandText :=
      'UPDATE #OffBandPrices SET OffBandPrice = ROUND(OffBandPrice, 2) '+
      'WHERE [Modified] = 1 AND OffBandPrice <> ROUND(OffBandPrice, 2)';
    Execute;
  end;
  Log.Event(MODULE_NAME, 'Finished ensuring changed offband prices only 2dps');
end;

procedure TOffBandPricesForm.ExportAllToClipboardExecute(Sender: TObject);
var
  DataFields: String;
begin
  Log.Event(MODULE_NAME, 'Starting Export To Clipboard');

  if tblOffBandPrices.State in [dsInsert, dsEdit] then
    tblOffBandPrices.Post;

  Screen.Cursor := crHourglass;
  with TExcelExportImport.Create do try
    if cbExtraColumnRestriction.Checked then
    begin
      if FShowingCurrentBandedPrice then
        DataFields := ExportFixedFields + ', CurrentBandedPrice, OffBandPrice'
      else
        DataFields := ExportFixedFields + ', OffBandPrice';
    end
    else
      DataFields := 'SiteRef, SiteName, SalesAreaName, ProductName, [Import/Export Reference], ProductDescription, PortionTypeName, OffBandPrice';

    RoundChangedPricesToTwoDecimalPlaces;

    try
      CopyToClipBoard(dmAdo.AztecConn, '#OffBandPrices',
        'SalesAreaCode, ProductID, PortionTypeID',
        DataFields,
        'SiteRef, SiteName, ProductName, PortionTypeID');

      MessageDlg(Format('%s copied to clipboard.',[MODULE_NAME]),
                  mtInformation,
                  [mbOK],
                  0);
    except
      on e:exception do
      begin
        MessageDlg(Format('Exception while copying to clipboard: %s',[E.message]),
                    mtInformation,
                    [mbOK],
                    0);
      end;
    end;
  finally
    Log.Event(MODULE_NAME, 'Completed Export to Clipboard');
    Screen.Cursor := crDefault;
    Free;
  end;
  Log.Event(MODULE_NAME, 'Finished Export To Clipboard');
end;

procedure TOffBandPricesForm.ImportFromClipboardExecute(Sender: TObject);
var
  StartRecNo, RecordsAffected: integer;
  i : Integer;
  ErrorList : TStringList;
  FixedFields: String;
  PriceField: Integer;
  KeyFields: String;
  SelectedDate: TDateTime;

  function DeterminePriceFieldIndex: Integer;
  var
    Fixed: TStringList;
    Key: TStringLIst;
  begin
    Fixed := TStringList.Create;
    Key := TStringList.Create;
    try
      ExtractStrings([','], [' '], PChar(FixedFields), Fixed);
      ExtractStrings([','], [' '], PChar('SalesAreaCode, ProductID, PortionTypeID'), Key);
      Result := Fixed.Count + Key.Count;
    finally
      Fixed.Free;
      Key.Free;
    end;
  end;

begin
  Log.Event(MODULE_NAME, 'Starting Import from Clipboard');
  RecordsAffected := -1;
  if tblOffBandPrices.State in [dsInsert, dsEdit] then
    tblOffBandPrices.Post;

  StartRecNo := tblOffBandPrices.RecNo;
  tblOffBandPrices.DisableControls;
  tblOffbandPrices.active := False;
  Screen.Cursor := crHourglass;
  // build up parameters for import method
  with TExcelExportImport.Create do
  begin
    KeyFields := 'SalesAreaCode, ProductID, PortionTypeID';
    ErrorList := TStringList.Create;
    try
      if cbExtraColumnRestriction.Checked then
      begin
        FixedFields := ExportFixedFields;
        if FShowingCurrentBandedPrice then
            FixedFields := ExportFixedFields + ', CurrentBandedPrice';
      end
      else
        FixedFields := 'SiteRef, SiteName, SalesAreaName, ProductName, [Import/Export Reference], ProductDescription, PortionTypeName';

      PriceField := DeterminePriceFieldIndex;
      SelectedDate := StrToDate(CbStartDate.Text);

      RecordsAffected := PasteFromClipBoard(dmAdo.AztecConn, '#OffBandPrices',
          KeyFields,
          FixedFields,
          'OffBandPrice',
          'Modified:1{OffBandPrice};DueNow:1{OffBandPrice};StartDate:'+dmADO.FormatDateForSQL(SelectedDate)+'{OffBandPrice}',
          ErrorList,[PriceField],'OffBandPrice');
    finally
      Free;
      Log.Event(MODULE_NAME, 'Starting ado table refresh');
      tblOffbandPrices.active := true;
      tblOffBandPrices.RecNo := StartRecNo;
      tblOffBandPrices.EnableControls;
      Log.Event(MODULE_NAME, 'Finishing ado table refresh');
      Screen.Cursor := crDefault;
      if RecordsAffected > 0 then
        SetUnsavedChangesExist(true);
      for i := 0 to ErrorList.Count-1 do
        Log.Event(MODULE_NAME, ErrorList.Strings [i]);
      ErrorList.Free;
      Log.Event(MODULE_NAME, 'Completed Import from Clipboard');
    end;
  end;
end;

procedure TOffBandPricesForm.XLGridOffBandPricesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ACoord:TGridCoord;
  FixedColCount: Integer;
  clickedColumn: TOffBandGridColumn;
begin
  ACoord := XLGridOffBandPrices.MouseCoord(X,Y);
  if chkbxShowBandedPrice.Checked then
    FixedColCount := XLGridOffBandPrices.FixedCols - 1
  else
    FixedColCount := XLGridOffBandPrices.FixedCols;
  if (ACoord.X <= FixedColCount) and (ACoord.Y < XLGridOffBandPrices.FixedRows)
  and (ACoord.X > 0) and (ACoord.Y >= 0) then
  begin
    if tblOffBandPrices.State = dsEdit then
      tblOffBandPrices.Post;

    clickedColumn := OffBandPriceColumn(ACoord.X);

    tblOffbandPrices.DisableControls;
    tblOffbandPrices.Active := FALSE;

    if OrderedByColumn = clickedColumn then
      if pos(' ASC',tblOffbandPrices.CommandText) > 0 then
      begin
        tblOffbandPrices.CommandText := StringReplace(tblOffbandPrices.CommandText,' ASC',' DESC',[rfReplaceAll]);
        CurrentSortOrder := soDescending;
      end
      else
      begin
        tblOffbandPrices.CommandText := StringReplace(tblOffbandPrices.CommandText,' DESC',' ASC',[rfReplaceAll]);
        CurrentSortOrder := soAscending;
      end
    else
    begin
      OrderedByColumn := clickedColumn;
      case OrderedByColumn of
        gcImportExportRef:
          begin
            tblOffbandPrices.CommandText := 'SELECT * FROM #OffBandPrices ' +
                                            'ORDER BY [Import/Export Reference] ASC, [ProductName] ASC, [PortionTypeID] ASC, ' +
                                            '[SiteRef] ASC, [SiteName] ASC, [SalesAreaName] ASC';
            CurrentSortFieldName := 'Import/Export Reference';
          end;
        gcSiteRef:
          begin
            tblOffbandPrices.CommandText := 'SELECT * FROM #OffBandPrices ' +
                                            'ORDER BY [SiteRef] ASC, [SiteName] ASC, [SalesAreaName] ASC, ' +
                                                     '[ProductName] ASC, [PortionTypeID] ASC';
            CurrentSortFieldName := 'SiteRef';
          end;
        gcSiteName:
          begin
            tblOffbandPrices.CommandText := 'SELECT * FROM #OffBandPrices ' +
                                            'ORDER BY [SiteName] ASC, [SiteRef] ASC, [SalesAreaName] ASC, ' +
                                                     '[ProductName] ASC, [PortionTypeID] ASC';
            CurrentSortFieldName := 'SiteName';
          end;
        gcSalesAreaName:
          begin
            tblOffbandPrices.CommandText := 'SELECT * FROM #OffBandPrices ' +
                                            'ORDER BY [SalesAreaName] ASC, [SiteRef] ASC, [SiteName] ASC, ' +
                                                     '[ProductName] ASC, [PortionTypeID] ASC';
            CurrentSortFieldName := 'SalesAreaName';
          end;
        gcProduct:
          begin
            tblOffbandPrices.CommandText := 'SELECT * FROM #OffBandPrices ' +
                                            'ORDER BY [ProductName] ASC, [PortionTypeID] ASC, ' +
                                            '[SiteRef] ASC, [SiteName] ASC, [SalesAreaName] ASC';
            CurrentSortFieldName := 'DisplayProductName';
          end;
        gcDescription:
          begin
            tblOffbandPrices.CommandText := 'SELECT * FROM #OffBandPrices ' +
                                            'ORDER BY [ProductDescription] ASC, [PortionTypeID] ASC, ' +
                                            '[SiteRef] ASC, [SiteName] ASC, [SalesAreaName] ASC';
            CurrentSortFieldName := 'ProductDescription';
          end;
        gcPortion:
          begin
            tblOffbandPrices.CommandText := 'SELECT * FROM #OffBandPrices ' +
                                            'ORDER BY [PortionTypeName] ASC, [ProductName] ASC, ' +
                                            '[SiteRef] ASC, [SiteName] ASC, [SalesAreaName] ASC';
            CurrentSortFieldName := 'PortionTypeName';

          end;
        gcStartDate:
          begin
            tblOffbandPrices.CommandText := 'SELECT * FROM #OffBandPrices ' +
                                            'ORDER BY [StartDate] DESC, [ProductName], ' +
                                            '[SiteRef], [SiteName], [SalesAreaName]';
            CurrentSortFieldName := 'StartDate';
          end;
      end;
      CurrentSortOrder := soAscending;
    end;
    SetGridFieldProperties;
    tblOffbandPrices.Active := TRUE;
    tblOffbandPrices.EnableControls;
  end;
end;

procedure TOffBandPricesForm.XLGridOffBandPricesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = 67) then // Ctrl-C
  begin
    //Note: The call to Application.ProcessMessages makes windows perform its own Ctrl-C handling now. Without this
    // the windows handler is called *after* this procedure has executed and overwrites what EditCopy1Execute places
    // in the clipboard. It would obviously be better to disable the windows Ctr-C handler but I don't know how to do this.
    // GDM 09/08/2013.
    Application.ProcessMessages;
    ActionCopyExecute(Sender)
  end
  else if (ssCtrl in Shift) and (Key = 86) then  // Ctrl-V
  begin
    Application.ProcessMessages; //See comment above for reason why this is called.
    ActionPasteExecute(Sender);
  end;
end;

procedure TOffBandPricesForm.XLGridOffBandPricesKeyPress(Sender: TObject;
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
end;

procedure TOffBandPricesForm.XLGridOffBandPricesCalcTitleImage(
  Sender: TObject; Field: TField;
  var TitleImageAttributes: TwwTitleImageAttributes);
begin
  TitleImageAttributes.ImageIndex := -1;
  if (Field.FieldName = CurrentSortFieldName) then
  begin
    if (CurrentSortOrder = soAscending) then
      TitleImageAttributes.ImageIndex := 0
    else if (CurrentSortOrder = soDescending) then
      TitleImageAttributes.ImageIndex := 1;
    TitleImageAttributes.Margin := 0;
  end;
end;

procedure TOffBandPricesForm.ActionIncDecExecute(Sender: TObject);
begin
  Log.Event('Off-Band Pricing', ' +/- button clicked');
  TfIncDec.IncDecSelectedPrices(XLGridOffBandPrices, FALSE);
end;

procedure TOffBandPricesForm.ActionIncDecUpdate(Sender: TObject);
begin
  ActionIncDec.Enabled := (tblOffbandPrices.Active) and (not XLGridOffBandPrices.ReadOnly)
          and (XLGridOffBandPrices.XLSelected or (XLGridOffBandPrices.GetActiveField.Value <> NULL));
end;

procedure TOffBandPricesForm.CompanyStructureFilterFramebtnSiteTagsClick(
  Sender: TObject);
begin
  CompanyStructureFilterFrame.btnSiteTagsClick(Sender);

end;

{ Set the grid display properties for the fields in the tblCrossPrices dataset }
procedure TOffBandPricesForm.SetGridFieldProperties;
begin
  with tblOffBandPrices do
  begin
    DisableControls;
    try
      { Set display options for all Price Band fields }
      tblOffbandPricesImpExpRef.DisplayLabel := 'Import/Export Ref';
      tblOffbandPricesSiteRef.DisplayLabel := 'Site Ref';
      tblOffbandPricesSiteName.DisplayLabel := 'Site';
      tblOffbandPricesSalesAreaName.DisplayLabel := 'Sales Area';
      tblOffbandPricesDisplayProductName.DisplayLabel := 'Product';
      tblOffbandPricesProductDescription.DisplayLabel := 'Retail Description';
      tblOffbandPricesPortionTypeName.DisplayLabel := 'Portion';
      tblOffbandPricesStartDate.DisplayLabel := 'Start Date';
      tblOffbandPricesCurrentBandedPrice.DisplayLabel := 'Banded'#13#10'Price';
      tblOffbandPricesPrice.DisplayLabel := 'Off Band'#13#10'Price';

      if CurrentSortFieldName <> '' then
        FieldByName(CurrentSortFieldName).DisplayLabel := FieldByName(CurrentSortFieldName).DisplayLabel +  #13#10 + '(Ordered)';

      tblOffbandPricesImpExpRef.DisplayWidth := 16;
      tblOffbandPricesSiteName.DisplayWidth := 19;
      tblOffbandPricesSalesAreaName.DisplayWidth := 16;
      tblOffbandPricesPortionTypeName.DisplayWidth := 15;
      tblOffbandPricesStartDate.DisplayWidth := 11;
      SetVariableFieldWidths;

      tblOffbandPricesImpExpRef.Visible := FShowImportExportRef;
    finally
      EnableControls;
    end;
  end;
end;

function TOffBandPricesForm.OffBandPriceColumn(columnNumber: integer) : TOffBandGridColumn;
begin
  if not tblOffbandPricesImpExpRef.Visible then
    columnNumber := columnNumber + 1;

  case columnNumber of
    1: Result := gcImportExportRef;
    2: Result := gcSiteRef;
    3: Result := gcSiteName;
    4: Result := gcSalesAreaName;
    5: Result := gcProduct;
    6: Result := gcDescription;
    7: Result := gcPortion;
    8: Result := gcStartDate;
    else Result := gcOffBandPrice;
  end;
end;

procedure TOffBandPricesForm.chkBoxShowImpExpRefClick(Sender: TObject);
begin
  FShowImportExportRef := chkBoxShowImpExpRef.Checked;

  if FShowImportExportRef then
  begin
    XLGridOffBandPrices.FixedCols := XLGridOffBandPrices.FixedCols + 1;
    tblOffbandPricesImpExpRef.Visible := true;
  end
  else
  begin
    XLGridOffBandPrices.FixedCols := XLGridOffBandPrices.FixedCols - 1;
    tblOffbandPricesImpExpRef.Visible := false;
  end;

  SetVariableFieldWidths;
end;

procedure TOffBandPricesForm.SetVariableFieldWidths;
const
  SITE_REF_DEFAULT_DISPLAY_WIDTH = 10;
  PRODUCT_DESCRIPTION_DEFAULT_DISPLAY_WIDTH = 30;
  PRODUCT_NAME_DEFAULT_DISPLAY_WIDTH = 16;
begin
  if FShowImportExportRef then
  begin
    tblOffbandPricesSiteRef.DisplayWidth := SITE_REF_DEFAULT_DISPLAY_WIDTH;
    tblOffbandPricesProductDescription.DisplayWidth := PRODUCT_DESCRIPTION_DEFAULT_DISPLAY_WIDTH;
    tblOffbandPricesDisplayProductName.DisplayWidth := PRODUCT_NAME_DEFAULT_DISPLAY_WIDTH;
  end
  else
  begin
    tblOffbandPricesSiteRef.DisplayWidth := SITE_REF_DEFAULT_DISPLAY_WIDTH + 2;
    tblOffbandPricesProductDescription.DisplayWidth := PRODUCT_DESCRIPTION_DEFAULT_DISPLAY_WIDTH + 8;
    tblOffbandPricesDisplayProductName.DisplayWidth := PRODUCT_NAME_DEFAULT_DISPLAY_WIDTH + 2;
  end;
end;

procedure TOffBandPricesForm.HideSubDivisionAndSuperCategoryFilters;
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
    chkbxShowBandedPrice.Left := chkbxShowBandedPrice.Left - moveDistance;
    lblPricing.Left := lblPricing.Left - moveDistance;
    cmbbxPricing.Left := cmbbxPricing.Left - moveDistance;
  end;
end;

procedure TOffBandPricesForm.seVisibleRecordCountChange(Sender: TObject);
begin
  with Sender as TSpinEdit do
  begin
    try
      if Text <> '' then
        if StrToInt(Text) > MaxValue then
        begin
          MessageDlg(Format('Value may not exceed %d.',[MaxValue]),mtError, [mbOK],0);
          Value := MaxValue;
        end;
    except
      on E:EConvertError do
      begin
        MessageDlg(Format('Value must be numeric and may not exceed %d.',[MaxValue]),mtError, [mbOK],0);
        Value := MaxValue;
      end;
    end;
  end;
end;

procedure TOffBandPricesForm.seVisibleRecordCountKeyPress(Sender: TObject;
  var Key: Char);
var
  Clpbrd: TClipboard;
begin
  // #3 = ctrl-c, #8 = backspace, #22 = ctrl-v
  if not (Key in [#3, #8, '0'..'9', #22]) then
  begin
    Key := #0;
  end
  else if Key = #22 then
  begin
    Clpbrd := Clipboard;
    try
      StrToInt(Clpbrd.AsText);
    except
      on e:EConvertError do
      begin
        Abort;
      end;
    end;
  end;
end;

end.
