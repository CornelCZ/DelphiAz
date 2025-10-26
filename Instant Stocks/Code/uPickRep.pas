unit uPickRep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, wwdbedit, Grids, Wwdbigrd, Wwdbgrid, DB,
  Wwdatsrc, ADODB, Buttons, ExtCtrls;

type
  TfPickRep = class(TForm)
    adoqDivs: TADOQuery;
    dsDivs: TwwDataSource;
    adoqThreads: TADOQuery;
    dsThreads: TwwDataSource;
    adoqThStock: TADOQuery;
    dsThStocks: TwwDataSource;
    Label1: TLabel;
    wwDBGrid1: TwwDBGrid;
    Label10: TLabel;
    wwDBGrid2: TwwDBGrid;
    wwDBGrid3: TwwDBGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    BitBtn3: TBitBtn;
    Bevel1: TBevel;
    ADOQuery1: TADOQuery;
    Label3: TLabel;
    Label4: TLabel;
    btnCPS: TBitBtn;
    Label5: TLabel;
    Label6: TLabel;
    Bevel2: TBevel;
    Label7: TLabel;
    Bevel3: TBevel;
    Label8: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ADOQuery1AfterScroll(DataSet: TDataSet);
    procedure adoqThStockAfterScroll(DataSet: TDataSet);
    procedure BitBtn3Click(Sender: TObject);
    procedure adoqThreadsAfterScroll(DataSet: TDataSet);
    procedure adoqDivsAfterScroll(DataSet: TDataSet);
    procedure wwDBGrid3CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure btnCPSClick(Sender: TObject);
    procedure wwDBGrid3CalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure wwDBGrid3TitleButtonClick(Sender: TObject;
      AFieldName: String);
    procedure WMSysCommand(var Msg: TWMSysCommand);
    message WM_SYSCOMMAND;
    procedure wwDBGrid2CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
  private
    showCPS, CPset, multiOnly : boolean;
    yellField, RedField : string;
    procedure SetSecurity;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fPickRep: TfPickRep;

implementation

uses udata1, uADO, uDataProc, uReps2, uReps1, uLog;

{$R *.dfm}  

{Used to minimise the whole app if the current form is minimised}
procedure TfPickRep.WMSysCommand;
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

procedure TfPickRep.SetSecurity;
var
  curTid : integer;
  s1 : string;
begin
  if data1.UKUSmode = 'US' then
    s1 := '---->>'
  else
    s1 := '--------->>';
  CurTid := adoqThreads.FieldByName('tid').AsInteger;

  bitBtn3.Visible := data1.UserAllowed(curTid, 22);

  multiOnly := False;
  label2.Enabled := True;
  if data1.UserAllowed(curTid, 23) then
  begin
    if data1.UserAllowed(curTid, 24) then
    begin                                 // ACC Single & Multi
      label4.Enabled := True;
      label2.Caption := '- Pick 1 ' + data1.SSbig + ' from the grid ' + s1 + #13 +
        '  to print Single ' + data1.SSbig + ' Reports' + #13 +
        '- Pick 2 or more ' + data1.SSplural + #13 +
        '  to print Multi-' + data1.SSbig + ' Reports';

      if not (Wwdbigrd.dgMultiSelect in wwDBGrid3.Options) then
      begin
        wwDBGrid3.Options := wwDBGrid3.Options + [Wwdbigrd.dgMultiSelect];
      end;
    end
    else
    begin                                 // ACC Single but NO Multi
      label4.Enabled := False;
      label2.Caption := '- Pick 1 ' + data1.SSbig + ' from the grid ' + s1 + #13 +
        '  to print Single ' + data1.SSbig + ' Reports' + #13 +
        '- Multi-' + data1.SSbig + ' Reports'  + #13 +
        '  are NOT permitted for this Thread.';

      if (Wwdbigrd.dgMultiSelect in wwDBGrid3.Options) then
      begin
        wwDBGrid3.Options := wwDBGrid3.Options - [Wwdbigrd.dgMultiSelect];
      end;
    end;
    bitbtn2.Visible := True;
  end
  else
  begin
    if data1.UserAllowed(curTid, 24) then
    begin                                 // ACC Multi but NO Single
      label4.Enabled := true;
      bitbtn2.Visible := True;
      label2.Caption := '- Single ' + data1.SSbig + ' Reports'  + #13 +
        '  are NOT permitted for this Thread.' + #13 +
        '- Pick 2 or more ' + data1.SSplural + #13 +
        '  to print Multi-' + data1.SSbig + ' Reports';

      if not (Wwdbigrd.dgMultiSelect in wwDBGrid3.Options) then
      begin
        wwDBGrid3.Options := wwDBGrid3.Options + [Wwdbigrd.dgMultiSelect];
      end;
      multiOnly := True;
    end
    else
    begin                                 // No ACC at all
      label4.Enabled := False;
      bitbtn2.Visible := False;
      label2.Enabled := False;
    end;
  end;
end; // procedure..


procedure TfPickRep.FormShow(Sender: TObject);
var
  s1 : string;
begin
  showCPS := False;
  if data1.UKUSmode = 'US' then
    s1 := '---->>'
  else
    s1 := '--------->>';

  self.Caption := data1.SSbig + ' Reports';
  label3.Caption := '3. Select 1 or more Accepted ' + data1.SSplural;
  bitbtn3.Caption := 'Current ' + data1.SSbig + ' Reports...';
  bitbtn2.Caption := 'Accepted ' + data1.SSbig + ' Reports...';
  label2.Caption := '- Pick 1 ' + data1.SSbig + ' from the grid ' + s1 + #13 +
    '  to print Single ' + data1.SSbig + ' Reports' + #13 +
    '- Pick 2 or more ' + data1.SSplural + #13 +
    '  to print Multi-' + data1.SSbig + ' Reports';

  adoqDivs.open;
  adoqThreads.Open;
  adoqThStock.open;
  adoquery1.open;
  adoqThreadsAfterScroll(adoqThreads);
  yellField := '';
  redField := '';
end;

procedure TfPickRep.BitBtn2Click(Sender: TObject);
var
  i: integer;
begin
  log.event('In fPickRep.BitBtn2Click, ThreadId = ' +
    IntToStr(adoqThStock.FieldByName('tid').AsInteger) + ', StockCode = ' +
    IntToStr(adoqThStock.FieldByName('stockcode').AsInteger));
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
    if multiOnly then
    begin
      showMessage('You do not have Security Permission to View Single Reports for this Thread!' + #13 + #13 +
        'Select more than 1 '+ data1.SSbig + ' to view Multi-Reports or choose another Thread.');
      exit;
    end;

    data1.initCurr(adoqThStock.FieldByName('tid').AsInteger,
       adoqThStock.FieldByName('StockCode').AsInteger, data1.TheSiteCode, True, False);

    fReps1 := TfReps1.Create(self);
    fReps1.ShowModal;
    fReps1.Free;
  end;
  log.event('Exiting fPickRep.BitBtn2Click');
end;

procedure TfPickRep.ADOQuery1AfterScroll(DataSet: TDataSet);
begin
  if ADOQuery1.RecordCount = 0 then
  begin
    bitbtn3.Enabled := False;
  end
  else
  begin
    bitbtn3.Enabled := True;
  end;
end;

procedure TfPickRep.adoqThStockAfterScroll(DataSet: TDataSet);
begin
  if adoqThStock.RecordCount = 0 then
  begin
    bitbtn2.Enabled := False;
  end
  else
  begin
    bitbtn2.Enabled := True;
  end;
  label2.Enabled := bitbtn2.Enabled and bitbtn2.Visible;

  bevel2.Visible := false;
  bevel3.Visible := false;
  if showCPS and CPSet then
  begin
    if adoqThStock.FieldByName('type').asstring = 'B' then
    begin
      btnCPS.Caption := '<- Reset from Start of Cumulative Period';
      bevel2.Visible := true;
    end
    else
    begin
      btnCPS.Caption := 'Set as Start of New Cumulative Period ->';
      bevel2.Visible := false;
    end;

    bevel3.Visible := not bevel2.Visible;
    label7.Visible := bevel2.Visible;
    label8.Visible := not bevel2.Visible;
    btnCPS.Enabled := bitbtn2.Enabled;
  end;
  label7.Visible := bevel2.Visible;
  label8.Visible := bevel3.Visible;

end;

procedure TfPickRep.BitBtn3Click(Sender: TObject);
begin
  log.event('In fPickRep.BitBtn3Click, ThreadId = ' +
    IntToStr(adoQuery1.FieldByName('tid').AsInteger) + ', StockCode = ' +
    IntToStr(adoQuery1.FieldByName('stockcode').AsInteger));
  data1.initCurr(adoQuery1.FieldByName('tid').AsInteger,
     adoQuery1.FieldByName('stockcode').AsInteger, data1.TheSiteCode, True, True);

  fReps1 := TfReps1.Create(self);
  fReps1.ShowModal;
  fReps1.Free;
  log.event('Exiting fPickRep.BitBtn3Click');
end;

procedure TfPickRep.adoqThreadsAfterScroll(DataSet: TDataSet);
begin
  wwdbGrid3.SelectedList.Clear;

  showCPS := (adoqThreads.FieldByName('doCPS').asstring = 'Y');

  SetSecurity;

  CPSet := (adoqThreads.FieldByName('CPSmode').asstring = 'R')
    and (data1.UserAllowed(adoqThreads.FieldByName('tid').asinteger, 22)
         and data1.UserAllowed(adoqThreads.FieldByName('tid').asinteger, 23)
         and data1.UserAllowed(adoqThreads.FieldByName('tid').asinteger, 24));

  if wwdbgrid3.DataSource.DataSet.Active then //and (wwdbgrid3.DataSource.DataSet.recordcount > 0) then
  begin
    if wwdbgrid3.DataSource.DataSet.recordcount > 0 then
      wwdbgrid3.SelectRecord;
    adoqThStockAfterScroll(TDataSet(adoqThStock));
  end
  else
  begin
    CPSet := False;
  end;


  if showCPS and CPSet then
  begin
    btnCPS.Visible := True;
    wwDBGrid3.Height := 437;
  end
  else
  begin
    btnCPS.Visible := False;
    wwDBGrid3.Height := 477;
  end;
end;

procedure TfPickRep.adoqDivsAfterScroll(DataSet: TDataSet);
begin
  wwdbGrid3.SelectedList.Clear;

  if wwdbgrid2.DataSource.DataSet.Active and (wwdbgrid2.DataSource.DataSet.recordcount > 0) then
  begin
    wwdbgrid2.SelectRecord;
    adoqThreadsAfterScroll(TDataSet(adoqThreads));
  end;

end;

procedure TfPickRep.wwDBGrid3CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if (Field.FieldName = 'EDate') or (Field.FieldName = 'ETime') or
         (Field.FieldName = 'AccDate') or (Field.FieldName = 'AccTime') then
  begin
    if showCPS then
    begin
      if wwDBGrid3.DataSource.DataSet.FieldByName('type').asstring = 'B' then
      begin
        if wwdbgrid3.IsSelectedRecord then
        begin
          AFont.Style := [fsBold];
          AFont.Color := clYellow;
          ABrush.Color := clBlack;
          exit;
        end;

        ABrush.Color := clYellow;
        AFont.Style := [fsBold];
      end
      else
      begin
        if wwdbgrid3.IsSelectedRecord then
          exit;
        ABrush.Color := clWhite;
        AFont.Style := [];
      end;
    end;
  end
  else
  begin
    if showCPS then
    begin
      if wwDBGrid3.DataSource.DataSet.FieldByName('type').asstring = 'B' then
      begin
        if wwdbgrid3.IsSelectedRecord then
        begin
          AFont.Style := [fsBold];
          AFont.Color := clYellow;
          ABrush.Color := clBlack;
          exit;
        end;

        ABrush.Color := clYellow;
        AFont.Style := [fsBold];
      end
      else
      begin
        if wwdbgrid3.IsSelectedRecord then
          exit;
        ABrush.Color := clWhite;
        AFont.Style := [];
      end;
    end;
  end;
end;

procedure TfPickRep.btnCPSClick(Sender: TObject);
begin

  if wwDBGrid3.DataSource.DataSet.FieldByName('type').asstring = 'B' then
  begin
    wwDBGrid3.DataSource.DataSet.edit;
    wwDBGrid3.DataSource.DataSet.FieldByName('type').asstring := 'A';
    wwDBGrid3.DataSource.DataSet.post;
    btnCPS.Caption := 'Set as Start of New Cumulative Period ->';
    bevel2.Visible := false;
  end
  else
  begin
    wwDBGrid3.DataSource.DataSet.edit;
    wwDBGrid3.DataSource.DataSet.FieldByName('type').asstring := 'B';
    wwDBGrid3.DataSource.DataSet.post;
    btnCPS.Caption := '<- Reset from Start of Cumulative Period';
    bevel2.Visible := true;
  end;
  bevel3.Visible := not bevel2.Visible;
  label7.Visible := bevel2.Visible;
  label8.Visible := not bevel2.Visible;

end;

procedure TfPickRep.wwDBGrid3CalcTitleAttributes(Sender: TObject;
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

procedure TfPickRep.wwDBGrid3TitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
  if (AFieldName = 'STime') or (AFieldName = 'ETime') or (AFieldName = 'AccTime') then
    exit;

  with adoqThStock do
  begin
    DisableControls;

    if (AFieldName = redField) then
    begin
      close;
      sql[3] := 'order by "edt" DESC';
      open;
      redField := '';
      yellField := '';
    end
    else
    begin
      if AFieldName = yellField then // already Yellow, make Red and do DESC by this field...
      begin
        close;
        sql[3] := 'order by [' + AFieldName + '] DESC';
        open;
        redField := AFieldName;
        yellField := '';
      end
      else    // no order or ordered by another field, make Yellow and order by ASCending
      begin
        close;
        sql[3] := 'order by [' + AFieldName + ']';
        open;
        redField := '';
        yellField := AFieldName;
      end;
    end;

    First;
    EnableControls;
  end;

end;

procedure TfPickRep.wwDBGrid2CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if adoqThreads.fieldbyname('Active').Value = 'N' then
  begin
      AFont.Style := [fsItalic];
      ABrush.Color := clSilver;
  end;
end;

end.
