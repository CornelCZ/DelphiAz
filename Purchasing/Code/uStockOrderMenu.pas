unit uStockOrderMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmStockOrderMenu = class(TForm)
    btnOrders: TButton;
    btnSchedule: TButton;
    btnExit: TButton;
    btnSupSet: TButton;
    procedure btnOrdersClick(Sender: TObject);
    procedure btnScheduleClick(Sender: TObject);
    procedure btnSupSetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure pcTypeOptions;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStockOrderMenu: TfrmStockOrderMenu;

implementation

uses
  OrderSummary, schedule, SupplierSettings, uGlobals;

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TfrmStockOrderMenu.btnOrdersClick(Sender: TObject);
var
  Dlg : TfrmOrderSummary;
begin
  Dlg := nil;
  try
    Dlg := TfrmOrderSummary.Create(self);
    Dlg.ShowModal;
  finally
    Dlg.Free;
  end;
end;

//------------------------------------------------------------------------------
procedure TfrmStockOrderMenu.btnScheduleClick(Sender: TObject);
var
  ScheduleDialog : TfrmSchedule;
begin
  ScheduleDialog := TfrmSchedule.Create(Self);

  try
    ScheduleDialog.ShowModal;
  finally
    ScheduleDialog.Free;
  end;
end;

//------------------------------------------------------------------------------
procedure TfrmStockOrderMenu.btnSupSetClick(Sender: TObject);
var
  ConfigurationDialog : TfrmSupplierConfig;
begin
  ConfigurationDialog := TfrmSupplierConfig.Create(Self);

  try
    ConfigurationDialog.ShowModal;
  finally
    ConfigurationDialog.Free;
  end;
end;

//------------------------------------------------------------------------------
procedure TfrmStockOrderMenu.pcTypeOptions;
begin
  if IsMaster then
  begin
    btnSupSet.Visible := True;
  end;
end;

//------------------------------------------------------------------------------
procedure TfrmStockOrderMenu.FormCreate(Sender: TObject);
begin
  pcTypeOptions;
  if purchHelpExists then
    setHelpContextID(self, HLP_STOCK_ORDER_MENU);
end;

//------------------------------------------------------------------------------
end.
