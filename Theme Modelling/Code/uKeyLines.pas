unit uKeyLines;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, Buttons, DB,
  ADODB, Menus;

type
  TKeyLineType = (kltProduct=0, kltSubcat=1);

  TKeyLinesForm = class(TForm)
    gbxProduct: TGroupBox;
    gbxSubCategory: TGroupBox;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Label1: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    wwDBGridProduct: TwwDBGrid;
    wwDBGridSubcat: TwwDBGrid;
    wwDBGridKeyLine: TwwDBGrid;
    btnAddProduct: TSpeedButton;
    btnAddSubcat: TSpeedButton;
    dtProduct: TADODataSet;
    dsProduct: TDataSource;
    dtSubcat: TADODataSet;
    dsSubcat: TDataSource;
    gbxFindProduct: TGroupBox;
    edtFindProduct: TEdit;
    chkbxProductMidWordSearch: TCheckBox;
    btnFindPrevProduct: TButton;
    btnFindNextProduct: TButton;
    gbxFindSubcat: TGroupBox;
    edtFindSubcat: TEdit;
    chkbxSubcatMidWordSearch: TCheckBox;
    btnFindPrevSubcat: TButton;
    btnFindNextSubcat: TButton;
    btnRemoveItem: TButton;
    cmdInitialise: TADOCommand;
    dtKeyLine: TADODataSet;
    dsKeyLine: TDataSource;
    PopupMenu: TPopupMenu;
    AddToKeyLines: TMenuItem;
    dtKeyLineId: TLargeintField;
    dtKeyLineType: TIntegerField;
    dtKeyLineName: TStringField;
    dtKeyLineDivisionName: TStringField;
    dtKeyLineTypeName: TStringField;
    dtProductProductId: TLargeintField;
    dtProductSubcategoryId: TIntegerField;
    dtProductProductName: TStringField;
    dtProductSubcategoryName: TStringField;
    dtProductDivisionName: TStringField;
    dtSubcatSubcategoryId: TIntegerField;
    dtSubcatSubcategoryName: TStringField;
    dtSubcatDivisionName: TStringField;
    pnlWarning: TPanel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure wwDBGridProductTitleButtonClick(Sender: TObject; AFieldName: String);
    procedure wwDBGridSubcatTitleButtonClick(Sender: TObject; AFieldName: String);
    procedure btnAddItemClick(Sender: TObject);
    procedure wwDBGridDblClick(Sender: TObject);
    procedure btnRemoveItemClick(Sender: TObject);
    procedure AddToKeyLinesClick(Sender: TObject);
    procedure dtKeyLineCalcFields(DataSet: TDataSet);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    FKeyLinesChanged: boolean;
    function KeyLineTypeToStr(KeyLineType: TKeyLinetype): string;
    procedure AddCurrentProduct;
    procedure AddCurrentSubcat;
    procedure AddKeyLineItem(ItemType: TKeyLineType);
    function IsKeyLine(ItemId: Int64; Itemtype: TKeyLineType): boolean;
    function ProductAndParentSubcategorySelected: boolean;
  end;

implementation

uses uADO, uGlobals, uGuiUtils, uAztecLog, uFormNavigate;

{$R *.dfm}

const
  MAX_KEY_LINES = 10;

procedure TKeyLinesForm.FormCreate(Sender: TObject);
var epostext : String;
begin
  Log('Key Lines form created');

  FKeyLinesChanged := False;

  //Note: Can't use parameters because the temp tables created aren't
  cmdInitialise.CommandText := StringReplace(cmdInitialise.CommandText, ':SiteId', IntToStr(uGlobals.SiteCode), [rfIgnoreCase]);
  cmdInitialise.Execute;

  dtProduct.Open;
  dtSubcat.Open;
  dtKeyLine.Open;

  pnlWarning.Visible := ProductAndParentSubcategorySelected;

  btnRemoveItem.Enabled := not(dtKeyLine.IsEmpty);

  uGuiUtils.setupSearchBox(gbxFindProduct, wwDBGridProduct, ['Product'], ['Product']);
  uGuiUtils.setupSearchBox(gbxFindSubcat, wwDBGridSubcat, ['Sub Category'], ['Sub Category']);

  if UKUSmode = 'US' then
     epostext := 'POS'
  else
     epostext := 'EPoS';

  Label1.Caption := 'Select up to 10 "Key Line" products and sub categories whose sales totals will be displayed on selected '+
                     epostext +' reports.';

  Label2.Caption := 'Warning: Both a product and its parent sub category have been chosen as Key Lines. This is allowed but it'+
                    ' means that the overall Key Line sales total will not be displayed on the '+epostext+' reports. This is'+
                    ' because a total could be misleading as it would include the sales of the product twice.';

end;

procedure TKeyLinesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dtSubcat.Close;
  dtProduct.Close;

  with dmADO.adocRun do
  begin
    CommandText :=
      'IF OBJECT_ID(''tempdb..#SellableProducts'') IS NOT NULL ' +
      '  DROP TABLE #SellableProducts ' +
      'IF OBJECT_ID(''tempdb..#KeyLine'') IS NOT NULL ' +
      '  DROP TABLE #KeyLine ';
    Execute;
  end;

  Log('Key Lines form closed');
  Nav.MoveBack;
end;

procedure TKeyLinesForm.wwDBGridProductTitleButtonClick(Sender: TObject; AFieldName: String);
var currProductId: Int64;
begin
  with dtProduct do
  begin
    if RecordCount > 0 then
    begin
      currProductId := FieldByName('ProductId').Value;
      IndexFieldNames := AFieldName;
      Locate('ProductId', currProductId, []);
    end;
  end;
end;

procedure TKeyLinesForm.wwDBGridSubcatTitleButtonClick(Sender: TObject; AFieldName: String);
var currSubcategoryId: integer;
begin
  with dtSubcat do
  begin
    if RecordCount > 0 then
    begin
      currSubcategoryId := FieldByName('SubcategoryId').Value;
      IndexFieldNames := AFieldName;
      Locate('SubcategoryId', currSubcategoryId, []);
    end;
  end;
end;

function TKeyLinesForm.KeyLineTypeToStr(KeyLineType: TKeyLinetype): string;
begin
  case KeyLineType of
    kltProduct: result := 'Product';
    kltSubcat: result := 'Sub Category';
    else result := '';
  end;
end;

function TKeyLinesForm.IsKeyLine(ItemId: Int64; Itemtype: TKeyLineType): boolean;
begin
  with dmADO.adoqRun do
  try
    SQL.Text :=
     'SELECT COUNT(*) AS [Count] FROM #KeyLine WHERE ID = ' +  IntToStr(ItemId) +
                                               ' AND Type = ' + IntToStr(Ord(Itemtype));
    Open;
    Result := (FieldByname('Count').AsInteger > 0);
  finally
    Close;
  end;
end;

procedure TKeyLinesForm.AddCurrentProduct;
begin
  if not IsKeyLine(TLargeIntField(dtProduct.FieldByName('ProductId')).AsLargeInt, kltProduct) then
  begin
    with dmADO.adocRun do
    begin
      CommandText :=
        'INSERT #KeyLine (Id, Name, DivisionName, Type) ' +
        'VALUES (' +
           dtProduct.FieldByName('ProductId').AsString + ', ' +
           QuotedStr(dtProduct.FieldByName('ProductName').AsString) + ', ' +
           QuotedStr(dtProduct.FieldByName('DivisionName').AsString) + ', ' +
           IntToStr(Ord(kltProduct)) + ')';
      Execute;
    end;

    Log('Product "' + dtProduct.FieldByName('ProductName').AsString + '" (Id:' +
        dtProduct.FieldByName('ProductId').AsString + ') added to key lines list by user');
  end;
end;

procedure TKeyLinesForm.AddCurrentSubcat;
begin
  if not IsKeyLine(dtSubcat.FieldByName('SubcategoryId').AsInteger, kltSubcat) then
  begin
    with dmADO.adocRun do
    begin
      CommandText :=
        'INSERT #KeyLine (Id, Name, DivisionName, Type) ' +
        'VALUES (' +
           dtSubcat.FieldByName('SubcategoryId').AsString + ', ' +
           QuotedStr(dtSubcat.FieldByName('SubcategoryName').AsString) + ', ' +
           QuotedStr(dtSubcat.FieldByName('DivisionName').AsString) + ', ' +
           IntToStr(Ord(kltSubcat)) + ')';
      Execute;
    end;

    Log('Sub Category "' + dtSubcat.FieldByName('SubcategoryName').AsString + '" (Id:' +
        dtSubcat.FieldByName('SubcategoryId').AsString + ') added to key lines list by user');
  end;
end;

procedure TKeyLinesForm.AddKeyLineItem(ItemType: TKeyLineType);
begin
  if dtKeyLine.RecordCount = MAX_KEY_LINES then
  begin
    ShowMessage('The limit of ' + IntToStr(MAX_KEY_LINES) + ' Key Lines has been reached.');
    log('The limit of ' + IntToStr(MAX_KEY_LINES) + ' Key Lines has been reached.');
    Exit;
  end;

  dtKeyLine.DisableControls;
  dtKeyLine.Close;

  if Itemtype = kltProduct then
    AddCurrentProduct
  else
    AddCurrentSubcat;

  dtKeyLine.EnableControls;
  dtKeyLine.Open;

  btnRemoveItem.Enabled := True;
  pnlWarning.Visible := ProductAndParentSubcategorySelected;
  FKeyLinesChanged := True;
end;

procedure TKeyLinesForm.btnAddItemClick(Sender: TObject);
begin
  if Sender = btnAddProduct then
    AddKeyLineItem(kltProduct)
  else
    AddKeyLineItem(kltSubcat);
end;

procedure TKeyLinesForm.wwDBGridDblClick(Sender: TObject);
begin
  if Sender = wwDBGridProduct then
    AddKeyLineItem(kltProduct)
  else
    AddKeyLineItem(kltSubcat);
end;

procedure TKeyLinesForm.AddToKeyLinesClick(Sender: TObject);
begin
  if PopupMenu.PopupComponent = wwDBGridProduct then
    AddKeyLineItem(kltProduct)
  else
    AddKeyLineItem(kltSubcat);
end;

procedure TKeyLinesForm.btnRemoveItemClick(Sender: TObject);
begin
  if MessageDlg('Are you sure you want to remove "' +
                StringReplace(dtKeyLine.FieldByName('Name').AsString, '&', '&&', [rfReplaceAll]) +
                '" from the Key Lines list ?',
                mtConfirmation, [mbYes,mbNo], 0) = mrYes then
  begin
    Log(KeyLineTypeToStr(TKeyLineType(dtKeyLine.FieldByName('Type').AsInteger)) + ' "' + dtKeyLine.FieldByName('Name').AsString +
        '" (Id:' + dtKeyLine.FieldByName('Id').AsString + ') removed from key lines list by user');
    dtKeyLine.Delete;
    pnlWarning.Visible := ProductAndParentSubcategorySelected;
    FKeyLinesChanged := True;
  end;

  btnRemoveItem.Enabled := not(dtKeyLine.IsEmpty);
end;

procedure TKeyLinesForm.dtKeyLineCalcFields(DataSet: TDataSet);
begin
  dtKeyLineTypeName.Value := KeyLineTypeToStr(TKeyLinetype(dtKeyLineType.Value));
end;

procedure TKeyLinesForm.btnOkClick(Sender: TObject);
var RecordsAffected: integer;
begin
  Log('Key Lines OK button clicked');

  dmADO.BeginTransaction;

  try try
    with dmADO.adocRun do
    begin
      CommandText :=
        'DELETE KeyLine ' +
        'WHERE NOT EXISTS(SELECT * FROM #KeyLine WHERE Id = KeyLine.Id AND Type = KeyLine.Type) ';
      Execute(RecordsAffected, null);
      Log(InttoStr(RecordsAffected) + ' record(s) deleted from KeyLine table');

      CommandText :=
        'INSERT KeyLine (SiteId, Id, Type) ' +
        'SELECT ' + IntToStr(uGlobals.SiteCode) + ', Id, Type ' +
        'FROM #KeyLine ' +
        'WHERE NOT EXISTS(SELECT * FROM KeyLine WHERE Id = #KeyLine.Id AND Type = #KeyLine.Type) ';
      Execute(RecordsAffected, null);
      Log(InttoStr(RecordsAffected) + ' record(s) added to KeyLine table');
    end;

    dmADO.CommitTransaction;

    if  FKeyLinesChanged and (dtKeyLine.RecordCount > 0) then
      MessageDlg('Sales totals for the chosen key lines will be displayed at the end of selected'#13#10 +
                 'EPoS reports the next time the report is produced on a terminal.'#13#10#13#10 +
                 'There is no need to perform a ''Send to Pos'' operation to enable this.', mtInformation, [mbOk], 0 );
  except
    on E:exception do
    begin
      Log('Error saving Key Line changes: ' + E.ClassName + ' ' + E.Message);
      ShowMessage('Failed to save changes due to an unexpected error.'#13#10#13#10 +
                  'Error message: ' + E.ClassName + ' ' + E.Message);
    end;
  end;
  finally
    if dmADO.InTransaction then dmADO.RollbackTransaction;
  end;

  Close;
end;

procedure TKeyLinesForm.btnCancelClick(Sender: TObject);
begin
  Log('Key Lines Cancel button clicked');
  Close;
end;

//Returns True if at least one product also has its subcategory selected as a key line.
function TKeyLinesForm.ProductAndParentSubcategorySelected: boolean;
begin
  with dmADO.qRun do
  try
    SQL.Text :=
      'SELECT k2.Id AS SubcategoryId ' +
      'FROM ' +
      '  ( ' +
      '   SELECT DISTINCT s.Id ' +
      '   FROM #KeyLine k1 ' +
      '     INNER JOIN Products p ON k1.Id = p.EntityCode AND k1.Type = 0 /*Product*/ ' +
      '     INNER JOIN ac_ProductSubcategory s ON p.[Sub-Category Name] = s.Name ' +
      '  ) Subcats ' +

      '  INNER JOIN #Keyline k2 ON Subcats.Id = k2.Id AND k2.type = 1 /*Subcategory*/';
    Open;
    Result := (RecordCount > 0);
  finally
    Close;
  end;
end;

end.
