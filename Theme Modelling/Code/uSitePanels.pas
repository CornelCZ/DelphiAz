unit uSitePanels;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ADODB, StdCtrls, uGridSortHelper, Wwdbigrd,
  Wwdbgrid;

type
  TSitePanels = class(TForm)
    Label1: TLabel;
    qGetSitePanels: TADOQuery;
    dsSitePanels: TDataSource;
    btCancel: TButton;
    btCustomise: TButton;
    qGetSitePanelsName: TStringField;
    qGetSitePanelsDescription: TStringField;
    qGetSitePanelssitecode: TSmallintField;
    qGetSitePanelssubpanelid: TLargeintField;
    dbgSitePanels: TwwDBGrid;
    qSetup: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCustomiseClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure dbgSitePanelsDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    SitePanelsSortHelper: TGridSortHelper;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uADO, uDesignSitePanel, uAztecLog, uGlobals, uSimpleLocalise,
  uFormNavigate;

{$R *.dfm}

procedure TSitePanels.FormShow(Sender: TObject);
begin
  if HelpExists then
    SetHelpContextID(self,AZTM_SITE_PANEL);
  Log('Form Show ' + Caption);

  qSetup.ExecSQL;
  qGetSitePanels.Active := True;
  SitePanelsSortHelper.Reset;
end;

procedure TSitePanels.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
  qGetSitePanels.Active := false;
  dmADO.AztecConn.Execute('if object_id(''tempdb..#panelset'') is not null '+
    'drop table #panelset');
  Nav.MoveBack;
end;

procedure TSitePanels.btCustomiseClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  if qGetSitePanels.RecordCount = 0 then
    raise exception.create('Please pick an item first!');
  screen.Cursor := crAppStart;
  application.ProcessMessages;
  with TDesignSitePanel.create(self) do try
    SubPanelID := TLargeintfield(qGetSitePanels.fieldbyname('Subpanelid')).aslargeint;
    SiteCode := qGetSitePanels.fieldbyname('sitecode').asinteger;
    Setup;
    showmodal;
  finally
    free;
  end;
end;

procedure TSitePanels.btCancelClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  Close;
end;

procedure TSitePanels.dbgSitePanelsDblClick(Sender: TObject);
begin
  btCustomise.Click;
end;

procedure TSitePanels.FormCreate(Sender: TObject);
begin
  LocaliseForm(self);
  SitePanelsSortHelper := TGridSortHelper.create;
  SitePanelsSortHelper.Initialise(dbgSitePanels);
end;

procedure TSitePanels.FormDestroy(Sender: TObject);
begin
  SitePanelsSortHelper.Free;
end;

end.
