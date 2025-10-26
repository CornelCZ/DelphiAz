unit uSiteChoose;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, wwdblook, Db, DBTables, Wwquery, Buttons, ADODB;

type
  TfSiteChoose = class(TForm)
    Label1: TLabel;
    lookSites: TwwDBLookupCombo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    wwqSites: TADOQuery;
    AllSitesCheckBox: TCheckBox;
    procedure lookSitesCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure AllSitesCheckBoxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor myCreate(AOwner: TComponent; showAllSites: boolean);
  end;

var
  fSiteChoose: TfSiteChoose;

implementation

uses
  uADO, uGlobals, uLog;

{$R *.DFM}

constructor TfSiteChoose.myCreate(AOwner: TComponent; showAllSites: boolean);
begin
  Create(AOwner);
  AllSitesCheckBox.Visible := showAllSites;
end;

procedure TfSiteChoose.lookSitesCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  lookSites.PerformSearch;
end;

procedure TfSiteChoose.FormShow(Sender: TObject);
begin
  caption := 'Site Selection';
  log.event('fSiteChoose; FormShow: wwqSites opened: ' + wwqSites.SQL.Text);
  wwqSites.open;
  looksites.Text := wwqsites.FieldByName('site name').asstring;
end;

procedure TfSiteChoose.BitBtn1Click(Sender: TObject);
begin
  if not AllSitesCheckBox.Checked then
  begin
    siteName := wwqSites.FieldByName('site name').asstring;
    siteCode := wwqSites.FieldByName('site Code').AsInteger;
  end
  else
  begin
    siteName := 'All Sites';
    siteCode := 0;
  end;
end;

procedure TfSiteChoose.AllSitesCheckBoxClick(Sender: TObject);
begin
  if AllSitesCheckBox.Checked then
    lookSites.Enabled := false
  else
    lookSites.Enabled := true;
end;

procedure TfSiteChoose.FormCreate(Sender: TObject);
begin
  log.event('fSiteChoose; Form opened');
  if purchHelpExists then
    setHelpContextID(self, HLP_SITE_SELECTION);
end;

procedure TfSiteChoose.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  log.event('fSiteChoose; Form closed');
end;

end.
