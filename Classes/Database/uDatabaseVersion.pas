unit uDatabaseVersion;

interface

uses ADODB;

type
  TDatabaseVersion = Class(TObject)
  private
    FVersionText : string;
    FProductVersion: integer;
    FMajorVersion: integer;
    FMinorVersion: integer;
    FBuild: integer;
    //Note: VersionDecomposed was introduced to speed up the use of this class when version decomposition is not required.
    VersionDecomposed: boolean;

    procedure SetVersionText(Value : string);
    procedure DecomposeDatabaseVersion;
    function GetProductVersion: integer;
    function GetMajorVersion: integer;
    function GetMinorVersion: integer;
    function GetBuild: integer;

  public
    constructor Create; overload;
    constructor Create(VersionString : string); overload;
    constructor CreateAtThisSystemVersion(ADOConnection : TADOConnection);
    function IsEqualTo(OtherVersion : TDatabaseVersion) : Boolean;
    function IsLowerThan(OtherVersion : TDatabaseVersion) : Boolean;
    function IsHigherThan(OtherVersion : TDatabaseVersion) : Boolean;
    procedure SetToMinimumPossibleVersion;
    procedure SetToThisSystemVersion(ADOConnection : TADOConnection);

    property VersionText: string read FVersionText write SetVersionText;
    property ProductVersion: integer read GetProductVersion;
    property MajorVersion: integer read GetMajorVersion;
    property MinorVersion: integer read GetMinorVersion;
    property Build: integer read GetBuild;
  end;

implementation

uses SysUtils, uAztecDatabaseUtils;

var
  //The following variables will be used to hold the version details of the database of this system.
  ThisSystemVersionText: string;
  ThisSystemProductVersion: integer;
  ThisSystemMajorVersion: integer;
  ThisSystemMinorVersion: integer;
  ThisSystemBuild: integer;

{ TDatabaseVersion }

constructor TDatabaseVersion.Create;
begin
  VersionText := '';
end;

constructor TDatabaseVersion.Create(VersionString : string);
begin
  VersionText := VersionString;
end;

constructor TDatabaseVersion.CreateAtThisSystemVersion(ADOConnection : TADOConnection);
begin
  SetToThisSystemVersion(ADOConnection);
end;

procedure TDatabaseVersion.DecomposeDatabaseVersion;
var
  p: Integer;
  TempVersion : string;
begin
  //Below are the defaults if the version string is empty or invalid
  FProductVersion := 0;
  FMajorVersion := 0;
  FMinorVersion := 0;
  FBuild := 0;

  try
    if FVersionText = '' then
      Exit;

    TempVersion := FVersionText + '.0.0.0.';

    try
      p := pos('.', TempVersion);
      FProductVersion := StrToInt(Copy(TempVersion, 1, p-1));
      Delete(TempVersion, 1, p);

      p := pos('.', TempVersion);
      FMajorVersion := StrToInt(Copy(TempVersion, 1, p-1));
      Delete(TempVersion, 1, p);

      p := pos('.', TempVersion);
      FMinorVersion := StrToInt(Copy(TempVersion, 1, p-1));
      Delete(TempVersion, 1, p);

      p := pos('.', TempVersion);
      if (FProductVersion < 3) or ((FProductVersion = 3) and (FMajorVersion < 2)) then
        FBuild := Ord(TempVersion[1])
      else
        FBuild := StrToInt(Copy(TempVersion, 1, p-1));
    except
      //If the database version string is invalid we will currently just assume the version is the highest
      //possible version. Ideally we should also log it in a log file. This would require the application
      //which creates this object to pass it a reference to the log procedure.
    end;
  finally
    VersionDecomposed := TRUE;
  end;
end;


function TDatabaseVersion.IsEqualTo(OtherVersion: TDatabaseVersion): Boolean;
begin
  Assert((VersionText <> '') and (OtherVersion.VersionText <> ''), 'Error: Attempt to compare unassigned versions');
  Result := (VersionText = OtherVersion.VersionText);
end;


function TDatabaseVersion.IsLowerThan(OtherVersion: TDatabaseVersion) : Boolean;
begin
  Assert((VersionText <> '') and (OtherVersion.VersionText <> ''), 'Error: Attempt to compare unassigned versions');

  Result := FALSE;

  if ProductVersion < OtherVersion.ProductVersion then
    Result := TRUE
  else if ProductVersion = OtherVersion.ProductVersion then
  begin
    if MajorVersion < OtherVersion.MajorVersion then
      Result := TRUE
    else if MajorVersion = OtherVersion.MajorVersion then
    begin
      if MinorVersion < OtherVersion.MinorVersion then
        Result := TRUE
      else if MinorVersion = OtherVersion.MinorVersion then
      begin
        if Build < OtherVersion.Build then
          Result := TRUE;
      end;
    end;
  end;
end;


function TDatabaseVersion.IsHigherThan(OtherVersion: TDatabaseVersion): Boolean;
begin
  Result := not(IsEqualTo(OtherVersion)) and not(IsLowerThan(OtherVersion));
end;


procedure TDatabaseVersion.SetVersionText(Value : string);
begin
  FVersionText := UpperCase(Value);
  VersionDecomposed := FALSE;
end;

function TDatabaseVersion.GetProductVersion: integer;
begin
  if not VersionDecomposed then DecomposeDatabaseVersion;
  Result := FProductVersion;
end;

function TDatabaseVersion.GetMajorVersion: integer;
begin
  if not VersionDecomposed then DecomposeDatabaseVersion;
  Result := FMajorVersion;
end;

function TDatabaseVersion.GetMinorVersion: integer;
begin
  if not VersionDecomposed then DecomposeDatabaseVersion;
  Result := FMinorVersion;
end;

function TDatabaseVersion.GetBuild: integer;
begin
  if not VersionDecomposed then DecomposeDatabaseVersion;
  Result := FBuild;
end;

procedure TDatabaseVersion.SetToMinimumPossibleVersion;
begin
  VersionText := '0.0.0.0';
  FProductVersion := 0;
  FMajorVersion := 0;
  FMinorVersion := 0;
  FBuild := 0;
  VersionDecomposed := TRUE;
end;

procedure TDatabaseVersion.SetToThisSystemVersion(ADOConnection : TADOConnection);
var
  ADODataset : TADODataset;
begin
  { If we haven't yet looked up ModuleVersion for this system's database version do it now }
  if ThisSystemVersionText = '' then
  begin
    try
      ADODataset := GetADODataset(ADOConnection);
      with ADODataset do
      begin
        CommandText := 'SELECT Id FROM sysobjects where Name = ''ModuleVersion'' and type = ''U''';
        Open;

        if RecordCount > 0 then
        begin
          Close;

          CommandText := 'SELECT * from ModuleVersion WHERE ModuleID = ''DB''';
          Open;

          Assert(RecordCount > 0, 'Error: Cannnot find database version in ModuleVersion table');

          VersionText :=
            FieldByName('ProductVersion').AsString + '.' +
            FieldByName('MajorVersion').AsString + '.' +
            FieldByName('MinorVersion').AsString + '.' +
            FieldByName('Revision').AsString;
        end
        else
        begin
          Close;

          CommandText := 'SELECT dbo.fn_getDbVerStr() as Version';
          Open;

          Assert(RecordCount > 0, 'Error: Cannnot find database version in ModuleVersion table');

          VersionText := FieldByName('Version').AsString;
        end;
      end;
    finally
      FreeAndNil(ADODataset);
    end;
  end
  else
    VersionText := ThisSystemVersionText;

  ThisSystemVersionText := VersionText;
  ThisSystemProductVersion := ProductVersion;
  ThisSystemMajorVersion := MajorVersion;
  ThisSystemMinorVersion := MinorVersion;
  ThisSystemBuild := Build;
end;

end.
