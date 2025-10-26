unit uScheduledEventForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TScheduledEventProgressForm = class(TForm)
    gbEvent: TGroupBox;
    imgIcon: TImage;
    lblNextEvent: TLabel;
    edNextEvent: TEdit;
    lblCurrentTime: TLabel;
    edCurrentDateTime: TEdit;
    tmrDateTimeTimer: TTimer;
    btnCancel: TButton;
    procedure tmrDateTimeTimerTimer(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FNextEvent:TDateTime;
  public
    { Public declarations }
  end;

function DisplayScheduledEventForm(const AEventDateTime:TDateTime):boolean;


implementation

{$R *.dfm}

function DisplayScheduledEventForm(const AEventDateTime:TDateTime):boolean;
var
  ScheduledEventProgressForm: TScheduledEventProgressForm;
begin
  ScheduledEventProgressForm:=TScheduledEventProgressForm.Create(nil);
  try
    with ScheduledEventProgressForm do
    begin
      FNextEvent:=AEventDateTime;
      edNextEvent.Text:=FormatDateTime('dd/mm/yyyy HH:mm:ss',AEventDateTime);
    end;
    Result:=ScheduledEventProgressForm.ShowModal=mrOk;
  finally
    FreeAndNil(ScheduledEventProgressForm);
  end;
end;

procedure TScheduledEventProgressForm.tmrDateTimeTimerTimer(Sender: TObject);
begin
  TTimer(Sender).Enabled:=FALSE;
  edCurrentDateTime.Text:=FormatDateTime('dd/mm/yyyy HH:mm:ss', Now);
  if Now>=FNextEvent then
     ModalResult:=mrOk
  else
     TTimer(Sender).Enabled:=TRUE;
end;

procedure TScheduledEventProgressForm.btnCancelClick(Sender: TObject);
begin
  if MessageDlg('Are You Sure?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
     Close;
end;

procedure TScheduledEventProgressForm.FormCreate(Sender: TObject);
begin
  edCurrentDateTime.Text:=FormatDateTime('dd/mm/yyyy HH:mm:ss',Now);
end;

end.
