program NetworkConfig;

uses
  Forms,
  FrmNetworkConfigMainU in 'FrmNetworkConfigMainU.pas' {FrmNetworkConfigMain},
  FrmStaticAddressU in 'FrmStaticAddressU.pas' {FrmStaticAddress};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmNetworkConfigMain, FrmNetworkConfigMain);
  Application.CreateForm(TFrmStaticAddress, FrmStaticAddress);
  Application.Run;
end.
