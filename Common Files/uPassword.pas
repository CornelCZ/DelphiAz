unit uPassword;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons,dialogs, DB, DBTables, ADODB, Variants, Messages, uUser, dADOAbstract, uPassToken;

type
  TfrmPassword = class(TForm)
    Label1: TLabel;
    edtPassword: TEdit;
    btnOK: TButton;
    CancelBtn: TButton;
    Label2: TLabel;
    edtUserName: TEdit;
    procedure btnOKClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure edtUserNameKeyPress(Sender: TObject; var Key: Char);
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
  private
    function AuthenticateUser(Username, Password: string; var UserId:Int64):boolean;
    function AuthenticateZonalUser(username, password:string):boolean;
    function IsZonalUsername(Username:string):boolean;
    procedure ResetCredentials;
    function CreateAndFetchUser(UserId:Int64; UserName, Password:string):TUser;
    function GetHashedPassword(Password: string): string;
  public
    function CheckPassword(UserName, Password:string) : Boolean;
    function LoginWithCommandLine(tokenParam: string):boolean;overload;

    class function UserHasPermission(TaskName: string): boolean;
    class function GetAccessNodeLevels(ReqAccessList: TStringList): TStringList;
    class function Login(tokenParam: string):boolean;
  end;

implementation

uses
  uGlobals, useful, uAztecDatabaseUtils, Bcrypt, DCPmd5;

{$R *.DFM}


// ---- ENTRY POINT, everything calls or should call this function --------------------------------
class function TfrmPassword.Login(tokenParam: string): boolean;
var PasswordForm:TfrmPassword;
begin
 PasswordForm:=TfrmPassword.Create(nil);
 try
  Result:= PasswordForm.LoginWithCommandLine(tokenParam);
 finally
  PasswordForm.Free;
 end;
end;
// ---- ENTRY POINT, everything calls or should call this function --------------------------------


function TfrmPassword.LoginWithCommandLine(tokenParam: string): boolean;
var
  UserName, Password :string;
begin
  uGlobals.LogonUserName := '';
  uGlobals.LogonFailedNames := '';
  uGlobals.LogonErrorString := '';
  uGlobals.LogonFailedTimes := 0;

  try
    if Length(tokenParam) > 22 then // any less it could not be a Token, show the dialog...
      Deobfuscate(tokenparam, Username, Password);
  except
    on E:Exception do
      // just log, if Deobfuscate/Decrypt fail just show the Password Entry dialog.
      uGlobals.LogonErrorString := uGlobals.LogonErrorString +
        ' ERROR: Deobfuscate for User "' + Username + '", Err: ' + E.Message;
  end;

  if (UserName = '') or not CheckPassword(UserName, Password)  then
    Result := ShowModal = mrOk
  else
  begin
    Result := True;
  end;
end;

procedure TfrmPassword.btnOKClick(Sender: TObject);
begin
  if trim(edtUserName.Text) = '' then
  begin
    edtUserName.SetFocus;
    ShowMessage('Please enter a valid user name.');
    Exit;
  end;

  if trim(edtPassword.Text) = '' then
  begin
    edtPassword.SetFocus;
    ShowMessage('Please enter a valid password.');
    Exit;
  end;

  if CheckPassword(edtUserName.Text, edtPassword.Text)  then
  begin
    ModalResult := mrOK;
  end
  else
  begin
    ShowMessage('Invalid User Name and/or Password - Please try again');
    edtUserName.Text := '';
    edtPassword.Text := '';
    ActiveControl := edtUserName;
  end;
end;

function TfrmPassword.CheckPassword(UserName, Password:string) : Boolean;
var
   UserId: Int64;
   locUser, locPass: string;
begin
  Result := False;

  locUser := UpperCase(UserName);
  locPass := UpperCase(Password);

  try
    if IsZonalUsername(locUser) then
    begin
      if AuthenticateZonalUser(locUser, locPass) then
      begin
        CurrentUser := TUser.Create(-1, locUser, locPass);
        CurrentUser.IsZonalUser:=true;
        Result := True;
      end
      else
        ResetCredentials();
    end
    else
    begin
      if AuthenticateUser(locUser, locPass, UserId) then
      begin
        CurrentUser := CreateAndFetchUser(UserId, locUser, locPass);
        CurrentUser.IsZonalUser:=false;
        Result := True;
      end
      else
      begin
        ResetCredentials;
        Result := False;
      end;
    end;

    if Result then
      uGlobals.LogonUserName := locUser;
  except
    ResetCredentials;
  end;
end;

function TfrmPassword.AuthenticateZonalUser(username, password:string):boolean;
begin
 result := ((username = 'ZONALDEV') and (password = ZonalDevPass)) or
      ((username = 'ZONALQA') and (password = ZonalQAPass)) or
      ((username = 'ZONALHC') and (password = ZonalHCPass));
end;

function TfrmPassword.IsZonalUsername(Username:string):boolean;
begin
 Result := (Username = 'ZONALDEV') or (Username = 'ZONALQA') or (Username = 'ZONALHC');
end;

function TfrmPassword.AuthenticateUser(Username, Password: string; var UserId: Int64):boolean;
var
  passwordAsMD5: string;
begin
  UserId := -1;
  with TADOQuery.Create(self) do
  begin
    try
      try
        passwordAsMD5 := LowerCase(GetHashedPassword(Password));
        Connection := GetAztecADOConnection;

        close;
        sql.Clear;

        if uGlobals.IsMaster then
        begin
          sql.Add('SELECT u.Id, u.Password');
          sql.Add('FROM ac_User u WHERE u.AztecUserName = ' + quotedStr(Username));
          sql.Add('AND u.Terminated = 0 AND u.AllowHeadOfficeLogin = 1');
          sql.Add('AND u.Password is NOT NULL ');
        end
        else
        begin
          sql.Add('DECLARE @SiteId int, @AreaId int, @CompanyId int');
          sql.Add(' ');
          sql.Add('SELECT @SiteId = s.Id, @AreaId = a.Id, @CompanyId = c.Id');
          sql.Add('FROM ac_SystemDefinition sd JOIN ac_Site s ON sd.SiteId = s.Id');
          sql.Add('JOIN ac_Area a ON s.AreaId = a.Id JOIN ac_Company c ON a.CompanyId = c.Id');
          sql.Add(' ');
          sql.Add('SELECT u.Id, u.Password FROM dbo.ac_User u');
          sql.Add('WHERE u.Terminated = 0 AND u.AztecUserName = ' + quotedStr(Username));
          sql.Add('AND u.Password is NOT NULL ');
          sql.Add('AND (  u.Id IN (SELECT UserId FROM ac_UserSites WHERE SiteId = @SiteId)');
          sql.Add('    OR u.Id IN (SELECT UserId FROM ac_UserAreas WHERE AreaId = @AreaId)');
          sql.Add('    OR u.Id IN (SELECT UserId FROM ac_UserCompanies WHERE CompanyId = @CompanyId))');
        end;
        open;

        while not Eof do // loop on all Users with the typed Name until the Password matches
        begin
          if TBCrypt.CheckPassword(passwordAsMD5, fieldByName('Password').asstring) then
          begin
            UserId := fieldByName('Id').value;
            break;
          end;
          next;
        end;

        Close;

        if UserId = -1 then
        begin
          uGlobals.LogonFailedNames := uGlobals.LogonFailedNames + ', ' + UserName +
            ' ' + formatdatetime('hh:nn:ss', Now());
          inc(uGlobals.LogonFailedTimes);
        end;
      except
        on E: Exception do
          uGlobals.LogonErrorString := uGlobals.LogonErrorString +
           ' ERROR: Checking Password for "' + Username + '", Err: ' + E.Message;
      end;
    finally
      free;
    end;
  end;

  Result := (UserId > -1);
end;

function TfrmPassword.GetHashedPassword(Password:string):string;
var
  Hasher: TDCP_md5;
  HashedPasswordArray: array[0..15] of byte;
  i:integer;
begin
  Hasher:= TDCP_md5.Create(nil);
  try
    Hasher.Init;
    Hasher.UpdateStr(Password);
    Hasher.Final(HashedPasswordArray);

    for i:=0 to Length(HashedPasswordArray) - 1 do
      Result := Result + IntToHex(HashedPasswordArray[i], 2);

  finally
    Hasher.Free;
  end;
end;

procedure TfrmPassword.CancelBtnClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmPassword.edtUserNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    edtPassword.SetFocus;
    Key := #0;
  end;
end;

procedure TfrmPassword.edtPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    btnOKClick(Sender);
    Key := #0;
  end;
end;

class function TfrmPassword.GetAccessNodeLevels(reqAccessList: TStringList): TStringList;
var
  i: integer;
  AccessLevels: TStringList;
  PermissionToTest: string;
begin
  AccessLevels := TStringList.Create;

  //Bug #332986
  AccessLevels.Sorted := True;

  for i:=0 to ReqAccessList.Count -1 do
   begin
    PermissionToTest := ReqAccessList[i];

    if UserHasPermission(PermissionToTest) then
     AccessLevels.Add(PermissionToTest);
   end;

  Result := AccessLevels;
end;

class function TfrmPassword.UserHasPermission(TaskName: string): boolean;
var StoredProc:TADOStoredProc;
    DbConnection:TADOConnection;
begin
  if CurrentUser=nil then
   begin
    Result := false;
    Exit;
   end;

  if CurrentUser.IsZonalUser then
   Result := True
  else
   begin
      StoredProc := TADOStoredProc.Create(nil);
      DbConnection := GetAztecADOConnection;
      try
        with StoredProc do
         begin
          ProcedureName := 'ac_spHasUserPermission';
          Connection := DbConnection;

          with Parameters do
          begin
               Clear;
               CreateParameter('@UserId',ftLargeInt, pdInput, 0, CurrentUser.Id);
               CreateParameter('@ActionTopic',ftString, pdInput, 100, TaskName);
               CreateParameter('@HasPermission',ftBoolean ,pdOutput, 1, 0);
               Prepared := true;
          end;

          ExecProc;

          Result := Parameters.ParamValues['@HasPermission'];
          Close;
         end;
      finally
       StoredProc.Free;
       DbConnection.Free;
      end;
   end;
end;


procedure TfrmPassword.ResetCredentials;
begin
 FreeAndNil(CurrentUser);
 CurrentUser := TUser.Create(-1, '','');
end;

function TfrmPassword.CreateAndFetchUser(UserId: Int64; UserName,
  Password: string): TUser;
var Query:TADOQuery;
    DBConnection:TADOConnection;
begin
 Result := TUser.Create(UserId, UserName, Password);

 Query:=TADOQuery.Create(nil);
 DBConnection:=GetAztecADOConnection;

 try
  Query.Connection:=DBConnection;
  Query.SQL.Add('SELECT UserId, UserName, UserPositionId, UserPositionName, RoleId, RoleName');
  Query.SQL.Add('FROM [dbo].[ad_UserDetails]');
  Query.SQL.Add(Format('WHERE UserId = %d', [UserId]));

  Query.Open;

  Assert(Query.RecordCount > 0);
  Result.UserPosition:= TUserPosition.Create(Query.FieldByName('UserPositionId').AsInteger, Query.FieldByName('UserPositionName').AsString);

  while not Query.EOF do
  begin

    if not Query.FieldByName('RoleId').IsNull then
      Result.Roles.Add( TRole.Create(Query.FieldByName('RoleId').AsInteger, Query.FieldByName('RoleName').AsString));

    Query.Next;
  end;

 finally
  Query.Free;
  DBConnection.Free;
 end;
end;

end.
