unit uOutletTablePlans;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, Wwdbigrd, Wwdbgrid, uGridSortHelper,
  ExtCtrls;

type
  TOutletTablePlans = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    btAddOutletTablePlan: TButton;
    btEditOutletTablePlan: TButton;
    btDeleteOutletTablePlan: TButton;
    btClose: TButton;
    btEditOutletTablePlanDesign: TButton;
    dbgSiteList: TwwDBGrid;
    dbgTablePlanList: TwwDBGrid;
    Bevel2: TBevel;
    procedure btAddOutletTablePlanClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btEditOutletTablePlanClick(Sender: TObject);
    procedure btDeleteOutletTablePlanClick(Sender: TObject);
    procedure btEditOutletTablePlanDesignClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
    SiteListSortHelper: TGridSortHelper;
    TablePlanListSortHelper: TGridSortHelper;
    SiteEditStartTime: TDateTime;
  public
    { Public declarations }
  end;

var
  OutletTablePlans: TOutletTablePlans;

implementation

uses uDMThemeData, uEditGenericDetails, uGenerateThemeIDs,
  uEditOutletTablePlan, uAztecLog, uFormNavigate;

{$R *.dfm}

procedure TOutletTablePlans.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
  dmThemeData.AccessDataset('qOutlets');
  dmThemeData.AccessDataset('qOutletTablePlans');
  SiteListSortHelper := TGridSortHelper.Create;
  SiteListSortHelper.Initialise(dbgSiteList);
  SiteListSortHelper.Reset;
  TablePlanListSortHelper := TGridSortHelper.Create;
  TablePlanListSortHelper.Initialise(dbgTablePlanList);
  TablePlanListSortHelper.Reset;
  if IsSite then
  begin
    dmThemeData.adoqRun.SQL.Text := 'select IsNull((select min(LastThemeSend) from aztecpos where lrdt > getdate()-7 and IsPos = 1), GETDATE())';
    dmThemeData.adoqRun.Open;
    SiteEditStartTime := dmThemeData.adoqRun.Fields[0].AsDateTime;
    dmThemeData.adoqRun.Close;
  end;
end;

procedure TOutletTablePlans.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
  dmThemeData.DeAccessDataset('qOutlets');
  dmThemeData.DeAccessDataset('qOutletTablePlans');
  SiteListSortHelper.Free;
  TablePlanListSortHelper.Free;
  Nav.MoveBack;
end;

procedure TOutletTablePlans.btAddOutletTablePlanClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  if dmThemeData.qOutlets.Recordcount = 0 then
    raise Exception.create('There are no Site/Site PCs!');
  if dmThemeData.qOutletTablePlans.RecordCount >= 30 then
    raise Exception.create('You cannot create more than 30 Site Table Plans');
  with TEditGenericDetails.create(nil) do try
    lbName.caption := 'Site Table Plan name';
    caption := 'Add new Site Table Plan';
    edName.text := '';
    mmDescription.lines.Clear;
    if showmodal = mrOk then
    begin
      dmThemeData.qOutletTablePlans.InsertRecord([
        dmThemeData.qOutlets.fieldbyname('SiteCode').asinteger,
        integer(GetNewID(scThemeOutletTablePlan)),
        edName.text,
        mmDescription.lines.text,
        nil
      ]);
    end;
  finally
    free;
  end;
end;


procedure TOutletTablePlans.btEditOutletTablePlanClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  if dmThemeData.qOutletTablePlans.RecordCount = 0 then
    raise Exception.Create('Add some items first!');
  with TEditGenericDetails.create(nil) do try
    lbName.caption := 'Site Table Plan name';
    caption := 'Edit Site Table Plan';
    edName.text := dmThemeData.qOutletTablePlans.fieldbyname('Name').AsString;
    mmDescription.Lines.Text := dmThemeData.qOutletTablePlans.fieldbyname('Description').AsString;
    if showmodal = mrOk then
    with dmThemeData.qOutletTablePlans do
    begin
      edit;
      fieldbyname('Name').asstring := edName.text;
      fieldbyname('Description').asstring := mmDescription.lines.text;
      post;
    end;
  finally
    free;
  end;
end;

procedure TOutletTablePlans.btDeleteOutletTablePlanClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  if dmThemeData.qOutletTablePlans.RecordCount = 0 then
    raise Exception.Create('Add some items first!');
  // labels and buttons deleted via cascade delete
  if messagedlg(
    format('Are you sure you want to delete table plan "%s"?', [dmThemeData.qOutletTablePlans.fieldbyname('Name').asstring]),
      mtConfirmation, [mbOk, mbCancel], 0) = mrOk then
  begin
    Log('Deleting Table Plan ' + dmThemeData.qOutletTablePlans.fieldbyname('Name').asstring);
    dmThemeData.qOutletTablePlans.Delete;
  end;
end;

procedure TOutletTablePlans.btEditOutletTablePlanDesignClick(
  Sender: TObject);
begin
  ButtonClicked(Sender);
  if dmThemeData.qOutletTablePlans.RecordCount = 0 then
    raise Exception.Create('Add some items first!');
  TEditOutletTablePlan.EditOutletTablePlan(dmThemeData.qOutletTablePlans.fieldbyname('OutletTablePlanID').asinteger);
end;

procedure TOutletTablePlans.btCloseClick(Sender: TObject);
var
  InUseTableCount: integer;
  TableList: string;
begin
  if IsSite then
  begin
    with dmThemeData.adoqRun do
    begin
      SQL.Text := Format(
        'declare @CheckTime datetime '+
        'set @CheckTime = %s '+
        'if exists( '+
        '  select TableNumber from ThemeOutletTable_Repl where LMDT > @CheckTime '+
        '  union '+
        '  select TableNumber from ThemeOutletTableSeat_Repl where LMDT > @CheckTime '+
        ') '+
        'begin '+
        '  select a.TableNumber '+
        '  from ( '+
        '    select TableNumber from ThemeOutletTable_Repl where LMDT > @CheckTime '+
        '    union '+
        '    select TableNumber from ThemeOutletTableSeat_Repl where LMDT > @CheckTime '+
        '  ) a '+
        '  join ( '+
        '    select distinct [Table Number] as TableNumber from tabledetails a '+
        '    join ( '+
        '    select a.accountid, max([transaction number]) as MaxTrx '+
        '    from accountdetail a '+
        '    join tabledetails b on a.accountid = b.accountid '+
        '    where a.opendate > getdate() - 1.0 and a.closedate is null '+
        '      and b.date > getdate() - 1.0 '+
        '    group by a.AccountID '+
        '    ) sub on a.AccountID = sub.AccountID and a.[Transaction Number] = MaxTrx '+
        '  ) b on a.TableNumber = b.TableNumber '+
        'end '+
        'else select top 0 * from (select 1 as TableNumber) a', [dmThemeData.FormatDateTimeForSQL(SiteEditStartTime)]);
      Open;
      InUseTableCount := 0;
      while not(EOF) do
      begin
        Inc(InUseTableCount);
        TableList := TableList + Format('%s, ', [FieldByName('TableNumber').AsString]);
        if InUseTableCount mod 15 = 0 then
          TableList := TableList + #13;
        Next;
      end;
      Close;
      if InUseTableCount > 0 then
      begin
        SetLength(TableList, Length(TableList)-2);
        MessageDlg('The following tables have been edited but are currently in use on EPOS:'+#13+#13+
          TableList+#13+#13+'Please ensure these tables are closed before the updated Theme is sent.', mtWarning, [mbOk], 0);
      end;
    end;
  end;
  ButtonClicked(Sender);
  Close;
end;

end.
