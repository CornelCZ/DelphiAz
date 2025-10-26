unit uImportStock;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, DB, Wwdatsrc, Grids, Wwdbigrd, Wwdbgrid, Dialogs;

type
  TImportStockForm = class(TForm)
    lblDescription: TLabel;
    gridDlg: TwwDBGrid;
    dsDlg: TwwDataSource;
    btnImport: TBitBtn;
    btnNoImport: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure GetStockToCopy(var AStockCode, AThreadID: integer);

implementation

uses uData1;

{$R *.DFM}

procedure GetStockToCopy(var AStockCode, AThreadID: integer);
var
  ImportStockForm: TImportStockForm;
begin
  ImportStockForm := TImportStockForm.Create(nil);

  try
    if ImportStockForm.ShowModal = mrOK then
    begin
      AStockCode := data1.adoqRun.FieldByName('StockCode').AsInteger;
      AThreadID := data1.adoqRun.FieldByName('TID').AsInteger;
    end;
  finally
    FreeAndNil(ImportStockForm);
  end;
end;

procedure TImportStockForm.FormShow(Sender: TObject);
begin
  lblDescription.Caption := 'The system has detected several accepted ' +
    data1.SSplural + ' for this division that have the same End Date/Time.' + #13#13 +
    'Select a ' + data1.SSlow + ' to import into the Audit Counts.';
end;

procedure TImportStockForm.btnImportClick(Sender: TObject);
begin
  if MessageDlg('Importing will overwrite any counts already saved.  Are you sure you wish to import?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    ModalResult := mrOK
  else
    ModalResult := mrNone;
end;

end.
