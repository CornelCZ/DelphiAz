unit uPCWasteRep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ActnList, StdCtrls, Buttons, DBCtrls, Grids,
  Wwdbigrd, Wwdbgrid, ExtCtrls, ComCtrls, ppCtrls, ppVar, ppPrnabl,
  ppClass, ppBands, ppCache, ppDB, ppDBPipe, ppComm, ppRelatv, ppProd,
  ppReport, ppStrtch, ppMemo, RXDice, Mask, wwdbedit, Wwdotdot, Wwdbcomb;

const SHOW_ALL = ' - SHOW ALL - ';
const NATURAL_ORDER = 'Div;Cat;SCat;Name;WasteDT DESC';

type
  TfPCWasteRep = class(TForm)
    PanelMain: TPanel;
    PanelBottom: TPanel;
    PanelFilter: TPanel;
    PanelGrid: TPanel;
    Panel1: TPanel;
    PanelGridBottom: TPanel;
    wwDBGridPCWaste: TwwDBGrid;
    LabelNote: TLabel;
    DBMemoNote: TDBMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ActionList: TActionList;
    ActDelete: TAction;
    ActReport: TAction;
    BitBtnClose: TBitBtn;
    ActCancel: TAction;
    adoqLoadTempstkPCWaste: TADOQuery;
    adotPCWaste: TADOTable;
    dsPCWaste: TDataSource;
    adotPCWasteSiteCode: TSmallintField;
    adotPCWasteHzID: TSmallintField;
    adotPCWasteEntityCode: TFloatField;
    adotPCWasteWasteDT: TDateTimeField;
    adotPCWasteBsDate: TDateTimeField;
    adotPCWasteUnit: TStringField;
    adotPCWasteWValue: TFloatField;
    adotPCWasteBaseUnits: TFloatField;
    adotPCWasteWasteBy: TStringField;
    adotPCWasteWasteFlag: TStringField;
    adotPCWasteLMDT: TDateTimeField;
    adotPCWasteLMBy: TStringField;
    adotPCWasteNote: TStringField;
    adotPCWasteName: TStringField;
    adotPCWasteDiv: TStringField;
    adotPCWasteCat: TStringField;
    adotPCWasteSCat: TStringField;
    adotPCWasteDeleteable: TBooleanField;
    adoqBuildTempstkPCWaste: TADOQuery;
    ActDateFilter: TAction;
    ppReportPCWaste: TppReport;
    ppDBPipelinePCWaste: TppDBPipeline;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppShape3: TppShape;
    pplTitle: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel12: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText12: TppDBText;
    ppSystemVariable3: TppSystemVariable;
    ppLine24: TppLine;
    ppLine1: TppLine;
    ppLine10: TppLine;
    ppLine2: TppLine;
    ppLine13: TppLine;
    ppLine14: TppLine;
    ppLine15: TppLine;
    ppLine17: TppLine;
    ppLabel2: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel13: TppLabel;
    ppLine9: TppLine;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppLine3: TppLine;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLine7: TppLine;
    ppLine8: TppLine;
    ppDBText1: TppDBText;
    ppLine16: TppLine;
    ppDBText3: TppDBText;
    ppLine12: TppLine;
    ppDBText2: TppDBText;
    pplToLabel: TppLabel;
    pplFromLabel: TppLabel;
    pplFromField: TppLabel;
    pplToField: TppLabel;
    ppLabelFilterStatus: TppLabel;
    ppMemoFilters: TppMemo;
    PanelLegend: TPanel;
    Label1: TLabel;
    PanelTop: TPanel;
    GroupBoxGridFilters: TGroupBox;
    LabelWasteBy: TLabel;
    LabelNameFilter: TLabel;
    Bevel1: TBevel;
    LabelSubCatFilter: TLabel;
    LabelCatFilter: TLabel;
    LabelDivFilter: TLabel;
    CheckBoxStockedItems: TCheckBox;
    ComboBoxWasteByFilter: TComboBox;
    ComboBoxNameFilter: TComboBox;
    ComboboxSubCategoryFilter: TComboBox;
    ComboboxCategoryFilter: TComboBox;
    ComboboxDivisionFilter: TComboBox;
    PanelFilterByDate: TPanel;
    LabelFrom: TLabel;
    LabelTo: TLabel;
    DateTimePickerFrom: TDateTimePicker;
    DateTimePickerTo: TDateTimePicker;
    CheckBoxFilterByDate: TCheckBox;
    Bevel2: TBevel;
    HZLabel: TLabel;
    ComboBoxHZFilter: TComboBox;
    ppLabel3: TppLabel;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppLine18: TppLine;
    ppLine19: TppLine;
    ppLine20: TppLine;
    ppLine4: TppLine;
    procedure wwDBGridPCWasteCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure FormShow(Sender: TObject);
    procedure ActDateFilterExecute(Sender: TObject);
    procedure DateTimePickerCloseUp(Sender: TObject);
    procedure ActDeleteUpdate(Sender: TObject);
    procedure ActReportUpdate(Sender: TObject);
    procedure ComboboxDivisionFilterChange(Sender: TObject);
    procedure ComboboxCategoryFilterChange(Sender: TObject);
    procedure ComboboxSubCategoryFilterChange(Sender: TObject);
    procedure ComboBoxNameFilterChange(Sender: TObject);
    procedure ComboBoxWasteByFilterChange(Sender: TObject);
    procedure ActDeleteExecute(Sender: TObject);
    procedure ActReportExecute(Sender: TObject);
    procedure ppReportPCWastePreviewFormCreate(Sender: TObject);
    procedure CheckBoxStockedItemsClick(Sender: TObject);
    procedure wwDBGridPCWasteTitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure wwDBGridPCWasteCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBoxHZFilterChange(Sender: TObject);
    procedure adotPCWasteWValueGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure ppDBText4GetText(Sender: TObject; var Text: String);
    procedure ppDetailBand1BeforePrint(Sender: TObject);
  private
    { Private declarations }
    FLowerBound: TDatetime;
    FUpperBound: TDatetime;
    FShowHZs: boolean;
    FHZs: TStringList;

    procedure SetHZVisibility;
    procedure SetupDateFilter;
    procedure BuildTempTable;
    procedure BuildCategoryList;
    procedure BuildDivisionList;
    procedure BuildSubCategoryList;
    procedure BuildHZList;
    procedure FilterPCWasteRecords;
    procedure BuildNameList;
    procedure BuildWasteByList;
    procedure RebuildAfterDateFilter;
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
  public
    { Public declarations }
    property ShowHZs: boolean read FShowHZs write FShowHZs;
  end;

var
  fPCWasteRep: TfPCWasteRep;

implementation

uses uADO, uGlobals, uData1, uLog;

{$R *.dfm}

procedure TfPCWasteRep.wwDBGridPCWasteCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin

  if (adotPCWaste.FieldByName('WasteFlag').asstring = 'P') then
  begin
    if (Field.FieldName = 'Name') then
    begin
      if gdSelected in State then
      begin
        aFont.Style := [fsBold];
        aFont.Color := clYellow;
        aBrush.Color := clBlue;
      end
      else
      begin
        aFont.Style := [fsBold];
        aFont.Color := clYellow;
        aBrush.Color := clBlack;
      end;
    end
    else
    begin
      if gdSelected in State then
      begin
        ABrush.Color := clHighlight;
        AFont.Color := clHighlightText;
      end
      else begin
        AFont.Color := clWindowText;
        if adotPCWaste.FieldByName('deleteable').Asboolean then
          ABrush.Color := clMoneyGreen
        else
          ABrush.Color := clWindow;
      end;
    end;
  end
  else
  begin
    if gdSelected in State then
    begin
      ABrush.Color := clHighlight;
      AFont.Color := clHighlightText;
    end
    else begin
      AFont.Color := clWindowText;
      if adotPCWaste.FieldByName('deleteable').Asboolean then
        ABrush.Color := clMoneyGreen
      else
        ABrush.Color := clWindow;
    end;
  end;
end;

procedure TfPCWasteRep.FormShow(Sender: TObject);
begin
  with dmado.adoqRun do
  try
    SQL.Clear;
    SQL.Add('SELECT SUM(CASE dozform  WHEN ''Y'' THEN 1 ELSE 0 END) AS dozs,');
    SQL.Add('       SUM(CASE gallform WHEN ''Y'' THEN 1 ELSE 0 END) AS galls');
    SQL.Add('FROM Threads');
    SQL.Add('WHERE Active = ''Y''');
    Open;

    if not (BOF and EOF) then
    begin
      data1.curGallForm := FieldByName('galls').AsInteger > 0;
      data1.curdozForm := FieldByName('dozs').AsInteger > 0;
    end;
  finally
    Close;
  end;

  SetHZVisibility;

  SetupDateFilter;

  BuildTempTable;

  adotPCWaste.Active := True;

  FilterPCWasteRecords;
end;

procedure TfPCWasteRep.SetupDateFilter;
begin
  FUpperBound := Now;
  FLowerBound := FUpperBound - 30;
  with dmADO.adoqRun do
  try
    SQL.Clear;
    SQL.Add('SELECT dbo.fn_ConvertToBusinessDate(GETDATE()) as UpperBound, MIN(SUB.LastAccepted) as LowerBound');
    SQL.Add('FROM (SELECT t.Tid, MAX(ISNULL(AccDate+CAST(AccTime AS DateTime),DATEADD(d,-30,GETDATE()))) AS LastAccepted');
    SQL.Add('FROM threads t');
    SQL.Add('JOIN stocks s');
    SQL.Add('ON s.Tid = t.Tid');
    SQL.Add('WHERE t.Active = ''Y''');
    SQL.Add('GROUP BY t.Tid) SUB');
    Open;

    if not (EOF and BOF) then
    begin
      FLowerBound := FieldByName('LowerBound').AsDatetime;
      FUpperBound := FieldByName('UpperBound').AsDatetime;
    end;
  finally
    Close;
  end;
  DateTimePickerFrom.DateTime := FLowerBound;
  DateTimePickerTo.DateTime := FUpperBound;
end;

procedure TfPCWasteRep.BuildTempTable;
begin
  adoqBuildTempstkPCWaste.ExecSQL;
  adoqLoadTempstkPCWaste.Parameters.ParamByName('Ubnd').Value := FormatDateTime('yyyy-mm-dd',FUpperBound);
  adoqLoadTempstkPCWaste.Parameters.ParamByName('Lbnd').Value := FormatDateTime('yyyy-mm-dd',FLowerBound);
  adoqLoadTempstkPCWaste.ExecSQL;
  BuildHZList;
  BuildDivisionList;
  BuildNameList;
  BuildWasteByList;
end;


procedure TfPCWasteRep.ActDateFilterExecute(Sender: TObject);
var
  Index: Integer;
begin
  for Index := 0 to PanelFilterByDate.ControlCount -1 do
  begin
    PanelFilterByDate.Controls[Index].Enabled := (Sender as TAction).Checked;
  end;


  if not (Sender as TAction).Checked then
    SetupDateFilter;
  RebuildAfterDateFilter;
end;

procedure TfPCWasteRep.DateTimePickerCloseUp(Sender: TObject);
begin
  FLowerBound := DateTimePickerFrom.DateTime;
  FUpperBound := DateTimePickerTo.DateTime;

  RebuildAfterDateFilter;
end;

procedure TfPCWasteRep.ActDeleteUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := not (adotPCWaste.Bof and adotPCWaste.Eof)
    and (adotPCWaste.FieldByName('deleteable').AsBoolean);
end;

procedure TfPCWasteRep.ActReportUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := not (adotPCWaste.Bof and adotPCWaste.Eof);
end;

procedure TfPCWasteRep.BuildDivisionList;
begin
  with dmADO.adoqRun do
  try
    Close;
    SQL.Clear;
    SQL.Add('select distinct div as divname from #stkPCWaste');
    SQL.Add('union select ('' - SHOW ALL - '') as divname');
    SQL.Add('order by div asc');
    Open;
    First;

    ComboboxDivisionFilter.Items.Clear;
    while not Eof do
    begin
      ComboboxDivisionFilter.Items.Add(FieldByName('divname').asstring);
      Next;
    end;
    Close;

    ComboboxDivisionFilter.Refresh;
    ComboboxDivisionFilter.ItemIndex := 0;
  finally
    Close;
  end;

  BuildCategoryList;
  BuildSubCategoryList;
end;

procedure TfPCWasteRep.BuildCategoryList;
var
  DivText: String;
  FilterText: String;
begin
  FilterText := '';
  DivText := ComboBoxDivisionFilter.Text;

  with dmADO.adoqRun do
  try
    Close;
    SQL.Clear;
    SQL.Add('select distinct cat from #stkPCWaste');

    if DivText <>  SHOW_ALL then
    begin
      FilterText := 'div = ' + QuotedStr(DivText);
    end;

    if FilterText <> '' then
      SQL.Add('where ' + FilterText);
    SQL.Add('union select ('' - SHOW ALL - '') as cat');
    SQL.Add('order by cat asc');
    Open;
    First;

    ComboboxCategoryFilter.Items.Clear;
    while not Eof do
    begin
      ComboboxCategoryFilter.Items.Add(FieldByName('cat').AsString);
      Next;
    end;
    Close;

    ComboboxCategoryFilter.Refresh;
    ComboboxCategoryFilter.ItemIndex := 0;
  finally
    Close;
  end;

  BuildSubCategoryList;
end;

procedure TfPCWasteRep.BuildSubCategoryList;
var
  DivText: String;
  Cattext: String;
  FilterText: String;
begin
  FilterText := '';
  DivText := ComboboxDivisionFilter.Text;
  CatText := ComboboxCategoryFilter.Text;

  with dmADO.adoqRun do
  try
    Close;
    SQL.Clear;
    SQL.Add('select distinct scat from #stkPCWaste');

    if (DivText <>  SHOW_ALL)
    or (CatText <>  SHOW_ALL) then
    begin
      if DivText <>  SHOW_ALL then
        FilterText := 'div = ' + QuotedStr(DivText);

      if CatText <>  SHOW_ALL then
      begin
        if DivText <>  SHOW_ALL then
          FilterText := FilterText + ' and ';
        FilterText := FilterText + 'cat = ' + QuotedStr(CatText);
      end;
    end;

    if FilterText <> '' then
      SQL.Add('where ' + FilterText);
    SQL.Add('union select ('' - SHOW ALL - '') as scat');
    SQL.Add('order by scat asc');
    Open;
    First;

    ComboboxSubCategoryFilter.Items.Clear;
    while not Eof do
    begin
      ComboboxSubCategoryFilter.Items.Add(FieldByName('scat').AsString);
      Next;
    end;
    Close;

    ComboboxSubCategoryFilter.Refresh;
    ComboboxSubCategoryFilter.ItemIndex := 0;
  finally
    Close;
  end;
  BuildNameList;
end;

procedure TfPCWasteRep.ComboboxDivisionFilterChange(Sender: TObject);
begin
  BuildCategoryList;
  BuildSubCategoryList;
  FilterPCWasteRecords;
end;

procedure TfPCWasteRep.ComboboxCategoryFilterChange(Sender: TObject);
begin
  BuildSubCategoryList;
  FilterPCWasteRecords;
end;

procedure TfPCWasteRep.BuildNameList;
var
  NameText: String;
  DivText: String;
  CatText: String;
  SCatText: String;
  FilterText: String;
begin
  NameText := ComboBoxNameFilter.Text;
  DivText := ComboboxDivisionFilter.Text;
  CatText := ComboboxCategoryFilter.Text;
  SCatText := ComboboxSubCategoryFilter.Text;

  with dmADO.adoqRun do
  try
    Close;
    SQL.Clear;
    SQL.Add('select distinct name from #stkPCWaste');

    if (DivText <>  SHOW_ALL)
    or (CatText <>  SHOW_ALL)
    or (Scattext <> SHOW_ALL) then
    begin
      if DivText <>  SHOW_ALL then
        FilterText := 'div = ' + QuotedStr(DivText);

      if CatText <>  SHOW_ALL then
      begin
        if FilterText <>  '' then
          FilterText := FilterText + ' and ';
        FilterText := FilterText + 'cat = ' + QuotedStr(CatText);
      end;

      if SCatText <>  SHOW_ALL then
      begin
        if FilterText <>  '' then
          FilterText := FilterText + ' and ';
        FilterText := FilterText + 'cat = ' + QuotedStr(CatText);
      end;
    end;

    if FilterText <> '' then
      SQL.Add('where ' + FilterText);
    SQL.Add('union select ('' - SHOW ALL - '') as cat');
    SQL.Add('order by name asc');
    Open;
    First;

    ComboboxNameFilter.Items.Clear;
    while not Eof do
    begin
      ComboboxNameFilter.Items.Add(FieldByName('name').AsString);
      Next;
    end;
    Close;

    ComboboxNameFilter.Refresh;
    ComboboxNameFilter.ItemIndex := 0;
  finally
    Close;
  end;
end;

procedure TfPCWasteRep.BuildWasteByList;
var
  WasteByText: String;
begin
  WasteByText := ComboBoxWasteByFilter.Text;

  with dmADO.adoqRun do
  try
    Close;
    SQL.Clear;
    SQL.Add('select distinct WasteBy from #stkPCWaste');
    SQL.Add('union select ('' - SHOW ALL - '') as WasteBY');
    SQL.Add('order by WasteBY asc');
    Open;
    First;

    ComboboxWasteByFilter.Items.Clear;
    while not Eof do
    begin
      ComboboxWasteByFilter.Items.Add(FieldByName('WasteBy').AsString);
      Next;
    end;
    Close;

    ComboboxWasteByFilter.Refresh;
    ComboboxWasteByFilter.ItemIndex := 0;
  finally
    Close;
  end;
end;

procedure TfPCWasteRep.ComboboxSubCategoryFilterChange(Sender: TObject);
begin
  FilterPCWasteRecords;
end;

procedure TfPCWasteRep.ComboBoxNameFilterChange(Sender: TObject);
begin
  FilterPCWasteRecords;
end;

procedure TfPCWasteRep.ComboBoxWasteByFilterChange(Sender: TObject);
begin
  FilterPCWasteRecords;
end;

procedure TfPCWasteRep.FilterPCWasteRecords;
var
  DivText: String;
  CatText: String;
  SubCatText: String;
  NameText: String;
  WasteByText: String;
  FilterText: String;
  Index: Integer;
  Filter: String;
  GridFilters: TStringList;
  HzIDString: String;
begin
  GridFilters := TStringList.Create;
  try
    FilterText := '';
    DivText := ComboBoxDivisionFilter.Text;
    CatText := ComboBoxCategoryFilter.Text;
    SubCatText := ComboBoxSubCategoryFilter.Text;
    NameText := ComboBoxNameFilter.Text;
    WasteByText := ComboBoxWasteByFilter.Text;

    if ComboBoxHZFilter.Text <> SHOW_ALL then
    begin
      HzIDString := FHZs.Values[ComboBoxHZFilter.Text];
      GridFilters.Add('HzID = ' + HzIDString);
    end;

    if DivText <>  SHOW_ALL then
      GridFilters.Add('div = ' + QuotedStr(DivText));

    if CatText <>  SHOW_ALL then
      GridFilters.Add('cat = ' + QuotedStr(CatText));

    if SubCatText <>  SHOW_ALL then
      GridFilters.Add('scat = ' + QuotedStr(SubCatText));

    if NameText <>  SHOW_ALL then
      GridFilters.Add('name = ' + QuotedStr(NameText));

    if WasteByText <>  SHOW_ALL then
      GridFilters.Add('wasteby = ' + QuotedStr(WasteByText));

    if not CheckBoxStockedItems.Checked then
      GridFilters.Add('Stocked = 1');

    Filter := '';
    if GridFilters.Count > 0 then
      Filter := GridFilters[0];
    for Index := 1 to GridFilters.Count - 1 do
    begin
      Filter := Filter + ' and ' + GridFilters[Index];
    end;
    if Filter <> '' then
      adotPCWaste.Filtered := True
    else
      adotPCWaste.Filtered := False;

    adotPCWaste.Filter := Filter;
  finally
    GridFilters.Free;
  end;
end;

procedure TfPCWasteRep.RebuildAfterDateFilter;
var
  DivText: String;
  CatText: String;
  SCatText: String;
  NameText: String;
  WasteByText: String;
  HzText: String;
begin
  //Note the users filter conditions
  DivText := ComboBoxDivisionFilter.Text;
  CatText := ComboBoxCategoryFilter.Text;
  SCatText := ComboBoxSubCategoryFilter.Text;
  NameText := ComboBoxNameFilter.Text;
  WasteByText := ComboBoxWasteByFilter.Text;
  HzText := ComboBoxHZFilter.Text;

  BuildTempTable;

  //Restore then if they still exist in the date range
  if (DivText <>  SHOW_ALL)
  and (ComboBoxDivisionFilter.Items.IndexOf(DivText) <> -1) then
    ComboBoxDivisionFilter.Text := DivText;

  if (CatText <>  SHOW_ALL)
  and (ComboboxCategoryFilter.Items.IndexOf(CatText) <> -1) then
    ComboBoxCategoryFilter.Text := CatText;

  if (ScatText <>  SHOW_ALL)
  and (ComboboxSubCategoryFilter.Items.IndexOf(ScatText) <> -1) then
    ComboboxSubCategoryFilter.Text := ScatText;

  if (NameText <>  SHOW_ALL)
  and (ComboBoxNameFilter.Items.IndexOf(NameText) <> -1) then
    ComboBoxNameFilter.Text := NameText;

  if (WasteByText <>  SHOW_ALL)
  and (ComboBoxWasteByFilter.Items.IndexOf(WasteByText) <> -1) then
    ComboBoxWasteByFilter.Text := WasteByText;

  if (HzText <>  SHOW_ALL)
  and (ComboBoxHZFilter.Items.IndexOf(HzText) <> -1) then
    ComboBoxHZFilter.Text := HzText;

  adotPCWaste.DisableControls;
  try
    adotPCWaste.Requery;
  finally
    adotPCWaste.EnableControls;
  end;

  FilterPCWasteRecords;
end;

procedure TfPCWasteRep.ActDeleteExecute(Sender: TObject);
var
  HzID: Integer;
  WasteDt, EntityCode: String;
  Wasteage: double;
  Qty, BaseUnits: double;
begin
  if MessageDlg('Do you wish to delete this Waste entry?',
    mtConfirmation,
    [mbYes,mbNo],
    0) = mrYes then
  begin
    dmADO.BeginTransaction;
    try
      try
        with dmADO.adoqRun do
        try
          HzID := adotPCWaste.FieldByName('HzID').ASInteger;
          WasteDt := FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz',adotPCWaste.FieldByName('WasteDt').AsDatetime);
          EntityCode := adotPCWaste.FieldByName('EntityCode').AsString;
          Qty := adotPCWaste.FieldByName('WValue').AsFloat;
          BaseUnits := adotPCWaste.FieldByName('BaseUnits').AsFloat;
          Wasteage := -1 * Qty * BaseUnits;

          if adotPCWaste.FieldByName('WasteFlag').Asstring = 'P' then
          begin
            // if the item is a Prep.Item make a temp table that contains the children Wastage
            // records so as to delete those records and to negate them in stkTheoRed...

            SQL.Clear;
            SQL.Add('IF object_id(''tempdb..#PCwasteDel'') IS NOT NULL DROP TABLE #PCwasteDel');
            SQL.Add('');
            SQL.Add('SELECT * INTO #PCwasteDel');
            SQL.Add('FROM stkPCWaste');
            SQL.Add(Format('WHERE SiteCode = %d',[uGlobals.SiteCode]));
            SQL.Add(Format('AND HzID = %d',[HzID]));
            SQL.Add(Format('AND Parent = %s',[EntityCode]));
            SQL.Add(Format('AND WasteDt = ''%s''',[WasteDt]));
            SQL.Add('AND WasteFlag = ''C''');
            ExecSQL;

            // delete the children from stkPCWaste...
            SQL.Clear;
            SQL.Add('DELETE stkPCWaste');
            SQL.Add('FROM stkPCWaste a, #PCWasteDel d');
            SQL.Add('WHERE a.SiteCode = d.SiteCode AND a.HZID = d.HZID');
            SQL.Add('AND a.EntityCode = d.EntityCode AND a.WasteDt = d.WasteDt');
            SQL.Add('AND a.Unit = d.Unit AND a.Parent = d.Parent');
            SQL.Add('');

            // delete the PrepItem...
            SQL.Add('DELETE stkPCWaste');
            SQL.Add(Format('WHERE SiteCode = %d',[uGlobals.SiteCode]));
            SQL.Add(Format('AND HzID = %d',[HzID]));
            SQL.Add(Format('AND EntityCode = %s',[EntityCode]));
            SQL.Add(Format('AND WasteDt = ''%s''',[WasteDt]));
            SQL.Add(Format('AND Unit = ''%s''',[adotPCWaste.FieldByName('Unit').AsString]));
            SQL.Add('');

            // negate the Wastage of the children; the PrepItem is not in stkTheoRed...
            // first mark those records where there are negated wastage records instkTheoRed
            // to protect against KVs
            SQL.Add('UPDATE #PCWasteDel SET WasteFlag = ''E''');
            SQL.Add('FROM');
            SQL.Add('  (SELECT EntityCode, DT, Parent FROM stkTheoRed');
            SQL.Add('       WHERE TermID = 0 AND FromTrx = -2 AND Source = ''C'' AND WasteFlag = 1');
            SQL.Add(Format('AND DT=%s AND Parent = %s', [QuotedStr(WasteDt),EntityCode]));  // EntityCode is the PrepItem parent
            SQL.Add('  ) sq ');
            SQL.Add('WHERE #PCWasteDel.EntityCode = sq.EntityCode');

            ExecSQL;

            // then insert but not the marked records...

            SQL.Clear;
            SQL.Add('INSERT stkTheoRed ([TermID], [DT], [FromTrx], [EntityCode], [RedQty],');
            SQL.Add('                   [WasteFlag], [ProcFlag], [BsDate], [LMDT], [Parent], [Source])');
            SQL.Add('SELECT 0, a.wasteDT, -2,');
            SQL.Add('       a.EntityCode, SUM(-1 * a.[WValue] * a.[BaseUnits]) as RedQty, 1, 0,');
            SQL.Add('  dbo.fn_ConvertToBusinessDate(a.[WasteDT]), GETDATE() as LMDT, Parent, ''C''');
            SQL.Add('FROM #PCWasteDel a');
            SQL.Add('Where a.WasteFlag = ''C''');
            SQL.Add('GROUP BY a.EntityCode,a.WasteDT, Parent');

            ExecSQL;

            if data1.ssDebug then
              with dmADO.adoqRun2 do
              begin
                Close;
                sql.Clear;
                sql.Add('IF EXISTS (SELECT * FROM sysobjects WHERE id=OBJECT_ID(''stkZZ_PCwasteDel'')) DROP TABLE [stkZZ_PCwasteDel]');
                sql.Add('SELECT * INTO dbo.[stkZZ_PCwasteDel] FROM [#PCwasteDel]');
                execSQL;
              end;
          end
          else
          begin
            SQL.Clear;
            SQL.Add('DECLARE @now datetime');
            SQL.Add('SET @now = GETDATE()');
            SQL.Add('');

            SQL.Add('DELETE stkPCWaste');
            SQL.Add(Format('WHERE SiteCode = %d',[uGlobals.SiteCode]));
            SQL.Add(Format('AND HzID = %d',[HzID]));
            SQL.Add(Format('AND EntityCode = %s',[EntityCode]));
            SQL.Add(Format('AND WasteDt = ''%s''',[WasteDt]));
            SQL.Add(Format('AND Unit = ''%s''',[adotPCWaste.FieldByName('Unit').AsString]));
            SQL.Add('');


            SQL.Add('IF EXISTS(SELECT * FROM stkTheoRed');
            SQL.Add(Format('WHERE TermID=0 AND DT=%s AND FromTrx = -1 AND EntityCode = %s)',[QuotedStr(WasteDt),EntityCode]));
            SQL.Add(' UPDATE stkTheoRed');
            SQL.Add(  Format('SET RedQty = RedQty + %s',[FloattoStr(Wasteage)]));
            SQL.Add(  Format('WHERE TermID=0 AND DT=%s AND FromTrx = -1 AND EntityCode = %s',[QuotedStr(WasteDt),EntityCode]));
            SQL.Add('ELSE');
            SQL.Add(' INSERT stkTheoRed ([TermID], [DT], [FromTrx], [EntityCode], [RedQty],');
            SQL.Add('                    [WasteFlag], [ProcFlag], [BsDate], [LMDT], [Parent], [Source])');
            SQL.Add(  Format('VALUES (0,%s,-1,%s,',[QuotedStr(WasteDt),EntityCode]));
            SQL.Add(  Format('%s,1,0,dbo.fn_ConvertToBusinessDate(cast(%s as datetime)),@now,NULL,''M'')',[FloattoStr(Wasteage),QuotedStr(WasteDt)]));

            ExecSQL;
          end;

          //Ensure the waste records appear in any subsequent line check
          SQL.Clear;
          SQL.Add('exec stkSP_ECLRed');

          ExecSQL;  

          adotPCWaste.Delete;
        finally
          Close;
        end;
        dmADO.CommitTransaction;
      except
        on E:Exception do
            log.event('Error deleting stkPCWaste record - error: ' + E.Message);
      end;
    finally
      if dmADO.InTransaction then
      begin
        dmADO.RollbackTransaction;
        log.event('Error deleting stkPCWaste record - transaction rolled back');
      end
    end;
  end;
end;

procedure TfPCWasteRep.ActReportExecute(Sender: TObject);
var
  DivText: String;
  CatText: String;
  SCatText: String;
  NameText: String;
  WasteByText: String;
  FilterText: String;
  HzText: String;
begin
  //Note the users filter conditions
  DivText := ComboBoxDivisionFilter.Text;
  CatText := ComboBoxCategoryFilter.Text;
  SCatText := ComboBoxSubCategoryFilter.Text;
  NameText := ComboBoxNameFilter.Text;
  WasteByText := ComboBoxWasteByFilter.Text;
  HzText := ComboBoxHZFilter.Text;
  FilterText := '';

  if (DivText <>  SHOW_ALL) then
    FilterText := FilterText + 'Division = ' + QuotedStr(DivText) + ', ';
  if (CatText <>  SHOW_ALL) then
    FilterText := FilterText + 'Category = ' + QuotedStr(CatText) + ', ';
  if (SCatText <>  SHOW_ALL) then
    FilterText := FilterText + 'Sub-Category = ' + QuotedStr(SCatText) + ', ';
  if (NameText <>  SHOW_ALL) then
    FilterText := FilterText + 'Name = ' + QuotedStr(NameText) + ', ';
  if (WasteByText <>  SHOW_ALL) then
    FilterText := FilterText + 'Entered By = ' + QuotedStr(WasteByText) + ', ';
  if (HzText <> SHOW_ALL) then
    FilterText := FilterText + 'Holding Zone = ' + QuotedStr(HzText) + ', ';
  if FilterText <> '' then
    FilterText := Copy(FilterText,1,Length(FilterText) - 2)
  else
    FilterText := 'No filters applied.';
  ppMemoFilters.Text := FilterText;

  pplFromField.Caption := DateTimeToStr(Trunc(FLowerBound));
  pplToField.Caption := DateTimeToStr(Trunc(FUpperBound));

  ppReportPCWaste.ShowPrintDialog := True;
  ppReportPCWaste.DeviceType := 'Screen';
  ppReportPCWaste.PrinterSetup.PaperName := data1.repPaperName;
  ppReportPCWaste.Print;
end;

procedure TfPCWasteRep.ppReportPCWastePreviewFormCreate(Sender: TObject);
begin
  dmADO.ALLRepsPreviewFormCreate(Sender, data1.repPaperName);
end;

procedure TfPCWasteRep.CheckBoxStockedItemsClick(Sender: TObject);
begin
  FilterPCWasteRecords;
end;

procedure TfPCWasteRep.wwDBGridPCWasteTitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  with adotPCWaste do
  begin
    DisableControls;
    try
      //sorted descending - go back to 'natural order'
      if AFieldName + ' DESC' = IndexFieldNames then
        IndexFieldNames := 'Div;Cat;Scat;Name;WasteDT DESC'
      //ordered ascending - go to ordered descending
      else if AFieldName = IndexFieldNames then
        IndexFieldNames := AFieldName + ' DESC'
      //ordered by some other field(s) - order by this one ascending
      else if AFieldName <> IndexFieldNames then
        IndexFieldNames := AFieldName;
    finally
      EnableControls;
    end;
  end;
end;

procedure TfPCWasteRep.wwDBGridPCWasteCalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  if adotPCWaste.IndexFieldNames = NATURAL_ORDER then
  begin
    ABrush.Color := wwDBGridPCWaste.TitleColor;
    AFont.Color := wwDBGridPCWaste.Font.Color;
  end
  else if adotPCWaste.IndexFieldNames = AFieldName + ' DESC' then
  begin
    ABrush.Color := clRed;
    AFont.Color := clHighLightText;
  end
  else if adotPCWaste.IndexFieldNames = AFieldName then
  begin
    ABrush.Color := clYellow;
    AFont.Color := clWindowText;
  end;
end;

procedure TfPCWasteRep.WMSysCommand(var Msg: TWMSysCommand);
begin
  if (Msg.CmdType = SC_MINIMIZE) then
  begin
    Application.Minimize;
  end
  else
  begin
    inherited;
  end;
end;

procedure TfPCWasteRep.SetHZVisibility;
begin
  if not ShowHzs then
  begin
    Bevel2.Visible := False;
    HZLabel.Visible := False;
    ComboBoxHZFilter.Visible := False;
    PanelTop.ClientHeight := PanelTop.Height - 30;
  end;
end;

procedure TfPCWasteRep.BuildHZList;
begin
  with dmADO.adoqRun do
  try
    Close;
    SQL.Clear;
    SQL.Add('select distinct s.HzID as HzID, s.HZname as HzName from #stkPCWaste t');
    SQL.Add('join stkHZs s on t.HzID  = s.HzID');
    SQL.Add('union select -1 as HzID, ('' - SHOW ALL - '') as HzName');
    SQL.Add('order by HzName asc');
    Open;
    First;

    FHZs.Clear;
    ComboBoxHZFilter.Items.Clear;
    while not Eof do
    begin
      FHZs.Add(FieldByName('HzName').asstring + '=' + FieldByName('HzID').asstring);
      ComboBoxHZFilter.Items.Add(FieldByName('HzName').asstring);
      Next;
    end;
    Close;

    ComboBoxHZFilter.Refresh;
    ComboBoxHZFilter.ItemIndex := 0;
  finally
    Close;
  end;
end;

procedure TfPCWasteRep.FormCreate(Sender: TObject);
begin
  FHZs := TStringList.Create;
end;

procedure TfPCWasteRep.FormDestroy(Sender: TObject);
begin
  FHZs.Free;
end;

procedure TfPCWasteRep.ComboBoxHZFilterChange(Sender: TObject);
begin
  FilterPCWasteRecords;
end;

procedure TfPCWasteRep.adotPCWasteWValueGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if sender.asstring = '' then
  begin
    Text := '';
    exit;
  end;

  Text := data1.dozGallFloatToStr(adotPCWasteUnit.Value, sender.Asfloat);
end;

procedure TfPCWasteRep.ppDBText4GetText(Sender: TObject; var Text: String);
begin
  Text := data1.fmtRepQtyText(ppDBText5.Text,Text);
end;

procedure TfPCWasteRep.ppDetailBand1BeforePrint(Sender: TObject);
begin
  ppLabel3.Visible := (adotPCWaste.FieldByName('WasteFlag').asstring = 'P');
end;

end.
