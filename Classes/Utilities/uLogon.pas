// Mike Palmer, 2004
// (c) Zonal Retail Data Systems Ltd
// Logon Interface
// IWindowsLogon - For Impersonating A User On Windows NT, 2000, XP, 2003 Domain
// IZonalLogon   - For Logging Into A Zonal System

Unit     uLogon;

Interface

Type     ILogon       =
         Interface
           Function  LogUserOn        : Boolean;
           Function  LogUserOff       : Boolean;
         End;

         IWindowsLogon =
         Interface ( ILogon )
         End;

         // For Logging In To Zonal Applications

         IZonalLogon   =
         Interface ( ILogon )
           Function AccessGranted     : Boolean;
           Function ChangeAccessLevel : Boolean;
           Function ChangeUserName    ( Const NewUserName : String ) : Boolean;
           Function ResetPassword     : Boolean;
           Function ChangePassword    ( Const OldPasword, NewPassword : String ) : Boolean;
         End;


Function MakeWindowsLogonInterface ( Const UserName, Password, Domain : String ) : IWindowsLogon;
Function MakeZonalLogonInterface   ( Const UserName, Password : String ) : IZonalLogon;

Implementation

Uses     ShellAPI, Windows;

Type     TWindowsLogon  =
         Class ( TInterfacedObject, IWindowsLogon )
             Constructor Create ( Const UserName, Password, Domain : String );
             Destructor  Destroy; Override;
             Function    LogUserOff     : Boolean;
             Function    LogUserOn      : Boolean;
           Private
             iUserName   : PChar;
             iDomain     : PChar;
             iPassword   : PChar;
             iToken      : Cardinal;
             iAdminToken : Cardinal;
             Function    UserIsLoggedOn : Boolean;
         End;

// Interface

Function MakeZonalLogonInterface   ( Const UserName, Password  : String ) : IZonalLogon;
Begin
//  Result := TAztecLogon.Create ( UserName, Password );
End;

Function MakeWindowsLogonInterface ( Const UserName, Password, Domain : String ) : IWindowsLogon;
// Instantiates The IWindowsLogon
Begin
  Result := TWindowsLogon.Create ( UserName, Password, Domain );
End;

// TWindowsLogon

Destructor  TWindowsLogon.Destroy;
// Releases All The Tokens Held For Login
Begin
  If UserIsLoggedOn Then
     LogUserOff;
  Inherited;
End;

Constructor TWindowsLogon.Create;
// Creates The TWindowsLogon
Begin
  iUserName := PChar ( UserName );
  iPassword := PChar ( Password );
  iDomain   := PChar ( Domain );
End;

Function    TWindowsLogon.LogUserOff;
// Logs The User Off And Closes All Associated Handles
Begin
  Result := RevertToSelf;
  Try
    CloseHandle ( iAdminToken );
    CloseHandle ( iToken );
  Except
  End;
End;

Function    TWindowsLogon.LogUserOn;
// Logs The User On And Initialises All Tokens
Begin
  LogonUser ( iUserName, iDomain, iPassword, LOGON32_LOGON_INTERACTIVE,
     LOGON32_PROVIDER_DEFAULT, iToken );
  DuplicateTokenEx ( iToken, TOKEN_QUERY And TOKEN_DUPLICATE And TOKEN_IMPERSONATE, Nil, SecurityImpersonation,
     TokenPrimary, iAdminToken );
  ImpersonateLoggedOnUser ( iAdminToken );
  Result := ( iAdminToken > 0 );
End;

Function    TWindowsLogon.UserIsLoggedOn;
// Verifies That The User Is Still Logged On
Begin
  Result := ( iAdminToken > 0 );
End;

End.


