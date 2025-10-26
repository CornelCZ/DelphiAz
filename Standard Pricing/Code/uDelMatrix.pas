unit uDelMatrix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfDelMatrix = class(TForm)
    lbMatrix: TListBox;
    btnDel: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDelClick(Sender: TObject);
  private
    { Private declarations }
    function MatrixUsedBySite(MatrixID : integer) : boolean;
  public
    { Public declarations }
    CurrentMatrixName: String;
    CurrentMatrixDeleted, UnSavedChanges: Boolean;
  end;

  TIntObject = class(TObject)
    Value: integer;
  end;

implementation

uses uADO, uGlobals, uPricinglog;

{$R *.dfm}

procedure TfDelMatrix.FormShow(Sender: TObject);
var
  AObject: TIntObject;
begin
  lbMatrix.Clear;

  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select MatrixID, MatrixName from PriceMatrix');
    SQL.Add('where Deleted = 0');

    if UnSavedChanges then
      SQL.Add('and MatrixName <> ' + QuotedStr(CurrentMatrixName));

    SQL.Add('order by MatrixID');
    Open;

    while not EOF do
    begin
      AObject := TIntObject.Create;
      AObject.Value := FieldByName('MatrixID').AsInteger;

      lbMatrix.Items.AddObject(FieldByName('MatrixName').AsString, AObject);

      Next;
    end;

    Close;
  end;

  if lbMatrix.Count > 0 then
    lbMatrix.ItemIndex := 0;
end;

procedure TfDelMatrix.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  for i := 0 to lbMatrix.Count - 1 do
    TIntObject(lbMatrix.Items.Objects[i]).Free;
end;



procedure TfDelMatrix.btnDelClick(Sender: TObject);
var
  MatrixID: integer;
  MatrixName: string;
begin
  MatrixID := TIntObject(lbMatrix.Items.Objects[lbMatrix.ItemIndex]).Value;
  MatrixName := lbMatrix.Items.Strings[lbMatrix.ItemIndex];

  //Disallow the deletion if the matrix is assigned to any sites.
  if MatrixUsedBySite(MatrixID) then
  begin
    ShowMessage('This matrix is currently assigned to a site and therefore cannot be deleted');
    ModalResult := mrNone;
    Exit;
  end;

  if MessageDlg('Are you sure you wish to delete matrix ' + MatrixName + '?' ,
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('update PriceMatrix');
      SQL.Add('set Deleted = 1, LMDT = GetDate(), LMBy = ' + QuotedStr(CurrentUser.UserName));
      SQL.Add('where MatrixID = ' + inttostr(MatrixID));
      ExecSQL;
      Close;
    end;

    Log.Event('Delete Matrix ', 'Matrix ' + inttostr(MatrixID) +
      ' - ' + MatrixName + ' has been deleted.');

    CurrentMatrixDeleted := MatrixName = CurrentMatrixName;
  end
  else
    ModalResult := mrCancel;
end;


{ Return TRUE if the given price matrix id is assigned to any sites }
function TfDelMatrix.MatrixUsedBySite(MatrixID : integer) : boolean;
begin
  with dmADO.adoqRun do
  try
    Close;
    SQL.Text :=
      'SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END as MatrixInUse ' +
      'FROM SiteMatrix ' +
      'WHERE (CurrentMatrix = ' + IntToStr(MatrixID) +
         ' OR FutureMatrix = ' + IntToStr(MatrixID) + ') ' +
         ' AND DELETED = 0';
    Open;
    Result := (FieldByName('MatrixInUse').AsInteger = 1);
  finally
    Close;
  end;
end;

end.
