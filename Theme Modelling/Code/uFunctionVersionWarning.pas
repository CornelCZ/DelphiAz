unit uFunctionVersionWarning;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmFunctionVersionDlg = class(TForm)
    lblDescription: TLabel;
    Image1: TImage;
    Panel1: TPanel;
    cbxDontShowAgain: TCheckBox;
    btnOK: TButton;
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function ShowVersionWarning(AOwner: TForm) : Boolean;

implementation

uses
  uAztecLog;

{$R *.dfm}

//------------------------------------------------------------------------------
function ShowVersionWarning(AOwner: TForm) : Boolean;
var
  WarningDialog : TfrmFunctionVersionDlg;
begin
  WarningDialog := TfrmFunctionVersionDlg.Create(AOwner);

  try
    WarningDialog.ShowModal;
    Result := not (WarningDialog.cbxDontShowAgain.Checked);
  finally
    WarningDialog.Free;
  end;
end;

//------------------------------------------------------------------------------
procedure TfrmFunctionVersionDlg.btnOKClick(Sender: TObject);
begin
  if cbxDontShowAgain.Checked then
    Log('Do not show this message again during this session has been checked');
end;

//------------------------------------------------------------------------------
end.
