unit uAddEditPrinter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uAddEdit, DB, StdCtrls, ComCtrls, ToolWin, DBCtrls, Mask,
  ImgList, wwdblook, Grids, DBGrids, ExtCtrls, adodb, wwdbedit, Wwdotdot,
  Wwdbcomb, uEposDevice;

type
  TParentDeviceDetails = class(TObject)
  private
    FParentHardwareType: TEPOSHardwareType;
    FParentDeviceType: TEPoSDeviceType;
    FParentUsingMultiDrawers: TEPoSMultiDrawerMode;
    procedure GetParentDeviceDetails(SiteCode: Integer; ParentDeviceID: Integer);
    function GetParentDeviceType: TEPoSDeviceType;
    function GetParentHardwareType: TEPOSHardwareType;
    function GetParentMultiDrawerMode: TEPoSMultiDrawerMode;
  public
    property ParentHardwareType: TEPOSHardwareType read GetParentHardwareType;
    property ParentDeviceType: TEPoSDeviceType read GetParentDeviceType;
    property ParentMultiDrawerMode: TEPoSMultiDrawerMode read GetParentMultiDrawerMode;
    function DoInitialise(const SiteCode: Integer; const ParentDeviceID: Integer): Boolean;
  end;

  TfrmAddEditPrinter = class(TfrmAddEdit)
    lblName: TLabel;
    lblPrinterType: TLabel;
    DBedtName: TDBEdit;
    lblNameReq: TLabel;
    Label1: TLabel;
    pcPortOrIPSettings: TPageControl;
    tsPortSettings: TTabSheet;
    tsIPSettings: TTabSheet;
    lbValidPorts: TLabel;
    Label2: TLabel;
    DBEdtPortNo: TDBEdit;
    lblPortNumber: TLabel;
    DBEditIPAddress: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    DBEditIPPort: TDBEdit;
    Label8: TLabel;
    Label9: TLabel;
    dbLkCbxPrinterType: TwwDBLookupCombo;
    pcScaleOrOtherSettings: TPageControl;
    tsBottomControls: TTabSheet;
    tsSiteScaleConfigs: TTabSheet;
    lblEposName1: TLabel;
    lblEposName2: TLabel;
    lblEposName3: TLabel;
    DBEdtEposName1: TDBEdit;
    DBEdtEposName2: TDBEdit;
    DBEdtEposName3: TDBEdit;
    lblREdirectionalPrinterID: TLabel;
    wwDBLookupCombo1: TwwDBLookupCombo;
    lblTimeout: TLabel;
    lblTimeoutRequired: TLabel;
    edTimeout: TDBEdit;
    DBCbxCompactOrderLines: TDBCheckBox;
    DBCbxShowSeatHeaders: TDBCheckBox;
    Label24: TLabel;
    Label10: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cmScaleDecimalPlaces: TwwDBComboBox;
    cmScaleDisplayUnit: TwwDBComboBox;
    Bevel1: TBevel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    DBcbxEFTPay: TDBCheckBox;
    pnlCashDrawer: TPanel;
    DBcbxCashDrawer: TDBCheckBox;
    lblNoOrderTickets: TLabel;
    DBEdtNoOrderTickets: TDBEdit;
    lblCustomDeviceID: TLabel;
    DBEditCustomDeviceID: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure cbxRedirectPrinterChange(Sender: TObject);
    procedure DBLookupComboBox1Click(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure DBedtNameKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbLkCbxPrinterTypeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure dbLkCbxPrinterTypeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    initialPrinterTypeID: integer;
    InitialScaleDisplayUnit: String;
    DeviceName : String;
    ParentDeviceDetails: TParentDeviceDetails;
    procedure PopulateDefaults;
    function ValidPortNo : Boolean;
    procedure CheckPrinterType;
    function ipAddressInUse(IPAddress : String) : Boolean;
    function PeripheralIsIncompatibleWithSite(PeripheralType : String) : Boolean;
  protected
    procedure CancelChanges; override;
    procedure SaveChanges; override;
    function ValidateFields : Boolean; override;
  end;

const
  COMMIDEA_DEFAULT_PORT_NUMBER = '25000';
  COMMIDEA_DEVICE_NAME = 'CommideaICC';
implementation

uses
  uADO, uGenerateThemeIDs, uSelectPort, uDMThemeData, uAztecLog;


{$R *.dfm}

//------------------------------------------------------------------------------
procedure TfrmAddEditPrinter.PopulateDefaults;
begin
  TLargeIntField(dsEditRec.dataSet.FieldByName('PrinterID')).AsLargeInt :=
    uGenerateThemeIDs.GetNewId(scThemeEposPrinter);
  with dmADO.qrun do
  begin
    SQL.Text := 'select top 1 printertypeid as answer from themeprintertype';
    if ParentDeviceDetails.ParentHardwareType = ehtMOAOrderPad then
    begin
      SQL.Add('where IPComms = 1 and IsPrinter = 1');
      SQL.Add(' order by PrinterTypeName');
    end;
    Open;
    dsEditRec.dataSet.FieldByName('PrinterType').AsInteger := fieldbyname('answer').AsInteger;
    Close;
  end;
  TWordField(dsEditRec.dataSet.FieldByName('PortNumber')).AsInteger := 1; //** default the value
  dsEditRec.DataSet.FieldByName('EposName1').AsString := '';
  dsEditRec.DataSet.FieldByName('EposName2').AsString := '';
  dsEditRec.DataSet.FieldByName('EposName3').AsString := '';
  dsEditRec.DataSet.FieldByName('ChangePaperTimeout').AsInteger := 20000;
  dsEditRec.DataSet.FieldByName('CompactOrderLines').AsBoolean := FALSE;
  dsEditRec.DataSet.FieldByName('ShowSeatHeader').AsBoolean := TRUE;
  dsEditRec.DataSet.FieldByName('EnableEFTPay').AsBoolean := False;
  dsEditRec.DataSet.FieldByName('HasCashDrawer').AsBoolean := False;
  dsEditRec.DataSet.FieldByName('OrderTicketsToPrint').AsInteger := 1;
end;

//------------------------------------------------------------------------------
// Mode 0 = Edit Peripheral, Mode 1 = Add Peripheral,  -  ONLY EVER OPENED WITH MODE 0 OR 1
// Mode 2 = Edit Server Printer, Mode 3 = Add Server Printer
procedure TfrmAddEditPrinter.FormShow(Sender: TObject);
var
  ExistingPeripheralId: integer;
  ExistingPeripheralType: integer;

  function BoolToBit(b: bool): integer;
  begin
    if b then Result := 1 else Result := 0;
  end;

begin
  ExistingPeripheralId := -1;
  ExistingPeripheralType := -1;
  if not ParentDeviceDetails.DoInitialise(FSiteCode, FParentDeviceID) then
  begin
    //We can't validate correctly if initialisation fails.  In order to close
    //a modal form from within the OnShow we need to post a WM_CLOSE message
    //but only after we disconnect the annoying OnCloseQuery handler.  YUK!
    Self.OnCloseQuery := nil;
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
  end;

  if not(dsEditRec.dataSet.FieldByName('PrinterID').IsNull or (FMode = ADD_PERIPHERAL)) then
  begin
    ExistingPeripheralId := dsEditRec.dataSet.FieldByName('PrinterID').AsInteger;
    ExistingPeripheralType := dsEditRec.dataSet.FieldByName('PrinterType').AsInteger;
  end;

  with dmADO.qPrinterTypes do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add('SELECT * FROM ThemePrinterType WHERE');

    if ParentDeviceDetails.ParentDeviceType = edtServer then
    begin
       //NB - Device 'Ocius PED (Integrated Printer)' allow report printing of
       //terminal reports on the PED but will crash the comms server if
       //if it is attached to it and attempts to print anything.  Applies to normal PED
       //printout, e.g. receipts, as well as terminal reports.  For aesthetics
       //we disallow the normal PED and the printer equipped version.  Note this
       //is specific to the PED rather than making it a blanket ban, i.e  avoided
       //(IsPrinter or (IsPrinter and IsPINPad and PINPadType = 'DataCash')) or
       //sum such kludge.
       //EB 2017-03-23
       SQL.Add('   ((IsPrinter = 1 AND NOT (IsPINPad = 1 AND PINPadType in (select id from ThemePinPadTypeLookup where value = ''Ocius'')))');
       SQL.Add('OR  (IsPINPad = 1 AND PinPadType = (select id from ThemePinPadTypeLookup where value = ''DataCash'')))');

       if (ParentDeviceDetails.ParentHardwareType in [ehtZonalSuperPOSServer]) then
         SQL.Add(' AND (IPComms = 1)')
    end
    else if ParentDeviceDetails.ParentHardwareType = ehtMOAOrderPad then
       SQL.Add('(IsPrinter = 1 AND IPComms = 1)')

    else if ParentDeviceDetails.ParentHardwareType = ehtAzOne then
       SQL.Add('(IPComms = 1)')

    else
    begin
       SQL.Add('(');
       SQL.Add(Format('(IsTextInserter = 0 OR (IsTextInserter = 1 AND %d = 0))',
          [BoolToBit(TerminalHasTextInserter(FSiteCode, FParentDeviceID, FALSE, ExistingPeripheralId))]));

       if ParentDeviceDetails.ParentHardwareType = ehtMOAPayAtTable then
         SQL.Add('AND NOT(IsPINPad = 1 AND PinPadType IN (select id from ThemePinPadTypeLookup where value = ''Ocius''))');
       SQL.Add(')');
    end;

    // Ensure that if a peripheral type has already been selected (i.e. we are editing a peripheral) that it is always
    // in the list, otherwise the combo box will show as blank. There are cases where certain types were allowed in the
    // past but in later versions were disallowed e.g. Ocius pinpads on MOA devices - see CR PM930.
    if ExistingPeripheralType <> -1 then
      SQL.Add('OR (PrinterTypeId = ' + IntToStr(ExistingPeripheralType) + ')');

    SQL.Add('ORDER BY [PrinterTypeName]');
    Active := true;
  end;

  dmADO.qRun.Close;

  tsPortSettings.TabVisible := false;
  tsIPSettings.TabVisible := false;
  tsSiteScaleConfigs.TabVisible := false;
  tsBottomControls.TabVisible := false;


  if Fmode = EDIT_PERIPHERAL then
    dsEditRec.DataSet.Edit
  else
  begin
    dsEditRec.DataSet.Append;
    dsEditRec.DataSet.FieldByName('SiteCode').Value := FSiteCode;
    dsEditRec.DataSet.FieldByName('EPoSDeviceID').Value := FParentDeviceID;
  end;

  if dsEditRec.state in [dsInsert] then
    populateDefaults;

  dmADO.qRedirectPrinterLookup.Close;
  dmADO.qRedirectPrinterLookup.Parameters.ParamByName('PrinterID').Value := TLargeIntField(dsEditRec.dataSet.FieldByName('PrinterID')).AsLargeInt;
  dmADO.qRedirectPrinterLookup.Open;

  // work around buguette in wwdblookupcombo- doesn't lookup null fields at first
  if wwdblookupcombo1.text = '' then
    wwdblookupcombo1.Text := '<no printer>';

  dmThemeData.AccessDataset(dmADO.qOutletConfigs);

  InitialScaleDisplayUnit := dmADO.qOutletConfigs.FieldbyName('ScaleDisplayUnit').AsString;
  initialPrinterTypeID := dsEditRec.dataSet.FieldByName('PrinterType').AsInteger;
  CheckPrinterType;

  if ParentDeviceDetails.ParentHardwareType = ehtXPPos then
     DBEdtPortNo.MaxLength := 3
end;

//------------------------------------------------------------------------------
function TfrmAddEditPrinter.ValidateFields: Boolean;

  function IsRoamingPinPad: boolean;
  var
    checkQry: TADOQuery;
  begin
    checkQry := TADOQuery.Create(nil);
    checkQry.Connection := dmAdo.AztecConn;
    checkQry.SQL.Text :=
      Format('SELECT ' +
             '  CASE ' +
             '    WHEN %d IN ' +
             '      (SELECT PrinterTypeId FROM ThemePrinterType ' +
             '       WHERE %s) THEN CAST(1 AS bit) ' +
             '    ELSE CAST(0 AS bit) ' +
             '  END AS IsRoamingPinPad ', [InitialPrinterTypeID, 'PrinterTypeName LIKE ''%roaming%''']);
    try
      checkQry.Open;
      Result := checkQry.FieldByName('IsRoamingPinPad').AsBoolean;
    finally
      checkQry.Close;
      checkQry.Free;
    end;
  end;

begin
  Result := TRUE;

  if DBedtName.Text = '' then
  begin
    Result := false;
    DBedtName.SetFocus;
    MessageDlg('Device Name is required', mtInformation, [mbOK], 0);
  end
  else if dbLkCbxPrinterType.Text = '' then
  begin
    Result := false;
    dbLkCbxPrinterType.SetFocus;
    MessageDlg('Device Type is required', mtInformation, [mbOK], 0);
  end
  else if (pcPortOrIPSettings.ActivePage = tsIPSettings) and
     (DBEditIPAddress.text = '') then
  begin
    result := false;
    DBEditIPAddress.setfocus;
    MessageDlg('IP address is required', mtInformation, [mbOK], 0);
  end
  else if (not IsRoamingPinPad)
        and (pcPortOrIPSettings.ActivePage = tsIPSettings)
        and (ipAddressInUse(DBEditIPAddress.Text)) then
  begin
    Result := FALSE;
    DBEditIPAddress.SetFocus;
    MessageDlg('IP Address '+DBEditIPAddress.Text+' is already being used by '+DeviceName+'.', mtInformation, [mbOK], 0);
  end
  else if (pcPortOrIPSettings.ActivePage = tsIPSettings) and
    (DBEditIPPort.text = '') then
  begin
    result := false;
    DBEditIPPort.setfocus;
    MessageDlg('IP port is required', mtInformation, [mbOK], 0);
  end
  else if (pcScaleOrOtherSettings.ActivePage = tsSiteScaleConfigs) and (cmScaleDecimalPlaces.ItemIndex = -1) then
  begin
    Result := False;
    cmScaleDecimalPlaces.SetFocus;
    MessageDlg('Scale decimal places is required', mtInformation, [mbOK], 0);
  end
  else if (pcScaleOrOtherSettings.ActivePage = tsSiteScaleConfigs) and (cmScaleDisplayUnit.ItemIndex = -1) then
  begin
    Result := False;
    cmScaleDisplayUnit.SetFocus;
    MessageDlg('Scale display unit is required', mtInformation, [mbOK], 0);
  end
  else if (pcScaleOrOtherSettings.ActivePage = tsSiteScaleConfigs)
      and (cmScaleDisplayUnit.Text <> InitialScaleDisplayUnit)
      and (InitialScaleDisplayUnit <> '') then
  begin
    if MessageDlg('Changing the scale display unit should only be done if all ' + #13#10 +
                  'sold by weight products have been adjusted accordingly.' + #13#10 +
                  'Do you wish to continue?',
                  mtWarning,
                  [mbYes, mbNo],
                  0) = mrNo then
    begin
      Result := False;
    end;
  end
  else if (pcPortOrIPSettings.ActivePage = tsPortSettings) and (DBEdtPortNo.Text = '') then
  begin
    Result := false;
    DBEdtPortNo.SetFocus;
    MessageDlg('Port Number is required', mtInformation, [mbOK], 0);
  end
  else if (pcPortOrIPSettings.ActivePage = tsPortSettings) and (not ValidPortNo) then
  begin
    Result := False;
    DBEdtPortNo.SetFocus;
    MessageDlg('Port Number ' + DBEdtPortNo.Text + ' is already used by another device' + #13#10 +
               'attached to the terminal/server', mtInformation, [mbOK], 0);
  end
  else if (pcScaleOrOtherSettings.ActivePage = tsBottomControls) and (edTimeout.text = '') then
  begin
    Result := false;
    edTimeout.SetFocus;
    MessageDlg('Change paper timeout is required', mtInformation, [mbOK], 0);
  end
  else
  try
    if (pcScaleOrOtherSettings.ActivePage = tsBottomControls) and (strtoint(edtimeout.text) < 0) then
    begin
      Result := false;
      edTimeout.SetFocus;
      MessageDlg('Change paper timeout cannot be negative', mtInformation, [mbOK], 0);
    end;
  except
    result := false;
      edTimeout.SetFocus;
      MessageDlg('Change paper timeout is invalid', mtInformation, [mbOK], 0);
  end;
  if (pcPortOrIPSettings.ActivePage = tsIPSettings) then
    dmado.ValidateIPAddress(DBEditIPAddress.Field);
end;

//------------------------------------------------------------------------------
function TfrmAddEditPrinter.ValidPortNo: Boolean;
begin
  Result := FALSE;

  if DBEdtPortNo.Text = '' then
    exit;

  with dmADO.qRun do
  begin
    Close;
    SQL.Clear;
    if dmAdo.qPrinterTypes.FieldByName('IsKitchenScreen').AsBoolean then
    begin
      // Can have more than one Kitchen Screen on the same port
      SQL.Add('SELECT ep.Name AS Answer ');
      SQL.Add('FROM ThemeEposPrinter ep join ThemePrinterType pt ');
      SQL.Add('  ON ep.PrinterType = pt.PrinterTypeID ');
      SQL.Add('WHERE ep.SiteCode = :Sitecode ');
      SQL.Add('AND ep.EposDeviceID = :EposDeviceID ');
      SQL.Add('AND ep.PrinterID <> :PrinterID ');
      SQL.Add('AND ep.PortNumber = :PortNumber ');
      SQL.Add('AND pt.IsKitchenScreen = 0 ');
    end
    else
    begin
      SQL.Add('SELECT Name as Answer FROM ThemeEposPrinter ');
      SQL.Add('WHERE SiteCode = :Sitecode ');
      SQL.Add('AND EposDeviceID = :EposDeviceID ');
      SQL.Add('AND PrinterID <> :PrinterID ');
      SQL.Add('AND PortNumber = :PortNumber ');
    end;
    Parameters[0].Value := FSiteCode;
    Parameters[1].Value := FParentDeviceID;
    Parameters[2].Value := TLargeIntField(dsEditRec.dataSet.FieldByName('PrinterID')).AsLargeInt;
    //** use the text property as if the user is in the dbedit control. The new
    //** field value will not be in the dataset.
    Parameters[3].Value := StrToInt(DBEdtPortNo.Text);
    Open;
    Result := BOF and EOF;
  end;
end;

//------------------------------------------------------------------------------
procedure TfrmAddEditPrinter.cbxRedirectPrinterChange(Sender: TObject);
begin
  inherited;
end;

//------------------------------------------------------------------------------
procedure TfrmAddEditPrinter.DBLookupComboBox1Click(Sender: TObject);
begin
  inherited;
  TLargeintField(dsEditRec.DataSet.FieldByName('RedirectionPrinterId')).AsLargeInt :=
      TLargeIntField(dmAdo.qRedirectPrinterLookUp.FieldByName('printerID')).AsLargeInt;
end;

//------------------------------------------------------------------------------
procedure TfrmAddEditPrinter.btnSaveClick(Sender: TObject);
var
  FPrinterType : integer;
  FPortNumber : integer;
  ClearPrinterAccess: boolean;
  ClearPeripheralAccess: boolean;
begin
  ClearPrinterAccess := false;
  ClearPeripheralAccess := false;
  FPrinterType := dsEditRec.DataSet.fieldbyname('PrinterType').asInteger;
  try
    dmADO.qRun.SQL.Text := 'select IPComms, case PinPadType when 2 then cast(1 as bit) else cast(0 as bit) end as IsCommideaDevice, IsPrinter, IsPinPad from ThemePrinterType where PrinterTypeID = '+inttostr(FPrinterType);
    dmADO.qRun.Open;
    if not dmADO.qRun.FieldByName('IPComms').AsBoolean then
      if ParentDeviceDetails.ParentHardwareType <> ehtXPPos then
        if DBEdtPortNo.Text <> '' then
        begin
          FPortNumber := StrToInt(DBEdtPortNo.Text);
          if not ValidatePeripheralPorts(FSiteCode, FParentDeviceID,FPrinterType,FPortNumber)then
            raise Exception.Create('The port selected for this type of device is invalid'+ #10#13 +
                                        'Please select another port number');
        end;

    if dmADO.qRun.FieldByName('IPComms').AsBoolean then
    begin
      dsEditRec.Dataset.FieldByName('PortNumber').Clear;
      if dmADO.qRun.FieldByName('isCommideaDevice').AsBoolean then
      begin
        if DBEditIPPort.Text = '' then
        begin
          DBEditIPPort.SetFocus;
          raise Exception.Create('Port Number Field Cannot Be Blank');
        end;
      end;
    end
    else
    begin
      dsEditRec.Dataset.FieldByName('IPAddress').Clear;
      dsEditRec.Dataset.FieldByName('IPPort').Clear;
      dsEditRec.DataSet.FieldByName('HasCashDrawer').AsBoolean := FALSE;
    end;
    if DBcbxEFTPay.Visible = False then
       dsEditRec.DataSet.FieldByName('EnableEFTPay').AsBoolean := False;

    ClearPrinterAccess := not dmADO.qRun.FieldByName('IsPrinter').AsBoolean;
    ClearPeripheralAccess := not dmADO.qRun.FieldByName('IsPinPad').AsBoolean;

  finally
    dmADO.qRun.Close;
  end;

  inherited;

  if ClearPrinterAccess then
  begin
     dmADO.qRun.SQL.Text := 'delete ThemeEposPrinterStream where SiteCode = ' +IntToStr(FSiteCode)+ ' and PrinterID = '+ dsEditRec.DataSet.fieldbyname('PrinterId').AsString;
     dmADO.qRun.ExecSQL;
     dmADO.qRun.SQL.Text := 'update ThemeEposPrinterStream '+
      'set Optional = 0 '+
      'from ThemeEposPrinterStream a '+
      'join ( '+
      'select SiteCode, EposDeviceID, PrintStreamID '+
      'from ThemeEposPrinterStream '+
      'group by SiteCode, EposDeviceID, PrintStreamID '+
      'having MAX(Optional*1) > 0 and COUNT(*) = 1 '+
      ') b on a.SiteCode = b.SiteCode and a.EposDeviceID = b.EposDeviceID and a.PrintStreamID = b.PrintStreamID '+
      'where a.SiteCode = '+IntToStr(FSiteCode) ;
     dmADO.qRun.ExecSQL;
  end;

  if ClearPeripheralAccess then
  begin
     dmADO.qRun.SQL.Text := 'delete ThemeEposPeripheralAccess where SiteCode = ' +IntToStr(FSiteCode)+ ' and PeripheralID = '+ dsEditRec.DataSet.fieldbyname('PrinterId').AsString;
     dmADO.qRun.ExecSQL;
  end;


end;

//------------------------------------------------------------------------------
procedure TfrmAddEditPrinter.DBedtNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  // Do not apply to OnKeyPress of TwwDBLookupCombo that contains validation in OnCloseUp event. OnKeyPress runs first
  // and validation is skipped (bug 365783)
  inherited;
  if Key = #13 then
    btnSaveClick(self);
end;

procedure TfrmAddEditPrinter.CheckPrinterType;
var
  i: integer;
  ShowBottomControls, IsCoinDispenser, IsScale, IsPrinter, IsPinPad, IsBarcodeReader, IsEFTPay, IsePurse, IsKitchenScreen : boolean;
  ValidPorts: string;
  FirstValidPort: Integer;
  PeripheralID : integer;
  PeripheralType : String;
  PeripheralName : String;
begin
  PeripheralID := dsEditRec.DataSet.fieldbyname('PrinterID').asInteger;
  PeripheralType := dsEditRec.DataSet.FieldByName('PrinterType').AsString;
  PeripheralName := dsEditRec.DataSet.FieldByName('PrinterTypeName').AsString;

  if PeripheralIsIncompatibleWithSite(PeripheralType) then
  begin
    MessageDlg(PeripheralName + ' is not compatible with this site''s version of '#13#10''
    + 'Aztec, please choose another device.', mtInformation, [mbOK], 0);
    if mrOK = 1 then
    begin
       dsEditRec.DataSet.FieldByName('PrinterType').AsInteger := initialPrintertypeID;
    end;
  end;

  if dbLkCbxPrinterType.Text = COMMIDEA_DEVICE_NAME  then
  begin
    if CommideaDeviceExistsForTerminal(FSiteCode, FParentDeviceID, PeripheralID) then
    begin
      dsEditRec.DataSet.FieldByName('PrinterType').AsInteger := initialPrintertypeID;
      raise Exception.Create('Cannot add more than 1 Commidea device to a Terminal');
    end;
    DBEdtPortNo.Text := '';
    if DBEditIPPort.Text = '' then
      DBEditIPPort.Text := COMMIDEA_DEFAULT_PORT_NUMBER;
  end;

  if TerminalHasPeripheralType(FSiteCode, FParentDeviceID, dsEditRec.dataset.FieldByName('PrinterType').AsInteger, TRUE, PeripheralID) then
  begin
    dsEditRec.DataSet.FieldByName('PrinterType').AsInteger := initialPrintertypeID;
    Exit;
  end;

  with TADOQuery.Create(Self) do
  begin
    Connection := dmADO.AztecConn;
    sql.Clear;
    sql.Add('select [IPComms], [IsPrinter], ISNULL(CashDrawerCommand, '''') AS CashDrawerCommand from [ThemePrinterType]');
    sql.Add('where [PrinterTypeID] = ' + PeripheralType);
    Open;
    // Style of tabs at design time allows to easily line up the tabsheet
    // and change tabs. TabVisible property of each tab sheet is set false,
    // so changing the tab style here just hides the border of the tab sheet
    pcPortOrIPSettings.TabPosition := tpTop;
    pcPortOrIPSettings.Style := tsButtons;
    if FieldByName('IPComms').AsBoolean then
    begin
      pcPortOrIPSettings.ActivePage := tsIPSettings;
      DBcbxCashDrawer.Visible :=
        FieldByName('IsPrinter').AsBoolean
        and (FieldByName('CashDrawerCommand').AsString <> '')
        and (ParentDeviceDetails.ParentDeviceType <> edtServer)
        and not dmADO.ParentHasIP_printerWithCashDrawer(FSiteCode, FParentDeviceID, TLargeIntField(dsEditRec.dataSet.FieldByName('PrinterID')).AsLargeInt);
      pnlCashDrawer.Hint := '';
      pnlCashDrawer.ShowHint := False;
      if DBcbxCashDrawer.Visible and (ParentDeviceDetails.ParentMultiDrawerMode = emdmMultiple) then
      begin
        DBcbxCashDrawer.Enabled := ParentDeviceDetails.ParentMultiDrawerMode <> emdmMultiple;
        pnlCashDrawer.Hint := 'Cash drawers may not be attached when the parent device' + #13#10 +
                              'is operating in two-drawer mode.';
        pnlCashDrawer.ShowHint := True;
      end;
    end
    else
      pcPortOrIPSettings.ActivePage := tsPortSettings;
    Close;
    sql.Clear;
    sql.Add('select [IsTextInserter], [IsCoinDispenser], [IsScale], [isPrinter], [isPinPad], [isBarcodeReader], [isEFTPay], [isePurse], [isKitchenScreen] from [ThemePrinterType]');
    sql.Add('where [PrinterTypeID] = ' + PeripheralType);
    Open;
    IsBarcodeReader := FieldByName('isBarcodeReader').AsBoolean;
    IsPrinter := FieldByName('isPrinter').AsBoolean;
    IsPinPad := FieldByName('isPinPad').AsBoolean;
    IsScale := FieldByName('IsScale').AsBoolean;
    IsEFTPay := FieldByName('isEFTPay').AsBoolean;
    IsePurse := FieldByName('IsePurse').AsBoolean;
    IsKitchenScreen := FieldByName('isKitchenScreen').AsBoolean;
    pcScaleOrOtherSettings.TabPosition := tpTop;
    pcScaleOrOtherSettings.Style := tsButtons;
    if IsScale then
      pcScaleOrOtherSettings.ActivePage := tsSiteScaleConfigs
    else
      pcScaleOrOtherSettings.ActivePage := tsBottomControls;
    IsCoinDispenser := FieldByName('IsCoinDispenser').AsBoolean;
    ShowBottomControls := not (FieldByName('IsTextInserter').AsBoolean or
                               IsCoinDispenser or IsBarcodeReader or IsePurse);
    Close;

    if pcScaleOrOtherSettings.ActivePage = tsBottomControls then
    begin
      lblREdirectionalPrinterID.Visible := ShowBottomControls and not IsCoinDispenser;
      lblEposName1.Visible := ShowBottomControls;
      lblEposName2.Visible := ShowBottomControls;
      lblEposName3.Visible := ShowBottomControls;
      DBEdtEposName1.Visible := ShowBottomControls;
      DBEdtEposName2.Visible := ShowBottomControls;
      DBEdtEposName3.Visible := ShowBottomControls;
      wwDBLookupCombo1.Visible := ShowBottomControls;
      edTimeout.Visible := ShowBottomControls or IsCoinDispenser;
      if IsCoinDispenser then
      begin
        lblTimeout.Caption := 'Timeout (ms):';
        lblTimeout.Height := 13;
        lblTimeout.Top := 103;
      end
      else
      begin
        lblTimeout.Caption := 'Change paper timeout (ms):';
        lblTimeout.Height := 30;
        lblTimeout.Top := 95;
      end;
      lblTimeout.Visible := ShowBottomControls or IsCoinDispenser;
      lblTimeoutRequired.Visible := ShowBottomControls;
      lblNoOrderTickets.Visible := ShowBottomControls;
      DBEdtNoOrderTickets.Visible := ShowBottomControls;
      DBCbxCompactOrderLines.Visible := ShowBottomControls;
      DBCbxShowSeatHeaders.Visible := ShowBottomControls;
      DBcbxEFTPay.Visible := ShowBottomControls;
      // custom device id cntrs
      lblCustomDeviceID.Visible := ShowBottomControls and IsPinPad;
      DBEditCustomDeviceID.Visible := ShowBottomControls and IsPinPad;


      // if a non printer pinpad, remove the printer options.
      if ShowBottomControls then
         begin
           lblREdirectionalPrinterID.Visible := not(IsPinPad and not isPrinter);
           wwDBLookupCombo1.Visible := not(IsPinPad and not isPrinter);
           lblTimeout.Visible := not(IsPinPad and not isPrinter);
           edTimeout.Visible := not(IsPinPad and not isPrinter);
           DBCbxCompactOrderLines.Visible := not(IsPinPad and not isPrinter);
           DBCbxShowSeatHeaders.Visible := not(IsPinPad and not isPrinter);
           lblTimeoutRequired.Visible := not(IsPinPad and not isPrinter);
           DBcbxEFTPay.Visible := isEFTPay;

           // also hide number of order tickets when configuring non printer pinpad or kitchen screen
           lblNoOrderTickets.Visible := not(IsPinPad and not isPrinter) and not isKitchenScreen;
           DBEdtNoOrderTickets.Visible := not(IsPinPad and not isPrinter) and not isKitchenScreen;
         end;
    end;

    lbValidPorts.Visible := ParentDeviceDetails.ParentHardwareType <> ehtXPPos;

    if (pcPortOrIPSettings.ActivePage = tsPortSettings) and (ParentDeviceDetails.ParentHardwareType <> ehtXPPos) then
    begin
      if dmAdo.qPrinterTypes.FieldByName('IsKitchenScreen').AsBoolean then
      begin
        SQL.Text := Format('SELECT a.PortNumber FROM ' +
                           '  (SELECT DISTINCT PortNumber FROM PeripheralDevicePortsSetup) a ' +
                           'WHERE a.PortNumber NOT IN ' +
                           '  (SELECT ep.PortNumber ' +
                           '   FROM ThemeEposPrinter ep join ThemePrinterType pt ' +
                           '     ON ep.PrinterType = pt.PrinterTypeID ' +
                           '   WHERE ep.EposDeviceID= %d ' +
                           '   AND ep.PrinterID <> %d AND ep.PortNumber IS NOT NULL ' +
                           '   AND ep.SiteCode = %d AND pt.IsKitchenScreen = 0 ) ',
                           [FParentDeviceID, dsEditRec.dataset.FieldByName('PrinterID').AsInteger, FSiteCode]);
      end
      else
      begin
        SQL.Text := Format('SELECT PortNumber FROM ' +
                           '  (SELECT DISTINCT PortNumber FROM PeripheralDevicePortsSetup) a ' +
                           'WHERE a.PortNumber NOT IN ' +
                           '  (SELECT PortNumber FROM ThemeEposPrinter WHERE EposDeviceID = %d ' +
                           '   AND PrinterID <> %d AND PortNumber IS NOT NULL ' +
                           '   AND SiteCode = %d)',
                           [FParentDeviceID, dsEditRec.dataset.FieldByName('PrinterID').AsInteger, FSiteCode]);
      end;

      Open;
      // work out valid ports
      ValidPorts := '';
      FirstValidPort := 0;
      while not EOF do
      begin
        i := FieldByName('PortNumber').AsInteger;
        if ValidatePeripheralPorts(FSiteCode, FParentDeviceID, StrToInt(PeripheralType), i) then
        begin
          if FirstValidPort = 0 then
            FirstValidPort := i;
          if ValidPorts <> '' then
            ValidPorts := ValidPorts + ', ';
          ValidPorts := ValidPorts + IntToStr(i);
        end;
        Next;
      end;
      Close;
      if ValidPorts = '' then
        ValidPorts := 'None found';
      lbValidPorts.Caption := 'Valid Ports:'+#13+ValidPorts;

      if (Fmode = ADD_PERIPHERAL) and (FirstValidPort <> 0) then
        DBEdtPortNo.Field.Value := IntToStr(FirstValidPort);
    end;
    initialPrinterTypeID := dbLkCbxPrinterType.LookupTable.FieldByName(dblkCbxPrinterType.LookupField).AsInteger;
    Free;
  end;
end;

procedure TfrmAddEditPrinter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  dmADO.qPrinterTypes.Filtered := false;
  dmADO.qRedirectPrinterLookup.Close;
end;

procedure TfrmAddEditPrinter.dbLkCbxPrinterTypeCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  CheckPrinterType;
end;

procedure TfrmAddEditPrinter.dbLkCbxPrinterTypeKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_Return then
    btnSaveClick(self);
end;

procedure TfrmAddEditPrinter.SaveChanges;
begin
  dmThemeData.DeAccessDataset(dmADO.qOutletConfigs, True);
  inherited;
end;

procedure TfrmAddEditPrinter.CancelChanges;
begin
  dmADO.qOutletConfigs.Cancel;
  dmThemeData.DeAccessDataset(dmADO.qOutletConfigs, False);
  inherited;
end;

function TfrmAddEditPrinter.ipAddressInUse(IPAddress : String) : Boolean;
var isCommideaDevice : Boolean;
begin
  Result := False;
  isCommideaDevice := False;

  if dbLkCbxPrinterType.Text = COMMIDEA_DEVICE_NAME then
     isCommideaDevice := True;

  with dmADO.qRun do
    begin
      Close;
      SQL.Text := Format('SELECT SiteCode, PrinterID, Name, IPAddress, IsCommideaDevice  '+
                         ' FROM (SELECT SiteCode, PrinterID, Name, IPAddress, case PinPadType when 2 then cast(1 as bit) else cast(0 as bit) end as IsCommideaDevice '+
                         '             FROM ThemeEposPrinter tep '+
                         '                  INNER JOIN ThemePrinterType tpt ON tep.PrinterType = tpt.PrinterTypeID '+
                         '      UNION '+
                         '      SELECT SiteCode, NULL,  Name, IPAddress, CAST(0 AS BIT) '+
                         '             FROM ThemeEposDevice) x '+
                         ' WHERE SiteCode = %s AND IPAddress = %s', [IntToStr(FSiteCode), QuotedStr(IPAddress) ]);
      Open;
      First;
      if FieldByName('PrinterID').AsString = dsEditRec.DataSet.FieldByName('PrinterID').AsString then
         Result := False
      else
      if (FieldByName('IsCommideaDevice').AsBoolean) and (isCommideaDevice) then
         result := false
      else
      if RecordCount > 0 then
         begin
           Result := True;
           DeviceName := FieldByName('Name').AsString;
         end;
    end
end;

function TfrmAddEditPrinter.PeripheralIsIncompatibleWithSite(PeripheralType: String) : Boolean;
var PeripheralVersionOK : Boolean;
begin
   with dmADO.qRun do
   try
      Close;
      SQL.Text := (
        'DECLARE @Sitecode int '+
        'DECLARE @Version varchar(50) '+
        'SET @SiteCode = '+IntToStr(dmADO.GetSiteCode)+
        'SET @Version = '+
                '(SELECT LowestCompatibleAztecVersion '+
                 'FROM ThemePrinterType '+
                 'WHERE PrinterTypeID = '+QuotedStr(PeripheralType)+')'+
        'SELECT Count(*) AS VersionCount '+
        'FROM '+
        'commsversions HOVersion '+
                'JOIN commsversions SiteVersion ON HOVersion.SiteCode = 0 and SiteVersion.sitecode = @SiteCode '+
        ' WHERE (dbo.fn_strVerToInt64(SiteVersion.[DBVersion]) < dbo.fn_strVerToInt64(@Version)) '
      );
      Open;
      PeripheralVersionOK := FieldByName('VersionCount').AsInteger > 0;
      result := PeripheralVersionOK;
   finally
      Close;
      SQL.Clear;
  end;
end;

{ TParentDeviceDetails }
procedure TParentDeviceDetails.GetParentDeviceDetails(
  SiteCode: Integer;
  ParentDeviceID: Integer);
begin
  with dmADO.qRun do
  try
    Close;
    SQL.Text := Format('SELECT IsServer, HardwareType, MultiDrawerMode'+
                       ' FROM ThemeEposDevice '+
                       ' WHERE SiteCode = %d AND EposDeviceID = %d', [SiteCode, ParentDeviceID]);
    Open;

    if not EOF then
    begin
      FParentDeviceType := edtTerminal;
      if FieldByName('IsServer').AsBoolean then
        FParentDeviceType := edtServer;

      FParentHardwareType := TEPOSHardwareType(FieldByName('HardwareType').AsInteger);

      FParentUsingMultiDrawers := emdmSingle;
      if FieldByName('MultiDrawerMode').AsBoolean then
        FParentUsingMultiDrawers := emdmMultiple;
    end
    else begin
      raise Exception.Create(Format('Unable to determine parent device details for EPoS Device id %d for sitecode %d.', [ParentDeviceID, SiteCode]));
    end;
  finally
    Close;
    SQL.Clear;
  end
end;

procedure TfrmAddEditPrinter.FormCreate(Sender: TObject);
begin
  inherited;
  ParentDeviceDetails := TParentDeviceDetails.Create;
end;

procedure TfrmAddEditPrinter.FormDestroy(Sender: TObject);
begin
  inherited;
  ParentDeviceDetails.Free;
end;

function TParentDeviceDetails.GetParentDeviceType: TEPoSDeviceType;
begin
  Result := FParentDeviceType;
end;

function TParentDeviceDetails.GetParentHardwareType: TEPOSHardwareType;
begin
  Result := FParentHardwareType
end;

function TParentDeviceDetails.GetParentMultiDrawerMode: TEPoSMultiDrawerMode;
begin
  if FParentDeviceType = edtServer then
    Result := emdmSingle
  else
    Result := FParentUsingMultiDrawers
end;

function TParentDeviceDetails.DoInitialise(const SiteCode,
  ParentDeviceID: Integer): Boolean;
begin
  Result := True;
  try
    GetParentDeviceDetails(SiteCode, ParentDeviceID);
  except
    on e:Exception do
    begin
      Result := False;
      Log('Exception: ' + e.Message);
      MessageDlg(e.Message,mtError,[mbOK],0);
    end;
  end;
end;


end.






