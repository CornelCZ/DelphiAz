unit uPromotionReports;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ActnList, ppDB, ppDBPipe, DB,
  ADODB, ppBands, ppCache, ppClass, ppComm, ppRelatv, ppProd, ppReport,
  uPromoCommon, ppCtrls, ppPrnabl, Grids, DBGrids, ppStrtch, ppSubRpt,
  uAztecLog;

type
  TPromotionReports = class(TForm)
    Panel1: TPanel;
    cbReportType: TComboBox;
    Label2: TLabel;
    Panel5: TPanel;
    lblReportTitle: TLabel;
    Bevel3: TBevel;
    Image4: TImage;
    lblReportDetail: TLabel;
    rbAllDates: TRadioButton;
    rbFilterDate: TRadioButton;
    dtpDateFilterStart: TDateTimePicker;
    Label1: TLabel;
    dtpDateFilterEnd: TDateTimePicker;
    Label4: TLabel;
    cbSiteNames: TComboBox;
    Label5: TLabel;
    cbPromotions: TComboBox;
    Label6: TLabel;
    btClose: TButton;
    btPreview: TButton;
    ActionList1: TActionList;
    SetDateFilterMode: TAction;
    LoadSiteNames: TAction;
    LoadPromotionNames: TAction;
    Preview: TAction;
    ppDBPipeline1: TppDBPipeline;
    adoReportTable: TADOTable;
    adoReportTableSiteName: TStringField;
    adoReportTableSalesAreaName: TStringField;
    adoReportTableName: TStringField;
    adoReportTableDescription: TStringField;
    adoReportTablePromoTypeName: TStringField;
    adoReportTableStartDate: TDateTimeField;
    adoReportTableEndDate: TDateTimeField;
    adoReportTableExceptionName: TStringField;
    adoReportTableExceptionDescription: TStringField;
    adoReportTablePromotionID: TLargeintField;
    dsReportAll: TDataSource;
    adoReportAll: TADOQuery;
    adoReportAllPromotionID: TLargeintField;
    adoReportAllSiteName: TStringField;
    adoReportAllSalesAreaName: TStringField;
    adoReportAllName: TStringField;
    adoReportAllDescription: TStringField;
    adoReportAllPromoTypeName: TStringField;
    adoReportAllStartDate: TDateTimeField;
    adoReportAllEndDate: TDateTimeField;
    adoReportAllExceptionName: TStringField;
    adoReportAllExceptionDescription: TStringField;
    ppRepSiteUsage: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppLabel1: TppLabel;
    ppShape1: TppShape;
    ppDBText1: TppDBText;
    ppLabel2: TppLabel;
    ppShape3: TppShape;
    ppDBText2: TppDBText;
    ppLabel3: TppLabel;
    ppShape5: TppShape;
    ppDBText3: TppDBText;
    ppLabel5: TppLabel;
    ppShape9: TppShape;
    ppDBText5: TppDBText;
    ppLabel4: TppLabel;
    ppShape7: TppShape;
    ppDBText4: TppDBText;
    ppLabel6: TppLabel;
    ppShape11: TppShape;
    ppDBText6: TppDBText;
    ppLabel7: TppLabel;
    ppShape13: TppShape;
    ppDBText7: TppDBText;
    ppLabel8: TppLabel;
    ChangeReportDetails: TAction;
    ppRepPromotion: TppReport;
    ppHeaderBand2: TppHeaderBand;
    ppShape2: TppShape;
    ppShape4: TppShape;
    ppShape6: TppShape;
    ppShape8: TppShape;
    ppShape10: TppShape;
    ppShape12: TppShape;
    ppShape14: TppShape;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    ppDetailBand2: TppDetailBand;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppDBText14: TppDBText;
    ppFooterBand2: TppFooterBand;
    adoReportTableSiteCode: TIntegerField;
    adoReportTableCreatedBy: TStringField;
    ppDBTextSiteIndicator: TppDBText;
    adoReportTableSiteIndicator: TStringField;
    ppDBTextSiteOnly: TppDBText;
    ppLabelSiteOnly: TppLabel;
    adoReportTableLegendIndicator: TStringField;
    ppLine1: TppLine;
    ppDBText15: TppDBText;
    ppLabel17: TppLabel;
    ppDBTextLegendIndicator: TppDBText;
    ppLine2: TppLine;
    procedure SetDateFilterModeExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LoadSiteNamesExecute(Sender: TObject);
    procedure LoadPromotionNamesExecute(Sender: TObject);
    procedure PreviewExecute(Sender: TObject);
    procedure ChangeReportDetailsExecute(Sender: TObject);
    procedure HandlePreviewFormCreate(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure ppDetailBand2BeforePrint(Sender: TObject);
    procedure dtpDateFilterStartChange(Sender: TObject);
    procedure dtpDateFilterEndChange(Sender: TObject);
  private
    { Private declarations }
//    RepType         : TReportType;
    PromoFilterStr  : String;
    SiteFilterStr   : String;
    UseDateRange    : Boolean;
    dtStartDate     : TDateTime;
    dtEndDate       : TDateTime;
//    procedure SetPromoFilter(const Value: String);
//    procedure SetSiteFilterStr(const Value: String);
    procedure BlankRepeatingFields;
    procedure BuildReportSQL;
    procedure CalcTitles;
    procedure SetStartAndEndDate;
  public
    { Public declarations }
    class procedure ShowDialog;
  end;

implementation

uses udmPromotions, useful, uSimpleLocalise, uSetupRBuilderPreview;
{$R *.dfm}

{ TPromotionReports }

class procedure TPromotionReports.ShowDialog;
begin
  Log('PromotionReports', 'Creating Instance...');
  with TPromotionReports.Create(nil) do try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TPromotionReports.SetDateFilterModeExecute(Sender: TObject);
begin
  if rbAllDates.Checked then
    Log('  Promotion Reports', 'All Dates Checked')
  else
    Log('  Promotion Reports', 'Promotions Effective Between.. Checked');

  dtpDateFilterStart.Enabled := rbFilterDate.Checked;
  dtpDateFilterEnd.Enabled := rbFilterDate.Checked;
  ChangeReportDetailsExecute(self);
end;

procedure TPromotionReports.CalcTitles;
const
  PROMOTION_INDEX = 0;
  SITE_INDEX      = 1;
var
  ReportDetail : String;
begin
  case TReportType (cbReportType.ItemIndex) of
    rtPromotionUsage: lblReportTitle.Caption := 'Promotion Usage Report';
    rtSiteUsage: lblReportTitle.Caption := 'Site Usage Report';
  end;
  Log('  Promotion Reports - ', lblReportTitle.Caption);

  ReportDetail := 'This report is showing ';
  if cbPromotions.Text <> ALL_PROMOTIONS then
  begin
    PromoFilterStr := cbPromotions.Text;
    ReportDetail := Format ('%s %s promotion', [ReportDetail, cbPromotions.Text]);
  end
  else
  begin
    PromoFilterStr := '';
    ReportDetail := Format ('%s all promotions', [ReportDetail]);
  end;
  Log('  Information to Report - ', cbPromotions.Text);
  Log('  ReportDetail - ', ReportDetail);

  if cbSiteNames.Text <> ALL_SITES then
  begin
    SiteFilterStr := cbSiteNames.Text;
    ReportDetail := Format ('%s on %s site', [ReportDetail, cbSiteNames.Text]);
  end
  else
  begin
    SiteFilterStr := '';
    ReportDetail := Format ('%s on all sites', [ReportDetail]);
  end;
  Log('  Site Filter - ', cbSiteNames.Text);
  Log('  ReportDetail - ', ReportDetail);

  UseDateRange := rbFilterDate.Checked;
  if rbFilterDate.Checked then
  begin
    dtStartDate := dtpDateFilterStart.Date;
    dtEndDate := dtpDateFilterEnd.Date;
    ReportDetail := Format ('%s between dates %s and %s.', [ReportDetail, DateToStr(dtpDateFilterStart.Date), DateToStr(dtpDateFilterEnd.Date)]);
  end
  else
    ReportDetail := Format ('%s for all dates.', [ReportDetail]);

   Log('  Start Date - ', datetostr(dtStartDate));
   Log('  End Date - ', datetostr(dtEndDate));
   Log('  ReportDetail - ', ReportDetail);

  lblReportDetail.Caption := ReportDetail;
end;

procedure TPromotionReports.FormShow(Sender: TObject);
begin
  SetStartAndEndDate;
  SetDateFilterMode.Execute;
  LoadSiteNames.Execute;
  LoadPromotionNames.Execute;
  CalcTitles;
  LocaliseForm(self);
end;

procedure TPromotionReports.SetStartAndEndDate;
begin
  dtpDateFilterStart.Date := Now;
  dtpDateFilterEnd.Date := Now;
end;

procedure TPromotionReports.LoadSiteNamesExecute(Sender: TObject);
var
  Items: TStringlist;
begin
  Items := dmPromotions.GetSiteNames;
  Items.Sort;
  cbSiteNames.items.Assign(Items);
  Items.Free;
  cbSiteNames.Items.Insert(0, ALL_SITES);
  cbSiteNames.ItemIndex := 0;
end;

procedure TPromotionReports.LoadPromotionNamesExecute(Sender: TObject);
var
  Items: TStringlist;
begin
  Items := dmPromotions.GetPromotions;
  Items.Sort;
  cbPromotions.items.Assign(Items);
  Items.Free;
  cbPromotions.Items.Insert(0, ALL_PROMOTIONS);
  cbPromotions.ItemIndex := 0;
end;


procedure TPromotionReports.PreviewExecute(Sender: TObject);
begin
  Log('Promotion Reports', 'Preview Button Clicked');
  try
    BuildReportSQL;
    case TReportType (cbReportType.ItemIndex) of
      rtPromotionUsage :
      begin
        ppRepPromotion.Print;
        adoReportTable.Close();
      end;
      rtSiteUsage:
      begin
        ppRepSiteUsage.Print;
        adoReportTable.Close();
      end;
    end;
  finally
    with dmPromotions.adoqRun do
    begin
      SQL.Clear;
      SQL.Add('IF OBJECT_ID(''tempdb..#ReportPreview'') IS NOT NULL DROP TABLE #ReportPreview');
      ExecSQL;
    end;
  end;
end;

procedure TPromotionReports.BlankRepeatingFields;
begin
  //Suppress repeated column text in the report.  SalesArea should not be suppressed due to
  //strange visual effect it can have in the report: most sites name sales areas consistently,
  //but if they do not then sales are names can appear to dangle in the report.  Uncomment
  //the line below to see the effect.
  with adoReportAll do
  begin
    SQL.Clear;
    SQL.Add('UPDATE rp1');
    SQL.Add('SET rp1.SiteName = CASE WHEN rp1.SiteName = rp2.SiteName THEN NULL ELSE rp1.Sitename END,');
    //SQL.Add(' rp1.SalesAreaName = CASE WHEN rp1.SalesAreaName = rp2.SalesAreaName THEN NULL ELSE rp1.SalesAreaName END,');
    SQL.Add(' rp1.Name = CASE WHEN rp1.Name = rp2.Name THEN NULL ELSE rp1.name END,');
    SQL.Add(' rp1.description = CASE WHEN rp1.Description = rp2.Description THEN NULL ELSE rp1.description END,');
    SQL.Add(' rp1.promotypename = CASE WHEN rp1.PromoTypeName = rp2.PromoTypeName THEN NULL ELSE rp1.PromoTypeName END,');
    SQL.Add(' rp1.startdate = CASE WHEN rp1.StartDate = rp2.StartDate THEN NULL ELSE rp1.StartDate END,');
    SQL.Add(' rp1.enddate = CASE WHEN rp1.EndDate = rp2.EndDate THEN NULL ELSE rp1.EndDate END,');
    SQL.Add(' rp1.SiteIndicator = CASE WHEN rp1.SiteIndicator = rp2.SiteIndicator THEN NULL ELSE rp1.SiteIndicator END');
    SQL.Add('FROM #reportpreview rp1');
    SQL.Add('JOIN #reportpreview rp2');
    SQL.Add('ON rp1.Id = rp2.Id + 1');
    SQL.Add('WHERE rp1.Promotionid = rp2.promotionid');
    ExecSQL;
  end;
end;

procedure TPromotionReports.BuildReportSQL;
var
  tmpStr   : String;
  WhereSQL : String;
begin
  with adoReportAll do
  begin
    SQL.Clear;
    SQL.Add('CREATE TABLE #ReportPreview(Id INT IDENTITY(1,1),');
    SQL.Add(' SiteCode INT,');
    SQL.Add(' CreatedBy varchar(25),');
    SQL.Add(' PromotionID BIGINT,');
    SQL.Add(' Name VARCHAR(25),');
    SQL.Add(' Description VARCHAR(256),');
    SQL.Add(' SiteName VARCHAR(20),');
    SQL.Add(' SalesAreaName VARCHAR(20),');
    SQL.Add(' PromoTypeName VARCHAR(50),');
    SQL.Add(' StartDate DATETIME,');
    SQL.Add(' EndDate DATETIME,');
    SQL.Add(' [Exception Name] VARCHAR(50),');
    SQL.Add(' [Exception Description] VARCHAR(255),');
    SQL.Add(' SiteIndicator VARCHAR(1),');
    SQL.Add(' LegendIndicator VARCHAR(1)');
    SQL.Add(' PRIMARY KEY (Id)');
    SQL.Add(')');
    ExecSQL;

    SQL.Clear;
    SQL.Add('INSERT #ReportPreview (SiteCode, CreatedBy, PromotionID, Name, Description, SiteName,SalesAreaName, PromoTypeName, StartDate, EndDate, [Exception Name], [Exception Description], SiteIndicator, LegendIndicator)');
    SQL.Add('SELECT a.SiteCode, case when a.SiteCode = 0 then ''Head Office'' else s.Name end, a.PromotionID, a.name, a.Description, SiteName, SalesAreaName,');
    SQL.Add('  case UserSelectsProducts when 0 then (case when (ExtendedFlag = 1 and a.PromoTypeID = 3) THEN (''Enh. '' + PromoTypeName) ELSE PromoTypeName end) ');
    SQL.Add('    else (case when (ExtendedFlag = 1 and a.PromoTypeID = 3) THEN (''DEAL: Enh. '' + PromoTypeName) ELSE (''DEAL: '' + PromoTypeName) end) ');
    SQL.Add('    end as PromoTypeName,  ');
    SQL.Add('  case a.PromoTypeID when 4 then null else a.StartDate end as StartDate, a.EndDate, e.Name AS [Exception Name], e.Description AS [Exception Description],');
    SQL.Add('  case when a.SiteCode <> 0 then NCHAR(0x2020) else '''' end as SiteIndicator, NCHAR(0x2020) as LegendIndicator');
    if dmPromotions.usePromoDeals then
      SQL.Add('FROM Promotion AS a')
    else
      SQL.Add('FROM (select * from Promotion where UserSelectsProducts = 0) AS a');
    SQL.Add('INNER JOIN PromotionSalesArea AS b ON');
    SQL.Add('  a.PromotionID = b.PromotionID');
    SQL.Add('JOIN (SELECT DISTINCT');
    SQL.Add('  CAST(config.[Sales Area Code] AS SMALLINT) AS SalesAreaID,');
    SQL.Add('  config.[Sales Area Name] AS SalesAreaName,');
    SQL.Add('  config.[Site Name] AS SiteName');
    SQL.Add('  FROM config');
    SQL.Add('  JOIN siteaztec ON config.[site code] = siteaztec.[site code]');
    SQL.Add('  WHERE (config.deleted IS NULL OR config.deleted = ''N'')');
    SQL.Add('  AND config.[Sales Area Code] IS NOT NULL)');
    SQL.Add('c ON b.SalesAreaID = c.SalesAreaID');
    SQL.Add('INNER JOIN PromoType AS d ON');
    SQL.Add(' a.PromoTypeID = d.PromoTypeID');
    SQL.Add('LEFT OUTER JOIN PromotionException AS e ON');
    SQL.Add('  a.PromotionID = e.PromotionID');
    SQL.Add('LEFT JOIN ac_Site s');
    SQL.Add('ON s.Id = a.SiteCode');
    if (PromoFilterStr <> '') or (SiteFilterStr <> '') or (UseDateRange) then
    begin
      WhereSQL := 'WHERE ';
      if PromoFilterStr <> '' then
        WhereSQL := Format ('%s a.Name = %s AND', [WhereSQL, QuotedStr (PromoFilterStr)]);
      if SiteFilterStr <> '' then
        WhereSQL := Format (' %s SiteName = %s AND', [WhereSQL, QuotedStr (SiteFilterStr)]);
      if UseDateRange then
        WhereSQL := Format (' %s a.StartDate >= %s AND (a.EndDate <= %s OR a.EndDate is NULL)', [WhereSQL, GetSQLDate(dtStartDate), GetSQLDate(dtEndDate)]);
      tmpStr := Copy (WhereSQL, Length (WhereSQL)-2, 3);
      if tmpStr = 'AND' then
        System.Delete (WhereSQL, Length (WhereSQL)-2, 3);
      SQL.Add(WhereSQL);
    end;
    SQL.Add('GROUP BY a.Sitecode, s.Name, a.PromotionId, SiteName, a.Name, SalesAreaName, a.Description, d.PromoTypeName, case a.PromoTypeID when 4 then null else a.StartDate end,');
    SQL.Add('  a.EndDate, e.Description, e.Name, ExtendedFlag, a.PromoTypeID, UserSelectsProducts');
    ExecSQL;

    BlankRepeatingFields;
  end;
end;

//procedure TPromotionReports.SetPromoFilter(const Value: String);
//begin
//  if Value = ALL_PROMOTIONS then
//    PromoFilterStr := ''
//  else
//    PromoFilterStr := Value;
//end;

//procedure TPromotionReports.SetSiteFilterStr(const Value: String);
//begin
//  if Value = ALL_SITES then
//    SiteFilterStr := ''
//  else
//    SiteFilterStr := Value;
//end;

procedure TPromotionReports.ChangeReportDetailsExecute(Sender: TObject);
begin
  CalcTitles;
end;

procedure TPromotionReports.HandlePreviewFormCreate(Sender: TObject);
begin
  SetupRBuilderPreview(TppReport(Sender));
  with Sender as TppReport do
  begin
    PreviewForm.Caption := lblReportTitle.Caption;
  end;
end;

procedure TPromotionReports.btCloseClick(Sender: TObject);
begin
  Log('Promotion Reports', 'Cancel Button Clicked');
end;

procedure TPromotionReports.ppDetailBand2BeforePrint(Sender: TObject);
begin
  ppDBTextSiteIndicator.Visible := adoReportTable.FieldByName('SiteCode').AsInteger <> 0;
end;

procedure TPromotionReports.dtpDateFilterStartChange(Sender: TObject);
begin
  Log('  Start Date Changed ', DateToStr(dtpDateFilterStart.Date));
  dtStartDate := dtpDateFilterStart.Date;
end;

procedure TPromotionReports.dtpDateFilterEndChange(Sender: TObject);
begin
  Log('  End Date Changed ', DateToStr(dtpDateFilterEnd.Date));
  dtEndDate := dtpDateFilterEnd.Date;
end;

end.




