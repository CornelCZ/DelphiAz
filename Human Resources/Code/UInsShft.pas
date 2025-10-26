unit UInsShft;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, wwdblook, DBTables, Wwtable, DB, Wwquery, Mask,
  Wwdbedit, Wwdotdot, Wwdbcomb, Messages, Dialogs, Variants, ADODB;

type
  TFInsShft = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Combo1: TwwDBLookupCombo;
    Combo2: TwwDBCombobox;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Label5: TLabel;
    ADOQuery1: TADOQuery;
    ListQry: TADOQuery;
    procedure Combo1CloseUp(Sender: TObject; LookupTable: TDataset;
      FillTable: TDataSet; modified: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Combo1Exit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure OKBtnClick(Sender: TObject);
    function checkTimes: boolean;

  private
    { Private declarations }
    daystart: tdatetime;
  public
    { Public declarations }
    shiftvar : integer;
    s1time : string;
    kschin : tdatetime;
    SiteCode: Integer;
  end;

var
  FInsShft: TFInsShft;

implementation

uses uempmnu, UVerify, uADO;

{$R *.DFM}


function TfInsShft.checkTimes: boolean;
var
  newcin, newcout, cin, cout: tdatetime;
begin
try  // job 17305 catch the exception if the maskedit fields are blank or have bad data in them
  if strtotime(maskedit1.text) < daystart then
  begin
    newcin := (vrfydlg.today + 1) + strtotime(maskedit1.text);
    if strtotime(maskedit1.text) > strtotime(maskedit2.text) then
    begin
      newcout := (vrfydlg.today + 2) + strtotime(maskedit2.text);
    end
    else
    begin
      newcout := (vrfydlg.today + 1) + strtotime(maskedit2.text);
    end;
  end
  else
  begin
    newcin := vrfydlg.today + strtotime(maskedit1.text);
    if strtotime(maskedit1.text) > strtotime(maskedit2.text) then
    begin
      newcout := (vrfydlg.today + 1) + strtotime(maskedit2.text);
    end
    else
    begin
      newcout := vrfydlg.today + strtotime(maskedit2.text);
    end;
  end;
  if newcout > fempmnu.empLADT then
  begin
    showmessage('Invalid shift times!' + #13 +
      'This shift finishes after the time of the last transmission' +
      ' from the registers.' + #13 +
      ' Thus it may interfere with a shift currently being worked');
    checkTimes := false;
    exit;
  end;

  if vrfydlg.vrfyschd.locate('UserId;shift',
        vararrayof([strtoint64(combo1.value), 2]), []) then
  begin
    showmessage('Cannot add another shift for ' + finsshft.combo1.text +
      ' as two shifts are already present.');
    checkTimes := false;
    exit;
  end;

  shiftvar := 1;

  if vrfydlg.vrfyschd.locate('UserId;shift',
    vararrayof([strtoint64(combo1.value), 1]), []) then
  begin
    with vrfydlg.vrfyschd do
    begin
      s1time := fieldbyname('schin').asstring;
      if strtotime(fieldbyname('accin').asstring) < daystart then
      begin
        cin := (vrfydlg.today + 1) + strtotime(fieldbyname('accin').asstring);
        if strtotime(fieldbyname('accin').asstring) >
          strtotime(fieldbyname('accout').asstring) then
        begin
          cout := (vrfydlg.today + 2) +
            strtotime(fieldbyname('accout').asstring);
        end
        else
        begin
          cout := (vrfydlg.today + 1) +
            strtotime(fieldbyname('accout').asstring);
        end;
      end
      else
      begin
        cin := vrfydlg.today + strtotime(fieldbyname('accin').asstring);
        if strtotime(fieldbyname('accin').asstring) >
          strtotime(fieldbyname('accout').asstring) then
        begin
          cout := (vrfydlg.today + 1) +
            strtotime(fieldbyname('accout').asstring);
        end
        else
        begin
          cout := vrfydlg.today +
            strtotime(fieldbyname('accout').asstring);
        end;
      end; // if cin < daystart..
    end; // with..

    if (newcin <= cout) and (newcout >= cin) then
    begin
      showmessage('Invalid shift times!' + #13 +
        'This shift overlaps with a shift already in the database.');
      checkTimes := false;
      exit;
    end;

    if newcin > cin then
    begin
      shiftvar := 2;
    end
    else
    begin
      shiftvar := 3;
    end;
  end; // if locate another record...
  kschin := newcin;
  checkTimes := true;
// job 17305
except
  checkTimes := false;
  exit;
end;
end;

procedure TFInsShft.Combo1CloseUp(Sender: TObject; LookupTable: TDataset;
  FillTable: TDataSet; modified: Boolean);
begin
  if combo1.text <> '' then
  begin
    with listqry do
    begin
      close;
      parameters.parambyname('UserId').value := strtofloat(combo1.value);
      parameters.parambyname('SiteId').value := SiteCode;
      open;
      first;
      combo2.items.clear;
      while not eof do
      begin
        combo2.items.add(fieldbyname('Name').asstring + #9 +
          fieldbyname('Id').asstring);
        next;
      end;
      combo2.applylist;
//      if listqry.recordcount = 1 then
//        combo2.text := fieldbyname('jobname').asstring;
      combo2.ItemIndex := 0;
      combo2.Refresh;
    end;
  end;
end;

procedure TFInsShft.FormShow(Sender: TObject);
var
  s2: string;
begin
  ADOQuery1.Parameters.ParamByName('SiteId').Value := SiteCode;
  adoquery1.open;
  daystart := (strtotime(fempmnu.roll) - strtotime(fempmnu.gracetm));
  s2 := copy(timetostr(daystart - strtotime('00:01')), 1, 5);
  label5.caption := 'Working day runs from ' + copy(timetostr(daystart), 1, 5) +
    ' to ' + s2;
end;

procedure TFInsShft.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //emptab.close;
end;

procedure TFInsShft.Combo1Exit(Sender: TObject);
begin
  if combo1.text = '' then
  begin
    combo2.items.clear;
    combo2.text := '';
  end;
end;

procedure TFInsShft.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    Perform(wm_NextDlgCtl, 0, 0);
  end;
end;

procedure TFInsShft.OKBtnClick(Sender: TObject);
var
  errflag: boolean;

begin
  errflag := false;
  if combo1.text <> '' then
  begin
    if combo2.text = '' then
    begin
      showmessage('A Worked role must be selected');
      combo2.setfocus;
      errflag := true;
    end;
    if (maskedit1.text = '  :  ') or
      (strtoint(copy(maskedit1.text, 1, 2)) > 23) or
      (strtoint(copy(maskedit1.text, 4, 2)) > 59) then
    begin
      showmessage('Clock In time is not valid');
      maskedit1.text := '  :  ';
      maskedit1.setfocus;
      errflag := true;
    end;
    if (maskedit2.text = '  :  ') or
      (strtoint(copy(maskedit2.text, 1, 2)) > 23) or
      (strtoint(copy(maskedit2.text, 4, 2)) > 59) then
    begin
      showmessage('Clock Out time is not valid');
      maskedit2.text := '  :  ';
      maskedit2.setfocus;
      errflag := true;
    end;
    if not checkTimes then
    begin
      maskedit1.text := '  :  ';
      maskedit2.text := '  :  ';
      maskedit1.setfocus;
      errflag := true;
    end;
  end
  else
  begin
    showmessage('An employee must be selected');
    combo1.setfocus;
    errflag := true;
  end;
  if errflag then
    exit
  else
    modalresult := mrok;
end;

end.
