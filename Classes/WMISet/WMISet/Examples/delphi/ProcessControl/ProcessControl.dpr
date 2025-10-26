program ProcessControl;

uses
  Forms,
  FrmMainU in 'FrmMainU.pas' {FrmMain},
  FrmSelectColumnsU in 'FrmSelectColumnsU.pas' {FrmSelectColumns},
  FrmNewTaskU in 'FrmNewTaskU.pas' {FrmNewTask},
  FrmNewHostU in 'FrmNewHostU.pas' {FrmNewHost};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmNewTask, FrmNewTask);
  Application.Run;
end.
