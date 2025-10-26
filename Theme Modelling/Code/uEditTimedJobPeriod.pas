unit uEditTimedJobPeriod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TEditJobPeriod = class(TForm)
    dtStart: TDateTimePicker;
    dtEnd: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    cbMon: TCheckBox;
    cbTue: TCheckBox;
    cbWed: TCheckBox;
    cbThu: TCheckBox;
    cbFri: TCheckBox;
    cbSat: TCheckBox;
    cbSun: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetValues(starttime, endtime: TDateTime; validdays: byte);
    procedure GetValues(var starttime, endtime: TDateTime; var validdays: byte);
  end;

var
  EditJobPeriod: TEditJobPeriod;

implementation

uses
  uAztecLog;

{$R *.dfm}

procedure TEditJobPeriod.FormCreate(Sender: TObject);
begin
  dtStart.Format := 'HH:mm';
  dtEnd.Format := 'HH:mm';
end;


procedure TEditJobPeriod.GetValues(var starttime, endtime: TDateTime;
  var validdays: byte);
begin
  starttime := frac(dtStart.Time);
  endtime := frac(dtEnd.Time);
  validdays := 1 * ord(cbmon.checked) + 2 * ord(cbtue.checked) + 4 * ord(cbwed.checked) + 8 * ord(cbthu.checked) +
    16 * ord(cbfri.checked) + 32 * ord(cbsat.checked) + 64 * ord(cbsun.checked);
end;

procedure TEditJobPeriod.SetValues(starttime, endtime: TDateTime; validdays: byte);
begin
  dtStart.time := starttime;
  dtEnd.time := endtime;
  cbmon.checked := boolean(validdays and 1);
  cbtue.checked := boolean(validdays and 2);
  cbwed.checked := boolean(validdays and 4);
  cbthu.checked := boolean(validdays and 8);
  cbfri.checked := boolean(validdays and 16);
  cbsat.checked := boolean(validdays and 32);
  cbsun.checked := boolean(validdays and 64);
end;

procedure TEditJobPeriod.Button1Click(Sender: TObject);
begin
  ButtonClicked(Sender);
  if (1 * ord(cbmon.checked) + 2 * ord(cbtue.checked) + 4 * ord(cbwed.checked) + 8 * ord(cbthu.checked) +
    16 * ord(cbfri.checked) + 32 * ord(cbsat.checked) + 64 * ord(cbsun.checked)) = 0 then
    raise exception.create('Timed security must apply on at least one business date.');
  modalresult := mrOk;
end;

procedure TEditJobPeriod.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
end;

procedure TEditJobPeriod.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
end;

procedure TEditJobPeriod.Button2Click(Sender: TObject);
begin
  ButtonClicked(Sender);

end;

end.
