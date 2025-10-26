unit uMaintPrintStream;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfMaintPrintStream = class(TForm)
    btnOK: TBitBtn;
    lblTitle: TLabel;
    lblName: TLabel;
    btnCancel: TBitBtn;
    edtStreamName: TEdit;
    DescriptionLabel: TLabel;
    PrintStreamDescMemo: TMemo;
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMaintPrintStream: TfMaintPrintStream;

implementation

uses uLineEdit, uDatabaseADO, uADO, uLog, uGlobals, uLocalisedText;

{$R *.dfm}

procedure TfMaintPrintStream.btnOKClick(Sender: TObject);
var
  Description: String;
  ParamCheck_Temp: Boolean;
begin
  if edtStreamName.Text = '' then
  begin
    ShowMessage('Please supply a name for the ' + uLocalisedText.PrintStreamText + '.');
    edtStreamName.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;

  with dmADO.adoqRun do
  begin
    ParamCheck_Temp := ParamCheck;
    ParamCheck := False;
    try
      if PrintStreamDescMemo.Text = '' then
        Description := 'null'
      else
        Description := QuotedStr(PrintStreamDescMemo.Text);

      Log.Event('Create Print Stream - ' + QuotedStr(edtStreamName.Text));

      Close;
      SQL.Clear;
      SQL.Add('DECLARE @ID INT');
      SQL.Add(Format('EXEC zsp_LegacyInsertPrintStream %s,%s,@ID OUTPUT',
              [QuotedStr(edtStreamName.Text),Description]));
      try
        ExecSQL;
        Close;

        ProductsDB.AddPrinterStream(edtStreamName.Text);
        LineEditForm.setupStaticPickLists;
      except
        on E:Exception do
        begin
          log.Event('Create Print Stream Failure - ' + E.Message);
          MessageDlg('Failed to create print stream: ' + E.Message,
            mtError,
            [mbOK],
            0);
          ModalResult := mrNone;
        end;
      end;
    finally
      ParamCheck := ParamCheck_Temp;
    end;
  end;
end;

procedure TfMaintPrintStream.FormShow(Sender: TObject);
begin
  setHelpContextID( self, AZPM_NEW_PRINTSTREAM_FORM );
  Self.Caption := 'New ' + uLocalisedText.PrintStreamText;
  lblTitle.Caption := Self.Caption;
end;

end.
