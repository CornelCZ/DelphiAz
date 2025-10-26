unit useful;

// Disable "specific to a platform" warnings for this unit
{$IFDEF ver140}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}
{$ENDIF}

{PeterW 29/06/00 }

{This unit defines lots of generally useful functions, mostly}
{wrappers for API calls that are commonly required. Therefore any API changes}
{will (hopefully) only need doing in one place (i.e. here).}
{NO Application specific code may be written here!}

{PeterW 10/07/02}
{Due to the risk of creating bugs in other programs, please check everyone's usage}
{of this unit before changing any existing functions - and update the changes log.}

{Changes Log:}
{24/08/2000 Peter: Added function to apply an upgrade to a directory full of
                   tables. }
{11/09/2000 Peter: Fixed a bug in ExtractFileBaseName which made DoRipple()
                   write rippled files to the current directory, not where they
                   were before. }

{28/03/2001 Peter: Added "tbldesc" to fixed tables - those which always get
                    copied wholesale rather than upgraded}

{28/01/2002 Peter: Fixed a bug in the GetSpecialShellPath function - it was
                   not using the ID parameter. Added GetProgramFilesDir fn.
                   Also fixed a bug in GetFileVersion.. it crashed on version
                   numbers greater than 9.. was using inttostr on a hex value!}

{30/01/2002 Peter: Fixed an upgradetable problem with BatCopy and Autoinc fields
                   Delphi's batchmove resets the numbering of such fields.. So
                   we convert these fields to large integers.}

{07/02/2002 Peter: DoSchemaUpgrade now handles key violations if required. An
                   optional ErrorList parameter makes the upgrade process
                   proceed despite any Key Violations, logging the number of
                   violations and the offending table to the list.}

{18/03/2002 Peter: Added renamefiles procedure.}

{11/04/2002 Peter: Fixed bug in FindFiles.. directory search logic was wrong,
                   this caused files to be returned as well}
{17/07/2002 Peter: New procedure to parse a delimited string into a TStrings}
{19/09/2002 Peter: Removed access to forms and BDE units, making these functions
                   useful for DLL and non-BDE applications!}

{11/11/2002 David: Add function to retrieve all server names from the network.}
{08/08/2003 HamishM (Edesix): Reimplement GetFileSize so that it works even if
                   the file in question is locked}
{01/10/2003 HamishM (Edesix): Removed unnecessary 'var' directive from last
                   parameter to SeparateList.}
{17/09/2004 Greg: Added function IsValidTime }
{17/07/2007 Peter: Added function GetStringResource}
{18/10/2007 Peter: Added function GetSafeSQLColumnName}
{13/10/2009 Peter: Fixed benign debugger exception on translating some win32 errors}
{01/05/2014 Peter: Added ExecuteBatchFileAndCapture. This function is so mental you'll be glad you waited 14 years for it. NOT!}
{30/06/2015 CraigM: Added procedure ConvertMouseWheelMessageToCursorKey}

{AFAIK To get Delphi to step through units on a network drive, you must make sure
 the project source file specifies a DRIVE LETTER, as the path to each unit is
 stamped into them from the project source filename. If this does not match
 the editor filename.. you will not be able to debug the code.}

{ (c) Zonal Retail Data Systems 2000 }

interface

uses
  sysutils, windows, messages, classes,{ forms, }filectrl{, db, dbtables, dialogs,
  bde}, shellapi, StrUtils;
  
const
  NetApi32 = 'netapi32.dll';
  ERROR_SUCCESS = 0;
  ERROR_MORE_DATA = 234;
  SIZE_SI_101 = 24;

  SV_TYPE_WORKSTATION       = $00000001; // All LAN Manager workstations
  SV_TYPE_SERVER            = $00000002; // All LAN Manager servers
  SV_TYPE_SQLSERVER         = $00000004; // Any server running with Microsoft SQL Server
  SV_TYPE_DOMAIN_CTRL       = $00000008; // Primary domain controller
  SV_TYPE_DOMAIN_BAKCTRL    = $00000010; // Backup domain controller
  SV_TYPE_TIMESOURCE        = $00000020; // Server running the Timesource service
  SV_TYPE_AFP               = $00000040; // Apple File Protocol servers
  SV_TYPE_NOVELL            = $00000080; // Novell servers
  SV_TYPE_DOMAIN_MEMBER     = $00000100; // LAN Manager 2.x Domain Member
  SV_TYPE_LOCAL_LIST_ONLY   = $40000000; // Servers maintained by the browser. See the following Remarks section.
  SV_TYPE_PRINT             = $00000200; // Server sharing print queue
  SV_TYPE_DIALIN            = $00000400; // Server running dial-in service
  SV_TYPE_XENIX_SERVER      = $00000800; // Xenix server
  SV_TYPE_MFPN              = $00004000; // Microsoft File and Print for Netware
  SV_TYPE_NT                = $00001000; // Windows NT (either Workstation or Server)
  SV_TYPE_WFW               = $00002000; // Server running Windows for Workgroups
  SV_TYPE_SERVER_NT         = $00008000; // Windows NT Non-DC server
  SV_TYPE_POTENTIAL_BROWSER = $00010000; // Server that can run the Browser service
  SV_TYPE_BACKUP_BROWSER    = $00020000; // Server running a Browser service as backup
  SV_TYPE_MASTER_BROWSER    = $00040000; // Server running the master Browser service
  SV_TYPE_DOMAIN_MASTER     = $00080000; // Server running the domain master Browser
  SV_TYPE_DOMAIN_ENUM       = $80000000; // Primary Domain
  SV_TYPE_WINDOWS           = $00400000; // Windows 95 or later
  SV_TYPE_ALL               = $FFFFFFFF; // All servers

  IMAGE_DIRECTORY_ENTRY_EXPORT = 0;
  IMAGE_DIRECTORY_ENTRY_IMPORT = 1; // Import Directory
  IMAGE_DIRECTORY_ENTRY_RESOURCE = 2; // Resource Directory
  IMAGE_DIRECTORY_ENTRY_EXCEPTION = 3; // Exception Directory
  IMAGE_DIRECTORY_ENTRY_SECURITY = 4; // Security Directory
  IMAGE_DIRECTORY_ENTRY_BASERELOC = 5; // Base Relocation Table
  IMAGE_DIRECTORY_ENTRY_DEBUG = 6; // Debug Directory
  IMAGE_DIRECTORY_ENTRY_COPYRIGHT = 7; // Description String
  IMAGE_DIRECTORY_ENTRY_GLOBALPTR = 8; // Machine Value (MIPS GP)
  IMAGE_DIRECTORY_ENTRY_TLS = 9; // TLS Directory
  IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG = 10; // Load Configuration Directory

type
  ERegistryAccessError = class(Exception);

  TVersion = packed record
    case integer of
      0:
      (Build: byte;
        MinorVersion: byte;
        MajorVersion: byte;
        ProductVersion: byte);
      1:
      (VersionLong: cardinal);
  end;

  TFindFilesSearchType = (ffstNameMatch, ffstLimitToDevices, ffstLimitToDirs);
  TTimeCheckComparisonType = (tctDifferent, tctSame, tctGreaterThan,
    tctLessThan);

  TLogFunction = procedure(Text: string) of object;
  TShutdownProc = procedure(Reason: string) of object;
  TWinPlatform = (wpNT, wpWin2000, wpXP);

  PSERVER_INFO_101 = ^SERVER_INFO_101;

  SERVER_INFO_101 = record
    dwPlatformId : integer;
    lpszServerName: LPWSTR;
    dwVersionMajor: integer;
    dwVersionMinor: integer;
    dwType: integer;
    lpszComment: LPWSTR;
  end;

  DosHeader = record
    e_magic: SmallInt; // Magic number
    e_cblp: SmallInt; // Bytes on last page of file
    e_cp: SmallInt; // Pages in file
    e_crcl: SmallInt; // Relocations
    e_cparhdr: SmallInt; // Size of header in paragraphs
    e_minalloc: SmallInt; // Minimum extra paragraphs needed
    e_maxalloc: SmallInt; // Maximum extra paragraphs needed
    e_ss: SmallInt; // Initial (relative) SS value
    e_sp: SmallInt; // Initial SP value
    e_csum: SmallInt; // Checksum
    e_ip: SmallInt; // Initial IP value
    e_cs: SmallInt; // Initial (relative) CS value
    e_lfarclc: SmallInt; // File address of relocation table
    e_ovno: SmallInt; // Overlay number
    e_res: array[1..4] of SmallInt; // Reserved words
    e_oemid: SmallInt; // OEM identifier (for e_oeminfo)
    e_oeminfo: SmallInt; // OEM information; e_oemid specific
    e_res2: array[1..10] of SmallInt; // Reserved words
    e_lfanew: Integer; // File address of new exe header
  end;

  PEImgHeader = record
    Machine: SmallInt;
    NumberofSections: SmallInt;
    TimeDateStamp: Integer;
    PointerToSymboltable: Integer;
    NumberofSymbols: Integer;
    SizeOfOptionalHeader: SmallInt;
    Characteristics: SmallInt;
  end;

  Image_Data_Directory = record
    VirtualAddress: Integer;
    Size: Integer;
  end;

  Thunk_Data = record
    AddressOfData: Integer;
  end;

  Import_Function = record
    Ordinal: SmallInt;
    Name: array[0..255] of Char;
  end;

  PEOptionalHeader = record
    Magic: SmallInt;
    MajorLinkerVersion: Byte;
    MinorLinkerVersion: Byte;
    SizeOfCode: Integer;
    SizeOfInitializedData: Integer;
    SizeOfUninitializedData: Integer;
    AddressOfEntryPoint: Integer;
    BaseofCode: Integer;
    BaseofData: Integer;
    ImageBase: Integer;
    SectionAlignment: Integer;
    FileAlignment: Integer;
    MajorOperatingSystemVersion: SmallInt;
    MinorOperatingSystemVersion: SmallInt;
    MajorImageVersion: SmallInt;
    MinorImageVersion: SmallInt;
    MajorSubsystemVersion: SmallInt;
    MinorSubsystemVersion: SmallInt;
    Win32Version: Integer;
    SizeOfImage: Integer;
    SizeOfHeaders: Integer;
    CheckSum: Integer;
    Subsystem: SmallInt;
    DLLCharacteristics: SmallInt;
    SizeOfStackReserve: Integer;
    SizeOfStackCommit: Integer;
    SizeOfHeapReserve: Integer;
    SizeOfHeapCommit: Integer;
    LoaderFlags: Integer;
    NumberofRVAandSizes: Integer;
    DataDirectories: array[0..15] of Image_Data_Directory;
  end;

  ImageSectionHeader = record
    Name: array[0..7] of Char;
    VirtualSize: Integer;
    VirtualAddress: Integer;
    SizeOfRawData: Integer;
    PointerToRawData: Integer;
    PointerToRelocations: Integer;
    PointerToLineNumbers: Integer;
    NumberofRelocations: SmallInt;
    NumberofLineNumbers: SmallInt;
    Characteristics: Integer;
  end;

  PEImportDescriptors = record
    Characteristics: Integer;
    TimeDateStamp: Integer;
    ForwarderChain: Integer;
    Name: Integer;
    FirstThunk: Integer;
  end;

  PEExportImage = record
    Characteristics: Integer;
    TimeDateStamp: Integer;
    MajorVersion: SmallInt;
    MinorVersion: SmallInt;
    Name: Integer;
    Base: Integer;
    NumberofFunctions: Integer;
    NumberofNames: Integer;
    AddressOfFunctions: Integer;
    AddressOfNames: Integer;
    AddressOfNameOrdinals: Integer;
  end;

  TImportExportItem = class(TCollectionItem)
  private
    FFunctionName: string;
    FOrdinal: Integer;
  public
    property FunctionName: string read FFunctionName write FFunctionName;
    property Ordinal: Integer read FOrdinal write FOrdinal;
  end;

  TImportExport = class(TCollection)
  private
    FPEName: string;
    function GetItem(Index: Integer): TImportExportItem;
    procedure SetItem(Index: Integer; Value: TImportExportItem);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    function Add: TImportExportItem;
    property PEName: string read FPEName write FPEName;
    property Items[Index: Integer]: TImportExportItem read GetItem write SetItem; default;
  end;

  TNumberType = (ntDecimal, ntHex);

  TPEFileInfo = class(TObject)
  private
    FStream: TFileStream;
    FFileName: string;
    FIsPE: Boolean;
    FIsMSDos: Boolean;
    FImportList: TStringList;
    FExportList: TStringList;
    FMSDOSHeader: TStringList;
    FPEHeaderList: TStringList;
    FPEOptionalHeaderList: TStringList;
    FSectionStart: Integer;
    FDosHeader: DosHeader;
    FPEHeader: PEImgHeader;
    FPEOptionalHeader: PEOptionalHeader;
    FNumberType: TNumberType;
    procedure ReadPEFileFormat;
    procedure ReadImportList;
    function GetEnclosingSectionHeader(rva: Integer; var SectionHeader: ImageSectionHeader): Boolean;
    procedure GetImportFunctions(const Import: PEImportDescriptors; Delta: Integer; ImpExp: TImportExport);
    procedure ReadExportList;
    function GetCPUType: string;
    procedure FillMSDOSHeader;
    procedure FillPEOptionalHeader;
    procedure FillPEHeader;
    function GetExportList: TStrings;
    function GetImportList: TStrings;
    function GetMSDOSHeader: TStrings;
    function GetPEHeaderList: TStrings;
    function GetPEOptionalHeaderList: TStrings;
  protected
  public
    function IntToNum(n: Integer): string;
    constructor Create(const FName: string; NType: TNumberType);
    destructor Destroy; override;
  published
    property FileName: string read FFileName;
    property CPUType: string read GetCPUType;
    property NumberType: TNumberType read FNumberType write FNumberType;
    property IsPE: Boolean read FIsPE;
    property IsMSDos: Boolean read FIsMSDos;
    property ImportList: TStrings read GetImportList;
    property ExportList: TStrings read GetExportList;
    property MSDOSHeader: TStrings read GetMSDOSHeader;
    property PEHeaderList: TStrings read GetPEHeaderList;
    property PEOptionalHeaderList: TStrings read GetPEOptionalHeaderList;
  end;

function Application_Exename: string;
// Executes a command FILENAME with paramters PARAMS, in directory DIR.
// If all is well, the command is executed and TRUE is returned, otherwise FALSE is returned.
function ExecuteBatchFileAndWait(FileName, Params, Dir: string; showcmd:
  cardinal = SW_HIDE): boolean;
// Calls notepad on a filename and waits for the process to finish (i.e. for notepad to exit)
function ExecuteBatchFile(FileName, Params, Dir: string): cardinal;
// Same as ExecuteBatchFileAndWait but captures output and error streams, standard in stays as-is, not captured, assumed not used
function ExecuteBatchFileAndCapture(FileName, Params, Dir: string; CaptureData: TStrings; showcmd: cardinal = SW_HIDE): boolean;
function NotePad(FileName: string): boolean;
// finds the first occurrence of a substring from the END of a string
function revpos(substr, str: string): integer;
// Gets the parent directory of a dir. pathname
function GetParentOf(dir: string): string;
//
procedure CreateAppDir(dir: string);
// Get a version key string
function GetVersionKeyInfo(VersionResourceKey: string): string;
function GetFileVersion(filename: string): TVersion;
// convert a paradox dir to a windows one
function convertpdoxdir(pdoxdir: string): string;
// extractfilebasename, removes extension and path from the filename
function extractfilebasename(filename: string): string;
// Get WINNT directory
function GetWinntDir: string;
function GetWinntSystemDir: string;
// get path to the temp directory
function GetTempDir: string;
// Delete a file, if it may be read only
function DeleteReadOnlyFile(path: string): boolean;
// scramble a plaintext password for storing in an INI file.
function encodepwd(const plain: string): string;
// unscramble a password scrambled with the above
function decodepwd(const scrambled: string): string;
// boolean to string conversion
function booltostr(boolval: boolean): string;
// reverse of above
function strtobool(strval: string): boolean;
// make sure a path name has a trailing slash, so a filename may be appended
function EnsureTrailingSlash(path: string): string;
function RemoveTrailingSlash(path: string): string;
// Make sure the given string has a backslash character at the start
function EnsureLeadingSlash(path: string): string;
// convert an integer to a string, return 0 if string is null or non-integer
function StrToIntChk(input: string): integer;
// convert an integer to a string, pad with zeroes to DIGITS number of digits
function IntToStrPad(input, digits: integer): string;
// is the string strictly numeric
function IsNumeric(input: string): boolean; overload;
// is the string numeric or blank
function IsNumericOrBlank(input: string): boolean;
// copy a file, delete source if it exists
procedure ForceCopy(sourcepath, destpath: string);
// copy files (with pattern) - uses forcecopy
procedure copyfiles(sourcepatt, destdir: string);
// delete files matching pattern
procedure deletefiles(filepatt: string);
// find files and return in a StringList
// 3 modes - ffstNameMatch (retursns only filenames which match),
// ffstLimitToDevices (return only devices - not tested),
// ffstLimitToDirs (return only directories)
// Does not recurse.
// This function uses windows findfirst APIs directly
function FindFiles(path: string; SearchType: TFindFilesSearchType; var FList:
  TStrings): boolean;
// Get the size of a given file in INT64
function GetSizeOfFile(filepath: string): int64;
// ripple files - new file is in filepath, size limit for each file, to backupcount number of backups
procedure DoRipple(filepath: string; sizelimit, backupcount: integer);
// return sign of an integer, -1 for less than 0 , otherwise 1
function ISign(input: integer): integer;
// remove a directory and all its kith + subfolders, use with caution.
procedure DeleteDir(pathname: string);
// swaps two VAR parameters
procedure swapint(var a, b: integer);

function qdate(const InDate: TDateTime): string;
function qtime(const InTime: TDateTime): string;


procedure SetReadOnlyAttr(filename: string; state: boolean);
// Get files using findfirst..
procedure MakeListOfFilesAtPattern(pattern: string; list: TStringList);
procedure MakeListOfFilesAtPatternFullPath(pattern: string; list: TStringList);
{The following 5 functions are from Paul Cooper's common.pas unit}
function CalculateVatFromNett(NettAmount, VatRate: Double): Double;
function CalculateNettFromGross(GrossAmount, VatRate: Double): Double;
function CalculateVatFromGross(GrossAmount, VatRate: Double): Double;
function CalcUKAmount(ForeignAmount, NominalRate: Double): Double;
function GetDiskFree(Drive: byte): comp;
function GetEnvironmentVar(name: string): string;
function GetNTUserName: string;
procedure TextLog(text: string; filename: string);

{Registry functions}
// open registry to read a string if its there, otherwise return blank string
function QueryRegString(RootKey: cardinal; Key, Value: string): string;
// open registry to read an integer. Raises an ERegistryAccessError exception if not found.
function QueryRegInteger(RootKey: cardinal; Key, Value: string): integer;
procedure SetRegStringVolatile(RootKey: cardinal; Key: string; Value: string);

function RightJustifySpaces(input: string; length: integer): string;

function MakeVersionLong(const verstring: string): Cardinal;

procedure MoveFile(frompath, topath: string);

function RunningOnNT: boolean;
function RunningOnVista: boolean;

{Is the given directory locked?? Returns true if the directory does not exist.}
function IsDirLocked(dir: string): boolean;
{Returns true if the specified directory could be locked, passes the dir}
{handle through the hDir parameter if so.}
function LockDir(dir: string; var hDir: cardinal): boolean;
{Unlock an opened directory handle.}
procedure UnlockDir(hDir: cardinal);
// Find a unique temporary sub directory from the chosen path, create it and
// return the path to it.
function GetTempSubDir(dir: string): string;

{SendESCToWindow: Simulate escape key being pressed in a window. Works for dos!}
procedure SendESCToWindow(hWnd: cardinal);
{TerminateWindow: Remove the process that owns a given window.}
procedure TerminateWindow(hWnd: cardinal);
{CloseWindow: send a standard close message to the given window}
procedure CloseWindow(hWnd: cardinal);
{FindPrizmWindow: Returns the window handle of the first "Zonal Prizm" DOS box
running this NT workstation. There are normally only one of these at a given
time.}
function FindPrizmWindowHandle: cardinal;
{CheckCommPort: Return true if the specified COM port is openable, otherwise
return false.}
function CheckCommPort(Comport: integer): boolean;
function FixedStrToTime(HHColonMMString: string): TDateTime;
function FixedTimeToStr(InTime: TDateTime): string;
// Check that a time as a string is of the format hh:mm.
function IsValidTime (t : String) : boolean;


{Get special shell paths, see implementation for a list of the IDs}
function GetSpecialShellPath(Id: integer): string;
function GetFileModifiedTime(filename: string): FileTime;
function FileTimeCheck(sourcefile: string; checktype: TTimeCheckComparisonType;
  destfile: string): boolean;

{Hack to update a paradox SOM file. Not sure if it will work with all versions.}
procedure UpdatePdoxDOSNetfile(pdoxdir, netfile: string);
function GetPdoxDOSNetfile(pdoxdir: string): string;

function GetProgramFilesDir: string;
function GetStartMenuDir: string;

{Rename files by pattern, if "blatant" is true then don't worry about}
{overwriting files in the process.}
procedure renamefiles(frompatt, topatt:string; blatant: boolean);
function GetWildCardName(pattern, origname: string):string;
function GetCurrentDir: string;

procedure SeparateList(list:string; separator: char; output: TStrings);

function GetLastErrorText: string;

procedure Start_Service(machinename, servicename: string; setautostart: boolean);

procedure ProcessPaintMessages;

// functions to display prizm-style messages and y/n confirmations on
// standard output. Applications using this must be compiled for console access.
procedure ConsoleMessage(text: TStrings);
//function ConsoleQuestion(text: TStrings): boolean;

function GetPlatform: TWinPlatform;

// Return a list of servers currently alive on the network.
procedure GetServers(filter : Dword; const domain : string; list : TStrings);

function GetShortPathName(input:string):string;

// Returns a comma seperated list of DLL Function Names
function GetDLLExportFunctions(DLLFileName: string): string;

{$ifdef ver140}
procedure ConvertUTFToUnicode(infilename: string; outfilename: string);
{$endif}

function GetStringResource(ResourceName, ResourceType: string): string;
function GetSQLDate(Date: TDateTime): string;
function GetSafeSQLColumnName(Input:string): string;
function GetJoinAlias(Input: integer): string;

function GetBCPPath: string;

function GetTerminalServicesSessionID: integer;

function CompareAlphaNumeric(leftString, rightString: string): integer;

function StringGreaterThan(Left, Right: string): boolean;

function IncString(strValue : string): string;
function DecString(strValue : string): string;

function IsValidBarcode(Barcode: String): Boolean;

procedure ConvertMouseWheelMessageToCursorKey(var msg : tagMSG; var Handled: Boolean);

function IndexStr(const AText: String; const AValues: array of String; const CaseSensitive: Boolean = TRUE): Integer;

implementation

uses shlobj, winsvc, registry;



function ExecuteBatchFileAndWait(FileName, Params, Dir: string; showcmd:
  cardinal = SW_HIDE): boolean;
var
  SInfo: TStartupInfo;
  PInfo: TProcessInformation;
begin
  if Dir = '' then
    Dir := GetCurrentDir;
  FillChar(SInfo, Sizeof(SInfo), #0);
  SInfo.cb := Sizeof(SInfo);
  SInfo.dwFlags := STARTF_USESHOWWINDOW;
  SInfo.wShowWindow := showcmd;
  if CreateProcess(nil, pchar(filename + ' ' + Params), nil, nil, false,
    CREATE_NEW_PROCESS_GROUP and NORMAL_PRIORITY_CLASS, nil, pchar(Dir),
    SInfo, PInfo) then
  begin
    {busy wait, processing messages}
    while WaitForSingleObject(Pinfo.hProcess, 100) <> WAIT_OBJECT_0 do
      ProcessPaintMessages;
    result := true;
    CloseHandle(pinfo.hprocess);
    CloseHandle(pinfo.hThread);
  end
  else
    result := false;
end;

function ExecuteBatchFile(FileName, Params, Dir: string): cardinal;
var
  hinst: cardinal;
begin
  hinst := Shellexecute(GetDesktopwindow, 'open', pchar(filename),
    pchar(params), pchar(dir), SW_SHOW);
  if hinst <= 32 then
    result := INVALID_HANDLE_VALUE
  else
    result := 42;
end;

(*
var
  SInfo: TStartupInfo;
  PInfo: TProcessInformation;
  cmdline, curdir: pchar;
  cmdlinestr: string;
begin
  if params <> '' then
    cmdlinestr := filename + ' '+params
  else
    cmdlinestr := filename;
  cmdline := stralloc(length(cmdlinestr)+1);
  strpcopy(cmdline, cmdlinestr);
  if dir <> '' then
  begin
    curdir := stralloc(length(dir)+1);
    strpcopy(curdir, dir);
  end
  else
    curdir := #0;
  FillChar(SInfo, Sizeof(SInfo), #0);
  SInfo.cb := Sizeof(SInfo);
  SInfo.dwFlags := STARTF_USESHOWWINDOW;
  SInfo.wShowWindow := SW_SHOW;
  if CreateProcess(nil, cmdline, nil, nil, false,
    CREATE_NEW_PROCESS_GROUP and NORMAL_PRIORITY_CLASS, nil, curdir,
    SInfo, PInfo) then
  begin
    {busy wait, processing messages}
{    while WaitForSingleObject(Pinfo.hProcess, 100) <> WAIT_OBJECT_0 do
      Application.processmessages;
    result := true;
    CloseHandle(pinfo.hprocess);}
    result := pinfo.hprocess;
  end
  else
  begin
    showmessage('Could not run process:'+inttostr(getlasterror));
    result := INVALID_HANDLE_VALUE;
  end;
  strdispose(cmdline);
  if assigned(curdir) then
    strdispose(curdir);
end;
  *)

function GetWinntDir: string;
var
  buff: array[0..255] of byte;
begin
  GetWindowsDirectory(@buff, 255);
  result := ensuretrailingslash(string(pchar(@buff)));
end;

function GetWinntSystemDir: string;
var
  buff: array[0..255] of byte;
begin
  GetSystemDirectory(@buff, 255);
  result := ensuretrailingslash(string(pchar(@buff)));
end;

function GetTempDir: string;
var
  buff: array[0..255] of byte;
begin
  GetTempPath(255,@buff);
  result := string(pchar(@buff));
end;

function NotePad(FileName: string): boolean;
//var
//  SInfo: TStartupInfo;
//  PInfo: TProcessInformation;
//  NTDir, Params, Dir, cmd: string;
begin
  shellexecute(getdesktopwindow, pchar('open'),
    pchar(EnsureTrailingSlash(GetWinntDir) + 'notepad.exe'),
    pchar(FileName), nil, SW_SHOW);

  result := true;
  (*
    Params := AnsiQuotedStr(FileName, '"');
    NTDir := GetWinntDir;
    cmd := NTDIR + '\notepad.exe';
    Dir := NTDir;
    FillChar(SInfo, Sizeof(SInfo), #0);
    SInfo.cb := Sizeof(SInfo);
    SInfo.dwFlags := STARTF_USESHOWWINDOW;
    SInfo.wShowWindow := SW_SHOW;
    if CreateProcess(nil, pchar(cmd + ' ' + Params), nil, nil, false,
      CREATE_NEW_PROCESS_GROUP and NORMAL_PRIORITY_CLASS, nil, pchar(Dir),
      SInfo, PInfo) then
    begin
      {busy wait, processing messages}
      while WaitForSingleObject(Pinfo.hProcess, 100) <> WAIT_OBJECT_0 do
        Application.processmessages;
      result := true;
      CloseHandle(pinfo.hprocess);
    end
    else
      result := false;
  *)
end;

function revpos(substr, str: string): integer;
{finds pos from the end of a string}
var
  found: boolean;
  i, j: integer;
begin
  found := false;
  i := length(str);
  while (i >= 1) and not (found) do
  begin
    found := true;
    for j := 1 to length(substr) do
    begin
      if (i + pred(j)) <= length(str) then
        found := found and (str[i + pred(j)] = substr[j]);
    end;
    dec(i);
  end;
  if not found then
    result := 0
  else
    result := succ(i);
end;

function GetParentOf(dir: string): string;
var
  tmpstr: string;
begin
  {Remove any trailing slash}
  tmpstr := ensuretrailingslash(dir);
  tmpstr := copy(tmpstr, 1, pred(length(tmpstr)));
  {extractfiledir will find the parent dir.}
  tmpstr := extractfiledir(tmpstr);
  result := ensuretrailingslash(tmpstr);
end;

procedure CreateAppDir(dir: string);
begin
  if not (directoryexists(getparentof(dir))) then
    createappdir(getparentof(dir));
  if not (directoryexists(dir)) then
    createdir(dir);
end;

function GetVersionKeyInfo(VersionResourceKey: string): string;
{cribbed from verslab.pas, original file header:
Unit        : verslab.pas
Description : A TCustomLabel derivative that displays Win32 VersionInfo data
Version     : 1.00, 15 June 1997
Status      : Freeware
Contact     : Marc Evans, marc@leviathn.demon.co.uk}
{This version has been modified to provide access to Win32 version data}
{at runtime through a function - used to read the Definitive project version}
{and also to determine the Application Short and Long IDs}
var
{$IFDEF VER120}
  dump, vallen: cardinal;
{$ELSE}
  dump, vallen: dword;
{$ENDIF}

  s: integer;
  buffer, VersionValue: pchar;
  VersionPointer: pchar;
begin
  s := GetFileVersionInfoSize(pchar(Application_Exename), dump);
  if s = 0 then
  begin
    Result := '';
  end
  else
  begin
    buffer := StrAlloc(s + 1);
    GetFileVersionInfo(Pchar(Application_Exename), 0, s, buffer);
    if VerQueryValue(buffer, pchar('\\StringFileInfo\\' + '080904E4' + '\\' +
      VersionResourceKey),
      pointer(VersionPointer), vallen) then
    begin
      if (Vallen > 1) then
      begin
        VersionValue := StrAlloc(vallen + 1);
        StrLCopy(VersionValue, VersionPointer, vallen);
        Result := VersionValue;
        StrDispose(Buffer);
        StrDispose(VersionValue);
      end
      else
        Result := '';
    end
    else
      result := '';
  end;
end;

function GetFileVersion(filename: string): TVersion;
var
  buff: TByteArray;
  s, verlen, dump: cardinal;
  verptr: PVSFixedFileInfo;
begin
  s := GetFileVersionInfoSize(pchar(filename), dump);
  if s = 0 then
  begin
    raise Exception.create('Could not get version information for ' +
      filename);
  end
  else
  begin
    GetFileVersionInfo(Pchar(filename), 0, s, @buff);
    if VerQueryValue(@buff, pchar('\\'),
      pointer(verptr), verlen) then
    begin
      if (verlen > 1) then
      begin
        result.ProductVersion := (verptr.dwFileVersionMS shr 16);
        result.MajorVersion := (verptr.dwFileVersionMS and 65535);
        result.MinorVersion := (verptr.dwFileVersionLS shr 16);
        result.Build := (verptr.dwFileVersionLS and 65535);
      end;
    end
    else
      raise Exception.create('Could not find file version information for file '
        + filename);
  end;
end;

function convertpdoxdir(pdoxdir: string): string;
var
  pcharstr: pchar;
begin
  result := trim(pdoxdir);
  result := StringReplace(result, '\\', '\', [rfReplaceAll]);
  pcharstr := pchar(result);
  result := AnsiExtractQuotedStr(pcharstr, '"');
end;

function extractfilebasename(filename: string): string;
begin
  result := copy(filename, 1, pred(revpos('.', filename)));
  if result = '' then
    result := filename;
end;

function DeleteReadOnlyFile(path: string): boolean;
var
  attr: cardinal;
begin
  if not Fileexists(path) then
    result := true
  else
  begin
    attr := GetFileAttributes(pchar(path));
    if attr and FILE_ATTRIBUTE_READONLY > 0 then
    begin
      attr := attr and (not (FILE_ATTRIBUTE_READONLY));
      SetFileAttributes(pchar(path), attr);
    end;
    if attr and FILE_ATTRIBUTE_ARCHIVE > 0 then
    begin
      attr := attr and (not (FILE_ATTRIBUTE_ARCHIVE));
      SetFileAttributes(pchar(path), attr);
    end;
    result := DeleteFile(pchar(path));
  end;
end;

function encodepwd(const plain: string): string;
var
  str: string;
  i: integer;
  seed: byte;

  function encodeprintable(input: byte): byte;
  begin
    {remove non-printables from input}
    if input < 32 then
      input := 32;
    {encode with seed}
    result := (((input) xor seed));
    {generate new seed - will not have high bit}
    {so as not to make next char >127 unnecessarily}
    seed := (seed xor input) and 127;
    {replace '"' chars so string may be quoted}
    if result = 34 then
      result := 31;
  end;
begin
  seed := $42;
  str := plain;
  for i := 1 to length(str) do
  begin
    str[i] := char(encodeprintable(byte(Str[i])));
  end;
  result := AnsiQuotedStr(str, '"');
end;

function decodepwd(const scrambled: string): string;
var
  istr: string;
  i: integer;
  seed: byte;

  function decodeprintable(input: byte): byte;
  begin
    {Restore '"' chars in encoded string}
    if input = 31 then
      input := 34;
    result := (((input) xor seed));
    {generate new seed}
    seed := (seed xor result) and 127;
  end;
begin
  seed := $42;
  istr := scrambled;
  for i := 1 to length(istr) do
  begin
    istr[i] := char(decodeprintable(byte(iStr[i])));
  end;
  result := istr;

end;

function booltostr(boolval: boolean): string;
begin
  if boolval then
    result := 'True'
  else
    result := 'False';
end;

function strtobool(strval: string): boolean;
begin
  result := (strval = 'True');
end;

function EnsureTrailingSlash(path: string): string;
begin
  if (path <> '') and (path[length(path)] <> '\') then
    result := path + '\'
  else
    result := path;
end;

function RemoveTrailingSlash(path: string): string;
begin
  if (path <> '') and (path[length(path)] = '\') then
    result := copy(path, 1, pred(length(path)))
  else
    result := path;
end;

function EnsureLeadingSlash(path: string): string;
begin
  if (path <> '') and (path[1] <> '\') then
    result := '\' + path
  else
    result := path;
end;

function StrToIntChk(input: string): integer;
var
  tmpstr: string;
begin
  result := 0;
  {remove spaces}
  tmpstr := trim(input);
  {blank or null string gets treated as zero}
  if tmpstr = '' then
    exit;
  if length(tmpstr) > 10 then
    raise EConvertError.create('String "' + tmpstr +
      '" too long to convert to a signed integer.');
  if not (isnumeric(tmpstr)) then
    raise EConvertError.create('String "' + tmpstr +
      '" containts non-numbers, can''t convert to a signed integer.');
  result := strtoint(tmpstr)
end;

function IntToStrPad(input, digits: integer): string;
begin
  result := inttostr(input);
  // copy from required position to end of string
  result := copy('000000000', 0, digits - length(result)) + result;
end;

function IsNumeric(input: string): boolean;
var
  i: integer;
begin
  result := false;
  if input = '' then
  begin
    exit;
  end;
  result := true;
  for i := 1 to length(input) do
    if (input[i] < '0') or (input[i] > '9') then
    begin
      result := false;
      exit;
    end;
end;

function IsNumericOrBlank(input: string): boolean;
var
  i: integer;
begin
  if input = '' then
  begin
    result := true;
    exit;
  end;
  result := true;
  for i := 1 to length(input) do
    if not ((input[i] >= '0') and (input[i] <= '9')) then
    begin
      result := false;
      exit;
    end;
end;


type
  WIN32_FILE_ATTRIBUTE_DATA = record
    dwFileAttributes: DWORD;
    ftCreationTime: TFileTime;
    ftLastAccessTime: TFileTime;
    ftLastWriteTime: TFileTime;
    nFileSizeHigh: DWORD;
    nFileSizeLow: DWORD;
  end;

function GetSizeOfFile(filepath: string): int64;
var
  attrData: WIN32_FILE_ATTRIBUTE_DATA;
begin
  if not GetFileAttributesEx( pchar(filepath), GetFileExInfoStandard,
                          pointer(@attrData) ) then
    raise Exception.create('GetSizeOfFile: Opening file "' + filepath +
      '" failed.');

  Result := int64(attrData.nFileSizeHigh shl 32) + int64(attrData.nFileSizeLow);
end;

{function GetSizeOfFile(filepath: string): int64;
var
  hFile: cardinal;
  lo, hi: Cardinal;
  ptr_hi: pointer;
begin
  Result := 0;
  hFile := CreateFile(pchar(filepath), FILE_READ_ATTRIBUTES, FILE_SHARE_READ, nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if hFile = INVALID_HANDLE_VALUE then
    raise Exception.create('GetSizeOfFile: Opening file "' + filepath +
      '" failed.');
  ptr_hi := @hi;
  lo := GetFileSize(hFile, ptr_hi);
  if (lo <> $FFFFFFFF) or (GetLastError <> NO_ERROR) then
  begin
    Result := int64(hi shl 32) + int64(lo);
    CloseHandle(hFile);
  end;
end;}

procedure DoRipple(filepath: string; sizelimit, backupcount: integer);
var
  i: integer;
  filebasename: string;
  function BackupName(sequencenumber: integer): string;
  begin
    result := filebasename + '.b' + inttostrpad(sequencenumber, 2);
  end;
begin
  if (FileExists(filepath) and (GetSizeOfFile(filepath) > sizelimit))
    or DirectoryExists(filepath) then
  begin
    {The file size has just been exceeded. "ripple" the files.}
    filebasename := extractfilebasename(filepath);
    {Get rid of file at end of backup count}
    if fileexists(BackupName(backupcount)) then
      sysutils.deletefile(BackupName(backupcount));
    if directoryexists(BackupName(backupcount)) then
      removedir(BackupName(backupcount));
    {Move along all intermediate backups 1->2 2->3 etc.}
    for i := pred(backupcount) downto 0 do
    begin
      if fileexists(BackupName(i)) or directoryexists(BackupName(i)) then
        renamefile(
          pchar(BackupName(i)),
          pchar(BackupName(i + 1))
          );
    end;
    {rename }
    renamefile(pchar(filepath), pchar(BackupName(0)));
  end;
end;

function isign(input: integer): integer;
begin
  {Returns the sign of the integer, either -1 or 1. 0 Is treated as positive.}
  if input < 0 then
    result := -1
  else
    result := 1;
end;

procedure copyfiles(sourcepatt, destdir: string);
var
  FilesToCopy: TSearchRec;
  searchres: integer;
  sourcefile: string;
begin
  if destdir[length(destdir)] <> '\' then
    destdir := destdir + '\';
  searchres := findfirst(sourcepatt, faAnyFile, FilestoCopy);
  while (searchres = 0) do
  begin
    sourcefile := string(filestocopy.FindData.cFileName);
    if (filestocopy.Attr and faDirectory) = 0 then
      forcecopy(extractfiledir(sourcepatt) + '\' + sourcefile,
        destdir + extractfilename(sourcefile));
    searchres := findnext(FilesToCopy);
  end;
  sysutils.findclose(FilesToCopy);
end;

procedure deletefiles(filepatt: string);
var
  FilesToDelete: TStringlist;
  i: integer;
begin
  FilesToDelete := TStringList.create;
  try
    FindFiles(filepatt, ffstNameMatch, TStrings(FilesToDelete));
    for i := 0 to pred(FilesToDelete.count) do
    begin
      sysutils.DeleteFile(FilesToDelete[i]);
    end;
  finally
    FilesToDelete.free;
  end;
end;

function FindFiles(path: string; SearchType: TFindFilesSearchType;
  var FList: TStrings): boolean;
var
  f: TWin32FindData;
  SearchHandle: cardinal;
  fSearchOp: TFindexSearchOps;
  FileName: string;
  res: cardinal;
begin
  result := false;
  case SearchType of
    ffstNameMatch: fSearchOp := FindExSearchNameMatch;
    ffstLimitToDevices: fSearchOp := FindExSearchLimitToDevices;
    ffstLimitToDirs: fSearchOp := FindExSearchLimitToDirectories;
  else
    fSearchOp := FindExSearchNameMatch;
  end;
  // cast result type of findfirstfileex, due to silly type declaration
  // in delphi windows unit. (as longbool?!?)
  SearchHandle := Cardinal(Windows.FindFirstFileEx(pchar(path),
    FindExInfoStandard, @f,
    fSearchOp, nil, 0));
  if SearchHandle <> INVALID_HANDLE_VALUE then
  begin
    try
      repeat
        FileName := ensuretrailingslash(extractfiledir(path)) +
          string(pchar(@f.cFileName));
        // If not a dir, add it. If its a directory, only add it if we're doing
        // a dir search and its not one of those stupid . .. thingys.
        // PW: this is the old logic.. its wrong!
        // It says: if [the item is not a directory] or [we only want directories
        // and the item is not a "virtual" directory i.e. ".."/"."] then add it
        // Therefore normal files will be returned in a directory search.
        {if not ((f.dwFileAttributes and faDirectory) > 0) or
          ((SearchType = ffstLimitToDirs) and
          not (string(pchar(@f.cFileName)) = '..') and
          not (string(pchar(@f.cFileName)) = '.'))
          then}
        if ((SearchType <> ffstLimitToDirs) and not ((f.dwFileAttributes and faDirectory) > 0))
          or
          (((SearchType = ffstLimitToDirs) and ((f.dwFileAttributes and faDirectory) > 0) and
          not (string(pchar(@f.cFileName)) = '..') and not (string(pchar(@f.cFileName)) = '.')))
          then
        begin
          result := true;
          FList.add(FileName);
        end;
        res := cardinal(Windows.FindNextFile(SearchHandle, f));
      until res = 0
    finally
      Windows.FindClose(SearchHandle);
    end;
  end;
end;

procedure ForceCopy(sourcepath, destpath: string);
begin
  if fileexists(destpath) then
    DeleteReadOnlyFile(destpath);
  if not CopyFile(pchar(sourcepath), pchar(destpath), true) then
    raise Exception.create('Could not copy file "'+sourcepath+'" to "'+destpath+'"');
end;

procedure DeleteDir(pathname: string);
var
  dir: string;
  children: TStringList;
  i: integer;
begin
  children := TStringList.create;
  try
    dir := ensuretrailingslash(pathname);
    if directoryexists(dir) then
    begin
      // dir exists. delete all files in it.
      if findfiles(dir + '*.*', ffstNameMatch, TStrings(children)) then
      begin
        for i := 0 to pred(children.count) do
          deletereadonlyfile(children.strings[i]);
        children.clear;
      end;
      // recurse on subdirectories, they will delete themselves
      if findfiles(dir + '*.*', ffstLimitToDirs, TStrings(children)) then
      begin
        for i := 0 to pred(children.count) do
          DeleteDir(children.strings[i]);
        children.clear;
      end;
      setreadonlyattr(dir, false);
      removedirectory(pchar(dir));
    end;
  finally
    children.free;
  end;
end;


procedure swapint(var a, b: integer);
var
  tmp: integer;
begin
  tmp := a;
  a := b;
  b := tmp;
end;

function qdate(const InDate: TDateTime): string;
begin
  result := formatdatetime('dd.mm.yyyy', InDate);
end;

function qtime(const InTime: TDateTime): string;
begin
  result := formatdatetime('hh:mm', InTime);
end;

procedure SetReadOnlyAttr(filename: string; state: boolean);
var
  attr: cardinal;
begin
  attr := GetFileAttributes(pchar(filename));
  if ((attr and FILE_ATTRIBUTE_READONLY) > 0) xor state then
  begin
    if state then
      attr := attr or (FILE_ATTRIBUTE_READONLY)
    else
      attr := attr and (not (FILE_ATTRIBUTE_READONLY));
    SetFileAttributes(pchar(filename), attr);
  end;

end;

procedure MakeListOfFilesAtPattern(pattern: string; list: TStringList);
var
  sRec: TSearchRec;
  res: integer;
  pattdir: string;
  pattpath: string;
begin
  pattdir := ensuretrailingslash(extractfiledir(pattern));
  res := FindFirst(pattern, faAnyFile, sRec);
  while res = 0 do
  begin
    pattpath := pattdir + string(sRec.name);
    if fileexists(pattpath) then
      list.add(lowercase(string(sRec.name)));
    res := FindNext(sRec);
  end;
  sysutils.FindClose(sRec);
end;

procedure MakeListOfFilesAtPatternFullPath(pattern: string; list: TStringList);
var
  sRec: TSearchRec;
  res: integer;
  pattdir: string;
  pattpath: string;
begin
  pattdir := ensuretrailingslash(extractfiledir(pattern));
  res := FindFirst(pattern, faAnyFile, sRec);
  while res = 0 do
  begin
    pattpath := pattdir + string(sRec.name);
    list.add(pattpath);
    res := FindNext(sRec);
  end;
  sysutils.FindClose(sRec);
end;

{The following from Paul cooper's Delphi code}

function CalculateVatFromNett(NettAmount, VatRate: Double): Double;
begin
  result := trunc(0.5 + 100 * (NettAmount * VatRate / 100)) / 100;
end;

function CalculateNettFromGross(GrossAmount, VatRate: Double): Double;
begin
  result := trunc(0.5 + (100 * 100 * GrossAmount) / (100 + VatRate)) / 100;
end;

function CalculateVatFromGross(GrossAmount, VatRate: Double): Double;
begin
  result := GrossAmount - CalculateNettFromGross(GrossAmount, VatRate);
end;

function CalcUKAmount(ForeignAmount, NominalRate: Double): Double;
begin
  if NominalRate = 0 then
  begin
    result := 0
  end else
  begin
    result := trunc(0.5 + (100 * ForeignAmount / NominalRate)) / 100;
  end;
end;

{PPP 26/3/99 following function courtesy of  http://members.xoom.com/jescott/DelphiCodeTips1.html }
{The DELPHI DiskFree function does not work for drives over 2Gb }

function GetDiskFree(Drive: byte): comp;
{ func to return the free space of a drive in bytes. }
var
  RootPath: array[0..4] of Char;
  RootPtr: PChar;
{$IFDEF VER100}
  SectorsPerCluster,
    BytesPerSector,
    FreeClusters,
    TotalClusters: integer;
{$ELSE}
  SectorsPerCluster,
    BytesPerSector,
    FreeClusters,
    TotalClusters: cardinal;
{$ENDIF}
  CompSectPerClusters: comp;
begin
  RootPtr := nil;
  if Drive > 0 then
  begin
    StrCopy(RootPath, 'A:\');
    RootPath[0] := CHR(Drive + ORD('A') - 1);
    RootPtr := RootPath
  end;

  if GetDiskFreeSpace(RootPtr, SectorsPerCluster, BytesPerSector,
    FreeClusters, TotalClusters) then
  begin
    CompSectPerClusters := SectorsPerCluster;
    Result := (CompSectPerClusters * BytesPerSector * FreeClusters) / 1024;
  end
  else
    Result := -1;
end;

function QueryRegString(RootKey: cardinal; Key, Value: string): string;
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create;
  try
    Registry.RootKey := RootKey;
    if not Registry.OpenKeyReadOnly(EnsureLeadingSlash(Key)) then
      raise ERegistryAccessError.Create('Failed to open registry key ' + Key + '. Check that it exists.');

    if not Registry.ValueExists(Value) then
      raise ERegistryAccessError.Create('Value ' + Value + ' does not exist in registry key ' + Key);

    if Registry.GetDataType(Value) <>  rdString then
      raise ERegistryAccessError.Create('Value ' + Value + ' in registry key ' + Key + ' is not of type String');

    Result := Registry.ReadString(Value);
  finally
    Registry.Free;
  end;
end;

function QueryRegInteger(RootKey: cardinal; Key, Value: string): integer;
var
  Registry : TRegistry;
begin
  Result := 0;
  Registry := TRegistry.Create;
  try
    Registry.RootKey := RootKey;
    if not Registry.OpenKeyReadOnly(EnsureLeadingSlash(Key)) then
      raise ERegistryAccessError.Create('Failed to open registry key ' + Key + '. Check that it exists.');

    if not Registry.ValueExists(Value) then
      raise ERegistryAccessError.Create('Value ' + Value + ' does not exist in registry key ' + Key);

    if Registry.GetDataType(Value) <>  rdInteger then
      raise ERegistryAccessError.Create('Value ' + Value + ' in registry key ' + Key + ' is not of type DWORD');

    Result := Registry.ReadInteger(Value);
  finally
    Registry.Free;
  end;
end;


procedure SetRegStringVolatile(RootKey: cardinal; Key: string; Value: string);
var
  RegHandle: HKEY;
  Retval: integer;
  Disposition: cardinal;
begin
  retVal := RegCreateKeyEx(RootKey,
    pchar(removetrailingslash(extractfilepath(key))), 0, pchar('String'),
    REG_OPTION_VOLATILE, KEY_WRITE, nil,
    RegHandle, @Disposition);
  if Retval <> ERROR_SUCCESS then
    exit;
  RegSetValueEx(RegHandle, pchar(extractfilename(key)), 0, REG_SZ,
    pchar(Value), Length(value));
  CloseHandle(RegHandle);
end;

function GetEnvironmentVar(name: string): string;
var
  pBuff, pName: pchar;
  buffmem: array[0..255] of char;
begin
  pName := pchar(Name);
  pBuff := buffmem;
  //showmessage(string(foo))
  if GetEnvironmentVariable(pName, pBuff, 255) > 0 then
    result := string(pBuff)
  else
    result := 'Unknown';
end;

function GetNTUserName: string;
begin
  result := GetEnvironmentVar('USERNAME')
end;

procedure TextLog(text: string; filename: string);
var
  LFile: Textfile;
begin
  assignfile(LFile, filename);
  if fileexists(filename) then
    append(LFile)
  else begin
    ForceDirectories(ExtractFileDir(filename));
    rewrite(LFile);
  end;
  writeln(LFile, datetimetostr(now) + ' : ' + text);
  closefile(LFile);
end;

function RightJustifySpaces(input: string; length: integer): string;
begin
  while system.length(input) < length do
    input := ' ' + input;
  result := input;
end;

function MakeVersionLong(const verstring: string): Cardinal;
var
  dot1pos, dot2pos: cardinal;
begin
  {converts a string in the form "majver.minver.servicepack"}
  {into packed VersionLong format for comparisons etc.}
  dot1pos := pos('.', verstring);
  dot2pos := revpos('.', verstring);
  if (dot1pos = 0) or (dot2pos = 0) then
    raise Exception.create('MakeVersionLong: invalid version passed.');
  result := strtoint(copy(verstring, 1, pred(dot1pos))) shl 24 +
    strtoint(copy(verstring, succ(dot1pos), pred(dot2pos - dot1pos))) shl 16 +
    strtoint(copy(verstring, succ(dot2pos), length(verstring))) shl 8;
end;

procedure MoveFile(frompath, topath: string);
begin
  if not windows.MoveFile(pchar(frompath), pchar(topath)) then
    raise Exception.create('Error moving file "' + frompath +
      '", Win32 Error code ' + inttostr(GetLastError));
end;

function RunningOnNT: boolean;
var
  osinfo: OSVERSIONINFO;
  OSver: Cardinal;
begin
  osinfo.dwOSVersionInfoSize := SizeOf(OSVERSIONINFO);
  GetVersionEx(osinfo);
  OSver := osinfo.dwMajorVersion;
  if OSver >= 4 then
    result := true
  else
    result := false;
end;

function RunningOnVista: boolean;
var
  osinfo: OSVERSIONINFO;
  OSver: Cardinal;
begin
  osinfo.dwOSVersionInfoSize := SizeOf(OSVERSIONINFO);
  GetVersionEx(osinfo);
  OSver := osinfo.dwMajorVersion;
  if OSver >= 6 then
    result := true
  else
    result := false;
end;

function GetTempSubDir(dir: string): string;
begin
  dir := ensuretrailingslash(dir);
  forcedirectories(dir);
  dir := dir + inttostr(GetTickCount);
  {the probability of this loop having to execute is very low - but is}
  {included to ensure uniqueness of the chosen directory}
  while directoryexists(dir) do
    dir := dir + '0';
  dir := ensuretrailingslash(dir);
  forcedirectories(dir);
  result := dir;
end;

function IsDirLocked(dir: string): boolean;
var
  hDir: cardinal;
begin
  if LockDir(dir, hDir) then
  begin
    {We could lock the dir.. so it wasn't locked before}
    result := false;
    UnlockDir(hDir);
  end
  else
    result := true;
end;

function LockDir(dir: string; var hDir: cardinal): boolean;
begin
  dir := ensuretrailingslash(dir);
  dir := copy(dir, 1, pred(length(dir)));
  hDir := createfile(pchar(dir), generic_write, 0, nil, open_existing,
    file_attribute_normal or FILE_FLAG_BACKUP_SEMANTICS, 0);
  if (hDir = INVALID_HANDLE_VALUE) or (hDir = 0) then
  begin
    result := false;
    exit;
  end
  else
    result := true;
end;

procedure UnlockDir(hDir: cardinal);
begin
  CloseHandle(hDir);
end;

procedure SendESCToWindow(hWnd: cardinal);
begin
  {Fake a keypress using the sequence that windows uses:}
  {the lower word of the "lparam" is a repeat count of 1}
  {the higher word is the previous key state, and a dummy scan code of 1}
  {27 is the ascii code for escape}
  postmessage(hWnd, WM_KEYDOWN, 27, $10001);
  postmessage(hWnd, WM_CHAR, 27, $10001);
  postmessage(hWnd, WM_KEYUP, 27, Integer($C0010001));
end;

procedure TerminateWindow(hWnd: cardinal);
var
  DosProcess, DosProcessHandle, DosExitCode: cardinal;
begin
  {DosThread := } GetWindowThreadProcessId(hWnd, @DosProcess);
  DosProcessHandle := OpenProcess(PROCESS_TERMINATE, FALSE, DosProcess);
  Getexitcodeprocess(DosProcessHandle, DosExitCode);
  Terminateprocess(DosProcessHandle, DosExitCode);
end;

procedure CloseWindow(hWnd: cardinal);
begin
  sendmessage(hWnd, WM_SYSCOMMAND, SC_CLOSE, 0);
end;

function FindPrizmWindowHandle: cardinal;
begin
  Result := findwindow('ConsoleWindowClass', 'Zonal Prizm');
end;

function CheckCommPort(Comport: integer): boolean;
var
  CommsHandle: cardinal;
  DeviceName: array[0..10] of char;
begin
  strpcopy(@Devicename, format('COM%d', [Comport]));
  CommsHandle := CreateFile(DeviceName,
    0, // device query access
    0,
    nil,
    open_existing,
    0,
    0
    );
  if CommsHandle = INVALID_HANDLE_VALUE then
  begin
    result := false;
  end
  else
  begin
    result := true;
    CloseHAndle(CommsHandle);
  end;
end;

function FixedStrToTime(HHColonMMString: string): TDateTime;
begin
  try
    if length(HHColonMMString) = 8 then
      result := (strtoint(copy(HHColonMMString, 1, 2)) / 24) +
        (strtoint(copy(HHColonMMString, 4, 2)) / 24 / 60) +
        (strtoint(copy(HHColonMMString, 7, 2)) / 24 / 3600)
    else
      result := (strtoint(copy(HHColonMMString, 1, 2)) / 24) +
        (strtoint(copy(HHColonMMString, 4, 2)) / 24 / 60);
  except
    result := strtotime(HHColonMMString);
  end;
end;

function FixedTimeToStr(InTime: TDateTime): string;
var
  mins: integer;
begin
  mins := trunc(frac(InTime) * (24*60));
  result := format('%s:%s', [inttostrpad(mins div 60, 2), inttostrpad(mins mod 60, 2)]);
end;

// Check that a time as a string is of the format hh:mm.
function IsValidTime (t : String) : boolean;

  function IsDigit (ch : char) : boolean;
  begin
    Result := (ch in ['0'..'9']);
  end;

begin
  Result := (length(t) = 5) and
            IsDigit(t[1]) and IsDigit(t[2]) and (t[3] = ':') and IsDigit(t[4]) and IsDigit(t[5]) and
            (StrToInt(copy(t, 1, 2)) <= 23) and (StrToInt(copy(t, 4, 2)) <= 59);
end;

{
  shell folder functions. Here are the other possible locations to get via this
  function

CSIDL_BITBUCKET
 Recycle bin ¾ file system directory containing file objects in the user’s
 recycle bin. The location of this directory is not in the registry; it is
 marked with the hidden and system attributes to prevent the user from moving
 or deleting it.

CSIDL_COMMON_DESKTOP
 File system directory that contains files and folders that appear on the
 desktop for all users.

CSIDL_COMMON_PROGRAMS
 File system directory that contains the directories for the common program
 groups that appear on the Start menu for all users.

CSIDL_COMMON_STARTMENU
 File system directory that contains the programs and folders that appear on
 the Start menu for all users.

CSIDL_COMMON_STARTUP
 File system directory that contains the programs that appear in the Startup
 folder for all users. The system starts these programs whenever any user logs
 on to Windows NT or starts up Windows 95.

CSIDL_CONTROLS
 Control Panel ¾ virtual folder containing icons for the control panel applications.

CSIDL_DESKTOP
 Windows desktop ¾ virtual folder at the root of the name space.

CSIDL_DESKTOPDIRECTORY
 File system directory used to physically store file objects on the desktop
 (not to be confused with the desktop folder itself).

CSIDL_DRIVES
 My Computer ¾ virtual folder containing everything on the local computer:
 storage devices, printers, and Control Panel. The folder may also contain
 mapped network drives.

CSIDL_FONTS
 Virtual folder containing fonts.

CSIDL_NETHOOD
 File system directory containing objects that appear in the network neighborhood.

CSIDL_NETWORK
 Network Neighborhood ¾ virtual folder representing the top level of the
 network hierarchy.

CSIDL_PERSONAL
 File system directory that serves as a common respository for documents.

CSIDL_PRINTERS
 Printers folder ¾ virtual folder containing installed printers.

CSIDL_PROGRAMS
 File system directory that contains the user’s program groups (which are also
 file system directories).

CSIDL_RECENT
 File system directory that contains the user’s most recently used documents.

CSIDL_SENDTO
 File system directory that contains Send To menu items.

CSIDL_STARTMENU
 File system directory containing Start menu items.

CSIDL_STARTUP
 File system directory that corresponds to the user’s Startup program group.

CSIDL_TEMPLATES
 File system directory that serves as a common repository for document templates.


}

function GetSpecialShellPath(Id: integer): string;
var
  items: PItemIdList;
begin
  shgetspecialfolderlocation(getdesktopwindow, Id, items);
  SetLength(Result, MAX_PATH);
  if SHGetPathFromIdList(items, PChar(Result)) then
    SetLength(result, StrLen(PChar(result)))
  else
    Result := '';
end;

function GetFileModifiedTime(filename: string): FileTime;
var
  HFile: cardinal;
begin
  HFile := createfile(pchar(filename), 0, FILE_SHARE_DELETE or FILE_SHARE_READ
    or FILE_SHARE_WRITE, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  GetFileTime(HFile, nil, nil, @Result);
  CloseHandle(HFile);
end;

function FileTimeCheck(sourcefile: string; checktype: TTimeCheckComparisonType;
  destfile: string): boolean;
var
  sourcetime, desttime: FileTime;
begin
  sourcetime := GetFileModifiedTime(sourcefile);
  desttime := GetFileModifiedTime(destfile);
  case checktype of
    tctDifferent:
      result := CompareFileTime(sourcetime, desttime) <> 0;
    tctSame:
      result := CompareFileTime(sourcetime, desttime) = 0;
    tctGreaterThan:
      result := CompareFileTime(sourcetime, desttime) = 1;
    tctLessThan:
      result := CompareFileTime(sourcetime, desttime) = -1;
  else
    result := false;
  end;

end;

procedure UpdatePdoxDOSNetfile(pdoxdir, netfile: string);
var
  writebuff: TByteArray;
begin
  if (pdoxdir <> '') and (fileexists(pdoxdir)) then
  begin
    if fileexists(ensuretrailingslash(extractfiledir(pdoxdir)) + 'paradox.som')
      then
    begin
      with TFileStream.create(ensuretrailingslash(extractfiledir(pdoxdir)) +
        'paradox.som',
        fmOpenReadWrite or fmShareDenyNone) do
      try
        Seek(14, soFromBeginning);
        StrPCopy(@Writebuff, netfile + #0);
        Write(WriteBuff, length(netfile) + 1);
      finally
        free;
      end;
    end;
    if fileexists(ensuretrailingslash(extractfiledir(pdoxdir)) +
      'pdoxrun.som') then
    begin
      with TFileStream.create(ensuretrailingslash(extractfiledir(pdoxdir)) +
        'pdoxrun.som',
        fmOpenReadWrite or fmShareDenyNone) do
      try
        Seek(14, soFromBeginning);
        StrPCopy(@Writebuff, netfile + #0);
        Write(WriteBuff, length(netfile) + 1);
      finally
        free;
      end;
    end
  end;
end;

function GetPdoxDOSNetfile(pdoxdir:string): string;
var
  Readbuff: TByteArray;
begin
  if fileexists(ensuretrailingslash(extractfiledir(pdoxdir)) +
      'pdoxrun.som') then
  begin
    with TFileStream.create(ensuretrailingslash(extractfiledir(pdoxdir)) +
      'pdoxrun.som',
      fmOpenReadWrite or fmShareDenyNone) do
    try
      Seek(14, soFromBeginning);
      Read(ReadBuff, 127);
      result := strpas(@readbuff);
    finally
      free;
    end;
  end else
  if fileexists(ensuretrailingslash(extractfiledir(pdoxdir)) + 'paradox.som')
    then
  begin
    with TFileStream.create(ensuretrailingslash(extractfiledir(pdoxdir)) +
      'paradox.som',
      fmOpenReadWrite or fmShareDenyNone) do
    try
      Seek(14, soFromBeginning);
      Read(ReadBuff, 127);
      result := strpas(@readbuff);
    finally
      free;
    end;
  end else
  raise Exception.create('Could not get Paradox SOM netfile');

end;

function GetStartMenuDir: string;
begin
  result := QueryRegString(HKEY_LOCAL_MACHINE,
    'SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders','Common Start Menu');
end;

function GetProgramFilesDir: string;
begin
  result := QueryRegString(HKEY_LOCAL_MACHINE,
    'SOFTWARE\Microsoft\Windows\CurrentVersion', 'ProgramFilesDir');
end;

function GetWildCardName(pattern, origname: string):string;
{not fully implemented, only deals with foo.* and *.foo at the moment!}
var
  patta, pattb, namea, nameb: string;
begin
  if pos('.', origname) = 0 then
  begin
    nameb := '';
    namea := origname;
  end
  else
  begin
    namea := copy(origname, 1, pred(pos('.', origname)));
    nameb := copy(origname, succ(pos('.', origname)), length(origname));
  end;
  if pos('.', pattern) = 0 then
  begin
    pattb := '';
    patta := pattern;
  end
  else
  begin
    patta := copy(pattern, 1, pred(pos('.', pattern)));
    pattb := copy(pattern, succ(pos('.', pattern)), length(pattern));
  end;
  {this is just a very cut-down version of full msdos wildcard substitution..}
  if nameb = '' then
  begin
    result := namea;
  end
  else
  begin
    if patta = '*' then result := namea + '.'
    else result := patta + '.';
    if pattb = '*' then result := result + nameb
    else result := result + pattb;
  end;
end;

procedure renamefiles(frompatt, topatt:string; blatant: boolean);
var
  FilesToRename: TStringlist;
  i: integer;
  newname: string;
begin
  FilesToRename := TStringList.create;
  try
    FindFiles(frompatt, ffstNameMatch, TStrings(FilesToRename));
    for i := 0 to pred(FilesToRename.count) do
    begin
      newname := ensuretrailingslash(extractfiledir(FilesToRename[i]));
      newname := newname + GetWildCardName(topatt, extractfilename(filestorename[i]));
      if blatant and fileexists(newname) then
        deletereadonlyfile(newname);
      movefile(filestorename[i], newname);
    end;
  finally
    FilesToRename.free;
  end;
end;

function GetCurrentDir: string;
var
  curdirbuff: array[0..4095] of char;
  idx: integer;
begin
  GetCurrentDirectory(4096, @curdirbuff);
  idx := 0;
  result := '';
  while ord(curdirbuff[idx]) <> 0 do
  begin
    result := result + curdirbuff[idx];
    inc(idx);
  end;
end;

procedure SeparateList(list:string; separator: char; output: TStrings);
// parse delimited list into a TStrings
var
  scanpos, nextpos: integer;
begin
  scanpos :=1;
  while scanpos <= length(list) do
  begin
    nextpos := pos(separator, copy(list, scanpos, length(list)));
    if nextpos = 0 then
      nextpos := length(list)+1;
    output.Add(copy(list, scanpos, pred(nextpos)));
    scanpos := scanpos + nextpos;
  end;
end;

function GetLastErrorText: string;
var
 buffer: Tbytearray;
 RetVal: cardinal;
begin
  RetVal := FormatMessage(
    {FORMAT_MESSAGE_ALLOCATE_BUFFER or} FORMAT_MESSAGE_FROM_SYSTEM or FORMAT_MESSAGE_IGNORE_INSERTS,
    nil,
    GetLastError(),
    0, // Default language
    @buffer,
    8000,
    nil);
  if RetVal <> 0 then
  begin
    result := StrPas(@buffer[0]);
    SetLength(Result, RetVal);
    while (Length(Result) > 0) and (Result[Length(Result)] in [#10, #13]) do
      SetLength(Result, Length(Result)-1);
  end
  else
    result := '???';
end;

procedure Start_Service(machinename, servicename: string; setautostart: boolean);
var
  hSCManager: thandle;
  hService: thandle;
  serviceconfig: TQueryServiceConfig;
  servicestatus: TServiceStatus;
  bytesneeded: cardinal;
  svcargs: pchar;
begin
  hSCManager := OpenSCManager(pchar(machinename), nil, SC_MANAGER_CONNECT);
  if hSCManager = 0 then
  begin
    raise Exception.create('Could not open service manager on "'+machinename+'" : '+getlasterrortext);
  end
  else
  try
    if setautostart then
      hService := OpenService(hSCManager, pchar(servicename), SERVICE_START or
        SERVICE_QUERY_STATUS or SERVICE_QUERY_CONFIG or SERVICE_CHANGE_CONFIG)
    else
      hService := OpenService(hSCManager, pchar(servicename), SERVICE_START or SERVICE_QUERY_STATUS);
    if hService = 0 then
    begin
      raise Exception.create('Could not open service "'+servicename+'" :'+getlasterrortext);
    end
    else
    try
      if setautostart then
      begin
        queryserviceconfig(hService, @serviceconfig, sizeof(TQueryServiceConfig), bytesneeded);
        (*if not queryserviceconfig(hService, @serviceconfig, 152, bytesneeded) then
        begin
          showmessage(inttostr(bytesneeded)+'/'+inttostr(sizeof(TQueryServiceConfig)));
          raise Exception.create('Could not query service configuration for "'+servicename+'" :'+getlasterrortext);
        end; *)
        if serviceconfig.dwStartType <> SERVICE_AUTO_START then
        begin
          if not changeserviceconfig(hService, SERVICE_NO_CHANGE, SERVICE_AUTO_START, SERVICE_NO_CHANGE,
            nil, nil, nil, nil, nil, nil, nil) then
            raise Exception.create('Could not change service configuration for "'+servicename+'" :'+getlasterrortext);
        end;
      end;
      if not queryservicestatus(hService, servicestatus) then
        raise Exception.create('Could not query status for service "'+servicename+'" :'+getlasterrortext);
      if (servicestatus.dwCurrentstate <> SERVICE_RUNNING) and
        (servicestatus.dwCurrentstate <> SERVICE_START_PENDING) and
        (servicestatus.dwCurrentstate <> SERVICE_CONTINUE_PENDING) then
      begin
        svcargs := nil;
        if not startservice(hservice, 0 , svcargs) then
          raise Exception.create('Could not start service "'+servicename+'" :'+getlasterrortext);
      end;
    finally
      closeservicehandle(hService);
    end;
  finally
    closeservicehandle(hSCManager);
  end;
end;

procedure ProcessPaintMessages;
// Process all paint messages in the message queue
// PW now fires WM_timechange messages also...
var
  msg: TMsg;
begin
  while PeekMessage(Msg, 0, WM_PAINT, WM_PAINT, PM_REMOVE) or
    PeekMessage(Msg, 0, WM_TIMECHANGE, WM_TIMECHANGE, PM_REMOVE) or
    PeekMessage(Msg, 0, WM_USER, pred(WM_APP), PM_REMOVE) do
  begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;
end;

function Application_Exename: string;
begin
  result := paramstr(0);
end;

procedure ConsoleMessage(text: TStrings);
var
  hStdout: cardinal;
  cursorpos: _coord;
  msgwidth, msgheight,i : integer;
  curline: string;
const
  // top, topright, right, bottomright, bottom, bottomleft, left, topleft
  pzchars = 'Í»º¼ÍÈºÉ';
type
  TPzborders = (pzbDummy, pzbTop, pzbTopRight, pzbRight, pzbBottomRight,
    pzbBottom, pzbBottomLeft, pzbLeft, pzbTopLeft);
  function repeatchar(bordchar: Tpzborders; count: integer): string; overload;
  var
    i: integer;
  begin
    result := '';
    for i := 1 to count do
      result := result + pzchars[ord(bordchar)];
  end;
  function repeatchar(thechar: char; count: integer): string; overload;
  var
    i: integer;
  begin
    result := '';
    for i := 1 to count do
      result := result + thechar;
  end;
begin
  msgwidth := 0;
  msgheight := text.Count;
  for i := 0 to pred(text.count) do
  begin
    if length(text[i]) > msgwidth then msgwidth := length(text[i]);
  end;

  hStdout := GetStdHandle(STD_OUTPUT_HANDLE);
  if hStdout = INVALID_HANDLE_VALUE then
    raise Exception.create('ConsoleMessage: Application can not access console output.');
  SetConsoleTextAttribute(hStdout,background_blue or foreground_blue or
    foreground_green or foreground_red or foreground_intensity);

  curline := repeatchar(pzbTopLeft, 1) + repeatchar(pzbTop, msgwidth + 2) + repeatchar(pzbTopRight, 1);
  cursorpos.x := 38 - msgwidth div 2;
  cursorpos.y := 10 - msgheight div 2;
  setconsolecursorposition(hStdOut, cursorpos);
  writeln(curline);
  inc(cursorpos.y);
  for i := 0 to pred(msgheight) do
  begin
    curline := repeatchar(pzbLeft, 1) + ' '+text[i] + repeatchar(' ',msgwidth - length(text[i])) + ' ' + repeatchar(pzbRight, 1);
    setconsolecursorposition(hStdOut, cursorpos);
    writeln(curline);
    inc(cursorpos.y);
  end;
  curline := repeatchar(pzbBottomLeft, 1) + repeatchar(pzbBottom, msgwidth + 2) + repeatchar(pzbBottomRight, 1);
  setconsolecursorposition(hStdOut, cursorpos);
  writeln(curline);
end;

(*
  PW: removed, has a problem whereby "popping up" of windows applications and
  transfer of focus to them is PREVENTED by the method used for console
  input..

function ConsoleQuestion(text: TStrings): boolean;
var
  hStdIn: cardinal;
  buff: _input_record;
  bytesread: cardinal;
  gotanswer: boolean;
begin
  hStdin := GetStdHandle(STD_INPUT_HANDLE);
  if hStdin = INVALID_HANDLE_VALUE then
    raise Exception.create('ConsoleQuestion: Application can not access console input.');
  consolemessage(text);
  gotanswer := false;
  while not(gotanswer) do
  begin
    ReadConsoleInput(hStdIn, buff, 1, bytesread);
    if (buff.EventType = KEY_EVENT) then
      if (buff.Event.KeyEvent.AsciiChar = 'y') or (buff.Event.KeyEvent.AsciiChar = 'Y') then
      begin
        gotanswer := true;
        result := true;
      end
      else
      if (buff.Event.KeyEvent.AsciiChar = 'n') or (buff.Event.KeyEvent.AsciiChar = 'N') then
      begin
        gotanswer := true;
        result := false;
      end;
  end;
end;
*)

function GetPlatform: TWinPlatform;
var
  OsVersion: _OSVERSIONINFOA;
begin
  // PW 11/11/02 Bug.. the size of the structure was not being passed in
  OsVersion.dwOSVersionInfoSize := sizeof(OsVersion);
  if GetVersionEx(OsVersion) = false then
    raise Exception.create('Failed to get OS version information, '+useful.GetLastErrorText);
  case OsVersion.dwMajorVersion of
    4:
      if OsVersion.dwMinorVersion = 0 then
        result := wpNT
      else
        raise Exception.create(format('Unsupported OS version: %d.%d',
          [osversion.dwmajorversion, osversion.dwminorversion]));
    5:
      begin
        case OsVersion.dwMinorVersion of
          0: result := wpWin2000;
          1: result := wpXP;
        else
        raise Exception.create(format('Unsupported OS version: %d.%d',
          [osversion.dwmajorversion, osversion.dwminorversion]));
      end
    end
    else
    raise Exception.create(format('Unsupported OS version: %d.%d',
      [osversion.dwmajorversion, osversion.dwminorversion]));
  end;
{
dwMajorVersion
Major version number of the operating system. This member can be one of the following values.

Operating System Meaning
Windows 95 4
Windows 98 4
Windows Me 4
Windows NT 3.51 3
Windows NT 4.0 4
Windows 2000 5
Windows XP 5
Windows .NET Server 5

dwMinorVersion
Minor version number of the operating system. This member can be one of the following values.

Operating System Meaning
Windows 95 0
Windows 98 10
Windows Me 90
Windows NT 3.51 51
Windows NT 4.0 0
Windows 2000 0
Windows XP 1
Windows .NET Server 2

dwBuildNumber
Windows NT/2000/XP: Build number of the operating system.
Windows 95/98/Me: The low-order word contains the build number of the operating. The high-order word contains the major and minor version numbers.

dwPlatformId
Operating system platform. This member can be one of the following values.

Value Meaning
VER_PLATFORM_WIN32s Win32s on Windows 3.1.
VER_PLATFORM_WIN32_WINDOWS Windows 95, Windows 98, or Windows Me.
VER_PLATFORM_WIN32_NT Windows NT 3.51, Windows NT 4.0, Windows 2000, Windows XP, or Windows .NET Server.
}
end;

procedure GetServers(filter : Dword; const domain : string; list : TStrings);
var
  wServerName: WideString;
  wDomain: WideString;
  pwDomain: PWideChar;
  rv: Dword;
  p: PSERVER_INFO_101;
  buffer: pointer;
  i, entriesRead, totalEntries, MAX_PREFERRED_LENGTH, NIL_HANDLE: Integer;
  ServerName: string;

  NetAPI: THandle;

  _NetServerEnum: function(serverName : PWideChar; level : Integer;
    var BufPtr : Pointer; prefMaxLen : Integer; var entriesRead,
    totalEntries : Integer; servertype : Integer; domain : PWideChar;
    var resume_handle : Integer) : integer; stdcall;

  _NetApiBufferFree: function(BufPtr : pointer): integer; stdcall;
begin
  List.Clear;
  ServerName := '';
  wServerName := ServerName;
  MAX_PREFERRED_LENGTH := -1;
  wDomain := domain;

  if domain = '' then
    pwDomain := Nil
  else
    pwDomain := PWideChar (wDomain);

  NetAPI := SafeLoadLibrary(NetApi32);
  if NetAPI <> 0 then
  begin
    @_NetServerEnum := GetProcAddress(NetAPI, 'NetServerEnum');
    @_NetAPIBufferFree := GetProcAddress(NetAPI, 'NetApiBufferFree');
  end
  else
    Exit;

  rv := _NetServerEnum (PWideChar (wServerName), 101, buffer, MAX_PREFERRED_LENGTH,
    entriesRead,  totalEntries, filter, pwDomain, NIL_HANDLE);

  if rv = ERROR_SUCCESS then
  begin
    try
      p := PSERVER_INFO_101 (buffer);

      for i := 0 to entriesRead - 1 do
      begin
        list.AddObject (p^.lpszServerName , TObject( p^.dwPlatformId));
        Inc(p);
      end;
    finally
      _NetAPIBufferFree(buffer);
    end;
  end
  else
    raise Exception.CreateRes(rv);
end;

function GetShortPathName(input:string):string;
var
  buffer: array[0..512] of char;
begin
  if windows.GetShortPathName(pchar(input), buffer, length(buffer)) <> 0 then
    result := strpas(buffer)
  else
    raise Exception.create('Call to GetShortFileName failed');
end;

{$ifdef ver140}
procedure ConvertUTFToUnicode(infilename: string; outfilename: string);
var
  infile: TFileStream;
  outfile: TFileStream;
  inbuf: array[1..4000] of char;
  outbuf: array[1..9000] of char;
  in_length, out_length: integer;
begin
  infile := TfileStream.create(infilename, fmOpenRead);
  outfile := TFilestream.create(outfilename, fmCreate);
  in_length := 1;
  while in_length > 0 do
  begin
    in_length := 4000;
    in_length := infile.read(inbuf, in_length);
    if in_length > 0 then
    begin
      out_length := pred(utf8tounicode(PWideChar(@outbuf), 9000, PChar(@inbuf), in_length));
      outfile.Write(outbuf, out_length * 2);
    end;
  end;
  infile.free;
  outfile.free;
end;
{$endif}

function TImportExport.GetItem(Index: Integer): TImportExportItem;
begin
  Result := TImportExportItem(inherited GetItem(Index));
end;

procedure TImportExport.SetItem(Index: Integer; Value: TImportExportItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TImportExport.Update(Item: TCollectionItem);
begin
   {Nothing for now}
end;

function TImportExport.Add: TImportExportItem;
begin
  Result := TImportExportItem(inherited Add);
end;

constructor TPEFileInfo.Create(const FName: string; NType: TNumberType);
begin
  inherited Create;
  NumberType := NType;
  FImportList := TStringList.Create;
  FExportList := TStringList.Create;
  FMSDOSHeader := TStringList.Create;
  FPEHEaderList := TStringList.Create;
  FPEOptionalHeaderList := TStringList.Create;

  FFileName := FName;
  FIsPE := False;
  FIsMSDos := False;
  ReadPEFileFormat;
end;

destructor TPEFileInfo.Destroy;
var
  i: Integer;
begin
  FreeAndNil(FMSDOSHeader);
  FreeAndNil(FPEHeaderList);
  FreeAndNil(FPEOptionalHeaderList);
  FreeAndNil(FExportList);

  if Assigned(FImportList) then
  begin
    for i := 0 to FImportList.Count-1 do
      TImportExport(FImportList.Objects[i]).Free;

    FreeAndNil(FImportList);
  end;

  inherited Destroy;
end;

function TPEFileInfo.IntToNum(n: Integer): string;

  function IntToHex(IntVal: Integer): AnsiString;
  type
    TIntegerCast = packed array[0..SizeOf(Integer)-1] of Byte;
  const
    HexTransform: array[$0..$F] of Char =
      ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
    Width = 16;
  var
    I: Integer;
    SIndex: Integer;
  begin
    SetLength(Result, Width);
    FillChar(PChar(Result)^, Width, '0');
    SIndex := Length(Result);
    for i := 0 to SizeOf(Integer)-1 do
    begin
      Result[SIndex] := HexTransform[TIntegerCast(IntVal)[i] and $0F];
      Dec(SIndex);
      Result[SIndex] := HexTransform[(TIntegerCast(IntVal)[i] shr 4) and $0F];
      Dec(SIndex);
    end;
  end;

const // Duplicated here for use outside of GExperts
  GXHexPrefix = {$IFDEF GX_BCB}'0x'{$ELSE}'$'{$ENDIF};
begin
  try
    case FNumberType of
      ntDecimal: Result := IntToStr(n);
      {$IFDEF LEADING0}
      ntHex: Result := IntToHex(n);
      {$ELSE}
      ntHex: Result := Format(GXHexPrefix+'%x', [n]);
      {$ENDIF LEADING0}
    end;
  except
    on E: EConvertError do
      Result := '';
  end;
end;

procedure TPEFileInfo.ReadPEFileFormat;
resourcestring
  SNotPeFile = 'Not a PE File';
var
  PE: array[0..3] of Char;
begin
  FStream := TFileStream.Create(Filename, fmOpenRead + fmShareDenyNone);
  try
    FStream.Read(FDosHeader, 64);

    FIsMSDos := (FDosHeader.e_magic = $5A4D);

    FStream.Position := FDosHeader.e_lfanew;
    FStream.Read(PE, 4);
    if (PE[0] = 'P') and (PE[1] = 'E') and (PE[2] = #0) and (PE[3] = #0) then
      FIsPE := True;
    FillMSDosHeader;
    if not FIsPE then
    begin
      FPEHEaderList.Add(SNotPeFile);
      Exit;
    end;
    FStream.Read(FPEHeader, 20);
    FStream.Read(FPEOptionalHeader, SizeOf(FPEOptionalHeader));
    FSectionStart := FStream.Position;
    ReadImportList;
    ReadExportList;
    FillPEOptionalHeader;
    FillPEHeader;
  finally
    FreeAndNil(FStream);
  end;
end;

procedure TPEFileInfo.ReadImportList;

  function GetName(L: Integer): string;
  var
    SPos: Integer;
    Buf: array[0..1024] of Char;
  begin
    SPos := FStream.Position;
    FStream.Position := L;
    FStream.Read(Buf, 1024);
    Result := StrPas(Buf);
    FStream.Position := SPos;
  end;

var
  Import: PEImportDescriptors;
  Delta, p: Integer;
  SectionHeader: ImageSectionHeader;
  Name: string;
  ImpExp: TImportExport;
begin
  FImportList.Sorted := False;
  FImportList.Clear;
  if not GetEnclosingSectionHeader(FPEOptionalHeader.DataDirectories[1].VirtualAddress, SectionHeader) then
    Exit;
  Delta := SectionHeader.VirtualAddress - SectionHeader.PointerToRawData;
  FStream.Position := FPEOptionalHeader.DataDirectories[1].VirtualAddress - Delta;
  FStream.Read(Import, SizeOf(Import));
  while (Import.Name <> 0) and (FStream.Position < FStream.Size) do
  begin
    Name := GetName(Import.Name - Delta);
    if FImportList.Indexof(Name) < 0 then
    begin
      ImpExp := TImportExport.Create(TImportExportItem);
      ImpExp.PEName := Name;
      FImportList.AddObject(Name, ImpExp);
    end;
    p := FImportList.Indexof(Name);
    GetImportFunctions(Import, Delta, TImportExport(FImportList.Objects[p]));
    FStream.Read(Import, SizeOf(Import));
  end;
  FImportList.Sorted := True;
end;

procedure TPEFileInfo.GetImportFunctions(const Import: PEImportDescriptors; Delta: Integer; ImpExp: TImportExport);
var
  Thunk: Integer;
  SPos, p: Integer;
  ThunkData: Thunk_Data;
  ImpF: Import_Function;
begin
  SPos := FStream.Position;
  try
    if Import.Characteristics = 0 then
      Thunk := Import.FirstThunk - Delta
    else
      Thunk := Import.Characteristics - Delta;
    FStream.Position := Thunk;
    FStream.Read(ThunkData, SizeOf(ThunkData));
    while (FStream.Position < FStream.Size) and (ThunkData.AddressOfData <> 0) do
    begin
      p := FStream.Position;
      if ThunkData.AddressOfData < 0 then
      begin {Imported by Ordinal}
        FStream.Position := Thunk;
        with ImpExp.Add do
        begin
          Ordinal := Word(ThunkData.AddressOfData);
          FunctionName := '';
        end;
      end
      else
      begin
        FStream.Position := ThunkData.AddressOfData - Delta;
        FStream.Read(ImpF, SizeOf(ImpF));
        with ImpExp.Add do
        begin
          Ordinal := ImpF.Ordinal;
          FunctionName := StrPas(ImpF.Name);
        end;
      end;
      FStream.Position := p;
      FStream.Read(ThunkData, SizeOf(ThunkData));
    end;
  finally
    FStream.Position := SPos;
  end;
end;

function TPEFileInfo.GetEnclosingSectionHeader(rva: Integer; var SectionHeader: ImageSectionHeader): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to FPEHeader.NumberOfSections-1 do
  begin
    FStream.Position := FSectionStart + SizeOf(SectionHeader) * i;
    FStream.Read(SectionHeader, SizeOf(SectionHeader));
    if (rva >= SectionHeader.VirtualAddress) and
       (rva < SectionHeader.VirtualAddress + SectionHeader.VirtualSize) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

procedure TPEFileInfo.ReadExportList;
var
  SectionHeader: ImageSectionHeader;
  ExportAddress: Integer;
  NameAddress: Integer;
  Buffer: array[0..255] of Char;
  j: Integer;
  MaxExports: Longint;
  Ordinal: Word;
  ExportVA: DWORD;
  ExportInfo: PEExportImage;
  Delta: Integer;
begin
  FExportList.Clear;
  with FPEOptionalHeader.DataDirectories[0] do
    ExportVA := VirtualAddress;
  if not GetEnclosingSectionHeader(ExportVA, SectionHeader) then
    Exit;
  Delta := SectionHeader.VirtualAddress - SectionHeader.PointerToRawData;
  FStream.Position := Longint(ExportVA) - Delta;
  FStream.Read(ExportInfo, SizeOf(ExportInfo));
  if ExportInfo.Characteristics <> 0 then
    Exit;
  FStream.Position := Longint(ExportInfo.Name) - Delta;
  with ExportInfo do
  begin
    MaxExports := NumberOfFunctions;
    if NumberOfNames < MaxExports then
      MaxExports := NumberOfNames;
  end;
  FExportList.Sorted := False;
  try
    FExportList.Capacity := MaxExports;
    FStream.Position := LongInt(ExportInfo.AddressOfNameOrdinals) - Delta;
    for j := 0 to MaxExports-1 do
    begin
      FStream.ReadBuffer(Ordinal, SizeOf(Ordinal));
      FExportList.Add(#9 + IntToNum(Ordinal + ExportInfo.Base) + #9);
    end;
    // Now read the names themselves
    for j := 0 to MaxExports-1 do
    begin
      FStream.Position := (LongInt(ExportInfo.AddressOfNames) - Delta)
                          + (j * SizeOf(NameAddress));
      FStream.ReadBuffer(NameAddress, SizeOf(NameAddress));
      FStream.Position := NameAddress - Delta;
      FStream.Read(Buffer, SizeOf(Buffer));
      FExportList[j] := StrPas(Buffer) + FExportList[j];
    end;
    // And finally read the function associated with each export
    FStream.Position := LongInt(ExportInfo.AddressOfFunctions) - Delta;
    for j := 0 to MaxExports-1 do
    begin
      FStream.ReadBuffer(ExportAddress, SizeOf(ExportAddress));
      FExportList[j] := FExportList[j] + IntToNum(ExportAddress);
    end;
  finally
    FExportList.Sorted := True;
  end;
end;

function TPEFileInfo.GetCPUType: string;
resourcestring
  SIntel_80386 = 'Intel 80386';
  SIntel_80486 = 'Intel 80486';
  SIntel_Pentium = 'Intel Pentium';
  SMIPS_R3000_BigEndian = 'MIPS R3000 (Big Endian)?';
  SMIPS_Mark_I = 'MIPS Mark I (R2000, R3000)';
  SMIPS_Mark_II = 'MIPS Mark II (R6000)';
  SMIPS_Mark_III = 'MIPS Mark III (R4000)';
  SMIPS_R10000 = 'MIPS R10000';
  SDEC_Alpha_XP = 'DEC Alpha XP';
  SPower_PC = 'Power PC';
  SMotorola_68000 = 'Motorola 68000';
  SPA_RISC = 'PA RISC';
  SUnknown_CPU = 'Unknown CPU';
begin
  if not isPE then
  begin
    Result := '';
    Exit;
  end;
  case FPEHeader.Machine of
    $14C: Result := SIntel_80386;
    $14D: Result := SIntel_80486;
    $14E: Result := SIntel_Pentium;
    $160: Result := SMIPS_R3000_BigEndian;
    $162: Result := SMIPS_Mark_I;
    $163: Result := SMIPS_Mark_II;
    $166: Result := SMIPS_Mark_III;
    $168: Result := SMIPS_R10000;
    $184: Result := SDEC_Alpha_XP;
    $1F0: Result := SPower_PC;
    $268: Result := SMotorola_68000;
    $290: Result := SPA_RISC;
  else
    Result := SUnknown_CPU;
  end;
end;

procedure TPEFileInfo.FillMSDOSHeader;
resourcestring
  SMagicNumber = 'Magic number';
  SBytesOnLastPage = 'Bytes on last page of file';
  SPagesInFile = 'Pages in file';
  SRelocations = 'Relocations';
  SSizeOfHeaderInParagraphs = 'Size of header in paragraphs';
  SMinimumExtraParagraphs = 'Minimum extra paragraphs';
  SMaximumExtraParagraphs = 'Maximum extra paragraphs';
  SInitialSS = 'Initial (relative) SS value';
  SInitialSP = 'Initial SP value';
  SChecksum = 'Checksum';
  SInitialIP = 'Initial IP value';
  SInitialCS = 'Initial (relative) CS value';
  SFileAddressRelocation = 'File address of relocation table';
  SOverlayNumber = 'Overlay number';
  // SReservedWords = 'Reserved words';
  SOemIdentifier = 'OEM identifier';
  SOemInformation = 'OEM information';
  SPeHeaderAddress = 'PE header address';
begin
  FMSDOSHeader.Clear;
  with FMSDOSHeader, FDOSHeader do
  begin
    Add(SMagicNumber + #9 + IntToNum(e_magic));
    Add(SBytesOnLastPage + #9 + IntToNum(e_cblp));
    Add(SPagesInFile + #9 + IntToNum(e_cp));
    Add(SRelocations + #9 + IntToNum(e_crcl));
    Add(SSizeOfHeaderInParagraphs + #9 + IntToNum(e_cparhdr));
    Add(SMinimumExtraParagraphs + #9 + IntToNum(e_minAlloc));
    Add(SMaximumExtraParagraphs + #9 + IntToNum(e_maxAlloc));
    Add(SInitialSS + #9 + IntToNum(e_ss));
    Add(SInitialSP + #9 + IntToNum(e_sp));
    Add(SChecksum + #9 + IntToNum(e_csum));
    Add(SInitialIP + #9 + IntToNum(e_ip));
    Add(SInitialCS + #9 + IntToNum(e_cs));
    Add(SFileAddressRelocation + #9 + IntToNum(e_lfarclc));
    Add(SOverlayNumber + #9 + IntToNum(e_ovno));
    // Add(SReserved words #9 + IntToNum(e_res));
    Add(SOemIdentifier + #9 + IntToNum(e_oemid));
    Add(SOemInformation + #9 + IntToNum(e_oemInfo));
    Add(SPeHeaderAddress + #9 + IntToNum(e_lfanew));
  end;
end;

procedure TPEFileInfo.FillPEHeader;
resourcestring
  SMachine = 'Machine';
  SNumberSections = 'Number of sections';
  STimeDate = 'Time/Date stamp';
  SAddressSymbolTable = 'Address of symbol table';
  SNumberSymbols = 'Number of symbols';
  SSizeOptionalHeader = 'Size of optional header';
  SCharacteristics = 'Characteristics';
begin
  FPEHeaderList.Clear;
  with FPEHeaderList, FPEHEader do
  begin
    Add(SMachine + #9 + CPUType);
    Add(SNumberSections + #9 + IntToNum(NumberofSections));
    Add(STimeDate + #9 + IntToNum(TimeDateStamp));
    Add(SAddressSymbolTable + #9 + IntToNum(PointerToSymboltable));
    Add(SNumberSymbols + #9 + IntToNum(NumberofSymbols));
    Add(SSizeOptionalHeader + #9 + IntToNum(SizeOfOptionalHeader));
    Add(SCharacteristics + #9 + IntToNum(Characteristics));
  end;
end;

procedure TPEFileInfo.FillPEOptionalHeader;
resourcestring
  SMagic = 'Magic';
  SMajorLinker = 'Major linker version';
  SMinorLinker = 'Minor linker version';
  SSizeCode = 'Size of Code';
  SInitializedData = 'Size of initialized data';
  SUninitializedData = 'Size of uninitialized data';
  SAddressEntryPoint = 'Address of entry point';
  SBaseCode = 'Base of code';
  SBaseData = 'Base of data';
  SImageBase = 'Image base';
  SSectionAlignment = 'Section alignment';
  SFileAlignment = 'File alignment';
  SMajorOs = 'Major OS version';
  SMinorOs = 'Minor OS version';
  SMajorImage = 'Major image version';
  SMinorImage = 'Minor image version';
  SMajorSubsystem = 'Major subsystem version';
  SMinorSubsystem = 'Minor subsystem version';
  SWin32Version = 'Win32 Version';
  SSizeImage = 'Size of image';
  SSizeHeaders = 'Size of headers';
  SCrc = 'CRC Checksum';

  SSub = 'Subsystem';
  SSubNative = 'Native, no subsystem required';
  SSubWinGui = 'Windows GUI subsystem required';
  SSubWinConsole = 'Windows console subsystem required';
  SSubOs2Console = 'OS/2 console subsystem required';
  SSubPosix = 'POSIX console subsystem required';

  SDll = 'DLL Characteristics';
  SDllPerProcessInit = 'Per-process library initialization';
  SDllPerProcessTermination = 'Per-process library termination';
  SDllPerThreadInit = 'Per-thread library initialization';
  SDllPerThreadTermination = 'Per-thread library termination';

  SStackReserve = 'Size of stack reserve';
  SStackCommit = 'Size of stack commit';
  SHeapReserve = 'Size of heap reserve';
  SHeapCommit = 'Size of heap commit';

  SLoaderFlags = 'Loader Flags';
  SLoaderFlagsBP = 'Invoke a breakpoint before starting process';
  SLoaderFlagsDBG = 'Invoke a debugger after process has been loaded';
  SLoaderFlagsNone = 'No flags set';

  SNumDataEntries = 'Number of entries in data directory';

begin
  FPEOptionalHEaderList.Clear;
  with FPEOptionalHeaderList, FPEOptionalHeader do
  begin
    Add(SMagic + #9 + IntToNum(Magic));
    Add(SMajorLinker + #9 + IntToNum(MajorLinkerVersion));
    Add(SMinorLinker + #9 + IntToNum(MinorLinkerVersion));
    Add(SSizeCode + #9 + IntToNum(SizeOfCode));
    Add(SInitializedData + #9 + IntToNum(SizeOfInitializedData));
    Add(SUninitializedData + #9 + IntToNum(SizeOfUninitializedData));
    Add(SAddressEntryPoint + #9 + IntToNum(AddressOfEntryPoint));
    Add(SBaseCode + #9 + IntToNum(BaseofCode));
    Add(SBaseData + #9 + IntToNum(baseofdata));
    Add(SImageBase + #9 + IntToNum(imagebase));
    Add(SSectionAlignment + #9 + IntToNum(sectionalignment));
    Add(SFileAlignment + #9 + IntToNum(filealignment));
    Add(sMajorOS + #9 + IntToNum(MajorOperatingSystemVersion));
    Add(SMinorOS + #9 + IntToNum(MinorOperatingSystemVersion));
    Add(SMajorImage + #9 + IntToNum(MajorImageVersion));
    Add(SMinorImage + #9 + IntToNum(MinorImageVersion));
    Add(SMajorSubsystem + #9 + IntToNum(MajorSubsystemVersion));
    Add(SMinorSubsystem + #9 + IntToNum(MinorSubsystemVersion));
    Add(SWin32Version + #9 + IntToNum(Win32Version));
    Add(SSizeImage + #9 + IntToNum(SizeOfImage));
    Add(SSizeHeaders + #9 + IntToNum(SizeOfHeaders));
    Add(SCRC + #9 + IntToNum(Checksum));
    case Subsystem of
      1: Add(SSub + #9 + SSubNative);
      2: Add(SSub + #9 + SSubWinGUI);
      3: Add(SSub + #9 + SSubWinConsole);
      5: Add(SSub + #9 + SSubOS2Console);
      7: Add(SSub + #9 + SSubPOSIX);
    end;
    if ((DLLCharacteristics and $0001) > 0) then
      Add(SDll + #9 + SDllPerProcessInit);
    if ((DLLCharacteristics and $0002) > 0) then
      Add(SDll + #9 + SDllPerProcessTermination);
    if ((DLLCharacteristics and $0004) > 0) then
      Add(SDll + #9 + SDllPerThreadInit);
    if ((DLLCharacteristics and $0008) > 0) then
      Add(SDll + #9 + SDllPerThreadTermination);
    Add(SStackReserve + #9 + IntToNum(SizeOfStackReserve));
    Add(SStackCommit + #9 + IntToNum(SizeOfStackCommit));
    Add(SHeapReserve + #9 + IntToNum(SizeOfHeapReserve));
    Add(SHeapCommit + #9 + IntToNum(SizeOfHeapCommit));
    case LoaderFlags of
      1: Add(SLoaderFlags + #9 + SLoaderFlagsBP);
      2: Add(SLoaderFlags + #9 + SLoaderFlagsDBG);
    else
      Add(SLoaderFlags + #9 + SLoaderFlagsNone);
    end;
    Add(SNumDataEntries + #9 + IntToNum(NumberofRVAandSizes));
  end;
end;

function TPEFileInfo.GetExportList: TStrings;
begin
  Result := FExportList;
end;

function TPEFileInfo.GetImportList: TStrings;
begin
  Result := FImportList;
end;

function TPEFileInfo.GetMSDOSHeader: TStrings;
begin
  Result := FMSDOSHeader;
end;

function TPEFileInfo.GetPEHeaderList: TStrings;
begin
  Result := FPEHEaderList;
end;

function TPEFileInfo.GetPEOptionalHeaderList: TStrings;
begin
  Result := FPEOptionalHeaderList;
end;

function GetDLLExportFunctions(DLLFileName: string): string;
var
  PEInfo: TPEFileInfo;
  i: integer;
  TempList: TStringList;
begin
  if DirectoryExists(DLLFileName) then
    raise Exception.Create('PE information is not available for directories');

  PEInfo := TPEFileInfo.Create(DLLFileName, ntHex);

  TempList := TStringList.Create;

  try
    TempList.CommaText := PEInfo.ExportList.CommaText;

    for i := 0 to TempList.Count - 1 do
      TempList.Strings[i] := Copy(TempList.Strings[i], 1, pos(#9, TempList.Strings[i]) - 1);

    Result := TempList.CommaText;
  finally
    TempList.Free;
  end;

  PEInfo.Free;
end;

function GetStringResource(ResourceName, ResourceType: string): string;
var
  HRes: cardinal;
  ResSize: integer;
  PRes: pointer;
  ResNameBuff: pchar;
  ResTypeBuff: pchar;
begin
  ResNameBuff := AllocMem(255);
  ResTypeBuff := AllocMem(255);
  StrPCopy(ResNameBuff, ResourceName);
  StrPCopy(ResTypeBuff, ResourceType);
  hRes := FindResource(hInstance, ResNameBuff, ResTypeBuff);
  FreeMem(ResNameBuff);
  FreeMem(ResTypeBuff);
  if hRes = 0 then
    raise exception.Create('Could not find string resource "'+ResourceName+'"');
  {get the aligned size of the resource}
  ResSize := SizeOfResource(HInstance, hRes);
  if ResSize = 0 then
    raise Exception.Create('Nothing to load - resource size = 0');
  {load the resource}
  hRes := LoadResource(hInstance, hRes);
  if hRes = 0 then
    raise exception.create('Failed to load string resource');
 {Get a pointer to the resource}
  pRes := LockResource(hRes);
  if pRes = nil then begin
    FreeResource(hRes);
    raise Exception.create('Failed to lock string resource');
  end;
  {write the resource out to a file}
  Result := StrPas(PChar(PRes));
  // strpas stops when it reaches a zero terminator.. should really replace
  // with a routine to just copy X bytes (X given by ResSize). as it happens,
  // the whole resource block is always zero terminated (well maybe only as long
  // as it isn't a multiple of some block size...) so this works for now.
  SetLength(Result, ResSize);
  {unlock and free the resource}
  UnLockResource(hRes);
  FreeResource(hRes);
end;

function GetSQLDate(Date: TDateTime): string;
begin
  if Date = 0 then
    Result := 'null'
  else
    Result := QuotedStr(FormatDateTime('yyyymmdd', Date));
end;

function GetSafeSQLColumnName(Input:string): string;
var
  i: integer;
  OutCount: integer;
begin
  // Replace underscore or space with an underscore, otherwise only alphabetical or numeric
  // chars are allowed
  SetLength(Result, Length(Input));
  OutCount := 0;
  for i := 1 to Length(Input) do
  begin
    if ((Input[i] >= 'a') and (Input[i] <= 'z'))
      or ((Input[i] >= 'A') and (Input[i] <= 'Z'))
      or ((Input[i] >= '0') and (Input[i] <= '9'))
      or (Input[i] = ' ') or (Input[i] = '_') then
    begin
      Inc(OutCount);
      if (Input[i] = ' ') or (Input[i] = '_') then
        Result[OutCount] := '_'
      else
        Result[OutCount] := Input[i];
    end;
  end;
  If OutCount = 0 then
    raise Exception.Create('Bad fieldname passed to GetSafeColumnName');
  SetLength(Result, OutCount);
end;

function GetJoinAlias(Input: integer): string;
begin
  Result := '';
  repeat
    Result := Chr(Ord('a')+input mod 26) + Result;
    Input := (Input div 26) - 1;
  until input < 0;

  if Length(Result) > 1 then
    Result := 'z'+Result;
  exit;


  if Input <= 25 then
    Result := Chr(Ord('a')+input)
  else
  if Input <= 276 then
    Result := 'z' + Chr(Ord('a') + input div 26) + Chr(Ord('a') + input mod 26)
  else
  if Input < 17576 then
  begin
    Result := 'z';
    Result := Result + Chr(Ord('a') + Input div 276);
    Input := Input mod 276;
    Result := Result + Chr(Ord('a') + Input div 26);
    Input := Input mod 26;
    Result := Chr(Ord('a')+input)
  end
  else
    raise Exception.Create('Too-high input passed to GetJoinAlias');

end;

function GetBCPPath: string;
var
  ProgramFilesDir: String;
begin
  ProgramFilesDir := EnsureTrailingSlash(GetProgramFilesDir);

  // TODO: Use a more watertight method to find BCP version for the correct
  // SQL client tools version
  if FileExists(ProgramFilesDir + 'Zonal\Aztec\Tools\BCP\bcp.exe') then
    Result := ProgramFilesDir + 'Zonal\Aztec\Tools\BCP\bcp.exe'
  else
  if FileExists('C:\Program Files\Microsoft SQL Server\90\Tools\Binn\bcp.exe') then
    Result := 'C:\Program Files\Microsoft SQL Server\90\Tools\Binn\bcp.exe'
  else
  if FileExists('C:\Program Files\Microsoft SQL Server\80\Tools\Binn\bcp.exe') then
    Result := 'C:\Program Files\Microsoft SQL Server\80\Tools\Binn\bcp.exe'
  else
    Result := 'bcp.exe';
end;

function GetTerminalServicesSessionID: integer;
type
  TProcessIdToSessionId = function(dwProcessID: cardinal; var pSessionId: cardinal): bool; stdcall;
var
  hDll: cardinal;
  TmpSessID: cardinal;
  FunctionRef: TProcessIdToSessionID;
begin
  hDll := SafeLoadLibrary('kernel32.dll');
  if hDll <> 0 then
  begin
    FunctionRef := GetProcAddress(hDll, 'ProcessIdToSessionId');
    if FunctionRef(GetCurrentProcessId, TmpSessId) then
      Result := TmpSessId
    else
      Result := -1;
    FreeLibrary(hDll);
  end
  else
    Result := -1;
end;

function CompareAlphaNumeric(leftString, rightString: string): integer;
// based on algoriithm from http://www.davekoelle.com/alphanum.html
// similar output to AnsiCompareText (which it uses)
type
  ChunkType = (AlphaNumeric, Numeric);
var
  leftIndex, rightIndex: integer;
  leftChar, rightChar: char;
  leftChunk, rightChunk: string;

  function InChunk(ch, otherCh: char): boolean;
  var
    ctype: ChunkType;
  begin
    ctype := AlphaNumeric;
    if IsNumeric(otherCh) then
      ctype := Numeric;
    if ((ctype = AlphaNumeric) and IsNumeric(ch)) or ((ctype = Numeric) and not(IsNumeric(ch))) then
      result := false
    else
      result := true;
  end;

begin
  result := 0;
  if (Length(leftString) = 0) and (Length(rightString) = 0) then
    exit;

  leftIndex := 1;
  rightIndex := 1;

  while ((leftIndex <= Length(leftString)) or (rightIndex <= Length(rightString))) do
  begin
    if (leftIndex > Length(leftString)) then
    begin
      result := -1;
      exit;
    end
    else
    if (rightIndex > Length(rightString)) then
    begin
      result := 1;
      exit;
    end;
    leftChar := leftString[leftIndex];
    rightChar := rightString[rightIndex];
    leftChunk := '';
    rightChunk := '';

    while ((leftIndex <= Length(leftString)) and ((Length(leftChunk)=0) or InChunk(leftChar, leftChunk[1]))) do
    begin
      leftChunk := leftChunk + leftChar;
      Inc(leftIndex);
      if leftIndex <= Length(leftString) then
        leftChar := leftString[leftIndex];
    end;

    while ((rightIndex <= Length(rightString)) and ((Length(rightChunk)=0) or InChunk(rightChar, rightChunk[1]))) do
    begin
      rightChunk := rightChunk + rightChar;
      Inc(rightIndex);
      if rightIndex <= Length(rightString) then
        rightChar := rightString[rightIndex];
    end;

    // If both chunks contain numeric characters, sort them numerically
    if (Length(leftChunk) > 0) and (Length(rightChunk) > 0) and IsNumeric(leftChunk[1]) and IsNumeric(rightChunk[1]) then
    begin
      if StrToIntDef(leftChunk, 0) < StrToIntDef(rightChunk, 0) then
        result := -1
      else
      if StrToIntDef(leftChunk, 0) > StrToIntDef(rightChunk, 0) then
        result := 1;
    end
    else
      result := AnsiCompareText(leftChunk, rightChunk);
    if result <> 0 then
      exit;
  end;
end;

function StringGreaterThan(Left,
  Right: string): boolean;
var
  i: integer;
begin
  // trim leading zeroes
  while (Length(Left) > 0) and (Left[1] = '0') do
    Delete(Left, 1, 1);
  while (Length(Right) > 0) and (Right[1] = '0') do
    Delete(Right, 1, 1);
  if Length(Left) > Length(Right) then
    Result := TRUE
  else
  if Length(Left) < Length(Right) then
    Result := FALSE
  else
  begin
    Result := FALSE;
    for i := 1 to Length(Left) do
    begin
      if Left[i] > Right[i] then
      begin
        Result := TRUE;
        break;
      end
      else
      if Left[i] < Right[i] then
      begin
        Result := FALSE;
        break;
      end;
    end;
  end;
end;

function IncString(strValue : string): string;
const
  valueArray: array [1..9] of char = ('1', '2', '3', '4', '5', '6', '7', '8', '9');
var i : integer;
begin
  for i := Length(strValue) downto 1 do
  begin
    if StrToInt(strValue[i]) < 9 then
       begin
         strValue[i] := valueArray[StrToInt(strValue[i]) + 1];
         Result := strValue;
         break;
       end
    else
    if (StrToInt(strValue[i]) = 9) and (i > 1) then
        strValue[i] := '0'
    else
    if (StrToInt(strValue[i]) = 9) and  (i = 1) then
       begin
         strValue[i] := '0';
         Result := '1'+ strValue;
         break;
       end;
  end;
end;

function DecString(strValue : string): string;
const
  valueArray: array [1..9] of char = ('0', '1', '2', '3', '4', '5', '6', '7', '8');
var i : integer;
begin
  for i := Length(strValue) downto 1 do
  begin
    if StrToInt(strValue[i]) > 0 then
       begin
         strValue[i] := valueArray[StrToInt(strValue[i])];
         Result := strValue;
         break;
       end
    else
    if (StrToInt(strValue[i]) = 0) and (i > 1) then
        strValue[i] := '9';
  end;

  if (StrToInt(strValue[1]) = 0) then
     begin
       Delete(strValue, 1, 1);
       Result := strValue;
     end;

end;

//The checksum is a Modulo 10 calculation.
//1. Add the values of the digits in positions 1, 3, 5, 7, 9, and 11.
//2. Multiply this result by 3.
//3. Add the values of the digits in positions 2, 4, 6, 8, and 10.
//4. Sum the results of steps 2 and 3.
//5. The check character is the smallest number which, when added to the result in step 4, produces a multiple of 10.
function IsValidBarcode(Barcode: String): Boolean;
var
  i, Checksum, TestChecksum, Odds, Evens: integer;
  Target: String;
begin
  result := False;
  Odds := 0;
  Evens := 0;
  if Length(Barcode) = 0 then
    Result := True
  else if Length(Barcode) = 12 then
  begin
    Checksum := StrToInt(Copy(barcode,12,1));
    Target := Copy(Barcode,1,11);
    for i := 1 to 11 do
      if (i mod 2) = 0 then
        Evens := Evens + StrtoInt(Copy(Target,i,1))
      else
        Odds := Odds + (3*StrtoInt(Copy(Target,i,1)));
    TestChecksum := (10 - ((Odds + Evens) mod 10)) mod 10;

    Result := TestChecksum = Checksum;
  end;
end;

function ExecuteBatchFileAndCapture(FileName, Params, Dir: string; CaptureData: TStrings; showcmd: cardinal = SW_HIDE): boolean;
const
  ReadBufferDefaultSize = 19200;
var
  ReadBuffer: DWord;
  Security: TSecurityAttributes;
  ReadPipe, WritePipe: THandle;
  SInfo: TStartupInfo;
  PInfo: TProcessInformation;
  Buffer: Pchar;
  BytesRead: DWord;

  procedure ReadFromPipe;
  var
    BytesRemaining: integer;
  begin
    BytesRemaining := 1;
    PeekNamedPipe(ReadPipe, Buffer, ReadBuffer, @BytesRead, @BytesRemaining, nil);
    while (BytesRemaining > 0) do
    begin
      BytesRead := 0;
      ReadFile(ReadPipe,Buffer[0], ReadBuffer,BytesRead,nil) ;
      Dec(BytesRemaining, BytesRead);
      Buffer[BytesRead]:= #0;
      OemToAnsi(Buffer,Buffer) ;
      CaptureData.Text := CaptureData.Text + string(Buffer);
    end;
  end;

begin
  if not Assigned(CaptureData) then
  begin
    result := ExecuteBatchFileAndWait(FileName, Params, Dir, ShowCmd);
    exit;
  end;

  ReadBuffer := ReadBufferDefaultSize;
  if DWord(CaptureData.Capacity) > ReadBuffer then
    ReadBuffer := CaptureData.Capacity;

  with Security do
  begin
    nlength := SizeOf(TSecurityAttributes);
    bInheritHandle := true;
    lpSecurityDescriptor := nil;
  end;

  if Dir = '' then
    Dir := GetCurrentDir;

  Result := false;
  if CreatePipe(ReadPipe, WritePipe, @Security, 0) then
  begin
    Buffer := AllocMem(ReadBuffer + 1);
    FillChar(SInfo, Sizeof(SInfo), #0);
    SInfo.cb := Sizeof(SInfo);
    SInfo.dwFlags := STARTF_USESHOWWINDOW + STARTF_USESTDHANDLES;
    SInfo.wShowWindow := showcmd;
    SInfo.hStdInput := GetStdHandle(STD_INPUT_HANDLE);
    SInfo.hStdOutput := WritePipe;
    SInfo.hStdError := WritePipe;

    if CreateProcess(nil, pchar(filename + ' ' + Params), @Security, @Security, true,
      NORMAL_PRIORITY_CLASS, nil, pchar(Dir),
      SInfo, PInfo) then
    begin
      {busy wait, processing messages}
      while WaitForSingleObject(Pinfo.hProcess, 100) <> WAIT_OBJECT_0 do
      begin
        ReadFromPipe;
        ProcessPaintMessages;
      end;
      ReadFromPipe;

      result := true;
      FreeMem(Buffer);
      CloseHandle(pinfo.hprocess);
      CloseHandle(pinfo.hThread);
      CloseHandle(ReadPipe);
      CloseHandle(WritePipe);
    end
  end;
end;

procedure ConvertMouseWheelMessageToCursorKey(var msg : tagMSG; var Handled: Boolean);
var
   i: SmallInt;
begin
  if Msg.message = WM_MOUSEWHEEL then
  begin
    Msg.message := WM_KEYDOWN;
    Msg.lParam := 0;
    i := HiWord(Msg.wParam) ;
    if i > 0 then
      Msg.wParam := VK_UP
    else
      Msg.wParam := VK_DOWN;

     Handled := False;
  end;
end;

function IndexStr(const AText: String;
                  const AValues: array of String;
                  const CaseSensitive: Boolean): Integer;
begin
  if CaseSensitive then
  begin
    Result := ANSIIndexStr(AText, AValues);
  end
  else begin
    Result := ANSIIndexText(AText, AValues);
  end;
end;

end.