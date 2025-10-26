unit uinscode;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, Db, DBTables, Dialogs, ADODB;

type
  TfrmInsCodeCateg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    CodeCatListBox: TListBox;
    CategoryEdit: TEdit;
    ReportCodeEdit: TEdit;
    CatLbl: TLabel;
    CodeLbl: TLabel;
    CodeHint: TLabel;
    Panel1: TPanel;
    HintLbl: TLabel;
    Label1: TLabel;
    QGetCodeCatNames: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CodeCatListBoxClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DisplayHint(Sender: TObject);
  end;

var
  frmInsCodeCateg: TfrmInsCodeCateg;

implementation

uses 
  uDMWklyPrchRep, config, uLog;

{$R *.DFM}

procedure TfrmInsCodeCateg.DisplayHint(Sender: TObject);
begin

end;

procedure TfrmInsCodeCateg.FormShow(Sender: TObject);
begin
  Log.Event('InsCodeCateg; FormShow');
  try
    QGetCodeCatNames.Close;
    QGetCodeCatNames.Open;
    QGetCodeCatNames.First;

    CodeCatListBox.Items.Clear;
    CategoryEdit.Text := '';
    ReportCodeEdit.Text := '';
    ReportCodeEdit.Enabled := False;

    while not QGetCodeCatNames.EOF do
    begin
      CodeCatListBox.Items.Add(QGetCodeCatNames.FieldByName('Category Name').AsString);
      QGetCodeCatNames.Next;
    end;
    QGetCodeCatNames.Close;
  except
    on E: Exception do
    begin
      Log.Event('InsCodeCateg ERROR - FormShow: ' + E.Message + '; ' + QGetCodeCatNames.SQL.Text);
      raise;
    end;
  end;
end;

procedure TfrmInsCodeCateg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QGetCodeCatNames.Close;
  log.event('InsCodeCateg; FormClose');
end;

procedure TfrmInsCodeCateg.CodeCatListBoxClick(Sender: TObject);
Var
  i: integer;
begin
  for i := 0 to CodeCatListBox.items.Count - 1 do
  begin
    if CodeCatListBox.Selected[i] then
    begin
      CategoryEdit.Text := CodeCatListBox.Items.Strings[i];
      ReportCodeEdit.Text := '';
    end;
  end;
  ReportCodeEdit.Enabled := True;
  ReportCodeEdit.SetFocus;
end;

procedure TfrmInsCodeCateg.OKBtnClick(Sender: TObject);
begin
  log.event('InsCodeCateg; OK button pressed');
  if (CategoryEdit.Text <> '') and (ReportCodeEdit.text <> '') then
  begin
    log.event('InsCodeCateg; OKBtnClick: frmMainConfig.wwCodeCatsTbl opened: ' + frmMainConfig.wwCodeCatsTbl.TableName);
    frmMainConfig.wwCodeCatsTbl.open;
    if  frmMainConfig.wwCodeCatsTbl.Locate('Code',ReportCodeEdit.text,[]) then
    begin
      ShowMessage('Code: '+ReportCodeEdit.text+' already exists.'+#13+'Category codes must be unique.');
      log.event('InsCodeCateg; ERROR: OKBtnClick: Code: '+ReportCodeEdit.text+' already exists.'+#13+'Category codes must be unique.');
      ReportCodeEdit.text:= '';
    end
    else
      modalResult := mrOK;
    //frmMainConfig.wwCodeCatsTbl.close;
  end
  else
  begin
    if CategoryEdit.Text = '' then
    begin
      ShowMessage('You must select a valid Category.');
      log.event('InsCodeCateg; ERROR: OKBtnClick: You must select a valid Category.');
    end
    else
    begin
      ShowMessage('You must enter a 2 character Report Code.');
      log.event('InsCodeCateg; ERROR: OKBtnClick: You must enter a 2 character Report Code.');
    end;

    modalResult := mrNone;
  end; //ifelse (outer)
end;

procedure TfrmInsCodeCateg.FormCreate(Sender: TObject);
begin
  log.event('InsCodeCateg; FormCreate');
end;

end.
