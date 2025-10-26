unit uMaintSuperCategory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfMaintSuperCategory = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edtSuperCategName: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
    FSubDivision: Integer;
    FSuperCategoryName: String;
  public
    { Public declarations }
    property SubDivision: Integer read FSubDivision write FSubDivision;
    property SuperCategoryname: String read FSuperCategoryName;
  end;

var
  fMaintSuperCategory: TfMaintSuperCategory;

implementation

uses uADO, uLog;

{$R *.dfm}

procedure TfMaintSuperCategory.btnOKClick(Sender: TObject);
begin
  if edtSuperCategName.Text = '' then
  begin
    ShowMessage('Please supply a name for the Super Category.');
    edtSuperCategName.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;

  with dmADO.adoqRun do
  begin
    Log.Event('Create Super Category - ' + QuotedStr(edtSuperCategName.Text));

    Close;
    SQL.Clear;
    SQL.Add('DECLARE @ID INT');
    SQL.Add(Format('EXEC zsp_LegacyInsertSuperCategory %s,%d,@ID OUTPUT',
            [QuotedStr(edtSuperCategName.Text),
             SubDivision]));
    try
      ExecSQL;
      Close;
      FSuperCategoryName := edtSuperCategName.Text;
    except
      on E:Exception do
      begin
        log.Event('Create Super Category Failure - ' + E.Message);
        MessageDlg('Failed to create Super Category: ' + E.Message,
          mtError,
          [mbOK],
          0);
        ModalResult := mrNone;
      end;
    end;
  end;
end;

end.
