unit uAddEditTerminal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uAddEdit, ImgList, DB, ComCtrls, StdCtrls, ToolWin, Mask,
  DBCtrls, ExtCtrls, wwdbedit, Wwdotdot, Wwdbcomb, wwdblook, StrUtils, uDatabaseVersion;

type
  TfrmAddEditTerminal = class(TfrmAddEdit)
    lblName: TLabel;
    lblIPAddress: TLabel;
    lblEposDeviceID: TLabel;
    DBEdtName: TDBEdit;
    DBEdtIPAddress: TDBEdit;
    dbEdtEposDeviceID: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    lblForceIPAddress: TLabel;
    lblHardwareType: TLabel;
    cmbbxHardwareType: TwwDBComboBox;
    lblForceSubnet: TLabel;
    lblSubnetmask: TLabel;
    lblGatewayIP: TLabel;
    DBEditSubnetMask: TDBEdit;
    DBEditGatewayIP: TDBEdit;
    lblForceGateway: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblScreenInterfaceID: TLabel;
    cmbbxScreenInterfaceID: TwwDBComboBox;
    pnladditional: TPanel;
    cbConfigSet: TwwDBLookupCombo;
    cbCustomerDisplayType: TwwDBComboBox;
    cbTerminalName: TwwDBLookupCombo;
    Label3: TLabel;
    ResetAccountNumberCheck: TDBCheckBox;
    LblPosCode: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBMemo1: TDBMemo;
    lblcustDisplayType: TLabel;
    ResetOrderNumberLabel: TLabel;
    cmbbxKioskUser: TwwDBLookupCombo;
    lbScrollingMessageOverrideWarning: TLabel;
    Label7: TLabel;
    DBEditPound: TDBEdit;
    lblpound: TLabel;
    pnlTwoDrawerMode: TPanel;
    TwoDrawerModeDBCheckBox: TDBCheckBox;
    pnlSoloMode: TPanel;
    dbcbxSoloMode: TDBCheckBox;
    procedure DBEdtNameKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure DBEdtNameChange(Sender: TObject);
    procedure cmbbxHardwareTypeChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbEdtEposDeviceIDKeyPress(Sender: TObject; var Key: Char);
    procedure btnSaveClick(Sender: TObject);
    procedure dbcbxSoloModeClick(Sender: TObject);
    procedure TwoDrawerModeDBCheckBoxClick(Sender: TObject);
  private
    validateTermName : Boolean;
    maxEposDeviceID : integer;
    FSiteVirtualIPAddress: String;
    OldConfigSetId: integer;
    OldUseDrawerAssignment: boolean;
    OldUseMultiDrawerMode: boolean;
    procedure PopulateHardwareDropDown;
    procedure UpdateConfigSetUseDrawerAssignmentIfRequired(useMultiDrawerMode: boolean);
    function ValidDeviceID(out ErrorMessage: string) : Boolean;
    function DuplicateCalculatedPortNumber(NewID: SmallInt): Boolean;
    function CheckAzOneTerminalAlreadyExists(CurrentEPoSDeviceID: Integer): Boolean;
    function IsTerminalHardwareMultiDrawerCompatable: boolean;
    function IsConfigSetInUseWithAnotherMultiDrawerModeTill(configSetId: integer; currentEposDeviceId: integer): boolean;
    function GetUseDrawerAssignmentForConfigSet(configSetId: integer): boolean;
    procedure GetSiteVirtualIPAddress;
    function IsTerminalPanelDesignMultiDrawerCompatible: boolean;
    function ServerHasSerialPeripherals: boolean;
  protected
    procedure SaveChanges;  override;
    function ValidateFields : Boolean; override;
  end;

  THackCheckBox = class(TCustomCheckBox)
  end;

var
  frmAddEditTerminal: TfrmAddEditTerminal;

Const
  DEFAULT_SUBNET_MASK = '255.255.255.0';
  TWO_DRAWER_MODE_ADDITIONAL_HINT = 'Two drawer mode can only be set once the Terminal details have been saved.';

procedure SetCheckedStatusWithoutClick(CheckBox: TCustomCheckBox; NewState: TCheckBoxState);

procedure ToggleCheckedStateWithoutClick(CheckBox: TCustomCheckBox; OriginalState: TCheckBoxState);

implementation

uses uADO, uDMThemeData, ADODB, uAztecStringUtils, uEposDevice, uGenerateThemeIDs, uGlobals, Math;

{$R *.dfm}

function TerminalRequiresPoundCodeSetting(TerminalHardwareType: Integer): Boolean;
begin
  //TODO - this ought to become a data driven operation, i.e. this property should reside
  //with the hardware type.  Do this when we add the front end to add new device types.
  Result := (TerminalHardwareType in [ord(ehtXPPos), ord(ehtIBMSurePOS500), ord(ehtIBMSurePOS514P126),
                                      ord(ehtIBMSurePOS532P126), ord(ehtSharpUPV5500), ord(ehtSharpRZX750),
                                      ord(ehtToshibaTECSTA10), ord(ehtToshibaTECSTA12), ord(ehtToshibaTECSTA20),
                                      ord(ehtIBMSurePOS514P1238), ord(ehtIBMSurePOS532P1238),
                                      ord(ehtZonalToshibaA12), ord(ehtZonalToshibaA20),
                                      ord(ehtZonalToshibaA30), ord(ehtZonalToshibaA10), 33 {ord(ehtZonalZ9)}])
        or (TerminalHardwareType >= 1000);
end;

{ TfrmAddEditTerminal }

function TfrmAddEditTerminal.ValidateFields: Boolean;
var
  ErrorMessage: string;
begin
  Result := True;
  if DBEdtName.Text = '' then
  begin
    Result := False;
    DBEdtName.SetFocus;
    MessageDlg('Name is Required', mtInformation, [mbOK], 0);
  end
  else if (DBEdtIPAddress.Text = '') and (DBEdtIPAddress.enabled) then
  begin
    Result := False;
    DBEdtIPAddress.SetFocus;
    MessageDlg('IP Address is Required', mtInformation, [mbOK], 0);
  end
  else if (DBEdtIPAddress.Text = FSiteVirtualIPAddress) and (Fmode = EDIT_SERVER) then
  begin
    // check we are not attempting to make an invalid server virtual
    with dmADO.adoqRun do
    begin
      SQL.Text := Format('select count(*) from ThemeEPOSDevice where SiteCode = %d '+
        'group by ServerID having count(*) > %d and ServerID = %d',
        [FSiteCode, dmADO.VirtualServerDeviceLimit, dsEditRec.DataSet.fieldbyname('EposDeviceId').AsInteger]
      );
      Open;
      if RecordCount > 0 then
      begin
        Close;
        raise Exception.Create(
          Format('Cannot make this device virtual as it already has more than %d devices.',
            [dmADO.VirtualServerDeviceLimit])
        );
      end;
      Close;

    end;
  end
  else if dbEdtEposDeviceID.Text = '' then
  begin
    Result := False;
    dbEdtEposDeviceID.SetFocus;
    MessageDlg('Device ID is Required', mtInformation, [mbOK], 0);
  end
  else if (StrToInt(dbEdtEposDeviceID.Text) mod 100 = 0) and (dbEdtEposDeviceID.Enabled = True) then
  begin
    Result := False;
    dbEdtEposDeviceID.SetFocus;
    MessageDlg('Device ID is incorrect.  Please ensure the ID does not end with a double zero(00).', mtInformation, [mbOK], 0);
  end
  else if (DBEditSubnetMask.Text = '') and (DBEditSubnetMask.Enabled) then
  begin
    Result := FALSE;
    DBEditSubnetMask.SetFocus;
    MessageDlg('Device Subnet Mask is Required', mtInformation, [mbOK], 0);
  end
  else if (DBEditGatewayIP.Text = '') and (DBEditGatewayIP.Enabled) then
  begin
    Result := FALSE;
    DBEditGatewayIP.SetFocus;
    MessageDlg('Device Gateway IP is Required', mtInformation, [mbOK], 0);
  end
  else if cmbbxHardwareType.Text = '' then
  begin
    Result := FALSE;
    cmbbxHardwareType.SetFocus;
    MessageDlg('Hardware Type is Required', mtInformation, [mbOK], 0);
  end
  else if ((cbTerminalName.Text = '') or (cbTerminalName.Text = '(none)')) and (validateTermName = True) then
  begin
    Result := FALSE;
    cbTerminalName.SetFocus;
    MessageDlg('Terminal Name is Required', mtInformation, [mbOK], 0);
  end
  //** just do simple check on insert as DB will not allow duplicate device IDs
  //** as it is part of the composite key
  else if (dseditRec.State = dsInsert) and (not ValidDeviceID(ErrorMessage)) then
  begin
    Result := False;
    dbEdtEposDeviceID.SetFocus;
    MessageDlg(ErrorMessage, mtInformation, [mbOK], 0);
  end
  else if (cmbbxHardwareType.Value = inttostr(ord(ehtKiosk))) and (cmbbxKioskUser.Text = '') then
  begin
    Result := FALSE;
    cmbbxKioskUser.SetFocus;
    MessageDlg('A user must be assigned to a Kiosk.', mtInformation, [mbOK], 0);
  end
  else if (cmbbxHardwareType.Value = inttostr(ord(ehtKiosk))) and dmADO.isLowVersionSite('3.5.1.0',FSiteCode) then
  begin
    Result := FALSE;
    cmbbxHardwareType.SetFocus;
    MessageDlg('This Site is running an older version of Aztec.'+#10#13#10#13+
               'The Kiosk hardware is only supported on Sites running a minimum of Aztec 3.5.1.', mtInformation, [mbOK], 0);
  end
  else if not (ValidIPv4Address(DBEdtIPAddress.Text, ErrorMessage)) then
  begin
    Result := False;
    DBEdtIPAddress.SetFocus;
    MessageDlg(ErrorMessage, mtInformation, [mbOK], 0);
  end
  else if not (ValidIPv4Address(DBEditSubnetMask.Text, ErrorMessage)) then
  begin
    Result := False;
    DBEditSubnetMask.SetFocus;
    MessageDlg(AnsiReplaceStr(ErrorMessage, 'IP Address', 'Subnet Mask'), mtInformation, [mbOK], 0);
  end
  else if not (ValidIPv4Address(DBEditGatewayIP.Text, ErrorMessage)) then
  begin
    Result := False;
    DBEditGatewayIP.SetFocus;
    MessageDlg(AnsiReplaceStr(ErrorMessage, 'IP Address', 'Gateway IP'), mtInformation, [mbOK], 0);
  end
  else if (StrToInt(cmbbxHardwareType.Value) in [ord(ehtAzTab), ord(ehtAzOne)]) and dmADO.isLowVersionSite('3.8.0.0',FSiteCode) then
  begin
    Result := FALSE;
    cmbbxHardwareType.SetFocus;
    MessageDlg('This Site is running an older version of Aztec.'+#10#13#10#13+
               'AzTab and AzOne hardware is only supported on Sites running a minimum of Aztec 3.8.0.0', mtInformation, [mbOK], 0);
  end
  else if ((cmbbxHardwareType.Value = inttostr(ord(ehtAzOne))) and CheckAzOneTerminalAlreadyExists(StrToInt(dbEdtEposDeviceID.Text))) then
  begin
    Result := False;
    cmbbxHardwareType.SetFocus;
  end
  // vk moved to TwoDrawerModeDBCheckBox onClick
  (*
  else if (TwoDrawerModeDBCheckBox.Checked and not IsTerminalPanelDesignMultiDrawerCompatible) then
  begin
    Result := FALSE;
    TwoDrawerModeDBCheckBox.SetFocus;
    MessageDlg('This terminal is assigned a panel design that is not compatible with two drawer mode.'+#10#13#10#13+
               'Terminals using ''Z300'' or ''Handheld'' panel design types cannot use two drawer mode functionality.', mtError, [mbOK], 0);
  end
  *)

  else if ((Fmode = EDIT_SERVER) and
           (StrToInt(cmbbxHardwareType.Value) in [ord(ehtZonalSuperPOSServer)]) and
            ServerHasSerialPeripherals) then
  begin
    Result := FALSE;
    cmbbxHardwareType.SetFocus;
    MessageDlg('Cannot change this servers hardware type to Super POS Server as it has '+#10#13#10#13+
               'existing serial peripherals attached. Please remove these before proceeding.',
               mtInformation, [mbOK], 0);
  end
  else begin
    //Determine whether or not our choice of customer display conflicts
    //with other peripherals.
    // 0 = Graphical 1 = Nnone 2 = Serial 3 = Serial (PTC Emulation)
    case cbCustomerDisplayType.Field.AsInteger of
      2, 3:
      begin
        // Are there any devices using the port required for the serial display?
        with dmAdo.adoqrun do
        begin
          SQL.Clear;
          SQL.Add('SELECT tep.printerid as id,tep.name as name, tep.portnumber port ');
          SQL.Add('       FROM ThemeEposPrinter tep ');
          SQL.Add('            INNER JOIN PeripheralDevicePortsSetup p ON tep.PortNumber = p.PortNumber ');
          SQL.Add('WHERE tep.EposdeviceID = ' + dsEditRec.DataSet.fieldbyname('EposDeviceId').AsString);
          SQL.Add('      AND p.HardwareType = ' + cmbbxHardwareType.Value);
          SQL.Add('	 AND tep.SiteCode = ' + IntToStr(FSiteCode));
          if cmbbxHardwareType.Value <> inttostr(ord(ehti700)) then
             SQL.Add('	AND p.customerdisplay = 1');
          Open;

          first;
          while not EOF do
          begin
            // i700 only restricts on port 2 for serial ptc displays.
            if (cmbbxHardwareType.Value = inttostr(ord(ehti700))) then
               begin
                 if (cbCustomerDisplayType.Field.AsInteger = 3) and (FieldByName('Port').AsInteger = 2) then
                    begin
                      MessageDlg(Format('A serial customer display will conflict with peripheral device ''%s'' on port 2.' + #13#10 +
                                        'Change the peripheral''s port or choose another display type.', [FieldByname('name').AsString]), mtInformation, [mbOK], 0);
                      Result := false;
                      Break;
                    end
                 else
                    next;
               end
            else
              begin
                MessageDlg(
                  Format('A serial customer display will conflict with peripheral device ''%s'' on port %d.' + #13#10 +
                         'Change the peripheral''s port or choose another display type.',
                         [FieldByname('name').AsString,FieldByname('port').AsInteger]),
                         mtInformation,
                         [mbOK],
                         0);

                Result := False;

                Next;
              end;
          end;
        end;
      end;
      else begin
        //Do nothing with these display types
      end;
    end;

  end;

  if cmbbxHardwareType.Value <> inttostr(ord(ehtKiosk)) then
     dsEditRec.DataSet.FieldByName('Kiosk_SEC').Value := NULL
  else
     begin
       dsEditRec.DataSet.FieldByName('ScrollingMessage').Value := '';
       dsEditRec.DataSet.FieldByName('CustomerDisplayType').Value := 1;
     end;

  //The following version checks only result in a warning.
  if (Result = True) then
  begin
    if (cmbbxScreenInterfaceID.ItemIndex = 1) and dmADO.isLowVersionSite('3.4.3.0',FSiteCode) and
       (cmbbxHardwareType.Value = inttostr(ord(ehtZ500))) then
       MessageDlg('This Site is running an older version of Aztec.'+#10#13#10#13+
                  'Until the Site is upgraded to 3.4.3, only standard Z500 Panel designs will be'+#10#13+
                  'supported on any Z500(15" Screen) Terminal configurations.', mtWarning, [mbOK], 0)
    else if (cmbbxHardwareType.Value = inttostr(ord(ehti700))) and dmADO.isLowVersionSite('3.5.0.0',FSiteCode) then
       MessageDlg('This Site is running an older version of Aztec.'+#10#13#10#13+
                  'The i700 hardware is only supported to run on Sites running a minimum of Aztec 3.5.0.', mtWarning, [mbOK], 0)
    else if (cmbbxHardwareType.Value = inttostr(ord(ehtXPPos))) and dmADO.isLowVersionSite('3.5.6.0',FSiteCode) then
       MessageDlg('This Site is running an older version of Aztec.'+#10#13#10#13+
                  'The XP Pos hardware is only supported to run on Sites running a minimum of Aztec 3.5.6.', mtWarning, [mbOK], 0);
  end;

  if cbCustomerDisplayType.ItemIndex = -1 then
     dsEditRec.DataSet.FieldByName('CustomerDisplayType').Value := 1;

  if not IsTerminalHardwareMultiDrawerCompatable then
    TwoDrawerModeDBCheckBox.Checked := false;

end;

//------------------------------------------------------------------------------
function TfrmAddEditTerminal.ValidDeviceID(out ErrorMessage: string): Boolean;
begin
  Result := False;
  ErrorMessage := '';

  with dmADO.qRun do
  try
    Close;
    SQL.Text := 'SELECT Name FROM ThemeEposDevice_Repl WHERE EposDeviceId = ' + dbEdtEposDeviceID.Text;
    Open;
    if (RecordCount > 0) then
    begin
      ErrorMessage := 'Device ID Must Be Unique.';
      Exit;
    end;

    Close;
    SQL.Text :=
      'SELECT Name FROM ThemeEposDevice ' +
      'WHERE SiteCode = ' + IntToStr(FSiteCode) + ' AND EposDeviceId % 100 = ' + dbEdtEposDeviceID.Text + ' % 100';
    Open;
    if (RecordCount > 0) then
    begin
      ErrorMessage := 'A terminal with Device ID ending ' + IntToStr(StrToInt(dbEdtEposDeviceID.Text) Mod 100) + ' already exists on this site.';
      Exit;
    end;

    if (dsEditRec.DataSet.FieldByName('HardwareType').AsInteger in [ord(ehtKiosk), ord(ehtMOAPayAtTable)])
    and DuplicateCalculatedPortNumber(dsEditRec.DataSet.FieldByName('EposDeviceID').AsInteger) then
    begin
      ErrorMessage := 'Device ID ' + dbEdtEposDeviceID.Text + ' for this ' + cmbbxHardwareType.Text +
        ' will result in' + #13#10 + 'a duplicate internal port number with another similar device.';
      Exit;
    end;

    Result := True;
  finally
    Close;
  end;
end;

function TfrmAddEditTerminal.IsTerminalHardwareMultiDrawerCompatable: boolean;
begin
  result := (cmbbxHardwareType.Value = inttostr(ord(ehti700))) OR
            (cmbbxHardwareType.Value = inttostr(ord(ehtZ500)))
end;

function TfrmAddEditTerminal.IsTerminalPanelDesignMultiDrawerCompatible: boolean;
begin
  with dmADO.adoqRun do
  begin
    SQL.Clear;
    SQL.Add('select IsNull(cast(case when tpd.PanelDesignType in (1,3) then 0 else 1 end as bit), 1) as ValidDesignType');
    SQL.Add('from ThemeEposDesign ted');
    SQL.Add('left join ThemePanelDesign tpd on tpd.PanelDesignID = ted.PanelDesignID');
    SQL.Add(Format('where ted.POSCode = %d', [dsEditRec.DataSet.FieldByName('POSCode').AsInteger]));

    Open;
    if (Recordset.RecordCount < 1) then
      Result := true
    else
      Result := FieldByName('ValidDesignType').AsBoolean;
    Close;
  end;
end;

function TfrmAddEditTerminal.ServerHasSerialPeripherals: boolean;
begin
  with dmADO.adoqRun do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM ThemeEposPrinter ');
    SQL.Add(Format('WHERE EposDeviceID = ''%d'' ', [dsEditRec.DataSet.FieldByName('EposDeviceId').AsInteger]));
    SQL.Add('AND PrinterType IN ');
    SQL.Add('(SELECT PrinterTypeID FROM ThemePrinterType WHERE IPComms = 0)');
    Open;
    Result := RecordCount > 0;
    Close;
  end;
end;


//------------------------------------------------------------------------------
procedure TfrmAddEditTerminal.DBEdtNameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  if Key = #13 then
    btnSaveClick(Sender)
end;


//------------------------------------------------------------------------------
// FMode 0 = edit terminal, 1 = add terminal, 2 = edit server, 3 = add server,
//       4 = edit conqueror terminal, 5 = add conqueror terminal, 6 = edit conqueror server
//       7 = edit MOA Order Pad, 8 = show iZone Table
procedure TfrmAddEditTerminal.FormShow(Sender: TObject);
var
  NewId, AreaID, CompanyID: integer;
  TmpRecordCount: integer;
  InvalidTermId: boolean;
  ScrollingMessageOverrideId: integer;
  OutOfRange : boolean;

  procedure getCompanyInfo(SiteCode : Integer);
  begin
    with dmADO.qRun do
       begin
         close;
         SQL.Text := Format('SELECT s.ID AS SiteID, a.ID AS AreaID, c.ID AS CompanyID FROM ac_Site s '+
                            '                  INNER JOIN ac_Area a ON a.ID = s.AreaID '+
                            '                  INNER JOIN ac_Company c ON c.ID = a.CompanyID '+
                            '         WHERE s.ID = %d ', [SiteCode]);
         Open;
         AreaID := FieldByName('AreaID').AsInteger;
         CompanyID  := FieldByName('CompanyID').AsInteger;
       end;
  end;
begin
  inherited;
  dbcbxSoloMode.Enabled := not dmADO.isLowVersionSite('3.10.2.0',FSiteCode);
  if not dbcbxSoloMode.Enabled then
    pnlSoloMode.Hint := 'Solo Mode is only supported on sites running a minimum of Aztec 3.10.2.';

  TwoDrawerModeDBCheckBox.Enabled := IsTerminalHardwareMultiDrawerCompatable() AND FCanSetMultiDrawerMode;
  GetSiteVirtualIPAddress;

  getCompanyInfo(FSiteCode);

  dmADO.qGetEmployees.Parameters[0].Value := FSiteCode;
  dmADO.qGetEmployees.Parameters[1].Value := AreaID;
  dmADO.qGetEmployees.Parameters[2].Value := CompanyID;
  dmADO.qGetEmployees.Parameters[3].Value := dsEditRec.DataSet.FieldByName('EposDeviceID').AsInteger;
  dmADO.qGetEmployees.Open;
  validateTermName := True;

  ScrollingMessageOverrideId := dmADO.GetSiteScrollingMessageOverride(FSiteCode);
  if ScrollingMessageOverrideId <> -1 then
  begin
    if dsEditRec.DataSet.FieldByName('ScrollingMessageOverrideId').AsInteger <> ScrollingMessageOverrideId then
      dsEditRec.DataSet.FieldByName('ScrollingMessageOverrideId').AsInteger := ScrollingMessageOverrideId;
    if FMode in [EDIT_TERMINAL, ADD_TERMINAL] then
      lbScrollingMessageOverrideWarning.Visible := true;
  end;

  if (DBEditSubnetMask.Text = '') and (DBEditSubnetMask.enabled) then
    dsEditRec.DataSet.FieldByName('SubnetMask').Value := DEFAULT_SUBNET_MASK;

  PopulateHardwareDropDown;

  if dsEditRec.DataSet.fieldbyname('HardwareType').AsInteger > 0 then
    cmbbxHardwareType.ItemIndex := cmbbxHardwareType.Items.IndexOfObject(TObject(dsEditRec.DataSet.FieldByName('HardwareType').AsInteger));

  ResetAccountNumberCheck.Enabled := FMode in [EDIT_SERVER, ADD_SERVER];
  ResetAccountNumberCheck.Visible := FMode in [EDIT_SERVER, ADD_SERVER];
  ResetOrderNumberLabel.Visible := FMode in [EDIT_SERVER, ADD_SERVER];

  if dsEditRec.DataSet.FieldByName('ResetAccountNumber').IsNull then
    dsEditRec.DataSet.FieldByName('ResetAccountNumber').AsBoolean := false;

  //if dmADO.isLowVersionSite('3.5.8.0',FSiteCode) then
  //   maxEposDeviceID := 9999
  //else
     maxEposDeviceID := 32767;

  case FMode of
    EDIT_TERMINAL:
      begin
        dbEdtEposDeviceID.Enabled := FALSE;
        HelpContext := 5023;
        cmbbxScreenInterfaceID.ItemIndex := dsEditRec.DataSet.fieldbyname('ScreenInterfaceID').AsInteger;
      end;
    ADD_TERMINAL:
      begin
        SetCheckedStatusWithoutClick(dbcbxSoloMode, cbUnchecked);
        cbCustomerDisplayType.Field.AsInteger := 1;  // pick "none" as the scrolling message type
        dsEditRec.DataSet.FieldByName('SiteCode').Value := FSiteCode;
        dsEditRec.DataSet.FieldByName('ServerID').Value := FParentDeviceID;
        dsEditRec.DataSet.FieldByName('GatewayIP').Value := dmADO.GetGatewayIPForTerminal(FSiteCode);
        HelpContext := 5023;
        ResetOrderNumberLabel.Visible := false;
        cmbbxScreenInterfaceID.ItemIndex := 0;
        TwoDrawerModeDBCheckBox.Checked := false;
      end;
    EDIT_SERVER, ADD_SERVER, EDIT_CONQUEROR_SERVER:
      begin
        if FMode in [ADD_SERVER, EDIT_CONQUEROR_SERVER] then
          dsEditRec.DataSet.FieldByName('IsServer').Value := TRUE
        else
          dbEdtEposDeviceID.Enabled := FALSE;

        dsEditRec.DataSet.FieldByName('ScreenInterfaceID').AsInteger := 0;
        caption := 'Site Server Setup';
        cbCustomerDisplayType.Visible := FALSE;
        cbConfigSet.Visible := FALSE;
        DBMemo1.Visible := FALSE;
        lblcustDisplayType.Visible := FALSE;
        Label4.Visible := FALSE;
        Label5.Visible := FALSE;
        Label3.Visible := FALSE;
        TwoDrawerModeDBCheckBox.Visible := false;
        dbcbxSoloMode.Visible := False;
        HelpContext := 5046;
      end;
    EDIT_MOA_ORDER_PAD:
      begin
        DBEdtEposDeviceID.Enabled := FALSE;
        DBEdtIPAddress.Enabled := FALSE;
        DBEditSubnetMask.Enabled := FALSE;
        DBEditGatewayIP.Enabled := FALSE;
        cmbbxHardwareType.Enabled := FALSE;
        cbTerminalName.Enabled := FALSE;
        cbCustomerDisplayType.Enabled := FALSE;
        DBMemo1.Enabled := FALSE;
        cbConfigSet.Enabled := FALSE;
        TwoDrawerModeDBCheckBox.Visible := false;
        dbcbxSoloMode.Visible := False;
        //todo Get HelpContext?
      end;
    SHOW_IZONE_TABLES:
      begin
        DBEdtName.Enabled := False;
        DBEdtEposDeviceID.Enabled := FALSE;
        DBEdtIPAddress.Enabled := FALSE;
        DBEditSubnetMask.Enabled := FALSE;
        DBEditGatewayIP.Enabled := FALSE;
        cmbbxHardwareType.Enabled := FALSE;
        cbTerminalName.Enabled := FALSE;
        cbCustomerDisplayType.Enabled := FALSE;
        DBMemo1.Enabled := FALSE;
        cbConfigSet.Enabled := False;
        TwoDrawerModeDBCheckBox.Visible := false;
        dbcbxSoloMode.Visible := False;
      end;
  end;

  if not dsEditRec.DataSet.FieldByName('HardwareType').IsNull
     and not (FMode in [EDIT_MOA_ORDER_PAD, SHOW_IZONE_TABLES]) then
  begin
    cmbbxHardwareType.ItemIndex := cmbbxHardwareType.Items.IndexOfObject(TObject(dsEditRec.DataSet.FieldByName('HardwareType').AsInteger));
    cmbbxHardwareTypeChange(sender);
  end;

  if uGlobals.UKUSmode = 'US' then
  begin
    ResetOrderNumberLabel.Caption := 'Reset Chk/Ord No. Daily:';
    lblPound.Caption := 'Dollar ($) code :';
  end;

  if dmThemeData.qConfigSetsLookUp.Active then
    dmThemeData.qConfigSetsLookUp.Requery()
  else
    dmThemeData.qConfigSetsLookUp.Open;

  //refresh the data set to ensure the drop down removes any newly assigned pos codes.
  dmAdo.qgetposes.Close;
  dmADO.qGetPoses.Parameters.ParamByName('current_pos').Value := dsEditRec.DataSet.fieldbyname('poscode').AsInteger;
  dmAdo.qgetposes.Open;

  if cmbbxHardwareType.Value <> '' then
    if ((strtoint(cmbbxHardwareType.Value) in [ord(ehtConqueror), ord(ehtHotelSystem)])
        and (dsEditRec.DataSet.FieldByName('IsServer').Value = TRUE)) then
    // this is probably wrong; I think that Hotel System Servers will never get Terminals
    // (this is stopped elsewhere) which is why the drop down is disabled in this "if" section.
    // But, while doing what we want, the logic is wrong, I think. HS should have its own "if".
    begin
      with dmAdo.adoqrun do
      begin
        close;
        sql.clear;
        sql.add ('SELECT COUNT(name) AS sqlcount FROM ThemeEposDevice');
        sql.add ('Where ServerID = :ServerID');
        parameters.ParamByName('ServerID').Value := dsEditRec.DataSet.FieldByName('ServerID').Value;
        open;
        cmbbxHardwareType.Enabled := fieldbyname('sqlcount').AsInteger > 0;
      end;
    end;

  if FMode in [ADD_TERMINAL, ADD_SERVER] then
  begin
    // Set default to site IP address if configured.
    with dmADO.ADOqRun do
    begin
      SQL.Text := Format(
        'select IPAddress from ThemeOutletConfigs where SiteCode = %d', [FSiteCode]
      );
      Open;
      DBEdtIPAddress.Field.asstring := FieldByName('IPAddress').AsString;
      DBEditGatewayIP.Field.asstring := FieldByName('IPAddress').AsString;
      Close;
    end;
  end;

  // Supply a default gateway IP for "virtual" type devices created
  // outside of theme modelling
  if (DBEditGatewayIP.Field.AsString = '')
    and (dsEditRec.DataSet.FieldByName('HardwareType').AsInteger in
      [8, 10, 11, 12, 13, 14]) then
    DBEditGatewayIP.Text := DBEdtIPAddress.Text;

  if  dsEditRec.DataSet.FieldByName('EposDeviceID').AsString = '' then
  begin
    InvalidTermId := True;
    NewId := -1;
    while InvalidTermID do
    begin
      NewId := uGenerateThemeIDs.GetNewId(scThemeEposDevice);
      // 32767 SQL smalint range max value
      OutOfRange := NewId >= 32767;
      // Check simple cases
      InvalidTermId := ((FMode = ADD_TERMINAL) and (NewId mod 100 = 0));
      if not(InvalidTermID) or (NewId > maxEposDeviceID) then
      begin
        // check if the generated id has been used before
        dmADO.qRun.SQL.Text := Format('select * from ThemeEposDevice_Repl where EposDeviceID = %d', [NewId]);
        dmADO.qRun.Open;
        TmpRecordCount := dmADO.qRun.RecordCount;
        dmADO.qRun.Close;
        if (TmpRecordCount > 0) or (NewId > maxEposDeviceID) then
        begin
          // ID is already used, find first free ID in table
          dmADO.qRun.SQL.Text := Format('DECLARE @NextAvailableID SMALLINT ' +

                                 ' exec ac_spGetNextAvailableEposDeviceId @NextAvailableID OUTPUT, NULL, %d ' +
                                 ' SELECT @NextAvailableID AS NextAvailableID ', [maxEposDeviceID]);

          dmADO.qRun.Open;
          if dmADO.qRun.FieldByName('NextAvailableID').IsNull then
            NewID := -1
          else
            NewID := dmADO.qRun.FieldByName('NextAvailableID').AsInteger;
          dmADO.qRun.Close;
          if NewID = -1 then
            raise Exception.Create('No more devices may be added to the system at this time - contact Zonal.');
          if (OutOfRange) then
            dmADO.AztecConn.Execute(Format('update UniqueID set CurrentID = %d where TableName = ''ThemeEposDevice_repl''', [NewID]))
          else
            dmADO.AztecConn.Execute(Format('update UniqueID set CurrentID = %d where TableName = ''ThemeEposDevice_repl''', [NewID-1]));
          InvalidTermID := false;
        end
        else
          InvalidTermID := false;
      end;
    end;
    dsEditRec.DataSet.FieldByName('EposDeviceID').AsInteger := NewId;
  end;

  OldConfigSetId := dsEditRec.DataSet.FieldByName('ConfigSetId').AsInteger;
  dmThemeData.qConfigSets.Open;
  OldUseDrawerAssignment := GetUseDrawerAssignmentForConfigSet(OldConfigSetId);
  OldUseMultiDrawerMode := dsEditRec.DataSet.FieldByName('MultiDrawerMode').AsBoolean;
end;

procedure TfrmAddEditTerminal.SaveChanges;
    function hasValidDashboardReportAssigned(Sitecode: integer; POSCode : integer) : Boolean;
    begin
      Result := False;
      with dmADO.adoqRun do
        begin
           close;
           SQL.Text := Format('SELECT DashboardReportID, DashboardTimeout FROM ThemeEposDesign '+
                              ' WHERE SiteCode = %d AND PosCode = %d ', [Sitecode, POSCode]);
           Open;

           if FieldByName('DashboardReportID').AsInteger <> 0 then
              Result := True;
      end;
    end;


begin

  if dmADO.qGetTerminals.FieldByName('ScrollingMessage').IsNull then
  begin
    dmADO.qGetTerminals.FieldByName('ScrollingMessage').Value := ''
  end;

  inherited;

  if FMode in [SHOW_IZONE_TABLES] then // browsing an iZone Tables device - uneditable.
    Exit;

  if ((strtoint(cmbbxHardwareType.Value) = ord(ehtConqueror)) and (dsEditRec.DataSet.FieldByName('isServer').Value=0)) then
  begin
    with dmAdo.adoqrun do
    begin
      close;
      sql.clear;
      sql.add ('SELECT COUNT(*) AS sqlcount FROM ConquerorEposDeviceDetails');
      sql.add ('Where EPoSDeviceID = :EPoSDeviceID');
      parameters.ParamByName('EPoSDeviceID').Value := dsEditRec.DataSet.FieldByName('EPoSDeviceID').Value;
      open;
      if fieldbyname('sqlcount').AsInteger = 0 then
      begin
        close;
        sql.clear;
        sql.add ('Insert into ConquerorEposDeviceDetails (SiteCode, EPoSDeviceID, ConquerorDeviceID)');
        sql.add ('values (:SiteCode, :EPoSDeviceID, null)');
        parameters.parambyname('SiteCode').Value := FSiteCode;
        parameters.parambyname('EPoSDeviceID').Value := dsEditRec.DataSet.FieldByName('EPoSDeviceID').Value;
        execsql;
      end;
    end;
  end;

  if FMode in [EDIT_SERVER, ADD_SERVER] then
    Exit;

  with dmADO.adoqRun do
  begin
    if (TEPoSHardwareType(StrToInt(cmbbxHardwareType.Value)) in [ehtConqueror, ehtHotelSystem])
      and (dsEditRec.DataSet.FieldByName('IPAddress').IsNull or (dsEditRec.DataSet.FieldByName('IPAddress').AsString <> '')) then
    begin
      dsEditRec.DataSet.Edit;
      dsEditRec.DataSet.FieldByName('IPAddress').AsString := '';
      dsEditRec.DataSet.Post;
    end;
  end;

  with dmADO.adoqRun do
  begin
    if  not TerminalRequiresPoundCodeSetting(strtoint(cmbbxHardwareType.Value)) then
    begin
      dsEditRec.DataSet.Edit;
      dsEditRec.DataSet.FieldByName('PoundCode').Value := NULL;
      dsEditRec.DataSet.Post;
    end;
  end;

  if strtoint(cmbbxHardwareType.Value) IN [ord(ehtZ400), ord(ehtZ300), ord(ehtHandHeld),
     ord(ehtConqueror), ord(ehtHotelSystem)] then
     begin
      if hasValidDashboardReportAssigned(dsEditRec.DataSet.FieldByName('SiteCode').AsInteger, dsEditRec.DataSet.FieldByName('POSCode').AsInteger) then
         begin
            with dmADO.adoqRun do
               begin
                close;
                SQL.Text := Format('UPDATE ThemeEposDesign SET DashboardReportID = NULL , DashBoardTimeout = NULL '+
                            ' WHERE SiteCode = %d AND PosCode = %d ', [dsEditRec.DataSet.FieldByName('SiteCode').AsInteger, dsEditRec.DataSet.FieldByName('POSCode').AsInteger]);
                execSQL;
               end;
         end;
     end;

  if strtoint(cmbbxHardwareType.Value) IN [ord(ehtKiosk)] then
     begin
       with dmADO.adoqRun do
            begin
              close;
              SQL.Text := Format('UPDATE ThemeEposDesign SET DefaultPanelID = NULL , DefaultCycleID = NULL '+
                                 ' WHERE SiteCode = %d AND PosCode = %d ', [dsEditRec.DataSet.FieldByName('SiteCode').AsInteger, dsEditRec.DataSet.FieldByName('POSCode').AsInteger]);
              execSQL;
            end;
       end;

  with dmADO.adoqRun do
  begin
    if not dsEditRec.dataset.fieldbyname('poscode').isnull and
      (dsEditRec.DataSet.FieldByName('isServer').Value=0) then
    begin
      try
        // insert default panel design for new/edited terminal (if it doesn't have one already)
        sql.text := 'declare @sitecode int, @themeid int '+
          'select @sitecode = sitecode from themeeposdevice where eposdeviceid = :deviceid '+
          'select @themeid = themeid from themesites where sitecode = @sitecode '+
          'select @sitecode as sitecode, @themeid as themeid';
        parameters.ParamByName('deviceid').value := dsEditRec.DataSet.fieldbyname('EposDeviceId').value;
        open;
        dmthemedata.qOutletTerminalsSetDefs.parameters.parambyname('sitecode').value :=
          FSiteCode;
        dmthemedata.qOutletTerminalsSetDefs.parameters.parambyname('themeid').value :=
          fieldbyname('themeid').asinteger;
        dmthemedata.qOutletTerminalsSetDefs.execsql;
      except
      end;
    end;
  end;

end;


procedure TfrmAddEditTerminal.DBEdtNameChange(Sender: TObject);
begin
  inherited;

  PreventInvalidCharacters(Sender as TCustomEdit, ['/','\',':','?','"','<','>', '|', ';']);
end;

procedure TfrmAddEditTerminal.cmbbxHardwareTypeChange(Sender: TObject);
var
  isEnabled : Boolean;
  ShowPound : Boolean;
  IdNotValid: Boolean;
  NewId: SmallInt;
begin
  inherited;

  // When user changes the hardware type check if it is two drawer mode compatibe.
  // If not, set two drawer mode to false (setting the checked state doesn't seem
  // to update the underlying db field?).
  // The dataset.state check is required when the user cancels out of Add Terminal
  // to stop it trying to update the field when ds is in the dsbrowse state (bug 366119).
  if not IsTerminalHardwareMultiDrawerCompatable AND (dmADO.qGetTerminals.State in [dsInsert, dsEdit]) then
    TwoDrawerModeDBCheckBox.Field.AsBoolean := false;

  TwoDrawerModeDBCheckBox.Enabled := IsTerminalHardwareMultiDrawerCompatable() AND FCanSetMultiDrawerMode;
  if TwoDrawerModeDBCheckBox.Enabled then
    pnlTwoDrawerMode.Hint := 'Enabling two drawer mode automatically sets the config set "Allow Drawer Assignment".' + #10#13 +
      TWO_DRAWER_MODE_ADDITIONAL_HINT;

  cmbbxHardwareType.Hint := cmbbxHardwareType.Text;

  cmbbxKioskUser.SendToBack;
  cmbbxKioskUser.Enabled := False;

  if cmbbxHardwareType.Value <> '' then
    isEnabled := (not (strtoint(cmbbxHardwareType.Value) in [integer(ehtConqueror), integer(ehtHotelSystem)]))
  else
    isEnabled := true;

  dbEdtIPAddress.enabled := isEnabled;
  lblIPAddress.Enabled := isEnabled;
  lblForceIPAddress.Enabled := isEnabled;
  dbEditSubnetMask.Enabled := isEnabled;
  lblSubnetMask.Enabled := isEnabled;
  lblForceSubnet.Enabled := isEnabled;
  dbeditGatewayIP.Enabled := isEnabled;
  lblGatewayIP.Enabled := isEnabled;
  lblForceGateway.Enabled := isEnabled;
  LblPosCode.Enabled := isEnabled;
  cbTerminalName.Enabled := isEnabled;
  ResetOrderNumberLabel.Enabled := isEnabled;
  ResetAccountNumberCheck.Enabled := isEnabled;

  if FMode in [EDIT_SERVER, ADD_SERVER, EDIT_CONQUEROR_SERVER] then
  begin
    LblPosCode.Enabled := False;
    cbTerminalName.Enabled := False;
  end;

  ValidateTermName := cbTerminalName.Enabled;

  ShowPound := False;
  if not (cmbbxHardwareType.Value = '') then
    ShowPound := TerminalRequiresPoundCodeSetting(StrToInt(cmbbxHardwareType.Value));
  lblpound.Visible := ShowPound;
  DBEditPound.Visible := ShowPound;


  if FMode in [EDIT_TERMINAL, ADD_TERMINAL] then
  begin
    if cmbbxHardwareType.Value <> '' then // when Form is 1st loaded this is NOT yet set
    begin                                 //   to Z500 or other values so the below code should be bypassed...
      if cmbbxHardwareType.Value = inttostr(ord(ehtZ500)) then
      begin
        pnladditional.Top := 186;
        lblScreenInterfaceID.Caption := 'Hardware Screen Size: ';
        cmbbxScreenInterfaceID.BringToFront;
      end
      else
      if cmbbxHardwareType.Value = inttostr(ord(ehtKiosk)) then
      begin
        pnladditional.Top := 186;
        lblScreenInterfaceID.Caption := 'Kiosk User : ';
        cmbbxKioskUser.BringToFront;
        cmbbxKioskUser.Enabled := True;
      end
      else
      begin
        cmbbxScreenInterfaceID.ItemIndex := 0; // set screen to 12" for any till not Z500
        cmbbxScreenInterfaceID.Value := '0';
        cmbbxScreenInterfaceID.Field.AsInteger := 0;
        pnladditional.Top := 162;
        cmbbxScreenInterfaceID.SendToBack;
      end;

      if (FMode = ADD_TERMINAL)
      and (
           (cmbbxHardWareType.Value = IntToStr(ord(ehtMOAPayAtTable)))
            or (cmbbxHardWareType.Value = IntToStr(ord(ehtKiosk)))
           ) then
      begin
        NewId := dsEditRec.DataSet.FieldByName('EposDeviceID').AsInteger;
        IdNotValid := DuplicateCalculatedPortNumber(NewId);

        if IdNotValid then
        begin
          dmADO.qRun.SQL.Text := Format('DECLARE @NextAvailableID SMALLINT ' +
                               ' exec ac_spGetNextAvailableEposDeviceId @NextAvailableID OUTPUT, NULL, %d, %d ' +
                               ' SELECT @NextAvailableID AS NextAvailableID ', [maxEposDeviceID, FSiteCode]);

          dmADO.qRun.Open;
          if dmADO.qRun.FieldByName('NextAvailableID').IsNull then
            NewID := -1
          else
            NewID := dmADO.qRun.FieldByName('NextAvailableID').AsInteger;

          if NewID = -1 then
            raise Exception.Create('Error setting a valid Device ID for this device: No more devices may be added to the system at this time - contact Zonal.');

          dmADO.qRun.Close;
        end;
        dsEditRec.DataSet.FieldByName('EposDeviceID').AsInteger := NewID;
      end;
    end;
  end;


  if not isEnabled then
  begin
    dbEdtIPAddress.Text := '';
    dbEditSubnetMask.Text := '';
    dbeditGatewayIP.Text := '';
  end;

  if not (cbTerminalName.Visible and cbTerminalName.Enabled) then
    cbTerminalName.Clear;

  if cmbbxHardwareType.Value = inttostr(ord(ehtKiosk)) then
     begin
       cbCustomerDisplayType.ItemIndex := 0;
       DBMemo1.Clear;
     end;

   cbCustomerDisplayType.Enabled := cmbbxHardwareType.Value <> inttostr(ord(ehtKiosk));
   DBMemo1.Enabled := cmbbxHardwareType.Value <> inttostr(ord(ehtKiosk));
end;

procedure TfrmAddEditTerminal.PopulateHardwareDropDown;
var
  HardwareExclusionList: String;
  DropDownWidth: Integer;
  HardwareName: String;
begin
  if (FMode in [EDIT_TERMINAL, ADD_TERMINAL, EDIT_SERVER]) and not
   (dsEditRec.DataSet.FieldByName('HardwareType').AsInteger  in [ord(ehtConqueror), ord(ehtHotelSystem)]) then
  begin
    HardwareExclusionList := inttostr(ord(ehtConqueror)) + ',' +
                             inttostr(ord(ehtHotelSystem))+ ',' + inttoStr(ord(ehtBookingsAPI)) + ',' +
                             intToStr(ord(ehtMobileOrdering)) + ',' + intToStr(ord(ehtMOAOrderPad)) + ',' +
                             intToStr(ord(ehtiZoneTables)) + ',' + intToStr(ord(ehtQueueBuster));

    // if the EposDeviceId has the same modulus 256 value as other devices hosted by the site
    // then exclude Kiosk and MOA Pay At Table hardware types from the hardware type dropdown list
    if (FMode = EDIT_TERMINAL)
    and not (dsEditRec.DataSet.FieldByName('HardwareType').AsInteger in [ord(ehtKiosk), ord(ehtMOAPayAtTable)])
    and DuplicateCalculatedPortNumber(dsEditRec.DataSet.FieldByName('EposDeviceID').AsInteger) then
      HardwareExclusionList := HardwareExclusionList + ',' +
                               IntToStr(ord(ehtKiosk)) + ',' +
                               IntToStr(ord(ehtMOAPayAtTable));
  end
  else if (FMode = ADD_SERVER) then
     HardwareExclusionList := IntToStr(Ord(ehtBookingsAPI)) + ',' +
                              IntToStr(ord(ehtMobileOrdering)) + ',' + IntToStr(ord(ehtMOAOrderPad)) + ',' +
                              IntToStr(ord(ehtMOAPayAtTable)) + ',' + IntToStr(ord(ehtiZoneTables)) + ',' +
                              IntToStr(ord(ehtQueueBuster));

  //As of 3.6.0.0 the Z300 cannot be added to a site on 3.6.0.0 and above
  if not dmADO.isLowVersionSite('3.6.0.0',FSiteCode) then
  begin
    if (Length(HardwareExclusionList) > 0) then
      HardwareExclusionList := HardwareExclusionList + ',';
    HardwareExclusionList := HardwareExclusionList + IntToStr(ord(ehtZ300));
  end;

  //As of 3.12.2 the Handheld cannot be added to a site on 3.12.2 and above
  if not dmADO.isLowVersionSite('3.12.2.0',FSiteCode) then
  begin
    if (Length(HardwareExclusionList) > 0) then
      HardwareExclusionList := HardwareExclusionList + ',';
    HardwareExclusionList := HardwareExclusionList + IntToStr(ord(ehtHandheld));
  end;

  //SuperPos Server cannot be added to a site below 3.17.0
  if dmADO.isLowVersionSite('3.17.0.0',FSiteCode) then
  begin
    if (Length(HardwareExclusionList) > 0) then
      HardwareExclusionList := HardwareExclusionList + ',';
    HardwareExclusionList := HardwareExclusionList + IntToStr(ord(ehtZonalSuperPOSServer)) + ',' + intToStr(ord(ehtZonalPOSIoTServer));
  end;

  if (FMode in [EDIT_TERMINAL, ADD_TERMINAL])
  then
    HardwareExclusionList := HardwareExclusionList + ',' + intToStr(ord(ehtZonalSuperPOSServer)) +
                                                     ',' + intToStr(ord(ehtZonalPOSIoTServer));

  cmbbxHardwareType.Items.Clear;
  with dmAdo.adoqrun do
  begin
    close;
    sql.clear;
    sql.add ('SELECT [HardwareType], [HardwareName] FROM dbo.[TerminalHardware]');
    if (length(HardwareExclusionList) > 0) then
      sql.Add('WHERE NOT [HardwareType] IN (' +HardwareExclusionList + ')');
    open;
    DropDownWidth := 0;
    while not eof do
    begin
      HardwareName := fieldbyname('HardwareName').AsString + #9 + fieldbyname('HardwareType').AsString;
      cmbbxHardwareType.Items.AddObject(HardwareName, TObject(FieldbyName('HardwareType').AsInteger));
      DropDownWidth := Max(DropDownWidth, cmbbxHardwareType.Canvas.TextWidth(HardwareName));
      next;
    end;
    cmbbxHardwareType.DropDownWidth := DropDownWidth;
  end;
end;

// checks that the EPoSDeviceId does not clash with the calculated port number of any
// devices that are hosted by the site. The port number is calculated by the Till Program
// using EposDeviceId modulus 256.
function TfrmAddEditTerminal.DuplicateCalculatedPortNumber(NewID: SmallInt): Boolean;
begin
  with dmADO.adoqRun do
  begin
    Close;
    SQL.Text :=
      'SELECT COUNT(*) AS TheCount ' +
      'FROM ThemeEposDevice ' +
      'WHERE SiteCode = ' +  IntToStr(FSiteCode) + ' ' +
      'AND ((HardwareType IN (' +
      IntToStr(ord(ehtKiosk)) + ', ' + IntToStr(ord(ehtMobileOrdering)) + ', ' + IntToStr(ord(ehtMOAOrderPad)) + ', ' +
      IntToStr(ord(ehtMOAPayAtTable)) + ', ' + IntToStr(ord(ehtiZoneTables)) + ') ' +
      '      OR (IsServer = 1 ' +
      '          AND IPAddress = ' +
      '            (SELECT IPAddress ' +
      '             FROM ThemeOutletConfigs ' +
      '             WHERE SiteCode = ' + IntToStr(FSiteCode) + '))) ' +
      'AND (EposDeviceId % 256) = (' + IntToStr(NewId) + ' % 256)) ';
    Open;
    Result := (FieldByName('TheCount').AsInteger > 0);
    SQL.Clear;
    Close;
  end;
end;


procedure TfrmAddEditTerminal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  dmADO.qGetEmployees.Close;
  dmADO.qGetPoses.Close;
end;


procedure TfrmAddEditTerminal.dbEdtEposDeviceIDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    btnSaveClick(Sender);
end;

function TfrmAddEditTerminal.CheckAzOneTerminalAlreadyExists(CurrentEPoSDeviceID: Integer): Boolean;
begin
  with dmADO.adoqRun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT Name, EPoSDeviceID FROM ThemeEpoSDevice ted');
    SQL.Add('WHERE ted.SiteCode = ' + IntToStr(FSiteCode));
    SQL.Add('AND ted.HardwareType IN (' + IntToStr(ord(ehtAzOne)) + ')');
    SQL.Add('AND ted.EPoSDeviceID <> ' + inttoStr(CurrentEPoSDeviceID));
    Open;

    Result := RecordCount > 0;

    if Result then
      MessageDlg(Format('Only one AzOne device can exist per site.' + #13#10 + 'AzOne device ''%s'' (Device ID = %d) already exists.',
                        [FieldByName('Name').AsString, FieldByName('EPoSDeviceID').AsInteger]),
                 mtInformation,
                 [mbOK],
                 0);

    SQL.Clear;
    Close;
  end;
end;

procedure TfrmAddEditTerminal.GetSiteVirtualIPAddress;
begin
  with dmADO.adoqRun do
  begin
    SQL.Text := format('select IPAddress from ThemeOutletConfigs where SiteCode = %d',
      [FSiteCode]);
    Open;
    FSiteVirtualIPAddress := Fieldbyname('IPAddress').AsString;
    Close;
  end;
end;

procedure TfrmAddEditTerminal.btnSaveClick(Sender: TObject);
begin
  inherited;
  if IsTerminalHardwareMultiDrawerCompatable then
    UpdateConfigSetUseDrawerAssignmentIfRequired(TwoDrawerModeDBCheckBox.Checked)
  else
    UpdateConfigSetUseDrawerAssignmentIfRequired(false);
end;

{**
  Based on the number of comments I've added to explain this method, it's probably
  over complicated and the logic could probably be simplified and the number of ConfigSet updates reduced.
**}
procedure TfrmAddEditTerminal.UpdateConfigSetUseDrawerAssignmentIfRequired(useMultiDrawerMode: boolean);
var
  newUseDrawerAssignment: boolean;
  selectedConfigSetId: integer;
  configSetInUseOnAnotherTillUsingMultiDrawerMode: boolean;
  tempUseDrawerAssignment: boolean;
begin

  if ( cbConfigSet.Value = '') then
     exit;

  selectedConfigSetId := StrToInt(cbConfigSet.Value);

  // Don't need to make any changes if MultiDrawerMode and ConfigSet haven't been changed
  if (OldConfigSetId = selectedConfigSetId) AND (OldUseMultiDrawerMode = useMultiDrawerMode) then
    exit;

  dmADO.qRun.Close;
  dmADO.qRun.SQL.Clear;

  // User has changed the configset from the initial setting
  if (OldConfigSetId <> selectedConfigSetId) then
  begin
    // check if the initial (old) configset is in use by a till with multiDrawerMode on...
    configSetInUseOnAnotherTillUsingMultiDrawerMode := IsConfigSetInUseWithAnotherMultiDrawerModeTill(OldConfigSetId, dbEdtEposDeviceID.Field.AsInteger);
    newUseDrawerAssignment := GetUseDrawerAssignmentForConfigSet(selectedConfigSetId);

    // If there are no tills in multi-drawer mode using the old ConfigSet then
    // update the UseDrawerAssignment value in the old and new config sets
    // based on the multi-drawer state and existing UseDrawerAssignment values.
    if (not configSetInUseOnAnotherTillUsingMultiDrawerMode) then
    begin

      // so... if the the old configSet is not in use with another till in multiDrawerMode
      // check if this till was in multiDrawerMode, if it was then disable the
      // old ConfigSet.UseDrawerAssignment, otherwise use the exisiting (old) configSet useDrawerAssignment
      // this preserves the useDrawerAssignment value when the MultDrawerMode is not being used.
      // One problem with this is if the multiDrawerMode is also switched off, the UseDrawerMode
      // for the old configSet will be switched off (even if it was on before multiDrawerMode was enabled)!!!
      if OldUseMultiDrawerMode then
        tempUseDrawerAssignment := false
      else
        tempUseDrawerAssignment := OldUseDrawerAssignment;

      // Update the old configSet.UseDrawerAssignment value
      dmADO.qRun.SQL.Text := 'UPDATE ThemeConfigSet SET UseDrawerAssignment = ' +
                              BoolToStr(tempUseDrawerAssignment) +
                             'WHERE ConfigSetId = ' + IntToStr(OldConfigSetId);
      dmADO.qRun.ExecSQL;
    end;
      // Update the newly selected configSet.UseDrawerAssignment value
      // based on it's existing value or if MultiDrawerMode is on
    dmADO.qRun.SQL.Text := 'UPDATE ThemeConfigSet SET UseDrawerAssignment = '+
                            BoolToStr(newUseDrawerAssignment OR useMultiDrawerMode) +
                           'WHERE ConfigSetId = ' + IntToStr(SelectedConfigSetId);
    dmADO.qRun.ExecSQL;
  end
  else
  begin
    // Only the MultiDrawerMode has been changed
    // so only need to update the selected configSet.UseDrawerAssignment
    configSetInUseOnAnotherTillUsingMultiDrawerMode := IsConfigSetInUseWithAnotherMultiDrawerModeTill(selectedConfigSetId, dbEdtEposDeviceID.Field.AsInteger);

    if(not configSetInUseOnAnotherTillUsingMultiDrawerMode) then
    begin
      dmADO.qRun.SQL.Text := 'UPDATE ThemeConfigSet SET UseDrawerAssignment = '+
                            BoolToStr(useMultiDrawerMode) +
                           ' WHERE ConfigSetId = ' + IntToStr(selectedConfigSetId);
      dmADO.qRun.ExecSQL;
    end;
  end;

  dmADO.qRun.Close;
end;

function TfrmAddEditTerminal.IsConfigSetInUseWithAnotherMultiDrawerModeTill(configSetId: integer; currentEposDeviceId: integer): boolean;
begin
  // check if a configSet is in use by another till in multiDrawerMode
  dmADO.qRun.Close;
  dmADO.qRun.SQL.Clear;
  dmADO.qRun.SQL.Text := 'select a.ConfigSetID, b.MultiDrawerMode ' +
                         'from ThemeConfigSet a '+
                         'join themeeposdevice b on a.ConfigSetID = b.ConfigSetID ' +
                         'where IsServer = 0 '+
                         'and HardwareType in (0, 7) '+ //Z500 & i700
                         'and b.MultiDrawerMode = 1 '+
                         'and b.EPoSDeviceID <> '+ IntToStr(currentEposDeviceId) +
                         ' and b.ConfigSetID = '+ IntToStr(configSetId) +
                         ' Group by a.ConfigSetID, b.MultiDrawerMode';
  dmADO.qRun.Open;
  result := dmADO.qRun.RecordCount > 0;
  dmADO.qRun.Close;
end;

function TfrmAddEditTerminal.GetUseDrawerAssignmentForConfigSet(configSetId: integer): boolean;
begin
  result := dmThemeData.qConfigSets.Lookup('ConfigSetId', configSetId, 'UseDrawerAssignment');
end;

procedure TfrmAddEditTerminal.dbcbxSoloModeClick(Sender: TObject);
var
  InfoMessage: String;
  mr: TModalResult;
  CheckedState: TCheckBoxState;
begin
  inherited;

  if Self.Showing then
  begin
    with (Sender as TDBCheckBox) do
    begin
      CheckedState := State;

      //Only disable the state if we are changing the Solo Mode status compared to
      //the saved value, i.e. don't show one version of the message if the user is
      //repeatedly clicking the checkbox without saving.
      if (Sender as TDBCheckBox).Field.OldValue <> (Sender as TDBCheckBox).Checked then
      begin
        case CheckedState of
          cbUnchecked:
          begin
            InfoMessage := 'Disabling Solo Mode requires that on the next Send to PoS:' + #13#10 + #13#10 +
                           '   -   The terminal is closed.' + #13#10 +
                           '   -   All employees are clocked out.' + #13#10 +
                           '   -   There are no open (non-training) accounts.' + #13#10 + #13#10 +
                           'If these conditions are not met the Send to PoS will fail.' + #13#10 + #13#10 +
                           'Continue and disable Solo Mode?';
          end;

          cbChecked:
          begin
            InfoMessage := 'Enabling Solo Mode requires that on the next Send to PoS:' + #13#10 + #13#10 +
                           '   -   The terminal is closed.' + #13#10 + #13#10 +
                           'If this condition is not met the Send to PoS will fail.' + #13#10 + #13#10 +
                           'Continue and enable Solo Mode?';
          end;

          else
            InfoMessage := '';
        end;

        if InfoMessage <> '' then
        begin
          mr := MessageDlg(InfoMessage, mtConfirmation, [mbOK, mbCancel], 0);
          if mr = mrCancel then
            ToggleCheckedStateWithoutClick(Sender as TCustomCheckBox, CheckedState);
        end;
      end;
    end;
  end;
end;

procedure ToggleCheckedStateWithoutClick(CheckBox: TCustomCheckBox; OriginalState: TCheckBoxState);
begin
  if OriginalState = cbGrayed then exit;

  case OriginalState of
    cbUnchecked: SetCheckedStatusWithoutClick(CheckBox, cbChecked);
    cbChecked: SetCheckedStatusWithoutClick(CheckBox, cbUnchecked);
  end;
end;

procedure SetCheckedStatusWithoutClick(CheckBox: TCustomCheckBox; NewState: TCheckBoxState);
var
  HackCheckBox: THackCheckBox;
begin
  HackCheckBox := THackCheckBox(CheckBox);

  with HackCheckBox do
  begin
    ClicksDisabled := True;
    try
      State := NewState;
    finally
      ClicksDisabled := False;
    end;
  end;
end;

procedure TfrmAddEditTerminal.TwoDrawerModeDBCheckBoxClick(
  Sender: TObject);
var
  Result: Boolean;
  ThemeId: Integer;
begin
  inherited;
  // vk check two drawer mode
  if ((dsEditRec.DataSet.State in [dsInsert, dsEdit]) and TwoDrawerModeDBCheckBox.Checked) then begin

    with dmADO.adoqRun do
    begin

      try
        if (dsEditRec.DataSet.State in [dsInsert]) then begin
          // new entry - get default panelDesign
          SQL.text := 'declare @sitecode int, @themeid int '+
          'select @themeid = themeid from themesites where sitecode = :sitecode '+
          'select @sitecode as sitecode, @themeid as themeid';

          parameters.ParamByName('sitecode').value := FSiteCode;
          open;

          ThemeId := fieldbyname('themeid').asinteger;
          Close;

          SQL.Clear;
          SQL.Add('select IsNull(cast(case when tpd.PanelDesignType in (1,3) then 0 else 1 end as bit), 1) as ValidDesignType');
          SQL.Add('from ThemePanelDesign tpd');
          SQL.Add(Format('where tpd.PanelDesignID in (select top 1 paneldesignid from themepaneldesign where themeid = %d)', [ThemeId]));

          Open;
          if (Recordset.RecordCount < 1) then
            Result := true
          else
            Result := FieldByName('ValidDesignType').AsBoolean;

          if (not Result) then
          begin
            MessageDlg('This terminal is assigned a panel design that is not compatible with two drawer mode.'+#10#13#10#13+
                       'Terminals using ''Z300'' or ''Handheld'' panel design types cannot use two drawer mode functionality.', mtError, [mbOK], 0);


            TwoDrawerModeDBCheckBox.Field.AsBoolean := false;
            TwoDrawerModeDBCheckBox.Checked := false;

          end;

          Close;
        end
        else
        begin
          // existing entry
          if (not IsTerminalPanelDesignMultiDrawerCompatible) then
          begin
            MessageDlg('This terminal is assigned a panel design that is not compatible with two drawer mode.'+#10#13#10#13+
                       'Terminals using ''Z300'' or ''Handheld'' panel design types cannot use two drawer mode functionality.', mtError, [mbOK], 0);


            TwoDrawerModeDBCheckBox.Field.AsBoolean := false;
            TwoDrawerModeDBCheckBox.Checked := false;
          end;

        end;

      except
       on E:Exception do
         ShowMessage('error: '+E.Message);
      end;

    end;
    
  end; // if checked
end;

end.
