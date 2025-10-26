unit uHardwareIcons;

// Interface unit for hardware icon resources

{$R '..\..\Common Files\Hardware Icons\AztecHardwareIcons16x16.res' '..\..\Common Files\Hardware Icons\AztecHardwareIcons16x16.rc'}
{$R '..\..\Common Files\Hardware Icons\AztecHardwareIcons32x32.res' '..\..\Common Files\Hardware Icons\AztecHardwareIcons32x32.rc'}

interface

uses adodb, controls, graphics;

type
  TIconKind = (ikServerGroup, ikPeripheral, ikDevice);

var
  ServerGroupIcon: string = 'ServerGroup';

  PeripheralTypeIconList: array[0..8] of string = (
    'Printer',
    'IPPrinter',
    'PinPad',
    'PinPadWithPrinter',
    'TextInserter',
    'BarcodeReader',
    'CoinDispenser',
    'Scales',
    'ePurse'
  );

  DeviceTypeIconList: array[0..32] of string = (
    'Z500',
    'Z400',
    'Z300',
    'HandHeld',
    'IBM551',
    'Conqueror',
    'HotelSystem',
    'i700',
    'Kiosk',
    'XPPOS',

    'MOA',
    'MOA', // dummy for external API access
    'MOAOrderPad',
    'MOAPayAtTable',
    'iZoneTables',
    'IBMSurePOS500',
    'IBMSurePOS514P126',
    'IBMSurePOS532P126',
    'SharpUPV5500',
    'SharpRZX750',

    'ToshibaTECSTA10',
    'ToshibaTECSTA12',
    'IBMSurePOS532P1238',
    'IBMSurePOS514P1238',
    'ToshibaTECSTA20',
    'AzOne',
    'AzTab',
    'ZonalToshibaA12',
    'ZonalToshibaA20',
    'ZonalToshibaA30',
    'ZonalToshibaA10',
    'ThirdParty',
    'Z9'
  );

  // Master list of icon resource IDs e.g. for loading to an image list
  HardwareIconsList: array of string;

procedure SetupIconList(AConnection: TADOConnection);
procedure LoadIconImageList(Imagelist: TImageList; IconSize: integer);
function GetIcon(IconKind: TIconKind; Identifier: integer = -1): integer;

implementation

uses math, sysutils;

type
  TPeripheralIconMap = packed record
    PeripheralID, IconID: integer
  end;
var
  PeripheralIconMap: array of TPeripheralIconMap;

procedure SetupIconList(AConnection: TADOConnection);
var
  i: integer;
  HardwareIconCount: integer;
  TempQuery: TADOQuery;
  procedure AddToPeripheralMap(PrinterTypeClause, ResourceName: string);
  var
    IconID: integer;
  begin
    TempQuery.SQL.Text := 'SELECT PrinterTypeID from ThemePrinterType WHERE '+PrinterTypeClause;
    for IconID := Low(HardwareIconsList) to High(HardwareIconsList) do
      if HardwareIconsList[IconID] = ResourceName then
        break;
    TempQuery.Open;
    while not TempQuery.Eof do
    begin
      SetLength(PeripheralIconMap, Length(PeripheralIconMap)+1);
      PeripheralIconMap[Length(PeripheralIconMap)-1].PeripheralID := TempQuery.FieldByName('PrinterTypeID').AsInteger;
      PeripheralIconMap[Length(PeripheralIconMap)-1].IconID := IconID;
      TempQuery.Next;
    end;
    TempQuery.Close;
  end;
begin
  SetLength(HardwareIconsList, 1 + Length(PeripheralTypeIconList) + Length(DeviceTypeIconList));
  HardwareIconCount := 0;
  HardwareIconsList[HardwareIconCount] := ServerGroupIcon;
  Inc(HardwareIconCount);
  for i := Low(PeripheralTypeIconList) to High(PeripheralTypeIconList) do
  begin
    HardwareIconsList[HardwareIconCount] := PeripheralTypeIconList[i];
    Inc(HardwareIconCount);
  end;
  for i := Low(DeviceTypeIconList) to High(DeviceTypeIconList) do
  begin
    HardwareIconsList[HardwareIconCount] := DeviceTypeIconList[i];
    Inc(HardwareIconCount);
  end;
  // build peripheral map
  TempQuery := TADOQuery.Create(nil);
  TempQuery.Connection := AConnection;
  try
    AddToPeripheralMap('IsTextInserter = 1', 'TextInserter');
    AddToPeripheralMap('IsBarcodeReader = 1', 'BarcodeReader');
    AddToPeripheralMap('PinPadType is not null AND IsPrinter = 1' , 'PinPadWithPrinter');
    AddToPeripheralMap('PinPadType is not null AND IsPrinter = 0' , 'PinPad');
    AddToPeripheralMap('IPComms = 0 AND (PinPadType is null) AND IsPrinter = 1' , 'Printer');
    AddToPeripheralMap('IPComms = 1 AND (PinPadType is null) AND IsPrinter = 1' , 'IPPrinter');
    AddToPeripheralMap('IsCoinDispenser = 1', 'CoinDispenser');
    AddToPeripheralMap('IsScale = 1','Scales');
    AddToPeripheralMap('IsePurse = 1', 'ePurse');
  finally
    TempQuery.Free;
  end;
end;

procedure LoadIconImageList(Imagelist: TImageList; IconSize: integer);
var
  i: integer;
  TempBitmap: TBitmap;
begin
  if (IconSize <> 16) and (IconSize <> 32) then
    raise Exception.Create('Invalid icon size in LoadIconImageList');
  TempBitmap := TBitmap.Create;
  try
    Imagelist.Clear;
    Imagelist.Width := IconSize;
    Imagelist.Height := IconSize;
    for i := Low(HardwareIconsList) to High(HardwareIconsList) do
    begin
      TempBitmap.LoadFromResourceName(HInstance, Format('%dx%d_', [IconSize, IconSize])+HardwareIconsList[i]);
      Imagelist.Add(TempBitmap, TempBitmap);
    end;
  finally
    TempBitmap.Free;
  end;
end;

function GetIcon(IconKind: TIconKind; Identifier: integer = -1): integer;
var
  i: integer;
begin
  Result := -1;
  case IconKind of
  ikServerGroup:
    Result := 0;
  ikPeripheral:
    begin
      for i := Low(PeripheralIconMap) to High(PeripheralIconMap) do
      begin
        if PeripheralIconMap[i].PeripheralID = Identifier then
        begin
          Result := PeripheralIconMap[i].IconID;
          break;
        end;
      end;
    end;
  ikDevice:
    begin
      if Identifier >= 1000 then
        for i := Low(DeviceTypeIconList) to High(DeviceTypeIconList) do
        begin
          if DeviceTypeIconList[i] = 'ThirdParty' then
          begin
            Result := i + Length(PeripheralTypeIconList) + 1;
            Break;
          end;
        end
      else
        Result := Min(Identifier, High(DeviceTypeIconList)) + Length(PeripheralTypeIconList)+1;
    end;
  end;
end;

end.
