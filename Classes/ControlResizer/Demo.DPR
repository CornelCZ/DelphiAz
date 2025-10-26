program Demo;

uses
  Forms,
  DemoU1 in 'DemoU1.pas' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
