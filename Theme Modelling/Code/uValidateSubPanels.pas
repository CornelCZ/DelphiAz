unit uValidateSubPanels;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ActnMan, Grids, Wwdbigrd, Wwdbgrid, StdCtrls, ExtCtrls,
  DB, ADODB, UTillButton, ImgList;

type
  TfrmSubPanelValidate = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    wwDBGrid1: TwwDBGrid;
    ActionManager1: TActionManager;
    AOK: TAction;
    ACancel: TAction;
    dsGrid: TDataSource;
    ImageList1: TImageList;
    spImpliedPanels: TADOStoredProc;
    spImpliedPanelsOrigin: TLargeintField;
    spImpliedPanelsOpens: TLargeintField;
    spImpliedPanelsName: TStringField;
    spImpliedPanelsWidth: TIntegerField;
    spImpliedPanelsHeight: TIntegerField;
    spImpliedPanelsLeft: TIntegerField;
    spImpliedPanelsTop: TIntegerField;
    spImpliedPanelsTopInButtons: TIntegerField;
    spImpliedPanelsLeftInButtons: TIntegerField;
    spImpliedPanelsPosOK: TIntegerField;
    spImpliedPanelsHideOrderDisplay: TBooleanField;
    procedure ExecuteOK(Sender: TObject);
    procedure ACancelExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qTempCalcFields(DataSet: TDataSet);
    procedure wwDBGrid1RowChanged(Sender: TObject);
    procedure qTempAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
  private
    procedure SetSharedPanelPos(Top, Left: Integer);
    { Private declarations }
  public
    FPanelManager : TPanelManager;
    FObject : TTillObject;
    AddingPanel, AddPanelValid, AddingSubPanelItem: boolean;
    procedure Init;
  end;

var
  frmSubPanelValidate: TfrmSubPanelValidate;

implementation

uses
  udmThemeData, uButtonPicker, uEditPanelDesign, uAztecLog,
  uTillSubPanelEditor;

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TfrmSubPanelValidate.ExecuteOK(Sender: TObject);
var
  CanClose : Boolean;
  PanelTop, PanelLeft, PanelWidth, PanelHeight : Integer;
  PanelRect: TRect;
begin
  ButtonClicked(Sender);
  with dsGrid.DataSet do
  begin
    AddPanelValid := true;
    CanClose := True;
    FPanelManager.AddingSharedPanel := False;
    disablecontrols;
    First;
    While Not eof do
    begin
      //** Same as below in Calc Fields
      //** Following bit requires a bit of messing. Because the Pixel values returned by the
      //** query may have very slight rounding problems use the Top/Left in buttons
      //** and the buttonwidth/Height to decide if the position os OK
      //** This was only a problem on the initial load, when valid position may be flagged
      //** as invalid. THe panel Manager does not have the same rounding issues as it
      //** uses pixel values so once it moved, even if it was back to the original
      //** invalid position it would then become OK.

      PanelRect := FPanelManager.pd.ButtonToPixelCoords(
        Rect(
          FieldByName('Left').AsInteger,
          FieldByName('Top').AsInteger,
          FieldByName('Width').AsInteger,
          FieldByName('Height').AsInteger
        ), true);

      if not FPanelManager.NewPanelPosValid(
        PanelRect.Top, PanelRect.Left, PanelRect.Bottom, PanelRect.Right,
        FieldByName('HideOrderDisplay').AsBoolean) then

      begin
        AddPanelValid := false;
        FPanelManager.AddingSharedPanel := True;
        EnableControls;
        Exit;
      end;
      next
    end;
    if CanClose then
    begin
      first;
      dmThemeData.adoqRun.SQL.Text := 'Delete From ThemePanelSharedPos where PanelID = :PanelID and PanelDesignID = :PanelDesignID';
      dmThemeData.adocRun.CommandText := 'Insert Into ThemePanelSharedPos (PanelID, [Left], [Top], PanelDesignID) '+
                                          'Values (:PanelID,:Left, :Top, :PanelDesignID)';
      while not EOF do
      begin
        dmThemeData.adoqRun.Parameters.ParamByName('PanelID').Value := FieldByName('Opens').AsInteger;
        dmThemeData.adoqRun.Parameters.ParamByName('PanelDesignID').Value := FPanelManager.PanelDesign;
        dmThemeData.adoqRun.ExecSQL;

        dmThemeData.adocRun.Parameters.ParamByName('PanelID').Value := FieldByName('Opens').AsInteger;
        dmThemeData.adocRun.Parameters.ParamByName('PanelDesignID').Value := FPanelManager.PanelDesign;

        PanelLeft := fieldbyname('Left').asInteger;
        PanelTop := fieldbyname('Top').asInteger;
        PanelWidth := fieldbyname('Width').asInteger;
        PanelHeight := fieldbyname('Height').asInteger;

        dmThemeData.adocRun.Parameters.ParamByName('Left').Value := (PanelLeft*1.0 + PanelWidth/2.0)/FPanelManager.pd.NumButtonsX;
        dmThemeData.adocRun.Parameters.ParamByName('Top').Value := (PanelTop*1.0 + PanelHeight/2.0)/FPanelManager.pd.NumButtonsY;
        dmThemeData.adocRun.Execute;
        Next;
      end;
    end
    else
      Exit;
  end;
  FPanelManager.AddingSharedPanel := False;
  spImpliedPanels.Close;
  close;
end;

//------------------------------------------------------------------------------
procedure TfrmSubPanelValidate.SetSharedPanelPos(Top, Left : Integer);
var
  PanelWasValid: boolean;
  TmpRecNo: integer;
  PanelButtonCoords: TRect;
begin
  PanelButtonCoords := FPanelManager.pd.PixelToButtonCoords(Rect(Left, Top, 0, 0));

  spImpliedPanels.Edit;
  PanelWasValid := spImpliedPanels.FieldByName('PosOk').AsInteger = 1;
  spImpliedPanels.FieldByName('Top').AsInteger := PanelButtonCoords.Top;
  spImpliedPanels.FieldByName('Left').AsInteger := PanelButtonCoords.Left;
  PanelButtonCoords.Right := spImpliedPanels.FieldByName('Width').AsInteger;
  PanelButtonCoords.Bottom := spImpliedPanels.FieldByName('Height').AsInteger;
  spImpliedPanels.Post;
  if not PanelWasValid and (spImpliedPanels.FieldByName('PosOk').AsInteger = 1) then
  with spImpliedPanels do
  begin
    // Apply change to panel that was just made valid, and recalculate
    // defaults which may apply to other panels.
    dmThemeData.adoqRun.SQL.Text :=
      Format('delete from ThemePanelSharedPos where PanelID = %d and PanelDesignID = %d', [FieldByName('Opens').AsInteger, FPanelManager.PanelDesign]);
    dmThemeData.adoqRun.ExecSQL;
    dmThemeData.adoqRun.SQL.Text :=
      Format('insert ThemePanelSharedPos (PanelID, PanelDesignID, [Left], [Top]) '+
        'select %d, %d, %f, %f', [FieldByName('Opens').AsInteger, FPanelManager.PanelDesign,
        (PanelButtonCoords.Left*1.0 + PanelButtonCoords.Right/2.0) / FPanelManager.pd.NumButtonsX,
        (PanelButtonCoords.Top*1.0 + PanelButtonCoords.Bottom/2.0) / FPanelManager.pd.NumButtonsY
    ]);
    dmThemeData.adoqRun.ExecSQL;
    dmThemeData.qSetDefaultSPPos.ExecSQL;
    TmpRecNo := spImpliedPanels.RecNo;
    spImpliedPanels.Close;
    spImpliedPanels.Parameters[1].Value := FPanelManager.PanelDesign;
    if FObject is TTillButton then
      spImpliedPanels.Parameters[2].Value := StrToInt(TTillButton(FObject).ButtonTypeData)
    else
      spImpliedPanels.Parameters[2].Value := TTillSubPanel(FObject).SubPanelID;

    spImpliedPanels.Open;
    spImpliedPanels.RecNo := TmpRecNo;
  end;
end;

//------------------------------------------------------------------------------
procedure TfrmSubPanelValidate.Init;
begin
//  if ButtonPicker.Visible then
//    ButtonPicker.Hide;
  FPanelManager.AddingSharedPanel := true;
  EditPanelDesign.cbPickPanel.enabled := false;
  Buttonpicker.Enabled := false;

  spImpliedPanels.Parameters[1].Value := FPanelManager.PanelDesign;
  if FObject is TTillButton then
    spImpliedPanels.Parameters[2].Value := StrToInt(TTillButton(FObject).ButtonTypeData)
  else
    spImpliedPanels.Parameters[2].Value := TTillSubPanel(FObject).SubPanelID;
  spImpliedPanels.Open;
  if spImpliedPanels.RecordCount <> 0 then
  begin
    spImpliedPanels.First;
    FPanelManager.pd.SetBoundsFromDataSet(FPanelManager.SPOL, spImpliedPanels);
    FPanelManager.OnMoveSPOL := SetSharedPanelPos;
  end
  else
  begin
    FPanelManager.AddingSharedPanel := False;
    Self.close;
  end;
end;

//------------------------------------------------------------------------------
procedure TfrmSubPanelValidate.ACancelExecute(Sender: TObject);
begin
  ButtonClicked(sender);
  close;
end;

//------------------------------------------------------------------------------
procedure TfrmSubPanelValidate.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
  FPanelManager.AddingSharedPanel := false;
  EditPanelDesign.cbPickPanel.enabled := true;
  ButtonPicker.Enabled := true;
  if AddingPanel and not(AddPanelValid)then
  begin
    FObject.Delete;
  end;
  if AddingSubPanelItem and not(AddPanelValid) then
  begin
    with TTillSubPanelEditor.Create(nil) do
    begin
      SubPanel := TTillSubPanel(FObject);
      RevertData;
      Free;
    end;
  end;
  action := caFree;
end;

//------------------------------------------------------------------------------
procedure TfrmSubPanelValidate.qTempCalcFields(DataSet: TDataSet);
var
  PanelRect: TRect;
begin
  with FPanelManager, DataSet do
  begin
    PanelRect := FPanelManager.pd.ButtonToPixelCoords(
      Rect(
        FieldByName('Left').AsInteger,
        FieldByName('Top').AsInteger,
        FieldByName('Width').AsInteger,
        FieldByName('Height').AsInteger
      ), true);

    DataSet.FieldByName('posok').AsInteger := Integer(FPanelManager.NewPanelPosValid(
      PanelRect.Top, PanelRect.Left, PanelRect.Bottom, PanelRect.Right,
      FieldByName('HideOrderDisplay').AsBoolean));
  end;
end;

//------------------------------------------------------------------------------
procedure TfrmSubPanelValidate.wwDBGrid1RowChanged(Sender: TObject);
begin
end;

//------------------------------------------------------------------------------
procedure TfrmSubPanelValidate.qTempAfterScroll(DataSet: TDataSet);
begin
  FPanelManager.pd.SetBoundsFromDataSet(FPanelManager.SPOL, spImpliedPanels);
  FPanelManager.SPOL.HideOrderDisplay := spImpliedPanels.FieldByName('HideOrderDisplay').AsBoolean;
end;

//------------------------------------------------------------------------------
procedure TfrmSubPanelValidate.FormShow(Sender: TObject);
begin
  Log('Form Show ' +Caption);
end;

end.
