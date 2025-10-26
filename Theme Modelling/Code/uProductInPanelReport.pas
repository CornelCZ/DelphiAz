unit uProductInPanelReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, ADODB;

type
  TProductInPanelReport = class(TForm)
    qSiteDetails: TADOQuery;
    qLocalPanels: TADOQuery;
    LocalPanelResults: TQuickRep;
    QRBand1: TQRBand;
    HeaderRect: TQRShape;
    QRLabel13: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel8: TQRLabel;
    QRExpr7: TQRExpr;
    QRExpr8: TQRExpr;
    qSharedPanels: TADOQuery;
    QRLabel2: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel1: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel3: TQRLabel;
    lbLocalPanelData: TQRDBText;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    lbLocalPanelOccurences: TQRLabel;
    lbLocalPanelOccurencesData: TQRDBText;
    QRLabel4: TQRLabel;
    QRDBText7: TQRDBText;
    QRLabel10: TQRLabel;
    QRDBText5: TQRDBText;
    VariationPanelResults: TQuickRep;
    lbSharedPanelOrVariationGroup: TQRLabel;
    lbSharedPanelData: TQRDBText;
    QRLabel15: TQRLabel;
    QRDBText9: TQRDBText;
    QRLabel17: TQRLabel;
    QRDBText11: TQRDBText;
    QRCompositeReport1: TQRCompositeReport;
    QRLabel14: TQRLabel;
    lbProductName: TQRLabel;
    qVariationPanels: TADOQuery;
    QRGroup7: TQRGroup;
    QRLabel7: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel16: TQRLabel;
    QRDBText4: TQRDBText;
    SharedPanelResults: TQuickRep;
    QRGroup10: TQRGroup;
    lbSharedPanel: TQRLabel;
    lbSharedPanelData2: TQRDBText;
    QRLabel30: TQRLabel;
    QRDBText14: TQRDBText;
    QRGroup11: TQRGroup;
    QRLabel31: TQRLabel;
    QRDBText15: TQRDBText;
    QRLabel32: TQRLabel;
    QRDBText16: TQRDBText;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    procedure QRGroup4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRCompositeReport1AddReports(Sender: TObject);
    procedure HandleBandBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup6BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRCompositeReport1Finished(Sender: TObject);
    procedure QRGroup3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    procedure SetParams;
  public
    { Public declarations }
    ProductID: int64;
    procedure PreviewReport;
  end;

var
  ProductInPanelReport: TProductInPanelReport;

implementation

uses uADO;

{$R *.dfm}

procedure TProductInPanelReport.PreviewReport;
begin
  SetParams;
  qsitedetails.Open;
  qlocalpanels.Open;
  qsharedpanels.open;
  qVariationPanels.Open;
  try
    if (qlocalpanels.RecordCount + qsharedpanels.RecordCount + qVariationPanels.RecordCount) = 0 then
      Messagedlg('No data to report!', mtInformation, [mbOk], 0)
    else
    begin
      QRCompositeReport1.Preview;
    end;
  finally
    qsitedetails.close;
    qlocalpanels.close;
    qsharedpanels.close;
    qVariationPanels.close;
  end;
end;

procedure TProductInPanelReport.QRGroup4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  printband := not LocalPanelResults.DataSet.FieldByName('SubPanel').IsNull;
end;

procedure TProductInPanelReport.QRCompositeReport1AddReports(
  Sender: TObject);
begin
  QRCompositeReport1.Reports.Add(LocalPanelResults);
  QRCompositeReport1.Reports.Add(SharedPanelResults);
  QRCompositeReport1.Reports.Add(VariationPanelResults);
end;

procedure TProductInPanelReport.HandleBandBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  i: integer;
  NoOccurences, MultipleOccurences: boolean;
begin
  // Band-dependent rules for if the band should print
  if Sender.Tag = 1 then
    PrintBand := not TQuickRep(Sender.ParentReport).DataSet.FieldByName('SubPanel').IsNull;

  // boldface controls with tags of 1 if atleast 1 occurence
  // hide those with tags of 2 if 0 or 1 occurence
  NoOccurences := TQuickRep(Sender.ParentReport).DataSet.FieldByName('Occurences').AsInteger < 1;
  MultipleOccurences := TQuickRep(Sender.ParentReport).DataSet.FieldByName('Occurences').AsInteger > 1;
  begin
    for i := 0 to Pred(Sender.ControlCount) do
    begin
      if Sender.Controls[i].Tag = 1 then
      begin
        if Sender.Controls[i] is TQRLabel then
        begin
          if NoOccurences then
            TQRLabel(Sender.Controls[i]).Font.Style := []
          else
            TQRLabel(Sender.Controls[i]).Font.Style := [fsBold];
        end
        else
        if Sender.Controls[i] is TQRDBText then
        begin
          if NoOccurences then
            TQRDBText(Sender.Controls[i]).Font.Style := []
          else
            TQRDBText(Sender.Controls[i]).Font.Style := [fsBold];
        end;
      end
      else
      if Sender.Controls[i].Tag = 2 then
      begin
        if Sender.Controls[i] is TQRLabel then
          TQRLabel(Sender.Controls[i]).Enabled := MultipleOccurences
        else
        if Sender.Controls[i] is TQRDBText then
          TQRDBText(Sender.Controls[i]).Enabled := MultipleOccurences;
      end;
    end;
  end;
end;

procedure TProductInPanelReport.QRGroup6BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  printband := not SharedPanelResults.DataSet.FieldByName('Variation').IsNull;
end;

procedure TProductInPanelReport.SetParams;
begin
  with dmAdo.adoqrun do
  begin
    SQL.Text := Format(
      'select [extended rtl name] as Name, ''(''+[retail description]+'')'' as Description from products where [entitycode] = %d',
      [ProductID]
    );
    Open;
    lbProductName.Caption := Format('%s %s', [
      QuotedStr(FieldByName('Name').AsString), FieldByName('Description').AsString]
    );
    Close;
    qLocalPanels.Parameters.ParamByName('ProductID').Value := ProductID;
    qSharedPanels.Parameters.ParamByName('ProductID').Value := ProductID;
    qVariationPanels.Parameters.ParamByName('ProductID').Value := ProductID;
  end;
end;

procedure TProductInPanelReport.QRCompositeReport1Finished(
  Sender: TObject);
begin
  Screen.Cursor := crDefault;
end;

procedure TProductInPanelReport.QRGroup3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if LocalPanelResults.DataSet.FieldByName('Occurences').AsInteger = 0 then
  begin
    lbLocalPanelOccurences.Enabled := False;
    lbLocalPanelOccurencesData.Enabled := False;
    lbLocalPanelData.Font.Style := [];
  end
  else
  begin
    lbLocalPanelOccurences.Enabled := True;
    lbLocalPanelOccurencesData.Enabled := True;
    lbLocalPanelData.Font.Style := [fsBold];
  end;
end;

end.
