unit uDatabaseADO;

interface

uses
  SysUtils, Classes, DB, ADODB, DBClient, Provider, comObj, uGlobals, Contnrs, Controls, forms;

type
  // Cost price mode used for computing the budgeted cost price of a choice.
  //   cpmAverage - price is the average price of all choice items
  //   cpmMaximum - price is the maximum price of all choice items
  //   cpmMinimum - price is the minimum price of all choice items
  TCostPriceMode = (cpmNone = 0, cpmAverage = 1, cpmMaximum = 2, cpmMinimum = 3);

  //The three selling price related values that are shown at the bottom of the portions grid.
  TPortionPriceGridValue = (ppgvPortionPrice = 0, ppgvGPAmount = 1, ppgvGPorCOSPercent = 2);

  //The figure used to calculate the selling price.
  //  spmGP - price is calculated from a GP% entered by user
  //  spmCOS - price is calculated from a Cost of Sales% entered by user
  TPortionPriceMode = (ppmGP = 0, ppmCOS = 1);

  //The figure used to calculate the selling price.
  //  comNonNested - multi-select choices cannot appear anywhere outside the first level.
  //  comNested - multi-select choices can be nested.
  TConversationalOrderingMode = (comNonNested = 0, comNested = 1);

  // Enumeration of entity types.
  EntType = (etNone, etInstruct, etChoice, etPrepItem, etPurchLine, etRecipe,
             etStrdLine, etMultiPurch);
  EntTypeSet = set of EntType;

  // Enumeration of methods of calculation Aztec Portion quantities (value stored in PortionIngredients table)
  TCalculationType = (calcUnspecified = 0, calcUnit = 1, calcPortion = 2, calcFactor = 3);

  TStaticLookupType = (sltPortionTypes, sltSubcategory, sltPrintStream, sltSupplier, sltVATBand, sltGiftCard);

  TDirection = (dUp, dDown);

  // Class representing information about a specific base unit, e.g. Volume, Weight, Item
  TBaseTypeInfo = class
  public
    // String list of all units with the given base type
    unitsforbasetype: TStringList;
    // String list of all units with the given base type, including 'Portion'
    unitsforbasetypeplusportion: TStringList;
  end;

  // Class representing information about a specific unit, e.g. #10 Olive, Each
  // This information is extracted from the Units.DB table.
  TUnitInfo = class
  public
    // Information about the base type of this unit
    basetypeinfo: TBaseTypeInfo;
    // Number of base units for this unit
    baseunits: Double;
  end;

  TVATBandInfo = class
  public
    VATIndex: integer;
  end;

  TListItemInfo = class
  public
    ListItemSchemaIndex: integer;
  end;


  TBoolFunc = function: boolean of object;
  TNoArgsProc = procedure of object;

  TProductsDB = class(TDataModule)

    //Note: The only reason for creating persistent fields on the EntityTable is so that
    // the [EntityCode] field can be specified as a key field for the EntityTableProvider
    // object. This is done by adding pfinKey to the ProviderFlags property of the field
    // object. Without this applying updates from the EntityClientDataset fails because the
    // provider cannot find the key field when it tries to create the UPDATE SQL. Unfortunately
    // when you create one persistent field you have to create them all.
    EntityTable: TADODataSet;
    EntityTableEntityCode: TFloatField;
    EntityTableRetailName: TStringField;
    EntityTableRetailDescription: TStringField;
    EntityTableEntityType: TStringField;
    EntityTableImportExportReference: TStringField;
    EntityTableSubCategoryName: TStringField;
    EntityTableDefaultPrinterStream: TStringField;
    EntityTableAlcohol: TFloatField;
    EntityTableWhetherSalesTaxable: TStringField;
    EntityTableWhetherOpenPriced: TStringField;
    EntityTablePurchaseName: TStringField;
    EntityTablePurchaseUnit: TStringField;
    EntityTableDefaultSupplier: TStringField;
    EntityTableBudgetedCostPrice: TBCDField;
    EntityTableLMDT: TDateTimeField;
    EntityTableModifiedBy: TStringField;
    EntityTableCreationDate: TDateTimeField;
    EntityTableDeleted: TStringField;
    EntityTableAztecEposButton1: TStringField;
    EntityTableAztecEposButton2: TStringField;
    EntityTableAztecEposButton3: TStringField;
    EntityTableExtendedRTLName: TStringField;
    EntityTableSpecialRecipe: TStringField;

    EntityTableProvider: TDataSetProvider;

    ClientEntityTable: TClientDataSet;
    ClientEntityTableEntityCode: TFloatField;
    ClientEntityTableRetailName: TStringField;
    ClientEntityTableRetailDescription: TStringField;
    ClientEntityTableEntityType: TStringField;
    ClientEntityTableImportExportReference: TStringField;
    ClientEntityTableSubCategoryName: TStringField;
    ClientEntityTableDefaultPrinterStream: TStringField;
    ClientEntityTableAlcohol: TFloatField;
    ClientEntityTableWhetherSalesTaxable: TStringField;
    ClientEntityTableWhetherOpenPriced: TStringField;
    ClientEntityTablePurchaseName: TStringField;
    ClientEntityTablePurchaseUnit: TStringField;
    ClientEntityTableDefaultSupplier: TStringField;
    ClientEntityTableBudgetedCostPrice: TBCDField;
    ClientEntityTableLMDT: TDateTimeField;
    ClientEntityTableModifiedBy: TStringField;
    ClientEntityTableCreationDate: TDateTimeField;
    ClientEntityTableDeleted: TStringField;
    ClientEntityTableAztecEposButton1: TStringField;
    ClientEntityTableAztecEposButton2: TStringField;
    ClientEntityTableAztecEposButton3: TStringField;
    ClientEntityTableExtendedRTLName: TStringField;
    ClientEntityTableSpecialRecipe: TStringField;
    ClientEntityTableEntityTypeOrder: TSmallintField;
    EntityDataSource: TDataSource;

    RecipeNotesTable: TADOTable;
    RecipeNotesTableEntityCode: TFloatField;
    RecipeNotesTableRecipeNotes: TMemoField;
    RecipeNotesTableOriginalLMD: TDateTimeField;
    RecipeNotesTableOriginalLMT: TStringField;
    RecipeNotesTableLMDT: TDateTimeField;
    RecipeNotesDataSource: TDataSource;

    UnitSupplierTable: TADOTable;
    UnitSupplierTableEntityCode: TFloatField;
    UnitSupplierTableSupplierName: TStringField;
    UnitSupplierTableUnitName: TStringField;
    UnitSupplierTableFlavour: TStringField;
    UnitSupplierTableImportExportReference: TStringField;
    UnitSupplierTableBarcode: TStringField;
    UnitSupplierTableUnitCost: TBCDField;
    UnitSupplierTableDefaultFlag: TStringField;
    UnitSupplierDataSource: TDataSource;
    ProductTypesDS: TDataSource;
    UnitsQuery: TADOQuery;
    SubcategoryQuery: TADOQuery;
    VatBandQuery: TADOQuery;
    PrintStreamQuery: TADOQuery;
    SupplierQuery: TADOQuery;

    //General purpose components for executing SQL specified at runtime.
    ADOCommand: TADOCommand;
    ADOQuery: TADOQuery;
    PortionTypeTable: TADOTable;
    PortionTypeDataSource: TDataSource;
    IngredDataSource1: TDataSource;
    PortionsDataSource1: TDataSource;
    EntityTableTrueHalfAllowed: TBooleanField;
    ClientEntityTableTrueHalfAllowed: TBooleanField;
    ADOStoredProc: TADOStoredProc;
    ProductTypesTable: TADODataSet;
    ProductTaxTable: TADOTable;
    ProductTaxTableEntityCode: TFloatField;
    ProductTaxDS: TDataSource;
    EntityTableCourseID: TSmallintField;
    ClientEntityTableCourseID: TSmallintField;
    ProductTaxTableTaxRule1: TSmallintField;
    ProductTaxTableTaxRule2: TSmallintField;
    ProductTaxTableTaxRule3: TSmallintField;
    ProductTaxTableTaxRule4: TSmallintField;
    qryTaxRules: TADOQuery;
    dsTaxRules: TDataSource;
    DefaultPortionQuery: TADOQuery;
    IngredientsQuery1: TADODataSet;
    IngredientsQuery1PortionID: TIntegerField;
    IngredientsQuery1IngredientCode: TFloatField;
    IngredientsQuery1UnitName: TStringField;
    IngredientsQuery1IsMinor: TBooleanField;
    IngredientsQuery1PortionTypeID: TSmallintField;
    IngredientsQuery1Quantity: TBCDField;
    IngredientsQuery1CalculationType: TWordField;
    IngredientsQuery1DisplayOrder: TWordField;
    IngredientsQuery1IngredientType: TStringField;
    IngredientsQuery1UnitDisplayName: TStringField;
    IngredientsQuery1IngredientDescription: TStringField;
    IngredientsQuery1IngredientName: TStringField;
    PortionsQuery1: TADODataSet;
    MultiPurchIngredientTable: TADOTable;
    MultiPurchIngredientTableEntityCode: TFloatField;
    MultiPurchIngredientTableIngredientCode: TFloatField;
    MultiPurchIngredientTableDisplayOrder: TWordField;
    MultiPurchIngredientTableUnitName: TStringField;
    MultiPurchIngredDataSource: TDataSource;
    MultiPurchIngredientTableIngredientName: TStringField;
    MultiPurchIngredientTableIngredientDescr: TStringField;
    FindEditSessionIdsQuery: TADODataSet;
    ProductChangeLog: TADODataSet;
    MultiPurchIngredientTableReturnable: TBooleanField;
    spDeleteEntityFromTheme: TADOStoredProc;
    CategoryTreeQuery: TADODataSet;
    EntityTablePrintStreamWhenChild: TWordField;
    ClientEntityTablePrintStreamWhenChild: TSmallintField;
    EntityTableRollupPriceWhenChild: TBooleanField;
    ClientEntityTableRollupPriceWhenChild: TBooleanField;
    EntityTableFollowCourseWhenChild: TBooleanField;
    ClientEntityTableFollowCourseWhenChild: TBooleanField;
    dsProductBarcodes: TDataSource;
    qryProductBarCodes: TADOQuery;
    tblPreparedItemDetails: TADOTable;
    tblPreparedItemDetailsEntityCode: TFloatField;
    tblPreparedItemDetailsStorageUnit: TStringField;
    tblPreparedItemDetailsBatchUnit: TStringField;
    tblPreparedItemDetailsNotes: TMemoField;
    tblPreparedItemDetailsLMDT: TDateTimeField;
    dsPreparedItemDetails: TDataSource;
    tblPreparedItemDetailsBatchSize: TBCDField;
    qEditTempPortions: TADOQuery;
    dsTempPortions: TDataSource;
    qEditCookTimes: TADOQuery;
    dsEditCookTimes: TDataSource;
    dsPortionType: TDataSource;
    qPortionType: TADOQuery;
    DataSource1: TDataSource;
    qLoadPortions: TADOQuery;
    qEditPortions: TADOQuery;
    qSavePortions: TADOQuery;
    dsPortions: TDataSource;
    EntityTableDiscontinue: TBooleanField;
    ClientEntityTableDiscontinue: TBooleanField;
    UnitSupplierTableEffectiveDate: TDateTimeField;
    UnitSupplierTableUserID: TLargeintField;
    qSavePurchaseUnits: TADOQuery;
    qLoadPurchaseUnits: TADOQuery;
    IngredientsQuery1Cost: TBCDField;
    EntityTableSoldByWeight: TBooleanField;
    ClientEntityTableSoldByWeight: TBooleanField;
    ScaleContainerTable: TADOTable;
    qEditContainers: TADOQuery;
    dsEditContainers: TDataSource;
    qEditContainersContainerId: TIntegerField;
    qEditContainersPortionid: TIntegerField;
    qEditContainersEntityCode: TFloatField;
    qEditContainersPortionTypeId: TIntegerField;
    qEditContainersDisplayOrder: TIntegerField;
    qEditContainersPortionName: TStringField;
    qEditContainersCookTime: TDateTimeField;
    qEditContainersDefaultCookTime: TBooleanField;
    qEditContainersContainerName: TStringField;
    ScaleContainerTableContainerId: TIntegerField;
    ScaleContainerTableName: TStringField;
    ScaleContainerTableDescription: TStringField;
    ScaleContainerTableTareWeight: TFloatField;
    adoqProductHasChoices: TADOQuery;
    qScaleContainers: TADOQuery;
    qryProductBarcodeRanges: TADOQuery;
    dsProductBarcodeRanges: TDataSource;
    qryProductBarcodeRangesEntityCode: TLargeintField;
    qryProductBarcodeRangesBarcodeRangeID: TLargeintField;
    qryProductBarcodeRangesDescription: TStringField;
    qryProductBarcodeRangesStartValue: TStringField;
    qryProductBarcodeRangesEndValue: TStringField;
    qryProductBarcodeRangesHasExceptions: TBooleanField;
    dtsEditPortionChoices: TDataSource;
    qEditPortionChoices: TADOQuery;
    ADOQueryPConfigs: TADOQuery;
    adoqRMControlled: TADOQuery;
    adocRecipeModelling: TADOConnection;
    adotRMControlled: TADOTable;
    qEditCookTimesCookTime: TDateTimeField;
    qEditCookTimesportionname: TStringField;
    qEditCookTimesdefaultcooktime: TBooleanField;
    qEditCookTimesportiontypeid: TSmallintField;
    ClientEntityTableisGiftCard: TWordField;
    EntityTableisGiftCard: TWordField;
    dsPortionPrices: TDataSource;
    qLoadPortionPrices: TADOQuery;
    qSavePortionPrices: TADOQuery;

    PortionPricesTable: TADODataSet;
    adotProductCostPrice: TADOTable;
    adotProductCostPriceEntityCode: TFloatField;
    adotProductCostPriceCostPriceMode: TWordField;
    ClientEntityTableB2BName: TStringField;
    EntityTableB2BName: TStringField;
    adoqGiftCardTypes: TADOQuery;
    ProductPropertiesTable: TADODataSet;
    PPTableProvider: TDataSetProvider;
    ClientPPTable: TClientDataSet;
    PPDataSource: TDataSource;
    ProductPropertiesTableIsAdmission: TBooleanField;
    ProductPropertiesTableValidateMembership: TBooleanField;
    ProductPropertiesTableIsFootfall: TBooleanField;
    ProductPropertiesTableIsDonation: TBooleanField;
    ProductPropertiesTablePromptForGiftAid: TBooleanField;
    ClientPPTableIsAdmission: TBooleanField;
    ClientPPTableValidateMembership: TBooleanField;
    ClientPPTableIsFootfall: TBooleanField;
    ClientPPTableIsDonation: TBooleanField;
    ClientPPTablePromptForGiftAid: TBooleanField;
    ProductPropertiesTableEntityCode: TFloatField;
    ClientPPTableEntityCode: TFloatField;
    ProductPropertiesTableCountryOfOrigin: TStringField;
    ClientPPTableCountryOfOrigin: TStringField;

    procedure ClientProductsTableBudgetedCostPriceGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);

    procedure DataModuleCreate(Sender: TObject);

    procedure ClientEntityTableBeforePost(DataSet: TDataSet);
    procedure ClientEntityTableCalcFields(DataSet: TDataSet);

    procedure RecipeNotesTableBeforePost(DataSet: TDataSet);

    procedure EntityTableProviderUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError;
      UpdateKind: TUpdateKind; var Response: TResolverResponse);

    procedure IngredientsQueryCalcFields(DataSet: TDataSet);
    procedure RecipeNotesTableRecipeNotesChange(Sender: TField);
    procedure ProductTaxDSUpdateData(Sender: TObject);
    procedure MultiPurchIngredientTableCalcFields(DataSet: TDataSet);
    procedure ClientEntityTableEntityTypeGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure ClientEntityTablePrintStreamWhenChildGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure ClientEntityTablePrintStreamWhenChildSetText(Sender: TField;
      const Text: String);
    procedure DataModuleDestroy(Sender: TObject);
    procedure tblPreparedItemDetailsStorageUnitChange(Sender: TField);
    procedure tblPreparedItemDetailsBatchUnitChange(Sender: TField);
    procedure qEditPortionChoicesAfterPost(DataSet: TDataSet);
    procedure qEditCookTimesCookTimeGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure ClientEntityTableisGiftCardGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure ClientEntityTableisGiftCardSetText(Sender: TField;
      const Text: String);
    procedure ClientEntityTableGiftCardToggleChange(Sender: TField);
    procedure tblPreparedItemDetailsBatchSizeValidate(Sender: TField);
    procedure ProductTaxTableTaxRuleChange(Sender: TField);
    procedure ProductTaxTableAfterScroll(DataSet: TDataSet);
    procedure qEditPortionsAfterPost(DataSet: TDataSet);
    procedure ClientPPTableAfterScroll(DataSet: TDataSet);
    procedure ClientPPTableReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure ClientPPTablePostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
  private
    IngnoreRecipeNoteChanges : Boolean;

    // Unit string lookups

    // A list of all currrently available unit names.  The object associated with a string
    // in this list is an instance of TUnitInfo, which contains additional info about the unit.
    validunitlist: TStringList;
    // A list of all unit names, including deleted ones.  The object associated with a string
    // in this list is an instance of TUnitInfo, which contains additional info about the unit.
    allunitlist: TStringList;
    // A list of all available base type names.  The object associated with a string in this
    // table is an instance of TBaseTypeInfo, which contains additional info about the base type.
    basetypelist: TStringList;
    // An empty string list
    nulllist: TStringList;
    // A string list containing all available portion types
    portionlist: TStringList;

    // Other lookup lists

    // A list of all available print streams
    printstreamlist: TStringList;
    // A list of all currently available subcategories.  The object associated with a
    // string in this table is an instance of TSubcategoryInfo.
    subcategorieslist: TStringList;
    // A list of all available suppliers.
    supplierlist: TStringList;
    // A list of all available VatBands.
    vatbandlist: TStringList;

    // List of child print modes
    UseChildPrintStreamText: string;
    UseParentPrintStreamText: string;
    UseBothPrintStreamText: string;
    ChildPrintStreamModes: array[1..3] of string;
    childPrintModesList: TStringList;

    GiftCardTypeNames: TStringList;
    GiftCardTypeList: TStringList;

    FpostingClientEntityTable : boolean;

    //Used for keeping a list of datasets which share the data of ClientEntityTable
    //by calling TClientDataSet.CloneCursor. The list will be used to "re-clone" these
    //datasets whenever ClientEntityTable data is re-loaded from the database.
    ClonedClientEntityDatasets : TObjectList;


    //True if product portion edits need saving
    FPortionChangesExist: Boolean;
    //Callback to do portion data save
    FSavePortionIngredients: TNoArgsProc;

    //Callbacks for portion prices data management
    FPortionPriceChangesExist: TBoolFunc;
    FSavePortionPriceChanges: TNoArgsProc;

    //Callbacks for unit supplier data management
    FUnitSupplierChangesExist: TBoolFunc;
    FSaveUnitSupplierChanges: TNoArgsProc;

    //Callbacks for tag data management.
    FTagChangesExist: TBoolFunc;
    FSaveTagChanges: TNoArgsProc;

    //The date that the cost price data in the tables #PortionBudgetedCosts & #UnitBudgetedCosts is for.
    FDateOfCostPriceCache: string;

    // The current cost price mode for choices - see definition of TCostPriceMode.
    FcostPriceModeForChoices: TCostPriceMode;

    // Whether to base selling price calculation on GP% or Cost of Sales%
    FPortionPriceMode: TPortionPriceMode;

    // Whether to base selling price calculation on GP% or Cost of Sales%
    FConversationalOrderingMode: TConversationalOrderingMode;

    // Whether to show the portions prices grid on the portions tab.
    FShowPortionPrices: boolean;

    // Maximum number of portions a product can have.
    FMaxAllowedPortions: integer;

    //Total of the inclusive tax rates assigned to the current product
    FTotalInclusiveTax: double;

    FTaxRulesChanged: TNotifyEvent;

    //Returns TRUE if the unit 'Portion' exists in the Units table.
    function PortionUnitExists : boolean;

    //Returns true if the given entityCode exists in the Products table.
    function ProductExists(entityCode: double) : boolean;

    // Locate the TUnitInfo record for a particular unit, or return nil, if it cannot be found.
    // This function will work even if the unit has been deleted.
    function getUnitInfo( unit1: string ) : TUnitInfo;

    procedure CreateProductTypesTable;
    procedure ConvertAllEmptyStringsToNull(DataSet : TDataSet);

    // Method to populate all the TStringList lookups
    procedure createLookups;

    // Is the field a field controlled by the master datasource for this dataset?
    function isMasterField( ds : TDataSet; f : TField ) : boolean;

    // One-shot call at start up to create all the default aztec portions and ingredients.
    procedure createDefaultAztecPortionsAndIngredients;
    // One-shot call at start up to fill in blank fields in product table
    procedure fillInDefaultProductData;

    procedure SavePendingPortionPriceChanges;
    procedure SavePendingUnitSupplierChanges;
    procedure SavePendingTagChanges;

    procedure SetChildPrintStreamMode;
    procedure SetIsMinorValues;
    procedure createTempTablesAndStoredProcs;
    procedure deleteTempTablesAndStoredProcs;
    procedure LogUpdateConflicts (d: TCustomADODataset);
    procedure LogClientEntityTableUpdateConflicts;
    procedure SetCostPriceModeForChoices(const AValue: TCostPriceMode);
    function GetCostPriceModeForChoices: TCostPriceMode;
    function IsEntityAChoice(EntityCode : String) : boolean;
    function GetDefaultTotal : integer;
    function GetAztecRecipeModellingDBConnectionString : String;
    function GetCurrentEntityControlledByRM: Boolean;
    function ProductTaxRulesValid: Boolean;
    function GetPortionPriceMode: TPortionPriceMode;
    function GetShowPortionPrices: boolean;
    procedure SetShowPortionPrices(const value: boolean);

    function GetShowB2BName: boolean;
    procedure SetShowB2BName(const Value: boolean);
    function GetTotalInclusiveTax: double;
    function GetConversationalOrderingMode: TConversationalOrderingMode;
  public
    // Level, i.e. are we performing global line edit or site line edit
    current_level1: Integer; // 1 = global lines, 4 = site lines
    // Either 'Global' for global lines or 'Site' for site lines.
    entity_level: String;
    // = 0 if we are doing global lines, or is set to the site_code if we are doing site lines.
    site_code: Integer;
    // 'Global' if we are doing global lines, or 'Site IHOP 123232' or similar for site lines.
    level_title: String;
    // The range of entity codes permitted at the current level
    entitycodelow, entitycodehigh: Double;

    // The login name of the user using LineEdit
    logonName: String;

    // The filter string used on the entity table to select those entities which may be
    // edited in the current session.
    //   - in global mode this selects all non-deleted global lines
    //   - in site mode this selects all non-deleted lines for the site
    editable_entity_filter: String;
    // The filter string used on the entity table to select those entities which may be
    // included in menus/choices/recipes in the current session.
    //   - in global mode this selects all non-deleted global lines
    //   - in site mode this selects all non-deleted lines for the site & non-deleted global lines
    ingredient_entity_filter: String;
    // The filter string used on the entity table to select those entities which are
    // available in memory.  This must include all the items selected by editable_entity_filter
    // and ingredient_entity_filter.
    //   - in global mode this selects all non-deleted global lines
    //   - in site mode this selects all non-deleted lines for the site & non-deleted global lines
    cached_entity_filter: String;

    // TRUE if there are any aztec tills in the system
    anyAztecTills: boolean;

    skipValidatePortion : boolean;

    GAidFlagEnabled : boolean;

    // Sets the database into global mode, initializing appropriate variables and query parameters
    procedure setGlobal;
    // Sets the database into site mode, initializing appropriate variables and query parameters
    procedure setSiteCode( siteCode: Integer; siteName: string );

    // Initializes all lookups lists and opens all tables, ready for the opening of the LineEdit
    // dialog This routine can only be called after setGlobal/setSetCode has been called.
    procedure start;

    // lookup lists

    // Returns TRUE if the units specified are of the same basic type
    function unitsHaveSameBaseType( unit1, unit2: string ) : boolean;
    // Returns a string list of units with the same basic type as unitname.
    // If includePortion is true, then the list will always contain the entry 'Portion',
    // even if Portion has a different base type.
    function getUnitsWithSameBaseType( unitname: string; includePortion: boolean ) : TStringList;
    // How many base units for unitname contain?  Returns 0 if unitname is unknown.
    function getBaseUnits( unitname: string ) : Double;
    // Get the division id for a subcategory name.
    function GetDivisionIdForSubcategory( subcat: string ) : string;
    // Returns TRUE if the current entity has Aztec Portions
    function ProductHasAztecPortions: boolean;

    procedure AddNewUnit(UName, BaseType: string; UnitSize: real);
    procedure AddPortionType(PortionTypeName: string);
    procedure AddPrinterStream(StreamName: string);
    procedure AddVATBand(BandName: string; Index: integer);
    procedure AddSubCateg(subCat: string; divisionId: integer);

    // Get a list of all valid unit names
    property validUnitsStringList : TStringList read validunitlist;
    // Get an empty list
    property nullStringList : TStringList read nulllist;
    // Get an list containing all available portion types
    property portionStringList : TStringList read portionlist;
    // Get an list of all print stream names
    property printStreamStringList : TStringList read printstreamlist;
    // Get an list of all subcategory names
    property subCategoryStringList : TStringList read subcategorieslist;
    // Get an list of all supplier names
    property supplierStringList : TStringList read supplierlist;
    // Get an list of all vatband names
    property vatbandStringList : TStringList read vatbandlist;
    // List of child print modes
    property childPrintModesStringList : TStringList read childPrintModesList;
    // List of gift card types
    property GiftCardTypesStringList : TStringList read GiftCardTypeList;

    // Scroll the ClientEntityLookupTable to the specified entity code.  Return value
    // is TRUE if an entity with that code was found, false otherwise.
    function EntityTableLookup( entityCode: double): boolean;

    // Update the budgeted cost price for the currently selected entity in the ClientEntityTable
    // If the dataset mode was dsBrowse, then ClientEntityTable.Edit is called, and the table
    // is left in the state dsEdit.  However, if the cost price is identical to the price in
    // the ClientEntityTable, then no update is performed.
    procedure SetBudgetedCostPrice( costPrice: double );
    // Set the budgeted cost price for the currently selected entity in the ClientEntityTable
    // If the dataset mode was dsBrowse, then ClientEntityTable.Edit is called, and the table
    // is left in the state dsEdit.  However, if the cost price was already NULL, then
    // then no update is performed.
    procedure ClearBudgetedCostPrice;

    // Post any outstanding modifications to tables which can be modified in the line edit
    // dialog.
    // This should be called prior to performing major operations involving these tables,
    // exiting the LineEdit dialog etc.
    // All the relevant validation routines are performed when posting chnages.  If any of
    // these validation routines fail, this routine will raise an EAbort exception.
    //
    // This routine is being called prior to scrolling the clientEntity table or leaving the
    // LineEdit dialog.
    procedure SaveAllTableChanges;
    function AreThereTableChangesToSave : boolean;
    procedure SavePendingPortionChanges;
    procedure SavePendingPortionChangesIfPossible;

    // Fills in default values for a newly created row in the ClientEntityTable.
    procedure ClientEntityTableDefaultFill(et : EntType);
    // Get the next available entity code.  If we are in global mode, this returns a global
    // entity code, otherwise it returns a site entity code
    function GetNextEntCode: double;

    //Get the next available ID for an Aztec Portion.
    function GetNextPortionID: integer;

    procedure ClientEntityTableInvisiblePost;
    function ProductNewlyInsertedAndNotSaved : boolean;

    procedure LoadProductsDataFromDatabase(ProgressTitle : string);
    procedure CloneClientEntityTable (CloneDataSet : TClientDataSet; KeepSettings : boolean);

    // Get the original base units for the current product in the ClientEntityTable, ignoring any
    // inprogress edits. This is used to validate that any modifications to units do not change the
    // base type of the units. If the dataset is in insert mode, this returns the empty string.
    function AllowBaseUnitChange: boolean;
    function OriginalBaseUnit: string;

    // Reload all the data from the database.
    procedure RefreshDataFromDatabase;

    // Returns TRUE if posting the current record in dataset will cause a key violation.
    // This can be used with BatchOptimistic ADO datasets to determine if posting a record
    // is safe, since the ADO dataset does not do this validation.  keyCols is the list
    // of columns to be used in determining if there is a duplicate.
    function WillADOPostCauseKeyViol( dataset: TCustomADODataSet;
                                      keyCols: array of string ) : boolean;

    // Remove references to a deleted product from Theme Modelling.
    procedure RemoveEntityFromThemeModel(entityCode: Double);

    // Returns TRUE if options for adding base data should be hidden.
    function shouldHideBaseDataAddOptions: boolean;

    property postingClientEntityTable : boolean read FpostingClientEntityTable;

    // Utilities for storing and restoring rows
    procedure storeRowValues( var rowValues : variant; ds : TDataSet );
    procedure restoreRowValues( rowValues : variant; ds : TDataSet );
    procedure storeRows( var rows : variant; ds : TDataSet );
    procedure restoreRows( rows : variant; ds : TDataSet );
    procedure cancelDatasetChanges( ds : TDataSet );

    function ValidateBarCode(const theBarCodeToValidate: string; isCustomBarcode: boolean): boolean; // job 326084

    //Return the name of the unit which a prepared item batch size is measured in.
    function GetAztecPreparedItemBatchUnit(EntityCode : Double) : string;

    procedure ApplyFutureChanges;
    property PortionChangesExist: Boolean read FPortionChangesExist write FPortionChangesExist;
    property SavePortionIngredients: TNoArgsProc read FSavePortionIngredients write FSavePortionIngredients;

    property PortionPriceChangesExist: TBoolFunc read FPortionPriceChangesExist write FPortionPriceChangesExist;
    property SavePortionPriceChanges: TNoArgsProc read FSavePortionPriceChanges write FSavePortionPriceChanges;

    property UnitSupplierChangesExist: TBoolFunc read FUnitSupplierChangesExist write FUnitSupplierChangesExist;
    property SaveUnitSupplierChanges: TNoArgsProc read FSaveUnitSupplierChanges write FSaveUnitSupplierChanges;

    property TagChangesExist: TBoolFunc read FTagChangesExist write FTagChangesExist ;
    property SaveTagChanges: TNoArgsProc read FSaveTagChanges write FSaveTagChanges;

    //Note: In the two function below Quantity is defined as a currency type not because it is a monetory value but
    // because the type is suitable. Currency is an "exact" data type with 4 decimal places.
    function GetPortionBudgetedCostPrice(ProductId: largeint; PortionTypeId: integer; Quantity: currency; EffectiveDate: string): currency;
    function GetUnitBudgetedCostPrice (ProductId: largeint; UnitName: string; Quantity: currency; EffectiveDate: string): currency;
    procedure ClearBudgetedCostPriceCacheTables;

    function GetCurrentBandAPrice(portionTypeId: integer): Variant;

    procedure LoadPortionRecipesForProduct(ProductId: double;  EffectiveDate: String; LoadPortionPrices: boolean);
    procedure LogProductChange(Text: string);
    function VarToInt(v: variant): integer;
    function SafeStrToInt(s: string): integer;

    // The current cost price mode for choices - see definition of TCostPriceMode.
    property costPriceModeForChoices: TCostPriceMode read GetCostPriceModeForChoices write SetCostPriceModeForChoices;
    procedure RefreshCostPriceModeForChoicesFromDB;

    property PortionPriceMode: TPortionPriceMode read FPortionPriceMode;
    property ConversationalOrderingMode: TConversationalOrderingMode read FConversationalOrderingMode;
    property ShowPortionPrices: boolean read FShowPortionPrices write SetShowPortionPrices;
    procedure SetMaxAllowedPortions(const value: integer);
    property MaxAllowedPortions: integer read FMaxAllowedPortions write SetMaxAllowedPortions;
    function GetMaxAllowedPortions: integer;
    function GetMaxPortionsInUse: integer;

    property ShowB2BName: boolean read GetShowB2BName write SetShowB2BName;


    //Total of the inclusive tax rates assigned to the current product
    property TotalInclusiveTax: double read GetTotalInclusiveTax;
    property OnTaxRulesChanged: TNotifyEvent read FTaxRulesChanged write FTaxRulesChanged; //This event fires if any of the four tax rule fields change.

    function ProductHasChoices: Boolean; //Returns true if the current product contains a choice
    function ProductHasBarcodeRanges: boolean; //Returns true if the current product has barcode ranges assigned to it.
    function ProductHasNegativeIngredientQuantities: boolean;
    function ProductHasPortionedIngredients: boolean;
    function ProductIsUsedAsIngredient: boolean;

    procedure RefreshLookup(LookupType: TStaticLookupType);
    function IsIngredientDefault(EntityCode : double) : boolean;
    function ContainsChoice(EntityCode : double; MinMaxChoiceOnly : Boolean = False) : boolean;
    function IngredientOfChoice(EntityCode : double; RestrictToImmediateParentOnly: Boolean = False; MinMaxChoiceOnly: boolean = False) : boolean;
    function IsMinMaxChoice(EntityCode : double) : boolean;
    procedure ResetPortionAttributes(curEntType, NewEntType: EntType);
    function validateChoiceSelections : boolean;
    function HasDefaultIngredientsInWorkingTempTable(EntityCode : String) : boolean;
    function HasDefaultIngredients(EntityCode : Double) : boolean;
    property CurrentEntityControlledByRM: Boolean read GetCurrentEntityControlledByRM;
    function RecipeModellingConnectionOK: Boolean;
    function GetPMAppLock: Boolean;
    function ReleasePMAppLock: Boolean;
    function IsUsedAsIngredient(EntityCode: double): boolean;
    function IsOpenPriced(EntityCode: double): boolean;
    function GetMaxDepth(EntityCode: double; var ParentEntityList: TStringList): integer;

    procedure DeleteAllButCurrentStandardPortion(); //Delete all portions except for the current Standard portion from the current product
    procedure DeleteAllPortions(); //Delete all portions from the current product
    procedure RemoveSelfIngredient();
    procedure AddSelfIngredient();
    procedure CreatePreparedItemPortionIfNecessary();
    procedure MoveCurrentIngredient(direction: TDirection);
    procedure RefreshPreparedItemIngredientDatasetsIfNecessary();

    function ProductInATicketSequence: boolean;
    procedure RemoveProductFromAllTicketSequences;
    function CurrentEntityCode: double;
    function CurrentEntityType: EntType;

    procedure GetPortionTypesInUse(var portionsTypes: TStringList);

    function GetPortionHierarchyFlags(EntityCode: double; PortionTypeID: integer; IngredientCode: double; IngredientPortionTypeID: variant; EffectiveDate: string): TADOQuery;

    procedure addProductToProductProperties(EntityCode : double);

    procedure clearProductProperties(currentId: String);
    procedure deleteProductProperties;

    procedure CloneClientPPTable (CloneDataSet : TClientDataSet; KeepSettings : boolean);
  end;

var
  ProductsDB: TProductsDB;


const
  RECIPE_MODELLING_SYSTEM_NAME = 'RecipeModelling';
  GIFT_CARD_NOTUSED = '<Not Set>';
  GIFT_CARD_LEGACY = '3rd Party Gift Card';
  GIFT_CARD_ZONALCLM = 'Zonal CLM';
  GIFT_CARD_CARDCOMMERCE = 'Card Commerce';
  MAX_RECIPE_DEPTH = 10;
  SHOW_PORTION_PRICES_CONFIG = 'ShowPortionPricesInProductModelling';
  SHOW_B2B_NAME_CONFIG = 'ShowB2BNameInProductModelling';
  MAX_NUMBER_OF_PORTIONS_CONFIG = 'MaxNumberOfProductPortions';

  DefaultPortionTypeID = 1; // This is the PortionTypeID for the 'Default' Portion Type in PortionTypes table
  DefaultPortionTypeName = 'Standard';
  // String values for Aztec Portion Calculation types
  UNITTYPE = 'Unit';
  PORTIONTYPE = 'Portion';
  FACTORTYPE = 'Factor';
  UNSPECIFIED_COURSE_LABEL = 'Unspecified';
  DEFAULT_MAX_NUMBER_OF_PORTIONS = 10;
  ABSOLUTE_MAX_NUMBER_OF_PORTIONS = 20;
  ABSOLUTE_MIN_NUMBER_OF_PORTIONS = 1;
  COST_PRICE_MODE_AVG = 'AVERAGE';
  COST_PRICE_MODE_MAX = 'MAXIMUM';
  COST_PRICE_MODE_MIN = 'MINIMUM';
  THREE_DIGIT_CUSTOM_PRICED_BARCODE_LENGTH = 3;
  STANDARD_PRICED_BARCODE_LENGTH = 7;
  PRICE_EMBEDDED_BARCODE_IDENTIFIER = '2';


  // Generally useful database utility functions.

  // Convert an entity type string (e.g. 'Menu')
  // into the corresponding Ent Type, e.g. etChoice
  function EntTypeStringToEnum( et: string ) : EntType;
  // Convert an EntType e.g. etChoice into the
  // corresponding entity type string (e.g. 'Menu') for storing in the Products table.
  function EntTypeEnumToString( et: EntType ) : string;
  // Convert an EntType e.g. etChoice into the
  // corresponding entity type string (e.g. 'Choice') for displaying to the user.
  function EntTypeEnumToDisplayString( et: EntType ) : string;
  function EntTypeEnumToFriendlyDisplayString( et: EntType ) : string;
  function EntTypeDescription( et: EntType ) : string;

  function CalcTypeEnumToString(calcType: TCalculationType): string;
  function CalcTypeStringToEnum(calcType: String): TCalculationType;

  function PortionPriceGridValueEnumToString(value: TPortionPriceGridValue): string;

  // Returns TRUE if a field is NULL or contains an empty string.
  function IsBlank( field: TField ) : boolean;

  // Make sure the current record in the dataset is posted.
  procedure PostRecord( dataset: TDataSet );

  // Returns TRUE if the value of a particular StringField is contained within the given string
  // list, false otherwise.  If the value of the field is '' or NULL, then the function will
  // return TRUE if allowBlank = TRUE or false otherwise.
  //
  // This function uses case-insensitive matching between the field value and the contents of
  // the string list.  If the field matches a string list entry, then the case of the field
  // value characters are 'corrected' to match the case of the string list entry.
  function FieldMatchesPickList( field: TStringField; strings: TStringList; allowBlank : boolean ) : boolean;

  function IsPricedBarcode(barcode: string): boolean;

implementation

uses uLineEdit, DateUtils, Dialogs, uSelectEntity, Math, uProgress,
     uADO, variants, uLog, uPortionIngredientDialog,
     StrUtils, uLocalisedText, uFutureDate, ADOint, uAztecDatabaseUtils,
  uEQATECMonitor, MidasLib;

type

  // Class representing information about a specific subcategory
  // This information derived from the Category and Subcategory tables.
  TSubcategoryInfo = class
  public
    // The division name for this subcategory.
    DivisionId: integer;
  end;

{$R *.dfm}

function IsPricedBarcode(barcode: string): boolean;
begin
  Result := (LeftStr(barcode, 1) = PRICE_EMBEDDED_BARCODE_IDENTIFIER);
end;

function BoolToBit(ABool: Boolean): Integer;
begin
  Result := 0;
  if ABool then Result := 1;
end;

{ TProductsDB }

procedure TProductsDB.DataModuleCreate(Sender: TObject);
begin
 IngnoreRecipeNoteChanges := FALSE;
 ClonedClientEntityDatasets := TObjectList.Create(false);
 ClonedClientEntityDatasets.Capacity := 2; //Only two datasets are cloned.
 FTotalInclusiveTax := -1;

 createTempTablesAndStoredProcs;
end;

procedure TProductsDB.DataModuleDestroy(Sender: TObject);
begin
 DeleteTempTablesandStoredProcs;
 ClonedClientEntityDatasets.Free;
end;

procedure TProductsDB.createTempTablesAndStoredProcs;
var i : integer;
begin
  //TODO (GDM): Include a UnitId in #TmpPortionCrosstab (will require a change to qLoadPortions as well) to make JOINs to the
  // ac_Unit table  more efficient when calculating cost prices.
  with ADOCommand do begin
    CommandText :=
      'IF object_id(''tempdb..#TmpPortionCrosstab'') IS NOT NULL DROP TABLE #TmpPortionCrosstab ' +
      'CREATE TABLE #TmpPortionCrosstab ( ' +
      '  EntityCode float, ' +
      '  Name varchar(100), ' +
      '  Description varchar(100), ' +
      '  Displayorder int, ' +
      '  IncludeByDefault bit, ';
      for i := 1 to ABSOLUTE_MAX_NUMBER_OF_PORTIONS do
        CommandText := CommandText +
        'Portionid' + IntToStr(i) + ' int, ' +
        'PortionIngredients_PortionTypeId' + IntToStr(i) + ' smallint, ' +
        'UnitName' + IntToStr(i) + ' varchar(10), ' +
        'Quantity' + IntToStr(i) + ' decimal (10,4), ' +
        'IsMinor' + IntToStr(i) + ' bit, '+
        'CalculationType' + IntToStr(i) + ' tinyint, ' +
        'CostPrice' + IntToStr(i) + ' money, ';
      CommandText := Commandtext +
        'PRIMARY KEY (EntityCode,DisplayOrder ASC)) ';

    CommandText := CommandText +
      'IF object_id(''tempdb..#TmpPortions'') IS NOT NULL DROP TABLE #TmpPortions ' +
      'CREATE TABLE #TmpPortions ( ' +
      '  Portionid int, ' +
      '  EntityCode float, ' +
      '  PortionTypeId int, ' +
      '  DisplayOrder int, ' +
      '  PortionName varchar(50), ' +
      '  CookTime datetime, ' +
      '  DefaultCookTime bit, ' +
      '  ContainerId int, ' +
      'PRIMARY KEY (DisplayOrder ASC)) ';


    CommandText := CommandText +
      'IF object_id(''tempdb..#TmpPortionChoices'') IS NOT NULL DROP TABLE #TmpPortionChoices ' +
      'CREATE TABLE #TmpPortionChoices ( ' +
      '  Portionid int, ' +
      '  EntityCode float, '+
      '  EnableChoices bit, '+
      '  MinChoice smallint, '+
      '  MaxChoice smallint, '+
      '  SuppChoice smallint, '+
      '  AllowPlain bit) ';

    CommandText := CommandText +
      'IF object_id(''tempdb..#TmpPricesCrosstab'') IS NOT NULL DROP TABLE #TmpPricesCrosstab ' +
      'CREATE TABLE #TmpPricesCrosstab ( ' +
      '  Type tinyint PRIMARY KEY, ' +
      '  Heading varchar(100) ';
      for i := 1 to ABSOLUTE_MAX_NUMBER_OF_PORTIONS do
        CommandText := CommandText + ',' +
        'DummyA' + IntToStr(i) + ' bit, ' +
        'DummyB' + IntToStr(i) + ' bit, ' +
        'Value' + IntToStr(i) + ' decimal (7,2), ' +
        'OldValue' + IntToStr(i) + ' decimal (7,2)';
    CommandText := CommandText + ') ';

    CommandText := CommandText +
      'IF object_id(''tempdb..#PortionBudgetedCosts'') IS NOT NULL DROP TABLE #PortionBudgetedCosts ' +
      'CREATE TABLE #PortionBudgetedCosts(ProductId bigint, PortionTypeId smallint, CostPrice money, PRIMARY KEY (ProductId, PortionTypeId)) ';

    CommandText := CommandText +
      'IF object_id(''tempdb..#UnitBudgetedCosts'') IS NOT NULL DROP TABLE #UnitBudgetedCosts ' +
      'CREATE TABLE #UnitBudgetedCosts(ProductId bigint, UnitType int, Amount decimal(26, 6), CostPrice money, PRIMARY KEY (ProductId)) ';

    CommandText := CommandText +
      'IF object_id(''tempdb..#tmpPurchaseUnits'') IS NOT NULL DROP TABLE #tmpPurchaseUnits ' +
      'CREATE TABLE #tmpPurchaseUnits (' +
        '[Entity Code] float,' +
        '[Supplier Name] varchar(20),' +
        '[Unit Name] varchar(10),' +
        'Flavour varchar(10) NOT NULL,' +
        '[Import/Export Reference] varchar(15),' +
        'Barcode varchar(20),' +
        '[Unit Cost] money,' +
        '[OriginalUnitCost] money,' +
        '[Default Flag] char(1),' +
        'EffectiveDate datetime,' +
        'UserID bigint) ';

    CommandText := CommandText +
      'IF object_id(''tempdb..#spGetPortionBudgetedCostPrice'') IS NOT NULL DROP PROCEDURE #spGetPortionBudgetedCostPrice ' +
      'IF object_id(''tempdb..#spGetUnitBudgetedCostPrice'') IS NOT NULL DROP PROCEDURE #spGetUnitBudgetedCostPrice ';

    Execute;

    CommandText :=
      'CREATE PROC #spGetPortionBudgetedCostPrice (@CostPrice money OUTPUT, @ProductId bigint, @PortionTypeId int, ' +
      '  @Quantity decimal(10,4), @EffectiveDate datetime = NULL) ' +
      'AS ' +
      'BEGIN ' +
      '  SET NOCOUNT ON ' +
      '  DECLARE @TodaysDate datetime ' +

      '  SET @CostPrice = NULL ' +
      '  SET @TodaysDate = GetDate() ' +

      '  SELECT @CostPrice = CostPrice ' +
      '  FROM #PortionBudgetedCosts ' +
      '  WHERE ProductId = @ProductId and PortionTypeId = @PortionTypeId ' +

      '  IF @CostPrice IS NULL ' +
      '  BEGIN ' +
      '    SET @CostPrice = ISNULL(cast(dbo.fnGetPortionBudgetedCostPrice(@ProductId, @PortionTypeID, @EffectiveDate, @TodaysDate) as money), 0) ' +

      '    INSERT #PortionBudgetedCosts (ProductId, PortionTypeId, CostPrice) VALUES (@ProductId, @PortionTypeId, @CostPrice) ' +
      '  END ' +

      '  SET @CostPrice = @CostPrice * @Quantity ' +
      'END';
    Execute;

    CommandText :=
      'CREATE PROC #spGetUnitBudgetedCostPrice (@CostPrice money OUTPUT, @ProductId bigint, @UnitName varchar(10), ' +
      '  @Quantity decimal(10,4), @EffectiveDate datetime) ' +
      'AS ' +
      'BEGIN ' +
      '  SET NOCOUNT ON ' +
      '  DECLARE @BaseUnitAmount decimal(26,6) ' +
      '  DECLARE @TodaysDate datetime ' +

      '  SET @CostPrice = NULL ' +
      '  SET @TodaysDate = GetDate() ' +

      '  IF NOT EXISTS (SELECT * FROM #UnitBudgetedCosts WHERE ProductId = @ProductId) ' +
      '  BEGIN ' +
      '    INSERT #UnitBudgetedCosts (ProductId, UnitType, Amount, CostPrice) ' +
      '    SELECT @ProductId, UnitType, Amount, CAST(CostPrice AS MONEY) ' +
      '    FROM dbo.fnGetUnitBudgetedCostPrice(@ProductId, @EffectiveDate, NULL, @TodaysDate) ' +
      '  END ' +

      '  SELECT @BaseUnitAmount = @Quantity * Amount ' +
      '  FROM ac_Unit ' +
      '  WHERE Name = @UnitName ' +

      '  SELECT @CostPrice = CONVERT(decimal(38,14), CostPrice * @BaseUnitAmount) / Amount ' +
      '  FROM #UnitBudgetedCosts ' +
      '  WHERE ProductId = @ProductId ' +
      '  SET @CostPrice = ISNULL(@CostPrice, 0) ' +
      'END ';

     Execute;
  end;
end;


function TProductsDB.GetPortionPriceMode: TPortionPriceMode;
begin
  with ADOQuery do
  try
    SQL.Text :=
     'SELECT ISNULL('+
       '(SELECT TOP 1 CASE WHEN isGP = ''Y'' THEN 0 ELSE 1 END ' +
        'FROM Threads a JOIN ac_ProductDivision b ON a.Division = b.Name ' +
        'WHERE b.Deleted = 0 AND ISNULL(a.SlaveTh, 0) >= 0 ' +
        'ORDER BY b.Id ASC), 0) AS PortionPriceMode';
    Open;
    Result := TPortionPriceMode(FieldByName('PortionPriceMode').AsInteger);
  finally
    Close;
  end;
end;

procedure TProductsDB.GetPortionTypesInUse(var portionsTypes: TStringList);
begin
  with ADOQuery do
  try
    SQL.Text := Format(
      'SELECT Id, Name FROM ac_PortionType ' +
      'WHERE (Id = %d ' +
         'OR Id IN ' +
           '(SELECT PortionTypeId FROM Portions ' +
            'WHERE EntityCode IN (SELECT EntityCode FROM Products WHERE ISNULL(Deleted, ''N'') = ''N'')) ' +
         'OR Id IN ' +
           '(SELECT PortionTypeId FROM #TmpPortions)) ' +
      'AND Deleted = 0 ' +
      'ORDER BY Name', [DefaultPortionTypeID]);
    Open;
    First;
    while not Eof do
    begin
      portionsTypes.AddObject(FieldByName('Name').AsString,  pointer(FieldByName('Id').AsInteger));
      Next;
    end;
  finally
    Close;
  end;
end;


function TProductsDB.GetConversationalOrderingMode: TConversationalOrderingMode;
begin
  with ADOQuery do
  try
    SQL.Text :=
     'SELECT CAST(ISNULL(EnableNestedConversationalOrdering, 0) AS INT) AS ConversationalOrderingMode  FROM ac_EstateProductSettings';
    Open;
    Result := TConversationalOrderingMode(FieldByName('ConversationalOrderingMode').AsInteger);
  finally
    Close;
  end;
end;

procedure TProductsDB.deleteTempTablesAndStoredProcs;
begin
  with ADOCommand do begin
    CommandText :=
      'IF object_id(''tempdb..#TmpPortionCrosstab'') IS NOT NULL DROP TABLE #TmpPortionCrosstab ' +
      'IF object_id(''tempdb..#TmpPricesCrosstab'') IS NOT NULL DROP TABLE #TmpPricesCrosstab ' +
      'IF object_id(''tempdb..#TmpPortions'') IS NOT NULL DROP TABLE #TmpPortions ' +
      'IF object_id(''tempdb..#PortionBudgetedCosts'') IS NOT NULL DROP TABLE #PortionBudgetedCosts ' +
      'IF object_id(''tempdb..#UnitBudgetedCosts'') IS NOT NULL DROP TABLE #UnitBudgetedCosts ' +
      'IF object_id(''tempdb..#spGetPortionBudgetedCostPrice'') IS NOT NULL DROP PROCEDURE #spGetPortionBudgetedCostPrice ' +
      'IF object_id(''tempdb..#spGetUnitBudgetedCostPrice'') IS NOT NULL DROP PROCEDURE #spGetUnitBudgetedCostPrice';
     Execute;
  end;
end;

procedure TProductsDB.LoadPortionRecipesForProduct(ProductId: double;  EffectiveDate: String; LoadPortionPrices: boolean);
begin
  //Load the portion recipes for the given product and date into the temporary table #TmpPortionCrosstab
  with qLoadPortions do
  begin
    Parameters.ParamByName('entitycode').value := ProductId;
    Parameters.ParamByName('effectivedate').value := EffectiveDate;
    ExecSQL;
  end;

  if LoadPortionPrices then
    with qLoadPortionPrices do
    begin
      Parameters.ParamByName('productId').Value := ProductId;
      Parameters.ParamByName('ppgvPortionPrice').Value := ord(ppgvPortionPrice);
      Parameters.ParamByName('ppgvGPAmount').Value := ord(ppgvGPAmount);
      Parameters.ParamByName('ppgvGPorCOSPercent').Value := ord(ppgvGPorCOSPercent);
      Parameters.ParamByName('portionPriceModeText').Value := ifthen(PortionPriceMode = ppmGP, 'Gross Profit %', 'Cost of Sales %');
      ExecSQL;
    end;

  FDateOfCostPriceCache := EffectiveDate;
end;

procedure TProductsDB.ClearBudgetedCostPriceCacheTables;
begin
  ADOCommand.CommandText := 'TRUNCATE TABLE #PortionBudgetedCosts  TRUNCATE TABLE #UnitBudgetedCosts';
  ADOCommand.Execute;
end;

//Notes:
// (a) Quantity is defined as a currency type not because it is a monetory value but because the type is suitable.
// Currency is an "exact" numeric type with 4 decimal places.
// (b) This function will not necessarily give the correct result for an EffectiveDate in the past. In this case it
//  will always return the current cost price.
function TProductsDB.GetPortionBudgetedCostPrice(ProductId: largeint; PortionTypeId: integer; Quantity: currency;
  EffectiveDate: string): currency;
begin
  //Clear the temp tables that cache cost price data if EffectiveDate is different from the date of the
  //cached data.
  if EffectiveDate <> FDateOfCostPriceCache then
  begin
    ClearBudgetedCostPriceCacheTables;
    FDateOfCostPriceCache := EffectiveDate;
  end;

  with ADOQuery do
  try
    SQL.Text :=
      'DECLARE @CostPrice money ' +
      'EXEC #spGetPortionBudgetedCostPrice ' +
         '@CostPrice OUTPUT, ' +
         '@ProductId = ' + IntToStr(ProductId) + ', ' +
         '@PortionTypeId = ' + IntToStr(PortionTypeId) + ', ' +
         '@Quantity = ' + FloatToStr(Quantity) + ', ' +
         '@EffectiveDate = ' + IfThen(EffectiveDate = CURRENT_ITEM, 'NULL', QuotedStr(EffectiveDate)) + ' ' +
      'SELECT @CostPrice AS CostPrice';
    Open;
    Result := FieldByName('CostPrice').Value;
  finally
    Close
  end;
end;


//Notes:
// (a) Quantity is defined as a currency type not because it is a monetory value but because the type is suitable.
// Currency is an "exact" numeric type with 4 decimal places.
// (b) This function will not necessarily give the correct result for an EffectiveDate in the past. In this case it
//  will always return the current cost price.
function TProductsDB.GetUnitBudgetedCostPrice (ProductId: largeint; UnitName: string; Quantity: currency; EffectiveDate: string): currency;
begin
  //Clear the temp tables that cache cost price data if EffectiveDate is different from the date of the
  //cached data.
  if EffectiveDate <> FDateOfCostPriceCache then
  begin
    ClearBudgetedCostPriceCacheTables;
    FDateOfCostPriceCache := EffectiveDate;
  end;

  if (ProductId = ClientEntityTableEntityCode.Value) then
  begin
    //We are calculating the cost price for the currently selected product and there may be unsaved supplier changes so we must
    //use in-memory data rather than database data.
    Result := RoundTo(ClientEntityTableBudgetedCostPrice.Value * Quantity *
                       (getBaseUnits(UnitName) / getBaseUnits(ClientEntityTablePurchaseUnit.AsString)), -4);
  end
  else
  begin
    with ADOQuery do
    try
      SQL.Text :=
        'DECLARE @CostPrice money ' +
        'EXEC #spGetUnitBudgetedCostPrice ' +
           '@CostPrice OUTPUT, ' +
           '@ProductId = ' + IntToStr(ProductId) + ', ' +
           '@UnitName = ' + QuotedStr(UnitName) + ', ' +
           '@Quantity = ' + FloatToStr(Quantity) + ', ' +
           '@EffectiveDate = ' + IfThen(EffectiveDate = CURRENT_ITEM, 'NULL', QuotedStr(EffectiveDate)) + ' ' +
        'SELECT @CostPrice AS CostPrice';
      Open;
      Result := FieldByName('CostPrice').Value;
    finally
      Close
    end;
  end;
end;


procedure TProductsDB.start;
begin
  // Progress during startup:
  // There is 1 stage to apply future product changes
  // There are 5 stages to creating the lookups
  // There is 1 stage to read the CostPrice mode
  // There is 1 stage to activating the linechange tables.
  // There is 1 stage creating Aztec portions & ingredients
  // There are 20 stages to reading the entity table.
  // There are 2 final stages
  // = 31 stages

  ProgressForm.progressStart( 32, nil, false );
  try
    // Abort if there is no Default Standard Portion Type
    Assert( StandardPortionTypeExists(dmADO.AztecConn), 'Data Error: There is no Default Portion Type - Aztec portions cannot be created.');

    // Abort if there is no Default Standard Portion Type
    Assert(PortionUnitExists, 'Data Error: Unit ''Portion'' does not exist in the Units table.');

    //Apply any future product changes
    ApplyFutureChanges;

    //Read various settings from the Aztec database.
    FcostPriceModeForChoices := cpmNone;
    FPortionPriceMode := GetPortionPriceMode;
    FShowPortionPrices := GetShowPortionPrices;
    FConversationalOrderingMode := GetConversationalOrderingMode;
    FMaxAllowedPortions := GetMaxAllowedPortions;

    // setup the unit lookups
    createLookups;

    createDefaultAztecPortionsAndIngredients;

    ProgressForm.progress( 'Preparing to display ' + ProductModellingTextName, 'Filling in default product data' );
    fillInDefaultProductData;

    LoadProductsDataFromDatabase('Preparing to display ' + ProductModellingTextName);

    // Figure out if there are any Aztec tills
    anyAztecTills := not dmADO.IsEmptyTable( 'AztecPOS' );
  finally
   ProgressForm.progressDone( false );
  end;
end;

procedure TProductsDB.SetCostPriceModeForChoices(const AValue: TCostPriceMode);
var costPriceModeStr: string;
begin
  if AValue = FcostPriceModeForChoices then
    Exit;

  case AValue of
    cpmNone   : costPriceModeStr := '';
    cpmAverage: costPriceModeStr := COST_PRICE_MODE_AVG;
    cpmMaximum: costPriceModeStr := COST_PRICE_MODE_MAX;
    cpmMinimum: costPriceModeStr := COST_PRICE_MODE_MIN;
  end;

  with ADOCommand do
  begin
    Commandtext := 'UPDATE Pconfigs SET CostPriceCalc = ' + QuotedStr(costPriceModeStr);
    Execute;
  end;

  FcostPriceModeForChoices := AValue;
end;

procedure TProductsDB.RefreshCostPriceModeForChoicesFromDb;
begin
  FcostPriceModeForChoices := cpmNone;
end;

function TProductsDB.GetCostPriceModeForChoices: TCostPriceMode;
var costPriceModeStr: string;
begin
  if FcostPriceModeForChoices = cpmNone then
  begin
    FcostPriceModeForChoices := cpmMaximum;

    with ADOQueryPConfigs do
    try
      SQL.Text := 'SELECT TOP 1 CostPriceCalc FROM Pconfigs';
      Open;
      if RecordCount = 0 then
      begin
        Log.Event('PConfig table is empty - cannot determine cost price calculation mode');
        raise Exception.Create( 'PConfig table is empty - cannot determine cost price calculation mode' );
      end;

      costPriceModeStr := FieldByName('CostPriceCalc').AsString;

      if costPriceModeStr = COST_PRICE_MODE_AVG then
        FcostPriceModeForChoices := cpmAverage
      else if costPriceModeStr = COST_PRICE_MODE_MAX then
        FcostPriceModeForChoices := cpmMaximum
      else if costPriceModeStr = COST_PRICE_MODE_MIN then
        FcostPriceModeForChoices := cpmMinimum
      else
      begin
        Log.Event('Invalid value for CostPriceCalc in Pconfigs : ' + costPriceModeStr);
        raise Exception.Create( 'Invalid value for CostPriceCalc in Pconfigs : ' + costPriceModeStr );
      end;

    finally
      Close;
    end;
  end;

  Result := FcostPriceModeForChoices;
end;

function TProductsDB.GetShowPortionPrices: boolean;
begin
  with ADOQuery do
  try
    SQL.Text :=
      'SELECT CASE WHEN StringValue = ''0'' THEN 0 ELSE 1 END AS Result ' +
      'FROM LocalConfiguration ' +
      'WHERE SiteCode = 0 ' +
      '  AND Deleted = 0 ' +
      '  AND KeyName = ' + QuotedStr(SHOW_PORTION_PRICES_CONFIG);
    Open;
    if IsEmpty then
      Result := False
    else
      Result := (FieldbyName('Result').AsInteger = 1);
  finally
    Close;
  end;
end;

function TProductsDB.GetMaxPortionsInUse: integer;
begin
  with ADOQuery do
  try
    SQL.Text :=
      'SELECT MAX(MaxDisplayOrder) as MaxDisplayOrder ' +
      'FROM ' +
      '( ' +
        'SELECT MAX(DisplayOrder) MaxDisplayOrder FROM Portions ' +
        'WHERE EntityCode IN (SELECT EntityCode FROM Products WHERE ISNULL(Deleted, ''N'') = ''N'') ' +
        'UNION ' +
        'SELECT MAX(DisplayOrder) as MaxDisplayOrder FROM PortionsFuture ' +
        'WHERE EntityCode IN (SELECT EntityCode FROM Products WHERE ISNULL(Deleted, ''N'') = ''N'') ' +
        'UNION ' +
        'SELECT MAX(DisplayOrder) as MaxDisplayOrder FROM #TmpPortions ' +
      ') x ';

    Open;
    if not(isEmpty) then
      Result := FieldByName('MaxDisplayOrder').AsInteger
    else
      Result := 1; // Must always at least have the Standard portion
  finally
    Close;
  end;
end;

function TProductsDB.GetMaxAllowedPortions: integer;
var
  configuredValue: integer;
begin
  configuredValue := DEFAULT_MAX_NUMBER_OF_PORTIONS;

  with ADOQuery do
  try
    SQL.Text :=
      'SELECT StringValue ' +
      'FROM LocalConfiguration ' +
      'WHERE SiteCode = 0 ' +
      '  AND Deleted = 0 ' +
      '  AND KeyName = ' + QuotedStr(MAX_NUMBER_OF_PORTIONS_CONFIG);
    Open;
    if not(IsEmpty) then
    begin
      configuredValue := SafeStrToInt(FieldbyName('StringValue').AsString);
      if configuredValue < ABSOLUTE_MIN_NUMBER_OF_PORTIONS then
        configuredValue := DEFAULT_MAX_NUMBER_OF_PORTIONS
      else if configuredValue > ABSOLUTE_MAX_NUMBER_OF_PORTIONS then
        configuredValue := ABSOLUTE_MAX_NUMBER_OF_PORTIONS;
    end;
  finally
    Close;
  end;

  Result := Max(configuredValue, GetMaxPortionsInUse);
end;

//TODO PM874: Create a SetLocalConfiguration method.
procedure TProductsDB.SetMaxAllowedPortions(const value: integer);
begin
  with ADOCommand do
  begin
    CommandText := Format(
      'IF EXISTS(SELECT * FROM LocalConfiguration WHERE SiteCode = 0 AND KeyName = ''%0:s'') ' +
      '  UPDATE LocalConfiguration SET StringValue = ''%1:s'' WHERE SiteCode = 0 AND KeyName = ''%0:s'' ' +
      'ELSE ' +
      '  INSERT LocalConfiguration(SiteCode, KeyName, StringValue) VALUES (0, ''%0:s'', ''%1:s'')',
      [MAX_NUMBER_OF_PORTIONS_CONFIG, IntToStr(value)]);
      Execute;
  end;

  FMaxAllowedPortions := value;
end;


procedure TProductsDB.SetShowPortionPrices(const value: boolean);
begin
  if Value = FShowPortionPrices then
    Exit;

  with ADOCommand do
  begin
    CommandText := Format(
      'IF EXISTS(SELECT * FROM LocalConfiguration WHERE SiteCode = 0 AND KeyName = ''%0:s'') ' +
      '  UPDATE LocalConfiguration SET StringValue = ''%1:s'' WHERE SiteCode = 0 AND KeyName = ''%0:s'' ' +
      'ELSE ' +
      '  INSERT LocalConfiguration(SiteCode, KeyName, StringValue) VALUES (0, ''%0:s'', ''%1:s'')',
      [SHOW_PORTION_PRICES_CONFIG, ifthen(value, '1', '0')]);
      Execute;
  end;
  FShowPortionPrices := Value;
end;

function TProductsDB.GetShowB2BName: boolean;
begin
  with ADOQuery do
  try
    SQL.Text :=
      'SELECT CASE WHEN StringValue = ''0'' THEN 0 ELSE 1 END AS Result ' +
      'FROM LocalConfiguration ' +
      'WHERE SiteCode = 0 ' +
      '  AND Deleted = 0 ' +
      '  AND KeyName = ' + QuotedStr(SHOW_B2B_NAME_CONFIG);
    Open;
    if IsEmpty then
      Result := False
    else
      Result := (FieldbyName('Result').AsInteger = 1);
  finally
    Close;
  end;
end;

procedure TProductsDB.SetShowB2BName(const Value: boolean);
begin
  if Value = GetShowB2BName then
    Exit;

  with ADOCommand do
  begin
    CommandText := Format(
      'IF EXISTS(SELECT * FROM LocalConfiguration WHERE SiteCode = 0 AND KeyName = ''%0:s'') ' +
      '  UPDATE LocalConfiguration SET StringValue = ''%1:s'' WHERE SiteCode = 0 AND KeyName = ''%0:s'' ' +
      'ELSE ' +
      '  INSERT LocalConfiguration(SiteCode, KeyName, StringValue) VALUES (0, ''%0:s'', ''%1:s'')',
      [SHOW_B2B_NAME_CONFIG, ifthen(Value, '1', '0')]);
      Execute;
  end;
end;

procedure TProductsDB.fillInDefaultProductData;
begin
  with dmADO.adocRun do begin

    // Ensure that user will not get hassled because the courseID is Null
    // Also, use this as an opportunity to setup a sensible
    CommandText :=
      'update Products '+
      'set [CourseID] = 1, '+
      '    [PrintStreamWhenChild] = 1 '+ // Use product pstream
      'where '+
      '[CourseID] is NULL and '+
      '[FollowCourseWhenChild] = 0 and '+
      '[Entity Type] in (''Strd.Line'',''Recipe'')';
    Execute;

    CommandText :=
      'update Products '+
      'set [FollowCourseWhenChild] = 1, '+
      '    [PrintStreamWhenChild] = 2 '+// Use parent pstream
      'where '+
      '[CourseID] is NULL and '+
      '[FollowCourseWhenChild] = 0 and '+
      '[Entity Type] = ''Instruct.''';
    Execute;
  end;
end;

procedure TProductsDB.createDefaultAztecPortionsAndIngredients;
begin
  ProgressForm.progress( 'Preparing to display ' + ProductModellingTextName,
                         'Creating Aztec Portions' );

  dmADO.BeginTransaction;
  try
    with dmADO.adocRun do begin
      CommandText :=

        { Make sure there is a Standard portion for every strd.line, recipe, menu and prepared item }

        'declare products_cur cursor local read_only static forward_only for '+
        '  select [entitycode] '+
        '  from products '+
        '  where '+
        '  [Deleted] IS NULL and '+
        '  [Entity Type] IN (''Strd.Line'', ''Recipe'', ''Menu'', ''Prep.Item'') and '+
        '  products.[entitycode] not in '+
        '  ( select [entitycode] from portions '+
        '    where [portiontypeid] = '+IntToStr(DefaultPortionTypeID)+' ) '+

        'declare @entcode float, @portionid int '+
        'OPEN products_cur '+
        'FETCH NEXT FROM products_cur INTO @entcode '+

        'WHILE @@FETCH_STATUS = 0 '+
        'BEGIN '+
        '  exec GetNextUniqueID '+
        '    @TableName = ''Portions'', '+
        '    @IdField = ''PortionID'', '+
        '    @RangeMin = 1, '+
        '    @RangeMax = 2147483647, '+
        '    @NextId = @portionid OUTPUT '+
        '  IF @portionid <> -1 '+
        '    insert into portions (portionid, entitycode, portiontypeid, displayorder) values '+
        '      (@portionid, @entcode, '+IntToStr(DefaultPortionTypeID)+', 1) '+
        '  FETCH NEXT FROM products_cur INTO @entcode '+
        'END '+

        'CLOSE products_cur '+
        'DEALLOCATE products_cur '+

        { Make sure there is 'self' ingredient for every strd.line }

        'insert into PortionIngredients (PortionID, IngredientCode, DisplayOrder) '+
        'select '+
        '  por.[PortionId], '+
        '  por.[EntityCode], '+
        '  1 '+
        'from '+
        '  Portions por '+
        'join '+
        '  Products prod on (por.[entitycode] = prod.[entitycode]) '+
        'where '+
        '  prod.[Entity Type] = ''Strd.Line'' and '+
        '  prod.[Deleted] IS NULL and '+
        '  not exists (select * from portioningredients ping '+
        '              where ping.portionid = por.portionid and '+
        '                    ping.ingredientcode = por.entitycode) '+
        '  and '+
        '  not exists (select * from portioningredients ping '+
        '              where ping.portionid = por.portionid and '+
        '                    ping.displayorder = 1 ) ';
      Execute;
    end;
    dmADO.CommitTransaction;
  finally
    if dmADO.InTransaction then
      dmADO.RollbackTransaction;
  end;
end;


procedure TProductsDB.LoadProductsDataFromDatabase(ProgressTitle : string);
var
  i: Integer;
  CurrentEntityCode : double;
  ClonedCurrentEntityCodes : array of double;
  BeforeScrollEvent: TDataSetNotifyEvent;
  AfterScrollEvent: TDataSetNotifyEvent;
  cloneDataset : TClientDataSet;

  {sub}procedure SetActivePropertyOfChildDatasets(const Active: boolean);
  begin
    RecipeNotesTable.Active := Active;
    ProductTaxTable.Active := Active;
    adotProductCostPrice.Active := Active;
    MultiPurchIngredientTable.Active := Active;
    PortionsQuery1.Active := Active;

    { Bug 327920: We must call EnableControls for the "master" datasets of IngredientsQueryX before opening
      these "detail" datasets. If not an exception occurs when these "detail" tables are opened because the
      code which handles the master-detail link tries to look up the current value in the "master" table's
      linking field and fails. This occurs in ADODB and looks to me like a bug in this Delphi unit. }
    if Active then
    begin
      PortionsQuery1.EnableControls;
    end;

    IngredientsQuery1.Active := Active;
    tblPreparedItemDetails.Active := Active;
  end;

begin
  // Progress:
  // There are 20 stages to reading the entity table.
  // There are 2 final stages
  // = 22 stages
  //  ProgressForm.progressStart( 31, nil, false );

  //Save currently selected product in the ClientEntityTable - for later restore
  if ClientEntityTable.Active and not(ClientEntityTableEntityCode.isNull) then
    CurrentEntityCode := ClientEntityTableEntityCode.Value
  else
    CurrentEntityCode := -1;

  //Save currently selected product in the clones of ClientEntityTable - for later restore
  setlength(ClonedCurrentEntityCodes, ClonedClientEntityDatasets.Count);
  for i := 0 to ClonedClientEntityDatasets.Count-1 do
  begin
    cloneDataset := TClientDataSet(ClonedClientEntityDatasets.Items[i]);
    if cloneDataset.Active and not(cloneDataset.FieldByName('EntityCode').isNull) then
      ClonedCurrentEntityCodes[i] := cloneDataset.FieldByName('EntityCode').Value
    else
      ClonedCurrentEntityCodes[i] := -1;

    cloneDataset.DisableControls;
  end;

  EntityTable.DisableControls;
  ClientEntityTable.DisableControls;
  RecipeNotesTable.DisableControls;

  PortionsQuery1.DisableControls;
  IngredientsQuery1.DisableControls;
  tblPreparedItemDetails.DisableControls;

  BeforeScrollEvent := ClientEntityTable.BeforeScroll;
  AfterScrollEvent := ClientEntityTable.AfterScroll;
  ClientEntityTable.BeforeScroll := nil;
  ClientEntityTable.AfterScroll := nil;

  try
    // Make sure all datasets are currently not active
    SetActivePropertyOfChildDatasets(FALSE);

    for i := 0 to ClonedClientEntityDatasets.Count-1 do
      TCLientDataSet(ClonedClientEntityDatasets.Items[i]).Active := FALSE;
    EntityTable.Active := FALSE;
    ClientEntityTable.Active := FALSE;

    // Must set this to empty string otherwise an error will occur when the dataset
    // is opened if IndexName had previously been set.
    ClientEntityTable.IndexName := '';

    
    // Create ADO entity dataset. Set a filter to select only products which can be edited -
    // This depends upon whether we are in Global or Site Only mode. This filter is used
    // purely to control which products will be loaded into the ClientEntityTable.
    ProgressForm.progress( ProgressTitle, 'Activating products table' );
    EntityTable.Active := TRUE;
    EntityTable.Filter := cached_entity_filter;
    EntityTable.Filtered := TRUE;

    ProductPropertiesTable.Active := TRUE;
    // Suck in all relevant entries from the entity table into the ClientEntityTable
    // TClientDataSet.  Do this in 20 chunks to allow sensible update of the progress bar.
    // Note: TcloneDataset is ONLY used to enable the 'search as you type' dialog to be fast
    // enough. I tried simply using the TADODataset (which also has it's own in memory cache) but
    // this proved too slow (10s compared to 0.1s to perform a table scan of all records).

    // ClientEntityTable.PacketRecords := Max(1, EntityTable.RecordCount div 20); commented by Ventsislav
    ClientEntityTable.PacketRecords := Max(10, EntityTable.RecordCount div 20);
    ClientPPTable.PacketRecords := Max(10, ProductPropertiesTable.RecordCount div 20);
    ProgressForm.progress( ProgressTitle, 'Caching products table' );
    ClientEntityTable.Active := TRUE;
    ClientPPTable.Active := TRUE;

    for i := 1 to 19 do begin
      ProgressForm.progress( ProgressTitle, 'Caching products table' );
      ClientEntityTable.GetNextPacket;
    end;

    try
      while ClientEntityTable.GetNextPacket <> 0 do ; // Make sure we have pulled in the entire table.
      while ClientPPTable.GetNextPacket <> 0 do ;
    except
    on E : Exception do
      Log.Event('Error in chunk loading of Products ' + E.Message);
    end;

    // We may, in exceptional circumstances, need to be able to see all entities in this table.
    EntityTable.Filtered := FALSE;

    ProgressForm.progress( ProgressTitle, 'Create product index' );

    // Create client entity table - ordered appropriately for the LineEdit dialog
    ClientEntityTable.AddIndex(
      'UserOrder', 'EntityTypeOrder; Sub-Category Name; Extended Rtl Name', [] );
    ClientEntityTable.IndexName := 'UserOrder';

    // Activate linked tables.
    ProgressForm.progress( ProgressTitle, 'Activate product subtables' );

    SetActivePropertyOfChildDatasets(TRUE);

    //Re-connect the clientdatasets which were cloned to ClientENtityTable.
    for i := 0 to ClonedClientEntityDatasets.Count-1 do
    begin
      cloneDataset := TClientDataSet(ClonedClientEntityDatasets.Items[i]);
      //Clone the dataset but keep the filter settings etc of the cloneDataset.
      CloneClientEntityTable(cloneDataset, true);

      //If cloneDataset is currently filtered must toggle the Filtered flag in
      //order for the filter to take effect - why I don't know!
      if cloneDataset.Filtered then
      begin
        cloneDataset.Filtered := FALSE;
        cloneDataset.Filtered := TRUE;
      end;
      cloneDataset.Active := TRUE;
    end;

  finally
    // Restore current product in ClientEntityTable.
    if CurrentEntityCode <> -1 then begin
      ClientEntityTable.Locate('EntityCode', CurrentEntityCode, []);
      ClientPPTable.Locate('EntityCode', CurrentEntityCode, []);
    end;

    // Restore current product in clones of ClientEntityTable.
    for i := 0 to ClonedClientEntityDatasets.Count-1 do
    begin
      if ClonedCurrentEntityCodes[i] <> -1 then
        TClientDataSet(ClonedClientEntityDatasets.Items[i]).Locate('EntityCode', ClonedCurrentEntityCodes[i], []);
      TClientDataSet(ClonedClientEntityDatasets.Items[i]).EnableControls;
    end;

    EntityTable.EnableControls;
    ClientEntityTable.EnableControls;
    RecipeNotesTable.EnableControls;
    PortionsQuery1.EnableControls;
    IngredientsQuery1.EnableControls;
    tblPreparedItemDetails.EnableControls;

    ClientEntityTable.BeforeScroll := BeforeScrollEvent;
    ClientEntityTable.AfterScroll := AfterScrollEvent;

    ProgressForm.progressDone( false );
  end;

end;

procedure TProductsDB.CloneClientEntityTable (CloneDataSet : TClientDataSet; KeepSettings : boolean);
begin
  // If filter is in effect, then only filtered rows appear in the clone, for
  // some reason.
  Assert( ClientEntityTable.filtered = false, 'ClientEntityTable must never be filtered' );
  CloneDataSet.CloneCursor( ClientEntityTable, false, KeepSettings );
  if (CloneDataSet.FindField( 'Entity Type' ) <> nil) and
     (not Assigned(CloneDataSet.FieldByName( 'Entity Type' ).OnGetText)) then
    CloneDataSet.FieldByName( 'Entity Type' ).OnGetText := ClientEntityTableEntityType.OnGetText;

  //Add CloneDataSet to the list of cloned datasets.
  if ClonedClientEntityDatasets.IndexOf(CloneDataSet) = -1 then
    ClonedClientEntityDatasets.Add(CloneDataSet);
end;

function CalcTypeEnumToString(calcType: TCalculationType): string;
begin
  case calcType of
    calcUnspecified: Result := '';
    calcUnit       : Result := UNITTYPE;
    calcPortion    : Result := PORTIONTYPE;
    calcFactor     : Result := FACTORTYPE;
  end;
end;

function CalcTypeStringToEnum(calcType: String): TCalculationType;
begin
  if calcType = UNITTYPE then Result := calcUnit
  else if calcType = PORTIONTYPE then Result := calcPortion
  else if calcType = FACTORTYPE then Result := calcFactor
  else Result := calcUnspecified;
end;

function EntTypeStringToEnum( et: string ) : EntType;
var
  i : EntType;
begin
  Result := etNone;
  for i := Low( EntType ) to High( EntType ) do
    if et = EntTypeEnumToString( i ) then begin
      Result := i;
      Break;
    end;
end;

function EntTypeEnumToString( et: EntType ) : string;
begin
  case et of
    etInstruct: Result := 'Instruct.';
    etChoice: Result := 'Menu';
    etPrepItem: Result := 'Prep.Item';
    etPurchLine: Result := 'Purch.Line';
    etRecipe: Result := 'Recipe';
    etStrdLine: Result := 'Strd.Line';
    etMultiPurch: Result := 'MultiPurch';
  else
    Result := '';
  end;
end;

function EntTypeEnumToDisplayString( et: EntType ) : string;
begin
  case et of
    etInstruct: Result := 'Instruct.';
    etChoice: Result := 'Choice';
    etPrepItem: Result := 'Prep.Item';
    etPurchLine: Result := 'Purch.Line';
    etRecipe: Result := 'Recipe';
    etStrdLine: Result := 'Strd.Line';
    etMultiPurch: Result := 'MultiPurch';
  else
    Result := '';
  end;
end;

function EntTypeEnumToFriendlyDisplayString( et: EntType ) : string;
begin
  case et of
    etInstruct: Result := 'instruction';
    etChoice: Result := 'choice';
    etPrepItem: Result := 'prepared item';
    etPurchLine: Result := 'purchase line';
    etRecipe: Result := 'recipe';
    etStrdLine: Result := 'standard line';
    etMultiPurch: Result := 'multipurch';
  else
    Result := '';
  end;
end;

function EntTypeDescription( et: EntType ) : string;
begin
  case et of
    etInstruct:  Result := 'Product preparation instruct';
    etChoice:    Result := 'List of product options';
    etPrepItem:  Result := 'As Recipe, not sold separately';
    etPurchLine: Result := 'Product ingredient not sold';
    etRecipe:    Result := 'Product made up on site';
    etStrdLine:  Result := 'Product bought in and sold';
    etMultiPurch:Result := 'Products purchased as group';
  else
    Result := '';
  end;
end;

function PortionPriceGridValueEnumToString(value: TPortionPriceGridValue): string;
begin
  case value of
    ppgvPortionPrice:   Result := 'Band A Price';
    ppgvGPAmount:       Result := 'Gross Profit';
    ppgvGPorCOSPercent: Result:= ifthen(ProductsDB.PortionPriceMode = ppmGP, 'Gross Profit %', 'Cost of Sales%');
  end;
end;

// Setup database for Global Lines
procedure TProductsDB.setGlobal;
begin
  current_level1 := 1;
  entity_level := 'Global';
  site_code := 0;
  level_title := 'Global';

  // Figure out filters to use for editable entities and selectable entities. Note that
  // even though the EntityTable dataset does not include Deleted products we still need
  // to filter deleted items with the editable_entity_filter and ingredient_entity_filter.
  // This is to handle products deleted during the current session.
  cached_entity_filter := '[EntityCode] < 19999999999';
  editable_entity_filter := '[EntityCode] < 19999999999 and NOT ([Deleted] = ''Y'')';
  ingredient_entity_filter := '[EntityCode] < 19999999999 and NOT ([Deleted] = ''Y'')';

  // Set up query for choosing the next entity code
  entitycodelow :=  10000000000;
  entitycodehigh := 19999999999;
end;

// Setup database for Site Lines
procedure TProductsDB.setSiteCode(siteCode: Integer; siteName: string);
begin
  current_level1 := 4;
  entity_level := 'Site';
  site_code := siteCode;
  level_title := 'Site ' + siteName;

  // Figure out filters to use for editable entities and selectable entities

 // Cached list includes all global and site lines.
  cached_entity_filter :=
    '([EntityCode] < 19999999999 OR ' +
     '([EntityCode] >= ' + IntToStr(40000000000 + siteCode*100000) +
     ' AND [EntityCode] <= ' + IntToStr(40000099999 + siteCode*100000) + ')' +
    ')';

  // Editable list does not include global lines.  Note that even though the EntityTable
  // dataset does not include Deleted products we still need to filter deleted items with
  // the editable_entity_filter and ingredient_entity_filter. This is to handle products
  // deleted during the current session.
  editable_entity_filter := '(NOT ([Deleted] = ''Y'') and ' +
    '([EntityCode] >= ' + IntToStr(40000000000 + siteCode*100000) +
    ' AND [EntityCode] <= ' + IntToStr(40000099999 + siteCode*100000) + '))';

  // lookup list DOES include global lines
  ingredient_entity_filter := '(NOT ([Deleted] = ''Y'') and ' +
    '([EntityCode] < 19999999999 OR ' +
     '([EntityCode] >= ' + IntToStr(40000000000 + siteCode*100000) +
     ' AND [EntityCode] <= ' + IntToStr(40000099999 + siteCode*100000) + ')' +
    '))';

  // Set up query for choosing the next entity code
  entitycodelow :=  40000000000 + siteCode*100000;
  entitycodehigh := 40000099999 + siteCode*100000;
end;


function TProductsDB.PortionUnitExists : boolean;
begin
  with ADOQuery do begin
    SQL.Text := 'SELECT COUNT(*) AS Count FROM Units WHERE [Unit Name] = ''Portion''';
    Open;
    try
      Result := FieldValues['Count'] > 0;
    finally
      Close;
    end;
  end;
end;

function TProductsDB.ProductExists(entityCode: double) : boolean;
begin
  with ADOQuery do begin
    SQL.Text := 'IF EXISTS(SELECT TOP 1 * FROM Products WHERE [EntityCode] = ' + FloatToStr(entityCode) + ') SELECT 1 ELSE SELECT 0';
    Open;
    try
      Result := Fields[0].AsInteger = 1;
    finally
      Close;
    end;
  end;
end;

function TProductsDB.ProductHasChoices: Boolean;
begin
  with adoqProductHasChoices do
  try
    Parameters.ParamByName('TargetEntityCode').Value := ClientEntityTableEntityCode.Value;
    Parameters.ParamByName('IntegrateTempTables').Value := ifthen(PortionChangesExist, 1, 0);
    Open;

    Result := FieldByName('HasChoices').AsBoolean;
  finally
    Close;
  end;
end;

function TProductsDB.ProductHasBarcodeRanges: boolean;
begin
  with ADOQuery do begin
    SQL.Text := Format(
      'IF EXISTS(SELECT TOP 1 * FROM ProductBarcodeRange WHERE EntityCode = %s) SELECT 1 ELSE SELECT 0',
      [FloatToStr(ClientEntityTableEntityCode.Value)]);
    Open;
    try
      Result := Fields[0].AsInteger = 1;
    finally
      Close;
    end;
  end;
end;

function TProductsDB.ProductHasNegativeIngredientQuantities: boolean;
begin
  with ADOQuery do
  try
    // Note: Having to make a call on a TFrame to check whether data has been loaded locally is bit crazy. Really
    // such data loading should be handled here. May require new eventhandlers here e.g. "OnPortionsDataLoaded"
    // which the TFrame can be hooked up to in order to do any of it's own UI related initialisation.
    // Generally we have far too much non-UI related code in our various TFrame classes. And I'm as much to blame as anyone
    // for this!  GDM 16/10/2015.
    if LineEditForm.NewPortionIngredientsFrame.IsInitialisedForCurrentProduct then
      SQL.Text := 'IF EXISTS(SELECT * FROM #TmpPortionCrosstab WHERE Quantity1 < 0) SELECT 1 ELSE SELECT 0'
    else
      SQL.Text := Format(
        'IF EXISTS(' +
        '  SELECT * FROM PortionIngredients ' +
        '  WHERE PortionID = (SELECT TOP 1 PortionID FROM Portions WHERE EntityCode = %0:f AND PortionTypeID = %1:d) ' +
        '    AND Quantity < 0) ' +
        '    SELECT 1 ' +
        '  ELSE ' +
        '    SELECT 0',
        [ClientEntityTableEntityCode.Value, DefaultPortionTypeID]);

    Open;
    Result := Fields[0].AsInteger = 1;
  finally
    Close;
  end;
end;

function TProductsDB.ProductHasPortionedIngredients: boolean;
begin
  with ADOQuery do
  try
    if LineEditForm.NewPortionIngredientsFrame.IsInitialisedForCurrentProduct then
      SQL.Text :=
        'IF EXISTS ( ' +
        '  SELECT * ' +
        '  FROM #TmpPortionCrosstab ' +
        '  WHERE CalculationType1 = ' + IntToStr(Ord(calcPortion)) +
        ' ) SELECT 1 ' +
        'ELSE SELECT 0'
    else
      SQL.Text := Format(
        'IF EXISTS ( ' +
        '  SELECT * ' +
        '  FROM Portions p ' +
        '  INNER JOIN PortionIngredients i ' +
        '  ON p.PortionID = i.PortionID ' +
        '  WHERE i.PortionTypeID is not null ' +
        '  AND p.EntityCode = %0:f ) ' +
        'SELECT 1 ' +
        'ELSE ' +
        'SELECT 0 ',
        [ClientEntityTableEntityCode.Value]);
    Open;
    result := Fields[0].AsInteger = 1;
  finally
    Close;
  end;
end;

function TProductsDB.ProductIsUsedAsIngredient: boolean;
begin
  result := IsUsedAsIngredient(ClientEntityTableEntityCode.Value);
end;

function TProductsDB.ProductInATicketSequence: boolean;
begin
  with ADOQuery do begin
    SQL.Text := Format(
      'IF EXISTS(SELECT TOP 1 * FROM ThemeCloakroomSequenceProductList WHERE ProductId = %s) SELECT 1 ELSE SELECT 0',
      [FloatToStr(ClientEntityTableEntityCode.Value)]);
    Open;
    try
      Result := Fields[0].AsInteger = 1;
    finally
      Close;
    end;
  end;
end;

procedure TProductsDB.RemoveProductFromAllTicketSequences;
begin
  with ADOCommand do
  begin
    CommandText := Format(
      'DELETE ThemeCloakroomSequenceProductList WHERE ProductId = %s',
      [FloatToStr(ClientEntityTableEntityCode.Value)]);
    Execute;
  end;
end;


// Create all the String lookup tables
procedure TProductsDB.createLookups;
var
  etype : EntType;
  Index: Integer;
  BaseTypeInfo: TBaseTypeInfo;
  UnitInfo: TUnitInfo;
  i : integer;
begin
  //
  // Unit lookups
  //
  validunitlist := TStringList.Create;
  allunitlist := TStringList.Create;
  AllUnitList.Sorted := TRUE;
  basetypelist := TStringList.Create;
  basetypelist.Sorted := TRUE;
  nulllist := TStringList.Create;
  portionlist := TStringList.Create;
  portionlist.Sorted := TRUE;
  printstreamlist := TStringList.Create;
  PrintStreamList.Sorted := TRUE;
  subcategorieslist := TStringList.Create;
  subcategorieslist.Sorted := TRUE;
  supplierlist := TStringList.Create;
  supplierlist.Sorted := TRUE;
  vatbandlist := TStringList.Create;
  VATBandList.Sorted := TRUE;
  childPrintModesList := TStringList.Create;
  GiftCardTypeList := TStringList.Create;
  GiftCardTypeNames := TStringList.Create;

  // Go through units table
  ProgressForm.progress( 'Preparing to display ' + ProductModellingTextName, 'Reading units table' );

  UnitsQuery.Active := TRUE;
  while not UnitsQuery.EOF do
  begin
    // find or create the TBaseTypeInfo instance for this base type
    if BaseTypeList.Find(UnitsQuery.FieldByName('Base Type').AsString, Index) then
      // TBaseTypeInfo for this type already exists
      BaseTypeInfo := TBaseTypeInfo(BaseTypeList.Objects[Index])
    else
    begin
      // TBaseTypeInfo must be created
      BaseTypeInfo := TBaseTypeInfo.Create;

      // Create a list of units which have this base type
      BaseTypeInfo.UnitsForBaseType := TStringList.Create;
      BaseTypeInfo.UnitsForBaseType.Sorted := TRUE;

      // Create a second list of units which have this base type, but also includes 'Portion'
      BaseTypeInfo.UnitsForBaseTypePlusPortion := TStringList.Create;
      BaseTypeInfo.UnitsForBaseTypePlusPortion.Sorted := TRUE;
      BaseTypeInfo.UnitsForBaseTypePlusportion.Add('Portion');
      BaseTypeInfo.UnitsForBaseTypePlusPortion.Duplicates := dupIgnore;

      // Add this to the list of base types
      BaseTypeList.AddObject(UnitsQuery.FieldByName('Base Type').AsString, BaseTypeInfo );
    end;

    // Create an instance of TUnitInfo to record information about this unit.
    UnitInfo := TUnitInfo.Create;
    UnitInfo.BaseTypeInfo := BaseTypeInfo;
    UnitInfo.BaseUnits := UnitsQuery.FieldByName('Base Units').AsFloat;

    //TODO: AllUnitList is identical to ValidUnitList. It does not contain deleted units which
    //seems to have been it's original intention. Should either include deleted units in this
    //list or remove the list altogether. (GDM 15/06/05)
    AllUnitList.AddObject(UnitsQuery.FieldByName('Unit Name').AsString, UnitInfo );

    BaseTypeInfo.UnitsForBaseType.Add(UnitsQuery.FieldByName('Unit Name').AsString);
    BaseTypeInfo.UnitsForBaseTypePlusPortion.Add(UnitsQuery.FieldByName('Unit Name').AsString);

    ValidUnitList.AddObject(UnitsQuery.FieldByName('Unit Name').AsString, UnitInfo);

    UnitsQuery.Next;
  end;
  UnitsQuery.Active := FALSE;
  // PortionsTable
  ProgressForm.progress( 'Preparing to display ' + ProductModellingTextName, 'Reading portions table' );
  refreshLookup(sltPortionTypes);

  // PrintStreamTable
  ProgressForm.progress( 'Preparing to display ' + ProductModellingTextName, 'Reading print stream table' );
  refreshLookup(sltPrintStream);

  // SubcategoryTable
  ProgressForm.progress( 'Preparing to display ' + ProductModellingTextName, 'Reading subcategory table' );
  refreshLookup(sltSubcategory);

  // SupplierTable
  ProgressForm.progress( 'Preparing to display ' + ProductModellingTextName, 'Reading supplier table' );
  refreshLookup(sltSupplier);

  // VatBandTable
  ProgressForm.progress( 'Preparing to display ' + ProductModellingTextName, 'Reading vatband table' );
  refreshLookup(sltVATBand);

  // Product types
  CreateProductTypesTable;
  ProductTypesTable.Active := TRUE;
  for eType := low(EntType) to high(EntType) do begin
    if eType <> etNone then
    begin
      ProductTypesTable.Insert;
      ProductTypesTable.FieldValues['ProductType'] := EntTypeEnumToString(eType);
      ProductTypesTable.FieldValues['DisplayProductType'] := EntTypeEnumToDisplayString(eType);
      ProductTypesTable.FieldValues['Description'] := EntTypeDescription(eType);
    end;
  end;

  { Following are the text values associated with the Products.PrintStreamWhenChild integer field }
  UseChildPrintStreamText := uLocalisedText.PrintStreamText + ' for this product';
  UseParentPrintStreamText := uLocalisedText.PrintStreamText + ' for parent product';
  UseBothPrintStreamText := 'both ' + uLocalisedText.PrintStreamText + 's';
  ChildPrintStreamModes[1] := UseChildPrintStreamText;
  ChildPrintStreamModes[2] := UseParentPrintStreamText;
  ChildPrintStreamModes[3] := UseBothPrintStreamText;

  for i := Low(ChildPrintStreamModes) to High(ChildPrintStreamModes) do
    childPrintModesList.Add( ChildPrintStreamModes[i] );

  refreshLookup(sltGiftCard);
end;

procedure TProductsDB.CreateProductTypesTable;
begin
  with ADOCommand do begin
     CommandText :=
       'CREATE TABLE #ProductTypes ('+
       '  [ProductType] [nvarchar] (10) collate database_default NULL, '+
       '  [DisplayProductType] [nvarchar] (10) collate database_default NULL, '+
       '  [Description] [nvarchar] (30) collate database_default NULL)';
     Execute;
  end;
end;

// Retrieve the unit info for the given unit name.
function TProductsDB.getUnitInfo( unit1: string ) : TUnitInfo;
var
  i: Integer;
begin
  // Unit name might have been deleted...
  if validunitlist.Find( unit1, i ) then
    getUnitInfo := TUnitInfo(validunitlist.Objects[i])
  else if allunitlist.Find( unit1, i ) then
    getUnitInfo := TUnitInfo(allunitlist.Objects[i])
  else
    getUnitInfo := nil;
end;

function TProductsDB.unitsHaveSameBaseType( unit1, unit2: string ) : boolean;
var
  i, j: TUnitInfo;
begin
  i := getUnitInfo( unit1 );
  j := getUnitInfo( unit2 );

  if Assigned(i) and Assigned(j) then begin

    // Found both units in the list - see if they share a base type
    unitsHaveSameBaseType := i.basetypeinfo = j.basetypeinfo;

  end else begin
    if not Assigned( i ) and not Assigned( j ) and AnsiSameText( unit1, unit2 ) then
      unitsHaveSameBaseType := TRUE // Same name = same units
    else
      unitsHaveSameBaseType := FALSE;
  end;
end;

// Get a list of units with the same base type - does NOT include deleted units.
function TProductsDB.getUnitsWithSameBaseType( unitname: string; includePortion: boolean ): TStringList;
var
  unitinfo: TUnitInfo;
begin
  unitinfo := getUnitInfo( unitname );
  if Assigned( unitinfo ) then begin

    if includePortion then
      getUnitsWithSameBaseType := unitinfo.basetypeinfo.unitsforbasetypeplusportion
    else
      getUnitsWithSameBaseType := unitinfo.basetypeinfo.unitsforbasetype;

  end else begin

    getUnitsWithSameBaseType := nulllist;

  end;
end;

// 0 = failure
function TProductsDB.getBaseUnits(unitname: string): Double;
var
  unitinfo: TUnitInfo;
begin
  unitinfo := getUnitInfo( unitname );

  if Assigned( unitinfo ) then
    getBaseUnits := unitinfo.baseunits
  else
    getBaseUnits := 0;
end;

function TProductsDB.ProductHasAztecPortions: boolean;
begin
  result := (EntTypeStringToEnum(ClientEntityTableEntityType.Value) in [etStrdLine, etRecipe, etChoice]);
end;

function TProductsDB.GetDivisionIdForSubcategory( subcat: string ) : string;
var
  Index : Integer;
begin
  if subcategorieslist.Find(subcat, Index) then
    result := IntToStr(TSubcategoryInfo(subcategorieslist.Objects[Index] ).DivisionId)
  else
    result := '';
end;

function TProductsDB.EntityTableLookup( entityCode: double ) : boolean;
begin
  // move cursor in EntityTable to the specified entityCode.

    if EntityTableEntityCode.Value = entityCode then begin
      Result := TRUE;
    end else begin
      Result := EntityTable.Locate('EntityCode', entityCode, []);
    end;

 //Note: Ideally would raise an exception here if the locate failed because it should
 // never fail. However if called from an event handler the exception appears just
 // to be swallowed. So clients of this function should really raise an exception.
end;

procedure TProductsDB.SetBudgetedCostPrice( costPrice: double );
begin
  // Set the budgeted cost price for the current product.
  if ClientEntityTableBudgetedCostPrice.IsNull or
     (ClientEntityTableBudgetedCostPrice.Value <> costPrice) then begin

    ClientEntityTable.Edit;
    ClientEntityTableBudgetedCostPrice.Value := costPrice;

  end;
end;

procedure TProductsDB.ClearBudgetedCostPrice;
begin
  // Clear the budgeted cost price for a record (if the cost is not already clear)
  if not ClientEntityTableBudgetedCostPrice.IsNull then begin

    ClientEntityTable.Edit;
    ClientEntityTableBudgetedCostPrice.Clear;

  end;
end;

//Convert all empty strings to null in the current record of the given dataset. This is
//necessary before saving the dataset to the SQL database otherwise a foreign key violation
//may result if the string field is a foreign key.
procedure TProductsDB.ConvertAllEmptyStringsToNull(DataSet : TDataSet);
var i : integer;
begin
  for i := 0 to DataSet.Fields.Count - 1 do begin
    if (DataSet.Fields[i].DataType = ftString) and (DataSet.Fields[i].Value = '') then begin
       If not(DataSet.State in [dsEdit, dsInsert]) then DataSet.Edit;
       DataSet.Fields[i].Value := Null;
    end;
  end;
end;

procedure TProductsDB.RefreshDataFromDatabase;
var
  oldEntityCode : double;
begin
  progressForm.progressStart(12, nil, false);
  try
    progressForm.progress('Reloading product data', '');

    PortionChangesExist := False;

    ClientEntityTable.CancelUpdates;
    PortionsQuery1.CancelBatch;
    IngredientsQuery1.CancelBatch;
    RecipeNotesTable.CancelBatch;
    ProductTaxTable.CancelBatch;
    MultiPurchIngredientTable.CancelBatch;
    tblPreparedItemDetails.CancelBatch;
    adotProductCostPrice.CancelBatch;

    if ClientEntityTable.EOF and ClientEntityTable.BOF then
      oldEntityCode := 0.0
    else
      oldEntityCode := ClientEntityTableEntityCode.Value;

    progressForm.progress('Reloading product data', '');
    EntityTable.Requery;

    progressForm.progress('Reloading product data', '');
    ClientEntityTable.DisableControls;
    try
      // This is very slow, but the full dataset must be refreshed.
      ClientEntityTable.PacketRecords := -1;
      ClientEntityTable.Refresh;
    finally
      ClientEntityTable.EnableControls;
    end;

    progressForm.progress('Reloading product data', '');
    PortionsQuery1.Requery;

    progressForm.progress('Reloading product data', '');
    IngredientsQuery1.Requery;

    progressForm.progress('Reloading product data', '');
    RecipeNotesTable.Requery;

    progressForm.progress('Reloading product data', '');
    ProductTaxTable.Requery;

    progressForm.progress('Reloading product data', '');
    MultiPurchIngredientTable.Requery;

    progressForm.progress('Reloading product data', '');
    tblPreparedItemDetails.Requery;

    progressForm.progress('Reloading product data', '');
    adotProductCostPrice.Requery;

    ClientEntityTable.locate( 'EntityCode', oldEntityCode, [] );
    LineEditForm.redisplayCurrentRecord;
  finally
    ProgressForm.progressDone( false );
  end;
end;

function TProductsDB.AreThereTableChangesToSave : boolean;

  function dirtyTable( table : TCustomADODataSet ) : boolean;
  begin
    if not table.active then
      Result := false
    else if table.state in [dsEdit, dsInsert] then
      Result := true
    else if dmADO.ADOUpdatesPending( table ) then
      Result := true
    else
      Result := FALSE;
  end;

begin
  Result :=
    (ClientEntityTable.state in [dsEdit,dsInsert]) or
    (ClientEntityTable.ChangeCount > 0) or
    dirtyTable(PortionsQuery1) or
    dirtyTable(IngredientsQuery1) or
    dirtyTable(RecipeNotesTable) or
    dirtyTable(MultiPurchIngredientTable) or
    dirtyTable(ProductTaxTable) or
    dirtyTable(tblPreparedItemDetails) or
    dirtyTable(qEditPortionChoices) or
    dirtyTable(adotProductCostPrice) or
    PortionChangesExist or
    (Assigned(FPortionPriceChangesExist) and FPortionPriceChangesExist) or
    (Assigned(FUnitSupplierChangesExist) and FUnitSupplierChangesExist) or
    (Assigned(FTagChangesExist) and FTagChangesExist);
end;


//Post changes to all datasets and then save to the database. The beforePost events
//of each dataset perform data verification and call Abort if there's anything amiss.
//Therefore only if all the posts are successful will any of the data changes actually
//be written to the database.
procedure TProductsDB.SaveAllTableChanges;
const
  //If an attempt is made to save changes to a product or any of its detail tables then
  //the exception raised has a message which starts with...
  //GDM 02/10/2010 - Removed the key violation messages from this list as I don't believe a multi-user
  //scenario can ever cause key violations. Have left the array checking code just in case we want to
  //add some other errors in the future - though is a bit overkill for one message!
  ChangedByOtherUserText: array[0..0] of string = (
    'Row cannot be located for updating'
  );

  function errorMessageIsInList( msg: string; const list: array of string): boolean;
  var
    i : Integer;
  begin
    Result := FALSE;
    for i := Low( list ) to High( list ) do
      if Copy( msg, 0, Length( list[i] ) ) = list[i] then
        Result := TRUE;
  end;

begin
  (*
  if (ClientPPTable.ChangeCount > 0) then begin
    ClientPPTable.ApplyUpdates(0);
    Log.Event('ProductProps applied to DB');
  end;
  *)
  // Avoid doing slow transaction & batch updates if nothing has actually changed.
  if AreThereTableChangesToSave then begin

    if qEditPortionChoices.Active and (EntTypeStringToEnum( ClientEntityTableEntityType.Value ) = etChoice) and not skipValidatePortion then
       begin
         if validateChoiceSelections then
            Abort;
       end;

    Log.Event('Saving changes to '''+ ClientEntityTableExtendedRTLName.Value + ''' (' +ClientEntityTableEntityCode.AsString +')');

    // If this routine is ever used to save more than 1 product at a time the following routine call
    // will have to be changed to loop through all changed records not just the current one.
    ConvertAllEmptyStringsToNull(ClientEntityTable);

    PostRecord( qEditPortionChoices );

    // Cancel blank unit supplier entries
    if (UnitSupplierTable.state = dsInsert) and
        UnitSupplierTableSupplierName.IsNull and
        UnitSupplierTableUnitName.IsNull and
        UnitSupplierTableFlavour.IsNull then
      UnitSupplierTable.Cancel;
    PostRecord( UnitSupplierTable );

    // If changes have been made to the entity, we must force the list entity
    // table into edit mode to force the invokation of the BeforePost handler...
    // the validation in the handler must be invoked even if the client entity table
    // itself has not been modified (e.g. to check that recipe apportions add up to
    // 100%).
    if not (ClientEntityTable.state in [dsEdit,dsInsert]) and
       not (ClientEntityTable.BOF and ClientEntityTable.EOF) then
      ClientEntityTable.Edit;

    // If entity type is Strd.Line, Recipe or Instruct then ensure that if the print stream mode is null
    // then it is set to the default value 1 (UseChildPrintStreamText).  If the entity type is anything
    // else then set print stream mode to null
    SetChildPrintStreamMode;

    // If entity type is Purch.Line and Strd.Lines then it may be used as a minor ingredient in other
    // products. If EntityType is being changed from a valid parent/ child combination for minor
    // ingredients to an invalid one then the ingredients should be set to major on save.
    SetIsMinorValues;

    FpostingClientEntityTable := TRUE;
    try
      PostRecord( ClientEntityTable );
    finally
      FpostingClientEntityTable := FALSE;
    end;

    PostRecord( PortionsQuery1 );
    PostRecord( IngredientsQuery1 );

    PostRecord( RecipeNotesTable );

    if not ProductTaxRulesValid then
      Abort
    else
      PostRecord( ProductTaxTable );

    PostRecord( MultiPurchIngredientTable );
    PostRecord( tblPreparedItemDetails );
    PostRecord( adotProductCostPrice );

    //Log certain changes to the ClientEntityTable
    if ClientEntityTable.ChangeCount > 0 then
    begin
      if ClientEntityTableExtendedRTLName.OldValue <> ClientEntityTableExtendedRTLName.NewValue then
        LogProductChange('Retail Name changed from "' + VarToStr(ClientEntityTableExtendedRTLName.OldValue) + '" to "' +
          VarToStr(ClientEntityTableExtendedRTLName.NewValue) + '"');

      if ClientEntityTableSubCategoryName.OldValue <> ClientEntityTableSubCategoryName.NewValue then
        LogProductChange('Subcategory changed from "' + VarToStr(ClientEntityTableSubCategoryName.OldValue) + '" to "' +
          VarToStr(ClientEntityTableSubCategoryName.NewValue) + '"');

      if ClientEntityTableEntityType.OldValue <> ClientEntityTableEntityType.NewValue then
        LogProductChange('Product Type changed from "' + VarToStr(ClientEntityTableEntityType.OldValue) + '" to "' +
          VarToStr(ClientEntityTableEntityType.NewValue) + '"');

      if ClientEntityTableDefaultSupplier.OldValue <> ClientEntityTableDefaultSupplier.NewValue then
        LogProductChange('Default Supplier changed from "' + VarToStr(ClientEntityTableDefaultSupplier.OldValue) + '" to "' +
          VarToStr(ClientEntityTableDefaultSupplier.NewValue) + '"');
    end;

    // None of the validation checks have failed so now save all changes to the database
    dmADO.BeginTransaction;
    try try
      LogProductChange(format('New LMDT: %s. Previous LMDT: %s', [VarToStr(ClientEntityTableLMDT.NewValue), VarToStr(ClientEntityTableLMDT.OldValue)]));
      if (ClientEntityTable.ChangeCount > 0) then ClientEntityTable.ApplyUpdates( 0 );

      //Cases have been reported where a new product has failed to be saved to the Products table and yet no error
      //was logged. This check has been added to catch these "silent failures".
      if not(ProductExists(ClientEntityTableEntityCode.AsFloat)) then
        raise Exception.Create('Failed to save new product for unknown reason');

      RecipeNotesTable.UpdateBatch(arAllChapters);
      ProductTaxTable.UpdateBatch(arAllChapters);
      MultiPurchIngredientTable.UpdateBatch(arAllChapters);
      tblPreparedItemDetails.UpdateBatch(arAllChapters);
      adotProductCostPrice.UpdateBatch(arAllChapters);

      // the Master Portions Queriefs have to be disconnected from the Child Ingredients
      // queries because the PortionQuery.UpdateBatch causes the IngredientsQuery to
      // be reselected from the database if they are still connected and the pending changes
      // of the Ingredients Query are lost before calling IngredientsQuery.UpdateBatch.
      PortionsQuery1.DisableControls;

      PortionsQuery1.UpdateBatch(arAllChapters);

      IngredientsQuery1.UpdateBatch(arAllChapters);

      SavePendingPortionChanges;

      SavePendingPortionPriceChanges;

      SavePendingUnitSupplierChanges;

      SavePendingTagChanges;

      dmADO.CommitTransaction;
    except

      on e: Exception do
        begin
          Log.Event('Failed to save changes to '''+ ClientEntityTableExtendedRTLName.Value + '''');
          EQATECMonitor.EQATECAppException(Application.Title, e);
          dmADO.RollbackTransaction;    // if an error occurs make sure that nothing is saved

          //It is a bit dodgy using the exception message to determine the type of exception raised just
          //in case the message text changes in the next release of ADO. However I can't see any other way
          //because the exception is of type EOleException which could be any number of things.
          if errorMessageIsInList( E.Message, ChangedByOtherUserText ) then
          begin
            Log.Event('Suspected clash with another user. Error: ' + E.ClassName + ' ' + E.Message);
            ShowMessage('Failed to save changes to '''+ ClientEntityTableExtendedRTLName.Value + ''' because another user has changed it'#13#10+
                        'since you opened ' + ProductModellingTextName + '.'#13#10#13#10+
                        'Your changes to this product have been undone and the other users changes'#13#10 +
                        'will now be made visible to you. Unfortunately you will have to re-make '#13#10 +
                        'your changes (for this product only).');
            LogClientEntityTableUpdateConflicts;
            LogUpdateConflicts(RecipeNotesTable);
            LogUpdateConflicts(ProductTaxTable);
            LogUpdateConflicts(MultiPurchIngredientTable);
            LogUpdateConflicts(tblPreparedItemDetails);
            LogUpdateConflicts(PortionsQuery1);
            LogUpdateConflicts(IngredientsQuery1);

            RefreshDataFromDatabase;
          end else
          begin
            Log.Event('Unexpected Error: (' + E.ClassName + ') ' + E.Message);
            ShowMessage('Failed to save changes to ' + ClientEntityTableExtendedRTLName.Value + ' due to an unexpected error.'#13#10 +
                        'Your changes have been undone.'#13#10#13#10 +
                        'Details: (' + E.ClassName + ') ' + E.Message);
            RefreshDataFromDatabase;
          end;

          Abort;
        end;
    end;

    finally
      if dmADO.InTransaction then dmADO.RollbackTransaction;
      PortionsQuery1.EnableControls;
    end;
  end;
end;

procedure TProductsDB.LogProductChange(Text: string);
begin
  Log.Event(ClientEntityTableExtendedRTLName.AsString + ' (' + ClientEntityTableEntityCode.AsString + '): ' + Text);
end;


// Determine the original purchase unit for the current product in the ClientEntityTable.

procedure TProductsDB.LogClientEntityTableUpdateConflicts;
var
  i: integer;
  CurrProduct: TADODataSet;
begin
  if ClientEntityTable.ChangeCount = 0 then
    Exit; //All changes were saved so no conflict has occured.

  Log.Event('Conflict occured saving changes in the ClientEntityTable dataset (Products table) to the database. Details below:');
  Log.Event('Notes:(1) ORIGINAL=Value initially read from DB, DB NOW = Value currently in DB, NEW=Value currently set in Product Modelling');
  Log.Event('      (2) Only conflicting fields (where ORIGINAL is different from DB NOW) are listed');

  currProduct := TADODataSet.Create(nil);
  try try
    currProduct.Connection := dmADO.AztecConn;
    currProduct.CommandText := 'SELECT * FROM Products WHERE EntityCode = ' + ClientEntityTableEntityCode.AsString;
    currproduct.Open;

    with ClientEntityTable do
      for i := 0 to Fields.Count-1 do
        if (Fields[i].FieldKind = fkData) and
           (Fields[i].OldValue <> currProduct.FieldByName(Fields[i].FieldName).CurValue) then
          Log.Event('  [' + Fields[i].FieldName + ']' +
            ' ORIGINAL: "'+ VarToStr(Fields[i].OldValue) + '"' +
            ' DB NOW: "'  + VarToStr(currProduct.FieldByName(Fields[i].FieldName).CurValue) + '"' +
            ' NEW: "'    + VarToStr(Fields[i].NewValue) + '"');

    currproduct.Close;
  except
    on e: Exception do
      Log.Event('Error in LogClientEntityTableUpdateConflicts: ' + E.ClassName + ' ' + E.Message);
  end;
  finally
    currProduct.Free;
  end;
end;


procedure TProductsDB.LogUpdateConflicts (d: TCustomADODataset);
var
  i, row: integer;
  DBText: string;
  clone: TADODataset;
begin
  clone := TADODataset.Create(nil);

  try try
    clone.Clone(d);
    //Note: Tried using the fgConflictingRecords filter but could not get it to work with a cloned dataset.
    //This worked Ok applied to the original dataset but then the records in all datasets that are the "detail" in a
    //master-detail relationship became out of synch with the master record.
    clone.FilterGroup := fgPendingRecords;
    clone.Filtered := True;
    if not(clone.Eof and clone.Bof) then
    begin
      //This is necessary to refresh the CurValue property of all the TField components with the
      //current values in the database.
      clone.Recordset.Resync(adAffectGroup, adResyncUnderlyingValues);

      if d is TADOTable then
        DBText :=  'Table: ' + TADOTable(d).TableName
      else if d is TADODataset then
        DBText :=  'SQL: ' + TADODataset(d).CommandText;

      Log.Event('Unsaved changes in the ' + d.Name + ' dataset ('+ DBText + ') listed below.');
      Log.Event('Notes:(1) ORIGINAL=Value initially read from DB, DB NOW= Value currently in DB, NEW=Value currently set in Product Modelling');
      Log.Event('      (2) Fields where ORIGINAL is different from DB NOW are marked with the word CONFLICT! These caused the failure to save');
      row := 0;
      clone.First;
      while not(clone.Eof) do
      begin
        log.Event('Unsaved row ' + IntToStr(row));
        for i := 0 to clone.Fields.Count-1 do
        begin
          if clone.Fields[i].FieldKind = fkData then
          begin

            //Note: The two variants compared in the ifthen statement are converted to strings using VarToStr before
            //comparison. This is to get around the Delphi ADO problems when dealing with the SQL decimal type. If not
            //converted to strings comparing TField.OldValue with TField.CurValue gives a variant conversion exception
            //with message "Unknown type: 14" if the underlying SQL type is a decimal.
            Log.Event('  [' + clone.Fields[i].FieldName + ']' +
              ' ORIGINAL: "'+ VarToStr(clone.Fields[i].OldValue) + '"' +
              ' DB NOW: "'  + VarToStr(clone.Fields[i].CurValue) + '"' +
              ' NEW: "'    + VarToStr(clone.Fields[i].NewValue) + '"' +
              ifthen(VarToStr(clone.Fields[i].OldValue) <> VarToStr(clone.Fields[i].CurValue), '   CONFLICT! ORIGINAL differs from DB NOW', ''));
         end;
        end;

        clone.Next;
        row := row + 1;
      end;
    end;
  except
    on e: Exception do
      Log.Event('Error in LogUpdateConflicts: ' + E.ClassName + ' ' + E.Message);
  end;
  finally
    clone.Free;
  end;
end;

// Determine the original purchase unit for the current product in the ClientEntityTable.
function TProductsDB.OriginalBaseUnit: string;
begin
  if ProductNewlyInsertedAndNotSaved then
    Result := ''
  else if (ClientEntityTable.State = dsEdit) then begin
    Result := VarToStr(ClientEntityTablePurchaseUnit.OldValue);
  end else
    Result := ClientEntityTablePurchaseUnit.Value;
end;

function TProductsDB.AllowBaseUnitChange: boolean;
begin
  // Products created today or which currently have no base unit can have the base units changed. If a product currently
  // has no base unit it must have just been changed from a product type that doesn't have a base unit (e.g. a Recipe), to
  // one that does (e.g. standard line or purchase product)
  if ProductNewlyInsertedAndNotSaved then
    Result := true
  else if OriginalBaseUnit = '' then
    Result := true
  else if DateOf( ClientEntityTableCreationDate.Value ) = Date then
    Result := true
  else
    Result := FALSE;
end;

// Returns TRUE if the specified field is null or a blank string.
function IsBlank( field: TField ) : boolean;
begin
  if field.IsNull then
    IsBlank := true
  else
    IsBlank := Length( Trim( field.AsString ) ) = 0;
end;

// Make sure the current record in the dataset is posted.
procedure PostRecord( dataset: TDataSet );
begin
  with dataset do begin
    if (state = dsInsert) or (state = dsEdit) then
      Post;
  end;
end;


// Returns TRUE if the valid of a particular StringField is contained within the given string
// list, false otherwise.  If the value of the field is '' or NULL, then the function will
// return TRUE if allowBlank = TRUE or false otherwise.
//
// This function uses case-insensitive matching between the field value and the contents of
// the string list.  If the field matches a string list entry, then the case of the field
// value characters are 'corrected' to match the case of the string list entry.
function FieldMatchesPickList( field: TStringField; strings: TStringList; allowBlank: boolean ) : boolean;
var
  i: Integer;
begin
  if IsBlank( field ) then begin
    FieldMatchesPickList := allowBlank;
  end else begin
    if strings.Find( field.Value, i) then begin
      // String is in list

      // If dataset is editing, fix the case of the string.
      if field.DataSet.State in [dsInsert,dsEdit] then begin
        if field.Value <> strings[i] then
          field.Value := strings[i];
      end;

      FieldMatchesPickList := TRUE;
    end else begin
      // String is not in list
      FieldMatchesPickList := FALSE;
    end;
  end;
end;

// Fill in default values for a new entity.
procedure TProductsDB.clientEntityTableDefaultFill(et : EntType);
begin
  if ClientEntityTableRollupPriceWhenChild.IsNull then
    ClientEntityTableRollupPriceWhenChild.Value := FALSE;
  if ClientEntityTableFollowCourseWhenChild.IsNull then
    ClientEntityTableFollowCourseWhenChild.Value := (et = etInstruct);
  if ClientEntityTableTrueHalfAllowed.IsNull then
    ClientEntityTableTrueHalfAllowed.Value := FALSE;

  if et in [etRecipe, etStrdLine] then begin
    if ClientEntityTableWhetherOpenPriced.Value = '' then
      ClientEntityTableWhetherOpenPriced.Value := 'F';
    if ClientEntityTableWhetherSalesTaxable.Value = '' then
      ClientEntityTableWhetherSalesTaxable.Value := 'Y';
  end;
  if et in [etRecipe, etStrdLine, etInstruct] then
  begin
    if VarIsNull(ClientEntityTablePrintStreamWhenChild.Value) or
       (ClientEntityTablePrintStreamWhenChild.Value = 0) then
    begin
      ClientEntityTablePrintStreamWhenChild.Value := 1;
    end;
  end;
end;

// Get the next available entity code for the current session.
function TProductsDB.GetNextEntCode: double;
begin
  // The parameters for the GetNextProductID stored proc were filled in when the session
  // was started.
  Log.Event('GetNextUniqueID');
  with ADOStoredProc do begin
     ProcedureName := 'GetNextUniqueID';
     Parameters.Refresh;
     Parameters.ParamByName('@TableName').Value := 'Products';
     Parameters.ParamByName('@IdField').Value := 'EntityCode';
     Parameters.ParamByName('@RangeMin').Value := EntityCodeLow;
     Parameters.ParamByName('@RangeMax').Value := EntityCodeHigh;
     Parameters.ParamByName('@NextID').Value := -1;
     ExecProc;

     Result := Parameters.ParamByName('@NextID').Value;

     if Result = -1 then
     begin
       Log.Event('Stored proc GetNextProductID failed with unknown error');
       raise Exception.Create('Stored proc GetNextProductID failed with unknown error');
     end;
  end;
end;

function TProductsDB.GetNextPortionID: integer;
var
  maxPortionID: Integer;
begin
  //2,147,483,647 is the maximum value of an integer data type in SQL Server
  maxPortionID := 2147483647;

  with ADOStoredProc do
  begin
     ProcedureName := 'GetNextUniqueID';
     Parameters.Refresh;
     Parameters.ParamByName('@TableName').Value := 'Portions';
     Parameters.ParamByName('@IdField').Value := 'PortionID';
     Parameters.ParamByName('@RangeMin').Value := 1;
     Parameters.ParamByName('@RangeMax').Value := maxPortionID;
     Parameters.ParamByName('@NextID').Value := -1;
     ExecProc;

     Result := Parameters.ParamByName('@NextID').Value;

     if Result = -1 then
     begin
       Log.Event('Stored proc GetNextPortionID failed with unknown error');
       raise Exception.Create('Stored proc GetNextPortionID failed with unknown error');
     end;
  end;
end;


// The budgeted cost price field is displayed with 4 digits of precision, not 2.
procedure TProductsDB.ClientProductsTableBudgetedCostPriceGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  Text := FloatToStrF( TFloatField(Sender).Value, ffCurrency, 15, 4 );
end;


function ArrayToStr(A : array of string) : string;
//Returns a string containing the list of strings in the array comma separated
//and quoted.
var i : integer;
begin
  Result := QuotedStr(A[low(A)]);
  for i := low(A) + 1 to high(A) do Result := Result + ', ' + QuotedStr(A[i]);;
end;


// Post the current ClientEntityTable record without calling any before/after post event handlers.
// Also leaves the record in a state where it still has unposted changes.
procedure TProductsDB.ClientEntityTableInvisiblePost;
var
  BeforePost, AfterPost: TDataSetNotifyEvent;
begin
  BeforePost := ProductsDB.ClientEntityTable.BeforePost;
  Afterpost := ProductsDB.ClientEntityTable.AfterPost;
  try
    ProductsDB.ClientEntityTable.BeforePost := nil; //Disable normal before/afterPost processing
    ProductsDB.ClientEntityTable.AfterPost := nil;
    productsDB.ClientEntityTable.Post;
    productsDB.ClientEntityTable.Edit; // leave record in a "unposted" changes state
  finally
    ClientEntityTable.BeforePost := BeforePost;
    ClientEntityTable.AfterPost := AfterPost;
  end;
end;

function TProductsDB.ProductNewlyInsertedAndNotSaved : boolean;
begin
 // If the current product in the ClientEntityTable does not yet exist in the
  // EntityTable dataset then it has not yet been saved. It still only exists in
  // the ClientEntityTable's delta.
    Result := (ClientEntityTable.State = dsInsert) OR
              not ProductsDB.EntityTableLookup(ClientEntityTableEntityCode.Value);
end;

//-----------------------------------------------
//           Event Handlers
//-----------------------------------------------

// Called before posting to the client entity table.  Ensures that ProductChangeLog is updated
// correctly, and also that addition actions required on post are performed.
procedure TProductsDB.ClientEntityTableBeforePost(DataSet: TDataSet);
begin
  // These fields are updated on every modification.
  ClientEntityTableLMDT.Value := now;
  Log.Event(format('Setting LMDT to: %s', [DateTimeToStr(ClientEntityTableLMDT.Value)]));
  ClientEntityTableModifiedBy.Value := logonName;

  if EntTypeStringToEnum( ClientEntityTableEntityType.Value ) in [etMultiPurch] then
    Exit; // Prizm doesn't know anything about MultiPurch items

  if ProductNewlyInsertedAndNotSaved then
    // New product
    ClientEntityTableCreationDate.Value := ClientEntityTableLMDT.Value;
end;

// Compute the 'EntityTypeOrder' column, used to ensure that the ClientEntityTable is
// correctly ordered when displayed in the LineEdit dialog.
procedure TProductsDB.ClientEntityTableCalcFields(DataSet: TDataSet);
var
  val: LongInt;
begin
  if DataSet.State = dsInternalCalc then begin
    // ordering is as follows:
    //
    // Item             Value of EntityTypeOrder
    // Global Lines:
    //   Strd.Line      1
    //   Recipe         2
    //   Purch.Line.    3
    //   Prep.Item      4
    //   MultiPurch     5
    //   Choice         6
    //   Instruct.      7
    // Site Lines:
    //   Same order     11 - 17
    case EntTypeStringToEnum( ClientEntityTableEntityType.Value ) of
      etStrdLine: val := 1;
      etRecipe: val := 2;
      etPurchLine: val := 3;
      etPrepItem: val := 4;
      etMultiPurch: val := 5;
      etChoice: val := 6;
      etInstruct: val := 7;
    else
      val := 0;
    end;

    if ClientEntityTableEntityCode.Value > 19999999999 then
      val := val + 10;

    ClientEntityTableEntityTypeOrder.Value := val;
  end;
end;


// The LastModifiedDate & Time must be updated on the RecipeNotes table whenever it is posted.
procedure TProductsDB.RecipeNotesTableBeforePost(DataSet: TDataSet);
var
  noteModifyTime: TDateTime;
begin
  noteModifyTime := Now;
  RecipeNotesTableLMDT.Value := noteModifyTime;
  RecipeNotesTableOriginalLMD.Value := noteModifyTime;
  RecipeNotesTableOriginalLMT.Value := FormatDateTime('hh:nn:ss', noteModifyTime);
end;

procedure TProductsDB.EntityTableProviderUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
  // Abort the update and re-raise the exception so that it can be caught and handled by
  // SaveAllTableChanges. Note if this event handler is omitted no exception is generated.
  Response := rrAbort;
  raise E;
end;

procedure TProductsDB.AddNewUnit(UName, BaseType: string; UnitSize: real);
var
  Index: Integer;
  BaseTypeInfo: TBaseTypeInfo;
  UnitInfo: TUnitInfo;
begin
  // find or create the TBaseTypeInfo instance for this base type
  if BaseTypeList.Find(BaseType, Index) then
    // TBaseTypeInfo for this type already exists
    BaseTypeInfo := TBaseTypeInfo(BaseTypeList.Objects[Index])
  else
  begin
    // TBaseTypeInfo must be created
    BaseTypeInfo := TBaseTypeInfo.Create;

    // Create a list of units which have this base type
    BaseTypeInfo.UnitsForBaseType := TStringList.Create;

    // Create a second list of units which have this base type, but also includes 'Portion'
    BaseTypeInfo.UnitsForBaseTypePlusPortion := TStringList.Create;
    BaseTypeInfo.UnitsForBaseTypePlusportion.Add('Portion');
    BaseTypeInfo.UnitsForBaseTypePlusPortion.Duplicates := dupIgnore;

    // Add this to the list of base types
    BaseTypeList.AddObject(BaseType, BaseTypeInfo );
  end;

  // Create an instance of TUnitInfo to record information about this unit.
  UnitInfo := TUnitInfo.Create;
  UnitInfo.BaseTypeInfo := BaseTypeInfo;
  UnitInfo.BaseUnits := UnitSize;

  AllUnitList.Sorted := TRUE;
  AllUnitList.AddObject(UName, UnitInfo );

  BaseTypeInfo.unitsforbasetype.Sorted := TRUE;
  BaseTypeInfo.UnitsForBaseType.Add(UName);

  BaseTypeInfo.UnitsForBaseTypePlusPortion.Sorted := TRUE;
  BaseTypeInfo.UnitsForBaseTypePlusPortion.Add(UName);

  ValidUnitList.Sorted := TRUE;
  ValidUnitList.AddObject(UName, UnitInfo );
end;

procedure TProductsDB.AddPortionType(PortionTypeName: string);
begin
  PortionList.Add(PortionTypeName);
end;

procedure TProductsDB.AddPrinterStream(StreamName: string);
begin
  PrintStreamList.Add(StreamName);
end;

procedure TProductsDB.AddSubCateg(subCat: string; divisionId: integer);
var
  subCatInfo: TSubCategoryInfo;
begin

  subCatInfo := TSubCategoryInfo.Create;
  subCatInfo.DivisionId := divisionId;

  subCategoriesList.AddObject(subCat, subCatInfo);
end;

procedure TProductsDB.AddVATBand(BandName: string; Index: integer);
var
  VATBandInfo: TVATBandInfo;
begin
  VATBandInfo := TVATBandInfo.Create;
  VATBandInfo.VATIndex := Index;

  VATBandList.AddObject(BandName, VATBandInfo);
end;

procedure TProductsDB.IngredientsQueryCalcFields(DataSet: TDataSet);
begin
  //Only prepared items use the IngredientsQuery1 dataset now.
  if EntTypeStringToEnum(ClientEntityTableEntityType.Value) <> etPrepItem then
    Exit;

  if not DataSet.FieldByName('IngredientCode').IsNull then begin
    if DataSet.FieldByName('IngredientCode').AsFloat = ClientEntityTableEntityCode.Value then
    begin
      DataSet.FieldByName('IngredientName').Value := ClientEntityTableExtendedRTLName.Value;
      DataSet.FieldByName('IngredientDescription').Value := ClientEntityTableRetailDescription.Value
    end
    else
    begin
      if ProductsDB.EntityTableLookup(DataSet.FieldByName('IngredientCode').AsFloat) then
      begin
        DataSet.FieldByName('IngredientName').Value := EntityTableExtendedRTLName.Value;
        DataSet.FieldByName('IngredientDescription').Value := EntityTableRetailDescription.Value;
      end
      else
      begin
        DataSet.FieldByName('IngredientName').Value := '';
        DataSet.FieldByName('IngredientDescription').Value := '';
      end;
    end;
  end;

  if not DataSet.FieldByName('CalculationType').IsNull then begin
    with DataSet do begin
      case FieldByName('CalculationType').AsInteger of
        ord(calcUnit):
          begin
            FieldByName('UnitDisplayName').Value := FieldByName('UnitName').Value;
            FieldByName('Cost').Value :=
                GetUnitBudgetedCostPrice(
                    StrToInt64(FieldByName('IngredientCode').AsString),
                    FieldByName('UnitName').AsString,
                    FieldByName('Quantity').AsCurrency, CURRENT_ITEM);
          end;

        ord(calcPortion):
          begin
            if FieldByName('PortionTypeID').IsNull then Exit;
            if not PortionTypeTable.Active then PortionTypeTable.Active := TRUE;
            FieldByName('UnitDisplayName').Value :=
                PortionTypeTable.Lookup('PortionTypeID', FieldByName('PortionTypeID').Value, 'PortionTypeName');
            FieldByName('Cost').Value :=
                GetPortionBudgetedCostPrice(
                    StrToInt64(FieldByName('IngredientCode').AsString),
                    FieldByName('PortionTypeID').AsInteger,
                    FieldByName('Quantity').AsCurrency,
                    CURRENT_ITEM);
          end;

        ord(calcFactor):
          FieldByName('UnitDisplayName').AsString := 'Factor';

        else
          FieldByName('UnitDisplayName').AsString := '';
      end;
    end;
  end;
end;

procedure TProductsDB.RecipeNotesTableRecipeNotesChange(Sender: TField);
begin
  if IngnoreRecipeNoteChanges = False then
  begin
     with Sender as TField do
     begin
        // Set flag to inform us to ingore the changes (as we are making them)
        IngnoreRecipeNoteChanges := TRUE;
        try
           asstring := stringreplace(asstring, #13#10, #10, [rfReplaceall]);
        finally
           // We've made our changes, no longer ignore any further changes.
           IngnoreRecipeNoteChanges := FALSE;
        end; // try
     end; //with Sender as TField
  end; // if IngnoreRecipeNoteChanges
end;

procedure TProductsDB.ProductTaxDSUpdateData(Sender: TObject);
begin
  // If all tax rules are null, we don't want to create a row
  // in the tax rule table.
  if (ProductTaxTable.state = dsInsert) and
      ProductTaxTableTaxRule1.IsNull and
      ProductTaxTableTaxRule2.IsNull and
      ProductTaxTableTaxRule3.IsNull and
      ProductTaxTableTaxRule4.IsNull then
    ProductTaxTable.Cancel;
end;

function TProductsDb.GetTotalInclusiveTax: double;
var TaxIds: string;
begin
  if FTotalInclusiveTax = -1 then
  begin
    TaxIds := '';

    if not ProductTaxTableTaxRule1.IsNull then
      TaxIds := TaxIds + ',' + ProductTaxTableTaxRule1.AsString;

    if not ProductTaxTableTaxRule2.IsNull then
      TaxIds := TaxIds + ',' + ProductTaxTableTaxRule2.AsString;

    if not ProductTaxTableTaxRule3.IsNull then
      TaxIds := TaxIds + ',' + ProductTaxTableTaxRule3.AsString;

    if not ProductTaxTableTaxRule4.IsNull then
      TaxIds := TaxIds + ',' + ProductTaxTableTaxRule4.AsString;

    if TaxIds <> '' then
    begin
      TaxIds := Copy(TaxIds, 2, length(TaxIds) -1);

      with TADODataset.Create(nil) do
      try
        Connection := dmADO.AztecConn;
        CommandType := cmdText;
        CommandText :=
          'SELECT SUM(b.Rate) AS TotalInclusiveTax ' +
          'FROM ac_TaxRule a INNER JOIN ac_TaxRate b ON a.TaxRateId = b.Id ' +
          'WHERE a.Deleted = 0 AND a.Exclusive = 0 AND a.Id IN (' + TaxIds + ')';
        Open;
        FTotalInclusiveTax := FieldByName('TotalInclusiveTax').AsFloat;
      finally
        Free;
      end;
    end;
  end;

  Result := FTotalInclusiveTax;
end;

function TProductsDB.WillADOPostCauseKeyViol( dataset: TCustomADODataSet; keyCols: array of string )
  : boolean;
var
  Clone : TADODataSet;
  keyColStr : string;
  keyColVals : Variant;
  i : Integer;
begin
  Result := FALSE;
  if dataset.Active then
  begin
    // build a string of the index columns
    keyColStr := keyCols[0];
    for i := 1 to High(keyCols) do
      keyColStr := keyColStr + ';' + keyCols[i];

    // build a variant array of key column values
    keyColVals := VarArrayCreate( [Low(keyCols),High(keyCols)], varVariant );
    for i := Low(keyCols) to High(keyCols) do
//      keyColVals[i] := dataset.Fields[i].AsVariant;    //Checks sequentially
//Above replaced with below by AK for PM335.
      keyColVals[i] := dataset.FieldValues[keycols[i]]; //Checks by column name(any sequence)

    Clone := TADODataSet.Create(nil);
    try
      Clone.Clone(dataset);
      if Clone.Locate( keyColStr, keyColVals, [] ) then begin
        if Dataset.State = dsInsert then
          Result := TRUE // New rows aren't visible in clone - definitely a key viol
        else
          // Only a key viol if this isn't the posted row
          Result := (dataset.Bookmark <> Clone.Bookmark);
      end;
      Clone.Close;
    finally
      Clone.Free;
    end;
  end;
end;

procedure TProductsDB.MultiPurchIngredientTableCalcFields(
  DataSet: TDataSet);
begin
  if not MultiPurchIngredientTableIngredientCode.IsNull then begin
    if MultiPurchIngredientTableIngredientCode.AsFloat = ClientEntityTableEntityCode.Value then begin
      MultiPurchIngredientTableIngredientName.Value := ClientEntityTableExtendedRTLName.Value;
      MultiPurchIngredientTableIngredientDescr.Value := ClientEntityTableRetailDescription.Value;
    end else begin
      if ProductsDB.EntityTableLookup(MultiPurchIngredientTableIngredientCode.AsFloat) then begin
        MultiPurchIngredientTableIngredientName.Value := EntityTableExtendedRTLName.Value;
        MultiPurchIngredientTableIngredientDescr.Value := EntityTableRetailDescription.Value;
      end else begin
        MultiPurchIngredientTableIngredientName.Value := '';
        MultiPurchIngredientTableIngredientDescr.Value := '';
      end;
    end;
  end;
end;

procedure TProductsDB.RemoveEntityFromThemeModel(entityCode: Double);
begin
  with spDeleteEntityFromTheme do
  begin
    Parameters.ParamByName('ProductID').Value := entityCode;
    ExecProc;
  end;
end;

function TProductsDB.shouldHideBaseDataAddOptions: boolean;
begin
  Result := FALSE;
  with dmADO.adoqRun do begin
    SQL.Text :=
      'select [VarName] from [GenerVar] where '+
      '[VarName] = ''PmHideBbAd'' and '+
      '[VarInt] <> 0 ';
    Open;
    try
      if not EOF then
        Result := TRUE;
    finally
      Close;
    end;
  end;
end;

procedure TProductsDB.ClientEntityTableEntityTypeGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  // Replace 'Menu' with 'Choice'
  if DisplayText then
    Text := EntTypeEnumToDisplayString( EntTypeStringToEnum( Sender.AsString ) )
  else
    Text := Sender.AsString;
end;

procedure TProductsDB.ClientEntityTablePrintStreamWhenChildGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if (Sender.AsInteger >= Low(ChildPrintStreamModes)) and
     (Sender.AsInteger <= High(ChildPrintStreamModes)) then
    // A valid option has been selected
    Text := ChildPrintStreamModes[Sender.AsInteger]
  else if ClientEntityTableEntityType.Value = EntTypeEnumToString(etInstruct) then
    // Default for an instruct is to use the parent print stream.
    Text := UseParentPrintStreamText
  else
    // Default for other types is to use their own print stream.
    Text := UseChildPrintStreamText;
end;

procedure TProductsDB.ClientEntityTablePrintStreamWhenChildSetText(
  Sender: TField; const Text: String);
var
  index : Integer;
begin
  index := AnsiIndexText(Text, ChildPrintStreamModes);

  if index = -1 then
    Sender.Clear
  else
    Sender.AsInteger := index + Low(ChildPrintStreamModes);
end;

function TProductsDB.isMasterField( ds : TDataSet; f : TField ) : boolean;
var
  fname, masterfields : string;
begin
  if ds is TADODataSet then
    masterfields := TADODataSet( ds ).MasterFields
  else if ds is TADOTable then
    masterfields := TADOTable( ds ).MasterFields
  else if ds is TClientDataSet then
    masterfields := TClientDataSet( ds ).MasterFields;

  fname := f.FieldName;
  Result := AnsiSameText( fname, masterfields ) or
    AnsiSameText( LeftStr( masterfields, Length( fname ) + 1 ), fname + ';' ) or
    AnsiSameText( RightStr( masterfields, Length( fname ) + 1 ), ';' + fname ) or
    AnsiContainsText( masterfields, ';'+fname+';' );
end;

procedure TProductsDB.storeRowValues( var rowValues : variant; ds : TDataSet );
var
  i : Integer;
begin
  rowValues := VarArrayCreate( [0, ds.FieldCount-1], varVariant );

  for i := VarArrayLowBound( rowValues,1 ) to VarArrayHighBound( rowValues,1 ) do
  begin
    if isMasterField( ds, ds.Fields.Fields[i] ) then
      rowValues[i] := Null
    else
      rowValues[i] := ds.Fields.Fields[i].Value;
  end;
end;

procedure TProductsDB.restoreRowValues( rowValues : variant; ds : TDataSet );
var
  i : Integer;
begin
  for i := VarArrayLowBound( rowValues,1 ) to VarArrayHighBound( rowValues,1 ) do
  begin
    if not VarIsNull(rowValues[i]) then
      ds.Fields.Fields[i].Value := rowValues[i];
  end;
end;

procedure TProductsDB.storeRows( var rows : variant; ds : TDataSet );
var
  recCount : Integer;
  i : Integer;
  values : Variant;
begin
  ds.First;
  recCount := 0;
  while not ds.EOF do begin
    Inc( recCount );
    ds.Next;
  end;

  rows := VarArrayCreate( [0, recCount-1], varVariant );
  ds.First;
  for i := 0 to recCount-1 do begin
    storeRowValues( values, ds );
    rows[i] := values;
    ds.Next;
    if ds.EOF then Break;
  end;
end;

procedure TProductsDB.restoreRows( rows : variant; ds : TDataSet );
var
  i : Integer;
begin
  for i := VarArrayLowBound( rows,1 ) to VarArrayHighBound( rows,1 ) do
  begin
    ds.Insert;
    restoreRowValues( rows[i], ds );
    ds.Post;
  end;
end;

procedure TProductsDB.cancelDatasetChanges( ds : TDataSet );
begin
  if not ds.Active then Exit;

  ds.Cancel;
  if ds is TADODataSet then
    TADODataSet(ds).CancelBatch
  else if ds is TADOTable then
    TADOTable(ds).CancelBatch
  else if ds is TClientDataSet then
    TClientDataSet(ds).CancelUpdates;
end;

function TProductsDB.ValidateBarCode(const theBarCodeToValidate: string; isCustomBarcode: boolean): boolean; // job 326084
begin
  Result := FALSE;

    if length(theBarCodeToValidate) = 0 then
  begin
    showmessage('INVALID Barcode cannot be blank');
    Exit;
  end;

  if isCustomBarcode then // Custom priced barcode
  begin
    if (NOT IsPricedBarcode(theBarCodeToValidate)) OR (length(theBarCodeToValidate) <> THREE_DIGIT_CUSTOM_PRICED_BARCODE_LENGTH) then
    begin
      showmessage('INVALID custom priced barcode. Must start with ''2'' and be a 3 digit number');
      Exit;
    end
  end
  else if IsPricedBarcode(theBarCodeToValidate) then // job 335125
  begin
    if (length(theBarCodeToValidate) < STANDARD_PRICED_BARCODE_LENGTH) then
    begin
      showmessage('INVALID Priced barcode length (less than 7 characters)');
      Exit;
    end;
  end
  else
  begin
    if (length(theBarCodeToValidate) < 8) then
    begin
      showmessage('INVALID Barcode length (less than 8 characters)');
      Exit;
    end;
  end;

  if (length(theBarCodeToValidate) > 13) then
  begin
    showmessage('INVALID Barcode length (more than 13 characters)');
    Exit;
  end;

  try
    // the statement below calls to function StrToInt64 in order to test the string
    // theBarCodeToValidate. If the string is not made up of digits only then the function
    // will fail and the INVALID message will appear.
    // The return from the function is not required so it is not read into any variable.
    StrToInt64(theBarCodeToValidate);
    Result := TRUE;
  except
    showmessage('INVALID Barcode character(s) (only digits are allowed)!');
    Exit;
  end;

  Result := TRUE;
end;

//Return the name of the unit which a prepared item batch size is measured in.
function TProductsDB.GetAztecPreparedItemBatchUnit(EntityCode : Double) : string;
begin
  Result := '';

  with ADOQuery do begin
    SQL.Text :=
     'SELECT BatchUnit FROM PreparedItemDetail ' +
     'WHERE EntityCode = :EntityCode';
    Parameters.ParamByName('EntityCode').Value := EntityCode;
    Open;
    try
      if RecordCount > 0 then
        Result := FieldByName('BatchUnit').AsString;
    finally
      Close;
    end;
  end;
end;

{ If the Storage Unit changes in the prepared item dataset then set the Count Unit to the
  same value, but only if it is null }
procedure TProductsDB.tblPreparedItemDetailsStorageUnitChange(Sender: TField);
begin
  if (tblPreparedItemDetailsStorageUnit.AsString <> '') and
     (tblPreparedItemDetailsBatchUnit.AsString = '') then
    tblPreparedItemDetailsBatchUnit.AsString := tblPreparedItemDetailsStorageUnit.AsString;
end;

{ If the Count Unit changes in the prepared item dataset then set the Storage Unit to the
  same value, but only if it is null }
procedure TProductsDB.tblPreparedItemDetailsBatchUnitChange(Sender: TField);
begin
  if (tblPreparedItemDetailsBatchUnit.AsString <> '') and
     (tblPreparedItemDetailsStorageUnit.AsString = '') then
    tblPreparedItemDetailsStorageUnit.AsString := tblPreparedItemDetailsBatchUnit.AsString;
end;

procedure TProductsDB.ApplyFutureChanges;
begin
  ProgressForm.progress('Preparing to display Product Modelling','Applying Future Product Changes');
  with ProductsDB.ADOStoredProc do
  begin
     ProcedureName := 'sp_ApplyAnyFuturePortions';
     ExecProc;
  end;
end;

procedure TProductsDB.SavePendingPortionChanges;
begin
  if Assigned(FSavePortionIngredients) then
  begin
    if PortionChangesExist then
    begin
      LogProductChange('About to save pending portion changes');
      FSavePortionIngredients;
    end;
  end;
end;

procedure TProductsDB.SavePendingPortionChangesIfPossible;
begin
 // It's not possible to save portions data unless the current product exists in the Products table because of foreign key constraints.
 if not ProductNewlyInsertedAndNotSaved then
   SavePendingPortionChanges();
end;

procedure TProductsDB.SavePendingPortionPriceChanges;
begin
  Assert(not PortionChangesExist, 'Changes to portions must be saved before changes to portion prices');

  if Assigned(FSavePortionPriceChanges) and Assigned(FPortionPriceChangesExist) then
  begin
    if FPortionPriceChangesExist then
    begin
      LogProductChange('About to save pending portion price changes');
      FSavePortionPriceChanges;
    end;
  end;
end;


procedure TProductsDB.SavePendingUnitSupplierChanges;
begin
  if Assigned(FSaveUnitSupplierChanges) and Assigned(FUnitSupplierChangesExist) then
  begin
    if FUnitSupplierChangesExist then
    begin
      LogProductChange('About to save pending Supplier Purchase Unit changes');
      FSaveUnitSupplierChanges;
    end;
  end;
end;

procedure TProductsDB.SavePendingTagChanges;
begin
  if Assigned(FSaveTagChanges) and Assigned(FTagChangesExist)then
  begin
    if FTagChangesExist then
    begin
      LogProductChange('About to save pending tag changes');
      FSaveTagChanges;
    end;
  end;
end;

procedure TProductsDB.SetChildPrintStreamMode;
begin
  if (EntTypeStringToEnum(ClientEntityTableEntityType.Value) in [etStrdLine, etRecipe, etInstruct]) then
  begin
    if VarIsNull(ClientEntityTablePrintStreamWhenChild.Value) or
       (ClientEntityTablePrintStreamWhenChild.Value = 0) then
    begin
      ClientEntityTablePrintStreamWhenChild.Value := 1;
    end;
  end
  else
  begin
    if not (VarIsNull(ClientEntityTablePrintStreamWhenChild.Value) or
             (ClientEntityTablePrintStreamWhenChild.Value = 0)) then
    begin
      ClientEntityTablePrintStreamWhenChild.Value := 0;
    end;
  end;
end;

procedure TProductsDB.SetIsMinorValues;
begin
  if not (EntTypeStringToEnum(ClientEntityTableEntityType.Value) in [etStrdLine, etPurchLine]) then
  begin
    with ADOCommand do
    begin
      CommandText := Format(
        'DECLARE @EntityCode nvarchar(max); ' +
        'SET @EntityCode = %s; ' +
        'IF EXISTS(SELECT * FROM PortionIngredients WHERE IngredientCode = @EntityCode) ' +
        'BEGIN ' +
        '  UPDATE PortionIngredients ' +
        '  SET IsMinor = 0 ' +
        '  WHERE IngredientCode = @EntityCode; ' +
        'END; ' +
        'IF EXISTS(SELECT * FROM PortionIngredientsFuture WHERE IngredientCode = @EntityCode) ' +
        'BEGIN ' +
        '  UPDATE PortionIngredientsFuture ' +
        '  SET IsMinor = 0 ' +
        '  WHERE IngredientCode = @EntityCode; ' +
        'END', [FloatToStr(ClientEntityTableEntityCode.Value)]);
      Execute;
    end;
  end;
end;

function TProductsDB.VarToInt(v: variant): integer;
begin
  if VarIsNull(v) then
    Result := 0
  else
    Result := v;
end;

function TProductsDB.SafeStrToInt(s: string): integer;
begin
  try
    result := StrToInt(s);
  except
    on EConvertError do
    begin
      Result := -1;
    end;
  end;
end;

procedure TProductsDB.refreshLookup(LookupType: TStaticLookupType);
var
  index: Integer;
  subcatinfo: TSubcategoryInfo;
  VATBandInfo: TVATBandInfo;
  ListItemInfo: TListItemInfo;
begin
  case LookupType of
    sltSubcategory:
    begin
      for index := 0 to subcategorieslist.Count - 1 do
        subcategorieslist.Objects[index].Free;
      subcategorieslist.Clear;
      SubcategoryQuery.Active := TRUE;
      while not SubcategoryQuery.EOF do begin
        subcatinfo := TSubcategoryInfo.Create;
        subcatinfo.DivisionId := SubcategoryQuery.FieldByName('DivisionId').AsInteger;

        subcategorieslist.AddObject( SubcategoryQuery.FieldByName('SubcategoryName').AsString,
                                     subcatinfo);

        SubcategoryQuery.Next;
      end;
      SubcategoryQuery.Active := FALSE;
    end;
    sltPortionTypes:
    begin
      // PortionTypesTable
      PortionList.Clear;
      qPortionType.Active := TRUE;
      while not qPortionType.EOF do
      begin
        PortionList.Add(qPortionType.FieldByName('PortionTypeName').AsString);
        qPortionType.Next;
      end;
      qPortionType.Active := FALSE;
    end;
    sltPrintStream:
    begin
      // PrintStreamTable
      PrintStreamList.Clear;
      PrintStreamQuery.Active := TRUE;
      while not PrintStreamQuery.EOF do
      begin
        PrintStreamList.Add(PrintStreamQuery.FieldByName('Printer Stream Name').AsString);

        PrintStreamQuery.Next;
      end;
      PrintStreamQuery.Active := FALSE;
    end;
    sltSupplier:
    begin
      supplierlist.Clear;
      SupplierQuery.Active := TRUE;
      while not SupplierQuery.EOF do begin

        supplierlist.Add( SupplierQuery.FieldByName('Supplier Name').AsString );

        SupplierQuery.Next;
      end;
      SupplierQuery.Active := FALSE;
    end;
    sltVatBand:
    begin
      for index := 0 to VATBandList.Count - 1 do
        VATBandList.Objects[index].Free;
      VATBandList.Clear;
      VatBandQuery.Active := TRUE;
      while not VatBandQuery.EOF do
      begin
        VATBandInfo := TVATBandInfo.Create;
        VATBandInfo.VATIndex := VatBandQuery.FieldByName('Index No').AsInteger;

        VATBandList.AddObject(VatBandQuery.FieldByName('Vat Band Name').AsString, VATBandInfo);

        VatBandQuery.Next;
      end;
      VatBandQuery.Active := FALSE;
    end;
    sltGiftCard:
    begin
      for index := 0 to GiftCardTypeList.Count - 1 do
        GiftCardTypeList.Objects[index].Free;
      GiftCardTypeList.Clear;
      GiftCardTypeList.Sorted := True;
      GiftCardTypeNames.Clear;

      adoqGiftCardTypes.Active := TRUE;

      while not adoqGiftCardTypes.EOF do
      begin
        ListItemInfo := TListItemInfo.Create;
        ListItemInfo.ListItemSchemaIndex := adoqGiftCardTypes.FieldByName('Id').AsInteger;

        GiftCardTypeList.AddObject(adoqGiftCardTypes.FieldByName('DisplayName').AsString, ListItemInfo);
        GiftCardTypeNames.Add(adoqGiftCardTypes.FieldByName('DisplayName').AsString);

        adoqGiftCardTypes.Next;
      end;
      GiftCardTypeList.Sorted := False;

      //Add the '<Not Set>' entry
      ListItemInfo := TListItemInfo.Create;
      ListItemInfo.ListItemSchemaIndex := 0;
      GiftCardTypeList.InsertObject(0,GIFT_CARD_NOTUSED,ListItemInfo);
      GiftCardTypeNames.Insert(0,GIFT_CARD_NOTUSED);

      adoqGiftCardTypes.Active := FALSE;
    end;
  end;
end;

procedure TProductsDB.qEditPortionChoicesAfterPost(DataSet: TDataSet);
begin
  PortionChangesExist := True;
end;

function TProductsDB.GetDefaultTotal : integer;
var SavePos : TBookmark;
iDefaultCount : Integer;
begin
  iDefaultCount := 0;
  with dsPortions.DataSet do
     begin
       DisableControls;
       SavePos := GetBookmark;
       First;
       while not EOF do
         begin
           if FieldByName('IncludeByDefault').AsBoolean then
              Inc(iDefaultCount);
           next;
         end;
       GotoBookmark(SavePos);
       FreeBookMark(SavePos);
       EnableControls;
     end;
  result := iDefaultCount;
end;

function TProductsDB.validateChoiceSelections : boolean;
var
  ErrMessage: String;
  SavePos : TBookmark;
  NumberOfDefaults: Integer;

begin
  result := false;
  if dtsEditPortionChoices.DataSet.FieldByName('EnableChoices').AsBoolean then
  begin
    NumberOfDefaults := GetDefaultTotal;

    // check to see if the choice is part of another multi-select (min/max) reciepe.  if it is, prevent the choices from being enabled.
    if (ingredientOfChoice(ClientEntityTableEntityCode.Value, False {RestrictToImmediateParentOnly}, True {MinMaxChoiceOnly}) and (ConversationalOrderingMode = comNonNested)) then
    begin
      MessageDlg('This choice is already part of a multi-select ingredient.', mtError, [mbOK], 0);
      result := True;
    end
    // check to see if the choice is part of another multi-select (min/max) recipe.  if it is, prevent the choices from being enabled.
    else if ContainsChoice(ClientEntityTableEntityCode.Value, True{MinMaxChoiceOnly}) and (ConversationalOrderingMode = comNonNested) then
    begin
      MessageDlg('This choice already includes a multi-select ingredient.', mtError, [mbOK], 0);
      result := True;
    end
    // defaults need to have more than ingredient selected.     //COMMON
    else if dsPortions.DataSet.RecordCount <= 1 then
    begin
      MessageDlg('Multi-select choice selections must have more than one ingredient.', mtError, [mbOK], 0);
      result := True;
    end
    // Max >= Min   //COMMON
    else if dtsEditPortionChoices.DataSet.FieldByName('MaxChoice').AsInteger < dtsEditPortionChoices.DataSet.FieldByName('MinChoice').AsInteger then
    begin
      MessageDlg('The maximum number of selections cannot be less than the minimum number of allowed choices.', mtError, [mbOK], 0);
      result := True;
    end
    // Max >0  //COMMON
    else if dtsEditPortionChoices.DataSet.FieldByName('MaxChoice').AsInteger = 0 then
    begin
      MessageDlg('The maximum number of selections must be greater than zero.', mtError, [mbOK], 0);
      result := True;
    end
    // Inclusive >= Min  //COMMON
    else if dtsEditPortionChoices.DataSet.FieldByName('SuppChoice').AsInteger > dtsEditPortionChoices.DataSet.FieldByName('MaxChoice').AsInteger then
    begin
      MessageDlg('The number of inclusive choices must be less than or equal to the maximum number of allowed choices.', mtError, [mbOK], 0);
      result := True;
    end
    // No. of defaults <= Max //COMMON
    else if GetDefaultTotal > dtsEditPortionChoices.DataSet.FieldByName('MaxChoice').AsInteger then
    begin
      MessageDlg('The number of default ingredients must be less than or equal to the maximum number of allowed choices.', mtError, [mbOK], 0);
      result := True;
    end
    // No. of defaults => 'Allow Plain' disallowed  //COMMON
    else if (NumberOfDefaults = 0)
    and (dtsEditPortionChoices.DataSet.FieldByName('AllowPlain').AsBoolean) then
    begin
      MessageDlg('''Allow Plain'' cannot be set when no default choices have been chosen.', mtError, [mbOK], 0);
      result := True;
    end
    // Min > 0 => 'Allow Plain' disallowed   //COMMON
    else if (dtsEditPortionChoices.DataSet.FieldByName('MinChoice').AsInteger > 0)
    and (dtsEditPortionChoices.DataSet.FieldByName('AllowPlain').AsBoolean) then
    begin
      MessageDlg('''Allow Plain'' cannot be set when the minimum number of selections is non-zero.', mtError, [mbOK], 0);
      result := True;
    end
    // Inclusive >= No. defaults  //COMMON
    else if (dtsEditPortionChoices.DataSet.FieldByName('SuppChoice').AsInteger < GetDefaultTotal) then
    begin
      MessageDlg('The number of inclusive choices must be greater than or equal to the number of default choices.', mtError, [mbOK], 0);
      result := True;
    end
    else begin
      with dsPortions.DataSet do
      begin
        DisableControls;
        SavePos := GetBookmark;
        First;
        while not EOF do
        begin
          // a choice cannot be a default ingredient
          if (IsEntityAChoice(FieldByName('EntityCode').AsString)) and (FieldByName('IncludeByDefault').AsBoolean) then
          begin
            ErrMessage := Format('Choice "%s" cannot be a default ingredient.', [FieldByName('Name').AsString]);
            MessageDlg(ErrMessage, mtError, [mbOK], 0);
            result := True;
            break;
          end
          // prevent an ingredient that contains a min max choice from being part of a min max choice.
          else if ContainsChoice(FieldByName('EntityCode').Value, True{MinMaxChoiceOnly}) and (ConversationalOrderingMode = comNonNested) then
          begin
            ErrMessage := Format('Ingredient "%s" contains a nested multi-select ingredient and cannot be included within a multi-select choice.', [FieldByName('Name').AsString]);
            MessageDlg(ErrMessage, mtError, [mbOK], 0);
            result := True;
            break;
          end
          // a default ingredient cannot be open priced (this check should have existed in the Non-nested
          // conversational ordering implementation ans as such is now a common validation rule).
          else if (FieldByName('IncludeByDefault').AsBoolean) and IsOpenPriced(FieldByName('EntityCode').Value) then
          begin
            ErrMessage := Format('Ingredient "%s" cannot be a default option because it open priced.', [FieldByName('Name').AsString]);
            MessageDlg(ErrMessage, mtError, [mbOK], 0);
            result := True;
            break;
          end
          // a default ingredient cannot contain any type of choice.
          else if (FieldByName('IncludeByDefault').AsBoolean) and ContainsChoice(FieldByName('EntityCode').Value) then
          begin
            ErrMessage := Format('Ingredient "%s" cannot be a default option because it contains a choice.', [FieldByName('Name').AsString]);
            MessageDlg(ErrMessage, mtError, [mbOK], 0);
            result := True;
            break;
          end
          // A min-max choice with a default ingredient cannot be directly contained in any type of choice.  This check only makes sense
          // in the context of nested conversational ordering as the default choice could only have been set on the first level
          // under non-nested conversational ordering.
          else if (FieldByName('IncludeByDefault').AsBoolean) and IngredientOfChoice(ClientEntityTableEntityCode.Value, True {RestrictToImmediateParentOnly})
             and (ConversationalOrderingMode = comNested) then
          begin
            ErrMessage := Format('Ingredient "%s" cannot be a default option because parent choice' + #13#10 +
                                 '"%s" is directly contained within another choice.', [FieldByName('Name').AsString, ClientEntityTableExtendedRTLName.AsString]);
            MessageDlg(ErrMessage, mtError, [mbOK], 0);
            result := True;
            break;
          end;
          Next;
        end;
        GotoBookmark(SavePos);
        FreeBookMark(SavePos);
        EnableControls;
      end;
    end;
  end;
end;

function TProductsDB.IsEntityAChoice(EntityCode : String) : boolean;
begin
  Result := false;
  with ADOQuery do
    begin
      Close;
      SQL.Text := Format('SELECT [Entity Type] '+
                         '       FROM Products '+
                         ' WHERE EntityCode = %s ', [EntityCode]);
      Open;
      First;
      if EntTypeStringToEnum(FieldByName('Entity Type').asString) = etChoice then
         result := True;
    end;
end;

function TProductsDB.IsIngredientDefault(EntityCode : double) : boolean;
begin
  Result := false;
  with ADOQuery do
    begin
      Close;
      SQL.Text := Format('SELECT IngredientCode '+
                         '       FROM PortionIngredients '+
                         ' WHERE IngredientCode = %s AND IncludeByDefault = 1 ', [FloatToStr(EntityCode)]);
      Open;
      if RecordCount > 0 then
         Result := True;
    end;
end;

function TProductsDB.IsMinMaxChoice(EntityCode : double) : boolean;
begin
  Result := false;
  with ADOQuery do
    begin
      Close;
      SQL.Text := Format('SELECT EntityCode '+
                         '       FROM Portions '+
                         ' WHERE EntityCode = %s AND MinChoice IS NOT NULL ', [FloatToStr(EntityCode)]);
      Open;
      if RecordCount > 0 then
         Result := True;
    end;
end;

function TProductsDB.HasDefaultIngredientsInWorkingTempTable(EntityCode : String) : boolean;
begin
  Result := false;
  with ADOQuery do
    begin
      Close;
      SQL.Text := 'SELECT COUNT(*) AS Total ' +
                  '       FROM #tmpportioncrosstab '+
                  ' WHERE IncludeByDefault = 1 ';
      Open;
      if FieldByName('Total').asInteger > 0 then
         Result := True;
    end;
end;

function TProductsDB.HasDefaultIngredients(EntityCode : Double) : boolean;
begin
  Result := false;
  with ADOQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) AS Total');
      SQl.Add('FROM portions po');
      SQL.Add('JOIN portioningredients pi on po.PortionID = pi.PortionID');
      SQl.Add(Format('WHERE IncludeByDefault = 1 and po.EntityCode = %s',[FloatToStr(EntityCode)]));
      Open;
      if FieldByName('Total').asInteger > 0 then
         Result := True;
    end;
end;

function TProductsDB.ContainsChoice(EntityCode : double; MinMaxChoiceOnly : Boolean) : boolean;
begin
  with ADOQuery do
  begin
    Close;
    // go down the rabbit hole to find any min max / normal choices.
    SQL.Text := Format('SELECT dbo.fnProductContainsChoice(%s, %d) as ProductContainsChoice',[FloatToStr(EntityCode), BoolToBit(MinMaxChoiceOnly)]);
    Open;
    Result := FieldByname('ProductContainsChoice').AsBoolean
  end
end;

function TProductsDB.IngredientOfChoice(EntityCode : double; RestrictToImmediateParentOnly: Boolean; MinMaxChoiceOnly: boolean) : Boolean;
begin
  with ADOQuery do
  begin
    Close;
    // go up the rabbit hole to find any min max / normal choices.
    SQL.Text := Format('SELECT dbo.fnIngredientOfChoice(%s, %d, %d) as IsIngredientOfChoice',[FloatToStr(EntityCode), BoolToBit(RestrictToImmediateParentOnly), BoolToBit(MinMaxChoiceOnly)]);
    Open;
    Result := FieldByname('IsIngredientOfChoice').AsBoolean
  end
end;

//Return true if the given product is used as an ingredient in any other product.
function TProductsDB.IsUsedAsIngredient(EntityCode: double): boolean;
begin
  with ADOQuery do
  try
    Close;
    SQL.Text := Format(
      'IF EXISTS ' +
      '( ' +
        'SELECT top 1 p.* ' +
        'FROM Portions p INNER JOIN PortionIngredients i ON p.PortionId = i.PortionId ' +
        'WHERE i.IngredientCode = %0:f AND p.EntityCode <> %0:f ' +
      ') ' +
        'SELECT 1 AS Result ' +
      'ELSE ' +
        'SELECT 0 AS Result', [EntityCode]);
    Open;
    Result := (FieldByname('Result').AsInteger = 1);
  finally
    Close;
  end;
end;

function TProductsDB.IsOpenPriced(EntityCode : double) : boolean;
begin
  Result := false;
  with ADOQuery do
    begin
      Close;
      //[Whether Open Priced]
      //    = 'O' (yes, capital letter o (O), not zero (0)) indicates open pricing.
      //    = 'F' indicates fixed pricing.
      SQL.Text := Format('SELECT * '+
                         'FROM Products '+
                         'WHERE EntityCode = %s AND [Whether Open Priced] = ''O''', [FloatToStr(EntityCode)]);
      Open;
      if RecordCount > 0 then
         Result := True;
    end;
end;

//Return the maximum depth at which the given product is used as an ingredient in the recipe tree. In other words it is the largest
//number of "child to parent" links starting from the given product as the first child and ending up at a top level product.
//If the product is not a child of another product the return value is 0.
//Example: If the product is used by product X which in turn is used by product Y the return value is 2.
//
//Also ParentEntityList is populated with the EntityCode of all parents, grandparents, etc of the given product.
function TProductsDB.GetMaxDepth(EntityCode: double; var ParentEntityList: TStringList): integer;
var
  TreeDepth: integer;
  MaxParentDepth: integer;
begin
  Result := 0;

  //TODO: This still causes a short delay on some datasets when adding ingredients to certain products. It could be speeded
  // up by maintaining a collection of previously calculated depths. Tried this using a temp SQL table but didn't speed
  // it up by much at all for some reason. GDM
  with TADOQuery.Create(Self) do
  try
    Connection := dmADO.AztecConn;
    SQL.Clear;
    SQL.Add('select distinct p.EntityCode');
    SQL.Add('from Portions p inner join PortionIngredients i');
    SQL.Add('  on p.PortionID = i.PortionID');
    SQL.Add('where i.IngredientCode = ' + format('%f', [EntityCode]));
    SQL.Add('and p.EntityCode <> ' + format('%f', [EntityCode]));
    Open;

    if RecordCount > 0 then
    begin
      MaxParentDepth := 0;

      while not EOF do
      begin
        ParentEntityList.Add(format('%f', [FieldByName('EntityCode').AsFloat]));
        TreeDepth := GetMaxDepth(FieldByName('EntityCode').AsFloat, ParentEntityList);

        if TreeDepth > MaxParentDepth then
          MaxParentDepth := TreeDepth;

        Next;
      end;

      Result := 1 + MaxParentDepth;
    end;
  finally
    Close;
    Free;
  end;
end;

procedure TProductsDB.ResetPortionAttributes(curEntType, NewEntType: EntType);
begin
  //Reset any portion attributes that no longer make sense for the new entity type
  if (curEntType = etChoice) and (NewEntType <> etChoice) then
  begin
    with ADOQuery do
    begin
      Close;
      SQL.Add('update #TmpPortionChoices');
      SQL.Add('set enablechoices = null, minchoice = null,');
      SQL.Add('maxchoice = null, suppchoice = null, AllowPlain = null');
      ExecSQL;
    end;

    PortionChangesExist := True;

    if qEditPortionChoices.State = dsEdit then
      qEditPortionChoices.Requery;
  end;
end;

procedure TProductsDB.DeleteAllButCurrentStandardPortion();
begin
  if not ClientEntityTable.Active then
    Exit;

  with ADOCommand do
  begin
    CommandText := Format(
      'DELETE PortionIngredients WHERE PortionID IN (SELECT PortionID FROM Portions WHERE EntityCode = %0:f AND PortionTypeId <> %1:d) ' +
      'DELETE Portions WHERE EntityCode = %0:f AND PortionTypeId <> %1:d ' +
      'DELETE PortionIngredientsFuture WHERE PortionID IN (SELECT PortionID FROM PortionsFuture WHERE EntityCode = %0:f) ' +
      'DELETE PortionsFuture WHERE EntityCode = %0:f'
      , [ClientEntityTableEntityCode.Value, DefaultPortionTypeID]);
    Execute;
  end;
end;

procedure TProductsDB.CreatePreparedItemPortionIfNecessary;
{ Add a record to the Portions dataset for the prepared item if one doesn't already exist }
var portionId: integer;
begin
  with PortionsQuery1 do
  begin
    Open;
    if RecordCount = 0 then
    begin
      portionId := GetNextPortionID;

      insert;
      FieldByName('PortionID').AsInteger := portionId;
      FieldByName('EntityCode').AsFloat := ProductsDB.ClientEntityTable.FieldValues['EntityCode'];
      FieldByName('PortionTypeID').AsInteger := DefaultPortionTypeID;
      FieldByName('DisplayOrder').AsInteger := 1;
      post;
    end;
  end;
end;

procedure TProductsDB.DeleteAllPortions();
begin
  if not ClientEntityTable.Active then
    Exit;

  with ADOCommand do
  begin
    CommandText := Format(
      'DELETE PortionIngredients WHERE PortionID IN (SELECT PortionID FROM Portions WHERE EntityCode = %0:f) ' +
      'DELETE Portions WHERE EntityCode = %0:f ' +
      'DELETE PortionIngredientsFuture WHERE PortionID IN (SELECT PortionID FROM PortionsFuture WHERE EntityCode = %0:f) ' +
      'DELETE PortionsFuture WHERE EntityCode = %0:f'
      , [ClientEntityTableEntityCode.Value]);
    Execute;
  end;
end;

procedure TProductsDB.RemoveSelfIngredient();
begin
  if not ClientEntityTable.Active then
    Exit;

  with ADOCommand do
  begin
    CommandText := Format(
      'DECLARE @displayOrder int ' +

      'SELECT @displayOrder = MIN(DisplayOrder) FROM PortionIngredients ' +
      'WHERE IngredientCode = %0:f ' +
      '  AND PortionID in ( ' +
      '    SELECT PortionID FROM Portions ' +
      '    WHERE EntityCode = %0:f) ' +

      'IF @displayOrder IS NOT NULL ' +
      'BEGIN ' +
      '  DELETE PortionIngredients ' +
      '  WHERE IngredientCode = %0:f ' +
      '    AND PortionID in (' +
      '      SELECT PortionID from Portions ' +
      '      WHERE EntityCode = %0:f) ' +

      '  UPDATE PortionIngredients' +
      '  SET DisplayOrder = DisplayOrder - 1 ' +
      '  WHERE DisplayOrder > @displayOrder ' +
      '    AND PortionID in ' +
      '      (SELECT PortionID FROM Portions ' +
      '       WHERE EntityCode = %0:f)' +
      'END'
      , [ClientEntityTableEntityCode.Value]);
    Execute;
  end;
end;

procedure TProductsDB.RefreshPreparedItemIngredientDatasetsIfNecessary();
begin
  if PortionsQuery1.Active then
  begin
    PortionsQuery1.Close;
    PortionsQuery1.Open;
  end;

  if IngredientsQuery1.Active then
  begin
    IngredientsQuery1.Close;
    IngredientsQuery1.Open;
  end;
end;


procedure TProductsDB.AddSelfIngredient();
begin
  if not ClientEntityTable.Active then
    Exit;

  with ADOCommand do
  begin
     CommandText := Format(
      'IF NOT EXISTS(' +
      '  SELECT * FROM PortionIngredients ' +
      '  WHERE IngredientCode = %0:f ' +
      '  AND PortionID in (' +
      '    SELECT PortionID FROM Portions ' +
      '    WHERE EntityCode = %0:f)) ' +

      'BEGIN ' +
      '  UPDATE PortionIngredients ' +
      '  SET DisplayOrder = DisplayOrder + 1 ' +
      '  WHERE PortionID in ' +
      '    (SELECT PortionID from Portions ' +
      '     WHERE EntityCode = %0:f) ' +

      '  INSERT PortionIngredients(PortionID, IngredientCode, DisplayOrder) ' +
      '  SELECT PortionID, %0:f, 1 ' +
      '  FROM Portions ' +
      '  WHERE EntityCode = %0:f ' +
      'END'
      , [ClientEntityTableEntityCode.Value]);
      Execute;
  end;
end;


//Move the current ingredient in the qEditPortions dataset either up one place or down one place.
procedure TProductsDB.MoveCurrentIngredient(direction: TDirection);
var
  currEntityCode: double;
  currDisplayOrder: integer;
  increment: integer;
begin
  with qEditPortions do
  begin
    if not Active then
      Exit;

    if (direction = dDown) and (RecNo = RecordCount) then
      Exit;

    if (direction = dUp) and (RecNo = 1) then
      Exit;
  end;

  qEditPortions.DisableControls;
  try
    currDisplayOrder := qEditPortions.FieldByName('DisplayOrder').AsInteger;
    currEntityCode := qEditPortions.FieldByName('EntityCode').AsFloat;
    increment := ifthen(direction = dDown, 1, -1);

    with ADOCommand do
    begin
      CommandText := Format(
        'DECLARE @displayOrder int, @direction int ' +
        'SET @displayOrder = %0:d ' +
        'SET @direction = %1:d ' +

        'IF EXISTS(SELECT * FROM #TmpPortionCrosstab WHERE DisplayOrder = @displayOrder) AND ' +
        '   EXISTS(SELECT * FROM #TmpPortionCrosstab WHERE DisplayOrder = @displayOrder + @direction) ' +
        'BEGIN ' +
        '  UPDATE #TmpPortionCrosstab ' +
        '  SET DisplayOrder = b.NewOrder ' +
        '  FROM #TmpPortionCrosstab a ' +
        '    JOIN ' +
        '    ( ' +
        '      SELECT @displayOrder AS OldOrder, @displayOrder + @direction AS NewOrder ' +
        '      UNION ' +
        '      SELECT @displayOrder + @direction AS OldOrder, @displayOrder AS NewOrder ' +
        '    ) b ON a.DisplayOrder = b.OldOrder ' +
        'END',
        [currDisplayOrder, increment]);

      Execute;
    end;

    //Close and Open qEditPortions in order to re-order the rows in its internal recordset.
    qEditPortions.Close;
    qEditPortions.Open;

    //Follow the moved record
    qEditPortions.Locate('EntityCode;DisplayOrder', VarArrayOf([currEntityCode, currDisplayOrder + increment]), []);
  finally
    qEditPortions.EnableControls;
  end;

  PortionChangesExist := True;
end;


function TProductsDB.GetAztecRecipeModellingDBConnectionString: String;
var
  ConnectionStringTemplate: String;
begin
  with ADOQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ConnectionString FROM ac_Module');
    SQL.Add('WHERE SystemName = ' + QuotedStr(RECIPE_MODELLING_SYSTEM_NAME));
    SQL.Add('AND Deleted = 0');
    Open;

    if not EOF then
    begin
      ConnectionStringTemplate := FieldByName('ConnectionString').AsString;
      ConnectionStringTemplate := StringReplace(ConnectionStringTemplate,'$(DbUserName)',uAztecDatabaseUtils.ZONALACCESS_LOGIN_NAME,[rfIgnoreCase, rfReplaceAll]);
      ConnectionStringTemplate := StringReplace(ConnectionStringTemplate,'$(DbPassword)',uAztecDatabaseUtils.ZONAL_ACCESS_PASSWORD,[rfIgnoreCase, rfReplaceAll]);
      ConnectionStringTemplate := StringReplace(ConnectionStringTemplate,'$(AppUserName)','ProductModelling',[rfIgnoreCase, rfReplaceAll]);
      ConnectionStringTemplate := 'Provider=SQLOLEDB.1;' + ConnectionStringTemplate;
      Result := ConnectionStringTemplate;
    end;
  end;
end;

function TProductsDB.RecipeModellingConnectionOK: Boolean;
var
  RMConnectionString: String;
begin
  Result := True;
  if not adocRecipeModelling.Connected then
  begin
    RMConnectionString := GetAztecRecipeModellingDBConnectionString;
    if RMConnectionString <> '' then
    begin
      Log.Event('Recipe Modelling has been installed.');
      adocRecipeModelling.ConnectionString := RMConnectionString;
      try
        adocRecipeModelling.Open;
      except
        on E:Exception do
        begin
          Log.Event('Failed to connect to the Recipe Modelling database : ' + E.Message);
          Result := False;
        end;
      end;

      if adocRecipeModelling.Connected then
      begin
        adoqRMControlled.Open;
        adotRMControlled.Active := True;
      end;
    end;
  end;
end;

function TProductsDB.GetCurrentEntityControlledByRM: Boolean;
begin
  Result := False;
  if ProductsDB.adocRecipeModelling.Connected then
  begin
    if ProductsDB.adoqRMControlled.Active then
      Result := (ProductsDB.adoqRMControlled.RecordCount > 0);
  end;
end;

procedure TProductsDB.qEditCookTimesCookTimeGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if Sender.IsNull then
    Text := ''
  else
    Text := FormatDateTime('hh:nn:ss', Frac(Sender.AsDateTime));
end;

function TProductsDB.GetPMAppLock: Boolean;
begin
  Result := False;
  with ProductsDB.ADOQuery do
  begin
    Close;
    SQL.CLear;
    //Applock is shared in order to allow multiple instances of PM to
    //operate simultaneously. Session based as we don't want to wrap all of
    //PM in a transaction.
    SQL.Add('DECLARE @result int');
    SQL.Add('EXEC @result = sp_getapplock @Resource = ''AztecProductModellingAppLock'',');
    SQL.Add('                             @LockMode = ''Shared'',');
    SQL.Add('                             @DbPrincipal = ''Public'',');
    SQL.Add('                             @LockTimeout = 0,');
    SQL.Add('                             @Lockowner = ''Session''');
    SQL.Add('SELECT @result as lockresult');
    Open;
    if not EOF then
      result := FieldByName('lockresult').AsInteger >= 0;
  end;
end;

function TProductsDB.ReleasePMAppLock: Boolean;
begin
  Result := False;
  with ProductsDB.ADOQuery do
  begin
    Close;
    SQL.CLear;
    SQL.Add('DECLARE @result int');
    SQL.Add('DECLARE @AppLockHeld nvarchar(32)');
    SQL.Add('SELECT @AppLockHeld = APPLOCK_MODE(''Public'', ''AztecProductModellingAppLock'', ''Session'')');
    SQL.Add('SET @result = 1');
    SQL.Add('IF @AppLockHeld <> ''NoLock''');
    SQL.Add('BEGIN');
    SQL.Add(' EXEC @result = sp_releaseapplock @Resource = ''AztecProductModellingAppLock'',');
    SQL.Add('                                  @DbPrincipal = ''Public'',');
    SQL.Add('                                  @LockOwner = ''Session''');
    SQL.Add('END');
    SQL.Add('SELECT @result as releaseresult');
    Open;
    if not EOF then
      result := FieldByName('releaseresult').AsInteger >= 0;
  end;
end;

procedure TProductsDB.ClientEntityTableisGiftCardGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if (Sender.AsInteger >= 0) and (Sender.AsInteger < GiftCardTypeNames.Count) then
  begin
    Text := GiftCardTypeNames[Sender.AsInteger];
  end;
end;

procedure TProductsDB.ClientEntityTableisGiftCardSetText(Sender: TField;
  const Text: String);
var
  index : Integer;
begin
  index := GiftCardTypeList.IndexOf(Text);

  if index = -1 then
    Sender.Clear
  else
    Sender.AsInteger := TListItemInfo(GiftCardTypeList.Objects[index]).ListItemSchemaIndex;
end;

procedure TProductsDB.ClientEntityTableGiftCardToggleChange(
  Sender: TField);
begin
  if Sender.AsBoolean then
    ClientEntityTableisGiftCard.Value := 2
  else
    ClientEntityTableisGiftCard.Value := 0;
end;

function TProductsDB.ProductTaxRulesValid: Boolean;
begin
  Result := True;
  if EntTypeStringToEnum(ClientEntityTableEntityType.Value) in [etStrdLine, etRecipe] then
  begin
    if IsBlank(productsDB.ProductTaxTableTaxRule1) and
       IsBlank(productsDB.ProductTaxTableTaxRule2) and
       IsBlank(productsDB.ProductTaxTableTaxRule3) and
       IsBlank(productsDB.ProductTaxTableTaxRule4) then
    begin
      ShowMessage('All Standard Lines and Recipes MUST have at least one Tax Rule defined');
      Result := False;
    end;
  end
  else begin
    if (ProductTaxTable.state = dsInsert) and
      ProductTaxTableTaxRule1.IsNull and
      ProductTaxTableTaxRule2.IsNull and
      ProductTaxTableTaxRule3.IsNull and
      ProductTaxTableTaxRule4.IsNull then
    ProductTaxTable.Cancel;
  end;
end;

procedure TProductsDB.tblPreparedItemDetailsBatchSizeValidate(
  Sender: TField);
begin
  if (Sender.AsFloat <= 0) then
  begin
    MessageDlg('Batch size must be greater than zero.',
      mtError,
      [mbOK],
      0);
    Abort;
  end;
end;

procedure TProductsDB.ProductTaxTableTaxRuleChange(Sender: TField);
begin
  FTotalInclusiveTax := -1; //Force the total tax figure to be recalculated

  if Assigned(FTaxRulesChanged) then
    FTaxRulesChanged(self);
end;

procedure TProductsDB.ProductTaxTableAfterScroll(DataSet: TDataSet);
begin
  FTotalInclusiveTax := -1; //Force the total tax figure to be recalculated
end;

function TProductsDB.GetCurrentBandAPrice(portionTypeId: integer): Variant;
begin
  with ADOQuery do
  try
    SQL.Text :=
      'SELECT TOP 1 Price AS CurrentBandAPrice ' +
      'FROM PBandVal ' +
      'WHERE MatrixId = (SELECT TOP 1 MatrixId FROM PriceMatrix WHERE Deleted = 0 ORDER BY MatrixID) ' +
      '  AND Band = ''A'' ' +
      '  AND ProductID = ' + ClientEntityTableEntityCode.AsString +
      '  AND PortionTypeId = ' + IntToStr(portionTypeId) +
      '  AND StartDate <= GETDATE() ' +
      '  AND Deleted = 0 ' +
      'ORDER BY StartDate DESC';
    Open;
    Result := FieldByName('CurrentBandAPrice').AsVariant;
  finally
    Close;
  end;
end;

procedure TProductsDB.qEditPortionsAfterPost(DataSet: TDataSet);
begin
  PortionChangesExist := true;
end;

//Returns the EntityCode of the currently selected product.
function TProductsDB.CurrentEntityCode: double;
begin
  result := ClientEntityTableEntityCode.Value;
end;

//Returns the type of the currently selected product.
function TProductsDB.CurrentEntityType: EntType;
begin
  result := EntTypeStringToEnum(ClientEntityTableEntityType.Value)
end;

function TProductsDB.GetPortionHierarchyFlags(EntityCode: double; PortionTypeID: integer; IngredientCode: double; IngredientPortionTypeID: variant; EffectiveDate: string): TADOQuery;
var
  ingredientPortionTypeIDString: string;
  effectiveDateString: string;
begin
  if (IngredientPortionTypeID = null) then
    ingredientPortionTypeIDString := 'NULL'
  else
    ingredientPortionTypeIDString := intToStr(IngredientPortionTypeID);

  if (EffectiveDate = CURRENT_ITEM) then
    effectiveDateString := 'NULL'
  else
    effectiveDateString := QuotedStr(EffectiveDate);

  with ADOQuery do
  begin
    SQL.Text := 'exec dbo.sp_GetPortionHierarchyFlags '
      + floatToStr(EntityCode) + ', '
      + intToStr(PortionTypeID) + ', '
      + floatToStr(IngredientCode) + ', '
      + ingredientPortionTypeIDString + ', '
      + effectiveDateString;
    Open;
    Result := ADOQuery;
  end;
end;

procedure TProductsDB.ClientPPTableAfterScroll(DataSet: TDataSet);
var
  cbIsAdmissionClickHandler,
  cbValidateMembershipClickHandler,
  cbIsFootfallClickHandler,
  cbIsDonationClickHandler,
  cbPromptForGiftAidClickHandler : TNotifyEvent;
begin
  // detach flag checkboxes onClicks to assign checked values from cds
  cbIsAdmissionClickHandler := LineEditForm.cbIsAdmission.OnClick;
  cbValidateMembershipClickHandler := LineEditForm.cbValidateMembership.OnClick;
  cbIsFootfallClickHandler := LineEditForm.cbIsFootfall.OnClick;
  cbIsDonationClickHandler := LineEditForm.cbIsDonation.OnClick;
  cbPromptForGiftAidClickHandler := LineEditForm.cbPromptForGiftAid.OnClick;


  LineEditForm.cbIsAdmission.OnClick := nil;
  LineEditForm.cbValidateMembership.OnClick := nil;
  LineEditForm.cbIsFootfall.OnClick := nil;
  LineEditForm.cbIsDonation.OnClick := nil;
  LineEditForm.cbPromptForGiftAid.OnClick := nil;

  LineEditForm.cbIsAdmission.Checked := ClientPPTableIsAdmission.Value;
  LineEditForm.cbValidateMembership.Checked := ClientPPTableValidateMembership.Value;
  LineEditForm.cbIsFootfall.Checked := ClientPPTableIsFootfall.Value;
  LineEditForm.cbIsDonation.Checked := ClientPPTableIsDonation.Value;

  LineEditForm.CountryOfOriginTextBox.Lines.Clear;
  LineEditForm.CountryOfOriginTextBox.Text := ClientPPTableCountryOfOrigin.Value;

  if (LineEditForm.cbPromptForGiftAid.Visible) then
    LineEditForm.cbPromptForGiftAid.Checked := ClientPPTablePromptForGiftAid.Value
  else
    LineEditForm.cbPromptForGiftAid.Checked := false;

  LineEditForm.cbIsAdmission.OnClick := cbIsAdmissionClickHandler;
  LineEditForm.cbValidateMembership.OnClick := cbValidateMembershipClickHandler;
  LineEditForm.cbIsFootfall.OnClick := cbIsFootfallClickHandler;
  LineEditForm.cbIsDonation.OnClick := cbIsDonationClickHandler;
  LineEditForm.cbPromptForGiftAid.OnClick := cbPromptForGiftAidClickHandler;

end;

procedure TProductsDB.addProductToProductProperties(EntityCode: double);
begin
  if not ClientPPTable.Locate( 'EntityCode', EntityCode, [] ) then
  begin
    if (ClientPPTable.State in [ dsEdit]) then
      ClientPPTable.Post;

    if not (ClientPPTable.State in [ dsInsert]) then
    begin
      ClientPPTable.Insert;

      ClientPPTableEntityCode.Value := EntityCode;

      ClientPPTableIsAdmission.Value := False;
      ClientPPTableValidateMembership.Value := False;
      ClientPPTableIsFootfall.Value := False;
      ClientPPTableIsDonation.Value := False;
      ClientPPTablePromptForGiftAid.Value := False;

      ClientPPTable.Post;
      
    end;
  end;
end;

procedure TProductsDB.CloneClientPPTable(CloneDataSet: TClientDataSet;
  KeepSettings: boolean);
begin
  Assert( ClientPPTable.filtered = false, 'ClientPPTable must never be filtered' );
  CloneDataSet.CloneCursor( ClientPPTable, false, KeepSettings );
end;

procedure TProductsDB.ClientPPTableReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError;
  UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  Log.Event('Reconcile PProps ERR:'+E.Message);
end;

procedure TProductsDB.ClientPPTablePostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  Log.Event('Post PProps ERR:'+E.Message);
end;

procedure TProductsDB.clearProductProperties(currentId: String);
var
  AfterScrollEvent: TDataSetNotifyEvent;
  Bookmark: TBookmark;
  id: String;
begin
  // remove records with no flags set
  if not(ClientPPTable.IsEmpty) then begin
    if not(currentId = '') then
      Bookmark := ClientPPTable.GetBookmark;

    ClientPPTable.DisableControls;

    AfterScrollEvent := ClientPPTable.AfterScroll;
    ClientPPTable.AfterScroll := nil;

    ClientPPTable.First;
    while not ClientPPTable.Eof do
    begin
      id := ClientPPTableEntityCode.AsString;
      if (id = currentId) then begin
        ClientPPTable.Next
      end
      else
      begin
        if not(ClientPPTableIsAdmission.Value or
            ClientPPTableValidateMembership.Value or
            ClientPPTableIsFootfall.Value or
            ClientPPTableIsDonation.Value or
            ClientPPTablePromptForGiftAid.Value) then

              ClientPPTable.Delete;

        ClientPPTable.Next;
      end;
    end;

    ClientPPTable.AfterScroll := AfterScrollEvent;
    if not(currentId = '') then
      ClientPPTable.GotoBookmark(Bookmark);
    ClientPPTable.EnableControls;

    if (ClientPPTable.ChangeCount > 0) then
      ClientPPTable.ApplyUpdates(0);
  end;
end;

procedure TProductsDB.deleteProductProperties;
begin
  // delete orphaned ProductProperties entries
  with ADOCommand do
  begin
    (*
    CommandText := 'delete from ProductProperties where ' +
      ' IsAdmission = 0 and' +
      ' ValidateMembership = 0 and' +
      ' IsFootfall = 0 and' +
      ' IsDonation = 0 and' +
      ' PromptForGiftAid = 0';
    *)
    CommandText := 'delete from ProductProperties where ' +
      ' EntityCode not in (' +
      ' select EntityCode from Products )';
    Execute;
  end;
end;

end.


