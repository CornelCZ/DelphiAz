unit uCourseAndTaxFrame;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, uAztecDBComboBox, uAztecDBLookupBox, DB, ADODB, Variants, uDatabaseADO,
  DBCtrls, ExtCtrls, Mask, wwdbedit;

type
  TTCoursesAndTaxRulesFrame = class(TFrame)
    TaxRuleGroupBox: TGroupBox;
    TaxRuleLabel1: TLabel;
    TaxRuleLabel2: TLabel;
    TaxRuleLabel3: TLabel;
    TaxRuleLabel4: TLabel;
    dsCourses: TDataSource;
    AztecDBLookupBox1: TAztecDBLookupBox;
    AztecDBLookupBox2: TAztecDBLookupBox;
    AztecDBLookupBox3: TAztecDBLookupBox;
    AztecDBLookupBox4: TAztecDBLookupBox;
    lblChoicePrintMode: TLabel;
    cmbChoicePrintMode: TDBComboBox;
    cbRollupPrice: TDBCheckBox;
    childBehaviourGroupBox: TGroupBox;
    cbFollowCourse: TDBCheckBox;
    tblCourses: TADODataSet;
    PricingRadioGroup: TDBRadioGroup;
    gbCourse: TGroupBox;
    cmbbxCourses: TAztecDBLookupBox;
    lblAlcohol: TLabel;
    dbedAlcohol: TDBEdit;
    procedure cmbbxCoursesCreateNew(Sender: TObject);
    procedure AztecDBLookupBoxExit(Sender: TObject);
    procedure TaxRuleSelected(Sender: TObject);
    procedure dbedAlcoholKeyPress(Sender: TObject; var Key: Char);
  private
    FEntityCode: double;

    procedure SetShowTaxRules(const value : boolean);
    procedure SetShowCoursesCombo(const value : boolean);
    procedure SetShowChoicePrintMode(const value : boolean);
    procedure SetShowRollupPrice(const value : boolean);
    procedure SetShowAlcohol(const value : boolean);
    procedure excludeTaxRulesAlreadyInUse;
    procedure checkChildBehaviourGroupBoxVisible;
    function IsInitialisedForCurrentProduct: boolean;
  public
    constructor Create(AOwner: TComponent); override;
    property ShowTaxRules : boolean write SetShowTaxRules;
    property ShowCoursesCombo : boolean write SetShowCoursesCombo;
    property ShowChoicePrintMode : boolean write SetShowChoicePrintMode;
    property ShowRollupPrice : boolean write SetShowRollupPrice;
    property ShowAlcohol : boolean write SetShowAlcohol;
    procedure setupStaticPickLists;
    procedure EnsureInitialisedForCurrentProduct;
  end;

implementation

uses uMaintCourses, uGUIUtils, uADO;

{$R *.dfm}

constructor TTCoursesAndTaxRulesFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FEntityCode := -1;
end;


procedure TTCoursesAndTaxRulesFrame.cmbbxCoursesCreateNew(Sender: TObject);
begin
  fMaintCourses := TfMaintCourses.Create(Self);

  try
    if fMaintCourses.ShowModal = mrOk then begin
      TAztecDBLookupBox( Sender ).DataSource.Edit;
      TAztecDBLookupBox( Sender ).Field.AsInteger := fMaintCourses.NewIx;
    end;
  finally
    fMaintCourses.Free;
  end;
end;

procedure TTCoursesAndTaxRulesFrame.AztecDBLookupBoxExit(Sender: TObject);
begin
  with Sender as TAztecDBLookupBox do
  begin
    if Text = '' then
    begin
      if not (DataSource.DataSet.State in [dsInsert, dsEdit]) then
      begin
        DataSource.DataSet.Edit;
        DataSource.DataSet.FieldByName(DataField).Clear;
        DataSource.DataSet.Post;
      end
      else
      begin
        DataSource.DataSet.FieldByName(DataField).Clear;
      end;
    end;
  end;
end;

procedure TTCoursesAndTaxRulesFrame.SetShowTaxRules(const value : boolean);
begin
  TaxRuleGroupBox.Visible := value;
end;

procedure TTCoursesAndTaxRulesFrame.SetShowCoursesCombo(const value : boolean);
begin
  gbCourse.Visible := value;
  cbFollowCourse.Visible := value;
  PricingRadioGroup.Visible := value;
  checkChildBehaviourGroupBoxVisible;
end;

procedure TTCoursesAndTaxRulesFrame.SetShowChoicePrintMode(
  const value: boolean);
begin
  lblChoicePrintMode.Visible := value;
  cmbChoicePrintMode.Visible := value;
  checkChildBehaviourGroupBoxVisible;
end;

procedure TTCoursesAndTaxRulesFrame.SetShowRollupPrice(
  const value: boolean);
begin
  cbRollupPrice.Visible := value;
  checkChildBehaviourGroupBoxVisible;
end;

procedure TTCoursesAndTaxRulesFrame.checkChildBehaviourGroupBoxVisible;
begin
  childBehaviourGroupBox.Visible :=
    cbRollupPrice.Visible or cmbChoicePrintMode.Visible or cbFollowCourse.Visible;
end;

procedure TTCoursesAndTaxRulesFrame.setupStaticPickLists;
begin
  cmbChoicePrintMode.Items := productsDB.childPrintModesStringList;
end;

procedure TTCoursesAndTaxRulesFrame.EnsureInitialisedForCurrentProduct;
begin
  if IsInitialisedForCurrentProduct then
    Exit;
    
  excludeTaxRulesAlreadyInUse;
  FEntityCode := ProductsDB.CurrentEntityCode;
end;

procedure TTCoursesAndTaxRulesFrame.TaxRuleSelected(
  Sender: TObject);
begin
  AztecDBLookupBoxExit(Sender);

  excludeTaxRulesAlreadyInUse;
end;

procedure TTCoursesAndTaxRulesFrame.excludeTaxRulesAlreadyInUse;
var
  ExcludeItems: array[1..4] of string;
begin
  excludeItems[1] := AztecDBLookupBox1.Text;
  excludeItems[2] := AztecDBLookupBox2.Text;
  excludeItems[3] := AztecDBLookupBox3.Text;
  excludeItems[4] := AztecDBLookupBox4.Text;

  AztecDBLookupBox1.RemoveItems(ExcludeItems);
  AztecDBLookupBox2.RemoveItems(ExcludeItems);
  AztecDBLookupBox3.RemoveItems(ExcludeItems);
  AztecDBLookupBox4.RemoveItems(ExcludeItems);
end;

procedure TTCoursesAndTaxRulesFrame.SetShowAlcohol(const value: boolean);
begin
  lblAlcohol.Visible := value;
  dbedAlcohol.Visible := Value;
end;

procedure TTCoursesAndTaxRulesFrame.dbedAlcoholKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not((Key in ['0'..'9', '.']) or (ord(Key) in [VK_BACK, VK_DELETE, VK_ESCAPE, VK_LEFT, VK_RIGHT])) then
    Key := #0
  else if (Key = '.') and (Pos('.', dbedAlcohol.Text) <> 0) then
    Key := #0
  else if (Key in ['0'..'9']) and (Pos('.',dbedAlcohol.Text) <> 0)
    and (Pos('.',dbedAlcohol.Text) = (Length(dbedAlcohol.Text) - 2))
    and (dbedAlcohol.SelLength = 0)  then
    Key := #0;
end;

function TTCoursesAndTaxRulesFrame.IsInitialisedForCurrentProduct: boolean;
begin
  Result := (productsDB.CurrentEntityCode = FEntityCode);
end;

end.
