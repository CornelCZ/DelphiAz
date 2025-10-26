unit uEditScaleContainer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls;

type
  TEditScaleContainer = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    lblName: TLabel;
    edtContainerName: TEdit;
    lblDescription: TLabel;
    memoDesc: TMemo;
    lblTareWeight: TLabel;
    edtTareWeight: TEdit;
    procedure edtTareWeightKeyPress(Sender: TObject; var Key: Char);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ContainerId: Integer;
  end;

var
  EditScaleContainer: TEditScaleContainer;

implementation

uses
 uAztecLog;

{$R *.dfm}

procedure TEditScaleContainer.edtTareWeightKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (Key in ['.','0'..'9',#8,#10])) then Key := #0;

  // Disallow multiple Decimal places
  if (Key = '.') and (Pos('.',TEdit(Sender).Text) > 0) then
    Key := #0;
end;

procedure TEditScaleContainer.btnOKClick(Sender: TObject);
var
  TrimmedName: String;
begin
  ButtonClicked(Sender);
  TrimmedName := Trim(edtContainername.Text);
  if (TrimmedName = '') then
    raise Exception.create('Please specify a name.');

  try
    StrToFloat(edtTareWeight.Text);
  except
    on E:EConvertError do
    begin
      raise Exception.Create('The tare weight entered is invalid.  Enter a tare weight without units and thousand separators.');
    end;
  end;

  modalresult := mrOk;
end;

end.
