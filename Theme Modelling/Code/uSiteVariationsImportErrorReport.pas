unit uSiteVariationsImportErrorReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, DB, ADODB, QRCtrls, ExtCtrls;

type
  TSiteVariationsImportErrorReport = class(TForm)
    ColumnValueErrors: TQuickRep;
    QRBand1: TQRBand;
    QRShape2: TQRShape;
    QRShape1: TQRShape;
    HeaderShape: TQRShape;
    QRLabel13: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel11: TQRLabel;
    QRDBText6: TQRDBText;
    QRLabel9: TQRLabel;
    QRLabel8: TQRLabel;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRBand2: TQRBand;
    QRShape3: TQRShape;
    QRDBText1: TQRDBText;
    QRShape4: TQRShape;
    QRDBText2: TQRDBText;
    qSiteDetails: TADOQuery;
    QRCompositeReport1: TQRCompositeReport;
    QRLabel3: TQRLabel;
    SitesWithErrors: TQuickRep;
    QRBand3: TQRBand;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRBand4: TQRBand;
    QRShape8: TQRShape;
    QRDBText4: TQRDBText;
    QRShape9: TQRShape;
    QRDBText5: TQRDBText;
    qUnrecognisedColumns: TADOQuery;
    qSitesWithErrors: TADOQuery;
    procedure QRCompositeReport1AddReports(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PreviewReport;
  end;

implementation

{$R *.dfm}

procedure TSiteVariationsImportErrorReport.PreviewReport;
begin
  qSiteDetails.Open;
  qUnrecognisedColumns.Open;
  qSitesWithErrors.Open;
  try
    if (qUnrecognisedColumns.recordcount + qSitesWithErrors.recordcount) = 0 then
      Messagedlg('No data to report!', mtInformation, [mbOk], 0)
    else
    begin
      QRCompositeReport1.Preview;
    end;
  finally
    qUnrecognisedColumns.close;
    qSitesWithErrors.close;
    qSiteDetails.Close
  end;
end;

procedure TSiteVariationsImportErrorReport.QRCompositeReport1AddReports(
  Sender: TObject);
begin
  QRCompositeReport1.Reports.Add(ColumnValueErrors);
  QRCompositeReport1.Reports.Add(SitesWithErrors);
end;

end.
