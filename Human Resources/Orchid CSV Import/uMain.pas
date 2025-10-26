unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, uAztecProgress, OleServer, DB, ADODB,
  Mask, ToolEdit, uAztecDatabaseUtils, uLogFile, uPassword, Math, uSQLUtils, uGlobals;

type
  TfrmCSVImport = class(TForm)
    btnImport: TButton;
    btnCancel: TButton;
    CSVImportBar: TAztecProgressBar;
    bvlBevel: TBevel;
    lblImportPath: TLabel;
    AztecConn: TADOConnection;
    fedImportFile: TFilenameEdit;
    qryOrchidImport: TADOQuery;
    qryInsertRecords: TADOQuery;
    procedure btnImportClick(Sender: TObject);
    procedure fedImportFileChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    FUdfTitle : integer;
    FUdfAccomDeduction : integer;
    FUdfPaymentMethod : integer;
    Logfile : ILogFile;
    OriginalFileName : String;
    ImportError : Boolean;
    function  GetOriginalFileName(FilePath : String) : string;
    procedure ProcessFailedImport(FailedRecord, NewFileName : String);
    procedure ProcessError(SiteCode : Integer; SEC :Real);
    function  UserDefinedFieldsSet: Boolean;
    function  SiteExists(SiteRef : String): integer;
    function  JobExists(JobName : String) : integer;
    function  GeneratePassCode(SiteCode : Integer) : String;
    procedure ValidateUser;
    procedure ExtractData(FileName : String);
    function  ParseRecord(RecordString : String) : TStringList;
    procedure AssignUDF(UDFName : String; UDFID : integer);
    procedure InsertRecord(RecordList : String; out SiteCode : Integer); //inserts the recored and returns the site code for that record
    function  GetUDFErrors : String;
    function  InsertSiteEmployees(SiteCode, SEC, LastName, FirstName, DateOfBirth, NINumber, PayRollNumber, Address1, Address2, Address3, PostCode, Password, StartDate : String) : Boolean;
    function  InsertEmpPayNo(SiteCode, SEC, PayrollNumber : String):Boolean;
    function  InsertSiteEmployeeJobs(SiteCode, JobID, SEC, NRate : String) : Boolean;
    function  InsertSiteEmployeeUserDefinedInfo(SiteCode, SEC, UDFTitle, UDFPaymentMethod, UDFAccommDeduction : String) : Boolean;
    function  EmployeeExists(SiteCode, NINumber, PayrollNumber : String) : Boolean;
    function  InsertExtraEmp(SiteCode, SEC, BankName, BankBranch, BankSortCode, BankAccNumber, AccountName, BuildingSocRollNo : String):Boolean;
    procedure SetupReconfigure(SiteCode : String);
    procedure LogSQLErrors(TableName, SQLString, ErrorMessage : String);
  public
    { Public declarations }
  end;

const
  OUTLET_CODE             = 0;
  JOB_TITLE               = 2;
  SURNAME                 = 3;
  FORENAME                = 4;
  TITLE                   = 5;
  DOB                     = 6;
  PAYROLL_NUMBER          = 7;
  START_DATE              = 9;
  HOURLY_RATE_1           = 10;
  NI_NUMBER               = 13;
  ACCOMM_DEDUCTION        = 14;
  ADDRESS_LINE_1          = 30;
  ADDRESS_LINE_2          = 31;
  ADDRESS_LINE_3          = 32;
  POST_CODE               = 34;
  PAYMENT_METHOD          = 38;
  SORT_CODE               = 39;
  BANK_NAME               = 40;
  SHORT_BANK_ADDRESS      = 41;
  ACCOUNT_NAME            = 42;
  ACCOUNT_NUMBER          = 43;
  ACCOUNT_REF             = 44;

  ERROR_PATH = 'C:\Program Files\Zonal\Aztec\Log\Employee Import Errors\';

var
  frmCSVImport: TfrmCSVImport;

implementation

uses

   uEmployeeClass;

{$R *.dfm}

procedure TfrmCSVImport.ExtractData(FileName: String);
var
  InputFile : TStringList;
  Position : integer;
  CurrentRecord : String;
  CurrentSite : integer;
  PreviousSite: integer;
begin
  try
    Position := 0;
    InputFile := TStringList.Create;
    InputFile.LoadFromFile(FileName);
    InputFile.Delete(0);
    CSVImportBar.blockSize := 1;
    CSVImportBar.maximum := InputFile.Count;
    CSVImportBar.Visible := TRUE;

    PreviousSite := -1;
    while InputFile.Count > 0 do
    begin
      CSVImportBar.position :=  Position;
      CurrentRecord := InputFile.Strings[0];
      InsertRecord(CurrentRecord, CurrentSite);
      if (CurrentSite <> PreviousSite) and (CurrentSite > 0) then
      begin
        SetupReconfigure(IntToStr(CurrentSite));
        PreviousSite := CurrentSite;
      end;
      InputFile.Delete(0);
      inc(Position);
      Application.ProcessMessages;
    end;
    CSVImportBar.position := CSVImportBar.maximum;
    if ImportError then
      ShowMessage('There was an importing some data.'+#10#13+ 'See the Logfile in :'+#10#13+
                         ERROR_PATH + 'for more details.')
  finally
     FreeAndNil(InputFile);
  end;
end;

procedure TfrmCSVImport.btnImportClick(Sender: TObject);
var
  FilePath : String;
begin
  FilePath := fedImportFile.FileName;
  OriginalFileName := GetOriginalFileName(FilePath);
  ExtractData(fedImportFile.FileName);
end;



function TfrmCSVImport.ParseRecord(RecordString: String) :TStringList;
var
   RecordList : TStringList;
   FieldValue : String;
begin
   RecordList := TStringList.Create;
   while pos(',',RecordString) > 0 do
   begin
     FieldValue := copy(RecordString,0,pos(',',RecordString)-1);
     RecordList.Add(FieldValue);
     Delete(RecordString,1,pos(',',RecordString));
     Next;
   end;
   Result := RecordList;

end;

procedure TfrmCSVImport.fedImportFileChange(Sender: TObject);
begin
  btnImport.Enabled := fedImportFile.FileName <> '';
end;

procedure TfrmCSVImport.FormCreate(Sender: TObject);
begin
  if not DirectoryExists('C:\Program Files\Zonal\Aztec\Log\Employee Import Errors') then
    CreateDir('C:\Program Files\Zonal\Aztec\Log\Employee Import Errors');
  Logfile := MakeLogFileInterface('C:\Program Files\Zonal\Aztec\Log\HRImportErrors.log');
  FUdfTitle := -1;
  FUdfAccomDeduction := -1;
  FUdfPaymentMethod := -1;
  ImportError := FALSE;
  //ValidateUser;
end;

function TfrmCSVImport.UserDefinedFieldsSet: Boolean;
var
  ErrorMessage : String;
  RecordPosition : integer;
begin
  RecordPosition := 0;
  Result := FALSE;
  try
    try
      AztecConn.Close;
      SetUpAztecADOConnection(AztecConn);
      with qryOrchidImport do
      begin
        Connection := AztecConn;
        SQL.Text := 'SELECT [Name], [Udf] '+
                    'FROM dbo.[UdfDets]';
        Open;

        while not eof do
        begin
           AssignUDF(FieldByName('Name').AsString, RecordPosition);
           inc(RecordPosition);
           Next;
        end;

        Result := (FUdfTitle <> -1) and (FUdfAccomDeduction <> -1) and (FUdfPaymentMethod <> -1);

        if not Result then
        begin
          ErrorMessage := 'The following user defined fields need to be set up in Human Resources' + #10#13;
          ErrorMessage := ErrorMessage +#10#13 + GetUDFErrors;
          ErrorMessage := ErrorMessage + #10#13#10#13 + 'before this application will run';
          Logfile.Write(ErrorMessage);
          MessageDlg(ErrorMessage, mtInformation, [mbOK],0);
          Exit;
        end;
      end;
    except on e : Exception do
      ShowMessage('An Error has occurred.' + #10#13 + e.Message);
    end;
  finally
    AztecConn.Close;
  end;
end;

procedure TfrmCSVImport.FormShow(Sender: TObject);
begin
  if not UserDefinedFieldsSet then
    Application.Terminate;
end;

procedure TfrmCSVImport.AssignUDF(UDFName: String; UDFID: integer);
Const
  TITLE = 'TITLE';
  ACCOM_DEDUCTION = 'ACCOMM DEDUCTION';
  PAYMENT_METHOD = 'PAYMENT METHOD';
begin
   if UpperCase(UDFName) = TITLE  then
     FUdfTitle := UDFID
   else if UpperCase(UDFName) = ACCOM_DEDUCTION then
     FUdfAccomDeduction := UDFID
   else if UpperCase(UDFName) = PAYMENT_METHOD then
     FUdfPaymentMethod := UDFID;
end;

function GetTokenParam: string;
var
  i: integer;
begin
  Result := '';
  for i := 1 to ParamCount do
  begin
    if Copy(LowerCase(ParamStr(i)),1,6) = 'token=' then
      Result := Copy( ParamStr(i), 7, Length(ParamStr(i)) );
  end;
end;

procedure TfrmCSVImport.ValidateUser;
var
  tokenParam : string;
begin
  try
    try
      tokenParam := GetTokenParam;
      AztecConn.Close;
      SetUpAztecADOConnection(AztecConn);
      GetGlobalData(AztecConn);
      if not IsMaster then
      begin
        MessageDlg('This application can only be run at Head Office', mtInformation, [mbOK],0);
        Application.Terminate;
        Exit;
      end;

      TfrmPassword.Login(tokenParam);

      if CurrentUser.IsZonalUser then
        Logfile.Write('User: '+ uGlobals.CurrentUser.UserName +' has logged in')
      else
      begin
        showmessage('You do not have permission to run this');
        LogFile.Write('User failed to login. Terminating application');
        Application.Terminate;
        Exit;
      end;
    Except on e : exception do
    begin
      ShowMessage('Error Occured: ' + e.Message);
      Logfile.Write('Error Message: ' + e.Message);
    end;
    end;
  finally
    AztecConn.Close;
  end;
end;

Procedure TfrmCSVImport.InsertRecord(RecordList: String; out SiteCode : Integer);
var
  LastName, FirstName, DateOfBirth, NINumber, PayRollNumber, Address1, Address2, Address3, PostCode, StartDate: String;
  SEC : Real;
  RecordFile : TStringList;
  Employee : TEmployeeClass;
  Password : String;
  JobName : String;
  JobID : integer;
  PayRate : String;
  UDFTitle, UDFAccommDeduction, UDFPaymentMethod : String;
  SiteRef : String;
  BankName, BankBranch, BankSortCode, BankAccNumber, AccountName, BuildingSocRollNo : String;
begin
  RecordFile := nil;

  try

    RecordFile := ParseRecord(RecordList);

    SiteRef := RecordFile.Strings[OUTLET_CODE];
    LastName := RecordFile.Strings[SURNAME];
    FirstName := RecordFile.Strings[FORENAME];
    DateOfBirth := RecordFile.Strings[DOB];
    NINumber := RecordFile.Strings[NI_NUMBER];
    PayRollNumber := RecordFile.Strings[PAYROLL_NUMBER];
    Address1 := RecordFile.Strings[ADDRESS_LINE_1];
    Address2 := RecordFile.Strings[ADDRESS_LINE_2];
    Address3 := RecordFile.Strings[ADDRESS_LINE_3];
    PostCode := RecordFile.Strings[POST_CODE];
    StartDate := RecordFile.Strings[START_DATE];
    JobName := RecordFile.Strings[JOB_TITLE];
    PayRate := RecordFile.Strings[HOURLY_RATE_1];
    UDFTitle := RecordFile.Strings[TITLE];
    UDFAccommDeduction := RecordFile.Strings[ACCOMM_DEDUCTION];
    UDFPaymentMethod := RecordFile.Strings[PAYMENT_METHOD];
    BankName := RecordFile.Strings[BANK_NAME];
    BankBranch := RecordFile.Strings[SHORT_BANK_ADDRESS];
    BankSortCode := RecordFile.Strings[SORT_CODE];
    BankAccNumber := RecordFile.Strings[ACCOUNT_NUMBER];
    AccountName := RecordFile.Strings[ACCOUNT_NAME];
    BuildingSocRollNo := RecordFile.Strings[ACCOUNT_REF];

    SiteCode := SiteExists(SiteRef);
    JobId := JobExists(JobName);
    if SiteCode > 0 then
    begin
      if JobId <> -1 then
      Begin
        if EmployeeExists(IntTostr(SiteCode), NINumber,PayRollNumber) then
        begin
          ProcessFailedImport(RecordList, 'ImportErrors');
          Logfile.Write('Duplicate Employee Not Inserted');
          Logfile.Write('The record has been saved to: ' + ERROR_PATH+OriginalFileName+'_ImportErrors.csv');
          ImportError := TRUE;
        end
        else
        begin
          try
            Employee := TEmployeeClass.Create;
            SEC := Employee.GetSiteSEC(SiteCode);
            Password := GeneratePassCode(SiteCode);
            if (InsertSiteEmployees(IntToStr(SiteCode), FloatToStr(SEC),LastName,FirstName,DateOfBirth,NINumber,PayRollNumber,Address1,Address2,Address3,PostCode, Password, StartDate)) and
               (InsertEmpPayNo(IntToStr(SiteCode),FloatToStr(SEC),PayrollNumber)) and
               (InsertSiteEmployeeJobs(IntToStr(SiteCode),IntToStr(JobID),FloatToStr(SEC),PayRate)) and
               (InsertSiteEmployeeUserDefinedInfo(IntToStr(SiteCode), FloatToStr(SEC), UDFTitle, UDFPaymentMethod ,UDFAccommDeduction)) and
               (InsertExtraEmp(IntToStr(SiteCode),FloatToStr(SEC),BankName, BankBranch, BankSortCode, BankAccNumber, AccountName, BuildingSocRollNo))then
              Logfile.Write('Employee Added to Aztec')
            else
            begin
              ProcessFailedImport(RecordList, 'ImportErrors');
              ProcessError(SiteCode, SEC);
              ImportError := TRUE;
            end;
          finally
            FreeAndNil(Employee);
          end;
        end;
      end
      else
      Begin
        ProcessFailedImport(RecordList, 'ImportErrors');
        Logfile.Write('Job name '+ JobName +' does not exist. This record has not been imported.');
        Logfile.Write('The record has been saved to: ' + ERROR_PATH+OriginalFileName+'_ImportErrors.csv');
        ImportError := TRUE;
      end;
    end
    else
    begin
      ProcessFailedImport(RecordList, 'SiteErrors');
      ImportError := TRUE;
      Logfile.Write('Site ref: ' + SiteRef + ' Has not been defined in Aztec');
      Logfile.Write('The record has been saved to: ' + ERROR_PATH+OriginalFileName+'_SiteErrors.csv');
    end;
  finally
    FreeAndNil(RecordFile);
  end;
end;

function TfrmCSVImport.SiteExists(SiteRef : String): integer;
begin
  Result := -1;
  with qryOrchidImport do
  try
    AztecConn.Close;
    SetUpAztecADOConnection(AztecConn);
    try
      begin
        Close;
        Connection := AztecConn;
        SQL.Text := 'SELECT [Site Code] from dbo.[SiteAztec] '+
                    'WHERE [Site Ref] = '+ QuotedStr(SiteRef);
        open;
        if recordcount > 0 then
           Result := FieldByName('Site Code').AsInteger;
      end;
    except on e: Exception do
      begin
        Logfile.Write('Error: ' + e.Message);
        ShowMessage('There was an error checking the site.' + #10#13 + 'See log for details.');
      end;
    end;
  finally
    AztecConn.Close;
  end;
end;

procedure TfrmCSVImport.btnCancelClick(Sender: TObject);
begin
  Close;
end;

function TfrmCSVImport.GeneratePassCode(SiteCode: Integer): String;
var
  LastPassword : string;
  CurrentPass : integer;
begin
  try
    AztecConn.Close;
    SetUpAztecADOConnection(AztecConn);
    with qryOrchidImport do
    begin
      Connection := AztecConn;
      SQL.Text := 'SELECT MAX([Password]) AS [Password] '+
                   'FROM dbo.[SiteEmployee] '+
                   'WHERE [SiteCode] = '+ IntToStr(SiteCode);
      open;
      LastPassword := FieldByName('PassWord').AsString;
      if LastPassword = '' then
        Result := '0001'
      else
      begin
        CurrentPass := StrToInt(LastPassword);
        CurrentPass := CurrentPass + 1;
        Result := FormatFloat('0000',CurrentPass);
      end;
    end
  finally
    AztecConn.Close;
  end;
end;

function TfrmCSVImport.GetUDFErrors: String;
var
  Title : String;
  AccommDeduction :String;
  PaymentMethod : String;
  ReturnString : String;
begin
  ReturnString := '';
  if FUdfTitle = -1 then
  begin
    Title := 'Title not defined in User Defined Fields' +#10#13;
    ReturnString := ReturnString + Title;
  end;
  if FUdfAccomDeduction = -1 then
  begin
    AccommDeduction := 'Accomm Deduction not defined in User Defined Fields' +#10#13;
    ReturnString := ReturnString + AccommDeduction;
  end;
  if FUdfPaymentMethod = -1 then
  begin
    PaymentMethod := 'Payment Method not defined in User Defined Fields' +#10#13;
    ReturnString := ReturnString + PaymentMethod;
  end;
  Result := ReturnString;
end;

function TfrmCSVImport.InsertSiteEmployees(SiteCode, SEC, LastName, FirstName, DateOfBirth,
  NINumber, PayRollNumber, Address1, Address2, Address3, PostCode,
  Password, StartDate: String): Boolean;
var
RegisterName : String;
begin
  RegisterName := FirstName;
  Delete(RegisterName,10,Length(RegisterName));
  Delete(FirstName,20,Length(FirstName));
  Delete(LastName,20,Length(LastName));
  Delete(Address1,30,Length(Address1));
  Delete(Address2,30,Length(address2));
  Delete(Address3,15,Length(Address3));
  Try
    Try
      Result := False;
      SetUpSysAdminAztecADOConnection(AztecConn);
      with qryInsertRecords do
      begin
        AztecConn.Close;
        Connection := AztecConn;
        SQL.Clear;
        SQL.Add( 'INSERT dbo.[SiteEmployee] (SiteCode, SEC, LastName, FirstName, '+
                    'DOB, SSNo, PayRollNo, Address1, Address2, Address3, '+
                    'PostCode, [Password], Hiredate, RegisterName, Incomplete)');
        SQL.Add('VALUES('+ SiteCode +', '+ SEC +', '+QuotedStr(LastName)  +', '+ QuotedStr(FirstName)+', '+
                         FormatDateTimeForSQL(StrToDateTime(DateOfBirth)) +', '+ QuotedStr(NINumber)+', '+ QuotedStr(PayRollNumber) +', '+
                         QuotedStr(Address1) +', '+ QuotedStr(Address2) +', '+ QuotedStr(Address3) +', '+
                         QuotedStr(PostCode) +', '+ QuotedStr(Password) +', '+ FormatDateTimeForSQL(StrToDateTime(StartDate))+', '+
                         QuotedStr(RegisterName) + ', ''N'')' );
        ExecSQL;
        Result := TRUE;
      end;
    Except on e : Exception Do
      begin
        LogSQLErrors('Site Employees', qryInsertRecords.SQL.Text, e.Message);
        Result := FALSE;
      end;
    end;
  Finally
    AztecConn.Close;
  end;
end;

procedure TfrmCSVImport.ProcessFailedImport( FailedRecord, NewFileName : String);
var
  ImportErrorsFile : TextFile;
begin

  AssignFile(ImportErrorsFile, ERROR_PATH+OriginalFileName+'_'+NewFileName+'.csv');
  if FileExists(ERROR_PATH+OriginalFileName+'_'+NewFileName+'.csv') then
    Append(ImportErrorsFile)
  else
  begin
    Rewrite(ImportErrorsFile);
    Writeln(ImportErrorsFile,'   ');
  end;
  Writeln(ImportErrorsFile, FailedRecord);
  Flush(ImportErrorsFile);
  CloseFile(ImportErrorsFile);
end;

function TfrmCSVImport.GetOriginalFileName(FilePath: String) : string;
var
  FileName : String;
begin
  FileName := ExtractFileName(FilePath);
  Delete(FileName,Pos('.',FileName),Length(FileName));
  
  Result := FileName;
end;

procedure TfrmCSVImport.ProcessError(SiteCode: Integer; SEC: Real);
begin
  try
    try
      SetUpAztecADOConnection(AztecConn);
      with qryOrchidImport do
      begin
        Connection := AztecConn;
        SQL.Clear;
        SQL.Text := 'DELETE FROM dbo.[SiteEmployee] WHERE [SiteCode] = '+ IntToStr(SiteCode) +
                    'AND SEC = ' + FloatToStr(SEC);
        ExecSQL;
        SQL.Clear;
        SQL.Text := 'DELETE FROM  dbo.[SiteEmployeeUserDefinedInfo] WHERE [SiteCode] = '+ IntToStr(SiteCode) +
                    'AND SEC = ' + FloatToStr(SEC);
        ExecSQL;
        SQL.Clear;
        SQL.Text := 'DELETE FROM  dbo.[EmpPayNo] WHERE [SiteCode] = '+ IntToStr(SiteCode) +
                    'AND SEC = ' + FloatToStr(SEC);
        ExecSQL;
        SQL.Clear;
        SQL.Text := 'DELETE FROM  dbo.[SiteEmployeeJobs] WHERE [SiteCode] = '+ IntToStr(SiteCode) +
                    'AND SEC = ' + FloatToStr(SEC);
        ExecSQL;
        SQL.Clear;
        SQL.Text := 'DELETE FROM  dbo.[ExtraEmp] WHERE [SiteCode] = '+ IntToStr(SiteCode) +
            'AND SEC = ' + FloatToStr(SEC);
        ExecSQL;
      end;
    except on e :exception do
      Logfile.Write(e.Message);
    end;
  finally
    AztecConn.Close;
  end;
end;

function TfrmCSVImport.InsertEmpPayNo(SiteCode, SEC,
  PayrollNumber : String): Boolean;
begin
  try
    try
      SetUpAztecADOConnection(AztecConn);
      with qryInsertRecords do
      begin
        Connection := AztecConn;
        SQL.Clear;
        SQL.Text := 'INSERT dbo.[EmpPayNo] (SiteCode, SEC, PayRollNo, LMDT)'+
                    'VALUES(' +SiteCode +', '+ SEC +', '+ PayRollNumber +', GetDate())';
        ExecSQL;
        Result := TRUE;
      end;
    Except on e : Exception Do
      begin
        LogSQLErrors('Emp Pay No', qryInsertRecords.SQL.Text, e.Message);
        Result := FALSE;
      end;
    end;
  finally
    AztecConn.Close;
  end;
end;


function TfrmCSVImport.JobExists(JobName: String): integer;
begin
  Result := -1;
  if Length(JobName) > 15 then
    Delete(JobName,16,Length(JobName));
  try
    try
      SetUpAztecADOConnection(AztecConn);
      with qryOrchidImport do
      begin
        Connection := AztecConn;
        SQL.Clear;
        SQL.Text := 'SELECT [JobId] '+ ' '+
                    'from dbo.[AztecJobCode] where [JobName] = ' + QuotedStr(JobName);
        Open;
        if RecordCount > 0 then
          Result := FieldByName('JobId').AsInteger;
      end;

    except on e : Exception do
      begin
        ShowMessage(e.Message);
        Logfile.Write('Job Exists:' + e.Message);
      end;
    end;
  finally
    AztecConn.Close;
  end;
end;

function TfrmCSVImport.InsertSiteEmployeeJobs(SiteCode, JobID, SEC,
  NRate: String): Boolean;
Const
  PAYTYPE = '1';
  VALID = 'D';
  USERMODE = 'N';
  DEFAULT = 'D';
begin
  try
    try
      SetUpAztecADOConnection(AztecConn);
      with qryInsertRecords do
      begin
        Connection := AztecConn;
        SQL.Clear;
        SQL.Text := 'INSERT dbo.[SiteEmployeeJobs] (SiteCode, JobID, [Default], Valid,  SEC, NRate, PayType, LMDT, ModBy)';
        SQl.Add('VALUES('+SiteCode +', '+ JobId +', '+QuotedStr(DEFAULT)+', '+ QuotedStr(VALID) +', '+SEC +', '+ NRate +', '+ PAYTYPE +',  GetDate(), '+ quotedstr(uGlobals.CurrentUser.UserName)+')');
        ExecSQL;
        Result := TRUE;
      end;
    Except on e : Exception Do
      begin
        LogSQLErrors('Site Employees', qryInsertRecords.SQL.Text, e.Message);
        Result := FALSE;
      end;
    end;
  finally
    AztecConn.Close;
  end;

end;

function TfrmCSVImport.InsertSiteEmployeeUserDefinedInfo(SiteCode, SEC,
  UDFTitle, UDFPaymentMethod, UDFAccommDeduction: String): Boolean;
begin
  try
    try
      SetUpAztecADOConnection(AztecConn);
      with qryInsertRecords do
      begin
        Connection := AztecConn;
        SQL.Clear;
        SQL.Text := 'INSERT dbo.[SiteEmployeeUserDefinedInfo](SiteCode, SEC'  +
                    ', UDF' + IntToStr(FUdfTitle) + ', UDF' + IntToStr(FUdfAccomDeduction) +
                    ', UDF' + IntToStr(FUdfPaymentMethod) + ', LMDT, ModBy)';

        SQL.Add('Values(' + SiteCode +', '+ SEC +', '+ quotedstr(UDFTitle) +
                          ', '+ quotedstr(UDFAccommDeduction)+', '+ quotedstr(UDFPaymentMethod)+
                          ', GetDate(), '+Quotedstr(uGlobals.CurrentUser.UserName) +')');
        ExecSQL;
        Result := TRUE;
      end;
    Except on e : Exception Do
      begin
        LogSQLErrors('Site Employee User Defined Info', qryInsertRecords.SQL.Text, e.Message);
        Result := FALSE;
      end;
    end;
  finally
    AztecConn.Close;
  end;
end;

function TfrmCSVImport.EmployeeExists(SiteCode, NINumber,
  PayrollNumber: String): Boolean;
begin
  Result := False;
  try
    try
      SetUpAztecADOConnection(AztecConn);
      with qryInsertRecords do
      begin
        Connection := AztecConn;
        SQL.Clear;
        SQL.Text := 'SELECT * FROM dbo.[SiteEmployee] '+
                    'WHERE [SiteCode] = '+SiteCode +' '+
                    'AND ([SSNo] = '+ quotedstr(NINumber) +' or [PayRollNo] = '+QuotedStr(PayrollNumber)+')';
        Open;

        Result := RecordCount > 0
      end;
    Except on e : Exception Do
      begin
        logFile.Write(qryInsertRecords.SQL.Text);
        Logfile.Write('Error checking Employee: '+e.Message);
      end;
    end;
  finally
    AztecConn.Close;
  end;
end;

function TfrmCSVImport.InsertExtraEmp(SiteCode, SEC, BankName, BankBranch,
  BankSortCode, BankAccNumber, AccountName,
  BuildingSocRollNo: String): Boolean;
begin
  Delete(BankName,25,Length(BankName));
  Delete(BankBranch,25,Length(BankBranch));
  Delete(AccountName,25,Length(AccountName));
  try
    try
      SetUpAztecADOConnection(AztecConn);
      with qryInsertRecords do
      begin
        Connection := AztecConn;
        SQL.Clear;
        SQL.Text := 'INSERT ExtraEmp(SiteCode, SEC, BankName, BankBranch, BankSortCode, BankAccNumber, AccountName, BuildingSocRollNo, LMDT, ModBy)';
        SQl.Add('VALUES('+SiteCode +', '+ SEC +', '+ QuotedStr(BankName) +', '+ QuotedStr(BankBranch)+
                                   ', '+ QuotedStr(BankSortCode)+', '+ QuotedStr(BankAccNumber)+
                                   ', '+ QuotedStr(AccountName)+', '+ QuotedStr(BuildingSocRollNo)+
                                   ', GetDate(), '+ quotedstr(uGlobals.CurrentUser.UserName)+')');
        ExecSQL;
        Result := TRUE;
      end;
    Except on e : Exception Do
      begin
        LogSQLErrors('Extra Emp', qryInsertRecords.SQL.Text, e.Message);
        Result := FALSE;
      end;
    end;
  finally
    AztecConn.Close;
  end;
end;

procedure TfrmCSVImport.SetupReconfigure(SiteCode : String);
begin
try
    try
      SetUpAztecADOConnection(AztecConn);
      with qryInsertRecords do
      begin
        Connection := AztecConn;
        SQL.Clear;
        SQL.Add('DELETE FROM dbo.[CommsReconfigureTables]');
        SQL.Add('WHERE [SiteCode] = '+ SiteCode +' ');
        SQL.Add('AND [CommsTableID] IN ');
        SQL.Add('    (SELECT [CommsTableID] FROM dbo.[ModuleComms] ');
        SQL.Add('     WHERE [TableName] IN ' +
                  '(''SiteEmployee'', ''SiteEmployeeJobs'', ''SiteEmployeeUserDefinedInfo'', ''EmpPayNo'', ''ExtraEmp''))');
        ExecSQL;

        SQL.Clear;
        SQL.Add('INSERT INTO dbo.[CommsReconfigureTables]');
        SQL.Add('SELECT '+ SiteCode +' , [TABLEID], 2');
        SQL.Add('FROM dbo.[ModuleComms]');
        SQL.Add('WHERE [TableName] IN ' +
                  '(''SiteEmployee'', ''SiteEmployeeJobs'', ''SiteEmployeeUserDefinedInfo'', ''EmpPayNo'', ''ExtraEmp'')');
        ExecSQL;
      end;
    except on e : Exception Do
      begin
        Logfile.Write('Reconfigure Failed with: '+ e.Message);
      end;
    end;
  finally
    AztecConn.Close;
  end;
end;

procedure TfrmCSVImport.LogSQLErrors(TableName, SQLString,
  ErrorMessage: String);
begin
  Logfile.Write('----------------- Import Error '+TableName+' -----------------');
  Logfile.Write('Error Importing Record: '+ErrorMessage);
  Logfile.Write('Failed SQL: '+ SQLString);
  Logfile.Write('The record has been saved to: ' + ERROR_PATH+OriginalFileName+'_ImportErrors.csv');
  Logfile.Write('---------------End Import Error----------------');
  Logfile.Write('');
end;



end.



