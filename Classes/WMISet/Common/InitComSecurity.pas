// include this unit into uses clause to have COM security initialized.
unit InitComSecurity;
{$I define.inc}

interface

Uses
  SysUtils, ActiveX, ComObj, RpcConstants;

// when in DLL and main executable does not initializes COM security,
// call this method for explicit initialization  
procedure DoInitComSecurity;

implementation

var
  SaveInitProc: Pointer;

threadvar
  ComInitialized: boolean;

procedure DoInitComSecurity;
begin
  if (not ComInitialized) then
  begin
      // this call may fail if COM is already initialized:
      // I do not care.

      // The COM calls in threads become teriibly slow if
      // COINIT_MULTITHREADED is specified.
      // CoInitializeEx(nil, COINIT_MULTITHREADED);
      CoInitializeEx(nil, COINIT_APARTMENTTHREADED);

      // Win 98 can work only with RPC_C_AUTHN_LEVEL_CONNECT.
      // Win2000 can negotiate it if RPC_C_AUTHN_LEVEL_DEFAULT specified.
      CoInitializeSecurity(nil, -1, nil, nil, RPC_C_AUTHN_LEVEL_DEFAULT, RPC_C_IMP_LEVEL_IMPERSONATE, nil, EOAC_NONE, nil);

      ComInitialized := true;
  end;
end;

procedure InitProcedure;
begin
  if SaveInitProc <> nil then TProcedure(SaveInitProc);
  if not IsLibrary then DoInitComSecurity;
end;

  
initialization

begin
  if not IsLibrary then
  begin
    SaveInitProc := InitProc;
    InitProc     := @InitProcedure;
  end;
end;

finalization


end.
