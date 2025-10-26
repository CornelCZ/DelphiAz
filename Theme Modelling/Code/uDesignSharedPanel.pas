unit uDesignSharedPanel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB,
  uTillButton, ExtCtrls, ActnList, ActnMan, ImgList, ToolWin, ActnCtrls, uGlobals;

Const
   PAYBUTTON = 6;  

type
  TDesignSharedPanel = class(TForm)
    pnToolBar: TPanel;
    Panel2: TPanel;
    ActionToolBar1: TActionToolBar;
    ImageList1: TImageList;
    ActionManager1: TActionManager;
    SavePanel: TAction;
    RevertPanel: TAction;
    ShowPicker: TAction;
    PanelProperties: TAction;
    Button1: TButton;
    ADOStoredProc1: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SavePanelExecute(Sender: TObject);
    procedure RevertPanelExecute(Sender: TObject);
    procedure ShowPickerExecute(Sender: TObject);
    procedure PanelPropertiesExecute(Sender: TObject);
    procedure SavePanelUpdate(Sender: TObject);
    procedure RevertPanelUpdate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PanelPropertiesUpdate(Sender: TObject);
  private
    { Private declarations }
    PanelManager: TPanelManager;
    procedure CheckSaveChanges;
    function isDefaultPayPanel(PanedlID : integer) : boolean;
    function checkValidPayPanel : boolean;
    function ValidDefaultPayPanel : boolean;
  public
    { Public declarations }
    ActionOnClose: TNotifyEvent;
    procedure OnObjectDblClick(obj: TTillObject);
    procedure OnObjectContextEvent(obj: TTillObject);
    procedure LoadSharedPanel(panel_id: integer; IsVariation: boolean=false);
  end;

implementation

uses uDMThemeData, uButtonPicker, uTillButtonEditor, uTillLabelEditor, uSharedPAnelProperties, uStdGrid,
  uThemeModellingMenu, uTillSubPanelEditor, uAztecLog, uFormNavigate;

{$R *.dfm}

procedure TDesignSharedPanel.OnObjectContextEvent(obj: TTillObject);
var
  Pos: Tpoint;
begin
  GetCursorPos(Pos);
  if ((panelmanager.selectedobject is TTillButton) and
    (TTillButton(panelmanager.selectedobject).drawtype = tbdtButton)) or (PanelManager.SelectedObject is TMultiItemSelection) then
    PanelManager.BackdropMenu.Popup(Pos.x, Pos.y);
end;


procedure TDesignSharedPanel.OnObjectDblClick(obj: TTillObject);
var
  t1, t2, t3: byte;
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
  end;
  if obj is TTillButton then
  begin
    with TTillButtonEditor.create(self) do try
      LoadData(TTillButton(obj));
      if showmodal = mrOk then
      begin
        SaveData(TTillButton(obj));
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
        SaveData;
    end;
  end;
end;


procedure TDesignSharedPanel.LoadSharedPanel(panel_id: integer; IsVariation: boolean=false);
begin
  if IsVariation then
    PanelManager.LoadPanel(dmThemeData.AztecConn, panel_id, lpmVariationPanel)
  else
    PanelManager.LoadPanel(dmThemeData.AztecConn, panel_id);
  clientwidth := PanelManager.pd.screenwidth;
  clientheight := PanelManager.pd.GetScreenRect.Bottom + 32;
  buttonpicker.current_design_type := 2;
  buttonpicker.current_panel_design := -1;
  buttonpicker.current_theme := -1;
  ReadDynamicLookups(dmThemeData.AztecConn, false, panel_id);
  // refresh the button picker and clear
  ButtonPicker.ButtonMenuCloseUp;
end;

procedure TDesignSharedPanel.FormCreate(Sender: TObject);
begin
  ReadFixedLookups(dmThemeData.AztecConn);
  if not assigned(PanelManager) then
    PanelManager := TPanelManager.create(self);
  with PanelManager do
  begin
    pd.LoadFromValues(73, 54, 1022, 756, 1, 6);
    ObjectContextEvent := OnObjectContextEvent;
    ObjectDblClickEvent := OnObjectDblClick;
    PanelOutLine.RepositionHintVisible := False;
    PanelOutLine.DragHandlesVisible := False;
  end;
end;

procedure TDesignSharedPanel.FormShow(Sender: TObject);
begin
  with dmThemeData do
  begin
    if not GetStoredMetrics(self, true, uDmThemeData.sttCentreScreen) then
    begin
      top := (screen.Height - height) div 2;
      left := (screen.Width - width) div 2;
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

procedure TDesignSharedPanel.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with dmThemeData do
  begin
    StoreMetrics(buttonpicker, false);
    StoreMetrics(self, true);
  end;
  buttonpicker.Hide;
  if Assigned(ActionOnClose) then ActionOnClose(Self);
  Nav.MoveBack;
end;


procedure TDesignSharedPanel.SavePanelExecute(Sender: TObject);
begin
  if not checkValidPayPanel then
     exit; 

  Log('Saving changes to shared panel "' + PanelManager.PanelName +
      '", Panel ID ' + IntToStr(PanelManager.PanelID) + ', UserName ' + CurrentUser.UserName);

  PanelManager.SavePanel(dmThemeData.AztecConn);
end;

procedure TDesignSharedPanel.RevertPanelExecute(Sender: TObject);
begin
  Log('Reverting shared panel "' + PanelManager.PanelName + '", Panel ID ' +
      IntToStr(PanelManager.PanelID) + ', UserName ' + CurrentUser.UserName);

  PanelManager.LoadPanel(dmThemeData.AztecConn, PanelManager.PanelID);
end;

procedure TDesignSharedPanel.ShowPickerExecute(Sender: TObject);
begin
  Log('Button Picker Button pressed'); 
  if buttonpicker.Visible then
    buttonpicker.Hide
  else
    buttonpicker.Show;
end;

procedure TDesignSharedPanel.PanelPropertiesExecute(Sender: TObject);
var
  Dlg : TfrmSharedPnlInfo;
begin
  Log('Shared Panel Properties Button Clicked');
  Dlg := nil;
  try
    Dlg := TfrmSharedPnlInfo.Create(nil);
    Dlg.sEdtTop.value := (panelmanager.paneltop - panelmanager.pd.gridoffsety) div panelmanager.pd.buttonheight;
    Dlg.sEdtLeft.value := (panelmanager.panelleft - panelmanager.pd.gridoffsetx) div panelmanager.pd.buttonwidth;
    Dlg.sEdtWidth.Value := PanelManager.panelwidth div PanelManager.pd.buttonwidth;
    Dlg.sEdtHeight.Value := PanelManager.panelHeight div PanelManager.pd.buttonHeight;
    Dlg.ShowModal;
    if Dlg.ModalResult = mrOK then
    begin
      with Dlg do
      begin
        panelmanager.PanelLeft := (sEdtLeft.Value * panelmanager.pd.buttonwidth) + panelmanager.pd.gridoffsetx;
        panelmanager.PanelTop := (sEdtTop.Value * panelmanager.pd.buttonheight) + panelmanager.pd.gridoffsety;
        PanelManager.PanelWidth := PanelManager.pd.buttonwidth * sedtWidth.value;
        PanelManager.PanelHeight := PanelManager.pd.buttonHeight * sedtHeight.value;
        Log(Format('Panel ID %d Width = %d Height = %d', [PanelManager.PanelID, PanelManager.PanelWidth, PanelManager.PanelHeight]));
      end;
    end;
  finally
    Dlg.Free;
  end;
end;

procedure TDesignSharedPanel.SavePanelUpdate(Sender: TObject);
begin
  TAction(sender).Enabled := PanelManager.DetailsModified or PanelManager.PanelModified;
end;

procedure TDesignSharedPanel.RevertPanelUpdate(Sender: TObject);
begin
  TAction(sender).Enabled := PanelManager.DetailsModified or PanelManager.PanelModified;
end;

procedure TDesignSharedPanel.Button1Click(Sender: TObject);
begin
  if checkValidPayPanel then
    begin
      ButtonClicked(Sender);
      close;
    end;
end;

procedure TDesignSharedPanel.CheckSaveChanges;
begin
  if PanelManager.panelmodified or PanelManager.detailsmodified then
  begin
    case messagedlg('Do you want to save changes?', mtConfirmation, [mbYes, mbNo], 0) of
      mrYes: SavePanel.Execute;
      mrNo:  Log('Shared Panel "' + PanelManager.PanelName + '" Panel ID ' + IntToStr(PanelManager.PanelID) +
             ' Save changes cancelled, UserName ' + CurrentUser.UserName);
    end;
  end;
end;

procedure TDesignSharedPanel.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_DELETE then
    PanelManager.delete
  else if Key = VK_F11 then
    PanelPropertiesExecute(self);
end;

procedure TDesignSharedPanel.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not ThemeModellingMenu.ApplicationClosing then
    CheckSaveChanges;
end;

procedure TDesignSharedPanel.PanelPropertiesUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := not(
    PanelManager.SharedPanelHasVariations or (PanelManager.PanelType = ptVariationPanel)
  );
end;

function TDesignSharedPanel.isDefaultPayPanel(PanedlID : integer) : boolean;
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

function TDesignSharedPanel.checkValidPayPanel : boolean;
begin

  result:= false;
  if (isDefaultPayPanel(PanelManager.PanelID)) and (not ValidDefaultPayPanel) then
       MessageDlg('Default Pay Panel must contain at least one payment button.', mtError, [mbOK], 0)
  else
     result := True;
end;

function TDesignSharedPanel.ValidDefaultPayPanel : boolean;
var i : integer;
begin
//  if PanelManager.DetailsModified then
//     begin
       result := false;
       // Check the selected panel for Payment Buttons
       with PanelManager do
         for i := 0 to Pred(ComponentCount) do
         begin
           if (components[i] is TTillbutton) and (TTillbutton(Components[i]).ButtonTypeID = PAYBUTTON) and
               (TTillbutton(Components[i]).Visible = True) then
               Result := True;
         end;
//  end;
end;

end.
