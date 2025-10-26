program ScheduledJobs;

uses
  Forms,
  FrmScheduledJobMainU in 'FrmScheduledJobMainU.pas' {FrmScheduledJobMain},
  FrmNewJobU in 'FrmNewJobU.pas' {FrmNewJob};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmScheduledJobMain, FrmScheduledJobMain);
  Application.Run;
end.
