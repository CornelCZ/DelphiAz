unit uConfigure;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, Grids, Wwdbigrd, Wwdbgrid,
  DB, ADODB;

const
  VIEW_COST_PRICES = 'DisplayCostPrices';
  VIEW_ALL_SUPPLIER_PRODUCTS = 'ViewAllProducts';
  EDIT_COST_PRICES = 'EditCostPrices';
  ALLOW_FREE_ITEMS = 'AddFreeItems';

type
  PEPluginLogFunction = procedure(text: string) { of object}; stdcall;
  AztecCommsMasterReconfigR = procedure(LogFunction: PEPluginLogFunction; SiteCode: integer;privdir: string;
    var Success: boolean); stdcall;
  TfrmConfigure = class(TForm)
    ButtonPanel: TPanel;
    BitBtn1: TBitBtn;
    Panel1: TPanel;
    Button3: TButton;
    ViewAllSuppProdsBtn: TButton;
    Button4: TButton;
    Button5: TButton;
    CreateMaskBtn: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ViewAllSuppProdsBtnClick(Sender: TObject);
    procedure CreateMaskBtnClick(Sender: TObject);
  private
    { Private declarations }
    procedure ShowSuppliersForm(FieldName, FormCaption: string);
  public
    { Public declarations }
  end;
procedure PluginLog(text:string) ;stdcall;
var
  frmConfigure: TfrmConfigure;

implementation

uses uFullReCfg, uGlobals, useful, uLog, uADO, uSuppliers, uInvoiceNumMask;

{$R *.dfm}
procedure PluginLog(text:string) ;stdcall;
begin
  Log.event(text);
end;

procedure TfrmConfigure.Button1Click(Sender: TObject);
begin
  ShowSuppliersForm('Send Deliveries To Till', 'Send Deliveries To Till');
end;

procedure TfrmConfigure.ShowSuppliersForm(FieldName, FormCaption: string);
var
  frmSuppliers: TfrmSuppliers;
begin
  frmSuppliers := TfrmSuppliers.Create(Self);

  if FieldName = VIEW_COST_PRICES then
  begin
    if purchHelpExists then
      setHelpContextID(frmSuppliers, HLP_VIEW_COST_PRICES);
  end
  else if FieldName = EDIT_COST_PRICES then
  begin
    if purchHelpExists then
      setHelpContextID(frmSuppliers, HLP_UPDATE_COST_PRICES);
  end
  else if FieldName = ALLOW_FREE_ITEMS then
  begin
    if purchHelpExists then
      setHelpContextID(frmSuppliers, HLP_ADD_FREE_ITEMS);
  end
  else if FieldName = VIEW_ALL_SUPPLIER_PRODUCTS then
  begin
    if purchHelpExists then
      setHelpContextID(frmSuppliers, HLP_VIEW_ALL_SUPPLIERS_PRODUCTS);
  end;

  try
    frmSuppliers.Caption := FormCaption;
    frmSuppliers.EditFieldName := FieldName;
    frmSuppliers.ShowModal;
  finally
    frmSuppliers.Free;
  end;
end;

procedure TfrmConfigure.Button3Click(Sender: TObject);
begin
  ShowSuppliersForm(VIEW_COST_PRICES, 'Allow View Cost Prices');
end;

procedure TfrmConfigure.Button4Click(Sender: TObject);
begin
  ShowSuppliersForm(EDIT_COST_PRICES, 'Allow Edit Cost Prices');
end;

procedure TfrmConfigure.Button5Click(Sender: TObject);
begin
  ShowSuppliersForm(ALLOW_FREE_ITEMS, 'Allow Free Items');
end;

procedure TfrmConfigure.FormCreate(Sender: TObject);
begin
  log.event('HO Configure Form FormCreate');
  CreateMaskBtn.Caption := 'Create ' + GetLocalisedName(lsInvoice) + ' Number Mask';
  if purchHelpExists then
    setHelpContextID(self, HLP_HO_CONFIGURATION);
end;

procedure TfrmConfigure.ViewAllSuppProdsBtnClick(Sender: TObject);
begin
  ShowSuppliersForm(VIEW_ALL_SUPPLIER_PRODUCTS, 'Allow View All Suppliers Products');
end;

procedure TfrmConfigure.CreateMaskBtnClick(Sender: TObject);
var
  frmInvoiceNumMask: TfrmInvoiceNumMask;
begin
  frmInvoiceNumMask := TfrmInvoiceNumMask.Create(Self);
  try
    frmInvoiceNumMask.ShowModal;
  finally
    frmInvoiceNumMask.Free;
  end;
end;

end.
