unit uSetPromotionOrderFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, uAztecLog;

type
  TPromotionOrderData = class(TObject)
    PromotionID: Int64;
    SiteCode: Integer;
    Name: String;
    Description: String;
    Priority: integer;
    Modified: boolean;
    Enabled: boolean;
    isDeal: boolean;
  end;

  TSetPromotionOrderFrame = class(TFrame)
    lbPromotionOrder: TListBox;
    sbMoveUp: TSpeedButton;
    sbMoveDown: TSpeedButton;
    cbAutoPriority: TComboBox;
    Label1: TLabel;
    Label3: TLabel;
    Timer1: TTimer;
    lbOrderHeader: TListBox;
    cbShowConflicts: TCheckBox;
    outerPanel: TPanel;
    dealsPanel: TPanel;
    Splitter1: TSplitter;
    promosPanel: TPanel;
    lblPromosPanel: TLabel;
    lblDealsPanel: TLabel;
    lbDealOrderHeader: TListBox;
    lbDealOrder: TListBox;
    pnlPromoRight: TPanel;
    pnlDealsRight: TPanel;
    sbMoveDownDeal: TSpeedButton;
    sbMoveUpDeal: TSpeedButton;
    pnlDealsLeft: TPanel;
    pnlPromoLeft: TPanel;
    Timer2: TTimer;
    procedure ListHandleDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListHandleDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure sbMoveUpClick(Sender: TObject);
    procedure sbMoveDownClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbPromotionOrderDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure Timer1Timer(Sender: TObject);
    procedure lbOrderHeaderDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormResize(Sender: TObject);
    procedure cbAutoPrioritySelect(Sender: TObject);
    procedure lbPromotionOrderClick(Sender: TObject);
    procedure cbShowConflictsClick(Sender: TObject);
    procedure lbDealOrderDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Timer2Timer(Sender: TObject);
    procedure lbDealOrderDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure sbMoveUpDealClick(Sender: TObject);
    procedure sbMoveDownDealClick(Sender: TObject);
  public
    procedure LoadData(aFilterString: String = ''; aMidWordSearch: Boolean = FALSE; PromotionTemplateID: Integer = 1);
    procedure savePromoOrder(TemplateID: Integer);
    procedure InitialiseFrame;
    procedure FormShow;
  private
    { Private declarations }
    FFilterString: String;
    FFiltered: Boolean;
    FMidWordSearch: Boolean;
    FRequiresEscapeChar: Boolean;
    FSelectedAutoPriorityMode : Integer;
    FPromoIDforConflictFilter : Int64;
    FPromotionTemplateID: Integer;
    focusListBox: TListBox;
    selectedItem: string;
    procedure SwapPriority(InputA, InputB: integer);
    procedure SwapDealPriority(InputA, InputB: integer);
    procedure AddEscapeToWildChars;
    procedure SetPriorityControlsEnabled(newValue: Boolean);
    procedure FillPromotionList;
    procedure ClearPromotionlist;
    procedure HideShowConflictsCheckbox;
    function GetConflictsFilterSQL(PromotionID: Int64): String;
  end;

implementation

uses udmPromotions, uSimpleLocalise, math, DB, uGlobals, uPromoCommon;

{$R *.dfm}

procedure TSetPromotionOrderFrame.AddEscapeToWildChars;
const
  WILD_CARDS: array [1..5] of String = ('%', '[', ']', '_', '^');
var
  i: smallint;
begin
  // ensure that quotes within the filter string are handled
  FFilterString := StringReplace(FFilterString,'''','''''',[rfReplaceAll]);

  for i := 1 to Length(WILD_CARDS) do
    FFilterString := StringReplace(FFilterString, WILD_CARDS[i], ''' + CHAR(0) + ''' + WILD_CARDS[i], [rfReplaceAll]);

  FRequiresEscapeChar := (pos('CHAR(0)', FFilterString) > 0);
end;

procedure TSetPromotionOrderFrame.LoadData(aFilterString: String = ''; aMidWordSearch: Boolean = FALSE; PromotionTemplateID: Integer = 1);
begin
  Log('SetPromotionOrderFrame', 'Loading Data into Instance...');
  // Ensure promotion priorities are unique first
  dmPromotions.FixPriorities(dmPromotions.SiteCode);
  FFilterString := aFilterString;
  FFiltered := (FFilterString <> '');
  FPromotionTemplateID := PromotionTemplateID;
//   Checking if the first char is %,* or _ is here to replicate a fix in the Main Promotions List filtering.
//   That fix puts a '%' character in front of the filter text if any of the Delphi ADO wildcards are the first
//   character in the filter text.  Forcing the filter to do a mid word search stops the filter from crashing.
//   This is here to ensure that the listbox shows exactly the same promotions as the Main Promotions List.
  FMidWordSearch := FFiltered and (aMidWordSearch or (FFilterString[1] in ['%','*','_']));

//   adjust filter string so any SQL wildcard characters will be treated as literal characters
  if FFiltered then
    AddEscapeToWildChars;
end;

procedure TSetPromotionOrderFrame.InitialiseFrame;
begin
  Log('SetPromotionOrderFrame', 'Initialising new frame');
  sbMoveUp.Glyph.LoadFromResourceName(HInstance,'ArrowGlyphUp');
  sbMoveDown.Glyph.LoadFromResourceName(HInstance,'ArrowGlyphDown');
  sbMoveUpDeal.Glyph.LoadFromResourceName(HInstance,'ArrowGlyphUp');
  sbMoveDownDeal.Glyph.LoadFromResourceName(HInstance,'ArrowGlyphDown');
  lbPromotionOrder.DoubleBuffered := True;
  lbOrderHeader.DoubleBuffered := True;
  lbDealOrder.DoubleBuffered := True;
  lbDealOrderHeader.DoubleBuffered := True;
end;

procedure TSetPromotionOrderFrame.ListHandleDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  DragPos: TPoint;
  DragItem: integer;
begin
  DragPos.X := X;
  DragPos.Y := Y;

  DragItem := TListBox(Sender).ItemAtPos(DragPos, False);
  Accept := (Source = lbPromotionOrder) and (DragItem >= 0) and (DragItem < TListBox(Sender).Count);

  Timer1.Enabled := (Source = lbPromotionOrder);
end;

procedure TSetPromotionOrderFrame.lbDealOrderDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  DragPos: TPoint;
  DragItem: integer;
begin
  DragPos.X := X;
  DragPos.Y := Y;

  DragItem := TListBox(Sender).ItemAtPos(DragPos, False);
  Accept := (Source = lbDealOrder) and (DragItem >= 0) and (DragItem < TListBox(Sender).Count);

  Timer2.Enabled := (Source = lbDealOrder);
end;



procedure TSetPromotionOrderFrame.ListHandleDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  DragPos: TPoint;
  i,j,k: integer;
  endpoint: integer;
  WStart, WEnd: Integer;
  SelStart,SelEnd: Integer;

  procedure DoSwap;
  begin
    while i <> j do
    begin
      SwapPriority(i, i + sign(j-i));
      i := i + sign(j-i);
    end;
  end;
begin
  Log('  Set Promotion Priority', 'Item Dropped');
  DragPos.X := X;
  DragPos.Y := Y;

  if lbPromotionOrder.SelCount > 1 then //Multiple, possibly disjoint, drop
  begin
    endpoint := TListBox(Sender).ItemAtPos(DragPos, False);

    SelStart := TListBox(Sender).Count + 1;
    SelEnd := -1;
    for k := 0 to TListBox(Sender).Count - 1 do
    begin
      if TListBox(Sender).Selected[k] then
      begin
        SelStart := Min(k,SelStart);
        SelEnd := Max(k, SelEnd);
      end;
    end;

    if SelStart >= endpoint then
    begin
      WStart  := SelStart;
      WEnd := SelEnd;
    end
    else begin
      WStart := SelEnd;
      WEnd := SelStart;
    end;

    TListBox(Sender).Items.BeginUpdate;
    while true do
    begin
      i := WStart;
      j := endpoint;
      if TListBox(Sender).Selected[i] then
      begin
        DoSwap;
        endpoint := endpoint + sign(WEnd - WStart);
      end;

      if (Wend - Wstart = 0) then Break;

      WStart := WStart + sign(WEnd-WStart);
    end;
    TListBox(Sender).Items.EndUpdate;
  end
  else begin //Single drop
    i := TListBox(Sender).ItemIndex;
    j := TListBox(Sender).ItemAtPos(DragPos, False);

    TListBox(Sender).Items.BeginUpdate;
    DoSwap;
    TListBox(Sender).Items.EndUpdate;
  end;
  Timer1.Enabled := False;
end;

procedure TSetPromotionOrderFrame.lbDealOrderDragDrop(Sender,
  Source: TObject; X, Y: Integer);
var
  DragPos: TPoint;
  i,j,k: integer;
  endpoint: integer;
  WStart, WEnd: Integer;
  SelStart,SelEnd: Integer;

  procedure DoSwap;
  begin
    while i <> j do
    begin
      SwapDealPriority(i, i + sign(j-i));
      i := i + sign(j-i);
    end;
  end;
begin
  Log('  Set Deal Priority', 'Item Dropped');
  DragPos.X := X;
  DragPos.Y := Y;

  if lbDealOrder.SelCount > 1 then //Multiple, possibly disjoint, drop
  begin
    endpoint := TListBox(Sender).ItemAtPos(DragPos, False);

    SelStart := TListBox(Sender).Count + 1;
    SelEnd := -1;
    for k := 0 to TListBox(Sender).Count - 1 do
    begin
      if TListBox(Sender).Selected[k] then
      begin
        SelStart := Min(k,SelStart);
        SelEnd := Max(k, SelEnd);
      end;
    end;

    if SelStart >= endpoint then
    begin
      WStart  := SelStart;
      WEnd := SelEnd;
    end
    else begin
      WStart := SelEnd;
      WEnd := SelStart;
    end;

    TListBox(Sender).Items.BeginUpdate;
    while true do
    begin
      i := WStart;
      j := endpoint;
      if TListBox(Sender).Selected[i] then
      begin
        DoSwap;
        endpoint := endpoint + sign(WEnd - WStart);
      end;

      if (Wend - Wstart = 0) then Break;

      WStart := WStart + sign(WEnd-WStart);
    end;
    TListBox(Sender).Items.EndUpdate;
  end
  else begin //Single drop
    i := TListBox(Sender).ItemIndex;
    j := TListBox(Sender).ItemAtPos(DragPos, False);

    TListBox(Sender).Items.BeginUpdate;
    DoSwap;
    TListBox(Sender).Items.EndUpdate;
  end;
  Timer2.Enabled := False;
end;



procedure TSetPromotionOrderFrame.sbMoveUpClick(Sender: TObject);
var SelItem: Integer;
begin
  lbPromotionOrder.Items.BeginUpdate;
  try
    if lbPromotionOrder.ItemIndex >= 1 then
    begin
      if lbPromotionOrder.SelCount > 1 then
      begin
        SelItem := lbPromotionOrder.ItemIndex;
        lbPromotionOrder.ClearSelection;
        lbPromotionOrder.ItemIndex := SelItem;
        lbPromotionOrder.Selected[SelItem] := True;
      end;
      Log('  Promotion Priority Move Up Button Clicked', lbPromotionOrder.Items[lbPromotionOrder.ItemIndex]);
      SwapPriority(lbPromotionOrder.ItemIndex, lbPromotionOrder.ItemIndex-1);
    end;
  finally
    lbPromotionOrder.Items.EndUpdate;
  end;
end;

procedure TSetPromotionOrderFrame.sbMoveUpDealClick(Sender: TObject);
var SelItem: Integer;
begin
  lbDealOrder.Items.BeginUpdate;
  try
    if lbDealOrder.ItemIndex >= 1 then
    begin
      SelItem := lbDealOrder.ItemIndex;
      if lbDealOrder.SelCount > 1 then
      begin
        lbDealOrder.ClearSelection;
        lbDealOrder.ItemIndex := SelItem;
        lbDealOrder.Selected[SelItem] := True;
      end;
      Log('  Deal Priority Move Up Button Clicked', lbDealOrder.Items[lbDealOrder.ItemIndex]);
      SwapDealPriority(lbDealOrder.ItemIndex, lbDealOrder.ItemIndex-1);
    end;
  finally
    lbDealOrder.Items.EndUpdate;
  end;
end;



procedure TSetPromotionOrderFrame.sbMoveDownClick(Sender: TObject);
var SelItem: Integer;
begin
  lbPromotionOrder.Items.BeginUpdate;
  try
    if (lbPromotionOrder.ItemIndex <> -1) and (lbPromotionOrder.ItemIndex < lbPromotionOrder.Count-1) then
    begin
      if lbPromotionOrder.SelCount > 1 then
      begin
        SelItem := lbPromotionOrder.ItemIndex;
        lbPromotionOrder.ClearSelection;
        lbPromotionOrder.ItemIndex := SelItem;
        lbPromotionOrder.Selected[SelItem] := True;
      end;
      Log('  Promotion Priority Move Down Button Clicked', lbPromotionOrder.Items[lbPromotionOrder.ItemIndex]);
      SwapPriority(lbPromotionOrder.ItemIndex, lbPromotionOrder.ItemIndex+1);
    end;
  finally
    lbPromotionOrder.Items.EndUpdate;
  end;
end;

procedure TSetPromotionOrderFrame.sbMoveDownDealClick(Sender: TObject);
var SelItem: Integer;
begin
  lbDealOrder.Items.BeginUpdate;
  try
    if (lbDealOrder.ItemIndex <> -1) and (lbDealOrder.ItemIndex < lbDealOrder.Count-1) then
    begin
      if lbDealOrder.SelCount > 1 then
      begin
        SelItem := lbDealOrder.ItemIndex;
        lbDealOrder.ClearSelection;
        lbDealOrder.ItemIndex := SelItem;
        lbDealOrder.Selected[SelItem] := True;
      end;
      Log('  Deal Priority Move Down Button Clicked', lbDealOrder.Items[lbDealOrder.ItemIndex]);
      SwapDealPriority(lbDealOrder.ItemIndex, lbDealOrder.ItemIndex+1);
    end;
  finally
    lbDealOrder.Items.EndUpdate;
  end;
end;


procedure TSetPromotionOrderFrame.FormShow;
var
  i: integer;
begin
  Log('SetPromotionOrder', 'Show');
  dealsPanel.Visible := dmPromotions.usePromoDeals;
  splitter1.Visible := dealsPanel.Visible;
  lblPromosPanel.Visible := dealsPanel.Visible;

  FillPromotionList;
  uSimpleLocalise.LocaliseForm(self);
  for i := 0 to Pred(cbAutoPriority.Items.Count) do
    cbAutoPriority.Items[i] := uSimpleLocalise.LocaliseString(cbAutoPriority.Items[i]);
  cbAutoPriority.ItemIndex := dmPromotions.GetAutoPriorityMode(FPromotionTemplateID);
  FSelectedAutoPriorityMode := cbAutoPriority.ItemIndex;
  if dmPromotions.PromotionMode = pmSite then
  begin
    cbAutoPriority.Enabled := False;
    HideShowConflictsCheckbox;
  end;

  SetPriorityControlsEnabled(cbAutoPriority.Text = '<None>');
end;

procedure TSetPromotionOrderFrame.FillPromotionList();
var
  TmpPromoData: TPromotionOrderData;
  SiteFilter, StatusFilter, NameFilter, ConflictFilter: string;
begin
  with dmPromotions.adoqRun do
  begin
    ClearPromotionlist;

    if dmPromotions.PromotionsHideDisabled then
      StatusFilter := 'Status = 0 AND'
    else
      StatusFilter := '';

    SiteFilter := Format('SiteCode = %d AND', [dmPromotions.SiteCode]);

    if FFiltered then
    begin
      if FMidWordSearch then
        nameFilter := '''%' + FFilterString + '%'' '
      else
        nameFilter := '''' + FFilterString  + '%'' ';

      if FRequiresEscapeChar then
        nameFilter := nameFilter + ' ESCAPE CHAR(0) ';

      NameFilter := '(Name LIKE ' + nameFilter + ' OR Description LIKE ' + nameFilter + ' ) AND';
    end
    else
      NameFilter := '';

    if cbShowConflicts.Checked then
      ConflictFilter := GetConflictsFilterSQL(FPromoIDforConflictFilter)
    else
      ConflictFilter := '';

    if dealsPanel.Visible then  // include Deals
      SQL.Text := Format('SELECT p.Name, p.Description, p.SiteCode, p.PromotionID, pto.Priority, p.Status, p.UserSelectsProducts' +
          ' FROM Promotion p join #PriorityTemplateOrder pto on p.PromotionID = pto.PromotionID ' +
          ' WHERE %s %s %s %s p.PromoTypeID NOT IN (4) ORDER BY Priority ASC',
        [SiteFilter, StatusFilter, NameFilter, ConflictFilter])
    else                        // exclude Deals
      SQL.Text := Format('SELECT p.Name, p.Description, p.SiteCode, p.PromotionID, pto.Priority, p.Status, p.UserSelectsProducts' +
          ' FROM Promotion p join #PriorityTemplateOrder pto on p.PromotionID = pto.PromotionID ' +
          ' WHERE %s %s %s %s p.PromoTypeID NOT IN (4) and p.UserSelectsProducts = 0 ORDER BY Priority ASC',
        [SiteFilter, StatusFilter, NameFilter, ConflictFilter]);

    Open;
    while not EOF do
    begin
      TmpPromoData := TPromotionOrderData.Create;
      TmpPromoData.PromotionID := TLargeIntField(FieldByName('PromotionId')).AsLargeInt;
      TmpPromoData.SiteCode := FieldByName('SiteCode').AsInteger;
      TmpPromoData.Name := StringReplace(FieldByName('Name').AsString, '&', '&&', [rfIgnoreCase, rfReplaceAll]);
      TmpPromoData.Description := StringReplace(FieldByName('Description').AsString, '&', '&&', [rfIgnoreCase, rfReplaceAll]);
      TmpPromoData.Priority := FieldByName('Priority').AsInteger;
      TmpPromoData.Modified := False;
      TmpPromoData.Enabled := FieldByName('Status').AsInteger = 0;
      TmpPromoData.isDeal := FieldByName('UserSelectsProducts').AsBoolean;
      if TmpPromoData.isDeal then
      begin
        if TmpPromoData.Enabled then
          lbDealOrder.Items.AddObject(FieldByName('Name').AsString, TmpPromoData)
        else
          lbDealOrder.Items.AddObject(FieldByName('Name').AsString+' (Disabled)', TmpPromoData);
      end
      else
      begin
        if TmpPromoData.Enabled then
          lbPromotionOrder.Items.AddObject(FieldByName('Name').AsString, TmpPromoData)
        else
          lbPromotionOrder.Items.AddObject(FieldByName('Name').AsString+' (Disabled)', TmpPromoData);
      end;
      Next;
    end;
  end;
end;

procedure TSetPromotionOrderFrame.ClearPromotionlist();
var
  i : integer;
begin
  for i := 0 to Pred(lbPromotionOrder.Items.Count) do
  begin
    lbPromotionOrder.Items.Objects[i].Free;
  end;
  lbPromotionOrder.Clear;

  if dealsPanel.Visible then
  begin
    for i := 0 to Pred(lbDealOrder.Items.Count) do
    begin
      lbDealOrder.Items.Objects[i].Free;
    end;
    lbDealOrder.Clear;
  end;
end;

function TSetPromotionOrderFrame.GetConflictsFilterSQL(PromotionID: Int64): String;
var
  filterString: string;
begin
  filterString := Format('p.PromotionID in (' + #13 +
  '     select distinct p.PromotionID' + #13 +
  '     from promotion p' + #13 +
  '     inner join PromotionSalesArea psa ' + #13 +
  '     on p.PromotionId = psa.PromotionID ' + #13 +
  '     inner join PromotionTimeCycles ptc ' + #13 +
  '     on p.PromotionId = ptc.PromotionId ' + #13 +
  '     where salesAreaID in (select psa.SalesAreaID ' + #13 +
  '			from promotionSalesArea psa' + #13 +
  '			where psa.PromotionID = %0:d)' + #13 +
  '     and p.PromotionID in (select distinct sgd.PromotionID ' + #13 +
  '     		from PromotionSaleGroupDetail sgd ' + #13 +
  '			join (select distinct ProductID, PortionTypeID ' + #13 +
  '     			from PromotionSaleGroupDetail ' + #13 +
  '				where PromotionID = %0:d) sub ' + #13 +
  '			on sgd.ProductID = sub.ProductID and sgd.PortionTypeID = sub.PortionTypeID ' + #13 +
  '			)' + #13 +
  '     and TimeCycleId in (select distinct TimeCycleID ' + #13 +
  '                     from (select DayOfWeek, StartTime, EndTime ' + #13 +
  '			        from ThemeTimeCycleDetails ' + #13 +
  '     		        where TimeCycleId in (select TimeCycleId ' + #13 +
  '				                from PromotionTimeCycles ' + #13 +
  '						where PromotionID = %0:d)) sub ' + #13 +
  '			join themetimecycledetails tcd ' + #13 +
  '                     on sub.dayofweek = tcd.dayofweek ' + #13 +
  '           	        where ( ' + #13 +
  '     			(tcd.StartTime between sub.StartTime and sub.EndTime) ' + #13 +
  '				or (tcd.EndTime between sub.StartTime and sub.EndTime) ' + #13 +
  '				or (sub.StartTime between tcd.StartTime and tcd.EndTime) ' + #13 +
  '    			) ' + #13 +
  '		) ' + #13 +
  '      ) AND ', [PromotionID]);
  result := filterString;
end;

procedure TSetPromotionOrderFrame.HideShowConflictsCheckbox();
var
  moveAmount: Integer;
begin
  moveAmount := cbShowConflicts.Height;
  cbShowConflicts.Visible := False;
  outerPanel.Top := outerPanel.Top - moveAmount;
end;

procedure TSetPromotionOrderFrame.SwapPriority(InputA, InputB: integer);
var
  DataA, DataB: TPromotionOrderData;
  TmpPriority: integer;
begin
  DataA := TPromotionOrderData(lbPromotionOrder.Items.Objects[InputA]);
  DataB := TPromotionOrderData(lbPromotionOrder.Items.Objects[InputB]);
  TmpPriority := DataA.Priority;
  DataA.Priority := DataB.Priority;
  DataB.Priority := TmpPriority;
  DataA.Modified := True;
  DataB.Modified := True;
  // Swap items in the list view
  lbPromotionOrder.Items.Exchange(InputA, InputB);
end;

procedure TSetPromotionOrderFrame.SwapDealPriority(InputA, InputB: integer);
var
  DataA, DataB: TPromotionOrderData;
  TmpPriority: integer;
begin
  DataA := TPromotionOrderData(lbDealOrder.Items.Objects[InputA]);
  DataB := TPromotionOrderData(lbDealOrder.Items.Objects[InputB]);
  TmpPriority := DataA.Priority;
  DataA.Priority := DataB.Priority;
  DataB.Priority := TmpPriority;
  DataA.Modified := True;
  DataB.Modified := True;
  // Swap items in the list view
  lbDealOrder.Items.Exchange(InputA, InputB);
end;

procedure TSetPromotionOrderFrame.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to pred(lbPromotionOrder.Items.Count) do
    lbPromotionOrder.Items.Objects[i].Free;

  for i := 0 to Pred(lbDealOrder.Items.Count) do
    lbDealOrder.Items.Objects[i].Free;
end;

procedure TSetPromotionOrderFrame.lbPromotionOrderDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  fmt: Cardinal;
  NameRect: TRect;
  DescriptionRect: TRect;
  TempPromotionOrderData: TPromotionOrderData;
begin
  with (Control as TListBox).Canvas do
  begin
    TempPromotionOrderData := TPromotionOrderData(TListBox(Control).Items.Objects[Index]);
    if not TempPromotionOrderData.Enabled or not Control.Enabled then
      Font.Color := clGrayText;
    FillRect(Rect);

    NameRect := Rect;
    DescriptionRect := Rect;
    NameRect.Right := Rect.Left + ((Rect.Right - Rect.Left) div 3) - 5;
    DescriptionRect.Left := NameRect.Right + 10;

    //fmt := DT_END_ELLIPSIS or DT_EXPANDTABS or DT_CALCRECT or DT_NOCLIP;
    fmt := DT_END_ELLIPSIS or DT_NOCLIP;
    DrawText(Handle, PChar(TempPromotionOrderData.Name), Length(TempPromotionOrderData.Name),
        NameRect, fmt);
    DrawText(Handle, PChar(TempPromotionOrderData.Description), Length(TempPromotionOrderData.Description),
        DescriptionRect, fmt);
  end;
end;


procedure TSetPromotionOrderFrame.Timer1Timer(Sender: TObject);
var
  Pt: TPoint;
begin
  // Stop timer and exit if not dragging any more
  if not lbPromotionOrder.Dragging then begin
    Timer1.Enabled := False;
    Exit;
  end;

  Pt := lbPromotionOrder.ScreenToClient(Mouse.CursorPos);
  if (Pt.Y < 0) then
  begin
    Timer1.Enabled := False;
    Timer1.Interval := 250 - Trunc(250 * Min(Abs(Pt.Y)/100,0.98));
    Timer1.Enabled := True;
    lbPromotionOrder.Perform(WM_VSCROLL, SB_LINEUP, 0)
  end
  else if Pt.Y > lbPromotionOrder.ClientHeight then
  begin
    Timer1.Enabled := False;
    Timer1.Interval := 250 - Trunc(250 * Min(Abs(Pt.Y - lbPromotionOrder.ClientHeight)/100,0.98));
    Timer1.Enabled := True;
    lbPromotionOrder.Perform(WM_VSCROLL, SB_LINEDOWN, 0)
  end
  else
    Timer1.Enabled := False;
end;

procedure TSetPromotionOrderFrame.lbOrderHeaderDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  fmt: Cardinal;
  NameRect: TRect;
  DescriptionRect: TRect;
begin
  with (Control as TListBox).Canvas do
  begin
    FillRect(Rect);

    Rect.Right := Rect.Right - GetSystemMetrics(SM_CXVSCROLL);

    if not lbPromotionOrder.Enabled then
      Font.Color := clGrayText;

    NameRect := Rect;
    DescriptionRect := Rect;
    NameRect.Right := Rect.Left + ((Rect.Right - Rect.Left) div 3) - 5;
    DescriptionRect.Left := NameRect.Right + 10;

    //fmt := DT_END_ELLIPSIS or DT_EXPANDTABS or DT_CALCRECT or DT_NOCLIP;
    fmt := DT_END_ELLIPSIS;
    DrawText(Handle, PChar('Name'), Length('Name'), NameRect, fmt);
    DrawText(Handle, PChar('Description'), Length('Description'), DescriptionRect, fmt);
  end;
end;

procedure TSetPromotionOrderFrame.FormResize(Sender: TObject);
begin
  lbPromotionOrder.Invalidate;
  if dealsPanel.Visible then lbDealOrder.Invalidate;
end;

procedure TSetPromotionOrderFrame.cbAutoPrioritySelect(Sender: TObject);
begin
  if (cbAutoPriority.ItemIndex <> FSelectedAutoPriorityMode) AND (MessageDlg('Changing the automatic priority mode ' +
        'will result in changes to behaviour on site, including changes to prices charged to customers when ' +
        'promotions are triggered. Are you sure?',
                mtWarning, [mbYes, mbNo], -1) = mrYes) then
  begin
    Log('SetPromotionOrder', 'Auto Priority changed from ' + cbAutoPriority.Items[FSelectedAutoPriorityMode] +
                        ' to ' + cbAutoPriority.Text);
    FSelectedAutoPriorityMode := cbAutoPriority.ItemIndex;
    SetPriorityControlsEnabled(cbAutoPriority.Text = '<None>');
  end
  else
    cbAutoPriority.ItemIndex := FSelectedAutoPriorityMode;
end;

procedure TSetPromotionOrderFrame.SetPriorityControlsEnabled(newValue: Boolean);
var
  i : integer;
begin
  lbPromotionOrder.Enabled := newValue;
  sbMoveUp.Enabled := newValue;
  sbMoveDown.Enabled := newValue;
  lbDealOrder.Enabled := newValue;
  sbMoveUpDeal.Enabled := newValue;
  sbMoveDownDeal.Enabled := newValue;
  cbShowConflicts.Enabled := newValue AND ((lbPromotionOrder.Items.Count + lbDealOrder.Items.Count) > 0);
  if not cbShowConflicts.Enabled then
    cbShowConflicts.Checked := false;
  if not newValue then
  begin
    for i := 0 to lbPromotionOrder.Items.Count - 1 do
      lbPromotionOrder.Selected[i] := False;
    for i := 0 to lbDealOrder.Items.Count - 1 do
      lbDealOrder.Selected[i] := False;
  end;
end;

procedure TSetPromotionOrderFrame.lbPromotionOrderClick(Sender: TObject);
begin
  cbShowConflicts.Enabled := (Sender as TListBox).SelCount <= 1;
  focusListBox := (Sender as TListBox);
end;

procedure TSetPromotionOrderFrame.cbShowConflictsClick(Sender: TObject);
var
  SavedCursorState: TCursor;
begin
  if (focusListBox = nil) then
  begin
    if (dealsPanel.Visible) then
      focusListBox := lbDealOrder
    else
      focusListBox := lbPromotionOrder;
  end;

  if focusListBox.ItemIndex >= 0 then
  begin
    SavedCursorState := Screen.Cursor;
    try
      if focusListBox.Items.Count >= 1 then
          selectedItem := focusListBox.Items[focusListBox.ItemIndex];

      Screen.Cursor := crHourGlass;
      Application.ProcessMessages;

      savePromoOrder(FPromotionTemplateID);
      if cbShowConflicts.Checked then
      begin
        cbShowConflicts.Caption := 'Showing only promotions which conflict with '
            + focusListBox.Items[focusListBox.ItemIndex];
        FPromoIdforConflictFilter := TPromotionOrderData(focusListBox.Items.Objects[focusListBox.ItemIndex]).PromotionID;
      end
      else
        cbShowConflicts.Caption := 'Show only promotions which conflict with current selection';
      FillPromotionList;
      focusListBox.Selected[focusListBox.Items.IndexOf(selectedItem)] := True;
    finally
      Screen.Cursor := SavedCursorState;
    end;
  end

end;

procedure TSetPromotionOrderFrame.savePromoOrder(TemplateID: Integer);
var
  i : Integer;
begin
  FPromotionTemplateID := TemplateID;

  for i := 0 to pred(lbDealOrder.Items.Count) do
  begin
    with dmPromotions, TPromotionOrderData(lbDealOrder.Items.Objects[i]) do
      if Modified then
      begin
        adoqRun.SQL.Text := Format('update #PriorityTemplateOrder set Priority = %d where PromotionId = %d',
          [Priority, PromotionID]);
        adoqRun.ExecSQL;
      end;
  end;

  for i := 0 to pred(lbPromotionOrder.Items.Count) do
  begin
    with dmPromotions, TPromotionOrderData(lbPromotionOrder.Items.Objects[i]) do
      if Modified then
      begin
        adoqRun.SQL.Text := Format('update #PriorityTemplateOrder set Priority = %d where PromotionId = %d',
          [Priority, PromotionID]);
        adoqRun.ExecSQL;
      end;
  end;
  if uGlobals.IsMaster then
    dmPromotions.SetAutoPriorityMode(FSelectedAutoPriorityMode, FPromotionTemplateID);
end;

procedure TSetPromotionOrderFrame.Timer2Timer(Sender: TObject);
var
  Pt: TPoint;
begin
  // Stop timer and exit if not dragging any more
  if not lbDealOrder.Dragging then begin
    Timer2.Enabled := False;
    Exit;
  end;

  Pt := lbDealOrder.ScreenToClient(Mouse.CursorPos);
  if (Pt.Y < 0) then
  begin
    Timer2.Enabled := False;
    Timer2.Interval := 250 - Trunc(250 * Min(Abs(Pt.Y)/100,0.98));
    Timer2.Enabled := True;
    lbDealOrder.Perform(WM_VSCROLL, SB_LINEUP, 0)
  end
  else if Pt.Y > lbDealOrder.ClientHeight then
  begin
    Timer2.Enabled := False;
    Timer2.Interval := 250 - Trunc(250 * Min(Abs(Pt.Y - lbDealOrder.ClientHeight)/100,0.98));
    Timer2.Enabled := True;
    lbDealOrder.Perform(WM_VSCROLL, SB_LINEDOWN, 0)
  end
  else
    Timer2.Enabled := False;
end;

end.
