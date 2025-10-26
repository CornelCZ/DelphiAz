program ServiceDemo;

uses
  Forms,
  FrmServiceMainU in 'FrmServiceMainU.pas' {FrmServiceMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFrmServiceMain, FrmServiceMain);
  Application.Run;
end.
