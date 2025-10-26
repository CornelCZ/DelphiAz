unit uSitePriceReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, QRCtrls, ExtCtrls, DB, ADODB, uado;

type
  TSitePriceReport = class(TForm)
    Report: TQuickRep;
    QRBand1: TQRBand;
    QRShape1: TQRShape;
    QRLabel13: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel11: TQRLabel;
    QRDBText6: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText4: TQRDBText;
    QRLabel9: TQRLabel;
    QRLabel8: TQRLabel;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    SessionData: TQRBand;
    qSiteDetails: TADOQuery;
    qPriceHistory: TADOQuery;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRBand2: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    procedure QRExpr8Print(sender: TObject; var Value: String);
    procedure QRExpr7Print(sender: TObject; var Value: String);
  private
    { Private declarations }
  public
    { Public declarations }
    SiteCode: integer;
    FromDate: TDateTime;
    ToDate: TDateTime;
    ByProduct: boolean;
    procedure PreviewReport;
  end;


var
  SitePriceReport: TSitePriceReport;

implementation

{$R *.dfm}

procedure TSitePriceReport.PreviewReport;
begin
  qsitedetails.Parameters.ParamByName('sitecode').value := sitecode;
  qsitedetails.Open;
  qpricehistory.Parameters.ParamByName('sitecode').value := sitecode;
  qpricehistory.Parameters.ParamByName('fromdate').value := trunc(fromdate);
  qpricehistory.Parameters.ParamByName('todate').value := trunc(todate) + 1;
  qpricehistory.Parameters.ParamByName('byproduct').value := ByProduct;
  qpricehistory.open;
  try
    if qpricehistory.recordcount = 0 then
      messagedlg('No data to report!', mtInformation, [mbOk], 0)
    else
      report.Previewmodal;
  finally
    qsitedetails.close;
    qpricehistory.close;
  end;

end;

procedure TSitePriceReport.QRExpr8Print(sender: TObject;
  var Value: String);
begin
  value := datetimetostr(now);
end;

procedure TSitePriceReport.QRExpr7Print(sender: TObject;
  var Value: String);
begin
  value := format('From %s to %s', [datetostr(fromdate), datetostr(todate)]);
end;

end.
