unit uHZMoveChoose;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TfHZMoveChoose = class(TForm)
    BitBtnCancelAndExit: TBitBtn;
    BitBtnViewInternalTransfer: TBitBtn;
    BitBtnMakeInternalTransfer: TBitBtn;
    procedure ButtonMakeInternalTransferClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtnViewInternalTransferClick(Sender: TObject);
    procedure BitBtnMakeInternalTransferClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetupButtons;
  public
    { Public declarations }
  end;

var
  fHZMoveChoose: TfHZMoveChoose;

implementation

uses
  uHZMove, uHZMoveRep, udata1;

{$R *.dfm}

procedure TfHZMoveChoose.ButtonMakeInternalTransferClick(Sender: TObject);
begin
  fHZmove := TfHZmove.Create(self);
  try
    fHZmove.ShowModal;
    SetupButtons;
  finally
    fHZmove.Release;
  end;
end;

procedure TfHZMoveChoose.FormShow(Sender: TObject);
begin
  SetupButtons
end;

procedure TfHZMoveChoose.SetupButtons;
begin
  with data1.adoqRun do
  try
    close;
    sql.Clear;
    sql.Add('select count(MoveID) as NumHZMoves from stkHZmoves');
    open;

    if FieldByName('NumHZMoves').AsInteger > 0 then
    begin
      BitBtnViewInternalTransfer.Enabled := True;
      BitBtnViewInternalTransfer.Caption := '&View Internal Transfer';
    end
    else
    begin
      BitBtnViewInternalTransfer.Enabled := False;
      BitBtnViewInternalTransfer.Caption := 'No Internal Transfers to View';
    end;
  finally
    close;
  end;
end;

procedure TfHZMoveChoose.BitBtnViewInternalTransferClick(Sender: TObject);
var
  fHZMoveRep: TfHZMoveRep;
begin
  fHZMoveRep := TfHZMoveRep.Create(Self);
  try
    fHZMoveRep.ShowModal;
  finally
    fHZMoveRep.Release;
  end;
end;

procedure TfHZMoveChoose.BitBtnMakeInternalTransferClick(Sender: TObject);
begin
  fHZmove := TfHZmove.Create(self);
  try
    fHZmove.ShowModal;
    SetupButtons;
  finally
    fHZmove.Release;
  end;
end;

end.
