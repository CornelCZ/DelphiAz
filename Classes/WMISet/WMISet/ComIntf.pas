unit ComIntf;

interface

Uses Windows;

(*
interface IClientSecurity : IUnknown
{

    typedef struct tagSOLE_AUTHENTICATION_SERVICE
    {
        DWORD    dwAuthnSvc;
        DWORD    dwAuthzSvc;
        OLECHAR *pPrincipalName;
        HRESULT  hr;
    } SOLE_AUTHENTICATION_SERVICE;

    {
        EOAC_NONE             = 0x0,
        EOAC_MUTUAL_AUTH      = 0x1,
        EOAC_STATIC_CLOAKING  = 0x20,
        EOAC_DYNAMIC_CLOAKING = 0x40,
        EOAC_ANY_AUTHORITY    = 0x80,
        EOAC_MAKE_FULLSIC     = 0x100,
        EOAC_DEFAULT          = 0x800,

        // These are only valid for CoInitializeSecurity
        EOAC_SECURE_REFS       = 0x2,
        EOAC_ACCESS_CONTROL    = 0x4,
        EOAC_APPID             = 0x8,
        EOAC_DYNAMIC           = 0x10,
        EOAC_REQUIRE_FULLSIC   = 0x200,
        EOAC_AUTO_IMPERSONATE  = 0x400,
        EOAC_NO_CUSTOM_MARSHAL = 0x2000,
        EOAC_DISABLE_AAA       = 0x1000
    } EOLE_AUTHENTICATION_CAPABILITIES;

    typedef SOLE_AUTHENTICATION_SERVICE *PSOLE_AUTHENTICATION_SERVICE;

    typedef enum tagEOLE_AUTHENTICATION_CAPABILITIES

    const OLECHAR *COLE_DEFAULT_PRINCIPAL = (OLECHAR * ) -1;
    const void    *COLE_DEFAULT_AUTHINFO  = (void * ) -1;


    typedef struct tagSOLE_AUTHENTICATION_INFO
    {
        DWORD  dwAuthnSvc;
        DWORD  dwAuthzSvc;
        void  *pAuthInfo;
    } SOLE_AUTHENTICATION_INFO, *PSOLE_AUTHENTICATION_INFO;

    typedef struct tagSOLE_AUTHENTICATION_LIST
    {
        DWORD                     cAuthInfo;
        SOLE_AUTHENTICATION_INFO *aAuthInfo;
    } SOLE_AUTHENTICATION_LIST, *PSOLE_AUTHENTICATION_LIST;

*)

type
  IClientSecurity = interface(IUnknown)
  ['{0000013D-0000-0000-C000-000000000046}']

    function QueryBlanket(
        pProxy:               IUnknown;
        var pAuthnSvc:        DWORD;
        var pAuthzSvc:        DWORD;
        var pServerPrincName: PWideChar;
        var pAuthnLevel:      DWORD;
        var pImpLevel:        DWORD;
        var AuthInfo:         Pointer;
        var pCapabilites:     DWORD): HRESULT; stdcall;

    function SetBlanket(
        pProxy:               IUnknown;
        pAuthnSvc:        DWORD;
        pAuthzSvc:        DWORD;
        pServerPrincName: PWideChar;
        pAuthnLevel:      DWORD;
        pImpLevel:        DWORD;
        AuthInfo:         Pointer;
        pCapabilites:     DWORD): HRESULT; stdcall;

    function CopyProxy(
        pProxy: IUnknown;
        var ppCopy: IUnknown): HRESULT; stdcall;
  end;
        
implementation

end.
 