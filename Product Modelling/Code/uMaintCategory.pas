unit uMaintCategory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfMaintCategory = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edtCategName: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    CategoryDescMemo: TMemo;
    DescriptionLabel: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FDivisionID: Integer;
    FSuperCategoryID: Integer;
    FCategoryName: String;
  public
    { Public declarations }
    property DivisionID: Integer read FDivisionID write FDivisionID;
    property SuperCategoryID: Integer read FSuperCategoryID write FSuperCategoryID;
    property CategoryName: String read FCategoryName;
  end;

var
  fMaintCategory: TfMaintCategory;

implementation

uses uLog, uADO, uDatabaseADO, uGlobals;

{$R *.dfm}

procedure TfMaintCategory.btnOKClick(Sender: TObject);
var
  Description: String;
begin
  if edtCategName.Text = '' then
  begin
    ShowMessage('Please supply a name for the Category.');
    edtCategName.SetFocus;
    ModalResult := mrNone;
    Exit;
  end;


  with dmADO.adoqRun do
  begin
    if CategoryDescMemo.Text = '' then
      Description := 'null'
    else
      Description := QuotedStr(CategoryDescMemo.Text);

    Log.Event('Create Category - ' + QuotedStr(edtCategName.Text));

    Close;
    SQL.Clear;
    SQL.Add('DECLARE @ID INT');
    SQL.Add(Format('EXEC zsp_LegacyInsertCategory %s,%s,%d,%d,@ID OUTPUT',
            [QuotedStr(edtCategName.Text),
             Description,
             FSuperCategoryID,
             FDivisionID]));
    try
      ExecSQL;
      Close;
      FCategoryName := edtCategName.Text;
    except
      on E:Exception do
      begin
        log.Event('Create Category Failure - ' + E.Message);
        MessageDlg('Failed to create category: ' + E.Message,
          mtError,
          [mbOK],
          0);
        ModalResult := mrNone;
      end;
    end;
  end;
end;

procedure TfMaintCategory.FormShow(Sender: TObject);
begin
  setHelpContextID( self, AZPM_NEW_CATEGORY_FORM );
end;

end.
