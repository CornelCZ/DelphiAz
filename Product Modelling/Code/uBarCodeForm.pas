unit uBarCodeForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask;

type
  TBarCodeForm = class(TForm)
    edtBarCode: TEdit;
    Label1: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    UseCustomBarcodeChkBx: TCheckBox;
    procedure edtBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edtBarCodeChange(Sender: TObject);
    procedure edtBarCodeEnter(Sender: TObject);
  private
    { Private declarations }
    tTempBarCode : String;
  public
    { Public declarations }
  end;

  function GetBarcodeFromUser(out barcode: string; out isCustomBarcode: boolean): boolean;

implementation

{$R *.dfm}

uses strUtils, uDatabaseADO, useful;

function GetBarcodeFromUser(out barcode: string; out isCustomBarcode: boolean): boolean;
begin
  Result := False;

  with TBarCodeForm.Create(nil) do
  try
    if ShowModal = mrOk then
    begin
      barcode := edtBarCode.Text;
      isCustomBarcode := UseCustomBarcodeChkBx.Checked;
      Result := True;
    end;
  finally
    Free;
  end;
end;

procedure TBarCodeForm.edtBarCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Ord(Key) in [Ord('0')..Ord('9'), VK_BACK]) and (Key <> #8)
     and (Key <> #3) and (Key <> #22) and (Key <> #24) then
    Abort;
  tTempBarCode := TEdit(Sender).Text;
end;

procedure TBarCodeForm.btnOkClick(Sender: TObject);
begin
  if ProductsDB.ValidateBarCode(edtBarcode.Text, UseCustomBarcodeChkBx.Checked) then
    ModalResult := mrOk;
end;

procedure TBarCodeForm.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TBarCodeForm.edtBarCodeChange(Sender: TObject);
begin
   if (Length(TEdit(Sender).Text) > 0) and  not IsNumeric(TEdit(Sender).Text) then
      begin
        TEdit(Sender).Text := tTempBarCode;
        Raise Exception.Create('Barcode must be numeric.');
      end;
end;

procedure TBarCodeForm.edtBarCodeEnter(Sender: TObject);
begin
  tTempBarCode := TEdit(Sender).Text;
end;

end.
