unit uPickFutureDate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TPickFutureDate = class(TForm)
    Label1: TLabel;
    dtpFutureDate: TDateTimePicker;
    btOk: TButton;
    btCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
