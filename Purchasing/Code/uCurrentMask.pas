unit uCurrentMask;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, DB, ADODB, Grids, Wwdbigrd, Wwdbgrid, dialogs, uADO;

type
  TfrmCurrentMask = class(TForm)
    Button1: TButton;
    dsMasks: TDataSource;
    qryMasks: TADOQuery;
    lblSupplier: TLabel;
    MaskGrid: TwwDBGrid;
    qryMasksSupplierName: TStringField;
    qryMasksConvertedMask: TStringField;
    qryMasksMask: TStringField;
    qryMasksMaskID: TSmallintField;
    qryMasksCurrentMask: TBooleanField;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  public
    theSupplier : string;
    selectedMaskID : Smallint;
  end;

implementation

uses uGlobals;

{$R *.DFM}

procedure TfrmCurrentMask.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (maskGrid.GetActiveRow < 0) then
  begin
    showmessage('You must select a mask as the current mask for Supplier ' +
                 theSupplier);
    CanClose := False;
  end
  else
  begin
    selectedMaskID := qryMasksMaskID.Value;
    CanClose := True;
  end;
end;

procedure TfrmCurrentMask.FormShow(Sender: TObject);
begin
  if HelpExists then
    setHelpContextID(self, HLP_CHOOSE_INVOICE_MASK);

  qryMasks.Close;
  qryMasks.Open;
  lblSupplier.Caption := 'Select the current mask for Supplier ' + theSupplier;
end;

end.
