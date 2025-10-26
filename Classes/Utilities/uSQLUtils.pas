unit uSQLUtils;

interface

{ Returns the given datetime as a quoted date & time string suitable for
  passing to an SQL query }
function FormatDateTimeForSQL(date : TDateTime) : string;

implementation

uses SysUtils;

function FormatDateTimeForSQL(date : TDateTime) : string;
begin
  Result := '''' + formatdatetime('yyyymmdd hh:nn:ss', date) + '''';
end;


end.
 