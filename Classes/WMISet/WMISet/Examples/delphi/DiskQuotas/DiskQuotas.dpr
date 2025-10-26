program DiskQuotas;

uses
  Forms,
  FrmMainU in 'FrmMainU.pas' {FrmMain},
  FrmNewDiskQuotaU in 'FrmNewDiskQuotaU.pas' {FrmNewDiskQuota},
  FrmAboutU in 'FrmAboutU.pas' {FrmAbout},
  FrmNewHostU in 'FrmNewHostU.pas' {FrmNewHost};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmNewDiskQuota, FrmNewDiskQuota);
  Application.CreateForm(TFrmAbout, FrmAbout);
  Application.CreateForm(TFrmNewHost, FrmNewHost);
  Application.Run;
end.
