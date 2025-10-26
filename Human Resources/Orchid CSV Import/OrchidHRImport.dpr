program OrchidHRImport;

uses
  Forms,
  uMain in 'uMain.pas' {frmCSVImport},
  uAztecDatabaseUtils in '..\Classes\Database\uAztecDatabaseUtils.pas',
  uEmployeeClass in '..\Code\uEmployeeClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Orchid Employee Import';
  Application.CreateForm(TfrmCSVImport, frmCSVImport);
  Application.Run;
end.
