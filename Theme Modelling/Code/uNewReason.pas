unit uNewReason;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Dialogs;

type
  TfrmNewReason = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    gbNewReason: TGroupBox;
    edNewReason: TEdit;
    lblNewReason: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edNewReasonChange(Sender: TObject);
  private
    function DuplicateReasonName(const AReasonName: string): boolean;
  end;

function GetReasonName(out AReasonName: string): boolean;

implementation

{$R *.DFM}

uses uADO;

function GetReasonName(out AReasonName: string): boolean;
var
  frmNewReason : TfrmNewReason;
begin
  frmNewReason :=  TfrmNewReason.Create(nil);

  try
    Result := (frmNewReason.ShowModal = mrOK);
    AReasonName := frmNewReason.edNewReason.Text;
  finally
    FreeAndNil(frmNewReason);
  end;
end;

function TfrmNewReason.DuplicateReasonName(const AReasonName: string): boolean;
begin
  with dmADO.qRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from ThemeReason');
    SQL.Add('where [Name] = ' + QuotedStr(AReasonName));
    Open;

    Result := (RecordCount > 0);

    Close;
  end;
end;

procedure TfrmNewReason.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (ModalResult = mrOK) and (DuplicateReasonName(edNewReason.Text)) then
  begin
    CanClose := FALSE;
    ShowMessage('A Reason named "' + edNewReason.Text + '" already exists.');
  end;
end;

procedure TfrmNewReason.edNewReasonChange(Sender: TObject);
begin
  btnOK.Enabled := (edNewReason.Text <> '');
end;

end.
