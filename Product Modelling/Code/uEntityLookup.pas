unit uEntityLookup;

(*
 * Unit contains the TEntityLookupFrame class which is a TFrame containing a list of
 * entities and the controls required for searching in the list.  This is used in the
 * line edit dialog, and also in the 'SelectEntityForm'.
 *
 * Author: Hamish Martin, IceCube/Edesix
 *)
 
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Variants, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, DB, FlexiDBGrid, uEntityFilter,
  Menus, ADODB;

type
  // The types of search which can be performed on the entity list.
  //   SearchNext - finds the next entity which matches search criteria.
  //   SearchInc - if the current entity matches the search criteria, then stay on the
  //               current entity, otherwise, do a SearchNext.
  //   SearchPrev - find the previous entity which matches search criteria.
  TSearchType = (SearchNext, SearchInc, SearchPrev);

  TColumnProperties = record
    InitialWidth: Integer;
    Resizable: Boolean;
    GrowthFactor: Integer;
  end;

  // TFrame class containing controls
  TEntityLookupFrame = class(TFrame)
    EntityGrid: TFlexiDBGrid;
    FindLineItemBox: TGroupBox;
    SearchTextEdit: TEdit;
    MidWordSearchCheckBox: TCheckBox;
    FindPrevButton: TButton;
    FindNextButton: TButton;
    GroupBox1: TGroupBox;
    cbFiltered: TCheckBox;
    SetFilterButton: TButton;
    PopupMenu1: TPopupMenu;
    ShowRetailDescriptionMenuItem: TMenuItem;
    ShowEntityCodeMenuItem: TMenuItem;
    additionalFiltersDataset: TADODataSet;
    constructor Create(Owner: TComponent); override;
    procedure EntityGridDblClick(Sender: TObject);
    procedure SetFilterButtonClick(Sender: TObject);
    procedure cbFilteredClick(Sender: TObject);
    procedure ShowRetailDescriptionMenuItemClick(Sender: TObject);
    procedure ShowEntityCodeMenuItemClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
  private
    // Filter form for this entity lookup thingy.
    filterForm: TEntityFilterForm;
    // Basic filter always applied to the recordset
    FbaseFilter: string;

    FwarnOnEmptyFilter : boolean;

    FalwaysVisibleItem : double;
    FdataSource: TDataSource;
    FcurrSupplierRefFilter: string;

    FColumnProperties: array of TColumnProperties;

    procedure confirmSelectedItem( Sender : TObject );
    procedure applyFilter;

    procedure setAlwaysVisibleItem( ec : double );
    procedure beforeFilterOrSearch(Sender: TObject);
    procedure refreshAdditionalFiltersData;
    function additionalFilterContains(EntityCode: double): boolean;
    procedure setDataSource(dataSource: TDataSource);
    procedure applyAdditionalFilter(DataSet: TDataSet; var Accept: Boolean);
    procedure SetupColumnProperties;
  public
    // Event:  invoked when the user presses ENTER anywhere in the frame.
    OnConfirmSelectedItem: TNotifyEvent;
    // Event:  invoked before a filter is applied.
    OnBeforeFilterOrSearch: TNotifyEvent;

    // Setup the base filter
    procedure SetFilter( filter : string );
    // Is the current view filtered?
    function isFiltered : boolean;
    // Is the current view filtered on supplier ref?
    function IsFilteredOnSupplierRef: boolean;
    // Invoke the filter dialog
    procedure showEditFilterForm;
    // Turn off any current filter
    procedure turnFilterOff;

    procedure SetInitialFocus;
    // Display an error message if filtering the table results in no records.
    property warnIfFilterResultsInEmptyTable : boolean read FwarnOnEmptyFilter write FwarnOnEmptyFilter default false;
    // Item which is always visible - set to 0.0 to get rid of the behaviour
    property alwaysVisibleItem : double read FalwaysVisibleItem write setAlwaysVisibleItem;
    // Set the dataset/source displayed in the frame and used to search against. This must be called before the component can be used.
    property dataSource : TDataSource write setDataSource;
  end;

implementation

uses StrUtils, uGuiUtils, uSearchUtils, uDatabaseADO;

{$R *.dfm}

constructor TEntityLookupFrame.Create(Owner: TComponent);
begin
  inherited;
  EntityGrid.DoubleBuffered := True;
  FwarnOnEmptyFilter := false;
  FalwaysVisibleItem := 0.0;
  FcurrSupplierRefFilter := '';
  setupSearchBox( FindLineItemBox, EntityGrid, ['Retail Name'], ['Retail Name'],
                  beforeFilterOrSearch, confirmSelectedItem );
  SetupColumnProperties;
end;

procedure TEntityLookupFrame.beforeFilterOrSearch( Sender : TObject );
begin
  if Assigned( OnBeforeFilterOrSearch) then
    OnBeforeFilterOrSearch( self );
end;

procedure TEntityLookupFrame.confirmSelectedItem( Sender : TObject );
begin
  // User pressed ENTER - invoke event handler
  if Assigned( OnConfirmSelectedItem ) then
    OnConfirmSelectedItem( self );
end;


procedure TEntityLookupFrame.setDataSource(dataSource: TDataSource);
begin
  FdataSource := dataSource;
  EntityGrid.DataSource := FdataSource;
end;

// Double clicking in grid has the same effect as pressing ENTER.
procedure TEntityLookupFrame.EntityGridDblClick(Sender: TObject);
begin
  confirmSelectedItem( Sender );
end;

procedure TEntityLookupFrame.SetInitialFocus;
begin
  PrizmSetFocus(SearchTextEdit);
end;

procedure TEntityLookupFrame.SetFilterButtonClick(Sender: TObject);
begin
  showEditFilterForm;
end;

procedure TEntityLookupFrame.showEditFilterForm;
var
  dataset : TDataset;

begin
  beforeFilterOrSearch( self );

  // Give owner of dataset an chance to object to the popping up of this form.
  dataset := EntityGrid.DataSource.DataSet;
  if dataset = nil then Exit;

  try
    if Assigned( dataset ) and Assigned( dataset.BeforeScroll ) then
      dataset.BeforeScroll( dataset );

    if not Assigned( filterForm ) then begin
      filterForm := TEntityFilterForm.Create( self );
    end;

    // Keep bringing up the filter dialog until the user clears the filter or
    // some rows are found.
    while true do begin
      case filterForm.ShowModal of
        mrOk:
          begin
            setCbStateWithNoEvent( cbFiltered, filterForm.filtered );
            applyFilter;
            if FwarnOnEmptyFilter and isFiltered and (dataset.BOF and dataset.EOF) then
              ShowMessage( 'No products matching the filter were found.  Please modify the filter.' )
            else
              Break;
          end;
      else
        Break;
      end;
    end;

  except
    on EAbort do ;
  end;
end;

procedure TEntityLookupFrame.cbFilteredClick(Sender: TObject);
begin
  if cbFiltered.Checked then
  begin
    // Turn off checkbox - in case user hits cancel
    setCbStateWithNoEvent( cbFiltered, false );
    showEditFilterForm;
  end
  else
    applyFilter;
end;

procedure TEntityLookupFrame.SetFilter( filter : string );
begin
  FbaseFilter := filter;
  setCbStateWithNoEvent( cbFiltered, false );
  applyFilter;
end;

procedure TEntityLookupFrame.refreshAdditionalFiltersData;
begin
  additionalFiltersDataset.Close;
  AdditionalFiltersDataset.Parameters.ParamByName('supplierRefFilter').Value := filterForm.supplierRefFilter;
  AdditionalFiltersDataset.Parameters.ParamByName('usesPortionFilter').Value := filterForm.usesPortionFilter;
  AdditionalFiltersDataset.Parameters.ParamByName('usesTaxRuleFilter').Value := filterForm.usesTaxRuleFilter;
  AdditionalFiltersDataset.Parameters.ParamByName('supplierNameFilter').Value := filterForm.supplierNameFilter;
  AdditionalFiltersDataset.Parameters.ParamByName('barcodeFilter').Value := filterForm.barcodeFilter;
  AdditionalFiltersDataset.Parameters.ParamByName('tagsFilter').Value := filterForm.tagsFilter;

  if filterForm.cbBarcodeSearchForBlank.Checked then
    AdditionalFiltersDataset.Parameters.ParamByName('searchForBlanksBarcode').Value := 1
  else
    AdditionalFiltersDataset.Parameters.ParamByName('searchForBlanksBarcode').Value := 0;
  if filterForm.cbSupplierRefSearchForBlank.Checked then
    AdditionalFiltersDataset.Parameters.ParamByName('searchForBlanksSupplierRef').Value := 1
  else
    AdditionalFiltersDataset.Parameters.ParamByName('searchForBlanksSupplierRef').Value := 0;
  AdditionalFiltersDataset.Open;
end;

function TEntityLookupFrame.additionalFilterContains(entityCode: double): boolean;
begin
  if additionalFiltersDataset.State <> dsBrowse then
  begin
    Result := false;
    Exit;
  end;

  Result :=  AdditionalFiltersDataset.Locate('EntityCode', entityCode, [])
end;

procedure TEntityLookupFrame.applyAdditionalFilter(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept := ProductsDB.ProductNewlyInsertedAndNotSaved or
              additionalFilterContains(Dataset.FieldByName('EntityCode').Value);
end;

procedure TEntityLookupFrame.applyFilter;

  function combineFilters( a, op, b : string ) : string;
  begin
    if (Length(a) > 0) and (Length(b) > 0) then
      Result := '( ' + a + ' ) ' + op + ' ( ' + b + ' )'
    else
      Result := a + b;
  end;

var
  dataset : TDataset;
  oldEntCode : Double;
  filter : string;
begin
  if FdataSource = nil then Exit;

  dataset := FdataSource.DataSet;

  dataset.DisableControls;
  try
    filter := '';
    oldEntCode := dataSet.FieldByName('EntityCode').AsFloat;

    if Assigned( filterForm ) and cbFiltered.Checked then
    begin
      filter := filterForm.filter;
      if FalwaysVisibleItem <> 0.0 then
        filter := combineFilters( filter, 'or', '[EntityCode] = '+FloatToStr(FalwaysVisibleItem) );
      if FilterForm.AdditionalFiltersActive then
      begin
        refreshAdditionalFiltersData;

        dataset.OnFilterRecord := applyAdditionalFilter;
      end
      else
        dataset.OnFilterRecord := nil;
    end
    else
    begin
      dataset.OnFilterRecord := nil;
    end;

    filter := combineFilters( filter, 'and', FbaseFilter );

    dataset.Filtered := false;
    dataset.Filter := filter;
    dataset.Filtered := (Length( dataset.Filter ) > 0) or filterForm.additionalFiltersActive;
    // dataset.locate moves selection to last selected record, or returns false - if not found,
    // select first record - explicitly calling dataset.First ensures that EntityListDataSetAfterScroll is called
    if not(dataset.Locate( 'EntityCode', oldEntCode, [] )) and (dataset.RecordCount > 0) then
      dataset.First;
  finally
    dataset.EnableControls;
  end;
end;

function TEntityLookupFrame.isFiltered : boolean;
begin
  Result := cbFiltered.Checked;
end;

function TEntityLookupFrame.IsFilteredOnSupplierRef: boolean;
begin
  Result := (Length(FcurrSupplierRefFilter) > 0);
end;

procedure TEntityLookupFrame.turnFilterOff;
begin
  if cbFiltered.Checked then
    cbFiltered.Checked := false; // Invokes callback to update filter.
end;

procedure TEntityLookupFrame.setAlwaysVisibleItem(ec: double);
begin
  if ec <> FalwaysVisibleItem then begin
    FalwaysVisibleItem := ec;
    applyFilter;
  end;
end;

procedure TEntityLookupFrame.ShowRetailDescriptionMenuItemClick(
  Sender: TObject);
begin
  ShowRetailDescriptionMenuItem.Checked := true;
  ShowEntityCodeMenuItem.Checked := false;
  EntityGrid.Columns[3].Visible := false;
  EntityGrid.Columns[2].Visible := true;
end;

procedure TEntityLookupFrame.ShowEntityCodeMenuItemClick(Sender: TObject);
var
  width : Integer;
begin
  ShowRetailDescriptionMenuItem.Checked := false;
  ShowEntityCodeMenuItem.Checked := true;

  if EntityGrid.Columns[2].Visible then
    width := EntityGrid.Columns[2].Width
  else
    width := -1;
  EntityGrid.Columns[2].Visible := false;
  EntityGrid.Columns[3].Visible := true;
  if width <> -1 then
  begin
    EntityGrid.Columns[3].Width := width;
    EntityGrid.Columns[3].Alignment := taLeftJustify; //This value is set at complile time but does not remain set.
  end;
end;

procedure TEntityLookupFrame.FrameResize(Sender: TObject);
var
  i : integer;
  TotWidth : integer;
  VarWidth : integer;
  AColumn : TColumn;
  TotGrowthFactor: Integer;
begin
  TotWidth := 0;
  TotGrowthFactor := 0;

  for i := 0 to EntityGrid.Columns.Count -1 do
  begin
    if EntityGrid.Columns[i].Visible then
    begin
      TotWidth := TotWidth + EntityGrid.Columns[i].Width;
      Inc(TotGrowthFactor, FColumnProperties[i].GrowthFactor);
    end;
  end;

  //add 1px for the column separator line
  if dgColLines in EntityGrid.Options then
    TotWidth := TotWidth + EntityGrid.Columns.Count;

  //add indicator column width
  if dgIndicator in EntityGrid.Options then
    TotWidth := TotWidth + IndicatorWidth;

  //Distribute VarWidth to all auto-resizable columns based on growth factor
  if TotGrowthFactor > 0 then
    for i := 0 to EntityGrid.Columns.Count - 1 do
    begin
      if EntityGrid.Columns[i].Visible then
      begin
        VarWidth :=  EntityGrid.ClientWidth - TotWidth - 1;
        VarWidth := Trunc((VarWidth * FColumnProperties[i].GrowthFactor)/TotGrowthFactor);

        AColumn := EntityGrid.Columns[i];
        if AColumn.Visible then
        begin
          AColumn.Width := AColumn.Width + VarWidth;
          if AColumn.Width < FColumnProperties[i].InitialWidth then
            AColumn.Width := FColumnProperties[i].InitialWidth;
        end;
      end;
    end;
end;

procedure TEntityLookupFrame.SetupColumnProperties;
var
  Index: Integer;
  GrowthFactor: Integer;
begin
  GrowthFactor := 1;
  SetLength(FColumnProperties, EntityGrid.Columns.Count);
  for Index := 0 to EntityGrid.Columns.Count - 1 do
  begin
    FColumnProperties[Index].InitialWidth := EntityGrid.Columns[Index].Width;
    FColumnProperties[Index].GrowthFactor := 1;
    if EntityGrid.Columns[Index].FieldName = 'Entity Type' then
      GrowthFactor := 0
    else if EntityGrid.Columns[Index].FieldName = 'Retail Description' then
      GrowthFactor := 3
    else if EntityGrid.Columns[Index].FieldName = 'EntityCode' then
      GrowthFactor := 3;
    FColumnProperties[Index].GrowthFactor := GrowthFactor;
  end;
end;

end.
