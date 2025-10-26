unit uinscat;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, Db, DBTables, Wwdatsrc, Dialogs, ComCtrls,
  ADODB;

type
  TInsertFixCatDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    FixCatListBox: TListBox;
    CatnameEdit: TEdit;
    RepNameEdit: TEdit;
    CatNameLbl: TLabel;
    RepNameLbl: TLabel;
    Label1: TLabel;
    RepnameInfoLbl: TLabel;
    Panel1: TPanel;
    HintLbl: TLabel;
    QGetFixedCatNames: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FixCatListBoxClick(Sender: TObject);
    procedure RepNameEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FixDisplayHint(Sender: TObject);
  end;

var
  InsertFixCatDlg: TInsertFixCatDlg;

implementation

uses 
  config, uLog;

{$R *.DFM}

procedure TInsertFixCatDlg.FixDisplayHint(Sender: TObject);
begin

end;

procedure TInsertFixCatDlg.FormShow(Sender: TObject);
begin
  try
    QGetFixedCatNames.Close;
    QGetFixedCatNames.Open;
    QGetFixedCatNames.First;

    FixCatListBox.Items.Clear;
    CatnameEdit.Text := '';
    RepNameEdit.Text := '';
    RepNameEdit.Enabled := False;

    while not QGetFixedCatNames.EOF do
    begin
      FixCatListBox.Items.Add(QGetFixedCatNames.FieldByName('Category Name').AsString);
      QGetFixedCatNames.Next;
    end;
    QGetFixedCatNames.Close;
  except
    on E: Exception do
    begin
      log.Event('InsertFixCatDlg; ERROR - FormShow: ' + E.Message + '; ' + QGetFixedCatNames.SQL.Text);
      raise;
    end;
  end;
end;

procedure TInsertFixCatDlg.OKBtnClick(Sender: TObject);
begin
  log.event('InsertFixCatDlg; OKBtnClick');
  if (CatnameEdit.Text <> '') and (RepNameEdit.text <> '') then
  begin
    if Length(RepNameEdit.Text)>10 then
    begin
      ShowMessage(#39+RepNameEdit.text+#39+' is more than 10 characters.'+#13+
           				 'Please reduce the size of the Report Name.');
    end
    else if frmMainConfig.wwFixedCatsTbl.Locate('Report Name',RepNameEdit.text,[]) then
    begin
      ShowMessage('Report Name: '+RepNameEdit.text+' already exists.'+#13+'Report names must be unique.');
      RepNameEdit.text:= '';
    end
    else
      modalResult := mrOK;
  end
  else
  begin
    if CatnameEdit.Text = '' then
    begin
      ShowMessage('You must select a valid Category.');
    end
    else
    begin
      ShowMessage('You must enter a Report Name.');
    end;
    modalResult := mrNone;
  end; //ifelse (outer)
end;

procedure TInsertFixCatDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  QGetFixedCatNames.Close;
  log.event('InsertFixCatDlg; FormClose');
end;

procedure TInsertFixCatDlg.FixCatListBoxClick(Sender: TObject);
Var
  i: integer;
begin
  for i := 0 to FixCatListBox.items.Count - 1 do
  begin
    if FixCatListBox.Selected[i] then
    begin
      if Pos('[',FixCatListBox.Items.Strings[i]) > 0 then
        Raise Exception.Create('The selected category ''' + FixCatListBox.Items.Strings[i] + ''' contains the invalid character ''[''.' + #13#10 +
                               'Please remove all instances of ''['' from the subcategory name before trying to select it again.');
      CatnameEdit.Text := FixCatListBox.Items.Strings[i];
      RepNameEdit.Text := FixCatListBox.Items.Strings[i];
    end;
  end;
  RepNameEdit.Enabled := True;
  RepNameEdit.SetFocus;
end;

procedure TInsertFixCatDlg.RepNameEditChange(Sender: TObject);
begin
  if Length(RepNameEdit.Text)>10 then
  begin
    HintLbl.Caption := #39+RepNameEdit.text+#39+' is more than 10 characters.'+#13+
           				 'Please reduce the size of the Report Name.';
    OKBtn.Enabled := False;
  end
  else
  begin
    HintLbl.Caption := '';
    OKBtn.Enabled := True;
  end;
end;

procedure TInsertFixCatDlg.FormCreate(Sender: TObject);
begin
  log.event('InsertFixCatDlg; FormCreate');
end;

end.
