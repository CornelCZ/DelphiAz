unit uTagListFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ADODB, DB, uTag,
  StdCtrls;

type
  TInteger = class(TObject)
  public
    Value : Integer;
    constructor Create(_Value: Integer);
  end;

  TTagLevel = (tlGroup, tlSubGroup, tlSection, tlSubSection);

  TTagListFrame = class(TFrame)
    ScrollBox: TScrollBox;
    grpBoxTagFilter: TGroupBox;
    cmbbxTagGroup: TComboBox;
    cmbbxTagSubGroup: TComboBox;
    cmbbxTagSection: TComboBox;
    cmbbxTagSubSection: TComboBox;
    lblGroup: TLabel;
    lblSubGroup: TLabel;
    lblSubSection: TLabel;
    lblSection: TLabel;
    adoqTags: TADOQuery;
    adoc: TADOCommand;
    adoq: TADODataSet;
    chkboxFiltered: TCheckBox;
    Label1: TLabel;
    procedure cmbbxTagGroupChange(Sender: TObject);
    procedure cmbbxTagSubGroupChange(Sender: TObject);
    procedure cmbbxTagSectionChange(Sender: TObject);
    procedure chkboxFilteredClick(Sender: TObject);
    procedure cmbbxTagSubSectionChange(Sender: TObject);
  private
    FSelectedTags: TTagList;
    FTagContext: TTagContext;
    FConnection: TADOConnection;
    FFiltered: boolean;
    procedure InitialiseList;
    procedure OnTagValueChange(Sender: TObject);
    procedure PopulateTagGroupCombo;
    procedure RefreshTagSubGroupCombo;
    procedure RefreshTagSectionCombo;
    procedure RefreshTagSubSectionCombo;
    procedure ApplyFilter(tagLevel: TTagLevel; itemId: integer);
    procedure ClearFilter;
    procedure ApplyFilterComboSettings;
    procedure DestroyComboBox(ComboBox: TComboBox);
  protected
    FTagSelectionsChanged: boolean;
    TagSelectionFrameList: TStringList;
  public
    destructor Destroy; override;
    procedure Initialise(Context: TTagContext; Connection: TADOConnection; SelectedTags: TTagList = nil);
    property SelectedTags: TTagList read FSelectedTags;
    procedure SaveTagSelections(const IncludeInvisibleTags: boolean);
    procedure ClearTagSelections;
    function TagSelectionsChanged: boolean;
  end;


implementation

uses
  Variants, uBaseTagFrame, uListTagSelectionFrame, uSingleTagSelectionFrame;

const
  TOP_GAP = 5; //Size of the gap betweeen the top of the scrollbox and the first tag component.

{$R *.dfm}

{ TInteger }
constructor TInteger.Create(_Value: Integer);
begin
  Value := _Value;
end;

{ TTagListFrame }
procedure TTagListFrame.Initialise(Context: TTagContext; Connection: TADOConnection; SelectedTags: TTagList = nil);
begin
  FConnection := Connection;
  FTagSelectionsChanged := False;

  adoqTags.Connection := FConnection;
  adoq.Connection := FConnection;
  adoc.Connection := FConnection;

  adoqTags.Connection := Connection;
  if Assigned(SelectedTags) then
    FSelectedTags := SelectedTags.Clone
  else
    FSelectedTags := TTagList.Create;

  with adoc do
  begin
    //#Tags will hold the list of selected tag ids after SaveTagSelections is called.
    CommandText := 'if object_id(''tempdb..#Tags'') is not null drop table #Tags';
    Execute;

    CommandText :='create table #Tags (TagId int, primary key (TagId))';
    Execute;
  end;

  FTagContext := Context;

  TagSelectionFrameList := TStringList.Create;

  InitialiseList;

  ScrollBox.DoubleBuffered := True;

  if grpBoxTagFilter.Visible then
  begin
    PopulateTagGroupCombo;
  end;
end;

destructor TTagListFrame.Destroy;
begin
  DestroyComboBox(cmbbxTagGroup);
  DestroyComboBox(cmbbxTagSubGroup);
  DestroyComboBox(cmbbxTagSection);
  DestroyComboBox(cmbbxTagSubSection);

  inherited Destroy;
end;

procedure TTagListFrame.InitialiseList;
var
  ParentId: Integer;
  ChildID: Integer;
  ParentName: String;
  ChildName: String;
  ContextString: String;
  FrameIndex: Integer;
  FrameCount: Integer;
  TempFrame: TfrmBaseTagFrame;
  ItemIndex: Integer;
  i: Integer;
begin
  with adoqTags do
  begin
    case FTagContext of
      tcSite: ContextString := 'Site';
      tcProduct: ContextString := 'Product';
    end;

    Parameters.ParamByName('Context').Value := ContextString;

    Open;

    FrameCount := 0;
    try
      ScrollBox.Visible := False;
      while not EOF do
      begin
        ParentId := FieldByName('Parent').AsInteger;
        ChildID := FieldByName('Child').AsInteger;
        ParentName := FieldByName('ParentName').AsString;
        ChildName := FieldByName('ChildName').AsString;

        //If we have no children then add an atomic node
        if VarIsNull(FieldByName('Child').Value) then
        begin
          TempFrame := TfrmSingleTagSelectionFrame.Create(ScrollBox,ParentId,ParentName, OnTagValueChange);
          TempFrame.Parent := ScrollBox;
          ScrollBox.ScrollInView(TempFrame);
          TempFrame.Width := ScrollBox.ClientWidth;
          TempFrame.Top := FrameCount * TempFrame.Height + TOP_GAP;
          TfrmSingleTagSelectionFrame(TempFrame).InitialiseFrame;
          TagSelectionFrameList.AddObject(ParentName,TempFrame);

          if FSelectedTags.FindTag(ParentId, ItemIndex) then
            TempFrame.TagID := ParentId;

          Inc(FrameCount);
        end
        else
        begin
          FrameIndex := TagSelectionFrameList.IndexOf(ParentName);
          if FrameIndex = -1 then
          begin
            TempFrame := TfrmListTagSelectionFrame.Create(ScrollBox,ParentId,ParentName, OnTagValueChange);
            TempFrame.Parent := ScrollBox;
            ScrollBox.ScrollInView(TempFrame);
            TempFrame.Width := ScrollBox.ClientWidth;
            TempFrame.Top := FrameCount * TempFrame.Height + TOP_GAP;
            TfrmListTagSelectionFrame(TempFrame).InitialiseFrame;
            TagSelectionFrameList.AddObject(ParentName,TempFrame);
            TfrmListTagSelectionFrame(TempFrame).AddChild(ChildID, ChildName);
            if FSelectedTags.FindTag(ChildId, ItemIndex) then
              TempFrame.TagID := ChildId;
            Inc(FrameCount);
          end
          else begin
            TempFrame := TfrmListTagSelectionFrame(TagSelectionFrameList.objects[FrameIndex]);
            TfrmListTagSelectionFrame(TempFrame).AddChild(ChildID, ChildName);
            if FSelectedTags.FindTag(ChildId, ItemIndex) then
              TempFrame.TagID := ChildId;
          end;
        end;
        Next;
      end;
    finally
      ScrollBox.Realign;
      for i := 0 to TagSelectionFrameList.Count - 1 do
        TfrmBaseTagFrame(TagSelectionFrameList.Objects[i]).ClientWidth := ScrollBox.ClientWidth;// - GetSystemMetrics(SM_CXVSCROLL);
      ScrollBox.Visible := True;
    end;
  end;
end;

// Save the current tag selections to both the #Tags table and the FSelectedTags field. If IncludeInvisibleTags is true then
// all tags settings are saved, even tags that are invisible because of the current filter settings. If this paramater is false
// only selections for visible tags are saved.
procedure TTagListFrame.SaveTagSelections(const IncludeInvisibleTags: boolean);
var
  i: Integer;
  TempFrame: TfrmBaseTagFrame;
begin
  FSelectedTags.Clear;
  adoc.CommandText := 'DELETE #Tags';
  adoc.Execute;

  for i := 0 to TagSelectionFrameList.Count - 1 do
  begin
    TempFrame := TfrmBaseTagFrame(TagSelectionFrameList.Objects[i]);

    if TempFrame.TagSelected and(IncludeInvisibleTags or TempFrame.Visible) then
    begin
        if TempFrame is TfrmListTagSelectionFrame then
          FSelectedTags.AddTag(TempFrame.ParentTagName, TempFrame.TagName, TempFrame.TagId)
        else
          FSelectedTags.AddTag('', TempFrame.TagName, TempFrame.TagId);

        adoc.CommandText := 'INSERT #Tags VALUES (' + IntToStr(TempFrame.TagID) + ')';
        adoc.Execute;
    end;
  end;
end;

procedure TTagListFrame.ClearTagSelections;
var
  i: integer;
begin
  for i := 0 to TagSelectionFrameList.Count - 1 do
    TfrmBaseTagFrame(TagSelectionFrameList.Objects[i]).ClearSelected;
  FTagSelectionsChanged := True;
end;

procedure TTagListFrame.chkboxFilteredClick(Sender: TObject);
begin
  if chkboxFiltered.Checked then
  begin
    ApplyFilterComboSettings;
  end
  else
  begin
    ClearFilter;
  end;
end;

procedure TTagListFrame.ApplyFilterComboSettings;
begin
  if cmbbxTagSubSection.ItemIndex > 0 then
    ApplyFilter(tlSubSection, TInteger(cmbbxTagSubSection.Items.Objects[cmbbxTagSubSection.ItemIndex]).Value)
  else if cmbbxTagSection.ItemIndex > 0 then
    ApplyFilter(tlSection, TInteger(cmbbxTagSection.Items.Objects[cmbbxTagSection.ItemIndex]).Value)
  else if cmbbxTagSubGroup.ItemIndex > 0 then
    ApplyFilter(tlSubGroup, TInteger(cmbbxTagSubGroup.Items.Objects[cmbbxTagSubGroup.ItemIndex]).Value)
  else if cmbbxTagGroup.ItemIndex > 0 then
    ApplyFilter(tlGroup, TInteger(cmbbxTagGroup.Items.Objects[cmbbxTagGroup.ItemIndex]).Value)
  else
    ClearFilter;
end;

procedure TTagListFrame.ApplyFilter(tagLevel: TTagLevel; itemId: integer);
var
  i: integer;
  visibleFrameCount: integer;
  tempFrame: TfrmBaseTagFrame;
  filteredTagIds: array of integer;

  function InFilteredList(parentTagId: integer): boolean;
  var i: integer;
  begin
    Result := False;

    for i := 0 to length(filteredTagIds) - 1 do
    begin
      if filteredTagIds[i] = parentTagId then
      begin
        Result := True;
        Break;
      end;

      if filteredTagIds[i] > parentTagId then //Note: This relies on filteredTagIds being a sorted in ascending order.
        Break;
    end;
  end;

  function GetFilterSQL: string;
  begin
    Result := 'SELECT Id FROM ac_Tag WHERE TagSubSectionId ';

    if tagLevel = tlSubSection then
      Result := Result + '= ' + IntToStr(itemId)

    else if tagLevel = tlSection then
      Result := Result + 'IN (SELECT Id FROM ac_TagSubSection WHERE TagSectionId = ' + IntToStr(itemId) + ')'

    else if tagLevel = tlSubGroup then
      Result := Result +
        'IN (SELECT Id FROM ac_TagSubSection WHERE TagSectionId IN ' +
              '(SELECT Id FROM ac_TagSection WHERE TagSubGroupId = ' + IntToStr(itemId) + '))'

    else if tagLevel = tlGroup then
      Result := Result +
        'IN (SELECT Id FROM ac_TagSubSection WHERE TagSectionId IN ' +
              '(SELECT Id FROM ac_TagSection WHERE TagSubGroupId IN ' +
                 '(SELECT ID FROM ac_TagSubGroup WHERE TagGroupId = ' + IntToStr(itemId) + ')))';
  end;

begin
  if FFiltered then
    ClearFilter;

  with adoq do
  try
    CommandText := GetFilterSQL;
    Open;
    SetLength(filteredTagIds, RecordCount);
    i := 0;
    while not eof do
    begin
      filteredTagIds[i] := FieldByName('Id').AsInteger;
      inc(i);
      Next;
    end;
  finally
    Close;
  end;

  FFiltered := true;
  visibleFrameCount := 0;

  ScrollBox.Visible := False;
  ScrollBox.VertScrollBar.Visible := False;
  try
    ScrollBox.VertScrollBar.Position := 0;
    for i := 0 to TagSelectionFrameList.Count - 1 do
    begin
      tempFrame := TfrmBaseTagFrame(TagSelectionFrameList.Objects[i]);
      tempFrame.Visible := InFilteredList(tempFrame.ParentTagID);
      if tempFrame.Visible then
      begin
        tempFrame.Top := visibleFrameCount * tempFrame.Height + TOP_GAP;
        inc(visibleFrameCount);
      end
    end;
  finally
    ScrollBox.VertScrollBar.Visible := True;
    ScrollBox.Visible := True;
  end;
end;

procedure TTagListFrame.ClearFilter;
var
  i: integer;
  tempFrame: TfrmBaseTagFrame;
begin
  if not FFiltered then
    Exit;

  ScrollBox.Visible := False;
  ScrollBox.VertScrollBar.Visible := False;
  try
  for i := 0 to TagSelectionFrameList.Count - 1 do
  begin
    tempFrame := TfrmBaseTagFrame(TagSelectionFrameList.Objects[i]);
    tempFrame.Visible := True;
    tempFrame.Top := i * tempFrame.Height + TOP_GAP;
  end;
  finally
    ScrollBox.VertScrollBar.Visible := True;
    ScrollBox.Visible := True;
  end;

  FFiltered := False;
end;

function TTagListFrame.TagSelectionsChanged: boolean;
begin
  Result := FTagSelectionsChanged;
end;

procedure TTagListFrame.OnTagValueChange(Sender: TObject);
begin
  FTagSelectionsChanged := True;
end;

procedure TTagListFrame.PopulateTagGroupCombo;
begin
  cmbbxTagGroup.Items.Clear;
  cmbbxTagGroup.Items.Add('<all values>');

  with adoq do
  try
    CommandText := 'SELECT Id, Name FROM ac_TagGroup WHERE Deleted = 0 ORDER BY Name';
    Open;

    while not EOF do
    begin
      cmbbxTagGroup.Items.AddObject(FieldByName('Name').AsString, TInteger.Create(FieldByName('Id').AsInteger));

      Next;
    end;
  finally
    Close;
  end;

  cmbbxTagGroup.ItemIndex := 0;
  cmbbxTagGroupChange(Self);
end;

procedure TTagListFrame.RefreshTagSubGroupCombo;
begin
  cmbbxTagSubGroup.Items.Clear;
  cmbbxTagSubGroup.Items.Add('<all values>');

  with adoq do
  try
    ParamCheck := False;
    CommandText := 'SELECT Id, Name FROM ac_TagSubGroup WHERE Deleted = 0 ';

    if cmbbxTagGroup.ItemIndex > 0 then
      CommandText := CommandText +
        ' AND TagGroupId = (SELECT TOP 1 Id FROM ac_TagGroup WHERE Name = ' + QuotedStr(cmbbxTagGroup.Text) + ')';

    CommandText := CommandText + ' ORDER BY Name';
    Open;

    while not EOF do
    begin
      cmbbxTagSubGroup.Items.AddObject(FieldByName('Name').AsString, TInteger.Create(FieldByName('Id').AsInteger));
      Next;
    end;
  finally
    Close;
  end;

  cmbbxTagSubGroup.ItemIndex := 0;
  RefreshTagSectionCombo;
end;

procedure TTagListFrame.RefreshTagSectionCombo;
begin
  cmbbxTagSection.Items.Clear;
  cmbbxTagSection.Items.Add('<all values>');

  with adoq do
  try
    ParamCheck := False;
    CommandText := 'SELECT Id, Name FROM ac_TagSection WHERE Deleted = 0 ';

    if cmbbxTagSubGroup.ItemIndex > 0 then
      CommandText := CommandText +
        'AND TagSubGroupId = (SELECT TOP 1 Id FROM ac_TagSubGroup where Name = ' + QuotedStr(cmbbxTagSubGroup.Text) + ')'
    else if cmbbxTagGroup.ItemIndex > 0 then
      CommandText := CommandText +
        'AND TagSubGroupId IN ' +
          '(SELECT Id FROM ac_TagSubGroup WHERE TagGroupId = ' +
            '(SELECT TOP 1 Id FROM ac_TagGroup WHERE Name = ' + QuotedStr(cmbbxTagGroup.Text) + '))';

    CommandText := CommandText + ' ORDER BY Name';
    Open;

    while not EOF do
    begin
      cmbbxTagSection.Items.AddObject(FieldByName('Name').AsString, TInteger.Create(FieldByName('Id').AsInteger));
      Next;
    end;
  finally
    Close;
  end;

  cmbbxTagSection.ItemIndex := 0;
  RefreshTagSubSectionCombo;
end;

procedure TTagListFrame.RefreshTagSubSectionCombo;
begin
  cmbbxTagSubSection.Items.Clear;
  cmbbxTagSubSection.Items.Add('<all values>');

  with adoq do
  try
    ParamCheck := False;
    CommandText := 'SELECT Id, Name FROM ac_TagSubSection WHERE Deleted = 0 ';

    if cmbbxTagSection.ItemIndex > 0 then
      CommandText := CommandText +
        'AND TagSectionId = (SELECT TOP 1 Id FROM ac_TagSection where Name = ' + QuotedStr(cmbbxTagSection.Text) + ')'
    else if cmbbxTagSubGroup.ItemIndex > 0 then
      CommandText := CommandText +
        'AND TagSectionId IN ' +
          '(SELECT Id FROM ac_TagSection WHERE TagSubGroupId = ' +
            '(SELECT TOP 1 Id FROM ac_TagSubGroup WHERE Name = ' + QuotedStr(cmbbxTagSubGroup.Text) + '))'
    else if cmbbxTagGroup.ItemIndex > 0 then
      CommandText := CommandText +
        'AND TagSectionId IN  ' +
          '(SELECT Id FROM ac_TagSection WHERE TagSubGroupId IN ' +
            '(SELECT Id FROM ac_TagSubGroup WHERE TagGroupId = ' +
              '(SELECT TOP 1 Id FROM ac_TagGroup WHERE Name = ' + QuotedStr(cmbbxTagGroup.Text) + ')))';

    CommandText := CommandText + ' ORDER BY Name';
    Open;

    while not EOF do
    begin
      cmbbxTagSubSection.Items.AddObject(FieldByName('Name').AsString, TInteger.Create(FieldByName('Id').AsInteger));
      Next;
    end;
  finally
    Close;
  end;

  cmbbxTagSubSection.ItemIndex := 0;
end;

procedure TTagListFrame.cmbbxTagGroupChange(Sender: TObject);
begin
  RefreshTagSubGroupCombo;

  if chkboxFiltered.Checked then
    ApplyFilterComboSettings;
end;

procedure TTagListFrame.cmbbxTagSubGroupChange(Sender: TObject);
begin
  RefreshTagSectionCombo;

  if chkboxFiltered.Checked then
    ApplyFilterComboSettings;
end;

procedure TTagListFrame.cmbbxTagSectionChange(Sender: TObject);
begin
  RefreshTagSubSectionCombo;

  if chkboxFiltered.Checked then
    ApplyFilterComboSettings;
end;

procedure TTagListFrame.cmbbxTagSubSectionChange(Sender: TObject);
begin
  if chkboxFiltered.Checked then
    ApplyFilterComboSettings;
end;

procedure TTagListFrame.DestroyComboBox(ComboBox: TComboBox);
var i : integer;
begin
  for i := 0 to ComboBox.Items.Count - 1 do
    ComboBox.Items.Objects[i].Free;
end;

end.
