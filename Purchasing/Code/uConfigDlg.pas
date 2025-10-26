unit uConfigDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, Db, Wwdatsrc, wwdblook,
  DBTables, dialogs, ADODB, ComCtrls;

type
  Tfconfigdlg = class(TForm)
    Button1: TButton;
    wwtSysVar: TADOTable;
    wwqBand: TADOQuery;
    cbxNoUserPrompt: TCheckBox;
    Label2: TLabel;
    Label1: TLabel;
    wwDBLookupCombo1: TwwDBLookupCombo;
    cbxHideSortOrder: TCheckBox;
    Label3: TLabel;
    qGenerVar: TADOQuery;
    cbxInsertAfter: TCheckBox;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    thetax : real;
  public
    { Public declarations }
  end;

var
  fconfigdlg: Tfconfigdlg;

implementation

{$R *.DFM}

uses
  uLog, uADO, uGlobals;

procedure Tfconfigdlg.FormShow(Sender: TObject);
begin
  log.event('fconfigdlg; FormShow');
  try
    wwtsysvar.open;
    thetax := wwtsysvar.FieldByName('tax').asfloat;
    if wwtsysvar.FieldByName('promptuc').asstring = 'Y' then
      cbxNoUserPrompt.Checked := false
    else
      cbxNoUserPrompt.Checked := true;

    cbxHideSortOrder.Checked := wwtsysvar.FieldByName('HideSortOrder').AsBoolean;
    wwtsysvar.close;
  except
    on E: Exception do
    begin
      Log.Event('fconfigdlg; ERROR - FormShow: wwtsysvar table ' + wwtsysvar.tablename + E.Message);
      raise;
    end;
  end;

  try
    wwqband.open;
    wwqband.locate('band',thetax,[]);
    wwdblookupcombo1.text := floattostr(thetax);

    Label2.Caption := 'Save new Unit Costs entered in ' + GetLocalisedName(lsInvoice) +' without prompting the user';
    if UKUSmode = 'UK' then
    begin
      wwdblookupcombo1.Visible := False;
      Label1.Visible := False;
    end;
  except
    on E: Exception do
    begin
      Log.Event('fconfigdlg ERROR - FormShow: ' + E.Message + '; ' + wwqband.SQL.Text);
      raise;
    end;
  end;

  try
    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from Genervar');
      SQL.Add('where VarName = ''PUInsAfter''');
      Open;

      if RecordCount = 0 then // create it first
      begin
        Close;
        SQL.Clear;
        SQL.Add('insert GenerVar ([VarName], [VarString])');
        SQL.Add('Values(''PUInsAfter'', ''Y'')');
        ExecSQL;
        cbxInsertAfter.Checked := True;
      end
      else
      begin
        cbxInsertAfter.Checked := (FieldByName('VarString').AsString = 'Y');
        Close;
      end;
    end;
  except
    on E: Exception do
    begin
      Log.Event('fconfigdlg ERROR - FormShow: ' + E.Message + '; ' + dmADO.adoqRun.SQL.Text);
      raise;
    end;
  end
end;

procedure Tfconfigdlg.Button1Click(Sender: TObject);
begin
  log.event('fconfigdlg; Button1Click');
  try
    with wwtsysvar do
    begin
      open;
      edit;
      if cbxNoUserPrompt.Checked then
        FieldByName('promptuc').asstring := 'N'
      else
        FieldByName('promptuc').asstring := 'Y';

      FieldByName('HideSortOrder').AsBoolean := cbxHideSortOrder.Checked;
      FieldByName('tax').asfloat := strtofloat(wwdblookupcombo1.text);
      post;
      close;
    end;
  except
    on E: Exception do
    begin
      Log.Event('fconfigdlg; ERROR - Button1Click: wwtsysvar table ' + wwtsysvar.tablename + E.Message);
      raise;
    end;
  end;

  try
    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Add('update GenerVar');
      if cbxInsertAfter.Checked then
        SQL.Add('set [VarString] = ''Y''')
      else
        SQL.Add('set [VarString] = ''N''');
      SQL.Add('where [VarName] = ''PUInsAfter''');
      ExecSQL;
    end
  except
    on E: Exception do
    begin
      Log.Event('fconfigdlg ERROR - Button1Click: ' + E.Message + '; ' + dmADO.adoqRun.SQL.Text);
      raise;
    end;
  end
end;

procedure Tfconfigdlg.FormCreate(Sender: TObject);
begin
  log.event('fconfigdlg; FormCreate');
  if purchHelpExists then
  begin
    if UKUSmode = 'UK' then
      setHelpContextID(self, HLP_CONFIGURE_UK)
    else
      setHelpContextID(self, HLP_CONFIGURE_US);
  end;
end;

procedure Tfconfigdlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  log.event('fconfigdlg; FormClose');
end;

end.
