unit uBaseTagFilterFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, uTagSelection, uTag, ADODB, uDataTree;

type
  TBaseTagFilterFrame = class(TFrame)
    chkbxFiltered: TCheckBox;
    btnTags: TButton;
    procedure btnTagsClick(Sender: TObject);
    procedure chkbxFilteredClick(Sender: TObject);
  private
    FTagList: TTagList;
    FDataTree: TDataTree;
    FTagFilterSelector: TfTagSelection;
    FADOConnection: TADOConnection;
    FADOCommand: TADOCommand;
    FFilteredIdsTable: string;

    procedure SetADOConnection(value: TADOConnection);
  protected
    function ItemName: string; virtual; abstract;
    function ItemTreeLevel: integer; virtual; abstract;
    function TagType: TTagContext; virtual; abstract;
    function SQLToSelectFilteredIds: string; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ADOConnection: TADOConnection write SetADOConnection;
    property DataTreeToFilter: TDataTree write FDataTree;
  end;

implementation

{$R *.dfm}


constructor TBaseTagFilterFrame.Create(AOwner: TComponent);
begin
  inherited;
  FTagList := TTagList.Create;
  FFilteredIdsTable := '#Filtered'+ItemName+'s_' + AOwner.Name;
  btnTags.Hint := 'Filter by ' + ItemName+ ' Tags';

  FADOCommand := TADOCommand.Create(nil);
  FADOCommand.CommandTimeout := 0;
  FADOCommand.CommandText := Format(
    'IF OBJECT_ID(''tempdb..%0:s'') IS NOT NULL ' +
    '  DELETE %0:s ' +
    'ELSE ' +
    '  CREATE TABLE %0:s (Id int PRIMARY KEY) ' +

    'IF EXISTS(SELECT * FROM #Tags) INSERT %0:s ' + SQLToSelectFilteredIds, [FFilteredIdsTable]);
end;

destructor TBaseTagFilterFrame.Destroy;
begin
  FTagList.Free;
  FADOCommand.Free;
  FTagFilterSelector.Free;
  inherited;
end;

procedure TBaseTagFilterFrame.SetADOConnection(value: TADOConnection);
begin
  FADOConnection := value;
  FADOCommand.Connection := FADOConnection;
end;

procedure TBaseTagFilterFrame.btnTagsClick(Sender: TObject);
var
  CurrentBaseTagList: string;
begin
  CurrentBaseTagList := FTagList.CommaText;

  if FTagFilterSelector = nil then
    FTagFilterSelector := TfTagSelection.Create(Self.Parent, nil, TagType, FADOConnection, nil);

  if FTagFilterSelector.ShowModal = mrOK then
  begin
    FTagList.Clear;
    FTagList.Free;
    FTagList := FTagFilterSelector.SelectedTags.Clone;
    if FTagList.CommaText = '' then
    begin
      btnTags.Hint := 'Filter by ' + ItemName+ ' Tags';
      FDataTree.ClearFilter(ItemTreeLevel);
    end
    else
    begin
      btnTags.Hint :=  ItemName + ' filter: ' + FTagList.CommaText;

      if FTagList.CommaText <> CurrentBaseTagList then
      begin
        FADOCommand.Execute;
        FDataTree.ApplyFilter(ItemTreeLevel, FFilteredIdsTable);
      end;
    end;
  end;
end;

procedure TBaseTagFilterFrame.chkbxFilteredClick(Sender: TObject);
begin
  if chkbxFiltered.Checked then
  begin
    if FTagList.CommaText <> '' then
      FDataTree.ApplyFilter(ItemTreeLevel, FFilteredIdsTable);
    btnTags.Enabled := True;
  end
  else
  begin
    btnTags.Enabled := False;
    btnTags.Hint := 'Filter by ' + ItemName+ ' Tags';
    FDataTree.ClearFilter(ItemTreeLevel);
  end;
end;


end.
