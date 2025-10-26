unit uPromotionSummary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Wwdbigrd, Wwdbgrid, DB, ADODB, StdCtrls, wwcheckbox,
  ExtCtrls, DBCtrls, ComCtrls, ppCtrls, ppPrnabl, ppClass, ppDB, ppBands,
  ppCache, ppProd, ppReport, ppComm, ppRelatv, ppDBPipe, ppStrtch, ppMemo,
  ppRegion, ppSubRpt, DBGrids;

const
  PRODUCTS_LINEHEIGHT = 17;
  MAX_PRODUCTS_IN_VIEW = 16;

type       
  TPromotionSummary = class(TForm)
    dsSalesAreas: TDataSource;
    qSalesAreas: TADOQuery;
    qSalesAreasSalesAreaID: TSmallintField;
    qSalesAreasExpandSA: TBooleanField;
    qSalesAreasSalesAreaName: TStringField;
    Label1: TLabel;
    qExceptions: TADOQuery;
    qSalesAreassiteid: TSmallintField;
    dsExceptions: TDataSource;
    qPromotionDetails: TADOQuery;
    dsPromotionDetails: TDataSource;
    qPromotionDetailsName: TStringField;
    qPromotionDetailsDescription: TStringField;
    qPromotionDetailsPromoTypeName: TStringField;
    qPromotionDetailsStartDate: TDateTimeField;
    qPromotionDetailsEndDate: TDateTimeField;
    qPromotionDetailsFavourCustomerOrCompany: TStringField;
    qPromotionDetailsStatus: TStringField;
    qPromotionDetailsGlobalRewardPrice: TBCDField;
    btnClose: TButton;
    Panel5: TPanel;
    Label18: TLabel;
    Bevel3: TBevel;
    imLogo: TImage;
    Label19: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    Label5: TLabel;
    DBText4: TDBText;
    Label6: TLabel;
    DBText5: TDBText;
    lbRewardPrice: TLabel;
    dbtRewardPrice: TDBText;
    lbSiteRewardPrice: TLabel;
    dbtSiteRewardPrice: TDBText;
    qSiteRewardPrice: TADOQuery;
    dsSiteRewardPrice: TDataSource;
    qSiteRewardPriceRewardPrice: TBCDField;
    qExceptionsStartDate: TDateTimeField;
    qExceptionsEndDate: TDateTimeField;
    tvPromotionSummary: TTreeView;
    qPromotionDetailsPromoTypeID: TSmallintField;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    DBText7: TDBText;
    DBText6: TDBText;
    GroupBox2: TGroupBox;
    DBText17: TDBText;
    DBText16: TDBText;
    btnPrint: TButton;
    ppDBPipelinePromotion: TppDBPipeline;
    ppPromotionSummary: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppShape1: TppShape;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppDBTextPromoName: TppDBText;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppDBTextPromoType: TppDBText;
    ppRegion1: TppRegion;
    ppRegion2: TppRegion;
    ppDBMemoDescription: TppDBMemo;
    ppLabel5: TppLabel;
    ppDBTextFavour: TppDBText;
    ppLabel6: TppLabel;
    ppDBTextStatus: TppDBText;
    ppLabelRewardPrice: TppLabel;
    ppDBTextRewardPrice: TppDBText;
    ppRegion3: TppRegion;
    ppLabel10: TppLabel;
    ppDBText3: TppDBText;
    ppLabel11: TppLabel;
    ppDBText4: TppDBText;
    ppLabel12: TppLabel;
    ppMemoValidDaysTimes: TppMemo;
    ppMemoBufferSpace: TppMemo;
    qExceptionsForReport: TADODataSet;
    dsExceptionsForReport: TDataSource;
    ppDBPipelineExceptions: TppDBPipeline;
    qExceptionsForReportSiteName: TStringField;
    qExceptionsForReportSalesAreaName: TStringField;
    qExceptionsForReportSalesAreaID: TSmallintField;
    qExceptionsForReportStartDate: TDateTimeField;
    qExceptionsForReportEndDate: TDateTimeField;
    qExceptionsForReportValidDays: TStringField;
    qExceptionsForReportStartTime: TDateTimeField;
    qExceptionsForReportEndTime: TDateTimeField;
    qExceptionsForReportValidDaysDisplay: TStringField;
    ppLabel9: TppLabel;
    ppRegion4: TppRegion;
    ppTitleBand1: TppTitleBand;
    qPromoPricesForReport: TADODataSet;
    dsPromoPricesForReport: TDataSource;
    qPromoPricesForReportGroupName: TStringField;
    qPromoPricesForReportExtendedRTLName: TStringField;
    qPromoPricesForReportPortionName: TStringField;
    qPromoPricesForReportPrice: TBCDField;
    qPromoPricesForReportSiteAndSalesAreaName: TStringField;
    ppDBPipelinePromotionPrices: TppDBPipeline;
    ppSubReportPromotionPrices: TppSubReport;
    ppChildReport2: TppChildReport;
    ppDetailBand3: TppDetailBand;
    ppDBText13: TppDBText;
    ppDBText9: TppDBText;
    ppDBTextPrice: TppDBText;
    ppLine30: TppLine;
    ppLine31: TppLine;
    ppLine32: TppLine;
    ppLine33: TppLine;
    ppLine34: TppLine;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppShape4: TppShape;
    DBTextSiteSalesArea: TppDBText;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppLine3: TppLine;
    ppLabelContinued1: TppLabel;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppSubReportExceptionOverrides: TppSubReport;
    ppChildReport1: TppChildReport;
    ppTitleBand2: TppTitleBand;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppLabel19: TppLabel;
    ppLine1: TppLine;
    ppShape2: TppShape;
    ppLabel20: TppLabel;
    ppLine4: TppLine;
    ppLine13: TppLine;
    ppLine14: TppLine;
    ppLine15: TppLine;
    ppLine16: TppLine;
    ppLine17: TppLine;
    ppLine18: TppLine;
    ppLine19: TppLine;
    ppLine20: TppLine;
    ppDetailBand2: TppDetailBand;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBTextValidDays: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppLine2: TppLine;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLine7: TppLine;
    ppLine8: TppLine;
    ppLine9: TppLine;
    ppLine10: TppLine;
    ppLine11: TppLine;
    ppLine12: TppLine;
    ppDBText8: TppDBText;
    ppSummaryBand2: TppSummaryBand;
    ppLine21: TppLine;
    DBTextSalesGroup1: TppDBText;
    ppLabelContinued2: TppLabel;
    ppLine35: TppLine;
    ppLine36: TppLine;
    ppLabel26: TppLabel;
    ppLine38: TppLine;
    ppLine39: TppLine;
    ppLine40: TppLine;
    ppLabel27: TppLabel;
    ppLabel28: TppLabel;
    ppLine41: TppLine;
    ppLabel29: TppLabel;
    ppTitleBand3: TppTitleBand;
    ppHeaderBand2: TppHeaderBand;
    qSaRewardPricesForReport: TADODataSet;
    dsSaRewardPricesForReport: TDataSource;
    ppDBPipelineSaRewardPrices: TppDBPipeline;
    SubReportSaRewardPrices: TppSubReport;
    ppChildReport3: TppChildReport;
    ppTitleBand4: TppTitleBand;
    ppDetailBand4: TppDetailBand;
    ppSummaryBand1: TppSummaryBand;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLine22: TppLine;
    ppShape3: TppShape;
    ppLabel30: TppLabel;
    ppLine23: TppLine;
    ppLine24: TppLine;
    ppLine27: TppLine;
    ppLine42: TppLine;
    ppLine25: TppLine;
    ppLabel21: TppLabel;
    ppLine26: TppLine;
    ppDBText1: TppDBText;
    ppLine28: TppLine;
    ppDBText2: TppDBText;
    ppLine29: TppLine;
    ppLine37: TppLine;
    ppLine43: TppLine;
    ppLine44: TppLine;
    ppDBText12: TppDBText;
    qSaRewardPricesForReportSiteName: TStringField;
    qSaRewardPricesForReportSalesAreaName: TStringField;
    qSaRewardPricesForReportRewardPrice: TBCDField;
    qValidTimes: TADODataSet;
    dsValidTimes: TDataSource;
    DBGridValidTimes: TDBGrid;
    qValidTimesValidDays: TStringField;
    qValidTimesStartTime: TDateTimeField;
    qValidTimesEndTime: TDateTimeField;
    qValidTimesValidDaysDisplay: TStringField;
    qValidTimesValidTimesDisplay: TStringField;
    DBGridExceptionTimes: TDBGrid;
    qExceptionValidTimes: TADODataSet;
    StringField1: TStringField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    StringField2: TStringField;
    StringField3: TStringField;
    dsExceptionValidTimes: TDataSource;
    qExceptionValidTimesSalesAreaId: TSmallintField;
    ppDBPipelineExceptionsppField9: TppField;
    ppGroupExceptionsSalesAreaId: TppGroup;
    ppGroupHeaderBand3: TppGroupHeaderBand;
    ppGroupFooterBand3: TppGroupFooterBand;
    lblSumCardActivated: TLabel;
    lblValidation: TLabel;
    lblValidType: TLabel;
    qPromotionDetailsCardActivated: TBooleanField;
    qPromotionDetailsDisplayString: TStringField;
    ppLabelCardActivated: TppLabel;
    ppLabelValidation: TppLabel;
    ppDBTextValidType: TppDBText;
    qPromotionDetailsSiteCode: TIntegerField;
    qPromotionDetailsPromotionID: TLargeintField;
    qSalesAreasPromotionID: TLargeintField;
    qPromotionDetailsExtendedFlag: TBooleanField;
    qPromotionDetailsUserSelectsProducts: TBooleanField;
    lblPromoDeal: TLabel;
    ppLblPromoDeal: TppLabel;
    procedure ValidDaysCalcFields(DataSet: TDataSet);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tvPromotionSummaryGetSelectedIndex(Sender: TObject;
      Node: TTreeNode);
    procedure tvPromotionSummaryExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure GetText_BlankToNA(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure btnPrintClick(Sender: TObject);
    procedure ppDBText4GetText(Sender: TObject; var Text: String);
    procedure ppLabelContinued1Print(Sender: TObject);
    procedure DBTextSalesGroupPrint(Sender: TObject);
    procedure ppDBTextPriceGetText(Sender: TObject; var Text: String);
    procedure ppPromotionSummaryPreviewFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure ShowPreview(PromotionID: Int64);
  end;

implementation

uses useful, udmPromotions, math, uSimpleLocalise, uPromoCommon, ppPrintr,
  uSetupRBuilderPreview, comobj;

{$R *.dfm}

procedure TPromotionSummary.ValidDaysCalcFields(DataSet: TDataSet);
var ValidTimesDisplay: TField;
begin
  with DataSet do
  begin
    FieldByName('ValidDaysDisplay').AsString := ValidDaysDisplay(FieldByName('ValidDays').AsString);

    ValidTimesDisplay := FindField('ValidTimesDisplay');
    if ValidTimesDisplay <> nil then
    begin
      ValidTimesDisplay.AsString := FormatDateTime('hh:mm', FieldByName('StartTime').Value) + '-' +
                                 FormatDateTime('hh:mm', FieldByName('EndTime').Value);
    end;
  end;
end;

procedure TPromotionSummary.btnCloseClick(Sender: TObject);
begin
  Close;
end;

class procedure TPromotionSummary.ShowPreview(PromotionID: Int64);
var
  CurrentSalesArea: integer;
  GroupParentNode: TTreeNode;
  GroupQuantityStr: string;
  PromoType: integer;
  LoadPromotionDataSQL: String;
begin
  dmPromotions.BeginHourglass;
  with TPromotionSummary.Create(nil) do try
    with dmPromotions do
    begin
      LoadPromotionDataSQL := GetStringResource('LoadPromotionData', 'TEXT');
      LoadPromotionDataSQL := StringReplace(LoadPromotionDataSQL, '@PromotionID', IntToStr(PromotionID), [rfReplaceAll, rfIgnoreCase]);
      LoadPromotionDataSQL := StringReplace(LoadPromotionDataSQL, '@SiteCode', '-1', [rfReplaceAll, rfIgnoreCase]);
      adoqRun.SQL.Text := LoadPromotionDataSQL;

      adoqrun.ExecSQL;

      // vk fill tmp tables needed to sp_DelayTariffPrices
      adoqrun.SQL.Text :=
        'if OBJECT_ID(''tempdb..##PromoProductSelection'') is not null drop table ##PromoProductSelection ';
      adoqrun.ExecSQL;

      adoqrun.SQL.Text := 'Select * into ##PromoProductSelection from #PromotionSaleGroupDetail';
      adoqrun.ExecSQL;
      //
      adoqrun.SQL.Text :=
        'if OBJECT_ID(''tempdb..##PromoSASelection'') is not null drop table ##PromoSASelection ';
      adoqrun.ExecSQL;

      adoqrun.SQL.Text := 'Select * into ##PromoSASelection from #PromotionSalesArea';
      adoqrun.ExecSQL;

      // vk call tariff thread
      dmPromotions.GetDelayTariffPricesThread.Execute;
      dmPromotions.AwaitPreload(pwTarrifPrices);

      adoqRun.SQL.Text := StringReplace(GetStringResource('LoadPromotionPrices', 'TEXT'), '<PromotionId>', IntToStr(PromotionID), [rfReplaceAll, rfIgnoreCase]);
      try
        adoqrun.ExecSQL;
      except on E:EOLEException do
        if Pos('duplicate key was ignored', LowerCase(E.Message)) = 0 then
          raise;
      end;
    end;
    GroupParentNode := nil;

    with dmPromotions.adoqRun do
    begin
      SQL.Text := Format(
        'select PromoTypeID from Promotion where PromotionID = %d', [PromotionID]);
      Open;
      PromoType := FieldByName('PromoTypeID').AsInteger;

      SQL.Text :=
        'select sub.[Site Code] as SiteID, sub.[Sales Area Code] as SalesAreaID, '+
        '  [Site Ref] + '' '' as SiteRef, '+
        '  isnull(a.Name,  ''Group ''+cast(SaleGroupID as varchar(50))) as GroupName, '+
        '  sub.[Site Name] as SiteName, sub.[Sales Area Name] as SalesAreaName, SaleGroupID, Quantity '+
        'from #PromotionSaleGroup a, #PromotionSalesArea b '+
        'join ( '+
        '  select distinct [Site Code], [Sales Area Code], [Site Name], [Sales Area Name] '+
        '  from config where (Deleted is null or Deleted = ''N'') '+
        '  and [Site Code] is not null and [Sales Area Code] is not null '+
        ') sub on b.SalesAreaID = sub.[Sales Area Code] '+
        'join SiteAztec c on sub.[site code] = c.[Site Code] '+
        'order by [Site Ref], sub.[Site Name], sub.[Sales Area Name], SaleGroupID';
      Open;
      First;
      CurrentSalesArea := -1;
      while not EOF do
      begin
        if CurrentSalesArea <> FieldByName('SalesAreaID').AsInteger then
        begin
          GroupParentNode := tvPromotionSummary.Items.AddChildObject(
            nil,
            Format('%s / %s', [FieldByName('SiteName').AsString, FieldByName('SalesAreaName').AsString]),
            TObject(FieldByName('SalesAreaID').Asinteger)
          );
          CurrentSalesArea := FieldByName('SalesAreaID').AsInteger;
        end;
        if PromoType = 4 then
          GroupQuantityStr := ''
        else
          GroupQuantityStr := Format(', Sale Quantity %d', [FieldByName('Quantity').AsInteger]);

        tvPromotionSummary.Items.AddChildObject(
          GroupParentNode,
          FieldByName('GroupName').AsString + GroupQuantityStr,
          TObject(FieldByName('SaleGroupID').AsInteger)
        ).HasChildren := True;
        Next;
      end;
      Close;
    end;

    qSalesAreas.Parameters.ParamByName('PromotionID').Value := PromotionID;
    dmPromotions.EndHourglass;
    ShowModal;
  finally
    Release;
    with dmPromotions do
    begin
      adoqRun.SQL.Text := GetStringResource('DropPromotionData', 'TEXT');
      adoqrun.ExecSQL;
    end;
  end;
end;

procedure TPromotionSummary.FormShow(Sender: TObject);
begin
  uSimpleLocalise.LocaliseForm(self);
  qPromotionDetails.Open;
  qValidTimes.Open;
  qSalesAreas.Open;
  qExceptions.Open;
  qExceptionValidTimes.Open;
  qSiteRewardPrice.Open;
  if qPromotionDetails.FieldByName('PromoTypeID').AsInteger <> 2 then
  begin
    // Not a multi buy - hide "per promotion price"
    lbRewardPrice.Visible := false;
    dbtRewardPrice.Visible := false;
    lbSiteRewardPrice.Visible := false;
    dbtSiteRewardPrice.Visible := false;
  end
  else
  begin
    if qSiteRewardPrice.RecordCount > 0 then
    begin
      // There are site reward prices defined, hide the global setting
      lbSiteRewardPrice.Top  := lbRewardPrice.Top;
      dbtSiteRewardPrice.Top := dbtRewardPrice.Top;
      lbRewardPrice.Visible := false;
      dbtRewardPrice.Visible := false;
    end
    else
    begin
      // No per site prices, hide the per site setting
      lbSiteRewardPrice.Visible := false;
      dbtSiteRewardPrice.Visible := false;
    end;
  end;
  lblSumCardActivated.Visible := qPromotionDetailsCardActivated.Value;
  lblValidation.Visible := qPromotionDetailsCardActivated.Value;
  lblValidType.Visible := qPromotionDetailsCardActivated.Value;
  lblValidType.Caption := qPromotionDetailsDisplayString.Value;
  lblPromoDeal.Visible := qPromotionDetailsUserSelectsProducts.AsBoolean;
end;

procedure TPromotionSummary.FormHide(Sender: TObject);
begin
  qSiteRewardPrice.Close;
  qExceptionValidTimes.Close;
  qExceptions.Close;
  qSalesAreas.Close;
  qValidTimes.Close;
  qPromotionDetails.Close;
end;

procedure TPromotionSummary.FormCreate(Sender: TObject);
begin
  imLogo.Picture.Bitmap.LoadFromResourceName(HInstance, 'ZonalZWhiteBk50x50');
end;

procedure TPromotionSummary.tvPromotionSummaryGetSelectedIndex(
  Sender: TObject; Node: TTreeNode);
var
  SalesAreaID: integer;
begin
  if node = TTreeView(Sender).Selected then
  begin
    while node.Parent <> nil do
      node := node.parent;
    SalesAreaID := Integer(node.data);
    if qSalesAreas.FieldByName('SalesAreaID').AsInteger <> SalesAreaID then
      qSalesAreas.Locate('SalesAreaID', SalesAreaID, []);
  end;
end;

procedure TPromotionSummary.tvPromotionSummaryExpanding(Sender: TObject;
  Node: TTreeNode; var AllowExpansion: Boolean);
var
  SalesAreaID, SaleGroupID: integer;
begin
  if (Node.Level = 1) and Node.HasChildren and (Node.getFirstChild = nil) then
  begin
    AllowExpansion := True;
    with dmPromotions.adoqRun do
    begin
      if qPromotionDetails.FieldByName('PromoTypeID').AsInteger <> 2 then
      begin
        SaleGroupID := Integer(node.data);
        SalesAreaID := Integer(node.parent.data);
        SQL.Text :=
          Format(
            'select b.[extended rtl name] as ProductName, c.PortionTypeName as PortionType, Price '+
            'from #PromotionPrices a '+
            'join products b on productid = entitycode '+
            'join portiontype c on a.portiontypeid = c.portiontypeid '+
            'where a.SalesAreaID = %d and a.SaleGroupID = %d '+
            'order by ProductName, PortionType',
            [SalesAreaID, SaleGroupID]
          );
      end
      else
      begin
        SaleGroupID := Integer(node.data);
        SQL.Text :=
          Format(
            'select b.[extended rtl name] as ProductName, c.PortionTypeName as PortionType, null as Price '+
            'from #PromotionSaleGroupDetail a '+
            'join products b on productid = entitycode '+
            'join portiontype c on a.portiontypeid = c.portiontypeid '+
            'where a.SaleGroupID = %d '+
            'order by ProductName, PortionType', [SaleGroupID]
          );
      end;
      Open;
      First;
      while not EOF do
      begin
        if FieldByName('Price').IsNull then
          tvPromotionSummary.Items.AddChild(Node, Format('%s (%s)', [FieldByName('ProductName').AsString, FieldByName('PortionType').AsString]))
        else
          tvPromotionSummary.Items.AddChild(Node, Format('%s (%s): %s', [FieldByName('ProductName').AsString, FieldByName('PortionType').AsString, CurrToStrF (FieldByName('Price').asCurrency, ffCurrency, CurrencyDecimals)]));
        Next;
      end;
      Close;
    end;
  end;
end;

procedure TPromotionSummary.GetText_BlankToNA(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if Length(Sender.AsString) = 0 then
    Text := 'n/a'
  else
  begin
    if Sender is TBCDField then
      Text := CurrToStrF(Sender.AsCurrency, ffCurrency, CurrencyDecimals)
    else
    if Sender is TDateTimeField then
      Text := FormatDateTime(TDateTimeField(Sender).DisplayFormat, Sender.AsDateTime)
    else
      Text := Sender.AsString;
  end;
end;


procedure TPromotionSummary.btnPrintClick(Sender: TObject);
begin
  try
    qExceptionsForReport.Open;
    qPromoPricesForReport.Open;

    //Hide the "Reward Price" in the header section of the report if the promotion is not a multi-buy or
    //it is a multi-buy but there are per-site reward prices.
    if (qPromotionDetails.FieldByName('PromoTypeID').AsInteger <> 2) or  //2 = multi-buy
       (qSiteRewardPrice.RecordCount > 0) then
    begin
      ppLabelRewardPrice.Visible := False;
      ppDBTextRewardPrice.Visible := False;
    end;

    ppLabelCardActivated.Visible := qPromotionDetailsCardActivated.Value;
    ppLabelValidation.Visible := qPromotionDetailsCardActivated.Value;
    ppDBTextValidType.Visible := qPromotionDetailsCardActivated.Value;
    pplblPromoDeal.Visible := qPromotionDetailsUserSelectsProducts.AsBoolean;

    with ppMemoValidDaysTimes do
    begin
      Lines.Clear;

      qValidTimes.First;
      while not(qValidTimes.Eof) do
      begin
        Lines.Add(Format('%-19s %s', [qValidTimesValidDaysDisplay.AsString, qValidTimesValidTimesDisplay.AsString]));
        qValidTimes.Next;
      end;
      //This final blank line is required to stop the previous line from extending too far on the printed output.
      //This only happens when there is one data line to display - No idea why.
      Lines.Add(' ');
    end;

    ppPromotionSummary.Print;
  finally
    qPromoPricesForReport.Close;
    qExceptionsForReport.Close;
  end;
end;

procedure TPromotionSummary.ppDBText4GetText(Sender: TObject; var Text: String);
begin
  if Text = '' then Text := 'End of time';
end;

procedure TPromotionSummary.ppLabelContinued1Print(Sender: TObject);
begin
  ppLabelContinued1.Visible := not(ppSubReportPromotionPrices.Report.Groups[0].FirstPage);
end;

procedure TPromotionSummary.DBTextSalesGroupPrint(Sender: TObject);
begin
  ppLabelContinued2.Visible := not(ppSubReportPromotionPrices.Report.Groups[1].FirstPage);
end;

procedure TPromotionSummary.ppDBTextPriceGetText(Sender: TObject; var Text: String);
begin
  if qPromotionDetailsPromoTypeID.Value = 2 then
    Text := 'n/a';
end;

procedure TPromotionSummary.ppPromotionSummaryPreviewFormCreate(Sender: TObject);
begin
  SetupRBuilderPreview(TppReport(Sender));
  with ppPromotionSummary.PreviewForm do
  begin
    Caption := 'Promotion Summary';
  end;
end;

end.

