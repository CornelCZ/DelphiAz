unit WmiMethod;

interface
{$INCLUDE ..\Common\define.inc}

{$NOINCLUDE WbemScripting_TLB}
{$HPPEMIT '#include <wbemdisp.h>'}
{$HPPEMIT '#include <oaidl.h>'}
{$HPPEMIT '#include "wbem_script_support.h"'}

uses
  Windows, SysUtils, Classes, WmiAbstract, WbemScripting_TLB,
  WmiUtil, ActiveX,
  {$IFDEF Delphi6}Variants, {$ENDIF}
  WmiErr, DB, DBConsts, WmiQualifiers;


type
  TWmiMethod = class;
  TWmiParam = class;
  TWmiParams = class;

  TWmiParam = class(TCollectionItem)
  private
    FData: Variant;
    FName: string;
    FDataType: TFieldType;
    FNull: Boolean;
  protected
    procedure AssignParam(Param: TWmiParam);
    procedure AssignField(Field: TField);
    procedure AssignFieldValue(Field: TField; const Value: Variant);
    function GetAsBoolean: Boolean;
    function GetAsDateTime: TDateTime;
    function GetAsTime: TDateTime;
    function GetAsFloat: Double;
    function GetAsInteger: Longint;
    function GetAsString: string;
    function GetAsVariant: Variant;
    function IsEqual(Value: TWmiParam): Boolean;
    function GetIsNull: Boolean;
    function GetDataType: TFieldType;
    procedure SetAsBoolean(Value: Boolean);
    procedure SetAsDateTime(const Value: TDateTime);
    procedure SetAsTime(const Value: TDateTime);
    procedure SetAsFloat(const Value: Double);
    procedure SetAsInteger(Value: Longint);
    procedure SetAsString(const Value: string);
    procedure SetAsVariant(const Value: Variant);
    procedure SetDataType(Value: TFieldType);
    function  GetDisplayName: string; override;
    function  GetWmiMethod: TWmiMethod;
  public
    constructor Create(Collection: TCollection); overload; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsTime: TDateTime read GetAsTime write SetAsTime;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsInteger: LongInt read GetAsInteger write SetAsInteger;
    property AsString: string read GetAsString write SetAsString;
    property IsNull: Boolean read GetIsNull;
  published
    property DataType: TFieldType read GetDataType write SetDataType;
    property Name: string read FName write FName;
    property Value: Variant read GetAsVariant write SetAsVariant;
  end;

  TWmiParams = class(TCollection)
  private
    FOwner: TPersistent;
    function GetParamValue(const ParamName: string): Variant;
    procedure SetParamValue(const ParamName: string; const Value: Variant);
    function GetItem(Index: Integer): TWmiParam;
    procedure SetItem(Index: Integer; Value: TWmiParam);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(Owner: TPersistent);
    procedure AssignValues(Value: TWmiParams);
    procedure AddParam(Value: TWmiParam);
    procedure RemoveParam(Value: TWmiParam);
    function  CreateParam(FldType: TFieldType; const ParamName: string): TWmiParam;
    procedure GetParamList(List: TList; const ParamNames: string);
    function IsEqual(Value: TWmiParams): Boolean;
    function ParamByName(const Value: string): TWmiParam;
    function FindParam(const Value: string): TWmiParam;

    property Items[Index: Integer]: TWmiParam read GetItem write SetItem; default;
    property ParamValues[const ParamName: string]: Variant read GetParamValue write SetParamValue;
  end;


  TWmiMethod = class(TComponent)
  private
    FWmiObjectSource: IWmiObjectSource;
    FWmiMethodName: widestring;
    FInParams:   TWmiParams;
    FOutParams:  TWmiParams;
    FPrivileges: TWmiPrivileges;
    FWmiMethodQualifiers: TWmiQualifiers;
    function  GetWmiMethodName: widestring;
    procedure SetWmiMethodName(const Value: widestring);
    procedure SetWmiObjectSource(const Value: IWmiObjectSource);
    function  GetInParams: TWmiParams;
    function  GetOutParams: TWmiParams;
    procedure SetInParams(const Value: TWmiParams);
    procedure SetOutParams(const Value: TWmiParams);
    function  GeTWmiQualifiers: TWmiQualifiers;
    procedure SeTWmiQualifiers(const Value: TWmiQualifiers);
    function  GetDesignTime: boolean;
    function  GetLastWmiErrorDescription: widestring;
    function  GetLastWmiError: integer;
    procedure SetLastWmiErrorDescription(const Value: widestring);
    procedure SetLastWmiError(const Value: integer);
    { Private declarations }
  protected
    { Protected declarations }
    // When IWmiObject is destroyed, this method will be called to notify
    // this component
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ParseOutParams(AMethodResult: ISWbemObject);
    property  IsDesignTime: boolean read GetDesignTime;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   FetchInParams;
    procedure   ListMethodNames(AList: TStrings);
    function    GetCurrentWmiObject: ISWbemObject;
    function    Execute: integer;
  published
    { Published declarations }
    property    WmiMethodName: widestring read GetWmiMethodName write SetWmiMethodName;
    property    WmiMethodQualifiers: TWmiQualifiers read GeTWmiQualifiers write SeTWmiQualifiers stored false;
    property    WmiObjectSource: IWmiObjectSource read FWmiObjectSource write SetWmiObjectSource;
    property    InParams: TWmiParams read GetInParams write SetInParams;
    property    OutParams: TWmiParams read GetOutParams write SetOutParams stored false;
    property    Privileges: TWmiPrivileges read FPrivileges write FPrivileges;
    property    LastWmiErrorDescription: widestring read GetLastWmiErrorDescription write SetLastWmiErrorDescription stored false;
    property    LastWmiError: integer read GetLastWmiError write SetLastWmiError stored false;  
  end;

implementation

resourcestring
  WMI_OBJECT_SOURCE_NOT_ASSIGNED = 'WmiObjectSource property is not assigned. Cannot execute method of non existing object.';
  WMI_OBJECT_SOURCE_DOES_NOT_RETURN_OBJECT = 'WmiObjectSource does not return the object. Cannot execute method of non existing object.';
  WMI_METHOD_NAME_IS_NOT_SPECIFIED = 'WmiMethodName is not specified. Cannot execute unknown method.'; 

{ TWmiMethod }

function TWmiMethod.GetWmiMethodName: widestring;
begin
  Result := FWmiMethodName;
end;

procedure TWmiMethod.ListMethodNames(AList: TStrings);
var
  vObject: ISWbemObject;
  vMethodEnum: IEnumVariant;
  vFetchedCount: cardinal;
  vOleVar: OleVariant;
  vMethod: ISWbemMethod;
  vName: widestring;
begin
  vObject := GetCurrentWmiObject;
  if (vObject <> nil) then
  begin
    vMethodEnum := WmiGetObjectMethods(vObject);
    while (vMethodEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
    begin
      vMethod    := IUnknown(vOleVar) as ISWBemMethod;
      vOleVar  := Unassigned;
      WmiCheck(vMethod.Get_Name(vName));
      AList.Add(vName);
    end;
  end;   
end;

procedure TWmiMethod.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (FWmiObjectSource <> nil) and
     (FWmiObjectSource.GetImplementingComponent = AComponent) and
     (Operation = opRemove) then
  begin
    FWmiObjectSource := nil;
  end;
end;

procedure TWmiMethod.SetWmiMethodName(const Value: widestring);
begin
  if Value <> FWmiMethodName then
  begin
    FWmiMethodName := Value;
    FWmiMethodQualifiers.Clear;
    InParams.Clear;
    FetchInParams;
  end;
end;

procedure TWmiMethod.SetWmiObjectSource(const Value: IWmiObjectSource);
begin
  if Pointer(FWmiObjectSource) <> Pointer(Value) then
  begin
    FWmiObjectSource := Value;
    FWmiMethodQualifiers.Clear;
    FetchInParams;
  end;  
end;

procedure TWmiMethod.FetchInParams;
var
  vObject: ISWbemObject;
  vMethod: ISWbemMethod;
  vParam:  ISWbemProperty;
  vParamEnum: IEnumVariant;
  vFetchedCount: cardinal;
  vOleVar: OleVariant;
  vName: widestring;
  vCimType: TOleEnum;
  vIsArray: wordbool;
  vFieldType: TFieldType;
  vSize: word;
begin
  vObject := GetCurrentWmiObject;
  if (vObject <> nil) and (WmiMethodName <> '') then
  begin
    vMethod := WmiGetObjectMethodSafe(vObject, FWmiMethodName);
    if vMethod <> nil then
    begin
      FInParams.Clear;
      vParamEnum := WmiGetMethodParams(vMethod);
      if vParamEnum <> nil then
        while (vParamEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
        begin
          vParam   := IUnknown(vOleVar) as ISWbemProperty;
          vOleVar  := Unassigned;
          WmiCheck(vParam.Get_Name(vName));
          WmiCheck(vParam.Get_CIMType(vCimType));
          WmiCheck(vParam.Get_IsArray(vIsArray));
          CimTypeToFieldType(vCimType, vIsArray, vFieldType, vSize);
          FInParams.CreateParam(vFieldType, vName);
        end;
    end;
  end;
end;

{ TParams }

procedure TWmiParams.AddParam(Value: TWmiParam);
begin
  Value.Collection := Self;
end;

procedure TWmiParams.AssignValues(Value: TWmiParams);
var
  I: Integer;
  P: TWmiParam;
begin
  for I := 0 to Value.Count - 1 do
  begin
    P := FindParam(Value[I].Name);
    if P <> nil then
      P.Assign(Value[I]);
  end;
end;

constructor TWmiParams.Create(Owner: TPersistent);
begin
  inherited Create(TWmiParam);
  FOwner := Owner;
end;

function TWmiParams.CreateParam(FldType: TFieldType;
  const ParamName: string): TWmiParam;
begin
  Result := Add as TWmiParam;
  Result.Name := ParamName;
  Result.DataType :=  FldType;
end;

function TWmiParams.FindParam(const Value: string): TWmiParam;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := TWmiParam(inherited Items[I]);
    if AnsiCompareText(Result.Name, Value) = 0 then Exit;
  end;
  Result := nil;
end;

function TWmiParams.GetItem(Index: Integer): TWmiParam;
begin
  Result := TWmiParam(inherited Items[Index]);
end;

function TWmiParams.GetOwner: TPersistent;
begin
  Result := FOwner;
end;


procedure TWmiParams.GetParamList(List: TList; const ParamNames: string);
var
  Pos: Integer;
begin
  Pos := 1;
  while Pos <= Length(ParamNames) do
    List.Add(ParamByName(ExtractFieldName(ParamNames, Pos)));
end;

function TWmiParams.GetParamValue(const ParamName: string): Variant;
var
  I: Integer;
  Params: TList;
begin
  if Pos(';', ParamName) <> 0 then
  begin
    Params := TList.Create;
    try
      GetParamList(Params, ParamName);
      Result := VarArrayCreate([0, Params.Count - 1], varVariant);
      for I := 0 to Params.Count - 1 do
        Result[I] := TParam(Params[I]).Value;
    finally
      Params.Free;
    end;
  end else
    Result := ParamByName(ParamName).Value
end;

function TWmiParams.IsEqual(Value: TWmiParams): Boolean;
var
  I: Integer;
begin
  Result := Count = Value.Count;
  if Result then
    for I := 0 to Count - 1 do
    begin
      Result := Items[I].IsEqual(Value.Items[I]);
      if not Result then Break;
    end
end;

function TWmiParams.ParamByName(const Value: string): TWmiParam;
begin
  Result := FindParam(Value);
  if Result = nil then
    DatabaseErrorFmt(SParameterNotFound, [Value], TComponent(FOwner));
end;

procedure TWmiParams.RemoveParam(Value: TWmiParam);
begin
  Value.Collection := nil;
end;

procedure TWmiParams.SetItem(Index: Integer; Value: TWmiParam);
begin
  inherited SetItem(Index, TCollectionItem(Value));
end;

procedure TWmiParams.SetParamValue(const ParamName: string;
  const Value: Variant);
var
  I: Integer;
  Params: TList;
begin
  if Pos(';', ParamName) <> 0 then
  begin
    Params := TList.Create;
    try
      GetParamList(Params, ParamName);
      for I := 0 to Params.Count - 1 do
        TParam(Params[I]).Value := Value[I];
    finally
      Params.Free;
    end;
  end else
    ParamByName(ParamName).Value := Value;
end;

constructor TWmiMethod.Create(AOwner: TComponent);
begin
  inherited;
  FInParams  :=  TWmiParams.Create(self);
  FOutParams :=  TWmiParams.Create(self);
  FWmiMethodQualifiers := TWmiQualifiers.Create(self);
end;

function TWmiMethod.GetInParams: TWmiParams;
begin
  Result := FInParams;
end;

function TWmiMethod.GetOutParams: TWmiParams;
begin
  Result := FOutParams;
end;

procedure TWmiMethod.SetInParams(const Value: TWmiParams);
begin

end;

procedure TWmiMethod.SetOutParams(const Value: TWmiParams);
begin

end;

destructor TWmiMethod.Destroy;
begin
  FInParams.Free;
  FOutParams.Free;
  FWmiMethodQualifiers.Free;
  inherited;
end;

function TWmiMethod.GetCurrentWmiObject: ISWbemObject;
begin
  Result := nil;
  if (WmiObjectSource <> nil) then Result := WmiObjectSource.GetWmiObject;
end;

function TWmiMethod.Execute: integer;
var
  vObject:   ISWbemObject;
  vInParams, vOutParams:  ISWbemObject;
  vInParam: ISWbemProperty;
  vIsArray: wordbool;
  i: integer;
  vPrivilege: TWmiPrivilege;
  vOlePrivilege: TOleEnum;
  vOleVar: OleVariant;

  vQualifier: TWmiQualifier;
  vQualifierValues: OleVariant;
  s: widestring;
begin
  // check that all the pre-requisits are met.
  if WmiObjectSource = nil then
     raise TWmiException.Create(WMI_OBJECT_SOURCE_NOT_ASSIGNED);

  vObject := GetCurrentWmiObject;
  if vObject = nil then
     raise TWmiException.Create(WMI_OBJECT_SOURCE_DOES_NOT_RETURN_OBJECT);

  if Trim(WmiMethodName) = '' then
     raise TWmiException.Create(WMI_METHOD_NAME_IS_NOT_SPECIFIED);

  // apply privileges explisitly specified by user
  if Privileges <> [] then
    for vPrivilege := Low(TWmiPrivilege) to High(TWmiPrivilege) do
      if vPrivilege in Privileges then
      begin
        vOlePrivilege := WmiPrivilegeToOleEnum(vPrivilege);
        WmiSetPrivilegeEnabled(vObject, vOlePrivilege, true);
      end;

  // apply privileges that the qualifier specifies.
  vQualifier := WmiMethodQualifiers.FindQualifier('Privileges');
  if (vQualifier <> nil) then
  begin
    vQualifierValues := vQualifier.Value;
    for i := VarArrayLowBound(vQualifierValues, 1) to VarArrayHighBound(vQualifierValues, 1) do
    begin
      s := vQualifierValues[i];
      vOlePrivilege := WmiPrivilegeNameToOleEnum(s);
      WmiSetPrivilegeEnabled(vObject, vOlePrivilege, true);
    end;
  end; 
      
  // assign input parameters
  vInParams  := WmiCreateClassMethodParameters(vObject, WmiMethodName);
  if vInParams <> nil then
    for i := 0 to InParams.Count - 1 do
    begin
      if InParams[i].IsNull then Continue;
      
      if InParams[i].DataType = ftDateTime then
      begin
        WmiSetDateTimeParameter(vInParams, InParams[i].Name, InParams[i].AsDateTime);
      end else
      if InParams[i].DataType = ftTime then
      begin
        WmiSetTimeParameter(vInParams, InParams[i].Name, InParams[i].AsDateTime);
      end else
      begin
        vInParam := WmiAddParameter(vInParams, InParams[i].Name);
        WmiCheck(vInParam.Get_IsArray(vIsArray));
        if vIsArray then
        begin
          vOleVar := varArrayCreate([0, 0], varvariant);
          vOleVar[0] := InParams[i].Value;
        end else
        begin
          {$WARNINGS OFF}
          vOleVar := InParams[i].Value;
          {$WARNINGS ON}
        end;  
        WmiCheck(vInParam.Set_Value(vOleVar));
      end;
    end;

  // execute method
  WmiCheck(vObject.ExecMethod_(WmiMethodName, vInParams, 0, nil, vOutParams));
  ParseOutParams(vOutParams);

  // extract execution result.
  Result := LastWmiError;
end;

procedure TWmiMethod.ParseOutParams(AMethodResult: ISWbemObject);
var
  vParam:  ISWbemProperty;
  vParamEnum: IEnumVariant;
  vFetchedCount: cardinal;
  vOleVar: OleVariant;
  vName: widestring;
  vCimType: TOleEnum;
  vIsArray:   wordbool;
  vFieldType: TFieldType;
  vSize: word;
  vWmiParam: TWmiParam;
begin
  if (AMethodResult <> nil) then
  begin
    FOutParams.Clear;
    vParamEnum := WmiGetObjectProperties(AMethodResult);
    if vParamEnum <> nil then
      while (vParamEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
      begin
        vParam   := IUnknown(vOleVar) as ISWbemProperty;
        vOleVar  := Unassigned;
        WmiCheck(vParam.Get_Name(vName));
        WmiCheck(vParam.Get_CIMType(vCimType));
        WmiCheck(vParam.Get_IsArray(vIsArray));
        WmiCheck(vParam.Get_Value(vOleVar));
        CimTypeToFieldType(vCimType, vIsArray, vFieldType, vSize);
        vWmiParam := FOutParams.CreateParam(vFieldType, vName);
        vWmiParam.SetAsVariant(vOleVar);
      end;
  end;
end;

function TWmiMethod.GeTWmiQualifiers: TWmiQualifiers;
var
  vObject: ISWbemObject;
  vMethod: ISWbemMethod;
  vQualifier:  ISWbemQualifier;
  vQualifierEnum: IEnumVariant;
  vFetchedCount: cardinal;
  vOleVar: OleVariant;
  vPath: ISWbemObjectPath;
  vClass: widestring;
begin
  Result := FWmiMethodQualifiers;
  if FWmiMethodQualifiers.Count > 0 then Exit;

  vObject := GetCurrentWmiObject;
  if (vObject <> nil) and (WmiMethodName <> '') then
  begin
    // if the vObject represents an existing instance of class - it will never
    // have the fill set of qualifiers. I need all the qualifiers.
    WmiCheck(vObject.Get_Path_(vPath));
    WmiCheck(vPath.Get_Class_(vClass));
    WmiCheck(WmiObjectSource.GetWmiServices.Get(vClass, wbemFlagUseAmendedQualifiers , nil, vObject));

    // obtain the qualifiers for a new object. It should be a full set of qualifiers 
    vMethod := WmiGetObjectMethodSafe(vObject, FWmiMethodName);
    if vMethod <> nil then
    begin
      FWmiMethodQualifiers.Clear;
      vQualifierEnum := WmiGetMethodQualifiers(vMethod);
      if vQualifierEnum <> nil then
        while (vQualifierEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
        begin
          vQualifier   := IUnknown(vOleVar) as ISWbemQualifier;
          vOleVar  := Unassigned;
          TWmiQualifier.Create(FWmiMethodQualifiers, vQualifier);
        end;
      Result := FWmiMethodQualifiers;
    end;
  end;
end;

procedure TWmiMethod.SeTWmiQualifiers(const Value: TWmiQualifiers);begin end;

function TWmiMethod.GetDesignTime: boolean;
begin
  Result := csDesigning in ComponentState;
end;

function TWmiMethod.GetLastWmiErrorDescription: widestring;
var
  vLastError: integer;
  vQualifier: TWmiQualifier;
  vErrors: OleVariant;
  vDescriptions: OleVariant;
  vLowBound, vHighBound, i: integer;
begin
  Result  := '';
  vErrors := Unassigned;
  vDescriptions := Unassigned;
  vLastError := LastWmiError;

  if vLastError <> -1 then
  begin
    vQualifier := WmiMethodQualifiers.FindQualifier('Values');
    if (vQualifier <> nil) then vDescriptions := vQualifier.GetVariantValue else Exit;
    vQualifier := WmiMethodQualifiers.FindQualifier('ValueMap');
    if (vQualifier <> nil) then
    begin
      // both Values and ValueMap qualifiers are present.
      // find the description of error in vDescriptions array by index.
      // index is the same as the index of value vLastError in vErrors array
      vErrors := vQualifier.GetVariantValue;
      vLowBound := VarArrayLowBound(vErrors, 1);
      vHighBound := VarArrayHighBound(vErrors, 1);
      for i := vLowBound to vHighBound do
        if vLastError = vErrors[i] then
        begin
          Result := vDescriptions[i];
          Exit;
        end;
    end else
    begin
      // only Values qualifier is present.
      // The vLastError value should be an index in vDescription array.
      if vLastError <= VarArrayHighBound(vDescriptions, 1) then
        Result := vDescriptions[vLastError];
    end;
  end;
end;

procedure TWmiMethod.SetLastWmiError(const Value: integer);begin end;
procedure TWmiMethod.SetLastWmiErrorDescription(const Value: widestring); begin end;

function TWmiMethod.GetLastWmiError: integer;
var
  vOutParam: TWmiParam;
begin
  vOutParam := OutParams.FindParam('ReturnValue');
  if vOutParam <> nil then Result := vOutParam.AsInteger
    else Result := -1;
end;

{ TWmiParam }

procedure TWmiParam.Assign(Source: TPersistent);
begin
  if Source is TWmiParam then
    AssignParam(TWmiParam(Source))
  else if Source is TField then
    AssignField(TField(Source))
  else
    inherited Assign(Source);
end;

procedure TWmiParam.AssignField(Field: TField);
begin
  if Field <> nil then
  begin
    AssignFieldValue(Field, Field.Value);
    Name := Field.FieldName;
  end;
end;

procedure TWmiParam.AssignFieldValue(Field: TField; const Value: Variant);
begin
  if Field <> nil then
  begin
    if (Field.DataType = ftString) and TStringField(Field).FixedChar then
      DataType := ftFixedChar
    else if (Field.DataType = ftMemo) and (Field.Size > 255) then
      DataType := ftString
    else
      DataType := Field.DataType;
    if VarIsNull(Value) then
      Clear else
      Self.Value := Value;
  end;
end;

procedure TWmiParam.AssignParam(Param: TWmiParam);
begin
  if Param <> nil then
  begin
    FDataType := Param.DataType;
    if Param.IsNull then
      Clear else
      Value := Param.FData;
    Name := Param.Name;
  end;
end;

procedure TWmiParam.Clear;
begin
  FNull := True;
  FData := Unassigned;
end;

constructor TWmiParam.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FDataType := ftUnknown;
  FData := Unassigned;
  FNull := True;
end;

function TWmiParam.GetAsBoolean: Boolean;
begin
  if IsNull then
    Result := False else
    Result := FData;
end;

function TWmiParam.GetAsDateTime: TDateTime;
begin
  if IsNull then
    Result := 0 else
    Result := VarToDateTime(FData);
end;

function TWmiParam.GetAsFloat: Double;
begin
  if IsNull then
    Result := 0 else
    Result := FData;
end;

function TWmiParam.GetAsInteger: Longint;
begin
  if IsNull then
    Result := 0 else
    Result := FData;
end;

function TWmiParam.GetAsString: string;
begin
  if IsNull then
    Result := ''
  else if DataType = ftBoolean then
  begin
    if FData then
      Result := STextTrue else
      Result := STextFalse;
  end else
    Result := FData;
end;

function TWmiParam.GetAsTime: TDateTime;
begin
  if IsNull then
    Result := 0 else
    Result := VarToDateTime(FData);
end;

function TWmiParam.GetAsVariant: Variant;
begin
  Result := FData;
end;

function TWmiParam.GetDataType: TFieldType;
begin
  Result := FDataType;
end;

function TWmiParam.GetDisplayName: string;
begin
  Result := FName;
end;

function TWmiParam.GetIsNull: Boolean;
begin
//  Result := FNull or VarIsNull(FData) or VarIsClear(FData);
  Result := FNull or VarIsNull(FData) or VarIsEmpty(FData);
end;

function TWmiParam.GetWmiMethod: TWmiMethod;
var
  vParams: TWmiParams;
begin
  vParams := TWmiParams(Collection);
  Result  := TWmiMethod(vParams.FOwner);
end;

function TWmiParam.IsEqual(Value: TWmiParam): Boolean;
begin
  Result := (VarType(FData) = VarType(Value.FData)) and
//    (VarIsClear(FData) or (FData = Value.FData)) and
    (VarIsEmpty(FData) or (FData = Value.FData)) and
    (Name = Value.Name) and (DataType = Value.DataType) and
    (IsNull = Value.IsNull);
end;

procedure TWmiParam.SetAsBoolean(Value: Boolean);
begin
  FDataType := ftBoolean;
  Self.Value := Value;
end;

procedure TWmiParam.SetAsDateTime(const Value: TDateTime);
begin
  FDataType := ftDateTime;
  Self.Value := Value
end;

procedure TWmiParam.SetAsFloat(const Value: Double);
begin
  FDataType := ftFloat;
  Self.Value := Value;
end;

procedure TWmiParam.SetAsInteger(Value: Integer);
begin
  FDataType := ftInteger;
  Self.Value := Value;
end;

procedure TWmiParam.SetAsString(const Value: string);
begin
  if FDataType <> ftFixedChar then FDataType := ftString;
  Self.Value := Value;
end;

procedure TWmiParam.SetAsTime(const Value: TDateTime);
begin
  FDataType := ftTime;
  Self.Value := Value
end;

procedure TWmiParam.SetAsVariant(const Value: Variant);
begin
//  FNull := VarIsClear(Value) or VarIsNull(Value);
  FNull := VarIsEmpty(Value) or VarIsNull(Value);
  if FDataType = ftUnknown then
    case VarType(Value) of
      varSmallint, varByte:     FDataType := ftSmallInt;
      varInteger:               FDataType := ftInteger;
      varCurrency:              FDataType := ftBCD;
      varSingle, varDouble:     FDataType := ftFloat;
      varDate:                  FDataType := ftDateTime;
      varBoolean:               FDataType := ftBoolean;
      varString, varOleStr:     if FDataType <> ftFixedChar then FDataType := ftString;
      {$IFDEF Delphi6}
      varShortInt:              FDataType := ftSmallInt;
      varWord:                  FDataType := ftInteger;
      varLongWord:              FDataType := ftFloat;
      varInt64:                 FDataType := ftLargeInt;
      {$ENDIF}
    else
        FDataType := ftUnknown;
    end;
  FData := Value;
end;

procedure TWmiParam.SetDataType(Value: TFieldType);
{$IFDEF Delphi6}
const
  VarTypeMap: array[TFieldType] of Integer = (varError,  varOleStr,  varSmallint,
       varInteger, varSmallint, varBoolean, varDouble, varCurrency, varCurrency,
       varDate, varDate, varDate, varOleStr, varOleStr, varInteger, varOleStr,
       varOleStr, varOleStr, varOleStr, varOleStr, varOleStr, varOleStr, varError,
       varOleStr, varOleStr, varError, varError, varError, varError, varError,
       varOleStr, varOleStr, varVariant, varUnknown, varDispatch, varOleStr, varOleStr, varOleStr);
{$ELSE}
const
  VarTypeMap: array[TFieldType] of Integer = (varError, varOleStr, varSmallint,
    varInteger, varSmallint, varBoolean, varDouble, varCurrency, varCurrency,
    varDate, varDate, varDate, varOleStr, varOleStr, varInteger, varOleStr,
    varOleStr, varOleStr, varOleStr, varOleStr, varOleStr, varOleStr, varError,
    varOleStr, varOleStr, varError, varError, varError, varError, varError,
    varOleStr, varOleStr, varVariant, varUnknown, varDispatch, varOleStr);
{$ENDIF}       
var
  vType: Integer;
  vOwnerComp: TWmiMethod;
begin
  FDataType := Value;
  vOwnerComp := GetWmiMethod;
  if Assigned(vOwnerComp) and (vOwnerComp.IsDesignTime) and
     (not IsNull) then
  begin
    vType := VarTypeMap[Value];
    if vType <> varError then
    begin
      try
        VarCast(FData, FData, vType);
      except
        Clear;
      end
    end else
    begin
      Clear;
    end;  
  end else
  begin
    Clear;
  end;  
end;


end.
