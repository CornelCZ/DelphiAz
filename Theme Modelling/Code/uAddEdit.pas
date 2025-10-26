unit uAddEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ComCtrls, ToolWin, ImgList, ExtCtrls;

type
  TfrmAddEdit = class(TForm)
    dsEditRec: TDataSource;
    GroupBox1: TGroupBox;
    ImageList1: TImageList;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    lblStarDesc: TLabel;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  protected
    function ValidateFields : Boolean; virtual;
    procedure SaveChanges; virtual;
    procedure CancelChanges; virtual;
  public
    FMode : Integer;
    FSiteCode: integer;
    FParentDeviceID: Integer;
    //TODO: This seems like the wrong place for FCanSetMultiDrawerMode as this
    //      abstract class is used as the basis for both uAddEditPrinter and
    //      uAddEditTerminal.
    //      EB 21/4/'17
    FCanSetMultiDrawerMode: Boolean;
  end;

const
  EDIT_TERMINAL = 0;
  ADD_TERMINAL = 1;
  EDIT_SERVER = 2;
  ADD_SERVER = 3;
  EDIT_CONQUEROR_TERMINAL = 4;
  ADD_CONQUEROR_TERMINAL = 5;
  EDIT_CONQUEROR_SERVER = 6;
  EDIT_MOA_ORDER_PAD = 7;
  SHOW_IZONE_TABLES = 8;

  EDIT_PERIPHERAL = 0;
  ADD_PERIPHERAL = 1;


implementation

uses
  uAztecLog;

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TfrmAddEdit.btnSaveClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  if ValidateFields then
  begin
    SaveChanges;
    ModalResult := mrOK;
  end;
end;

procedure TfrmAddEdit.SaveChanges;
begin
  dsEditRec.DataSet.Post;
end;
//------------------------------------------------------------------------------
procedure TfrmAddEdit.btnCancelClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  ModalResult := mrCancel;
end;

procedure TfrmAddEdit.CancelChanges;
begin
  dsEditRec.DataSet.Cancel;
end;
//------------------------------------------------------------------------------
function TfrmAddEdit.ValidateFields: Boolean;
begin
  Result := True;
end;

//------------------------------------------------------------------------------
procedure TfrmAddEdit.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
  case FMode of
    EDIT_TERMINAL, EDIT_SERVER, EDIT_CONQUEROR_TERMINAL,
    EDIT_CONQUEROR_SERVER, EDIT_MOA_ORDER_PAD, SHOW_IZONE_TABLES:
      dsEditRec.DataSet.Edit;
    ADD_TERMINAL, ADD_SERVER, ADD_CONQUEROR_TERMINAL:
      dsEditRec.DataSet.Append;
  end;
end;

//------------------------------------------------------------------------------
procedure TfrmAddEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if dsEditRec.State in [dsEdit, dsInsert] then
  begin
    if MessageDlg('Cancel changes and close Form?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      CanClose := FALSE
    else
    begin
      CancelChanges;
      CanClose := TRUE;
      ModalResult := mrCancel;
    end;
  end;
end;

//------------------------------------------------------------------------------
procedure TfrmAddEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
end;


end.
