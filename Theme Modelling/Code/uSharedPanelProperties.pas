unit uSharedPanelProperties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ToolWin, ActnMan, ActnCtrls, StdCtrls, ComCtrls,
  ImgList, Mask, Spin;

type
  TfrmSharedPnlInfo = class(TForm)
    ActionManager1: TActionManager;
    Action1: TAction;
    Action2: TAction;
    ImageList1: TImageList;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    sEdtWidth: TSpinEdit;
    Label3: TLabel;
    sEdtHeight: TSpinEdit;
    Button1: TButton;
    Button2: TButton;
    lblTop: TLabel;
    sEdtTop: TSpinEdit;
    lblLeft: TLabel;
    sEdtLeft: TSpinEdit;
    procedure edtWidthIBKeyPress(Sender: TObject; var Key: Char);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtWidthIBKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mEdtLeftOffsetKeyPress(Sender: TObject; var Key: Char);
    procedure sEdtWidthKeyPress(Sender: TObject; var Key: Char);
    procedure sEdtWidthKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function ValidateFields : Boolean;
  public
    { Public declarations }
  end;

implementation

uses
  uAztecLog;

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TfrmSharedPnlInfo.edtWidthIBKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    Action1Execute(self)
  else if not (Key in ['0','1','2','3','4','5','6','7','8','9']) then
    Key := #0;
end;

//------------------------------------------------------------------------------
function TfrmSharedPnlInfo.ValidateFields : Boolean;
begin
  Result := True;
  if sEdtWidth.Value < 1 then
  begin
    MessageDlg('Width must be at least 1 button wide!',mtError, [mbOK], 0);
    sEdtWidth.SetFocus;
    Result := False;
  end
  else if sEdtHeight.Value < 1 then
  begin
    MessageDlg('Height must be at least 1 button High!',mtError, [mbOK], 0);
    sEdtHeight.SetFocus;
    Result := False;
  end
  else if (sEdtLeft.Value + sEdtWidth.Value > 14) or (sEdtTop.Value + sEdtHeight.Value > 14) then
  begin
    MessageDlg('New position is invalid.  Panel dimensions should not exceed the screen layout.', mtError, [mbOK], 0);
    Result := False;
  end;
end;

//------------------------------------------------------------------------------
procedure TfrmSharedPnlInfo.Action1Execute(Sender: TObject);
begin
  ButtonClicked(Sender);
  if ValidateFields then
    ModalResult := mrOK;
end;

//------------------------------------------------------------------------------
procedure TfrmSharedPnlInfo.Action2Execute(Sender: TObject);
begin
  ButtonClicked(Sender);
  
  ModalResult := mrCancel;
end;

//------------------------------------------------------------------------------
procedure TfrmSharedPnlInfo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Escape then
    modalResult := mrCancel
end;

procedure TfrmSharedPnlInfo.edtWidthIBKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Escape then
    ModalResult := mrCancel;
end;

//------------------------------------------------------------------------------
procedure TfrmSharedPnlInfo.mEdtLeftOffsetKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
    Action1Execute(self);
end;

//------------------------------------------------------------------------------
procedure TfrmSharedPnlInfo.sEdtWidthKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    Action1Execute(self)
  else if Key = #27 then
    modalREsult := mrCancel;
end;

//------------------------------------------------------------------------------
procedure TfrmSharedPnlInfo.sEdtWidthKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Return then
    Action1Execute(self)
end;

//------------------------------------------------------------------------------
procedure TfrmSharedPnlInfo.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
end;

//------------------------------------------------------------------------------
procedure TfrmSharedPnlInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
end;

//------------------------------------------------------------------------------
end.
