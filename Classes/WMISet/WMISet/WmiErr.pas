unit WmiErr;

interface

Uses SysUtils;

type
  TWmiException = class(Exception)
  private
    FErrorCode: integer;
  public
    constructor Create(const Msg: string); overload;
    constructor Create(ErrorCode: integer; const Msg: string); overload;
    property ErrorCode: integer read FErrorCode;
  end;

function  GetWmiErrorString(ACode: HRESULT): string;
procedure WmiCheck(Result: HResult);
function Succeeded(Res: HResult): Boolean;


const 

WBEM_S_NO_ERROR = 0;

// The call failed.
WBEM_E_FAILED = $80041001;

// The object could not be found.
WBEM_E_NOT_FOUND = $80041002;

// The current user does not have permission to perform the action.
WBEM_E_ACCESS_DENIED = $80041003;

// The provider has failed at some time other than during initialization.
WBEM_E_PROVIDER_FAILURE = $80041004;

// A type mismatch occurred.
WBEM_E_TYPE_MISMATCH = $80041005;

// There was not enough memory for the operation.
WBEM_E_OUT_OF_MEMORY = $80041006;

// The IWbemContext object is not valid.
WBEM_E_INVALID_CONTEXT =  $80041007;

// One of the parameters to the call is not correct.
WBEM_E_INVALID_PARAMETER = $80041008;

// The resource, typically a remote server, is not currently available.
WBEM_E_NOT_AVAILABLE = $80041009;

// An internal, critical, and unexpected error occurred. Report this error to Microsoft Technical Support.
WBEM_E_CRITICAL_ERROR = $8004100A;

// One or more network packets were corrupted during a remote session.
WBEM_E_INVALID_STREAM = $8004100B;

// The feature or operation is not supported.
WBEM_E_NOT_SUPPORTED = $8004100C;

// The superclass specified is not valid.
WBEM_E_INVALID_SUPERCLASS = $8004100D;

// The namespace specified could not be found.
WBEM_E_INVALID_NAMESPACE = $8004100E;

// The specified instance is not valid.
WBEM_E_INVALID_OBJECT = $8004100F;

// The specified class is not valid.
WBEM_E_INVALID_CLASS = $80041010;

// A provider referenced in the schema does not have a corresponding registration.
WBEM_E_PROVIDER_NOT_FOUND = $80041011;

// A provider referenced in the schema has an incorrect or incomplete registration. This error may be caused by any of the following:
// A missing #pragma namespace command in the MOF file used to register the provider, resulting in the provider being registered in the wrong WMI namespace.
// A corrupt repository, which may be fixed by deleting it and recompiling the MOF file.
WBEM_E_INVALID_PROVIDER_REGISTRATION = $80041012;

// COM cannot locate a provider referenced in the schema. This error may be caused by any of the following:
// The provider is using a WMI DLL that does not match the .lib file used when the provider was built.
// The provider's DLL, or any of the DLLs on which it depends, is corrupt.
// The provider failed to export DllRegisterServer.
// An in-process provider was not registered using the regsvr32 command.
// An out-of-process provider was not registered using the /regserver switch. For example, myprog.exe /regserver.
WBEM_E_PROVIDER_LOAD_FAILURE = $80041013;

// A component, such as a provider, failed to initialize for internal reasons.
WBEM_E_INITIALIZATION_FAILURE = $80041014;

// A networking error that prevents normal operation has occurred.
WBEM_E_TRANSPORT_FAILURE = $80041015;

// The requested operation is not valid. This error usually applies to invalid attempts to delete classes or properties.
WBEM_E_INVALID_OPERATION = $80041016;

// The query was not syntactically valid.
WBEM_E_INVALID_QUERY = $80041017;

// The requested query language is not supported.
WBEM_E_INVALID_QUERY_TYPE = $80041018;

// In a put operation, the wbemChangeFlagCreateOnly flag was specified, but the instance already exists.
WBEM_E_ALREADY_EXISTS = $80041019;

// It is not possible to perform the add operation on this qualifier because the owning object does not permit overrides.
WBEM_E_OVERRIDE_NOT_ALLOWED = $8004101A;

// The user attempted to delete a qualifier that was not owned. The qualifier was inherited from a parent class.
WBEM_E_PROPAGATED_QUALIFIER = $8004101B;

// The user attempted to delete a property that was not owned. The property was inherited from a parent class.
WBEM_E_PROPAGATED_PROPERTY = $8004101C;

// The client made an unexpected and illegal sequence of calls, such as calling EndEnumeration before calling BeginEnumeration.
WBEM_E_UNEXPECTED = $8004101D;

// The user requested an illegal operation, such as spawning a class from an instance.
WBEM_E_ILLEGAL_OPERATION = $8004101E;

// There was an illegal attempt to specify a key qualifier on a property that cannot be a key. The keys are specified in the class definition for an object, and cannot be altered on a per-instance basis.
WBEM_E_CANNOT_BE_KEY = $8004101F;

// The current object is not a valid class definition. Either it is incomplete, or it has not been registered with WMI using SWbemObject.Put_.
WBEM_E_INCOMPLETE_CLASS = $80041020;

// Reserved for future use.
WBEM_E_INVALID_SYNTAX = $80041021;

// Reserved for future use.
WBEM_E_NONDECORATED_OBJECT = $80041022;

// The property that you are attempting to modify is read-only.
WBEM_E_READ_ONLY = $80041023;

//The provider cannot perform the requested operation. This would include a query that is too complex, retrieving an instance, creating or updating a class, deleting a class, or enumerating a class.
WBEM_E_PROVIDER_NOT_CAPABLE = $80041024;

// An attempt was made to make a change that would invalidate a subclass.
WBEM_E_CLASS_HAS_CHILDREN = $80041025;

// An attempt has been made to delete or modify a class that has instances.
WBEM_E_CLASS_HAS_INSTANCES = $80041026;

// Reserved for future use.
WBEM_E_QUERY_NOT_IMPLEMENTED = $80041027;

// A value of Nothing/NULL was specified for a property that must have a value, such as one that is marked by a Key, Indexed, or Not_Null qualifier.
WBEM_E_ILLEGAL_NULL = $80041028;

// The variant value for a qualifier was provided that is not of a legal qualifier type.
WBEM_E_INVALID_QUALIFIER_TYPE = $80041029;

// The CIM type specified for a property is not valid.
WBEM_E_INVALID_PROPERTY_TYPE = $8004102A;

// The request was made with an out-of-range value, or is incompatible with the type.
WBEM_E_VALUE_OUT_OF_RANGE = $8004102B;

// An illegal attempt was made to make a class singleton, such as when the class is derived from a non-singleton class.
WBEM_E_CANNOT_BE_SINGLETON = $8004102C;

// The CIM type specified is not valid.
WBEM_E_INVALID_CIM_TYPE = $8004102D;

// The requested method is not available.
WBEM_E_INVALID_METHOD = $8004102E;

// The parameters provided for the method are not valid.
WBEM_E_INVALID_METHOD_PARAMETERS = $8004102F;

// There was an attempt to get qualifiers on a system property.
WBEM_E_SYSTEM_PROPERTY = $80041030;

// The property type is not recognized.
WBEM_E_INVALID_PROPERTY = $80041031;

// An asynchronous process has been canceled internally or by the user. Note that due to the timing and nature of the asynchronous operation the operation may not have been truly canceled.
WBEM_E_CALL_CANCELLED = $80041032;

// The user has requested an operation while WMI is in the process of shutting down.
WBEM_E_SHUTTING_DOWN = $80041033;

// An attempt was made to reuse an existing method name from a superclass, and the signatures did not match.
WBEM_E_PROPAGATED_METHOD = $80041034;

// One or more parameter values, such as a query text, is too complex or unsupported. WMI is therefore requested to retry the operation with simpler parameters.
WBEM_E_UNSUPPORTED_PARAMETER = $80041035;

// A parameter was missing from the method call.
WBEM_E_MISSING_PARAMETER_ID = $80041036;

// A method parameter has an invalid ID qualifier.
WBEM_E_INVALID_PARAMETER_ID = $80041037;

// One or more of the method parameters have ID qualifiers that are out of sequence.
WBEM_E_NONCONSECUTIVE_PARAMETER_IDS = $80041038;

// The return value for a method has an ID qualifier.
WBEM_E_PARAMETER_ID_ON_RETVAL = $80041039;

// The specified object path was invalid.
WBEM_E_INVALID_OBJECT_PATH = $8004103A;

// There is not enough free disk space to continue the operation.
WBEM_E_OUT_OF_DISK_SPACE = $8004103B;

// The supplied buffer was too small to hold all the objects in the enumerator or to read a string property.
WBEM_E_BUFFER_TOO_SMALL = $8004103C;

// The provider does not support the requested put operation.
WBEM_E_UNSUPPORTED_PUT_EXTENSION = $8004103D;

// An object with an incorrect type or version was encountered during marshaling.
WBEM_E_UNKNOWN_OBJECT_TYPE = $8004103E;

// A packet with an incorrect type or version was encountered during marshaling.
WBEM_E_UNKNOWN_PACKET_TYPE = $8004103F;

// The packet has an unsupported version.
WBEM_E_MARSHAL_VERSION_MISMATCH = $80041040;

// The packet appears to be corrupted.
WBEM_E_MARSHAL_INVALID_SIGNATURE = $80041041;

// An attempt has been made to mismatch qualifiers, such as putting [key] on an object instead of a property.
WBEM_E_INVALID_QUALIFIER = $80041042;

// A duplicate parameter has been declared in a CIM method.
WBEM_E_INVALID_DUPLICATE_PARAMETER = $80041043;

// Reserved for future use.
WBEM_E_TOO_MUCH_DATA = $80041044;

// A call to IWbemObjectSink::Indicate has failed. The provider may choose to refire the event.
WBEM_E_SERVER_TOO_BUSY = $80041045;

// The specified qualifier flavor was invalid.
WBEM_E_INVALID_FLAVOR = $80041046;

// An attempt has been made to create a reference that is circular (for example, deriving a class from itself).
WBEM_E_CIRCULAR_REFERENCE = $80041047;

//The specified class is not supported.
WBEM_E_UNSUPPORTED_CLASS_UPDATE = $80041048;

//An attempt was made to change a key when instances or subclasses are already using the key.
WBEM_E_CANNOT_CHANGE_KEY_INHERITANCE = $80041049;

// An attempt was made to change an index when instances or subclasses are already using the index.
WBEM_E_CANNOT_CHANGE_INDEX_INHERITANCE = $80041050;

// An attempt was made to create more properties than the current version of the class supports.
WBEM_E_TOO_MANY_PROPERTIES = $80041051;

// A property was redefined with a conflicting type in a derived class.
WBEM_E_UPDATE_TYPE_MISMATCH = $80041052;

//An attempt was made in a derived class to override a qualifier that cannot be overridden.
WBEM_E_UPDATE_OVERRIDE_NOT_ALLOWED = $80041053;

// A method was re-declared with a conflicting signature in a derived class.
WBEM_E_UPDATE_PROPAGATED_METHOD = $80041054;

// An attempt was made to execute a method not marked with [implemented] in any relevant class.
WBEM_E_METHOD_NOT_IMPLEMENTED = $80041055;

// An attempt was made to execute a method marked with [disabled].
WBEM_E_METHOD_DISABLED = $80041056;

// The refresher is busy with another operation.
WBEM_E_REFRESHER_BUSY = $80041057;

// The filtering query is syntactically invalid.
WBEM_E_UNPARSABLE_QUERY = $80041058;

// The FROM clause of a filtering query references a class that is not an event class (not derived from __Event).
WBEM_E_NOT_EVENT_CLASS = $80041059;

// A GROUP BY clause was used without the corresponding GROUP WITHIN clause.
WBEM_E_MISSING_GROUP_WITHIN = $8004105A;

// A GROUP BY clause was used. Aggregation on all properties is not supported.
WBEM_E_MISSING_AGGREGATION_LIST = $8004105B;

// Dot notation was used on a property that is not an embedded object.
WBEM_E_PROPERTY_NOT_AN_OBJECT = $8004105C;

//A GROUP BY clause references a property that is an embedded object without using dot notation.
WBEM_E_AGGREGATING_BY_OBJECT = $8004105D;

// An event provider registration query ( __EventProviderRegistration) did not specify the classes for which events were provided.
WBEM_E_UNINTERPRETABLE_PROVIDER_QUERY = $8004105F;

//An request was made to back up or restore the repository while it was in use by WinMgmt.exe or, in Windows XP or later, the SVCHOST process containing the Windows Management service.
WBEM_E_BACKUP_RESTORE_WINMGMT_RUNNING = $80041060;

// The asynchronous delivery queue overflowed due to the event consumer being too slow.
WBEM_E_QUEUE_OVERFLOW = $80041061;

// The operation failed because the client did not have the necessary security privilege.
WBEM_E_PRIVILEGE_NOT_HELD = $80041062;

// The operator is not valid for this property type.
WBEM_E_INVALID_OPERATOR = $80041063;

// The user specified a username/password/authority on a local connection. The user must use a blank username/password and rely on default security.
WBEM_E_LOCAL_CREDENTIALS = $80041064;

// The class was made abstract when its superclass is not abstract.
WBEM_E_CANNOT_BE_ABSTRACT = $80041065;

//An amended object was written without the WBEM_FLAG_USE_AMENDED_QUALIFIERS flag being specified.
WBEM_E_AMENDED_OBJECT = $80041066;

// Windows XP: The client was not retrieving objects quickly enough from an enumeration. This constant is returned when a client creates an enumeration object but does not retrieve objects from the enumerator in a timely fashion, causing the enumerator's object caches to get backed up.
WBEM_E_CLIENT_TOO_SLOW = $80041067;

// Windows XP: A null security descriptor was used.
WBEM_E_NULL_SECURITY_DESCRIPTOR = $80041068;

// Windows XP: The operation timed out.
WBEM_E_TIMED_OUT = $80041069;

// Windows XP: The association being used is not valid.
WBEM_E_INVALID_ASSOCIATION = $8004106A;

// Windows XP: The operation was ambiguous.
WBEM_E_AMBIGUOUS_OPERATION = $8004106B;

// Windows XP: WMI is taking up too much memory. This could be caused either by low memory availability or excessive memory consumption by WMI.
WBEM_E_QUOTA_VIOLATION = $8004106C;

// Windows XP: The operation resulted in a transaction conflict.
WBEM_E_TRANSACTION_CONFLICT = $8004106D;

// Windows XP: The transaction forced a rollback.
WBEM_E_FORCED_ROLLBACK = $8004106E;

// Windows XP: The locale used in the call is not supported.
WBEM_E_UNSUPPORTED_LOCALE = $8004106F;

// Windows XP: The object handle is out of date.
WBEM_E_HANDLE_OUT_OF_DATE = $80041070;

//Windows XP: The connection to the SQL database failed.
WBEM_E_CONNECTION_FAILED = $80041071;

// Windows XP: The handle request was invalid.
WBEM_E_INVALID_HANDLE_REQUEST = $80041072;

// Windows XP: The property name contains more than 255 characters.
WBEM_E_PROPERTY_NAME_TOO_WIDE = $80041073;

//Windows XP: The class name contains more than 255 characters.
WBEM_E_CLASS_NAME_TOO_WIDE = $80041074;

// Windows XP: The method name contains more than 255 characters.
WBEM_E_METHOD_NAME_TOO_WIDE = $80041075;

// Windows XP: The qualifier name contains more than 255 characters.
WBEM_E_QUALIFIER_NAME_TOO_WIDE = $80041076;

//Windows XP: The SQL command should be rerun because there is a deadlock in SQL. This can be returned only when data is being stored in an SQL database.
WBEM_E_RERUN_COMMAND = $80041077;

// Windows XP: The database version does not match the version that the repository driver understands.
WBEM_E_DATABASE_VER_MISMATCH = $80041078;

// Windows XP: WMI cannot execute the delete operation because the provider does not allow it.
WBEM_E_VETO_DELETE = $80041079;

// Windows XP: WMI cannot execute the put operation because the provider does not allow it.
WBEM_E_VETO_PUT = $8004107A;

// Windows XP: The specified locale identifier was not valid for the operation.
WBEM_E_INVALID_LOCALE = $80041080;

// Windows XP: The provider is suspended.
WBEM_E_PROVIDER_SUSPENDED = $80041081;

// Windows XP: The object must be committed and retrieved again before the requested operation can succeed. This constant is returned when an object must be committed and re-retrieved to see the property value.
WBEM_E_SYNCHRONIZATION_REQUIRED = $80041082;

// Windows XP: The operation cannot be completed because no schema is available.
WBEM_E_NO_SCHEMA = $80041083;

// Windows XP: The provider cannot be registered because the provider is already registered.
WBEM_E_PROVIDER_ALREADY_REGISTERED = $80041084;

//Windows XP: The provider was not registered.
WBEM_E_PROVIDER_NOT_REGISTERED = $80041085;

// Windows XP: A fatal transport error occurred.
WBEM_E_FATAL_TRANSPORT_ERROR = $80041086;

// Windows XP: The user attempted to set a computer name or domain without an encrypted connection.
WBEM_E_ENCRYPTED_CONNECTION_REQUIRED = $80041087;

// The provider registration overlaps with the system event domain.
WBEM_E_REGISTRATION_TOO_BROAD = $80042001;

//A WITHIN clause was not used in this query.
WBEM_E_REGISTRATION_TOO_PRECISE = $80042002;

// Reserved for future use.
WBEM_E_RETRY_LATER = $80043001;

// Reserved for future use.
WBEM_E_RESOURCE_CONTENTION = $80043002;

implementation

procedure WmiError(ErrorCode: HResult);
begin
  raise TWmiException.Create(ErrorCode, GetWmiErrorString(ErrorCode));
end;

function Succeeded(Res: HResult): Boolean;
begin
  Result := Res and $80000000 = 0;
end;

procedure WmiCheck(Result: HResult);
begin
  if not Succeeded(Result) then WmiError(Result);
end;

function  GetWmiErrorString(ACode: HRESULT): string;
begin
  case ACode of
    {$WARNINGS OFF}
    WBEM_E_FAILED: Result := 'The call failed.';
    WBEM_E_NOT_FOUND: Result := 'The object could not be found.';
    WBEM_E_ACCESS_DENIED: Result := 'The current user does not have permission to perform the action.';
    WBEM_E_PROVIDER_FAILURE: Result := 'The provider has failed at some time other than during initialization.';
    WBEM_E_TYPE_MISMATCH: Result := 'A type mismatch occurred.';
    WBEM_E_OUT_OF_MEMORY: Result := 'There was not enough memory for the operation.';
    WBEM_E_INVALID_CONTEXT: result := 'The IWbemContext object is not valid.';
    WBEM_E_INVALID_PARAMETER: Result := 'One of the parameters to the call is not correct.';
    WBEM_E_NOT_AVAILABLE: Result := 'The resource, typically a remote server, is not currently available.';
    WBEM_E_CRITICAL_ERROR: Result := 'An internal, critical, and unexpected error occurred. Report this error to Microsoft Technical Support.';
    WBEM_E_INVALID_STREAM: Result := 'One or more network packets were corrupted during a remote session.';
    WBEM_E_NOT_SUPPORTED: Result := 'The feature or operation is not supported.';
    WBEM_E_INVALID_SUPERCLASS: Result := 'The superclass specified is not valid.';
    WBEM_E_INVALID_NAMESPACE: Result := 'The namespace specified could not be found.';
    WBEM_E_INVALID_OBJECT: Result := 'The specified instance is not valid.';
    WBEM_E_INVALID_CLASS: Result := 'The specified class is not valid.';
    WBEM_E_PROVIDER_NOT_FOUND: Result := 'A provider referenced in the schema does not have a corresponding registration.';
    WBEM_E_INVALID_PROVIDER_REGISTRATION: Result := 'A provider referenced in the schema has an incorrect or incomplete registration. This error may be caused by any of the following:' +
                        'A missing #pragma namespace command in the MOF file used to register the provider, resulting in the provider being registered in the wrong WMI namespace.'+
                        'A corrupt repository, which may be fixed by deleting it and recompiling the MOF file.';
    WBEM_E_PROVIDER_LOAD_FAILURE: Result := 'COM cannot locate a provider referenced in the schema. This error may be caused by any of the following:'+
        'The provider is using a WMI DLL that does not match the .lib file used when the provider was built.'+
        'The provider''s DLL, or any of the DLLs on which it depends, is corrupt.'+
        'The provider failed to export DllRegisterServer.'+
        'An in-process provider was not registered using the regsvr32 command.' +
        'An out-of-process provider was not registered using the /regserver switch. For example, myprog.exe /regserver.';
    WBEM_E_INITIALIZATION_FAILURE: Result := 'A component, such as a provider, failed to initialize for internal reasons.';
    WBEM_E_TRANSPORT_FAILURE: Result := 'A networking error that prevents normal operation has occurred.';
    WBEM_E_INVALID_OPERATION: Result := 'The requested operation is not valid. This error usually applies to invalid attempts to delete classes or properties.';
    WBEM_E_INVALID_QUERY: Result := 'The query was not syntactically valid.';
    WBEM_E_INVALID_QUERY_TYPE: Result := 'The requested query language is not supported.';
    WBEM_E_ALREADY_EXISTS: Result := 'In a put operation, the wbemChangeFlagCreateOnly flag was specified, but the instance already exists.';
    WBEM_E_OVERRIDE_NOT_ALLOWED: Result := 'It is not possible to perform the add operation on this qualifier because the owning object does not permit overrides.';
    WBEM_E_PROPAGATED_QUALIFIER: Result := 'The user attempted to delete a qualifier that was not owned. The qualifier was inherited from a parent class.';
    WBEM_E_PROPAGATED_PROPERTY: Result := 'The user attempted to delete a property that was not owned. The property was inherited from a parent class.';
    WBEM_E_UNEXPECTED: Result := 'The client made an unexpected and illegal sequence of calls, such as calling EndEnumeration before calling BeginEnumeration.';
    WBEM_E_ILLEGAL_OPERATION: Result := 'The user requested an illegal operation, such as spawning a class from an instance.';
    WBEM_E_CANNOT_BE_KEY: Result := 'There was an illegal attempt to specify a key qualifier on a property that cannot be a key. The keys are specified in the class definition for an object, and cannot be altered on a per-instance basis.';
    WBEM_E_INCOMPLETE_CLASS: Result := 'The current object is not a valid class definition. Either it is incomplete, or it has not been registered with WMI using SWbemObject.Put_.';
    WBEM_E_INVALID_SYNTAX: Result := 'Reserved for future use: WBEM_E_INVALID_SYNTAX';
    WBEM_E_NONDECORATED_OBJECT: Result := 'Reserved for future use: WBEM_E_NONDECORATED_OBJECT';
    WBEM_E_READ_ONLY: Result := 'The property that you are attempting to modify is read-only.';
    WBEM_E_PROVIDER_NOT_CAPABLE: Result := 'The provider cannot perform the requested operation. This would include a query that is too complex, retrieving an instance, creating or updating a class, deleting a class, or enumerating a class.';
    WBEM_E_CLASS_HAS_CHILDREN: Result := 'An attempt was made to make a change that would invalidate a subclass.';
    WBEM_E_CLASS_HAS_INSTANCES: Result := 'An attempt has been made to delete or modify a class that has instances.';
    WBEM_E_QUERY_NOT_IMPLEMENTED: Result := 'Reserved for future use: WBEM_E_QUERY_NOT_IMPLEMENTED';
    WBEM_E_ILLEGAL_NULL: Result := 'A value of Nothing/NULL was specified for a property that must have a value, such as one that is marked by a Key, Indexed, or Not_Null qualifier.';
    WBEM_E_INVALID_QUALIFIER_TYPE: Result := 'The variant value for a qualifier was provided that is not of a legal qualifier type.';
    WBEM_E_INVALID_PROPERTY_TYPE: Result := 'The CIM type specified for a property is not valid.';
    WBEM_E_VALUE_OUT_OF_RANGE: Result := 'The request was made with an out-of-range value, or is incompatible with the type.';
    WBEM_E_CANNOT_BE_SINGLETON: Result := 'An illegal attempt was made to make a class singleton, such as when the class is derived from a non-singleton class.';
    WBEM_E_INVALID_CIM_TYPE: Result := 'The CIM type specified is not valid.';
    WBEM_E_INVALID_METHOD: Result := 'The requested method is not available.';
    WBEM_E_INVALID_METHOD_PARAMETERS: Result := 'The parameters provided for the method are not valid.';
    WBEM_E_SYSTEM_PROPERTY: Result := 'There was an attempt to get qualifiers on a system property.';
    WBEM_E_INVALID_PROPERTY: Result := 'The property type is not recognized.';
    WBEM_E_CALL_CANCELLED: Result := 'An asynchronous process has been canceled internally or by the user. Note that due to the timing and nature of the asynchronous operation the operation may not have been truly canceled.';
    WBEM_E_SHUTTING_DOWN: Result := 'The user has requested an operation while WMI is in the process of shutting down.';
    WBEM_E_PROPAGATED_METHOD: Result := 'An attempt was made to reuse an existing method name from a superclass, and the signatures did not match.';
    WBEM_E_UNSUPPORTED_PARAMETER: Result := 'One or more parameter values, such as a query text, is too complex or unsupported. WMI is therefore requested to retry the operation with simpler parameters.';
    WBEM_E_MISSING_PARAMETER_ID: Result := 'A parameter was missing from the method call.';
    WBEM_E_INVALID_PARAMETER_ID: Result := 'A method parameter has an invalid ID qualifier.';
    WBEM_E_NONCONSECUTIVE_PARAMETER_IDS: Result := 'One or more of the method parameters have ID qualifiers that are out of sequence.';
    WBEM_E_PARAMETER_ID_ON_RETVAL: Result := 'The return value for a method has an ID qualifier.';
    WBEM_E_INVALID_OBJECT_PATH: Result := 'The specified object path was invalid.';
    WBEM_E_OUT_OF_DISK_SPACE: Result := 'There is not enough free disk space to continue the operation.';
    WBEM_E_BUFFER_TOO_SMALL: Result := 'The supplied buffer was too small to hold all the objects in the enumerator or to read a string property.';
    WBEM_E_UNSUPPORTED_PUT_EXTENSION: Result := 'The provider does not support the requested put operation.';
    WBEM_E_UNKNOWN_OBJECT_TYPE: Result := 'An object with an incorrect type or version was encountered during marshaling.';
    WBEM_E_UNKNOWN_PACKET_TYPE: Result := 'A packet with an incorrect type or version was encountered during marshaling.';
    WBEM_E_MARSHAL_VERSION_MISMATCH: Result := 'The packet has an unsupported version.';
    WBEM_E_MARSHAL_INVALID_SIGNATURE: Result := 'The packet appears to be corrupted.';
    WBEM_E_INVALID_QUALIFIER: Result := 'An attempt has been made to mismatch qualifiers, such as putting [key] on an object instead of a property.';
    WBEM_E_INVALID_DUPLICATE_PARAMETER: Result := 'A duplicate parameter has been declared in a CIM method.';
    WBEM_E_TOO_MUCH_DATA: Result := 'Reserved for future use.';
    WBEM_E_SERVER_TOO_BUSY: Result := 'A call to IWbemObjectSink::Indicate has failed. The provider may choose to refire the event.';
    WBEM_E_INVALID_FLAVOR: Result := 'The specified qualifier flavor was invalid.';
    WBEM_E_CIRCULAR_REFERENCE: Result := 'An attempt has been made to create a reference that is circular (for example, deriving a class from itself).';
    WBEM_E_UNSUPPORTED_CLASS_UPDATE: Result := 'The specified class is not supported.';
    WBEM_E_CANNOT_CHANGE_KEY_INHERITANCE: Result := 'An attempt was made to change a key when instances or subclasses are already using the key.';
    WBEM_E_CANNOT_CHANGE_INDEX_INHERITANCE: Result := 'An attempt was made to change an index when instances or subclasses are already using the index.';
    WBEM_E_TOO_MANY_PROPERTIES: Result := 'An attempt was made to create more properties than the current version of the class supports.';
    WBEM_E_UPDATE_TYPE_MISMATCH: Result := 'A property was redefined with a conflicting type in a derived class.';
    WBEM_E_UPDATE_OVERRIDE_NOT_ALLOWED: Result := 'An attempt was made in a derived class to override a qualifier that cannot be overridden.';
    WBEM_E_UPDATE_PROPAGATED_METHOD: Result := 'A method was re-declared with a conflicting signature in a derived class.';
    WBEM_E_METHOD_NOT_IMPLEMENTED: Result := 'An attempt was made to execute a method not marked with [implemented] in any relevant class.';
    WBEM_E_METHOD_DISABLED: Result := 'An attempt was made to execute a method marked with [disabled].';
    WBEM_E_REFRESHER_BUSY: Result := 'The refresher is busy with another operation.';
    WBEM_E_UNPARSABLE_QUERY: Result := 'The filtering query is syntactically invalid.';
    WBEM_E_NOT_EVENT_CLASS: Result := 'The FROM clause of a filtering query references a class that is not an event class (not derived from __Event).';
    WBEM_E_MISSING_GROUP_WITHIN: Result := 'A GROUP BY clause was used without the corresponding GROUP WITHIN clause.';
    WBEM_E_MISSING_AGGREGATION_LIST: Result := 'A GROUP BY clause was used. Aggregation on all properties is not supported.';
    WBEM_E_PROPERTY_NOT_AN_OBJECT: Result := 'Dot notation was used on a property that is not an embedded object.';
    WBEM_E_AGGREGATING_BY_OBJECT: Result := 'A GROUP BY clause references a property that is an embedded object without using dot notation.';
    WBEM_E_UNINTERPRETABLE_PROVIDER_QUERY: Result := 'An event provider registration query ( __EventProviderRegistration) did not specify the classes for which events were provided.';
    WBEM_E_BACKUP_RESTORE_WINMGMT_RUNNING: Result := 'An request was made to back up or restore the repository while it was in use by WinMgmt.exe or, in Windows XP or later, the SVCHOST process containing the Windows Management service.';
    WBEM_E_QUEUE_OVERFLOW: Result := 'The asynchronous delivery queue overflowed due to the event consumer being too slow.';
    WBEM_E_PRIVILEGE_NOT_HELD: Result := 'The operation failed because the client did not have the necessary security privilege.';
    WBEM_E_INVALID_OPERATOR: Result := 'The operator is not valid for this property type.';
    WBEM_E_LOCAL_CREDENTIALS: Result := 'The user specified a username/password/authority on a local connection. The user must use a blank username/password and rely on default security.';
    WBEM_E_CANNOT_BE_ABSTRACT: Result := 'The class was made abstract when its superclass is not abstract.';
    WBEM_E_AMENDED_OBJECT: Result := 'An amended object was written without the WBEM_FLAG_USE_AMENDED_QUALIFIERS flag being specified.';
    WBEM_E_CLIENT_TOO_SLOW: Result := 'Windows XP: The client was not retrieving objects quickly enough from an enumeration. This constant is returned when a client creates an enumeration object but does not retrieve '+
           'objects from the enumerator in a timely fashion, causing the enumerator''s object caches to get backed up.';
    WBEM_E_NULL_SECURITY_DESCRIPTOR: Result := 'Windows XP: A null security descriptor was used.';
    WBEM_E_TIMED_OUT: Result := 'Windows XP: The operation timed out.';
    WBEM_E_INVALID_ASSOCIATION: Result := 'Windows XP: The association being used is not valid.';
    WBEM_E_AMBIGUOUS_OPERATION: Result := 'Windows XP: The operation was ambiguous.';
    WBEM_E_QUOTA_VIOLATION: Result := 'Windows XP: WMI is taking up too much memory. This could be caused either by low memory availability or excessive memory consumption by WMI.';
    WBEM_E_TRANSACTION_CONFLICT: Result := 'Windows XP: The operation resulted in a transaction conflict.';
    WBEM_E_FORCED_ROLLBACK: Result := 'Windows XP: The transaction forced a rollback.';
    WBEM_E_UNSUPPORTED_LOCALE: Result := 'Windows XP: The locale used in the call is not supported.';
    WBEM_E_HANDLE_OUT_OF_DATE: Result := 'Windows XP: The object handle is out of date.';
    WBEM_E_CONNECTION_FAILED: Result := 'Windows XP: The connection to the SQL database failed.';
    WBEM_E_INVALID_HANDLE_REQUEST: Result := 'Windows XP: The handle request was invalid.';
    WBEM_E_PROPERTY_NAME_TOO_WIDE: Result := 'Windows XP: The property name contains more than 255 characters.';
    WBEM_E_CLASS_NAME_TOO_WIDE: Result := 'Windows XP: The class name contains more than 255 characters.';
    WBEM_E_METHOD_NAME_TOO_WIDE: Result := 'Windows XP: The method name contains more than 255 characters.';
    WBEM_E_QUALIFIER_NAME_TOO_WIDE: Result := 'Windows XP: The qualifier name contains more than 255 characters.';
    WBEM_E_RERUN_COMMAND: Result := 'Windows XP: The SQL command should be rerun because there is a deadlock in SQL. This can be returned only when data is being stored in an SQL database.';
    WBEM_E_DATABASE_VER_MISMATCH: Result := 'Windows XP: The database version does not match the version that the repository driver understands.';
    WBEM_E_VETO_DELETE: Result := 'Windows XP: WMI cannot execute the delete operation because the provider does not allow it.';
    WBEM_E_VETO_PUT: Result := 'Windows XP: WMI cannot execute the put operation because the provider does not allow it.';
    WBEM_E_INVALID_LOCALE: Result := 'Windows XP: The specified locale identifier was not valid for the operation.';
    WBEM_E_PROVIDER_SUSPENDED: Result := 'Windows XP: The provider is suspended.';
    WBEM_E_SYNCHRONIZATION_REQUIRED: Result := 'Windows XP: The object must be committed and retrieved again before the requested operation can succeed. This constant is returned when an object must be committed and re-retrieved to see the property value.';
    WBEM_E_NO_SCHEMA: Result := 'Windows XP: The operation cannot be completed because no schema is available.';
    WBEM_E_PROVIDER_ALREADY_REGISTERED: Result := 'Windows XP: The provider cannot be registered because the provider is already registered.';
    WBEM_E_PROVIDER_NOT_REGISTERED: Result := 'Windows XP: The provider was not registered.';
    WBEM_E_FATAL_TRANSPORT_ERROR: Result := 'Windows XP: A fatal transport error occurred.';
    WBEM_E_ENCRYPTED_CONNECTION_REQUIRED: Result := 'Windows XP: The user attempted to set a computer name or domain without an encrypted connection.';
    WBEM_E_REGISTRATION_TOO_BROAD: Result := 'The provider registration overlaps with the system event domain.';
    WBEM_E_REGISTRATION_TOO_PRECISE: Result := 'A WITHIN clause was not used in this query.';
    WBEM_E_RETRY_LATER: Result := 'Reserved for future use: WBEM_E_RETRY_LATER';
    WBEM_E_RESOURCE_CONTENTION: Result := 'Reserved for future use: WBEM_E_RESOURCE_CONTENTION';
   {$WARNINGS ON}
    else Result := SysErrorMessage(ACode);
  end;
  Result := IntToHex(ACode, 8) + ': ' + Result;
end;

{ TWmiException }

constructor TWmiException.Create(const Msg: string);
begin
  inherited Create(Msg);
end;

constructor TWmiException.Create(ErrorCode: integer; const Msg: string);
begin
  inherited Create(Msg);
  FErrorCode := ErrorCode;
end;


end.
