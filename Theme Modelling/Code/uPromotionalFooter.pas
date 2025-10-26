unit uPromotionalFooter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, ActnList, DB, ADODB,
  ImgList;

type
  THackedADOQuery = class(TADOQuery)
  end;

  TPromotionalFooter = class(TForm)
    dbgPromotionalFooters: TwwDBGrid;
    Bevel1: TBevel;
    lblPromoFooters: TLabel;
    btnNew: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    btnEnableDisable: TButton;
    cbHideDisabledFooters: TCheckBox;
    PromotionalFooterActionList: TActionList;
    actEnableDisable: TAction;
    btnClose: TButton;
    btnSetPriority: TButton;
    actSetPriority: TAction;
    btnCopy: TButton;
    btnOverride: TButton;
    btnMapOverrides: TButton;
    actOverride: TAction;
    actMapOverrides: TAction;
    ilSortGlyphs: TImageList;
    FilterPanel: TPanel;
    edtFilterText: TEdit;
    chkbxMidwordSearch: TCheckBox;
    chkbxFiltered: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbHideDisabledFootersClick(Sender: TObject);
    procedure actEnableDisableUpdate(Sender: TObject);
    procedure actEnableDisableExecute(Sender: TObject);
    procedure PromotionalFooterActionListExecute(Action: TBasicAction;
      var Handled: Boolean);
    procedure btnNewClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure actSetPriorityExecute(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure dbgPromotionalFootersDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actOverrideExecute(Sender: TObject);
    procedure actMapOverridesExecute(Sender: TObject);
    procedure actOverrideUpdate(Sender: TObject);
    procedure actMapOverridesUpdate(Sender: TObject);
    procedure dbgPromotionalFootersTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure dbgPromotionalFootersDrawTitleCell(Sender: TObject;
      Canvas: TCanvas; Field: TField; Rect: TRect;
      var DefaultDrawing: Boolean);
    procedure ApplyFilterSettings(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PromotionalFooter: TPromotionalFooter;

implementation

uses
  uDMPromotionalFooter, uFormNavigate, uPromotionalFooterWizard, uPromotionalFooterPriorities,
  uAztecLog, uDMThemeData, uGlobals, uMapFootertext;
{$R *.dfm}

procedure TPromotionalFooter.FormShow(Sender: TObject);
begin
  dmPromotionalFooter.qPromotionalFooter.Active := True;
  // if Site or Single Site Master allow Overrides and Mapping Overrides
  if IsSite then
  begin
    dmPromotionalFooter.qCanOverridePromotionalFooter.Active := True;
    dmPromotionalFooter.qAllOverrideSalesAreas.Active := True;
  end;
  cbHideDisabledFooters.Checked := dmPromotionalFooter.HideDisabledPromotionalFooters;
end;

procedure TPromotionalFooter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dmPromotionalFooter.ClearMainPromotionalFooterListFilter;
  // if Site or Single Site Master allow Overrides and Mapping Overrides
  if IsSite then
  begin
    dmPromotionalFooter.qCanOverridePromotionalFooter.Active := False;
    dmPromotionalFooter.qAllOverrideSalesAreas.Active := False;
  end;
  dmPromotionalFooter.qPromotionalFooter.Active := False;
  Nav.MoveBack;
end;

procedure TPromotionalFooter.cbHideDisabledFootersClick(Sender: TObject);
begin
  if cbHideDisabledFooters.Checked then
    Log('Promotional Footers - cbHideDisabledFooters Checked')
  else
    Log('Promotional Footers - cbHideDisabledFooters unchecked');
  dmPromotionalFooter.HideDisabledPromotionalFooters := cbHideDisabledFooters.Checked;
end;

procedure TPromotionalFooter.actEnableDisableUpdate(Sender: TObject);
var
  Dataset: TDataset;
begin
  Dataset := dbgpromotionalFooters.DataSource.DataSet;
  TAction(Sender).Enabled := (Dataset.RecordCount <> 0) and IsMaster;
  if Dataset.RecordCount <> 0 then
    case TFooterStatus(Dataset.FieldByName('Status').AsInteger) of
      fsEnabled: TAction(Sender).Caption := 'Disable';
      fsDisabled: TAction(Sender).Caption := 'Enable';
    end;
end;

procedure TPromotionalFooter.actEnableDisableExecute(Sender: TObject);
var
  Dataset: TDataset;
  procedure SetStatus(Status: TFooterStatus);
  begin
    Dataset.Edit;
    Dataset.FieldByName('Status').AsInteger := Ord(Status);
    Dataset.Post;
  end;
begin
  Log(Format('Promotional Footers - %s footer pressed',[TAction(Sender).Caption]));
  if dbgPromotionalFooters.DataSource.Dataset.RecordCount = 0 then
    raise Exception.Create('Please pick a footer to '+TAction(Sender).Caption+' first');
  Log(Format('  %s footer - id = %d ', [TAction(Sender).Caption,dmPromotionalFooter.qPromotionalFooter.FieldByName('Id').AsInteger]));
  Dataset := dbgPromotionalFooters.DataSource.DataSet;
  if Dataset.RecordCount <> 0 then
    case TFooterStatus(Dataset.FieldByName('Status').AsInteger) of
      fsEnabled:
      begin
        SetStatus(fsDisabled);
      end;
      fsDisabled:
      begin
        SetStatus(fsEnabled);
      end;
    end;
end;

procedure TPromotionalFooter.PromotionalFooterActionListExecute(
  Action: TBasicAction; var Handled: Boolean);
begin
  dbgPromotionalFooters.SetFocus;
end;

procedure TPromotionalFooter.btnNewClick(Sender: TObject);
begin
  Log('Promotional Footers - New footer pressed');
  if TPromotionalFooterWizard.ShowWizard(-1,-1) then
    dmPromotionalFooter.UpdatePromotionalFooterQuery;
end;

procedure TPromotionalFooter.btnCloseClick(Sender: TObject);
begin
  Log('Promotional Footers - Close clicked');
  Close;
end;

procedure TPromotionalFooter.btnEditClick(Sender: TObject);
var
  OldFooter: Integer;
begin
  Log('Promotional Footers - Edit footer pressed');
  if dbgPromotionalFooters.DataSource.Dataset.RecordCount = 0 then
    raise Exception.Create('Please pick a footer to edit first');
  Log(Format('  Edit Footer - footer id = %d',
             [dbgPromotionalFooters.DataSource.DataSet.FieldByName('Id').AsInteger]));
  TPromotionalFooterWizard.ShowWizard(
    dbgPromotionalFooters.DataSource.DataSet.FieldByName('Id').AsInteger,
    dbgPromotionalFooters.DataSource.DataSet.FieldByName('Id').AsInteger);

  OldFooter := dbgPromotionalFooters.DataSource.Dataset.FieldByName('Id').AsInteger;
  dbgPromotionalFooters.DataSource.DataSet.Close;
  dbgPromotionalFooters.DataSource.DataSet.Open;
  dbgPromotionalFooters.DataSource.Dataset.Locate('Id', OldFooter, []);
end;

procedure TPromotionalFooter.actSetPriorityExecute(Sender: TObject);
var
  Priorities: TPromotionalFooterPriorities;
begin
  Log('Promotional Footers - Set Priorities clicked');
  Priorities := TPromotionalFooterPriorities.Create(Self);
  try
    Priorities.ShowModal;
  finally
    Priorities.Release;
  end;
end;

procedure TPromotionalFooter.btnDeleteClick(Sender: TObject);
begin
  Log('Promotional Footers - Delete footer pressed');
  if dbgPromotionalFooters.DataSource.Dataset.RecordCount = 0 then
    raise Exception.Create('Please pick a footer to delete first');
  if MessageDlg('Are you sure?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dmPromotionalFooter.BeginHourglass;
    with dmThemeData do try
      Log(Format('  Deleting footer - id = %d ', [dmPromotionalFooter.qPromotionalFooter.FieldByName('Id').AsInteger]));
      adoqRun.SQL.Text := Format('DELETE PromotionalFooter where Id = %d',
        [dmPromotionalFooter.qPromotionalFooter.FieldByName('Id').AsInteger]);
      adoqRun.ExecSQL;
      dmPromotionalFooter.UpdatePromotionalFooterQuery;
    finally
      dmPromotionalFooter.EndHourglass;
    end;
  end;
end;

procedure TPromotionalFooter.btnCopyClick(Sender: TObject);
begin
  Log('Promotional Footers - Copy footer pressed');
  if dbgPromotionalFooters.DataSource.Dataset.RecordCount = 0 then
    raise Exception.Create('Please pick a footer to copy first');
  Log(Format('  Copy Footer - footer id = %d',
             [dbgPromotionalFooters.DataSource.DataSet.FieldByName('Id').AsInteger]));

  if TPromotionalFooterWizard.ShowWizard(
      -1,
      dbgPromotionalFooters.DataSource.DataSet.FieldByName('Id').AsInteger
    ) then
    dmPromotionalFooter.UpdatePromotionalFooterQuery;
end;

procedure TPromotionalFooter.dbgPromotionalFootersDblClick(
  Sender: TObject);
var
  Point: TPoint;
begin
  if TwwDbGrid(Sender).DataSource.DataSet.RecordCount > 0 then
  begin
    Point := TwwDBGrid(sender).ScreenToClient(Mouse.CursorPos);
    if TwwDBGrid(sender).MouseCoord(Point.x, Point.y).y > 0 then
      if IsSite and not IsMaster then
      begin
        if actOverride.Enabled then
          actOverrideExecute(self)
        else
          if (dbgPromotionalFooters.DataSource.DataSet.FieldByName('Status').AsInteger = 1) then
            MessageDlg('Overrides cannot be created for this Promotional Footer' + #13#10 +
                'as it is currently disabled',mtInformation,[mbOK],0)
          else
            MessageDlg('Overrides cannot be created for this Promotional Footer' + #13#10 +
                'as there are no Sales Areas configured to allow overrides',mtInformation,[mbOK],0)
      end
      else
        btnEditClick(self);
  end;
end;
    
procedure TPromotionalFooter.FormCreate(Sender: TObject);
begin
  if (IsSite and not IsMaster) then
  begin
    btnNew.Enabled := False;
    btnEdit.Enabled := False;
    btnDelete.Enabled := False;
    btnEnableDisable.Enabled := False;
    btnSetPriority.Enabled := False;
    btnCopy.Enabled := False;
  end;

  // allowed both for Sites and Single Site Masters
  if IsSite then
  begin
    actOverride.Visible := True;
    actMapOverrides.Visible := True;
  end;
end;

procedure TPromotionalFooter.actOverrideExecute(Sender: TObject);
var
  OldFooter: Integer;
begin
  Log('Promotional Footers - Override footer pressed');
  if dbgPromotionalFooters.DataSource.Dataset.RecordCount = 0 then
    raise Exception.Create('Please pick a footer to override first');
  Log(Format('  Override Footer - footer id = %d',
             [dbgPromotionalFooters.DataSource.DataSet.FieldByName('Id').AsInteger]));
  TPromotionalFooterWizard.ShowWizard(
    dbgPromotionalFooters.DataSource.DataSet.FieldByName('Id').AsInteger,
    dbgPromotionalFooters.DataSource.DataSet.FieldByName('Id').AsInteger,
    wmOverrideFooter);

  OldFooter := dbgPromotionalFooters.DataSource.Dataset.FieldByName('Id').AsInteger;
  dbgPromotionalFooters.DataSource.DataSet.Open;
  dbgPromotionalFooters.DataSource.Dataset.Locate('Id', OldFooter, []);
end;

procedure TPromotionalFooter.actMapOverridesExecute(Sender: TObject);
begin
  TMapFooterText.ShowOverrideMappingForm;
end;

procedure TPromotionalFooter.actOverrideUpdate(Sender: TObject);
begin
  // if Site or Single Site Master allow Overrides
  actOverride.Enabled := IsSite and
    (dmPromotionalFooter.qCanOverridePromotionalFooter.RecordCount > 0) and
    (dbgPromotionalFooters.DataSource.DataSet.FieldByName('Status').AsInteger = 0);
end;

procedure TPromotionalFooter.actMapOverridesUpdate(Sender: TObject);
begin
  // if Site or Single Site Master allow Mapping Overrides
  actMapOverrides.Enabled := IsSite and
    (dmPromotionalFooter.qAllOverrideSalesAreas.RecordCount > 0);
end;

procedure TPromotionalFooter.dbgPromotionalFootersTitleButtonClick(
  Sender: TObject; AFieldName: String);
var
  bkmark: TBookmark;
begin
  with THackedADOQuery(dmPromotionalFooter.qPromotionalFooter) do
  begin
    DisableControls;
    bkmark := GetBookmark;
    try
      if AFieldName = 'StatusLookup' then
        AFieldName := 'Status';

      if (AFieldName = IndexFieldNames) then
        IndexFieldNames := AFieldName + ' DESC'
      else if (AFieldName + ' DESC') = IndexFieldNames then
        IndexFieldNames := AFieldName
      else
        IndexFieldNames := AFieldName;
    finally
      GotoBookmark(bkmark);
      EnableControls;
    end;
  end;
end;

procedure TPromotionalFooter.dbgPromotionalFootersDrawTitleCell(
  Sender: TObject; Canvas: TCanvas; Field: TField; Rect: TRect;
  var DefaultDrawing: Boolean);
var
  txtRect: TRect;
  bmpRect: TRect;
  str: string;
  SortDown: Boolean;
  DrawGlyph: Boolean;
  IndexFieldName: String;
  GlyphIndex: Integer;
begin
  DefaultDrawing := False;
  txtRect := Rect;
  GlyphIndex := -1;

  with Canvas do
  begin
    Brush.Color := clBtnFace;
    FillRect(rect);

    DrawGlyph := False;
    IndexFieldName := THackedADOQuery(dmPromotionalFooter.qPromotionalFooter).IndexFieldNames;
    if Pos('Status', IndexFieldName) > 0 then
      IndexFieldName := StringReplace(IndexFieldName, 'Status', 'StatusLookup', [rfReplaceAll, rfIgnoreCase]);
    if (Pos(Field.FullName,IndexFieldName) > 0) then
    begin
      DrawGlyph := True;
      SortDown := Pos(' DESC',THackedADOQuery(dmPromotionalFooter.qPromotionalFooter).IndexFieldNames) > 0;
      //reverse the sense of the sort glyph is the 'Status' column was clicked
      if SortDown and (Pos('StatusLookup', IndexFieldName) > 0) then
        GlyphIndex := 1
      else if (not SortDown) and (Pos('StatusLookup', IndexFieldName) > 0) then
        GlyphIndex := 0
      else if SortDown then
        GlyphIndex := 0
      else
        GlyphIndex := 1;
    end;

    if DrawGlyph then
    begin
      bmpRect := Rect;
      bmpRect.Left := bmpRect.Right - ilSortGlyphs.Width;
      bmpRect.Top := bmpRect.Top + ((bmpRect.Bottom - bmpRect.Top - ilSortGlyphs.Height) div 2);

      txtRect.Right := bmpRect.Left;
    end;

    str := Field.DisplayName;
    txtRect.Left := txtRect.Left + 2;
    txtRect.Top := (txtRect.Bottom - txtRect.Top - TextHeight(str)) div 2;
    DrawText(canvas.Handle, PChar(str),
             length(str), txtRect,
             DT_SINGLELINE or DT_LEFT or DT_VCENTER or DT_END_ELLIPSIS);

    if DrawGlyph and (GlyphIndex >= 0) then
    begin
      ilSortGlyphs.Draw(Canvas,bmpRect.left,bmpRect.top,GlyphIndex);
    end;
  end;
end;


procedure TPromotionalFooter.ApplyFilterSettings(Sender: TObject);
begin
  if (chkbxFiltered.Checked) and (edtFilterText.Text <> '') then
    dmPromotionalFooter.SetMainPromotionalFooterListFilter(edtFilterText.Text, chkbxMidwordSearch.Checked)
  else
    dmPromotionalFooter.ClearMainPromotionalFooterListFilter;
end;

end.
