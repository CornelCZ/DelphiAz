unit uComdlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Messages, dialogs, DB, DBTables, Wwtable,
  Serial5;

type
  TfComdlg = class(TForm)
    Panel1: TPanel;
    Label3: TLabel;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    Timer1: TTimer;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    Serial1: TSerial;
    procedure FormShow(Sender: TObject);
    function inSession: boolean;
    function inWaiting: boolean;
    procedure getAllWindows;
    procedure killHost;
    procedure waitSessionOff;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);

  private
    { Private declarations }
    sHandle, wHandle: THandle;
    sessionOn, waitingOn, stopwait: boolean;
    waitsec: integer;
  public
    { Public declarations }
    restartPcAny: boolean;
    function decideIfShow: integer;

  end;
function DoEnumWindow(hwnd: Thandle; lIntParam: LPARAM): Bool stdcall;


var
  fComdlg: TfComdlg;

implementation

{$R *.DFM}

procedure TfComdlg.killHost;
var
  hostname: string;
begin

  sendmessage(whandle, WM_SYSCOMMAND, SC_CLOSE, 0);
  Application.ProcessMessages;
  Application.ProcessMessages;

  SetLength(hostname, 255);
  while true do
  begin
    restartpcAny := true;
    Application.ProcessMessages;
    if IsWindow(whandle) then
    begin
      GetWindowText(whandle, PCHAR(hostname), 255);
      if copy(hostname, 1, 17) <> copy('pcANYWHERE Waiting...', 1, 17) then
        break;
    end
    else
    begin
      break;
    end;
  end; // while true...
end;

procedure TfComdlg.waitSessionOff;
var
  winname: string;
begin
  SetLength(winname, 255);
  while not stopwait do
  begin
    Application.ProcessMessages;
    if IsWindow(shandle) then
    begin
      GetWindowText(shandle, PCHAR(winname), 255);
      if copy(winname, 1, 23) <> copy('pcANYWHERE [In Session]', 1, 23) then
        break;
    end
    else
    begin
      break;
    end;
  end; // while true...
end;

procedure Tfcomdlg.getAllWindows;
var
  lpCallBack: TFNWndEnumProc; {pointer to callback function }

begin
  lpCallBack := @DoEnumWindow; { get address of callback function }
  EnumWindows(lpCallBack, 0); { start enumeration process }
end;

function DoEnumWindow(hwnd: Thandle; lIntParam: LPARAM): Bool;
var
  sWindowName: string; { window name }
begin
  SetLength(sWindowName, 255); { set length of display string }
  if IsWindow(hwnd) then { make sure there is a window handle }
  begin
    SetLength(sWindowName, 255);
    GetWindowText(hwnd, PCHAR(sWindowName), 255); {get window name}
    if copy(sWindowName, 1, 23) = copy('pcANYWHERE [In Session]', 1, 23) then
    begin
      fcomdlg.shandle := hwnd;
    end;
    if copy(sWindowName, 1, 17) = copy('pcANYWHERE Waiting...', 1, 17) then
    begin
      fcomdlg.whandle := hwnd;
    end;
  end;
  Result := True;
end;


// is the pcAny in session and if yes get it's handle...

function TfComdlg.inSession: boolean;
begin
  shandle := 0;
  getAllWindows;
  if IsWindow(shandle) then
    inSession := true
  else
    insession := false;
end;

// is the pcAny in waiting and if yes get it's handle...

function TfComdlg.inWaiting: boolean;
begin
  whandle := 0;
  getAllWindows;
  if IsWindow(whandle) then
    inWaiting := true
  else
    inWaiting := false;
end;


// returns : -1- port locked but not by pcAnywhere,
//            0- port free, but host is up (or in session)
//            1- port free and host not up (or in session)
//            2- port locked by host (waiting or in session)

function Tfcomdlg.decideIfShow: integer;
begin
  serial1.active := true;
  if serial1.active = false then
  begin
    if inSession then
    begin
      sessionOn := true;
      decideIfShow := 2; // port locked by host
    end // if inSession
    else
    begin // not in session
      if inWaiting then
      begin
        waitingOn := true;
        decideIfShow := 2; // port locked by host
      end
      else
      begin
        decideIfShow := -1; // port locked , host not up
      end;
    end; // if in session .. else..

  end // serial1- inactive
  else
  begin // port activated ok..
    serial1.active := false;
    if inSession then
    begin
      sessionOn := true;
      decideIfShow := 0; //port free, host up
    end // if inSession
    else
    begin // not in session
      if inWaiting then
      begin
        waitingOn := true;
        decideIfShow := 0; // port free, host up
      end
      else
      begin
        decideIfShow := 1; // port free, host not up
      end;
    end; // if in session .. else..
  end;
end;

procedure TfComdlg.FormShow(Sender: TObject);
begin
  if sessionOn then
  begin
    panel1.visible := true;
    panel2.visible := false;
  end;
  if WaitingOn then
  begin
    panel1.visible := false;
    panel2.visible := true;
  end;
  stopwait := false;
end;

procedure TfComdlg.FormCreate(Sender: TObject);
begin
  restartpcAny := false;
  sessionOn := false;
  waitingOn := false;
end;

procedure TfComdlg.FormActivate(Sender: TObject);
begin
  waitsec := -1;
  timer1.enabled := true;
  if sessionOn then
  begin
    waitSessionOff;
    if stopwait then
    begin
      waitsec := 0;
      exit;
    end;
    Application.ProcessMessages;
    while (not inWaiting) and (not stopwait) do
      Application.ProcessMessages;
  end;
  if stopwait then
  begin
    waitsec := 0;
    exit;
  end;
  if inWaiting then
  begin
    killHost;
  end;
  waitsec := 0;
  //timer1.enabled := true;
  Application.processmessages;
end;

procedure TfComdlg.Timer1Timer(Sender: TObject);
begin
  if waitsec >= 0 then
  begin
    if waitsec > 3 then
    begin
      timer1.enabled := false;
      if stopwait then
        modalresult := mrCancel
      else
        modalResult := mrOK;
    end;
    waitsec := waitsec + 1;
    Application.processmessages;
  end;

  if label3.color = clRed then
  begin
    label3.color := clYellow;
    label3.font.color := clRed;
  end
  else
  begin
    label3.color := clRed;
    label3.font.color := clYellow;
  end;
  Application.processmessages;
end;

procedure TfComdlg.BitBtn1Click(Sender: TObject);
begin
  stopwait := true;
end;

end.

