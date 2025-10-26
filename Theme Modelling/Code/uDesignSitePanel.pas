unit uDesignSitePanel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uTillButton, uado, DB, ADODB, dbcgrids, ExtCtrls, uButtonPicker;

type
  TDesignSitePanel = class(TForm)
    pnBottomBar: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    RButtonPicker: TButtonPicker;
    FSubPanelDimsHiding: integer;
    { Private declarations }
    procedure HandleDoubleClick(obj: TTillObject);
    procedure HandleContextClick(obj: TTillObject);
  public
    panelmanager: TPanelManager;
    { Public declarations }
    SubPanelID: int64;
    SiteCode: integer;
    procedure Load;
    procedure Save;
    procedure Setup;
  end;

implementation

uses uDMThemeData, uTillButtonEditor, uGlobals;

{$R *.dfm}

procedure TDesignSitePanel.FormShow(Sender: TObject);
begin
  with dmThemeData do
  begin
    if not GetStoredMetrics(self, true, uDmThemeData.sttCentreScreen) then
    begin
      self.top := (screen.Height - self.height) div 2;
      self.left := (screen.Width - self.width) div 2;
    end;
    if not GetStoredMetrics(RButtonPicker, false, self, uDMThemeData.sttLeftRight) then
    begin
      RButtonPicker.Left := self.left - RButtonPicker.Width;
      RButtonPicker.Height := self.height;
      RButtonPicker.Top := (screen.Height - RButtonpicker.Height) div 2;
    end;
  end;
  RButtonPicker.show;
  Screen.cursor := crDefault;
end;

procedure TDesignSitePanel.Button1Click(Sender: TObject);
begin
  Save;
  modalresult := mrOk;
end;

procedure TDesignSitePanel.Load;
begin
  readfixedlookups(dmThemedata.aztecconn);
  panelmanager := TPanelmanager.Create(self);
  readdynamiclookups(dmthemedata.aztecconn, false, subpanelid);
  panelmanager.LoadPanel(dmThemeData.AztecConn, subpanelid, lpmSitePanel, sitecode);
  if panelmanager.PanelOutLine.Width > clientwidth then
    clientwidth := panelmanager.PanelOutLine.Width;
  if (panelmanager.PanelOutLine.Height + pnBottomBar.Height) > clientheight then
    ClientHeight := panelmanager.PanelOutLine.Height + pnBottomBar.Height;
  panelmanager.ObjectDblClickEvent := HandleDoubleCLick;
  panelmanager.ObjectContextEvent := HandleContextClick;

    // test for buttons hidden by change to sub panel geometry
  dmThemeData.adoqRun.SQL.Text := Format(
    'declare @SiteCode Int '+
    'declare @SubPanelID int '+
    'set @SiteCode = %d '+
    'set @SubPanelID = %d '+
    'select * from ThemePanelSubPanel Parent '+
    'join ThemePanelSubPanelButtons Child on Parent.SubPanelID = Child.SubPanelID '+
    'where Parent.SubPanelID = @SubPanelId and Child.SiteCode = @SiteCode '+
    'and (Child.[Top] >= Parent.Height or Child.[Left] >= Parent.Width)',
    [SiteCode, SubPanelID]);
  dmThemeData.adoqRun.Open;
  FSubPanelDimsHiding := dmThemeData.adoqRun.RecordCount;
  dmThemeData.adoqRun.Close;

    if (FSubPanelDimsHiding > 0) then MessageDlg(
    Format('Site Panel dimensions have changed, causing %d buttons to be hidden. '#10#13+
      'It must be restored to its former size to allow these to be edited again.'#10#13+
      'Selecting OK in the design screen will permanently remove the hidden buttons.', [FSubPanelDimsHiding]),
    mtConfirmation, mbOKCancel, 0);
end;

procedure TDesignSitePanel.Save;
begin
  panelmanager.SavePanel(dmThemeData.AztecConn);
end;

procedure TDesignSitePanel.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dmThemeData.StoreMetrics(RButtonPicker, false);
  dmThemeData.StoreMetrics(self, true);
  RButtonPicker.hide;
  RButtonPicker.free;
  dmThemeData.adoqrun.sql.text := 'if object_id(''tempdb..#custombuttonmenu'') is not null drop table #custombuttonmenu';
  dmThemeData.adoqrun.execsql;
end;

procedure TDesignSitePanel.Setup;
begin
  // remove inapplicable openpanel buttons from site panel
  dmThemeData.adoqRun.SQL.Text := Format(
    'declare @Sitecode Int '+
    'declare @SubPanelID int '+
    'set @Sitecode = %d '+
    'set @SubPanelID = %d '+
    'delete ThemePanelSubPanelButtons '+
    'from ThemePanelSubPanelButtons a '+
    'join ( '+
    '  select b.PanelID, b.ButtonID from ThemePanel a '+
    '  join ThemePanelButton b on a.PanelID = b.PanelID '+
    '  where b.ButtonTypeChoiceID in (select Id from ThemeButtonTypeChoiceLookup where Name in (''OpenPanel'', ''ApplyAnd'')) '+
    '    and b.ButtonTypeChoiceAttr01 in ( '+
    '      select CAST(PanelID as varchar(50)) from ThemeSiteVariation a '+
    '      where a.SiteCode = @Sitecode and a.VariationPanelID = -1 '+
    '    ) '+
    ') b on a.SiteCode = @Sitecode and a.SubPanelID = b.PanelID and a.ButtonID = b.ButtonID',
    [SiteCode, SubPanelID]);
  dmThemeData.adoqRun.ExecSQL;

  load;
  RButtonPicker := TButtonPicker.create(self);
  RbuttonPicker.Top := Buttonpicker.Top;
  RButtonPicker.Left := Buttonpicker.Left;
  RButtonPicker.Width := Buttonpicker.width;
  RButtonPicker.Height := Buttonpicker.Height;

  dmThemeData.adoqrun.sql.text := 'if object_id(''tempdb..#custombuttonmenu'') is not null drop table #custombuttonmenu';
  dmThemeData.adoqrun.execsql;

  dmThemeData.adoqRun.SQL.Text :=
    'select backdrop, eposname1, eposname2, eposname3, ButtonTypeChoiceID, ButtonTypeChoiceAttr01, '+
    'fontcolourr,fontcolourg, fontcolourb, b.[sub-category name] as subcategory, b.[extended rtl name] as buttonname , b.[retail description] as buttondescription, '+
    'buttonid, buttonsecurityid '+ #13 +
    'into #custombuttonmenu from themepanelbutton a '+ #13 +
    'left outer join entity b on cast(cast(b.[entity code] as bigint) as varchar(50)) = a.buttontypechoiceattr01 '+
    'where panelid = '+inttostr(subpanelid);
  dmThemeData.adoqRun.ExecSQL;

  // remove inapplicable site variations
  dmThemeData.adoqRun.SQL.Text :=
    'delete #custombuttonmenu '+
    'where ButtonTypeChoiceID in '+
    '  (select Id from ThemeButtonTypeChoiceLookup where Name in (''OpenPanel'', ''ApplyAnd'')) '+
    'and ButtonTypeChoiceAttr01 in ( '+
    '  select cast(a.PanelID as varchar(50)) as PanelID '+
    '  from themepanelvariation a '+
    '  left outer join themesitevariation b on a.PanelID = b.PanelID '+
    '    and sitecode = dbo.fnGetSiteCode() and effectivedate = 0 and b.variationpanelid <> -1 '+
    '  where b.PanelID is null) ';
  dmThemeData.adoqRun.ExecSQL;

  // remove unsupported functions
  dmThemeData.adoqRun.SQL.Text :=
    'delete #custombuttonmenu '+
    'from #custombuttonmenu a '+
    'left outer join ThemeButtonTypeChoiceLookup b on a.ButtonTypeChoiceID = b.ID '+
    'where b.ID is null';
  dmThemeData.adoqRun.ExecSQL;

  RButtonpicker.mode := bpmCustom;
end;

procedure TDesignSitePanel.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = VK_DELETE) and assigned(panelmanager.SelectedObject) then
    panelmanager.Delete;
end;

procedure TDesignSitePanel.HandleDoubleClick(obj: TTillObject);
begin
  if (obj is TTillButton) then
  begin
    if not panelmanager.SitePanelAllowAppearanceEdits then
      Raise exception.create('Editing of the button properties is not allowed for this panel');
    with TTillButtonEditor.create(self) do try
      // disable epos name edit
      mmeposname.Enabled := false;
      mmeposname.Color := clBtnFace;
      btEditSecurity.Enabled := false;
      LoadData(TTillButton(obj));

      if TTillButton(Panelmanager.selectedobject).IsCorrectionMethod then
      begin
        cbDefault.Visible := True;
        cbDefault.Enabled := True;

        if TTillButton(Panelmanager.selectedobject).ButtonTypeData = IntToStr(PanelManager.DefaultcorrectionMethod) then
        begin
          cbDefault.Checked := True;
          cbDefault.Enabled := False;
        end;
      end
      else
      begin
        cbDefault.Visible := False;
        cbDefault.Checked := False;
      end;

      if showmodal = mrOk then
      begin
        SaveData(TTillButton(obj));

        if cbDefault.Checked then
        begin
          PanelManager.DefaultCorrectionMethod := StrToInt(TTillButton(Panelmanager.selectedobject).ButtonTypeData);
        end;
      end;
    finally
      free;
    end;
  end;
end;

procedure TDesignSitePanel.FormActivate(Sender: TObject);
begin
  if HelpExists then
    SetHelpContextID(self,AZTM_DESIGN_SITE_PANEL);
end;

procedure TDesignSitePanel.HandleContextClick(obj: TTillObject);
var
  Pos: Tpoint;
begin
  GetCursorPos(Pos);
  if ((panelmanager.selectedobject is TTillButton) and
    (TTillButton(panelmanager.selectedobject).drawtype = tbdtButton)) or (PanelManager.SelectedObject is TMultiItemSelection) then
    PanelManager.BackdropMenu.Popup(Pos.x, Pos.y);
end;


end.
