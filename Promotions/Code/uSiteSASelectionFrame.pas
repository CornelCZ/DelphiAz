unit uSiteSASelectionFrame;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uBaseTagFilterFrame, uSiteTagFilterFrame, StdCtrls, ComCtrls, uDataTree, uAztecLog;

const
  PANE_RESIZE_LEFT_OFFSET = -27;
  PANE_RESIZE_MIDDLE_OFFSET = -12;
  PANE_RESIZE_RIGHT_OFFSET = 20;

type
  TSiteSASelectionFrame = class(TFrame)
    lbAvailableItems: TLabel;
    tvAvailableItems: TTreeView;
    sbIncludeItem: TButton;
    sbIncludeAllItems: TButton;
    sbExcludeAllItems: TButton;
    sbExcludeItem: TButton;
    lbSelectedItems: TLabel;
    tvSelectedItems: TTreeView;
    edSearchTerm: TEdit;
    btFindPrev: TButton;
    btFindNext: TButton;
    SiteTagFilterFrame: TSiteTagFilterFrame;
    procedure sbExcludeAllItemsClick(Sender: TObject);
    procedure sbExcludeItemClick(Sender: TObject);
    procedure sbIncludeAllItemsClick(Sender: TObject);
    procedure sbIncludeItemClick(Sender: TObject);
    procedure SelectSitesSAResize(Sender: TObject);
    procedure FindPrevClick(Sender: TObject);
    procedure FindNextClick(Sender: TObject);
    procedure FindUpdate(Sender: TObject);
    procedure edSearchTermChange(Sender: TObject);
    procedure SearchTermEnter(Sender: TObject);
    procedure SearchTermExit(Sender: TObject);
  private
    SourceTree: TDataTree;
    SearchTerm: string;
    SearchTermChanged: boolean;
    function getSelectedItems : TTreeView;
    procedure setAvailableItemsListName(Value: String);
    procedure setSelectedItemsListName(Value: String);
  public
    SelectionChanged: boolean;
    procedure InitialiseFrame(var SourceTree: TDataTree);
    procedure LoadData(const TableName, IDField: String);
    property SelectedItems: TTreeView read getSelectedItems;
    property AvailableItemsListName: String write setAvailableItemsListName;
    property SelectedItemsListName: String write setSelectedItemsListName;
  end;

implementation    

uses udmPromotions;

{$R *.dfm}

procedure TSiteSASelectionFrame.InitialiseFrame(var SourceTree: TDataTree);
begin
  self.SourceTree := SourceTree;
  SiteTagFilterFrame.ADOConnection := dmPromotions.AztecConn;
  SiteTagFilterFrame.DataTreeToFilter := self.SourceTree;
end;

procedure TSiteSASelectionFrame.LoadData(const TableName, IDField: String);
begin
  SourceTree.LoadFromTempTable(tvSelectedItems, TableName, IDField);
end;

procedure TSiteSASelectionFrame.sbIncludeItemClick(Sender: TObject);
begin
  Log('  Select Sites', 'Include Item (>) Clicked');
  SourceTree.SelectItem(tvSelectedItems);
  SelectionChanged := True;
end;

procedure TSiteSASelectionFrame.sbIncludeAllItemsClick(Sender: TObject);
begin
  Log('  Select Sites', 'Include All (>>) Clicked');
  SourceTree.SelectAll(tvSelectedItems);
  SelectionChanged := True;
end;

procedure TSiteSASelectionFrame.sbExcludeAllItemsClick(Sender: TObject);
begin
  Log('  Select Sites', 'Exclude All (<<) Clicked');
  SourceTree.DeselectAll(tvSelectedItems);
  SelectionChanged := True;
end;

procedure TSiteSASelectionFrame.sbExcludeItemClick(Sender: TObject);
begin
  Log('  Select Sites', 'Exclude Item (<) Clicked');
  SourceTree.DeselectItem(tvSelectedItems);
  SelectionChanged := True;
end;

procedure TSiteSASelectionFrame.SelectSitesSAResize(Sender: TObject);
begin
  tvAvailableItems.Width := TTabSheet(Sender).width div 2 + PANE_RESIZE_LEFT_OFFSET;
  tvSelectedItems.Width := TTabSheet(Sender).width div 2 + PANE_RESIZE_LEFT_OFFSET;
  sbIncludeItem.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  sbIncludeAllItems.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  sbExcludeAllItems.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  sbExcludeItem.Left := TTabSheet(Sender).Width div 2 + PANE_RESIZE_MIDDLE_OFFSET;
  tvSelectedItems.Left := TTabSheet(Sender).width div 2 + PANE_RESIZE_RIGHT_OFFSET;
  lbSelectedItems.Left := TTabSheet(Sender).width div 2 + PANE_RESIZE_RIGHT_OFFSET;
end;

procedure TSiteSASelectionFrame.FindPrevClick(Sender: TObject);
begin
  with SourceTree do
  begin
    if SearchTermChanged then
    begin
      SearchTermChanged := false;
      FindNodes(SearchTerm, '##ConfigTree_Names', 0, GetMaxLevel);
      FindPrev;
    end
    else
      FindPrev;
  end;
  tvAvailableItems.SetFocus;
end;

procedure TSiteSASelectionFrame.FindNextClick(Sender: TObject);
begin
  with SourceTree do
  begin
    if SearchTermChanged then
    begin
      SearchTermChanged := false;
      FindNodes(SearchTerm, '##ConfigTree_Names', 0, GetMaxLevel);
      FindNext;
    end
    else
      FindNext;
  end;
  tvAvailableItems.SetFocus;
end;

procedure TSiteSASelectionFrame.FindUpdate(Sender: TObject);
begin
  TControl(Sender).Enabled := Length(SearchTerm) <> 0;
end;

procedure TSiteSASelectionFrame.edSearchTermChange(Sender: TObject);
begin
  if TEdit(Sender).Tag = 0 then
  begin
    if SearchTerm <> TEdit(Sender).Text then
    begin
      SearchTermChanged := true;
      btFindPrev.Enabled := true;
      btFindNext.Enabled := true;
      SearchTerm := TEdit(Sender).Text;
    end;
  end;
end;

procedure TSiteSASelectionFrame.SearchTermEnter(Sender: TObject);
begin
  if TEdit(Sender).Tag = 1 then
  begin
    TEdit(Sender).Font.Color := clWindowText;
    TEdit(Sender).Text := '';
    TEdit(Sender).Tag := 0;
  end;
end;

procedure TSiteSASelectionFrame.SearchTermExit(Sender: TObject);
begin
  if Length(TEdit(Sender).Text) = 0 then
  begin
    TEdit(Sender).Tag := 1;
    TEdit(Sender).Font.Color := clGrayText;
    TEdit(Sender).Text := '<Type keywords to search>';
  end;
end;


function TSiteSASelectionFrame.getSelectedItems: TTreeView;
begin
  result := tvSelectedItems;
end;

procedure TSiteSASelectionFrame.setAvailableItemsListName(Value: String);
begin
  lbAvailableItems.Caption := Value;
end;

procedure TSiteSASelectionFrame.setSelectedItemsListName(Value: String);
begin
  lbSelectedItems.Caption := Value;
end;

end.
