unit UWarn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons, ExtCtrls, //DB, DBTables, Wwtable, Wwquery,
  Spin, Wwdatsrc, Wwdbedit, ADODB, DB;

type
  TFWarn = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Emphrsflag: TCheckBox;
    Label9: TLabel;
    Label16: TLabel;
    Label15: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    label2: TLabel;
    Empcstflag: TCheckBox;
    Label3: TLabel;
    label4: TLabel;
    label5: TLabel;
    label6: TLabel;
    label7: TLabel;
    label8: TLabel;
    weekcstflag: TCheckBox;
    weekhrsflag: TCheckBox;
    daycstflag: TCheckBox;
    dayhrsflag: TCheckBox;
    Jobcstflag: TCheckBox;
    Jobhrsflag: TCheckBox;
    btnSaveChanges: TBitBtn;
    BitBtn3: TBitBtn;
    Panel2: TPanel;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    SpinEdit6: TSpinEdit;
    SpinEdit7: TSpinEdit;
    SpinEdit8: TSpinEdit;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Emphrsval: TEdit;
    Jobhrsval: TEdit;
    Dayhrsval: TEdit;
    Weekhrsval: TEdit;
    wwE: TwwDBEdit;
    wwJ: TwwDBEdit;
    wwD: TwwDBEdit;
    wwW: TwwDBEdit;
    wwDataSource1: TwwDataSource;
    BitBtn1: TBitBtn;
    Warnings: TADOTable;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure btnSaveChangesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure flags;
    procedure EmphrsflagMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpinEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure wwEEnter(Sender: TObject);
    procedure SpinEdit1Enter(Sender: TObject);
    procedure SpinEdit3Enter(Sender: TObject);
    procedure SpinEdit7Enter(Sender: TObject);
    procedure SpinEdit8Enter(Sender: TObject);
    procedure wwJEnter(Sender: TObject);
    procedure wwDEnter(Sender: TObject);
    procedure wwWEnter(Sender: TObject);
    procedure SpinEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure wwEKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpinEdit3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpinEdit4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure wwJKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpinEdit7KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpinEdit5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure wwDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpinEdit8KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpinEdit6KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure wwWKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FWarn: TFWarn;

implementation

uses uempmnu, uglobals, dmodule1, uADO;

{$R *.DFM}

procedure TFWarn.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  warnings.close;
  //Fempmnu.show;
end;

procedure TFWarn.BitBtn4Click(Sender: TObject);
begin
  emphrsflag.checked := true;
  empcstflag.checked := true;
  jobhrsflag.checked := true;
  jobcstflag.checked := true;
  dayhrsflag.checked := true;
  daycstflag.checked := true;
  weekhrsflag.checked := true;
  weekcstflag.checked := true;
  flags;
end;

procedure TFWarn.BitBtn5Click(Sender: TObject);
begin
  emphrsflag.checked := false;
  empcstflag.checked := false;
  jobhrsflag.checked := false;
  jobcstflag.checked := false;
  dayhrsflag.checked := false;
  daycstflag.checked := false;
  weekhrsflag.checked := false;
  weekcstflag.checked := false;
  flags;
end;

procedure TFWarn.btnSaveChangesClick(Sender: TObject);
var
  i, c: integer;
begin

  // check spin edits only hold digits...
  Val(spinedit1.text, i, c);
  if c <> 0 then
  begin
    ShowMessage('INPUT ERROR: The "Warn by Employee Hours" Hrs box contains invalid characters!' + #13 + #13 +
      'Settings cannot be saved like this.');
    SpinEdit1.SetFocus;
    exit;
  end;

  Val(spinedit2.text, i, c);
  if c <> 0 then
  begin
    ShowMessage('INPUT ERROR: The "Warn by Employee Hours" Mins box contains invalid characters!' + #13 + #13 +
      'Settings cannot be saved like this.');
    SpinEdit2.SetFocus;
    exit;
  end;

  Val(spinedit3.text, i, c);
  if c <> 0 then
  begin
    ShowMessage('INPUT ERROR: The "Warn by Job Week Hours" Hrs box contains invalid characters!' + #13 + #13 +
      'Settings cannot be saved like this.');
    SpinEdit3.SetFocus;
    exit;
  end;

  Val(spinedit4.text, i, c);
  if c <> 0 then
  begin
    ShowMessage('INPUT ERROR: The "Warn by Job week Hours" Mins box contains invalid characters!' + #13 + #13 +
      'Settings cannot be saved like this.');
    SpinEdit1.SetFocus;
    exit;
  end;

  Val(spinedit5.text, i, c);
  if c <> 0 then
  begin
    ShowMessage('INPUT ERROR: The "Warn by Day Hours" Hrs box contains invalid characters!' + #13 + #13 +
      'Settings cannot be saved like this.');
    SpinEdit5.SetFocus;
    exit;
  end;

  Val(spinedit6.text, i, c);
  if c <> 0 then
  begin
    ShowMessage('INPUT ERROR: The "Warn by Day Hours" Mins box contains invalid characters!' + #13 + #13 +
      'Settings cannot be saved like this.');
    SpinEdit6.SetFocus;
    exit;
  end;

  Val(spinedit7.text, i, c);
  if c <> 0 then
  begin
    ShowMessage('INPUT ERROR: The "Warn by Week Hours" Hrs box contains invalid characters!' + #13 + #13 +
      'Settings cannot be saved like this.');
    SpinEdit7.SetFocus;
    exit;
  end;

  Val(spinedit8.text, i, c);
  if c <> 0 then
  begin
    ShowMessage('INPUT ERROR: The "Warn by Week Hours" Mins box contains invalid characters!' + #13 + #13 +
      'Settings cannot be saved like this.');
    SpinEdit8.SetFocus;
    exit;
  end;    


  if warnings.state = dsedit then
    warnings.post;

  with dmod1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('update warnings set "empcstval" = "eval", "daycstval" = "dval",');
    sql.Add('"jobcstval" = "jval", "weekcstval" = "wval"');
    execSQL;
  end;

  emphrsval.text := spinedit1.text + '.' + spinedit2.text;
  jobhrsval.text := spinedit3.text + '.' + spinedit4.text;
  dayhrsval.text := spinedit7.text + '.' + spinedit5.text;
  weekhrsval.text := spinedit8.text + '.' + spinedit6.text;
  with warnings do
  begin
    requery;
    edit;
    for i := 0 to (panel1.controlcount - 1) do
    begin
      if panel1.controls[i] is tcheckbox then
      begin
        if tcheckbox(panel1.controls[i]).checked = true then
          fieldbyname(panel1.controls[i].name).asstring := 'Y'
        else
          fieldbyname(panel1.controls[i].name).asstring := 'N'
      end;
      if panel1.controls[i] is tedit then
        fieldbyname(panel1.controls[i].name).asstring :=
          tedit(panel1.controls[i]).text;
    end;
    {PW: adding last mod date}
    fieldbyname('LMDT').asdatetime := now;
    post;
    close;
  end;
  close;
end;

//EXITS CURRENT PAGE AND RESTORES ORIGINAL SETTINGS REGARDLESS OF CHANGES MADE

procedure TFWarn.FormShow(Sender: TObject);
var
  i: integer;
begin
  with dmod1.adoqRun do
  begin
    close;
    sql.Clear;
    sql.Add('update warnings set "eval" = "empcstval", "dval" = "daycstval",');
    sql.Add('"jval" = "jobcstval", "wval" = "weekcstval"');
    execSQL;
  end;

  with warnings do
  begin
    open;
    for i := 0 to (panel1.controlcount - 1) do
    begin
      if panel1.controls[i] is tcheckbox then
      begin
        if fieldbyname(panel1.controls[i].name).asstring = 'Y' then
          tcheckbox(panel1.controls[i]).checked := true
        else
          tcheckbox(panel1.controls[i]).checked := false
      end;
      if panel1.controls[i] is tedit then
        tedit(panel1.controls[i]).text :=
          fieldbyname(panel1.controls[i].name).asstring;
    end;

  end;
  spinedit1.text := copy(emphrsval.text, 1, pos('.', emphrsval.text) - 1);
  spinedit2.text := copy(emphrsval.text, pos('.', emphrsval.text) + 1, 2);
  spinedit3.text := copy(jobhrsval.text, 1, pos('.', jobhrsval.text) - 1);
  spinedit4.text := copy(jobhrsval.text, pos('.', jobhrsval.text) + 1, 2);
  spinedit7.text := copy(dayhrsval.text, 1, pos('.', dayhrsval.text) - 1);
  spinedit5.text := copy(dayhrsval.text, pos('.', dayhrsval.text) + 1, 2);
  spinedit8.text := copy(weekhrsval.text, 1, pos('.', weekhrsval.text) - 1);
  spinedit6.text := copy(weekhrsval.text, pos('.', weekhrsval.text) + 1, 2);
  flags;

  if not isMaster then
  begin
    if WarControl <> 'S' then
    begin
      for i := 0 to (panel1.controlcount - 1) do
      begin
        if not (panel1.controls[i] is TLabel) then
          panel1.controls[i].Enabled := false;
      end;

      btnSaveChanges.Visible := false;
      bitbtn3.Visible := false;
      bitbtn1.Visible := True;
      bitbtn4.Enabled := false;
      bitbtn5.Enabled := false;
      self.Caption := self.Caption + ' (Read Only)';

    end;
  end;
end;

procedure TFwarn.flags;
begin
  if emphrsflag.checked then
  begin
    spinedit1.readonly := false;
    spinedit2.readonly := false;
  end
  else
  begin
    spinedit1.readonly := true;
    spinedit2.readonly := true;
  end;
  if empcstflag.checked then
    wwe.readonly := false
  else
    wwe.readonly := true;
  if jobhrsflag.checked then
  begin
    spinedit3.readonly := false;
    spinedit4.readonly := false;
  end
  else
  begin
    spinedit3.readonly := true;
    spinedit4.readonly := true;
  end;
  if jobcstflag.checked then
    wwj.readonly := false
  else
    wwj.readonly := true;
  if dayhrsflag.checked then
  begin
    spinedit7.readonly := false;
    spinedit5.readonly := false;
  end
  else
  begin
    spinedit7.readonly := true;
    spinedit5.readonly := true;
  end;
  if daycstflag.checked then
    wwd.readonly := false
  else
    wwd.readonly := true;
  if weekhrsflag.checked then
  begin
    spinedit8.readonly := false;
    spinedit6.readonly := false;
  end
  else
  begin
    spinedit8.readonly := true;
    spinedit6.readonly := true;
  end;
  if weekcstflag.checked then
    www.readonly := false
  else
    www.readonly := true;
end;

procedure TFWarn.EmphrsflagMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  flags;
end;

procedure TFWarn.SpinEdit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = vk_return) then
    wwe.setfocus;
end;

procedure TFWarn.wwEEnter(Sender: TObject);
begin
  if twwdbedit(sender).readonly then
    spinedit3.setfocus;
end;

procedure TFWarn.SpinEdit1Enter(Sender: TObject);
begin
  if tspinedit(sender).readonly then
    wwe.setfocus;
end;

procedure TFWarn.SpinEdit3Enter(Sender: TObject);
begin
  if tspinedit(sender).readonly then
    wwj.setfocus;
end;

procedure TFWarn.SpinEdit7Enter(Sender: TObject);
begin
  if tspinedit(sender).readonly then
    wwd.setfocus;
end;

procedure TFWarn.SpinEdit8Enter(Sender: TObject);
begin
  if tspinedit(sender).readonly then
    www.setfocus;
end;

procedure TFWarn.wwJEnter(Sender: TObject);
begin
  if twwdbedit(sender).readonly then
    spinedit7.setfocus;
end;

procedure TFWarn.wwDEnter(Sender: TObject);
begin
  if twwdbedit(sender).readonly then
    spinedit8.setfocus;
end;

procedure TFWarn.wwWEnter(Sender: TObject);
begin
  if twwdbedit(sender).readonly then
    btnSaveChanges.setfocus;
end;

procedure TFWarn.SpinEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = vk_return) then
    spinedit2.setfocus;
end;

procedure TFWarn.wwEKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = vk_return) then
    spinedit3.setfocus;
end;

procedure TFWarn.SpinEdit3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = vk_return) then
    spinedit4.setfocus;
end;

procedure TFWarn.SpinEdit4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = vk_return) then
    wwj.setfocus;
end;

procedure TFWarn.wwJKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = vk_return) then
    spinedit7.setfocus;
end;

procedure TFWarn.SpinEdit7KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = vk_return) then
    spinedit5.setfocus;
end;

procedure TFWarn.SpinEdit5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = vk_return) then
    wwd.setfocus;
end;

procedure TFWarn.wwDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = vk_return) then
    spinedit8.setfocus;
end;

procedure TFWarn.SpinEdit8KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = vk_return) then
    spinedit6.setfocus;
end;

procedure TFWarn.SpinEdit6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = vk_return) then
    www.setfocus;
end;

procedure TFWarn.wwWKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = vk_return) then
    btnSaveChanges.setfocus;
end;

procedure TFWarn.FormCreate(Sender: TObject);
begin
  if HelpExists then
    setHelpContextID(self, EMP_WARNING_CONTROLS);
end;

end.

//Tuein   char(5) NULL,
//Tueout  char(5) NULL,
//F2      char(1) NULL,
//Wedin   char(5) NULL,
//Wedout  char(5) NULL,
//F3      char(1) NULL,
//Thuin   char(5) NULL,
//Thuout  char(5) NULL,
//F4      char(1) NULL,
//Friin   char(5) NULL,
//Friout  char(5) NULL,
//F5      char(1) NULL,
//Satin   char(5) NULL,
//Satout  char(5) NULL,
//F6      char(1) NULL,
//Sunin   char(5) NULL,
//Sunout  char(5) NULL,
//F7      char(1) NULL,
//monoc   char(2) NULL,
//tueoc   char(2) NULL,
//wedoc   char(2) NULL,
//thuoc   char(2) NULL,
//frioc   char(2) NULL,
//satoc   char(2) NULL,
//sunoc   char(2) NULL,
//Old1    smalldatetime NULL,
//Old2    smalldatetime NULL,
//Old3    smalldatetime NULL,
//Old4    smalldatetime NULL,
//Old5    smalldatetime NULL,
//Old6    smalldatetime NULL,
//Old7    smalldatetime NULL,
//Deleted char(1) NULL,
//Pt1     Smallint NULL,
//Pt2     Smallint NULL,
//Pt3     Smallint NULL,
//Pt4     Smallint NULL,
//Pt5     Smallint NULL,
//Pt6     Smallint NULL,
//Pt7     Smallint NULL

