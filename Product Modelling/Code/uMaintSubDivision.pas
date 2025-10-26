unit uMaintSubDivision;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfMaintSubDivision = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edtSubDivisionName: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
    FSubDivisionName: String;
    FDivision: Integer;
  public
    { Public declarations }
    property SubDivisionName: String read FSubDivisionName;
    property Division: Integer read FDivision write FDivision;
  end;

var
  fMaintSubDivision: TfMaintSubDivision;

implementation

uses uADO, uLog;

//uses uADO, uLog, uDatabaseADO, uGlobals;

{$R *.dfm}

procedure TfMaintSubDivision.btnOKClick(Sender: TObject);
begin
  if edtSubDivisionName.Text = '' then
  begin
    ShowMessage('Please supply a name for the Sub Division.');
    edtSubDivisionName.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;

  with dmADO.adoqRun do
  begin
    Log.Event('Create Sub Division - ' + QuotedStr(edtSubDivisionName.Text));

    Close;
    SQL.Clear;
    SQL.Add('DECLARE @ID INT');
    SQL.Add(Format('EXEC zsp_LegacyInsertSubDivision %s,%d,@ID OUTPUT',
            [QuotedStr(edtSubDivisionName.Text),
             Division]));
    try
      ExecSQL;
      Close;
      FSubDivisionName := edtSubDivisionName.Text;
    except
      on E:Exception do
      begin
        log.Event('Create Sub Division Failure - ' + E.Message);
        MessageDlg('Failed to create Sub Division: ' + E.Message,
          mtError,
          [mbOK],
          0);
        ModalResult := mrNone;
      end;
    end;
  end;
end;

end.
