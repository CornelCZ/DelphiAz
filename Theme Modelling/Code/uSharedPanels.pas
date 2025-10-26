unit uSharedPanels;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, db, ActnList, Wwdbigrd, Wwdbgrid, uGridSortHelper,
  wwdblook, wwcheckbox, ExtCtrls, uGlobals;

type
  TSharedPanels = class(TForm)
    Label1: TLabel;
    btAddStandard: TButton;
    btEditStandard: TButton;
    btDeleteStandard: TButton;
    btClose: TButton;
    btDesignStandard: TButton;
    Label2: TLabel;
    btCopyStandard: TButton;
    SharedPanelActions: TActionList;
    AddStandard: TAction;
    EditStandard: TAction;
    CopyStandard: TAction;
    DesignStandard: TAction;
    DeleteStandard: TAction;
    CloseForm: TAction;
    btAddVariation: TButton;
    btEditVariation: TButton;
    btDeleteVariation: TButton;
    btDesignVariation: TButton;
    btCopyVariation: TButton;
    AddVariation: TAction;
    EditVariation: TAction;
    CopyVariation: TAction;
    DesignVariation: TAction;
    DeleteVariation: TAction;
    dbgSharedPanels: TwwDBGrid;
    dbgSharedPanelVariations: TwwDBGrid;
    lbDefaultVariation: TLabel;
    cbDefaultVariation: TwwDBLookupCombo;
    imCheck: TImage;
    Bevel1: TBevel;
    Bevel2: TBevel;
    procedure btDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AddStandardExecute(Sender: TObject);
    procedure EditStandardExecute(Sender: TObject);
    procedure DesignStandardExecute(Sender: TObject);
    procedure DeleteStandardExecute(Sender: TObject);
    procedure SharedPanelActionsExecute(Action: TBasicAction;
      var Handled: Boolean);
    procedure CloseFormExecute(Sender: TObject);
    procedure dbgSharedPanelsDblClick(Sender: TObject);
    procedure dbgSharedPanelVariationsDblClick(Sender: TObject);
    procedure DesignVariationExecute(Sender: TObject);
    procedure EditVariationExecute(Sender: TObject);
    procedure DeleteVariationExecute(Sender: TObject);
    procedure CopyStandardExecute(Sender: TObject);
    procedure CopyVariationExecute(Sender: TObject);
    procedure AddVariationExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HandleUpdateEnabledIfNoVariations(Sender: TObject);
    procedure HandleUpdateDisabledIfNoVariations(Sender: TObject);
    procedure cbDefaultVariationChange(Sender: TObject);
    procedure dbgSharedPanelsDrawDataCell(Sender: TObject;
      const Rect: TRect; Field: TField; State: TGridDrawState);
  private
    DoneFirstShow: boolean;
    SharedPanelsSortHelper: TGridSortHelper;
    SharedPanelVariationsSortHelper: TGridSortHelper;
    function PanelInUse(PanelID: integer): boolean;
    function isDefaultPayPanel(PanedlID : integer) : boolean;
    procedure HandleSharedPanelDesignerClose(Sender: TObject);
    procedure HandleSharedPanelVariationDesignerClose(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SharedPanels: TSharedPanels;

implementation

uses uDMThemeData, uEditSharedPanel, uGenerateThemeIDs, uDesignSharedPanel, uAztecLog,
  uEditVariationPanel, uEditGenericDetails, ADODB, uFormNavigate;

{$R *.dfm}

procedure TSharedPanels.btDeleteClick(Sender: TObject);
begin
  ButtonClicked(Sender);
end;

procedure TSharedPanels.FormShow(Sender: TObject);
begin
  Log('Form Show '+ Caption);
  if not DoneFirstShow then
  begin
    dmThemeData.AccessDataset('qSharedPanels');
    dmThemeData.AccessDataset('qSharedPanelVariations');
    dmThemeData.AccessDataset('qSharedPanelDefault');
    dmThemeData.AccessDataset('qDefaultChoices');
    SharedPanelsSortHelper.Reset;
    SharedPanelVariationsSortHelper.Reset;
    DoneFirstShow := true;
  end;
end;

procedure TSharedPanels.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
  dmThemeData.DeAccessDataset('qSharedPanels');
  dmThemeData.DeAccessDataset('qSharedPanelVariations');
  dmThemeData.DeAccessDataset('qSharedPanelDefault');
  dmThemeData.DeAccessDataset('qDefaultChoices');
  DoneFirstShow := false;
  Nav.MoveBack;
end;

procedure TSharedPanels.AddStandardExecute(Sender: TObject);
var
  NewID: int64;
  pd_screenwidth, pd_screenheight, pd_gridoffsetx, pd_gridoffsety : integer;
begin
  with TEditSharedPanel.Create(nil) do
  try
    PanelID := -1;
    Caption := 'Add Shared Panel';

    if ShowModal = mrOk then
    with dmThemeData.qSharedPanels do
    begin
      NewID := uGenerateThemeIDs.GetNewId(scThemePanel);
      Insert;
      TLargeIntField(FieldByName('PanelID')).aslargeint := NewID;
      Log(Format('Adding New Shared Panel ID %d Name - %s',
        [TLargeIntField(FieldByName('PanelID')).AsLargeInt, edName.Text]));

      FieldByName('PanelType').AsInteger := 2;
      FieldByName('Name').AsString := edName.Text;
      FieldByName('Description').AsString := mmDescription.Lines.Text;
      // dummy initialisation to check screen size and if any refactoring is required.
      // proper initialsation of the panel is done later on.
      pd_screenwidth := 1022;
      pd_screenheight := 756;
      pd_gridoffsetx := 1;
      pd_gridoffsety := 6;

      if ((pd_screenwidth+2*pd_gridoffsetx+8) >= Screen.DesktopWidth) or ((pd_screenheight+2*pd_gridoffsety+8) >= Screen.DesktopHeight) then
         begin
          FieldByName('Left').AsFloat := 0.571428571428571 * 0.78125;
          FieldByName('Top').AsFloat := 0.357142857142857 * 0.78125;
         end
      else
         begin
           FieldByName('Left').AsFloat := 0.571428571428571;
           FieldByName('Top').AsFloat := 0.357142857142857;
         end;

      FieldByName('Width').AsInteger := 8;
      FieldByName('Height').AsInteger := 8;
      FieldByName('HideOrderDisplay').AsBoolean := cbHideOrderDisplay.Checked;
      FieldByName('Mod').AsBoolean := cbModPanel.Checked;

      if mmEposName.Lines.Count > 0 then
        FieldByName('EposName1').AsString := mmEposName.Lines[0]
      else
        FieldByName('EposName1').AsString := '';

      if mmEposName.Lines.Count > 1 then
        FieldByName('EposName2').AsString := mmEposName.Lines[1]
      else
        FieldByName('EposName2').AsString := '';

      if mmEposName.Lines.Count > 2 then
        FieldByName('EposName3').AsString := mmEposName.Lines[2]
      else
        FieldByName('EposName3').AsString := '';

      Post;
//      UpdateBatch();
      SharedPanelsSortHelper.Refresh('PanelID');
      if dmThemeData.qSharedPanels.FieldByName('PanelID').AsInteger <> NewID then
        dmThemeData.qSharedPanels.Locate('PanelID', NewID, []);
      Log(Format('New shared panel added Name %s : ID %d',
        [edName.Text, TLargeIntField(FieldByName('PanelID')).AsLargeInt]));
    end;
  finally
    Free;
  end;
end;

procedure TSharedPanels.EditStandardExecute(Sender: TObject);
begin
  if dmThemeData.qSharedPanels.RecordCount = 0 then
    Raise exception.create('Please add some items first!');
  with TEditSharedPanel.create(nil) do try
    with dmThemeData.qSharedPanels do
    begin
      PanelID := FieldByName('PanelID').AsInteger;
      caption := 'Edit Shared Panel';
      edName.text := fieldbyname('Name').asstring;
      mmDescription.Lines.Text := fieldbyname('Description').asstring;
      mmeposname.Lines.Text :=
        fieldbyname('EposName1').asstring + #13+
        fieldbyname('EposName2').asstring + #13+
        fieldbyname('EposName3').asstring;
      cbHideOrderDisplay.Checked := fieldbyname('HideOrderDisplay').AsBoolean;
      cbModPanel.checked := fieldbyname('mod').asboolean;
      if showmodal = mrOk then
      with dmThemeData.qSharedPanels do
      begin
        edit;
        fieldbyname('Name').asstring := edName.text;
        fieldbyname('Description').asstring := mmDescription.lines.Text;
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

        Fieldbyname('HideOrderDisplay').AsBoolean := cbHideOrderDisplay.Checked;
        fieldbyname('Mod').asboolean := cbModPanel.checked;
        post;
        SharedPanelsSortHelper.Refresh('PanelID');
      end;
    end;
  finally
    free;
  end;

end;

procedure TSharedPanels.DesignStandardExecute(Sender: TObject);
var
  DesignSharedPanel: TDesignSharedPanel;
begin
  // This action is called indirectly via a grid double click hander
  // so disable this if the action is disabled.
  if not DesignStandard.Enabled then
    exit;
  if dmThemeData.qSharedPanels.RecordCount = 0 then
    Raise exception.create('Please add some items first!');
  DesignSharedPanel := TDesignSharedPanel.create(nil);
  with DesignSharedPanel do
  try
    screen.cursor := crAppStart;
    loadsharedpanel(TLargeIntField(dmThemeData.qSharedPanels.fieldbyname('PanelID')).aslargeint);
    screen.cursor := crDefault;
    ActionOnClose := HandleSharedPanelDesignerClose;
    Nav.MoveForward(DesignSharedPanel, True);
    //SharedPanelsSortHelper.Refresh('PanelID');
  finally
  end;
end;

procedure TSharedPanels.DeleteStandardExecute(Sender: TObject);
begin
  if dmThemeData.qSharedPanels.RecordCount = 0 then
    Raise exception.create('Please add some items first!');
  //** NB: Table THemePanelsSharedPos has a foreign key on ThemePanels to cascade deletes

  if PanelInUse(dmThemeData.qSharedPanels.FieldByName('PanelID').AsInteger) then
      raise Exception.Create('This Panel is linked to one or more panel designs - the Delete cannot proceed.');

  if isDefaultPayPanel(dmThemeData.qSharedPanels.FieldByName('PanelID').AsInteger) then
      raise Exception.Create('This Panel currently set as a Pay Panel to one or more panel designs - the Delete cannot proceed.');

  if messagedlg(
    format('Are you sure you want to delete Shared Panel "%s"?',
      [dmThemeData.qsharedpanels.fieldbyname('Name').asstring]),
      mtConfirmation, [mbOk, mbCancel], 0) = mrOk then
  begin
    with dmThemeData.adoqRun do
    begin
      Log('Deleting Shared Panel "' + dmThemeData.qSharedPanels.FieldByName('Name').AsString + '", PanelID ' +
          IntToStr(TLargeintfield(dmThemeData.qsharedpanels.fieldbyname('panelid')).aslargeint) +
          ', UserName ' + CurrentUser.UserName);

      sql.text := 'delete from themepanelbutton where '+
        'buttontypechoiceid = ( '+
        'select id from themebuttontypechoicelookup '+
        'where name = ''OpenPanel'') '+
        'and buttontypechoiceattr01 = cast(:panelid as varchar(50))';
      parameters.ParamByName('panelid').value :=
        TLargeintfield(dmThemeData.qsharedpanels.fieldbyname('panelid')).aslargeint;
      execsql;
    end;
    dmThemeData.qSharedPanels.delete;
{    if not(dmThemeData.qSharedPanels.Bof) and not(dmThemeData.qSharedPanels.Eof) then
      dmThemeData.qSharedPanels.Prior; }
    SharedPanelsSortHelper.Refresh('PanelID');
  end;
end;

procedure TSharedPanels.SharedPanelActionsExecute(Action: TBasicAction;
  var Handled: Boolean);
begin
  if Action is TCustomAction then
  Log('User action: ' + TCustomAction(Action).Caption);
end;

procedure TSharedPanels.CloseFormExecute(Sender: TObject);
begin
  dmThemeData.BeginHourglass;
  // This is only run to set defaults for allocations to existing sites
  dmThemeData.AztecConn.Execute('EXEC dbo.Theme_ApplyAnyFutureSiteVariations');
  dmThemeData.qSetDefaultSPPos.ExecSQL;
  dmThemeData.EndHourglass;
  ModalResult := mrOk;
  Close;
end;

procedure TSharedPanels.dbgSharedPanelsDblClick(Sender: TObject);
begin
  DesignStandard.Execute;
end;

procedure TSharedPanels.dbgSharedPanelVariationsDblClick(Sender: TObject);
begin
  DesignVariation.Execute;
end;

procedure TSharedPanels.DesignVariationExecute(Sender: TObject);
var
  DesignSharedPanel: TDesignSharedPanel;
begin
  if dmThemeData.qSharedPanelVariations.RecordCount = 0 then
    Raise exception.create('Please add some items first!');
  DesignSharedPanel := TDesignSharedPanel.create(nil);
  with DesignSharedPanel do
  try
    screen.cursor := crAppStart;
    loadsharedpanel(TLargeIntField(dmThemeData.qSharedPanelVariations.fieldbyname('PanelID')).aslargeint, true);
    screen.cursor := crDefault;
    ActionOnClose := HandleSharedPanelVariationDesignerClose;
    Nav.MoveForward(DesignSharedPanel, True);
  finally
  end;
end;

procedure TSharedPanels.EditVariationExecute(Sender: TObject);
begin
  with TEditVariationPanel.Create(nil) do try
    PanelID := dmThemeData.qSharedPanelVariations.FieldByName('PanelID').AsInteger;
    Caption := 'Edit variation';
    VariationGroup := TLargeIntField(dmThemeData.qSharedPanels.FieldByName('PanelID')).AsLargeInt;
    edName.Text := dmThemeData.qSharedPanelVariations.FieldbyName('Name').AsString;
    mmDescription.Text := dmThemeData.qSharedPanelVariations.FieldbyName('Description').AsString;
    if ShowModal = mrOk then
    begin
      with dmThemeData.qSharedPanelVariations do
      begin
        Edit;
        if cbDefaultVariation.Text = FieldByName('Name').AsString then
          cbDefaultVariation.Text := edName.Text;
        FieldByName('Name').AsString := edName.Text;
        FieldByName('Description').AsString := mmDescription.Text;
        Post;
      end;
    end;
    dmThemeData.qDefaultChoices.Requery;

  finally
    Free;
  end;
end;

procedure TSharedPanels.DeleteVariationExecute(Sender: TObject);
var
  ConfirmationMessage: string;
  RevertToShared: boolean;
begin
  if dmThemeData.qSharedPanelVariations.RecordCount = 0 then
    Raise exception.create('Please add some items first!');

  with dmThemeData.adoqRun do
  begin
    SQL.Text := Format('select sum(count) as Result from ( '+
      'select count(*) as count from ThemeSiteVariation join ThemeSites on ThemeSiteVariation.SiteCode = ThemeSites.SiteCode where VariationPanelID = %d '+
      ') sub', [dmThemeData.qSharedPanelVariations.fieldbyname('PanelID').AsInteger,
        dmThemeData.qSharedPanelVariations.fieldbyname('PanelID').AsInteger]);
    Open;
    if FieldByName('Result').AsInteger > 0 then
    begin
      Close;
      raise Exception.Create('This Variation Panel is assigned to sites - the Delete cannot proceed.');
    end;
    Close;
  end;

  if isDefaultPayPanel(dmThemeData.qSharedPanelVariations.FieldByName('PanelID').AsInteger) then
      raise Exception.Create('This Variation Panel currently set as a Pay Panel to one or more panel designs - the Delete cannot proceed.');

  RevertToShared := dmThemeData.qSharedPanelVariations.RecordCount = 1;

  // Suppress this prompt if in shared panel=variation mode.
  if RevertToShared then
    ConfirmationMessage := Format(
      'Deleting the last variation will revert this Variation Group to be a global Shared Panel.'#13#10+
      'Are you sure you want to delete Panel Variation "%s"?',
      [dmThemeData.qSharedPanelVariations.fieldbyname('Name').AsString])
  else
    ConfirmationMessage := Format('Are you sure you want to delete Panel Variation "%s"?',
      [dmThemeData.qSharedPanelVariations.fieldbyname('Name').AsString]);

  if MessageDlg(ConfirmationMessage, mtConfirmation, [mbOk, mbCancel], 0) = mrOk then
  begin
    Log('Deleting Panel Variation ' + IntToStr(TLargeintfield(dmThemeData.qSharedPanelVariations.fieldbyname('panelid')).aslargeint));
    with dmThemeData.adoqRun do
    begin
      if dmThemeData.qSharedPanelDefault.FieldByName('defaultvariationpanelid').AsInteger =
        TLargeintfield(dmThemeData.qSharedPanelVariations.fieldbyname('panelid')).asinteger then
      begin
        // This variation is the default, set the default to "N/a"
        SQL.Text := Format(
          'update ThemePanelVariationGroup set DefaultVariationPanelID = -1 where PanelID = %d ',
          [TLargeIntField(dmThemeData.qSharedPanels.FieldByName('PanelID')).asinteger]);
        ExecSQL;
        dmThemeData.qSharedPanelDefault.Requery();
      end;
    end;
    // Delete the variation via recordset
    dmThemeData.qSharedPanelVariations.delete;

    if RevertToShared then
    begin
      with dmThemeData.adoqRun do
      begin
        SQL.Text := Format('DELETE ThemePanelVariationGroup WHERE PanelID = %d', [dmThemeData.qSharedPanels.FieldByName('PanelID').AsInteger]);
        ExecSQL;
        SQL.Text := Format('DELETE ThemeSiteVariation WHERE PanelID = %d', [dmThemeData.qSharedPanels.FieldByName('PanelID').AsInteger]);
        ExecSQL;
      end;
      SharedPanelsSortHelper.Refresh;
    end;
    dmThemeData.qDefaultChoices.Requery;
  end;
end;

procedure TSharedPanels.CopyStandardExecute(Sender: TObject);
var
  OldID, NewID: int64;
  TmpLeft, TmpTop, TmpWidth, TmpHeight: double;
begin
  if dmThemeData.qSharedPanels.RecordCount = 0 then
    Raise exception.create('Please pick an item to copy first!');

  with TEditSharedPanel.Create(nil) do
  try
    PanelID := -1;
    Caption := 'Copy Shared Panel';

    with dmThemeData.qSharedPanels do
    begin
      OldID := TLargeIntField(FieldByName('PanelID')).AsLargeInt;
      edName.text := fieldbyname('Name').asstring;
      mmDescription.Lines.Text := fieldbyname('Description').asstring;
      mmeposname.Lines.Text :=
        fieldbyname('EposName1').asstring + #13+
        fieldbyname('EposName2').asstring + #13+
        fieldbyname('EposName3').asstring;
      cbHideOrderDisplay.Checked := fieldbyname('HideOrderDisplay').AsBoolean;
      cbModPanel.checked := fieldbyname('mod').asboolean;
      TmpLeft := fieldbyname('Left').Asfloat;
      TmpTop := fieldbyname('Top').Asfloat;
      TmpWidth := fieldbyname('Width').Asfloat;
      TmpHeight := fieldbyname('Height').Asfloat;
    end;

    if ShowModal = mrOk then
    with dmThemeData.qSharedPanels do
    begin
      Insert;
      NewID := uGenerateThemeIDs.GetNewId(scThemePanel);
      TLargeIntField(FieldByName('PanelID')).aslargeint := NewID;
      Log(Format('Adding New Shared Panel ID %d Name - %s',
        [TLargeIntField(FieldByName('PanelID')).AsLargeInt, edName.Text]));

      FieldByName('PanelType').AsInteger := 2;
      FieldByName('Name').AsString := edName.Text;
      FieldByName('Description').AsString := mmDescription.Lines.Text;
      FieldByName('Left').AsFloat := TmpLeft;
      FieldByName('Top').AsFloat := TmpTop;
      FieldByName('Width').AsFloat := TmpWidth;
      FieldByName('Height').AsFloat := TmpHeight;
      FieldByName('HideOrderDisplay').AsBoolean := cbHideOrderDisplay.Checked;
      FieldByName('Mod').AsBoolean := cbModPanel.Checked;

      if mmEposName.Lines.Count > 0 then
        FieldByName('EposName1').AsString := mmEposName.Lines[0]
      else
        FieldByName('EposName1').AsString := '';

      if mmEposName.Lines.Count > 1 then
        FieldByName('EposName2').AsString := mmEposName.Lines[1]
      else
        FieldByName('EposName2').AsString := '';

      if mmEposName.Lines.Count > 2 then
        FieldByName('EposName3').AsString := mmEposName.Lines[2]
      else
        FieldByName('EposName3').AsString := '';

      Post;
      dmThemeData.AztecConn.Execute(Format('EXEC dbo.Theme_Copy_Panel_Contents %d, %d', [OldID, NewID]));
      Log(Format('New shared panel copied Name %s : ID %d',
        [edName.Text, TLargeIntField(FieldByName('PanelID')).AsLargeInt]));
      SharedPanelsSortHelper.Refresh('PanelID');
    end;
  finally
    Free;
  end;
end;

procedure TSharedPanels.CopyVariationExecute(Sender: TObject);
var
  OldID, NewID: int64;
  TmpLeft, TmpTop, TmpWidth, TmpHeight: integer;
begin
  if dmThemeData.qSharedPanelVariations.RecordCount = 0 then
    Raise exception.create('Please pick an item to copy first!');

  with TEditVariationPanel.Create(nil) do
  try
    PanelID := -1;
    Caption := 'Copy Panel Variation';
    VariationGroup := TLargeIntField(dmThemeData.qSharedPanels.FieldByName('PanelID')).AsLargeInt;

    with dmThemeData.qSharedPanelVariations do
    begin
      OldID := TLargeIntField(FieldByName('PanelID')).AsLargeInt;
      with dmThemeData.adoqrun do
      begin
        SQL.Text :=
          Format('select * from ThemePanel where PanelID = %d', [OldID]);
        Open;
        edName.text := fieldbyname('Name').asstring;
        mmDescription.Lines.Text := fieldbyname('Description').asstring;
        TmpLeft := fieldbyname('Left').AsInteger;
        TmpTop := fieldbyname('Top').AsInteger;
        TmpWidth := fieldbyname('Width').AsInteger;
        TmpHeight := fieldbyname('Height').AsInteger;
        Close;
      end;
    end;

    if ShowModal = mrOk then
    with dmThemeData.qSharedPanelVariations do
    begin
      Insert;
      NewID := uGenerateThemeIDs.GetNewId(scThemePanel);
      TLargeIntField(FieldByName('PanelID')).aslargeint := NewID;
      Log(Format('Adding New Shared Panel ID %d Name - %s',
        [TLargeIntField(FieldByName('PanelID')).AsLargeInt, edName.Text]));

      FieldByName('PanelType').AsInteger := 6;
      FieldByName('Name').AsString := edName.Text;
      FieldByName('Description').AsString := mmDescription.Lines.Text;
      FieldByName('Left').AsFloat := TmpLeft;
      FieldByName('Top').AsFloat := TmpTop;
      FieldByName('Width').AsInteger := TmpWidth;
      FieldByName('Height').AsInteger := TmpHeight;

      Post;
      dmThemeData.AztecConn.Execute(Format('EXEC dbo.Theme_Copy_Panel_Contents %d, %d', [OldID, NewID]));
      // Create ThemePanelVariation record
      with dmThemeData.adoqrun do
      begin
        SQL.Text := Format(
          'INSERT ThemePanelVariation SELECT %d, %d', [dmThemeData.qSharedPanels.FieldByName('PanelID').AsInteger, NewID]
        );
        ExecSql;
      end;
      Log(Format('New variation panel copied Name %s : ID %d',
        [edName.Text, TLargeIntField(FieldByName('PanelID')).AsLargeInt]));
    end;
    dmThemeData.qDefaultChoices.Requery;
  finally
    Free;
  end;
end;


procedure TSharedPanels.AddVariationExecute(Sender: TObject);
var
  OldID, NewID: int64;
  TmpLeft, TmpTop, TmpWidth, TmpHeight: integer;
  ConvertToGroup: boolean;
begin
  with TEditVariationPanel.Create(nil) do
  try
    PanelID := -1;
    Caption := 'Add Panel Variation';
    VariationGroup := TLargeIntField(dmThemeData.qSharedPanels.FieldByName('PanelID')).AsLargeInt;

    ConvertToGroup := not (dmThemeData.qSharedPanelVariations.RecordCount > 0);
    if (dmThemeData.qSharedPanelVariations.RecordCount > 0) then
    with dmThemeData.qSharedPanelVariations do
    begin
      OldID := TLargeIntField(FieldByName('PanelID')).AsLargeInt;
      with dmThemeData.adoqrun do
      begin
        SQL.Text :=
          Format('select * from ThemePanel where PanelID = %d', [OldID]);
        Open;
        edName.text := fieldbyname('Name').asstring;
        mmDescription.Lines.Text := fieldbyname('Description').asstring;
        TmpLeft := fieldbyname('Left').AsInteger;
        TmpTop := fieldbyname('Top').AsInteger;
        TmpWidth := fieldbyname('Width').AsInteger;
        TmpHeight := fieldbyname('Height').AsInteger;
        Close;
      end;
    end
    else
    with dmThemeData.qSharedPanels do
    begin
      OldID := TLargeIntField(FieldByName('PanelID')).AsLargeInt;
      with dmThemeData.adoqrun do
      begin
        SQL.Text :=
          Format('select * from ThemePanel where PanelID = %d', [OldID]);
        Open;
        edName.text := fieldbyname('Name').asstring;
        mmDescription.Lines.Text := fieldbyname('Description').asstring;
        TmpLeft := fieldbyname('Left').AsInteger;
        TmpTop := fieldbyname('Top').AsInteger;
        TmpWidth := fieldbyname('Width').AsInteger;
        TmpHeight := fieldbyname('Height').AsInteger;
        Close;
      end;
    end;

    if ConvertToGroup then
    begin
      dmThemeData.ADOqRun.SQL.Text := Format(
        'select count(*) as Result '+
        'from ThemePanel where PanelType = 2 and PanelID <> %d and Name = %s ',
        [OldID, QuotedStr(edName.Text)]);
      dmThemeData.ADOqRun.Open;
      if dmThemeData.ADOqRun.FieldByName('Result').AsInteger > 0 then
      begin
        dmThemeData.ADOqRun.Close;
        raise Exception.Create('This Shared Panel''s name is in use by other Shared Panels/Variation Groups'+#13+
          'Please correct this before adding variations.');
      end;
      dmThemeData.ADOqRun.Close;
    end;

    if ShowModal = mrOk then
    with dmThemeData.qSharedPanelVariations do
    begin
      Insert;
      NewID := uGenerateThemeIDs.GetNewId(scThemePanel);
      TLargeIntField(FieldByName('PanelID')).aslargeint := NewID;
      Log(Format('Adding New Shared Panel ID %d Name - %s',
        [TLargeIntField(FieldByName('PanelID')).AsLargeInt, edName.Text]));

      FieldByName('PanelType').AsInteger := 6;
      FieldByName('Name').AsString := edName.Text;
      FieldByName('Description').AsString := mmDescription.Lines.Text;
      FieldByName('Left').AsFloat := TmpLeft;
      FieldByName('Top').AsFloat := TmpTop;
      FieldByName('Width').AsInteger := TmpWidth;
      FieldByName('Height').AsInteger := TmpHeight;

      Post;
      // TODO: Copy panel contents needs to copy site panels.
      dmThemeData.AztecConn.Execute(Format('EXEC dbo.Theme_Copy_Panel_Contents %d, %d', [OldID, NewID]));

      if ConvertToGroup then
      begin
        with dmThemeData.adoqRun do
        begin
          if PanelInUse(dmThemeData.qSharedPanels.FieldByName('PanelID').AsInteger) then
            SQL.Text := Format('INSERT ThemePanelVariationGroup SELECT %d, %d', [dmThemeData.qSharedPanels.FieldByName('PanelID').AsInteger, NewID])
          else
            SQL.Text := Format('INSERT ThemePanelVariationGroup SELECT %d, -1', [dmThemeData.qSharedPanels.FieldByName('PanelID').AsInteger]);
          ExecSQL;
        end;
      end;

      // Create ThemePanelVariation record
      with dmThemeData.adoqrun do
      begin
        SQL.Text := Format(
          'INSERT ThemePanelVariation SELECT %d, %d', [dmThemeData.qSharedPanels.FieldByName('PanelID').AsInteger, NewID]
        );
        ExecSql;
      end;

      if ConvertToGroup then
      begin
        SharedPanelsSortHelper.Refresh;
      end;

      Log(Format('New variation panel added Name %s : ID %d',
        [edName.Text, TLargeIntField(FieldByName('PanelID')).AsLargeInt]));
    end;
    dmThemeData.qDefaultChoices.Requery;
  finally
    Free;
  end;
end;

procedure TSharedPanels.FormCreate(Sender: TObject);
begin
  SharedPanelsSortHelper := TGridSortHelper.Create;
  SharedPanelsSortHelper.Initialise(dbgSharedPanels);
  SharedPanelVariationsSortHelper := TGridSortHelper.Create;
  SharedPanelVariationsSortHelper.Initialise(dbgSharedPanelVariations);
end;

procedure TSharedPanels.FormDestroy(Sender: TObject);
begin
  SharedPanelsSortHelper.Free;
  SharedPanelVariationsSortHelper.Free;
end;

procedure TSharedPanels.HandleUpdateEnabledIfNoVariations(Sender: TObject);
begin
  TAction(Sender).Enabled := (dmThemeData.qSharedPanelVariations.RecordCount = 0);
end;

procedure TSharedPanels.HandleUpdateDisabledIfNoVariations(Sender: TObject);
begin
  TAction(Sender).Enabled := dmThemeData.qSharedPanelVariations.RecordCount <> 0;
  cbDefaultVariation.Enabled := dmThemeData.qSharedPanelVariations.RecordCount <> 0;
  lbDefaultVariation.Enabled := dmThemeData.qSharedPanelVariations.RecordCount <> 0;
end;

procedure TSharedPanels.cbDefaultVariationChange(Sender: TObject);
begin
  if TwwDBLookupCombo(Sender).Datasource.Dataset.State = dsEdit then
    TwwDBLookupCombo(Sender).Datasource.Dataset.Post;
end;

procedure TSharedPanels.dbgSharedPanelsDrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
var
  GlyphRect, TmpRect: TRect;
  GlyphBitmap: TBitmap;
begin
  if Field.FieldName = 'VariationGroup' then
  begin
    TwwDBGrid(Sender).Canvas.Pen.Style := psClear;
    TwwDBGrid(Sender).Canvas.Rectangle(Rect);
    TwwDBGrid(Sender).Canvas.Pen.Style := psSolid;
    if Field.AsBoolean then
    with TwwdbGrid(sender) do
    begin
      GlyphRect := imCheck.Picture.Bitmap.Canvas.ClipRect;
      Glyphbitmap := imCheck.Picture.Bitmap;

      TmpRect := Rect;
      TmpRect.Left := TmpRect.Left + 5;
      TmpRect.Top := TmpRect.top +  (
        (tmprect.Bottom - tmprect.Top) -
        (GlyphRect.Bottom - GlyphRect.Top)
      ) div 2;

      TmpRect.Top := TmpRect.Top + 1;
      TmpRect.Left := TmpRect.left - 2;

      TmpRect.Right := TmpRect.Left + (GlyphRect.Right - GlyphRect.Left);
      TmpRect.Bottom := TmpRect.Top + (GlyphRect.Bottom - GlyphRect.Top);
      Canvas.BrushCopy(TmpRect, GlyphBitmap, GlyphRect, clAqua);
    end;
  end;
end;

function TSharedPanels.PanelInUse(PanelID: integer): boolean;
begin
  with TADOQuery.Create(nil) do try
    Connection := dmThemeData.AztecConn;
    // recurse up from all "openpanel" references until a local panel is found to be referencing it
    // therefore a theme references it. We don't care even if the paneldesign is not assigned to anything.

    // TODO: Generalise this "inverse recursion with variations" to a stored procedure
    //   It doesn't require complicated modes of operation as it implicitly checks all variations
    SQL.Text := Format(
      'declare @panelheap table (panelid int, paneltype int) '+
      'declare @foundcount int '+
      'declare @localpanelfound bit '+
      'set @localpanelfound = 0 '+
      'set @foundcount = 1 '+
      ' '+
      'insert @panelheap (panelid, paneltype) '+
      'select distinct themepanel.panelid, themepanel.paneltype '+
      'from themepanelbutton '+
      'join themepanel on themepanelbutton.panelid = themepanel.panelid '+
      'where buttontypechoiceattr01 = ''%d'' '+
      'and buttontypechoiceid = (select id from themebuttontypechoicelookup where name=''openpanel'') '+
      ' '+
      'while @foundcount <> 0 '+
      'begin '+
      ' '+
      '  insert @panelheap select distinct panelid, 2 from ThemePanelVariation '+
      '  where variationpanelid in (select panelid from @panelheap) '+
      '  and panelid not in (select panelid from @panelheap) '+
      ' '+
      '  insert @panelheap (panelid, paneltype) '+
      '  select distinct themepanel.panelid, themepanel.paneltype '+
      '  from themepanelbutton '+
      '  join themepanel on themepanelbutton.panelid = themepanel.panelid '+
      '  join @panelheap a on themepanelbutton.buttontypechoiceattr01 = cast(a.panelid as varchar(50)) '+
      '  where buttontypechoiceid = (select id from themebuttontypechoicelookup where name=''openpanel'') '+
      '  and themepanel.panelid not in (select panelid from @panelheap) '+
      '  set @foundcount = @@rowcount '+
      '  if exists(select * from @panelheap where paneltype = 3) '+
      '  begin '+
      '    set @foundcount = 0 '+
      '    set @localpanelfound = 1 '+
      '  end '+
      'end '+
      'select @localpanelfound as Result', [PanelID]);
    Open;
    Result := FieldByName('Result').AsBoolean;
    Close;
  finally
    Free;
  end;
end;

procedure TSharedPanels.HandleSharedPanelDesignerClose(Sender: TObject);
begin
  SharedPanelsSortHelper.Refresh('PanelID');
end;

procedure TSharedPanels.HandleSharedPanelVariationDesignerClose(
  Sender: TObject);
begin
  SharedPanelVariationsSortHelper.Refresh();
end;

function TSharedPanels.isDefaultPayPanel(PanedlID : integer) : boolean;
begin
  result := False;

  with dmThemeData.adoqRun do
  begin
    SQL.Text := Format('SELECT * FROM ThemePanelDesign WHERE DefaultPay = %d ', [PanedlID]);
    Open;
    if RecordCount > 0 then
        Result := True;
  end;

end;

end.
