unit uEntityFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, uADO, DBCtrls, ExtCtrls, Buttons, CheckLst, ActnList,
  uExtendedCheckListBox, ComCtrls;

(*
 * TTreeLevel is used to store details of members of both the Product Structure tree (Division, Subdivision etc)
 * and Product Tags tree. Defined as a type to allow them to be stored in a list and easily iterated over
 *)
type
  TTreeLevel = class
  private
    FName : String;
    FCheckListBox : TExtendedCheckListBox;
    FDataSet : TADOQuery;
    procedure setCurrentSelection ( NewSelections : TStringList );
    property Name : String read FName write FName;
    property CheckListBox : TExtendedCheckListBox read FCheckListBox write FCheckListBox;
    property DataSet : TADOQuery read FDataSet;
    function getCurrentSelection : TStringList;
    function getSelectionAsString : string;
  public
    constructor create ( aName : String; aCheckListBox : TExtendedCheckListBox; aDataSet : TADOQuery);
    property currentSelection : TStringList read getCurrentSelection write setCurrentSelection;
    function anySelectionsMade : boolean;
end;

(*
 * The form returns filters in two different ways, depending on the filter and where this sits in the database schema.
 * Details directly held in the Products table are accessed via the Filter property, which returns a string for use in
 * the Filter property of the appropriate dataset.
 * Filters accessed in this way are: Product Name, Product Description, Invoice Name, Import/Export Ref,
 * Product Structure, Product Type, Discontinued, Print Stream, Course, Entity Code
 * Details which are held in other tables are accessed as individual properties for each filter to be used in
 * dynamic SQL queries.
 * Filters accessed in this way are Uses Portion, Uses Tax Rule, Product Tags, Supplier Filters, Barcode
 *)
  TEntityFilterForm = class(TForm)
    ProductStructureTreeQuery: TADOQuery;
    okButton: TButton;
    clearFilterButton: TButton;
    cancelButton: TButton;
    pnlButtons: TPanel;
    productTagTreeQuery: TADOQuery;
    productTagTreeQueryTag: TStringField;
    productTagTreeQuerySubSection: TStringField;
    productTagTreeQuerySectionId: TIntegerField;
    productTagTreeQuerySection: TStringField;
    productTagTreeQuerySubGroupId: TIntegerField;
    productTagTreeQuerySubGroup: TStringField;
    productTagTreeQueryGroupId: TIntegerField;
    productTagTreeQueryTagGroup: TStringField;
    productTagTreeQueryTagId: TIntegerField;
    productTagTreeQuerySubSectionId: TIntegerField;
    pnlActiveFilters: TPanel;
    pnlMenu: TPanel;
    ActionList1: TActionList;
    acnShowTextFilter: TAction;
    acnShowProdStructure: TAction;
    acnShowProdSetUp: TAction;
    acnShowProdTags: TAction;
    acnShowSupplier: TAction;
    acnShowBarcode: TAction;
    acnShowEntityCode: TAction;
    btnTextFilter: TButton;
    btnProductStructure: TButton;
    btnProductSetUp: TButton;
    btnProductTags: TButton;
    btnBarcodeFilters: TButton;
    btnSupplierDetails: TButton;
    btnEntityCode: TButton;
    lblMenuLabel: TLabel;
    lblActiveFilters: TLabel;
    rtbActiveFilters: TRichEdit;
    pcMainWindow: TPageControl;
    tsTextFilter: TTabSheet;
    tsProductStructure: TTabSheet;
    tsProductSetUp: TTabSheet;
    tsProductTags: TTabSheet;
    tsBarcode: TTabSheet;
    tsSupplierDetails: TTabSheet;
    tsEntityCode: TTabSheet;
    lblTextFilter: TLabel;
    lblSearchIn: TLabel;
    lblEdText: TLabel;
    edText: TEdit;
    cbName: TCheckBox;
    cbMidwordSearch: TCheckBox;
    cbInvoiceName: TCheckBox;
    cbImportExportRef: TCheckBox;
    cbDescription: TCheckBox;
    cbB2BName: TCheckBox;
    lblSupercategory: TLabel;
    lblSubdivision: TLabel;
    lblSubcategory: TLabel;
    lblProductStructure: TLabel;
    lblDivision: TLabel;
    lblCategory: TLabel;
    clbSupercategory: TExtendedCheckListBox;
    clbSubdivision: TExtendedCheckListBox;
    clbSubcategory: TExtendedCheckListBox;
    clbDivision: TExtendedCheckListBox;
    clbCategory: TExtendedCheckListBox;
    lblTaxRule: TLabel;
    lblProductType: TLabel;
    lblProductSetUp: TLabel;
    lblPrintStream: TLabel;
    lblPortion: TLabel;
    lblDiscontinue: TLabel;
    lblCourse: TLabel;
    clbUsesTaxRule: TExtendedCheckListBox;
    clbUsesPortion: TExtendedCheckListBox;
    clbPrintStream: TExtendedCheckListBox;
    clbLineType: TExtendedCheckListBox;
    clbCourse: TExtendedCheckListBox;
    cbDiscontinue: TComboBox;
    lblTagGroup: TLabel;
    lblTag: TLabel;
    lblSubsection: TLabel;
    lblSubgroup: TLabel;
    lblSection: TLabel;
    lblProductTags: TLabel;
    clbTagGroup: TExtendedCheckListBox;
    clbTag: TExtendedCheckListBox;
    clbSubsection: TExtendedCheckListBox;
    clbSubgroup: TExtendedCheckListBox;
    clbSection: TExtendedCheckListBox;
    lblBarcodeFilters: TLabel;
    lblBarcode: TLabel;
    edBarcode: TEdit;
    lblSupplierRef: TLabel;
    lblSupplierFilters: TLabel;
    lblSupplier: TLabel;
    edSupplierRef: TEdit;
    clbSupplier: TExtendedCheckListBox;
    lblEntityFilter: TLabel;
    lblEntityCode: TLabel;
    edtEntityCode: TEdit;
    cbTextSearchForBlank: TCheckBox;
    cbBarcodeSearchForBlank: TCheckBox;
    cbSupplierRefSearchForBlank: TCheckBox;
    ThreeDigitBarcodeSearchFilterChkBx: TCheckBox;
    procedure clearFilterButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure cancelButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbDiscontinueExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure clbDivisionClickCheck(Sender: TObject);
    procedure clbSubdivisionClickCheck(Sender: TObject);
    procedure clbSupercategoryClickCheck(Sender: TObject);
    procedure clbCategoryClickCheck(Sender: TObject);
    procedure clbSubcategoryClickCheck(Sender: TObject);
    procedure clbTagGroupClickCheck(Sender: TObject);
    procedure clbSubgroupClickCheck(Sender: TObject);
    procedure clbSectionClickCheck(Sender: TObject);
    procedure clbSubsectionClickCheck(Sender: TObject);
    procedure clbTagClickCheck(Sender: TObject);
    procedure acnShowTextFilterExecute(Sender: TObject);
    procedure acnShowProdStructureExecute(Sender: TObject);
    procedure acnShowProdSetUpExecute(Sender: TObject);
    procedure acnShowProdTagsExecute(Sender: TObject);
    procedure acnShowSupplierExecute(Sender: TObject);
    procedure acnShowBarcodeExecute(Sender: TObject);
    procedure acnShowEntityCodeExecute(Sender: TObject);
    procedure edTextChange(Sender: TObject);
    procedure textCheckBoxClick(Sender: TObject);
    procedure productSetUpFiltersChanged(Sender: TObject);
    procedure clbLineTypeClickCheck(Sender: TObject);
    procedure clbPrintStreamClickCheck(Sender: TObject);
    procedure clbCourseClickCheck(Sender: TObject);
    procedure clbUsesPortionClickCheck(Sender: TObject);
    procedure clbUsesTaxRuleClickCheck(Sender: TObject);
    procedure clbSupplierClickCheck(Sender: TObject);
    procedure tsTextFilterShow(Sender: TObject);
    procedure tsTextFilterHide(Sender: TObject);
    procedure tsProductStructureShow(Sender: TObject);
    procedure tsProductStructureHide(Sender: TObject);
    procedure tsProductSetUpShow(Sender: TObject);
    procedure tsProductSetUpHide(Sender: TObject);
    procedure tsProductTagsShow(Sender: TObject);
    procedure tsProductTagsHide(Sender: TObject);
    procedure tsBarcodeShow(Sender: TObject);
    procedure tsBarcodeHide(Sender: TObject);
    procedure tsSupplierDetailsShow(Sender: TObject);
    procedure tsSupplierDetailsHide(Sender: TObject);
    procedure tsEntityCodeShow(Sender: TObject);
    procedure tsEntityCodeHide(Sender: TObject);
    procedure cbTextSearchForBlankClick(Sender: TObject);
    procedure cbSupplierRefSearchForBlankClick(Sender: TObject);
    procedure cbBarcodeSearchForBlankClick(Sender: TObject);
  private
  // ensures that form only populated once when the form is first shown
    Fpopulated : boolean;
  // disables automatic refiltering of the tree structures while changes are in progress
    FenableComboRefilter : boolean;
  // Dialog values saved when dialog opened, in case user cancels
    saveEdText : string;
    saveCbName : boolean;
    saveCbDescription : boolean;
    saveCbInvoiceName : boolean;
    saveCbImportExportRef : boolean;
    saveCbMidwordSearch : boolean;
    saveClbDivision : TStringList;
    saveClbSubdivision : TStringList;
    saveClbSupercategory : TStringList;
    saveClbCategory : TStringList;
    saveClbSubcategory : TStringList;
    saveClbLineType :TStringList;
    saveCbDiscontinue : string;
    saveClbPrintStream : TStringList;
    saveClbCourse : TStringList;
    saveClbUsesPortion : TStringList;
    SaveClbUsesTaxRule : TStringList;
    saveClbTagGroup : TStringList;
    saveClbsubgroup : TStringList;
    saveClbSection : TStringList;
    saveClbSubsection : TStringList;
    saveClbTag : TStringList;
    saveEdBarcode : string;
    saveEdSupplierRef : string;
    saveClbSupplier : TStringList;
    saveEdEntityCode : string;
  // variables to hold the tree structures for both categorisation and tags
    divisionTreeLevel : TTreeLevel;
    subdivisionTreeLevel : TTreeLevel;
    supercategoryTreeLevel : TTreeLevel;
    categoryTreeLevel : TTreeLevel;
    subcategoryTreeLevel : TTreeLevel;
    structureTreeList : TList;
    tagGroupTreeLevel : TTreeLevel;
    subgroupTreeLevel : TTreeLevel;
    sectionTreeLevel : TTreeLevel;
    subsectionTreeLevel : TTreeLevel;
    tagTreeLevel : TTreeLevel;
    tagTreeList : TList;
  // variables to hold whether any value is checked for each checklistbox - used to detect changes
    FdivisionAnyChecked : boolean;
    FsubdivisionAnyChecked : boolean;
    FsupercategoryAnyChecked : boolean;
    FcategoryAnyChecked : boolean;
    FsubcategoryAnyChecked : boolean;
    FlinetypeAnyChecked : boolean;
    FprintStreamAnyChecked : boolean;
    FcourseAnyChecked : boolean;
    FusesPortionAnyChecked : boolean;
    FusesTaxRuleAnyChecked : boolean;
    FtagGroupAnyChecked : boolean;
    FsubgroupAnyChecked : boolean;
    FsectionAnyChecked : boolean;
    FsubsectionAnyChecked : boolean;
    FtagAnyChecked : boolean;
    FsupplierAnyChecked : boolean;

    procedure populate;
    procedure clearFilter;
    procedure saveDlgValues;
    procedure restoreDlgValues;
    procedure updateActiveFilterList;
  // hides subdivision, supercat boxes if these levels not in use
    procedure hideSubDivisionSupercategoryCombos;
  // returns list of matching subcategories for selections in product structure
    function getSubCategoriesFromTreeLevel(filterLevel: TTreeLevel): string;
  // returns list of matching tags for selections in tags structure
    function getTagIdsFromTreeLevel(filterLevel: TTreeLevel): string;
  // refills combobox,  limited to appropriate values for those selected in higher level boxes
    procedure populateListBoxFromTreeLevels( targetTreeLevel : TTreeLevel; filterTreeLevel : TTreeLevel ); overload;
  // refills combobox with no filter
    procedure populateListBoxFromTreeLevels( targetTreeLevel : TTreeLevel );  overload;
  // manage the updating of tree structures when selections made
  // for an individual tree level:
    procedure refillTreeLevel( levelToRefill : TTreeLevel; treeToUse : TList );
  // for the full tree:
    procedure refillTree( levelsList: TList );
  // for the tree beginning from a specified level:
    procedure refillTreeFrom( levelsList: TList; fromLevel: TTreeLevel );
  // to handle the above for each tree structure in use on the form:
    procedure refillStructureTree;
    procedure refillStructureTreeFrom( fromLevel : TTreeLevel );
    procedure refillTagTree;
    procedure refillTagTreeFrom( fromLevel: TTreeLevel );
  // handles calling updates in response to changes in structure/tag selections
    procedure handleStructureFilterCheck( refreshFromLevel: TTreeLevel );
    procedure handleTagFilterCheck( refreshFromLevel: TTreeLevel );
  // validates entity code, barcode text entries on form
    function validateForm : boolean;
    function parseEntityCodeFilter( out entityCode : Int64; out filterByEntityCode : boolean ) : boolean;
  // validates combobox entries - if it is set to invalid value, instead use the supplied default value
    procedure checkComboValue(cb: TComboBox; defVal: string);
  // checks if only selection in checklistbox is 'Any'
    function onlyAnySelected( checklist : TExtendedCheckListBox ) : boolean;
  // checks if 'Any' selection has changed from false to true
    function anyChangedToTrue( checklist : TExtendedCheckListBox; currentValue : boolean) : boolean;
  // updates checkboxes if 'any' is selected, or clears 'any' if others are picked
    procedure handleAnyChecking(checkList: TExtendedCheckListBox; anyChecked : boolean);
  // getter functions for properties
    function isFiltered : boolean;
    function getBarcodeFilter : string;
    function getSupplierRefFilter : string;
    function getUsesPortionFilter : string;
    function getUsesTaxRuleFilter : string;
    function getSupplierNameFilter : string;
    function getTagsFilter : string;
    function getAdditionalFiltersActive : boolean;
    function getFilter: string;
    procedure hideProductTagsButton;
    procedure addActivePageIndicator(button: TButton);
    procedure removeActivePageIndicator(button: TButton);
  public
    property filtered : boolean read isFiltered;
    property barcodeFilter : string read getBarcodeFilter;
    property supplierRefFilter : string read getSupplierRefFilter;
    property usesPortionFilter : string read getUsesPortionFilter;
    property usesTaxRuleFilter : string read getUsesTaxRuleFilter;
    property supplierNameFilter : string read getSupplierNameFilter;
    property tagsFilter : string read getTagsFilter;
    property additionalFiltersActive : boolean read getAdditionalFiltersActive;
    property filter : string read getFilter;
  end;

implementation

uses uDatabaseADO, uGuiUtils, uGlobals;

{$R *.dfm}

const
  ANY_DISCONTINUE_STRING : string = '<Any>';
  FcaseInsensitive = true;
  DEF_TEXT_MATCH_INDEX = 2;
  GROUPBOX_WIDTH : integer = 256;

type
  TProductField = ( pfName, pfDescription, pfInvoiceName, pfImportExportRef, pfB2BName );
  TProductFields = set of TProductField;

{TTreeLevel}
constructor TTreeLevel.create(aName : String; aCheckListBox : TExtendedCheckListBox; aDataSet : TADOQuery);
begin
  Name := aName;
  CheckListBox := aCheckListBox;
  FDataSet := aDataSet;
  inherited create;
end;

function TTreeLevel.getCurrentSelection: TStringList;
begin
  result := CheckListBox.CurrentSelections;
end;

procedure TTreeLevel.setCurrentSelection (NewSelections : TStringList);
begin
  CheckListBox.CurrentSelections := NewSelections;
end;

function TTreeLevel.anySelectionsMade : boolean;
begin
  result := CheckListBox.AnySelectionsMade;
end;

function TTreeLevel.getSelectionAsString: string;
var
  i : integer;
  selections : TStringList;
begin
  result := '';
  selections := currentSelection;
  for i := 0 to selections.Count - 1 do
  begin
    if length(result) = 0 then
      result := QuotedStr(selections[i])
    else
      result := result + ', ' + QuotedStr(selections[i]);
  end;
end;

{TEntityFilterForm}
procedure TEntityFilterForm.clearFilterButtonClick(Sender: TObject);
begin
  clearFilter;
end;

procedure TEntityFilterForm.populateListBoxFromTreeLevels(
                                      targetTreeLevel : TTreeLevel;
                                      filterTreeLevel : TTreeLevel );
var
  strings : TStringList;
  clb : TExtendedCheckListBox;
  resultCol : String;
  filterCol : String;
  filterVals : TStrings;
  thisFilter : String;
  i : integer;
begin
  strings := TStringList.Create;
  strings.Sorted := false;
  clb := targetTreeLevel.CheckListBox;
  resultCol := targetTreeLevel.Name;
  filterCol := filterTreeLevel.Name;
  filterVals := filterTreeLevel.CurrentSelection;
  try
    clb.Clear;
    clb.Items.Add('Any');
    for i := 0 to filterVals.Count - 1 do
    begin
      thisFilter := filterVals[i];
      with targetTreeLevel.DataSet do begin
        if Length( filterCol ) > 0 then begin
          Filter := filterCol + ' = ' + QuotedStr( thisFilter );
          Filtered := true;
        end else begin
          Filtered := false;
        end;
        Active := true;
        Sort := resultCol;
        First;
        while not EOF do begin
          if strings.IndexOf( FieldByName( resultCol ).AsString ) = -1 then
            strings.Add( FieldByName( resultCol ).AsString );
          Next;
        end;
      end;
    end;
    clb.Items.AddStrings(strings);
  finally
    strings.Free;
  end;
end;

procedure TEntityFilterForm.populateListBoxFromTreeLevels( targetTreeLevel : TTreeLevel );
var
  strings : TStringList;
  resultCol : string;
  clb : TExtendedCheckListBox;
begin
  resultCol := targetTreeLevel.Name;
  clb := targetTreeLevel.CheckListBox;
  strings := TStringList.Create;
  strings.Sorted := false;
  try
    clb.ItemIndex := -1;
    clb.Items.Clear;
    clb.Items.Add('Any');
    with targetTreeLevel.DataSet do begin
      Filtered := false;
      Active := true;
       Sort := resultCol;
      First;
      while not EOF do begin
        if strings.IndexOf( FieldByName( resultCol ).AsString ) = -1 then
          strings.Add( FieldByName( resultCol ).AsString );
        Next;
      end;
    end;
    clb.Items.AddStrings(strings);
  finally
    strings.Free;
  end;
end;

// As subcategory is held in Products table, we use the lowest level of the product structure with active selections
//  and return a list of the subcategories which match this selection
function TEntityFilterForm.getSubCategoriesFromTreeLevel( filterLevel : TTreeLevel ) : string;

  function getMatchingSubcategories( colName : string; value : string ) : string;
  begin
    Result := '';
    with productStructureTreeQuery do
    begin
      Filter := colName + ' = ' + QuotedStr( value );
      Filtered := true;
      Active := true;
      First;
      while not EOF do
      begin
        if Length( result ) = 0 then
          Result := Result + QuotedStr( FieldByName( 'subcategory' ).AsString )
        else
          Result := Result + ', ' + QuotedStr( FieldByName( 'subcategory' ).AsString );
        Next;
      end;
    end;
  end;

var
  i : integer;
  selections : TStringList;
begin
  Result := '';
  selections := filterLevel.currentSelection;
  for i := 0 to (selections.Count - 1) do
  begin
    if length(Result) = 0 then
      result := getMatchingSubcategories( filterLevel.Name, selections[i] )
    else
      result := result + ', ' +  getMatchingSubcategories( filterLevel.Name, selections[i] );
  end;
end;

// To allow us to query the Tag table directly, rather than needing to join tables for the whole structure,
// this returns a list of tag Ids available for the supplied selection in a format suitable to use in a
// ' WHERE tagId IN *** ' statement
function TEntityFilterForm.getTagIdsFromTreeLevel( filterLevel : TTreeLevel ) : string;

  function getMatchingTagIds( colName : string; value : string ) : string;
  begin
    Result := '';
    with ProductTagTreeQuery do
    begin
      Filter := colName + ' = ' + QuotedStr( value );
      Filtered := true;
      Active := true;
      First;
      while not EOF do
      begin
        if Length( Result ) = 0 then
          Result := Result + FieldByName( 'tagId' ).AsString
        else
          Result := Result + ', ' + FieldByName( 'tagId' ).AsString;
        Next;
      end;
    end;
  end;

var
  i : integer;
  selections : TStringList;
begin
  Result := '';
  selections := filterLevel.currentSelection;
  for i := 0 to (selections.Count - 1) do
  begin
    if length(Result) = 0 then
      result := getMatchingTagIds( filterLevel.Name, selections[i] )
    else
      result := result + ', ' + getMatchingTagIds( filterLevel.Name, selections[i] );
  end;
  Result := '(' + Result + ')'
end;

procedure TEntityFilterForm.populate;

  procedure PopulateItemList ( checkListBox : TExtendedCheckListBox;
                         tableName : string;
                         nameColumn : string;
                         idColumn : string );
  var
    itemList : TStringList;
  begin
    itemList := TStringList.Create;
    try
      with dmADO.adoqRun do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT ' + nameColumn + ', ' + idColumn);
        SQL.Add('FROM ' + tableName);
        Open;
        First;
        while not Eof do
        begin
          itemList.AddObject(FieldByName(nameColumn).AsString,
                           pointer(FieldByName(idColumn).AsInteger));
          Next;
        end;
        checkListBox.Clear;
        checkListBox.Items.Add('Any');
        checkListBox.Items.AddStrings(itemList);
      end;
    finally
      itemList.Free;
    end;
  end;

begin
   Fpopulated := true;
  clbLineType.Items.Clear;
  clbLineType.Items.Add('Any');
  with ProductsDB.ProductTypesTable do begin
    First;
    while not EOF do
    begin
      clbLineType.Items.Add(EntTypeEnumToDisplayString(
                                EntTypeStringToEnum( FindField('ProductType').AsString ) ) );
      Next;
    end;
  end;

  // set up product structure tree - highest category level must be first in list, lowest must be last
  divisionTreeLevel := TTreeLevel.create( 'division', clbDivision, productStructureTreeQuery);
  subdivisionTreeLevel := TTreeLevel.create( 'subdivision', clbSubdivision, productStructureTreeQuery );
  supercategoryTreeLevel := TTreeLevel.create( 'supercategory', clbSupercategory, productStructureTreeQuery );
  categoryTreeLevel := TTreeLevel.create( 'category', clbCategory, productStructureTreeQuery );
  subcategoryTreeLevel := TTreeLevel.create( 'subcategory', clbSubcategory, productStructureTreeQuery );
  structureTreeList := TList.create;
  structureTreeList.add(divisionTreeLevel);
  structureTreeList.add(subdivisionTreeLevel);
  structureTreeList.add(supercategoryTreeLevel);
  structureTreeList.Add(categoryTreeLevel);
  structureTreeList.Add(subcategoryTreeLevel);

  // set up product tag tree - again, list is ordered highest level -> lowest
  taggroupTreeLevel := TTreeLevel.create( 'taggroup', clbTagGroup, productTagTreeQuery );
  subgroupTreeLevel := TTreeLevel.create( 'subgroup', clbSubGroup, productTagTreeQuery );
  sectionTreeLevel := TTreeLevel.create( 'section', clbSection, productTagTreeQuery );
  subsectionTreeLevel := TTreeLevel.create( 'subsection', clbSubSection, productTagTreeQuery );
  tagTreeLevel := TTreeLevel.create( 'tag', clbTag, productTagTreeQuery );
  TagTreeList := TList.create;
  tagTreeList.Add(tagGroupTreeLevel);
  tagTreeList.Add(subgroupTreeLevel);
  tagTreeList.Add(sectionTreeLevel);
  tagTreeList.Add(subsectionTreeLevel);
  tagTreeList.Add(tagTreeLevel);

  FenableComboRefilter := false;
  try
    refillStructureTree;
    refillTagTree;
  finally
    FenableComboRefilter := true;
  end;

  clbPrintStream.Items.Add('Any');
  clbPrintStream.Items.AddStrings(ProductsDB.printStreamStringList);
  clbUsesTaxRule.Items.Add('Any');
  clbUsesTaxRule.Items.AddStrings(ProductsDB.vatbandStringList);
  clbSupplier.Items.Add('Any');
  clbSupplier.Items.AddStrings(ProductsDB.supplierStringList);

  cbDiscontinue.Items.Add(ANY_DISCONTINUE_STRING);
  cbDiscontinue.Items.Add('True');
  cbDiscontinue.Items.Add('False');

  populateItemList( clbCourse, 'ac_course', 'Name', 'id' );
  PopulateItemList( clbUsesPortion, 'ac_PortionType', 'Name', 'Id' );
  PopulateItemList( clbUsesTaxRule, 'ac_TaxRule', 'Name', 'Id' );
end;

procedure TEntityFilterForm.clearFilter;

  procedure clearCheckListFilters(Checklist: TExtendedCheckListBox; var anyCheckedField: boolean);
  begin
    Checklist.clearSelection;
    Checklist.Checked[Checklist.Items.IndexOf('Any')] := True;
    anyCheckedField := true;
  end;

var
  oldEnable : boolean;
begin
  edText.Text := '';
  cbTextSearchForBlank.Checked := false;
  cbName.Checked := true;
  cbDescription.Checked := true;
  cbInvoiceName.Checked := false;
  cbImportExportRef.Checked := false;
  cbMidwordSearch.Checked := true;
  edSupplierRef.Text := '';
  cbSupplierRefSearchForBlank.Checked := false;
  edBarcode.Text := '';
  cbBarcodeSearchForBlank.Checked := false;
  edtEntityCode.Text := '';
  clearCheckListFilters(clbDivision, FdivisionAnyChecked);
  clearCheckListFilters(clbSubdivision, FsubdivisionAnyChecked);
  clearCheckListFilters(clbSupercategory, FsupercategoryAnyChecked);
  clearCheckListFilters(clbCategory, FcategoryAnyChecked);
  clearCheckListFilters(clbSubcategory, FsubcategoryAnyChecked);
  clearCheckListFilters(clbLineType, FlineTypeAnyChecked);
  clearCheckListFilters(clbPrintStream, FprintStreamAnyChecked);
  clearCheckListFilters(clbCourse, FcourseAnyChecked);
  clearCheckListFilters(clbUsesPortion, FusesPortionAnyChecked);
  clearCheckListFilters(clbUsesTaxRule, FusesTaxRuleAnyChecked);
  cbDiscontinue.Text := ANY_DISCONTINUE_STRING;
  clearCheckListFilters(clbTagGroup, FtagGroupAnyChecked);
  clearCheckListFilters(clbSubgroup, FsubgroupAnyChecked);
  clearCheckListFilters(clbSection, FsectionAnyChecked);
  clearCheckListFilters(clbSubsection, FsubsectionAnyChecked);
  clearCheckListFilters(clbTag, FtagAnyChecked);
  clearCheckListFilters(clbSupplier, FsupplierAnyChecked);

  oldEnable := FenableComboRefilter;
  FenableComboRefilter := false;
  try
    refillStructureTree;
    refillTagTree;
  finally
    FenableComboRefilter := oldEnable;
  end;

  updateActiveFilterList;
end;

function TEntityFilterForm.validateForm : boolean;

  function isTextFilterInvalid : boolean;
  var
    anyChecked : bool;
  begin
    anyChecked := cbName.Checked
                  or cbDescription.Checked
                  or cbInvoiceName.Checked
                  or cbImportExportRef.Checked
                  or cbB2BName.Checked;

    result := not anyChecked and (Length(Trim(edText.Text)) > 0);
  end;
  
const
  ENTITY_CODE_LENGTH = 11;
var
  entityCode : Int64;
  filterByEntityCode : boolean;
begin
  if not parseEntityCodeFilter( entityCode, filterByEntityCode ) then
  begin
    Result := false;
    ShowMessage('Invalid entity code "'+edtEntityCode.Text+'" - must be all digits');
  end
  else if filterByEntityCode and (Length(IntToStr(entityCode)) <> ENTITY_CODE_LENGTH) then
  begin
    Result := false;
    ShowMessage('Invalid entity code "'+edtEntityCode.Text+'" - must be '+IntToStr(ENTITY_CODE_LENGTH)+' digits long');
  end
  else if (length(barCodeFilter) > 0) and not (ProductsDB.ValidateBarCode(barcodeFilter, ThreeDigitBarcodeSearchFilterChkBx.Checked)) then
  begin
    result := false;
    // no messagebox - validatebarcode shows its own message boxes
  end
  else if isTextFilterInvalid then
  begin
    Result := false;
    ShowMessage('You must select at least one field to perform a text search on');
  end
  else
  begin
    Result := true;
  end;
end;

function TEntityFilterForm.parseEntityCodeFilter( out entityCode : Int64; out filterByEntityCode : boolean ) : boolean;
var
  s: string;
begin
  s := edtEntityCode.Text;
  s := Trim(s);

  Result := true;
  filterByEntityCode := s <> '';

  if filterByEntityCode then
  begin
    try
      entityCode := StrToInt64(s);
    except
      on EConvertError do
      begin
        filterByEntityCode := false;
        Result := false;
      end;
    end;
  end;
end;

function TEntityFilterForm.getSupplierRefFilter : string;
begin
  Result := '';
  if (Trim(edSupplierRef.Text) <> '') and (Trim(edSupplierRef.Text) <> '*') then
    Result := Trim(edSupplierRef.Text);
end;

function TEntityFilterForm.getBarcodeFilter : string;
begin
  Result := '';
  if (Trim(edBarcode.Text) <> '') and (Trim(edBarcode.Text) <> '*') then
    Result := Trim(edBarcode.Text);
end;

function TEntityFilterForm.getUsesPortionFilter : string;
var
  selections : TStringList;
  i : integer;
begin
  Result := '';
  if not(onlyAnySelected(clbUsesPortion)) then
  begin
    selections := TStringList.Create;
    selections.Assign(clbUsesPortion.CurrentSelections);
    try
      for i := 0 to selections.Count - 1 do
      begin
        if i = 0 then
          result := result +
                IntToStr(Integer(clbUsesPortion.Items.Objects[clbUsesPortion.Items.IndexOf(selections[i])]))
        else
          result := result + ', ' +
                IntToStr(Integer(clbUsesPortion.Items.Objects[clbUsesPortion.Items.IndexOf(selections[i])]));
      end;
      result := '(' + result + ')';
    finally
      selections.Free;
    end;
  end;
end;

function TEntityFilterForm.getUsesTaxRuleFilter : string;
var
  selections : TStringList;
  i : integer;
begin
  Result := '';
  if not(onlyAnySelected(clbUsesTaxRule)) then
  begin
    selections := TStringList.Create;
    selections.Assign(clbUsesTaxRule.CurrentSelections);
    try
      for i := 0 to selections.Count - 1 do
      begin
        if i = 0 then
          result := result +
                IntToStr(Integer(clbUsesTaxRule.Items.Objects[clbUsesTaxRule.Items.IndexOf(selections[i])]))
        else
          result := result + ', ' +
                IntToStr(Integer(clbUsesTaxRule.Items.Objects[clbUsesTaxRule.Items.IndexOf(selections[i])]));
      end;
      result := '(' + result + ')';
    finally
      selections.Free;
    end;
  end;
end;

function TEntityFilterForm.getSupplierNameFilter : string;
var
  selections : TStringList;
  i : integer;
begin
  Result := '';
  if not(onlyAnySelected(clbSupplier)) then
  begin
    selections := TStringList.Create;
    selections.Assign(clbSupplier.CurrentSelections);
    try
      for i := 0 to selections.Count - 1 do
      begin
        if i = 0 then
          result := result + QuotedStr(selections[i])
        else
          result := result + ', ' + QuotedStr(selections[i]);
      end;
      result := '(' + result + ')';
    finally
      selections.Free;
    end;
  end;
end;

function TEntityFilterForm.getTagsFilter : string;
begin
  result := '';
  if not(onlyAnySelected(tagTreeLevel.CheckListBox)) then
    result := result + getTagIdsFromTreeLevel( tagTreeLevel )
  else if not(onlyAnySelected(subsectionTreeLevel.CheckListBox)) then
    result := result + getTagIdsFromTreeLevel( subsectionTreeLevel )
  else if not(onlyAnySelected(sectionTreeLevel.CheckListBox)) then
    result := result + getTagIdsFromTreeLevel( sectionTreeLevel )
  else if not(onlyAnySelected(subgroupTreeLevel.CheckListBox)) then
    result := result + getTagIdsFromTreeLevel( subgroupTreeLevel )
  else if not(onlyAnySelected(tagGroupTreeLevel.CheckListBox)) then
    result := result + getTagIdsFromTreeLevel( tagGroupTreeLevel );
end;

function TEntityFilterForm.getAdditionalFiltersActive : boolean;
begin
  result := (Length(supplierRefFilter) > 0)
            OR (Length(usesPortionFilter) > 0)
            OR (Length(usesTaxRuleFilter) > 0)
            OR (Length(supplierNameFilter) > 0)
            OR (Length(barcodeFilter) > 0)
            OR (Length(tagsFilter) > 0)
            OR cbBarcodeSearchForBlank.Checked
            OR cbSupplierRefSearchForBlank.Checked;
end;

function TEntityFilterForm.getFilter: string;
var
  filter : string;

  function displayEntTypeToDbEntType( et: string ) : string;
  var
    i : EntType;
  begin
    Result := 'none';
    for i := Low( EntType ) to High( EntType ) do
      if et = EntTypeEnumToDisplayString( i ) then
      begin
        Result := EntTypeEnumToString( i );
        Break;
      end;
  end;

  function MakeLikeMatchText( wc : string ) : string;
  var
    i : Integer;
  begin
    if FcaseInsensitive then
      wc := LowerCase( wc );
    if cbMidwordSearch.Checked then
      wc := '*' + wc + '*'
    else
      wc := wc + '*';
    Result := '''';
    for i := 1 to Length( wc ) do
      case wc[i] of
        '''': Result := Result + '''''';
        '*': Result := Result + '%';
        '?': Result := Result + '_';
      else
        Result := Result + wc[i];
      end;
    Result := Result + '''';
  end;

  procedure addAnd;
  begin
    if Length( filter ) > 0 then
      filter := filter + ' and ';
  end;

  procedure addToFilter( newFilter : String );
  begin
    filter := filter + ' (' + newFilter + ') ';
  end;

  function productFieldName( f : TProductField ) : string;
  begin
    case f of
      pfName: Result := 'Extended Rtl Name';
      pfDescription: Result := 'Retail Description';
      pfInvoiceName: Result := 'Purchase Name';
      pfImportExportRef: Result := 'Import/Export Reference';
      pfB2BName: Result := 'B2BName';
    end;
  end;

  function getProductFieldsToSearch : TProductFields;
  begin
    Result := [];
    if cbName.Checked = true then
      Result := Result + [pfName];
    if cbDescription.Checked then
      Result := Result + [pfDescription];
    if cbInvoiceName.Checked then
      Result := Result + [pfInvoiceName];
    if cbImportExportRef.Checked then
      Result := Result + [pfImportExportRef];
    if cbB2BName.Checked then
      Result := Result + [pfB2BName];
  end;

var
  textMatchFields : TProductFields;
  f : TProductField;
  first : boolean;
  entityCode : Int64;
  filterByEntityCode : boolean;
  i : integer;
  selections : TStringList;
  tempString : String;
begin
  filter := '';

  // Text filtering
  if ((Trim( edText.Text ) <> '') and (Trim( edText.Text ) <> '*')) or
        (cbTextSearchForBlank.Checked) then begin
    textMatchFields := getProductFieldsToSearch;

    tempString := '';
    addAnd;

    if textMatchFields <> [] then
    begin
      // Filters on the different fields get ORed together
      first := true;
      for f := Low( TProductField ) to High( TProductField ) do
      begin
        if f in textMatchFields then
        begin
          if first then
            first := false
          else
            tempString := tempString + ' OR ';

          if (cbTextSearchForBlank.Checked) then
            if FcaseInsensitive then
              tempString := tempString + 'LOWER(['+productFieldName( f )+']) IS NULL'
            else
              tempString := tempString + '[' + productFieldName( f ) + ']) IS NULL'
          else
          begin
            if FcaseInsensitive then
              tempString := tempString + 'LOWER(['+productFieldName( f )+']) LIKE '
            else
              tempString := tempString + '['+productFieldName( f )+']) LIKE ';
            tempString := tempString + MakeLikeMatchText( edText.Text );
          end;
        end;
      end;
    end;
    addToFilter(tempString);
  end;

  // Type filtering
  if not(onlyAnySelected(clbLineType)) then begin
    selections := TStringList.Create;
    try
      addAnd;
      tempString := '';
      selections.Assign(clbLineType.CurrentSelections);
      for i := 0 to selections.Count - 1 do
      begin
        if i = 0 then
          tempString := tempString + '[Entity Type] = '+QuotedStr(displayEntTypeToDbEntType(selections[i]))
        else
          tempString := tempString + 'OR [Entity Type] = ' +QuotedStr(displayEntTypeToDbEntType(selections[i]));
      end;
    finally
      selections.Free;
    end;
    addToFilter(tempString);
  end;

  if not(onlyAnySelected(SubcategoryTreeLevel.CheckListBox)) then
  begin
    addAnd;
    addToFilter('[Sub-Category Name] IN (' + subcategoryTreeLevel.getSelectionAsString + ')');
  end
  else if not(onlyAnySelected(CategoryTreeLevel.CheckListBox)) then
  begin
    addAnd;
    addToFilter('[Sub-Category Name] IN ('+
                getSubCategoriesFromTreeLevel( categoryTreeLevel ) + ')');
  end
  else if not(onlyAnySelected(supercategoryTreeLevel.CheckListBox)) then
  begin
    addAnd;
    addToFilter('[Sub-Category Name] IN ('+
              getSubCategoriesFromTreeLevel( supercategoryTreeLevel ) + ')');
  end
  else if not(onlyAnySelected(subdivisionTreeLevel.CheckListBox)) then
  begin
    addAnd;
    addToFilter('[Sub-Category Name] IN ('+
              getSubCategoriesFromTreeLevel( subdivisionTreeLevel ) + ')');
  end
  else if not(onlyAnySelected(divisionTreeLevel.CheckListBox)) then
  begin
    addAnd;
    addToFilter('[Sub-Category Name] IN ('+
              getSubCategoriesFromTreeLevel( divisionTreeLevel ) + ')');
  end;

  if (cbDiscontinue.Text <> ANY_DISCONTINUE_STRING) then
  begin
    addAnd;
    filter := Filter + ' (';
      //Client ADO seems to ignore the value 1 in a filter.
      if cbDiscontinue.text = 'False' then
         filter := filter + 'Discontinue = 0'
      else
         filter := filter + 'Discontinue <> 0';
    filter := Filter + ') ';
  end;

  if not(onlyAnySelected(clbPrintStream)) then
  begin
    selections := TStringList.Create;
    try
      addAnd;
      tempString := '';
      selections.Assign(clbPrintStream.CurrentSelections);
      for i := 0 to selections.Count - 1 do
      begin
        if i = 0 then
          tempString := tempString + '[Default Printer Stream] = ' +QuotedStr(selections[i])
        else
          tempString := tempString + ' OR [Default Printer Stream] = ' +QuotedStr(selections[i]);
      end;
    finally
      selections.Free;
    end;
    addToFilter(tempString);
  end;

  if not(onlyAnySelected(clbCourse)) then
  begin
    selections := TStringList.Create;
    try
      selections.Assign(clbCourse.CurrentSelections);
      addAnd;
      tempString := '';
      for i := 0 to selections.Count - 1 do
      begin
        if i = 0 then
          tempString := tempString + '[CourseId] = '
            + IntToStr(Integer(clbCourse.Items.Objects[clbCourse.Items.IndexOf(selections[i])]))
        else
          tempString := tempString + ' OR [CourseId] = '
            + IntToStr(Integer(clbCourse.Items.Objects[clbCourse.Items.IndexOf(selections[i])]));
      end;
    finally
      selections.Free;
    end;
    addToFilter(tempString);
  end;

  // Entity Code filtering
  parseEntityCodeFilter(entityCode, filterByEntityCode);
  if filterByEntityCode then
  begin
    addAnd;
    addToFilter('[EntityCode] = ' + IntToStr(entityCode));
  end;

  Result := filter;
end;

function TEntityFilterForm.isFiltered: boolean;
begin
  Result := (Length( getFilter ) > 0) or additionalFiltersActive;
end;

procedure TEntityFilterForm.FormCreate(Sender: TObject);
begin
  Fpopulated := false;
  FenableComboRefilter := false;

  if not dmADO.SubDivisionOrSuperCategoryUsed then
  begin
    hideSubDivisionSupercategoryCombos;
  end;

  if not dmADO.ProductTagsUsed then
  begin
    hideProductTagsButton;
  end;

  saveClbDivision := TStringList.Create;
  saveClbSubdivision :=  TStringList.Create;
  saveClbSupercategory :=  TStringList.Create;
  saveClbCategory := TStringList.Create;
  saveClbSubcategory := TStringList.Create;
  saveClbTagGroup := TStringList.Create;
  saveClbsubgroup := TStringList.Create;
  saveClbSection := TStringList.Create;
  saveClbSubsection := TStringList.Create;
  saveClbTag := TStringList.Create;
  saveClbLineType := TStringList.Create;
  saveClbPrintStream := TStringList.Create;
  saveClbCourse := TStringList.Create;
  saveClbUsesPortion := TStringList.Create;
  saveClbUsesTaxRule := TStringList.Create;
  saveClbSupplier := TStringList.Create;

  self.AutoSize := true;
end;

procedure TEntityFilterForm.hideSubDivisionSupercategoryCombos;
var
  moveDistance : integer;
begin
  moveDistance := (clbSupercategory.Top - clbSubdivision.Top ) +
                ( clbCategory.Top - clbSupercategory.Top );

  lblSubDivision.Visible := false;
  lblSupercategory.Visible := false;
  clbSubdivision.Visible := false;
  clbSupercategory.Visible := false;

  lblCategory.Top := lblCategory.Top - moveDistance;
  lblSubcategory.Top := lblSubcategory.Top - moveDistance;
  clbCategory.Top := clbCategory.Top - moveDistance;
  clbSubCategory.Top := clbSubCategory.Top - moveDistance;
end;

procedure TEntityFilterForm.hideProductTagsButton;
var
  moveDistance : integer;
begin
  moveDistance := btnProductTags.Height;

  btnProductTags.Visible := false;
  btnBarcodeFilters.Top := btnBarcodeFilters.Top - moveDistance;
  btnSupplierDetails.Top := btnSupplierDetails.Top - moveDistance;
  btnEntityCode.Top := btnEntityCode.Top - moveDistance;
end;

procedure TEntityFilterForm.FormShow(Sender: TObject);
begin
  if not Fpopulated then begin
    setHelpContextID( self, AZPM_FILTER_FORM );
    populate;
    clearFilter;
  end;

  // if Show B2B Name is disabled in settings, hide from form
  if not ProductsDB.ShowB2BName then
    cbB2BName.Visible := false
  else
    cbB2BName.Visible := true;


  // Ensure we are using the most up to date structure/tag info
  refillStructureTree;
  refillTagTree;
  saveDlgValues;
  FenableComboRefilter := true;
  AcnShowTextFilterExecute( self );
  updateActiveFilterList;
  if edText.Enabled then
  begin
    PrizmSetFocus( edText );
    edText.SelectAll;
  end;
end;

procedure TEntityFilterForm.FormClose(Sender: TObject;
                                  var Action: TCloseAction);
begin
  FenableComboRefilter := false;
end;

procedure TEntityFilterForm.refillTreeLevel ( levelToRefill : TTreeLevel ; treeToUse : TList );
var
  previousSelections : TStringList;
  levelIndex : integer;
  filterTreeLevel : TTreeLevel;
  indexToCheck : integer;
  treeRefilled : boolean;
begin
  previousSelections := TStringList.Create;
  previousSelections.Assign(levelToRefill.CurrentSelection);
  try
    levelIndex := treeToUse.IndexOf(levelToRefill);
    // if level 0, then no need to check for other filters - refill the box
    if (levelIndex = 0) then
    begin
      populateListBoxFromTreeLevels( levelToRefill );
    end
    // otherwise, need to check for active filters on higher levels - check
    // each higher level until active filter found
    else
    begin
      indexToCheck := levelIndex - 1;
      treeRefilled := false;
      while ( indexToCheck >= 0 ) and ( treeRefilled = false ) do
      begin
        filterTreeLevel := TObject(treeToUse.Items[indexToCheck]) as TTreeLevel;
        if not(onlyAnySelected(filterTreeLevel.CheckListBox)) then
        begin
          populateListBoxFromTreeLevels( levelToRefill, filterTreeLevel );
          treeRefilled := true;
        end
        else
        begin
          indexToCheck := indexToCheck - 1;
        end
      end;
      // if loop is done and no filter has been found, refill without filter
      if ( indexToCheck <= 0 ) and ( treeRefilled = false ) then
      begin
        populateListBoxFromTreeLevels( levelToRefill );
      end;
    end;
    // try to set box to previous selections
    if previousSelections.Count > 0 then
      levelToRefill.currentSelection := previousSelections;
    if levelToRefill.currentSelection.Count = 0 then
      levelToRefill.CheckListBox.Checked[levelToRefill.CheckListBox.Items.IndexOf('Any')] := true;
  finally
    previousSelections.Free;
  end;
end;

procedure TEntityFilterForm.refillTree ( levelsList : TList );
var
  startLevel : TTreeLevel;
begin
  startLevel := TObject(levelsList.Items[0]) as TTreeLevel;
  refillTreeFrom ( levelsList, startLevel );
end;

procedure TEntityFilterForm.refillTreeFrom ( levelsList : TList; fromLevel : TTreeLevel );
var
  i : integer;
  thisTreeLevel : TTreeLevel;
begin
  for i := levelsList.IndexOf(fromLevel) to levelsList.Count - 1 do
  begin
    thisTreeLevel := TObject(levelsList.Items[i]) as TTreeLevel;
    refillTreeLevel( thisTreeLevel, levelsList );
  end;
end;

procedure TEntityFilterForm.refillStructureTree;
begin
  refillTree( structureTreeList );
end;

procedure TEntityFilterForm.refillStructureTreeFrom ( fromLevel : TTreeLevel );
begin
  refillTreeFrom( structureTreeList, fromLevel );
end;

procedure TEntityFilterForm.refillTagTree;
begin
  refillTree( tagTreeList );
end;

procedure TEntityFilterForm.refillTagTreeFrom (fromLevel : TTreeLevel );
begin
  refillTreeFrom( tagTreeList, fromLevel );
end;

procedure TEntityFilterForm.checkComboValue( cb : TComboBox; defVal : string );
begin
  if cb.Items.IndexOf( cb.Text ) = -1 then
    cb.Text := defVal;
end;

procedure TEntityFilterForm.FormShortCut(var Msg: TWMKey;
                                        var Handled: Boolean);
begin
  if Msg.CharCode = VK_F2 then begin
    clearFilter;
    Handled := true;
  end;
end;

procedure TEntityFilterForm.cancelButtonClick(Sender: TObject);
begin
  restoreDlgValues;
end;

procedure TEntityFilterForm.restoreDlgValues;
begin
  edText.Text := saveEdText;
  cbName.Checked := saveCbName;
  cbDescription.Checked := saveCbDescription;
  cbInvoiceName.Checked := saveCbInvoiceName;
  cbMidwordSearch.Checked := saveCbMidwordSearch;
  edtEntityCode.Text := saveEdEntityCode;
  cbDiscontinue.Text := saveCbDiscontinue;
  cbImportExportRef.Checked := saveCbImportExportRef;
  edBarcode.Text := saveEdBarcode;
  edSupplierRef.Text := saveEdSupplierRef;
  clbDivision.CurrentSelections := saveClbDivision;
  clbSubdivision.CurrentSelections := saveClbSubdivision;
  clbSupercategory.CurrentSelections := saveClbSupercategory;
  clbCategory.CurrentSelections := saveClbCategory;
  clbSubcategory.CurrentSelections := saveClbSubcategory;
  clbLineType.CurrentSelections := saveClbLineType;
  clbPrintStream.CurrentSelections := saveClbPrintStream;
  clbCourse.CurrentSelections := saveClbCourse;
  clbUsesPortion.CurrentSelections := saveClbUsesPortion;
  clbUsesTaxRule.CurrentSelections := SaveClbUsesTaxRule;
  clbTagGroup.CurrentSelections := saveClbTagGroup;
  clbSubgroup.CurrentSelections := saveClbsubgroup;
  clbSection.CurrentSelections := saveClbSection;
  clbSubsection.CurrentSelections := saveClbSubsection;
  clbTag.CurrentSelections := saveClbTag;
  clbSupplier.CurrentSelections := saveClbSupplier;
end;

procedure TEntityFilterForm.saveDlgValues;
begin
  saveEdText := edText.Text;
  saveCbName := cbName.Checked;
  saveCbDescription := cbDescription.Checked;
  saveCbInvoiceName := cbInvoiceName.Checked;
  saveCbImportExportRef := cbImportExportRef.Checked;
  saveClbLineType.Assign(clbLineType.CurrentSelections);
  saveClbDivision.Assign(clbDivision.CurrentSelections);
  saveClbSubdivision.Assign(clbSubdivision.CurrentSelections);
  saveClbSupercategory.Assign(clbSupercategory.CurrentSelections);
  saveClbCategory.Assign(clbCategory.CurrentSelections);
  saveClbSubcategory.Assign(clbSubCategory.CurrentSelections);
  saveCbDiscontinue := cbDiscontinue.Text;
  saveClbPrintStream.Assign(clbPrintStream.CurrentSelections);
  saveCbMidwordSearch := cbMidwordSearch.Checked;
  saveEdEntityCode := edtEntityCode.Text;
  saveClbCourse.Assign(clbCourse.CurrentSelections);
  saveClbUsesPortion.Assign(clbUsesPortion.CurrentSelections);
  SaveClbUsesTaxRule.Assign(clbUsesTaxRule.CurrentSelections);
  saveEdBarcode := edBarcode.Text;
  saveClbSupplier.Assign(clbSupplier.CurrentSelections);
  saveEdSupplierRef := edSupplierRef.Text;
  saveClbTagGroup.Assign(clbTagGroup.CurrentSelections);
  saveClbSubgroup.Assign(clbSubgroup.CurrentSelections);
  saveClbSection.Assign(clbSection.CurrentSelections);
  saveClbSubsection.Assign(clbSubSection.CurrentSelections);
  saveClbTag.Assign(clbTag.CurrentSelections);
end;

procedure TEntityFilterForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (ModalResult = mrOk) then
  begin
    if not ValidateForm then
      CanClose := false;
  end;
end;

procedure TEntityFilterForm.cbDiscontinueExit(Sender: TObject);
begin
  checkComboValue( TComboBox( Sender ), ANY_DISCONTINUE_STRING );
end;

procedure TEntityFilterForm.FormDestroy(Sender: TObject);
var
  i : Integer;
begin
  saveClbDivision.Free;
  saveClbSubdivision.Free;
  saveClbSupercategory.Free;
  saveClbCategory.Free;
  saveClbSubcategory.Free;
  saveClbTagGroup.Free;
  saveClbsubgroup.Free;
  saveClbSection.Free;
  saveClbSubsection.Free;
  saveClbTag.Free;
  saveClbLineType.Free;
  saveClbPrintStream.Free;
  saveClbCourse.Free;
  saveClbUsesPortion.Free;
  saveClbUsesTaxRule.Free;
  saveClbSupplier.Free;

  for i := 0 to structureTreeList.Count - 1 do
  begin
    TTreeLevel(structureTreeList.Items[i]).Free;
  end;

  for i := 0 to tagTreeList.Count - 1 do
  begin
    TTreeLevel(tagTreeList.Items[i]).Free;
  end;

  structureTreeList.Free;
  tagTreeList.Free;
end;

procedure TEntityFilterForm.handleStructureFilterCheck( refreshFromLevel : TTreeLevel );
begin
  FenableComboRefilter := false;
  try
    refillStructureTreeFrom( refreshFromLevel );
  finally
    FenableComboRefilter := true;
  end;
end;

procedure TEntityFilterForm.handleTagFilterCheck( refreshFromLevel : TTreeLevel );
begin
  FEnableComboRefilter := false;
  try
    refillTagTreeFrom( refreshFromLevel );
  finally
    FenableComboRefilter := true;
  end;
end;

procedure TEntityFilterForm.clbDivisionClickCheck(Sender: TObject);
begin
  handleAnyChecking(clbDivision, FdivisionAnyChecked);
  handleStructureFilterCheck( subdivisionTreeLevel );
  updateActiveFilterList;
  FdivisionAnyChecked := clbDivision.Checked[clbDivision.Items.IndexOf('Any')];
end;

procedure TEntityFilterForm.clbSubdivisionClickCheck(Sender: TObject);
begin
  handleAnyChecking(clbSubdivision, FsubdivisionAnyChecked);
  handleStructureFilterCheck( supercategoryTreeLevel );
  updateActiveFilterList;
  FSubdivisionAnyChecked := clbSubdivision.Checked[clbSubdivision.Items.IndexOf('Any')];
end;

procedure TEntityFilterForm.clbSupercategoryClickCheck(Sender: TObject);
begin
  handleAnyChecking(clbSupercategory, FsupercategoryAnyChecked);
  handleStructureFilterCheck( CategoryTreeLevel );
  updateActiveFilterList;
  FSupercategoryAnyChecked := clbSupercategory.Checked[clbSupercategory.Items.IndexOf('Any')];
end;

procedure TEntityFilterForm.clbCategoryClickCheck(Sender: TObject);
begin
  handleAnyChecking(clbCategory, FcategoryAnyChecked);
  handleStructureFilterCheck( subcategoryTreeLevel );
  updateActiveFilterList;
  FcategoryAnyChecked := clbCategory.Checked[clbCategory.Items.IndexOf('Any')];
end;

procedure TEntityFilterForm.clbSubcategoryClickCheck(Sender: TObject);
begin
  handleAnyChecking(clbSubcategory, FsubcategoryAnyChecked);
  updateActiveFilterList;
  FSubcategoryAnyChecked := clbSubcategory.Checked[clbSubcategory.Items.IndexOf('Any')];
end;

procedure TEntityFilterForm.clbTagGroupClickCheck(Sender: TObject);
begin
  handleAnyChecking(clbTagGroup, FtagGroupAnyChecked);
  handleTagFilterCheck( subgroupTreeLevel );
  updateActiveFilterList;
  FtagGroupAnyChecked := clbTagGroup.Checked[clbTagGroup.Items.IndexOf('Any')];
end;

procedure TEntityFilterForm.clbSubgroupClickCheck(Sender: TObject);
begin
  handleAnyChecking(clbSubgroup, FsubgroupAnyChecked);
  handleTagFilterCheck( sectionTreeLevel );
  updateActiveFilterList;
  FsubgroupAnyChecked := clbSubgroup.Checked[clbSubgroup.Items.IndexOf('Any')];
end;

procedure TEntityFilterForm.clbSectionClickCheck(Sender: TObject);
begin
  handleAnyChecking(clbSection, FsectionAnyChecked);
  handleTagFilterCheck( subsectionTreeLevel );
  updateActiveFilterList;
  FsectionAnyChecked := clbSection.Checked[clbSection.Items.IndexOf('Any')];
end;

procedure TEntityFilterForm.clbSubsectionClickCheck(Sender: TObject);
begin
  handleAnyChecking(clbSubsection, FsubsectionAnyChecked);
  handleTagFilterCheck( tagTreeLevel );
  updateActiveFilterList;
  FsubsectionAnyChecked := clbSubsection.Checked[clbSubsection.Items.IndexOf('Any')];
end;

procedure TEntityFilterForm.clbTagClickCheck(Sender: TObject);
begin
  handleAnyChecking(clbTag, FtagAnyChecked);
  updateActiveFilterList;
  FtagAnyChecked := clbTag.Checked[clbTag.Items.IndexOf('Any')];
end;

procedure TEntityFilterForm.acnShowTextFilterExecute(Sender: TObject);
begin
  pcMainWindow.ActivePage := tsTextFilter;
end;

procedure TEntityFilterForm.acnShowProdStructureExecute(Sender: TObject);
begin
  pcMainWindow.ActivePage := tsProductStructure;
end;

procedure TEntityFilterForm.acnShowProdSetUpExecute(Sender: TObject);
begin
  pcMainWindow.ActivePage := tsProductSetUp;
end;

procedure TEntityFilterForm.acnShowProdTagsExecute(Sender: TObject);
begin
  pcMainWindow.ActivePage := tsProductTags;
end;

procedure TEntityFilterForm.acnShowSupplierExecute(Sender: TObject);
begin
  pcMainWindow.ActivePage := tsSupplierDetails;
end;

procedure TEntityFilterForm.acnShowBarcodeExecute(Sender: TObject);
begin
  pcMainWindow.ActivePage := tsBarcode;
end;

procedure TEntityFilterForm.acnShowEntityCodeExecute(Sender: TObject);
begin
  pcMainWindow.ActivePage := tsEntityCode;
end;

procedure TEntityFilterForm.updateActiveFilterList;

  function getSelectionsAsString (selections : TStringList) : String;
  var
    i : integer;
  begin
    for i := 0 to selections.Count - 1 do
    begin
      if i = 0 then
        result := result + selections[i]
      else
        result := result + ', ' + selections[i];
    end;
  end;

  procedure addCheckListSelections (checkList : TExtendedCheckListBox; checkListName : string);
  var
    header : string;
    newLine : string;
  begin
    if not(onlyAnySelected(checkList))then
    begin
      header := checkListName;
      newLine := ': ' + getSelectionsAsString(checkList.CurrentSelections) + #13#10;
      rtbActiveFilters.SelStart := rtbActiveFilters.GetTextLen;
      rtbActiveFilters.SelAttributes.Style := [fsBold];
      rtbActiveFilters.SelText := header;
      rtbActiveFilters.SelStart := rtbActiveFilters.GetTextLen;
      rtbActiveFilters.SelAttributes.Style := [];
      rtbActiveFilters.SelText := newLine;
    end;
  end;

  function textFilterFieldSelected : boolean;
  begin
    result := cbName.Checked or cbDescription.Checked or cbB2BName.Checked
                or cbInvoiceName.Checked or cbImportExportRef.Checked;
  end;

var
  newLine : string;
begin
  rtbActiveFilters.Lines.Clear;
  if ((Trim( edText.Text ) <> '') and (Trim( edText.Text ) <> '*') or (cbTextSearchForBlank.Checked))
        and textFilterFieldSelected then
  begin
    if (cbTextSearchForBlank.Checked) then
      newLine := 'Blank values in '
    else
      newLine := trim(edText.Text) + ' in ';
    if cbName.Checked then
      newLine := newLine + 'Product Name; ';
    if cbDescription.Checked then
      newLine := newLine + 'Product Description; ';
    if cbB2BName.Checked then
      newLine := newLine + 'B2B Name; ';
    if cbInvoiceName.Checked then
      newLine := newLine + 'Invoice Name; ';
    if cbImportExportRef.Checked then
      newLine := newLine + 'Import/Export Ref; ';
    rtbActiveFilters.Lines.Add(newLine);
  end;

// Product structure group
  addCheckListSelections(clbDivision, 'Division');
  addCheckListSelections(clbSubdivision, 'Subdivision');
  addCheckListSelections(clbSupercategory, 'Supercategory');
  addCheckListSelections(clbCategory, 'Category');
  addCheckListSelections(clbSubcategory, 'Subcategory');

// product set up group
  addCheckListSelections(clbLineType, 'Product Type');
  addCheckListSelections(clbPrintStream, 'Print Stream');
  addCheckListSelections(clbCourse, 'Course');
  addCheckListSelections(clbUsesPortion, 'Uses Portion');
  addCheckListSelections(clbUsesTaxRule, 'Uses Tax Rule');
  if cbDiscontinue.Text <> ANY_DISCONTINUE_STRING then
  begin
    newLine := 'Discontinued: ' + cbDiscontinue.Text;
    rtbActiveFilters.Lines.Add(newLine);
  end;

// product tags group
  addCheckListSelections(clbTagGroup, 'Tag Group');
  addCheckListSelections(clbSubgroup, 'Sub-group');
  addCheckListSelections(clbSection, 'Section');
  addCheckListSelections(clbSubsection, 'Sub-section');
  addCheckListSelections(clbTag, 'Tag');

// barcode filter
  if cbBarcodeSearchForBlank.Checked then
    rtbActiveFilters.Lines.Add ( 'Has no Barcode defined' )
  else if (Trim( edBarcode.Text ) <> '') and (Trim( edBarcode.Text ) <> '*') then
  begin
    newLine := ': ' + Trim(edBarcode.Text) + #13#10;
    rtbActiveFilters.SelStart := rtbActiveFilters.GetTextLen;
    rtbActiveFilters.SelAttributes.Style := [fsBold];
    rtbActiveFilters.SelText := 'Barcode';
    rtbActiveFilters.SelStart := rtbActiveFilters.GetTextLen;
    rtbActiveFilters.SelAttributes.Style := [];
    rtbActiveFilters.SelText := newLine;
  end;

// supplier filters
  if cbSupplierRefSearchForBlank.Checked then
  begin
    newLine := ' is blank' + #13#10;
    rtbActiveFilters.SelStart := rtbActiveFilters.GetTextLen;
    rtbActiveFilters.SelAttributes.Style := [fsBold];
    rtbActiveFilters.SelText := 'Supplier Reference';
    rtbActiveFilters.SelStart := rtbActiveFilters.GetTextLen;
    rtbActiveFilters.SelAttributes.Style := [];
    rtbActiveFilters.SelText := newLine;
  end
  else if (Trim( edSupplierRef.Text ) <> '') and (Trim( edSupplierRef.Text ) <> '*') then
  begin
    newLine := ': ' + Trim(edSupplierRef.Text) + #13#10;
    rtbActiveFilters.SelStart := rtbActiveFilters.GetTextLen;
    rtbActiveFilters.SelAttributes.Style := [fsBold];
    rtbActiveFilters.SelText := 'Supplier Reference';
    rtbActiveFilters.SelStart := rtbActiveFilters.GetTextLen;
    rtbActiveFilters.SelAttributes.Style := [];
    rtbActiveFilters.SelText := newLine;
  end;
  addCheckListSelections(clbSupplier, 'Supplier Name');

// entity code filter
  if (Trim( edtEntityCode.Text ) <> '') and (Trim( edtEntityCode.Text ) <> '*') then
  begin
    newLine := ': ' + Trim( edtEntityCode.Text ) + #13#10;
    rtbActiveFilters.SelStart := rtbActiveFilters.GetTextLen;
    rtbActiveFilters.SelAttributes.Style := [fsBold];
    rtbActiveFilters.SelText := 'Entity Code';
    rtbActiveFilters.SelStart := rtbActiveFilters.GetTextLen;
    rtbActiveFilters.SelAttributes.Style := [];
    rtbActiveFilters.SelText := newLine;
  end;

  if rtbActiveFilters.GetTextLen = 0 then
    rtbActiveFilters.Lines.Add('No filters active');
end;

procedure TEntityFilterForm.edTextChange(Sender: TObject);
begin
  updateActiveFilterList;
end;

procedure TEntityFilterForm.textCheckBoxClick(Sender: TObject);
begin
  updateActiveFilterList;
end;

function TEntityFilterForm.onlyAnySelected( checklist : TExtendedCheckListBox) : boolean;
begin
  if ( checkList.Items.IndexOf('Any') <> -1 ) then
    if ( checkList.CurrentSelections.Count = 1 ) and
          (checkList.Checked[checkList.Items.IndexOf('Any')]) then
      result := true
    else
      result := false
  else
    result := false;
end;

function TEntityFilterForm.anyChangedToTrue(
  checklist: TExtendedCheckListBox; currentValue: boolean): boolean;
var
  oldValue : boolean;
  newValue : boolean;
begin
  oldValue := currentValue;
  if (checklist.Items.IndexOf('Any') <> -1) then
    newValue := checklist.Checked[checkList.Items.IndexOf('Any')]
  else
    newValue := false;
  result := (newValue = true) and (newValue <> oldValue);
end;

procedure TEntityFilterForm.handleAnyChecking(checkList : TExtendedCheckListBox; anyChecked : boolean);
var
  i : integer;
begin
  if anyChangedToTrue(checkList, anyChecked) then
  begin
    // change all other values to false
    for i := 0 to checkList.Items.Count - 1 do
    begin
      if checkList.Items[i] <> 'Any' then
        checkList.Checked[i] := false;
    end;
  end
  else if (checkList.CurrentSelections.Count = 0) then
  begin
    // if no selection made, check the 'any' box
    checkList.Checked[checkList.Items.IndexOf('Any')] := true;
  end
  else if not (onlyAnySelected(checkList)) then
  begin
    // unselect 'any'
    checkList.Checked[checkList.Items.IndexOf('Any')] := false;
  end;
end;

procedure TEntityFilterForm.clbLineTypeClickCheck(Sender: TObject);
begin
  handleAnyChecking(clbLineType, FlinetypeAnyChecked);
  updateActiveFilterList;
  FlineTypeAnyChecked := clbLineType.Checked[clbLineType.Items.IndexOf('Any')];
end;

procedure TEntityFilterForm.clbPrintStreamClickCheck(Sender: TObject);
begin
  handleAnyChecking(clbPrintStream, FprintStreamAnyChecked);
  updateActiveFilterList;
  FprintStreamAnyChecked := clbPrintStream.Checked[clbPrintStream.Items.IndexOf('Any')];
end;

procedure TEntityFilterForm.clbCourseClickCheck(Sender: TObject);
begin
  handleAnyChecking(clbCourse, FcourseAnyChecked);
  updateActiveFilterList;
  FcourseAnyChecked := clbCourse.Checked[clbCourse.Items.IndexOf('Any')];
end;

procedure TEntityFilterForm.clbUsesPortionClickCheck(Sender: TObject);
begin
  handleAnyChecking(clbUsesPortion, FusesPortionAnyChecked);
  updateActiveFilterList;
  FusesPortionAnyChecked := clbUsesPortion.Checked[clbUsesPortion.Items.IndexOf('Any')];
end;

procedure TEntityFilterForm.clbUsesTaxRuleClickCheck(Sender: TObject);
begin
  handleAnyChecking(clbUsesTaxRule, FusesTaxRuleAnyChecked);
  updateActiveFilterList;
  FusesTaxRuleAnyChecked := clbUsesTaxRule.Checked[clbUsesTaxRule.Items.IndexOf('Any')];
end;

procedure TEntityFilterForm.clbSupplierClickCheck(Sender: TObject);
begin
  handleAnyChecking(clbSupplier, FsupplierAnyChecked);
  updateActiveFilterList;
  FsupplierAnyChecked := clbSupplier.Checked[clbSupplier.Items.IndexOf('Any')];
end;

procedure TEntityFilterForm.addActivePageIndicator(button : TButton);
begin
  button.Caption := button.Caption + ' >';
end;

procedure TEntityFilterForm.removeActivePageIndicator(button : TButton);
begin
  button.Caption := copy(button.Caption, 0, Length(button.Caption) - 2);
end;

procedure TEntityFilterForm.productSetUpFiltersChanged(Sender: TObject);
begin
  updateActiveFilterList;
end;

procedure TEntityFilterForm.tsTextFilterShow(Sender: TObject);
begin
  addActivePageIndicator(btnTextFilter);
end;

procedure TEntityFilterForm.tsTextFilterHide(Sender: TObject);
begin
  removeActivePageIndicator(btnTextFilter);
end;

procedure TEntityFilterForm.tsProductStructureShow(Sender: TObject);
begin
  addActivePageIndicator(btnProductStructure);
end;

procedure TEntityFilterForm.tsProductStructureHide(Sender: TObject);
begin
  removeActivePageIndicator(btnProductStructure);
end;

procedure TEntityFilterForm.tsProductSetUpShow(Sender: TObject);
begin
  addActivePageIndicator(btnProductSetUp);
end;

procedure TEntityFilterForm.tsProductSetUpHide(Sender: TObject);
begin
  removeActivePageIndicator(btnProductSetUp);
end;

procedure TEntityFilterForm.tsProductTagsShow(Sender: TObject);
begin
  addActivePageIndicator(btnProductTags);
end;

procedure TEntityFilterForm.tsProductTagsHide(Sender: TObject);
begin
  removeActivePageIndicator(btnProductTags);
end;

procedure TEntityFilterForm.tsBarcodeShow(Sender: TObject);
begin
  addActivePageIndicator(btnBarcodeFilters);
end;

procedure TEntityFilterForm.tsBarcodeHide(Sender: TObject);
begin
  removeActivePageIndicator(btnBarcodeFilters);
end;

procedure TEntityFilterForm.tsSupplierDetailsShow(Sender: TObject);
begin
  addActivePageIndicator(btnSupplierDetails);
end;

procedure TEntityFilterForm.tsSupplierDetailsHide(Sender: TObject);
begin
  removeActivePageIndicator(btnSupplierDetails);
end;

procedure TEntityFilterForm.tsEntityCodeShow(Sender: TObject);
begin
  addActivePageIndicator(btnEntityCode);
end;

procedure TEntityFilterForm.tsEntityCodeHide(Sender: TObject);
begin
  removeActivePageIndicator(btnEntityCode);
end;

procedure TEntityFilterForm.cbTextSearchForBlankClick(Sender: TObject);
begin
  edText.Enabled := not (cbTextSearchForBlank.Checked);
  updateActiveFilterList;
end;

procedure TEntityFilterForm.cbBarcodeSearchForBlankClick(Sender: TObject);
begin
  edBarcode.Enabled := not (cbBarcodeSearchForBlank.Checked);
  updateActiveFilterList;
end;

procedure TEntityFilterForm.cbSupplierRefSearchForBlankClick(
  Sender: TObject);
begin
  edSupplierRef.Enabled := not (cbSupplierRefSearchForBlank.Checked);
  updateActiveFilterList;
end;



end.
