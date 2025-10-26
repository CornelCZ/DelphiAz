program SQLemp;

uses
  ShareMem,
  Windows,
  Forms,
  SysUtils,
  MicDelphiAgent in '..\..\Common Files\QuickTestPro\MicDelphiAgent.pas',
  MicWWSupport in '..\..\Common Files\QuickTestPro\MicWWSupport.pas',
  DlphVDEPAgentImpl in '..\..\Common Files\QuickTestPro\DlphVDEPAgentImpl.pas',
  MicAOFactory in '..\..\Common Files\QuickTestPro\MicAOFactory.pas',
  MicAOFactoryMgr in '..\..\Common Files\QuickTestPro\MicAOFactoryMgr.pas',
  AgentExtensibilitySDK in '..\..\Common Files\QuickTestPro\AgentExtensibilitySDK.pas',
  MicDelphiGridSupport in '..\..\Common Files\QuickTestPro\MicDelphiGridSupport.pas',
  dmodule1 in 'dmodule1.pas' {dMod1: TDataModule},
  dShiftMatch in 'dShiftMatch.pas' {dmShiftMatch: TDataModule},
  uAboutForm in 'uAboutForm.pas' {AboutForm},
  uAttend in 'uAttend.pas' {fAttend},
  ubasefrm in 'ubasefrm.pas' {fbasefrm},
  UCopyopt in 'UCopyopt.pas' {CopyOptDlg},
  UDelVrfy in 'UDelVrfy.pas' {FDelVrfy},
  uempmnu in 'uempmnu.pas' {fEmpMnu},
  uExpTake in 'uExpTake.pas' {fExpTake},
  Ufrowdlg in 'Ufrowdlg.pas' {Ffrowdlg},
  UInsEmp in 'UInsEmp.pas' {fInsEmp},
  UInsShft in 'UInsShft.pas' {FInsShft},
  uLSPay in 'uLSPay.pas' {fLSPay},
  uOpClose in 'uOpClose.pas' {fOpClose},
  uOver24 in 'uOver24.pas' {fOver24},
  uPickWeek in 'uPickWeek.pas' {fPickWeek},
  uSchedule in 'uSchedule.pas' {fSchedule},
  uSiteChoose in 'uSiteChoose.pas' {fSiteChoose},
  UTotals in 'UTotals.pas' {FTotals},
  UVerify in 'UVerify.pas' {VrfyDlg},
  uwait in 'uwait.pas' {fwait},
  UWarn in 'UWarn.pas' {FWarn},
  uADO in 'uADO.pas' {dmADO: TDataModule},
  fEmployeeBreaks in 'fEmployeeBreaks.pas' {EmployeeBreaksForm},
  dADOAbstract in '..\..\Common Files\dADOAbstract.pas' {dmADOAbstract: TDataModule},
  uPassword in '..\..\Common Files\uPassword.pas' {frmPassword},
  uGlobals in '..\..\Common Files\uGlobals.pas',
  uAztecSplash in '..\..\Common Files\uAztecSplash.pas' {SplashForm},
  useful in '..\..\Common Files\useful.pas',
  ulog in '..\..\Common Files\ulog.pas',
  MercWwControl in '..\..\Common Files\WinRunner\MercWwControl.pas',
  TestSrvr in '..\..\Common Files\WinRunner\TestSrvr.pas',
  uGuiUtils in 'uGuiUtils.pas',
  uPickSignoffDate in 'uPickSignoffDate.pas' {PickSignoffStart},
  uSimpleLocalise in '..\..\Common Files\uSimpleLocalise.pas',
  uXPFix in '..\..\Common Files\uXPFix.pas',
  uSetupRBuilderPreview in '..\..\Common Files\uSetupRBuilderPreview.pas',
  uRateOverrides in 'uRateOverrides.pas' {fRateOverrides},
  uDiagnosticlog in 'uDiagnosticLog.pas',
  uEQATECMonitor in '..\..\Common Files\uEQATECMonitor.pas',
  uEposDevice in '..\..\Classes\Base Classes\uEposDevice.pas';

{$R *.res}

const
  MutexName = 'AZTEC_HUMAN_RESOURCE';

var
  MutexHandle : THandle;
begin
  MutexHandle := CreateMutex(nil, false, MutexName);

  {if it failed then there is another instance}
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    {Send all windows our custom message - only our other}
    {instance will recognise it, and restore itself}
    SendMessage(HWND_BROADCAST, RegisterWindowMessage(MutexName), 0, 0);
    {Lets quit}
    Halt(0);
  end;

  Application.Initialize;

  Application.Title := 'Time & Attendance';
  log.setup('Log','ESlog',99,100);
  log.SetModule('Start Up');
  log.event('Employee system starting');
  diagLog.setup('Log\HRScheduleLog','HRSchedule',3,1000);
  diagLog.SetModule('HR Schedule');
  Application.CreateForm(TfEmpMnu, fEmpMnu);
  try
    Application.Run;
    EQATECMonitor.CloseDown(StringReplace(Application.Title, '&', '&&', [rfIgnoreCase, rfReplaceAll]));
  except
    on E:exception do
    begin
      log.SetModule('SYSTEM ERROR');
      log.event('MAJOR FAIL: ' + e.MESSAGE);
    end;
  end;

  log.SetModule('Exit');
  log.event('Employee system ended');

  if ( MutexHandle <> 0 ) then
    CloseHandle(MutexHandle);
end.
