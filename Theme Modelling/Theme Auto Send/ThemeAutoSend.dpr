library ThemeAutoSend;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes,
  activex,
  windows,
  Dialogs,
  uAztecZoeComms in '..\Code\uAztecZoeComms.pas',
  uUpdateTerminals in '..\Code\uUpdateTerminals.pas' {UpdateTerminals},
  useful in '..\..\Common Files\useful.pas',
  ZOEDLL in '..\..\Common Files\ZOEDLL.PAS',
  uXMLSave in '..\..\Common Files\uXMLSave.pas',
  uADODB_27_TLB in '..\..\Common Files\uADODB_27_TLB.pas',
  uDMThemeData in '..\Code\uDMThemeData.pas',
  dADOAbstract in '..\..\Common Files\dADOAbstract.pas' {dmADOAbstract: TDataModule},
  uAztecLog in '..\..\Common Files\uAztecLog.pas',
  uWidestringUtils in '..\Code\uWidestringUtils.pas',
  uXMLModify in '..\Code\uXMLModify.pas',
  AztecResourceStrings in '..\..\Common Files\AztecResourceStrings.pas',
  uGlobals in '..\..\Common Files\uGlobals.pas',
  uDatabaseVersion in '..\..\Classes\Database\uDatabaseVersion.pas',
  uAztecDatabaseUtils in '..\..\Classes\Database\uAztecDatabaseUtils.pas',
  uSystemUtils in '..\..\Classes\Utilities\uSystemUtils.pas',
  uAztecStringUtils in '..\..\Classes\Utilities\uAztecStringUtils.pas',
  uAztecSplashScreen in '..\..\Classes\Splash\uAztecSplashScreen.pas' {frmAztecSplashForm},
  uSplashConstants in '..\..\Classes\Splash\uSplashConstants.pas',
  uAztecSplash in '..\..\Common Files\uAztecSplash.pas' {SplashForm},
  ULogFile in '..\..\Classes\Logging\ULogFile.pas',
  uADO in '..\Code\uADO.pas' {dmADO: TDataModule},
  uHardwareIcons in '..\..\Common Files\Hardware Icons\uHardwareIcons.pas';

{$R *.res}
{$R Version.RES}

type TUpdateResult = (urNoDevicesToUpdate, urAllDevicesUpdated, urNotAllDevicesUpdated);

function UpdateTerminals: TUpdateResult;
var
  TillCount, Errors: integer;
  UpdateTerminals: TUpdateTerminals;
begin
  Windows.SetCurrentDirectory(AZTECDIR);
  TillCount := 0;
  Errors := 1;

  try
    CoInitialize(nil);

    try
      // PW Rework 327104 - Need to initialise logging for DLL
      InitialiseLog(AZTECDIR + 'ThemeModeling.log');

      dmThemeData := nil;
      UpdateTerminals := nil;

      try
        dmThemeData := TdmThemeData.Create(nil);
        UpdateTerminals := TUpdateTerminals.Create(nil);

        with UpdateTerminals do
        try
          try
            InDLL := TRUE;
            FormShow(UpdateTerminals);
            UpdateRunning := TRUE;
            SendTheme;

            while UpdateRunning do
              Sleep(100);
          except
          end;
        finally
          TillCount := TerminalCount;
          Errors := ErrorCount;
        end;
      finally
        UpdateTerminals.free;
        dmthemedata.free;
      end;
    finally
      CoUninitialize;
    end;
  except
  end;

  if TillCount = 0 then
    Result := urNoDevicesToUpdate
  else if Errors > 0 then
    Result := urNotAllDevicesUpdated
  else
    Result := urAllDevicesUpdated;
end;

exports UpdateTerminals;

begin
end.
