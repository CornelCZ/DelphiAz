unit uSiteVariationsImportErrors;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TSiteVariationsImportErrors = class(TForm)
    Label1: TLabel;
    btnDetails: TButton;
    btnOk: TButton;
    procedure btnDetailsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMThemeData, uSiteVariationsImportErrorReport, useful;

{$R *.dfm}

procedure TSiteVariationsImportErrors.btnDetailsClick(Sender: TObject);
begin
  dmThemeData.adocRun.CommandText :=
     'IF object_id(''tempdb..#SiteVariations_ImportFailedCells'') IS NOT NULL DROP TABLE #SiteVariations_ImportFailedCells ' +
     'IF object_id(''tempdb..#SiteVariations_ImportFailedSites'') IS NOT NULL DROP TABLE #SiteVariations_ImportFailedSites ' +

     'CREATE TABLE #SiteVariations_ImportFailedCells (ColumnID int, ColumnName varchar(50), ColumnValue varchar(50)) ' +
     'CREATE TABLE #SiteVariations_ImportFailedSites (SiteCode int) ' +

     'INSERT #SiteVariations_ImportFailedCells ' +
     'SELECT DISTINCT ColumnId, Name, VariationPanelName ' +
     'FROM #ImportErrors ' +

     'INSERT #SiteVariations_ImportFailedSites ' +
     'SELECT DISTINCT SiteCode '+
     'FROM #ImportErrors ';
  dmThemeData.adocRun.Execute;

  with TSiteVariationsImportErrorReport.Create(nil) do
  begin
    PreviewReport;
    Free;
  end;
end;

end.
