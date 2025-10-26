unit uSelectReasonsFrame;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ActnList, Contnrs;

type
  TNoArgsProc = procedure of object;

  TSelectReasonsFrame = class(TFrame)
    pnlClient: TPanel;

    pnlLeft: TPanel;
    lblSelectedReasons: TLabel;
    lbSelectedReasons: TListBox;
    pnlButtons: TPanel;
    btnSelect: TButton;
    btnDeselect: TButton;

    pnlRight: TPanel;
    lbAvailableReasons: TListBox;
    lblAvailableReasons: TLabel;
    actlSelectReasons: TActionList;
    actMoveToAvailable: TAction;
    actMoveToSelected: TAction;

    pnlBottom: TPanel;
    btnSave: TButton;
    btnCancel: TButton;

    procedure actMoveToAvailableUpdate(Sender: TObject);
    procedure actMoveToAvailableExecute(Sender: TObject);
    procedure actMoveToSelectedExecute(Sender: TObject);
    procedure actMoveToSelectedUpdate(Sender: TObject);
    procedure pnlClientResize(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    FAllReasonsSQL: string;
    FBehaveAsDialog: boolean;
    FPerformSave: TNoArgsProc;
    FUnsavedChanges: boolean;
    FMaximumAssignedReasonCount: Integer;

    AvailableReasonsList: TStringList;
    ChosenReasonsList: TStringList;
    procedure TransferReason(SourceList, DestinationList: TListBox);
    procedure InitialiseReasonsLists;
    function GetChosenReasons: TStrings;
    procedure ClearLists;
    procedure SetBehaveAsDialog(const value: boolean);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // This property must be set to a SQL statement which returns a dataset (ReasonId int, Used bit) conatining all reason Ids
    // from ThemeReason with [Used] set to 1 if the reason is currently selected for the purpose the frame is being used for.
    property AllReasonsSQL: string read FAllReasonsSQL write FAllReasonsSQL;

    property BehaveAsDialog: boolean read FBehaveAsDialog write SetBehaveAsDialog;  //Just changes behaviour of Cancel button
    property PerformSave: TNoArgsProc read FPerformSave write FPerformSave;
    property ChosenReasons: TStrings read GetChosenReasons;
    property MaximumAssignedReasonCount: Integer write FMaximumAssignedReasonCount;
    procedure Initialise;
    procedure SaveAnyChanges;
  end;

implementation

uses uADO;

{$R *.dfm}

const
  MAXIMUM_ASSIGNED_REASON_COUNT = 20;

//TODO: Action-ise the Save and Cancel buttons

{ TSelectReasonsFrame }

constructor TSelectReasonsFrame.Create(AOwner: TComponent);
begin
  inherited;

  AvailableReasonsList := TStringList.Create;
  ChosenReasonsList := TStringList.Create;

  pnlClient.DoubleBuffered := True;
  pnlLeft.DoubleBuffered := True;
  pnlRight.DoubleBuffered := True;
  pnlButtons.DoubleBuffered := True;
  lbSelectedReasons.DoubleBuffered := True;
  lbAvailableReasons.DoubleBuffered := True;

  FBehaveAsDialog := false;
  FUnsavedChanges := false;

  FMaximumAssignedReasonCount := MAXIMUM_ASSIGNED_REASON_COUNT;
end;

destructor TSelectReasonsFrame.Destroy;
begin
  inherited;

  ClearLists;
  AvailableReasonsList.Free;
  ChosenReasonsList.Free;
end;

procedure TSelectReasonsFrame.SetBehaveAsDialog(const value: boolean);
begin
  FBehaveAsDialog := value;
  btnCancel.Enabled := value;
end;

procedure TSelectReasonsFrame.ClearLists;
begin
  AvailableReasonsList.Clear;
  ChosenReasonsList.Clear;
end;

procedure TSelectReasonsFrame.Initialise;
begin
  InitialiseReasonsLists;
end;

procedure TSelectReasonsFrame.InitialiseReasonsLists;
begin
  Assert(FAllReasonsSQL <> '', 'AllReasonsSQL property has not been set');

  ClearLists;

  with dmADO.adoqRun do
  try
    Close;
    SQL.Text := FAllReasonsSQL;
    Open;
    while not Eof do
    begin
      if FieldByName('Used').AsBoolean then
        ChosenReasonsList.AddObject(FieldByName('Name').AsString, TObject(FieldByName('ReasonID').AsInteger))
      else
        AvailableReasonsList.AddObject(FieldByName('Name').AsString, TObject(FieldByName('ReasonID').AsInteger));
      Next;
    end;
  finally
    Close
  end;

  ChosenReasonsList.Sorted := True;
  AvailableReasonsList.Sorted := True;

  lbSelectedReasons.Sorted := True;
  lbAvailableReasons.Sorted := True;

  lbSelectedReasons.Items.Assign(ChosenReasonsList);
  lbAvailableReasons.Items.Assign(AvailableReasonsList);

  FUnsavedChanges := false;
  btnSave.Enabled := false;
  btnCancel.Enabled := FBehaveAsDialog;
end;


procedure TSelectReasonsFrame.TransferReason(SourceList, DestinationList: TListBox);
var
  OldIndex: Integer;
  NewDestinationIndex: Integer;
begin
  SourceList.Items.BeginUpdate;
  DestinationList.Items.BeginUpdate;
  try
    if SourceList.Count <> 0 then
    begin
      if SourceList.ItemIndex = -1 then
        SourceList.ItemIndex := 0;

      OldIndex := SourceList.ItemIndex;

      NewDestinationIndex := DestinationList.Items.AddObject(SourceList.Items[SourceList.ItemIndex],
                                                             SourceList.Items.Objects[SourceList.ItemIndex]);
      SourceList.DeleteSelected;

      SourceList.ItemIndex := SourceList.Count - 1;
      if SourceList.Count - 1 >= OldIndex then
        SourceList.ItemIndex := OldIndex;

      DestinationList.ItemIndex := NewDestinationIndex;

      btnSave.Enabled := true;
      btnCancel.Enabled := true;
      FUnsavedChanges := true;
    end;
  finally
    SourceList.Items.EndUpdate;
    DestinationList.Items.EndUpdate;
  end;
end;

procedure TSelectReasonsFrame.actMoveToAvailableUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := lbSelectedReasons.Count > 0;
end;

procedure TSelectReasonsFrame.actMoveToAvailableExecute(Sender: TObject);
begin
  TransferReason(lbSelectedReasons,lbAvailableReasons);
end;

procedure TSelectReasonsFrame.actMoveToSelectedExecute(Sender: TObject);
begin
  if lbSelectedReasons.Count < FMaximumAssignedReasonCount then
    TransferReason(lbAvailableReasons, lbSelectedReasons)
  else
    ShowMessage('A maximum of ' + IntToStr(FMaximumAssignedReasonCount) +
      ' reasons can be assigned.');
end;

procedure TSelectReasonsFrame.actMoveToSelectedUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := lbAvailableReasons.Count > 0;
end;


procedure TSelectReasonsFrame.pnlClientResize(Sender: TObject);
begin
  pnlLeft.ClientWidth := (pnlClient.ClientWidth + pnlButtons.ClientWidth) div 2;
end;

procedure TSelectReasonsFrame.SaveAnyChanges;
begin
  Assert(Assigned(PerformSave), 'PerformSave handler has not been assigned');

  if not FUnsavedChanges then
    Exit;

  PerformSave;

  btnSave.Enabled := False;

  if not FBehaveAsDialog then
    btnCancel.Enabled := False;

  FUnsavedChanges := false
end;


procedure TSelectReasonsFrame.btnSaveClick(Sender: TObject);
begin
  SaveAnyChanges;
end;

function TSelectReasonsFrame.GetChosenReasons: TStrings;
begin
  Result := lbSelectedReasons.Items;
end;

procedure TSelectReasonsFrame.btnCancelClick(Sender: TObject);
begin
  if FBehaveAsDialog then
    // Cancel button does nothing just returns mrCancel modal result.
    Exit;

  InitialiseReasonsLists;
  btnSave.Enabled := false;
  btnCancel.Enabled := false;
  FUnsavedChanges := false;
end;

end.
