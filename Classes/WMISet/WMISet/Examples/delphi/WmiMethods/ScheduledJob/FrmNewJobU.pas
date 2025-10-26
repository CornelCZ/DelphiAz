unit FrmNewJobU;

interface

uses
  Windows, Messages, SysUtils,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ComCtrls, Buttons;

type
  TFrmNewJob = class(TForm)
    Label1: TLabel;
    spbCommand: TSpeedButton;
    lblStartTime: TLabel;
    lblDaysOfWeek: TLabel;
    lblDaysOfMonth: TLabel;
    edtCommand: TEdit;
    dtpStartTime: TDateTimePicker;
    chbRunRepeatedly: TCheckBox;
    clbDaysOfWeek: TCheckListBox;
    chbInteract: TCheckBox;
    clbDaysOfMonth: TCheckListBox;
    btnCreate: TButton;
    btnCancel: TButton;
    odCommand: TOpenDialog;
    procedure spbCommandClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCommandChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function getDaysOfWeek: integer;
    function getDaysOfMonth: integer;
  end;

var
  FrmNewJob: TFrmNewJob;

implementation

{$R *.dfm}

procedure TFrmNewJob.spbCommandClick(Sender: TObject);
begin
  if (odCommand.Execute) then
    edtCommand.Text := odCommand.FileName;
end;


function TFrmNewJob.getDaysOfWeek: integer;
var
  vMask, i: integer;
begin
  vMask  := 1;
  Result := 0;
  for i := 0 to clbDaysOfWeek.Items.Count - 1 do
  begin
    if (clbDaysOfWeek.Checked[i]) then Result := Result or vMask;
    vMask := vMask * 2;
  end;
end;

function TFrmNewJob.getDaysOfMonth: integer;
var
  vMask, i: integer;
begin
  vMask  := 1;
  Result := 0;
  for i := 0 to clbDaysOfMonth.Items.Count - 1 do
  begin
    if (clbDaysOfMonth.Checked[i]) then Result := Result or vMask;
    vMask := vMask * 2;
  end;
end;

procedure TFrmNewJob.FormCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to clbDaysOfMonth.Items.Count - 1 do clbDaysOfMonth.Checked[i] := true;
  for i := 0 to clbDaysOfWeek.Items.Count - 1 do clbDaysOfWeek.Checked[i] := true;
  dtpStartTime.DateTime := Now;
end;

procedure TFrmNewJob.edtCommandChange(Sender: TObject);
begin
  btnCreate.Enabled := edtCommand.Text <> '';
end;

end.
