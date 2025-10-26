program StartService;

{$APPTYPE CONSOLE}
uses
  Variants, SysUtils, WmiDataSet, WmiConnection, WmiMethod;

var
  vQuery: TWmiQuery;
  vConnection: TWmiConnection;
  vMethod: TWmiMethod;
  i: integer;
  vName: string;
begin
  if ParamCount > 0 then vName := ParamStr(1) else Exit;

  vQuery := TWmiQuery.Create(nil);
  vConnection := TWmiConnection.Create(nil);
  vMethod := TWmiMethod.Create(nil);
  try
    vQuery.Connection := vConnection;
    vMethod.WmiObjectSource := vQuery;
    vQuery.WQL.Text := 'select * from Win32_Service';
    vQuery.Open;
    if vQuery.Locate('Name', vName, []) then
    begin
      vMethod.WmiMethodName := 'StartService';
      if vMethod.Execute = 0 then writeln('Ok')
        else writeln(vMethod.LastWmiErrorDescription);
    end else writeln('Service '+ vName + ' not found.');
  finally
    vMethod.Free;
    vQuery.Free;
    vConnection.Free;
  end;
end.

end.
