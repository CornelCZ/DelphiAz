unit uExpTake;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfExpTake = class(TForm)
    Label3: TLabel;
    lblCurVal: TLabel;
    Label5: TLabel;
    edVal: TEdit;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    Label38: TLabel;
    lblWeek: TLabel;
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    newvalue : double;
  end;

var
  fExpTake: TfExpTake;

implementation

{$R *.DFM}

procedure TfExpTake.btnOKClick(Sender: TObject);
var
  theval : double;
begin
  // check new value is a float, check is not bigger than 9,999,999.99
  // and then get out...

  try
    theval := strtofloat(edVal.text);
  except
    on exception do
    begin
      showmessage('"' + edVal.text + '" is not a valid entry!' + #13 +
        'Type a number (without using any currency sign), e.g. 6400.56');
      edVal.text := '0.00';
      edVal.SetFocus;
      edVal.SelectAll;
      exit;
    end;
  end;

  if theval >= 10000000 then
  begin
    showmessage('"' + edVal.text + '" is too much!' + #13 +
      'Type a number smaller than 10,000,000.00');
    edVal.text := '0.00';
    edVal.SetFocus;
    edVal.SelectAll;
    exit;
  end;

  newvalue := theval;
  modalResult := mrOK;
end;

end.
