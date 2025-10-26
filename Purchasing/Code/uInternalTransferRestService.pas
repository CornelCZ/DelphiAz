unit uInternalTransferRestService;

interface

uses Windows, IdHTTP, DCPbase64, SysUtils, Classes, IdSSLIntercept, IdSSLOpenSSL, IdURI, ShellApi;

type TInternalTransferRestService = class(TObject)
	public
		function Send(destinationSiteId: integer; jsonRequestString: string): integer;
		function Accept(destinationSiteId: integer; jsonRequestString: string): integer;
		function SiteRestServiceConnectionDetailsValid(): Boolean;
	private
		function DoPost(requestUrl: string; jsonStringData: string): integer;
                function HasZcfCredentials(): boolean;
	end;
	
var
	internalTransferRestService: TInternalTransferRestService;
        SSL: TIdConnectionInterceptOpenSSL;

implementation

uses uGlobals, ulog, uAdo, DB, ADODB, uSystemUtils;

function GetConsoleOutput(CommandLine: string; Work: string = 'C:\'): string;  { Run a DOS program and retrieve its output dynamically while it is running. }
var
  SecAtrrs: TSecurityAttributes;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  pCommandLine: array[0..255] of AnsiChar;
  BytesRead: Cardinal;
  WorkDir: string;
  Handle: Boolean;
begin
  Result := '';
  with SecAtrrs do begin
    nLength := SizeOf(SecAtrrs);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SecAtrrs, 0);
  try
    with StartupInfo do
    begin
      FillChar(StartupInfo, SizeOf(StartupInfo), 0);
      cb := SizeOf(StartupInfo);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect stdin
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;
    WorkDir := Work;
    Handle := CreateProcess(nil, PChar('cmd.exe /C ' + CommandLine),
                            nil, nil, True, 0, nil,
                            PChar(WorkDir), StartupInfo, ProcessInfo);
    CloseHandle(StdOutPipeWrite);
    if Handle then
      try
        repeat
          WasOK := windows.ReadFile(StdOutPipeRead, pCommandLine, 255, BytesRead, nil);
          if BytesRead > 0 then
          begin
            pCommandLine[BytesRead] := #0;
            Result := Result + pCommandLine;
          end;
        until not WasOK or (BytesRead = 0);
        WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
      finally
        CloseHandle(ProcessInfo.hThread);
        CloseHandle(ProcessInfo.hProcess);
      end;
  finally
    CloseHandle(StdOutPipeRead);
  end;
end;

function TInternalTransferRestService.HasZcfCredentials(): boolean;
var
  un: string;
  pwd: string;
  key: string;
begin
    Result := true;

    with dmADO.adoqRun do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT TOP 1 * FROM ac_EstateZcfInternalTransferSettings WHERE EstateId = 1';
      Open;

      if RecordCount = 0 then
      begin
        Result := false;
      end
      else
      begin
        un := FieldByName('Username').AsString;
        pwd := FieldByName('Password').AsString;
        key := FieldByName('Key').AsString;

        if ((un = '') or (pwd = '') or (key = '')) then
        begin
          Result := false;
        end;
      end;
      close;
    end;
end;

function TInternalTransferRestService.Send(destinationSiteId: integer; jsonRequestString: string): integer;
var
  restUrl: string;
begin
  restUrl := uGlobals.zcfHeadOfficeUrl + '/send-to-site/'+ IntToStr(destinationSiteId) +'/Proxy/AztecRest/InternalTransfer/Send/';
  Result := DoPost(restUrl, jsonRequestString);
end;

function TInternalTransferRestService.Accept(destinationSiteId: integer; jsonRequestString: string): integer;
var
  restUrl: string;
begin
  restUrl := uGlobals.zcfHeadOfficeUrl + '/send-to-site/'+ IntToStr(destinationSiteId) +'/Proxy/AztecRest/InternalTransfer/Accept/';
  Result := DoPost(restUrl, jsonRequestString);
end;

function TInternalTransferRestService.SiteRestServiceConnectionDetailsValid(): Boolean;
begin
  Result := true;

  if uGlobals.zcfHeadOfficeUrl = '' then
  begin
    log.Event('ZCF Head Office Proxy Url not set - falling back to direct SQL connection');
    Result := False;
  end
  else if not HasZcfCredentials() then
  begin
    log.Event('ZCF Head Office Proxy credentials not set - falling back to direct SQL connection');
    Result := False;
  end
  else
  begin
    log.Event('ZCF Url & Credentials are valid - trying transfer via ZCF');
  end;
end;

// This currently does nothing with the result.
// Will require some modification in the future if we ever want to do something with the result of the request.
function TInternalTransferRestService.DoPost(requestUrl: string; jsonStringData: string): integer;
var
  zcfHttpClientExePath: string;
  jsonDataFilePath: string;
  jsonStrList: TStringList;
begin
  if not HasZcfCredentials() then
  begin
    log.Event('Internal Transfers (ZCF); Invalid credentials - check Estate settings in Aztec Shell');
    Result := -1;
    Exit;
  end;

  try
    zcfHttpClientExePath := GetAztecInstallationFolder();
  except on E:Exception do
    begin
      log.Event('ERROR: Exception getting Aztec installation folder (path = "'+zcfHttpClientExePath+'") - ' + E.Message);
      Result := -1;
      Exit;
    end;
  end;

  jsonDataFilePath := ExtractFilePath(ParamStr(0)) + 'InternalTransfer.json';
  jsonDataFilePath := AnsiQuotedStr(jsonDataFilePath, '"');
  log.Event('JSON File Path: '+jsonDataFilePath);

  jsonStrList := TStringlist.create;
  jsonStrList.Text := jsonStringData;

  log.Event('POST REQUEST DATA: ' + jsonStringData);
  log.Event('POST REQUEST URL: ' + requestUrl);

  try
    jsonStrList.SaveToFile('InternalTransfer.json');
  except on E:Exception do
    begin
      log.Event('ERROR: Exception saving json data file - ' + E.Message);
      Result := -1;
      Exit;
    end;
  end;

  zcfHttpClientExePath := zcfHttpClientExePath+'bin\managed\';
  if not DirectoryExists(zcfHttpClientExePath) then
  begin
    log.Event('ERROR: Exception calling ZfcHttpClient - cannot find folder: '+zcfHttpClientExePath);
    Result := -1;
    exit;
  end;

  try
    Result := StrToInt(Trim(GetConsoleOutput('ZcfHttpClient.exe ' +requestUrl+' post'+' '+jsonDataFilePath, zcfHttpClientExePath)));
  except on E:Exception do
    begin
      log.Event('ERROR: Exception calling ZfcHttpClient - ' + E.Message);
      Result := -1;
    end;
  end;

  DeleteFile(jsonDataFilePath);
end;

initialization

internalTransferRestService := TInternalTransferRestService.create;

finalization

internalTransferRestService.Free;

end.