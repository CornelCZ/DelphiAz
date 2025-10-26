unit uXMLSave;

interface

uses classes, adodb, uADODB_27_TLB;

//
// Unit XMLSave - returns result of a FOR XML query as an XML file on disk
// By Peter Wishart - please ask before modifying
// (c) Zonal Retail Data Systems 2002
//
// A good modification would be to copy the ADO Stream object to a memory stream
// for v.fast writing to the network

// one procedure for string input (TADOCommand), one for TStrings input (TADOQuery etc.)
procedure XMLSaveToDisk(connection: TADOConnection; query: string; outfile: string; header,footer: string); overload;
procedure XMLSaveToDisk(connection: TADOConnection; query: TStrings; outfile: string; header,footer: string); overload;

function GetXMLStream(connection: TADOConnection; query: string): widestring;

type
  TXMLStreamAsync = class(TObject)
  public
    StreamResult: widestring;
    procedure Initialise(Connection: TADOConnection; query: string);
    procedure Cancel;
    function IsFinished: boolean;
    function IsCancelled: boolean;
  private
    Cancelled: boolean;
    RecordsAffected: olevariant;
    ADOCommand: uADODB_27_TLB._command;
    ADOStream: uADODB_27_TLB._stream;
  end;


implementation

uses activex, comobj, variants, sysutils, uXMLRectanglePatch;

procedure XMLSaveToDisk(connection: TADOConnection; query: TStrings;
  outfile: string; header, footer: string); overload;
begin
  XMLSaveToDisk(connection, query.text, outfile, header, footer);
end;

procedure XMLSaveToDisk(connection: TADOConnection; query: string;
  outfile: string; header, footer: string);
var
  recordsaffected: olevariant;
  ADOCommand: uADODB_27_TLB._command;
  ADOStream: uADODB_27_TLB._stream;
begin
  // uses ADO version 2.7, as XML saving via streams was introduced later than
  // the version Delphi uses.
  OleCheck(CoCreateInstance(uADODB_27_TLB.CLASS_Command, nil,
    CLSCTX_ALL, uADODB_27_TLB.IID_Command25, ADOCommand));
  OleCheck(CoCreateInstance(uADODB_27_TLB.CLASS_Stream, nil,
    CLSCTX_ALL, uADODB_27_TLB.IID__Stream, ADOStream));

  // create ADO stream object to receive XML
  ADOStream.Type_ := adTypeText;
  ADOStream.Open(EmptyParam, adModeUnknown, adOpenStreamUnspecified, '', '');

  // Modify dialect if ADOCommand is an XML query, allows for wrapping query result with XML code
  //  ADOCommand.Dialect := '{5D531CB2-E6Ed-11D2-B252-00C04F681B71}';
  ADOCommand.CommandType := adCmdText;
  ADOCommand.CommandText :=
  //    '<ROOT xmlns:sql=''urn:schemas-microsoft-com:xml-sql''><sql:query> '+ #13+
    query;// + #13+
  //    '</sql:query> </ROOT>';
  ADOCommand.Set_ActiveConnection(connection.ConnectionObject);
  ADOCommand.Properties.Item['Output Stream'].Value := ADOStream;
  RecordsAffected := 0;

  ADOCommand.CommandTimeout := 0;
  connection.CommandTimeout := 0;

  // write header, set character set to avoid it changing from the default("Unicode")
  // to UTF-8 halfway through..

  ADOStream.Charset := 'UTF-8';
  if header <> '' then
    ADOStream.WriteText(header, adWriteline);

  // recordsaffected will be set to -1 by this call, but the procedure objects
  // if I don't pass it..
  ADOCommand.Execute(recordsaffected, EmptyParam, adExecuteStream);

  // Make sure we're at the end of the stream, then write the footer.
  ADOStream.Position := ADOStream.Size;
  if footer <> '' then
    ADOStream.WriteText(footer, adWriteLine);
  ADOStream.SaveToFile(outfile, adSaveCreateOverWrite);


end;

function GetXMLStream(connection: TADOConnection; query: string): widestring;
var
  recordsaffected: olevariant;
  ADOCommand: uADODB_27_TLB._command;
  ADOStream: uADODB_27_TLB._stream;
  ErrorLocation: string;
begin
  // uses ADO version 2.7, as XML saving via streams was introduced later than
  // the version Delphi uses.
  try
  ErrorLocation := 'Creating ADO 2.5 command object';
  OleCheck(CoCreateInstance(uADODB_27_TLB.CLASS_Command, nil,
    CLSCTX_ALL, uADODB_27_TLB.IID_Command25, ADOCommand));
  ErrorLocation := 'Creating ADO stream object';
  OleCheck(CoCreateInstance(uADODB_27_TLB.CLASS_Stream, nil,
    CLSCTX_ALL, uADODB_27_TLB.IID__Stream, ADOStream));

  // create ADO stream object to receive XML
  ErrorLocation := 'Setting stream type';
  ADOStream.Type_ := adTypeText;
  ErrorLocation := 'Opening stream';
  ADOStream.Open(EmptyParam, adModeUnknown, adOpenStreamUnspecified, '', '');

  // Modify dialect if ADOCommand is an XML query, allows for wrapping query result with XML code
  //  ADOCommand.Dialect := '{5D531CB2-E6Ed-11D2-B252-00C04F681B71}';
  ErrorLocation := 'Setting command type';
  ADOCommand.CommandType := adCmdText;
  ErrorLocation := 'Setting command text';
  ADOCommand.CommandText :=
  //    '<ROOT xmlns:sql=''urn:schemas-microsoft-com:xml-sql''><sql:query> '+ #13+
    query;// + #13+
  //    '</sql:query> </ROOT>';
  ErrorLocation := 'Setting command/connection timeouts';
  ADOCommand.CommandTimeout := 0;
  connection.CommandTimeout := 0;
  ErrorLocation := 'Setting command connection';
  ADOCommand.Set_ActiveConnection(connection.ConnectionObject);
  ErrorLocation := 'Setting command output stream';
  ADOCommand.Properties.Item['Output Stream'].Value := ADOStream;
  ErrorLocation := 'Setting recordsaffected';
  RecordsAffected := 0;

  // write header, set character set to avoid it changing from the default("Unicode")
  // to UTF-8 halfway through..
//  ADOStream.Charset := 'Unicode';
  // recordsaffected will be set to -1 by this call, but the procedure objects
  // if I don't pass it..
  ErrorLocation := 'Executing command';
  ADOCommand.Execute(recordsaffected, EmptyParam, adExecuteStream);
  //result := allocmem(ADOStream.size * 2 + 1);
  ErrorLocation := 'Reading stream';
  
  // This is significantly faster if you read 128kb at a time. For more info see:
  // https://learn.microsoft.com/en-us/sql/ado/reference/ado-api/readtext-method
  result := '';
  while not ADOStream.EOS do
  begin
	result := result + (ADOStream.ReadText(128*1024));
  end;
  
  except on E:Exception do
    raise exception.create('Error '+Errorlocation + ' : ' + E.Message);
  end;

  // Rectangle refactor XML patch (hack alert)
  if Pos('theme_generateeposmodel', lowercase(Query)) <> 0 then
  begin
    with TXMLRectanglePatch.Create do try
      Apply(Result, mNewToOld);
    finally
      free;
    end;
  end;
end;

{ TXMLStreamAsync }


procedure TXMLStreamAsync.Initialise(Connection: TADOConnection;
  query: string);
begin
  StreamResult := '';
  // uses ADO version 2.7, as XML saving via streams was introduced later than
  // the version Delphi uses.
  OleCheck(CoCreateInstance(uADODB_27_TLB.CLASS_Command, nil,
    CLSCTX_ALL, uADODB_27_TLB.IID_Command25, ADOCommand));
  OleCheck(CoCreateInstance(uADODB_27_TLB.CLASS_Stream, nil,
    CLSCTX_ALL, uADODB_27_TLB.IID__Stream, ADOStream));

  // create ADO stream object to receive XML
  ADOStream.Type_ := adTypeText;
  ADOStream.Open(EmptyParam, adModeUnknown, adOpenStreamUnspecified, '', '');

  // Modify dialect if ADOCommand is an XML query, allows for wrapping query result with XML code
  //  ADOCommand.Dialect := '{5D531CB2-E6Ed-11D2-B252-00C04F681B71}';
  ADOCommand.CommandType := adCmdText;
  ADOCommand.CommandText :=
  //    '<ROOT xmlns:sql=''urn:schemas-microsoft-com:xml-sql''><sql:query> '+ #13+
    query;// + #13+
  //    '</sql:query> </ROOT>';
  ADOCommand.CommandTimeout := 0;
  Connection.CommandTimeout := 0;
  ADOCommand.Set_ActiveConnection(connection.ConnectionObject);
  ADOCommand.Properties.Item['Output Stream'].Value := ADOStream;
  RecordsAffected := 0;
  ADOCommand.Execute(recordsaffected, EmptyParam, adExecuteStream or adAsyncExecute {and adAsyncFetchNonBlocking});
end;

procedure TXMLStreamAsync.Cancel;
begin
  try
    if Assigned(ADOCommand) then
      ADOCommand.Cancel;
  except
    //Woe is me...
  end;
  Cancelled := True;
end;

function TXMLStreamAsync.IsCancelled: boolean;
begin
  if Cancelled and IsFinished then
    result := true
  else
    result := false;
end;

function TXMLStreamAsync.IsFinished: boolean;
begin
  result := ((ADOCommand.State and (adStateConnecting or adStateExecuting or adStateFetching)) = 0);
  if result and (StreamResult = '') then
    StreamResult := (ADOStream.ReadText(adostream.size));
end;

end.
