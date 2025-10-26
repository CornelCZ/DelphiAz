unit DemoU1;

interface

uses
{$IFDEF VER80}
  WinTypes, WinProcs,
{$ELSE}
  Windows,
{$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, StdCtrls, ssCtrlSize;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Button1: TButton;
    cbAllowMove: TCheckBox;
    cbAllowResize: TCheckBox;
    cbControls: TComboBox;
    cbLimitToParent: TCheckBox;
    CheckBox1: TCheckBox;
    ControlSizer1: TControlSizer;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ListBox1: TListBox;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    RadioButton1: TRadioButton;
    RadioGroup1: TRadioGroup;
    SpeedButton1: TSpeedButton;
    procedure cbAllowMoveClick(Sender: TObject);
    procedure cbAllowResizeClick(Sender: TObject);
    procedure cbLimitToParentClick(Sender: TObject);
    procedure ControlSizer1EndMove(Sender: TObject);
    procedure ControlSizer1EndSize(Sender: TObject);
    procedure ControlSizer1StartMove(Sender: TObject);
    procedure ControlSizer1StartSize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MouseDownClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OnClick(Sender: TObject);
    procedure PanelResize(Sender: TObject);
    procedure SelectControl(Sender: TObject);
  private
    procedure SetControlTo(c: TControl);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

{ TForm1 }

procedure TForm1.cbAllowMoveClick(Sender: TObject);
begin
  ControlSizer1.AllowMove := cbAllowMove.Checked;
end;

procedure TForm1.cbAllowResizeClick(Sender: TObject);
begin
  ControlSizer1.AllowResize := cbAllowResize.Checked;
end;

procedure TForm1.cbLimitToParentClick(Sender: TObject);
begin
  ControlSizer1.LimitToParentRect := cbLimitToParent.Checked;
end;

procedure TForm1.ControlSizer1EndMove(Sender: TObject);
begin
  Caption := 'End move of ' + TControl(Sender).Name + ' (' + Sender.ClassName + ')';
end;

procedure TForm1.ControlSizer1EndSize(Sender: TObject);
begin
  Caption := 'End size of ' + TControl(Sender).Name + ' (' + Sender.ClassName + ')';
end;

procedure TForm1.ControlSizer1StartMove(Sender: TObject);
begin
  Caption := 'Start move of ' + TControl(Sender).Name + ' (' + Sender.ClassName + ')';
end;

procedure TForm1.ControlSizer1StartSize(Sender: TObject);
begin
  Caption := 'Start size of ' + TControl(Sender).Name + ' (' + Sender.ClassName + ')';
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ControlCount - 1 do
    with Controls[i] do
      if Tag = 0 then { don't allow sizing/moving of the working controls }
        cbControls.Items.Add(Name + ' (' + ClassName + ')');
  if cbControls.Items.Count > 0 then
    cbControls.ItemIndex := 0;
end;

procedure TForm1.MouseDownClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if sender is TControl then
    SetControlTo(TControl(Sender));
end;

procedure TForm1.OnClick(Sender: TObject);
begin
  if sender is TControl then
    SetControlTo(TControl(Sender));
end;

procedure TForm1.PanelResize(Sender: TObject);
begin
  with TPanel(Sender) do
    Caption := Format('%d x %d', [Width, Height]);
end;

procedure TForm1.SelectControl(Sender: TObject);
var
  c: TComponent;
  n: string;
  p: integer;
begin
  n := cbControls.Text;
  p := Pos(' ', n);
  if p <> 0 then
    n := Copy(n, 1, p - 1);
  c := FindComponent(n);
  if c is TControl then
    SetControlTo(TControl(c));
end;

procedure TForm1.SetControlTo(c: TControl);
begin
  ControlSizer1.Control := c;
  Caption := 'Control set to ' + c.Name + ' (' + c.ClassName + ')';
  cbAllowMove.Enabled := c is TWinControl;
  if not cbAllowMove.Enabled then
    cbAllowMove.Checked := false;
end;

end.

