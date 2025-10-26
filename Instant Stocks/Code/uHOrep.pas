unit uHOrep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Wwdatsrc, ADODB, StdCtrls, Buttons, Grids, Wwdbigrd,
  Wwdbgrid, ExtCtrls;

type
  TfHOrep = class(TForm)
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    wwDBGrid1: TwwDBGrid;
    wwDBGrid2: TwwDBGrid;
    wwDBGrid3: TwwDBGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    adoqDivs: TADOQuery;
    dsDivs: TwwDataSource;
    adoqThreads: TADOQuery;
    dsThreads: TwwDataSource;
    adoqThStock: TADOQuery;
    dsThStocks: TwwDataSource;
    dsArea: TwwDataSource;
    adoqArea: TADOQuery;
    adoqSite: TADOQuery;
    dsSite: TwwDataSource;
    wwDBGrid4: TwwDBGrid;
    wwDBGrid5: TwwDBGrid;
    Label5: TLabel;
    Label6: TLabel;
    BitBtn3: TBitBtn;
    Bevel1: TBevel;
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure adoqThStockAfterScroll(DataSet: TDataSet);
    procedure adoqThreadsAfterScroll(DataSet: TDataSet);
    procedure adoqDivsAfterScroll(DataSet: TDataSet);
    procedure adoqSiteAfterScroll(DataSet: TDataSet);
    procedure wwDBGrid3CalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure wwDBGrid3TitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure WMSysCommand(var Msg: TWMSysCommand);
    message WM_SYSCOMMAND;
    procedure BitBtn3Click(Sender: TObject);
    procedure wwDBGrid2CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
  private
    yellField, RedField : string;
  public
    { Public declarations }
  end;

var
  fHOrep: TfHOrep;

implementation

uses udata1, uADO, uDataProc, uReps2, uReps1, uLCRep, ulog;

{$R *.dfm}

{Used to minimise the whole app if the current form is minimised}
procedure TfHOrep.WMSysCommand;
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


procedure TfHOrep.FormShow(Sender: TObject);
var
  s1 : string;
begin
  if data1.UKUSmode = 'US' then
    s1 := '---->>'
  else
    s1 := '--------->>';

  self.Caption := 'Head Office ' + data1.SSbig + ' Reports';
  label3.Caption := '5. Select 1 or more Accepted ' + data1.SSplural;
  bitbtn2.Caption := 'View ' + data1.SSbig + ' Reports...';
  label2.Caption := '- Pick 1 ' + data1.SSbig + ' from the grid ' + s1 + #13 +
    '  to print Single ' + data1.SSbig + ' Reports' + #13 +
    '- Pick 2 or more ' + data1.SSplural + #13 +
    '  to print Multi-' + data1.SSbig + ' Reports';
  label10.Caption := '4. Choose ' + data1.SSbig + ' Thread';

  adoqArea.open;
  adoqSite.Open;

  adoqDivs.open;
  adoqThreads.Open;

  with adoqThStock do
  begin
    sql.Clear;
    sql.Add('select [sitecode], [Tid], [StockCode], [SDate], [STime], [EDate], [ETime], sdt, edt,');
    sql.Add('	[AccDate], [AccTime], [StkKind], [division], [type], [byHZ],');
    sql.Add(' (CAST(((FLOOR(CAST(([edate] - [sdate] + 1) AS int))) / 7) AS VARCHAR) + ''/'' + ');
    sql.Add('  CAST(((FLOOR(CAST(([edate] - [sdate] + 1) AS int))) % 7) AS VARCHAR)) as period,pureAZ, byLocation');

    sql.Add('from Stocks');
    sql.Add('where Tid = :tid');
    sql.Add('and sitecode = ' + adoqSite.FieldByName('sitecode').asstring);
    sql.Add('and stockcode >= 2 and PureAZ = 1');
    sql.Add('order by edt DESC');
    open;
  end;
  yellField := '';
  redField := '';
end;

procedure TfHOrep.BitBtn2Click(Sender: TObject);
var
  i: integer;
begin
  log.event('In fHOrep.BitBtn2Clicked');
  data1.repSite := adoqThStock.FieldByName('SiteCode').AsInteger;

  data1.isDeactivatedThread := (adoqThreads.FieldByName('Active').Value = 'N');

  if wwdbgrid3.SelectedList.Count > 1 then
  begin
    with wwdbgrid3,wwdbgrid3.datasource.dataset do
    begin
      DisableControls; {Disable controls to improve performance}

      with data1, data1.adoqRun do
      begin
        close;
        sql.Clear;
        sql.Add('select * from threads where tid = ' + adoqThStock.FieldByName('tid').AsString);
        open;

        curTidName := FieldByName('tname').asstring;
        curDozForm := (FieldByName('dozform').asstring = 'Y');   // 17701
        curIsGP := (FieldByName('isGP').asstring = 'Y');
        curCPS := (FieldByName('doCPS').asstring = 'Y');
        curGallForm := (FieldByName('gallform').asstring = 'Y');

        curByLocation := (FieldByName('byHZ').asboolean) and data1.siteUsesLocations; // only one of ...
        curByHz := (FieldByName('byHZ').asboolean) and data1.siteUsesHZs;            // these 2 can be TRUE

        close;
      end;

      data1.sitetab.close;
      data1.sitetab.Parameters.ParamByName('repSite').Value := data1.repSite;
      data1.sitetab.Open;

      data1.areatab.close;
      data1.areatab.Parameters.ParamByName('repSite').Value := data1.repSite;
      data1.areatab.Open;

      fReps2 := TfReps2.Create(self);
      fReps2.curTid := FieldByName('tid').asinteger;
      setLength(fReps2.stocks, SelectedList.Count);

      for i:= 0 to SelectedList.Count-1 do
      begin
        GotoBookmark(SelectedList.items[i]);
        fReps2.stocks[i] := FieldByName('stockcode').asinteger;
      end;

      fReps2.ShowModal;
      fReps2.Free;

      EnableControls;  { Re-enable controls }
    end;
  end
  else
  begin
    data1.initCurr(adoqThStock.FieldByName('tid').AsInteger,
       adoqThStock.FieldByName('StockCode').AsInteger,
       adoqThStock.FieldByName('SiteCode').AsInteger, True, False);

    fReps1 := TfReps1.Create(self);
    fReps1.ShowModal;
    fReps1.Free;
  end;
  log.event('Exiting fHOrep.BitBtn2Clicked');
end;

procedure TfHOrep.adoqThStockAfterScroll(DataSet: TDataSet);
begin
  if adoqThStock.RecordCount = 0 then
  begin
    bitbtn2.Enabled := False;
  end
  else
  begin
    bitbtn2.Enabled := True;
  end;
  label2.Enabled := bitbtn2.Enabled;
end;

procedure TfHOrep.adoqThreadsAfterScroll(DataSet: TDataSet);
begin
  wwdbGrid3.SelectedList.Clear;
end;

procedure TfHOrep.adoqDivsAfterScroll(DataSet: TDataSet);
begin
  wwdbGrid3.SelectedList.Clear;
end;

procedure TfHOrep.adoqSiteAfterScroll(DataSet: TDataSet);
begin
  if adoqThStock.Active then
  begin
    with adoqThStock do
    begin
      DisableControls;
      close;
      sql.Clear;
      sql.Add('select [sitecode], [Tid], [StockCode], [SDate], [STime], [EDate], [ETime], sdt, edt,');
      sql.Add('	[AccDate], [AccTime], [StkKind], [division], [type], [byHZ],');
      sql.Add(' (CAST(((FLOOR(CAST(([edate] - [sdate] + 1) AS int))) / 7) AS VARCHAR) + ''/'' + ');
      sql.Add('  CAST(((FLOOR(CAST(([edate] - [sdate] + 1) AS int))) % 7) AS VARCHAR)) as period,pureAZ, byLocation');

      sql.Add('from Stocks');
      sql.Add('where Tid = :tid');
      sql.Add('and sitecode = ' + adoqSite.FieldByName('sitecode').asstring);
      sql.Add('and stockcode >= 2 and PureAZ = 1');
      sql.Add('order by edt DESC');
      open;
      EnableControls;
    end;
  end;

  with data1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select * from');
    sql.Add('  (select count(*) as lcc from LineCheck ');
    sql.Add('     where sitecode = ' + adoqSite.FieldByName('sitecode').asstring + ') a,');
    sql.Add('  (select count(*) as scc from stksc');
    sql.Add('     where sitecode = ' + adoqSite.FieldByName('sitecode').asstring + ') b');
    open;

    bitbtn3.Enabled := ((FieldByName('lcc').asinteger + FieldByName('scc').asinteger) > 0);

    close;
  end;

end;

procedure TfHOrep.wwDBGrid3CalcTitleAttributes(Sender: TObject;
  AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  if afieldname = yellField then
  begin
    aBrush.Color := clYellow;
    aFont.Color := clBlack;
  end
  else if afieldname = redField then
  begin
    aBrush.Color := clRed;
    aFont.Color := clWhite;
  end;
end;

procedure TfHOrep.wwDBGrid3TitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  if (AFieldName = 'period') then
    exit;

  with adoqThstock do
  begin
    DisableControls;

    if (AFieldName = redField) then // already Red, take color off and use default order...
    begin
      close;
      sql[8] := 'order by "edt" DESC';
      open;
      redField := '';
      yellField := '';
    end
    else
    begin
      if AFieldName = yellField then // already Yellow, make Red and do DESC by this field...
      begin
        close;
        sql[8] := 'order by [' + AFieldName + '] DESC';
        open;
        redField := AFieldName;
        yellField := '';
      end
      else    // no order or ordered by another field, make Yellow and order by ASCending
      begin
        close;
        sql[8] := 'order by [' + AFieldName + ']';
        open;
        redField := '';
        yellField := AFieldName;
      end;
    end;

    First;
    EnableControls;
  end;

end;

procedure TfHOrep.BitBtn3Click(Sender: TObject);
begin
  data1.repSite := adoqSite.FieldByName('SiteCode').AsInteger;

  fLCRep := TfLCRep.Create(self);
  flcRep.Caption := 'Site: ' + adoqSite.FieldByName('Site Name').Asstring +
    ' -- Line Checks and Spot Checks Reports';
  fLCRep.ShowModal;
  fLCRep.free;
end;

procedure TfHOrep.wwDBGrid2CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if adoqThreads.fieldbyname('Active').Value = 'N' then
  begin
      AFont.Style := [fsItalic];
      ABrush.Color := clSilver;
  end;
end;

end.
