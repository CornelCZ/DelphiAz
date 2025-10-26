unit uPriorityTemplateWizard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, DB, DBCtrls, uSiteSASelectionFrame, uDataTree,
  uSetPromotionOrderFrame, uWizardManager, ExtCtrls;

type
  TfPriorityTemplateWizard = class(TForm)
    pcPriorityWizard: TPageControl;
    tsAddSites: TTabSheet;
    tsSetPriorities: TTabSheet;
    SiteSelectionFrame: TSiteSASelectionFrame;
    lbTemplateName: TLabel;
    dbeTemplateName: TDBEdit;
    SetPromotionOrderFrame: TSetPromotionOrderFrame;
    btnNext: TButton;
    btnPrev: TButton;
    btnClose: TButton;
    pnlSelectSitesHeader: TPanel;
    lblSelectSitesTitle: TLabel;
    Bevel1: TBevel;
    lblSelectSitesText: TLabel;
    imgSelectSitesLogo: TImage;
    pnlSetPriorityHeader: TPanel;
    lblSetPriorityTitle: TLabel;
    Bevel2: TBevel;
    lblSetPriorityText: TLabel;
    imgSetPriorityLogo: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OnEnterPage(Page: TTabSheet; Direction : TWizardDirection);
    procedure OnLeavePage(Page: TTabSheet; Direction : TWizardDirection);
    procedure btnNextClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure SiteSelectionFramesbIncludeItemClick(Sender: TObject);
    procedure SiteSelectionFramesbIncludeAllItemsClick(Sender: TObject);
  private
    { Private declarations }
    SiteTree: TDataTree;
    WizardManager: TWizardManager;
    TemplateID: Integer;
    PromotionFilterText: String;
    MidwordSearch: Boolean;
    procedure LoadData;
    procedure LoadExistingTemplateData;
    procedure SetUpTempTables;
    procedure SetUpNewTemplateData;
    procedure SaveTemplateData;
    function GetNewTemplateID: Integer;
    procedure SaveSiteSelections(TableName: String);
    function OkToReassignSites(SelectedNode: TTreeNode): boolean;
  public
    { Public declarations }
    class function GetWizardInstance(TemplateID: Integer = -1;
        PromotionFilterText: String = ''; MidwordSearch: Boolean = false): TfPriorityTemplateWizard;
  end;

var
  fPriorityTemplateWizard: TfPriorityTemplateWizard;

implementation

uses udmPromotions, ADODB, useful, uGlobals, dADOAbstract, uAztecLog;

{$R *.dfm}

class function TfPriorityTemplateWizard.GetWizardInstance(TemplateID: Integer = -1;
        PromotionFilterText: String = ''; MidwordSearch: Boolean = false): TfPriorityTemplateWizard;
var
  newWizard : TfPriorityTemplateWizard;
begin
  log('Priority Template Wizard', Format('Getting Wizard Instance - TemplateID %d', [TemplateID]));
  newWizard := TfPriorityTemplateWizard.Create(nil);
  newWizard.TemplateID := TemplateID;
  newWizard.PromotionFilterText := PromotionFilterText;
  newWizard.MidwordSearch := MidwordSearch;
  newWizard.LoadData;

  result := newWizard;
end;

procedure TfPriorityTemplateWizard.FormCreate(Sender: TObject);
begin
  log('Priority Template Wizard', 'Creating form');
  WizardManager := TWizardManager.Create(pcPriorityWizard, btnNext, btnPrev, OnEnterPage, OnLeavePage);
  WizardManager.WizardName := 'Priority Template Wizard';

  SiteTree := TDataTree.Create(SiteSelectionFrame.tvAvailableItems, dmPromotions.AztecConn, '##ConfigTree_Data', ConfigNamesArray, True);
  SiteTree.AddLevel('Company', '');
  SiteTree.AddLevel('Area', '');
  SiteTree.AddLevel('Site', '');
  SiteTree.Initialise;
  SiteSelectionFrame.InitialiseFrame(SiteTree);
  SiteSelectionFrame.AvailableItemsListName := 'Available Sites';
  SiteSelectionFrame.SelectedItemsListName := 'Selected Sites';
  SetPromotionOrderFrame.InitialiseFrame;
end;

procedure TfPriorityTemplateWizard.FormShow(Sender: TObject);
var
  DefaultDataWarning: String;
begin
  log('Priority Template Wizard', 'FormShow');
  dmPromotions.qTempPriorityTemplate.Close;
  dmPromotions.qTempPriorityTemplate.Open;
  SetPromotionOrderFrame.FormShow;
  
  DefaultDataWarning := 'Sites cannot be removed from the default dataset.';
  if TemplateID = 1 then
  begin
    SiteSelectionFrame.sbExcludeAllItems.Enabled := false;
    SiteSelectionFrame.sbExcludeAllItems.Hint := DefaultDataWarning;
    SiteSelectionFrame.sbExcludeItem.Enabled := false;
    SiteSelectionFrame.sbExcludeItem.Hint := DefaultDataWarning;
    dbeTemplateName.ReadOnly := true;
  end
  else
  begin
    SiteSelectionFrame.sbExcludeAllItems.Enabled := true;
    SiteSelectionFrame.sbExcludeAllItems.Hint := '';
    SiteSelectionFrame.sbExcludeItem.Enabled := true;
    SiteSelectionFrame.sbExcludeItem.Hint := '';
    dbeTemplateName.ReadOnly := false;
  end;
end;

procedure TfPriorityTemplateWizard.OnEnterPage(Page: TTabSheet;
  Direction: TWizardDirection);
begin
  // do nothing - needed for TWizardManager implementation, but nothing needs doing
end;

procedure TfPriorityTemplateWizard.OnLeavePage(Page: TTabSheet;
  Direction: TWizardDirection);
begin
  log('Priority Template Wizard', Format('OnLeavePage: %s', [Page.Name]));
  if (Page = tsAddSites) then
  begin
    if dmPromotions.qTempPriorityTemplate.State = dsEdit then
    begin
      dmPromotions.qTempPriorityTemplate.Post;
    end;
    SaveSiteSelections(SiteTree.SaveToTempTable(SiteSelectionFrame.SelectedItems));
  end;

end;

procedure TfPriorityTemplateWizard.btnNextClick(Sender: TObject);
begin
  log('Priority Template Wizard', 'Next button clicked');
  ModalResult := WizardManager.NextPageExecute(Sender);
  if ModalResult = mrOK then
  begin
    if TemplateID = -1 then
    begin
      TemplateID := GetNewTemplateID;
      dmPromotions.qTempPriorityTemplate.Edit;
      dmPromotions.qTempPriorityTemplate.FieldByName('Id').AsInteger := TemplateID;
      dmPromotions.qTempPriorityTemplate.Post;
    end;
    SetPromotionOrderFrame.SavePromoOrder(TemplateID);
    SaveTemplateData;
  end;
end;

procedure TfPriorityTemplateWizard.btnPrevClick(Sender: TObject);
begin
  log('Priority Template Wizard', 'Previous button clicked');
  WizardManager.PrevPageExecute(Sender);
end;

procedure TfPriorityTemplateWizard.SaveSiteSelections(TableName: String);
var
  query: TADOQuery;
begin
  log('Priority Template Wizard', 'Saving site selections');
  query := dmPromotions.adoqRun;
  query.SQL.Text := 'delete #SiteTemplate';
  query.ExecSQL;

  query.SQL.Text := Format('insert #SiteTemplate (SiteId) '+
      'select Level3ID from %s ', [TableName]);
  query.ExecSQL;

  query.SQL.Text := Format('drop table %s', [TableName]);
  query.ExecSQL;
end;

procedure TfPriorityTemplateWizard.FormDestroy(Sender: TObject);
begin
  log('Priority Template Wizard', 'Cleaning up form');
  WizardManager.Free;
  SetPromotionOrderFrame.FormDestroy(Sender);
end;

procedure TfPriorityTemplateWizard.LoadData;
begin
  log('Priority Template Wizard', 'Loading data');
  SetPromotionOrderFrame.LoadData(PromotionFilterText, MidwordSearch, TemplateID);
  SetUpTempTables;
  if TemplateID <> -1 then
  begin
    LoadExistingTemplateData;
    SiteSelectionFrame.LoadData('#SiteTemplate','SiteID');
  end
  else
  begin
    SetUpNewTemplateData;
  end;
end;

procedure TfPriorityTemplateWizard.SetUpTempTables;
var
  query : TADOQuery;
begin
  log('Priority Template Wizard', 'Setting up new temp tables');
  query := dmPromotions.adoqRun;
  query.SQL.Text := GetStringResource('SetUpTemplateTables', 'TEXT');
  query.ExecSQL;
end;

procedure TfPriorityTemplateWizard.LoadExistingTemplateData;
var
  query : TADOQuery;
  loadSQL : String;
begin
  log('Priority Template Wizard', Format('Loading data into temp tables - TemplateID %d', [TemplateID]));
  dmPromotions.qTempPriorityTemplate.Close;
  query := dmPromotions.adoqRun;
  loadSQL := GetStringResource('LoadTemplateData','TEXT');
  loadSQL := StringReplace(loadSQL, '@TemplateID', IntToStr(TemplateID), [rfIgnoreCase, rfReplaceAll]);
  loadSQL := StringReplace(loadSQL, '@SiteCode', IntToStr(uGlobals.SiteCode), [rfIgnoreCase, rfReplaceAll]);
  query.SQL.Text := loadSQL;
  query.ExecSQL;
  dmPromotions.qTempPriorityTemplate.Open;
end;

procedure TfPriorityTemplateWizard.SetUpNewTemplateData;
var
  query: TADOQuery;
begin
  log('Priority Template Wizard', 'Setting up default data for new template');
  query := dmPromotions.adoqRun;
  query.SQL.Text := GetStringResource('LoadDefaultTemplateData','TEXT');
  query.ExecSQL;
end;

procedure TfPriorityTemplateWizard.btnCloseClick(Sender: TObject);
begin
  log('Priority Template Wizard', 'Close clicked');
  Close;
end;

procedure TfPriorityTemplateWizard.SaveTemplateData;
var
  query: TADOQuery;
  queryText: String;
begin
  log('Priority Template Wizard', 'Saving data');
  query := dmPromotions.adoqRun;
  queryText := GetStringResource('SaveTemplateData', 'TEXT');
  queryText := StringReplace(queryText, '@TemplateID', IntToStr(TemplateID), [rfIgnoreCase, rfReplaceAll]);
  query.SQL.Text := queryText;
  query.ExecSQL;
end;

function TfPriorityTemplateWizard.GetNewTemplateID: Integer;
var
  query: TADOQuery;
  NewTemplateID: Integer;
begin
  log('Priority Template Wizard', 'Fetching new template ID');
  query := dmPromotions.adoqRun;
  query.SQL.Clear;
  query.SQL.Add('declare @newid bigint');
  query.SQL.Add(Format('exec ac_spGetTableIdNextValue %s, %s output',['ac_PromotionPriorityTemplate','@newid']));
  query.SQL.Add('select @newid as Output');
  query.Open;
  NewTemplateID := query.fieldbyname('Output').AsInteger;
  query.Close;
  Result := NewTemplateID;
end;

procedure TfPriorityTemplateWizard.SiteSelectionFramesbIncludeItemClick(
  Sender: TObject);
begin
  if OkToReassignSites(SiteSelectionFrame.tvAvailableItems.Selected) then
    SiteSelectionFrame.sbIncludeItemClick(Sender);
end;

procedure TfPriorityTemplateWizard.SiteSelectionFramesbIncludeAllItemsClick(
  Sender: TObject);
begin
  if OkToReassignSites(SiteSelectionFrame.tvAvailableItems.Items[0]) then
    SiteSelectionFrame.sbIncludeAllItemsClick(Sender);
end;

function TfPriorityTemplateWizard.OkToReassignSites(SelectedNode: TTreeNode): boolean;
var
  WarningMessage: String;
  Query: TADOQuery;
  idList: TStringList;
begin
  result := False;
  if assigned(SelectedNode) then
  begin
    idList := SiteTree.GetLeafIdListFromSourceTree(SelectedNode);
    try
      Query := dmPromotions.adoqRun;
      Query.Close;
      Query.SQL.Text := Format('select distinct t.Name ' +
                          ' from ac_SitePriorityTemplate s ' +
                          ' join ac_PromotionPriorityTemplate t ' +
                          ' on s.PriorityTemplateId = t.Id ' +
                          ' where s.SiteID in (%s) and s.PriorityTemplateId not in (1,%d)',
                  [idList.CommaText, TemplateID]);
      Query.Open;
      if Query.RecordCount > 0 then
      begin
        if idList.Count = 1 then
          WarningMessage := Format('This site is currently assigned to template %s - do you wish to reassign it to the ' +
                'current template?', [query.FieldByName('Name').AsString])
        else
          WarningMessage := 'Some of the sites selected are already assigned to another template, ' +
                'do you wish to reassign them?';
        result := MessageDlg(WarningMessage, mtConfirmation, [mbYes, mbNo], -1) = mrYes;
      end
      else
        result := true;
    finally
      idList.Free;
    end;
  end;
end;

end.
