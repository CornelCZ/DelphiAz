unit uReporting;

interface

procedure CreateReport(Token, AModuleName, AComponentName: string); overload
procedure CreateReport(Token, AModuleName, AComponentName: string; AStartDate, AEndDate: TDateTime); overload

implementation

uses SysUtils, uAztecDatabaseUtils, ADODB, ShellAPI, Forms, Windows, uModuleLauncher;

procedure GetReportDetails(AModuleName, AComponentName: string;
  out AFolderName, AReportName: string; out AUseStartDate, AUseEndDate, AAutoPrint: boolean);
var
  DBQuery : TADOQuery;
begin
  DBQuery := TADOQuery.Create(nil);

  with DBQuery do
  try
    ConnectionString := GetAztecDBConnectionString;
    CommandTimeout := 0;
    SQL.Text := 'select * from ReportDefinition where ModuleName = '''
      + AModuleName + ''' and ComponentName = ''' + AComponentName + '''';
    Open;

    AFolderName   := FieldByName('FolderName').AsString;
    AReportName   := FieldByName('ReportName').AsString;
    AUseStartDate := FieldByName('UseStartDate').AsBoolean;
    AUseEndDate   := FieldByName('UseEndDate').AsBoolean;

    //Added 328701
    AAutoPrint    := FieldByName('AutoPrint').AsBoolean;
    Close;
  finally
    FreeAndNil(DBQuery);
  end;
end;

procedure CreateReport(Token, AModuleName, AComponentName: string);
begin
  CreateReport(Token, AModuleName, AComponentName, 0, 0);
end;

procedure CreateReport(Token, AModuleName, AComponentName: string; AStartDate, AEndDate: TDateTime);
var
  CommandLine      : string;
  FolderName       : string;
  ReportName       : string;
  UseStartDate     : boolean;
  UseEndDate       : boolean;
  AutoPrint        : boolean;
begin
  CommandLine := Token;

  GetReportDetails(AModuleName, AComponentName, FolderName, ReportName, UseStartDate, UseEndDate,AutoPrint);

  if FolderName <> '' then
    CommandLine := CommandLine + ' folder="' + FolderName + '"';

  if ReportName <> '' then
    CommandLine := CommandLine + ' report="' + ReportName + '"';

  if UseStartDate then
    CommandLine := CommandLine + ' sdate="' + formatDateTime('dd/mm/yyyy', AStartDate) + '"';

  if UseEndDate then
    CommandLine := CommandLine + ' edate="' + formatDateTime('dd/mm/yyyy', AEndDate) + '"';

  //Added 328701
  if AutoPrint then
    CommandLine := CommandLine + ' Print="Y"';

  uModuleLauncher.RunModule(ReportsModule, CommandLine);
end;

end.


