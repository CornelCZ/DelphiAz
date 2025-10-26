unit uLCchoose;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfLCchoose = class(TForm)
    btnDoLC: TBitBtn;
    btnRepLC: TBitBtn;
    btnTempl: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnDoLCClick(Sender: TObject);
    procedure btnRepLCClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnTemplClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fLCchoose: TfLCchoose;

implementation

uses uLC, udata1, uLCTempl, uLCRep;

{$R *.dfm}

procedure TfLCchoose.btnDoLCClick(Sender: TObject);
begin
  fLC := TfLC.Create(self);
  fLC.ShowModal;
  fLC.Free;

  FormShow(self);
end;

procedure TfLCchoose.btnRepLCClick(Sender: TObject);
begin
  fLCRep := TfLCRep.Create(self);
  fLCRep.ShowModal;
  fLCRep.free;
end;

procedure TfLCchoose.FormShow(Sender: TObject);
begin
  with data1.adoqRun do
  begin
    // any templates to manage?
    close;
    sql.Clear;
    sql.Add('select templateID from LineCheckTemplate');
    open;

    if recordcount = 0 then
    begin
      btnTempl.Enabled := false;
      btnTempl.Caption := 'No LC Templates Set';
    end
    else
    begin
      btnTempl.Enabled := true;
      btnTempl.Caption := '&Manage LC Templates';
    end;
    close;

    // any Reports to see?
    if btnRepLC.Visible then
    begin
      close;
      sql.Clear;
      sql.Add('select count(*) from LineCheck');
      open;

      if fields[0].AsInteger = 0 then
      begin
        btnreplc.Enabled := false;
        btnreplc.Caption := 'No LCs to Report on yet';
      end
      else
      begin
        btnreplc.Enabled := true;
        btnreplc.Caption := 'View Line Check &Reports';
      end;
      close;
    end;
  end;

  if not btnRepLC.Visible then
  begin
    btnTempl.Top := 80;
    btnCancel.Top := 152;
    self.Height := 248;
  end;
end;

procedure TfLCchoose.btnTemplClick(Sender: TObject);
begin
  fLCTempl := TFLCTempl.Create(self);

  flctempl.Label1.Caption := 'Choose a Template to edit or delete:';
  flctempl.Caption := 'Manage Line Check Selection Templates';

  flctempl.ADOQuery3.Open;
  flcTempl.ADOQuery2.DataSource := flcTempl.wwDataSource3;
  flctempl.ADOQuery2.Open;

  flctempl.Panel1.Visible := false;
  flctempl.pnlManage.Visible := True;
  flcTempl.ClientWidth := flcTempl.pnlManage.Width + 2;

  flcTempl.pnlManage.Align := alClient;

  if flctempl.ShowModal = mrNoToAll then // if auto exit because deleted ALL templates
  begin
    btnTempl.Enabled := false;
    btnTempl.Caption := 'No LC Templates Set';
  end;

  flctempl.Free;

end;

end.
