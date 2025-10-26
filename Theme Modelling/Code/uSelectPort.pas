unit uSelectPort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TSelectPortForm = class(TForm)
    btnOK: TButton;
    theLabel: TLabel;
    btnCancel: TButton;
    rgpPorts: TRadioGroup;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    
  private
    { Private declarations }
  public
      { Public declarations }
  end;

function CheckThePort(var aPortNumber: Integer; siteCode, printerID, newDeviceId: integer;
                      deviceName, newDeviceName: string; IsKitchenScreen: Boolean): Word;

function ValidatePeripheralPorts(ASiteCode, ATerminalID,   ADeviceID, APortNumber: integer): Boolean;
function CommideaDeviceExistsForTerminal(ASiteCode, ATerminalID, APrinterID : integer) : boolean;
function TerminalHasTextInserter(ASiteCode, ATerminalID: integer; DisplayTheMessage: Boolean; ExistingPeripheralId: integer = -1): Boolean;
function TerminalHasPeripheralType(ASiteCode, ATerminalID, PrinterTypeID: integer; DisplayTheMessage: Boolean; PrinterID: integer = -1): Boolean;


implementation

uses uADO, ADODB, uAztecLog, uAztecdatabaseUtils;


{$R *.dfm}

function CheckThePort(var aPortNumber: Integer; siteCode, printerID, newDeviceId: integer;
                      deviceName, newDeviceName: string; IsKitchenScreen: Boolean): Word;
var
  SelectPortForm: TSelectPortForm;
  i: integer;
  freePorts: TStringList;
  originalPortNumber: Integer;
begin
  freePorts := TStringList.Create;
  with TADOQuery.Create(nil) do
  try
    Connection := dmADO.AztecConn;

    // check that port numbers are not all used in the terminal/server the
    // device is being moved to and if so then cancel the move
    if IsKitchenScreen then
    begin
      SQL.Add('SELECT a.PortNumber FROM ');
      SQL.Add('  (SELECT 1 AS PortNumber ');
      SQL.Add('   UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6) a ');
      SQL.Add('WHERE a.PortNumber NOT IN ');
      SQL.Add('  (SELECT ISNULL(PortNumber, 255) ');
      SQL.Add('   FROM ThemeEposPrinter ep JOIN ThemePrinterType tp ');
      SQL.Add('     ON ep.PrinterType = tp.PrinterTypeID ');
      SQL.Add('   WHERE ep.SiteCode = ' + IntToStr(SiteCode));
      SQL.Add('   AND ep.EposDeviceID = ' + IntToStr(newDeviceID));
      SQL.Add('   AND tp.IsKitchenScreen = 0) ');
    end
    else
    begin
      SQL.Add('select a.PortNumber from');
      SQL.Add('  (select 1 as PortNumber');
      SQL.Add('   union select 2 union select 3 union select 4 union select 5 union select 6) a');
      SQL.Add('where a.PortNumber not in ');
      SQL.Add('(SELECT ISNULL(PortNumber, 255) FROM ThemeEposPrinter');
      SQL.Add(' WHERE SiteCode = ' + IntToStr(SiteCode));
      SQL.Add(' AND EposDeviceID = ' + IntToStr(newDeviceID) + ')');
    end;
    Open;
    if RecordCount = 0 then
    begin
      Log('Pop Up Menu, move disallowed because no ports are available on ' + newDeviceName);
      MessageDlg('There are no available ports on ' + newDeviceName + '.' + #13#10 +
                 'The move action is not allowed.',mtWarning,[mbOK],0);
      Result := mrCancel;
    end
    else
    begin
      while not Eof do
      begin
        freePorts.Add(FieldByName('PortNumber').AsString);
        Next;
      end;

      SQL.Clear;
      SQL.Add('select PortNumber from ThemeEposPrinter where PrinterID = ' + InttoStr(PrinterID));
      Open;
      originalPortNumber := FieldByName('PortNumber').AsInteger;
      Close;
      SQL.Clear;
      // check if the port no of the device being moved is already used by another
      // device attached to the terminal/server the device is being moved to and
      // if so then force the user to select an available port number
      if IsKitchenScreen then
      begin
        SQL.Add('SELECT ep.[Name], ep.PortNumber ');
        SQL.Add('FROM ThemeEposPrinter ep JOIN ThemePrinterType tp ');
        SQL.Add('  ON ep.PrinterType = tp.PrinterTypeID ');
        SQL.Add('WHERE ep.SiteCode = ' + IntToStr(SiteCode));
        SQL.Add(' AND ep.EposDeviceID =  ' + IntToStr(newDeviceID));
        SQL.Add(' AND ep.PortNumber = ' + IntToStr(originalPortNumber));
        SQL.Add(' AND tp.IsKitchenScreen = 0 ');
      end
      else
      begin
        SQL.Add('SELECT [Name], PortNumber FROM ThemeEposPrinter');
        SQL.Add('WHERE SiteCode = ' + IntToStr(SiteCode));
        SQL.Add('AND EposDeviceID = ' + IntToStr(newDeviceID));
        SQL.Add('and PortNumber = ' + IntToStr(originalPortNumber));
      end;
      Open;
      if RecordCount > 0 then
      begin
        SelectPortForm := TSelectPortForm.Create(Application);
        try
          for i := 0 to freePorts.Count-1 do
          begin
            with SelectPortForm.rgpPorts do
            begin
              Height := Height + 11;
              Items.Add(freePorts[i]);
            end;
            SelectPortForm.theLabel.Caption := 'The port number ' + IntToStr(originalPortNumber) +
                  ' set for ' + deviceName + ' is already used by ' + FieldByName('Name').AsString + ' on ' + newDeviceName +'.' + #13#10#10 +
                  'Please select one of these available ports and press OK or press Cancel to abandon the move action.';
          end;
          Result := SelectPortForm.ShowModal;
          if Result = mrOK then
          begin
             aPortNumber := StrToInt(freePorts[SelectPortForm.rgpPorts.ItemIndex]);
          end;
        finally
          SelectPortForm.Free;
        end;
      end
      else
      begin
        aPortNumber := originalPortNumber;
        Result := mrOK;
      end;
    end;
  finally
    freePorts.Free;
    Close;
    Free;
  end;
end;

function CommideaDeviceExistsForTerminal(ASiteCode, ATerminalID, APrinterID : integer) : boolean;
var
  FAztecConn : TADOConnection;
  FResultQry : TADOQuery;
begin
  FAztecConn := GetAztecADOConnection;
  FResultQry := TADOQuery.Create(nil);
  FResultQry.Connection := FAztecConn;
  FResultQry.SQL.Add('SELECT ');
  FResultQry.SQL.Add('  COUNT(*) AS DeviceExists');
  FResultQry.SQL.Add('FROM ThemeEposPrinter tep');
  FResultQry.SQL.Add('	INNER JOIN ThemePrinterType tpt ON tep.PrinterType = tpt.PrinterTypeID');
  FResultQry.SQL.Add('WHERE tpt.PinPadType = 2 AND');
  FResultQry.SQL.Add('  SiteCode = '+IntToStr(ASiteCode)+' AND');
  FResultQry.SQL.Add('  EposDeviceID = '+IntToStr(ATerminalID)+' AND');
  FResultQry.SQL.Add('  PrinterID <> '+IntToStr(APrinterID));
  FResultQry.Open;
  result := (FResultQry.FieldByName('DeviceExists').AsInteger > 0);
end;

function ValidatePeripheralPorts(ASiteCode, ATerminalID, ADeviceID,
  APortNumber: integer): Boolean;
var
  FAztecConn : TADOConnection;
  FResultQry : TADOQuery;
begin
  try
    FAztecConn := GetAztecADOConnection;
    FResultQry := TADOQuery.Create(nil);
    FResultQry.Connection := FAztecConn;
    FResultQry.SQL.Text := 'ValidatePeripheralDevices ' + IntToStr(ASiteCode) + ', ' + IntToStr(ATerminalID) +
                           ', ' + IntToStr(ADeviceID) + ', ' + IntToStr(APortNumber);
    FResultQry.open;
    result := FResultQry.fieldbyname('RetVal').AsBoolean;
  finally
    FreeAndNil(FResultQry);
  end;
end;

procedure TSelectPortForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (rgpPorts.ItemIndex = -1) and (self.ModalResult = mrOK) then
    CanClose := False;
end;

function TerminalHasTextInserter(ASiteCode, ATerminalID: integer; DisplayTheMessage: Boolean; ExistingPeripheralId: integer = -1): Boolean;
var
  FAztecConn : TADOConnection;
  FResultQry : TADOQuery;
begin
  try
    FAztecConn := GetAztecADOConnection;
    FResultQry := TADOQuery.Create(nil);
    FResultQry.Connection := FAztecConn;
    FResultQry.SQL.Add('select themeeposdevice.name as TerminalName, themeeposprinter.name as PrinterName');
    FResultQry.SQL.Add('from themeeposdevice');
    FResultQry.SQL.Add('join themeeposprinter on themeeposprinter.eposdeviceid = themeeposdevice.eposdeviceid');
    FResultQry.SQL.Add('join themeprintertype on themeeposprinter.printertype = themeprintertype.printertypeid');
    FResultQry.SQL.Add('where themeeposdevice.EposdeviceID = ' + IntToStr(ATerminalID));
    FResultQry.SQL.Add('and themeeposdevice.SiteCode = ' + IntToStr(ASiteCode));
    FResultQry.SQL.Add('and ThemePrinterType.IsTextInserter = 1');
    FResultQry.SQL.Add(Format('and printerid <> %d', [ExistingPeripheralID]));
    FResultQry.open;

    if DisplayTheMessage and (FResultQry.RecordCount > 0) then
    begin
      ShowMessage('Terminal "' + FResultQry.fieldbyname('TerminalName').AsString + '"' +
                  'already has a Text Inserter attached (named "' +
                  FResultQry.fieldbyname('PrinterName').AsString + '")!');
    end;

    result := (FResultQry.RecordCount > 0);
  finally
    FreeAndNil(FResultQry);
  end;
end;

function TerminalHasPeripheralType(ASiteCode, ATerminalID, PrinterTypeID: integer; DisplayTheMessage: Boolean; PrinterId: integer = -1): Boolean;
var
  PeripheralType, PeripheralTypeName: String;
begin
  Result := FALSE;
  with TADOQuery.Create(Nil) do
  try
    Connection := dmADO.AztecConn;
    SQL.Text :=
      'SELECT a.TypeString, a.TypeName ' +
      'FROM  ' +
      '  (SELECT PrinterTypeID, ''IsCoinDispenser'' AS TypeString, ''Coin Dispenser'' AS TypeName ' +
      '   FROM ThemePrinterType ' +
      '   WHERE IsCoinDispenser = 1 ' +
      '   UNION ' +
      '   SELECT PrinterTypeID, ''IsScale'' AS TypeString, ''Scale'' AS TypeName ' +
      '   FROM ThemePrinterType ' +
      '   WHERE IsScale = 1) a ' +
      'WHERE a.PrinterTypeID = ' + IntToStr(PrinterTypeID);
    Open;
    if (RecordCount = 0) then   // only want to check for CoinDispenser or Scale
      Exit;

    PeripheralType := FieldByName('TypeString').AsString;
    PeripheralTypeName := FieldByName('TypeName').AsString;

    SQL.Text := 'IF (SELECT [' + PeripheralType + '] FROM ThemePrinterType WHERE PrinterTypeID = ' + IntToStr(PrinterTypeID) + ') = 1 ' +
                'BEGIN ' +
                '  SELECT COUNT(*) AS [' + PeripheralTypeName + 'Count] ' +
                '  FROM ThemeEposPrinter pr INNER JOIN ' +
                '    ThemePrinterType pt ON pr.PrinterType = pt.PrinterTypeID ' +
                '  WHERE pt.[' + PeripheralType + '] = 1 AND pr.SiteCode = ' + IntToStr(ASiteCode) + ' ' +
                '  AND pr.EposDeviceID = ' + IntToStr(ATerminalID) + ' ' +
                '  AND pr.PrinterID <> ' + IntToStr(PrinterID) + ' ' +
                'END ' +
                'ELSE ' +
                '  SELECT 0 AS [' + PeripheralTypeName + 'Count] ';
    Open;
    Result := (FieldByName(PeripheralTypeName + 'Count').AsInteger > 0);
    if Result and DisplayTheMessage then
    begin
      Close;
      SQL.Text := 'SELECT [name] AS TerminalName FROM ThemeEposDevice WHERE EPoSDeviceID = ' + IntToStr(ATerminalID);
      Open;
      ShowMessage('Terminal "' + FieldByName('TerminalName').AsString + '" ' +
                  'already has a ' + PeripheralTypeName + ' attached');
    end;
  finally
    Close;
    Free;
  end;
end;


end.
