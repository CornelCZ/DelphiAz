unit uSingleInstance;

interface

uses Windows, Forms, Messages, AppEvnts, Dialogs, sysutils;

const
  AZTEC_WATCHDOG_INSTANCE      = 'Aztec_Watchdog';
  AZTEC_LAUNCHCONTROL_INSTANCE = 'Aztec_LaunchControl';

type
  TSingleInstance = class(TObject)
    procedure HandleCustomMessages(var Msg: tagMSG; var Handled: Boolean);
  private
    RestoreApplicationMessage: Cardinal;
    ApplicationEvents: TApplicationEvents;
  public
    constructor Create(ASystemID: PChar);
    destructor Destroy; override;
  end;

implementation

{ TUniqueInstance }

constructor TSingleInstance.Create(ASystemID: PChar);
begin
  RestoreApplicationMessage := RegisterWindowMessage(ASystemID);

  CreateMutex(nil, false, ASystemID);

  {if it failed then there is another instance}
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    {Send all windows our custom message - only our other}
    {instance will recognise it, and restore itself}
    PostMessage(HWND_BROADCAST, RestoreApplicationMessage, 0, 0);
    {Lets quit}
    Halt(0);
  end;

  ApplicationEvents := TApplicationEvents.Create(nil);
  ApplicationEvents.OnMessage := HandleCustomMessages;
end;

destructor TSingleInstance.Destroy;
begin
  ApplicationEvents.Free;
  
  inherited;
end;

procedure TSingleInstance.HandleCustomMessages(var Msg: tagMSG;
  var Handled: Boolean);
begin
  if Msg.message = RestoreApplicationMessage then
  begin
    SendMessage(Application.handle, WM_SYSCOMMAND, SC_ICON, 0);
    SendMessage(Application.handle, WM_SYSCOMMAND, SC_RESTORE, 0);

    SetForegroundWindow(Application.Handle);
    Handled := TRUE;
  end
  else
    Handled := FALSE;
end;

end.
 