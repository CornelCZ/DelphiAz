unit uWinHelpFixup;

interface

uses WinHelpViewer;

var ShutDownWinHelpOnClose: boolean;

implementation

initialization
  ShutDownWinHelpOnClose := true;
finalization

  // *** HACK ALERT ***
  // Delphi help manager registers all help to window handle 0
  // Every delphi app will close all help windows when exiting.
  // This kludge uses a fixed offset from a public member of the offending
  // unit to clear the pointer to HelpManager which prevents help from being closed.
  // This is only suitable for use in apps that will never or have never opened help
  // while they are run.
  // I think this will only break if we move from Delphi 6.240 update pack 2.
  if ShutDownWinHelpOnClose then
    pinteger(ptr(pinteger(ptr(integer(@WinHelpViewer.WinHelpTester) + $c))^ + 28))^ := 0;

end.