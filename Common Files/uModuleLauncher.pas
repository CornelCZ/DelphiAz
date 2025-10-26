unit uModuleLauncher;

interface

const
  ReportsModule = 'Reports'; //This is the name of the module as it appears in the ac_Module table.

procedure RunModule(moduleName, commandLine : string);


implementation

uses Windows, Forms, SysUtils, ShellAPI, uSystemUtils, uAztecDatabaseUtils, ADODB;

const
  ProgramFilesEnVar = '%programfiles%';
  ProgramFilesx86EnVar = '%programfiles(x86)%';

  RootAztecFolder = '[rootaztecfolder]';
  RootAztecModulesFolder = '[rootaztecmodulesfolder]';
  RootAztecDotNetFolder = '[rootaztecdotnetfolder]';

  ManagedBinFolder = 'bin\managed';
  LegacyModulesFolder = 'Modules';

var
  installFolder: string;
  AztecQuery: TADODataset;


function GetAztecQuery: TADODataset;
begin
  if AztecQuery = nil then
  begin
    AztecQuery := TADODataset.Create(nil);
    AztecQuery.ConnectionString := GetAztecDBConnectionString;
    AztecQuery.CommandTimeout := 0;
  end;

  result := AztecQuery;
end;

// Returns the string s with all environment variable strings of the form %variableName% replaced
// with the current value of the environment variable. If any environment variable strings cannot be
// replaced an exception is raised.
function ExpandEnvironmentVariables(const s: string): string;
var
  src, dest: pchar;
  buffmem: array[0..255] of char;
begin
  src := pchar(s);
  dest := buffmem;

  if ExpandEnvironmentStrings(src, dest, 255) > 0 then
    result := string(dest)
  else
    raise Exception.Create('Failed to expand all environment variable strings in ' + s);
end;

function GetInstallFolder: string;
begin
  if installFolder = '' then
  begin
    installFolder := uSystemUtils.GetAztecInstallationFolder;
  end;

  result := installFolder;
end;

function ExpandModulePath(const path: string): string;
var expandedPath: string;
begin
  expandedPath := Lowercase(path);

  if (Pos(ProgramFilesx86EnVar, expandedPath) <> 0) and (GetEnvironmentVariable(ProgramFilesx86EnVar) = '') then
    expandedPath := StringReplace(expandedPath, ProgramFilesx86EnVar, ProgramFilesEnVar, []);

  expandedPath := ExpandEnvironmentVariables(expandedPath);

  expandedPath := StringReplace(expandedPath, RootAztecFolder, GetInstallFolder, []);
  expandedPath := StringReplace(expandedPath, RootAztecModulesFolder, GetInstallFolder + LegacyModulesFolder, []);
  expandedPath := StringReplace(expandedPath, RootAztecDotNetFolder, GetInstallFolder + ManagedBinFolder, []);

  Result := expandedPath;
end;

procedure RunModule(moduleName, commandLine : string);
var
  query: TADODataset;
  modulePath: string;
begin
  query := GetAztecQuery;

  query.CommandText := 'SELECT Path FROM ac_Module WHERE SystemName = ' + QuotedStr(moduleName);
  query.Open;
  modulePath := query.FieldByName('Path').AsString;
  query.Close;

  if modulePath = '' then
    raise Exception.Create('Could not find path for module ' + moduleName + ' in ac_Module');

  modulePath := ExpandModulePath(modulePath);

  if not(FileExists(modulePath)) then
    raise Exception.Create('Could not find executable ' + modulePath);

  ShellExecute(Application.Handle, 'Open', PChar(modulePath), PChar(commandLine), nil, sw_ShowNormal);

end;

end.
