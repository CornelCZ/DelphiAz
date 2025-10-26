unit uEditPanelDesign;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB,
  uTillButton, ExtCtrls, ActnList, ActnMan, ToolWin, ActnCtrls, ImgList,
  ComCtrls;

type
  TInt64Obj = class(TObject)
  public
    value: int64;
    constructor create(value: int64);
  end;
  TEditPanelDesign = class(TForm)
    pnToolBar: TPanel;
    ImageList1: TImageList;
    Panel2: TPanel;
    ActionManager1: TActionManager;
    SavePanel: TAction;
    RevertPanel: TAction;
    NewPanel: TAction;
    DeletePanel: TAction;
    ShowPicker: TAction;
    PanelProperties: TAction;
    ADOStoredProc1: TADOStoredProc;
    ADOStoredProc2: TADOStoredProc;
    ADOStoredProc2PanelID: TLargeintField;
    ADOStoredProc2PanelType: TWordField;
    ADOStoredProc2PanelName: TStringField;
    ADOStoredProc2Left: TSmallintField;
    ADOStoredProc2Right: TSmallintField;
    ADOStoredProc2Top: TSmallintField;
    ADOStoredProc2Bottom: TSmallintField;
    ADOStoredProc3: TADOStoredProc;
    SharedPanels: TAction;
    btClose: TButton;
    Panel1: TPanel;
    cbPickPanel: TComboBox;
    Label1: TLabel;
    PageScroller1: TPageScroller;
    ActionToolBar1: TActionToolBar;
    procedure FormCreate(Sender: TObject);
    procedure cbPickPanelChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SavePanelExecute(Sender: TObject);
    procedure RevertPanelExecute(Sender: TObject);
    procedure NewPanelExecute(Sender: TObject);
    procedure DeletePanelExecute(Sender: TObject);
    procedure ShowPickerExecute(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure SavePanelUpdate(Sender: TObject);
    procedure RevertPanelUpdate(Sender: TObject);
    procedure PanelPropertiesExecute(Sender: TObject);
    procedure ActionManager1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure SharedPanelsExecute(Sender: TObject);
    procedure ActionToolBar1DblClick(Sender: TObject);
    procedure SharedPanelsUpdate(Sender: TObject);
    procedure NewPanelUpdate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbPickPanelCloseUp(Sender: TObject);
  private
    current_panel_design: integer;
    procedure CheckSaveChanges;
    function ValidOrderDisplayDims: Boolean;
    procedure CanAddOpenPanelButton(SharedPanelReferrer: TTillObject; Adding : Boolean);
    function ValidCorrectionPanelDims: Boolean;
   { Private declarations }
  public
    PanelManager: TPanelManager;
    { Public declarations }
    procedure OnObjectDblClick(obj: TTillObject);
    procedure OnObjectContextEvent(obj: TTillObject);
    procedure LoadPanelDesign(paneldesignid: integer);
  end;

var
  EditPanelDesign: TEditPanelDesign;

implementation

uses uDMThemeData, uButtonPicker, uTillButtonEditor, uTillLabelEditor,
  uGenerateThemeIDs, uTillPanelEditor, uStdGrid, dADOAbstract, uValidateSubPanels,
  uThemeModellingMenu, uEditDialogs, uTillSubPanelEditor, uAztecLog, uEditOrderDisplay,
  uGlobals, uThemes, uFormNavigate;


{$R *.dfm}

procedure TEditPanelDesign.OnObjectContextEvent(obj: TTillObject);
var
  Pos: Tpoint;
begin
  GetCursorPos(Pos);
  if ((panelmanager.selectedobject is TTillButton) and
    (TTillButton(panelmanager.selectedobject).drawtype = tbdtButton)) or (PanelManager.SelectedObject is TMultiItemSelection) then
    PanelManager.BackdropMenu.Popup(Pos.x, Pos.y);
end;

procedure TEditPanelDesign.OnObjectDblClick(obj: TTillObject);
var
  t1, t2, t3: byte;
  tempGraphicID : integer;
// AK PM303
  EditChoiceSelected:Boolean;
  NeedToValidateIncludedSharedPanels: Boolean;
//  s:TSize;
begin
  if obj is TTillLabel then
  begin
    with TTillLabelEditor.create(self) do try
      edLabel.text := TTillLabel(Panelmanager.selectedobject).Text;
      edFGColour.color := MakeColour(
        TTillLabel(Panelmanager.selectedobject).FGColourRed,
        TTillLabel(Panelmanager.selectedobject).FGColourGreen,
        TTillLabel(Panelmanager.selectedobject).FGColourBlue
      );
      edBGColour.color := MakeColour(
        TTillLabel(Panelmanager.selectedobject).BGColourRed,
        TTillLabel(Panelmanager.selectedobject).BGColourGreen,
        TTillLabel(Panelmanager.selectedobject).BGColourBlue
      );
      cbLargeFont.Checked := TTillLabel(Panelmanager.SelectedObject).FontID = 0;
      if showmodal = mrOk then
      begin
        TTillLabel(Panelmanager.selectedobject).Text := edLabel.text;
        splitcolour(edFGColour.color, t1, t2, t3);
        TTillLabel(Panelmanager.SelectedObject).FGColourRed := t1;
        TTillLabel(Panelmanager.SelectedObject).FGColourGreen := t2;
        TTillLabel(Panelmanager.SelectedObject).FGColourBlue := t3;
        splitcolour(edBGColour.color, t1, t2, t3);
        TTillLabel(Panelmanager.SelectedObject).BGColourRed := t1;
        TTillLabel(Panelmanager.SelectedObject).BGColourGreen := t2;
        TTillLabel(Panelmanager.SelectedObject).BGColourBlue := t3;
        TTillLabel(Panelmanager.SelectedObject).Invalidate;
        if cbLargeFont.Checked then
          TTillLabel(Panelmanager.SelectedObject).FontID := 0
        else
          TTillLabel(Panelmanager.SelectedObject).FontID := 1;
      end;
    finally
      free;
    end;
  end else
  if obj is TTillButton then
  begin
    with TTillButtonEditor.create(self) do
    try
      LoadData(TTillButton(obj));
      cbDefault.Caption := 'Default Correction Method';
      EditChoiceSelected := FALSE;
      if TTillButton(Panelmanager.selectedobject).IsCorrectionMethod then
      begin
        cbDefault.Visible := True;
        cbDefault.Enabled := True;
        if TTillButton(Panelmanager.selectedobject).ButtonTypeData = IntToStr(PanelManager.DefaultcorrectionMethod) then
        begin
          cbDefault.Checked := True;
          cbDefault.Enabled := False;
        end
// AK PM303
        else
          if TTillbutton(obj).ButtonTypeID = EditChoiceFunctionID then
          begin
            cbDefault.Checked := PanelManager.OnByDefault;
            cbDefault.Caption := 'On by default';
            EditChoiceSelected := TRUE;
//            GetTextExtentPoint32(Canvas.Handle,PChar(cbDefault.Caption),Length(cbDefault.Caption) + 8,s);
//            cbDefault.Width := s.cx;
          end
      end
      else
      begin
        cbDefault.Visible := False;
        cbDefault.Checked := False;
      end;
      if showmodal = mrOk then
      begin
        SaveData(TTillButton(obj));
// AK PM303
        if EditChoiceSelected then
          PanelManager.OnByDefault := cbDefault.Checked
        else
          if cbDefault.Checked then
            PanelManager.DefaultCorrectionMethod := StrToInt(TTillButton(Panelmanager.selectedobject).ButtonTypeData);
      end;
    finally
      free;
    end;
  end
  else if obj is TTillSubPanel then
  begin
    with TTillSubPanelEditor.create(self) do
    begin
      SubPanel := TTillSubPanel(obj);
      LoadData;
      if showmodal = mrOk then
      begin
        SaveData;
        with dmThemeData.adoqRun do
        begin
          SQL.Text := Format(
            'declare @PanelDesignID int '+
            'declare @PanelID int '+
            'set @PanelDesignID = %d '+
            'set @PanelID = %d '+
            'exec theme_implicitsharedpanels @PanelDesignID, @PanelID ',
            [PanelManager.PanelDesign, SubPanel.SubPanelID]);
          Open;
          NeedToValidateIncludedSharedPanels := PanelManager.InvalidPanelPositionsInSubPanel(dmThemeData.adoqRun);
          Close;
        end;

        if NeedToValidateIncludedSharedPanels then
        with TfrmSubPanelValidate.Create(self) do
        begin
          AddingSubPanelItem := true;
          FPanelManager := PanelManager;
          FObject := TTillObject(PanelManager.SelectedObject);
          Init;
          AddingPanel := false;
          Show; //** cant be shown modally as user needs to interact with panel manager
        end;
      end;
    end;
  end
  else if obj is TTillHeader then
  begin
    with (obj as TTillHeader) do
    begin
      if HeaderType = 'OrderDisplay' then
      begin
        tempGraphicID := GraphicID;
        EditOrderDisplay(tempGraphicID);
        (obj as TTillHeader).GraphicID := tempGraphicID;
      end;
    end;
  end;
end;

procedure TEditPanelDesign.LoadPanelDesign(paneldesignid: integer);
var
  i: integer;
  rootpanel: int64;
  rootname: string;
begin
  with dmThemeData.adoqRun do
  begin
    sql.text := format('select * from themepaneldesign a '+
      'join themepaneldesigntype b on a.paneldesigntype = b.paneldesigntypeid  and a.ScreenInterfaceID = b.ScreenInterfaceID '+
      'where paneldesignid = %d ',
      [paneldesignid]);
    open;
    PanelManager.pd.LoadFromDataSet(dmThemeData.adoqRun);

    clientwidth := panelmanager.pd.screenwidth + (2 * panelmanager.pd.gridoffsetx);
    clientheight := panelmanager.pd.screenheight + (2 * panelmanager.pd.gridoffsety) + pnToolbar.height;
    buttonpicker.current_theme := fieldbyname('themeid').asinteger;
    buttonpicker.current_design_type := 3;
    buttonpicker.current_panel_design := fieldbyname('PanelDesignID').asinteger;
    self.current_panel_design := fieldbyname('PanelDesignID').asinteger;
    PanelManager.PanelDesign := self.current_panel_design;
    PanelManager.ScreenInterfaceID := FieldByName('ScreenInterfaceID').AsInteger;
    close;
    for i := 0 to pred(cbPickPanel.items.count) do
      cbPickPanel.Items.Objects[i].Free;
    cbPickPanel.items.clear;
    sql.Text := format('select root from themepaneldesign where paneldesignid = %d', [paneldesignid]);
    open;
    rootpanel := TLargeIntField(fieldbyname('root')).aslargeint;
    sql.Text := format('select name from themepanel where panelid = %d', [rootpanel]);
    open;
    rootname := fieldbyname('name').asstring;;
    sql.text := format('select * from themepanel where paneltype = 3 and paneldesignid = %d and panelid <> %d order by name', [paneldesignid, rootpanel]);
    open;
    cbPickPanel.Items.addobject(rootname, TInt64Obj.create(rootpanel));
    while not EOF do
    begin
      cbPickPanel.Items.addobject(fieldbyname('Name').asstring, TInt64Obj.create(TLargeIntField(fieldbyname('PanelID')).aslargeint));
      next;
    end;
    close;
  end;
  panelmanager.DetailsModified := false;
  panelmanager.PanelModified := false;
  ReadDynamicLookups(dmThemeData.AztecConn, false, TInt64Obj(cbPickPanel.Items.Objects[0]).value);
  cbPickPanel.ItemIndex := 0;
  cbPickPanel.OnChange(cbPickPanel);
  // refresh the button picker and clear
  ButtonPicker.ButtonMenuCloseUp;
end;

procedure TEditPanelDesign.CanAddOpenPanelButton(SharedPanelReferrer: TTillObject; Adding : Boolean);
begin
  with TAdoQuery.Create(Self) do try
    connection := dmThemeData.AztecConn;
    if (SharedPanelReferrer is TTillButton) then
    begin
      SQL.Text := 'Select PanelType From ThemePanel Where PanelID = ' + TTillButton(SharedPanelReferrer).ButtonTypeData;
      Open;
      if FieldByName('PanelType').AsInteger = 2 then //** Adding a shared Panel go Nuts.
      begin
        if Adding then
        begin
          with TfrmSubPanelValidate.Create(self) do
          begin
            FPanelManager := PanelManager;
            FObject := SharedPanelReferrer;
            Init;
            AddingPanel := true;
            Show; //** cant be shown modally as user needs to interact with panel manager
          end;
        end
        else
          PanelManager.EnableSharedPanelEdit := True;
        //** The Only control that can have focus until this is added or removed is the SharedPanelOulineObject
      end;
    end
    else
    begin
      // Check if sub panel contains some shared panels
      SQL.Text := Format(
        'exec Theme_ImplicitSharedPanels %d, %d', [
        PanelManager.PanelDesign,
        TTillSubPanel(SharedPanelReferrer).SubPanelID]
      );
      Open;
      PanelManager.EnableSharedPanelEdit := RecordCount > 0;
      Close;
    end;
  finally
    Free;
  end;
{
  ADOStoredProc3.Parameters[1].Value := PanelManager.PanelID;
  ADOStoredProc3.Parameters[2].Value := StrToInt(PanelID);
  ADOStoredProc3.ExecProc;
  CanAdd := ADOStoredProc3.Parameters[0].Value = 1;
}
end;

//------------------------------------------------------------------------------
procedure TEditPanelDesign.FormCreate(Sender: TObject);
begin
  ReadFixedLookups(dmThemeData.AztecConn);
  if not assigned(panelmanager) then
    panelmanager := TPanelManager.create(self);
  //ReadDynamicLookups(dmThemeData.AztecConn);
  with panelmanager do
  begin
    pd.LoadFromValues(64, 48, 640, 480, 0, 0);
    ObjectContextEvent := OnObjectContextEvent;
    ObjectDblClickEvent := OnObjectDblClick;
    OnAddOpenPanelButton := CanAddOpenPanelButton;
  end;
end;

{ TInt64Obj }

constructor TInt64Obj.create(value: int64);
begin
  self.value := value;
end;

procedure TEditPanelDesign.cbPickPanelChange(Sender: TObject);
var
  panel_id: int64;
  panelDesignType: integer;
begin
  CheckSaveChanges;
  with TCombobox(sender) do
  begin
    if itemindex >= 0 then
    begin
      panel_id := TInt64Obj(items.objects[itemindex]).value;
      PanelManager.LoadPanel(dmThemeData.AztecConn, panel_id);

      if dmThemeData.IsForcedSelectionPanel(panel_id) then
      begin
        PanelManager.ForcedSelectionPanel := true;

        Log('Button Picker mode = ForcedSelection');
        buttonpicker.Mode := bpmForcedSelection;

        with TADOQuery.create(nil) do try
          connection := dmthemedata.AztecConn;

          sql.text := format('select paneldesigntype from themepaneldesign '+
            ' where paneldesignid = %d and screeninterfaceid = %d', [PanelManager.PanelDesign, PanelManager.ScreenInterfaceID]);

          open;
          panelDesignType := fieldbyname('paneldesigntype').AsInteger;
          close;
        finally
          free;
        end;

        if panelDesignType = 3 then
        begin  // for Handhelds min size = max size, i.e. fixed size
          PanelManager.MinWidthInButtons := 6;
          PanelManager.MinHeightInButtons := 10;
        end
        else
        begin
          PanelManager.MinWidthInButtons := 6;
          PanelManager.MinHeightInButtons := 5;
        end;

      end
      else
      begin
        PanelManager.ForcedSelectionPanel := false;
        
        PanelManager.MinWidthInButtons := 1;
        PanelManager.MinHeightInButtons := 1;

        Log('Button Picker mode = Normal');
        buttonpicker.Mode := bpmNormal;
      end;
    end;
  end;
end;

procedure TEditPanelDesign.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
  if Assigned(Application.FindComponent('EditDialogs')) then
    TForm(Application.FindComponent('EditDialogs')).Release;
  with dmThemeData do
  begin
    StoreMetrics(buttonpicker, false);
    StoreMetrics(self, true);
  end;
  buttonpicker.Hide;
  Nav.MoveBack;
end;

procedure TEditPanelDesign.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption); 
  with dmThemeData do
  begin
    if not GetStoredMetrics(self, true, uDMThemeData.sttCentreScreen) then
    begin
      top := (screen.Height - height) div 2 ;
      left := (screen.Width - width) div 2 ;
    end;
    if not GetStoredMetrics(ButtonPicker, false, self, uDMThemeData.sttLeftRight) then
    begin
      ButtonPicker.Top := top;
      ButtonPicker.Left := left - ButtonPicker.Width;
      ButtonPicker.Height := height;
    end;
  end;
  buttonpicker.show;
end;

procedure TEditPanelDesign.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = VK_DELETE) and (shift * [ssCtrl, ssAlt] = []) then
    PanelManager.delete
  else if (ssCtrl in shift) and (ssAlt in shift) and (CurrentUser.IsZonalUser) then
  if (key = ord('0')) then
  begin
    if application.FindComponent('EditDialogs') = nil then
      TEditDialogs.create(application).Show
    else
      TForm(application.FindComponent('EditDialogs')).show;
  end;
end;

//------------------------------------------------------------------------------
function TEditPanelDesign.ValidOrderDisplayDims : Boolean;
var
  index : Integer;
  dlg : TfrmStdGrid;

  function ValidOrderDisplayHeight(OrderDisplayHeight: Integer): Boolean;
  begin
    Result := True;
    case PanelManager.FPanelDesignTypeID of
      1,2:
        if (OrderDisplayHeight < (PanelManager.pd.buttonheight * 2)) then
        begin
          Result := False;
          MessageDlg('The Order Display must have a height of at least 2 buttons.',mtError,[mbOK],0);
        end;
      3:
        if (OrderDisplayHeight < (PanelManager.pd.buttonheight * 3)) then
        begin
          Result := False;
          MessageDlg('The Order Display must have a height of at least 3 buttons.',mtError,[mbOK],0);
        end;
    end;
  end;

begin
  Result := True;
  if PanelManager.IsRoot then //** Need to make sure the OrderDisplay in valid location
  begin
    for index := 0 to PanelManager.ComponentCount -1 do
    begin
      if (PanelManager.Components[index] is TTillHeader) and
      (TTillHeader(PanelManager.Components[index]).HeaderType = 'OrderDisplay') and
      (TTillHeader(PanelManager.Components[index]).upd) then
      begin
        with TTillHeader(PanelManager.Components[index]) do
        begin
          if not ValidOrderDisplayHeight(Height) then
          begin
            Result := False;
            break;
          end;
          ADOStoredProc2.Parameters[1].Value := PanelManager.PanelID;
          ADOStoredProc2.Parameters[2].Value := Top;
          ADOStoredProc2.Parameters[3].Value := Left;
          ADOStoredProc2.Parameters[4].Value := Top+Height;
          ADOStoredProc2.Parameters[5].Value := left+Width;
          ADOStoredProc2.Open;
          if ADOStoredProc2.RecordCount > 0 then //** we have a conflicting panel show the
          //** Origianlly I thought about letting them override this but when testing panels that
          //** overlap the OD can seriously screw up the till so no more! They cant save it
          begin
            dlg := TfrmStdGrid.Create(self);
            try
              Result := False;  //** saving is cancelled
              dlg.dsGrid.DataSet := ADOStoredProc2;
              dlg.ShowModal;
            finally
              dlg.Free;
            end;
          end;
          ADOStoredProc2.Close;
        end; {with}
      end; {if Header is order display}
    end;
  end;{if Panel is Root}
end;

function TEditPanelDesign.ValidCorrectionPanelDims : Boolean;
var
  index : Integer;
  TillHeader: TTillHeader;

  function ValidHeight(Height: Integer): Boolean;
  begin
    Result := True;
    case PanelManager.FPanelDesignTypeID of
      3: //handheld
        if (Height < (PanelManager.pd.buttonheight * 4)) then
        begin
          Result := False;
          MessageDlg('Correction display must have a height of at least 4 buttons.',mtError,[mbOK],0);
        end;
      else //all other hardware
        if (Height < (PanelManager.pd.buttonheight * 3)) then
        begin
          Result := False;
          MessageDlg('Correction display must have a height of at least 3 buttons.',mtError,[mbOK],0);
        end;
    end;
  end;

begin
  Result := True;
  if PanelManager.EditingCorrectionPanel then
  begin
    for index := 0 to PanelManager.ComponentCount -1 do
    begin
      if (PanelManager.Components[index] is TTillHeader) then
      begin
        TillHeader := TTillHeader(PanelManager.Components[index]);
        if TillHeader.upd
        and ((TillHeader.HeaderType = 'CorrectAccountAccount') or (TillHeader.HeaderType = 'CorrectAccountCorrections')) then
        begin
          with TTillHeader(PanelManager.Components[index]) do
            if not ValidHeight(Height) then
            begin
              Result := False;
              break;
            end;
        end;
      end;
    end;
  end;
end;

procedure TEditPanelDesign.SavePanelExecute(Sender: TObject);
var
  tmp_bool: boolean;
begin
  log('Save Panel Clicked');
  if ValidOrderDisplayDims and ValidCorrectionPanelDims then
  begin
    log('Panel positions valid, saving panel "' + PanelManager.PanelName +
      '", Panel ID ' + IntToStr(PanelManager.PanelID) + '", Username ' + CurrentUser.UserName);
    tmp_bool := PanelManager.PanelModified;
    PanelManager.SavePanel(dmThemeData.AztecConn);
    if tmp_bool then
      ReadDynamicLookups(dmThemeData.AztecConn, true, panelmanager.PanelID);
  end;
end;

procedure TEditPanelDesign.RevertPanelExecute(Sender: TObject);
var
  i: integer;
begin
  Log('Reverting panel "' + PanelManager.PanelName + '", Panel ID ' +
      IntToStr(PanelManager.PanelID) + ', UserName ' + CurrentUser.UserName);

  PanelManager.LoadPanel(dmThemeData.AztecConn, PanelManager.PanelID);
  // fix - make sure panel name is reverted as this is not a panelmgr. property
  for i := 0 to pred(cbPickPanel.items.count) do
    if TInt64obj(cbPickpanel.items.objects[i]).value = panelmanager.PanelID then
    begin
      cbPickpanel.items[i] := panelmanager.panelname;
      cbPickPanel.itemindex := i;
    end;
end;

procedure TEditPanelDesign.NewPanelExecute(Sender: TObject);
var
  newpanelid: largeint;
  Dlg : TTillPanelEditor;
  RelTop, RelLeft : double;
  line1, Line2, Line3 : string;
  //****************************************************************************
  function DimsOK : Boolean;
  var
    PTop, PLeft, Pheight, PWidth : Integer;
  begin
    with Dlg do
    begin
      PTop := (PanelManager.pd.buttonheight * seTop.Value) + PanelManager.pd.gridoffsetY;
      PLeft := (PanelManager.pd.buttonWidth * seLeft.Value) + PanelManager.pd.gridoffsetX;
      PHeight := PanelManager.pd.buttonheight * seHeight.Value;
      PWidth := PanelManager.pd.buttonWidth * seWidth.Value;
      result := PanelManager.NewPanelPosValid(PTop,PLeft,Ptop + PHeight,Pleft + PWidth,Dlg.cbHideOrderDisplay.Checked);

//      PLeft := PLeft + panelmanager.pd.gridoffsetx;
      RelTop :=  (PTop - PanelManager.pd.gridoffsety + (pheight / 2)) / PanelManager.pd.screenheight;
      relLeft := (PLeft - PanelManager.pd.gridoffsetx  + (pwidth / 2)) / PanelManager.pd.screenwidth;
    end;
  end;

begin
  log('New panel button clicked.');
  CheckSaveChanges;
  Dlg := nil;
  try
    Dlg := TTillPanelEditor.Create(nil);
    with Dlg do
    begin
      // Bug - panel names are not checked for uniqueness when creating a new local panel
      PanelDesignID := PanelManager.PanelDesign;
      edName.Text := '';
      mmDescription.Lines.Text := '';
      mmEposName.lines.Text := '';
      seTop.value := (panelmanager.paneltop - panelmanager.pd.gridoffsety) div panelmanager.pd.buttonheight;
      seLeft.value := (panelmanager.panelleft - panelmanager.pd.gridoffsetx) div panelmanager.pd.buttonwidth;
      seWidth.value := panelmanager.panelwidth div panelmanager.pd.buttonwidth;
      seHeight.value := panelmanager.panelheight div panelmanager.pd.buttonheight;
      Dlg.ShowModal;
      while (Dlg.ModalResult <> mrCancel) do
      begin
        if not DimsOK then
        begin
          MessageDlg('Suggested Dimensions will overlap order display.', mtError, [mbOK], 0);
          Dlg.ShowModal;
        end
        else
          break;
      end;
    end;  // with Dlg
    if Dlg.ModalResult = mrOk then //** we have a valid panel position continue
    begin
      with TADOQuery.create(nil) do try
        connection := dmthemedata.AztecConn;
        with dmThemeData.adoqRun do
        begin
          newpanelid := uGenerateThemeIDs.GetNewId(scThemePanel);
          if Dlg.mmEposName.Lines.count > 0 then
            Line1 := Dlg.mmEposName.lines[0]
          else
            Line1 := '';
          if Dlg.mmEposName.Lines.count > 1 then
            Line2 := Dlg.mmEposName.lines[1]
          else
            Line2 := '';
          if Dlg.mmEposName.Lines.count > 2 then
            Line3 := Dlg.mmEposName.lines[2]
          else
            Line3 := '';

          sql.text := format('insert into themepanel select '+
            '%d, 3, %d, %s, %s, %.18f, %.18f, %d, %d, %d, %d, %s, %s, %s',
            [newpanelid, current_panel_design, QuotedStr(Dlg.edName.Text), QuotedStr(Dlg.mmDescription.Text),
             RelLeft, RelTop, Dlg.seWidth.Value,Dlg.seHeight.Value,
             integer(Dlg.cbHideOrderDisplay.Checked),
             integer(Dlg.cbModPanel.Checked),
             QuotedStr(Line1), QuotedStr(Line2),QuotedStr(Line3)]);
          execsql;
          panelmanager.LoadPanel(dmThemeData.AztecConn, newpanelid);
          cbPickPanel.itemindex := cbPickPanel.items.addobject(Dlg.edName.Text, TInt64Obj.create(newpanelid));
        end;
      finally
        free;
      end;
      ReadDynamicLookups(dmThemeData.AztecConn, true, newpanelid);
    end;
  finally
    Dlg.Free;
  end;
end;

procedure TEditPanelDesign.DeletePanelExecute(Sender: TObject);
var
  oldindex: integer;
  panelname: string;
begin
  with dmThemeData.adoqRun do
  begin
    // check panel can be deleted
    sql.Text := Format(
      'declare @paneldesignid int '+
      'declare @panelid int '+
      'select @paneldesignid = %d '+
      'select @panelid = %d '+
      'select themepanel.panelid from themepanel '+
      'join themepanelbutton on themepanel.panelid = themepanelbutton.panelid '+
      'where themepanel.paneldesignid = @paneldesignid and themepanelbutton.buttontypechoiceattr01 = CAST(@panelid as varchar(50)) '+
      'and buttontypechoiceid in (select id from themebuttontypechoicelookup where name in (''openpanel'', ''applyand'')) '+
      'union '+
      'select a.panelid from '+
      '( '+
      'select [root] as panelid from themepaneldesign '+
      'where paneldesignid = @paneldesignid '+
      'union '+
      'select [correctaccount] as panelid from themepaneldesign '+
      'where paneldesignid = @paneldesignid '+
      'union '+
      'select [pay] as panelid from themepaneldesign '+
      'where paneldesignid = @paneldesignid '+
      ') a '+
      'where a.panelid = @panelid',
       [current_panel_design, panelmanager.panelid]);
    open;
    if recordcount > 0 then
    begin
      close;
      raise exception.create('You may not delete a panel used in this panel design, or a root/pay/correct panel');
    end;
    close;
    panelname := PanelManager.PanelName;
    if messagedlg(format('Are you sure you want to delete panel "%s"?', [panelname]), mtConfirmation, [mbOk, mbCancel], 0) = mrCancel then
      exit;

    if dmThemeData.IsForcedSelectionPanel(panelmanager.panelid) then
    begin
      dmThemeData.DeleteForcedSelectionPanel(PanelManager.PanelDesign);
    end
    else
    begin
      sql.text := format('delete themepanel where panelid = %d', [panelmanager.panelid]);
      execsql;
    end;
  end;
  Log('Deleting Panel "' + PanelManager.PanelName + '", PanelID ' + IntToStr(PanelManager.PanelID) +
      ', UserName ' + CurrentUser.UserName);

  oldindex := cbPickPanel.ItemIndex;
  cbPickPanel.DeleteSelected;
  try
    if oldindex >= cbPickPanel.Items.count then
      cbPickPanel.ItemIndex := oldindex - 1
    else
      cbPickPanel.ItemIndex := oldindex;
  except
  end;
  panelmanager.DetailsModified := false;
  panelmanager.PanelModified := false;
  cbPickPanel.OnChange(cbPickPanel);
end;


procedure TEditPanelDesign.ShowPickerExecute(Sender: TObject);
begin
  Log('Show Button Picker clicked');
  if buttonpicker.Visible then
    buttonpicker.Hide
  else
    buttonpicker.Show;
end;

procedure TEditPanelDesign.btCloseClick(Sender: TObject);
begin
  ButtonClicked(Sender);
  close;
end;

procedure TEditPanelDesign.CheckSaveChanges;
begin
  if SavePanel.Enabled then
  begin
    case messagedlg('Do you want to save changes?', mtConfirmation, [mbYes, mbNo], 0) of
      mrYes: SavePanel.Execute;
      mrNo:  Log('Panel "' + PanelManager.PanelName + '" Panel ID ' + IntToStr(PanelManager.PanelID) +
                 ' Save changes cancelled, UserName ' + CurrentUser.UserName);
    end;
  end;
end;

procedure TEditPanelDesign.SavePanelUpdate(Sender: TObject);
begin
  //** if user saves form without specifing spanel position generated XML is invalid
  TAction(sender).Enabled :=
    (PanelManager.PanelType <> ptDialog) and
    (PanelManager.DetailsModified or PanelManager.PanelModified) and (PanelManager.AddingSharedPanel = False);
end;

procedure TEditPanelDesign.RevertPanelUpdate(Sender: TObject);
begin
  //** if user reverts while adding sp access violates as tries to reference invalid button
  TAction(sender).Enabled := (PanelManager.DetailsModified or PanelManager.PanelModified) and (PanelManager.AddingSharedPanel = False);
end;

procedure TEditPanelDesign.PanelPropertiesExecute(Sender: TObject);
var
  i: integer;
  hide_order_display: boolean;
  panelDesignType: integer;
begin
  Log('Panel Properties button Clicked');
  PanelManager.SelectedObject := PanelManager.PanelOutLine;
  with TTillPanelEditor.Create(nil) do try
    PanelID := panelmanager.PanelID;
    PanelDesignID := PanelManager.PanelDesign;
    edName.Text := panelmanager.PanelName;
    mmDescription.Lines.Text := panelmanager.PanelDescription;
    mmEposName.lines.Text := panelmanager.EposName1 + #13+ panelmanager.EposName2 + #13 +
      panelmanager.EposName3;
    seTop.value := (panelmanager.paneltop - panelmanager.pd.gridoffsety) div panelmanager.pd.buttonheight;
    seLeft.value := (panelmanager.panelleft - panelmanager.pd.gridoffsetx) div panelmanager.pd.buttonwidth;
    seWidth.value := panelmanager.panelwidth div panelmanager.pd.buttonwidth;
    seHeight.value := panelmanager.panelheight div panelmanager.pd.buttonheight;
    cbHideOrderDisplay.Checked := panelmanager.HideOrderDisplay;
    cbModPanel.checked := panelmanager.ModPanel;
    if HelpExists then
      SetHelpContextID(self,AZTM_EDIT_PANEL);
    if panelmanager.IsRoot then
    begin
      if HelpExists then
        SetHelpContextID(self,AZTM_EDIT_ROOT_PANEL);
      cbHideOrderDisplay.checked := false;
      cbHideOrderDisplay.Enabled := false;
      cbModPanel.Checked := false;
      cbModPanel.Enabled := false;
      if panelmanager.HideOrderDisplay = true then
        panelmanager.hideorderdisplay := false;
      if panelmanager.ModPanel = true then
        panelmanager.ModPanel := false;
    end;

    if dmThemeData.IsForcedSelectionPanel(panelManager.PanelID) then
    begin
      if HelpExists then
        SetHelpContextID(self,AZTM_EDIT_FORCED_ITEM_SELECTION);
      cbHideOrderDisplay.checked := true;
      cbHideOrderDisplay.Enabled := false;
      cbModPanel.Checked := false;
      cbModPanel.Enabled := false;
      if panelmanager.HideOrderDisplay = false then
        panelmanager.hideorderdisplay := true;

      with TADOQuery.create(nil) do try
        connection := dmthemedata.AztecConn;

        sql.text := format('select paneldesigntype from themepaneldesign '+
          ' where paneldesignid = %d ', [PanelManager.PanelDesign]);

        open;
        panelDesignType := fieldbyname('paneldesigntype').AsInteger;
        close;
      finally
        free;
      end;

      if panelDesignType = 3 then
      begin  // for Handhelds min size = max size, i.e. fixed size
        PanelManager.MinWidthInButtons := 6;
        PanelManager.MinHeightInButtons := 10;
        seTop.Enabled := false;
        seLeft.Enabled := false;
        seWidth.Enabled := false;
        seHeight.Enabled := false;
        label6.Enabled := false;
        label5.Enabled := false;
        label2.Enabled := false;
        label3.Enabled := false;
      end
      else
      begin
        PanelManager.MinWidthInButtons := 6;
        PanelManager.MinHeightInButtons := 5;
      end;

      edName.Enabled := false;
      lbName.Enabled := false;
      mmEposName.Visible := false;
      label1.Visible := false;
      seWidth.MinValue := PanelManager.MinWidthInButtons;
      seHeight.MinValue := PanelManager.MinHeightInButtons;
    end;

    if showmodal = mrOk then
    begin
      panelmanager.ModPanel := cbModPanel.checked;
      hide_order_display := cbHideOrderDisplay.Checked;
      if panelmanager.IsRoot then
        hide_order_display := true;
      if not PanelManager.NewPanelPosValid(
 (seTop.value * PanelManager.pd.buttonheight) + panelManager.GridOffsetY,
 (seLeft.value * PanelManager.pd.buttonWidth) + panelManager.GridOffsetX,
 (seTop.value * PanelManager.pd.buttonheight) + panelManager.GridOffsetY + (seHeight.Value * PanelManager.pd.buttonheight),
 (seLeft.value * PanelManager.pd.buttonWidth) + panelManager.GridOffsetX + (seWidth.Value * PanelManager.pd.buttonWidth),
          hide_order_display) then
            Raise Exception.Create('Panel Dimensions will OverLap with the Order Display' +  #13#10 +
                                   'This Panel is not marked as Panel Hides Order Display' + #13#10 +
                                   'New dimensions have been rejected');
{


      if (not cbHideOrderDisplay.checked) and (not (PanelManager.PanelName = 'Root'))  then
      begin
        try
        ADOStoredProc1.Close;
        ADOStoredProc1.Parameters[1].Value := PanelManager.PanelID;
        ADOStoredProc1.Parameters[2].Value := seTop.value;
        ADOStoredProc1.Parameters[3].Value := seLeft.value;
        ADOStoredProc1.Parameters[4].Value := seHeight.value;
        ADOStoredProc1.Parameters[5].Value := seWidth.value;
        ADOStoredProc1.Open;
        if ADOStoredProc1.Parameters[0].Value = 0 then
          Raise Exception.Create('Panel Dimensions will OverLap with the Order Display Header' +  #13#10 +
                                 'This Panel is not marked as Panel Hides Order Display' + #13#10 +
                                 'New dimensions have been rejected');

        finally
          ADOStoredProc1.Close;
        end;
      end;
}

      panelmanager.PanelName := edName.text;
      panelmanager.Paneldescription := mmDescription.Lines.text;
      if mmEposName.Lines.count > 0 then
        panelmanager.EposName1 := mmEposName.lines[0]
      else
        panelmanager.EposName1 := '';
      if mmEposName.Lines.count > 1 then
        panelmanager.EposName2 := mmEposName.lines[1]
      else
        panelmanager.EposName2 := '';
      if mmEposName.Lines.count > 2 then
        panelmanager.EposName3 := mmEposName.lines[2]
      else
        panelmanager.EposName3 := '';
      panelmanager.HideOrderDisplay := cbHideOrderDisplay.checked;
      panelmanager.ModPanel := cbModPanel.checked;
      panelManager.PanelOutLine.HideOrderDisplay := cbHideOrderDisplay.checked;
      panelmanager.PanelLeft := (seLeft.Value * panelmanager.pd.buttonwidth) + panelmanager.pd.gridoffsetx;
      panelmanager.PanelTop := (seTop.Value * panelmanager.pd.buttonheight) + panelmanager.pd.gridoffsety;
      panelmanager.PanelWidth := seWidth.Value * panelmanager.pd.buttonwidth;
      panelmanager.panelheight := seHeight.Value * panelmanager.pd.buttonheight;
      for i := 0 to pred(cbPickPanel.items.count) do
        if TInt64obj(cbPickpanel.items.objects[i]).value = panelmanager.PanelID then
        begin
          cbPickpanel.items[i] := panelmanager.panelname;
          cbPickPanel.itemindex := i;
        end;
    end;
  finally
    free;
  end;

end;

procedure TEditPanelDesign.ActionManager1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
//  if PanelManager.AddingSharedPanel then
//  begin
//    ActionManager1.State := asSuspended;
//    Handled := True;
//  end;
end;

//------------------------------------------------------------------------------
procedure TEditPanelDesign.SharedPanelsExecute(Sender: TObject);
begin
  log('View Associated Shared panels button clicked');
  with TfrmSubPanelValidate.Create(self) do
  begin
    FPanelManager := PanelManager;
    FObject := TTillObject(PanelManager.SelectedObject);
    Init;
    AddingPanel := false;
    Show; //** cant be shown modally as user needs to interact with panel manager
  end;
end;

//------------------------------------------------------------------------------
procedure TEditPanelDesign.ActionToolBar1DblClick(Sender: TObject);
//var
//  panel2edit: integer;
begin
//  panel2edit := 57;
//  if panelmanager.PanelID = panel2edit then panelmanager.SavePanel(dmthemedata.AztecConn);
//  panelmanager.LoadPanel(dmthemedata.AztecConn, panel2edit);
end;

procedure TEditPanelDesign.SharedPanelsUpdate(Sender: TObject);
begin
  SharedPanels.Enabled := PanelManager.EnableSharedPanelEdit;
end;

procedure TEditPanelDesign.NewPanelUpdate(Sender: TObject);
begin
  if PanelManager.AddingSharedPanel then
    TAction(Sender).Enabled := False
  else
    TAction(Sender).Enabled := True;
end;

procedure TEditPanelDesign.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if PanelManager.AddingSharedPanel then
  begin
    CanClose := False;
    MessageDlg('Cannot Close Panel Design While Editing Shared Panel Details.', mtError, [mbOK], 0);
  end
  else if not (ThemeModellingMenu.ApplicationClosing) then
    CheckSaveChanges;
end;

procedure TEditPanelDesign.cbPickPanelCloseUp(Sender: TObject);
begin
  Log('Panel ' + cbPickPanel.Text + ' Selected From Drop Down List');
end;

end.
