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
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fwait: Tfwait;

implementation

{$R *.DFM}

end.
