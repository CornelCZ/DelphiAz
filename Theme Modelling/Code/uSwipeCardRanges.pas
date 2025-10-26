unit uSwipeCardRanges;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ExtCtrls, StdCtrls, Grids, Wwdbigrd, Wwdbgrid,
  ComCtrls;

type
  TProtectionHackCheckBox = class(TCheckBox);

  TDisableControlsProc = procedure(ParentControl: TWinControl);

  TfrmSwipeCardRanges = class(TForm)
    pnlMain: TPanel;
    btnClose: TButton;
    pcRanges: TPageControl;
    tsCardRanges: TTabSheet;
    tsGroups: TTabSheet;
    dsSwipeCards: TDataSource;
    qrySwipeCards: TADOQuery;
    qrySwipeCardsDescription: TStringField;
    qrySwipeCardsStartValue: TStringField;
    qrySwipeCardsEndValue: TStringField;
    qrySwipeCardsTrack: TSmallintField;
    qrySwipeCardsSwipeCardrangeID: TLargeintField;
    gridSwipeCards: TwwDBGrid;
    btnAdd: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    btnExceptions: TButton;
    grbxCardGroups: TGroupBox;
    cbxGroupNames: TComboBox;
    btnAddGroup: TButton;
    btnDeleteGroup: TButton;
    lbSelectedRanges: TListBox;
    lbAvailableRanges: TListBox;
    btnMoveToSelected: TButton;
    btnMoveToAvail: TButton;
    Label1: TLabel;
    Label2: TLabel;
    qrySwipeCardsPromotional: TBooleanField;
    btnValidationConfigs: TButton;
    qrySwipeCardsLoyalty: TBooleanField;
    qrySwipeCardsURL: TSmallintField;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure gridSwipeCardsDblClick(Sender: TObject);
    procedure btnExceptionsClick(Sender: TObject);
    procedure pcRangesChange(Sender: TObject);
    procedure btnAddGroupClick(Sender: TObject);
    procedure btnDeleteGroupClick(Sender: TObject);
    procedure cbxGroupNamesChange(Sender: TObject);
    procedure btnMoveToSelectedClick(Sender: TObject);
    procedure btnMoveToAvailClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure pcRangesChanging(Sender: TObject; var AllowChange: Boolean);
    procedure cbxGroupNamesDropDown(Sender: TObject);
    procedure btnValidationConfigsClick(Sender: TObject);
    procedure gridSwipeCardsRowChanged(Sender: TObject);
  private
    GroupList : TStringList;
    activeGroupID : Integer;
    modifiedLists : Boolean;
    FisPromotional : Boolean;
    FReadOnly: Boolean;
    FDisableControls: TDisableControlsProc;
    function PopulateGroupList : TStrings;
    procedure loadSwipeCardRanges(activeGroupID : Integer);
    procedure loadSelectedCardRanges(activeGroupID: Integer);
    procedure TransferCardRange(ASourceList,
      ADestinationList: TListBox);
    procedure enableMoveCardRanges(Enable: Boolean);
    procedure saveGroupLists;
    function isValidGroup: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ShowSwipeCardRanges(isPromotional : Boolean; ShowReadOnly: Boolean = False; DisableControlsMethod: TDisableControlsProc = nil);

implementation

uses uAdo_SwipeRange, uEditSwipeCardRange, uSwipeCardExceptions, uGenerateThemeIDs,
     uEditValidationConfigs;

{$R *.dfm}

procedure ShowSwipeCardRanges(isPromotional : Boolean; ShowReadOnly: Boolean; DisableControlsMethod: TDisableControlsProc);
var
  Dlg : TfrmSwipeCardRanges;
begin
  Dlg := nil;
  try
    Dlg := TfrmSwipeCardRanges.Create(nil);
    Dlg.FisPromotional := isPromotional;
    Dlg.FReadOnly := ShowReadOnly;
    Dlg.FDisableControls := DisableControlsMethod;
    Dlg.ShowModal;
  finally
    Dlg.Free;
  end
end;

procedure TfrmSwipeCardRanges.FormShow(Sender: TObject);
begin
  if FisPromotional then
    HelpContext := 7105
  else
    HelpContext := 5048;

  btnValidationConfigs.Visible := FisPromotional;
  qrySwipeCards.Parameters[0].Value := FisPromotional;
  qrySwipeCards.Open;

  pcRanges.ActivePage := tsCardRanges;

  if not FisPromotional then
     tsGroups.TabVisible := FisPromotional
  else
     begin
       GroupList := TStringList.Create;

       activeGroupID := 0;
       GroupList.Clear;
       cbxGroupNames.Items.Assign(PopulateGroupList);
       cbxGroupNames.ItemIndex := GroupList.IndexOfObject(TObject(activeGroupID));
       btnValidationConfigs.Enabled := not qrySwipeCards.FieldByName('Loyalty').AsBoolean;
     end;
  if FReadOnly and Assigned(FDisableControls) then
  begin
    FDisableControls(Self);
    btnExceptions.Enabled := True;
    btnValidationConfigs.Enabled := True;
    pnlMain.Enabled := True;
    btnClose.Enabled := True;
    btnEdit.Enabled := True;
  end;
end;

function TfrmSwipeCardRanges.PopulateGroupList : TStrings;
begin
  with dmAdo_SwipeRange.adoqRun do
     begin
       Close;
       SQL.Text := 'SELECT Name, GroupID FROM ThemeSwipeCardGroups WHERE Promotional = '+IntToStr(Integer(FisPromotional)) ;
       Open;

       First;
       while not EOF do
       begin
         if activeGroupID = 0 then
            activeGroupID := FieldByName('GroupID').AsInteger;
         GroupList.AddObject(FieldByName('Name').AsString, TObject((FieldByName('GroupID').AsInteger)));
         Next;
       end;
     end;
   Result := GroupList;
end;

procedure TfrmSwipeCardRanges.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if modifiedLists then
       Abort
  else
    begin
      qrySwipeCards.Close;
      GroupList.Free;
    end
end;

procedure TfrmSwipeCardRanges.btnAddClick(Sender: TObject);
begin
  uEditSwipeCardRange.ShowSwipeCardRange(qrySwipeCards, AddRange, 0, FisPromotional);
end;

procedure TfrmSwipeCardRanges.btnEditClick(Sender: TObject);
begin
  if qrySwipeCards.RecordCount = 0 then
    raise Exception.create('Please pick an item to edit first.');
  uEditSwipeCardRange.ShowSwipeCardRange(qrySwipeCards, EditRange, 0, FisPromotional, FReadOnly, FDisableControls);
end;

procedure TfrmSwipeCardRanges.btnDeleteClick(Sender: TObject);
var
  DeleteErrorMessage: string;

  procedure DeleteRangeFromGroup(SwipeCardRangeID : Integer);
  begin
    with dmADO_SwipeRange.qRun do
    begin
      Close;
      SQL.Text := Format('DELETE FROM ThemeSwipeCardGroupRange WHERE SwipeCardRangeID = %d ', [SwipeCardRangeID]);
      ExecSQL;
    end
  end;

  procedure DeleteRangeFromConfigs(SwipeCardRangeID : Integer);
  begin
    with dmADO_SwipeRange.qRun do
    begin
      Close;
      SQL.Text := Format('DELETE FROM CardRangeValidationConfig WHERE RangeID = %d ', [SwipeCardRangeID]);
      ExecSQL;
    end
  end;

begin
  if qrySwipeCards.RecordCount = 0 then
    raise Exception.create('There are no ranges to delete.');

  with dmADO_SwipeRange.qRun do
  begin
    // Check if swipe range is in use
    SQL.Text := Format('Select count(*) as UseCount From ThemeDiscountCardSecurity where SwipeCardRangeID = %d',
      [qrySwipeCards.FieldByName('SwipeCardRangeID').AsInteger]);
    Open;
    if FieldByName('UseCount').AsInteger > 0 then
    begin
      // Get list of discounts using it
      SQL.Text := Format('select Name from Discount where DiscountID in (select discountID from ThemeDiscountCardSecurity where SwipeCardRangeID = %d)',
       [qrySwipeCards.FieldByName('SwipeCardRangeID').AsInteger]);
      Open;
      DeleteErrorMessage := '';
      while not EOF do
      begin
        DeleteErrorMessage := DeleteErrorMessage + FieldByName('Name').AsString;
        Next;
        if not EOF then
          DeleteErrorMessage := DeleteErrorMessage + ', ';
      end;
      Close;
      Raise Exception.Create('Cannot delete this Card Range as it is in use by the following Discounts:'+#13+
        DeleteErrorMessage);
    end;
    Close;
  end;

  if FisPromotional then
  with dmADO_SwipeRange.qRun do
  begin
    // check to see if the card is the only range assigned to a group.  if it is then do not delete.
    SQL.Text := Format('SELECT tg.Name  '+
                       '       FROM ThemeSwipeCardGroups tg '+
                       '            INNER JOIN (SELECT GroupID, COUNT(RangeID) AS CardCount '+
                       '                               FROM ThemeSwipeCardGroupRange '+
                       '                        WHERE GroupID IN (SELECT GroupID FROM ThemeSwipeCardGroupRange WHERE SwipeCardRangeID = %d) '+
                       '                        GROUP BY GroupID '+
                       '                        HAVING COUNT(RangeID) = 1) ts ON ts.GroupID = tg.GroupID ', [qrySwipeCards.FieldByName('SwipeCardRangeID').AsInteger]);
      Open;

      if RecordCount > 0 then
         begin
           DeleteErrorMessage := '';
           while not EOF do
           begin
             DeleteErrorMessage := DeleteErrorMessage + FieldByName('Name').AsString;
             Next;
             if not EOF then
                DeleteErrorMessage := DeleteErrorMessage + ', ';
           end;

           Raise Exception.Create('Cannot delete this Card Range while its the only Range assigned to the following Groups:'+#13+
                                   DeleteErrorMessage);
         end;
    Close;
  end;

  if MessageDlg(Format('Do you want to delete card range ''%s''?',[qrySwipeCards.FieldByName('Description').AsString]),
      mtConfirmation,
      [mbYes, mbNo],
      0) = mrYes then
  begin
    if FisPromotional then
    begin
      DeleteRangeFromGroup(qrySwipeCards.FieldByName('SwipeCardRangeID').AsInteger);
      DeleteRangeFromConfigs(qrySwipeCards.FieldByName('SwipeCardRangeID').AsInteger);
    end;
    qrySwipeCards.Delete;
  end;
end;

procedure TfrmSwipeCardRanges.gridSwipeCardsDblClick(Sender: TObject);
begin
  btnEdit.Click;
end;

procedure TfrmSwipeCardRanges.btnExceptionsClick(Sender: TObject);
begin
  if qrySwipeCards.RecordCount = 0 then
    raise Exception.create('Please select a vaild security range.')
  else
    with TSwipeCardExceptions.Create(nil) do
       try
         IsPromotional := FisPromotional;
         ReadOnly := FReadOnly;
         DisableControls := FDisableControls;
         SwipeCardRangeID := qrySwipeCards.FieldByName('SwipeCardRangeID').AsInteger;
         StartValue := qrySwipeCards.FieldByName('StartValue').asString;
         EndValue := qrySwipeCards.FieldByName('EndValue').asString;
         if ShowModal = mrOk then
            begin
              Cursor := crDefault;
              ExceptionList.Free;
            end;
       finally
          free;
    end;
end;

procedure TfrmSwipeCardRanges.pcRangesChange(Sender: TObject);
begin
  if pcRanges.ActivePage = tsGroups then
     begin
       if GroupList.Count = 0 then
          enableMoveCardRanges(False);

       loadSwipeCardRanges(activeGroupID);
       loadSelectedCardRanges(activeGroupID);
     end
end;

procedure TfrmSwipeCardRanges.enableMoveCardRanges(Enable : Boolean);
begin
  lbSelectedRanges.Enabled := Enable;
  lbAvailableRanges.Enabled := Enable;

  btnMoveToSelected.Enabled := Enable;
  btnMoveToAvail.Enabled := Enable;
end;

procedure TfrmSwipeCardRanges.loadSwipeCardRanges(activeGroupID : Integer);
begin
  lbAvailableRanges.Items.Clear;
  with dmADO_SwipeRange.qRun do
    begin
      Close;
      SQL.Text := format('SELECT SwipeCardRangeID, Description '+
                         '       FROM ThemeSwipeCardRange '+
                         ' WHERE SwipeCardRangeID NOT IN (SELECT SwipeCardRangeID '+
                         '                                       FROM ThemeSwipeCardGroupRange '+
                         '                                WHERE GroupID = %d) '+
                         '   AND     Promotional = 1 AND Loyalty = 0 ', [activeGroupID]);
      Open;
      First;
      while not EOF do
        begin
          lbAvailableRanges.AddItem(fieldbyname('Description').asstring, TObject(fieldbyname('SwipeCardRangeID').asinteger));
          next;
        end;
    end;
end;

procedure TfrmSwipeCardRanges.loadSelectedCardRanges(activeGroupID : Integer);
begin
  lbSelectedRanges.Items.Clear;
  with dmADO_SwipeRange.qRun do
    begin
      Close;
      SQL.Text := format('SELECT SwipeCardRangeID, Description '+
                         '       FROM ThemeSwipeCardRange '+
                         ' WHERE SwipeCardRangeID IN (SELECT SwipeCardRangeID '+
                         '                                   FROM ThemeSwipeCardGroupRange '+
                         '                            WHERE GroupID = %d) '+
                         '       AND Promotional = '+ IntToStr(Integer(FisPromotional)) + ' AND Loyalty = 0 ', [activeGroupID]);
      Open;
      First;
      while not EOF do
        begin
          lbSelectedRanges.AddItem(fieldbyname('Description').asstring, TObject(fieldbyname('SwipeCardRangeID').asinteger));
          next;
        end;
    end;
end;

procedure TfrmSwipeCardRanges.btnAddGroupClick(Sender: TObject);
var GroupName : String;
    newGroupID : Integer;
    canProceed : Boolean;

  function nameExists(GroupName : String) :Boolean;
  var i : integer;
  begin
    Result := false;
    for i := 0 to Pred(GroupList.Count) do
      begin
        if GroupList.Strings[i] = GroupName then
           Result := True;
      end;
  end;

begin
   if modifiedLists then
      saveGroupLists;

    if isValidGroup  then
       begin
         canProceed := InputQuery('Add Group Name', 'Group Name', GroupName);
         if Length(GroupName) > 25 then
            raise exception.Create('Group name must not exceed 25 characters.')
         else
         if canProceed then
            begin
              if not nameExists(GroupName) and (GroupName <> '') then
                 begin
                   with dmADO_SwipeRange.qRun do
                   begin
                     Close;
                     newGroupID := GetNewId(scThemeSwipeCardGroup);
                     SQL.Text := Format('INSERT INTO ThemeSwipeCardGroups (GroupID, Name, Promotional) '+
                                        '       VALUES (%d, %s, %d)', [newGroupID, QuotedStr(GroupName), Integer(FisPromotional)]);
                     ExecSQL;
                     GroupList.AddObject(GroupName, TObject(newGroupID));
                     GroupList.Sort;

                     cbxGroupNames.Items.Assign(GroupList);
                     cbxGroupNames.ItemIndex := GroupList.IndexOfObject(TObject(newGroupID));
                     loadSwipeCardRanges(newGroupID);
                     loadSelectedCardRanges(newGroupID);
                     activeGroupID := newGroupID;
                   end;
              end
            else
              MessageDlg('New Group Name is invalid.  Please enter a valid name.',mtError, [mbOk], 0);
           end;

           if GroupList.Count > 0 then
              enableMoveCardRanges(True);
        end;
end;

procedure TfrmSwipeCardRanges.btnDeleteGroupClick(Sender: TObject);
var errorMessage : String;
    nPromoCount : integer;
begin
        if GroupList.Count = 0 then
           MessageDlg('Please select a valid Group.', mtError, [mbOk], 0)
        else
           if MessageDlg('Do you wish to delete?',mtConfirmation, [mbYes,mbNo], 0) = mrYes then
              begin
                with dmADO_SwipeRange.qRun do
                     begin
                       SQL.Text := Format('SELECT * FROM Promotion WHERE SwipeGroupID = %d ', [activeGroupID]);
                       Open;

                       nPromoCount := 0;
                       First;
                       While not EOF do
                       begin
                          errorMessage := errorMessage + '     ' +FieldByName('Name').AsString + #13;
                          inc(nPromoCount);

                          if (nPromoCount = 5) and (nPromoCount < RecordCount) then
                             begin
                               errorMessage := errorMessage + format('     and %d other Promotion(s).', [RecordCount - nPromoCount]) + #13;
                               Break;
                             end
                          else
                            Next;
                       end;

                       if RecordCount > 0 then
                          begin
                            if MessageDlg('This Group is assigned to the following Promotions:' + #13 + #13 + errorMessage + #13 +
                                          'Deleting this Group will also delete a Promotions Card Validation settings. Continue?', mtConfirmation,
                               [mbYes, mbNo], 0) = mrNo then
                               Exit
                            else
                               close;
                               SQL.Text := Format('UPDATE Promotion SET CardActivated = 0, SwipeGroupID = NULL, CardRating = NULL WHERE SwipeGroupID = %d', [activeGroupID]);
                               ExecSQL;
                          end;

                          GroupList.Delete(GroupList.IndexOfObject(TObject(activeGroupID)));

                          close;
                          SQL.Text := Format('DELETE FROM ThemeSwipeCardGroups WHERE GroupID = %d', [activeGroupID]);
                          ExecSQL;


                          cbxGroupNames.Items.Assign(GroupList);
                          cbxGroupNames.ItemIndex:=0;

                          if GroupList.Count = 0 then
                             begin
                               enableMoveCardRanges(false);
                               activeGroupID := 0;
                            end
                          else
                            activeGroupID := Integer(cbxGroupNames.Items.Objects[cbxGroupNames.ItemIndex]);

                            loadSwipeCardRanges(activeGroupID);
                            loadSelectedCardRanges(activeGroupID);

                            modifiedLists := false;
                     end;
              end;
end;

procedure TfrmSwipeCardRanges.cbxGroupNamesChange(Sender: TObject);
begin
   if modifiedLists and not FReadOnly then
      saveGroupLists;

   activeGroupID := Integer(cbxGroupNames.Items.Objects[cbxGroupNames.ItemIndex]);
   loadSwipeCardRanges(activeGroupID);
   loadSelectedCardRanges(activeGroupID);
end;

procedure TfrmSwipeCardRanges.btnMoveToSelectedClick(Sender: TObject);
begin
  if lbAvailableRanges.ItemIndex <> -1 then
    begin
     TransferCardRange(lbAvailableRanges, lbSelectedRanges);
     modifiedLists := True;
    end;
end;

procedure TfrmSwipeCardRanges.TransferCardRange(ASourceList, ADestinationList: TListBox);
begin
  if ASourceList.Count <> 0 then
  begin
    if ASourceList.ItemIndex = -1 then
      ASourceList.ItemIndex := 0;

    ADestinationList.AddItem(ASourceList.Items[ASourceList.ItemIndex], ASourceList.Items.Objects[ASourceList.ItemIndex]);
    ASourceList.DeleteSelected;
  end;
end;

procedure TfrmSwipeCardRanges.btnMoveToAvailClick(Sender: TObject);
begin
  if lbSelectedRanges.ItemIndex <> -1 then
     begin
       TransferCardRange(lbSelectedRanges, lbAvailableRanges);
       modifiedLists := True;
     end;
end;

procedure TfrmSwipeCardRanges.saveGroupLists;
var rangeID, i : integer;
  procedure deleteExistingLists;
  begin
    with dmADO_SwipeRange.qRun do
    begin
      Close;
      SQL.Text := Format('DELETE FROM ThemeSwipeCardGroupRange WHERE GroupID = %d', [activeGroupID]);
      ExecSQL;
    end;
  end;

begin

  if MessageDlg('Do you wish to save the changes to this Group?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     begin
       if IsValidGroup then
          begin
            deleteExistingLists;
            for i := 0 to pred(lbSelectedRanges.Items.Count ) do
                with dmADO_SwipeRange.qRun do
                begin
                  rangeID := integer(lbSelectedRanges.Items.Objects[i]);
                  Close;
                  SQL.Text := Format('INSERT INTO ThemeSwipeCardGroupRange(RangeID, GroupID, SwipeCardRangeID) '+
                                     '             VALUES(%d, %d, %d)', [GetNewId(scThemeSwipeCardGroupRange),activeGroupID, RangeID ]);
                  ExecSQL;
                end;
            modifiedLists := False;
         end
         else
        Abort;
     end
  else
     modifiedLists := False;
end;

function TfrmSwipeCardRanges.IsValidGroup : Boolean;
begin
  Result := True;

  if cbxGroupNames.Items.Count > 0 then
     begin
       if (lbSelectedRanges.Items.Count = 0) and (pcRanges.ActivePage = tsGroups)  then
       begin
         MessageDlg('A Group must be assigned at least one Swipe Card Range.', mtError, [mbOK], 0);
         Result := False;
       end;
     end;
end;

procedure TfrmSwipeCardRanges.btnCloseClick(Sender: TObject);
begin
  if modifiedLists and not FReadOnly then
     saveGroupLists;
end;

procedure TfrmSwipeCardRanges.pcRangesChanging(Sender: TObject;
  var AllowChange: Boolean);
begin

  if (pcRanges.ActivePage = tsGroups) then
     begin
        if isValidGroup then
          begin
            if modifiedLists then
            saveGroupLists;
          end
        else
          AllowChange := False;
     end;  
end;

procedure TfrmSwipeCardRanges.cbxGroupNamesDropDown(Sender: TObject);
begin
    if not isValidGroup then
       exit;

end;

procedure TfrmSwipeCardRanges.btnValidationConfigsClick(Sender: TObject);
begin
  if qrySwipeCards.RecordCount = 0 then
    raise Exception.create('Please select a vaild security range.')
  else
    with TfrmEditValidationConfigs.Create(nil) do
       try
         Caption := 'Card Validation Response - ' + qrySwipeCards.FieldByName('Description').AsString;
         IsPromotional := FisPromotional;
         ReadOnly := FReadOnly;
         DisableControls := FDisableControls;
         SwipeCardRangeID := qrySwipeCards.FieldByName('SwipeCardRangeID').AsInteger;
         if ShowModal = mrOk then
       finally
          free;
    end;
end;

procedure TfrmSwipeCardRanges.gridSwipeCardsRowChanged(Sender: TObject);
begin
  if FisPromotional then
     btnValidationConfigs.Enabled := not qrySwipeCards.FieldByName('Loyalty').AsBoolean;
end;

end.
