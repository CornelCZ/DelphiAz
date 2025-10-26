unit uLCTempl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, Grids, Wwdbigrd, Wwdbgrid, DB,
  Wwdatsrc, ADODB, ExtCtrls, Mask, wwdbedit;

type
  TfLCtempl = class(TForm)
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    wwDataSource1: TwwDataSource;
    wwDataSource2: TwwDataSource;
    wwDBGrid1: TwwDBGrid;
    wwDBGrid2: TwwDBGrid;
    DBText1: TDBText;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    Edit1: TEdit;
    Memo1: TMemo;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    pnlManage: TPanel;
    Label8: TLabel;
    wwDBGrid3: TwwDBGrid;
    Label9: TLabel;
    ADOQuery3: TADOQuery;
    wwDataSource3: TwwDataSource;
    Label10: TLabel;
    Label11: TLabel;
    wwDBEdit1: TwwDBEdit;
    wwDBGrid4: TwwDBGrid;
    Label12: TLabel;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fLCtempl: TfLCtempl;

implementation

uses uADO;

{$R *.dfm}

procedure TfLCtempl.BitBtn3Click(Sender: TObject);
begin
  // is there a name?
  if edit1.Text = '' then
  begin
    showmessage('Please type a name (unique per Division) for this Template!');
    edit1.SetFocus;
    exit;
  end;

  // is it unique per div?
  if adoquery1.Locate('tname', edit1.Text, []) then
  begin
    showmessage('The Template name has to be unique for this Division!' + #13 +
      'There is already a Template named "' + edit1.Text + '". Try again.');
    edit1.SetFocus;
    exit;
  end;

  // that's OK then
  modalResult := mrOK;
end;

procedure TfLCtempl.BitBtn6Click(Sender: TObject);
begin
  if adoquery3.State = dsEdit then
    adoquery3.Post;

  if MessageDlg('About to delete Line Check selection template "' +
    adoQuery3.FieldByName('TName').AsString + '"' +
    '(Division: "' + adoQuery3.FieldByName('div').AsString +
    ')'+#13+#10+''+#13+#10+'Are you sure?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
  begin
    // delete selected template and all products from TemplEnts
    adoQuery2.DisableControls;
    adoQuery3.DisableControls;
    with dmADO.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('delete from LineCheckTemplateDetail');
      sql.Add('where TemplateID = ' + adoQuery3.FieldByName('TemplateID').AsString);
      sql.Add('');
      sql.Add('delete from LineCheckTemplate');
      sql.Add('where TemplateID = ' + adoQuery3.FieldByName('TemplateID').AsString);
      execSQL;
    end;
    adoQuery2.Close;
    adoQuery3.Close;
    adoQuery3.Open;
    adoQuery3.EnableControls;
    adoQuery2.Open;
    adoQuery2.EnableControls;
  end;

  if adoQuery3.RecordCount = 0 then
  begin
    showMessage('There are no more LC Selection Templates to manage!');

    modalResult := mrNoToAll;
  end;

end;

procedure TfLCtempl.BitBtn5Click(Sender: TObject);
begin
  if adoquery3.State = dsEdit then
    adoquery3.Post;
end;

procedure TfLCtempl.FormShow(Sender: TObject);
begin
  if pnlManage.Visible then
  begin
    self.HelpContext := 1039;
  end
  else
  begin
    if panel1.Visible then
      self.HelpContext := 1040
    else
      self.HelpContext := 1041;
  end;
end;

end.
