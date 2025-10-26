unit uAztecService;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs;

type
  TAztecBaseService = class(TService)
    procedure ServiceExecute(Sender: TService); virtual;
    procedure ServiceStart(Sender: TService; var Started: Boolean); virtual;
    procedure ServiceStop(Sender: TService; var Stopped: Boolean); virtual;
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  AztecBaseService: TAztecBaseService;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  AztecBaseService.Controller(CtrlCode);
end;

function TAztecBaseService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TAztecBaseService.ServiceExecute(Sender: TService);
begin
  While Not Terminated Do
    ServiceThread.ProcessRequests(TRUE);
end;

procedure TAztecBaseService.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  Started := TRUE;
end;

procedure TAztecBaseService.ServiceStop(Sender: TService;
  var Stopped: Boolean);
begin
  Stopped := TRUE;
end;

initialization
  RegisterClass(TAztecBaseService);

finalization
  UnRegisterClass(TAztecBaseService);

end.
