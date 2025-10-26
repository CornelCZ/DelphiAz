unit uSelectEntity;

(*
 * Unit contains the TSelectEntityForm form - used to allow the user to select an entity
 * from the entity for addition to a menu/recipe.
 *
 * Much of the functionality of this form is achieved by use of the TEntityLookupFrame
 * class.
 *
 * Author: Hamish Martin, IceCube/Edesix
 *)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, DBClient, StdCtrls, uEntityLookup, uDatabaseADO;

type
  TSelectEntityForm = class(TForm)
    okButton: TButton;
    cancelButton: TButton;
    SelectEntityDataSource: TDataSource;
    EntityLookupFrame: TEntityLookupFrame;
    PromptLabel: TLabel;
    SelectEntityTable: TClientDataSet;
    SelectEntityTableRetailName: TStringField;
    SelectEntityTableEntityCode: TFloatField;
    SelectEntityTableEntityType: TStringField;
    SelectEntityTableRetailDescription: TStringField;
    SelectEntityTableDeleted: TStringField;
    SelectEntityTableLevel: TStringField;
    SelectEntityTableSpecialRecipe: TStringField;
    SelectEntityTableSubCategoryName: TStringField;
    SelectEntityTableSoldByWeight: TBooleanField;
    SelectEntityTableDiscontinue: TBooleanField;
    SelectEntityTableDefaultPrinterStream: TStringField;
    SelectEntityTablePurchaseName: TStringField;
    SelectEntityTableCourseID: TIntegerField;
    SelectEntityTableImportExportReference: TStringField;
    SelectEntityTableB2BName: TStringField;
    SelectPPTable: TClientDataSet;
    SelectPPTableEntityCode: TFloatField;
    SelectPPTableIsAdmission: TBooleanField;
    SelectPPTableValidateMembership: TBooleanField;
    SelectPPTableIsFootfall: TBooleanField;
    SelectPPTableIsDonation: TBooleanField;
    SelectPPTablePromptForGiftAid: TBooleanField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SelectEntityTableCalcFields(DataSet: TDataSet);
    function ShowModal: Integer; override;
    procedure okButtonClick(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
  private
    // The entity code, Retail Name, entity type, standard portion unit and special recipe status
    // of the item selected by the user.  These fields are only filled in when the
    // form is closed.
    selected_entcode: Double;
    selected_RetailName: string;
    selected_enttype: EntType;
    is_special_recipe: boolean;

    // The filter string to use on the entity table when the dialog is displayed.
    // This does not include filters subsequently applied using the filter dialog.
    filter: String;

    // Called when user double clicks on, or presses enter on, a selected item.
    procedure ConfirmItem(Sender: TObject);
    function MyShowModal: Integer;
    function ApplyMinMaxChoiceChecks: boolean;
  public
    procedure initialise;
    // Get the entity code of the item the user selected.
    function getSelectedEntityCode: Double;
    // Get the retail name of the item the user selected.
    function getSelectedRetailName: string;
    // Get the entity type of the item the user selected.
    function getSelectedEntityType: EntType;
    // Get the special recipe status of the item the user selected.
    function isSelectedSpecialRecipe: boolean;
    // Get the 'sold by weight' status of the item the user selected
    function isSelectedSoldByWeight: boolean;
    // Get the container usage of the item the user selected
    function isSelectedUsingContainers: boolean;
    // Setup the filter used for filtering the entity table.
    // - permittedTypes: only entities of the specified types will be displayed in the form.
    // - disallowEntCode: the item with this ent code will not be displayed in the form.
    procedure setFilter( permittedTypes: EntTypeSet; disallowEntCode: double = -1 );
    // Setup the caption for the form and the help ID
    procedure setCaptionAndHelpId( newCaption, newPrompt : string; helpId : Integer );

    //NTFlags
    function checkProductFlagOnAddingAsIngredient(EntityCode:double):boolean;
  end;

var
  SelectEntityForm: TSelectEntityForm;

implementation

uses uGuiUtils, uGlobals, uADO;

{$R *.dfm}

procedure TSelectEntityForm.FormCreate(Sender: TObject);
begin
  // Inform the entity lookup frame of the dataset and search field to use.
  EntityLookupFrame.DataSource := SelectEntityDataSource;
  EntityLookupFrame.OnConfirmSelectedItem := ConfirmItem;
  EntityLookupFrame.warnIfFilterResultsInEmptyTable := true;

  // Disable controls - controls are only enabled when the form is visible.
  SelectEntityTable.DisableControls;
end;

procedure TSelectEntityForm.Initialise;
begin
  //Make SelectEntityTable share the data of ProductsDB.ClientEntityTable and also
  //copy all filter settings, etc.
  ProductsDB.CloneClientEntityTable (SelectEntityTable, false);

  ProductsDB.CloneClientPPTable(SelectPPTable, false);
end;

procedure TSelectEntityForm.ConfirmItem(Sender: TObject);
begin
  okButton.Click;
end;

// Form is about to be displayed
procedure TSelectEntityForm.FormShow(Sender: TObject);
begin
  // Activate the table, and setup the form.
  SelectEntityTable.EnableControls;
  EntityLookupFrame.SearchTextEdit.Text := '';
  EntityLookupFrame.SearchTextEdit.SetFocus;

  okButton.ModalResult := mrOk;
  okButton.Caption := 'OK';

  cancelButton.Caption := 'Cancel';
end;

function TSelectEntityForm.ShowModal: Integer;
begin
  Position := poMainFormCenter;
  Result := MyShowModal;
end;

function TSelectEntityForm.MyShowModal: Integer;
begin
  // Use precomputed filter.
  EntityLookupFrame.SetFilter( filter );

  if SelectEntityTable.EOF and SelectEntityTable.BOF then begin
    // Nothing that the user can select
    ShowMessage( 'There are no suitable items available.' );
    Result := mrCancel;
  end else begin
    Result := inherited ShowModal;
  end;
end;

// Form has been closed.
procedure TSelectEntityForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // Record details of the selected entity.
  selected_entcode := SelectEntityTable.FieldByName( 'EntityCode' ).AsFloat;
  selected_RetailName := SelectEntityTable.FieldByName( 'Extended RTL Name' ).AsString;
  selected_enttype := EntTypeStringToEnum(
                        SelectEntityTable.FieldByName( 'Entity Type' ).AsString );
  is_special_recipe := (selected_enttype = etRecipe) and
                       (SelectEntityTable.FieldByName( 'SpecialRecipe' ).AsString = 'Y');

  // Disable table until the form is shown again.
  SelectEntityTable.DisableControls;
end;

function TSelectEntityForm.getSelectedEntityCode: Double;
begin
  if SelectEntityTable.Active then
    getSelectedEntityCode := SelectEntityTable.FieldByName( 'EntityCode' ).AsFloat
  else
    getSelectedEntityCode := selected_entcode;
end;

function TSelectEntityForm.getSelectedRetailName: string;
begin
  if SelectEntityTable.Active then
    getSelectedRetailName := SelectEntityTable.FieldByName( 'Extended RTL Name' ).AsString
  else
    getSelectedRetailName := selected_RetailName;
end;

function TSelectEntityForm.getSelectedEntityType: EntType;
begin
  if SelectEntityTable.Active then
    getSelectedEntityType := EntTypeStringToEnum( SelectEntityTable.FieldByName( 'Entity Type' ).AsString )
  else
    getSelectedEntityType := selected_enttype;
end;

function TSelectEntityForm.isSelectedSpecialRecipe: boolean;
begin
  if SelectEntityTable.Active then
    isSelectedSpecialRecipe := (getSelectedEntityType = etRecipe) and
                               (SelectEntityTable.FieldByName( 'SpecialRecipe' ).AsString = 'Y')
  else
    isSelectedSpecialRecipe := is_special_recipe;
end;

// Setup the filter to be used on the entity table when the form is displayed
procedure TSelectEntityForm.setFilter( permittedTypes: EntTypeSet; disallowEntCode: double );
var
  i: integer;
begin
  filter := '';

  // Ensure only the desired entity types are visible
  for i := Ord(etInstruct) to Ord(etMultiPurch) do begin
    if EntType(i) in permittedTypes then begin
      if filter = '' then
        filter := '( '
      else
        filter := filter + ' OR ';

      filter := filter + '[Entity Type] = ' + QuotedStr(EntTypeEnumToString(EntType(i)));
    end;
  end;
  filter := filter + ' )';

  // Ensure the specified entity code is not visible.
  if disallowEntCode <> -1 then
    filter := filter + ' AND [EntityCode] <> ' + FloatToStr( disallowEntCode );

  // Use ingredient_entity_filter to filter out deleted items and items not of the right level/site.
  filter := productsDB.ingredient_entity_filter + ' AND ' + filter;
end;

// Compute the level column of the table.
procedure TSelectEntityForm.SelectEntityTableCalcFields(DataSet: TDataSet);
begin
  if DataSet.State <> dsInternalCalc then begin
    if SelectEntityTableEntityCode.Value > 19999999999 then
      SelectEntityTableLevel.Value := 'Site'
    else
      SelectEntityTableLevel.Value := 'Global';
  end;
end;

function TSelectEntityForm.ApplyMinMaxChoiceChecks: boolean;
var selectedIngredient: double;

  function PassesNonNestedConversationalOrderingValidations: Boolean;
  begin
    Result := True;
    if (ProductsDB.isMinMaxChoice(selectedIngredient)) then
    begin
       if EntTypeStringToEnum(ProductsDB.ClientEntityTableEntityType.Value) = etChoice then
       begin
         ShowMessage('A multi-select choice cannot be added to a choice.');
         Result := False;
         exit;
       end;

       if ProductsDB.IsUsedAsIngredient(ProductsDB.ClientEntityTableEntityCode.Value) then
       begin
         ShowMessage('A multi-select choice may only be added to a top level product.');
         Result := False;
         Exit;
       end;
    end;

    if ProductsDB.ContainsChoice(selectedIngredient, True {MinMaxChoiceOnly}) then
    begin
      ShowMessage('A product that contains a multi-select choice may not be added as an ingredient.');
      Result := False;
    end;
  end;

  function PassesNestedConverstaionalOrderingValidations: Boolean;
  begin
    Result := True;
    if (ProductsDB.isMinMaxChoice(selectedIngredient)) then
    begin
      //A choice cannot contain a choice  with defaults as the user will not
      //see the default and if it removed there would be insufficient indication to the kitchen
      if (ProductsDB.CurrentEntityType = etChoice)
      and ProductsDB.HasDefaultIngredients(selectedIngredient)
      and (EntTypeStringToEnum(SelectEntityTableEntityType.Value) = etChoice) then
      begin
        MessageDlg('A choice containing default ingredients may not be added to a product that is itself a choice.',
          mtError,
          [mbOK],0);
        Result := False;
      end;
    end;
  end;

  //The following common validation is slightly looser in this version than in previous incarnations:
  //the old validation checked for ContainsMinMaxChoice wheras the correct tighter condition is to
  //check for containment of any choice.
  function PassesCommonConverstaionalOrderingValidations: Boolean;
  begin
    Result := True;
    // if parent product is a default ingredient in a min/max choice check that selected entity is not a choice and does not contain any choices.
    if (ProductsDB.isIngredientDefault(ProductsDB.ClientEntityTableEntityCode.Value)) and
       (     (EntTypeStringToEnum(SelectEntityTableEntityType.Value) = etChoice)
          or (ProductsDB.ContainsChoice(selectedIngredient))) then
    begin
      MessageDlg('A choice (or a product that contains a choice) cannot be added to a product that is a default ingredient',
        mtError,
        [mbOK],0);
      Result := False;
    end;
  end;

begin
  //TODO: the validation is done similar to a case satement, i.e. only one validation is
  //ever reported even though several might apply.  Should this be revamped to do all checks
  //sequentially and report them all if necessary?
  Result := True;
  selectedIngredient := SelectEntityTableEntityCode.Value;

  if checkProductFlagOnAddingAsIngredient(selectedIngredient) then
  begin
    ShowMessage('A product with "Is Admission" enabled may not be an ingredient of any other product.');
    Result := false;
    Exit;
  end;

  case ProductsDB.ConversationalOrderingMode of
    comNonNested: Result := PassesNonNestedConversationalOrderingValidations;
    comNested: Result := PassesNestedConverstaionalOrderingValidations;
  end;

  
  if not Result then Exit;

  Result := PassesCommonConverstaionalOrderingValidations;
end;


procedure TSelectEntityForm.okButtonClick(Sender: TObject);
begin
  if ApplyMinMaxChoiceChecks then
    ModalResult := mrOk
  else
    ModalResult := mrNone;
end;

procedure TSelectEntityForm.FormShortCut(var Msg: TWMKey;
  var Handled: Boolean);
var
  Shift : TShiftState;
  ShiftCtl : TShiftState;
begin
  Shift := KeyDataToShiftState(Msg.KeyData);
  ShiftCtl := Shift * [ssShift, ssAlt, ssCtrl];

  // Ctrl+F - filter
  if (Msg.CharCode = Ord('F')) and (ShiftCtl = [ssCtrl]) then begin
    try
      Handled := true;
      EntityLookupFrame.showEditFilterForm;
    except
      on EAbort do ;
    end;
  end;

  if not doesControlContainFocus( EntityLookupFrame.FindLineItemBox ) then begin
    // F3 - jump to search box
    if (Msg.CharCode = VK_F3) and (ShiftCtl = []) then begin
      Handled := true;
      try
        PrizmSetFocus( EntityLookupFrame.SearchTextEdit );
      except
        on EAbort do ;
      end;
    end;
  end;
end;

procedure TSelectEntityForm.setCaptionAndHelpId(
  newCaption, newPrompt: string; helpId: Integer);
begin
  Caption := newCaption;
  PromptLabel.Caption := newPrompt;
  setHelpContextID( self, helpId );
end;

function TSelectEntityForm.isSelectedSoldByWeight: boolean;
begin
  isSelectedSoldByWeight := SelectEntityTable.FieldByName('SoldByWeight').AsBoolean;
end;

function TSelectEntityForm.isSelectedUsingContainers: boolean;
var
  Query: TADOQuery;
begin
  Query := TADOQuery.Create(Self);
  Query.Connection := dmado.AztecConn;
  try
    with Query do
    begin
      SQL.Add('select count(*) as ContainerCount');
      SQL.Add('from products p');
      SQL.Add('join portions po');
      SQL.Add('on p.EntityCode = po.EntityCode');
      SQL.Add('where po.ContainerID is not null');
      SQL.Add('and p.EntityCode = ' + FloatToStr(getSelectedEntityCode));

      Open;

      isSelectedUsingContainers :=FieldByName('ContainerCount').AsInteger > 0;

      Close;
    end;
  finally
    Query.Free;
  end;
end;

function TSelectEntityForm.checkProductFlagOnAddingAsIngredient(
  EntityCode: double): boolean;
begin
  // IsAdmission Product can not be assigned as a child if Flags are enabled
  Result := false;

  if SelectPPTable.Locate( 'EntityCode', EntityCode, [] ) then
    if(SelectPPTableIsAdmission.Value) then
      Result := true
    else
      Result := false
  else
    Result := false;

end;

end.
