unit uAddMatrix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfAddMatrix = class(TForm)
    btnCancel: TBitBtn;
    btnFinish: TBitBtn;
    lbMatrices: TListBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtMatrixName: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnFinishClick(Sender: TObject);
  private
    { Private declarations }
    function MatrixNameInUse(AMatrixName: string): boolean;
  public
    { Public declarations }
    MatrixName: string;
  end;

implementation

uses uADO;

{$R *.dfm}

procedure TfAddMatrix.FormShow(Sender: TObject);
begin
  lbMatrices.Clear;

  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select MatrixName from PriceMatrix');
    SQL.Add('where Deleted = 0');
    SQL.Add('order by MatrixID');
    Open;

    while not Eof do
    begin
      lbMatrices.Items.Add(FieldByName('MatrixName').AsString);

      Next;
    end;

    Close;
  end;
end;

procedure TfAddMatrix.btnFinishClick(Sender: TObject);
begin
  if (edtMatrixName.Text = '') or (MatrixNameInUse(edtMatrixName.Text)) then
    ModalResult := mrNone
  else
    MatrixName := edtMatrixName.Text;
end;

function TfAddMatrix.MatrixNameInUse(AMatrixName: string): boolean;
begin
  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select MatrixName');
    SQL.Add('from PriceMatrix');
    SQL.Add('where Deleted = 0');
    SQL.Add('and MatrixName = ' + QuotedStr(AMatrixName));
    Open;

    Result := RecordCount > 0;

    if Result then
      ShowMessage('A matrix with the name "' + AMatrixName + '" already exists.');

    Close;
  end;
end;

end.
