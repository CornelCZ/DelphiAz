unit uSiteTemplates;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwdblook, Grids, Wwdbigrd, Wwdbgrid, DBCtrls, ExtCtrls,
  uBaseTagFilterFrame, uSiteTagFilterFrame, uTagSelection, uTag, DB, ADODB,
  AppEvnts;

type
  TfSiteTemplates = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    dbgSiteTemplate: TwwDBGrid;
    dbcTemplateName: TwwDBLookupCombo;
    pnlFilters: TPanel;
    lblCompany: TLabel;
    lblArea: TLabel;
    lblTextFilter: TLabel;
    edtTextFilter: TEdit;
    btnApplyFilters: TButton;
    btnClearFilters: TButton;
    cbCompany: TComboBox;
    cbArea: TComboBox;
    chbxFilterBySiteTags: TCheckBox;
    btnTags: TButton;
    qSiteTags: TADOQuery;
    ApplicationEvents1: TApplicationEvents;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnClearFiltersClick(Sender: TObject);
    procedure btnApplyFiltersClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbCompanyChange(Sender: TObject);
    procedure btnTagsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure evntMouseWheelCatcherMessage(var Msg: tagMSG;
      var Handled: Boolean);
  private
    fTagList: TTagList;
    procedure qSitePriorityTemplateFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure FillCompanyFilterBox;
    procedure FillAreaFilterBox(CompanyName: String = '');

  public
    { Public declarations }
  end;

var
  fSiteTemplates: TfSiteTemplates;

implementation

{$R *.dfm}

uses
  udmPromotions, StrUtils, dADOAbstract, uAztecLog, useful;

procedure TfSiteTemplates.FormShow(Sender: TObject);
begin
  Log('Site Templates', 'Showing Form');
  dmPromotions.qSitePriorityTemplate.Close;
  dmPromotions.qSitePriorityTemplate.Open;
  dmPromotions.qPromotionPriorityTemplate.Close;
  dmPromotions.qPromotionPriorityTemplate.Open;
  FillCompanyFilterBox;
  FillAreaFilterBox;
end;

procedure TfSiteTemplates.btnOKClick(Sender: TObject);
begin
  Log('Site Templates', 'OK Clicked');
  if dmPromotions.qSitePriorityTemplate.State = dsEdit then
    dmPromotions.qSitePriorityTemplate.Post;
end;

procedure TfSiteTemplates.btnClearFiltersClick(Sender: TObject);
begin
  Log('Site Templates', 'Clearing filters');
  cbCompany.ItemIndex := -1;
  cbCompany.Text := '';
  cbArea.ItemIndex := -1;
  cbArea.Text := '';
  edtTextFilter.Text := '';
  chbxFilterBySiteTags.Checked := False;
  dbgSiteTemplate.DataSource.DataSet.Filtered := False;
end;

procedure TfSiteTemplates.btnApplyFiltersClick(Sender: TObject);
begin
  Log('Site Templates', 'Applying filters');

  if (chbxFilterBySiteTags.Checked) then
  begin
    if ((fTagList = nil) or (fTagList.Count = 0)) then
    begin
      ShowMessage('You have to select one or more items in "Tags"');
      exit;
    end
  end;

  if (dbgSiteTemplate.DataSource.DataSet.Active) then
      dbgSiteTemplate.DataSource.DataSet.Close;
  dbgSiteTemplate.DataSource.DataSet.Filtered := False;
  dbgSiteTemplate.DataSource.DataSet.Filtered := True;

  if (fTagList <> nil) and (not qSiteTags.Active) then
    qSiteTags.Open;
  dbgSiteTemplate.DataSource.DataSet.Open;
end;

procedure TfSiteTemplates.qSitePriorityTemplateFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
var
  acceptRecord: Boolean;
begin
  inherited;
  acceptRecord := true;

  if Trim(edtTextFilter.Text) <> '' then
    acceptRecord := acceptRecord and AnsiContainsText(DataSet['SiteName'], Trim(edtTextFilter.Text)) OR
                        AnsiContainsText(DataSet['Reference'], Trim(edtTextFilter.Text));

  if cbArea.ItemIndex >= 0 then
    acceptRecord := acceptRecord and AnsiContainsText(DataSet.FieldByName('AreaName').AsString, cbArea.Text)
  else if cbCompany.ItemIndex >= 0 then
    acceptRecord := acceptRecord and AnsiContainsText(DataSet.FieldByName('CompanyName').AsString, cbCompany.Text);

  if chbxFilterBySiteTags.Checked then
    acceptRecord := acceptRecord and qSiteTags.Locate('SiteId', DataSet.FieldByName('SiteId').AsInteger, []);

  Accept := acceptRecord;
end;

procedure TfSiteTemplates.FormCreate(Sender: TObject);
begin
  dmPromotions.qSitePriorityTemplate.OnFilterRecord := qSitePriorityTemplateFilterRecord;
end;

procedure TfSiteTemplates.FillCompanyFilterBox;
var
  query: TADOQuery;
  nameField: TField;
begin
  query := dmPromotions.adoqRun;
  query.SQL.Text := 'select c.Id, c.Name from ac_Company c where c.Deleted = 0 order by Name asc';
  query.Open;
  cbCompany.Items.Clear;
  nameField := query.FieldByName('Name');
  while not query.Eof do
  begin
    cbCompany.Items.Add(nameField.AsString);
    query.Next;
  end;
  cbCompany.ItemIndex := -1;
end;

procedure TfSiteTemplates.FillAreaFilterBox(CompanyName: String = '');
var
  query: TADOQuery;
  nameField: TField;
begin
  cbArea.Text := '';
  query := dmPromotions.adoqRun;
  query.SQL.Text := ' select a.id, a.Name from ac_Area a ' +
                ' join ac_Company c on a.CompanyId = c.Id ' +
                ' where a.Deleted = 0 ';
  if CompanyName <> '' then
    query.SQL.Add(Format(' and c.Name = %s ', [QuotedStr(CompanyName)]));
  query.SQL.Add(' order by Name asc ');
  query.Open;
  cbArea.Items.Clear;
  nameField := query.FieldByName('Name');
  while not query.Eof do
  begin
    cbArea.Items.Add(nameField.AsString);
    query.Next;
  end;
  cbArea.ItemIndex := -1;
end;

procedure TfSiteTemplates.cbCompanyChange(Sender: TObject);
begin
  FillAreaFilterBox(cbCompany.Text);
end;

procedure TfSiteTemplates.btnTagsClick(Sender: TObject);
var
  TagWindow: TfTagSelection;
begin
  TagWindow := TfTagSelection.Create(nil, fTagList, tcSite, dmPromotions.AztecConn);
  try
    if TagWindow.ShowModal = mrOk then
    begin
      fTagList := TagWindow.SelectedTags;
      qSiteTags.Close;
      qSiteTags.Open;
      chbxFilterBySiteTags.Checked := True;
    end;
  finally
    TagWindow.Free;
  end;
end;

procedure TfSiteTemplates.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dmPromotions.qSitePriorityTemplate.Filtered := false;
end;

procedure TfSiteTemplates.FormDestroy(Sender: TObject);
begin
  dmPromotions.qSitePriorityTemplate.OnFilterRecord := nil;
end;

procedure TfSiteTemplates.evntMouseWheelCatcherMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  if (Msg.message = WM_MOUSEWHEEL) and
    (ActiveControl is TwwDBLookupCombo) then
    ConvertMouseWheelMessageToCursorKey(Msg, Handled);
end;

end.
