program SystemEvents;

uses
  Forms,
  FrmEventsMainU in 'FrmEventsMainU.pas' {FrmEventsMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmEventsMain, FrmEventsMain);
  Application.Run;
end.
