unit uSetupRBuilderPreview;

interface

uses ppReport;

procedure SetupRBuilderPreview(Report: TppReport);

implementation

uses ppPrintr, Forms, ppViewr;

procedure SetupRBuilderPreview(Report: TppReport);
var
  Viewer: TppViewer;
begin
  if not Assigned(ppPrinters.PrinterInfo[ppPrinters.GetSystemDefaultPrinterName]) then
  begin
    ppPrinters.Refresh;
  end;
  with Report.PreviewForm do
  begin
    
    WindowState := wsMaximized;
  end;
  Viewer := TppViewer(Report.PreviewForm.Viewer);
  Viewer.ZoomSetting := zs100Percent;
  Viewer.FirstPage;
end;

end.
 