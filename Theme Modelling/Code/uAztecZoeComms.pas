unit uAztecZoeComms;

interface

//This enumeration corresponds to the return code enumeration
//in ZoeReturnCode.h
//Return codes are decoded in TranslateZoeReturnCode
type

TZoeReturnCode = (
  zrcSuccess = 0,
  zrcConnection_Error = 1,
  zrcTreansaction_Not_Found_Error = 2,
  zrcBuffer_Too_Small_Error = 3,
  zrcUnhandled_Error = 4,
  zrcXML_Parse_Error = 5,
  zrcVersion_Error = 6,
  zrcPrinter_Error = 7,
  zrcText_Not_Specified_Error = 8,
  zrcText_Too_Long_Error = 9,
  zrcInvalid_Date_Error = 10,
  zrcMutex_Timeout_Error = 11,
  zrcZeal_Error = 12,
  zrcUnableToExecute_Error = 13,
  zrcEPOS_Data_Version_Error = 14,
  zrcEPOS_Data_Invalid_Error = 15,
  zrcDevice_Type_Error = 16,
  zrcIncompatible_Hardware_Error = 17,
  zrcNothing_To_Do = 18,
  zrcPrint_Not_Finished = 19,
  zrcSwitch_Comms_Mode_Failure = 20,
  zrcUNKNOWN = -1
);

TZoeCommsMode = (
  zcmFullComms = 0,
  zcmCommsFailedStandalone = 1,
  zcmSoloMode = 2,
  zcmUNKNOWN = -1
);

TCallback = procedure(msg: String) of Object;

function TranslateZoeReturnCode(ReturnCode: Integer): TZoeReturnCode;
function TranslateZoeCommsMode(CommsMode: String): TZoeCommsMode;
procedure ParseModel(ipaddress: widestring; eposdeviceid: integer; const model: widestring);
procedure SendModel(ipaddress: widestring; eposdeviceid: integer; const model: widestring);
function SendPartialModel(ipAddress : wideString;
                          id : integer;
                          neweposmodel : WideString;
                          addendummodel : WideString;
                          CallbackFunc : TCallback = nil) : boolean;
function GetServerIPAddress(ipaddress: widestring; eposdeviceid: integer): String;
function CheckServer(ipaddress: widestring; eposdeviceid: integer):boolean;
function CheckTerminal(ipaddress: widestring; eposdeviceid: integer):boolean;
function ModelRequiresTerminalReset(ipaddress: widestring; eposdeviceid: integer; model: widestring; AddendumBufferSize : Integer; addendumbuffer : pwidechar): boolean;
function CheckEPoSStatus(IPAddress: widestring; EPOSDeviceID: integer;
                         var EPOSStatus: Integer; var Revision: WideString;
                         var ZoeReturnCode: TZoeReturnCode): Boolean;
function GetDataVersion(var DataVersion: WideString): Boolean;
function GetSoloModeUpgradePreventionReason(ipAddress: widestring;
                                            EPoSDeviceID: integer): String;
function GetTerminalCommsMode(ipAddress: widestring;
                              EPoSDeviceID: integer): TZoeCommsMode;

implementation

uses windows, useful, sysutils, classes, ZOEDLL, shellapi, registry, uWideStringUtils, strUtils;

function TranslateZoeReturnCode(ReturnCode: Integer): TZoeReturnCode;
begin
  case ReturnCode of
    0..18: Result := TZoeReturnCode(ReturnCode);
    else
      Result := zrcUNKNOWN;
  end;
end;

function TranslateZoeCommsMode(CommsMode: String): TZoeCommsMode;
var
  AnsiIndex: Integer;
begin
  AnsiIndex := AnsiIndexText(CommsMode, ['FULLCOMMS', 'COMMSFAILEDSTANDALONE', 'SOLOMODE']);
  case AnsiIndex of
    0..2: Result := TZoeCommsMode(AnsiIndex);
    else
      Result := zcmUNKNOWN;
  end;
end;

function SendPartialModel(ipAddress : WideString;
                          id : integer;
                          neweposmodel : WideString;
                          addendummodel : WideString;
                          CallbackFunc : TCallback = nil) : boolean;
var
   returnmessage : array[0..511] of widechar;
   returncode : integer;
begin

  if not(zoedll.dllloaded) then
     zoedll.LoadDLL;

  Fillchar(returnmessage,512,#0);

  result := Zoe_EPoSTerminalProxy_partialrefresh(pWideChar(ipAddress),
                                               id,
                                               pWideChar(neweposmodel),
                                               pWideChar(addendummodel),
                                               @returnmessage,
                                               returncode);


  if (not result) and (Assigned(CallbackFunc)) then
    CallbackFunc('Partial Model Send failed: '+#10#13+widechartostring(returnmessage));
end;

function ModelRequiresTerminalReset(ipaddress: widestring; eposdeviceid: integer; model: widestring; AddendumBufferSize : Integer; addendumbuffer : pwidechar): boolean;
var
   returnmessage : array[0..511] of widechar;
   returncode : integer;
begin
  if not(zoedll.dllloaded) then
     zoedll.LoadDLL;


  Fillchar(returnmessage,512,#0);

  result :=  (not zoedll.Zoe_EPoSTerminalProxy_createaddendummodelifable( pwidechar(ipaddress),
                                                                     eposdeviceid,
                                                                     pwidechar(model),
                                                                     addendumbuffer,
                                                                     ADDENDUMBUFFERSIZE,
                                                                     @returnmessage,
                                                                     returncode))and (returncode <> 18);
  if returncode = 1 then raise Exception.Create('Could not contact terminal');
end;

procedure ParseModel(ipaddress: widestring; eposdeviceid: integer; const model: widestring);
var
  returnmessage: array[0..511] of widechar;
  returncode: integer;
begin
  if not(zoedll.dllloaded) then zoedll.LoadDLL;
  if not zoedll.Zoe_parse(
    EposDeviceId,
    pwidechar(Model),
    ReturnMessage,
    ReturnCode
  ) then
    raise Exception.create('Parse Failed: '+widechartostring(returnmessage));
end;

procedure SendModel(ipaddress: widestring; eposdeviceid: integer; const model: widestring);
var
  returnmessage: array[0..511] of widechar;
  returncode: integer;
begin
  if not(zoedll.dllloaded) then zoedll.LoadDLL;
  if not zoedll.Zoe_EPoSTerminalProxy_refresh(
    pwidechar(ipaddress),
    eposdeviceid,
    pwidechar(model),
    returnmessage,
    returncode
  ) then
  begin
    if returncode = 1 then
      raise Exception.create('Send failed - Could not contact terminal')
    else
      raise Exception.create('Send failed: '+#13+widechartostring(returnmessage));
  end;
  // PW disk diagnostic of XML that was sent to each till
  with TFileStream.create(ensuretrailingslash(useful.gettempdir)+'aztec_theme_xml_'+inttostr(eposdeviceid)+'.xml', fmCreate) do try
    size := length(model) * 2;
    seek(0, soFromBeginning);
    write(pointer(model)^, length(model) * 2);
  finally
    free;
  end;
end;

function GetServerIPAddress(ipaddress: widestring; eposdeviceid: integer): String;
var
  ipAddr : array [0..255] of WideChar;
  serverIPAddress : array [0..1024] of WideChar;
  returnMessage: array[0..1024] of widechar;
  returnCode: integer;
  success : WORDBOOL;
begin
  Result := '';
  FillChar(returnMessage,SizeOf(returnMessage),#0);
  FillChar(serverIPAddress, SizeOf(serverIPAddress),#0);
  StringToWideChar(ipaddress,@ipAddr,255);
  if not (zoedll.DLLLoaded) then zoedll.LoadDLL;
  success := zoedll.Zoe_EPoSTerminalProxy_getServerIPAddress(
                @ipAddr,
                eposdeviceid,
                @serverIPAddress,
                SizeOf(serverIPAddress),
                @returnMessage,
                returnCode);

  if not success then
    raise Exception.Create('CheckServerIPAddress failed - could not contact terminal')
  else
    Result := WideCharToString(@serverIPAddress);
end;

function CheckServer(ipaddress: widestring; eposdeviceid: integer):boolean;
var
  returnmessage: array[0..511] of widechar;
  devicetype: integer;
  returncode: integer;
begin
  if not(zoedll.dllloaded) then zoedll.LoadDLL;
  result := zoedll.Zoe_EPoSDeviceProxy_getType(pwidechar(ipaddress), eposdeviceid,  devicetype, returnmessage, returncode);
  if devicetype <> 0 then
    result := false;
end;

function CheckTerminal(ipaddress: widestring; eposdeviceid: integer):boolean;
var
  returnmessage: array[0..511] of widechar;
  devicetype: integer;
  returncode: integer;
begin
  if not(zoedll.dllloaded) then zoedll.LoadDLL;
  result := zoedll.Zoe_EPoSDeviceProxy_getType(pwidechar(ipaddress), eposdeviceid,  devicetype, returnmessage, returncode);
  if devicetype <> 1 then
    result := false;
end;

function CheckEPoSStatus(IPAddress: WideString; EPOSDeviceID: Integer;
                         var EPOSStatus: Integer; var Revision: WideString;
                         var ZoeReturnCode: TZoeReturnCode): Boolean;
var
  ReturnMessage: array[0..511] of widechar;
  ReturnCode: integer;
  RevisionBuffer: array[0..1023] of widechar;
begin
  if not(zoedll.dllloaded) then zoedll.LoadDLL;
  Result := zoedll.Zoe_EPoSTerminalProxy_getEPoSModelStatus(
    pWideChar(IPAddress),
    EPOSDeviceID,
    EPOSStatus,
    RevisionBuffer,
    1024, //RevisionBufferSize of 1024 as per the spec?
    ReturnMessage,
    ReturnCode);

  ZoeReturnCode := TranslateZoeReturnCode(ReturnCode);

  Revision := RevisionBuffer;
end;

function GetDataVersion(var DataVersion: WideString): Boolean;
var
  ReturnMessageBuffer: array[0..511] of widechar;
  ReturnCode: integer;
  DataVersionBuffer: array[0..1023] of widechar;
begin
  if not(zoedll.dllloaded) then zoedll.LoadDLL;
  Result := zoedll.Zoe_getDataVersion(DataVersionBuffer, 1024, ReturnMessageBuffer, ReturnCode);
  DataVersion := Trim(StringReplace(DataVersionBuffer, 'Program Version: ', '', []));
end;

function GetSoloModeUpgradePreventionReason(ipAddress: widestring;
                                            EPoSDEviceID: integer): String;
var
  _PreventionReason: array[0..1023] of widechar;
  _ReturnMessage: array[0..1023] of widechar;
  _ReturnMessageW: widestring;
  ReturnCode: integer;
begin
  if not(zoedll.dllloaded) then zoedll.LoadDLL;

  if not zoedll.Zoe_EPoSTerminalProxy_getSoloModeUpgradePreventionReason(pwidechar(ipaddress),
                                                                         eposdeviceid,
                                                                         _PreventionReason,
                                                                         Length(_PreventionReason),
                                                                         _ReturnMessage,
                                                                         ReturnCode) then
  begin
    Result := '';
    _ReturnMessageW := _ReturnMessage;
    raise Exception.Create(Format('GetTerminalCommsMode failed: ReturnCode: %d, ReturnMessage: %s',[ReturnCode, _ReturnMessageW]))
  end
  else begin
    Result := _PreventionReason;
  end;
end;

function GetTerminalCommsMode(ipAddress: widestring;
                              EPoSDeviceID: integer): TZoeCommsMode;
var
  _CommsMode: array[0..1023] of widechar;
  _CommsModeW: widestring;
  _ReturnMessage: array[0..1023] of widechar;
  _ReturnMessageW: widestring;
  ReturnCode: integer;
begin
  if not(zoedll.dllloaded) then zoedll.LoadDLL;

  if not zoedll.Zoe_EPoSTerminalProxy_getTerminalCommsMode(pwidechar(ipAddress),
                                                           EPoSDeviceID,
                                                           _CommsMode,
                                                           Length(_CommsMode),
                                                           _ReturnMessage,
                                                           ReturnCode) then
  begin
    _ReturnMessageW := _ReturnMessage;
    raise Exception.Create(Format('GetTerminalCommsMode failed: ReturnCode: %d, ReturnMessage: %s',[ReturnCode, _ReturnMessageW]))
  end
  else begin
    _CommsModeW := _CommsMode;
    Result := TranslateZoeCommsMode(_CommsModeW);
  end;
end;

end.
