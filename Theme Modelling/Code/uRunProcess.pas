unit uRunProcess;

interface

uses windows;

type
  TRunProcess = class(TObject)
  private
    HandlesOpen: boolean;
    SInfo: TStartupInfo;
    PInfo: TProcessInformation;
    ExitStatus: cardinal;
    MainWindowHandle: cardinal;
    procedure CloseHandles;
    procedure ScanForMainHWND;
  public
    destructor Destroy; override;
    procedure Start(FileName, Params, WorkingDirectory: string; Show: boolean = true);
    function HasExited: boolean;
    procedure BringToFront;
    procedure Stop;
  end;

implementation

uses sysutils, useful;

{ TRunProcess }

procedure TRunProcess.BringToFront;
begin
  ScanForMainHWND;
  BringWindowToTop(MainWindowHandle)
end;

procedure TRunProcess.CloseHandles;
begin
  if HandlesOpen then
  begin
    CloseHandle(PInfo.hProcess);
    CloseHandle(PInfo.hThread);
    HandlesOpen := false;
  end;
end;

destructor TRunProcess.Destroy;
begin
  if not HasExited then Stop;
  CloseHandles;
  inherited;
end;

function TRunProcess.HasExited: boolean;
begin
   GetExitCodeProcess(PInfo.hProcess, ExitStatus);
   Result := ExitStatus <> STILL_ACTIVE;
end;

var
  EnumResult: cardinal;

function EnumWindowProc(HWnd: cardinal; lParam: cardinal): bool; stdcall;
begin
  if GetWindowThreadProcessId(hWnd) = lParam then
  begin
    EnumResult := HWnd;
    result := false;
  end
  else
    result := true;
end;

procedure TRunProcess.ScanForMainHWND;
var
  DeskTop: cardinal;
begin
  DeskTop := GetThreadDesktop(GetCurrentThreadId);
  EnumDesktopWindows(DeskTop, @EnumWindowProc, PInfo.dwThreadId);
  MainWindowHandle := EnumResult;
end;

procedure TRunProcess.Start(FileName, Params, WorkingDirectory: string;
  Show: boolean);
begin
  if WorkingDirectory = '' then
    WorkingDirectory := GetCurrentDir;
  FillChar(SInfo, Sizeof(SInfo), #0);
  SInfo.cb := Sizeof(SInfo);
  SInfo.dwFlags := STARTF_USESHOWWINDOW;
  if Show then
    SInfo.wShowWindow := SW_SHOW
  else
    SInfo.wShowWindow := SW_HIDE;
  if not CreateProcess(nil, PChar(FileName + ' ' + Params), nil, nil, false,
    {CREATE_NEW_PROCESS_GROUP and }NORMAL_PRIORITY_CLASS, nil, PChar(WorkingDirectory),
    SInfo, PInfo) then
  begin
    raise Exception.Create('Could not create process, Error:'+useful.GetLastErrorText);
  end;
  HandlesOpen := true;
end;

procedure TRunProcess.Stop;
begin
  if not HasExited then
    TerminateProcess(pinfo.hProcess, 0);
end;

end.
