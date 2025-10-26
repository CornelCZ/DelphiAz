unit AdsBrowser;

interface
{$I DEFINE.INC}

{$NOINCLUDE ActiveDS}
{$HPPEMIT '#include <oaidl.h>'}
{$HPPEMIT 'typedef IAdsClass*  _di_IAdsClass;'}


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActiveDsTLB, ActiveDS, ActiveX,
  {$IFDEF Delphi6}
  Variants,
  {$ENDIF}
  AdsErr, AdsUtil;

type
  TAdsBrowser = class;
  TAdsClassInfo = class;
  TAdsCredentials  = class;
  TAdsPropertyInfo = class;
  TAdsVariants = class;

  TAdsPropertyType = (adspMandatory, adspOptional, adspNaming, adspAny);

  TAdsVariants = class(TPersistent)
  private
    FItems:   Variant;
    FOnChange: TNotifyEvent;
    function  GetCount: integer;
    function  GetItem(AIndex: integer): variant;
    procedure SetItem(AIndex: integer; const Value: variant);
    procedure CheckBounds(AIndex: integer);
    function  GetItems: Variant;
    procedure SetItems(const Value: Variant);
    procedure Notify;
  public
    constructor Create;
    function    Add(Value: variant): integer;
    procedure   Insert(Value: variant; AIndex: integer);
    procedure   Delete(AIndex: integer);
    procedure   Clear;
    procedure   Assign(ASource: TPersistent); override;
    property    Count: integer read GetCount;
    property    Items: Variant read GetItems write SetItems;
    property    Item[AIndex: integer]: Variant read GetItem write SetItem; default;
  published
    property    OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdsPropertyInfo = class(TPersistent)
  private
    FName:          widestring;
    FOwner:         TAdsBrowser;
    FValues:        TAdsVariants;
    FPropertyEntry: IAdsPropertyEntry;
    FAdsProperty:   IAdsProperty;

    function  GetPropertyType: integer;
    procedure SetName(const Value: widestring);
    procedure SetPropertyType(const Value: integer);
    function  GetValue: Variant;
    procedure SetValue(const Value: Variant);
    function  ObtainPropertyEntry: boolean;
    function  GetIsMultiValued: wordbool;
    procedure SetIsMultiValued(const Value: wordbool);
    function  ObtainAdsProperty: boolean;
    function  GetValues: TAdsVariants;
    procedure SetValues(const Value: TAdsVariants);
    procedure ValuesChanged(ASender: TObject);
    function  GetMaxRange: integer;
    function  GetMinRange: integer;
    procedure SetMaxRange(const Value: integer);
    procedure SetMinRange(const Value: integer);
    function  GetSyntax: widestring;
    procedure SetSyntax(const Value: widestring);
  public
    constructor Create(AOwner: TAdsBrowser);
    procedure   Clear;
    function    GetOwner: TAdsBrowser; reintroduce;
    destructor  Destroy; override;
  published
    property Name: widestring read FName write SetName;
    property PropertyType: integer read GetPropertyType write SetPropertyType stored false;
    property Value: Variant read GetValue write SetValue stored false;
    property Values: TAdsVariants read GetValues write SetValues stored false; 
    property IsMultiValued: wordbool read GetIsMultiValued write SetIsMultiValued stored false;
    property MinRange: integer read GetMinRange write SetMinRange;
    property MaxRange: integer read GetMaxRange write SetMaxRange;
    property Syntax: widestring read GetSyntax write SetSyntax;
  end;

  TAdsCredentials = class(TPersistent)
  private
    FUserName: widestring;
    FPassword: widestring;
    FAuthentication: DWORD;
  protected
  public
    procedure   Clear;
    procedure   Assign(Source: TPersistent); override;
    function    IsEmpty: boolean;
  published
    property UserName: widestring read FUserName write FUserName;
    property Password: widestring read FPassword write FPassword;
    property Authentication: DWORD read FAuthentication write FAuthentication;
  end;

  TAdsClassInfo = class(TPersistent)
  private
    FOwner:       TAdsBrowser;
    FAdsClass:    IAdsClass;
    FDerivedFrom: TStrings;
    FContainment:  TStrings;
    FOptionalProperties: TStrings;
    FMandatoryProperties: TStrings;
    FNamingProperties: TStrings;
    FPossibleSuperiors: TStrings;
    function  GetIsAbstract: wordbool;
    function  GetDerivedFrom: TStrings;
    function  GetAdsClass: boolean;
    function  GetIsAuxilary: wordbool;
    function  GetCLSID: widestring;
    function  GetIsContainer: wordbool;
    function  GetContainment: TStrings;
    function  GetHelpContext: integer;
    function  GetHelpFileName: widestring;
    function  GetOptionalProperties: TStrings;
    function  GetMandatoryProperties: TStrings;
    function  GetNamingProperties: TStrings;
    function  GetObjectId: widestring;
    function  GetPossibleSuperiors: TStrings;
    function  GetPrimaryInterface: widestring;
    procedure SetPrimaryInterface(const Value: widestring);
    procedure SetPossibleSuperiors(const Value: TStrings);
    procedure SetObjectId(const Value: widestring);
    procedure SetNamingProperties(const Value: TStrings);
    procedure SetMandatoryProperties(const Value: TStrings);
    procedure SetOptionalProperties(const Value: TStrings);
    procedure SetHelpFileName(const Value: widestring);
    procedure SetHelpContext(const Value: integer);
    procedure SetContainment(const Value: TStrings);
    procedure SetIsContainer(const Value: wordbool);
    procedure SetCLSID(const Value: widestring);
    procedure SetIsAuxilary(const Value: wordbool);
    procedure SetDerivedFrom(const Value: TStrings);
    procedure SetIsAbstract(const Value: wordbool);
    function  IsDesignTime: boolean;
  protected
    procedure Clear;
  public
    constructor Create(AOwner: TAdsBrowser);
    destructor  Destroy; override;
    function    GetClass: IAdsClass;
  published
    property IsAbstract: wordbool read GetIsAbstract write SetIsAbstract;
    property DerivedFrom: TStrings read GetDerivedFrom write SetDerivedFrom;
    property IsAuxilary: wordbool read GetIsAuxilary write SetIsAuxilary;
    property IsContainer: wordbool read GetIsContainer write SetIsContainer;
    property CLSID: widestring read GetCLSID write SetCLSID;
    property Containment: TStrings read GetContainment write SetContainment;
    property HelpConext: integer read GetHelpContext write SetHelpContext;
    property HelpFileName: widestring read GetHelpFileName write SetHelpFileName;
    property OptionalProperties: TStrings read GetOptionalProperties write SetOptionalProperties;
    property MandatoryProperties: TStrings read GetMandatoryProperties write SetMandatoryProperties;
    property NamingProperties: TStrings read GetNamingProperties write SetNamingProperties;
    property PossibleSuperiors: TStrings read GetPossibleSuperiors write SetPossibleSuperiors;
    property ObjectId: widestring read GetObjectId write SetObjectId;
    property PrimaryInterface: widestring read GetPrimaryInterface write SetPrimaryInterface;
  end;

  TAdsBrowser = class(TComponent)
  private
    FObjectPath:      widestring;
    FActive:          boolean;
    FObject:          IAds;
    FNameTranslator:  IAdsNameTranslate;
    FContainer:       IAdsContainer;
    FAdsClassInfo:       TAdsClassInfo;
    FAutoCommit:      boolean;
    FChildFilter:     widestring;
    FChildItems:      TStrings;
    FSystemInfo:      TAdsSystemInfo;
    FCredentials: TAdsCredentials;
    FPropertyInfo: TAdsPropertyInfo;

    function   GetObjectPath: widestring;
    procedure  SetObjectPath(const Value: widestring);
    procedure  SetActive(const Value: boolean);
    function   GetObjectClassName: widestring;
    procedure  SetObjectClassName(const Value: widestring);
    // function GetObjectGUID: widestring;
    // procedure SetObjectGUID(const Value: widestring);
    procedure  SetAdsClassInfo(const Value: TAdsClassInfo);
    function   GetParentObjectPath: widestring;
    procedure  SetParentObjectPath(const Value: widestring);
    function   GetNameTranslator: IADsNameTranslate;
    procedure  SetChildFilter(const Value: widestring);
    procedure  SetChildItems(const Value: TStrings);
    function   GetChildItems: TStrings;
    function   GetContainerInterface: boolean;
    procedure  SetSystemInfo(const Value: TAdsSystemInfo);
    procedure  SetCredentials(const Value: TAdsCredentials);
    procedure  SetPropertyInfo(const Value: TAdsPropertyInfo);
    procedure LoadObjectInfo;
    { Private declarations }
  protected
    { Protected declarations }
    property  NameTranslator: IADsNameTranslate read GetNameTranslator;
    function  IsDesignTime: boolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
//    procedure   GetAdsPropertyNames(AStrings: TStrings); overload;
//    procedure   GetAdsPropertyNames(AStrings: TStrings; AType: TAdsPropertyType); overload;
    procedure   Commit;
    procedure   GetNameSpaces(AList: TStrings);
    function    TranslateObjectName(ASourceName: widestring; ASourceFormat: integer;
                                    ADestFormat: integer): widestring;
    function    GetPropertyInfo(APropertyName: widestring): IAdsProperty;
    procedure   GetAdsPropertyNames(AList: TStrings);

  published
    { Published declarations }
    property ObjectPath: widestring read GetObjectPath write SetObjectPath;
    property ParentObjectPath: widestring read GetParentObjectPath write SetParentObjectPath stored false;
    property Active: boolean read FActive write SetActive;
    property ObjectClassName: widestring read GetObjectClassName write SetObjectClassName;
    property AdsClassInfo: TAdsClassInfo read FAdsClassInfo write SetAdsClassInfo stored false;
    property AutoCommit: boolean read FAutoCommit write FAutoCommit;
    property ChildFilter: widestring read FChildFilter write SetChildFilter;
    property ChildItems: TStrings read GetChildItems write SetChildItems stored false;
    property SystemInfo: TAdsSystemInfo read FSystemInfo write SetSystemInfo stored false;
    property Credentials: TAdsCredentials read FCredentials write SetCredentials;
    property PropertyInfo: TAdsPropertyInfo read FPropertyInfo write SetPropertyInfo;
  end;

function  PropertyValueToString(const AValue: variant; AdsType: integer): string;


implementation

resourcestring
  ARRAY_INDEX_OUT_OF_BOUNDS = 'Array index out of bounds: %d';
  VARIANT_IS_NOT_ARRAY = 'Variant is not array';
  NAME_PROPERTY_IS_REQUIRED = '"Name" property is required.';
  CANNOT_CHANGE_PROPERTY_WHEN_INACTIVE = 'Cannot change property when not active.';

function PropertyValueToString(const AValue: variant; AdsType: integer): string;
type
  TLargeInt = record
    case Integer of
    0: (
      LowPart: DWORD;
      HighPart: Longint);
    1: (
      QuadPart: LONGLONG);
  end;

var
  vLargeIntDiapatch: IADsLargeInteger;
  vLargeInt: TLargeInt;
//  vLowPart64, vHighPart64: int64;
//  vLowPart32, vHighPart32: integer;


begin
  case AdsType of
    ADSTYPE_INVALID:               Result := '';
    ADSTYPE_DN_STRING:             Result := AValue;
    ADSTYPE_CASE_EXACT_STRING:     Result := AValue;
    ADSTYPE_CASE_IGNORE_STRING:    Result := AValue;
    ADSTYPE_PRINTABLE_STRING:      Result := AValue;
    ADSTYPE_NUMERIC_STRING:        Result := AValue;
    ADSTYPE_BOOLEAN:               Result := AValue;
    ADSTYPE_INTEGER:               Result := AValue;
    ADSTYPE_OCTET_STRING:          Result := AValue;
    ADSTYPE_UTC_TIME:              Result := AValue;
    ADSTYPE_LARGE_INTEGER:
      begin
      vLargeIntDiapatch := IUnknown(AValue) as IADsLargeInteger;
      AdsCheck(vLargeIntDiapatch.Get_LowPart(Integer(vLargeInt.LowPart)));
      AdsCheck(vLargeIntDiapatch.Get_HighPart(vLargeInt.HighPart));
//      vLowPart64  := DWORD(vLowPart32);
//      vHighPart64 := DWORD(vHighPart32);
//      vLargeInt   := vLowPart64 + (vHighPart64 * $100000000);
      Result      := IntToStr(vLargeInt.QuadPart);


//      Result := IntToStr(vHighPart64 * $100000000 + vLowPart64);
      end;
    ADSTYPE_PROV_SPECIFIC:         Result := '';
    ADSTYPE_OBJECT_CLASS:          Result := AValue;
    ADSTYPE_CASEIGNORE_LIST:       Result := AValue;
    ADSTYPE_OCTET_LIST:            Result := AValue;
    ADSTYPE_PATH:                  Result := AValue;
    ADSTYPE_POSTALADDRESS:         Result := AValue;
    ADSTYPE_TIMESTAMP:             Result := AValue;
    ADSTYPE_BACKLINK:              Result := AValue;
    ADSTYPE_TYPEDNAME:             Result := AValue;
    ADSTYPE_HOLD:                  Result := AValue;
    ADSTYPE_NETADDRESS:            Result := AValue;
    ADSTYPE_REPLICAPOINTER:        Result := AValue;
    ADSTYPE_FAXNUMBER:             Result := AValue;
    ADSTYPE_EMAIL:                 Result := AValue;
    ADSTYPE_NT_SECURITY_DESCRIPTOR: Result := AValue;
    ADSTYPE_UNKNOWN:                Result := AValue;
    ADSTYPE_DN_WITH_BINARY:         Result := AValue;
    ADSTYPE_DN_WITH_STRING:         Result := AValue;
    else Result := AValue;
  end;
end;

function AdsTypeToVarType(AdsType: integer): integer;
begin
  case AdsType of
    ADSTYPE_INVALID:               Result := varOleStr;
    ADSTYPE_DN_STRING:             Result := varOleStr;
    ADSTYPE_CASE_EXACT_STRING:     Result := varOleStr;
    ADSTYPE_CASE_IGNORE_STRING:    Result := varOleStr;
    ADSTYPE_PRINTABLE_STRING:      Result := varOleStr;
    ADSTYPE_NUMERIC_STRING:        Result := varOleStr;
    ADSTYPE_BOOLEAN:               Result := varBoolean;
    ADSTYPE_INTEGER:               Result := varInteger;
    ADSTYPE_OCTET_STRING:          Result := varOleStr;
    ADSTYPE_UTC_TIME:              Result := varOleStr;
    ADSTYPE_LARGE_INTEGER:         Result := varDispatch;
    ADSTYPE_PROV_SPECIFIC:         Result := varVariant;
    ADSTYPE_OBJECT_CLASS:          Result := varDispatch;
    ADSTYPE_CASEIGNORE_LIST:       Result := varOleStr;
    ADSTYPE_OCTET_LIST:            Result := varOleStr;
    ADSTYPE_PATH:                  Result := varOleStr;
    ADSTYPE_POSTALADDRESS:         Result := varOleStr;
    ADSTYPE_TIMESTAMP:             Result := varDate;
    ADSTYPE_BACKLINK:              Result := varOleStr;
    ADSTYPE_TYPEDNAME:             Result := varOleStr;
    ADSTYPE_HOLD:                  Result := varOleStr;
    ADSTYPE_NETADDRESS:            Result := varOleStr;
    ADSTYPE_REPLICAPOINTER:        Result := varOleStr;
    ADSTYPE_FAXNUMBER:             Result := varOleStr;
    ADSTYPE_EMAIL:                 Result := varOleStr;
    ADSTYPE_NT_SECURITY_DESCRIPTOR: Result := varDispatch;
    ADSTYPE_UNKNOWN:                Result := varVariant;
    ADSTYPE_DN_WITH_BINARY:         Result := varOleStr;
    ADSTYPE_DN_WITH_STRING:         Result := varOleStr;
    else Result := varVariant;
  end;

end;

procedure CheckErrorInStringProperty(AError: HRESULT; var Value: widestring; IsDesignTime: boolean);
begin
  case AError of
    E_ADS_SUCCESS:  Exit;
    {$WARNINGS OFF}
    E_NOTIMPL, E_ADS_PROPERTY_NOT_SUPPORTED:
    {$WARNINGS ON}
      if IsDesignTime then Value := '' else AdsCheck(AError);
    else raise TAdsException.Create(GetAdsErrorString(AError));
  end;
end;

procedure CheckErrorInVariantProperty(AError: HRESULT; var Value: OleVariant; IsDesignTime: boolean);
begin
  case AError of
    E_ADS_SUCCESS:  Exit;
    {$WARNINGS OFF}
    E_NOTIMPL, E_ADS_PROPERTY_NOT_SUPPORTED: 
    {$WARNINGS ON}
      if IsDesignTime then Value := Unassigned else AdsCheck(AError);
    else raise TAdsException.Create(GetAdsErrorString(AError));
  end;
end;

procedure CheckErrorInBooleanProperty(AError: HRESULT; var Value: wordbool; IsDesignTime: boolean);
begin
  case AError of
    E_ADS_SUCCESS:  Exit;
    {$WARNINGS OFF}
    E_NOTIMPL, E_ADS_PROPERTY_NOT_SUPPORTED:
    {$WARNINGS ON}
      if IsDesignTime then Value := false else AdsCheck(AError);
    else raise TAdsException.Create(GetAdsErrorString(AError));
  end;
end;

procedure CheckErrorInIntegerProperty(AError: HRESULT; var Value: integer; IsDesignTime: boolean);
begin
  case AError of
    E_ADS_SUCCESS:  Exit;
    {$WARNINGS OFF}
    E_NOTIMPL, E_ADS_PROPERTY_NOT_SUPPORTED:
    {$WARNINGS ON}
      if IsDesignTime then Value := 0 else AdsCheck(AError);
    else raise TAdsException.Create(GetAdsErrorString(AError));
  end;
end;


{ TAdsBrowser }
function TAdsBrowser.GetObjectPath: widestring;
begin
  Result := FObjectPath;
end;

function TAdsBrowser.GetPropertyInfo(
  APropertyName: widestring): IAdsProperty;
var
  vSchema: widestring;
  vClassParentName: widestring;
  vClass: IAdsClass;
  vContainer: IAdsContainer;
  vDispatch:  IDispatch;
begin
  Result := nil;
  if FObject <> nil then
  begin
    if not Succeeded(FObject.Get_Schema(vSchema)) then Exit;
    if not Succeeded(ADsGetObject(PWideChar(vSchema), IAdsClass, vClass)) then Exit;
    if not Succeeded((vClass as IAds).Get_Parent(vClassParentName)) then Exit;
    if not Succeeded(ADsGetObject(PWideChar(vClassParentName), IADsContainer, vContainer)) then Exit;
    if not Succeeded(vContainer.GetObject('Property', APropertyName, vDispatch)) then Exit;
    Result := vDispatch as IAdsProperty; 
  end else
  begin
    Result := nil;
  end;
end;


procedure TAdsBrowser.SetActive(const Value: boolean);
begin
  if Value <> FActive then
  begin
    if Value then
    begin
      if Trim(FObjectPath) = '' then
        raise TAdsException.Create('ObjectPath property is required');
      if Credentials.IsEmpty then
      begin
        AdsCheck(ADsGetObject(PWideChar(FObjectPath), IADs, FObject));
      end else
      begin
        AdsCheck(ADsOpenObject(PWideChar(FObjectPath),
                               GetWPointer(Credentials.FUserName),
                               GetWPointer(Credentials.FPassword),
                               Credentials.Authentication,
                               IADs,
                               FObject));
      end;
      LoadObjectInfo;
    end else
    begin
      FObject := nil;
      FContainer := nil;
      FAdsClassInfo.Clear;
      FPropertyInfo.Clear;
      FChildItems.Clear;

    end;
    FActive := Value;
  end;
end;

procedure TAdsBrowser.LoadObjectInfo;
var
  vRes: HRESULt;
begin
  if FObject <> nil then
  begin
    vRes := FObject.GetInfo;
    case vRes of
      E_ADS_SUCCESS, E_NOTIMPL: Exit;
      else raise TAdsException.Create(GetAdsErrorString(vRes));
    end;
  end;
end;

procedure TAdsBrowser.SetObjectPath(const Value: widestring);
var
  vWasActive: boolean;
begin
  if Value <> FObjectPath then
  begin
    vWasActive := Active;
    Active := false;
    FObjectPath := Value;
    Active := vWasActive;
  end;
end;

function TAdsBrowser.GetObjectClassName: widestring;
var
  vRes: HRESULT;
begin
  if FObject = nil then Result := '' else
  begin
    vRes := FObject.Get_Class_(Result);
    CheckErrorInStringProperty(vRes, Result, IsDesignTime);
  end;
end;

procedure TAdsBrowser.SetObjectClassName(const Value: widestring);begin end;
procedure TAdsBrowser.SetAdsClassInfo(const Value: TAdsClassInfo);begin end;
procedure TAdsBrowser.SetParentObjectPath(const Value: widestring);begin end;
procedure TAdsBrowser.SetChildItems(const Value: TStrings);begin end;
procedure TAdsBrowser.SetPropertyInfo(const Value: TAdsPropertyInfo);begin end;

(*
function TAdsBrowser.GetObjectGUID: widestring;
begin
  if FObject = nil then Result := ''
    else Result := FObject.GUID;
end;
*)
(*
procedure TAdsBrowser.GetAdsPropertyNames(AStrings: TStrings; AType: TAdsPropertyType);
var
  vSchema: widestring;
  vClass: IADsClass;
  vProps: OleVariant;
  vLowBound, vHighBound, i: integer;
begin
  if AStrings = nil then Exit;
  if FObject <> nil then
  begin
    AdsCheck(FObject.Get_Schema(vSchema));
    AdsCheck(ADsGetObject(PWideChar(vSchema), IID_IADsClass, vClass));
    case AType of
      adspMandatory: AdsCheck(vClass.Get_MandatoryProperties(vProps));
      adspOptional:  AdsCheck(vClass.Get_OptionalProperties(vProps));
      adspNaming:    AdsCheck(vClass.Get_NamingProperties(vProps));
      adspAny:
        begin
        GetAdsPropertyNames(AStrings);
        Exit;
        end;
    end;

    if not VarIsEmpty(vProps) then
    begin
      vLowBound  := VarArrayLowBound(vProps, 1);
      vHighBound := VarArrayHighBound(vProps, 1);
      for i := vLowBound to vHighBound do
        AStrings.Add(vProps[i]);
    end;
  end;
end;


procedure TAdsBrowser.GetAdsPropertyNames(AStrings: TStrings);
begin
  GetAdsPropertyNames(AStrings, adspMandatory);
  GetAdsPropertyNames(AStrings, adspOptional);
  GetAdsPropertyNames(AStrings, adspNaming);
end;
*)

constructor TAdsBrowser.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAdsClassInfo    := TAdsClassInfo.Create(self);
  FAutoCommit   := false;
  FChildItems   := TStringList.Create;
  FSystemInfo   := TAdsSystemInfo.Create;
  FCredentials  := TAdsCredentials.Create;
  FPropertyInfo := TAdsPropertyInfo.Create(self);
end;

destructor TAdsBrowser.Destroy;
begin
  FAdsClassInfo.Free;
  FCredentials.Free; 
  FChildItems.Free;
  FSystemInfo.Free;
  FPropertyInfo.Free;
  inherited;
end;

procedure TAdsBrowser.Commit;
begin
  if FObject <> nil then
  begin
    FObject.SetInfo;
  end;  
end;


procedure TAdsBrowser.GetNameSpaces(AList: TStrings);
var
  vNameSpaces: IADsNamespaces;
begin
  if AList = nil then Exit;
  AdsCheck(ADsGetObject('ADS:', IADsNamespaces, vNameSpaces));
  RetrieveContainedItems(vNameSpaces as IAdsContainer, AList);
end;

function TAdsBrowser.GetParentObjectPath: widestring;
begin
  if FObject = nil then Result := ''
    else AdsCheck(FObject.Get_Parent(Result));
end;

function TAdsBrowser.TranslateObjectName(ASourceName: widestring;
  ASourceFormat, ADestFormat: integer): widestring;
begin
  NameTranslator.Set_(ASourceFormat, ASourceName);
  AdsCheck(NameTranslator.Get(ADestFormat, Result));
end;

function TAdsBrowser.GetNameTranslator: IADsNameTranslate;
begin
  if FNameTranslator = nil then
  begin
    AdsCheck(CoCreateInstance(CLASS_NameTranslate,    nil,
                CLSCTX_INPROC_SERVER,  IAdsNameTranslate,
                FNameTranslator));

    // try to bind to server
    // FNameTranslator.Init(ADS_NAME_INITTYPE_SERVER, 'CE08N500');
    // try to bind to domain that this computer belongs to
    FNameTranslator.Init(ADS_NAME_INITTYPE_DOMAIN, SystemInfo.DomainName);
    // try to bind to global service
    // FNameTranslator.Init(ADS_NAME_INITTYPE_GC, '');
  end;
  Result := FNameTranslator;
end;

procedure TAdsBrowser.SetChildFilter(const Value: widestring);
begin
  if FChildFilter <> Value then
  begin
    FChildFilter := Value;
    FChildItems.Clear;
  end;
end;

function TAdsBrowser.GetContainerInterface: boolean;
begin
  if (FContainer = nil) and (Active) then
    (FObject as IUnknown).QueryInterface(IAdsContainer, FContainer);
  Result := FContainer <> nil;
end;

function TAdsBrowser.GetChildItems: TStrings;
begin
  Result := FChildItems;
  if FChildItems.Count = 0 then
  begin
    if GetContainerInterface then
    begin
      if ChildFilter <> '' then SetContainerFilter(FContainer, FChildFilter);
      RetrieveContainedItems(FContainer, Result);
    end;
  end;
end;

procedure TAdsBrowser.SetSystemInfo(const Value: TAdsSystemInfo);begin end;

function TAdsBrowser.IsDesignTime: boolean;
begin
  Result := csDesigning in ComponentState;
end;

procedure TAdsBrowser.SetCredentials(const Value: TAdsCredentials);
begin
  FCredentials.Assign(Value);
end;

procedure TAdsBrowser.GetAdsPropertyNames(AList: TStrings);
var
  vList: IAdsPropertyList;
  vCount: integer;
  vOleVar: OleVariant;
  i: integer;
begin
  if FObject <> nil then
  begin
    vList := FObject as IAdsPropertyList;
    AdsCheck(vList.Reset);
    AdsCheck(vList.Get_PropertyCount(vCount));
    for i := 0 to vCount - 1 do
    begin
      AdsCheck(vList.Next(vOleVar));
      AList.Add(vOleVar.Name);
    end;
  end;
end;


{ TAdsClassInfo }

procedure TAdsClassInfo.Clear;
begin
  FAdsClass := nil;
end;

constructor TAdsClassInfo.Create(AOwner: TAdsBrowser);
begin
  inherited Create;
  FOwner := AOwner;
  FDerivedFrom := TStringList.Create;
  FContainment  := TStringList.Create;
  FOptionalProperties  := TStringList.Create;
  FMandatoryProperties := TStringList.Create;
  FNamingProperties    := TStringList.Create;
  FPossibleSuperiors   := TStringList.Create;
end;

destructor TAdsClassInfo.Destroy;
begin
  FDerivedFrom.Free;
  FContainment.Free;
  FOptionalProperties.Free;
  FMandatoryProperties.Free;
  FNamingProperties.Free;
  FPossibleSuperiors.Free;
  inherited;
end;


procedure VarArrayToStrings(const AVariant: OleVariant; AStrings: TStrings);
var
  vLowBound, vHighBound, i: integer;
begin
  if not VarIsEmpty(AVariant) then
  begin
    if VarIsArray(AVariant) then
    begin
      vLowBound  := VarArrayLowBound(AVariant, 1);
      vHighBound := VarArrayHighBound(AVariant, 1);
      for i := vLowBound to vHighBound do AStrings.Add(AVariant[i]);
    end else
    begin
      AStrings.Add(VarToStr(AVariant));
    end;
  end;
end;

function TAdsClassInfo.GetDerivedFrom: TStrings;
var
  vVar: OleVariant;
  vRes: HRESULT;
begin
  Result := FDerivedFrom;
  Result.Clear;
  if GetAdsClass then
  begin
    vRes := FAdsClass.Get_DerivedFrom(vVar);
    CheckErrorInVariantProperty(vRes, vVar, IsDesignTime);
    if not VarIsEmpty(vVar) then VarArrayToStrings(vVar, Result);
  end;
end;

function TAdsClassInfo.GetAdsClass: boolean;
var
  vSchema: widestring;
begin
  // the function may return false if unable to retrieve
  // class interface 
  if (FAdsClass = nil) and (FOwner.Active) then
  begin
    try 
      AdsCheck(FOwner.FObject.Get_Schema(vSchema));
      AdsCheck(ADsGetObject(PWideChar(vSchema), IID_IADsClass, FAdsClass));
    except
    end
  end;
  Result := FAdsClass <> nil;
end;

function TAdsClassInfo.GetIsAbstract: wordbool;
var
  vRes: HRESULT;
begin
  if GetAdsClass then
  begin
    vRes := FAdsClass.Get_Abstract(Result);
    CheckErrorInBooleanProperty(vRes, Result, IsDesignTime);
  end else
  begin
    Result := false;
  end;  
end;

function TAdsClassInfo.GetIsAuxilary: wordbool;
var
  vRes: HRESULT;
begin
  if GetAdsClass then
  begin
    vRes := FAdsClass.Get_Auxiliary(Result);
    CheckErrorInBooleanProperty(vRes, Result, IsDesignTime);
  end else
  begin
    Result := false;
  end;  
end;

function TAdsClassInfo.GetCLSID: widestring;
var
  vRes: HRESULT;
begin
  if GetAdsClass then
  begin
    vRes := FAdsClass.Get_CLSID(Result);
    CheckErrorInStringProperty(vRes, Result, IsDesignTime);
  end else
  begin
    Result := '';
  end;  
end;

function TAdsClassInfo.GetIsContainer: wordbool;
var
  vRes: HRESULT;
begin
  if GetAdsClass then
  begin
    vRes := FAdsClass.Get_Container(Result);
    CheckErrorInBooleanProperty(vRes, Result, IsDesignTime);
  end else
  begin
    Result := false;
  end;  
end;

function TAdsClassInfo.GetContainment: TStrings;
var
  vVar: OleVariant;
  vRes: HRESULT;
begin
  Result := FContainment;
  Result.Clear;
  if GetAdsClass then
  begin
    vRes := FAdsClass.Get_Containment(vVar);
    CheckErrorInVariantProperty(vRes, vVar, IsDesignTime);
    if not VarIsEmpty(vVar) then VarArrayToStrings(vVar, result);
  end;
end;

function TAdsClassInfo.GetHelpContext: integer;
var
  vRes: HRESULT;
begin
  if GetAdsClass then
  begin
    vRes := FAdsClass.Get_HelpFileContext(Result);
    CheckErrorInIntegerProperty(vRes, Result, IsDesignTime);
  end else
  begin
    Result := 0;
  end;  
end;

function TAdsClassInfo.GetHelpFileName: widestring;
var
  vRes: HRESULT;
begin
  if GetAdsClass then
  begin
     vRes := FAdsClass.Get_HelpFileName(Result);
     CheckErrorInStringProperty(vRes, Result, IsDesignTime);
  end else
  begin
    Result := '';
  end;  
end;

function TAdsClassInfo.GetOptionalProperties: TStrings;
var
  vOleVar: OleVariant;
  vRes: HRESULT;
begin
  Result := FOptionalProperties;
  Result.Clear;
  if GetAdsClass then
  begin
    vRes := FAdsClass.Get_OptionalProperties(vOleVar);
    CheckErrorInVariantProperty(vRes, vOleVar, IsDesignTime);
    if not VarIsEmpty(vOleVar) then VarArrayToStrings(vOleVar, result);
  end;
end;

function TAdsClassInfo.GetMandatoryProperties: TStrings;
var
  vOleVar: OleVariant;
  vRes: HRESULT;
begin
  Result := FMandatoryProperties;
  Result.Clear;
  if GetAdsClass then
  begin
    vRes := FAdsClass.Get_MandatoryProperties(vOleVar);
    CheckErrorInVariantProperty(vRes, vOleVar, IsDesignTime);
    if not VarIsEmpty(vOleVar) then VarArrayToStrings(vOleVar, result);
  end;
end;

function TAdsClassInfo.GetNamingProperties: TStrings;
var
  vOleVar: OleVariant;
  vRes: HRESULT;
begin
  Result := FNamingProperties;
  Result.Clear;
  if GetAdsClass then
  begin
    vRes := FAdsClass.Get_NamingProperties(vOleVar);
    CheckErrorInVariantProperty(vRes, vOleVar, IsDesignTime);
    if not VarIsEmpty(vOleVar) then VarArrayToStrings(vOleVar, Result);
  end;
end;

function TAdsClassInfo.GetObjectId: widestring;
var
  vRes: HRESULT;
begin
  if GetAdsClass then
  begin
    vRes := FAdsClass.Get_OID(Result);
    CheckErrorInStringProperty(vRes, Result, IsDesignTime);
  end else
  begin
    Result := '';
  end;  
end;

function TAdsClassInfo.GetPossibleSuperiors: TStrings;
var
  vOleVar: OleVariant;
  vRes: HRESULT;
begin
  Result := FPossibleSuperiors;
  Result.Clear;
  if GetAdsClass then
  begin
    vRes := FAdsClass.Get_PossibleSuperiors(vOleVar);
    CheckErrorInVariantProperty(vRes, vOleVar, IsDesignTime);
    if not VarIsEmpty(vOleVar) then VarArrayToStrings(vOleVar, Result);
  end;
end;

function TAdsClassInfo.GetPrimaryInterface: widestring;
var
  vRes: HRESULT;
begin
  if GetAdsClass then
  begin
    vRes := FAdsClass.Get_PrimaryInterface(Result);
    CheckErrorInStringProperty(vRes, Result, IsDesignTime);
  end else
  begin
    Result := '';
  end;  
end;

procedure TAdsClassInfo.SetDerivedFrom(const Value: TStrings);begin end;
procedure TAdsClassInfo.SetIsAbstract(const Value: wordbool); begin end;
procedure TAdsClassInfo.SetIsAuxilary(const Value: wordbool); begin end;
procedure TAdsClassInfo.SetCLSID(const Value: widestring); begin end;
procedure TAdsClassInfo.SetIsContainer(const Value: wordbool);begin end;
procedure TAdsClassInfo.SetContainment(const Value: TStrings);begin end;
procedure TAdsClassInfo.SetHelpContext(const Value: integer);begin end;
procedure TAdsClassInfo.SetHelpFileName(const Value: widestring);begin end;
procedure TAdsClassInfo.SetOptionalProperties(const Value: TStrings);begin end;
procedure TAdsClassInfo.SetMandatoryProperties(const Value: TStrings);begin end;
procedure TAdsClassInfo.SetNamingProperties(const Value: TStrings);begin end;
procedure TAdsClassInfo.SetObjectId(const Value: widestring);begin end;
procedure TAdsClassInfo.SetPossibleSuperiors(const Value: TStrings);begin end;
procedure TAdsClassInfo.SetPrimaryInterface(const Value: widestring);begin end;

function TAdsClassInfo.IsDesignTime: boolean;
begin
  Result := FOwner.IsDesignTime;
end;

function TAdsClassInfo.GetClass: IAdsClass;
begin
  GetAdsClass;
  Result := FAdsClass;
end;

{ TAdsCredentials }

procedure TAdsCredentials.Assign(Source: TPersistent);
var
  Other: TAdsCredentials;
begin
  if (Source is TAdsCredentials) then
  begin
    Other := Source as TAdsCredentials;
    UserName := Other.UserName;
    Password := Other.Password;
  end else
  begin
    inherited;
  end;  

end;

procedure TAdsCredentials.Clear;
begin
  UserName := '';
  Password := '';
end;

function TAdsCredentials.IsEmpty: boolean;
begin
  Result := (Trim(UserName) = '') and (Password = '') and (Authentication = 0) 
end;

{ TAdsPropertyInfo }

procedure TAdsPropertyInfo.Clear;
begin
  FName := '';
  FPropertyEntry := nil;
  FAdsProperty := nil;
end;

procedure TAdsPropertyInfo.ValuesChanged(ASender: TObject);
begin
  if Trim(Name) = '' then raise TAdsException.Create(NAME_PROPERTY_IS_REQUIRED);
  if not FOwner.Active then raise TAdsException.Create(CANNOT_CHANGE_PROPERTY_WHEN_INACTIVE);

  FOwner.FObject.Put(Name, FValues.GetItems);
  if FOwner.AutoCommit then FOwner.Commit;
end;

constructor TAdsPropertyInfo.Create(AOwner: TAdsBrowser);
begin
  inherited Create;
  FOwner  := AOwner;
  FValues := TAdsVariants.Create;
  FValues.OnChange := ValuesChanged;
end;

destructor TAdsPropertyInfo.Destroy;
begin
  FValues.Free;
  inherited;
end;

function TAdsPropertyInfo.ObtainAdsProperty: boolean;
begin
  if (FAdsProperty = nil) and (Trim(Name) <> '') then
  begin
    FAdsProperty := FOwner.GetPropertyInfo(Name);
    if FAdsProperty <> nil then FAdsProperty.GetInfo;
  end;
  Result := FAdsProperty <> nil;
end;


function TAdsPropertyInfo.GetIsMultiValued: wordbool;
var
  vOleVar: OleVariant;
begin
  if (FOwner.FObject <> nil) and (Name <> '')then
    AdsCheck(FOwner.FObject.Get(Name, vOleVar))
    else vOleVar := '';
  Result := VarIsArray(vOleVar);
end;

function TAdsPropertyInfo.GetOwner: TAdsBrowser;
begin
  Result := FOwner;
end;

function TAdsPropertyInfo.GetPropertyType: integer;
begin
  if ObtainPropertyEntry then
  begin
    AdsCheck(FPropertyEntry.Get_ADsType(Result));
  end else
  begin
    Result := 0;
  end;
end;

function TAdsPropertyInfo.GetValue: Variant;
var
  vOleVar: OleVariant;
begin
  if (FOwner.FObject <> nil) and (Name <> '')then
    AdsCheck(FOwner.FObject.Get(Name, vOleVar))
    else vOleVar := '';
  if not VarIsArray(vOleVar)
    then Result := vOleVar
    else Result := Unassigned;
end;

function TAdsPropertyInfo.ObtainPropertyEntry: boolean;
var
  vList: IAdsPropertyList;
  vOleVar: OleVariant;
begin
  if (FPropertyEntry = nil) and 
     (FOwner.FObject <> nil) and
     (Trim(Name) <> '') then
  begin
    vList := FOwner.FObject as IAdsPropertyList;
    AdsCheck(vList.Item(Name, vOleVar));
    FPropertyEntry := IUnknown(vOleVar) as IADsPropertyEntry;
  end;
  Result := FPropertyEntry <> nil; 
end;

procedure TAdsPropertyInfo.SetName(const Value: widestring);
begin
  if FName <> Value then
  begin 
    Clear;
    FName := Value;
  end;  
end;

procedure TAdsPropertyInfo.SetPropertyType(const Value: integer);begin end;
procedure TAdsPropertyInfo.SetSyntax(const Value: widestring);begin end;

procedure TAdsPropertyInfo.SetValue(const Value: Variant);
begin
  if Trim(Name) = '' then raise TAdsException.Create(NAME_PROPERTY_IS_REQUIRED);
  if not FOwner.Active then raise TAdsException.Create(CANNOT_CHANGE_PROPERTY_WHEN_INACTIVE);

  FOwner.FObject.Put(Name, Value);
  if FOwner.AutoCommit then FOwner.Commit;
end;

procedure TAdsPropertyInfo.SetIsMultiValued(const Value: wordbool);begin end;
procedure TAdsPropertyInfo.SetMaxRange(const Value: integer);begin end;
procedure TAdsPropertyInfo.SetMinRange(const Value: integer);begin end;

function TAdsPropertyInfo.GetValues: TAdsVariants;
var
  vOleVar: OleVariant;
begin
  Result := FValues;
  Result.Clear;
  if (FOwner.FObject <> nil) and (Name <> '')then
  begin
    AdsCheck(FOwner.FObject.Get(Name, vOleVar));
    if not VarIsArray(vOleVar) then Result.Add(vOleVar)
      else Result.SetItems(vOleVar);
  end
end;

procedure TAdsPropertyInfo.SetValues(const Value: TAdsVariants);
begin
  FValues.Assign(value);
end;

function TAdsPropertyInfo.GetMaxRange: integer;
begin
  Result := 0;
  if ObtainAdsProperty then
    if not Succeeded(FAdsProperty.Get_MaxRange(Result)) then
      Result := 0;
end;

function TAdsPropertyInfo.GetMinRange: integer;
begin
  Result := 0;
  if ObtainAdsProperty then
    if not Succeeded(FAdsProperty.Get_MinRange(Result)) then
      Result := 0;
end;

function TAdsPropertyInfo.GetSyntax: widestring;
begin
  if ObtainAdsProperty then
    AdsCheck(FAdsProperty.Get_Syntax(Result))
    else result := '';
end;


{ TAdsVariants }

constructor TAdsVariants.Create;
begin
  inherited Create;
  FItems := Unassigned;  
end;

function TAdsVariants.GetCount: integer;
begin
  if VarIsEmpty(FItems) then
    Result := 0
    else Result := VarArrayHighBound(FItems, 1) + 1;
end;

procedure TAdsVariants.CheckBounds(AIndex: integer);
begin
  if AIndex > Count - 1 then
    raise TAdsException(Format(ARRAY_INDEX_OUT_OF_BOUNDS, [AIndex]));
end;

function TAdsVariants.GetItem(AIndex: integer): variant;
begin
  CheckBounds(AIndex);
  Result := FItems[AIndex];
end;

procedure TAdsVariants.SetItem(AIndex: integer; const Value: variant);
begin
  CheckBounds(AIndex);
  FItems[AIndex] := Value;
  Notify;
end;

function TAdsVariants.Add(Value: variant): integer;
var
  vNewItems: OleVariant;
  vNewCount: integer;
  i: integer; 
begin
  vNewCount := Count + 1;
  vNewItems := VarArrayCreate([0, vNewCount - 1], varVariant);
  for i := 0 to vNewCount - 2 do vNewItems[i] := FItems[i];
  vNewItems[vNewCount - 1] := Value;
  FItems := vNewItems;
  Notify;
  Result := vNewCount - 1;
end;

procedure TAdsVariants.Clear;
begin
  FItems := Unassigned;
end;

procedure TAdsVariants.Delete(AIndex: integer);
var
  vNewItems: OleVariant;
  vNewCount: integer;
  i: integer; 
begin
  CheckBounds(AIndex);
  vNewCount := Count - 1;
  if vNewCount > 0 then
  begin
    vNewItems := VarArrayCreate([0, vNewCount - 1], varVariant);
    for i := 0 to AIndex - 1 do vNewItems[i] := FItems[i];
    for i := AIndex + 1 to Count - 1 do vNewItems[i-1] := FItems[i];
    FItems := vNewItems;
  end else
  begin
    Clear;
  end;
  Notify;
end;

function TAdsVariants.GetItems: Variant;
begin
  Result := FItems;
end;

procedure TAdsVariants.SetItems(const Value: Variant);
begin
  if VarIsEmpty(Value) or VarIsArray(Value) then
    FItems := Value
    else raise TAdsException(VARIANT_IS_NOT_ARRAY);
  Notify;
end;

procedure TAdsVariants.Insert(Value: variant; AIndex: integer);
var
  vNewItems: OleVariant;
  vNewCount: integer;
  i: integer; 
begin
  CheckBounds(AIndex);
  vNewCount := Count + 1;
  vNewItems := VarArrayCreate([0, vNewCount - 1], varVariant);
  for i := 0 to AIndex - 1 do vNewItems[i] := FItems[i];
  vNewItems[AIndex] := Value;
  for i := AIndex + 1 to vNewCount - 1 do vNewItems[i] := FItems[i-1];
  FItems := vNewItems;
  Notify;
end;

procedure TAdsVariants.Assign(ASource: TPersistent);
begin
  if ASource is TAdsVariants then
  begin
    FItems := (ASource as TAdsVariants).Items;
  end else
  begin
    inherited Assign(ASource);
  end;
  Notify;
end;

procedure TAdsVariants.Notify;
begin
  if Assigned(FOnChange) then FOnChange(self);
end;

end.

