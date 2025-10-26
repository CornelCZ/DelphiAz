unit FrmAboutU;

interface

uses
  Windows, Messages, SysUtils,
  {$IFDEF Delph6}
  Variants,
  {$ENDIF}      
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmAbout = class(TForm)
    btnOk: TButton;
    memAbout: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAbout: TFrmAbout;

implementation

{$R *.dfm}

end.
