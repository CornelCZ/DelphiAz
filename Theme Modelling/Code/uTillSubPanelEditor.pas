unit uTillSubPanelEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, uADO, Grids, DBGrids, uTillButton, dbcgrids,
  uButtonPicker, Menus, uAztecLog;

type
  TTillSubPanelEditor = class(TForm)
    Label1: TLabel;
    edName: TEdit;
    Label2: TLabel;
    mmDesc: TMemo;
    cbSiteSetAppearance: TCheckBox;
    cbSiteSetSecurity: TCheckBox;
    Label3: TLabel;
    qGetSubPanelButtons: TADOQuery;
    DataSource1: TDataSource;
    dbcgSubPanelButtons: TDBCtrlGrid;
    Tillbutton1: TTillbutton;
    btOk: TButton;
    btCancel: TButton;
    qEditSubPanelButtons: TADOQuery;
    qDelSubPanelTmp: TADOQuery;
    qSaveSubPanelButtons: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btOkClick(Sender: TObject);
    procedure dbcgSubPanelButtonsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure dbcgSubPanelButtonsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Tillbutton1DblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure HandleButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    CorrectionMode: boolean;
    RButtonPicker: TButtonPicker;
    { Private declarations }
    procedure SaveButtons;
  public
    { Public declarations }
    SubPanel: TTillSubPanel;
    procedure LoadData;
    procedure SaveData;
    procedure RevertData;
  end;

var
  TillSubPanelEditor: TTillSubPanelEditor;

implementation

uses uTillButtonEditor, uDMThemeData, uGlobals;

{$R *.dfm}

procedure TTillSubPanelEditor.FormShow(Sender: TObject);
begin
  RbuttonPicker.Top := Buttonpicker.Top;
  RButtonPicker.Left := Buttonpicker.Left;
  RButtonPicker.Width := Buttonpicker.width;
  RButtonPicker.Height := Buttonpicker.Height;
  if CorrectionMode then
    RButtonPicker.Mode := bpmRestrictedCorrection
  else
    RButtonpicker.mode := bpmRestricted;
  dmThemeData.GetStoredMetrics(RButtonPicker, false);
  RButtonPicker.current_design_type := ButtonPicker.current_design_type;
  RButtonPicker.current_theme := ButtonPicker.current_theme;
  RButtonPicker.current_panel_design := ButtonPicker.current_panel_design;
  RButtonpicker.show;
end;

procedure TTillSubPanelEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dmThemeData.StoreMetrics(RButtonPicker, false);
  RButtonPicker.hide;
end;

procedure TTillSubPanelEditor.LoadData;
begin
  Log('Loading subpanel "' + SubPanel.Name + '" data, SubPanelID = ' + IntToStr(SubPanel.SubPanelID) +
      ', UserName ' + dmADO.Logon_Name);
  edName.text := SubPanel.Name;
  mmDesc.Lines.Text := SubPanel.Description;
  cbSiteSetAppearance.Checked := SubPanel.SiteEditAppearance;
  cbSiteSetSecurity.Checked := SubPanel.SiteEditSecurity;
  qDelSubPanelTmp.ExecSQL;
// Changed by AK for bug 336176
  qGetSubPanelButtons.SQL.text := Format(
    'select * from ThemePanelDesign '+
    'where CorrectAccount = %d ', [SubPanel.ParentPanelID]
  );

  qGetSubPanelButtons.Open;
  CorrectionMode := qGetSubPanelButtons.RecordCount > 0;
  qGetSubPanelButtons.Close;

  qGetSubPanelButtons.sql.text := 'CREATE TABLE [#editsubpanelbuttons] ( '+#13+
    '[backdrop] [tinyint] NULL , '+#13+
    '[eposname1] [varchar] (50) COLLATE Latin1_General_CI_AS NULL , '+#13+
    '[eposname2] [varchar] (50) COLLATE Latin1_General_CI_AS NULL , '+#13+
    '[eposname3] [varchar] (50) COLLATE Latin1_General_CI_AS NULL , '+#13+
    '[buttontypechoiceid] [smallint] NULL , '+#13+
    '[buttontypechoiceattr01] [varchar] (50) COLLATE database_default NULL , '+#13+
    '[fontcolourr] [tinyint] NULL , '+#13+
    '[fontcolourg] [tinyint] NULL , '+#13+
    '[fontcolourb] [tinyint] NULL , '+#13+
    '[buttonsecurityid] [int] NULL , '+#13+
    '[font] [tinyint] NULL , '+#13+
    '[buttonid] [bigint] NULL '+#13+
    ') ON [PRIMARY]';
  qGetSubPanelButtons.execsql;
  qGetSubPanelButtons.sql.text :=
    'insert #editsubpanelbuttons select backdrop, eposname1, eposname2, eposname3, buttontypechoiceid, buttontypechoiceattr01, '+
    'fontcolourr, fontcolourg, fontcolourb, buttonsecurityid, font, buttonid '+
    'from themepanelbutton '+
    'where panelid = '+inttostr(SubPanel.SubPanelID);
  qGetSubPanelButtons.execsql;

  qGetSubPanelButtons.SQL.Text := 'if object_id(''tempdb..#subpanelbuttons_backup'') is not null drop table #subpanelbuttons_backup';
  qGetSubPanelButtons.execsql;
  qGetSubPanelButtons.SQL.Text := 'select * into #subpanelbuttons_backup from #editsubpanelbuttons';
  qGetSubPanelButtons.execsql;

  qEditSubPanelButtons.Open;
end;

procedure TTillSubPanelEditor.SaveData;
begin
  if qEditSubPanelButtons.State in [dsEdit, dsInsert] then
    qEditSubPanelButtons.post;
  if SubPanel.Name <> edName.text then
  begin
    Log('Subpanel "' + SubPanel.Name + '", SubPanelID ' + IntToStr(SubPanel.SubPanelID) +
        ' - name changed to "' + edName.Text + '", UserName ' + dmADO.Logon_Name);
    SubPanel.name := edName.text;
  end;
  if SubPanel.Description <> mmDesc.lines.text then
  begin
    SubPanel.Description := mmDesc.lines.text;
    Log('Subpanel "' + SubPanel.Name + '", SubPanelID ' + IntToStr(SubPanel.SubPanelID) +
    ' - description changed, UserName ' + dmADO.Logon_Name);
  end;
  if SubPanel.SiteEditAppearance <> cbSiteSetAppearance.checked then
  begin
    SubPanel.SiteEditAppearance := cbSiteSetAppearance.checked;
    Log('Subpanel "' + SubPanel.Name + '", SubPanelID ' + IntToStr(SubPanel.SubPanelID) +
        ' - button properties changed, UserName ' + dmADO.Logon_Name);
  end;
  if SubPanel.SiteEditSecurity <> cbSiteSetSecurity.checked then
  begin
    SubPanel.SiteEditSecurity := cbSiteSetSecurity.checked;
    Log('Subpanel "' + SubPanel.Name + '", SubPanelID ' + IntToStr(SubPanel.SubPanelID) +
        ' - button security changed, UserName ' + dmADO.Logon_Name);
  end;

  SaveButtons;
  qEditSubPanelButtons.Close;
end;

procedure TTillSubPanelEditor.btOkClick(Sender: TObject);
begin
  modalresult := mrOk;
end;

procedure TTillSubPanelEditor.dbcgSubPanelButtonsDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept := Source is TTillButton;
end;

procedure TTillSubPanelEditor.dbcgSubPanelButtonsDragDrop(Sender, Source: TObject;
  X, Y: Integer);
begin
  dbcgSubPanelButtons.SetFocus;
  if source is TTillButton then
    with TTillButton(source).Datasource.DataSet do
    begin
      SubPanel.CheckFunctionValid(FieldByName('ButtonTypeChoiceID').AsInteger);
      if qEditSubPanelButtons.Locate('buttontypechoiceid;buttontypechoiceattr01',
             vararrayof([fieldbyname('Buttontypechoiceid').asinteger,
                         fieldbyname('Buttontypechoiceattr01').asstring]), []) then
        messagedlg('This button has been added already!', mtWarning, [mbOk], 0)
      else
      begin
//Prevents EditChoice being added to site panel if site panel is not on correction panel
        if fieldbyname('Buttontypechoiceid').AsInteger = EDITCHOICE_ID then
          if not SubPanel.isSubPanelOnCorrectionPanel then
            raise Exception.create('Correction methods may only be added to site panels within a correction panel.');
        qEditSubPanelButtons.InsertRecord([fieldbyname('backdrop').asinteger,
                                           nil,
                                           nil,
                                           nil,
                                           fieldbyname('Buttontypechoiceid').asinteger,
                                           fieldbyname('Buttontypechoiceattr01').asstring,
                                           fieldbyname('fontcolourr').asinteger,
                                           fieldbyname('fontcolourg').asinteger,
                                           fieldbyname('fontcolourb').asinteger,
                                           nil,
                                           1]);

        with TTillButton(Source) do
          Log('Subpanel "' + SubPanel.Name + '", SubPanelID ' + IntToStr(SubPanel.SubPanelID) +
              ' - adding button "' +
              Trim(StringReplace(StringReplace(GetButtonText,#10,' ',[rfReplaceAll]),#13,' ',[rfReplaceAll])) +
              '", Type ID ' + IntToStr(ButtonTypeID) + ', Data ' + ButtonTypeData + ', UserName ' + dmADO.Logon_Name);
      end;
    end;
end;

procedure TTillSubPanelEditor.Tillbutton1DblClick(Sender: TObject);
var
  t1, t2, t3: byte;
begin
  canceldrag;
  with TTillButtonEditor.create(self) do try
    NoTimedSecurity := true;
    LoadData(tillbutton1);
    cbLargeFont.Checked := false;
    cbLargeFont.Enabled := false;
    if showmodal = mrOk then
    begin
      with dbcgSubPanelButtons.DataSource.DataSet do
      begin
        edit;

        if ButtonSecurityId = 0 then
          fieldbyname('ButtonSecurityId').value := null
        else
          fieldbyname('ButtonSecurityId').AsInteger := ButtonSecurityId;

        if cbLargeFont.checked then
          fieldbyname('Font').AsInteger := 0
        else
          fieldbyname('Font').AsInteger := 1;

        if mmEposName.Lines.count > 0 then
          fieldbyname('eposname1').asstring := mmEposName.lines[0]
        else
          fieldbyname('eposname1').asstring := '';
        if mmEposName.Lines.count > 1 then
          fieldbyname('eposname2').asstring := mmEposName.lines[1]
        else
          fieldbyname('eposname2').asstring := '';
        if mmEposName.Lines.count > 2 then
          fieldbyname('eposname3').asstring := mmEposName.lines[2]
        else
          fieldbyname('eposname3').asstring := '';

        if (fieldbyname('eposname1').asstring = '') and
          (fieldbyname('eposname2').asstring = '') and
          (fieldbyname('eposname3').asstring = '') then
        begin
          fieldbyname('eposname1').clear;
          fieldbyname('eposname2').clear;
          fieldbyname('eposname3').clear;
        end;

        splitcolour(edFGColour.color, t1, t2, t3);
        fieldbyname('fontcolourr').AsInteger := t1;
        fieldbyname('fontcolourg').AsInteger := t2;
        fieldbyname('fontcolourb').AsInteger := t3;
        fieldbyname('backdrop').AsInteger :=
          integer(cbbackdropcolours.itemsex[cbbackdropcolours.itemindex].data);
        post;
      end;
    end;
  finally
    free;
  end;
  abort;
end;

procedure TTillSubPanelEditor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if dbcgSubPanelButtons.Focused and (key = vk_delete) and
    (dbcgSubPanelButtons.DataSource.DataSet.RecordCount > 0) then
  begin
    Log('Subpanel "' + SubPanel.Name + '", SubPanelID ' + IntToStr(SubPanel.SubPanelID) +
        ' - deleting button "' +
        Trim(StringReplace(StringReplace(Tillbutton1.GetButtonText,#10,' ',[rfReplaceAll]),#13,' ',[rfReplaceAll])) +
        '", Type ID ' + IntToStr(Tillbutton1.ButtonTypeID) + ', Data ' + Tillbutton1.ButtonTypeData + ', UserName ' + dmADO.Logon_Name);
    dbcgSubPanelButtons.DataSource.DataSet.Delete;
  end;
end;

procedure TTillSubPanelEditor.FormActivate(Sender: TObject);
begin
  if HelpExists then
    SetHelpContextID(self,AZTM_EDIT_SITE_PANEL);
end;

procedure TTillSubPanelEditor.HandleButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  dbcgSubPanelButtons.SetFocus;
end;

procedure TTillSubPanelEditor.RevertData;
begin
  Log('Reverting subpanel "' + SubPanel.Name + '", SubPanelID ' + IntToStr(SubPanel.SubPanelID) +
      '", UserName ' + dmADO.Logon_Name);

  qGetSubPanelButtons.SQL.Text := 'if object_id(''tempdb..#editsubpanelbuttons'') is not null drop table #editsubpanelbuttons';
  qGetSubPanelButtons.execsql;
  qGetSubPanelButtons.SQL.Text := 'select * into #editsubpanelbuttons from #subpanelbuttons_backup';
  qGetSubPanelButtons.execsql;
  SaveButtons;
end;

procedure TTillSubPanelEditor.FormCreate(Sender: TObject);
begin
  RButtonPicker := TButtonPicker.create(self);
end;

procedure TTillSubPanelEditor.FormDestroy(Sender: TObject);
begin
  RButtonPicker.free;
end;

procedure TTillSubPanelEditor.SaveButtons;
begin
  qSaveSubPanelButtons.SQL.Text :=
    'declare @panelid bigint '+#13+
    'set @panelid = '+#13+inttostr(subpanel.SubPanelID)+' '+#13+
    '-- only deletes and inserts should be required '+#13+
    'declare @ins table (btc smallint, bta1 varchar(50), buttonid bigint) '+#13+
    'declare @dels table (btc smallint, bta1 varchar(50)) '+#13+
    'declare @mod table (btc smallint, bta1 varchar(50)) '+#13+
    'insert @dels select buttontypechoiceid, buttontypechoiceattr01  '+#13+
    'from ThemePanelButton  '+#13+
    'where panelid = @panelid '+#13+
    'insert @ins select buttontypechoiceid, buttontypechoiceattr01, 0 '+#13+
    'from #editsubpanelbuttons '+#13+
    'insert @mod select a.btc, a.bta1 from @ins a '+#13+
    'join @dels b  on a.btc = b.btc and a.bta1 = b.bta1 '+#13+
    'delete from @dels  '+#13+
    'from ( '+#13+
    '  select btc as zbtc, bta1 as zbta1 from @mod '+#13+
    ') sub  '+#13+
    'where sub.zbtc = btc and sub.zbta1 = bta1 '+#13+
    'delete from @ins  '+#13+
    'from ( '+#13+
    '  select btc as zbtc, bta1 as zbta1 from @mod '+#13+
    ') sub  '+#13+
    'where sub.zbtc = btc and sub.zbta1 = bta1 '+#13+
    '-- fill in new ids for inserted records '+#13+
    'declare @btc smallint, @bta1 varchar(50), @newid bigint '+#13+
    'declare  newids  cursor for '+#13+
    'select * from @ins '+#13+
    'open newids '+#13+
    'fetch next from newids into @btc, @bta1, @newid '+#13+
    'while @@fetch_status = 0 '+#13+
    'begin '+#13+
    '  exec getnextuniqueid  ThemePanelButton_repl, ButtonId, 10000, 9223372036854775807, @nextid = @newid OUTPUT  '+#13+
    '  update @ins  '+#13+
    '  set buttonid = @newid '+#13+
    '  where btc = @btc and bta1 = @bta1 '+#13+
    '  fetch next from newids into @btc, @bta1, @newid '+#13+
    'end '+#13+
    'delete from ThemePanelButton_repl  '+#13+
    'from ( '+#13+
    '  select * from @dels   '+#13+
    ') sub '+#13+
    'where PanelID = @panelid and buttontypechoiceid = sub.btc and buttontypechoiceattr01 = sub.bta1 '+#13+
    'insert ThemePanelbutton '+#13+
    'select @Panelid, a.buttonid, 0, 0, 0, 0, b.backdrop, b.font, b.buttonsecurityid, 0 as RequestWitness, b.eposname1, b.eposname2, b.eposname3, null, ' +#13+
    'b.fontcolourr, b.fontcolourg, b.fontcolourb, a.btc, a.bta1, null '+#13+
    'from @ins a join #editsubpanelbuttons b on a.btc = b.buttontypechoiceid and a.bta1 = b.buttontypechoiceattr01 '+#13+
    'update ThemePanelButton_repl '+#13+
    'set backdrop = b.backdrop, buttonsecurityid = b.buttonsecurityid, buttontypechoiceid = b.buttontypechoiceid, '+#13+
    '  buttontypechoiceattr01 = b.buttontypechoiceattr01, font = b.font, '+#13+
    '  eposname1 = b.eposname1, eposname2 = b.eposname2, eposname3 = b.eposname3, '+#13+
    '  fontcolourr = b.fontcolourr, fontcolourg = b.fontcolourg, fontcolourb = b.fontcolourb '+#13+
    'from @mod a join #editsubpanelbuttons b on a.btc = b.buttontypechoiceid and a.bta1 = b.buttontypechoiceattr01 '+#13+
    'where ThemePanelButton_repl.panelid = @panelid and ThemePanelButton_repl.buttontypechoiceid = a.btc and ThemePanelButton_repl.buttontypechoiceattr01 = a.bta1';
  qSaveSubPanelButtons.execsql;

    Log('All subpanel "' + SubPanel.Name+ '", SubPanelID ' + IntToStr(SubPanel.SubPanelID) +
        ' changes have been saved, UserName ' + dmADO.Logon_Name);
end;

end.
