unit uEngDeviceList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, DB, ADODB, ImgList, Menus;

type THeightMode = (hmNone, hmSingleLine, hmDoubleLine);

type
  TEngDeviceList = class(TForm)
    tvServerDevices: TTreeView;
    pnlSelectedDetail: TPanel;
    qryServers: TADOQuery;
    qryServersSiteCode: TIntegerField;
    qryServersEPoSDeviceID: TSmallintField;
    qryServersPOSCode: TIntegerField;
    qryServersName: TStringField;
    qryServersIPAddress: TStringField;
    qryServersCustomerDisplayType: TIntegerField;
    qryServersScrollingMessage: TStringField;
    qryServersConfigSetID: TIntegerField;
    qryServersIsServer: TBooleanField;
    qryServersServerID: TSmallintField;
    qryServersHardwareType: TIntegerField;
    qryServerTerminals: TADOQuery;
    qryServerTerminalsSiteCode: TIntegerField;
    qryServerTerminalsEPoSDeviceID: TSmallintField;
    qryServerTerminalsPOSCode: TIntegerField;
    qryServerTerminalsName: TStringField;
    qryServerTerminalsIPAddress: TStringField;
    qryServerTerminalsCustomerDisplayType: TIntegerField;
    qryServerTerminalsScrollingMessage: TStringField;
    qryServerTerminalsConfigSetID: TIntegerField;
    qryServerTerminalsIsServer: TBooleanField;
    qryServerTerminalsServerID: TSmallintField;
    qryServerTerminalsHardwareType: TIntegerField;
    qryTerminalDeviceList: TADOQuery;
    qryTerminalDeviceListName: TStringField;
    qryTerminalDeviceListPrinterTypeName: TStringField;
    qryTerminalDeviceListPortNumber: TWordField;
    qryTerminalDeviceListIPAddress: TStringField;
    qryTerminalDeviceListIPPort: TIntegerField;
    qryTerminalDeviceListDeviceID: TLargeintField;
    qryTerminalDeviceListTypeOfDevice: TStringField;
    qryTerminalDeviceListPrinterType: TIntegerField;
    qryServerPrinters: TADOQuery;
    ilDevices: TImageList;
    qrySelectRoot: TADOQuery;
    qrySelectedServerDetails: TADOQuery;
    qrySelectTerminal: TADOQuery;
    qrySelectPeripheralDevice: TADOQuery;
    pmNodeServerPrinter: TPopupMenu;
    EditServerPrinter: TMenuItem;
    qrySiteServers: TADOQuery;
    pnlBottom: TPanel;
    btnClose: TButton;
    pnlSubTop: TPanel;
    lblNameLabel: TLabel;
    lblName: TLabel;
    pnlSubBottom: TPanel;
    lblHardWareTypeLabel: TLabel;
    lblHardwaretype: TLabel;
    lblDeviceIdLabel: TLabel;
    lblDeviceID: TLabel;
    pnSubMiddle: TPanel;
    lblIPAddressLabel: TLabel;
    lblIPAddress: TLabel;
    procedure FormShow(Sender: TObject);
    procedure tvServerDevicesChange(Sender: TObject; Node: TTreeNode);
    procedure tvServerDevicesMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure EditServerPrinterClick(Sender: TObject);
  private
    SelectedNode, RecordNode: TTreeNode;
    currentPrinterNameHeightMode: THeightMode;
    procedure BuildServerDevicesTree;
    procedure RefreshSelectedDetailPanel;
    procedure ShowTerminalPrinterDialog(fromNodeMenu: Boolean;
      mode: Integer);
    { Private declarations }
  public
    FSiteCode : Integer;
    { Public declarations }
  end;

implementation

uses
  uBaseEdit, uEposDevice, uADO,uHardwareIcons, uAddEditPrinter,
  uDMThemeData;

const
  ROOT_IMAGE = 0;
  SERVER_IMAGE = 1;
  TERMINAL_IMAGE = 2;
  PRINTER_IMAGE = 3;

{$R *.dfm}

procedure TEngDeviceList.BuildServerDevicesTree;
var
  rootNode, serverNode, serverDeviceNode, TerminalDeviceNode: TTreeNode;
  TmpDeviceType: TDeviceObjectType;
begin
  SelectedNode := nil;
  RecordNode := nil;
  tvServerDevices.Items.Clear;
  rootNode := tvServerDevices.Items.Add(nil, '[Site Devices]');
  rootNode.ImageIndex := 0;
  rootNode.Data := TDeviceObject.Create(rootNode, doRoot, -1, -1, 0);

  qryServers.Close;
  qryServers.Parameters.ParamByName('siteCode').Value := FSiteCode;
  qryServers.Open;
  while not qryServers.Eof do
  begin
    serverNode := tvServerDevices.Items.AddChild(rootNode, qryServers.FieldByName('Name').Value);
    serverNode.ImageIndex := SERVER_IMAGE;
    serverNode.SelectedIndex := SERVER_IMAGE;

    case TEPOSHardwareType(qryServers.FieldByName('HardwareType').AsInteger) of
    ehtConqueror:
      TmpDeviceType := doConquerorServer;
    ehtHotelSystem:
      TmpDeviceType := doHotelSystemServer;
    ehtMobileOrdering:
      TmpDeviceType := doMOARemoteOrdering;
    else
      TmpDeviceType := doServer;
    end;

    ServerNode.Data := TDeviceObject.Create(serverNode, TmpDeviceType, qryServers.FieldByName('HardwareType').AsInteger, -1, qryServers.FieldByName('EPoSDeviceID').Value);

    // add nodes for terminals attached to the server
    qryServerTerminals.Close;
    qryServerTerminals.Parameters.ParamByName('serverID').Value := qryServers.FieldByName('EPoSDeviceID').Value;
    qryServerTerminals.Parameters.ParamByName('siteCode').Value := FSiteCode;
    qryServerTerminals.Open;
    while not qryServerTerminals.Eof do
    begin
      serverDeviceNode := tvServerDevices.Items.AddChild(serverNode, qryServerTerminals.FieldByName('Name').Value);
      serverDeviceNode.ImageIndex := TERMINAL_IMAGE;
      serverDeviceNode.SelectedIndex := TERMINAL_IMAGE;
      if (qryServers.FieldByName('HardwareType').AsInteger = ord(ehtConqueror)) then
        serverDeviceNode.Data := TDeviceObject.Create(serverDeviceNode, doConquerorTerminal, qryServerTerminals.FieldByName('HardwareType').AsInteger, -1, qryServerTerminals.FieldByName('EPoSDeviceID').Value)
      else if (qryServerTerminals.FieldByName('HardwareType').AsInteger = ord(ehtMobileOrdering)) then
        serverDeviceNode.Data := TDeviceObject.Create(serverDeviceNode, doMOARemoteOrdering, qryServerTerminals.FieldByName('HardwareType').AsInteger, -1,
                                           qryServerTerminals.FieldByName('EPoSDeviceID').Value)
      else
        serverDeviceNode.Data := TDeviceObject.Create(serverDeviceNode, doTerminal, qryServerTerminals.FieldByName('HardwareType').AsInteger, -1, qryServerTerminals.FieldByName('EPoSDeviceID').Value);

      //add nodes for Peripheral devices to Terminal
      qryTerminalDeviceList.Close;
      qryTerminalDeviceList.Parameters.ParamByName('terminalID').Value := qryServerTerminals.FieldByName('EposDeviceID').Value;
      qryTerminalDeviceList.Parameters.ParamByName('siteCode1').Value := FSiteCode;
      qryTerminalDeviceList.Parameters.ParamByName('siteCode2').Value := FSiteCode;
      qryTerminalDeviceList.Open;
      While not qryTerminalDeviceList.Eof do
      begin
        TerminalDeviceNode := tvServerDevices.Items.AddChild(serverDeviceNode,qryTerminalDeviceList.FieldByName('Name').Value);
        TerminalDeviceNode.ImageIndex := PRINTER_IMAGE;
        TerminalDeviceNode.SelectedIndex := PRINTER_IMAGE;
        TerminalDeviceNode.Data := TDeviceObject.Create(TerminalDeviceNode, doPrinter, -1, qryTerminalDeviceList.FieldByName('PrinterType').AsInteger, qryTerminalDeviceList.FieldByName('DeviceID').Value);
        qryTerminalDeviceList.Next;
      end;
      //end add nodes for peripheral devices
      qryServerTerminals.Next;
    end;

    // add nodes for printers directly linked to Servers
    qryServerPrinters.Close;
    qryServerPrinters.Parameters.ParamByName('serverID').Value := qryServers.FieldByName('EPoSDeviceID').Value;
    qryServerPrinters.Parameters.ParamByName('siteCode').Value := FSiteCode;
    qryServerPrinters.Open;

    // add nodes for terminals attached to the server
    while not qryServerPrinters.Eof do
    begin
      serverDeviceNode := tvServerDevices.Items.AddChild(serverNode, qryServerPrinters.FieldByName('Name').Value);
      serverDeviceNode.ImageIndex := PRINTER_IMAGE;
      serverDeviceNode.SelectedIndex := PRINTER_IMAGE;
      serverDeviceNode.Data := TDeviceObject.Create(serverDeviceNode, doPrinter, -1, qryServerPrinters.FieldByName('PrinterType').AsInteger, qryServerPrinters.FieldByName('PrinterID').Value);
      qryServerPrinters.Next;
    end;

    qryServers.Next;
  end;
  rootNode.Expand(TRUE);
end;


procedure TEngDeviceList.FormShow(Sender: TObject);
begin
  BuildServerDevicesTree;
  with dmADO do
  begin
    qrySiteServers.Parameters.ParamByName('SiteCode').Value := FSiteCode;
    qGetTerminals.Parameters.ParamValues['SiteCode'] := FSiteCode;
    qGetTerminals.active := true;
    qTerminalPrinters.active := true;
    qPrintStreams.Active := true;
    qPrinterTypes.active := true;
    qryServers.Active := True;
  end;
end;

procedure TEngDeviceList.tvServerDevicesChange(Sender: TObject;
  Node: TTreeNode);
begin
  SelectedNode := Node;
  case TDeviceObject(Node.Data).deviceObjectType of
    doPrinter :
    begin
      dmADO.qGetTerminals.Locate('SiteCode;EPOSDeviceID',VarArrayOf([FSiteCode,TDeviceObject(SelectedNode.Parent.Data).deviceID]),[]);
      dmADO.qTerminalPrinters.Locate('PrinterID;SiteCode',VarArrayOf([TDeviceObject(SelectedNode.Data).deviceID,FSiteCode]),[]);
      RefreshSelectedDetailPanel;
    end;
    else
    begin
      dmADO.qGetTerminals.Locate('SiteCode;EPOSDeviceID',VarArrayOf([FSiteCode,TDeviceObject(SelectedNode.Data).deviceID]),[]);
      RefreshSelectedDetailPanel;
    end;
  end;
end;

procedure TEngDeviceList.RefreshSelectedDetailPanel;
var
  SelectedObject: TDeviceObject;

  procedure AdjustPrinterTypeNameHeight(heightMode: THeightMode);
  var
    moveValue: smallint;
  begin
    if heightMode = currentPrinterNameHeightMode then
      exit;

    moveValue := 13;

    case heightMode of
      hmDoubleLine:
        pnlSelectedDetail.Height := pnlSelectedDetail.Height + moveValue;
      hmSingleLine, hmNone:
        begin
          if currentPrinterNameHeightMode = hmDoubleLine then
            pnlSelectedDetail.Height := pnlSelectedDetail.Height - moveValue;
        end;
    end;

    lblIPAddress.Refresh;
    currentPrinterNameHeightMode := heightMode;
  end;

begin
  SelectedObject := TDeviceObject(SelectedNode.Data);

  case SelectedObject.deviceObjectType of
    doRoot :
      begin
        qrySelectRoot.Close;
        qrySelectRoot.Parameters.ParamByName('SiteCode').Value := FSiteCode;
        qrySelectRoot.Open;
        if qrySelectRoot.RecordCount > 0 then
        begin
          pnlSelectedDetail.Show;
          lblNameLabel.Caption := 'Company Name:';
          lblName.Caption := qrySelectRoot.fieldByName('Company Name').AsString;

          lblIPAddressLabel.Caption := 'Site Name:';
          lblIPAddress.Caption := qrySelectRoot.fieldByName('Site Name').AsString;

          lblHardWareTypeLabel.Caption := 'Site Manager:';
          lblHardwaretype.Caption := qrySelectRoot.fieldByName('Site Manager').AsString;

          lblDeviceIdLabel.Caption := 'Telephone:';
          lblDeviceID.Caption := qrySelectRoot.fieldByName('Phone').AsString;
        end;
        AdjustPrinterTypeNameHeight(hmNone);
      end;
    doServer:
      begin
        qrySelectedServerDetails.Close;
        qrySelectedServerDetails.Parameters.ParamByName('SiteCode').Value := FSiteCode;
        qrySelectedServerDetails.Parameters.ParamByName('TerminalID').Value := SelectedObject.deviceID;
        qrySelectedServerDetails.Open;
        pnlSelectedDetail.Show;
        if qrySelectedServerDetails.RecordCount > 0 then
        begin
          lblHardWareTypeLabel.Caption := 'Hardware Type:';
          lblNameLabel.Caption := 'Name:';
          lblDeviceIdLabel.Caption := 'Device ID:';
          lblIPAddressLabel.Caption := 'IP Address:';

          lblName.Caption := qrySelectedServerDetails.fieldByName('Name').AsString;
          lblIPAddress.Caption := qrySelectedServerDetails.fieldByName('IPAddress').AsString;
          lblHardwaretype.Caption := qrySelectedServerDetails.fieldByName('HardwareName').AsString;
          lblDeviceID.Caption := qrySelectedServerDetails.fieldByName('DeviceID').AsString;
        end;
        AdjustPrinterTypeNameHeight(hmNone);
      end;
    doConquerorServer, doHotelSystemServer, doQueueBuster:
      begin
        qrySelectedServerDetails.Close;
        qrySelectedServerDetails.Parameters.ParamByName('SiteCode').Value := FSiteCode;
        qrySelectedServerDetails.Parameters.ParamByName('TerminalID').Value := SelectedObject.deviceID;
        qrySelectedServerDetails.Open;
        pnlSelectedDetail.Show;
        if qrySelectedServerDetails.RecordCount > 0 then
        begin
          lblHardWareTypeLabel.Caption := 'Hardware Type:';
          lblNameLabel.Caption := 'Name:';
          lblDeviceIdLabel.Caption := 'Device ID:';
          lblIPAddressLabel.Caption := 'IP Address:';

          lblName.Caption := qrySelectedServerDetails.fieldByName('Name').AsString;
          lblIPAddress.Caption := 'N/A';
          lblHardwaretype.Caption := qrySelectedServerDetails.fieldByName('HardwareName').AsString;
          lblDeviceID.Caption := qrySelectedServerDetails.fieldByName('DeviceID').AsString;
        end;
        AdjustPrinterTypeNameHeight(hmNone);
      end;
    doTerminal:
      begin
        qrySelectTerminal.Close;
        qrySelectTerminal.Parameters.ParamByName('DeviceID').Value := SelectedObject.deviceID;
        qrySelectTerminal.Parameters.ParamByName('SiteCode').Value := FSiteCode;
        qrySelectTerminal.Open;

        if qrySelectTerminal.RecordCount > 0 then
        begin
          pnlSelectedDetail.Show;

          lblIPAddressLabel.Caption := 'IP Address:';
          lblDeviceIdLabel.Caption := 'Device ID:';
          lblHardWareTypeLabel.Caption := 'Hardware Type:';
          lblNameLabel.Caption := 'Name:';

          lblName.Caption := qrySelectTerminal.fieldByName('Name').AsString;
          lblIPAddress.Caption := qrySelectTerminal.fieldByName('IPAddress').AsString;
          lblHardwaretype.Caption := qrySelectTerminal.fieldByName('HardwareName').AsString;
          lblDeviceID.Caption := qrySelectTerminal.fieldByName('EposDeviceID').AsString;

          if qrySelectTerminal.fieldByName('MultiDrawerMode').AsBoolean then
            lblHardwaretype.Caption := lblHardwaretype.Caption + ' (Two drawer mode)';
        end;
        AdjustPrinterTypeNameHeight(hmNone);
      end;
    doConquerorTerminal:
      begin
        qrySelectTerminal.Close;
        qrySelectTerminal.Parameters.ParamByName('DeviceID').Value := SelectedObject.deviceID;
        qrySelectTerminal.Parameters.ParamByName('SiteCode').Value := FSiteCode;
        qrySelectTerminal.Open;

        if qrySelectTerminal.RecordCount > 0 then
        begin
          pnlSelectedDetail.Show;

          lblIPAddressLabel.Caption := 'Conqueror Device ID:';
          lblDeviceIdLabel.Caption := 'Device ID:';
          lblHardWareTypeLabel.Caption := 'Hardware Type:';
          lblNameLabel.Caption := 'Name:';

          lblName.Caption := qrySelectTerminal.fieldByName('Name').AsString;
          with dmADO.qRun do
          begin
            Close;
            Sql.Clear;
            Sql.Add('Select ConquerorDeviceID from ConquerorEposDeviceDetails where EposDeviceID = ' + qrySelectTerminal.fieldByName('EposDeviceID').AsString);
            open;
          end;
          lblIPAddress.Caption := dmADO.qRun.fieldByName('ConquerorDeviceID').AsString;
          lblHardwaretype.Caption := qrySelectTerminal.fieldByName('HardwareName').AsString;
          lblDeviceID.Caption := qrySelectTerminal.fieldByName('EposDeviceID').AsString;
        end;
        AdjustPrinterTypeNameHeight(hmNone);
      end;
    doMOARemoteOrdering:
      begin
        dmADO.qGetMoaDetails.Close;
        dmADO.qGetMoaDetails.Parameters[0].Value := FSiteCode;
        dmADO.qGetMoaDetails.Parameters[1].Value := SelectedObject.deviceID;
        try
          dmADO.qGetMoaDetails.Open;
          if dmADO.qGetMoaDetails.RecordCount > 0 then
          begin
            pnlSelectedDetail.Show;
            lblNameLabel.Caption :=  'Sales Area:';
            lblIPAddressLabel.Caption := 'No. of Terminals:';
            lblDeviceIdLabel.Caption := 'MOA Employee:';
            lblHardWareTypeLabel.Caption := 'Hardware Type:';

            lblName.Caption := dmADO.qGetMoaDetailsSalesArea.AsString;
            lblIPAddress.Caption := IntToStr(dmADO.qGetMoaDetailsMOACount.AsInteger);
            lblHardwaretype.Caption := 'Mobile Ordering Terminal';
            lblDeviceID.Caption := dmADO.qGetMoaDetailsMOAUser.AsString;
          end;
        finally
          dmADO.qGetMoaDetails.Close;
        end;
      end;
    doPrinter:
      begin
        qrySelectPeripheralDevice.Close;
        qrySelectPeripheralDevice.Parameters.ParamByName('SiteCode').Value := FSiteCode;
        qrySelectPeripheralDevice.Parameters.ParamByName('DeviceID').Value := SelectedObject.deviceID;
        qrySelectPeripheralDevice.Open;
        if qrySelectPeripheralDevice.RecordCount > 0 then
        begin
          pnlSelectedDetail.Show;

          lblHardWareTypeLabel.Caption := 'Hardware Type:';
          lblNameLabel.Caption := 'Name:';
          lblIPAddressLabel.Caption := 'Device:';
          lblDeviceIdLabel.Caption := 'Port Number:';

          lblName.Caption := qrySelectPeripheralDevice.fieldByName('Name').AsString;
          lblHardwaretype.Caption := qrySelectPeripheralDevice.fieldByName('PeripheralDevice').AsString;
          lblIPAddress.Caption := qrySelectPeripheralDevice.fieldByName('PrintertypeName').AsString;
          lblDeviceID.Caption := qrySelectPeripheralDevice.fieldByName('PortNumber').AsString;

          if qrySelectPeripheralDevice.FieldByName('IPAddress').AsString <> '' then
          begin
            lblDeviceIdLabel.Caption := 'IP Address/Port Number:';
            lblDeviceID.Caption := qrySelectPeripheralDevice.fieldByName('IPAddress').AsString +' / '+
                                   qrySelectPeripheralDevice.fieldByName('IPPort').AsString;
          end;

          if lblIPAddress.Canvas.TextWidth(lblIPAddress.Caption) >= lblIPAddress.ClientWidth then
          begin
            AdjustPrinterTypeNameHeight(hmDoubleLine);
          end
          else
          begin
            AdjustPrinterTypeNameHeight(hmSingleLine);
          end;
        end;
      end;
  end; // end of case statement
end;


procedure TEngDeviceList.tvServerDevicesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  theNode: TTreeNode;
  thePoint: TPoint;
begin
  theNode := tvServerDevices.GetNodeAt(X,Y);
  if Assigned(theNode) then
  begin
    if Button = mbRight then
    begin
      // Right click - move selection to clicked item, then popup context menu
      tvServerDevices.Select(theNode);
      SelectedNode := theNode;
      thePoint.X := X;
      thePoint.Y := Y;
      thePoint := tvServerDevices.ClientToScreen( thePoint );
      case TDeviceObject(theNode.Data).deviceObjectType of
             doPrinter :
               begin
                 EditServerPrinter.Caption := 'Edit ' + theNode.Text;
                 pmNodeServerPrinter.Popup(thePoint.X, thePoint.Y);
               end;
        end;
      end;
  end;
end;

procedure TEngDeviceList.EditServerPrinterClick(Sender: TObject);
begin
  ShowTerminalPrinterDialog(TRUE,0);
end;

procedure TEngDeviceList.ShowTerminalPrinterDialog(fromNodeMenu: Boolean; mode : Integer);
var
  dlg : TfrmAddEditPrinter;
begin
  dlg := nil;
  try
    dlg := TfrmAddEditPrinter.Create(self);
    dlg.FMode := Mode;
    dlg.FSiteCode := FSiteCode;
    dlg.dsEditRec.DataSet := dmado.qTerminalPrinters;    // doesnt matter if its a server printer or terminal printer

    dlg.dbLkCbxPrinterType.Enabled := false;
    dlg.edTimeout.Enabled := false;
    dlg.DBCbxCompactOrderLines.Enabled := false;
    dlg.DBCbxShowSeatHeaders.Enabled := false;

    if fromNodeMenu then
        dlg.FParentDeviceID := TDeviceObject(SelectedNode.Parent.Data).deviceID
      else
        dlg.FParentDeviceID := TDeviceObject(RecordNode.Parent.Data).deviceID;

    if dlg.ShowModal = mrOK then
    begin
      TDeviceObject(SelectedNode.Data).PeripheralType := dlg.dsEditRec.DataSet.fieldbyname('PrinterType').AsInteger;

      if fromNodeMenu then
         begin
           SelectedNode.Text := dlg.dsEditRec.DataSet.FieldByName('Name').Value;
           RefreshSelectedDetailPanel;
         end
            else
              RecordNode.Text := dlg.dsEditRec.DataSet.FieldByName('Name').Value;

    end;
  finally
    dlg.Free;
  end;
end;

end.
