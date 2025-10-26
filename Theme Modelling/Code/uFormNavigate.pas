unit uFormNavigate;

interface

uses contnrs, forms;

type
  TMoveInfo = class(TObject)
  public
    OldForm: TForm;
    KillAfter: boolean;
    constructor Create(KillAfter: boolean);
  end;

  TFormNavigator = class(TObject)
  private
    FormStack: TStack;
  public
    constructor Create;
    procedure MoveForward(NewForm: TForm; KillAfter: boolean = false);
    procedure MoveBack;
    function Level: integer;
  end;

function Nav: TFormNavigator;

implementation

var
  Navigator: TFormNavigator;

function Nav: TFormNavigator;
begin
  if not Assigned(Navigator) then
    Navigator := TFormNavigator.Create;
  result := Navigator;
end;


{ TFormNavigator }

constructor TFormNavigator.Create;
begin
  inherited Create;
  FormStack := TStack.Create;
end;

procedure TFormNavigator.MoveBack;
var
  MoveInfo: TMoveInfo;
  NewForm: TForm;
begin
  NewForm := Screen.ActiveForm;
  if FormStack.Count > 0 then
  begin
    MoveInfo := FormStack.Pop;
    MoveInfo.OldForm.Show;
    if MoveInfo.KillAfter then
      NewForm.Release;
  end;
end;

procedure TFormNavigator.MoveForward(NewForm: TForm; KillAfter: boolean = false);
begin
  FormStack.Push(TMoveInfo.Create(KillAfter));
  NewForm.Show;
  TMoveInfo(FormStack.Peek).OldForm.Hide;
end;

{ TMoveInfo }

constructor TMoveInfo.Create(KillAfter: boolean);
begin
  inherited Create;
  OldForm := Screen.ActiveForm;
  self.KillAfter := KillAfter;
end;

function TFormNavigator.Level: integer;
begin
  result := FormStack.Count;
end;

end.
