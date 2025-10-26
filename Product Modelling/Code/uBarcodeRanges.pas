unit uBarcodeRanges;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ExtCtrls, StdCtrls, Grids, Wwdbigrd, Wwdbgrid,
  ComCtrls, uADOBarcodeRanges;

type
  TfrmBarcodeRanges = class(TForm)
    pnlMain: TPanel;
    btnClose: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    gridBarcodes: TwwDBGrid;
    btnAdd: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    lblBarcodeRanges: TLabel;
    gridBarcodeExceptions: TwwDBGrid;
    btnAddException: TButton;
    btnDeleteException: TButton;
    lblRangeExceptions: TLabel;
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure gridBarcodesDblClick(Sender: TObject);
    procedure btnAddExceptionClick(Sender: TObject);
    procedure btnDeleteExceptionClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure gridBarcodesRowChanged(Sender: TObject);
  private
    { Private declarations }
    FBarcodeSource: TBarcodeRangeSource;   // Only 1 type (bcuProduct) for now.  Added this in case barcode ranges added to other data, e.g. Promotions
    FExceptionsModified: Boolean;
    FEntityCode: Double;
    procedure GenerateExceptionRanges(theBarcodeRangeID: Integer);
  public
    { Public declarations }
  end;

procedure ShowAllBarcodeRanges;
procedure ShowProductBarcodeRanges(_EntityCode: Double; ProductName: String);

var
  frmBarcodeRanges: TfrmBarcodeRanges;

implementation

uses uEditBarcodeRange, uBarcodeExceptionValue, uLog;

{$R *.dfm}

procedure ShowAllBarcodeRanges;
var
  Dlg : TfrmBarcodeRanges;
begin
  Dlg := nil;
  try
    Dlg := TfrmBarcodeRanges.Create(nil);
    Dlg.FBarcodeSource := brsNone;
    dmBarcodeRanges.dsBarcodeRanges.DataSet := dmBarcodeRanges.qAllBarcodeRanges;
    dmBarcodeRanges.qAllBarcodeRanges.Open;
    dmBarcodeRanges.dstBarcodeExceptions.Open;
    Dlg.ShowModal;
  finally
    Dlg.Free;
    dmBarcodeRanges.qAllBarcodeRanges.Close;
    dmBarcodeRanges.dstBarcodeExceptions.Close;
  end
end;

procedure ShowProductBarcodeRanges(_EntityCode: Double; ProductName: String);
var
  Dlg : TfrmBarcodeRanges;
begin
  Dlg := nil;
  try
    Dlg := TfrmBarcodeRanges.Create(nil);
    Dlg.FBarcodeSource := brsProduct;
    Dlg.FEntityCode := _EntityCode;
    Dlg.lblBarcodeRanges.Caption := 'Barcode Ranges for product "' + ProductName + '"';
    dmBarcodeRanges.dsBarcodeRanges.DataSet := dmBarcodeRanges.qProductBarcodeRanges;
    dmBarcodeRanges.qProductBarcodeRanges.Parameters.ParamByName('entityCode').Value := _EntityCode;
    dmBarcodeRanges.qProductBarcodeRanges.Open;
    dmBarcodeRanges.dstBarcodeExceptions.Open;
    Dlg.ShowModal;
  finally
    Dlg.Free;
    dmBarcodeRanges.qProductBarcodeRanges.Close;
    dmBarcodeRanges.dstBarcodeExceptions.Close;
  end
end;


procedure TfrmBarcodeRanges.btnAddClick(Sender: TObject);
var
  NewBarcodeRangeID: int64;
  WasAdded: Boolean;
begin

  case FBarcodeSource of
    brsNone : WasAdded := uEditBarcodeRange.AddBarcodeRange(FBarcodeSource, NewBarcodeRangeID, NULL);
    brsProduct: WasAdded := uEditBarcodeRange.AddBarcodeRange(FBarcodeSource, NewBarcodeRangeID, FEntityCode);
  else
    WasAdded := uEditBarcodeRange.AddBarcodeRange(FBarcodeSource, NewBarcodeRangeID, NULL);
  end;

  if not WasAdded then
    Exit;

  GenerateExceptionRanges(NewBarcodeRangeID);
  TADOQuery(gridBarcodes.DataSource.DataSet).Requery();
  dmBarcodeRanges.dstBarcodeExceptions.Requery();
  gridBarcodes.DataSource.DataSet.Locate('BarcodeRangeID', NewBarcodeRangeID, []);
end;


procedure TfrmBarcodeRanges.btnEditClick(Sender: TObject);
var
  SelectedBarcodeRangeID: Int64;
  WasModified: Boolean;
begin
  if (gridBarcodes.DataSource.DataSet.RecordCount = 0) then
    raise Exception.create('Please pick an item to edit first!');


  SelectedBarcodeRangeID := gridBarcodes.DataSource.DataSet.FieldByName('BarcodeRangeID').Value;
  WasModified := uEditBarcodeRange.EditBarcodeRange(SelectedBarcodeRangeID);

  if not WasModified then
    Exit;

  GenerateExceptionRanges(SelectedBarcodeRangeID);
  TADOQuery(gridBarcodes.DataSource.DataSet).Requery();
  dmBarcodeRanges.dstBarcodeExceptions.Requery();
  gridBarcodes.DataSource.DataSet.Locate('BarcodeRangeID', SelectedBarcodeRangeID, []);
end;


//TODO: 344322 Need to find out what checks should be done before allowing deletion
procedure TfrmBarcodeRanges.btnDeleteClick(Sender: TObject);
begin
 if (gridBarcodes.DataSource.DataSet.RecordCount = 0) then
    raise Exception.create('Please pick an item to delete first!')
 else
 begin
   if MessageDlg('Delete Barcode Range "' + gridBarcodes.DataSource.DataSet.FieldByName('Description').AsString +
          '".  Are you sure?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
     if (FBarcodeSource = brsProduct) then
     begin
       dmBarcodeRanges.qDeleteSelectedBarcodeRange.Parameters.ParamByName('barcodeRangeID').Value :=
         gridBarcodes.DataSource.DataSet.FieldByName('BarcodeRangeID').Value;
       dmBarcodeRanges.qDeleteSelectedBarcodeRange.ExecSQL;
     end;

     gridBarcodes.DataSource.DataSet.Delete;
   end;
 end;
end;


procedure TfrmBarcodeRanges.gridBarcodesDblClick(Sender: TObject);
begin
  btnEdit.Click;
end;


procedure TfrmBarcodeRanges.btnAddExceptionClick(Sender: TObject);
var
  i : integer;
  SelectedBarcodeRangeID: Int64;
  ExceptionList: TStringList;
  frmBarcodeExceptionValue: TBarcodeExceptionValue;
begin
  SelectedBarcodeRangeID := gridBarcodes.DataSource.DataSet.FieldByName('BarcodeRangeID').AsInteger;
  ExceptionList := TStringList.Create;
  with dmBarcodeRanges.dstBarcodeExceptions do
  begin
    First;
    while not EOF do
    begin
      ExceptionList.Add(FieldByName('Value').AsString);
      Next;
    end
  end;

  frmBarcodeExceptionValue := TBarcodeExceptionValue.Create(nil);
  with frmBarcodeExceptionValue do
  try
    ExStartValue := gridBarcodes.DataSource.DataSet.FieldByName('StartValue').asString;
    ExEndValue := gridBarcodes.DataSource.DataSet.FieldByName('EndValue').asString;
    FExceptionList := TStringList.Create;
    FExceptionList := ExceptionList;
    FExceptionsModified := FALSE;
    if ShowModal = mrOK then
    begin
      FExceptionsModified := True;
      for i := 0 to Pred(newExceptionList.Count) do
        with dmBarcodeRanges.dstBarcodeExceptions do
        begin
            Insert;
            FieldByName('ExceptionID').AsInteger := dmBarcodeRanges.GetNewId('ThemeBarcodeException_repl','ExceptionID');
            FieldByName('BarcodeRangeID').AsInteger := SelectedBarcodeRangeID;
            FieldByName('Value').AsString := newExceptionList[i];
            Post;
        end;
    end;
    dmBarcodeRanges.dstBarcodeExceptions.Close;
    dmBarcodeRanges.dstBarcodeExceptions.Open;
    newExceptionList.Free;
    if FExceptionsModified then
    begin
      GenerateExceptionRanges(SelectedBarcodeRangeID);
    end;
    Cursor := crDefault;
  finally
    ExceptionList.Free;
    FreeAndNil(frmBarcodeExceptionValue);
  end;
end;


procedure TfrmBarcodeRanges.btnDeleteExceptionClick(Sender: TObject);
var
  SelectedBarcodeRangeID: Integer;
begin
  if dmBarcodeRanges.dstBarcodeExceptions.RecordCount = 0 then
    raise Exception.Create('There are no exceptions to delete.')
  else
  begin
    FExceptionsModified := FALSE;
    SelectedBarcodeRangeID := dmBarcodeRanges.dstBarcodeExceptions.FieldByName('BarcodeRangeID').AsInteger;
    if MessageDlg('Delete Exception.  Are you sure?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      FExceptionsModified := True;
      dmBarcodeRanges.dstBarcodeExceptions.Delete;
    end;
    if FExceptionsModified then
      GenerateExceptionRanges(SelectedBarcodeRangeID);
  end;
end;


procedure TfrmBarcodeRanges.GenerateExceptionRanges(theBarcodeRangeID: Integer);
var
  originalParam, newParam: String;
begin
  originalParam := ':BarcodeRangeID -- IDParam';
  newParam := IntToStr(theBarcodeRangeID) + ' -- IDParam';
  
  with dmBarcodeRanges.qGenerateRanges do
  begin
    SQL.Text := StringReplace(SQL.Text, originalParam, newParam, [rfReplaceAll, rfIgnoreCase]);
    ExecSQL;
    SQL.Text := StringReplace(SQL.Text, newParam, originalParam, [rfReplaceAll, rfIgnoreCase]);
  end;
end;


procedure TfrmBarcodeRanges.FormShow(Sender: TObject);
begin
//
end;

procedure TfrmBarcodeRanges.gridBarcodesRowChanged(Sender: TObject);
begin
  if (gridBarcodes.DataSource.DataSet.RecordCount > 0) then
    lblRangeExceptions.Caption := 'Exceptions for range "' +
        dmBarcodeRanges.dsBarcodeRanges.DataSet.FieldByName('Description').AsString + '"';
end;

end.
