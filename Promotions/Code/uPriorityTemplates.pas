unit uPriorityTemplates;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Grids, DBGrids;

type
  // hack - redeclare the DBGrid class to get access to the vertical scroll message handler to fix issue with
  // using the scroll bar multiselecting records
  TDBGrid = class(DBGrids.TDBGrid)
    procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
  end;

  TfPriorityTemplates = class(TForm)
    btnNew: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    btnSiteTemplates: TButton;
    btnClose: TButton;
    dbgPriorityTemplates: TDBGrid;
    procedure btnNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnSiteTemplatesClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure dbgPriorityTemplatesKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgPriorityTemplatesMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure HandleDBGridMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  private
    PromotionFilterText: String;
    MidwordSearch: Boolean;
    procedure DeleteTemplate(SelectedID: Integer);
    function OkToDelete(SelectedID: Integer): boolean;
    procedure RefreshButtonAvailability;
  public
    class function getWindowInstance(PromotionFilterText: String; MidwordSearch: Boolean): TfPriorityTemplates;
  end;

var
  fPriorityTemplates: TfPriorityTemplates;

implementation

uses
  uPriorityTemplateWizard, udmPromotions, DB, ADODB, useful, uSiteTemplates, uAztecLog;
{$R *.dfm}

class function TfPriorityTemplates.getWindowInstance(PromotionFilterText: String;
  MidwordSearch: Boolean): TfPriorityTemplates;
var
  newWindow: TfPriorityTemplates;
begin
  Log('Priority Templates', 'Getting new window instance');
  newWindow := TfPriorityTemplates.Create(nil);
  newWindow.PromotionFilterText := PromotionFilterText;
  newWindow.MidwordSearch := MidwordSearch;
  result := newWindow;
end;

procedure TfPriorityTemplates.FormShow(Sender: TObject);
begin
  Log('Priority Templates', 'Showing form');
  dmPromotions.cmdAddMissingSitesDefaultTemplates.Execute;
  dmPromotions.InsertMissingPromotionPriorities;
  dmPromotions.qPromotionPriorityTemplate.Open;

  // since DBGrid doesn't allow us to set OnMouseWheel by default, we need to cast to Form to assign the handler
  TForm(dbgPriorityTemplates).OnMouseWheel := HandleDBGridMouseWheel;

  RefreshButtonAvailability;
  btnNew.SetFocus;
end;

procedure TfPriorityTemplates.btnNewClick(Sender: TObject);
var
  TemplateWizard : TfPriorityTemplateWizard;
begin
  Log('Priority Templates', 'New button clicked');
  dmPromotions.AwaitPreload(pwSiteAndProductTree);

  TemplateWizard := TfPriorityTemplateWizard.GetWizardInstance(-1, PromotionFilterText, MidwordSearch);
  try
    if TemplateWizard.ShowModal = mrOK then
    begin
      dmPromotions.qPromotionPriorityTemplate.Requery;
      dbgPriorityTemplates.SelectedRows.Clear;
    end;
  finally
    TemplateWizard.Free;
  end;
end;

procedure TfPriorityTemplates.btnEditClick(Sender: TObject);
var
  TemplateWizard: TfPriorityTemplateWizard;
  SelectedRow: Integer;
  SelectedRecord: TBookmark;
begin
  Log('Priority Templates', 'Edit button clicked');

  if dbgPriorityTemplates.SelectedRows.Count = 1 then
  begin
    SelectedRow := dbgPriorityTemplates.DataSource.DataSet.FieldByName('Id').AsInteger;
    SelectedRecord := TBookmark(dbgPriorityTemplates.SelectedRows.Items[0]);
    dmPromotions.AwaitPreload(pwSiteAndProductTree);
    TemplateWizard := TfPriorityTemplateWizard.GetWizardInstance(SelectedRow, PromotionFilterText, MidwordSearch);
    try
      if TemplateWizard.ShowModal = mrOK then
      begin
        dmPromotions.qPromotionPriorityTemplate.Requery;
        dmPromotions.qPromotionPriorityTemplate.GotoBookmark(SelectedRecord);
      end;
    finally
      TemplateWizard.Free;
    end;
  end;
end;

procedure TfPriorityTemplates.btnDeleteClick(Sender: TObject);
var
  SelectedID: Integer;
begin
  Log('Priority Templates', 'Delete button clicked');
  if dbgPriorityTemplates.SelectedRows.Count = 1 then
  begin
    SelectedID := dbgPriorityTemplates.DataSource.DataSet.FieldByName('Id').AsInteger;
    if SelectedID = 1 then
      ShowMessage('The Default priority template cannot be deleted')
    else if okToDelete(SelectedID) then
    begin
      DeleteTemplate(SelectedId);
      dmPromotions.qPromotionPriorityTemplate.Requery;
      dbgPriorityTemplates.SelectedRows.Clear;
    end;
  end;
end;

function TfPriorityTemplates.OkToDelete(SelectedID: Integer): boolean;
var
  query: TADOQuery;
begin
  Log('Priority Templates', Format('Prompting user before template deletion - templateID: %d', [SelectedID]));
  query := dmPromotions.adoqRun;
  query.SQL.Text := Format('select SiteID from ac_SitePriorityTemplate where PriorityTemplateId = %d', [SelectedID]);
  query.Open;
  if query.RecordCount > 0 then
  begin
    ShowMessage('Sites are assigned to this template. The template cannot be deleted until these sites are reassigned.');
    result := false;
  end
  else
    result := true;
end;

procedure TfPriorityTemplates.DeleteTemplate(SelectedID: Integer);
var
  query: TADOQuery;
  SQL: String;
begin
  Log('Priority Templates', Format('Deleting template - TemplateID: %d', [SelectedID]));
  query := dmPromotions.adoqRun;
  SQL := GetStringResource('DeletePriorityTemplate', 'TEXT');
  SQL := StringReplace(SQL, '@TemplateID', IntToStr(SelectedID), [rfReplaceAll, rfIgnoreCase]);
  query.SQL.Text := SQL;
  query.ExecSQL;
end;

procedure TfPriorityTemplates.btnSiteTemplatesClick(Sender: TObject);
var
  SiteTemplatesForm : TfSiteTemplates;
begin
  Log('Priority Templates', 'Opening Site Templates window');
  SiteTemplatesForm := TfSiteTemplates.Create(self);
  SiteTemplatesForm.ShowModal;
end;

procedure TfPriorityTemplates.RefreshButtonAvailability;
begin
  dbgPriorityTemplates.SelectedRows.CurrentRowSelected := true;
  btnEdit.Enabled := dbgPriorityTemplates.SelectedRows.Count = 1;
  btnDelete.Enabled := dbgPriorityTemplates.SelectedRows.Count = 1;
end;

procedure TfPriorityTemplates.dbgPriorityTemplatesKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  RefreshButtonAvailability;
end;

procedure TfPriorityTemplates.dbgPriorityTemplatesMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  RefreshButtonAvailability;
end;

procedure TfPriorityTemplates.HandleDBGridMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  dbgPriorityTemplates.SelectedRows.Clear;

  if WheelDelta > 0 then
    dbgPriorityTemplates.DataSource.DataSet.Prior
  else
    dbgPriorityTemplates.DataSource.DataSet.Next;

  RefreshButtonAvailability;
end;

procedure TDBGrid.WMVScroll(var Msg: TWMVScroll);
begin
  SelectedRows.Clear;
  inherited;
  SelectedRows.CurrentRowSelected := true;
end;

end.
