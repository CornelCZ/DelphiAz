unit uThemes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, db, Wwdbigrd, Wwdbgrid, uGridSortHelper,
  ExtCtrls, Menus, Buttons, ActnList;

const
  HO_PREVIEW_TERMINALID = 1;

type
  TThemes = class(TForm)
    Label1: TLabel;
    btAddTheme: TButton;
    btEditTheme: TButton;
    btDeleteTheme: TButton;
    btClose: TButton;
    btAddPanelDesign: TButton;
    btEditPanelDesign: TButton;
    btDeletePanelDesign: TButton;
    Label2: TLabel;
    btDesignPanelDesign: TButton;
    Label3: TLabel;
    btAddTablePlan: TButton;
    btEditTablePlan: TButton;
    btDeleteTablePlan: TButton;
    btPreviewPanelDesign: TButton;
    btGroup: TButton;
    btEditChoices: TButton;
    btStaticPanelSecurity: TButton;
    btCopyPanelDesign: TButton;
    btTickets: TButton;
    dbgThemes: TwwDBGrid;
    dbgThemePanelDesigns: TwwDBGrid;
    dbgThemeTablePlans: TwwDBGrid;
    btMacros: TButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    PreviewTypeMenu: TPopupMenu;
    ptStandardPreview: TMenuItem;
    ptRandomTerminal: TMenuItem;
    ptChooseTerminal: TMenuItem;
    Selectpreviewmode1: TMenuItem;
    btChoosePreviewType: TButton;
    ShowPreviewManager1: TMenuItem;
    ActionList1: TActionList;
    ShowPreviewManager: TAction;
    btnDefaultRolePanel: TButton;
    procedure btDeleteThemeClick(Sender: TObject);
    procedure btDeletePanelDesignClick(Sender: TObject);
    procedure btAddThemeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure btEditThemeClick(Sender: TObject);
    procedure btAddPanelDesignClick(Sender: TObject);
    procedure btEditPanelDesignClick(Sender: TObject);
    procedure btPreviewPanelDesignClick(Sender: TObject);
    procedure btDesignPanelDesignClick(Sender: TObject);
    procedure btAddTablePlanClick(Sender: TObject);
    procedure btEditTablePlanClick(Sender: TObject);
    procedure btDeleteTablePlanClick(Sender: TObject);
    procedure btGroupClick(Sender: TObject);
    procedure btEditChoicesClick(Sender: TObject);
    procedure btStaticPanelSecurityClick(Sender: TObject);
    procedure btCopyPanelDesignClick(Sender: TObject);
    procedure btTicketsClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btChoosePreviewTypeClick(Sender: TObject);
    procedure HandlePreviewTypePopupMenuItem(Sender: TObject);
    procedure btMacrosClick(Sender: TObject);
    procedure ShowPreviewManagerUpdate(Sender: TObject);
    procedure ShowPreviewManagerExecute(Sender: TObject);
    procedure btnDefaultRolePanelClick(Sender: TObject);
  private
    { Private declarations }
    LastThemeID, LastPanelDesignID, LastTablePlanID: integer;
    ThemeSortHelper: TGridSortHelper;
    PanelDesignSortHelper: TGridSortHelper;
    TablePlanSortHelper: TGridSortHelper;
    procedure CheckCanEdit(dataset: TDataset);
    procedure SavePreviewType;
    procedure LoadPreviewType;
  public
    { Public declarations }
  end;

var
  Themes: TThemes;

implementation

uses uDMThemeData, uEditThemeDetails, uGenerateThemeIDs,
  uEditPanelDesignDetails, uXMLSave, uAztecZoeComms, uEditThemeTablePlan,
  uEditPanelDesign, uThemeTablePlanGroups, uEditChoices,
  uEditDialogSecurity, useful, uEditTicketing, uAztecLog, uPreviewManager,
  uThemeModellingMenu, uFormNavigate, uSelectTerminal, Registry,
  uDefineMacros, uEditDefaultJobPanel;

{$R *.dfm}

procedure TThemes.btDeleteThemeClick(Sender: TObject);
begin
  Log('Delete Theme Clicked');
  CheckCanEdit(dmThemeData.qThemes);

  with dmThemeData.adoqrun do
  begin
    SQL.Text := Format('select Count(*) as Result from ThemeSites where ThemeID = %d',
      [dbgThemes.datasource.dataset.fieldbyname('ThemeID').AsInteger]);
    Open;
    if FieldByName('Result').AsInteger > 0 then
    begin
      Close;
      raise Exception.Create('Sites are using this Theme - the Delete cannot proceed.');
    end;
    Close;
  end;
  if messagedlg(
    format('Are you sure you want to delete Theme "%s"?', [dbgThemes.datasource.dataset.fieldbyname('Name').asstring]),
      mtConfirmation, [mbOk, mbCancel], 0) = mrOk then
  begin
    log('Deleting Theme ' + dbgThemes.datasource.dataset.fieldbyname('Name').asstring);
    dmThemeData.qThemes.delete;
  end;
end;

procedure TThemes.btDeletePanelDesignClick(Sender: TObject);
begin
  Log('Delete Theme Panel Design Clicked');
  CheckCanEdit(dmThemeData.qPanelDesigns);

  with dmThemeData.adoqrun do
  begin
    SQL.Text := Format(
      'select Count(*) as Result '+
      'from ThemeEposDesign a '+
      'join ThemeEposDevice b on a.SiteCode = b.SiteCode and a.POSCode = b.POSCode '+
      'where PanelDesignID = %d',
      [dmThemeData.qPanelDesigns.fieldbyname('PanelDesignID').AsInteger]);
    Open;
    if FieldByName('Result').AsInteger > 0 then
    begin
      Close;
      raise Exception.Create('Terminals are using this Panel Design - the Delete cannot proceed.');
    end;
    Close;
  end;

  if messagedlg(
    format('Are you sure you want to delete Panel Design "%s"?', [dmThemeData.qPanelDesigns.fieldbyname('Name').asstring]),
      mtConfirmation, [mbOk, mbCancel], 0) = mrOk then
  begin
    Log('Deleting Panel Design :' +dmThemeData.qPanelDesigns.fieldbyname('Name').asstring);
    dmThemeData.qPanelDesigns.delete;
  end;
end;

procedure TThemes.btAddThemeClick(Sender: TObject);
begin
  Log('Add Theme Clicked');
  with TThemeDetails.create(nil) do try
    caption := 'Add Theme';
    lbName.caption := 'Theme name';
    edName.text := '';
    mmDescription.lines.Clear;
    seIdleTime.Value := 60;
    ThemeID := -1;
    if showmodal = mrOk then
    begin
      log('Theme ' + edName.text +' Added');
      dmThemeData.qThemes.InsertRecord([
        integer(GetNewId(scTheme)),
        edName.text,
        mmDescription.Lines.Text,
        seIdleTime.Value
      ]);
    end;
  finally
    free;
  end;
end;

procedure TThemes.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
  dmThemedata.AccessDataset('qThemes');
  dmThemedata.AccessDataset('qPanelDesigns');
  dmThemedata.AccessDataset('qThemeTablePlans');

  //check that hotel divisions have been updated with all new changes.
  dmThemedata.qConfigSetCheckDivisions.execsql;
  dmThemedata.qConfigSetCheckOrderDestinations.ExecSQL;

  ThemeSortHelper.Reset;
  PanelDesignSortHelper.Reset;
  TablePlanSortHelper.Reset;
  dmThemeData.qThemes.Locate('ThemeID', LastThemeID, []);
  dmThemeData.qPanelDesigns.Locate('PanelDesignID', LastPanelDesignID, []);
  dmThemeData.qThemeTablePlans.Locate('TablePlanID', LastTablePlanID, []);

  ShowPreviewManager1.Checked := false;
end;

procedure TThemes.FormHide(Sender: TObject);
begin
  if not application.Terminated then
  begin
    LastThemeID := dmThemeData.qThemes.FieldByName('ThemeID').AsInteger;
    LastPanelDesignID := dmThemeData.qPanelDesigns.FieldByName('PanelDesignID').AsInteger;
    LastTablePlanID := dmThemeData.qThemeTablePlans.FieldByName('TablePlanID').AsInteger;
    dmThemedata.DeAccessDataset('qThemes');
    dmThemedata.DeAccessDataset('qPanelDesigns');
    dmThemedata.DeAccessDataset('qThemeTablePlans');
  end;
end;

procedure TThemes.btEditThemeClick(Sender: TObject);
begin
  Log('Edit Theme Clicked');
  CheckCanEdit(dmThemeData.qThemes);
  with TThemeDetails.create(nil) do try
    caption := 'Edit Theme';
    lbName.caption := 'Theme name';
    edName.text := '';
    mmDescription.lines.Clear;
    edName.text := dmThemeData.qThemes.FieldByName('Name').AsString;
    mmDescription.text := dmThemeData.qThemes.FieldByName('Description').AsString;
    seIdleTime.Value := dmThemeData.qThemes.FieldByName('IdleTime').asInteger;
    ThemeID := dmThemeData.qThemes.FieldByName('ThemeID').AsInteger;
    if showmodal = mrOk then
    begin
      with dmThemeData.qThemes do
      begin
        edit;
        fieldbyname('Name').asstring := edName.text;
        fieldbyname('Description').asstring := mmDescription.Lines.text;
        fieldbyname('IdleTime').asInteger := seIdleTime.Value;
        post;
      end;
      log('Theme ' + edName.text +' Edited');
    end;
  finally
    free;
  end;
end;

procedure TThemes.btAddPanelDesignClick(Sender: TObject);
var
  NewPanelDesignID, screensize : integer;
begin
  Log('Add Theme Panel Design Clicked');
  if dmThemeData.qThemes.RecordCount = 0 then
    raise exception.create('Please add a theme first');
  with TEditPanelDesignDetails.create(emAdd) do try
    caption := 'Add Panel Design';
    PanelDesignID:= -1;
    ThemeID := dmThemeData.qThemes.FieldByName('ThemeID').AsInteger;
    DefaultPayPanel:= 0;
    SetScreenSizes;
    cbxScreenSize.ItemIndex := 0;
    if showmodal = mrOK then
    begin
      Log('Panel Design ' + edName.text + ' created');
      if not cbxScreenSize.Visible then
         screensize := 0
      else screensize := integer(cbxScreenSize.items.Objects[cbxScreenSize.ItemIndex]);
      with dmThemeData.adocRun do
      begin
        commandtext := format('exec Theme_Copy_Or_New_PanelDesign null, null, %d, %s, %s, %d, %d, %d',
          [dmThemeData.qThemes.fieldbyname('ThemeID').asinteger,
          quotedstr(edName.text),
          quotedstr(mmDescription.lines.Text),
          integer(cbPanelDesignType.items.Objects[cbPanelDesignType.ItemIndex]),
          TInt64Obj(cbPayPanel.items.Objects[cbPayPanel.ItemIndex]).value,
          screensize]);
        execute;
        dmThemeData.qPanelDesigns.Requery;
      end;

      if cbUseForcedSelection.Checked then
      begin
        with dmThemeData.adoqRun do
        begin
          Close;
          sql.Clear;
          sql.Add('SELECT MAX(PanelDesignID) AS NewPanelDesignID FROM dbo.[ThemePanelDesign]');
          open;

          NewPanelDesignID := FieldByName('NewPanelDesignID').asInteger;
          close;
        end;

        dmThemeData.NewForcedSelectionPanel(NewPanelDesignID);
      end;

    end;
  finally
    free;
  end;
end;

procedure TThemes.btEditPanelDesignClick(Sender: TObject);
var
  i,p: integer;
  PayPanel, oldDefaultPayPanel, cPanelDesignID : Int64;
  paypanelModified : Boolean;
begin
  Log('Edit Theme Panel Design Clicked');
  paypanelModified := False;
  CheckCanEdit(dmThemeData.qPanelDesigns);
  with TEditPanelDesignDetails.create(emEdit) do try
    caption := 'Edit Panel Design';
    with dmThemeData.qPanelDesigns do
    begin
      edName.text := fieldbyname('Name').asstring;
      mmDescription.lines.text := fieldbyname('Description').asstring;
      for i := 0 to pred(cbPanelDesignType.items.count) do
        if integer(cbPanelDesignType.items.objects[i]) = fieldbyname('PanelDesignType').asinteger then
          break;

      DefaultPayPanel := FieldByName('DefaultPay').AsInteger;
      oldDefaultPayPanel := FieldByName('DefaultPay').AsInteger;
      cbPanelDesignType.itemindex := i;
      cbPanelDesignType.Enabled := false;

      SetScreenSizes;
      for p := 0 to cbxScreenSize.items.count do
          if integer(cbxScreenSize.items.objects[p]) = fieldbyname('ScreenInterfaceID').asinteger then
              break;

      cbxScreenSize.ItemIndex := p;
      cbxScreenSize.Enabled := false;

      cbUseForcedSelection.Checked := (dmThemeData.GetForcedSelectionPanelID(
                      dmThemeData.qPanelDesigns.fieldbyname('PanelDesignID').asinteger) <> -1);
      PanelDesignID := FieldByName('PanelDesignID').AsInteger;
      ThemeID := dmThemeData.qThemes.FieldByName('ThemeID').AsInteger;
      PayPanel := FieldByName('Pay').AsInteger;
      cPanelDesignID := FieldByName('PanelDesignID').AsInteger;

      if showmodal = mrOk then
      begin
        Log('Panel Design ' + edName.text + ' Modified');
        dmThemeData.qPanelDesigns.edit;
        if FieldByName('DefaultPay').AsInteger <> TInt64Obj(cbPayPanel.items.Objects[cbPayPanel.ItemIndex]).value then
           paypanelModified := True;
        fieldbyname('Name').asstring := edName.text;
        fieldbyname('Description').asstring := mmDescription.lines.Text;
        fieldbyname('PanelDesignType').asinteger :=
          integer(cbPanelDesignType.items.Objects[cbPanelDesignType.ItemIndex]);
        FieldByName('DefaultPay').AsInteger := TInt64Obj(cbPayPanel.items.Objects[cbPayPanel.ItemIndex]).value;
        dmThemeData.qPanelDesigns.Post;

        if paypanelModified then
          begin
            with dmThemeData.adoqRun do
              begin
                if oldDefaultPayPanel = 0 then
                   oldDefaultPayPanel := PayPanel;
                   
                SQL.Add('UPDATE ThemePanelButton ');
                if TInt64Obj(cbPayPanel.items.Objects[cbPayPanel.ItemIndex]).value = 0 then
                   SQL.Add(' SET ButtonTypeChoiceAttr01 = '+ IntToStr(PayPanel) )
                else
                   SQL.Add(' SET ButtonTypeChoiceAttr01 = '+ IntToStr(TInt64Obj(cbPayPanel.items.Objects[cbPayPanel.ItemIndex]).value) );
                SQL.Add(' WHERE ButtonTypeChoiceID = 10 AND ButtonTypeChoiceAttr01 = '+ IntToStr(oldDefaultPayPanel));
                SQL.Add(' AND PanelID IN (SELECT Root FROM ThemePanelDesign WHERE PanelDesignID = '+ IntToStr(cPanelDesignID) + ') ');
                ExecSQL;
              end;
          end;

        if cbUseForcedSelection.Checked then
        begin
          if dmThemeData.GetForcedSelectionPanelID(
                      dmThemeData.qPanelDesigns.fieldbyname('PanelDesignID').asinteger) = -1 then
            dmThemeData.NewForcedSelectionPanel(
                          dmThemeData.qPanelDesigns.fieldbyname('PanelDesignID').asinteger);
        end
        else
        begin
          if dmThemeData.GetForcedSelectionPanelID(
                      dmThemeData.qPanelDesigns.fieldbyname('PanelDesignID').asinteger) <> -1 then
            dmThemeData.DeleteForcedSelectionPanel(
                          dmThemeData.qPanelDesigns.fieldbyname('PanelDesignID').asinteger);
        end;

        PayPanelList.free;
      end;
    end;
  finally
    free;
  end;
end;

procedure TThemes.btPreviewPanelDesignClick(Sender: TObject);
var
  PanelDesignID: integer;
  ExampleSiteCode, ExampleSalesArea, ExamplePOSCode: integer;
begin
  ButtonClicked(Sender);
  CheckCanEdit(dmThemeData.qPanelDesigns);
  PanelDesignID := dmThemeData.qPanelDesigns.FieldByName('PanelDesignId').AsInteger;
  if ptStandardPreview.Checked then
    PreviewManager.AddPreviewRequest(-1, -1, -1, PanelDesignID)
  else
  if ptRandomTerminal.Checked then
  begin
    dmThemeData.GetPanelDesignExampleSite(PanelDesignID, ExampleSiteCode, ExampleSalesArea, ExamplePOSCode);
    PreviewManager.AddPreviewRequest(ExampleSiteCode, ExampleSalesArea, ExamplePOSCode, PanelDesignID);
  end
  else
  begin
    // select terminal
    TSelectTerminalForm.SelectExamplePOS(PanelDesignID, ExampleSiteCode, ExampleSalesArea, ExamplePOSCode);
    if ExamplePOSCode <> -1 then
      PreviewManager.AddPreviewRequest(ExampleSiteCode, ExampleSalesArea, ExamplePOSCode, PanelDesignID);
  end;
end;

procedure TThemes.btDesignPanelDesignClick(Sender: TObject);
begin
  Log('Design Theme Panel Design Clicked');
  CheckCanEdit(dmThemeData.qPanelDesigns);
  EditPanelDesign := TEditPanelDesign.create(nil);
  with EditPanelDesign do try
    screen.Cursor := crAppStart;
    Log('Loading Panel Design ID ' + dmThemeData.qPanelDesigns.fieldbyname('PanelDesignID').AsString);
    loadpaneldesign(dmThemeData.qPanelDesigns.fieldbyname('PanelDesignID').asinteger);
    screen.cursor := crDefault;
    Nav.MoveForward(EditPanelDesign, True);
  finally
  end;
end;

procedure TThemes.btAddTablePlanClick(Sender: TObject);
begin
  Log('Add Theme Table Plan Clicked');
  if dmThemeData.qPanelDesigns.RecordCount = 0 then
    raise exception.create('Please add a panel design first');
  if dmThemeData.qThemeTablePlans.RecordCount >= 30 then
    raise Exception.create('You cannot create more than 30 Theme Table Plans');
  with TEditThemeTablePlan.create(nil) do try
    caption := 'Add Table Plan';
    TablePlanID := -1;
    ThemeID := dmThemeData.qThemes.FieldByName('ThemeID').AsInteger;
    if showmodal = mrOk then
    with dmThemeData.qThemeTablePlans do
    begin
      Log('Adding Table Plan : ' + edName.text);
      insert;
      fieldbyname('TablePlanID').asinteger :=
        uGenerateThemeIDs.GetNewId(scThemeTablePlan);
      fieldbyname('ThemeID').AsInteger :=
        dmThemeData.qThemes.fieldbyname('ThemeID').asinteger;
      fieldbyname('Name').asstring := edName.text;
      fieldbyname('Description').asstring := mmDescription.lines.text;
      if mmEposName.Lines.count > 0 then
        Fieldbyname('eposname1').asstring := mmEposName.lines[0]
      else
        Fieldbyname('eposname1').asstring := '';
      if mmEposName.Lines.count > 1 then
        Fieldbyname('eposname2').asstring := mmEposName.lines[1]
      else
        Fieldbyname('eposname2').asstring := '';
      if mmEposName.Lines.count > 2 then
        Fieldbyname('eposname3').asstring := mmEposName.lines[2]
      else
        Fieldbyname('eposname3').asstring := '';
      fieldbyname('ShowSplitTable').asboolean := cbSplitTableMode.checked;
      post;
    end;
  finally
    free;
  end;
end;

procedure TThemes.btEditTablePlanClick(Sender: TObject);
begin
  Log('Edit Theme Table Plan Clicked');
  CheckCanEdit(dmThemeData.qThemeTablePlans);
  with TEditThemeTablePlan.create(nil) do try
    caption := 'Edit Table Plan';
    with dmThemeData.qThemeTablePlans do
    begin
      edName.text := fieldbyname('Name').asstring;
      mmDescription.Lines.text := fieldbyname('Description').asstring;
      mmEposName.Lines.text :=
        fieldbyname('Eposname1').asstring + #13+
        fieldbyname('Eposname2').asstring + #13+
        fieldbyname('Eposname3').asstring;
      cbSplitTableMode.checked := fieldbyname('ShowSplitTable').asboolean;
      TablePlanID := FieldByName('TablePlanID').AsInteger;
      ThemeID := dmThemeData.qThemes.FieldByName('ThemeID').AsInteger;

      if showmodal = mrOk then
      begin
        Log('Table Plan ' + edName.text + ' modified');
        edit;
        fieldbyname('Name').asstring := edName.text;
        fieldbyname('Description').asstring := mmDescription.lines.text;
        if mmEposName.Lines.count > 0 then
          Fieldbyname('eposname1').asstring := mmEposName.lines[0]
        else
          Fieldbyname('eposname1').asstring := '';
        if mmEposName.Lines.count > 1 then
          Fieldbyname('eposname2').asstring := mmEposName.lines[1]
        else
          Fieldbyname('eposname2').asstring := '';
        if mmEposName.Lines.count > 2 then
          Fieldbyname('eposname3').asstring := mmEposName.lines[2]
        else
          Fieldbyname('eposname3').asstring := '';
        fieldbyname('ShowSplitTable').asboolean := cbSplitTableMode.checked;
        post;
      end;
    end;
  finally
    free;
  end;

end;

procedure TThemes.btDeleteTablePlanClick(Sender: TObject);
begin
  Log('Delete Table Plab Button clicked');
  CheckCanEdit(dmThemeData.qThemeTablePlans);
  if messagedlg(
    format('Are you sure you want to delete Theme Table Plan "%s"?', [dmThemeData.qThemeTablePlans.fieldbyname('Name').asstring]),
      mtConfirmation, [mbOk, mbCancel], 0) = mrOk then
  begin
    Log('Deleting table Plan ' + dmThemeData.qThemeTablePlans.fieldbyname('Name').asstring);
    dmThemeData.qThemeTablePlans.delete;
  end;
end;

procedure TThemes.CheckCanEdit(dataset: TDataset);
begin
  if dataset.recordcount = 0 then
    Raise exception.create('Please add some items first!');
end;

procedure TThemes.btGroupClick(Sender: TObject);
begin
  buttonClicked(Sender);
  uthemetableplangroups.TThemeTablePlanGroups.EditGroups(
    dmThemeData.qThemes.fieldbyname('ThemeID').asinteger
  );
end;

procedure TThemes.btEditChoicesClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  CheckCanEdit(dmThemeData.qPanelDesigns);
  Log('Editng Panel Choices for Design ID ' + dmThemeData.qPanelDesigns.FieldByName('paneldesignid').AsString);
  uEditChoices.TEditChoices.EditChoices(
    dmThemeData.qPanelDesigns.FieldByName('paneldesignid').asinteger
  );
end;

procedure TThemes.btStaticPanelSecurityClick(Sender: TObject);
var
  EditDialogSecurity: TEditDialogSecurity;
begin
  ButtonClicked(Sender);
  CheckCanEdit(dmThemeData.qThemes);
  EditDialogSecurity := TEditDialogSecurity.create(nil);
  with EditDialogSecurity do try
    screen.cursor := crAppStart;
    LoadThemeDialogs(dmThemeData.qThemes.FieldByName('ThemeID').asinteger);
    screen.cursor := crDefault;
    Nav.MoveForward(EditDialogSecurity, true);
  finally
  end;
end;

procedure TThemes.btCopyPanelDesignClick(Sender: TObject);
var
  i,p: integer;
  PayPanel : Int64;
begin
  ButtonClicked(Sender);
  CheckCanEdit(dmThemeData.qPanelDesigns);

  with TEditPanelDesignDetails.create(emCopy) do try
    caption := 'Copy Panel Design';
    with dmThemeData.qPanelDesigns do
    begin
      edName.text := fieldbyname('Name').asstring;
      mmDescription.lines.text := fieldbyname('Description').asstring;
      for i := 0 to pred(cbPanelDesignType.items.count) do
        if integer(cbPanelDesignType.items.objects[i]) = fieldbyname('PanelDesignType').asinteger then
          break;

      DefaultPayPanel := FieldByName('DefaultPay').AsInteger;
      cbPayPanel.Enabled := False;
      cbPanelDesignType.itemindex := i;
      cbPanelDesignType.Enabled := false;
      cbUseForcedSelection.Checked := (dmThemeData.GetForcedSelectionPanelID(
                      dmThemeData.qPanelDesigns.fieldbyname('PanelDesignID').asinteger) <> -1);
      cbUseForcedSelection.Enabled := false;
      PanelDesignID := dmThemeData.qPanelDesigns.FieldByName('PanelDesignID').AsInteger;
      ThemeID := dmThemeData.qThemes.FieldByName('ThemeID').AsInteger;

      SetScreenSizes;
      for p := 0 to cbxScreenSize.items.count do
          if integer(cbxScreenSize.items.objects[p]) = fieldbyname('ScreenInterfaceID').asinteger then
              break;

      cbxScreenSize.ItemIndex := p;
      cbxScreenSize.Enabled := false;

      if showmodal = mrOk then
      begin
        screen.cursor := crHourglass;
        try
        with dmThemeData.adoqRun do
        begin
          if cbPayPanel.ItemIndex = 0 then
             PayPanel := 0
          else
             PayPanel := TInt64Obj(cbPayPanel.items.Objects[cbPayPanel.ItemIndex]).value;

          sql.text := format('exec theme_copy_or_new_paneldesign %d, %d, %d, %s, %s, 0, %d, %d',  [
            dmThemeData.qPanelDesigns.fieldbyname('PanelDesignID').asinteger,
            dmThemeData.qThemes.fieldbyname('ThemeID').asinteger,
            dmThemeData.qThemes.fieldbyname('ThemeID').asinteger,
            quotedstr(edName.Text),
            quotedstr(mmDescription.Text),
            PayPanel,
            dmThemeData.qPanelDesigns.fieldbyname('ScreenInterfaceID').asinteger
          ]);
          execsql;
          dmThemeData.qPanelDesigns.Requery;
        end;
        finally
          screen.cursor := crDefault;
        end;
      end
    end;
  finally
    free;
  end;
end;

procedure TThemes.btTicketsClick(Sender: TObject);
var
  TicketForm: TEditTicketing;
begin
  ButtonClicked(Sender);
  TicketForm := TEditTicketing.create(nil);
  TicketForm.theme_id := dmThemeData.qThemes.FieldByName('ThemeID').AsInteger;
  TicketForm.Prepare;
  nav.MoveForward(TicketForm, True);
end;

procedure TThemes.btCloseClick(Sender: TObject);
begin
  buttonClicked(Sender);
  Close;
end;

procedure TThemes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
  Nav.MoveBack;
end;

procedure TThemes.FormCreate(Sender: TObject);
begin
  ThemeSortHelper:= TGridSortHelper.Create;
  ThemeSortHelper.Initialise(dbgThemes);
  PanelDesignSortHelper:= TGridSortHelper.Create;
  PanelDesignSortHelper.Initialise(dbgThemePanelDesigns);
  TablePlanSortHelper:= TGridSortHelper.Create;
  TablePlanSortHelper.Initialise(dbgThemeTablePlans);
  LoadPreviewType;
end;

procedure TThemes.FormDestroy(Sender: TObject);
begin
  SavePreviewType;
  ThemeSortHelper.Free;
  PanelDesignSortHelper.Free;
  TablePlanSortHelper.Free;
end;

procedure TThemes.btChoosePreviewTypeClick(Sender: TObject);
var
  PopupPosition: TPoint;
begin
  PopupPosition.X := TButton(sender).Left;
  PopupPosition.Y := TButton(sender).Top + TButton(Sender).Height;
  PopupPosition := clienttoscreen(PopupPosition);
  PreviewTypeMenu.PopupComponent := TComponent(Sender);
  PreviewTypeMenu.Popup(PopupPosition.X, PopupPosition.Y);
end;

procedure TThemes.HandlePreviewTypePopupMenuItem(Sender: TObject);
begin
  TMenuItem(Sender).Checked := True;
  case TMenuItem(Sender).Tag of
    0:
      btChoosePreviewType.Hint := 'Standard preview; no site data included';
    1:
      btChoosePreviewType.Hint := 'Random terminal; use data from random terminal assigned to Panel Design';
    2:
      btChoosePreviewType.Hint := 'Choose terminal; use data from a user-selected terminal';
  end;
end;

procedure TThemes.LoadPreviewType;
var
  PreviewMode: integer;
  i: integer;
begin
  PreviewMode := 0;
  with TRegistry.Create do
  begin
    RootKey := HKEY_CURRENT_USER;
    if OpenKeyReadOnly('Software\Zonal\Aztec\AZTM') then
    begin
      if ValueExists('PreviewMode') then
        PreviewMode := ReadInteger('PreviewMode');
    end;
    Free;
  end;
  for i := 0 to Pred(PreviewTypeMenu.Items.Count) do
  begin
    if PreviewTypeMenu.Items[i].Tag = PreviewMode then
      PreviewTypeMenu.Items[i].Checked := true;
  end;
end;

procedure TThemes.SavePreviewType;
var
  i: integer;
  PreviewMode: integer;
begin
  PreviewMode := 0;
  for i := 0 to Pred(PreviewTypeMenu.Items.Count) do
  begin
    if PreviewTypeMenu.Items[i].Checked then
      PreviewMode := PreviewTypeMenu.Items[i].Tag;
  end;
  with TRegistry.Create do
  begin
    RootKey := HKEY_CURRENT_USER;
    if OpenKey('Software\Zonal\Aztec\AZTM', True) then
    begin
      WriteInteger('PreviewMode', PreviewMode);
    end;
    free;
  end;
end;

procedure TThemes.btMacrosClick(Sender: TObject);
begin
  Log('Edit Macros Clicked');
  CheckCanEdit(dmThemeData.qPanelDesigns);
  DefineMacros := TDefineMacros.Create(nil);
  DefineMacros.PanelDesignID := dmThemeData.qPanelDesigns.FieldByName('PanelDesignID').AsInteger;
  Nav.MoveForward(DefineMacros, True);
end;

procedure TThemes.ShowPreviewManagerUpdate(Sender: TObject);
begin
  TAction(Sender).Checked := PreviewManager.Visible;
end;

procedure TThemes.ShowPreviewManagerExecute(Sender: TObject);
begin
  PreviewManager.Visible := not PreviewManager.Visible;
end;

procedure TThemes.btnDefaultRolePanelClick(Sender: TObject);
begin
  with TEditDefaultJobPanel.Create(nil) do
  try
    with dmThemeData.qPanelDesigns do
         begin
           FPanelDesignID := FieldByName('PanelDesignID').AsInteger;
           FThemeID := dmThemeData.qThemes.FieldByName('ThemeID').AsInteger;
           FPanelName := FieldByName('Name').AsString;
           Log('Default Job Panel opened.');
           if ShowModal = mrOK then
              begin
                Log('Default Job Panel closed.');
              end;
    end;
  finally
    free;
  end;
end;

end.
