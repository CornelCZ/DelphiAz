unit uInvMenu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBTables, Db, ADODB, Math,
  ComObj,Variants;

type
  Tfinvmenu = class(TForm)
    btnNewInv: TBitBtn;
    Label1: TLabel;
    btnEditInv: TBitBtn;
    BtnViewCurr: TBitBtn;
    btnViewAcc: TBitBtn;
    btnMainMenu: TBitBtn;
    btnAuditInvoice: TBitBtn;
    procedure btnNewInvClick(Sender: TObject);
    procedure btnEditInvClick(Sender: TObject);
    procedure BtnViewCurrClick(Sender: TObject);
    procedure btnViewAccClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure WMSysCommand(var Msg: TWMSysCommand);
      message WM_SYSCOMMAND;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAuditInvoiceClick(Sender: TObject);
  end;

var
  InvoiceMenu: Tfinvmenu;

implementation

uses
  uMainMenu, uGlobals, uLog, uInvoiceManager, uInvFrm;

{$R *.DFM}

procedure Tfinvmenu.FormCreate(Sender: TObject);
begin
  log.event('finvmenu; FormCreate');

  if purchHelpExists then
    setHelpContextID(self, HLP_DELIVERY_NOTE_ENTRY);
end;

procedure Tfinvmenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  log.event('finvmenu; FormClose');
end;

procedure Tfinvmenu.FormShow(Sender: TObject);
var
  tmpLocalisedName: String;
begin
  log.Event('finvmenu; FormShow');
  tmpLocalisedName := GetLocalisedName(lsInvoice);
  self.Caption := tmpLocalisedName + ' Menu';
  Label1.Caption := tmpLocalisedName + ' Entry';
  if UKUSmode = 'US' then
    btnNewInv.Caption := '&New ' + tmpLocalisedName
  else
    btnNewInv.Caption := '&Add ' + tmpLocalisedName;

  btnEditInv.Caption := '&Edit ' + tmpLocalisedName;
  btnAuditInvoice.Caption := 'A&udit ' + tmpLocalisedName;
  btnViewCurr.Caption := 'View &Current ' + tmpLocalisedName + 's';
  btnViewAcc.Caption := 'View &Accepted ' + tmpLocalisedName + 's';

  btnViewCurr.Enabled := PurViewCurrent;
  btnViewAcc.Enabled := PurViewAccepted;
  // Job 16222
  if isMaster and (not isSite) then
  begin
    btnEditInv.Enabled := False;
    btnNewInv.Enabled := False;
    btnAuditInvoice.Enabled := False;
  end
  else
  begin
    btnAuditInvoice.Enabled := PurAudit;
    btnEditInv.Enabled := PurEdit;
    btnNewInv.Enabled := PurAdd;
    // end job 16222
  end;
end;

procedure Tfinvmenu.btnNewInvClick(Sender: TObject);
begin
  log.event('finvmenu; New Invoice button pressed');
  InvoiceManager.CreateNewInvoice(self);
end;

procedure Tfinvmenu.btnEditInvClick(Sender: TObject);
begin
  log.event('finvmenu; Edit Invoice button pressed');
  InvoiceManager.OpenInvoice(TASK_EDIT, Self);
end;

procedure Tfinvmenu.btnAuditInvoiceClick(Sender: TObject);
begin
  log.event('finvmenu; Audit Invoice button pressed');
  InvoiceManager.OpenInvoice(TASK_AUDIT, Self);
end;

procedure Tfinvmenu.BtnViewCurrClick(Sender: TObject);
begin
  log.event('finvmenu; View Current Invoices button pressed');
  InvoiceManager.OpenInvoice(TASK_VIEW_CURR, Self);
end;

procedure Tfinvmenu.btnViewAccClick(Sender: TObject);
begin
  log.event('finvmenu; View Accepted Invoices button pressed');
  InvoiceManager.OpenInvoice(TASK_VIEW_ACC, Self);
end;

procedure Tfinvmenu.WMSysCommand(var Msg: TWMSysCommand);
begin
  if (Msg.CmdType = SC_MINIMIZE) then
    Application.Minimize
  else
    inherited;
end;


end.
