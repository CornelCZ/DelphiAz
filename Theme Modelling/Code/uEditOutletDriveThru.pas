unit uEditOutletDriveThru;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uTillButton, Menus, uEditSeatPlan, ExtCtrls, ToolWin,
  ActnMan, ActnCtrls, ActnList, ImgList;

const
  CurrentVariation = 0;
  CreateNewVariation = 1;
  DebugSiteVariations = false;
  EMPTY_SPACE = 0;
  PAY_POINT = 1;
  PICKUP_POINT = 2;
  PARKING_BAY = 3;
  PAYPICKUP_POINT = 4;
  ORDER_POINT = 5;

type
  TQueueSets = set of 0..5;

type
  TEditOutletDriveThru = class(TForm)
    pnToolBar: TPanel;
    Button1: TButton;
    Panel2: TPanel;
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    SavePanel: TAction;
    RevertPanel: TAction;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    NewCarSpace: TMenuItem;
    NewLabel: TMenuItem;
    NewOrderPoint1: TMenuItem;
    NewParkingBay1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure NewLabelClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure SavePanelUpdate(Sender: TObject);
    procedure RevertPanelUpdate(Sender: TObject);
    procedure SavePanelExecute(Sender: TObject);
    procedure RevertPanelExecute(Sender: TObject);
    procedure CheckSaveChanges;
    function GetSequenceNumber(queuePoints : TQueueSets) : Integer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ConfigureDriveThruSpace(SpaceType : integer);
    procedure NewCarSpaceClick(Sender: TObject);
    procedure NewOrderPoint1Click(Sender: TObject);
    procedure NewParkingBay1Click(Sender: TObject);
  private
    { Private declarations }
    DriveThruid: integer;
    DriveThrusitecode: integer;
    popup_cursorpos: TPoint;
    parkingSet : TQueueSets;
    queueSet : TQueueSets;
    SequenceNumber: array of boolean;
    function FlowOutofSync : boolean;
    procedure ReSequenceQueueFlow(queuePoints : TQueueSets);
    function getButtonCount(queuePoints : TQueueSets) : integer;
    function validateDriveThruQueue : boolean;
    procedure configurePointOrder;
  public
    procedure OnObjectDblClick(obj: TTillObject);
    class procedure EditOutletDriveThru(id: integer);
    function PointTypeExists(PointType, Position : integer) : boolean;
    function notBeforeAfterPointType(isBefore : Boolean; PointType, Position : integer) : boolean;
    function TerminalAllocated(EposDeviceID : Integer) : Boolean;
  end;

var
  EditOutletDriveThru: TEditOutletDriveThru;

implementation

uses uDMThemeData, uEnterTableNumberDialog, uTillButtonEditor,
  uTillLabelEditor, uTillPanelEditor, uThemeModellingMenu, uAztecLog, uEditParkingSpace,
  ADODB, DB, uAztecDatabaseUtils, uADO, uGenerateThemeIDs;

var
  panelmanager: TPanelManager;

{$R *.dfm}

class procedure TEditOutletDriveThru.EditOutletDriveThru(id: integer);
var
  form: TEditOutletDriveThru;
begin
  ReadFixedLookups(dmThemeData.AztecConn);

  form := TEditOutletDriveThru.create(nil);
  with form do try

    DriveThruid := id;
    DriveThrusitecode := id;
    
    if not assigned(panelmanager) then
      panelmanager := TPanelManager.create(form);
    with panelmanager do
    begin
      // used as defaults for new tables/labels and should be divisible by current
      // grid sizes
      pd.LoadFromValues(8, 8, 800, 600, 0, 0);
      parkingSet := [PARKING_BAY];
      queueSet := [EMPTY_SPACE, PAY_POINT, PICKUP_POINT, PAYPICKUP_POINT];
      
      LoadPanel(dmThemeData.AztecConn, id, lpmDriveThru, DriveThrusitecode);

      // Dynamically set the array to the number of Queue Spaces.
      SetLength(SequenceNumber, getButtonCount(QueueSet));

      ObjectDblClickEvent := form.OnObjectDblClick;
      if showmodal = mrOK then
        SavePanel(dmThemeData.AztecConn);
    end;
  finally
    if assigned(panelmanager) then
    begin
      panelmanager.free;
      panelmanager := nil;
    end;
    form.free;
  end;
end;

procedure TEditOutletDriveThru.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
  with dmThemeData do
  begin
    if not GetStoredMetrics(self, true) then
    begin
      top := (screen.Height - height) div 2;
      left := (screen.Width - width) div 2;
    end;
  end;
end;

procedure TEditOutletDriveThru.SavePanelExecute(Sender: TObject);
begin
  Log('Saving Drive Thru ' + IntToStr(panelmanager.PanelID));
  if validateDriveThruQueue then
    begin
      configurePointOrder;
      panelmanager.SavePanel(dmThemeData.AztecConn);
    end
end;

function TEditOutletDriveThru.FlowOutofSync : boolean;
var
  i, p : integer;
  ButtonCount: Integer;
begin
  Result := false;
  ButtonCount := getButtonCount(queueSet);
  for p := 1 to ButtonCount do
    begin
      // if sequence number is not found then return true
      if result = true then
         exit
      else
        for i := pred(panelmanager.ComponentCount) downto 0  do
          begin
            if (panelmanager.components[i] is TTillbutton) then
              begin
                if (TTillbutton(panelmanager.Components[i]).SequenceNumber = p) and
                   (TTillbutton(panelmanager.Components[i]).SpaceType in queueSet) and
                   (TTillbutton(panelmanager.Components[i]).Visible = true) then
                     begin
                       // if the result is false then leave loop and find next sequence number.
                       result := false;
                       break;
                     end
                   else
                     Result := true;
              end;
         end;
    end;
end;

function TEditOutletDriveThru.getButtonCount(queuePoints : TQueueSets) : integer;
var i, nMaxSeq : integer;
begin
  nMaxSeq := 0;

  for i := pred(panelmanager.ComponentCount) downto 0  do
      begin
      if (panelmanager.components[i] is TTillbutton) then
        begin
          if (TTillbutton(panelmanager.Components[i]).SequenceNumber > nMaxSeq) and
             (TTillbutton(panelmanager.Components[i]).SpaceType in queuePoints) and
             (TTillbutton(panelmanager.Components[i]).Visible = true) then
                  nMaxSeq := TTillbutton(panelmanager.Components[i]).SequenceNumber;
       end;
    end;
  result := nMaxSeq;
end;

procedure TEditOutletDriveThru.ReSequenceQueueFlow(queuePoints : TQueueSets);
var
  p, nAdjusmentAmount : integer;

  function sequenceFound(SeqNum, nAdjusmentAmount : integer; queuePoints : TQueueSets) : boolean;
  var i : integer;
  begin
    result := false;

    for i := pred(panelmanager.ComponentCount) downto 0  do
      begin
        if (panelmanager.components[i] is TTillbutton) then
          begin
            if (TTillbutton(panelmanager.Components[i]).SequenceNumber = SeqNum) and
               (TTillbutton(panelmanager.Components[i]).SpaceType in queuePoints) and
               (TTillbutton(panelmanager.Components[i]).Visible = true) then
               begin
                 TTillbutton(panelmanager.Components[i]).SequenceNumber := SeqNum - nAdjusmentAmount;

                 if TTillbutton(panelmanager.Components[i]).EposName1 = IntToStr(SeqNum) then
                    TTillbutton(panelmanager.Components[i]).EposName1 := IntToStr(SeqNum - nAdjusmentAmount);
                    
                 TTillbutton(panelmanager.Components[i]).Refresh;
                 result := true;
                 break;
               end
               else
                 Result := false;
          end;
      end;
  end;

begin

  nAdjusmentAmount := 0;
  
  for p := 1 to getButtonCount(queuePoints) do
    begin
      // if sequence number is not found then return true
      if not sequenceFound(p, nAdjusmentAmount, queuePoints) then
         nAdjusmentAmount := nAdjusmentAmount + 1;
    end;

end;

procedure TEditOutletDriveThru.RevertPanelExecute(Sender: TObject);
begin
  Log('Revert Button Clicked While editing Drive Thru Plan.');
  panelmanager.LoadPanel(dmthemedata.aztecconn, panelmanager.panelid, lpmDriveThru, DriveThrusitecode);
end;

procedure TEditOutletDriveThru.CheckSaveChanges;
begin
  if Assigned(PanelManager) then
  begin
    if PanelManager.panelmodified or PanelManager.detailsmodified then
       if messagedlg('Do you want to save changes?', mtConfirmation, [mbYes, mbNo], 0) =
            mrYes then
            begin
             SavePanel.Execute;
            end;
  end;
end;

function TEditOutletDriveThru.validateDriveThruQueue : boolean;
begin
  result := True;

  if not PointTypeExists(ORDER_POINT, -1) then
     begin
       MessageDlg('The Drive Thru plan must include an Order Point.',mtError, [mbOk],0);
       result := false;
     end
  else
  if not PointTypeExists(PAY_POINT, -1) and not PointTypeExists(PAYPICKUP_POINT, -1) then
     begin
       MessageDlg('The Drive Thru plan must include a Pay Point.',mtError, [mbOk],0);
       result := false;
     end
  else
  if not PointTypeExists(PICKUP_POINT, -1) and not PointTypeExists(PAYPICKUP_POINT, -1) then
     begin
       MessageDlg('The Drive Thru plan must include a Pickup Point.',mtError, [mbOk],0);
       result := false;
     end
  else
  if FlowOutofSync then
     begin
       if MessageDlg('There are gaps in the Drive Thru sequence.  Do you wish to re-sequence the plan?',mtWarning, [mbYes,mbNo],0) = mrYes then
          ReSequenceQueueFlow(queueSet)
       else
          begin
            MessageDlg('The Drive Thru plan must be sequenced correctly before it can be saved.',mtError, [mbOK], 0);
            Result := false;
          end;
     end;
  ReSequenceQueueFlow(parkingSet);
end;

procedure TEditOutletDriveThru.Button1Click(Sender: TObject);
begin
  ButtonClicked(Sender);

  if panelmanager.DetailsModified or panelmanager.PanelDesignModified then
    begin
      if not validateDriveThruQueue then
         exit
      else
         close;
    end
  else
     Close;
end;

procedure TEditOutletDriveThru.SavePanelUpdate(Sender: TObject);
begin
  TAction(sender).enabled := panelmanager.detailsmodified or panelmanager.PanelModified;
end;

procedure TEditOutletDriveThru.RevertPanelUpdate(Sender: TObject);
begin
  TAction(sender).enabled := panelmanager.detailsmodified or panelmanager.PanelModified;
end;


procedure TEditOutletDriveThru.OnObjectDblClick(obj: TTillObject);
var
  t1, t2, t3: byte;
  Dlg : TEditParkingSpace;

  procedure updateEposName(EposName1, EposName2 : String; FontID : integer);
  begin
    TTillbutton(obj).EposName1 := EposName1;
    TTillbutton(obj).EposName2 := EposName2;
    TTillbutton(obj).FontID := FontID;
  end;

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
    if TTillButton(Obj).SpaceType IN (queueSet) then
      begin
        Dlg := nil;
        try
          Dlg := TEditParkingSpace.Create(nil);

          Dlg.FTerminalID := TTillButton(Obj).TerminalID;
          Dlg.edtSeqNum.Text := IntToStr(TTillButton(Obj).SequenceNumber);

          case TTillButton(Obj).SpaceType of
               PAY_POINT       : Dlg.cbxPayPoint.Checked := true;
               PICKUP_POINT    : Dlg.cbxPickupPoint.Checked := true;
               PAYPICKUP_POINT : begin
                                   Dlg.cbxPayPoint.Checked := true;
                                   Dlg.cbxPickupPoint.Checked := true;
                                 end;
          end;


      if (Dlg.ShowModal = mrOk) then
      begin
         TTillbutton(obj).TerminalID := Dlg.FTerminalID;

         if (Dlg.cbxPayPoint.Checked = true) and
            (Dlg.cbxPickupPoint.Checked = false) then
                begin
                  TTillbutton(obj).SpaceType := PAY_POINT;
                  updateEposName('Pay','Point',1);

                end
         else
         if (Dlg.cbxPayPoint.Checked = false) and
            (Dlg.cbxPickupPoint.Checked = true) then
                begin
                  TTillbutton(obj).SpaceType := PICKUP_POINT;
                  updateEposName('Pickup','Point',1);
                end
         else
         if (Dlg.cbxPayPoint.Checked = true) and
            (Dlg.cbxPickupPoint.Checked = true) then
                begin
                  TTillbutton(obj).SpaceType := PAYPICKUP_POINT;
                  updateEposName('Pickup','Point',1);
                end
         else
           begin
             TTillbutton(obj).SpaceType := EMPTY_SPACE;
             updateEposName(IntToStr(TTillbutton(obj).SequenceNumber),'',0);
           end;
         TTillButton(Obj).Refresh;
      end;
    finally
      Dlg.Free;
    end;
  end;
  end;
end;

procedure TEditOutletDriveThru.NewLabelClick(Sender: TObject);
var
  mousepos: TPoint;
begin
  mousepos := screentoclient(popup_cursorpos);
  panelmanager.AddLabel(mousepos.X, mousepos.y);

end;

procedure TEditOutletDriveThru.PopupMenu1Popup(Sender: TObject);
begin
  popup_cursorpos := mouse.cursorpos;
  panelmanager.SnapPointToGrid(popup_cursorpos);
end;

procedure TEditOutletDriveThru.ConfigureDriveThruSpace(SpaceType : integer);
var
  mousepos: TPoint;
  draw_Type : TTillButtonDrawType;
  SeqNum, SpaceNum, NextSeqNum : integer;
begin
  SeqNum := 0;
  mousepos := screentoclient(popup_cursorpos);
  draw_Type := tbdtSquare;

  //Once the squence number has been calculated, check to see if it exists in the ThemeOutletParkingSpace
  //table.

  NextSeqNum :=  getButtonCount(queueSet) + 2;

  SetLength(SequenceNumber, NextSeqNum);

  if (SpaceType = EMPTY_SPACE) then
      SeqNum := GetSequenceNumber(queueSet);

  if (SpaceType = PARKING_BAY) then
      SeqNum := GetSequenceNumber(parkingSet);

  if notBeforeAfterPointType(false, PICKUP_POINT, SeqNum) or notBeforeAfterPointType(false, PAYPICKUP_POINT, SeqNum) then
     MessageDlg('A Drive Thru space cannot be placed after a Pick Up Point.', mtError, [mbOk], 0)
  else
    begin
      SpaceNum := uGenerateThemeIDs.GetNewId(scThemeDriveThruButton);
      try
        panelmanager.AddSpace(mousepos.X, mousepos.y, SpaceNum, SeqNum, SpaceType, draw_Type);

        //SetLength(SequenceNumber, High(SequenceNumber) + 2);
        //ShowMessage('Number is:'+ inttostr(High(SequenceNumber)));
      except
        Raise;
      end;
    end;
end;

function TEditOutletDriveThru.GetSequenceNumber(queuePoints : TQueueSets) : Integer;
var
  i, nButtonCount : integer;
begin
  result := 0;
  // Find all TButton Components on the form.  Set the array postion to true
  // Recurse through array to find first false position.  This will give the
  // next sequence number.

  // Set all values to false
  for i := Low(SequenceNumber) to High(SequenceNumber) do
    SequenceNumber[i] := False;

  //SequenceNumber[0] := True;

  nButtonCount := 1;
  for i := pred(panelmanager.ComponentCount) downto 0  do
      begin
        if (panelmanager.components[i] is TTillbutton) then
          begin
            if (TTillbutton(panelmanager.Components[i]).SpaceType in queuePoints ) and
               (TTillbutton(panelmanager.Components[i]).Visible = true) then
                begin
                  SequenceNumber[(TTillbutton(panelmanager.Components[i]).SequenceNumber)] := True;
                  inc(nButtonCount);
                end;
         end
       end;

    // find the first false value in the array.  This should be the next sequential number
    for i := 1 to nButtonCount do
     begin
       if SequenceNumber[i] = false then
          begin
            Result := i;
            exit;
          end
     end;
end;

procedure TEditOutletDriveThru.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_DELETE then
     PanelManager.delete;
end;

procedure TEditOutletDriveThru.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
  with dmThemeData do
  begin
    StoreMetrics(self, true);
  end;
end;

procedure TEditOutletDriveThru.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not ThemeModellingMenu.ApplicationClosing then
    CheckSaveChanges;
end;

function TEditOutletDriveThru.PointTypeExists(PointType, Position : integer) : boolean;
var
 i : integer;
begin
   Result := false;
   for i := pred(panelmanager.ComponentCount) downto 0  do
       begin
         if (panelmanager.components[i] is TTillbutton) then
           begin
             if (TTillbutton(panelmanager.Components[i]).SpaceType = PointType) and
                (TTillbutton(panelmanager.Components[i]).Visible = true) then
                  begin
                    if (Position = -1) or
                        (TTillbutton(panelmanager.Components[i]).SequenceNumber <> Position) then
                      begin
                        Result := true;
                        exit;
                      end;
                  end
             else
                Result := false;
            end;
       end;
end;

function TEditOutletDriveThru.notBeforeAfterPointType(isBefore : Boolean; PointType, Position : integer) : boolean;
var
 i : integer;
begin
   Result := false;
   for i := pred(panelmanager.ComponentCount) downto 0  do
       begin
         if (panelmanager.components[i] is TTillbutton) then
           begin
             if (TTillbutton(panelmanager.Components[i]).SpaceType = PointType) and
                (TTillbutton(panelmanager.Components[i]).Visible = true) then
                  begin
                    if isBefore then
                      begin
                       if (Position < TTillbutton(panelmanager.Components[i]).SequenceNumber) then
                         begin
                           Result := true;
                           exit;
                         end;
                      end
                    else
                      begin
                      if (Position > TTillbutton(panelmanager.Components[i]).SequenceNumber) then
                         begin
                           Result := true;
                           exit;
                         end;
                      end;
                  end
             else
                Result := false;
            end;
       end;
end;

procedure TEditOutletDriveThru.NewCarSpaceClick(Sender: TObject);
begin
  ConfigureDriveThruSpace(EMPTY_SPACE);
end;

procedure TEditOutletDriveThru.NewOrderPoint1Click(Sender: TObject);
begin
  if PointTypeExists(ORDER_POINT, -1) then
     MessageDlg('An Order Point already exists.',mtWarning,[mbOK],0)
  else
     ConfigureDriveThruSpace(ORDER_POINT);
end;

procedure TEditOutletDriveThru.NewParkingBay1Click(Sender: TObject);
begin
  ConfigureDriveThruSpace(PARKING_BAY);
end;

function TEditOutletDriveThru.TerminalAllocated(EposDeviceID : Integer) : Boolean;
var
 i : integer;
begin
   Result := false;
   for i := pred(panelmanager.ComponentCount) downto 0  do
       begin
         if (panelmanager.components[i] is TTillbutton) then
           begin
             if (TTillbutton(panelmanager.Components[i]).TerminalID = EposDeviceID) and
                (TTillbutton(panelmanager.Components[i]).Visible = true) then
                  begin
                    Result := True;
                    exit;
                  end;
           end
         else
           Result := false;
       end;
end;

procedure TEditOutletDriveThru.configurePointOrder;

  function getPointSequenceNumber(PointType : integer) : integer;
  var i : integer;
  begin
    Result := 0;
       for i := pred(panelmanager.ComponentCount) downto 0  do
          begin
            if (panelmanager.components[i] is TTillbutton) then
              begin
                if (TTillbutton(panelmanager.Components[i]).SpaceType = PointType) and
                   (TTillbutton(panelmanager.Components[i]).Visible = true) then
                    Result := TTillbutton(panelmanager.Components[i]).SequenceNumber;
              end;
          end;

  end;

  procedure modifySpace(SeqNum, ParentType : integer; queuePoints : TQueueSets );
  var p, y, ParentSequence : integer;
  begin
    if PARKING_BAY IN queuePoints then
       ParentSequence := SeqNum - 1
    else
       ParentSequence := 0;

    for p := SeqNum downto 1 do
      begin
        for y := pred(panelmanager.ComponentCount) downto 0  do
          begin
            if (panelmanager.Components[y] is TTillbutton) then
              begin
                if (TTillbutton(panelmanager.Components[y]).SequenceNumber = p) and
                   (TTillbutton(panelmanager.Components[y]).SpaceType in queuePoints ) and
                   (TTillbutton(panelmanager.Components[y]).Visible = true) then
                   begin
                     TTillbutton(panelmanager.Components[y]).ButtonTypeData2 := IntToStr(ParentType);
                     TTillbutton(panelmanager.Components[y]).ButtonTypeData := IntToStr(ParentSequence);

                     if PARKING_BAY IN queuePoints then
                        Dec(ParentSequence)
                     else
                        Inc(ParentSequence);
                   end;
              end;
          end;
      end;
  end;


begin
  // Pay/Pickup points are assigned to PAYPOINTS within the Xml.
  if PointTypeExists(PAYPICKUP_POINT, -1) then
     modifySpace(getPointSequenceNumber(PAYPICKUP_POINT), PAY_POINT, queueSet);

  if PointTypeExists(PICKUP_POINT, -1) then
     modifySpace(getPointSequenceNumber(PICKUP_POINT), PICKUP_POINT, queueSet);

  if PointTypeExists(PAY_POINT, -1) then
     modifySpace(getPointSequenceNumber(PAY_POINT), PAY_POINT, queueSet);

  if PointTypeExists(PARKING_BAY, -1) then
     modifySpace(getButtonCount(parkingSet), PARKING_BAY, ParkingSet);
end;

end.
