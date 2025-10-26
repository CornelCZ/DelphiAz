unit uDatePicker;

(*
 * Unit contains TApplyDatePickerForm which allows the user to select the
 * date at which changes to line edit will be applied.
 *
 * Author: Hamish Martin, IceCube/Edesix
 *)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, CommCtrl;

type
  TDatePickerForm = class(TForm)
    DatePicker: TDateTimePicker;
    QueryLabel: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure DatePickerDropDown(Sender: TObject);
  private
    { Private declarations }
    FHideToday: Boolean;
    function GetDate : TDate;
    procedure SetCalendarStyle(Value: Integer; UseStyle: Boolean);
  public
    // Setup the parameters used for displaying the dialog.
    //   query - The message displayed in the form.
    //   earliest & latest - bound the dates which the user may select
    //   current - The initial date selected in the dialog.
    procedure SetQueryParams( query: string; earliest, latest, current: TDate; HideToday: Boolean = True);
    // Get the date selected by the user in the dialog
    property Date: TDate read GetDate;
  end;

var
  DatePickerForm: TDatePickerForm;


implementation

uses DateUtils, uGlobals, uLocalisedText;

{$R *.dfm}

function TDatePickerForm.GetDate : TDate;
begin
  GetDate := DateOf( DatePicker.Date );
end;

procedure TDatePickerForm.SetQueryParams( query: string; earliest, latest, current: TDate; HideToday: Boolean = True);
begin
  // ensure that earliest <= now <= latest
  if earliest > latest then
    latest := earliest;
  if current < earliest then
    current := earliest;
  if current > latest then
    current := latest;

  // Set up fields of date picker : logic below is carefully
  // organized to avoid an exception
  if earliest < DatePicker.MinDate then
    DatePicker.MinDate := earliest;
  if latest > DatePicker.MaxDate then
    DatePicker.MaxDate := latest;
  DatePicker.Date := current;
  DatePicker.MinDate := earliest;
  DatePicker.MaxDate := latest;
  FHideToday := HideToday;

  QueryLabel.Caption := query;
end;

procedure TDatePickerForm.FormShow(Sender: TObject);
begin
  setHelpContextID( self, AZPM_CHOOSE_DATE_FORM );
  Caption := ProductModellingTextName;
end;

procedure TDatePickerForm.SetCalendarStyle(Value: Integer; UseStyle: Boolean);
var
  wnd: HWND;
  Style: Integer;
begin
  wnd := DateTime_GetMonthCal(DatePicker.Handle);
  if wnd <> 0 then
  begin
    Style := GetWindowLong(wnd, GWL_STYLE);
    if not UseStyle then
      Style := Style and not Value
    else
      Style := Style or Value;
    SetWindowLong(wnd, GWL_STYLE, Style or Value);
  end;
end;

procedure TDatePickerForm.DatePickerDropDown(Sender: TObject);
begin
  if FHideToday then
    SetCalendarStyle(MCS_NOTODAY or MCS_NOTODAYCIRCLE, True);
end;

end.
