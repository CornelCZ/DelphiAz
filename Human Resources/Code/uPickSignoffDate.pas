unit uPickSignoffDate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls;

type
  TPickSignoffStart = class(TForm)
    Label2: TLabel;
    Image1: TImage;
    DayPicker: TMonthCalendar;
    btCancel: TButton;
    btOk: TButton;
    procedure FormShow(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    StartOfWeekDelphi: integer;
  public
    StartOfWeekDay: integer;
    Signoffdate: TDateTime;
  end;

function GetFirstWeekToSignOff(out FirstWeekToSignOff: TDate; const AStartOfWeekDay: integer): Boolean;

implementation

{$R *.DFM}

function GetFirstWeekToSignOff(out FirstWeekToSignOff: TDate; const AStartOfWeekDay: integer): Boolean;
begin
  Result := FALSE;

  with TPickSignoffStart.create(nil) do
  try
    StartOfWeekDay := AStartOfWeekDay;
    if showmodal = mrOK then
    begin
      FirstWeekToSignOff := Signoffdate;
      Result := TRUE;
    end;
  finally
    free;
  end;
end;

procedure TPickSignoffStart.FormShow(Sender: TObject);
begin
  { Note: HR uses day numberings of Mon=0..Sun=6. Delphi DayOfWeek function uses Sun=1..Sat=7.
    If only HR used the same numbering scheme as delphi! }
  StartOfWeekDelphi := ((StartOfWeekDay + 1) mod 7) + 1;

  { Default to the current week }
  SignOffDate := date - DayOfWeek(date) + StartOfWeekDelphi;

  DayPicker.Date := Signoffdate;
end;

procedure TPickSignoffStart.btOkClick(Sender: TObject);
begin
  Signoffdate := DayPicker.date;
  if Dayofweek(signoffdate) <> StartOfWeekDELPHI then
  begin
    Showmessage('The date you have picked does not match the ' + #13 +
      'trading start of week, which is ' + longdaynames[StartOfWeekDelphi]);
    exit;
  end;
  modalresult := mrOk;
end;

end.

