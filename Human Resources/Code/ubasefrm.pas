unit ubasefrm;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, Wwdatsrc, Mask,
  Wwdbedit, wwdblook, DBCtrls, dialogs,
  ShellAPI, Wwdotdot, Wwdbcomb, ADODB, DB, CheckLst, Wwdbspin;


type
  Tfbasefrm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    BitBtn5: TBitBtn;
    SysVarTab: TTabSheet;
    ScrollBox1: TScrollBox;
    Label11: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    graceedit: TMaskEdit;
    Shape3: TShape;
    Label14: TLabel;
    lee1edit: TMaskEdit;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    lee2edit: TMaskEdit;
    Shape4: TShape;
    Panel4: TPanel;
    BitBtn17: TBitBtn;
    BitBtn18: TBitBtn;
    Label20: TLabel;
    BitBtn19: TBitBtn;
    Label22: TLabel;
    Label24: TLabel;
    BitBtn21: TBitBtn;
    Shape7: TShape;
    Shape8: TShape;
    Shape10: TShape;
    Label25: TLabel;
    CheckBox3: TCheckBox;
    Label26: TLabel;
    CheckBox4: TCheckBox;
    Shape6: TShape;
    Label27: TLabel;
    Label28: TLabel;
    edEIN: TEdit;
    AttCodeTab: TTabSheet;
    wwDBGrid1: TwwDBGrid;
    gridAttCd: TwwDBGrid;
    Label30: TLabel;
    Label31: TLabel;
    Bevel2: TBevel;
    btnInsAttCode: TBitBtn;
    rgAttOrd: TRadioGroup;
    pnlInsAtt: TPanel;
    btnOKAttCode: TBitBtn;
    BitBtn22: TBitBtn;
    edAttDisp: TEdit;
    edAttCode: TEdit;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    CheckBox5: TCheckBox;
    Label9: TLabel;
    Label29: TLabel;
    Shape13: TShape;
    Label36: TLabel;
    autoclose: TCheckBox;
    Rolledit: TEdit;
    Shape14: TShape;
    Shape15: TShape;
    Label40: TLabel;
    edtLookAhead: TMaskEdit;
    Shape17: TShape;
    cbAutoPrintPayReport: TCheckBox;
    Shape18: TShape;
    lblAutoPrintPayReport: TLabel;
    cbDecimalHours: TCheckBox;
    lblWageCostUplift: TLabel;
    spinEdWageCostUplift: TwwDBSpinEdit;
    procedure PageControl1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBMemo2Exit(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure BitBtn18Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure BitBtn21Click(Sender: TObject);
    procedure WMSysCommand(var Msg: TWMSysCommand);
    message WM_SYSCOMMAND;
    procedure rgAttOrdClick(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure btnInsAttCodeClick(Sender: TObject);
    procedure BitBtn22Click(Sender: TObject);
    procedure btnOKAttCodeClick(Sender: TObject);
    procedure edAttCodeKeyPress(Sender: TObject; var Key: Char);
    procedure edAttDispKeyPress(Sender: TObject; var Key: Char);
    procedure CustomTabSheetEnter(Sender: TObject);
    procedure CustomTabSheetExit(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure ValidateTimeInEditControl(Sender: TObject);
  private
    { Private declarations }
    procedure SaveAutoPrintPayReportFlags;
    procedure AttCodeTabActivated;
    procedure SysVarTabActivated;
  public
    { Public declarations }
    //grfield, oldattdisp : string;
    //termtype, NewUDF, DTCode: Integer;
  end;

const
  CR = #13;
  LF = #10;

var
  fbasefrm: Tfbasefrm;

implementation

uses dmodule1, uempmnu, UTotals,
  uOpClose, uGlobals, uZip32,
  useful, uwait, ulog, uADO, Variants;

{$R *.DFM}

procedure Tfbasefrm.PageControl1Change(Sender: TObject);
begin
  if pagecontrol1.activePage = SysVarTab then
  begin
    SysVarTabActivated;
  end
  else if pagecontrol1.activePage = AttCodeTab then
  begin
    AttCodeTabActivated;
  end
end;

procedure Tfbasefrm.FormShow(Sender: TObject);
var
  username: string;
begin
  //15118
  dmod1.wwtsitevar.open;
  autoclose.checked := dmod1.wwtsitevar.fieldbyname('AutoClose').asString = 'Y';
  //job  16087 ESL addition
  dmod1.wwtsitevar.Locate('Sitecode',uGlobals.SiteCode,[]);
  dmod1.wwtsitevar.close;
 //end
//  {PW Job 15671}
  with dmod1.wwtsysvar do
  begin
    open;
    username := CurrentUser.UserName;
    if (UpperCase(UserName) = 'ZZCRITICAL') or
      (UpperCase(UserName) = 'ZONALDEV') or
      (UpperCase(UserName) = 'ZONALQA') or
      (UpperCase(UserName) = 'ZONALHC') then
    begin
      sysvartab.tabvisible := true;

      if (fieldbyname('fillsch').asstring = 'Y') or
        (fieldbyname('fillsch').asstring = 'A') then
      begin
        checkbox3.checked := true;
        label6.Enabled := True;
        checkbox5.Enabled := True;

        if fieldbyname('fillsch').asstring = 'A' then
          checkbox5.Checked := True
        else
          checkbox5.Checked := False;
      end
      else
      begin
        checkbox3.checked := false;
        checkbox5.Checked := False;
        label6.Enabled := False;
        checkbox5.Enabled := False;
      end;

      if fieldbyname('ratechg').asstring = 'Y' then
      begin
        checkbox4.checked := true;
      end
      else
      begin
        checkbox4.checked := false;
      end;

      cbAutoPrintPayReport.Checked := FieldByName('AutoPrintPayReport').AsBoolean;
      cbDecimalHours.Checked := FieldByName('PayReportDecimalHours').AsBoolean;
    end
    else
      sysvartab.tabvisible := false;
  end;

  if SysVarTab.Visible then
  begin
    pagecontrol1.activePage := SysVarTab;
    SysVarTabActivated;
  end
  else begin
    pagecontrol1.activePage := AttCodeTab;
    AttCodeTabActivated;
  end;

  screen.cursor := crDefault;
end;

procedure Tfbasefrm.BitBtn5Click(Sender: TObject);
begin
  Close;
end;

procedure Tfbasefrm.FormCreate(Sender: TObject);
begin
  if not isMaster then
  begin
    if AttControl <> 'S' then
    begin
      btnInsAttCode.visible := false;
      gridAttCd.ReadOnly := true;
      AttCodeTab.Caption := AttCodeTab.Caption + ' (Read Only)';
    end;
  end;

  if HelpExists then
    setHelpContextID(self, EMP_BASE_DATA);
end;

procedure Tfbasefrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if dmod1.wwtAttCd.State in [dsEdit, dsInsert] then
    dmod1.wwtAttCd.Post;
  modalResult := mrOK;
end;

procedure Tfbasefrm.DBMemo2Exit(Sender: TObject);
begin
  if (Sender as twwdbedit).ReadOnly then
    exit;
  if (Sender as twwdbedit).text = '' then
    if messagedlg('There is no description for this Termination Code!' + #13 +
      'Do you want to type a description now?', mtConfirmation, [mbYes, mbNo], 0) =
      mrYes then (Sender as twwdbedit).setfocus;
end;

procedure Tfbasefrm.WMSysCommand;
{Used to minimise the whole app if the current form is minimised}
begin
  if (Msg.CmdType = SC_MINIMIZE) then
  begin
    Application.Minimize;
  end
  else
  begin
    inherited;
  end;
end;

procedure Tfbasefrm.BitBtn17Click(Sender: TObject);
begin
  dmod1.wwtsysvar.close;
  dmod1.wwtmastervar.close;
  dmod1.wwtsitevar.close;

  dmod1.wwtsysvar.open;
  dmod1.wwtmastervar.open;
  dmod1.wwtsitevar.open;
  //job 16067
  dmod1.wwtsitevar.Edit;
  dmod1.wwtsitevar.post;
  //end
  // Job 16495 - Always update AutoClose value.
  dmod1.wwtSiteVar.edit;

  if AutoClose.Checked then
    dmod1.wwtSiteVar.FieldByName('AutoClose').AsString := 'Y'
  else
    dmod1.wwtSiteVar.FieldByName('AutoClose').AsString := 'N';

  if IsMaster then
  begin
    dmod1.wwtmastervar.edit;
    dmod1.wwtsysvar.edit;

    SaveAutoPrintPayReportFlags;

    dmod1.wwtmastervar.fieldbyname('ein').asstring := edEIN.text;
    dmod1.wwtmastervar.fieldbyname('ScheduleLookAhead').asstring := edtLookAhead.text;
    if graceedit.Text = '  :  ' then
      graceedit.Text := '00:00';
    if lee1edit.Text = '  :  ' then
      lee1edit.text := '00:00';
    if lee2edit.Text = '  :  ' then
      lee2edit.Text := '00:00';
    dmod1.wwtsysvar.fieldbyname('grace').asstring := graceedit.text;
    dmod1.wwtsysvar.fieldbyname('leeway1').asstring := lee1edit.text;
    dmod1.wwtsysvar.fieldbyname('leeway2').asstring := lee2edit.text;

    if checkbox3.checked then
    begin
      fempmnu.fillsch := true;
      if checkbox5.Checked then
      begin
        dmod1.wwtsysvar.fieldbyname('fillsch').asstring := 'A';
        fempmnu.fillschALL := true;
      end
      else
      begin
        dmod1.wwtsysvar.fieldbyname('fillsch').asstring := 'Y';
        fempmnu.fillschALL := false;
      end;
    end
    else
    begin
      dmod1.wwtsysvar.fieldbyname('fillsch').asstring := 'N';
      fempmnu.fillsch := false;
      fempmnu.fillschALL := false;
    end;

    if checkbox4.checked then
    begin
      fempmnu.ratechg := true;
      dmod1.wwtsysvar.fieldbyname('ratechg').asstring := 'Y';
    end
    else
    begin
      dmod1.wwtsysvar.fieldbyname('ratechg').asstring := 'N';
      fempmnu.ratechg := false;
    end;

    dMod1.wwtSysVar.FieldByName('LMDT').asDateTime := now;
    dMod1.wwtMasterVar.FieldByName('LMDT').asDateTime := now; // 14885 CC

    dmod1.wwtsysvar.post;
    dmod1.wwtmastervar.post;

    {update all sites with SYSVAR records from the master.}

    // 14885 US mode gets this as well
    with dmod1.adoqRun do
    begin
      close;
      sql.Clear;
      sql.Add('UPDATE sysvar');
      sql.Add('SET "Grace" = b."Grace", "Leeway1" = b."Leeway1", "Leeway2" = b."Leeway2",');
      sql.Add('"Schedule" = b."Schedule", "PaidBreak" = b."PaidBreak", "Totals" = b."Totals",');
      sql.Add('"Fillsch" = b."Fillsch", "JPayChg" = b."JPayChg", "RateChg" = b."RateChg",');
      sql.Add('"PayMode" = b."PayMode", "JobControl" = b."JobControl", "WarControl" = b."WarControl",');
      sql.Add('"AttControl" = b."AttControl", "UDFControl" = b."UDFControl",');
      sql.Add('"TermControl" = b."TermControl", AutoPrintPayReport = b.AutoPrintPayReport,');
      SQL.Add('PayReportDecimalHours = b.PayReportDecimalHours, "LMDT" = b."LMDT"');
      sql.Add('from   (select a.sitecode as thesite, c.* ');
      sql.Add('        from "sysvar" a, "sysvar" c where c.sitecode = 0) as b');
      sql.Add('where sysvar.sitecode = b.thesite');

      execSQL;
    end;
  end;

  dmod1.wwtsitevar.post;

  fempmnu.grace := copy(timetostr(strtotime(fempmnu.roll) -
    strtotime(graceedit.text)), 1, 5);
  fempmnu.leeway1 := lee1edit.text;
  fempmnu.leeway2 := lee2edit.text;

  uGlobals.grace := fempmnu.grace;
  uGlobals.leeway1 := fempmnu.leeway1;
  uGlobals.leeway2 := fempmnu.leeway2;

  dmod1.wwtsysvar.close;
  dmod1.wwtmastervar.close;
  dmod1.wwtsitevar.close;

  dmod1.wwtsysvar.open;
  dmod1.wwtmastervar.open;
  dmod1.wwtsitevar.open;

  if (dmod1.ADOtWageCostUplift.State = dsEdit)or (dmod1.ADOtWageCostUplift.State = dsInsert) then
      dmod1.ADOtWageCostUplift.Post;
  dmod1.ADOtWageCostUplift.Close;
  dmod1.ADOtWageCostUplift.Open;
  
end;

procedure Tfbasefrm.BitBtn18Click(Sender: TObject);
begin
  dmod1.wwtsysvar.open;
  graceedit.text := dmod1.wwtsysvar.fieldbyname('grace').asstring;
  lee1edit.text := dmod1.wwtsysvar.fieldbyname('leeway1').asstring;
  lee2edit.text := dmod1.wwtsysvar.fieldbyname('leeway2').asstring;
  //15118
  dmod1.wwtsitevar.open;
  autoclose.checked := dmod1.wwtsitevar.fieldbyname('AutoClose').asString = 'Y';
  dmod1.wwtsitevar.close;
  //end

  dmod1.ADOtWageCostUplift.Open;
  spinEdWageCostUplift.Text :=  dmod1.ADOtWageCostUplift.fieldbyname('wage cost uplift Factor').AsString;
  dmod1.ADOtWageCostUplift.Close;
  dmod1.ADOtWageCostUplift.Open;
end;

procedure Tfbasefrm.BitBtn19Click(Sender: TObject);
begin
  FTotals := TFTotals.create(nil);

  try
    FTotals.showmodal;
  finally
    FTotals.free;
  end;
end;

procedure Tfbasefrm.BitBtn21Click(Sender: TObject);
begin
  Fopclose := TFopclose.create(nil);

  try
    Fopclose.showmodal;
  finally
    Fopclose.free;
  end;
end;

procedure Tfbasefrm.rgAttOrdClick(Sender: TObject);
begin
  if rgAttOrd.ItemIndex = 0 then
  begin
    dmod1.wwtAttCd.IndexFieldNames := 'attcode';
  end
  else
  begin
    dmod1.wwtAttCd.IndexFieldNames := 'Display';
  end;
end;

procedure Tfbasefrm.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  if pagecontrol1.activePage = AttCodeTab then
  begin
    dmod1.wwqROAtt.close;
    if (dmod1.wwtAttCd.State = dsEdit) or (dmod1.wwtAttCd.State = dsInsert) then
    begin
      dmod1.wwtAttCd.Post;
    end;
    dmod1.wwtAttCd.close;
  end 
end;

procedure Tfbasefrm.btnInsAttCodeClick(Sender: TObject);
begin
  edAttCode.Text := '';
  edAttDisp.Text := '';
  pnlInsAtt.Visible := true;
  btnInsAttCode.Enabled := false;
  edAttCode.SetFocus;
end;

procedure Tfbasefrm.BitBtn22Click(Sender: TObject);
begin
  pnlInsAtt.Visible := false;
  btnInsAttCode.Enabled := True;
end;

procedure Tfbasefrm.btnOKAttCodeClick(Sender: TObject);
begin
  if (edAttCode.text = '') or (edAttDisp.text = '') then
  begin
    showmessage('You have to type both a code and a display string!');
    exit;
  end;

  with dmod1.wwtAttCd do
  begin
    // check unique code...
    if dmod1.wwqROAtt.locate('attcode', edAttCode.text, [loCaseInsensitive	]) then
    begin
      showmessage('The Attendance Code "' + Uppercase(edAttCode.Text) +
        '" is already present (default code). Please type in another code (case insensitive).');
      edAttCode.Text := '';
      edAttCode.SetFocus;
      exit;
    end;

    if locate('attcode', edAttCode.text, [loCaseInsensitive	]) then
    begin
      showmessage('The Attendance Code "' + Uppercase(edAttCode.Text) +
        '" is already present. Please type in another code (case insensitive).');
      edAttCode.Text := '';
      edAttCode.SetFocus;
      exit;
    end;

    // check unique display...
    if dmod1.wwqROAtt.locate('display', edAttDisp.text, [loCaseInsensitive	]) then
    begin
      showmessage('The Display String "' + (edAttDisp.Text) +
        '" is already present (default code "' + dmod1.wwqROAtt.FieldByName('attcode').asstring +
        '"). Please type in another Display String (case insensitive).');
      edAttDisp.Text := '';
      edAttDisp.SetFocus;
      exit;
    end;

    if locate('display', edAttDisp.text, [loCaseInsensitive	]) then
    begin
      showmessage('The Display String "' + (edAttDisp.Text) +
        '" is already present (code "' + FieldByName('attcode').asstring +
        '"). Please type in another Display String (case insensitive).');
      edAttDisp.Text := '';
      edAttDisp.SetFocus;
      exit;
    end;

    // all OK do insertion
    if (State = dsEdit) or (State = dsInsert) then
    begin
      Post;
    end;

    insert;
    FieldByName('attcode').asstring := Uppercase(edAttCode.Text);
    FieldByName('display').asstring := edAttDisp.Text;
    FieldByName('default').asstring := 'N';
    FieldByName('lmdt').asdatetime := Now;
    post;

    pnlInsAtt.Visible := false;
    btnInsAttCode.Enabled := True;

    gridAttCd.SetFocus;
  end;
end;

procedure Tfbasefrm.edAttCodeKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    edAttDisp.SetFocus;
  end;
end;

procedure Tfbasefrm.edAttDispKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    btnOKAttCode.SetFocus;
  end;
end;

// Job 14259
procedure Tfbasefrm.CustomTabSheetEnter(Sender: TObject);
begin
  with dMod1 do
  begin
    wwtGenerVar.Filtered := True;
    wwtGenerVar.Active := True;
  end;
end;

procedure Tfbasefrm.CustomTabSheetExit(Sender: TObject);
begin
  with dMod1 do
  begin
    wwtGenerVar.Filtered := False;
    wwtGenerVar.Active := False;
  end;
end;
// End Job 14259

procedure Tfbasefrm.CheckBox3Click(Sender: TObject);
begin
   if checkbox3.checked then
   begin
     label6.Enabled := True;
     checkbox5.Enabled := True;
   end
   else
   begin
     checkbox5.Checked := False;
     label6.Enabled := False;
     checkbox5.Enabled := False;
   end;
end;

procedure Tfbasefrm.SaveAutoPrintPayReportFlags;
begin
  with dMod1.wwtSysVar do
  begin
    FieldByName('AutoPrintPayReport').Value := cbAutoPrintPayReport.Checked;
    FieldByName('PayReportDecimalHours').Value := cbDecimalHours.Checked;
  end;
end;

procedure Tfbasefrm.SysVarTabActivated;
begin
  dmod1.wwtsysvar.open;
  edEIN.text := dmod1.wwtmastervar.fieldbyname('ein').asstring;
  edtLookAhead.text := dmod1.wwtmastervar.fieldbyname('ScheduleLookAhead').asstring;
  graceedit.text := dmod1.wwtsysvar.fieldbyname('grace').asstring;
  lee1edit.text := dmod1.wwtsysvar.fieldbyname('leeway1').asstring;
  lee2edit.text := dmod1.wwtsysvar.fieldbyname('leeway2').asstring;
  rolledit.text := fempmnu.roll;

  dmod1.ADOtWageCostUplift.Active := true;
end;

procedure tfbasefrm.AttCodeTabActivated;
begin
  dmod1.wwqROAtt.open;
  dmod1.wwtAttCd.open;
  rgAttOrd.ItemIndex := 0;
  rgAttOrdClick(self);
  pnlInsAtt.Visible := false;
  btnInsAttCode.Enabled := true;
  gridAttCd.SetFocus;
end;

procedure Tfbasefrm.ValidateTimeInEditControl(Sender: TObject);
var
  t: TDateTime;
  editControl: TCustomEdit;
begin
  editControl := TCustomEdit(Sender);
  if not(TryStrToTime(editControl.Text, t)) then
  begin
    ShowMessage(editControl.Text + ' is not a valid time');
    editControl.SetFocus;
  end;
end;

end.


