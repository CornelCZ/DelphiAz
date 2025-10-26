program OsViewer;

uses
  Forms,
  FrmOsViewerMainU in 'FrmOsViewerMainU.pas' {FrmOsViewerMain},
  FrmNewHostU in 'FrmNewHostU.pas' {FrmNewHost},
  FrmAboutU in 'FrmAboutU.pas' {FrmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmOsViewerMain, FrmOsViewerMain);
  Application.Run;
end.
