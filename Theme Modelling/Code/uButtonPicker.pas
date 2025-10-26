unit uButtonPicker;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, DB, ADODB, uTillButton, dbcgrids, ComCtrls,
  ExtCtrls, Buttons, uButtonTypeDropDown, uTag, uTagSelection;

type
  TModCombobox = class(TComboBox)
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure ComboWndProc(var Message: TMessage; ComboWnd: HWnd;
      ComboProc: Pointer); override;
  end;

  TButtonPickerMode = (bpmNormal, bpmRestricted, bpmCustom, bpmForcedSelection, bpmRestrictedCorrection);

  TButtonMenuData = class(TObject)
  public
    multititle: boolean;
    multititleid: int64;
    multititlefield: string;
    buttonsql: string;
  end;

  TButtonPicker = class(TForm)
    ButtonGrid: TDBCtrlGrid;
    ADOQuery1: TADOQuery;
    Panel1: TPanel;
    pnHeader: TPanel;
    ADOQuery2: TADOQuery;
    StatusBar: TStatusBar;
    qButtonList: TADOQuery;
    DataSource2: TDataSource;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    edNameFilter: TEdit;
    edDescFilter: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    cbNameMidword: TCheckBox;
    cbDescMidword: TCheckBox;
    FilterTimer: TTimer;
    TillButton1: TTillButton;
    qGetSearchNames: TADOQuery;
    lblTagFilter: TLabel;
    edtTagFilter: TEdit;
    btnTags: TButton;
    procedure ButtonMenuSelect(Sender: TObject);
    procedure ShowPopup(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qButtonListAfterOpen(DataSet: TDataSet);
    procedure FormResize(Sender: TObject);
    procedure FilterTextChange(Sender: TObject);
    procedure FilterTimerTimer(Sender: TObject);
    procedure ButtonGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBText1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBText3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBText2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure btnTagsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtTagFilterChange(Sender: TObject);
  private
    { Private declarations }
    LastSelectedNode: TTreeNode;
    filtered: boolean;
    FMode: TButtonPickerMode;

    IncSearchString: string;
    LastKeyTime: TDateTime;

    FTagList: TTagList;
    FTagFilterSelector: TfTagSelection;

    procedure BuildButtonMenu;
    procedure ClearFilter;
    procedure RefreshButtonList;
    procedure SetMode(const Value: TButtonPickerMode);
    procedure OverrideTagSelectionWindowPosition(ChildWindow: TForm);
    function ProductTagsExist: Boolean;
    function ProductTagFilteringAllowed: Boolean; overload;
    function ProductTagFilteringAllowed(ButtonSQL: String): Boolean; overload;
    procedure UpdateProductTagFilteringInterface(ShowEnabled: Boolean);
    procedure ApplyFilter;

  public
    ModCombo : TModCombobox;
    ButtonMenuCombo: TButtonMenuCombo;
    current_design_type: integer;
    current_panel_design: integer;
    current_theme: integer;
    property Mode: TButtonPickerMode read FMode write SetMode;
    { Public declarations }
    procedure ButtonMenuCloseUp;
  end;

var
  ButtonPicker: TButtonPicker;

implementation

uses math, uDMThemeData, uAztecLog;

{$R *.dfm}

procedure TButtonPicker.ButtonMenuSelect(Sender: TObject);
begin
  //
end;

procedure TButtonPicker.ShowPopup(Sender: TObject);
var
  pt: TPoint;
begin
  with ButtonMenuCombo do
  begin
    OnCloseUp := ButtonMenuCloseUp;
    pt.X := TControl(sender).Left;
    pt.y := TControl(sender).Top;
    pt := self.clienttoscreen(pt);
    left := pt.X;
    top := pt.y + TControl(sender).height;
    width := TControl(sender).width;
    visible := true;
  end;
end;

procedure TButtonPicker.ButtonMenuCloseUp;
begin
  if assigned(ButtonMenuCombo.Tree.Selected)
    and (LastSelectedNode <> ButtonMenuCombo.Tree.Selected) then
  with ButtonMenuCombo.Tree.Selected do
  begin
    LastSelectedNode := ButtonMenuCombo.Tree.Selected;
    ClearFilter;

    ModCombo.items[0] := text;
    ModCombo.itemindex := 0;

    RefreshButtonList;

    UpdateProductTagFilteringInterface(ProductTagsExist and ProductTagFilteringAllowed);
  end;
end;

{ TModCombobox }

procedure TModCombobox.ComboWndProc(var Message: TMessage; ComboWnd: HWnd;
  ComboProc: Pointer);
begin
{  case Message.Msg of
    WM_KEYDOWN, WM_SYSKEYDOWN, WM_CHAR,WM_KEYUP, WM_SYSKEYUP:
    exit;
  else  }
    inherited;
  {end }
end;

procedure TModCombobox.WMLButtonDown(var Message: TWMLButtonDown);
var
  pt: TPoint;
begin
  with TButtonPicker(owner).ButtonMenuCombo do
  begin
    OnCloseUp := TButtonpicker(owner).ButtonMenuCloseUp;
    pt.X := self.Left;
    pt.y := self.Top;
    pt := self.clienttoscreen(pt);
    left := pt.X;
    top := pt.y + self.height;
    width := self.width;
    visible := true;
  end;
end;

procedure TButtonPicker.FormCreate(Sender: TObject);
begin
  Filtered := false;
  ModCombo := TModCombobox.create(self);
  ModCombo.align := alClient;
  ModCombo.Parent := pnHeader;
  ModCombo.Style := csDropDownList;
  ModCombo.items.add('Select...');
  ModCombo.ItemIndex := 0;
  qGetSearchNames.ExecSQL;
  buttonmenucombo := TButtonMenuCombo.create(self);
  BuildButtonMenu;

  FTagList := TTagList.Create;

  UpdateProductTagFilteringInterface(ProductTagsExist and ProductTagFilteringAllowed);
end;

procedure TButtonPicker.BuildButtonMenu;
var
  openlevels: array[0..10] of TTreenode;
  level, newlevel: integer;
  tmpnode: TTreeNode;
  nodes: TTreeNodes;
  tmpdata: TButtonMenuData;
  i: integer;
begin
  for i := 0 to 10 do
    openlevels[i] := nil;
  level := 0;
  nodes := buttonmenucombo.Tree.Items;
  nodes.Clear;
  with adoquery1 do
  begin
    if mode = bpmNormal then
      sql.text := 'select * from themebuttonmenu where [order] < 2000'
    else
//Added by AK for Bug 336176
    if mode = bpmRestricted then
      sql.text := 'select * from themebuttonmenu where [order] < 2000 ' +
                  'and [order] <> 402'
    else
    if mode = bpmRestrictedCorrection then
      sql.text := 'select * from themebuttonmenu where [order] = 402'
    else
    if mode = bpmCustom then
      sql.text := 'select 100 as [order], 0 as [level], ''select * from #custombuttonmenu'' as ButtonSQL, ''Allowed buttons'' as MenuTitle , null as MenutitleSQL, cast(0 as bit) as MultiTitle, null as MultiTitleFilterField'
    else
    if mode = bpmForcedSelection then
      sql.text := 'select [Order], ' +
                    '(CASE [Order] WHEN 403 THEN 0 ELSE [level] END) as [level], ' +
                    ' [ButtonSQL], [MenuTitle], [MenuTitleSQL], [MultiTitle], [MultiTitleFilterField] ' +
                    'from themebuttonmenu where [order] in (100, 102, 300, 403, 2001)';
    open;
    try
      first;
      while not EOF do
      begin
        // Skip "Table Plans" menu in restricted mode
        if (mode = bpmRestricted) and (fieldbyname('order').asinteger = 504) then
        begin
          next;
          continue;
        end;
        newlevel := fieldbyname('Level').asinteger;
        if fieldbyname('MultiTitle').AsBoolean = false then
        begin
          // normal, one title generating one fixed list of buttons
          tmpnode := TTreenode.create(nodes);
          if newlevel = 0 then
          begin
            // todo: better icons for these..
            tmpnode.ImageIndex := 1;
            tmpnode.SelectedIndex := 2;
          end
          else
          begin
            tmpnode.ImageIndex := 1;
            tmpnode.SelectedIndex := 2;
          end;
          tmpdata := TButtonMenuData.create;
          with tmpdata do
          begin
            multititle := false;
            multititleid := 0;
            buttonsql := fieldbyname('ButtonSQL').asstring;
            // Replace "Panels" menu in restricted mode
            if (fieldbyname('order').asinteger = 500) and (mode = bpmRestricted) then
              buttonsql := StringReplace(
               'select top 0 (select id from themebackdroplookup where value = "Close") as backdrop, '+
               '"" as eposname1, "" as eposname2, "" as eposname3, '+
               '(select id from themebuttontypechoicelookup where Name = "ClosePanel") as ButtonTypeChoiceID, '+
               '"" as ButtonTypeChoiceAttr01,     255 as fontcolourr, 255 as fontcolourg, 255 as fontcolourb, '+
               '"" as buttonname, "" as buttondescription, "" as subcategory', '"', '''', [rfReplaceAll]);
          end;
          if newlevel > level then
            nodes.AddNode(tmpnode, openlevels[level], fieldbyname('MenuTitle').asstring, tmpdata, naAddChild)
          else
            nodes.AddNode(tmpnode, openlevels[newlevel], fieldbyname('MenuTitle').asstring, tmpdata, naAdd);
          level := newlevel;
          openlevels[level] := tmpnode;
        end
        else
        begin
          // multi title menu entry - more than one entry created, based on
          // another query
          adoquery2.SQL.text := fieldbyname('MenuTitleSql').asstring;
          try
            adoquery2.Open;
          except on E:exception do
            begin
              raise exception.createfmt('Error with button SQL %s:%s',
                [fieldbyname('MenuTitle').asstring, e.message]);
            end;
          end;
          adoquery2.First;
          while not adoquery2.Eof do
          begin
            // create each sub menu entry
            tmpnode := TTreenode.create(nodes);
            if newlevel = 0 then
            begin
              tmpnode.ImageIndex := 0;
              tmpnode.SelectedIndex := 0;
            end
            else
            begin
              tmpnode.ImageIndex := 1;
              tmpnode.SelectedIndex := 2;
            end;
            tmpdata := TButtonMenuData.create;
            with tmpdata do
            begin
              multititle := true;
              multititleid := adoquery2.fieldbyname('ID').AsInteger;
              multititlefield := fieldbyname('MultiTitleFilterField').asstring;
              buttonsql := fieldbyname('ButtonSQL').asstring;
            end;
            if newlevel > level then
              nodes.AddNode(tmpnode, openlevels[level], adoquery2.fieldbyname('Title').asstring, tmpdata, naAddChild)
            else
              nodes.AddNode(tmpnode, openlevels[newlevel], adoquery2.fieldbyname('Title').asstring, tmpdata, naAdd);
            level := newlevel;
            openlevels[level] := tmpnode;
            adoquery2.next;
          end;
          adoquery2.close;
        end;
        next;
      end;
    finally
      close;
    end;
  end;
end;

procedure TButtonPicker.qButtonListAfterOpen(DataSet: TDataSet);
var
  cnt: integer;
begin
  cnt := dataset.RecordCount;
  if cnt < 1 then
    statusbar.Simpletext := 'No buttons to display.'
  else
    statusbar.SimpleText := format('%d buttons.', [cnt]);
end;

procedure TButtonPicker.FormResize(Sender: TObject);
begin
  ButtonGrid.RowCount := buttongrid.ClientHeight div 50;
  buttongrid.PanelHeight := 50;
end;

procedure TButtonPicker.FilterTextChange(Sender: TObject);
begin
  if FilterTimer.Enabled then
    FilterTimer.Enabled := false;
  FilterTimer.Enabled := true;
end;

procedure TButtonPicker.FilterTimerTimer(Sender: TObject);
begin
  ApplyFilter;
end;

procedure TButtonPicker.ButtonGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not ButtonGrid.Focused then
    ButtonGrid.SetFocus;

  tillbutton1.mousedown(button, shift, x, y);
//  tillbutton1.BeginDrag(false, 10);
end;

procedure TButtonPicker.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_f5 then
    buttonmenucloseup;
end;

procedure TButtonPicker.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qButtonlist.close;
  adoquery1.close;
  adoquery2.close;
end;

procedure TButtonPicker.SetMode(const Value: TButtonPickerMode);
begin
  if Value <> FMode then
  begin
    FMode := Value;
    qButtonlist.close;
    BuildButtonMenu;
    ModCombo.Items.clear;
    ModCombo.items.add('Select...');
    ModCombo.ItemIndex := 0;
    if Value = bpmNormal then
    begin
      caption := 'Button Picker';
      name := 'ButtonPicker';
    end
    else
    if Value = bpmRestricted then
    begin
      caption := 'Button Picker (Restricted mode)';
      name := 'ButtonPickerR';
      // in restricted mode, most often "products" will be used so pre-select this sub menu
      ModCombo.ItemIndex := 0;
      buttonmenucombo.Tree.Selected := buttonmenucombo.Tree.Items[0];
      ButtonMenuCloseUp;
    end
    else
    if Value = bpmCustom then
    begin
      caption := 'Button Picker (Custom List)';
      name := 'ButtonPickerC';
      // in custom mode, we only have one subsection to the button picker, so pick this one by default
      ModCombo.ItemIndex := 0;
      buttonmenucombo.Tree.Selected := buttonmenucombo.Tree.Items[0];
      ButtonMenuCloseUp;
    end
    else
    if Value = bpmForcedSelection then
    begin
      caption := 'Button Picker (Forced Selection)';
      name := 'ButtonPickerFS';
    end;
  end;
end;

procedure TButtonPicker.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ButtonGrid.Focused then
  begin
    if (now-LastKeyTime) > (0.9/24.0/60.0/60.0) then
      IncSearchString := '';
    LastKeyTime := now;
    IncSearchString := IncSearchString + Key;
    if (ButtonGrid.DataSource.DataSet.State = dsBrowse) then
    begin
      try
        TADOQuery(ButtonGrid.Datasource.DataSet).Locate(
          'buttonname',
          IncSearchString,
          [loCaseInsensitive, loPartialKey]
        );
      except
      end;
    end;
  end;
end;

procedure TButtonPicker.DBText1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not ButtonGrid.Focused then
    ButtonGrid.SetFocus;
end;

procedure TButtonPicker.DBText3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not ButtonGrid.Focused then
    ButtonGrid.SetFocus;
end;

procedure TButtonPicker.DBText2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not ButtonGrid.Focused then
    ButtonGrid.SetFocus;
end;

procedure TButtonPicker.ClearFilter;
begin
  Filtered := false;
  edNameFilter.Clear;
  edDescFilter.Clear;
  FTagList.Clear;
  cbNameMidWord.checked := true;
  cbDescMidWord.checked := true;
  FilterTimer.Enabled := Filtered;
end;

procedure TButtonPicker.RefreshButtonList;
begin
  if assigned(ButtonMenuCombo.Tree.Selected) and
    assigned(ButtonMenuCombo.Tree.Selected.data) then
  with TButtonMenuData(ButtonMenuCombo.Tree.Selected.data) do
  begin
    qButtonList.Paramcheck := false;
    qButtonList.close;
    qButtonList.SQL.clear;
    qButtonList.SQL.Text := buttonsql;
    qButtonlist.SQL.text := stringreplace(qButtonList.SQL.Text, 'current_design_type', inttostr(current_design_type), [rfReplaceAll, rfIgnoreCase]);
    qButtonlist.SQL.text := stringreplace(qButtonList.SQL.Text, 'current_panel_design', inttostr(current_panel_design), [rfReplaceAll, rfIgnoreCase]);
    qButtonlist.sql.text := stringreplace(qButtonList.SQL.Text, 'current_theme', inttostr(current_theme), [rfReplaceAll, rfIgnoreCase]);
    if multititle then
    begin
      qButtonList.SQL[qButtonlist.SQL.IndexOf('where_dynamic')] := (format('where %s = %d', [multititlefield, multititleid]));
    end;
    qButtonlist.SQL.Add('order by subcategory, buttonname');
    try
      qButtonList.Open;
    except on E:Exception do
      begin
        ButtonMenuCombo.OnCloseUp := nil;
        messagedlg('Sorry, there was an error when generating the button list.'+#13+
          'Opening and closing the application may remedy this, otherwise contact Zonal.'+#13+
          #13+
          'The error message was:'+e.message, mtError, [mbOk], 0);
      end;
    end;
  end;
end;

procedure TButtonPicker.FormShow(Sender: TObject);
begin
  RefreshButtonList;
  ApplyFilter;
end;

procedure TButtonPicker.btnTagsClick(Sender: TObject);
begin
  if FTagFilterSelector = nil then
    FTagFilterSelector := TfTagSelection.Create(Self.Parent, nil, tcProduct, dmThemeData.AztecConn, OverrideTagSelectionWindowPosition);

  if FTagFilterSelector.ShowModal = mrOK then
  begin
    FTagList.Clear;
    FTagList.Free;
    FTagList := FTagFilterSelector.SelectedTags.Clone;
    edtTagFilter.Text := FTagList.CommaText;
  end;
end;

procedure TButtonPicker.FormDestroy(Sender: TObject);
begin
  FTagList.Free;
  FTagFilterSelector.Free;
end;

procedure TButtonPicker.edtTagFilterChange(Sender: TObject);
begin
  if FilterTimer.Enabled then
    FilterTimer.Enabled := false;
  FilterTimer.Enabled := true;
  with (Sender as TEdit) do
  begin
    Hint := Text;
  end;
end;

procedure TButtonPicker.OverrideTagSelectionWindowPosition(
  ChildWindow: TForm);
begin
  if Assigned(ChildWindow) then
  begin
    ChildWindow.Top := Top + Height - ChildWindow.Height;
    ChildWindow.Left := Left +  + Width;
  end;
end;

function TButtonPicker.ProductTagsExist: Boolean;
begin
  Result := False;
  with ADOQuery1 do
  try
    SQL.Text := 'select count(*) as NumTags from ac_Tag where IsProductTag = 1';
    Open;
    if not EOF then
      Result := FieldByName('NumTags').AsInteger > 0;
  finally
    Close;
  end;
end;

function TButtonPicker.ProductTagFilteringAllowed: Boolean;
begin
  Result := False;
  if Assigned(ButtonMenuCombo.Tree.Selected) then
    if assigned(ButtonMenuCombo.Tree.Selected.data) then
      Result := ProductTagFilteringAllowed(TButtonMenuData(ButtonMenuCombo.Tree.Selected.data).buttonsql);
end;

function TButtonPicker.ProductTagFilteringAllowed(ButtonSQL: String): Boolean;
begin
  Result := pos('entity type', Lowercase(ButtonSQL)) > 0;
end;

procedure TButtonPicker.UpdateProductTagFilteringInterface(ShowEnabled: Boolean);
begin
  btnTags.Enabled := ShowEnabled;
  lblTagFilter.Enabled := ShowEnabled;
  edtTagFilter.Enabled := ShowEnabled;
  if not ShowEnabled then
  begin
    edtTagFilter.Text := '';
    btnTags.Hint := 'Product tag filtering not available.';
  end
  else begin
   edtTagFilter.Text := FTagList.CommaText;
    btnTags.Hint := '';
  end;                                     
end;

procedure TButtonPicker.ApplyFilter;
var
  //t1 : tdatetime;  // for speed debug only

  hasChoiceAttr02 : boolean;
  SelectClause, NameFltClause, DescFltClause, FltClause: string;
  FilteredByTag, FilteredByNameOrDescription: Boolean;
  treeView : TTreeView;
  treeViewSelected : boolean;
  treeNodeSelected : TTreeNode;
  descriptionFilter, nameFilter: string;
  treeNodeSelectedText : string;
  SelectAggClause : string;
  srcText : string;
  posTxt : integer;
  qButtonlistSql : string;
  butfun, butfun1 : string;

  function RemoveBadFltChars(input:string):string;
  var
    i: integer;
  begin
    result := '';
    for i := 1 to length(input) do
      if input[i] in ['''', '%', '_', '['] then
      begin
        if input[i] = '''' then
          result := result + input[i]+input[i]
        else
          result := result + '['+input[i]+']';
      end
      else
        result := result + input[i];
  end;
begin
  FilterTimer.Enabled := false;

  // ButtonMenuCombo.Tree selected crashes sometimes use a copy
  treeView := ButtonMenuCombo.Tree;
  treeViewSelected := Assigned(treeView) and Assigned(treeView.Selected);
  treeNodeSelected := nil;
  treeNodeSelectedText := '';

  if treeViewSelected then
  begin
   treeNodeSelected := ButtonMenuCombo.Tree.Selected;
   treeNodeSelectedText := treeNodeSelected.text;
  end; 

  // if  (any filters are given OR we are currently filtering)   AND   (Button Menu selected and has a button list)
  if ((edNameFilter.Text <> '') or (edDescFilter.Text <> '') or (FTagList.Count > 0) or filtered)
    and treeViewSelected and qButtonList.active then
  begin
    if Assigned(treeNodeSelected) and Assigned(treeNodeSelected.Data) then
    with TButtonMenuData(treeNodeSelected.Data) do
    begin
      FilteredByTag := (FTagList.Count > 0) and ProductTagFilteringAllowed(buttonsql);
      FilteredByNameOrDescription := (edNameFilter.Text <> '') or (edDescFilter.Text <> '');

      // build button list query from tree-associated data
      qButtonList.Paramcheck := false;
      qButtonList.close;
      qButtonList.SQL.clear;
      qButtonList.SQL.Text := buttonsql;
      qButtonlist.SQL.text := stringreplace(qButtonList.SQL.Text, 'current_design_type', inttostr(current_design_type), [rfReplaceAll, rfIgnoreCase]);
      qButtonlist.SQL.text := stringreplace(qButtonList.SQL.Text, 'current_panel_design', inttostr(current_panel_design), [rfReplaceAll, rfIgnoreCase]);
      qButtonlist.sql.text := stringreplace(qButtonList.SQL.Text, 'current_theme', inttostr(current_theme), [rfReplaceAll, rfIgnoreCase]);

      if multititle then
        qButtonList.SQL[qButtonlist.SQL.IndexOf('where_dynamic')] := (format('where %s = %d', [multititlefield, multititleid]));

      hasChoiceAttr02 := pos('ButtonTypeChoiceAttr02', qButtonlist.SQL.text) <> 0;

      // build up filter where clause
      if edNameFilter.Text <> '' then
      begin
        butfun := '';
        butfun1 := '';
        if (lowercase(treeNodeSelectedText) = lowercase('Gift cards'))
          or (lowercase(treeNodeSelectedText) = lowercase('Delayed orders'))
          or (lowercase(treeNodeSelectedText) = lowercase('Hotel Revenue Centre'))
          or (lowercase(treeNodeSelectedText) = lowercase('Panels root'))
        then
        begin
          butfun :=     'lower(ButtonFunction) like ''%0:s%%'' or ' ;
          butfun1 :=    'lower(ButtonFunction) like ''%%%0:s%%'' or ';
        end;

        nameFilter :=    ' CASE ButtonFunction WHEN ''PAY'' THEN PaymentMethodName ELSE '' '' END';
        if not cbNameMidword.Checked then
          NameFltClause := format(
            'lower(buttonname) like ''%0:s%%'' or '+
            'lower(searchname) like ''%0:s%%'' or ' +
            butfun +
            'lower(' + nameFilter + ') like ''%0:s%%''',
            [lowercase(removebadfltchars(edNameFilter.text))])
        else
          NameFltClause := format(
            'lower(buttonname) like ''%%%0:s%%'' or '+
            'lower(searchname) like ''%%%0:s%%'' or '+
            butfun1 +
            'lower(' + nameFilter + ') like ''%%%0:s%%''',
            [lowercase(removebadfltchars(edNameFilter.text))]);
      end;

      if edDescFilter.Text <> '' then
      begin
        descriptionFilter := '  CASE ButtonFunction WHEN ''PAY'' THEN PaymentMethodDescription ELSE '' '' END';
        if not cbDescMidword.Checked then
          DescFltClause := format(
            'lower(buttondescription) like ''%0:s%%'' or '+
            'lower(' + descriptionFilter + ') like ''%0:s%%''',
            [lowercase(removebadfltchars(edDescFilter.text))])
        else
           DescFltClause := format(
            'lower(buttondescription) like ''%%%0:s%%'' or '+
            'lower(' + descriptionFilter + ') like ''%%%0:s%%''',
            [lowercase(removebadfltchars(edDescFilter.text))]);
      end;

      filtered := False;

      if FilteredByTag or FilteredByNameOrDescription then
      begin
        SelectClause :=  'select distinct ' +
        '     case sub.SearchName  ' +
            '   when '''' then (select top 1 SearchName from #TempSearchAgg where buttonName = sub.buttonname) '+
            '   else sub.SearchName end as SearchName, '+
            ' sub.backdrop, sub.EposName1, sub.EposName2, sub.EposName3, ' +
            ' sub.ButtonTypeChoiceID, sub.ButtonTypeChoiceAttr01, ';

        if hasChoiceAttr02 then   SelectClause := SelectClause + ' sub.ButtonTypeChoiceAttr02, ';

        SelectClause := SelectClause + ' sub.fontcolourr,  sub.fontcolourg,  sub.fontcolourb, ' +
            ' sub.buttonname,  sub.buttondescription,  sub.subcategory,  sub.ButtonFunction ';

        if mode = bpmCustom then  SelectClause := SelectClause + ', sub.ButtonId ';

        SelectClause := SelectClause + 'from (select a.*, t.ButtonFunction %s from(';
      end;

      if (lowercase(treeNodeSelectedText) <> lowercase('Payment')) then
        SelectClause := stringreplace(SelectClause, 'select a.*, t.ButtonFunction',
                           'select a.*, t.ButtonFunction,'''' as PaymentMethodName, '''' as PaymentMethodDescription',
                            [rfReplaceAll, rfIgnoreCase]);


      if FilteredByNameOrDescription then
      begin
        if (lowercase(treeNodeSelectedText) = lowercase('Panels'))
            or (lowercase(treeNodeSelectedText) = lowercase('Delayed orders'))
            or (lowercase(treeNodeSelectedText) = lowercase('Staff'))
        then
          SelectClause := Format(SelectClause,[', LTrim(RTrim(isnull(c.SearchName, isnull(a.eposname1, '''') + '' '' + isnull(a.eposname2, '''')  + '' '' + isnull(a.eposname3, '''') +'' '' + IsNull(a.ButtonTypeChoiceAttr01,'''')) )) as SearchName'])
        else
          SelectClause := Format(SelectClause,[', LTrim(Rtrim(isnull(a.eposname1, '''') + '' '' + isnull(a.eposname2, '''')  + '' '' + isnull(a.eposname3, '''') ))  as SearchName'])
      end
      else if FilteredByTag then
        SelectClause := Format(SelectClause,[', LTrim(Rtrim(isnull(a.eposname1, '''') + '' '' + isnull(a.eposname2, '''')  + '' '' + isnull(a.eposname3, '''') ))  as SearchName'])
      else
        SelectClause := Format(SelectClause,['']);

      if FilteredByNameOrDescription or FilteredByTag then
      begin
        Filtered := true;

        qButtonList.SQL.Add(') a ');
        FltClause := '';
        if edNameFilter.text <> '' then
          FltClause := NameFltClause;
        if edDescFilter.text <> '' then
          if FltClause = '' then
            FltClause := DescFltClause
          else
            FltClause := '(' + FltClause + ') and ('+ DescFltClause +')';

        if hasChoiceAttr02 then
          qButtonList.SQL.Add('left join ThemeButtonTypeChoiceLookup b on a.ButtonTypeChoiceID = b.ID '+
            'left outer join #ButtonNameLookup c on a.ButtonTypeChoiceID = c.ButtonTypeChoiceID '+
            '  and (IsNull(a.ButtonTypeChoiceAttr01, '''') = IsNull(c.ButtonTypeChoiceAttr01, '''') and (IsNull(a.ButtonTypeChoiceAttr02, '''') = IsNull(c.ButtonTypeChoiceAttr02, ''''))) ')
        else
          qButtonList.SQL.Add('left join ThemeButtonTypeChoiceLookup b on a.ButtonTypeChoiceID = b.ID '+
            'left outer join #ButtonNameLookup c on a.ButtonTypeChoiceID = c.ButtonTypeChoiceID '+
            '  and ((IsNull(a.ButtonTypeChoiceAttr01, '''') = IsNull(c.ButtonTypeChoiceAttr01, '''') and c.ButtonTypeChoiceAttr02 is null) )');  // or a.ButtonTypeChoiceAttr01 = ''1''

      	qButtonList.SQL.Add('left join ThemeButtonTypeChoiceLookup bb on bb.id = b.Id');
	qButtonList.SQL.Add('left join ThemeFunctionText t on bb.Name = t.ButtonFunction');
      end;

      if FilteredByTag then //handle the product tag filtering condition
      begin
        Filtered := True;
        qButtonList.SQL.Add('join (select pt.EntityCode from ProductTag pt');
        qButtonList.SQL.Add('      join #Tags st on st.TagId = pt.TagId');
        qButtonList.SQL.Add('      group by pt.EntityCode having count(st.TagId) = (select count(TagId) from #Tags)) sub2');
        qButtonList.SQL.Add('on a.ButtonTypeChoiceAttr01 = sub2.EntityCode');
      end;

      if FilteredByTag or FilteredByNameOrDescription then
        qButtonList.SQL.Add(') sub');
      if FilteredByNameOrDescription then
        qButtonList.SQL.Add('where ' + FltClause);

      qButtonlist.SQL.Add('order by subcategory, buttonname');

      qButtonlistSql := qButtonlist.SQL.Text;
      if FilteredByTag or FilteredByNameOrDescription then
      begin
        SelectAggClause := ' IF OBJECT_ID(''tempdb..#TempSearchName'') IS NOT NULL DROP TABLE #TempSearchName ' +#13#10 +
                         ' IF OBJECT_ID(''tempdb..#TempSearchAgg'') IS NOT NULL DROP TABLE #TempSearchAgg ' +#13#10 +
                         ' select sub.buttonname, sub.SearchName into #TempSearchName ';

        srcText := 'from (select a.*, t.ButtonFunction';
        posTxt:= Pos(srcText, SelectClause);
        SelectAggClause := SelectAggClause + copy(SelectClause, posTxt, maxint);
        qButtonList.Close;
        qButtonlist.SQL.Insert(0, SelectAggClause);

        qButtonlist.SQL.Add('SELECT buttonname, ');
        qButtonlist.SQL.Add('REPLACE(REPLACE(REPLACE( ');
        qButtonlist.SQL.Add('                   (SELECT SearchName as A ');
        qButtonlist.SQL.Add('                    FROM   #TempSearchName ');
        qButtonlist.SQL.Add('                    WHERE  ( buttonname = Results.buttonname ) ');
        qButtonlist.SQL.Add('                    FOR XML PATH ('''')) ');
        qButtonlist.SQL.Add('        , ''</A><A>'', '', '')  ');
      	qButtonlist.SQL.Add('	   ,''<A>'','''') ');
        qButtonlist.SQL.Add('  ,''</A>'','''') AS SearchName ');
        qButtonlist.SQL.Add(' into #TempSearchAgg ');
        qButtonlist.SQL.Add('FROM   #TempSearchName Results ');
        qButtonlist.SQL.Add('GROUP  BY buttonname ');

        //Log('--  into #TempSearchAgg  ----------------------------');
        //Log('  SQL:  ' + qButtonlist.SQL.Text);

        qButtonList.ExecSQL;

      end;
      qButtonList.Close;
      qButtonlist.SQL.Text := qButtonlistSql;
      qButtonlist.SQL.Insert(0, SelectClause);

      //Log('--- qGetSearchNames.SQL -----------------------------------');
      //      Log(qGetSearchNames.SQL.Text);
      //Log('--- qButtonList.SQL -----------------------------------');
      //Log(qButtonList.SQL.Text);
      //t1 := Now;

      qButtonList.Open;

      //Log('--    ' + FormatDateTime('hh:nn:ss.zzz', Now - t1) + '   -----------------');
    end;
  end;
end;

end.
