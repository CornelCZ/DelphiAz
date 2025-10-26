{ Mike Palmer
  (c) Copyright Zonal Retail Data Systems Ltd.  All Rights Reserved}

unit uAztecScheduler;

interface

uses uAztecAction,uAztecComputer,uCommon;

type
  TAztecPause=class(TAztecAction)
  private
    FMilliSeconds:integer;
  public
    constructor Create(const APause:integer); reintroduce;
    function Execute(Computer : TAztecComputer; var AResultString:string):boolean; override;
  published
    property MilliSeconds:integer read FMilliSeconds write FMilliSeconds default 500;
  end;

  TAztecSchedule=class(TAztecAction)
  private
    FDateTime:TDateTime;
  public
    constructor Create(const ADateTime:TDateTime); reintroduce;
    function Execute(Computer : TAztecComputer; var AResultString:string):boolean; override;
  published
    property DateTime:TDateTime read FDateTime write FDateTime;
  end;

implementation

uses Forms, Controls, SysUtils, ExtCtrls, Windows, uScheduledEventForm;

{ TAztecPause }
constructor TAztecPause.Create(const APause:integer);
begin
  inherited Create;
  FMilliSeconds:=APause;
  FActionDescription:='Pause';
end;

function TAztecPause.Execute(Computer : TAztecComputer; var AResultString:string): boolean;
var
  endTime : Integer;
  togo : Integer;
begin
  Computer.Progress('Paused',0);
  endTime := Integer(GetTickCount) + MilliSeconds;
  while not Computer.IsCancelledFunc do
  begin
    togo := endTime - Integer(GetTickCount); // Note that GetTickCount can wrap, hence the way this is constructed
    if togo <= 0 then
      Break;

    Computer.Progress('Paused ('+IntToStr((togo+999) div 1000)+' secs left)',100 - (togo * 100 div MilliSeconds));

    if togo > 200 then togo := 200;
    Sleep(togo);
  end;
  Computer.Progress('Pause done',100);
  Result:=TRUE;
  AResultString:=FActionDescription+','+IntToStr(MilliSeconds)+'ms,'+BooleanToString(Result)
end;

{ TAztecSchedule }

constructor TAztecSchedule.Create(const ADateTime: TDateTime);
begin
  Inherited Create;
  DateTime:=ADateTime;
  FActionDescription:='Schedule';
  FFirstAction:=TRUE;
  FTerminate:=TRUE;
end;

function TAztecSchedule.Execute(Computer : TAztecComputer; var AResultString:string): boolean;
var
  cancelled : boolean;
begin
  EnableWindow(Application.MainForm.Handle,FALSE);
  cancelled:=DisplayScheduledEventForm(FDateTime);
  EnableWindow(Application.MainForm.Handle,TRUE);
  Result:=TRUE;
  AResultString:=FActionDescription+','+FormatDateTime('dd/mm/yyyy hh:mm',FDateTime)+','+BooleanToString(cancelled)
end;

end.
