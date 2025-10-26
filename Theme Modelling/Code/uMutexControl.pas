unit uMutexControl;

interface

uses
  Windows, Sysutils, uAztecLog;

type
  TEnumResponse = record
     hInst,
     hWindow,
     hProcessID:HWND;
     Title:string;
  end;
  pEnumResponse = ^TEnumResponse;

const
  WM_CANCELMANUALSEND = $0400 + 103;

var
  ER:TEnumResponse;
  OpenProcessHandle:THandle;
  SendToPosMutex:Cardinal;

function EnumerateWindows(hw:HWND;p:Pointer):Boolean;stdcall;
function CreateEPOSMutex(MyUpdateTerminalsHandle: cardinal; var SelfCancelled: boolean; InitialTicks: cardinal):Boolean;
procedure ReleaseEPOSMutex;

implementation

function EnumerateWindows(hw:HWND;p:Pointer):Boolean;stdcall;
var
   ProcId,hInst:Cardinal;
   temp:array[0..255] of char;
begin
  Result := TRUE;
  GetWindowText(hw,temp,sizeof(temp));
  hInst := GetWindowThreadProcessId(hw,@ProcId);
  if temp = TEnumResponse(p^).Title then
  begin
    TEnumResponse(p^).hInst := hInst;
    TEnumResponse(p^).hWindow := hw;
    TEnumResponse(p^).hProcessID := ProcID;
    Result := FALSE;
  end;
end;

function CreateEPOSMutex(MyUpdateTerminalsHandle: cardinal; var SelfCancelled: boolean; InitialTicks: cardinal):Boolean;
var
  hWnd, retcode: cardinal;
  i,j: integer;
  UpdateTerminalInstanceCount: integer;
  UpdateTerminalInstance: array[0..255] of cardinal;
  AllPreExistingInstancesClosed: boolean;
begin
  Result := FALSE;
  SendToPosMutex := CreateMutex(nil, true, 'Global\AztecThemeSend');
  retcode := GetLastError;
  if SendToPosMutex = 0  then
  begin
    Log('Send to Pos Failed - Cannot create Mutex! Win32 error '+inttostr(retcode));
  end
  else
    if retcode = ERROR_ALREADY_EXISTS then
    begin
      // We have obtiained a handle to the mutex but it already exists with another
      // process as the owner.
      Log('Send to Pos is Currently Running - Restarting...');

      // Get list of all update terminal view window handles.
      // In the event of multiple users logged in, this may not get every running instance.
      UpdateTerminalInstanceCount := 0;
      hWnd := FindWindowEx(0, 0, 'TUpdateTerminals', 'Send to POS');
      while hWnd <> 0 do
      begin
        UpdateTerminalInstance[UpdateTerminalInstanceCount] := hWnd;
        Inc(UpdateTerminalInstanceCount);
        hWnd := FindWindowEx(0, hWnd, 'TUpdateTerminals', 'Send to POS');
      end;

      AllPreExistingInstancesClosed := false;
      for i := 0 to 500 do
      begin
        if (SendToPosMutex <> 0) and (retcode <> ERROR_ALREADY_EXISTS) then
        begin
          // We now own the mutex
          Result := true;
          exit;
        end
        // We have send cancel messages to all other instances but they haven't
        // released the mutex.
        else if AllPreExistingInstancesClosed then
        begin
          break;
        end
        // Check if we have processed a cancel ourselves (manually or via SendMessage
        // from a competing instance).
        else if SelfCancelled then
          break;

        // Close our existing mutex handle
        if (SendToPosMutex <> 0) then
        begin
          CloseHandle(SendToPosMutex);
          SendToPosMutex := 0;
        end;

        AllPreExistingInstancesClosed := true;
        for j := 0 to pred(UpdateTerminalInstanceCount) do
        begin
          hWnd := UpdateTerminalInstance[j];
          if IsWindow(hWnd) and (hwnd <> MyUpdateTerminalsHandle) then
          begin
            AllPreExistingInstancesClosed := false;
            // If we can successfully Send the message, update its handle to ours
            // so we don't send it again.
            // We pass the "initialticks" count as a crude mechansism to ensure
            // the last instance wins out.
            // Again, may be blocked and return access denied.
            if SendMessage(hWnd, WM_CANCELMANUALSEND, 0, InitialTicks) = 0 then
               UpdateTerminalInstance[j] := MyUpdateTerminalsHandle;
          end;
        end;
        Sleep(20);
        SendToPosMutex := CreateMutex(nil, true, 'Global\AztecThemeSend');
        retcode := GetLastError;
      end;
      Log('Existing STP mutex could not be closed');
      if (SendToPosMutex <> 0) then
      begin
        CloseHandle(SendToPosMutex);
        SendToPosMutex := 0;
      end;
    end
    else if retcode = 0 then
    begin
      Log('Send to Pos Mutex Created.');
      Result := TRUE;
    end
    else
    begin
      Log('Send to Pos Failed - Cannot create Mutex! Win32 error '+inttostr(retcode));
    end;
end;

procedure ReleaseEPOSMutex;
begin
  CloseHandle(SendToPosMutex);
end;

end.
