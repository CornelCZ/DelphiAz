unit uShowSitePriceReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TShowSitePriceReport = class(TForm)
    Label1: TLabel;
    cbSites: TComboBox;
    dtpFrom: TDateTimePicker;
    Label2: TLabel;
    dtpTo: TDateTimePicker;
    Label3: TLabel;
    btPreview: TButton;
    Button2: TButton;
    cbOrderByProduct: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btPreviewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbOrderByProductClick(Sender: TObject);
    procedure cbSitesCloseUp(Sender: TObject);
    procedure dtpFromCloseUp(Sender: TObject);
    procedure dtpToCloseUp(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ShowSitePriceReport: TShowSitePriceReport;

implementation

uses uADO, uSitePriceReport, uAztecLog;

{$R *.dfm}

procedure TShowSitePriceReport.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
  dmado.qRun.SQL.Text := 'select [site code], [site name] from siteaztec where deleted is null or deleted = ''N''';
  cbSites.clear;
  dmado.qrun.Open;
  while not dmado.qrun.Eof do
  begin
    cbSites.AddItem(dmado.qrun.fieldbyname('site name').asstring, tobject(dmado.qRun.FieldByName('site code').asinteger));
    dmado.qRun.next;
  end;
  dmado.qRun.close;
  dtpFrom.Date := date;
  dtpTo.date := date;
  if cbsites.items.Count = 0 then
  begin
    cbsites.AddItem('(No sites in system)',Tobject(-1));
    btPreview.enabled := false;
  end;
  cbsites.ItemIndex := 0;
end;

procedure TShowSitePriceReport.Button2Click(Sender: TObject);
begin
  ButtonClicked(Sender);
  modalresult := mrcancel;
end;

procedure TShowSitePriceReport.btPreviewClick(Sender: TObject);
begin
  buttonClicked(Sender);
  screen.cursor := crHourglass;
  application.processmessages;
  with TSitePriceReport.create(nil) do try
    SiteCode := integer(cbsites.items.objects[cbsites.itemindex]);
    Fromdate := dtpFrom.date;
    Todate := dtpTo.date;
    ByProduct := cbOrderByProduct.checked;
    PreviewReport;
  finally
    screen.Cursor := crDefault;
    free;
  end;
end;

//------------------------------------------------------------------------------
procedure TShowSitePriceReport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
end;

//------------------------------------------------------------------------------
procedure TShowSitePriceReport.cbOrderByProductClick(Sender: TObject);
begin
  if cbOrderByProduct.Checked then
    Log('Order Ny Product then Date Checked' )
  else
    Log('Order Ny Product then Date UnChecked' )
end;

procedure TShowSitePriceReport.cbSitesCloseUp(Sender: TObject);
begin
  Log(Format('%S selected from Site Drop Down List',[cbSites.Text]));
end;

procedure TShowSitePriceReport.dtpFromCloseUp(Sender: TObject);
begin
  Log(Format('%S selected from "From" Date Drop Down List',[DateToStr(dtpFrom.Date)]));
end;

procedure TShowSitePriceReport.dtpToCloseUp(Sender: TObject);
begin
  Log(Format('%S selected from "To" Date Drop Down List',[DateToStr(dtpTo.Date)]));
end;

end.
