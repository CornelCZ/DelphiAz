unit uProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Gauges;

type
  TProgressForm = class(TForm)
    ggProgress: TGauge;
  public
    constructor Create(ACaption : String); reintroduce; overload;
    procedure MoveOn(Value: integer);
  end;

implementation

{$R *.dfm}

{ TfProgress }

constructor TProgressForm.Create(ACaption: String);
begin
  inherited Create(nil);
  Caption := ACaption;
end;

procedure TProgressForm.MoveOn(Value: integer);
begin
  ggProgress.Progress := Value;
end;

end.
