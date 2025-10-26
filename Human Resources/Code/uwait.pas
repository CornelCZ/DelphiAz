unit uwait;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls;

type
  Tfwait = class(TForm)
    Bar: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    Shape1: TShape;
  private
    procedure SetPercentComplete(const Value: ShortInt);
  public
    constructor Create(AOwner: TCOmponent); override;
    property PercentComplete : ShortInt write SetPercentComplete;
  end;

var
  fwait: Tfwait;

implementation

{$R *.DFM}

{ Tfwait }

constructor Tfwait.Create(AOwner: TComponent);
begin
  inherited;
  bar.position := 0;

  // If the owner is a form set this forms position relative to it.
  if AOwner is TForm then
    with AOwner as TForm do
    begin
      self.Top := Top + Height - self.Height - 16;
      self.Left := Left + trunc(Width / 2) - trunc(self.Width / 2);
    end;
end;

procedure Tfwait.SetPercentComplete(const Value: ShortInt);
begin
  bar.position := value;
  label2.caption := IntToStr(Value)+'%';
  Application.ProcessMessages;
end;

end.
