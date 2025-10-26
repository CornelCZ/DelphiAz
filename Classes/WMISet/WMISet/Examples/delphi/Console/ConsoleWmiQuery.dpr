program ConsoleWmiQuery;
{$APPTYPE CONSOLE}
uses
  SysUtils, WmiDataSet, WmiConnection;

var
  vQuery: TWmiQuery;
  vConnection: TWmiConnection;
  i: integer;
begin
  vQuery := TWmiQuery.Create(nil);
  vConnection := TWmiConnection.Create(nil);
  try
    vQuery.Connection := vConnection;
    vQuery.WQL.Text := 'select * from Win32_Account';
    vQuery.Open;
    while not vQuery.EOF do
    begin
      for i := 0 to vQuery.Fields.Count - 1 do
      begin
        write(vQuery.Fields[i].FieldName+ ': ');
        writeln(vQuery.Fields[i].AsString);
      end;
      vQuery.Next;
      writeln;
    end;
  finally
    vQuery.Free;
    vConnection.Free;
  end;
end.



