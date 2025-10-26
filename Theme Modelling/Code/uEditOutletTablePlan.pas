unit uEditOutletTablePlan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uTillButton, Menus, uEditSeatPlan, ExtCtrls, ToolWin,
  ActnMan, ActnCtrls, ActnList, ImgList;

type
  TEditOutletTablePlan = class(TForm)
    PopupMenu1: TPopupMenu;
    NewSquareTable: TMenuItem;
    NewLabel: TMenuItem;
    NewRoundTable: TMenuItem;
    NewDiamondTable: TMenuItem;
    pnToolBar: TPanel;
    Button1: TButton;
    Panel2: TPanel;
    ActionToolBar1: TActionToolBar;
    ImageList1: TImageList;
    ActionManager1: TActionManager;
    SavePanel: TAction;
    RevertPanel: TAction;
    procedure NewSquareTableClick(Sender: TObject);
    procedure NewLabelClick(Sender: TObject);
    procedure NewDiamondTableClick(Sender: TObject);
    procedure NewRoundTableClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SavePanelUpdate(Sender: TObject);
    procedure RevertPanelUpdate(Sender: TObject);
    procedure SavePanelExecute(Sender: TObject);
    procedure RevertPanelExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NewTableClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

  private
    { Private declarations }
    tableplanid: integer;
    tableplansitecode: integer;
    popup_cursorpos: TPoint;
    TempSeatTableName: String;

    deletedtables: TStrings;

    procedure CheckSaveChanges;
    function GetTableInstances(tablenumber: integer): integer;
    procedure UpdateTableInstances(tablenumber: integer; backdropid: integer);
    procedure CreateTempSeatTable(TableNumber: integer);
    procedure SaveSeatChanges(TableNumber: integer);

    procedure AddSelectedToDeletedList();
    procedure ProcessDeletedList();
  public
    { Public declarations }
    procedure OnObjectDblClick(obj: TTillObject);
    procedure OnObjectContextClick(obj: TTillObject);
    class procedure EditOutletTablePlan(id: integer);
  end;

var
  EditOutletTablePlan: TEditOutletTablePlan;

implementation

uses uDMThemeData, uEnterTableNumberDialog, uTillButtonEditor,
  uTillLabelEditor, uTillPanelEditor, uThemeModellingMenu, uAztecLog;

var
  panelmanager: TPanelManager;

{$R *.dfm}

class procedure TEditOutletTablePlan.EditOutletTablePlan(id: integer);
var
  form: TEditOutletTablePlan;
begin
  ReadFixedLookups(dmThemeData.AztecConn);

  form := TEditOutletTablePlan.create(nil);
  with form do try
    with dmThemeData.adoqRun do
    begin
      SQL.Text := 'select @@SPID as SPID';
      Open;
      TempSeatTableName := '##' + IntToStr(FieldByName('SPID').AsInteger) + 'ThemeOutletTableSeat';
      Close;
      SQL.text :=
        format('select sitecode from themeoutlettableplan where outlettableplanid = %d', [id]);
      Open;
      tableplanid := id;
      tableplansitecode := fieldbyname('sitecode').asinteger;
      close;
    end;
    if not assigned(panelmanager) then
      panelmanager := TPanelManager.create(form);
    with panelmanager do
    begin
      //ReadDynamicLookups(dmThemeData.AztecConn, false, );
      // used as defaults for new tables/labels and should be divisible by current
      // grid sizes
      pd.LoadFromValues(8, 8, 800, 600, 0, 0);
      LoadPanel(dmThemeData.AztecConn, id, lpmTablePlan, tableplansitecode);
      ObjectContextEvent := form.OnObjectContextClick;
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

procedure TEditOutletTablePlan.OnObjectDblClick(obj: TTillObject);
var
  t1, t2, t3: byte;
  TempBackdrop: integer;
  Dlg : TfrmTableSetUp;
  i : Integer;
  SelectedTableNumber: integer;
  PanelDetailsModified: Boolean;
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
    Dlg := nil;
    try
      SelectedTableNumber := StrToInt(TTillButton(Obj).ButtonTypeData);
      CreateTempSeatTable(SelectedTableNumber);
      Dlg := TfrmTableSetUp.Create(nil);
      Dlg.FSiteCode := dmThemeData.qOutlets.fieldbyname('SiteCode').asinteger;
      Dlg.FTableNumber := SelectedTableNumber;
      Dlg.FPanelButtonID := TTillButton(Obj).buttonID;
      Dlg.TempSeatTableName := TempSeatTableName;
      for i := low(drawtypelookup) to high(drawtypelookup) do
      begin
        if drawtypelookup[i] = tbdtCircle then
          Dlg.lkUpRound := i
        else if drawtypelookup[i] = tbdtSquare then
          Dlg.lkUpSquare := i
        else if drawtypelookup[i] = tbdtDiamond then
          Dlg.lkUpDiamond := i
      end;
//      case drawtypelookup[TTillButton(Obj).BackdropID] of
//        tbdtSquare : Dlg.ComboBox1.ItemIndex := 1;
//        tbdtDiamond : Dlg.ComboBox1.ItemIndex := 2;
//        else Dlg.ComboBox1.ItemIndex := 0;
//      end;

      if Dlg.ShowModal = mrOk then
      begin
        // the Backdrop has already been saved to ThemeOutletTable when the Seat Plan was
        // closed with mrOK and ThemeOutletTablePlanButton backdrop is synchronised with
        // ThemeOutletTable when the panel is loaded so the Save and Revert actions
        // won't alter any data and should not be enabled (when PanelManager.DetailsModified = TRUE)
        // for this type of change
        PanelDetailsModified := PanelManager.DetailsModified;
        SaveSeatChanges(Dlg.FTableNumber);
        case dlg.SeatPlan1.TableShape of
          0 : TempBackdrop := Dlg.lkUpRound;
          1 : TempBackdrop := Dlg.lkUpSquare;
          2 : TempBackdrop := Dlg.lkUpDiamond;
        else
          TempBackdrop := TTillButton(Obj).backdropid;
        end;
        if TempBackdrop <> TTillButton(Obj).backdropid then
          TTillButton(Obj).backdropid := TempBackdrop;
        updatetableinstances(Dlg.FTableNumber, TTillButton(Obj).backdropid);
        PanelManager.DetailsModified := PanelDetailsModified;
      end;
    finally
      Dlg.Free;
    end;
  end;
end;


//------------------------------------------------------------------------------
procedure TEditOutletTablePlan.NewTableClick(Sender: TObject);
var
  mousepos: TPoint;
  draw_Type : TTillButtonDrawType;
  i, BackgroundTypeId : integer;
  mySQL : string;
begin
  BackgroundTypeId := 0;
  draw_Type := tbdtSquare;
  
  mousepos := screentoclient(popup_cursorpos);
  with TEnterTableNumberDialog.create(self) do try
    if showmodal = mrOk then
    begin
      case TMenuItem(Sender).Tag of
        0 : draw_Type := tbdtCircle;
        1 : draw_Type := tbdtSquare;
        2 : draw_Type := tbdtDiamond;
      end;
      for i := low(drawtypelookup) to high(drawtypelookup) do
        if drawtypelookup[i] = draw_type then
           BackgroundTypeId := i;
      if gettableinstances(strtoint(edTableNumber.text)) > 0 then
        MessageDlg(format('Table %d is already on one or more site table plans - existing tables will be updated.'#10'Please check the seating plan for this table.', [strtoint(edTableNumber.text)]), mtInformation, [mbOk], 0);
      try
        panelmanager.AddTable(mousepos.X, mousepos.y, strtoint(edTableNumber.text), draw_Type);
        // 340227 changed to be consistent with table shape change in SeatPlan, i.e. all the
        // chairs are deleted.  This code previously only deleted chairs if the shape was
        // changed to round.
        mySQL :=
          format('DECLARE @Present int, @SiteCode int, @TableNumber int, @Backdrop int ' + #13#10 +
                 'SET @SiteCode = %d  SET @TableNumber = %d SET @Backdrop = %d ' + #13#10 +
                 'SELECT @Present  = COUNT(*) ' + #13#10 +
                 'FROM ThemeOutletTable ' + #13#10 +
                 'WHERE  SiteCode = @SiteCode AND TableNumber = @TableNumber ' + #13#10 +
                 '            ' + #13#10 +
                 'IF (@Present = 0) ' + #13#10 +
                 'BEGIN ' + #13#10 +
                 '  INSERT INTO ThemeOutletTable (Sitecode,  TableNumber,  BackDrop,  HasSeatPlan, HorizSize, VertSize, SeatRotation, ClockWise, CircleOffset) ' + #13#10 +
                 '  VALUES (@SiteCode, @TableNumber, @Backdrop, 0, 0.20, 0.20, 1, 1, 0) ' + #13#10 +
                 'END ' + #13#10 +
                 'ELSE ' + #13#10 +
                 'BEGIN ' + #13#10 +
                 '  UPDATE ThemeOutletTable ' + #13#10 +
                 '    SET BackDrop = @Backdrop, ' + #13#10 +
                 '        HasSeatPlan = 0, ' + #13#10 +
                 '        NumSeats1 = 0, NumSeats2 = 0, NumSeats3 = 0, NumSeats4 = 0 ' + #13#10 +
                 '  WHERE SiteCode = @SiteCode AND TableNumber = @TableNumber ' + #13#10 +
                 '            ' + #13#10 +
                 '  DELETE FROM themeoutlettableseat ' + #13#10 +
                 '  WHERE sitecode = @SiteCode AND tablenumber = @TableNumber ' + #13#10 +
                 'END',
                 [dmThemeData.qOutlets.fieldbyname('SiteCode').asinteger,
                 strtoint(edTableNumber.text),
                 BackgroundTypeId]);
        dmThemeData.adoqRun.SQL.Text := MySQL;
        dmThemeData.adoqRun.ExecSQL;
        dmThemeData.adoqRun.SQL.Clear;
        updatetableinstances(strtoint(edTableNumber.text), BackgroundTypeId);

      except
        Raise;
      end;
    end;
  finally
    free;
  end;
end;



procedure TEditOutletTablePlan.NewSquareTableClick(Sender: TObject);
var
  mousepos: TPoint;
begin
  mousepos := screentoclient(popup_cursorpos);
  with TEnterTableNumberDialog.create(self) do try
    if showmodal = mrOk then
      panelmanager.AddTable(mousepos.X, mousepos.y, strtoint(edTableNumber.text), tbdtSquare);
  finally
    free;
  end;
end;

procedure TEditOutletTablePlan.NewLabelClick(Sender: TObject);
var
  mousepos: TPoint;
begin
  mousepos := screentoclient(popup_cursorpos);
  panelmanager.AddLabel(mousepos.X, mousepos.y);
end;

procedure TEditOutletTablePlan.NewDiamondTableClick(Sender: TObject);
var
  mousepos: TPoint;
begin
  mousepos := screentoclient(popup_cursorpos);
  with TEnterTableNumberDialog.create(self) do try
    if showmodal = mrOk then
      panelmanager.AddTable(mousepos.X, mousepos.y, strtoint(edTableNumber.text), tbdtDiamond);
  finally
    free;
  end;
end;

procedure TEditOutletTablePlan.NewRoundTableClick(Sender: TObject);
var
  mousepos: TPoint;
begin
  mousepos := screentoclient(popup_cursorpos);
  with TEnterTableNumberDialog.create(self) do try
    if showmodal = mrOk then
      panelmanager.AddTable(mousepos.X, mousepos.y, strtoint(edTableNumber.text), tbdtCircle);
  finally
    free;
  end;
end;

procedure TEditOutletTablePlan.OnObjectContextClick(obj: TTillObject);
begin
  // todo: when user clicks the right button on an object, the form popup
  // menu is still shown. Ideally this should be prevented. Raising an exception
  // here does not prevent the pop up.
end;

procedure TEditOutletTablePlan.AddSelectedToDeletedList();
var
  tablenumber: string;
begin
  if assigned(panelmanager.selectedobject) then
  begin
    // delete table if this deletion would cause a table to
    // no longer be referenced. todo: save table/seat details in memory
    // along with seating plan data.
    if panelmanager.selectedobject is TTillButton then
    begin
      tablenumber := TTillButton(panelmanager.selectedobject).ButtonTypeData;
      if deletedtables.indexof(tablenumber) = -1 then
        deletedtables.add(tablenumber);
    end;
  end;
end;

procedure TEditOutletTablePlan.ProcessDeletedList();
var
  outletid: integer;
  tablenumber: integer;
  refcount: integer;
  i,j : integer;
begin
  if deletedtables <> nil then
  begin
    // delete table if its no longer referenced.
    for j := 0 to pred(deletedtables.Count) do
    begin
      tablenumber := strtoint(deletedtables[j]);
      with udmthemedata.dmThemeData.adoqRun do
      begin
        outletid := self.tableplansitecode;
        sql.text := format('select count(*) as numtables '+
          'from themeoutlettableplan a '+
          'join themeoutlettableplanbutton b on (a.outlettableplanid = b.outlettableplanid) '+
          'and b.buttontypechoiceid = (select id from themebuttontypechoicelookup where name = ''SelectTable'') '+
          'where a.sitecode = %d and not(b.buttontypechoiceattr01 is null) '+
          'and cast(b.buttontypechoiceattr01 as int) = %d', [outletid, tablenumber]);

                  
        open;
        refcount := fieldbyname('numtables').asinteger;
        close;
        for i := 0 to pred(panelmanager.componentcount) do
        begin
          if (panelmanager.components[i] is TTillButton)
            //and (TTillbutton(panelmanager.components[i]).kwp = false)
            and (TTillbutton(panelmanager.components[i]).kip = true) then
          begin
            if strtoint(TTillButton(panelmanager.Components[i]).ButtonTypeData) = tablenumber then
            begin
              // theres an unsaved button
              inc(refcount);
            end;
          end;
        end;
        if refcount = 0 then
        begin
          sql.text := format('delete themeoutlettable where sitecode = %d and tablenumber = %d '+
            'delete themeoutlettableseat where sitecode = %d  and tablenumber = %d ',
            [outletid, tablenumber, outletid, tablenumber]);
          execsql;
        end;
      end;
    end;
  end;
end;

procedure TEditOutletTablePlan.PopupMenu1Popup(Sender: TObject);
begin
  popup_cursorpos := mouse.cursorpos;
  panelmanager.SnapPointToGrid(popup_cursorpos);
end;

procedure TEditOutletTablePlan.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
  deletedtables := TStringlist.create;
  with dmThemeData do
  begin
    if not GetStoredMetrics(self, true) then
    begin
      top := (screen.Height - height) div 2;
      left := (screen.Width - width) div 2;
    end;
  end;
end;

procedure TEditOutletTablePlan.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
  with dmThemeData do
  begin
    StoreMetrics(self, true);
  end;
  if deletedtables <> nil then
  begin
    deletedtables.Free;
    deletedtables := nil;
  end;
end;

procedure TEditOutletTablePlan.SavePanelUpdate(Sender: TObject);
begin
  TAction(sender).enabled := panelmanager.detailsmodified or panelmanager.PanelModified;
end;

procedure TEditOutletTablePlan.RevertPanelUpdate(Sender: TObject);
begin
  TAction(sender).enabled := panelmanager.detailsmodified or panelmanager.PanelModified;
end;

procedure TEditOutletTablePlan.SavePanelExecute(Sender: TObject);
begin
  Log('Saving Table Plan ' + IntToStr(panelmanager.PanelID));
  panelmanager.SavePanel(dmThemeData.AztecConn);
  ProcessDeletedList();
  if deletedtables <> nil then
  begin
    deletedtables.Clear();
  end;
end;

procedure TEditOutletTablePlan.RevertPanelExecute(Sender: TObject);
begin
  Log('Revert Button Clicked While editing Panel ID ' + IntToStr(panelmanager.panelid));
  panelmanager.LoadPanel(dmthemedata.aztecconn, panelmanager.panelid, lpmTablePlan, tableplansitecode);
  if deletedtables <> nil then
  begin
    deletedtables.Clear();
  end;
end;

procedure TEditOutletTablePlan.Button1Click(Sender: TObject);
begin
  ButtonClicked(Sender);
  Close;
end;

procedure TEditOutletTablePlan.CheckSaveChanges;
begin
  if PanelManager.panelmodified or PanelManager.detailsmodified then
    if messagedlg('Do you want to save changes?', mtConfirmation, [mbYes, mbNo], 0) =
      mrYes then SavePanel.Execute;
end;

procedure TEditOutletTablePlan.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_DELETE then
  begin
    AddSelectedToDeletedList();
    PanelManager.delete;
  end;
end;

//------------------------------------------------------------------------------
procedure TEditOutletTablePlan.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not ThemeModellingMenu.ApplicationClosing then
    CheckSaveChanges;
end;

function TEditOutletTablePlan.GetTableInstances(tablenumber: integer): integer;
var
  i: integer;
begin
  result := 0;
  for i := 0 to pred(controlcount) do
  begin
    if (controls[i] is TTillButton) and (TTillButton(controls[i]).ButtonTypeData = inttostr(tablenumber)) and (TTillButton(controls[i]).kip) then
      inc(result);
  end;
  with dmThemeData.adoqRun do
  begin
    sql.text := format('select count(*) as count from themeoutlettableplan a '+
      'join themeoutlettableplanbutton b on a.outlettableplanid = b.outlettableplanid and a.sitecode = %d '+
      'where a.outlettableplanid <> %d and buttontypechoiceattr01 = %d', [tableplansitecode, tableplanid, tablenumber]);
    open;
    inc(result, fieldbyname('count').asinteger);
    close;
  end;
end;



procedure TEditOutletTablePlan.UpdateTableInstances(tablenumber: integer; backdropid: integer);
var
  i: integer;
begin
  for i := 0 to pred(controlcount) do
  begin
    if (controls[i] is TTillButton)
      and (TTillButton(controls[i]).ButtonTypeData = inttostr(tablenumber))
      and (TTillButton(controls[i]).kip)
      and (TTillButton(controls[i]).BackdropID <> backdropid) then
    begin
      TTillButton(controls[i]).BackdropID := backdropid;
    end;
  end;
  with dmThemeData.adoqRun do
  begin
    sql.text := format('update themeoutlettableplanbutton set backdrop = %d '+
      'where buttontypechoiceattr01 = %d and outlettableplanid  in ( '+
      ' select outlettableplanid from themeoutlettableplan where sitecode = %d and outlettableplanid <> %d)',
      [backdropid, tablenumber, tableplansitecode, tableplanid]);
    execsql;
  end;
end;


procedure TEditOutletTablePlan.CreateTempSeatTable(TableNumber: integer);
begin
  with dmThemeData.adoqRun do
  begin
      SQL.Text :=
        format('IF OBJECT_ID(''tempdb..' + TempSeatTableName + ''') IS NOT NULL ' + #13#10 +
               '  DROP TABLE ' + TempSeatTableName + ' ' + #13#10 +
               'DECLARE @SiteCode int, @TableNumber int ' + #13#10 +
               'SET @SiteCode = %d ' + #13#10 +
               'SET @TableNumber = %d ' + #13#10 +
               ' ' + #13#10 +
               'SELECT s.SiteCode, s.TableNumber, s.SeatNumber, s.X, s.Y ' + #13#10 +
               'INTO ' + TempSeatTableName + ' ' + #13#10 +
               'FROM ThemeOutletTable t ' + #13#10 +
               'JOIN ThemeOutletTableSeat s ON t.SiteCode = s.SiteCode AND t.TableNumber = s.TableNumber ' + #13#10 +
               'WHERE t.SiteCode = @SiteCode AND t.TableNumber = @TableNumber ' + #13#10 +
               'ORDER BY s.SiteCode, s.TableNumber, s.SeatNumber ',[TablePlanSiteCode, TableNumber]);
        ExecSQL;
  end;
end;


procedure TEditOutletTablePlan.SaveSeatChanges(TableNumber: integer);
begin
  with dmThemeData.adoqRun do
  begin
    SQL.Text :=
      format(
             'DECLARE @Sitecode int, @TableNumber int, @Error int ' + #13#10 +
             'SET @SiteCode = %d ' + #13#10 +
             'SET @TableNumber = %d ' + #13#10 +
             'SET @Error = 0 ' + #13#10 +
             'BEGIN TRANSACTION ' + #13#10 +
             '  DELETE ThemeOutletTableSeat ' + #13#10 +
             '  WHERE SiteCode = @SiteCode ' + #13#10 +
             '  AND TableNumber = @TableNumber '  + #13#10 +
             '  SET @Error = @Error + @@ERROR    '  + #13#10 +
             '  INSERT ThemeOutletTableSeat ' + #13#10 +
             '  SELECT * FROM ' + TempSeatTableName + ' ' + #13#10 +
             '  SET @Error = @Error + @@ERROR ' + #13#10 +
             '  IF (@Error <> 0) ' + #13#10 +
             '    ROLLBACK TRANSACTION ' + #13#10 +
             '  ELSE ' + #13#10 +
             '    COMMIT TRANSACTION ' + #13#10 +
             'DROP TABLE ' + TempSeatTableName + ' ',[TablePlanSiteCode,TableNumber]);
    ExecSQL;
  end;
end;

end.
