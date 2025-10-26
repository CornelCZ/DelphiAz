unit ActiveDsTLB;

{$I ..\Common\define.inc}

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision:   1.88.1.0.1.0  $
// File generated on 08/29/2002 10:57:59 AM from Type Library described below.

// ************************************************************************ //
// Type Lib: C:\WINNT\system32\activeds.tlb (1)
// IID\LCID: {97D25DB0-0363-11CF-ABC4-02608C9E7553}\0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINNT\System32\STDVCL40.DLL)
// Errors:
//   Hint: Member 'String' of '_ADS_CASEIGNORE_LIST' changed to 'String_'
//   Hint: Member 'Type' of '__MIDL___MIDL_itf_ads_0000_0005' changed to 'Type_'
//   Hint: Member 'Type' of '__MIDL___MIDL_itf_ads_0000_0014' changed to 'Type_'
//   Hint: Member 'Class' of 'IADs' changed to 'Class_'
//   Hint: Member 'Set' of 'IADsNameTranslate' changed to 'Set_'
//   Hint: Member 'Type' of 'IADsEmail' changed to 'Type_'
//   Hint: Member 'Type' of 'IADsPath' changed to 'Type_'
//   Hint: Member 'Set' of 'IADsPathname' changed to 'Set_'
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, OleCtrls, StdVCL;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  ActiveDsMajorVersion = 1;
  ActiveDsMinorVersion = 0;

  LIBID_ActiveDs: TGUID = '{97D25DB0-0363-11CF-ABC4-02608C9E7553}';

  IID_IADs: TGUID = '{FD8256D0-FD15-11CE-ABC4-02608C9E7553}';
  IID_IADsContainer: TGUID = '{001677D0-FD16-11CE-ABC4-02608C9E7553}';
  IID_IADsCollection: TGUID = '{72B945E0-253B-11CF-A988-00AA006BC149}';
  IID_IADsMembers: TGUID = '{451A0030-72EC-11CF-B03B-00AA006E0975}';
  IID_IADsPropertyList: TGUID = '{C6F602B6-8F69-11D0-8528-00C04FD8D503}';
  IID_IADsPropertyEntry: TGUID = '{05792C8E-941F-11D0-8529-00C04FD8D503}';
  CLASS_PropertyEntry: TGUID = '{72D3EDC2-A4C4-11D0-8533-00C04FD8D503}';
  IID_IADsPropertyValue: TGUID = '{79FA9AD0-A97C-11D0-8534-00C04FD8D503}';
  IID_IADsPropertyValue2: TGUID = '{306E831C-5BC7-11D1-A3B8-00C04FB950DC}';
  CLASS_PropertyValue: TGUID = '{7B9E38B0-A97C-11D0-8534-00C04FD8D503}';
  IID_IPrivateDispatch: TGUID = '{86AB4BBE-65F6-11D1-8C13-00C04FD8D503}';
  IID_ITypeInfo: TGUID = '{00020401-0000-0000-C000-000000000046}';
  IID_ITypeComp: TGUID = '{00020403-0000-0000-C000-000000000046}';
  IID_ITypeLib: TGUID = '{00020402-0000-0000-C000-000000000046}';
  IID_IPrivateUnknown: TGUID = '{89126BAB-6EAD-11D1-8C18-00C04FD8D503}';
  IID_IADsExtension: TGUID = '{3D35553C-D2B0-11D1-B17B-0000F87593A0}';
  IID_IADsDeleteOps: TGUID = '{B2BD0902-8878-11D1-8C21-00C04FD8D503}';
  IID_IADsNamespaces: TGUID = '{28B96BA0-B330-11CF-A9AD-00AA006BC149}';
  IID_IADsClass: TGUID = '{C8F93DD0-4AE0-11CF-9E73-00AA004A5691}';
  IID_IADsProperty: TGUID = '{C8F93DD3-4AE0-11CF-9E73-00AA004A5691}';
  IID_IADsSyntax: TGUID = '{C8F93DD2-4AE0-11CF-9E73-00AA004A5691}';
  IID_IADsLocality: TGUID = '{A05E03A2-EFFE-11CF-8ABC-00C04FD8D503}';
  IID_IADsO: TGUID = '{A1CD2DC6-EFFE-11CF-8ABC-00C04FD8D503}';
  IID_IADsOU: TGUID = '{A2F733B8-EFFE-11CF-8ABC-00C04FD8D503}';
  IID_IADsDomain: TGUID = '{00E4C220-FD16-11CE-ABC4-02608C9E7553}';
  IID_IADsComputer: TGUID = '{EFE3CC70-1D9F-11CF-B1F3-02608C9E7553}';
  IID_IADsComputerOperations: TGUID = '{EF497680-1D9F-11CF-B1F3-02608C9E7553}';
  IID_IADsGroup: TGUID = '{27636B00-410F-11CF-B1FF-02608C9E7553}';
  IID_IADsUser: TGUID = '{3E37E320-17E2-11CF-ABC4-02608C9E7553}';
  IID_IADsPrintQueue: TGUID = '{B15160D0-1226-11CF-A985-00AA006BC149}';
  IID_IADsPrintQueueOperations: TGUID = '{124BE5C0-156E-11CF-A986-00AA006BC149}';
  IID_IADsPrintJob: TGUID = '{32FB6780-1ED0-11CF-A988-00AA006BC149}';
  IID_IADsPrintJobOperations: TGUID = '{9A52DB30-1ECF-11CF-A988-00AA006BC149}';
  IID_IADsService: TGUID = '{68AF66E0-31CA-11CF-A98A-00AA006BC149}';
  IID_IADsServiceOperations: TGUID = '{5D7B33F0-31CA-11CF-A98A-00AA006BC149}';
  IID_IADsFileService: TGUID = '{A89D1900-31CA-11CF-A98A-00AA006BC149}';
  IID_IADsFileServiceOperations: TGUID = '{A02DED10-31CA-11CF-A98A-00AA006BC149}';
  IID_IADsFileShare: TGUID = '{EB6DCAF0-4B83-11CF-A995-00AA006BC149}';
  IID_IADsSession: TGUID = '{398B7DA0-4AAB-11CF-AE2C-00AA006EBFB9}';
  IID_IADsResource: TGUID = '{34A05B20-4AAB-11CF-AE2C-00AA006EBFB9}';
  IID_IADsOpenDSObject: TGUID = '{DDF2891E-0F9C-11D0-8AD4-00C04FD8D503}';
  IID_IDirectoryObject: TGUID = '{E798DE2C-22E4-11D0-84FE-00C04FD8D503}';
  IID_IDirectorySearch: TGUID = '{109BA8EC-92F0-11D0-A790-00C04FD8D5A8}';
  IID_IDirectorySchemaMgmt: TGUID = '{75DB3B9C-A4D8-11D0-A79C-00C04FD8D5A8}';
  IID_IADsAggregatee: TGUID = '{1346CE8C-9039-11D0-8528-00C04FD8D503}';
  IID_IADsAggregator: TGUID = '{52DB5FB0-941F-11D0-8529-00C04FD8D503}';
  IID_IADsAccessControlEntry: TGUID = '{B4F3A14C-9BDD-11D0-852C-00C04FD8D503}';
  CLASS_AccessControlEntry: TGUID = '{B75AC000-9BDD-11D0-852C-00C04FD8D503}';
  IID_IADsAccessControlList: TGUID = '{B7EE91CC-9BDD-11D0-852C-00C04FD8D503}';
  CLASS_AccessControlList: TGUID = '{B85EA052-9BDD-11D0-852C-00C04FD8D503}';
  IID_IADsSecurityDescriptor: TGUID = '{B8C787CA-9BDD-11D0-852C-00C04FD8D503}';
  CLASS_SecurityDescriptor: TGUID = '{B958F73C-9BDD-11D0-852C-00C04FD8D503}';
  IID_IADsLargeInteger: TGUID = '{9068270B-0939-11D1-8BE1-00C04FD8D503}';
  CLASS_LargeInteger: TGUID = '{927971F5-0939-11D1-8BE1-00C04FD8D503}';
  IID_IADsNameTranslate: TGUID = '{B1B272A3-3625-11D1-A3A4-00C04FB950DC}';
  CLASS_NameTranslate: TGUID = '{274FAE1F-3626-11D1-A3A4-00C04FB950DC}';
  IID_IADsCaseIgnoreList: TGUID = '{7B66B533-4680-11D1-A3B4-00C04FB950DC}';
  CLASS_CaseIgnoreList: TGUID = '{15F88A55-4680-11D1-A3B4-00C04FB950DC}';
  IID_IADsFaxNumber: TGUID = '{A910DEA9-4680-11D1-A3B4-00C04FB950DC}';
  CLASS_FaxNumber: TGUID = '{A5062215-4681-11D1-A3B4-00C04FB950DC}';
  IID_IADsNetAddress: TGUID = '{B21A50A9-4080-11D1-A3AC-00C04FB950DC}';
  CLASS_NetAddress: TGUID = '{B0B71247-4080-11D1-A3AC-00C04FB950DC}';
  IID_IADsOctetList: TGUID = '{7B28B80F-4680-11D1-A3B4-00C04FB950DC}';
  CLASS_OctetList: TGUID = '{1241400F-4680-11D1-A3B4-00C04FB950DC}';
  IID_IADsEmail: TGUID = '{97AF011A-478E-11D1-A3B4-00C04FB950DC}';
  CLASS_Email: TGUID = '{8F92A857-478E-11D1-A3B4-00C04FB950DC}';
  IID_IADsPath: TGUID = '{B287FCD5-4080-11D1-A3AC-00C04FB950DC}';
  CLASS_Path: TGUID = '{B2538919-4080-11D1-A3AC-00C04FB950DC}';
  IID_IADsReplicaPointer: TGUID = '{F60FB803-4080-11D1-A3AC-00C04FB950DC}';
  CLASS_ReplicaPointer: TGUID = '{F5D1BADF-4080-11D1-A3AC-00C04FB950DC}';
  IID_IADsAcl: TGUID = '{8452D3AB-0869-11D1-A377-00C04FB950DC}';
  CLASS_Acl: TGUID = '{7AF1EFB6-0869-11D1-A377-00C04FB950DC}';
  IID_IADsTimestamp: TGUID = '{B2F5A901-4080-11D1-A3AC-00C04FB950DC}';
  CLASS_Timestamp: TGUID = '{B2BED2EB-4080-11D1-A3AC-00C04FB950DC}';
  IID_IADsPostalAddress: TGUID = '{7ADECF29-4680-11D1-A3B4-00C04FB950DC}';
  CLASS_PostalAddress: TGUID = '{0A75AFCD-4680-11D1-A3B4-00C04FB950DC}';
  IID_IADsBackLink: TGUID = '{FD1302BD-4080-11D1-A3AC-00C04FB950DC}';
  CLASS_BackLink: TGUID = '{FCBF906F-4080-11D1-A3AC-00C04FB950DC}';
  IID_IADsTypedName: TGUID = '{B371A349-4080-11D1-A3AC-00C04FB950DC}';
  CLASS_TypedName: TGUID = '{B33143CB-4080-11D1-A3AC-00C04FB950DC}';
  IID_IADsHold: TGUID = '{B3EB3B37-4080-11D1-A3AC-00C04FB950DC}';
  CLASS_Hold: TGUID = '{B3AD3E13-4080-11D1-A3AC-00C04FB950DC}';
  IID_IADsObjectOptions: TGUID = '{46F14FDA-232B-11D1-A808-00C04FD8D5A8}';
  IID_IADsPathname: TGUID = '{D592AED4-F420-11D0-A36E-00C04FB950DC}';
  CLASS_Pathname: TGUID = '{080D0D78-F421-11D0-A36E-00C04FB950DC}';
  IID_IADsADSystemInfo: TGUID = '{5BB11929-AFD1-11D2-9CB9-0000F87A369E}';
  CLASS_ADSystemInfo: TGUID = '{50B6327F-AFD1-11D2-9CB9-0000F87A369E}';
  IID_IADsWinNTSystemInfo: TGUID = '{6C6D65DC-AFD1-11D2-9CB9-0000F87A369E}';
  CLASS_WinNTSystemInfo: TGUID = '{66182EC4-AFD1-11D2-9CB9-0000F87A369E}';
  IID_IADsDNWithBinary: TGUID = '{7E99C0A2-F935-11D2-BA96-00C04FB6D0D1}';
  CLASS_DNWithBinary: TGUID = '{7E99C0A3-F935-11D2-BA96-00C04FB6D0D1}';
  IID_IADsDNWithString: TGUID = '{370DF02E-F934-11D2-BA96-00C04FB6D0D1}';
  CLASS_DNWithString: TGUID = '{334857CC-F934-11D2-BA96-00C04FB6D0D1}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum __MIDL___MIDL_itf_ads_0000_0001
type
  __MIDL___MIDL_itf_ads_0000_0001 = TOleEnum;
const
  ADSTYPE_INVALID = $00000000;
  ADSTYPE_DN_STRING = $00000001;
  ADSTYPE_CASE_EXACT_STRING = $00000002;
  ADSTYPE_CASE_IGNORE_STRING = $00000003;
  ADSTYPE_PRINTABLE_STRING = $00000004;
  ADSTYPE_NUMERIC_STRING = $00000005;
  ADSTYPE_BOOLEAN = $00000006;
  ADSTYPE_INTEGER = $00000007;
  ADSTYPE_OCTET_STRING = $00000008;
  ADSTYPE_UTC_TIME = $00000009;
  ADSTYPE_LARGE_INTEGER = $0000000A;
  ADSTYPE_PROV_SPECIFIC = $0000000B;
  ADSTYPE_OBJECT_CLASS = $0000000C;
  ADSTYPE_CASEIGNORE_LIST = $0000000D;
  ADSTYPE_OCTET_LIST = $0000000E;
  ADSTYPE_PATH = $0000000F;
  ADSTYPE_POSTALADDRESS = $00000010;
  ADSTYPE_TIMESTAMP = $00000011;
  ADSTYPE_BACKLINK = $00000012;
  ADSTYPE_TYPEDNAME = $00000013;
  ADSTYPE_HOLD = $00000014;
  ADSTYPE_NETADDRESS = $00000015;
  ADSTYPE_REPLICAPOINTER = $00000016;
  ADSTYPE_FAXNUMBER = $00000017;
  ADSTYPE_EMAIL = $00000018;
  ADSTYPE_NT_SECURITY_DESCRIPTOR = $00000019;
  ADSTYPE_UNKNOWN = $0000001A;
  ADSTYPE_DN_WITH_BINARY = $0000001B;
  ADSTYPE_DN_WITH_STRING = $0000001C;

// Constants for enum __MIDL___MIDL_itf_ads_0000_0018
type
  __MIDL___MIDL_itf_ads_0000_0018 = TOleEnum;
const
  ADS_SECURE_AUTHENTICATION = $00000001;
  ADS_USE_ENCRYPTION = $00000002;
  ADS_USE_SSL = $00000002;
  ADS_READONLY_SERVER = $00000004;
  ADS_PROMPT_CREDENTIALS = $00000008;
  ADS_NO_AUTHENTICATION = $00000010;
  ADS_FAST_BIND = $00000020;
  ADS_USE_SIGNING = $00000040;
  ADS_USE_SEALING = $00000080;
  ADS_USE_DELEGATION = $00000100;
  ADS_SERVER_BIND = $00000200;
  ADS_AUTH_RESERVED = $80000000;

// Constants for enum __MIDL___MIDL_itf_ads_0000_0019
type
  __MIDL___MIDL_itf_ads_0000_0019 = TOleEnum;
const
  ADS_STATUS_S_OK = $00000000;
  ADS_STATUS_INVALID_SEARCHPREF = $00000001;
  ADS_STATUS_INVALID_SEARCHPREFVALUE = $00000002;

// Constants for enum __MIDL___MIDL_itf_ads_0000_0020
type
  __MIDL___MIDL_itf_ads_0000_0020 = TOleEnum;
const
  ADS_DEREF_NEVER = $00000000;
  ADS_DEREF_SEARCHING = $00000001;
  ADS_DEREF_FINDING = $00000002;
  ADS_DEREF_ALWAYS = $00000003;

// Constants for enum __MIDL___MIDL_itf_ads_0000_0021
type
  __MIDL___MIDL_itf_ads_0000_0021 = TOleEnum;
const
  ADS_SCOPE_BASE = $00000000;
  ADS_SCOPE_ONELEVEL = $00000001;
  ADS_SCOPE_SUBTREE = $00000002;

// Constants for enum __MIDL___MIDL_itf_ads_0000_0022
type
  __MIDL___MIDL_itf_ads_0000_0022 = TOleEnum;
const
  ADSIPROP_ASYNCHRONOUS = $00000000;
  ADSIPROP_DEREF_ALIASES = $00000001;
  ADSIPROP_SIZE_LIMIT = $00000002;
  ADSIPROP_TIME_LIMIT = $00000003;
  ADSIPROP_ATTRIBTYPES_ONLY = $00000004;
  ADSIPROP_SEARCH_SCOPE = $00000005;
  ADSIPROP_TIMEOUT = $00000006;
  ADSIPROP_PAGESIZE = $00000007;
  ADSIPROP_PAGED_TIME_LIMIT = $00000008;
  ADSIPROP_CHASE_REFERRALS = $00000009;
  ADSIPROP_SORT_ON = $0000000A;
  ADSIPROP_CACHE_RESULTS = $0000000B;
  ADSIPROP_ADSIFLAG = $0000000C;

// Constants for enum __MIDL___MIDL_itf_ads_0000_0023
type
  __MIDL___MIDL_itf_ads_0000_0023 = TOleEnum;
const
  ADSI_DIALECT_LDAP = $00000000;
  ADSI_DIALECT_SQL = $00000001;

// Constants for enum __MIDL___MIDL_itf_ads_0000_0024
type
  __MIDL___MIDL_itf_ads_0000_0024 = TOleEnum;
const
  ADS_CHASE_REFERRALS_NEVER = $00000000;
  ADS_CHASE_REFERRALS_SUBORDINATE = $00000020;
  ADS_CHASE_REFERRALS_EXTERNAL = $00000040;
  ADS_CHASE_REFERRALS_ALWAYS = $00000060;

// Constants for enum __MIDL___MIDL_itf_ads_0000_0025
type
  __MIDL___MIDL_itf_ads_0000_0025 = TOleEnum;
const
  ADS_SEARCHPREF_ASYNCHRONOUS = $00000000;
  ADS_SEARCHPREF_DEREF_ALIASES = $00000001;
  ADS_SEARCHPREF_SIZE_LIMIT = $00000002;
  ADS_SEARCHPREF_TIME_LIMIT = $00000003;
  ADS_SEARCHPREF_ATTRIBTYPES_ONLY = $00000004;
  ADS_SEARCHPREF_SEARCH_SCOPE = $00000005;
  ADS_SEARCHPREF_TIMEOUT = $00000006;
  ADS_SEARCHPREF_PAGESIZE = $00000007;
  ADS_SEARCHPREF_PAGED_TIME_LIMIT = $00000008;
  ADS_SEARCHPREF_CHASE_REFERRALS = $00000009;
  ADS_SEARCHPREF_SORT_ON = $0000000A;
  ADS_SEARCHPREF_CACHE_RESULTS = $0000000B;
  ADS_SEARCHPREF_DIRSYNC = $0000000C;
  ADS_SEARCHPREF_TOMBSTONE = $0000000D;

// Constants for enum __MIDL___MIDL_itf_ads_0000_0026
type
  __MIDL___MIDL_itf_ads_0000_0026 = TOleEnum;
const
  ADS_PROPERTY_CLEAR = $00000001;
  ADS_PROPERTY_UPDATE = $00000002;
  ADS_PROPERTY_APPEND = $00000003;
  ADS_PROPERTY_DELETE = $00000004;

// Constants for enum tagTYPEKIND
type
  tagTYPEKIND = TOleEnum;
const
  TKIND_ENUM = $00000000;
  TKIND_RECORD = $00000001;
  TKIND_MODULE = $00000002;
  TKIND_INTERFACE = $00000003;
  TKIND_DISPATCH = $00000004;
  TKIND_COCLASS = $00000005;
  TKIND_ALIAS = $00000006;
  TKIND_UNION = $00000007;
  TKIND_MAX = $00000008;

// Constants for enum tagDESCKIND
type
  tagDESCKIND = TOleEnum;
const
  DESCKIND_NONE = $00000000;
  DESCKIND_FUNCDESC = $00000001;
  DESCKIND_VARDESC = $00000002;
  DESCKIND_TYPECOMP = $00000003;
  DESCKIND_IMPLICITAPPOBJ = $00000004;
  DESCKIND_MAX = $00000005;

// Constants for enum tagFUNCKIND
type
  tagFUNCKIND = TOleEnum;
const
  FUNC_VIRTUAL = $00000000;
  FUNC_PUREVIRTUAL = $00000001;
  FUNC_NONVIRTUAL = $00000002;
  FUNC_STATIC = $00000003;
  FUNC_DISPATCH = $00000004;

// Constants for enum tagINVOKEKIND
type
  tagINVOKEKIND = TOleEnum;
const
  INVOKE_FUNC = $00000001;
  INVOKE_PROPERTYGET = $00000002;
  INVOKE_PROPERTYPUT = $00000004;
  INVOKE_PROPERTYPUTREF = $00000008;

// Constants for enum tagCALLCONV
type
  tagCALLCONV = TOleEnum;
const
  CC_FASTCALL = $00000000;
  CC_CDECL = $00000001;
  CC_MSCPASCAL = $00000002;
  CC_PASCAL = $00000002;
  CC_MACPASCAL = $00000003;
  CC_STDCALL = $00000004;
  CC_FPFASTCALL = $00000005;
  CC_SYSCALL = $00000006;
  CC_MPWCDECL = $00000007;
  CC_MPWPASCAL = $00000008;
  CC_MAX = $00000009;

// Constants for enum tagVARKIND
type
  tagVARKIND = TOleEnum;
const
  VAR_PERINSTANCE = $00000000;
  VAR_STATIC = $00000001;
  VAR_CONST = $00000002;
  VAR_DISPATCH = $00000003;

// Constants for enum tagSYSKIND
type
  tagSYSKIND = TOleEnum;
const
  SYS_WIN16 = $00000000;
  SYS_WIN32 = $00000001;
  SYS_MAC = $00000002;
  SYS_WIN64 = $00000001;

// Constants for enum __MIDL___MIDL_itf_ads_0120_0001
type
  __MIDL___MIDL_itf_ads_0120_0001 = TOleEnum;
const
  ADS_SYSTEMFLAG_DISALLOW_DELETE = $80000000;
  ADS_SYSTEMFLAG_CONFIG_ALLOW_RENAME = $40000000;
  ADS_SYSTEMFLAG_CONFIG_ALLOW_MOVE = $20000000;
  ADS_SYSTEMFLAG_CONFIG_ALLOW_LIMITED_MOVE = $10000000;
  ADS_SYSTEMFLAG_DOMAIN_DISALLOW_RENAME = $08000000;
  ADS_SYSTEMFLAG_DOMAIN_DISALLOW_MOVE = $04000000;
  ADS_SYSTEMFLAG_CR_NTDS_NC = $00000001;
  ADS_SYSTEMFLAG_CR_NTDS_DOMAIN = $00000002;
  ADS_SYSTEMFLAG_ATTR_NOT_REPLICATED = $00000001;
  ADS_SYSTEMFLAG_ATTR_IS_CONSTRUCTED = $00000004;

// Constants for enum __MIDL___MIDL_itf_ads_0126_0001
type
  __MIDL___MIDL_itf_ads_0126_0001 = TOleEnum;
const
  ADS_GROUP_TYPE_GLOBAL_GROUP = $00000002;
  ADS_GROUP_TYPE_DOMAIN_LOCAL_GROUP = $00000004;
  ADS_GROUP_TYPE_LOCAL_GROUP = $00000004;
  ADS_GROUP_TYPE_UNIVERSAL_GROUP = $00000008;
  ADS_GROUP_TYPE_SECURITY_ENABLED = $80000000;

// Constants for enum ADS_USER_FLAG
type
  ADS_USER_FLAG = TOleEnum;
const
  ADS_UF_SCRIPT = $00000001;
  ADS_UF_ACCOUNTDISABLE = $00000002;
  ADS_UF_HOMEDIR_REQUIRED = $00000008;
  ADS_UF_LOCKOUT = $00000010;
  ADS_UF_PASSWD_NOTREQD = $00000020;
  ADS_UF_PASSWD_CANT_CHANGE = $00000040;
  ADS_UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED = $00000080;
  ADS_UF_TEMP_DUPLICATE_ACCOUNT = $00000100;
  ADS_UF_NORMAL_ACCOUNT = $00000200;
  ADS_UF_INTERDOMAIN_TRUST_ACCOUNT = $00000800;
  ADS_UF_WORKSTATION_TRUST_ACCOUNT = $00001000;
  ADS_UF_SERVER_TRUST_ACCOUNT = $00002000;
  ADS_UF_DONT_EXPIRE_PASSWD = $00010000;
  ADS_UF_MNS_LOGON_ACCOUNT = $00020000;
  ADS_UF_SMARTCARD_REQUIRED = $00040000;
  ADS_UF_TRUSTED_FOR_DELEGATION = $00080000;
  ADS_UF_NOT_DELEGATED = $00100000;

// Constants for enum __MIDL___MIDL_itf_ads_0148_0001
type
  __MIDL___MIDL_itf_ads_0148_0001 = TOleEnum;
const
  ADS_RIGHT_DELETE = $00010000;
  ADS_RIGHT_READ_CONTROL = $00020000;
  ADS_RIGHT_WRITE_DAC = $00040000;
  ADS_RIGHT_WRITE_OWNER = $00080000;
  ADS_RIGHT_SYNCHRONIZE = $00100000;
  ADS_RIGHT_ACCESS_SYSTEM_SECURITY = $01000000;
  ADS_RIGHT_GENERIC_READ = $80000000;
  ADS_RIGHT_GENERIC_WRITE = $40000000;
  ADS_RIGHT_GENERIC_EXECUTE = $20000000;
  ADS_RIGHT_GENERIC_ALL = $10000000;
  ADS_RIGHT_DS_CREATE_CHILD = $00000001;
  ADS_RIGHT_DS_DELETE_CHILD = $00000002;
  ADS_RIGHT_ACTRL_DS_LIST = $00000004;
  ADS_RIGHT_DS_SELF = $00000008;
  ADS_RIGHT_DS_READ_PROP = $00000010;
  ADS_RIGHT_DS_WRITE_PROP = $00000020;
  ADS_RIGHT_DS_DELETE_TREE = $00000040;
  ADS_RIGHT_DS_LIST_OBJECT = $00000080;
  ADS_RIGHT_DS_CONTROL_ACCESS = $00000100;

// Constants for enum __MIDL___MIDL_itf_ads_0148_0002
type
  __MIDL___MIDL_itf_ads_0148_0002 = TOleEnum;
const
  ADS_ACETYPE_ACCESS_ALLOWED = $00000000;
  ADS_ACETYPE_ACCESS_DENIED = $00000001;
  ADS_ACETYPE_SYSTEM_AUDIT = $00000002;
  ADS_ACETYPE_ACCESS_ALLOWED_OBJECT = $00000005;
  ADS_ACETYPE_ACCESS_DENIED_OBJECT = $00000006;
  ADS_ACETYPE_SYSTEM_AUDIT_OBJECT = $00000007;

// Constants for enum __MIDL___MIDL_itf_ads_0148_0003
type
  __MIDL___MIDL_itf_ads_0148_0003 = TOleEnum;
const
  ADS_ACEFLAG_INHERIT_ACE = $00000002;
  ADS_ACEFLAG_NO_PROPAGATE_INHERIT_ACE = $00000004;
  ADS_ACEFLAG_INHERIT_ONLY_ACE = $00000008;
  ADS_ACEFLAG_INHERITED_ACE = $00000010;
  ADS_ACEFLAG_VALID_INHERIT_FLAGS = $0000001F;
  ADS_ACEFLAG_SUCCESSFUL_ACCESS = $00000040;
  ADS_ACEFLAG_FAILED_ACCESS = $00000080;

// Constants for enum __MIDL___MIDL_itf_ads_0148_0004
type
  __MIDL___MIDL_itf_ads_0148_0004 = TOleEnum;
const
  ADS_FLAG_OBJECT_TYPE_PRESENT = $00000001;
  ADS_FLAG_INHERITED_OBJECT_TYPE_PRESENT = $00000002;

// Constants for enum __MIDL___MIDL_itf_ads_0148_0005
type
  __MIDL___MIDL_itf_ads_0148_0005 = TOleEnum;
const
  ADS_SD_CONTROL_SE_OWNER_DEFAULTED = $00000001;
  ADS_SD_CONTROL_SE_GROUP_DEFAULTED = $00000002;
  ADS_SD_CONTROL_SE_DACL_PRESENT = $00000004;
  ADS_SD_CONTROL_SE_DACL_DEFAULTED = $00000008;
  ADS_SD_CONTROL_SE_SACL_PRESENT = $00000010;
  ADS_SD_CONTROL_SE_SACL_DEFAULTED = $00000020;
  ADS_SD_CONTROL_SE_DACL_AUTO_INHERIT_REQ = $00000100;
  ADS_SD_CONTROL_SE_SACL_AUTO_INHERIT_REQ = $00000200;
  ADS_SD_CONTROL_SE_DACL_AUTO_INHERITED = $00000400;
  ADS_SD_CONTROL_SE_SACL_AUTO_INHERITED = $00000800;
  ADS_SD_CONTROL_SE_DACL_PROTECTED = $00001000;
  ADS_SD_CONTROL_SE_SACL_PROTECTED = $00002000;
  ADS_SD_CONTROL_SE_SELF_RELATIVE = $00008000;

// Constants for enum __MIDL___MIDL_itf_ads_0148_0006
type
  __MIDL___MIDL_itf_ads_0148_0006 = TOleEnum;
const
  ADS_SD_REVISION_DS = $00000004;

// Constants for enum __MIDL___MIDL_itf_ads_0149_0001
type
  __MIDL___MIDL_itf_ads_0149_0001 = TOleEnum;
const
  ADS_NAME_TYPE_1779 = $00000001;
  ADS_NAME_TYPE_CANONICAL = $00000002;
  ADS_NAME_TYPE_NT4 = $00000003;
  ADS_NAME_TYPE_DISPLAY = $00000004;
  ADS_NAME_TYPE_DOMAIN_SIMPLE = $00000005;
  ADS_NAME_TYPE_ENTERPRISE_SIMPLE = $00000006;
  ADS_NAME_TYPE_GUID = $00000007;
  ADS_NAME_TYPE_UNKNOWN = $00000008;
  ADS_NAME_TYPE_USER_PRINCIPAL_NAME = $00000009;
  ADS_NAME_TYPE_CANONICAL_EX = $0000000A;
  ADS_NAME_TYPE_SERVICE_PRINCIPAL_NAME = $0000000B;
  ADS_NAME_TYPE_SID_OR_SID_HISTORY_NAME = $0000000C;

// Constants for enum __MIDL___MIDL_itf_ads_0149_0002
type
  __MIDL___MIDL_itf_ads_0149_0002 = TOleEnum;
const
  ADS_NAME_INITTYPE_DOMAIN = $00000001;
  ADS_NAME_INITTYPE_SERVER = $00000002;
  ADS_NAME_INITTYPE_GC = $00000003;

// Constants for enum __MIDL___MIDL_itf_ads_0163_0001
type
  __MIDL___MIDL_itf_ads_0163_0001 = TOleEnum;
const
  ADS_OPTION_SERVERNAME = $00000000;
  ADS_OPTION_REFERRALS = $00000001;
  ADS_OPTION_PAGE_SIZE = $00000002;
  ADS_OPTION_SECURITY_MASK = $00000003;
  ADS_OPTION_MUTUAL_AUTH_STATUS = $00000004;

// Constants for enum __MIDL___MIDL_itf_ads_0163_0002
type
  __MIDL___MIDL_itf_ads_0163_0002 = TOleEnum;
const
  ADS_SECURITY_INFO_OWNER = $00000001;
  ADS_SECURITY_INFO_GROUP = $00000002;
  ADS_SECURITY_INFO_DACL = $00000004;
  ADS_SECURITY_INFO_SACL = $00000008;

// Constants for enum __MIDL___MIDL_itf_ads_0164_0001
type
  __MIDL___MIDL_itf_ads_0164_0001 = TOleEnum;
const
  ADS_SETTYPE_FULL = $00000001;
  ADS_SETTYPE_PROVIDER = $00000002;
  ADS_SETTYPE_SERVER = $00000003;
  ADS_SETTYPE_DN = $00000004;

// Constants for enum __MIDL___MIDL_itf_ads_0164_0002
type
  __MIDL___MIDL_itf_ads_0164_0002 = TOleEnum;
const
  ADS_FORMAT_WINDOWS = $00000001;
  ADS_FORMAT_WINDOWS_NO_SERVER = $00000002;
  ADS_FORMAT_WINDOWS_DN = $00000003;
  ADS_FORMAT_WINDOWS_PARENT = $00000004;
  ADS_FORMAT_X500 = $00000005;
  ADS_FORMAT_X500_NO_SERVER = $00000006;
  ADS_FORMAT_X500_DN = $00000007;
  ADS_FORMAT_X500_PARENT = $00000008;
  ADS_FORMAT_SERVER = $00000009;
  ADS_FORMAT_PROVIDER = $0000000A;
  ADS_FORMAT_LEAF = $0000000B;

// Constants for enum __MIDL___MIDL_itf_ads_0164_0003
type
  __MIDL___MIDL_itf_ads_0164_0003 = TOleEnum;
const
  ADS_DISPLAY_FULL = $00000001;
  ADS_DISPLAY_VALUE_ONLY = $00000002;

// Constants for enum __MIDL___MIDL_itf_ads_0164_0004
type
  __MIDL___MIDL_itf_ads_0164_0004 = TOleEnum;
const
  ADS_ESCAPEDMODE_DEFAULT = $00000001;
  ADS_ESCAPEDMODE_ON = $00000002;
  ADS_ESCAPEDMODE_OFF = $00000003;
  ADS_ESCAPEDMODE_OFF_EX = $00000004;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IADs = interface;
  IADsDisp = dispinterface;
  IADsContainer = interface;
  IADsContainerDisp = dispinterface;
  IADsCollection = interface;
  IADsCollectionDisp = dispinterface;
  IADsMembers = interface;
  IADsMembersDisp = dispinterface;
  IADsPropertyList = interface;
  IADsPropertyListDisp = dispinterface;
  IADsPropertyEntry = interface;
  IADsPropertyEntryDisp = dispinterface;
  IADsPropertyValue = interface;
  IADsPropertyValueDisp = dispinterface;
  IADsPropertyValue2 = interface;
  IADsPropertyValue2Disp = dispinterface;
  IPrivateDispatch = interface;
  ITypeInfo = interface;
  ITypeComp = interface;
  ITypeLib = interface;
  IPrivateUnknown = interface;
  IADsExtension = interface;
  IADsDeleteOps = interface;
  IADsDeleteOpsDisp = dispinterface;
  IADsNamespaces = interface;
  IADsNamespacesDisp = dispinterface;
  IADsClass = interface;
  IADsClassDisp = dispinterface;
  IADsProperty = interface;
  IADsPropertyDisp = dispinterface;
  IADsSyntax = interface;
  IADsSyntaxDisp = dispinterface;
  IADsLocality = interface;
  IADsLocalityDisp = dispinterface;
  IADsO = interface;
  IADsODisp = dispinterface;
  IADsOU = interface;
  IADsOUDisp = dispinterface;
  IADsDomain = interface;
  IADsDomainDisp = dispinterface;
  IADsComputer = interface;
  IADsComputerDisp = dispinterface;
  IADsComputerOperations = interface;
  IADsComputerOperationsDisp = dispinterface;
  IADsGroup = interface;
  IADsGroupDisp = dispinterface;
  IADsUser = interface;
  IADsUserDisp = dispinterface;
  IADsPrintQueue = interface;
  IADsPrintQueueDisp = dispinterface;
  IADsPrintQueueOperations = interface;
  IADsPrintQueueOperationsDisp = dispinterface;
  IADsPrintJob = interface;
  IADsPrintJobDisp = dispinterface;
  IADsPrintJobOperations = interface;
  IADsPrintJobOperationsDisp = dispinterface;
  IADsService = interface;
  IADsServiceDisp = dispinterface;
  IADsServiceOperations = interface;
  IADsServiceOperationsDisp = dispinterface;
  IADsFileService = interface;
  IADsFileServiceDisp = dispinterface;
  IADsFileServiceOperations = interface;
  IADsFileServiceOperationsDisp = dispinterface;
  IADsFileShare = interface;
  IADsFileShareDisp = dispinterface;
  IADsSession = interface;
  IADsSessionDisp = dispinterface;
  IADsResource = interface;
  IADsResourceDisp = dispinterface;
  IADsOpenDSObject = interface;
  IADsOpenDSObjectDisp = dispinterface;
  IDirectoryObject = interface;
  IDirectorySearch = interface;
  IDirectorySchemaMgmt = interface;
  IADsAggregatee = interface;
  IADsAggregator = interface;
  IADsAccessControlEntry = interface;
  IADsAccessControlEntryDisp = dispinterface;
  IADsAccessControlList = interface;
  IADsAccessControlListDisp = dispinterface;
  IADsSecurityDescriptor = interface;
  IADsSecurityDescriptorDisp = dispinterface;
  IADsLargeInteger = interface;
  IADsLargeIntegerDisp = dispinterface;
  IADsNameTranslate = interface;
  IADsNameTranslateDisp = dispinterface;
  IADsCaseIgnoreList = interface;
  IADsCaseIgnoreListDisp = dispinterface;
  IADsFaxNumber = interface;
  IADsFaxNumberDisp = dispinterface;
  IADsNetAddress = interface;
  IADsNetAddressDisp = dispinterface;
  IADsOctetList = interface;
  IADsOctetListDisp = dispinterface;
  IADsEmail = interface;
  IADsEmailDisp = dispinterface;
  IADsPath = interface;
  IADsPathDisp = dispinterface;
  IADsReplicaPointer = interface;
  IADsReplicaPointerDisp = dispinterface;
  IADsAcl = interface;
  IADsAclDisp = dispinterface;
  IADsTimestamp = interface;
  IADsTimestampDisp = dispinterface;
  IADsPostalAddress = interface;
  IADsPostalAddressDisp = dispinterface;
  IADsBackLink = interface;
  IADsBackLinkDisp = dispinterface;
  IADsTypedName = interface;
  IADsTypedNameDisp = dispinterface;
  IADsHold = interface;
  IADsHoldDisp = dispinterface;
  IADsObjectOptions = interface;
  IADsObjectOptionsDisp = dispinterface;
  IADsPathname = interface;
  IADsPathnameDisp = dispinterface;
  IADsADSystemInfo = interface;
  IADsADSystemInfoDisp = dispinterface;
  IADsWinNTSystemInfo = interface;
  IADsWinNTSystemInfoDisp = dispinterface;
  IADsDNWithBinary = interface;
  IADsDNWithBinaryDisp = dispinterface;
  IADsDNWithString = interface;
  IADsDNWithStringDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  PropertyEntry = IADsPropertyEntry;
  PropertyValue = IADsPropertyValue;
  AccessControlEntry = IADsAccessControlEntry;
  AccessControlList = IADsAccessControlList;
  SecurityDescriptor = IADsSecurityDescriptor;
  LargeInteger = IADsLargeInteger;
  NameTranslate = IADsNameTranslate;
  CaseIgnoreList = IADsCaseIgnoreList;
  FaxNumber = IADsFaxNumber;
  NetAddress = IADsNetAddress;
  OctetList = IADsOctetList;
  Email = IADsEmail;
  Path = IADsPath;
  ReplicaPointer = IADsReplicaPointer;
  Acl = IADsAcl;
  Timestamp = IADsTimestamp;
  PostalAddress = IADsPostalAddress;
  BackLink = IADsBackLink;
  TypedName = IADsTypedName;
  Hold = IADsHold;
  Pathname = IADsPathname;
  ADSystemInfo = IADsADSystemInfo;
  WinNTSystemInfo = IADsWinNTSystemInfo;
  DNWithBinary = IADsDNWithBinary;
  DNWithString = IADsDNWithString;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PUserType1 = ^_ADS_CASEIGNORE_LIST; {*}
  PUserType2 = ^_ADS_OCTET_LIST; {*}
  PPWideChar1 = ^PWideChar; {*}
  PUserType8 = ^tagTYPEDESC; {*}
  PUserType9 = ^tagARRAYDESC; {*}
  PUserType3 = ^TGUID; {*}
  PWord1 = ^Word; {*}
  PPWord1 = ^PWord1; {*}
  PUserType4 = ^TGUID; {*}
  PUserType5 = ^tagTYPEATTR; {*}
  PUserType6 = ^tagFUNCDESC; {*}
  PUserType7 = ^tagVARDESC; {*}
  PUserType10 = ^tagTLIBATTR; {*}
  PUserType11 = ^_ads_object_info; {*}
  PUserType12 = ^_ads_attr_info; {*}
  PUserType13 = ^ads_searchpref_info; {*}
  PUserType14 = ^ads_search_column; {*}
  PUserType15 = ^_ads_attr_def; {*}
  PPUserType1 = ^PUserType15; {*}
  PUINT1 = ^LongWord; {*}
  PUserType16 = ^_ads_class_def; {*}
  PPUserType2 = ^PUserType16; {*}

  ADSTYPEENUM = __MIDL___MIDL_itf_ads_0000_0001; 

  __MIDL___MIDL_itf_ads_0000_0002 = packed record
    dwLength: LongWord;
    lpValue: ^Byte;
  end;

  ADS_OCTET_STRING = __MIDL___MIDL_itf_ads_0000_0002; 

  __MIDL___MIDL_itf_ads_0000_0003 = packed record
    dwLength: LongWord;
    lpValue: ^Byte;
  end;

  ADS_NT_SECURITY_DESCRIPTOR = __MIDL___MIDL_itf_ads_0000_0003; 

  {$EXTERNALSYM _SYSTEMTIME}
  _SYSTEMTIME = packed record
    wYear: Word;
    wMonth: Word;
    wDayOfWeek: Word;
    wDay: Word;
    wHour: Word;
    wMinute: Word;
    wSecond: Word;
    wMilliseconds: Word;
  end;

  _LARGE_INTEGER = packed record
    QuadPart: Int64;
  end;

  __MIDL___MIDL_itf_ads_0000_0004 = packed record
    dwLength: LongWord;
    lpValue: ^Byte;
  end;

  ADS_PROV_SPECIFIC = __MIDL___MIDL_itf_ads_0000_0004; 

  __MIDL___MIDL_itf_ads_0000_0005 = packed record
    Type_: LongWord;
    VolumeName: PWideChar;
    Path: PWideChar;
  end;

  ADS_PATH = __MIDL___MIDL_itf_ads_0000_0005; 

  __MIDL___MIDL_itf_ads_0000_0006 = packed record
    PostalAddress: array[0..5] of PWideChar;
  end;

  ADS_POSTALADDRESS = __MIDL___MIDL_itf_ads_0000_0006; 

  __MIDL___MIDL_itf_ads_0000_0007 = packed record
    WholeSeconds: LongWord;
    EventID: LongWord;
  end;

  ADS_TIMESTAMP = __MIDL___MIDL_itf_ads_0000_0007; 

  __MIDL___MIDL_itf_ads_0000_0008 = packed record
    RemoteID: LongWord;
    ObjectName: PWideChar;
  end;

  ADS_BACKLINK = __MIDL___MIDL_itf_ads_0000_0008; 

  __MIDL___MIDL_itf_ads_0000_0009 = packed record
    ObjectName: PWideChar;
    Level: LongWord;
    Interval: LongWord;
  end;

  ADS_TYPEDNAME = __MIDL___MIDL_itf_ads_0000_0009; 

  __MIDL___MIDL_itf_ads_0000_0010 = packed record
    ObjectName: PWideChar;
    Amount: LongWord;
  end;

  ADS_HOLD = __MIDL___MIDL_itf_ads_0000_0010; 

  __MIDL___MIDL_itf_ads_0000_0011 = packed record
    AddressType: LongWord;
    AddressLength: LongWord;
    Address: ^Byte;
  end;

  ADS_NETADDRESS = __MIDL___MIDL_itf_ads_0000_0011; 

  __MIDL___MIDL_itf_ads_0000_0012 = packed record
    ServerName: PWideChar;
    ReplicaType: LongWord;
    ReplicaNumber: LongWord;
    Count: LongWord;
    ReplicaAddressHints: ^__MIDL___MIDL_itf_ads_0000_0011;
  end;

  ADS_REPLICAPOINTER = __MIDL___MIDL_itf_ads_0000_0012; 

  __MIDL___MIDL_itf_ads_0000_0013 = packed record
    TelephoneNumber: PWideChar;
    NumberOfBits: LongWord;
    Parameters: ^Byte;
  end;

  ADS_FAXNUMBER = __MIDL___MIDL_itf_ads_0000_0013; 

  __MIDL___MIDL_itf_ads_0000_0014 = packed record
    Address: PWideChar;
    Type_: LongWord;
  end;

  ADS_EMAIL = __MIDL___MIDL_itf_ads_0000_0014; 

  __MIDL___MIDL_itf_ads_0000_0015 = packed record
    dwLength: LongWord;
    lpBinaryValue: ^Byte;
    pszDNString: PWideChar;
  end;

  ADS_DN_WITH_BINARY = __MIDL___MIDL_itf_ads_0000_0015; 

  __MIDL___MIDL_itf_ads_0000_0016 = packed record
    pszStringValue: PWideChar;
    pszDNString: PWideChar;
  end;

  ADS_DN_WITH_STRING = __MIDL___MIDL_itf_ads_0000_0016; 

  _ADS_CASEIGNORE_LIST = packed record
    Next: PUserType1;
    String_: PWideChar;
  end;

  _ADS_OCTET_LIST = packed record
    Next: PUserType2;
    Length: LongWord;
    Data: ^Byte;
  end;

  __MIDL___MIDL_itf_ads_0000_0017 = record
    case Integer of
      0: (DNString: PWideChar);
      1: (CaseExactString: PWideChar);
      2: (CaseIgnoreString: PWideChar);
      3: (PrintableString: PWideChar);
      4: (NumericString: PWideChar);
      5: (Boolean: LongWord);
      6: (Integer: LongWord);
      7: (OctetString: ADS_OCTET_STRING);
      8: (UTCTime: _SYSTEMTIME);
      9: (LargeInteger: _LARGE_INTEGER);
      10: (ClassName: PWideChar);
      11: (ProviderSpecific: ADS_PROV_SPECIFIC);
      12: (pCaseIgnoreList: ^_ADS_CASEIGNORE_LIST);
      13: (pOctetList: ^_ADS_OCTET_LIST);
      14: (pPath: ^__MIDL___MIDL_itf_ads_0000_0005);
      15: (pPostalAddress: ^__MIDL___MIDL_itf_ads_0000_0006);
      16: (Timestamp: ADS_TIMESTAMP);
      17: (BackLink: ADS_BACKLINK);
      18: (pTypedName: ^__MIDL___MIDL_itf_ads_0000_0009);
      19: (Hold: ADS_HOLD);
      20: (pNetAddress: ^__MIDL___MIDL_itf_ads_0000_0011);
      21: (pReplicaPointer: ^__MIDL___MIDL_itf_ads_0000_0012);
      22: (pFaxNumber: ^__MIDL___MIDL_itf_ads_0000_0013);
      23: (Email: ADS_EMAIL);
      24: (SecurityDescriptor: ADS_NT_SECURITY_DESCRIPTOR);
      25: (pDNWithBinary: ^__MIDL___MIDL_itf_ads_0000_0015);
      26: (pDNWithString: ^__MIDL___MIDL_itf_ads_0000_0016);
  end;

  ADS_AUTHENTICATION_ENUM = __MIDL___MIDL_itf_ads_0000_0018; 

  _ads_object_info = packed record
    pszRDN: PWideChar;
    pszObjectDN: PWideChar;
    pszParentDN: PWideChar;
    pszSchemaDN: PWideChar;
    pszClassName: PWideChar;
  end;

  ADS_STATUSENUM = __MIDL___MIDL_itf_ads_0000_0019; 
  ADS_DEREFENUM = __MIDL___MIDL_itf_ads_0000_0020; 
  ADS_SCOPEENUM = __MIDL___MIDL_itf_ads_0000_0021; 
  ADS_PREFERENCES_ENUM = __MIDL___MIDL_itf_ads_0000_0022; 
  ADSI_DIALECT_ENUM = __MIDL___MIDL_itf_ads_0000_0023; 
  ADS_CHASE_REFERRALS_ENUM = __MIDL___MIDL_itf_ads_0000_0024; 
  ADS_SEARCHPREF_ENUM = __MIDL___MIDL_itf_ads_0000_0025; 

  _adsvalue = packed record
    dwType: ADSTYPEENUM;
    __MIDL_0010: __MIDL___MIDL_itf_ads_0000_0017;
  end;

  ads_search_column = packed record
    pszAttrName: PWideChar;
    dwADsType: ADSTYPEENUM;
    pADsValues: ^_adsvalue;
    dwNumValues: LongWord;
    hReserved: Pointer;
  end;

  _ads_attr_def = packed record
    pszAttrName: PWideChar;
    dwADsType: ADSTYPEENUM;
    dwMinRange: LongWord;
    dwMaxRange: LongWord;
    fMultiValued: Integer;
  end;


  _ads_sortkey = packed record
    pszAttrType: PWideChar;
    pszReserved: PWideChar;
    fReverseorder: Shortint;
  end;

  ADS_PROPERTY_OPERATION_ENUM = __MIDL___MIDL_itf_ads_0000_0026; 

  __MIDL_IOleAutomationTypes_0005 = record
    case Integer of
      0: (lptdesc: PUserType8);
      1: (lpadesc: PUserType9);
      2: (hreftype: LongWord);
  end;

  tagTYPEDESC = packed record
    __MIDL_0008: __MIDL_IOleAutomationTypes_0005;
    vt: Word;
  end;

  tagSAFEARRAYBOUND = packed record
    cElements: LongWord;
    lLbound: Integer;
  end;

//  ULONG_PTR = LongWord;

  tagIDLDESC = packed record
//    dwReserved: ULONG_PTR;
    dwReserved: LongWord;
    wIDLFlags: Word;
  end;

  tagPARAMDESCEX = packed record
    cBytes: LongWord;
    varDefaultValue: OleVariant;
  end;

  tagPARAMDESC = packed record
    pparamdescex: ^tagPARAMDESCEX;
    wParamFlags: Word;
  end;

  tagELEMDESC = packed record
    tdesc: tagTYPEDESC;
    paramdesc: tagPARAMDESC;
  end;

  tagFUNCDESC = packed record
    memid: Integer;
    lprgscode: ^SCODE;
    lprgelemdescParam: ^tagELEMDESC;
    funckind: tagFUNCKIND;
    invkind: tagINVOKEKIND;
    callconv: tagCALLCONV;
    cParams: Smallint;
    cParamsOpt: Smallint;
    oVft: Smallint;
    cScodes: Smallint;
    elemdescFunc: tagELEMDESC;
    wFuncFlags: Word;
  end;

  __MIDL_IOleAutomationTypes_0006 = record
    case Integer of
      0: (oInst: LongWord);
      1: (lpvarValue: ^OleVariant);
  end;

  tagVARDESC = packed record
    memid: Integer;
    lpstrSchema: PWideChar;
    __MIDL_0009: __MIDL_IOleAutomationTypes_0006;
    elemdescVar: tagELEMDESC;
    wVarFlags: Word;
    varkind: tagVARKIND;
  end;

  tagTLIBATTR = packed record
    GUID: TGUID;
    lcid: LongWord;
    syskind: tagSYSKIND;
    wMajorVerNum: Word;
    wMinorVerNum: Word;
    wLibFlags: Word;
  end;

  ADS_SYSTEMFLAG_ENUM = __MIDL___MIDL_itf_ads_0120_0001; 
  ADS_GROUP_TYPE_ENUM = __MIDL___MIDL_itf_ads_0126_0001; 
  ADS_RIGHTS_ENUM = __MIDL___MIDL_itf_ads_0148_0001; 
  ADS_ACETYPE_ENUM = __MIDL___MIDL_itf_ads_0148_0002; 
  ADS_ACEFLAG_ENUM = __MIDL___MIDL_itf_ads_0148_0003; 
  ADS_FLAGTYPE_ENUM = __MIDL___MIDL_itf_ads_0148_0004; 
  ADS_SD_CONTROL_ENUM = __MIDL___MIDL_itf_ads_0148_0005; 
  ADS_SD_REVISION_ENUM = __MIDL___MIDL_itf_ads_0148_0006; 
  ADS_NAME_TYPE_ENUM = __MIDL___MIDL_itf_ads_0149_0001; 
  ADS_NAME_INITTYPE_ENUM = __MIDL___MIDL_itf_ads_0149_0002; 
  ADS_OPTION_ENUM = __MIDL___MIDL_itf_ads_0163_0001; 
  ADS_SECURITY_INFO_ENUM = __MIDL___MIDL_itf_ads_0163_0002; 
  ADS_SETTYPE_ENUM = __MIDL___MIDL_itf_ads_0164_0001; 
  ADS_FORMAT_ENUM = __MIDL___MIDL_itf_ads_0164_0002; 
  ADS_DISPLAY_ENUM = __MIDL___MIDL_itf_ads_0164_0003; 
  ADS_ESCAPE_MODE_ENUM = __MIDL___MIDL_itf_ads_0164_0004; 

  _ads_attr_info = packed record
    pszAttrName: PWideChar;
    dwControlCode: LongWord;
    dwADsType: ADSTYPEENUM;
    pADsValues: ^_adsvalue;
    dwNumValues: LongWord;
  end;

  ads_searchpref_info = packed record
    dwSearchPref: ADS_SEARCHPREF_ENUM;
    vValue: _adsvalue;
    dwStatus: ADS_STATUSENUM;
  end;

  _ads_class_def = packed record
    pszClassName: PWideChar;
    dwMandatoryAttrs: LongWord;
    ppszMandatoryAttrs: ^PWideChar;
    optionalAttrs: LongWord;
    ppszOptionalAttrs: ^PPWideChar1;
    dwNamingAttrs: LongWord;
    ppszNamingAttrs: ^PPWideChar1;
    dwSuperClasses: LongWord;
    ppszSuperClasses: ^PPWideChar1;
    fIsContainer: Integer;
  end;


  tagTYPEATTR = packed record
    GUID: TGUID;
    lcid: LongWord;
    dwReserved: LongWord;
    memidConstructor: Integer;
    memidDestructor: Integer;
    lpstrSchema: PWideChar;
    cbSizeInstance: LongWord;
    typekind: tagTYPEKIND;
    cFuncs: Word;
    cVars: Word;
    cImplTypes: Word;
    cbSizeVft: Word;
    cbAlignment: Word;
    wTypeFlags: Word;
    wMajorVerNum: Word;
    wMinorVerNum: Word;
    tdescAlias: tagTYPEDESC;
    idldescType: tagIDLDESC;
  end;

  tagARRAYDESC = packed record
    tdescElem: tagTYPEDESC;
    cDims: Word;
    rgbounds: ^tagSAFEARRAYBOUND;
  end;


// *********************************************************************//
// Interface: IADs
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FD8256D0-FD15-11CE-ABC4-02608C9E7553}
// *********************************************************************//
  IADs = interface(IDispatch)
    ['{FD8256D0-FD15-11CE-ABC4-02608C9E7553}']
    function  Get_Name(out retval: WideString): HResult; stdcall;
    function  Get_Class_(out retval: WideString): HResult; stdcall;
    function  Get_GUID(out retval: WideString): HResult; stdcall;
    function  Get_ADsPath(out retval: WideString): HResult; stdcall;
    function  Get_Parent(out retval: WideString): HResult; stdcall;
    function  Get_Schema(out retval: WideString): HResult; stdcall;
    function  GetInfo: HResult; stdcall;
    function  SetInfo: HResult; stdcall;
    function  Get(const bstrName: WideString; out pvProp: OleVariant): HResult; stdcall;
    function  Put(const bstrName: WideString; vProp: OleVariant): HResult; stdcall;
    function  GetEx(const bstrName: WideString; out pvProp: OleVariant): HResult; stdcall;
    function  PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant): HResult; stdcall;
    function  GetInfoEx(vProperties: OleVariant; lnReserved: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FD8256D0-FD15-11CE-ABC4-02608C9E7553}
// *********************************************************************//
  IADsDisp = dispinterface
    ['{FD8256D0-FD15-11CE-ABC4-02608C9E7553}']
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsContainer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {001677D0-FD16-11CE-ABC4-02608C9E7553}
// *********************************************************************//
  IADsContainer = interface(IDispatch)
    ['{001677D0-FD16-11CE-ABC4-02608C9E7553}']
    function  Get_Count(out retval: Integer): HResult; stdcall;
    function  Get__NewEnum(out retval: IUnknown): HResult; stdcall;
    function  Get_Filter(out pVar: OleVariant): HResult; stdcall;
    function  Set_Filter(pVar: OleVariant): HResult; stdcall;
    function  Get_Hints(out pvFilter: OleVariant): HResult; stdcall;
    function  Set_Hints(pvFilter: OleVariant): HResult; stdcall;
    function  GetObject(const ClassName: WideString; const RelativeName: WideString; 
                        out ppObject: IDispatch): HResult; stdcall;
    function  Create(const ClassName: WideString; const RelativeName: WideString; 
                     out ppObject: IDispatch): HResult; stdcall;
    function  Delete(const bstrClassName: WideString; const bstrRelativeName: WideString): HResult; stdcall;
    function  CopyHere(const SourceName: WideString; const NewName: WideString; 
                       out ppObject: IDispatch): HResult; stdcall;
    function  MoveHere(const SourceName: WideString; const NewName: WideString; 
                       out ppObject: IDispatch): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsContainerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {001677D0-FD16-11CE-ABC4-02608C9E7553}
// *********************************************************************//
  IADsContainerDisp = dispinterface
    ['{001677D0-FD16-11CE-ABC4-02608C9E7553}']
    property Count: Integer readonly dispid 2;
    property _NewEnum: IUnknown readonly dispid -4;
    function  Filter: OleVariant; dispid 3;
    function  Hints: OleVariant; dispid 4;
    function  GetObject(const ClassName: WideString; const RelativeName: WideString): IDispatch; dispid 5;
    function  Create(const ClassName: WideString; const RelativeName: WideString): IDispatch; dispid 6;
    procedure Delete(const bstrClassName: WideString; const bstrRelativeName: WideString); dispid 7;
    function  CopyHere(const SourceName: WideString; const NewName: WideString): IDispatch; dispid 8;
    function  MoveHere(const SourceName: WideString; const NewName: WideString): IDispatch; dispid 9;
  end;

// *********************************************************************//
// Interface: IADsCollection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {72B945E0-253B-11CF-A988-00AA006BC149}
// *********************************************************************//
  IADsCollection = interface(IDispatch)
    ['{72B945E0-253B-11CF-A988-00AA006BC149}']
    function  Get__NewEnum(out ppEnumerator: IUnknown): HResult; stdcall;
    function  Add(const bstrName: WideString; vItem: OleVariant): HResult; stdcall;
    function  Remove(const bstrItemToBeRemoved: WideString): HResult; stdcall;
    function  GetObject(const bstrName: WideString; out pvItem: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsCollectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {72B945E0-253B-11CF-A988-00AA006BC149}
// *********************************************************************//
  IADsCollectionDisp = dispinterface
    ['{72B945E0-253B-11CF-A988-00AA006BC149}']
    property _NewEnum: IUnknown readonly dispid -4;
    procedure Add(const bstrName: WideString; vItem: OleVariant); dispid 4;
    procedure Remove(const bstrItemToBeRemoved: WideString); dispid 5;
    function  GetObject(const bstrName: WideString): OleVariant; dispid 6;
  end;

// *********************************************************************//
// Interface: IADsMembers
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {451A0030-72EC-11CF-B03B-00AA006E0975}
// *********************************************************************//
  IADsMembers = interface(IDispatch)
    ['{451A0030-72EC-11CF-B03B-00AA006E0975}']
    function  Get_Count(out plCount: Integer): HResult; stdcall;
    function  Get__NewEnum(out ppEnumerator: IUnknown): HResult; stdcall;
    function  Get_Filter(out pvFilter: OleVariant): HResult; stdcall;
    function  Set_Filter(pvFilter: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsMembersDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {451A0030-72EC-11CF-B03B-00AA006E0975}
// *********************************************************************//
  IADsMembersDisp = dispinterface
    ['{451A0030-72EC-11CF-B03B-00AA006E0975}']
    property Count: Integer readonly dispid 2;
    property _NewEnum: IUnknown readonly dispid -4;
    function  Filter: OleVariant; dispid 3;
  end;

// *********************************************************************//
// Interface: IADsPropertyList
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C6F602B6-8F69-11D0-8528-00C04FD8D503}
// *********************************************************************//
  IADsPropertyList = interface(IDispatch)
    ['{C6F602B6-8F69-11D0-8528-00C04FD8D503}']
    function  Get_PropertyCount(out plCount: Integer): HResult; stdcall;
    function  Next(out pVariant: OleVariant): HResult; stdcall;
    function  Skip(cElements: Integer): HResult; stdcall;
    function  Reset: HResult; stdcall;
    function  Item(varIndex: OleVariant; out pVariant: OleVariant): HResult; stdcall;
    function  GetPropertyItem(const bstrName: WideString; lnADsType: Integer; 
                              out pVariant: OleVariant): HResult; stdcall;
    function  PutPropertyItem(varData: OleVariant): HResult; stdcall;
    function  ResetPropertyItem(varEntry: OleVariant): HResult; stdcall;
    function  PurgePropertyList: HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsPropertyListDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C6F602B6-8F69-11D0-8528-00C04FD8D503}
// *********************************************************************//
  IADsPropertyListDisp = dispinterface
    ['{C6F602B6-8F69-11D0-8528-00C04FD8D503}']
    property PropertyCount: Integer readonly dispid 2;
    function  Next: OleVariant; dispid 3;
    procedure Skip(cElements: Integer); dispid 4;
    procedure Reset; dispid 5;
    function  Item(varIndex: OleVariant): OleVariant; dispid 0;
    function  GetPropertyItem(const bstrName: WideString; lnADsType: Integer): OleVariant; dispid 6;
    procedure PutPropertyItem(varData: OleVariant); dispid 7;
    procedure ResetPropertyItem(varEntry: OleVariant); dispid 8;
    procedure PurgePropertyList; dispid 9;
  end;

// *********************************************************************//
// Interface: IADsPropertyEntry
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05792C8E-941F-11D0-8529-00C04FD8D503}
// *********************************************************************//
  IADsPropertyEntry = interface(IDispatch)
    ['{05792C8E-941F-11D0-8529-00C04FD8D503}']
    function  Clear: HResult; stdcall;
    function  Get_Name(out retval: WideString): HResult; stdcall;
    function  Set_Name(const retval: WideString): HResult; stdcall;
    function  Get_ADsType(out retval: Integer): HResult; stdcall;
    function  Set_ADsType(retval: Integer): HResult; stdcall;
    function  Get_ControlCode(out retval: Integer): HResult; stdcall;
    function  Set_ControlCode(retval: Integer): HResult; stdcall;
    function  Get_Values(out retval: OleVariant): HResult; stdcall;
    function  Set_Values(retval: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsPropertyEntryDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {05792C8E-941F-11D0-8529-00C04FD8D503}
// *********************************************************************//
  IADsPropertyEntryDisp = dispinterface
    ['{05792C8E-941F-11D0-8529-00C04FD8D503}']
    procedure Clear; dispid 1;
    function  Name: WideString; dispid 2;
    function  ADsType: Integer; dispid 3;
    function  ControlCode: Integer; dispid 4;
    function  Values: OleVariant; dispid 5;
  end;

// *********************************************************************//
// Interface: IADsPropertyValue
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {79FA9AD0-A97C-11D0-8534-00C04FD8D503}
// *********************************************************************//
  IADsPropertyValue = interface(IDispatch)
    ['{79FA9AD0-A97C-11D0-8534-00C04FD8D503}']
    function  Clear: HResult; stdcall;
    function  Get_ADsType(out retval: Integer): HResult; stdcall;
    function  Set_ADsType(retval: Integer): HResult; stdcall;
    function  Get_DNString(out retval: WideString): HResult; stdcall;
    function  Set_DNString(const retval: WideString): HResult; stdcall;
    function  Get_CaseExactString(out retval: WideString): HResult; stdcall;
    function  Set_CaseExactString(const retval: WideString): HResult; stdcall;
    function  Get_CaseIgnoreString(out retval: WideString): HResult; stdcall;
    function  Set_CaseIgnoreString(const retval: WideString): HResult; stdcall;
    function  Get_PrintableString(out retval: WideString): HResult; stdcall;
    function  Set_PrintableString(const retval: WideString): HResult; stdcall;
    function  Get_NumericString(out retval: WideString): HResult; stdcall;
    function  Set_NumericString(const retval: WideString): HResult; stdcall;
    function  Get_Boolean(out retval: Integer): HResult; stdcall;
    function  Set_Boolean(retval: Integer): HResult; stdcall;
    function  Get_Integer(out retval: Integer): HResult; stdcall;
    function  Set_Integer(retval: Integer): HResult; stdcall;
    function  Get_OctetString(out retval: OleVariant): HResult; stdcall;
    function  Set_OctetString(retval: OleVariant): HResult; stdcall;
    function  Get_SecurityDescriptor(out retval: IDispatch): HResult; stdcall;
    function  Set_SecurityDescriptor(const retval: IDispatch): HResult; stdcall;
    function  Get_LargeInteger(out retval: IDispatch): HResult; stdcall;
    function  Set_LargeInteger(const retval: IDispatch): HResult; stdcall;
    function  Get_UTCTime(out retval: TDateTime): HResult; stdcall;
    function  Set_UTCTime(retval: TDateTime): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsPropertyValueDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {79FA9AD0-A97C-11D0-8534-00C04FD8D503}
// *********************************************************************//
  IADsPropertyValueDisp = dispinterface
    ['{79FA9AD0-A97C-11D0-8534-00C04FD8D503}']
    procedure Clear; dispid 1;
    function  ADsType: Integer; dispid 2;
    function  DNString: WideString; dispid 3;
    function  CaseExactString: WideString; dispid 4;
    function  CaseIgnoreString: WideString; dispid 5;
    function  PrintableString: WideString; dispid 6;
    function  NumericString: WideString; dispid 7;
    function  Boolean: Integer; dispid 8;
    function  Integer: Integer; dispid 9;
    function  OctetString: OleVariant; dispid 10;
    function  SecurityDescriptor: IDispatch; dispid 11;
    function  LargeInteger: IDispatch; dispid 12;
    function  UTCTime: TDateTime; dispid 13;
  end;

// *********************************************************************//
// Interface: IADsPropertyValue2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {306E831C-5BC7-11D1-A3B8-00C04FB950DC}
// *********************************************************************//
  IADsPropertyValue2 = interface(IDispatch)
    ['{306E831C-5BC7-11D1-A3B8-00C04FB950DC}']
    function  GetObjectProperty(var lnADsType: Integer; out pvProp: OleVariant): HResult; stdcall;
    function  PutObjectProperty(lnADsType: Integer; vProp: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsPropertyValue2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {306E831C-5BC7-11D1-A3B8-00C04FB950DC}
// *********************************************************************//
  IADsPropertyValue2Disp = dispinterface
    ['{306E831C-5BC7-11D1-A3B8-00C04FB950DC}']
    function  GetObjectProperty(var lnADsType: Integer): OleVariant; dispid 1;
    procedure PutObjectProperty(lnADsType: Integer; vProp: OleVariant); dispid 2;
  end;

// *********************************************************************//
// Interface: IPrivateDispatch
// Flags:     (0)
// GUID:      {86AB4BBE-65F6-11D1-8C13-00C04FD8D503}
// *********************************************************************//
  IPrivateDispatch = interface(IUnknown)
    ['{86AB4BBE-65F6-11D1-8C13-00C04FD8D503}']
    function  ADSIInitializeDispatchManager(dwExtensionId: Integer): HResult; stdcall;
    function  ADSIGetTypeInfoCount(out pctinfo: SYSUINT): HResult; stdcall;
    function  ADSIGetTypeInfo(itinfo: SYSUINT; lcid: LongWord; out ppTInfo: ITypeInfo): HResult; stdcall;
    function  ADSIGetIDsOfNames(var riid: TGUID; rgszNames: PPWord1; cNames: SYSUINT; 
                                lcid: LongWord; out rgdispid: Integer): HResult; stdcall;
    function  ADSIInvoke(dispidMember: Integer; var riid: TGUID; lcid: LongWord; wFlags: Word; 
                         var pdispparams: TGUID; out pvarResult: OleVariant; out pexcepinfo: TGUID; 
                         out puArgErr: SYSUINT): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITypeInfo
// Flags:     (0)
// GUID:      {00020401-0000-0000-C000-000000000046}
// *********************************************************************//
  ITypeInfo = interface(IUnknown)
    ['{00020401-0000-0000-C000-000000000046}']
    function  RemoteGetTypeAttr(out ppTypeAttr: PUserType5; out pDummy: DWORD): HResult; stdcall;
    function  GetTypeComp(out ppTComp: ITypeComp): HResult; stdcall;
    function  RemoteGetFuncDesc(index: SYSUINT; out ppFuncDesc: PUserType6; out pDummy: DWORD): HResult; stdcall;
    function  RemoteGetVarDesc(index: SYSUINT; out ppVarDesc: PUserType7; out pDummy: DWORD): HResult; stdcall;
    function  RemoteGetNames(memid: Integer; out rgBstrNames: WideString; cMaxNames: SYSUINT; 
                             out pcNames: SYSUINT): HResult; stdcall;
    function  GetRefTypeOfImplType(index: SYSUINT; out pRefType: LongWord): HResult; stdcall;
    function  GetImplTypeFlags(index: SYSUINT; out pImplTypeFlags: SYSINT): HResult; stdcall;
    function  LocalGetIDsOfNames: HResult; stdcall;
    function  LocalInvoke: HResult; stdcall;
    function  RemoteGetDocumentation(memid: Integer; refPtrFlags: LongWord; 
                                     out pBstrName: WideString; out pBstrDocString: WideString; 
                                     out pdwHelpContext: LongWord; out pBstrHelpFile: WideString): HResult; stdcall;
    function  RemoteGetDllEntry(memid: Integer; invkind: tagINVOKEKIND; refPtrFlags: LongWord; 
                                out pBstrDllName: WideString; out pBstrName: WideString; 
                                out pwOrdinal: Word): HResult; stdcall;
    function  GetRefTypeInfo(hreftype: LongWord; out ppTInfo: ITypeInfo): HResult; stdcall;
    function  LocalAddressOfMember: HResult; stdcall;
    function  RemoteCreateInstance(var riid: TGUID; out ppvObj: IUnknown): HResult; stdcall;
    function  GetMops(memid: Integer; out pBstrMops: WideString): HResult; stdcall;
    function  RemoteGetContainingTypeLib(out ppTLib: ITypeLib; out pIndex: SYSUINT): HResult; stdcall;
    function  LocalReleaseTypeAttr: HResult; stdcall;
    function  LocalReleaseFuncDesc: HResult; stdcall;
    function  LocalReleaseVarDesc: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITypeComp
// Flags:     (0)
// GUID:      {00020403-0000-0000-C000-000000000046}
// *********************************************************************//
  ITypeComp = interface(IUnknown)
    ['{00020403-0000-0000-C000-000000000046}']
    function  RemoteBind(szName: PWideChar; lHashVal: LongWord; wFlags: Word; 
                         out ppTInfo: ITypeInfo; out pDescKind: tagDESCKIND; 
                         out ppFuncDesc: PUserType6; out ppVarDesc: PUserType7; 
                         out ppTypeComp: ITypeComp; out pDummy: DWORD): HResult; stdcall;
    function  RemoteBindType(szName: PWideChar; lHashVal: LongWord; out ppTInfo: ITypeInfo): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ITypeLib
// Flags:     (0)
// GUID:      {00020402-0000-0000-C000-000000000046}
// *********************************************************************//
  ITypeLib = interface(IUnknown)
    ['{00020402-0000-0000-C000-000000000046}']
    function  RemoteGetTypeInfoCount(out pctinfo: SYSUINT): HResult; stdcall;
    function  GetTypeInfo(index: SYSUINT; out ppTInfo: ITypeInfo): HResult; stdcall;
    function  GetTypeInfoType(index: SYSUINT; out pTKind: tagTYPEKIND): HResult; stdcall;
    function  GetTypeInfoOfGuid(var GUID: TGUID; out ppTInfo: ITypeInfo): HResult; stdcall;
    function  RemoteGetLibAttr(out ppTLibAttr: PUserType10; out pDummy: DWORD): HResult; stdcall;
    function  GetTypeComp(out ppTComp: ITypeComp): HResult; stdcall;
    function  RemoteGetDocumentation(index: SYSINT; refPtrFlags: LongWord; 
                                     out pBstrName: WideString; out pBstrDocString: WideString; 
                                     out pdwHelpContext: LongWord; out pBstrHelpFile: WideString): HResult; stdcall;
    function  RemoteIsName(szNameBuf: PWideChar; lHashVal: LongWord; out pfName: Integer; 
                           out pBstrLibName: WideString): HResult; stdcall;
    function  RemoteFindName(szNameBuf: PWideChar; lHashVal: LongWord; out ppTInfo: ITypeInfo; 
                             out rgMemId: Integer; var pcFound: Word; out pBstrLibName: WideString): HResult; stdcall;
    function  LocalReleaseTLibAttr: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IPrivateUnknown
// Flags:     (0)
// GUID:      {89126BAB-6EAD-11D1-8C18-00C04FD8D503}
// *********************************************************************//
  IPrivateUnknown = interface(IUnknown)
    ['{89126BAB-6EAD-11D1-8C18-00C04FD8D503}']
    function  ADSIInitializeObject(const lpszUserName: WideString; const lpszPassword: WideString; 
                                   lnReserved: Integer): HResult; stdcall;
    function  ADSIReleaseObject: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IADsExtension
// Flags:     (0)
// GUID:      {3D35553C-D2B0-11D1-B17B-0000F87593A0}
// *********************************************************************//
  IADsExtension = interface(IUnknown)
    ['{3D35553C-D2B0-11D1-B17B-0000F87593A0}']
    function  Operate(dwCode: LongWord; varData1: OleVariant; varData2: OleVariant; 
                      varData3: OleVariant): HResult; stdcall;
    function  PrivateGetIDsOfNames(var riid: TGUID; rgszNames: PPWord1; cNames: SYSUINT; 
                                   lcid: LongWord; out rgdispid: Integer): HResult; stdcall;
    function  PrivateInvoke(dispidMember: Integer; var riid: TGUID; lcid: LongWord; wFlags: Word; 
                            var pdispparams: TGUID; out pvarResult: OleVariant; 
                            out pexcepinfo: TGUID; out puArgErr: SYSUINT): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IADsDeleteOps
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B2BD0902-8878-11D1-8C21-00C04FD8D503}
// *********************************************************************//
  IADsDeleteOps = interface(IDispatch)
    ['{B2BD0902-8878-11D1-8C21-00C04FD8D503}']
    function  DeleteObject(lnFlags: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsDeleteOpsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B2BD0902-8878-11D1-8C21-00C04FD8D503}
// *********************************************************************//
  IADsDeleteOpsDisp = dispinterface
    ['{B2BD0902-8878-11D1-8C21-00C04FD8D503}']
    procedure DeleteObject(lnFlags: Integer); dispid 2;
  end;

// *********************************************************************//
// Interface: IADsNamespaces
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {28B96BA0-B330-11CF-A9AD-00AA006BC149}
// *********************************************************************//
  IADsNamespaces = interface(IADs)
    ['{28B96BA0-B330-11CF-A9AD-00AA006BC149}']
    function  Get_DefaultContainer(out retval: WideString): HResult; stdcall;
    function  Set_DefaultContainer(const retval: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsNamespacesDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {28B96BA0-B330-11CF-A9AD-00AA006BC149}
// *********************************************************************//
  IADsNamespacesDisp = dispinterface
    ['{28B96BA0-B330-11CF-A9AD-00AA006BC149}']
    function  DefaultContainer: WideString; dispid 1;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsClass
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C8F93DD0-4AE0-11CF-9E73-00AA004A5691}
// *********************************************************************//
  IADsClass = interface(IADs)
    ['{C8F93DD0-4AE0-11CF-9E73-00AA004A5691}']
    function  Get_PrimaryInterface(out retval: WideString): HResult; stdcall;
    function  Get_CLSID(out retval: WideString): HResult; stdcall;
    function  Set_CLSID(const retval: WideString): HResult; stdcall;
    function  Get_OID(out retval: WideString): HResult; stdcall;
    function  Set_OID(const retval: WideString): HResult; stdcall;
    function  Get_Abstract(out retval: WordBool): HResult; stdcall;
    function  Set_Abstract(retval: WordBool): HResult; stdcall;
    function  Get_Auxiliary(out retval: WordBool): HResult; stdcall;
    function  Set_Auxiliary(retval: WordBool): HResult; stdcall;
    function  Get_MandatoryProperties(out retval: OleVariant): HResult; stdcall;
    function  Set_MandatoryProperties(retval: OleVariant): HResult; stdcall;
    function  Get_OptionalProperties(out retval: OleVariant): HResult; stdcall;
    function  Set_OptionalProperties(retval: OleVariant): HResult; stdcall;
    function  Get_NamingProperties(out retval: OleVariant): HResult; stdcall;
    function  Set_NamingProperties(retval: OleVariant): HResult; stdcall;
    function  Get_DerivedFrom(out retval: OleVariant): HResult; stdcall;
    function  Set_DerivedFrom(retval: OleVariant): HResult; stdcall;
    function  Get_AuxDerivedFrom(out retval: OleVariant): HResult; stdcall;
    function  Set_AuxDerivedFrom(retval: OleVariant): HResult; stdcall;
    function  Get_PossibleSuperiors(out retval: OleVariant): HResult; stdcall;
    function  Set_PossibleSuperiors(retval: OleVariant): HResult; stdcall;
    function  Get_Containment(out retval: OleVariant): HResult; stdcall;
    function  Set_Containment(retval: OleVariant): HResult; stdcall;
    function  Get_Container(out retval: WordBool): HResult; stdcall;
    function  Set_Container(retval: WordBool): HResult; stdcall;
    function  Get_HelpFileName(out retval: WideString): HResult; stdcall;
    function  Set_HelpFileName(const retval: WideString): HResult; stdcall;
    function  Get_HelpFileContext(out retval: Integer): HResult; stdcall;
    function  Set_HelpFileContext(retval: Integer): HResult; stdcall;
    function  Qualifiers(out ppQualifiers: IADsCollection): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsClassDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C8F93DD0-4AE0-11CF-9E73-00AA004A5691}
// *********************************************************************//
  IADsClassDisp = dispinterface
    ['{C8F93DD0-4AE0-11CF-9E73-00AA004A5691}']
    property PrimaryInterface: WideString readonly dispid 15;
    function  CLSID: WideString; dispid 16;
    function  OID: WideString; dispid 17;
    function  Abstract: WordBool; dispid 18;
    function  Auxiliary: WordBool; dispid 26;
    function  MandatoryProperties: OleVariant; dispid 19;
    function  OptionalProperties: OleVariant; dispid 29;
    function  NamingProperties: OleVariant; dispid 30;
    function  DerivedFrom: OleVariant; dispid 20;
    function  AuxDerivedFrom: OleVariant; dispid 27;
    function  PossibleSuperiors: OleVariant; dispid 28;
    function  Containment: OleVariant; dispid 21;
    function  Container: WordBool; dispid 22;
    function  HelpFileName: WideString; dispid 23;
    function  HelpFileContext: Integer; dispid 24;
    function  Qualifiers: IADsCollection; dispid 25;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsProperty
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C8F93DD3-4AE0-11CF-9E73-00AA004A5691}
// *********************************************************************//
  IADsProperty = interface(IADs)
    ['{C8F93DD3-4AE0-11CF-9E73-00AA004A5691}']
    function  Get_OID(out retval: WideString): HResult; stdcall;
    function  Set_OID(const retval: WideString): HResult; stdcall;
    function  Get_Syntax(out retval: WideString): HResult; stdcall;
    function  Set_Syntax(const retval: WideString): HResult; stdcall;
    function  Get_MaxRange(out retval: Integer): HResult; stdcall;
    function  Set_MaxRange(retval: Integer): HResult; stdcall;
    function  Get_MinRange(out retval: Integer): HResult; stdcall;
    function  Set_MinRange(retval: Integer): HResult; stdcall;
    function  Get_MultiValued(out retval: WordBool): HResult; stdcall;
    function  Set_MultiValued(retval: WordBool): HResult; stdcall;
    function  Qualifiers(out ppQualifiers: IADsCollection): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsPropertyDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C8F93DD3-4AE0-11CF-9E73-00AA004A5691}
// *********************************************************************//
  IADsPropertyDisp = dispinterface
    ['{C8F93DD3-4AE0-11CF-9E73-00AA004A5691}']
    function  OID: WideString; dispid 17;
    function  Syntax: WideString; dispid 18;
    function  MaxRange: Integer; dispid 19;
    function  MinRange: Integer; dispid 20;
    function  MultiValued: WordBool; dispid 21;
    function  Qualifiers: IADsCollection; dispid 22;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsSyntax
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C8F93DD2-4AE0-11CF-9E73-00AA004A5691}
// *********************************************************************//
  IADsSyntax = interface(IADs)
    ['{C8F93DD2-4AE0-11CF-9E73-00AA004A5691}']
    function  Get_OleAutoDataType(out retval: Integer): HResult; stdcall;
    function  Set_OleAutoDataType(retval: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsSyntaxDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C8F93DD2-4AE0-11CF-9E73-00AA004A5691}
// *********************************************************************//
  IADsSyntaxDisp = dispinterface
    ['{C8F93DD2-4AE0-11CF-9E73-00AA004A5691}']
    function  OleAutoDataType: Integer; dispid 15;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsLocality
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A05E03A2-EFFE-11CF-8ABC-00C04FD8D503}
// *********************************************************************//
  IADsLocality = interface(IADs)
    ['{A05E03A2-EFFE-11CF-8ABC-00C04FD8D503}']
    function  Get_Description(out retval: WideString): HResult; stdcall;
    function  Set_Description(const retval: WideString): HResult; stdcall;
    function  Get_LocalityName(out retval: WideString): HResult; stdcall;
    function  Set_LocalityName(const retval: WideString): HResult; stdcall;
    function  Get_PostalAddress(out retval: WideString): HResult; stdcall;
    function  Set_PostalAddress(const retval: WideString): HResult; stdcall;
    function  Get_SeeAlso(out retval: OleVariant): HResult; stdcall;
    function  Set_SeeAlso(retval: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsLocalityDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A05E03A2-EFFE-11CF-8ABC-00C04FD8D503}
// *********************************************************************//
  IADsLocalityDisp = dispinterface
    ['{A05E03A2-EFFE-11CF-8ABC-00C04FD8D503}']
    function  Description: WideString; dispid 15;
    function  LocalityName: WideString; dispid 16;
    function  PostalAddress: WideString; dispid 17;
    function  SeeAlso: OleVariant; dispid 18;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsO
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A1CD2DC6-EFFE-11CF-8ABC-00C04FD8D503}
// *********************************************************************//
  IADsO = interface(IADs)
    ['{A1CD2DC6-EFFE-11CF-8ABC-00C04FD8D503}']
    function  Get_Description(out retval: WideString): HResult; stdcall;
    function  Set_Description(const retval: WideString): HResult; stdcall;
    function  Get_LocalityName(out retval: WideString): HResult; stdcall;
    function  Set_LocalityName(const retval: WideString): HResult; stdcall;
    function  Get_PostalAddress(out retval: WideString): HResult; stdcall;
    function  Set_PostalAddress(const retval: WideString): HResult; stdcall;
    function  Get_TelephoneNumber(out retval: WideString): HResult; stdcall;
    function  Set_TelephoneNumber(const retval: WideString): HResult; stdcall;
    function  Get_FaxNumber(out retval: WideString): HResult; stdcall;
    function  Set_FaxNumber(const retval: WideString): HResult; stdcall;
    function  Get_SeeAlso(out retval: OleVariant): HResult; stdcall;
    function  Set_SeeAlso(retval: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsODisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A1CD2DC6-EFFE-11CF-8ABC-00C04FD8D503}
// *********************************************************************//
  IADsODisp = dispinterface
    ['{A1CD2DC6-EFFE-11CF-8ABC-00C04FD8D503}']
    function  Description: WideString; dispid 15;
    function  LocalityName: WideString; dispid 16;
    function  PostalAddress: WideString; dispid 17;
    function  TelephoneNumber: WideString; dispid 18;
    function  FaxNumber: WideString; dispid 19;
    function  SeeAlso: OleVariant; dispid 20;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsOU
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A2F733B8-EFFE-11CF-8ABC-00C04FD8D503}
// *********************************************************************//
  IADsOU = interface(IADs)
    ['{A2F733B8-EFFE-11CF-8ABC-00C04FD8D503}']
    function  Get_Description(out retval: WideString): HResult; stdcall;
    function  Set_Description(const retval: WideString): HResult; stdcall;
    function  Get_LocalityName(out retval: WideString): HResult; stdcall;
    function  Set_LocalityName(const retval: WideString): HResult; stdcall;
    function  Get_PostalAddress(out retval: WideString): HResult; stdcall;
    function  Set_PostalAddress(const retval: WideString): HResult; stdcall;
    function  Get_TelephoneNumber(out retval: WideString): HResult; stdcall;
    function  Set_TelephoneNumber(const retval: WideString): HResult; stdcall;
    function  Get_FaxNumber(out retval: WideString): HResult; stdcall;
    function  Set_FaxNumber(const retval: WideString): HResult; stdcall;
    function  Get_SeeAlso(out retval: OleVariant): HResult; stdcall;
    function  Set_SeeAlso(retval: OleVariant): HResult; stdcall;
    function  Get_BusinessCategory(out retval: WideString): HResult; stdcall;
    function  Set_BusinessCategory(const retval: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsOUDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A2F733B8-EFFE-11CF-8ABC-00C04FD8D503}
// *********************************************************************//
  IADsOUDisp = dispinterface
    ['{A2F733B8-EFFE-11CF-8ABC-00C04FD8D503}']
    function  Description: WideString; dispid 15;
    function  LocalityName: WideString; dispid 16;
    function  PostalAddress: WideString; dispid 17;
    function  TelephoneNumber: WideString; dispid 18;
    function  FaxNumber: WideString; dispid 19;
    function  SeeAlso: OleVariant; dispid 20;
    function  BusinessCategory: WideString; dispid 21;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsDomain
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {00E4C220-FD16-11CE-ABC4-02608C9E7553}
// *********************************************************************//
  IADsDomain = interface(IADs)
    ['{00E4C220-FD16-11CE-ABC4-02608C9E7553}']
    function  Get_IsWorkgroup(out retval: WordBool): HResult; stdcall;
    function  Get_MinPasswordLength(out retval: Integer): HResult; stdcall;
    function  Set_MinPasswordLength(retval: Integer): HResult; stdcall;
    function  Get_MinPasswordAge(out retval: Integer): HResult; stdcall;
    function  Set_MinPasswordAge(retval: Integer): HResult; stdcall;
    function  Get_MaxPasswordAge(out retval: Integer): HResult; stdcall;
    function  Set_MaxPasswordAge(retval: Integer): HResult; stdcall;
    function  Get_MaxBadPasswordsAllowed(out retval: Integer): HResult; stdcall;
    function  Set_MaxBadPasswordsAllowed(retval: Integer): HResult; stdcall;
    function  Get_PasswordHistoryLength(out retval: Integer): HResult; stdcall;
    function  Set_PasswordHistoryLength(retval: Integer): HResult; stdcall;
    function  Get_PasswordAttributes(out retval: Integer): HResult; stdcall;
    function  Set_PasswordAttributes(retval: Integer): HResult; stdcall;
    function  Get_AutoUnlockInterval(out retval: Integer): HResult; stdcall;
    function  Set_AutoUnlockInterval(retval: Integer): HResult; stdcall;
    function  Get_LockoutObservationInterval(out retval: Integer): HResult; stdcall;
    function  Set_LockoutObservationInterval(retval: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsDomainDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {00E4C220-FD16-11CE-ABC4-02608C9E7553}
// *********************************************************************//
  IADsDomainDisp = dispinterface
    ['{00E4C220-FD16-11CE-ABC4-02608C9E7553}']
    property IsWorkgroup: WordBool readonly dispid 15;
    function  MinPasswordLength: Integer; dispid 16;
    function  MinPasswordAge: Integer; dispid 17;
    function  MaxPasswordAge: Integer; dispid 18;
    function  MaxBadPasswordsAllowed: Integer; dispid 19;
    function  PasswordHistoryLength: Integer; dispid 20;
    function  PasswordAttributes: Integer; dispid 21;
    function  AutoUnlockInterval: Integer; dispid 22;
    function  LockoutObservationInterval: Integer; dispid 23;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsComputer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EFE3CC70-1D9F-11CF-B1F3-02608C9E7553}
// *********************************************************************//
  IADsComputer = interface(IADs)
    ['{EFE3CC70-1D9F-11CF-B1F3-02608C9E7553}']
    function  Get_ComputerID(out retval: WideString): HResult; stdcall;
    function  Get_Site(out retval: WideString): HResult; stdcall;
    function  Get_Description(out retval: WideString): HResult; stdcall;
    function  Set_Description(const retval: WideString): HResult; stdcall;
    function  Get_Location(out retval: WideString): HResult; stdcall;
    function  Set_Location(const retval: WideString): HResult; stdcall;
    function  Get_PrimaryUser(out retval: WideString): HResult; stdcall;
    function  Set_PrimaryUser(const retval: WideString): HResult; stdcall;
    function  Get_Owner(out retval: WideString): HResult; stdcall;
    function  Set_Owner(const retval: WideString): HResult; stdcall;
    function  Get_Division(out retval: WideString): HResult; stdcall;
    function  Set_Division(const retval: WideString): HResult; stdcall;
    function  Get_Department(out retval: WideString): HResult; stdcall;
    function  Set_Department(const retval: WideString): HResult; stdcall;
    function  Get_Role(out retval: WideString): HResult; stdcall;
    function  Set_Role(const retval: WideString): HResult; stdcall;
    function  Get_OperatingSystem(out retval: WideString): HResult; stdcall;
    function  Set_OperatingSystem(const retval: WideString): HResult; stdcall;
    function  Get_OperatingSystemVersion(out retval: WideString): HResult; stdcall;
    function  Set_OperatingSystemVersion(const retval: WideString): HResult; stdcall;
    function  Get_Model(out retval: WideString): HResult; stdcall;
    function  Set_Model(const retval: WideString): HResult; stdcall;
    function  Get_Processor(out retval: WideString): HResult; stdcall;
    function  Set_Processor(const retval: WideString): HResult; stdcall;
    function  Get_ProcessorCount(out retval: WideString): HResult; stdcall;
    function  Set_ProcessorCount(const retval: WideString): HResult; stdcall;
    function  Get_MemorySize(out retval: WideString): HResult; stdcall;
    function  Set_MemorySize(const retval: WideString): HResult; stdcall;
    function  Get_StorageCapacity(out retval: WideString): HResult; stdcall;
    function  Set_StorageCapacity(const retval: WideString): HResult; stdcall;
    function  Get_NetAddresses(out retval: OleVariant): HResult; stdcall;
    function  Set_NetAddresses(retval: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsComputerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EFE3CC70-1D9F-11CF-B1F3-02608C9E7553}
// *********************************************************************//
  IADsComputerDisp = dispinterface
    ['{EFE3CC70-1D9F-11CF-B1F3-02608C9E7553}']
    property ComputerID: WideString readonly dispid 16;
    property Site: WideString readonly dispid 18;
    function  Description: WideString; dispid 19;
    function  Location: WideString; dispid 20;
    function  PrimaryUser: WideString; dispid 21;
    function  Owner: WideString; dispid 22;
    function  Division: WideString; dispid 23;
    function  Department: WideString; dispid 24;
    function  Role: WideString; dispid 25;
    function  OperatingSystem: WideString; dispid 26;
    function  OperatingSystemVersion: WideString; dispid 27;
    function  Model: WideString; dispid 28;
    function  Processor: WideString; dispid 29;
    function  ProcessorCount: WideString; dispid 30;
    function  MemorySize: WideString; dispid 31;
    function  StorageCapacity: WideString; dispid 32;
    function  NetAddresses: OleVariant; dispid 17;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsComputerOperations
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EF497680-1D9F-11CF-B1F3-02608C9E7553}
// *********************************************************************//
  IADsComputerOperations = interface(IADs)
    ['{EF497680-1D9F-11CF-B1F3-02608C9E7553}']
    function  Status(out ppObject: IDispatch): HResult; stdcall;
    function  Shutdown(bReboot: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsComputerOperationsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EF497680-1D9F-11CF-B1F3-02608C9E7553}
// *********************************************************************//
  IADsComputerOperationsDisp = dispinterface
    ['{EF497680-1D9F-11CF-B1F3-02608C9E7553}']
    function  Status: IDispatch; dispid 33;
    procedure Shutdown(bReboot: WordBool); dispid 34;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsGroup
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {27636B00-410F-11CF-B1FF-02608C9E7553}
// *********************************************************************//
  IADsGroup = interface(IADs)
    ['{27636B00-410F-11CF-B1FF-02608C9E7553}']
    function  Get_Description(out retval: WideString): HResult; stdcall;
    function  Set_Description(const retval: WideString): HResult; stdcall;
    function  Members(out ppMembers: IADsMembers): HResult; stdcall;
    function  IsMember(const bstrMember: WideString; out bMember: WordBool): HResult; stdcall;
    function  Add(const bstrNewItem: WideString): HResult; stdcall;
    function  Remove(const bstrItemToBeRemoved: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsGroupDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {27636B00-410F-11CF-B1FF-02608C9E7553}
// *********************************************************************//
  IADsGroupDisp = dispinterface
    ['{27636B00-410F-11CF-B1FF-02608C9E7553}']
    function  Description: WideString; dispid 15;
    function  Members: IADsMembers; dispid 16;
    function  IsMember(const bstrMember: WideString): WordBool; dispid 17;
    procedure Add(const bstrNewItem: WideString); dispid 18;
    procedure Remove(const bstrItemToBeRemoved: WideString); dispid 19;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsUser
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3E37E320-17E2-11CF-ABC4-02608C9E7553}
// *********************************************************************//
  IADsUser = interface(IADs)
    ['{3E37E320-17E2-11CF-ABC4-02608C9E7553}']
    function  Get_BadLoginAddress(out retval: WideString): HResult; stdcall;
    function  Get_BadLoginCount(out retval: Integer): HResult; stdcall;
    function  Get_LastLogin(out retval: TDateTime): HResult; stdcall;
    function  Get_LastLogoff(out retval: TDateTime): HResult; stdcall;
    function  Get_LastFailedLogin(out retval: TDateTime): HResult; stdcall;
    function  Get_PasswordLastChanged(out retval: TDateTime): HResult; stdcall;
    function  Get_Description(out retval: WideString): HResult; stdcall;
    function  Set_Description(const retval: WideString): HResult; stdcall;
    function  Get_Division(out retval: WideString): HResult; stdcall;
    function  Set_Division(const retval: WideString): HResult; stdcall;
    function  Get_Department(out retval: WideString): HResult; stdcall;
    function  Set_Department(const retval: WideString): HResult; stdcall;
    function  Get_EmployeeID(out retval: WideString): HResult; stdcall;
    function  Set_EmployeeID(const retval: WideString): HResult; stdcall;
    function  Get_FullName(out retval: WideString): HResult; stdcall;
    function  Set_FullName(const retval: WideString): HResult; stdcall;
    function  Get_FirstName(out retval: WideString): HResult; stdcall;
    function  Set_FirstName(const retval: WideString): HResult; stdcall;
    function  Get_LastName(out retval: WideString): HResult; stdcall;
    function  Set_LastName(const retval: WideString): HResult; stdcall;
    function  Get_OtherName(out retval: WideString): HResult; stdcall;
    function  Set_OtherName(const retval: WideString): HResult; stdcall;
    function  Get_NamePrefix(out retval: WideString): HResult; stdcall;
    function  Set_NamePrefix(const retval: WideString): HResult; stdcall;
    function  Get_NameSuffix(out retval: WideString): HResult; stdcall;
    function  Set_NameSuffix(const retval: WideString): HResult; stdcall;
    function  Get_Title(out retval: WideString): HResult; stdcall;
    function  Set_Title(const retval: WideString): HResult; stdcall;
    function  Get_Manager(out retval: WideString): HResult; stdcall;
    function  Set_Manager(const retval: WideString): HResult; stdcall;
    function  Get_TelephoneHome(out retval: OleVariant): HResult; stdcall;
    function  Set_TelephoneHome(retval: OleVariant): HResult; stdcall;
    function  Get_TelephoneMobile(out retval: OleVariant): HResult; stdcall;
    function  Set_TelephoneMobile(retval: OleVariant): HResult; stdcall;
    function  Get_TelephoneNumber(out retval: OleVariant): HResult; stdcall;
    function  Set_TelephoneNumber(retval: OleVariant): HResult; stdcall;
    function  Get_TelephonePager(out retval: OleVariant): HResult; stdcall;
    function  Set_TelephonePager(retval: OleVariant): HResult; stdcall;
    function  Get_FaxNumber(out retval: OleVariant): HResult; stdcall;
    function  Set_FaxNumber(retval: OleVariant): HResult; stdcall;
    function  Get_OfficeLocations(out retval: OleVariant): HResult; stdcall;
    function  Set_OfficeLocations(retval: OleVariant): HResult; stdcall;
    function  Get_PostalAddresses(out retval: OleVariant): HResult; stdcall;
    function  Set_PostalAddresses(retval: OleVariant): HResult; stdcall;
    function  Get_PostalCodes(out retval: OleVariant): HResult; stdcall;
    function  Set_PostalCodes(retval: OleVariant): HResult; stdcall;
    function  Get_SeeAlso(out retval: OleVariant): HResult; stdcall;
    function  Set_SeeAlso(retval: OleVariant): HResult; stdcall;
    function  Get_AccountDisabled(out retval: WordBool): HResult; stdcall;
    function  Set_AccountDisabled(retval: WordBool): HResult; stdcall;
    function  Get_AccountExpirationDate(out retval: TDateTime): HResult; stdcall;
    function  Set_AccountExpirationDate(retval: TDateTime): HResult; stdcall;
    function  Get_GraceLoginsAllowed(out retval: Integer): HResult; stdcall;
    function  Set_GraceLoginsAllowed(retval: Integer): HResult; stdcall;
    function  Get_GraceLoginsRemaining(out retval: Integer): HResult; stdcall;
    function  Set_GraceLoginsRemaining(retval: Integer): HResult; stdcall;
    function  Get_IsAccountLocked(out retval: WordBool): HResult; stdcall;
    function  Set_IsAccountLocked(retval: WordBool): HResult; stdcall;
    function  Get_LoginHours(out retval: OleVariant): HResult; stdcall;
    function  Set_LoginHours(retval: OleVariant): HResult; stdcall;
    function  Get_LoginWorkstations(out retval: OleVariant): HResult; stdcall;
    function  Set_LoginWorkstations(retval: OleVariant): HResult; stdcall;
    function  Get_MaxLogins(out retval: Integer): HResult; stdcall;
    function  Set_MaxLogins(retval: Integer): HResult; stdcall;
    function  Get_MaxStorage(out retval: Integer): HResult; stdcall;
    function  Set_MaxStorage(retval: Integer): HResult; stdcall;
    function  Get_PasswordExpirationDate(out retval: TDateTime): HResult; stdcall;
    function  Set_PasswordExpirationDate(retval: TDateTime): HResult; stdcall;
    function  Get_PasswordMinimumLength(out retval: Integer): HResult; stdcall;
    function  Set_PasswordMinimumLength(retval: Integer): HResult; stdcall;
    function  Get_PasswordRequired(out retval: WordBool): HResult; stdcall;
    function  Set_PasswordRequired(retval: WordBool): HResult; stdcall;
    function  Get_RequireUniquePassword(out retval: WordBool): HResult; stdcall;
    function  Set_RequireUniquePassword(retval: WordBool): HResult; stdcall;
    function  Get_EmailAddress(out retval: WideString): HResult; stdcall;
    function  Set_EmailAddress(const retval: WideString): HResult; stdcall;
    function  Get_HomeDirectory(out retval: WideString): HResult; stdcall;
    function  Set_HomeDirectory(const retval: WideString): HResult; stdcall;
    function  Get_Languages(out retval: OleVariant): HResult; stdcall;
    function  Set_Languages(retval: OleVariant): HResult; stdcall;
    function  Get_Profile(out retval: WideString): HResult; stdcall;
    function  Set_Profile(const retval: WideString): HResult; stdcall;
    function  Get_LoginScript(out retval: WideString): HResult; stdcall;
    function  Set_LoginScript(const retval: WideString): HResult; stdcall;
    function  Get_Picture(out retval: OleVariant): HResult; stdcall;
    function  Set_Picture(retval: OleVariant): HResult; stdcall;
    function  Get_HomePage(out retval: WideString): HResult; stdcall;
    function  Set_HomePage(const retval: WideString): HResult; stdcall;
    function  Groups(out ppGroups: IADsMembers): HResult; stdcall;
    function  SetPassword(const NewPassword: WideString): HResult; stdcall;
    function  ChangePassword(const bstrOldPassword: WideString; const bstrNewPassword: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsUserDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3E37E320-17E2-11CF-ABC4-02608C9E7553}
// *********************************************************************//
  IADsUserDisp = dispinterface
    ['{3E37E320-17E2-11CF-ABC4-02608C9E7553}']
    property BadLoginAddress: WideString readonly dispid 53;
    property BadLoginCount: Integer readonly dispid 54;
    property LastLogin: TDateTime readonly dispid 56;
    property LastLogoff: TDateTime readonly dispid 57;
    property LastFailedLogin: TDateTime readonly dispid 58;
    property PasswordLastChanged: TDateTime readonly dispid 59;
    function  Description: WideString; dispid 15;
    function  Division: WideString; dispid 19;
    function  Department: WideString; dispid 122;
    function  EmployeeID: WideString; dispid 20;
    function  FullName: WideString; dispid 23;
    function  FirstName: WideString; dispid 22;
    function  LastName: WideString; dispid 25;
    function  OtherName: WideString; dispid 27;
    function  NamePrefix: WideString; dispid 114;
    function  NameSuffix: WideString; dispid 115;
    function  Title: WideString; dispid 36;
    function  Manager: WideString; dispid 26;
    function  TelephoneHome: OleVariant; dispid 32;
    function  TelephoneMobile: OleVariant; dispid 33;
    function  TelephoneNumber: OleVariant; dispid 34;
    function  TelephonePager: OleVariant; dispid 17;
    function  FaxNumber: OleVariant; dispid 16;
    function  OfficeLocations: OleVariant; dispid 28;
    function  PostalAddresses: OleVariant; dispid 30;
    function  PostalCodes: OleVariant; dispid 31;
    function  SeeAlso: OleVariant; dispid 117;
    function  AccountDisabled: WordBool; dispid 37;
    function  AccountExpirationDate: TDateTime; dispid 38;
    function  GraceLoginsAllowed: Integer; dispid 41;
    function  GraceLoginsRemaining: Integer; dispid 42;
    function  IsAccountLocked: WordBool; dispid 43;
    function  LoginHours: OleVariant; dispid 45;
    function  LoginWorkstations: OleVariant; dispid 46;
    function  MaxLogins: Integer; dispid 47;
    function  MaxStorage: Integer; dispid 48;
    function  PasswordExpirationDate: TDateTime; dispid 49;
    function  PasswordMinimumLength: Integer; dispid 50;
    function  PasswordRequired: WordBool; dispid 51;
    function  RequireUniquePassword: WordBool; dispid 52;
    function  EmailAddress: WideString; dispid 60;
    function  HomeDirectory: WideString; dispid 61;
    function  Languages: OleVariant; dispid 62;
    function  Profile: WideString; dispid 63;
    function  LoginScript: WideString; dispid 64;
    function  Picture: OleVariant; dispid 65;
    function  HomePage: WideString; dispid 120;
    function  Groups: IADsMembers; dispid 66;
    procedure SetPassword(const NewPassword: WideString); dispid 67;
    procedure ChangePassword(const bstrOldPassword: WideString; const bstrNewPassword: WideString); dispid 68;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsPrintQueue
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B15160D0-1226-11CF-A985-00AA006BC149}
// *********************************************************************//
  IADsPrintQueue = interface(IADs)
    ['{B15160D0-1226-11CF-A985-00AA006BC149}']
    function  Get_PrinterPath(out retval: WideString): HResult; stdcall;
    function  Set_PrinterPath(const retval: WideString): HResult; stdcall;
    function  Get_Model(out retval: WideString): HResult; stdcall;
    function  Set_Model(const retval: WideString): HResult; stdcall;
    function  Get_Datatype(out retval: WideString): HResult; stdcall;
    function  Set_Datatype(const retval: WideString): HResult; stdcall;
    function  Get_PrintProcessor(out retval: WideString): HResult; stdcall;
    function  Set_PrintProcessor(const retval: WideString): HResult; stdcall;
    function  Get_Description(out retval: WideString): HResult; stdcall;
    function  Set_Description(const retval: WideString): HResult; stdcall;
    function  Get_Location(out retval: WideString): HResult; stdcall;
    function  Set_Location(const retval: WideString): HResult; stdcall;
    function  Get_StartTime(out retval: TDateTime): HResult; stdcall;
    function  Set_StartTime(retval: TDateTime): HResult; stdcall;
    function  Get_UntilTime(out retval: TDateTime): HResult; stdcall;
    function  Set_UntilTime(retval: TDateTime): HResult; stdcall;
    function  Get_DefaultJobPriority(out retval: Integer): HResult; stdcall;
    function  Set_DefaultJobPriority(retval: Integer): HResult; stdcall;
    function  Get_Priority(out retval: Integer): HResult; stdcall;
    function  Set_Priority(retval: Integer): HResult; stdcall;
    function  Get_BannerPage(out retval: WideString): HResult; stdcall;
    function  Set_BannerPage(const retval: WideString): HResult; stdcall;
    function  Get_PrintDevices(out retval: OleVariant): HResult; stdcall;
    function  Set_PrintDevices(retval: OleVariant): HResult; stdcall;
    function  Get_NetAddresses(out retval: OleVariant): HResult; stdcall;
    function  Set_NetAddresses(retval: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsPrintQueueDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B15160D0-1226-11CF-A985-00AA006BC149}
// *********************************************************************//
  IADsPrintQueueDisp = dispinterface
    ['{B15160D0-1226-11CF-A985-00AA006BC149}']
    function  PrinterPath: WideString; dispid 15;
    function  Model: WideString; dispid 16;
    function  Datatype: WideString; dispid 17;
    function  PrintProcessor: WideString; dispid 18;
    function  Description: WideString; dispid 19;
    function  Location: WideString; dispid 20;
    function  StartTime: TDateTime; dispid 21;
    function  UntilTime: TDateTime; dispid 22;
    function  DefaultJobPriority: Integer; dispid 23;
    function  Priority: Integer; dispid 24;
    function  BannerPage: WideString; dispid 25;
    function  PrintDevices: OleVariant; dispid 26;
    function  NetAddresses: OleVariant; dispid 27;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsPrintQueueOperations
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {124BE5C0-156E-11CF-A986-00AA006BC149}
// *********************************************************************//
  IADsPrintQueueOperations = interface(IADs)
    ['{124BE5C0-156E-11CF-A986-00AA006BC149}']
    function  Get_Status(out retval: Integer): HResult; stdcall;
    function  PrintJobs(out pObject: IADsCollection): HResult; stdcall;
    function  Pause: HResult; stdcall;
    function  Resume: HResult; stdcall;
    function  Purge: HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsPrintQueueOperationsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {124BE5C0-156E-11CF-A986-00AA006BC149}
// *********************************************************************//
  IADsPrintQueueOperationsDisp = dispinterface
    ['{124BE5C0-156E-11CF-A986-00AA006BC149}']
    property Status: Integer readonly dispid 27;
    function  PrintJobs: IADsCollection; dispid 28;
    procedure Pause; dispid 29;
    procedure Resume; dispid 30;
    procedure Purge; dispid 31;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsPrintJob
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {32FB6780-1ED0-11CF-A988-00AA006BC149}
// *********************************************************************//
  IADsPrintJob = interface(IADs)
    ['{32FB6780-1ED0-11CF-A988-00AA006BC149}']
    function  Get_HostPrintQueue(out retval: WideString): HResult; stdcall;
    function  Get_User(out retval: WideString): HResult; stdcall;
    function  Get_UserPath(out retval: WideString): HResult; stdcall;
    function  Get_TimeSubmitted(out retval: TDateTime): HResult; stdcall;
    function  Get_TotalPages(out retval: Integer): HResult; stdcall;
    function  Get_Size(out retval: Integer): HResult; stdcall;
    function  Get_Description(out retval: WideString): HResult; stdcall;
    function  Set_Description(const retval: WideString): HResult; stdcall;
    function  Get_Priority(out retval: Integer): HResult; stdcall;
    function  Set_Priority(retval: Integer): HResult; stdcall;
    function  Get_StartTime(out retval: TDateTime): HResult; stdcall;
    function  Set_StartTime(retval: TDateTime): HResult; stdcall;
    function  Get_UntilTime(out retval: TDateTime): HResult; stdcall;
    function  Set_UntilTime(retval: TDateTime): HResult; stdcall;
    function  Get_Notify(out retval: WideString): HResult; stdcall;
    function  Set_Notify(const retval: WideString): HResult; stdcall;
    function  Get_NotifyPath(out retval: WideString): HResult; stdcall;
    function  Set_NotifyPath(const retval: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsPrintJobDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {32FB6780-1ED0-11CF-A988-00AA006BC149}
// *********************************************************************//
  IADsPrintJobDisp = dispinterface
    ['{32FB6780-1ED0-11CF-A988-00AA006BC149}']
    property HostPrintQueue: WideString readonly dispid 15;
    property User: WideString readonly dispid 16;
    property UserPath: WideString readonly dispid 17;
    property TimeSubmitted: TDateTime readonly dispid 18;
    property TotalPages: Integer readonly dispid 19;
    property Size: Integer readonly dispid 234;
    function  Description: WideString; dispid 20;
    function  Priority: Integer; dispid 21;
    function  StartTime: TDateTime; dispid 22;
    function  UntilTime: TDateTime; dispid 23;
    function  Notify: WideString; dispid 24;
    function  NotifyPath: WideString; dispid 25;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsPrintJobOperations
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9A52DB30-1ECF-11CF-A988-00AA006BC149}
// *********************************************************************//
  IADsPrintJobOperations = interface(IADs)
    ['{9A52DB30-1ECF-11CF-A988-00AA006BC149}']
    function  Get_Status(out retval: Integer): HResult; stdcall;
    function  Get_TimeElapsed(out retval: Integer): HResult; stdcall;
    function  Get_PagesPrinted(out retval: Integer): HResult; stdcall;
    function  Get_Position(out retval: Integer): HResult; stdcall;
    function  Set_Position(retval: Integer): HResult; stdcall;
    function  Pause: HResult; stdcall;
    function  Resume: HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsPrintJobOperationsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9A52DB30-1ECF-11CF-A988-00AA006BC149}
// *********************************************************************//
  IADsPrintJobOperationsDisp = dispinterface
    ['{9A52DB30-1ECF-11CF-A988-00AA006BC149}']
    property Status: Integer readonly dispid 26;
    property TimeElapsed: Integer readonly dispid 27;
    property PagesPrinted: Integer readonly dispid 28;
    function  Position: Integer; dispid 29;
    procedure Pause; dispid 30;
    procedure Resume; dispid 31;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsService
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {68AF66E0-31CA-11CF-A98A-00AA006BC149}
// *********************************************************************//
  IADsService = interface(IADs)
    ['{68AF66E0-31CA-11CF-A98A-00AA006BC149}']
    function  Get_HostComputer(out retval: WideString): HResult; stdcall;
    function  Set_HostComputer(const retval: WideString): HResult; stdcall;
    function  Get_DisplayName(out retval: WideString): HResult; stdcall;
    function  Set_DisplayName(const retval: WideString): HResult; stdcall;
    function  Get_Version(out retval: WideString): HResult; stdcall;
    function  Set_Version(const retval: WideString): HResult; stdcall;
    function  Get_ServiceType(out retval: Integer): HResult; stdcall;
    function  Set_ServiceType(retval: Integer): HResult; stdcall;
    function  Get_StartType(out retval: Integer): HResult; stdcall;
    function  Set_StartType(retval: Integer): HResult; stdcall;
    function  Get_Path(out retval: WideString): HResult; stdcall;
    function  Set_Path(const retval: WideString): HResult; stdcall;
    function  Get_StartupParameters(out retval: WideString): HResult; stdcall;
    function  Set_StartupParameters(const retval: WideString): HResult; stdcall;
    function  Get_ErrorControl(out retval: Integer): HResult; stdcall;
    function  Set_ErrorControl(retval: Integer): HResult; stdcall;
    function  Get_LoadOrderGroup(out retval: WideString): HResult; stdcall;
    function  Set_LoadOrderGroup(const retval: WideString): HResult; stdcall;
    function  Get_ServiceAccountName(out retval: WideString): HResult; stdcall;
    function  Set_ServiceAccountName(const retval: WideString): HResult; stdcall;
    function  Get_ServiceAccountPath(out retval: WideString): HResult; stdcall;
    function  Set_ServiceAccountPath(const retval: WideString): HResult; stdcall;
    function  Get_Dependencies(out retval: OleVariant): HResult; stdcall;
    function  Set_Dependencies(retval: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsServiceDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {68AF66E0-31CA-11CF-A98A-00AA006BC149}
// *********************************************************************//
  IADsServiceDisp = dispinterface
    ['{68AF66E0-31CA-11CF-A98A-00AA006BC149}']
    function  HostComputer: WideString; dispid 15;
    function  DisplayName: WideString; dispid 16;
    function  Version: WideString; dispid 17;
    function  ServiceType: Integer; dispid 18;
    function  StartType: Integer; dispid 19;
    function  Path: WideString; dispid 20;
    function  StartupParameters: WideString; dispid 21;
    function  ErrorControl: Integer; dispid 22;
    function  LoadOrderGroup: WideString; dispid 23;
    function  ServiceAccountName: WideString; dispid 24;
    function  ServiceAccountPath: WideString; dispid 25;
    function  Dependencies: OleVariant; dispid 26;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsServiceOperations
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5D7B33F0-31CA-11CF-A98A-00AA006BC149}
// *********************************************************************//
  IADsServiceOperations = interface(IADs)
    ['{5D7B33F0-31CA-11CF-A98A-00AA006BC149}']
    function  Get_Status(out retval: Integer): HResult; stdcall;
    function  Start: HResult; stdcall;
    function  Stop: HResult; stdcall;
    function  Pause: HResult; stdcall;
    function  Continue: HResult; stdcall;
    function  SetPassword(const bstrNewPassword: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsServiceOperationsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5D7B33F0-31CA-11CF-A98A-00AA006BC149}
// *********************************************************************//
  IADsServiceOperationsDisp = dispinterface
    ['{5D7B33F0-31CA-11CF-A98A-00AA006BC149}']
    property Status: Integer readonly dispid 27;
    procedure Start; dispid 28;
    procedure Stop; dispid 29;
    procedure Pause; dispid 30;
    procedure Continue; dispid 31;
    procedure SetPassword(const bstrNewPassword: WideString); dispid 32;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsFileService
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A89D1900-31CA-11CF-A98A-00AA006BC149}
// *********************************************************************//
  IADsFileService = interface(IADsService)
    ['{A89D1900-31CA-11CF-A98A-00AA006BC149}']
    function  Get_Description(out retval: WideString): HResult; stdcall;
    function  Set_Description(const retval: WideString): HResult; stdcall;
    function  Get_MaxUserCount(out retval: Integer): HResult; stdcall;
    function  Set_MaxUserCount(retval: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsFileServiceDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A89D1900-31CA-11CF-A98A-00AA006BC149}
// *********************************************************************//
  IADsFileServiceDisp = dispinterface
    ['{A89D1900-31CA-11CF-A98A-00AA006BC149}']
    function  Description: WideString; dispid 33;
    function  MaxUserCount: Integer; dispid 34;
    function  HostComputer: WideString; dispid 15;
    function  DisplayName: WideString; dispid 16;
    function  Version: WideString; dispid 17;
    function  ServiceType: Integer; dispid 18;
    function  StartType: Integer; dispid 19;
    function  Path: WideString; dispid 20;
    function  StartupParameters: WideString; dispid 21;
    function  ErrorControl: Integer; dispid 22;
    function  LoadOrderGroup: WideString; dispid 23;
    function  ServiceAccountName: WideString; dispid 24;
    function  ServiceAccountPath: WideString; dispid 25;
    function  Dependencies: OleVariant; dispid 26;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsFileServiceOperations
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A02DED10-31CA-11CF-A98A-00AA006BC149}
// *********************************************************************//
  IADsFileServiceOperations = interface(IADsServiceOperations)
    ['{A02DED10-31CA-11CF-A98A-00AA006BC149}']
    function  Sessions(out ppSessions: IADsCollection): HResult; stdcall;
    function  Resources(out ppResources: IADsCollection): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsFileServiceOperationsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A02DED10-31CA-11CF-A98A-00AA006BC149}
// *********************************************************************//
  IADsFileServiceOperationsDisp = dispinterface
    ['{A02DED10-31CA-11CF-A98A-00AA006BC149}']
    function  Sessions: IADsCollection; dispid 35;
    function  Resources: IADsCollection; dispid 36;
    property Status: Integer readonly dispid 27;
    procedure Start; dispid 28;
    procedure Stop; dispid 29;
    procedure Pause; dispid 30;
    procedure Continue; dispid 31;
    procedure SetPassword(const bstrNewPassword: WideString); dispid 32;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsFileShare
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EB6DCAF0-4B83-11CF-A995-00AA006BC149}
// *********************************************************************//
  IADsFileShare = interface(IADs)
    ['{EB6DCAF0-4B83-11CF-A995-00AA006BC149}']
    function  Get_CurrentUserCount(out retval: Integer): HResult; stdcall;
    function  Get_Description(out retval: WideString): HResult; stdcall;
    function  Set_Description(const retval: WideString): HResult; stdcall;
    function  Get_HostComputer(out retval: WideString): HResult; stdcall;
    function  Set_HostComputer(const retval: WideString): HResult; stdcall;
    function  Get_Path(out retval: WideString): HResult; stdcall;
    function  Set_Path(const retval: WideString): HResult; stdcall;
    function  Get_MaxUserCount(out retval: Integer): HResult; stdcall;
    function  Set_MaxUserCount(retval: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsFileShareDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EB6DCAF0-4B83-11CF-A995-00AA006BC149}
// *********************************************************************//
  IADsFileShareDisp = dispinterface
    ['{EB6DCAF0-4B83-11CF-A995-00AA006BC149}']
    property CurrentUserCount: Integer readonly dispid 15;
    function  Description: WideString; dispid 16;
    function  HostComputer: WideString; dispid 17;
    function  Path: WideString; dispid 18;
    function  MaxUserCount: Integer; dispid 19;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsSession
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {398B7DA0-4AAB-11CF-AE2C-00AA006EBFB9}
// *********************************************************************//
  IADsSession = interface(IADs)
    ['{398B7DA0-4AAB-11CF-AE2C-00AA006EBFB9}']
    function  Get_User(out retval: WideString): HResult; stdcall;
    function  Get_UserPath(out retval: WideString): HResult; stdcall;
    function  Get_Computer(out retval: WideString): HResult; stdcall;
    function  Get_ComputerPath(out retval: WideString): HResult; stdcall;
    function  Get_ConnectTime(out retval: Integer): HResult; stdcall;
    function  Get_IdleTime(out retval: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsSessionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {398B7DA0-4AAB-11CF-AE2C-00AA006EBFB9}
// *********************************************************************//
  IADsSessionDisp = dispinterface
    ['{398B7DA0-4AAB-11CF-AE2C-00AA006EBFB9}']
    property User: WideString readonly dispid 15;
    property UserPath: WideString readonly dispid 16;
    property Computer: WideString readonly dispid 17;
    property ComputerPath: WideString readonly dispid 18;
    property ConnectTime: Integer readonly dispid 19;
    property IdleTime: Integer readonly dispid 20;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsResource
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {34A05B20-4AAB-11CF-AE2C-00AA006EBFB9}
// *********************************************************************//
  IADsResource = interface(IADs)
    ['{34A05B20-4AAB-11CF-AE2C-00AA006EBFB9}']
    function  Get_User(out retval: WideString): HResult; stdcall;
    function  Get_UserPath(out retval: WideString): HResult; stdcall;
    function  Get_Path(out retval: WideString): HResult; stdcall;
    function  Get_LockCount(out retval: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsResourceDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {34A05B20-4AAB-11CF-AE2C-00AA006EBFB9}
// *********************************************************************//
  IADsResourceDisp = dispinterface
    ['{34A05B20-4AAB-11CF-AE2C-00AA006EBFB9}']
    property User: WideString readonly dispid 15;
    property UserPath: WideString readonly dispid 16;
    property Path: WideString readonly dispid 17;
    property LockCount: Integer readonly dispid 18;
    property Name: WideString readonly dispid 2;
    property Class_: WideString readonly dispid 3;
    property GUID: WideString readonly dispid 4;
    property ADsPath: WideString readonly dispid 5;
    property Parent: WideString readonly dispid 6;
    property Schema: WideString readonly dispid 7;
    procedure GetInfo; dispid 8;
    procedure SetInfo; dispid 9;
    function  Get(const bstrName: WideString): OleVariant; dispid 10;
    procedure Put(const bstrName: WideString; vProp: OleVariant); dispid 11;
    function  GetEx(const bstrName: WideString): OleVariant; dispid 12;
    procedure PutEx(lnControlCode: Integer; const bstrName: WideString; vProp: OleVariant); dispid 13;
    procedure GetInfoEx(vProperties: OleVariant; lnReserved: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: IADsOpenDSObject
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DDF2891E-0F9C-11D0-8AD4-00C04FD8D503}
// *********************************************************************//
  IADsOpenDSObject = interface(IDispatch)
    ['{DDF2891E-0F9C-11D0-8AD4-00C04FD8D503}']
    function  OpenDSObject(const lpszDNName: WideString; const lpszUserName: WideString; 
                           const lpszPassword: WideString; lnReserved: Integer; 
                           out ppOleDsObj: IDispatch): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsOpenDSObjectDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DDF2891E-0F9C-11D0-8AD4-00C04FD8D503}
// *********************************************************************//
  IADsOpenDSObjectDisp = dispinterface
    ['{DDF2891E-0F9C-11D0-8AD4-00C04FD8D503}']
    function  OpenDSObject(const lpszDNName: WideString; const lpszUserName: WideString; 
                           const lpszPassword: WideString; lnReserved: Integer): IDispatch; dispid 1;
  end;

// *********************************************************************//
// Interface: IDirectoryObject
// Flags:     (0)
// GUID:      {E798DE2C-22E4-11D0-84FE-00C04FD8D503}
// *********************************************************************//
  IDirectoryObject = interface(IUnknown)
    ['{E798DE2C-22E4-11D0-84FE-00C04FD8D503}']
    function  GetObjectInformation(out ppObjInfo: PUserType11): HResult; stdcall;
    function  GetObjectAttributes(var pAttributeNames: PWideChar; dwNumberAttributes: LongWord; 
                                  out ppAttributeEntries: PUserType12; 
                                  out pdwNumAttributesReturned: LongWord): HResult; stdcall;
    function  SetObjectAttributes(var pAttributeEntries: _ads_attr_info; dwNumAttributes: LongWord; 
                                  out pdwNumAttributesModified: LongWord): HResult; stdcall;
    function  CreateDSObject(pszRDNName: PWideChar; var pAttributeEntries: _ads_attr_info; 
                             dwNumAttributes: LongWord; out ppObject: IDispatch): HResult; stdcall;
    function  DeleteDSObject(pszRDNName: PWideChar): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDirectorySearch
// Flags:     (0)
// GUID:      {109BA8EC-92F0-11D0-A790-00C04FD8D5A8}
// *********************************************************************//
  IDirectorySearch = interface(IUnknown)
    ['{109BA8EC-92F0-11D0-A790-00C04FD8D5A8}']
    function  SetSearchPreference(var pSearchPrefs: ads_searchpref_info; dwNumPrefs: LongWord): HResult; stdcall;
    function  ExecuteSearch(pszSearchFilter: PWideChar; var pAttributeNames: PWideChar; 
                            dwNumberAttributes: LongWord; out phSearchResult: Pointer): HResult; stdcall;
    function  AbandonSearch(var phSearchResult: Pointer): HResult; stdcall;
    function  GetFirstRow(var hSearchResult: Pointer): HResult; stdcall;
    function  GetNextRow(var hSearchResult: Pointer): HResult; stdcall;
    function  GetPreviousRow(var hSearchResult: Pointer): HResult; stdcall;
    function  GetNextColumnName(var hSearchHandle: Pointer; out ppszColumnName: PWideChar): HResult; stdcall;
    function  GetColumn(var hSearchResult: Pointer; szColumnName: PWideChar; 
                        out pSearchColumn: ads_search_column): HResult; stdcall;
    function  FreeColumn(var pSearchColumn: ads_search_column): HResult; stdcall;
    function  CloseSearchHandle(var hSearchResult: Pointer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDirectorySchemaMgmt
// Flags:     (0)
// GUID:      {75DB3B9C-A4D8-11D0-A79C-00C04FD8D5A8}
// *********************************************************************//
  IDirectorySchemaMgmt = interface(IUnknown)
    ['{75DB3B9C-A4D8-11D0-A79C-00C04FD8D5A8}']
    function  EnumAttributes(var ppszAttrNames: PWideChar; dwNumAttributes: LongWord; 
                             ppAttrDefinition: PPUserType1; var pdwNumAttributes: LongWord): HResult; stdcall;
    function  CreateAttributeDefinition(pszAttributeName: PWideChar; 
                                        var pAttributeDefinition: _ads_attr_def): HResult; stdcall;
    function  WriteAttributeDefinition(pszAttributeName: PWideChar; 
                                       var pAttributeDefinition: _ads_attr_def): HResult; stdcall;
    function  DeleteAttributeDefinition(pszAttributeName: PWideChar): HResult; stdcall;
    function  EnumClasses(var ppszClassNames: PWideChar; dwNumClasses: LongWord; 
                          ppClassDefinition: PPUserType2; var pdwNumClasses: LongWord): HResult; stdcall;
    function  WriteClassDefinition(pszClassName: PWideChar; var pClassDefinition: _ads_class_def): HResult; stdcall;
    function  CreateClassDefinition(pszClassName: PWideChar; var pClassDefinition: _ads_class_def): HResult; stdcall;
    function  DeleteClassDefinition(pszClassName: PWideChar): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IADsAggregatee
// Flags:     (0)
// GUID:      {1346CE8C-9039-11D0-8528-00C04FD8D503}
// *********************************************************************//
  IADsAggregatee = interface(IUnknown)
    ['{1346CE8C-9039-11D0-8528-00C04FD8D503}']
    function  ConnectAsAggregatee(const pOuterUnknown: IUnknown): HResult; stdcall;
    function  DisconnectAsAggregatee: HResult; stdcall;
    function  RelinquishInterface(var riid: TGUID): HResult; stdcall;
    function  RestoreInterface(var riid: TGUID): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IADsAggregator
// Flags:     (0)
// GUID:      {52DB5FB0-941F-11D0-8529-00C04FD8D503}
// *********************************************************************//
  IADsAggregator = interface(IUnknown)
    ['{52DB5FB0-941F-11D0-8529-00C04FD8D503}']
    function  ConnectAsAggregator(const pAggregatee: IUnknown): HResult; stdcall;
    function  DisconnectAsAggregator: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IADsAccessControlEntry
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B4F3A14C-9BDD-11D0-852C-00C04FD8D503}
// *********************************************************************//
  IADsAccessControlEntry = interface(IDispatch)
    ['{B4F3A14C-9BDD-11D0-852C-00C04FD8D503}']
    function  Get_AccessMask(out retval: Integer): HResult; stdcall;
    function  Set_AccessMask(retval: Integer): HResult; stdcall;
    function  Get_AceType(out retval: Integer): HResult; stdcall;
    function  Set_AceType(retval: Integer): HResult; stdcall;
    function  Get_AceFlags(out retval: Integer): HResult; stdcall;
    function  Set_AceFlags(retval: Integer): HResult; stdcall;
    function  Get_Flags(out retval: Integer): HResult; stdcall;
    function  Set_Flags(retval: Integer): HResult; stdcall;
    function  Get_ObjectType(out retval: WideString): HResult; stdcall;
    function  Set_ObjectType(const retval: WideString): HResult; stdcall;
    function  Get_InheritedObjectType(out retval: WideString): HResult; stdcall;
    function  Set_InheritedObjectType(const retval: WideString): HResult; stdcall;
    function  Get_Trustee(out retval: WideString): HResult; stdcall;
    function  Set_Trustee(const retval: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsAccessControlEntryDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B4F3A14C-9BDD-11D0-852C-00C04FD8D503}
// *********************************************************************//
  IADsAccessControlEntryDisp = dispinterface
    ['{B4F3A14C-9BDD-11D0-852C-00C04FD8D503}']
    function  AccessMask: Integer; dispid 2;
    function  AceType: Integer; dispid 3;
    function  AceFlags: Integer; dispid 4;
    function  Flags: Integer; dispid 5;
    function  ObjectType: WideString; dispid 6;
    function  InheritedObjectType: WideString; dispid 7;
    function  Trustee: WideString; dispid 8;
  end;

// *********************************************************************//
// Interface: IADsAccessControlList
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B7EE91CC-9BDD-11D0-852C-00C04FD8D503}
// *********************************************************************//
  IADsAccessControlList = interface(IDispatch)
    ['{B7EE91CC-9BDD-11D0-852C-00C04FD8D503}']
    function  Get_AclRevision(out retval: Integer): HResult; stdcall;
    function  Set_AclRevision(retval: Integer): HResult; stdcall;
    function  Get_AceCount(out retval: Integer): HResult; stdcall;
    function  Set_AceCount(retval: Integer): HResult; stdcall;
    function  AddAce(const pAccessControlEntry: IDispatch): HResult; stdcall;
    function  RemoveAce(const pAccessControlEntry: IDispatch): HResult; stdcall;
    function  CopyAccessList(out ppAccessControlList: IDispatch): HResult; stdcall;
    function  Get__NewEnum(out retval: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsAccessControlListDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B7EE91CC-9BDD-11D0-852C-00C04FD8D503}
// *********************************************************************//
  IADsAccessControlListDisp = dispinterface
    ['{B7EE91CC-9BDD-11D0-852C-00C04FD8D503}']
    function  AclRevision: Integer; dispid 3;
    function  AceCount: Integer; dispid 4;
    procedure AddAce(const pAccessControlEntry: IDispatch); dispid 5;
    procedure RemoveAce(const pAccessControlEntry: IDispatch); dispid 6;
    function  CopyAccessList: IDispatch; dispid 7;
    property _NewEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: IADsSecurityDescriptor
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B8C787CA-9BDD-11D0-852C-00C04FD8D503}
// *********************************************************************//
  IADsSecurityDescriptor = interface(IDispatch)
    ['{B8C787CA-9BDD-11D0-852C-00C04FD8D503}']
    function  Get_Revision(out retval: Integer): HResult; stdcall;
    function  Set_Revision(retval: Integer): HResult; stdcall;
    function  Get_Control(out retval: Integer): HResult; stdcall;
    function  Set_Control(retval: Integer): HResult; stdcall;
    function  Get_Owner(out retval: WideString): HResult; stdcall;
    function  Set_Owner(const retval: WideString): HResult; stdcall;
    function  Get_OwnerDefaulted(out retval: WordBool): HResult; stdcall;
    function  Set_OwnerDefaulted(retval: WordBool): HResult; stdcall;
    function  Get_Group(out retval: WideString): HResult; stdcall;
    function  Set_Group(const retval: WideString): HResult; stdcall;
    function  Get_GroupDefaulted(out retval: WordBool): HResult; stdcall;
    function  Set_GroupDefaulted(retval: WordBool): HResult; stdcall;
    function  Get_DiscretionaryAcl(out retval: IDispatch): HResult; stdcall;
    function  Set_DiscretionaryAcl(const retval: IDispatch): HResult; stdcall;
    function  Get_DaclDefaulted(out retval: WordBool): HResult; stdcall;
    function  Set_DaclDefaulted(retval: WordBool): HResult; stdcall;
    function  Get_SystemAcl(out retval: IDispatch): HResult; stdcall;
    function  Set_SystemAcl(const retval: IDispatch): HResult; stdcall;
    function  Get_SaclDefaulted(out retval: WordBool): HResult; stdcall;
    function  Set_SaclDefaulted(retval: WordBool): HResult; stdcall;
    function  CopySecurityDescriptor(out ppSecurityDescriptor: IDispatch): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsSecurityDescriptorDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B8C787CA-9BDD-11D0-852C-00C04FD8D503}
// *********************************************************************//
  IADsSecurityDescriptorDisp = dispinterface
    ['{B8C787CA-9BDD-11D0-852C-00C04FD8D503}']
    function  Revision: Integer; dispid 2;
    function  Control: Integer; dispid 3;
    function  Owner: WideString; dispid 4;
    function  OwnerDefaulted: WordBool; dispid 5;
    function  Group: WideString; dispid 6;
    function  GroupDefaulted: WordBool; dispid 7;
    function  DiscretionaryAcl: IDispatch; dispid 8;
    function  DaclDefaulted: WordBool; dispid 9;
    function  SystemAcl: IDispatch; dispid 10;
    function  SaclDefaulted: WordBool; dispid 11;
    function  CopySecurityDescriptor: IDispatch; dispid 12;
  end;

// *********************************************************************//
// Interface: IADsLargeInteger
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9068270B-0939-11D1-8BE1-00C04FD8D503}
// *********************************************************************//
  IADsLargeInteger = interface(IDispatch)
    ['{9068270B-0939-11D1-8BE1-00C04FD8D503}']
    function  Get_HighPart(out retval: Integer): HResult; stdcall;
    function  Set_HighPart(retval: Integer): HResult; stdcall;
    function  Get_LowPart(out retval: Integer): HResult; stdcall;
    function  Set_LowPart(retval: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsLargeIntegerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9068270B-0939-11D1-8BE1-00C04FD8D503}
// *********************************************************************//
  IADsLargeIntegerDisp = dispinterface
    ['{9068270B-0939-11D1-8BE1-00C04FD8D503}']
    function  HighPart: Integer; dispid 2;
    function  LowPart: Integer; dispid 3;
  end;

// *********************************************************************//
// Interface: IADsNameTranslate
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B1B272A3-3625-11D1-A3A4-00C04FB950DC}
// *********************************************************************//
  IADsNameTranslate = interface(IDispatch)
    ['{B1B272A3-3625-11D1-A3A4-00C04FB950DC}']
    function  Set_ChaseReferral(Param1: Integer): HResult; stdcall;
    function  Init(lnSetType: Integer; const bstrADsPath: WideString): HResult; stdcall;
    function  InitEx(lnSetType: Integer; const bstrADsPath: WideString; 
                     const bstrUserID: WideString; const bstrDomain: WideString; 
                     const bstrPassword: WideString): HResult; stdcall;
    function  Set_(lnSetType: Integer; const bstrADsPath: WideString): HResult; stdcall;
    function  Get(lnFormatType: Integer; out pbstrADsPath: WideString): HResult; stdcall;
    function  SetEx(lnFormatType: Integer; pVar: OleVariant): HResult; stdcall;
    function  GetEx(lnFormatType: Integer; out pVar: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsNameTranslateDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B1B272A3-3625-11D1-A3A4-00C04FB950DC}
// *********************************************************************//
  IADsNameTranslateDisp = dispinterface
    ['{B1B272A3-3625-11D1-A3A4-00C04FB950DC}']
    property ChaseReferral: Integer writeonly dispid 1;
    procedure Init(lnSetType: Integer; const bstrADsPath: WideString); dispid 2;
    procedure InitEx(lnSetType: Integer; const bstrADsPath: WideString; 
                     const bstrUserID: WideString; const bstrDomain: WideString; 
                     const bstrPassword: WideString); dispid 3;
    procedure Set_(lnSetType: Integer; const bstrADsPath: WideString); dispid 4;
    function  Get(lnFormatType: Integer): WideString; dispid 5;
    procedure SetEx(lnFormatType: Integer; pVar: OleVariant); dispid 6;
    function  GetEx(lnFormatType: Integer): OleVariant; dispid 7;
  end;

// *********************************************************************//
// Interface: IADsCaseIgnoreList
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7B66B533-4680-11D1-A3B4-00C04FB950DC}
// *********************************************************************//
  IADsCaseIgnoreList = interface(IDispatch)
    ['{7B66B533-4680-11D1-A3B4-00C04FB950DC}']
    function  Get_CaseIgnoreList(out retval: OleVariant): HResult; stdcall;
    function  Set_CaseIgnoreList(retval: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsCaseIgnoreListDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7B66B533-4680-11D1-A3B4-00C04FB950DC}
// *********************************************************************//
  IADsCaseIgnoreListDisp = dispinterface
    ['{7B66B533-4680-11D1-A3B4-00C04FB950DC}']
    function  CaseIgnoreList: OleVariant; dispid 2;
  end;

// *********************************************************************//
// Interface: IADsFaxNumber
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A910DEA9-4680-11D1-A3B4-00C04FB950DC}
// *********************************************************************//
  IADsFaxNumber = interface(IDispatch)
    ['{A910DEA9-4680-11D1-A3B4-00C04FB950DC}']
    function  Get_TelephoneNumber(out retval: WideString): HResult; stdcall;
    function  Set_TelephoneNumber(const retval: WideString): HResult; stdcall;
    function  Get_Parameters(out retval: OleVariant): HResult; stdcall;
    function  Set_Parameters(retval: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsFaxNumberDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A910DEA9-4680-11D1-A3B4-00C04FB950DC}
// *********************************************************************//
  IADsFaxNumberDisp = dispinterface
    ['{A910DEA9-4680-11D1-A3B4-00C04FB950DC}']
    function  TelephoneNumber: WideString; dispid 2;
    function  Parameters: OleVariant; dispid 3;
  end;

// *********************************************************************//
// Interface: IADsNetAddress
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B21A50A9-4080-11D1-A3AC-00C04FB950DC}
// *********************************************************************//
  IADsNetAddress = interface(IDispatch)
    ['{B21A50A9-4080-11D1-A3AC-00C04FB950DC}']
    function  Get_AddressType(out retval: Integer): HResult; stdcall;
    function  Set_AddressType(retval: Integer): HResult; stdcall;
    function  Get_Address(out retval: OleVariant): HResult; stdcall;
    function  Set_Address(retval: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsNetAddressDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B21A50A9-4080-11D1-A3AC-00C04FB950DC}
// *********************************************************************//
  IADsNetAddressDisp = dispinterface
    ['{B21A50A9-4080-11D1-A3AC-00C04FB950DC}']
    function  AddressType: Integer; dispid 2;
    function  Address: OleVariant; dispid 3;
  end;

// *********************************************************************//
// Interface: IADsOctetList
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7B28B80F-4680-11D1-A3B4-00C04FB950DC}
// *********************************************************************//
  IADsOctetList = interface(IDispatch)
    ['{7B28B80F-4680-11D1-A3B4-00C04FB950DC}']
    function  Get_OctetList(out retval: OleVariant): HResult; stdcall;
    function  Set_OctetList(retval: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsOctetListDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7B28B80F-4680-11D1-A3B4-00C04FB950DC}
// *********************************************************************//
  IADsOctetListDisp = dispinterface
    ['{7B28B80F-4680-11D1-A3B4-00C04FB950DC}']
    function  OctetList: OleVariant; dispid 2;
  end;

// *********************************************************************//
// Interface: IADsEmail
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {97AF011A-478E-11D1-A3B4-00C04FB950DC}
// *********************************************************************//
  IADsEmail = interface(IDispatch)
    ['{97AF011A-478E-11D1-A3B4-00C04FB950DC}']
    function  Get_Type_(out retval: Integer): HResult; stdcall;
    function  Set_Type_(retval: Integer): HResult; stdcall;
    function  Get_Address(out retval: WideString): HResult; stdcall;
    function  Set_Address(const retval: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsEmailDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {97AF011A-478E-11D1-A3B4-00C04FB950DC}
// *********************************************************************//
  IADsEmailDisp = dispinterface
    ['{97AF011A-478E-11D1-A3B4-00C04FB950DC}']
    function  Type_: Integer; dispid 2;
    function  Address: WideString; dispid 3;
  end;

// *********************************************************************//
// Interface: IADsPath
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B287FCD5-4080-11D1-A3AC-00C04FB950DC}
// *********************************************************************//
  IADsPath = interface(IDispatch)
    ['{B287FCD5-4080-11D1-A3AC-00C04FB950DC}']
    function  Get_Type_(out retval: Integer): HResult; stdcall;
    function  Set_Type_(retval: Integer): HResult; stdcall;
    function  Get_VolumeName(out retval: WideString): HResult; stdcall;
    function  Set_VolumeName(const retval: WideString): HResult; stdcall;
    function  Get_Path(out retval: WideString): HResult; stdcall;
    function  Set_Path(const retval: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsPathDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B287FCD5-4080-11D1-A3AC-00C04FB950DC}
// *********************************************************************//
  IADsPathDisp = dispinterface
    ['{B287FCD5-4080-11D1-A3AC-00C04FB950DC}']
    function  Type_: Integer; dispid 2;
    function  VolumeName: WideString; dispid 3;
    function  Path: WideString; dispid 4;
  end;

// *********************************************************************//
// Interface: IADsReplicaPointer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F60FB803-4080-11D1-A3AC-00C04FB950DC}
// *********************************************************************//
  IADsReplicaPointer = interface(IDispatch)
    ['{F60FB803-4080-11D1-A3AC-00C04FB950DC}']
    function  Get_ServerName(out retval: WideString): HResult; stdcall;
    function  Set_ServerName(const retval: WideString): HResult; stdcall;
    function  Get_ReplicaType(out retval: Integer): HResult; stdcall;
    function  Set_ReplicaType(retval: Integer): HResult; stdcall;
    function  Get_ReplicaNumber(out retval: Integer): HResult; stdcall;
    function  Set_ReplicaNumber(retval: Integer): HResult; stdcall;
    function  Get_Count(out retval: Integer): HResult; stdcall;
    function  Set_Count(retval: Integer): HResult; stdcall;
    function  Get_ReplicaAddressHints(out retval: OleVariant): HResult; stdcall;
    function  Set_ReplicaAddressHints(retval: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsReplicaPointerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F60FB803-4080-11D1-A3AC-00C04FB950DC}
// *********************************************************************//
  IADsReplicaPointerDisp = dispinterface
    ['{F60FB803-4080-11D1-A3AC-00C04FB950DC}']
    function  ServerName: WideString; dispid 2;
    function  ReplicaType: Integer; dispid 3;
    function  ReplicaNumber: Integer; dispid 4;
    function  Count: Integer; dispid 5;
    function  ReplicaAddressHints: OleVariant; dispid 6;
  end;

// *********************************************************************//
// Interface: IADsAcl
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8452D3AB-0869-11D1-A377-00C04FB950DC}
// *********************************************************************//
  IADsAcl = interface(IDispatch)
    ['{8452D3AB-0869-11D1-A377-00C04FB950DC}']
    function  Get_ProtectedAttrName(out retval: WideString): HResult; stdcall;
    function  Set_ProtectedAttrName(const retval: WideString): HResult; stdcall;
    function  Get_SubjectName(out retval: WideString): HResult; stdcall;
    function  Set_SubjectName(const retval: WideString): HResult; stdcall;
    function  Get_Privileges(out retval: Integer): HResult; stdcall;
    function  Set_Privileges(retval: Integer): HResult; stdcall;
    function  CopyAcl(out ppAcl: IDispatch): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsAclDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8452D3AB-0869-11D1-A377-00C04FB950DC}
// *********************************************************************//
  IADsAclDisp = dispinterface
    ['{8452D3AB-0869-11D1-A377-00C04FB950DC}']
    function  ProtectedAttrName: WideString; dispid 2;
    function  SubjectName: WideString; dispid 3;
    function  Privileges: Integer; dispid 4;
    function  CopyAcl: IDispatch; dispid 5;
  end;

// *********************************************************************//
// Interface: IADsTimestamp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B2F5A901-4080-11D1-A3AC-00C04FB950DC}
// *********************************************************************//
  IADsTimestamp = interface(IDispatch)
    ['{B2F5A901-4080-11D1-A3AC-00C04FB950DC}']
    function  Get_WholeSeconds(out retval: Integer): HResult; stdcall;
    function  Set_WholeSeconds(retval: Integer): HResult; stdcall;
    function  Get_EventID(out retval: Integer): HResult; stdcall;
    function  Set_EventID(retval: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsTimestampDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B2F5A901-4080-11D1-A3AC-00C04FB950DC}
// *********************************************************************//
  IADsTimestampDisp = dispinterface
    ['{B2F5A901-4080-11D1-A3AC-00C04FB950DC}']
    function  WholeSeconds: Integer; dispid 2;
    function  EventID: Integer; dispid 3;
  end;

// *********************************************************************//
// Interface: IADsPostalAddress
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7ADECF29-4680-11D1-A3B4-00C04FB950DC}
// *********************************************************************//
  IADsPostalAddress = interface(IDispatch)
    ['{7ADECF29-4680-11D1-A3B4-00C04FB950DC}']
    function  Get_PostalAddress(out retval: OleVariant): HResult; stdcall;
    function  Set_PostalAddress(retval: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsPostalAddressDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7ADECF29-4680-11D1-A3B4-00C04FB950DC}
// *********************************************************************//
  IADsPostalAddressDisp = dispinterface
    ['{7ADECF29-4680-11D1-A3B4-00C04FB950DC}']
    function  PostalAddress: OleVariant; dispid 2;
  end;

// *********************************************************************//
// Interface: IADsBackLink
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FD1302BD-4080-11D1-A3AC-00C04FB950DC}
// *********************************************************************//
  IADsBackLink = interface(IDispatch)
    ['{FD1302BD-4080-11D1-A3AC-00C04FB950DC}']
    function  Get_RemoteID(out retval: Integer): HResult; stdcall;
    function  Set_RemoteID(retval: Integer): HResult; stdcall;
    function  Get_ObjectName(out retval: WideString): HResult; stdcall;
    function  Set_ObjectName(const retval: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsBackLinkDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FD1302BD-4080-11D1-A3AC-00C04FB950DC}
// *********************************************************************//
  IADsBackLinkDisp = dispinterface
    ['{FD1302BD-4080-11D1-A3AC-00C04FB950DC}']
    function  RemoteID: Integer; dispid 2;
    function  ObjectName: WideString; dispid 3;
  end;

// *********************************************************************//
// Interface: IADsTypedName
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B371A349-4080-11D1-A3AC-00C04FB950DC}
// *********************************************************************//
  IADsTypedName = interface(IDispatch)
    ['{B371A349-4080-11D1-A3AC-00C04FB950DC}']
    function  Get_ObjectName(out retval: WideString): HResult; stdcall;
    function  Set_ObjectName(const retval: WideString): HResult; stdcall;
    function  Get_Level(out retval: Integer): HResult; stdcall;
    function  Set_Level(retval: Integer): HResult; stdcall;
    function  Get_Interval(out retval: Integer): HResult; stdcall;
    function  Set_Interval(retval: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsTypedNameDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B371A349-4080-11D1-A3AC-00C04FB950DC}
// *********************************************************************//
  IADsTypedNameDisp = dispinterface
    ['{B371A349-4080-11D1-A3AC-00C04FB950DC}']
    function  ObjectName: WideString; dispid 2;
    function  Level: Integer; dispid 3;
    function  Interval: Integer; dispid 4;
  end;

// *********************************************************************//
// Interface: IADsHold
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B3EB3B37-4080-11D1-A3AC-00C04FB950DC}
// *********************************************************************//
  IADsHold = interface(IDispatch)
    ['{B3EB3B37-4080-11D1-A3AC-00C04FB950DC}']
    function  Get_ObjectName(out retval: WideString): HResult; stdcall;
    function  Set_ObjectName(const retval: WideString): HResult; stdcall;
    function  Get_Amount(out retval: Integer): HResult; stdcall;
    function  Set_Amount(retval: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsHoldDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B3EB3B37-4080-11D1-A3AC-00C04FB950DC}
// *********************************************************************//
  IADsHoldDisp = dispinterface
    ['{B3EB3B37-4080-11D1-A3AC-00C04FB950DC}']
    function  ObjectName: WideString; dispid 2;
    function  Amount: Integer; dispid 3;
  end;

// *********************************************************************//
// Interface: IADsObjectOptions
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {46F14FDA-232B-11D1-A808-00C04FD8D5A8}
// *********************************************************************//
  IADsObjectOptions = interface(IDispatch)
    ['{46F14FDA-232B-11D1-A808-00C04FD8D5A8}']
    function  GetOption(lnOption: Integer; out pvValue: OleVariant): HResult; stdcall;
    function  SetOption(lnOption: Integer; vValue: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsObjectOptionsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {46F14FDA-232B-11D1-A808-00C04FD8D5A8}
// *********************************************************************//
  IADsObjectOptionsDisp = dispinterface
    ['{46F14FDA-232B-11D1-A808-00C04FD8D5A8}']
    function  GetOption(lnOption: Integer): OleVariant; dispid 2;
    procedure SetOption(lnOption: Integer; vValue: OleVariant); dispid 3;
  end;

// *********************************************************************//
// Interface: IADsPathname
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D592AED4-F420-11D0-A36E-00C04FB950DC}
// *********************************************************************//
  IADsPathname = interface(IDispatch)
    ['{D592AED4-F420-11D0-A36E-00C04FB950DC}']
    function  Set_(const bstrADsPath: WideString; lnSetType: Integer): HResult; stdcall;
    function  SetDisplayType(lnDisplayType: Integer): HResult; stdcall;
    function  Retrieve(lnFormatType: Integer; out pbstrADsPath: WideString): HResult; stdcall;
    function  GetNumElements(out plnNumPathElements: Integer): HResult; stdcall;
    function  GetElement(lnElementIndex: Integer; out pbstrElement: WideString): HResult; stdcall;
    function  AddLeafElement(const bstrLeafElement: WideString): HResult; stdcall;
    function  RemoveLeafElement: HResult; stdcall;
    function  CopyPath(out ppAdsPath: IDispatch): HResult; stdcall;
    function  GetEscapedElement(lnReserved: Integer; const bstrInStr: WideString; 
                                out pbstrOutStr: WideString): HResult; stdcall;
    function  Get_EscapedMode(out retval: Integer): HResult; stdcall;
    function  Set_EscapedMode(retval: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsPathnameDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D592AED4-F420-11D0-A36E-00C04FB950DC}
// *********************************************************************//
  IADsPathnameDisp = dispinterface
    ['{D592AED4-F420-11D0-A36E-00C04FB950DC}']
    procedure Set_(const bstrADsPath: WideString; lnSetType: Integer); dispid 2;
    procedure SetDisplayType(lnDisplayType: Integer); dispid 3;
    function  Retrieve(lnFormatType: Integer): WideString; dispid 4;
    function  GetNumElements: Integer; dispid 5;
    function  GetElement(lnElementIndex: Integer): WideString; dispid 6;
    procedure AddLeafElement(const bstrLeafElement: WideString); dispid 7;
    procedure RemoveLeafElement; dispid 8;
    function  CopyPath: IDispatch; dispid 9;
    function  GetEscapedElement(lnReserved: Integer; const bstrInStr: WideString): WideString; dispid 10;
    function  EscapedMode: Integer; dispid 11;
  end;

// *********************************************************************//
// Interface: IADsADSystemInfo
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5BB11929-AFD1-11D2-9CB9-0000F87A369E}
// *********************************************************************//
  IADsADSystemInfo = interface(IDispatch)
    ['{5BB11929-AFD1-11D2-9CB9-0000F87A369E}']
    function  Get_UserName(out retval: WideString): HResult; stdcall;
    function  Get_ComputerName(out retval: WideString): HResult; stdcall;
    function  Get_SiteName(out retval: WideString): HResult; stdcall;
    function  Get_DomainShortName(out retval: WideString): HResult; stdcall;
    function  Get_DomainDNSName(out retval: WideString): HResult; stdcall;
    function  Get_ForestDNSName(out retval: WideString): HResult; stdcall;
    function  Get_PDCRoleOwner(out retval: WideString): HResult; stdcall;
    function  Get_SchemaRoleOwner(out retval: WideString): HResult; stdcall;
    function  Get_IsNativeMode(out retval: WordBool): HResult; stdcall;
    function  GetAnyDCName(out pszDCName: WideString): HResult; stdcall;
    function  GetDCSiteName(const szServer: WideString; out pszSiteName: WideString): HResult; stdcall;
    function  RefreshSchemaCache: HResult; stdcall;
    function  GetTrees(out pvTrees: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsADSystemInfoDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5BB11929-AFD1-11D2-9CB9-0000F87A369E}
// *********************************************************************//
  IADsADSystemInfoDisp = dispinterface
    ['{5BB11929-AFD1-11D2-9CB9-0000F87A369E}']
    property UserName: WideString readonly dispid 2;
    property ComputerName: WideString readonly dispid 3;
    property SiteName: WideString readonly dispid 4;
    property DomainShortName: WideString readonly dispid 5;
    property DomainDNSName: WideString readonly dispid 6;
    property ForestDNSName: WideString readonly dispid 7;
    property PDCRoleOwner: WideString readonly dispid 8;
    property SchemaRoleOwner: WideString readonly dispid 9;
    property IsNativeMode: WordBool readonly dispid 10;
    function  GetAnyDCName: WideString; dispid 11;
    function  GetDCSiteName(const szServer: WideString): WideString; dispid 12;
    procedure RefreshSchemaCache; dispid 13;
    function  GetTrees: OleVariant; dispid 14;
  end;

// *********************************************************************//
// Interface: IADsWinNTSystemInfo
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6C6D65DC-AFD1-11D2-9CB9-0000F87A369E}
// *********************************************************************//
  IADsWinNTSystemInfo = interface(IDispatch)
    ['{6C6D65DC-AFD1-11D2-9CB9-0000F87A369E}']
    function  Get_UserName(out retval: WideString): HResult; stdcall;
    function  Get_ComputerName(out retval: WideString): HResult; stdcall;
    function  Get_DomainName(out retval: WideString): HResult; stdcall;
    function  Get_PDC(out retval: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsWinNTSystemInfoDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6C6D65DC-AFD1-11D2-9CB9-0000F87A369E}
// *********************************************************************//
  IADsWinNTSystemInfoDisp = dispinterface
    ['{6C6D65DC-AFD1-11D2-9CB9-0000F87A369E}']
    property UserName: WideString readonly dispid 2;
    property ComputerName: WideString readonly dispid 3;
    property DomainName: WideString readonly dispid 4;
    property PDC: WideString readonly dispid 5;
  end;

// *********************************************************************//
// Interface: IADsDNWithBinary
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7E99C0A2-F935-11D2-BA96-00C04FB6D0D1}
// *********************************************************************//
  IADsDNWithBinary = interface(IDispatch)
    ['{7E99C0A2-F935-11D2-BA96-00C04FB6D0D1}']
    function  Get_BinaryValue(out retval: OleVariant): HResult; stdcall;
    function  Set_BinaryValue(retval: OleVariant): HResult; stdcall;
    function  Get_DNString(out retval: WideString): HResult; stdcall;
    function  Set_DNString(const retval: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsDNWithBinaryDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7E99C0A2-F935-11D2-BA96-00C04FB6D0D1}
// *********************************************************************//
  IADsDNWithBinaryDisp = dispinterface
    ['{7E99C0A2-F935-11D2-BA96-00C04FB6D0D1}']
    function  BinaryValue: OleVariant; dispid 2;
    function  DNString: WideString; dispid 3;
  end;

// *********************************************************************//
// Interface: IADsDNWithString
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {370DF02E-F934-11D2-BA96-00C04FB6D0D1}
// *********************************************************************//
  IADsDNWithString = interface(IDispatch)
    ['{370DF02E-F934-11D2-BA96-00C04FB6D0D1}']
    function  Get_StringValue(out retval: WideString): HResult; stdcall;
    function  Set_StringValue(const retval: WideString): HResult; stdcall;
    function  Get_DNString(out retval: WideString): HResult; stdcall;
    function  Set_DNString(const retval: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  IADsDNWithStringDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {370DF02E-F934-11D2-BA96-00C04FB6D0D1}
// *********************************************************************//
  IADsDNWithStringDisp = dispinterface
    ['{370DF02E-F934-11D2-BA96-00C04FB6D0D1}']
    function  StringValue: WideString; dispid 2;
    function  DNString: WideString; dispid 3;
  end;

// *********************************************************************//
// The Class CoPropertyEntry provides a Create and CreateRemote method to          
// create instances of the default interface IADsPropertyEntry exposed by              
// the CoClass PropertyEntry. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPropertyEntry = class
    class function Create: IADsPropertyEntry;
    class function CreateRemote(const MachineName: string): IADsPropertyEntry;
  end;

// *********************************************************************//
// The Class CoPropertyValue provides a Create and CreateRemote method to          
// create instances of the default interface IADsPropertyValue exposed by              
// the CoClass PropertyValue. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPropertyValue = class
    class function Create: IADsPropertyValue;
    class function CreateRemote(const MachineName: string): IADsPropertyValue;
  end;

// *********************************************************************//
// The Class CoAccessControlEntry provides a Create and CreateRemote method to          
// create instances of the default interface IADsAccessControlEntry exposed by              
// the CoClass AccessControlEntry. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAccessControlEntry = class
    class function Create: IADsAccessControlEntry;
    class function CreateRemote(const MachineName: string): IADsAccessControlEntry;
  end;

// *********************************************************************//
// The Class CoAccessControlList provides a Create and CreateRemote method to          
// create instances of the default interface IADsAccessControlList exposed by              
// the CoClass AccessControlList. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAccessControlList = class
    class function Create: IADsAccessControlList;
    class function CreateRemote(const MachineName: string): IADsAccessControlList;
  end;

// *********************************************************************//
// The Class CoSecurityDescriptor provides a Create and CreateRemote method to          
// create instances of the default interface IADsSecurityDescriptor exposed by              
// the CoClass SecurityDescriptor. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSecurityDescriptor = class
    class function Create: IADsSecurityDescriptor;
    class function CreateRemote(const MachineName: string): IADsSecurityDescriptor;
  end;

// *********************************************************************//
// The Class CoLargeInteger provides a Create and CreateRemote method to          
// create instances of the default interface IADsLargeInteger exposed by              
// the CoClass LargeInteger. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoLargeInteger = class
    class function Create: IADsLargeInteger;
    class function CreateRemote(const MachineName: string): IADsLargeInteger;
  end;

// *********************************************************************//
// The Class CoNameTranslate provides a Create and CreateRemote method to          
// create instances of the default interface IADsNameTranslate exposed by              
// the CoClass NameTranslate. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoNameTranslate = class
    class function Create: IADsNameTranslate;
    class function CreateRemote(const MachineName: string): IADsNameTranslate;
  end;

// *********************************************************************//
// The Class CoCaseIgnoreList provides a Create and CreateRemote method to          
// create instances of the default interface IADsCaseIgnoreList exposed by              
// the CoClass CaseIgnoreList. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCaseIgnoreList = class
    class function Create: IADsCaseIgnoreList;
    class function CreateRemote(const MachineName: string): IADsCaseIgnoreList;
  end;

// *********************************************************************//
// The Class CoFaxNumber provides a Create and CreateRemote method to          
// create instances of the default interface IADsFaxNumber exposed by              
// the CoClass FaxNumber. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoFaxNumber = class
    class function Create: IADsFaxNumber;
    class function CreateRemote(const MachineName: string): IADsFaxNumber;
  end;

// *********************************************************************//
// The Class CoNetAddress provides a Create and CreateRemote method to          
// create instances of the default interface IADsNetAddress exposed by              
// the CoClass NetAddress. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoNetAddress = class
    class function Create: IADsNetAddress;
    class function CreateRemote(const MachineName: string): IADsNetAddress;
  end;

// *********************************************************************//
// The Class CoOctetList provides a Create and CreateRemote method to          
// create instances of the default interface IADsOctetList exposed by              
// the CoClass OctetList. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoOctetList = class
    class function Create: IADsOctetList;
    class function CreateRemote(const MachineName: string): IADsOctetList;
  end;

// *********************************************************************//
// The Class CoEmail provides a Create and CreateRemote method to          
// create instances of the default interface IADsEmail exposed by              
// the CoClass Email. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoEmail = class
    class function Create: IADsEmail;
    class function CreateRemote(const MachineName: string): IADsEmail;
  end;

// *********************************************************************//
// The Class CoPath provides a Create and CreateRemote method to          
// create instances of the default interface IADsPath exposed by              
// the CoClass Path. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPath = class
    class function Create: IADsPath;
    class function CreateRemote(const MachineName: string): IADsPath;
  end;

// *********************************************************************//
// The Class CoReplicaPointer provides a Create and CreateRemote method to          
// create instances of the default interface IADsReplicaPointer exposed by              
// the CoClass ReplicaPointer. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoReplicaPointer = class
    class function Create: IADsReplicaPointer;
    class function CreateRemote(const MachineName: string): IADsReplicaPointer;
  end;

// *********************************************************************//
// The Class CoAcl provides a Create and CreateRemote method to          
// create instances of the default interface IADsAcl exposed by              
// the CoClass Acl. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAcl = class
    class function Create: IADsAcl;
    class function CreateRemote(const MachineName: string): IADsAcl;
  end;

// *********************************************************************//
// The Class CoTimestamp provides a Create and CreateRemote method to          
// create instances of the default interface IADsTimestamp exposed by              
// the CoClass Timestamp. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTimestamp = class
    class function Create: IADsTimestamp;
    class function CreateRemote(const MachineName: string): IADsTimestamp;
  end;

// *********************************************************************//
// The Class CoPostalAddress provides a Create and CreateRemote method to          
// create instances of the default interface IADsPostalAddress exposed by              
// the CoClass PostalAddress. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPostalAddress = class
    class function Create: IADsPostalAddress;
    class function CreateRemote(const MachineName: string): IADsPostalAddress;
  end;

// *********************************************************************//
// The Class CoBackLink provides a Create and CreateRemote method to          
// create instances of the default interface IADsBackLink exposed by              
// the CoClass BackLink. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBackLink = class
    class function Create: IADsBackLink;
    class function CreateRemote(const MachineName: string): IADsBackLink;
  end;

// *********************************************************************//
// The Class CoTypedName provides a Create and CreateRemote method to          
// create instances of the default interface IADsTypedName exposed by              
// the CoClass TypedName. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTypedName = class
    class function Create: IADsTypedName;
    class function CreateRemote(const MachineName: string): IADsTypedName;
  end;

// *********************************************************************//
// The Class CoHold provides a Create and CreateRemote method to          
// create instances of the default interface IADsHold exposed by              
// the CoClass Hold. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoHold = class
    class function Create: IADsHold;
    class function CreateRemote(const MachineName: string): IADsHold;
  end;

// *********************************************************************//
// The Class CoPathname provides a Create and CreateRemote method to          
// create instances of the default interface IADsPathname exposed by              
// the CoClass Pathname. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPathname = class
    class function Create: IADsPathname;
    class function CreateRemote(const MachineName: string): IADsPathname;
  end;

// *********************************************************************//
// The Class CoADSystemInfo provides a Create and CreateRemote method to          
// create instances of the default interface IADsADSystemInfo exposed by              
// the CoClass ADSystemInfo. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoADSystemInfo = class
    class function Create: IADsADSystemInfo;
    class function CreateRemote(const MachineName: string): IADsADSystemInfo;
  end;

// *********************************************************************//
// The Class CoWinNTSystemInfo provides a Create and CreateRemote method to          
// create instances of the default interface IADsWinNTSystemInfo exposed by              
// the CoClass WinNTSystemInfo. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoWinNTSystemInfo = class
    class function Create: IADsWinNTSystemInfo;
    class function CreateRemote(const MachineName: string): IADsWinNTSystemInfo;
  end;

// *********************************************************************//
// The Class CoDNWithBinary provides a Create and CreateRemote method to          
// create instances of the default interface IADsDNWithBinary exposed by              
// the CoClass DNWithBinary. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDNWithBinary = class
    class function Create: IADsDNWithBinary;
    class function CreateRemote(const MachineName: string): IADsDNWithBinary;
  end;

// *********************************************************************//
// The Class CoDNWithString provides a Create and CreateRemote method to          
// create instances of the default interface IADsDNWithString exposed by              
// the CoClass DNWithString. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDNWithString = class
    class function Create: IADsDNWithString;
    class function CreateRemote(const MachineName: string): IADsDNWithString;
  end;

implementation

uses ComObj;

class function CoPropertyEntry.Create: IADsPropertyEntry;
begin
  Result := CreateComObject(CLASS_PropertyEntry) as IADsPropertyEntry;
end;

class function CoPropertyEntry.CreateRemote(const MachineName: string): IADsPropertyEntry;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PropertyEntry) as IADsPropertyEntry;
end;

class function CoPropertyValue.Create: IADsPropertyValue;
begin
  Result := CreateComObject(CLASS_PropertyValue) as IADsPropertyValue;
end;

class function CoPropertyValue.CreateRemote(const MachineName: string): IADsPropertyValue;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PropertyValue) as IADsPropertyValue;
end;

class function CoAccessControlEntry.Create: IADsAccessControlEntry;
begin
  Result := CreateComObject(CLASS_AccessControlEntry) as IADsAccessControlEntry;
end;

class function CoAccessControlEntry.CreateRemote(const MachineName: string): IADsAccessControlEntry;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AccessControlEntry) as IADsAccessControlEntry;
end;

class function CoAccessControlList.Create: IADsAccessControlList;
begin
  Result := CreateComObject(CLASS_AccessControlList) as IADsAccessControlList;
end;

class function CoAccessControlList.CreateRemote(const MachineName: string): IADsAccessControlList;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AccessControlList) as IADsAccessControlList;
end;

class function CoSecurityDescriptor.Create: IADsSecurityDescriptor;
begin
  Result := CreateComObject(CLASS_SecurityDescriptor) as IADsSecurityDescriptor;
end;

class function CoSecurityDescriptor.CreateRemote(const MachineName: string): IADsSecurityDescriptor;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SecurityDescriptor) as IADsSecurityDescriptor;
end;

class function CoLargeInteger.Create: IADsLargeInteger;
begin
  Result := CreateComObject(CLASS_LargeInteger) as IADsLargeInteger;
end;

class function CoLargeInteger.CreateRemote(const MachineName: string): IADsLargeInteger;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_LargeInteger) as IADsLargeInteger;
end;

class function CoNameTranslate.Create: IADsNameTranslate;
begin
  Result := CreateComObject(CLASS_NameTranslate) as IADsNameTranslate;
end;

class function CoNameTranslate.CreateRemote(const MachineName: string): IADsNameTranslate;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_NameTranslate) as IADsNameTranslate;
end;

class function CoCaseIgnoreList.Create: IADsCaseIgnoreList;
begin
  Result := CreateComObject(CLASS_CaseIgnoreList) as IADsCaseIgnoreList;
end;

class function CoCaseIgnoreList.CreateRemote(const MachineName: string): IADsCaseIgnoreList;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CaseIgnoreList) as IADsCaseIgnoreList;
end;

class function CoFaxNumber.Create: IADsFaxNumber;
begin
  Result := CreateComObject(CLASS_FaxNumber) as IADsFaxNumber;
end;

class function CoFaxNumber.CreateRemote(const MachineName: string): IADsFaxNumber;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FaxNumber) as IADsFaxNumber;
end;

class function CoNetAddress.Create: IADsNetAddress;
begin
  Result := CreateComObject(CLASS_NetAddress) as IADsNetAddress;
end;

class function CoNetAddress.CreateRemote(const MachineName: string): IADsNetAddress;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_NetAddress) as IADsNetAddress;
end;

class function CoOctetList.Create: IADsOctetList;
begin
  Result := CreateComObject(CLASS_OctetList) as IADsOctetList;
end;

class function CoOctetList.CreateRemote(const MachineName: string): IADsOctetList;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_OctetList) as IADsOctetList;
end;

class function CoEmail.Create: IADsEmail;
begin
  Result := CreateComObject(CLASS_Email) as IADsEmail;
end;

class function CoEmail.CreateRemote(const MachineName: string): IADsEmail;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Email) as IADsEmail;
end;

class function CoPath.Create: IADsPath;
begin
  Result := CreateComObject(CLASS_Path) as IADsPath;
end;

class function CoPath.CreateRemote(const MachineName: string): IADsPath;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Path) as IADsPath;
end;

class function CoReplicaPointer.Create: IADsReplicaPointer;
begin
  Result := CreateComObject(CLASS_ReplicaPointer) as IADsReplicaPointer;
end;

class function CoReplicaPointer.CreateRemote(const MachineName: string): IADsReplicaPointer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ReplicaPointer) as IADsReplicaPointer;
end;

class function CoAcl.Create: IADsAcl;
begin
  Result := CreateComObject(CLASS_Acl) as IADsAcl;
end;

class function CoAcl.CreateRemote(const MachineName: string): IADsAcl;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Acl) as IADsAcl;
end;

class function CoTimestamp.Create: IADsTimestamp;
begin
  Result := CreateComObject(CLASS_Timestamp) as IADsTimestamp;
end;

class function CoTimestamp.CreateRemote(const MachineName: string): IADsTimestamp;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Timestamp) as IADsTimestamp;
end;

class function CoPostalAddress.Create: IADsPostalAddress;
begin
  Result := CreateComObject(CLASS_PostalAddress) as IADsPostalAddress;
end;

class function CoPostalAddress.CreateRemote(const MachineName: string): IADsPostalAddress;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PostalAddress) as IADsPostalAddress;
end;

class function CoBackLink.Create: IADsBackLink;
begin
  Result := CreateComObject(CLASS_BackLink) as IADsBackLink;
end;

class function CoBackLink.CreateRemote(const MachineName: string): IADsBackLink;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BackLink) as IADsBackLink;
end;

class function CoTypedName.Create: IADsTypedName;
begin
  Result := CreateComObject(CLASS_TypedName) as IADsTypedName;
end;

class function CoTypedName.CreateRemote(const MachineName: string): IADsTypedName;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TypedName) as IADsTypedName;
end;

class function CoHold.Create: IADsHold;
begin
  Result := CreateComObject(CLASS_Hold) as IADsHold;
end;

class function CoHold.CreateRemote(const MachineName: string): IADsHold;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Hold) as IADsHold;
end;

class function CoPathname.Create: IADsPathname;
begin
  Result := CreateComObject(CLASS_Pathname) as IADsPathname;
end;

class function CoPathname.CreateRemote(const MachineName: string): IADsPathname;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Pathname) as IADsPathname;
end;

class function CoADSystemInfo.Create: IADsADSystemInfo;
begin
  Result := CreateComObject(CLASS_ADSystemInfo) as IADsADSystemInfo;
end;

class function CoADSystemInfo.CreateRemote(const MachineName: string): IADsADSystemInfo;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ADSystemInfo) as IADsADSystemInfo;
end;

class function CoWinNTSystemInfo.Create: IADsWinNTSystemInfo;
begin
  Result := CreateComObject(CLASS_WinNTSystemInfo) as IADsWinNTSystemInfo;
end;

class function CoWinNTSystemInfo.CreateRemote(const MachineName: string): IADsWinNTSystemInfo;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_WinNTSystemInfo) as IADsWinNTSystemInfo;
end;

class function CoDNWithBinary.Create: IADsDNWithBinary;
begin
  Result := CreateComObject(CLASS_DNWithBinary) as IADsDNWithBinary;
end;

class function CoDNWithBinary.CreateRemote(const MachineName: string): IADsDNWithBinary;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DNWithBinary) as IADsDNWithBinary;
end;

class function CoDNWithString.Create: IADsDNWithString;
begin
  Result := CreateComObject(CLASS_DNWithString) as IADsDNWithString;
end;

class function CoDNWithString.CreateRemote(const MachineName: string): IADsDNWithString;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DNWithString) as IADsDNWithString;
end;

end.
