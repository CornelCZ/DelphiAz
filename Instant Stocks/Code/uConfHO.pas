unit uConfHO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfConfHO = class(TForm)
    BitBtn6: TBitBtn;
    BitBtn5: TBitBtn;
    cbLCzeroLG: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
  private
    { Private declarations }
    procedure DoneEdits;
  public
    { Public declarations }
  end;

var
  fConfHO: TfConfHO;

implementation

{$R *.dfm}

{ TfConfHO }

procedure TfConfHO.DoneEdits;
begin
  bitbtn5.Enabled := True;
  bitbtn6.Caption := 'E&xit && Discard'#10'Changes';
end;

procedure TfConfHO.FormShow(Sender: TObject);
begin


  // fill checkboxes, etc...

  with dmADO.adoqRun do
  begin
    // Get stkHOConf GLOBAL variables
    SQL.Clear;
    SQL.Add('select * from stkHOConf');
    SQL.Add('where SiteCode = 0');
    Open;

    // should I Show Line Checks on Reports even if Variance = 0?
    // Default is NO (cbit = 0)
    if locate('varname', 'LCzeroLG', []) then
    begin
      cbLCzeroLG.Checked := FieldByName('cbit').asboolean;
    end
    else
    begin
      insert;
      FieldByName('sitecode').asinteger := 0;
      FieldByName('cname').asstring := 'LCzeroLG';
      FieldByName('cbit').asboolean := False;
      post;
      cbLCzeroLG.Checked := False;
    end;


    close;
  end;

end;

procedure TfConfHO.BitBtn5Click(Sender: TObject);
begin
  // save all configs

  // save GLOBAL configs to stkConfHO
  with dmADO.adoqRun do
  begin
    // Get stkHOConf GLOBAL variables
    SQL.Clear;
    SQL.Add('select * from stkHOConf');
    SQL.Add('where SiteCode = 0');
    Open;

    // should I Show Line Checks on Reports even if Variance = 0?
    if locate('varname', 'LCzeroLG', []) then
    begin
      edit;
      FieldByName('cbit').asboolean := cbLCzeroLG.Checked;
      post;
    end
    else
    begin
      insert;
      FieldByName('sitecode').asinteger := 0;
      FieldByName('cname').asstring := 'LCzeroLG';
      FieldByName('cbit').asboolean := cbLCzeroLG.Checked;
      post;
    end;


    close;
  end;
end;

end.
