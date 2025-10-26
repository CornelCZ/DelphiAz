unit uViewMOATerminal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uAddEdit, ImgList, DB, StdCtrls, ExtCtrls;

type
  TViewMOATerminal = class(TForm)
    GroupBox1: TGroupBox;
    lblSalesArea: TLabel;
    lblNumTerminals: TLabel;
    lblMOAEmployee: TLabel;
    edSalesArea: TEdit;
    edMOACount: TEdit;
    edMOAUser: TEdit;
    Panel1: TPanel;
    btnOK: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure ShowMOATerminal(aEposDeviceID, aSiteCode: integer);
  end;


implementation

uses uADO;

{$R *.dfm}

class procedure TViewMOATerminal.ShowMOATerminal(aEposDeviceID, aSiteCode: integer);
var
  MOATerminal: TViewMOATerminal;
begin
  MOATerminal := TViewMOATerminal.Create(nil);
  try
    dmADO.qGetMoaDetails.Parameters[0].Value := aSiteCode;
    dmADO.qGetMoaDetails.Parameters[1].Value := aEposDeviceID;
    dmADO.qGetMoaDetails.Open;
    with MOATerminal do
    begin
      edSalesArea.Text := dmADO.qGetMoaDetailsSalesArea.AsString;
      edMOAUser.Text := dmADO.qGetMoaDetailsMOAUser.AsString;
      edMOACount.Text := IntToStr(dmADO.qGetMoaDetailsMOACount.AsInteger);
      ShowModal;
    end;
  finally
    dmADO.qGetMoaDetails.Close;
    MOATerminal.Release;
  end;
end;

end.
