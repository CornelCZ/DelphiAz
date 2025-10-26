unit uMiscMenu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, DBTables;

type
  Tfmiscmenu = class(TForm)
    btnProdAnalysis: TBitBtn;
    btnMainMenu: TBitBtn;
    Label1: TLabel;
    btnImportInvoices: TBitBtn;
    btnConfigure: TButton;
    procedure btnProdAnalysisClick(Sender: TObject);
    procedure btnMainMenuClick(Sender: TObject);
    procedure btnImportInvoicesClick(Sender: TObject);
    procedure WMSysCommand(var Msg: TWMSysCommand);
      message WM_SYSCOMMAND;
    procedure FormShow(Sender: TObject);
    procedure btnConfigureClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure RepositionButtons;
  public
    { Public declarations }
  end;

var
  fmiscmenu: Tfmiscmenu;

implementation

uses
  uMainMenu, uProdDlg, uAlliant, uGlobals, uConfigure, uLog, uADO;

{$R *.DFM}

procedure Tfmiscmenu.btnProdAnalysisClick(Sender: TObject);
begin
  log.event('fmiscMenu; Product Analysis button pressed');

  if not fmainmenu.WhatSite(True) then
    exit;

  fproddlg := tfProdDlg.Create(self);
  fproddlg.Top := self.Top;
  fproddlg.Left := self.Left;
  fproddlg.WindowState := self.WindowState;
  fproddlg.ShowModal;
  fproddlg.free;
end;


procedure Tfmiscmenu.btnMainMenuClick(Sender: TObject);
begin
  log.event('fmiscMenu; Main Menu button pressed');
  modalresult := mrOk;
end;

procedure Tfmiscmenu.btnImportInvoicesClick(Sender: TObject);
begin
  log.event('fmiscMenu; Import US Foods Invoices button pressed');
  fAlliant := TfAlliant.Create(self);
  fAlliant.ShowModal;
  fAlliant.free; 
end;

procedure Tfmiscmenu.WMSysCommand(var Msg: TWMSysCommand);
begin
  if (Msg.CmdType = SC_MINIMIZE) then
    Application.Minimize
  else
    inherited;
end;

procedure Tfmiscmenu.FormShow(Sender: TObject);
begin
  //Alliant link button only available on US Site at the moment
  if IsMaster then
  begin
    if IsSite then
    begin
      if UKUSmode = 'US' then
        // show all 4 buttons
      begin
        RepositionButtons;
        btnImportInvoices.Visible := true;
        btnConfigure.Visible := true;
      end
      else
      begin
        // show analysis, config, main menu buttons
        btnImportInvoices.Visible := false;
        btnConfigure.Visible := true;
      end
    end
    else
    begin
      // show analysis, config, main menu buttons
      btnImportInvoices.Visible := false;
      btnConfigure.Visible := true;
      if dmADO.IsAposDatabaseInstalled then
        btnConfigure.Enabled := FALSE
      else
        btnConfigure.Enabled := TRUE;
    end
  end
  else  // site only
  begin
    if UKUSMode = 'US' then
    begin
      // show analysis, import, main menu buttons
      btnImportInvoices.Visible := true;
      btnConfigure.Visible := false;
    end
    else
    begin
      // show analysis, main menu buttons
      btnImportInvoices.Visible := false;
      btnConfigure.Visible := false;
    end
  end;
end;

{ reposition the buttons in 2 rows, 2 cols }
procedure Tfmiscmenu.RepositionButtons;
begin
  btnProdAnalysis.Left := 28;
  btnProdAnalysis.Top := 123;
  btnImportInvoices.Left := 374;
  btnImportInvoices.Top := 123;
  btnConfigure.Left := 28;
  btnConfigure.Top := 298;
  btnMainMenu.Left := 374;
  btnMainMenu.Top := 298;
end;

procedure Tfmiscmenu.btnConfigureClick(Sender: TObject);
begin
  log.event('fmiscMenu; Configure button pressed');
  frmConfigure := TfrmConfigure.Create(self);
  frmConfigure.ShowModal;
end;

procedure Tfmiscmenu.FormCreate(Sender: TObject);
begin
  log.event('fmiscMenu; Miscellaneous Form opened');
  if purchHelpExists then
  begin
    if UKUSmode = 'UK' then
      setHelpContextID(self, HLP_MISC_UK)
    else
      setHelpContextID(self, HLP_MISC_US);
  end;
end;

procedure Tfmiscmenu.FormDestroy(Sender: TObject);
begin
  log.event('fmiscMenu; Miscellaneous Form closed');
end;

end.
