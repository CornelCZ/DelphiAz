unit uPickWeek;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Wwdbigrd, Wwdbgrid, Db, DBTables, Wwquery, Wwdatsrc, StdCtrls,
  Buttons, Variants, ADODB;

type TPickWeekMode = (pwmVerifyShifts, pwmSchedule);

type
  TfPickWeek = class(TForm)
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    DBGrid1: TwwDBGrid;
    adoqRun: TADOQuery;
    dsRun: TDataSource;
    adoqRunweekStart: TDateTimeField;
    adoqRunweekEnd: TDateTimeField;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
  private
    { Private declarations }
    firstday: integer;
    stayHere : boolean;
  public
    { Public declarations }
    selWeekSt, curWeekSt: tdatetime;
    extraDays, VSiteCode: integer;
    mode: TPickWeekMode;
  end;

var
  fPickWeek: TfPickWeek;

implementation

uses uempmnu, dmodule1, uADO, uGlobals;

{$R *.DFM}

procedure TfPickWeek.FormShow(Sender: TObject);
var
  startdate: tdatetime;

  {SUB} procedure CreateGridTable;
  begin
    dmADO.DelSQLTable('#PickWeekGrid');

    with TADOCommand.Create(nil)do try
      Connection := dmADO.AztecConn;
      CommandText :=
        'CREATE TABLE [#PickWeekGrid] (' +
          '[weekStart] [datetime] NOT NULL ,' +
          '[weekEnd] [datetime] NOT NULL) ON [PRIMARY] ';
      Execute;
    finally
      free;
    end;
  end; { SUB procedure CreateGridTable }


begin
  adoqRunweekStart.DisplayFormat := shortdateformat + 'yy';
  adoqRunweekEnd.DisplayFormat := shortdateformat + 'yy';

  if IsSite then
      uGlobals.stweek := dMod1.GetSiteStartOfWeek(SiteCode)
    else
      uGlobals.stweek := dMod1.GetSiteStartOfWeek(VSiteCode);

  firstday := ((11 - uGlobals.stweek) mod 7) + 1; // factor to calculate first day of week
  curWeekSt := date - ((dayofweek(date) + firstday) mod 7);

  with dmod1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('select min(schin) as minschin, count(schin) as countschin');
    SQL.Add('from schedule');
    SQL.Add('where schin < ''' + formatDateTime('mm/dd/yyyy', Date + 1) + '''');

    if IsSite then
      SQL.Add('and SiteCode = ' + inttostr(SiteCode))
    else
      SQL.Add('and SiteCode = ' + inttostr(VSiteCode));

    open;

    if (recordcount = 1) and (FieldByName('countschin').asinteger = 0) then
      // IF NO RECORDS IN SCHEDULE THEN CUREENT WEEK IS FIRST AVAILABLE. 
      startdate := curWeekSt
    else
      // IF SOME TIMES ARE IN SCHEDULE THEN THE FIRST AVAILABLE WEEK IS THAT WITH THE
      // EARLIEST DATE.
      startdate := trunc(fieldbyname('minschin').asdatetime) -
        ((dayofweek(fieldbyname('minschin').asdatetime) + firstday) mod 7);

    CreateGridTable;

    while startdate <= Date + ExtraDays do
    begin
      Close;
      sql.Clear;
      sql.Add('INSERT [#PickWeekGrid] (weekStart, weekEnd) VALUES ( ' );
      sql.Add('''' + formatDateTime('yyyymmdd', startdate) + ''',');
      sql.Add('''' + formatDateTime('yyyymmdd', startdate + 6) + ''')');
      execSQL;

      startdate := startdate + 7;
    end;
  end;

  adoqRun.Close;
  adoqRun.sql.Clear;
  adoqRun.sql.Add('select * from #PickWeekGrid order by weekStart');
  adoqRun.open;

  if fPickWeek.mode = pwmVerifyShifts then
    adoqRun.Locate('weekstart', fempmnu.SOweek, [])
  else
    adoqRun.locate('weekStart', curWeekSt, []);

  screen.cursor := crDefault;
end;

procedure TfPickWeek.btnOKClick(Sender: TObject);
begin
  stayHere := FALSE;
  with adoqRun do
  begin
    selWeekSt := fieldbyname('weekstart').asdatetime;
  end;

  if fPickWeek.mode = pwmVerifyShifts then
    if fempmnu.forceWeekSignOff then
      if selWeekSt > fempmnu.SOweek then
      begin
        MessageDlg('You can Verify Times for a week only after the previous week has been Signed-Off.'+
              #13+#10+'Currently, the only week for which you can Verify Times is: ' +
              formatDateTime('ddd ddddd', fempmnu.SOweek) + ' - ' +
              formatDateTime('ddd ddddd', fempmnu.SOweek + 6) + '.', mtInformation, [mbOK], 0);
        stayHere := TRUE;
      end;

  if stayHere then
    modalResult := mrNone
  else
    modalResult := mrOK;
end;

procedure TfPickWeek.DBGrid1DblClick(Sender: TObject);
begin
  btnOKClick(self);
end;

procedure TfPickWeek.FormCreate(Sender: TObject);
begin
  if HelpExists then
    setHelpContextID(self, EMP_PICK_WEEK);
end;

procedure TfPickWeek.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  adoqRun.close;
end;

procedure TfPickWeek.DBGrid1CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if fPickWeek.mode = pwmVerifyShifts then
    if fempmnu.forceWeekSignOff then
      if adoqRun.fieldbyname('weekstart').asdatetime = fempmnu.SOweek then
        AFont.Style := [fsBold];

end;

end.

