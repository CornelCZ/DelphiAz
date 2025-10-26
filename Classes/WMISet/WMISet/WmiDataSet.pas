unit WmiDataSet;

interface
{$INCLUDE ..\Common\define.inc}

{$NOINCLUDE WbemScripting_TLB}
{$HPPEMIT '#include <wbemdisp.h>'}
{$HPPEMIT '#include <oaidl.h>'}
{$HPPEMIT '#include "wbem_script_support.h"'}

uses
  Windows, Messages, SysUtils, Classes, DB, WmiConnection,
  WbemScripting_TLB, WmiUtil, ActiveX, WmiErr,
  {$IFDEF Delphi6}
  Variants,  StrUtils,
  {$ENDIF}
  DBConsts,
  WmiAbstract;

type
  TInterfaceHolder = class;
  TVariantHolder = class;
  TWmiDataBuffer = class;
  TWmiDataSet = class;
  TWmiQuery = class;

  // this class keeps an interface pointer to the
  // one record in WmiQuery dataset.
  // it also caches property values of the pointed object.
  TInterfaceHolder = class
  private
    FWbemObject: ISWbemObject;
    FWbemObjectProperties: ISWbemPropertySet; // cached properties of the object
    FIndex: integer;
    FCache: TStringList; // cached prperty values.
    procedure SetWbemObject(const Value: ISWbemObject);
    function  GetWbemObjectProperties: ISWbemPropertySet;
  public
    constructor Create(AWbemObject: ISWbemObject; AIndex: integer);
    destructor  Destroy; override;
    procedure   ClearCache;
    function    GetPropertyValueByName(const AName: widestring): OleVariant;
    property    WbemObject: ISWbemObject read FWbemObject write SetWbemObject;
    property    Index: integer read FIndex write FIndex;
  end;

  TVariantHolder = class
  private
    FValue: OleVariant;
  public
    constructor Create(AValue: OleVariant); 
    property Value: OleVariant read FValue; 
  end;



  // This class knows how to retrieve next record fron the result set.
  // It also caches record for WmiDataSet.
  TWmiDataBuffer = class
  private
    FWmiData: IEnumVariant;
    FUniDirectional: boolean;
    FRecord: TInterfaceHolder;
    FEof: boolean;
    FBof: boolean;
    FAllRetrieved: boolean; // All records where retrieved and are in the buffer.
    FBeforeFirstRecord: boolean;
    FBeyondLastRecord: boolean;
    FDataBuffer: TList;
    FBufferIndex: integer;
    function GetCount: integer;
    function GetRecordCount: integer;
  protected
    procedure SetBufferIndex(AValue: integer);

  public
    constructor Create(AWmiData: IEnumVariant; IsUniDirectional: boolean);
    destructor  Destroy; override;
    function    GetRecord: ISWbemObject; overload;
    procedure Next;
    procedure Prev;
    procedure First;
    procedure Last;
    procedure DeleteRecord(AIndex: integer);
    property Bof: boolean read FBof;
    property Eof: boolean read FEof;
    property Count: integer read GetCount;
    property RecordCount: integer read GetRecordCount;
  end;

  // This class knows how to convert variant arrays to string,
  // so they can be shown in DBGrid
  TWmiVariantField = class(TVariantField)
  protected
    function GetAsString: string; override;
  public
  end;

  // override to fix bug: SetAsWideString does not work
  TWmiWideStringField = class(TWideStringField)
  protected
    function GetDataSize: Integer; override;
    procedure SetAsString(const Value: string); override;
    procedure SetAsWideString(const Value: WideString);
  end;

  TWmiFieldDef = class(TFieldDef)
  private
    FIsArray: boolean;
  public
    constructor Create(Owner: TFieldDefs; const Name: string;
      DataType: TFieldType; Size: Integer; Required: Boolean;
      FieldNo: Integer; IsArray: boolean);
  published
    property IsArray: boolean read FIsArray;
  end;

  // This is a dataset that executes WMI queries
  TWmiDataSet = class(TDataSet, IWmiObjectSource)
  private
    FConnection: TWmiConnection;
    FWQL: TStrings;
    FData: TWmiDataBuffer;
    FAsynchronous: boolean;
    FIrregularView: boolean;
    FIrregularFieldDefs: TFieldDefs;
    FReadOnly: boolean;

    procedure SetConnection(const Value: TWmiConnection);
    procedure CheckConnectionActive;
    procedure CheckWQLDefined;
    procedure SetWQL(const Value: TStrings);
    function  GetQueryFlags: integer;
    function  GetDataRecord(Buffer: PChar; DoCheck: Boolean): TGetResult;
    function  ConvertFieldData(const Field: TField; const Value: OleVariant;
      const Buffer: Pointer): boolean;
    procedure SetAsynchronous(const Value: boolean);
    procedure SetIrregularView(const Value: boolean);
    function GetIrregularFieldValues(AFieldName: string): Variant;
    function GetCurrentObject: ISWbemObject;
    function ConvertQualifiersToAttributes(
      AProperty: ISWbemProperty): TFieldAttributes;
    { Private declarations }
  protected
    { Method stubs for UniDirectional/Readonly/Unbuffered datasets }
    function  AllocRecordBuffer: PChar; override;
    procedure FreeRecordBuffer(var Buffer: PChar); override;

    // this creates field definition according to the provided
    // pattern and adds them to AFieldDefs storage.
    procedure CreateFieldDefs(AFieldDefs: TFieldDefs; APattern: ISWbemObject; AIrregular: boolean); virtual;

    // when irregular query is executed, this method
    // fills in IrregularFieds every time when cursor moves.

    { methods of TDataSet}
    function  GetRecord(Buffer: PChar; GetMode: TGetMode; DoCheck: Boolean): TGetResult; override;
    procedure InternalClose; override;
    procedure InternalHandleException; override;

    // this method is called by TDataSet when the user scrolls
    // in the DBGrid, and TDataSet updates current position in
    // its buffer. This methid is called so the descendant (this class)
    // has a chance to learn which record is current.
    procedure InternalSetToRecord(Buffer: PChar); override;

    // TDataSet calls this method when, for example, TDBText is looking for
    // available fileds in the dataset at design time.
    procedure InternalInitFieldDefs; override;

    // TDataSet calls this method if dataset was sucessfully open.
    procedure DoAfterOpen; override;

    // TDataSet calls this method to find out if the dataset can be modified.
    // Among other things, this controls if TDBGrid will automatically
    // display a new record, if user hits "down" key while at the last
    // record.
    function GetCanModify: Boolean; override;

    // this method is called by TDataSet to open cursor.
    // It supposed to execute query and set cursor on the first record.
    procedure InternalOpen; override;

    // this nethod is called from TDataSet.Edit
    procedure InternalEdit; override;

    // this method is called when editing (insertion)
    // is canceled before post
    procedure InternalCancel; override;

    procedure InternalInsert; override;

    procedure InternalAddRecord(Buffer: Pointer; Append: Boolean); override;
    
    // this nethod is called from TDataSet.Post
    procedure InternalPost; override;

    procedure CreateFields; override;

    // in Delphi 5 a lot of methods are defined abstract
    // I have to override it to avoid exceptions    
    function GetBookmarkFlag(Buffer: PChar): TBookmarkFlag; override;

    // this method does returns number of records that have been
    // into internal buffer of this component.
    // it DOES NOT retrieve the number of records that may be retrieved
    // from the dataset.
    //
    // If this method was not be overriden, TDBGrid would not show
    // vertical scroll bar.
    function GetRecordCount: Integer; override;

    // TDBGrid calls this method to calculate position
    // of its vertical scroll bar.
    function GetRecNo: integer; override;

    // TDBGrid calls this method when user chages position in the verrical
    // scroll bar.
    procedure SetRecNo(Value: Integer); override;

    // TDBGrid calls this method when user drugs scroll bar pointer to
    // the first record.
    procedure InternalFirst; override;

    // TDBGrid calls this method when user drugs scroll bar pointer to
    // the last record.
    procedure InternalLast; override;

    function  IsCursorOpen: Boolean; override;

    // When TWmiConnection is destroyed, this method will be called to notify
    // this component
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    // TDataSet calls this method when user requests bookmark
    procedure GetBookmarkData(Buffer: PChar; Data: Pointer); override;

    // TDataSet calls this method when user GotoBookmark is called
    procedure InternalGotoBookmark(Bookmark: Pointer); override;

    // TDataSet calls this method field gets new value
    procedure SetFieldData(Field: TField; Buffer: Pointer); override;

    // This method is required to plug-in the new implementetion
    // of TVariantField. My implementation knows how to deal with
    // variant arrays.
    function  GetFieldClass(FieldType: TFieldType): TFieldClass; override;

    procedure InternalDelete; override;

    // Use this method to catch the fact that TDataSet clears
    // its buffers. Use it synchronize with my buffers. 
    procedure ClearBuffers; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function    GetFieldData(Field: TField; Buffer: Pointer): Boolean; override;
    function    GetFieldData(Field: TField; Buffer: Pointer; NativeFormat: Boolean): Boolean; overload; override;
    function    BookmarkValid(Bookmark: TBookmark): Boolean;   override;
    function    Locate(const KeyFields: string; const KeyValues: Variant; Options: TLocateOptions): Boolean; override;

    { IWmiObjectSource implementation}
    function    GetWmiObject: ISWbemObject;
    function    GetWmiServices: ISWbemServices;
    function    GetImplementingComponent: TComponent;

    property    Connection: TWmiConnection read FConnection write SetConnection;
    property    Active;
    property    WQL: TStrings read FWQL write SetWQL;
    property    Asynchronous: boolean read FAsynchronous write SetAsynchronous default true;
    property    ReadOnly: boolean read FReadOnly write FReadOnly default true;

    // in irregular view the data set only one field called 'Object';
    // The field value is a variant that has the Wmi Object
    property    IrregularView: boolean read FIrregularView write SetIrregularView;
    property    IrregularFieldDefs: TFieldDefs read FIrregularFieldDefs;
    property    IrregularFieldValues[AFieldName: string]: Variant read GetIrregularFieldValues;
    property    CurrentObject: ISWbemObject read GetCurrentObject;
  end;
  
  // The component that will show up in the component pallette.
  TWmiQuery = class(TWmiDataSet)
  published
    property  Connection;
    property  Active;
    property  WQL;
    property  Asynchronous;
    property  IrregularView;
    property  ReadOnly;

    property BeforeOpen;
    property AfterOpen;
    property BeforeClose;
    property AfterClose;
    property BeforeScroll;
    property AfterScroll;
    property BeforeRefresh;
    property AfterRefresh;
  end;
  
resourcestring
  ERROR_CONNECTION_NOT_DEFINED = 'Connection is not defined';
  ERROR_WQL_IS_NOT_DEFINED = 'WQL is not defined';
  CANNOT_INSERT_RECORD_IN_IRREGULAR_VIEW = 'Cannot insert record in IrregularView mode';

  // Name of the only field in "Fields" property that
  // WmiDataSet has when in "irregular view"
  OBJECT_FIELD = 'Object';

implementation

{ TWmiDataSet }

constructor TWmiDataSet.Create(AOwner: TComponent);
begin
  inherited;
  FWQL  := TStringList.Create;
  BookmarkSize := SizeOf(integer); 
  FData := nil;
  Asynchronous := true;
  FReadOnly := true;
  FIrregularFieldDefs := TFieldDefs.Create(self);
end;

function TWmiDataSet.GetDataRecord(Buffer: PChar; DoCheck: Boolean): TGetResult;
var
  vHolder: TInterfaceHolder;
begin
  if FData.FRecord = nil then
  begin
    if FData.Eof then Result := grEof
      else
    if FData.Bof then Result := grBOF
      else
    Result := grError;
  end else
  begin
    vHolder := TInterfaceHolder(Buffer);
    vHolder.WBemObject := FData.FRecord.WbemObject;
    vHolder.Index      := FData.FBufferIndex;

    Result := grOK;
  end;
end;

function TWmiDataSet.GetRecord(Buffer: PChar; GetMode: TGetMode;
  DoCheck: Boolean): TGetResult;
begin
  if GetMode = gmCurrent then
  begin
    Result := GetDataRecord(Buffer, DoCheck);
  end else
  if GetMode = gmNext then
  begin
    FData.Next;
    Result := GetDataRecord(Buffer, DoCheck);
  end else
  if GetMode = gmPrior then
  begin
    FData.Prev;
    result := GetDataRecord(Buffer, DoCheck);
  end else
  begin
    result := grError;
  end;

  if (result <> grError) and IrregularView then
  begin
     CreateFieldDefs(FIrregularFieldDefs, FData.GetRecord, false);
  end;

end;

procedure TWmiDataSet.InternalClose;
begin
  FData.Free;
  FData := nil;
  if DefaultFields then DestroyFields;
end;

procedure TWmiDataSet.InternalHandleException;
begin
  raise Exception.Create('InternalHandleException Not implemented');
end;

procedure TWmiDataSet.InternalInitFieldDefs;
begin
  // if WMI object is available, use as a pattern for generating
  // fields.
  if Active and (FData <> nil) and (FData.GetRecord <> nil) then
  begin
    CreateFieldDefs(FieldDefs, FData.GetRecord, IrregularView);
  end else
  if Trim(WQL.Text) <> '' then
  begin
    CreateFieldDefs(FieldDefs, WmiGetPrototypeObject(WQL.Text), IrregularView);
    // todo: execute query in prototype mode and build the fields
  end;
end;

procedure TWmiDataSet.CheckConnectionActive;
begin
  if Connection = nil then
    DatabaseError(ERROR_CONNECTION_NOT_DEFINED);
  Connection.Connected := true;
end;

procedure TWmiDataSet.CheckWQLDefined;
begin
  if Trim(WQL.Text) = '' then
    DatabaseError(ERROR_WQL_IS_NOT_DEFINED);
end;

function  TWmiDataSet.GetQueryFlags: integer;
begin
  if Asynchronous then
   Result := wbemFlagReturnImmediately or wbemFlagForwardOnly
   else Result := wbemFlagReturnWhenComplete or wbemFlagForwardOnly;
end;

procedure TWmiDataSet.InternalOpen;
var
  ObjectSet: SWbemObjectSet;
  vUnknown:  IUnknown;
begin
  CheckWQLDefined;
  CheckConnectionActive;

  WmiCheck(Connection.WmiServices.ExecQuery(
     WQL.Text,  'WQL',
     GetQueryFlags,
     nil,
     ObjectSet));

  WmiCheck(ObjectSet.Get__NewEnum(vUnknown));
  FData := TWmiDataBuffer.Create(vUnknown as IEnumVariant, false);

  if DefaultFields and (not FData.Eof) then
  begin
    CreateFieldDefs(FieldDefs, FData.GetRecord, IrregularView);
    CreateFields;
  end;

  BindFields(True);

end;

function TWmiDataSet.IsCursorOpen: Boolean;
begin
  Result := FData <> nil;
end;

procedure TWmiDataSet.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (AComponent = FConnection) and (Operation = opRemove) then
  begin
    Active := false;
    FConnection := nil;
  end;
end;

procedure TWmiDataSet.SetConnection(const Value: TWmiConnection);
begin
  FConnection := Value;
end;

procedure TWmiDataSet.SetWQL(const Value: TStrings);
begin
  if (Value.Text <> FWQL.Text)  then
  begin
    if not (csLoading in ComponentState) then Close;
    FWQL.Assign(Value);
  end;
end;

destructor TWmiDataSet.Destroy;
begin
  FreeAndNil(FWQL);
  FreeAndNil(FIrregularFieldDefs);
  inherited;
end;

function TWmiDataSet.AllocRecordBuffer: PChar;
begin
  result := PChar(TInterfaceHolder.Create(nil, 0));
end;

procedure TWmiDataSet.FreeRecordBuffer(var Buffer: PChar);
var
  vHolder: TInterfaceHolder;
begin
  vHolder := TInterfaceHolder(Buffer);
  vHolder.WBemObject := nil;
  FreeAndNil(vHolder);
  Buffer := nil;
end;


function TWmiDataSet.ConvertFieldData(const Field: TField;
                                      const Value: OleVariant;
                                      const Buffer: Pointer): boolean;
var
  vWord: word;
  vInteger: integer;
  vString: String;
  vWideString: WideString;
  vBool: WordBool;
  vDouble: double;
  vDateTime: TDateTime;
  vInt64: int64;
begin
  Result := true;
  if Buffer = nil then Exit;
   
  case Field.DataType of
    ftUnknown, ftCurrency, ftBCD, ftParadoxOle,
    ftDBaseOle, ftTypedBinary, ftCursor, ftADT,
    ftDataSet, ftOraBlob, ftOraClob,
    ftGraphic, ftAutoInc,
    {$IFDEF Delphi6}
    ftFMTBcd,
    {$ENDIF}
    ftBlob, ftBytes, ftVarBytes,
    ftMemo, ftFmtMemo,  ftFixedChar,  
    ftReference, ftIDispatch, ftGuid, ftInterface:
      raise Exception.Create('Unknown data type in field '+Field.FieldName);
      
    ftArray:
        Variant(Buffer^) := Value;
    
    ftSmallint, ftWord:
      begin
      vWord := Value;
      word(Buffer^) := vWord;
      end;
    ftInteger:
      begin
      vInteger := Value;
      Move(vInteger, Buffer^, SizeOf(vInteger));
      integer(Buffer^) := Value;
      end;
    ftString:
      begin
      vString := Value;
      String(Buffer^) := vString;
      end;
    ftWideString:
      begin
      vWideString := Value;
      WideString(Buffer^) := vWideString;
      end;
    ftBoolean:
      begin
      vBool := Value;
      WordBool(Buffer^) := vBool;
      end;
    ftFloat:
      begin
      vDouble := Value;
      double(Buffer^) := vDouble;
      end;
    {$IFDEF Delphi6}
    ftTimeStamp,
    {$ENDIF}
    ftDate, ftTime,
    ftDateTime:
      begin
        vString := Value;
        vDateTime := WmiParseDateTime(vString);
        TDateTime(Buffer^) := vDateTime;
      end;
    ftLargeint:
      begin
        vInt64 := VariantToInt64(Value);
        int64(Buffer^) := vInt64;
      end;
    ftVariant:
      begin
        Variant(Buffer^) := Value;
      end;
    end;
end;

function TWmiDataSet.ConvertQualifiersToAttributes(AProperty: ISWbemProperty): TFieldAttributes;
var
  vQualifiers:   ISWbemQualifierSet;
  vUnknown:      IUnknown;
  vQualEnum:     IEnumVariant;
  vOleVar:       OleVariant;
  vQualifier:    ISWbemQualifier;
  vFetchedCount: cardinal;
  vQualName:     widestring;
begin
  Result := [];
  WmiCheck(AProperty.Get_Qualifiers_(vQualifiers));
  WmiCheck(vQualifiers.Get__NewEnum(vUnknown));
  vQualEnum := vUnknown as IEnumVariant;
  while (vQualEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
  begin
    vQualifier := IUnknown(vOleVar) as SWBemQualifier;
    WmiCheck(vQualifier.Get_Name(vQualName));
    if UpperCase(vQualName) = 'KEY' then
    begin
      WmiCheck(vQualifier.Get_Value(vOleVar));
      if vOleVar then Result := Result + [faRequired];
    end;

    if UpperCase(vQualName) = 'READONLY' then
    begin
      WmiCheck(vQualifier.Get_Value(vOleVar));
      if vOleVar then Result := Result + [faReadonly];
    end;
    vOleVar    := Unassigned;
  end;
end;

procedure TWmiDataSet.CreateFieldDefs(AFieldDefs: TFieldDefs; APattern: ISWbemObject; AIrregular: boolean);
var
  vPropSet:  ISWbemPropertySet;
  vPropEnum: IEnumVariant;
  vUnknown:  IUnknown;
  vOleVar:   OleVariant;
  vProp:     ISWbemProperty;
  vFetchedCount: cardinal;
  vCimType:   TOleEnum;
  vIsArray:   wordbool;
  vFieldName: widestring;
  vFieldType: TFieldType;
  vFieldSize: word;
  vFieldNo:   integer;
  vAttributes: TFieldAttributes;
  vFieldDef: TFieldDef;
begin
  AFieldDefs.Clear;
  if APattern = nil then Exit;

  if AIrregular then
  begin
    TWmiFieldDef.Create(AFieldDefs, OBJECT_FIELD, ftVariant, 0, false, 1, false);
  end else
  begin
    WmiCheck(APattern.Get_Properties_(vPropSet));
    WmiCheck(vPropSet.Get__NewEnum(vUnknown));
    vPropEnum := vUnknown as IEnumVariant;
    vFieldNo := 1;
    while (vPropEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
    begin
      vProp   := IUnknown(vOleVar) as SWBemProperty;
      vOleVar := Unassigned;
      WmiCheck(vProp.Get_Name(vFieldName));
      WmiCheck(vProp.Get_CIMType(vCimType));
      WmiCheck(vProp.Get_IsArray(vIsArray));

      vAttributes := ConvertQualifiersToAttributes(vProp);
      CimTypeToFieldType(vCimType, vIsArray, vFieldType, vFieldSize);
      vFieldDef := TWmiFieldDef.Create(AFieldDefs, vFieldName, vFieldType,
                          vFieldSize, false, vFieldNo, vIsArray);
      vFieldDef.Attributes := vAttributes;

      Inc(vFieldNo);
    end;
  end;
end;

function TWmiDataSet.GetFieldData(Field: TField; Buffer: Pointer): Boolean;
var
  vInterfaceHolder: TInterfaceHolder;
  vValue: OleVariant;
begin
  vInterfaceHolder := TInterfaceHolder(ActiveBuffer);

  if vInterfaceHolder.WbemObject <> nil then
  begin
    if IrregularView then
    begin
       vValue := vInterfaceHolder.WbemObject;
       if Buffer <> nil then Variant(Buffer^) := vValue;
       Result := true;
    end else
    begin
//      vValue := vInterfaceHolder.GetPropertyValueByName(Field.FieldName);
      vValue := vInterfaceHolder.GetPropertyValueByName(Field.FieldName);
      if not VarIsNull(vValue) then
        Result := ConvertFieldData(Field, vValue, Buffer)
        else Result := false;
    end;   
  end else
  begin
    Result := false;
  end;
end;

procedure TWmiDataSet.DoAfterOpen;
var
  i: integer;
begin
  inherited;
  // this block is a MUST.
  // It implicitly initializes TDataSet.NestedDataSets property,
  // so TDataSet will call InternalSetToRecord method
  // whenever cursor position is changed in TDataSet's internal buffer.
  // This class relyes on InternalSetToRecord merthod to be called
  // for synchronization purposes. 

  for i := 0 to NestedDataSets.Count - 1 do
    with TDataSet(NestedDataSets[i]) do
      if Active then
        DataEvent(deParentScroll, 0);
end;


function TWmiDataSet.GetFieldData(Field: TField; Buffer: Pointer;
  NativeFormat: Boolean): Boolean;
begin
  Result := GetFieldData(Field, Buffer);
end;

procedure TWmiDataSet.InternalSetToRecord(Buffer: PChar);
begin
  FData.SetBufferIndex(TInterfaceHolder(Buffer).Index);
end;

function TWmiDataSet.GetCanModify: Boolean;
begin
  Result := not ReadOnly;
end;

function TWmiDataSet.GetRecordCount: Integer;
begin
  if Active then 
    Result := FData.RecordCount
    else Result := 0;
end;


function TWmiDataSet.GetRecNo: integer;
var
  vHolder: TInterfaceHolder;
begin
  if (ActiveRecord >= 0) then
  begin
    vHolder := TInterfaceHolder(ActiveBuffer);
    if (vHolder <> nil) then
    begin
      Result := vHolder.Index + 1;
      Exit;
    end;
  end;

  Result := 0;
end;

procedure TWmiDataSet.SetRecNo(Value: Integer);
begin
  CheckBrowseMode;
  DoBeforeScroll;
  FData.SetBufferIndex(Value - 1);
  Resync([]);
  DoAfterScroll;
end;

procedure TWmiDataSet.InternalFirst;
begin
  FData.First;
end;

procedure TWmiDataSet.InternalLast;
begin
  FData.Last;
end;

function TWmiDataSet.BookmarkValid(Bookmark: TBookmark): Boolean;
begin
  Result := integer(Bookmark^) < FData.Count;
end;

procedure TWmiDataSet.GetBookmarkData(Buffer: PChar; Data: Pointer);
begin
  integer(Data^) := TInterfaceHolder(Buffer).Index;
end;

procedure TWmiDataSet.InternalGotoBookmark(Bookmark: Pointer);
var
   vIndex: integer;
begin
  vIndex := integer(Bookmark^);
  if vIndex < FData.Count then FData.SetBufferIndex(vIndex);
end;

procedure TWmiDataSet.SetFieldData(Field: TField; Buffer: Pointer);
var
  vObject: ISWbemObject;
  vInterfaceHolder: TInterfaceHolder;
  vValue: OleVariant;
  
  vWord: word;
  vInteger: integer;
  vString: String;
  vWideString: WideString;
  vBool: WordBool;
  vDouble: double;
  vDateTime: TDateTime;
  vFieldDef: TWmiFieldDef;
  vInt64: int64;
begin
  if not CanModify then DatabaseError(SDataSetReadOnly);
  vInterfaceHolder := TInterfaceHolder(ActiveBuffer);
  vObject := vInterfaceHolder.WbemObject;
  if vObject = nil then DatabaseErrorFmt(SFieldAccessError, [Field.FieldName, 'any']);
  // check if this field is read only.
  if IrregularView then
    vFieldDef := IrregularFieldDefs.Find(Field.FieldName) as TWmiFieldDef
    else vFieldDef := FieldDefs.Find(Field.FieldName) as TWmiFieldDef;
  if faReadOnly in vFieldDef.Attributes then DatabaseErrorFmt(SFieldReadOnly, [Field.FieldName]);

  case Field.DataType of
    ftUnknown, ftCurrency, ftBCD, ftParadoxOle,
    ftDBaseOle, ftTypedBinary, ftCursor, ftADT,
    ftDataSet, ftOraBlob, ftOraClob,
    ftGraphic, ftAutoInc,
    {$IFDEF Delphi6}
    ftFMTBcd,
    {$ENDIF}
    ftBlob, ftBytes, ftVarBytes,
    ftMemo, ftFmtMemo,  ftFixedChar,
    ftReference, ftIDispatch, ftGuid, ftInterface:
      DatabaseErrorFmt(SUnknownFieldType, [Field.FieldName]);

    ftArray:
        vValue := Variant(Buffer^);

    ftSmallint, ftWord:
      begin
      vWord := word(Buffer^);
      vValue := vWord;
      end;
    ftInteger:
      begin
      vInteger := integer(Buffer^);
      vValue   := vInteger;
      end;
    ftString:
      begin
      vString := String(Buffer^);
      vValue  := vString;
      end;
    ftWideString:
      begin
      vWideString := WideString(Buffer^);
      vValue      := vWideString;
      end;
    ftBoolean:
      begin
      vBool  := WordBool(Buffer^);
      vValue := vBool;
      end;
    ftFloat:
      begin
      vDouble := double(Buffer^);
      vValue := vDouble;
      end;
    {$IFDEF Delphi6}
    ftTimeStamp,
    {$ENDIF}
    ftDate, ftTime,
    ftDateTime:
      begin
        vDateTime := TDateTime(Buffer^);
        vValue := WmiEncodeDateTime(vDateTime);
      end;
    ftLargeint:
      begin
        vInt64 := int64(Buffer^);
        {$IFDEF Delphi6}
        vValue := vInt64;
        {$ELSE}
        vValue := IntToStr(vInt64);
        {$ENDIF}
      end;
    ftVariant:
      begin
        if Buffer <> nil then vValue := Variant(Buffer^)
          else vValue := Null;
        if (vFieldDef.IsArray) and
           ((VarType(vValue) = varOleStr) or (VarType(vValue) = varString)) then
          vValue := StringToVariantArray(vValue);
      end;
    end;

  WmiSetObjectPropertyValue(vObject, Field.FieldName, vValue);
  vInterfaceHolder.ClearCache;
end;

function TWmiDataSet.GetFieldClass(FieldType: TFieldType): TFieldClass;
begin
  case FieldType of
   ftVariant: Result := TWmiVariantField;
   ftWideString: Result := TWmiWideStringField;
    else Result := inherited GetFieldClass(FieldType);
  end;  
end;

procedure TWmiDataSet.SetAsynchronous(const Value: boolean);
begin
  if (FAsynchronous <> Value) then
  begin
    if Active then Active := false;
    FAsynchronous := Value;
  end;
end;

procedure TWmiDataSet.SetIrregularView(const Value: boolean);
begin
  if (FIrregularView <> Value) then
  begin
    if Active then Active := false;
    FIrregularView := Value;
    FIrregularFieldDefs.Clear;
  end;
end;


function TWmiDataSet.GetIrregularFieldValues(AFieldName: string): Variant;
var
  vObject: ISWbemObject;
  vProperties: ISWbemPropertySet;
begin
  vObject := FData.GetRecord;
  WmiCheck(vObject.Get_Properties_(vProperties));
  Result := WmiGetPropertyValueByName(vProperties, AFieldName);
end;

procedure SplitStr(Str: string; splitter: char; AResult: TStrings);
var
  vIndex: integer;
begin
  vIndex := Pos(splitter, Str);
  while vIndex > 0 do
  begin
    AResult.Add(Trim(Copy(Str, 1, vIndex - 1)));
    Delete(Str, 1, vIndex);
    vIndex := Pos(splitter, Str);
  end;
  if Trim(Str) <> '' then AResult.Add(Trim(Str));
end;

function TWmiDataSet.Locate(const KeyFields: string;
  const KeyValues: Variant; Options: TLocateOptions): Boolean;

    function GetArrayElement(VarArray: variant; index: integer): variant;
    begin
      if (index = 0) and not (VarIsArray(VarArray)) then Result := VarArray
        else
      Result := VarArray[index];
    end;


    function ValuesMatch(AValue, APattern: Variant; AOptions: TLocateOptions): boolean;
    var
      vValue: string;
      vPattern: string;
    begin
      vValue := VariantToString(AValue);
      vPattern := VariantToString(APattern);
      if loCaseInsensitive in AOptions then
      begin
        vValue := UpperCase(vValue);
        vPattern := UpperCase(vPattern);
      end;

      if loPartialKey in AOptions then Result := AnsiStartsText(vPattern, vValue)
        else Result := vPattern = vValue;
    end;
    
var
  vBookmark: TBookmark;
  vKeyNames: TStrings;
  i: integer;
  vFieldDefs: TFieldDefs;
  vMatchFound: boolean;
  vValue: Variant;
begin
  {$IFDEF Delphi6}
  CheckBiDirectional;
  {$ENDIF}
  
  Result := false;

  vBookmark := GetBookmark;
  vKeyNames := TStringList.Create;
  try
    SplitStr(KeyFields, ';', vKeyNames);

    // number of keys should be equal or less then the number of values.
    if (vKeyNames.Count > 1) and
       (
         not VarIsArray(KeyValues) or
         ((VarArrayHighBound(KeyValues, 1) - VarArrayLowBound(KeyValues, 1)) <> vKeyNames.Count - 1)
       )
       then DatabaseError(SExprIncorrect, self);

    First;
    while not EOF do
    begin
      if IrregularView then  vFieldDefs := IrregularFieldDefs
        else vFieldDefs := FieldDefs;

      vMatchFound := true;
      for i := 0 to vKeyNames.Count - 1 do
      begin
        if vFieldDefs.Find(vKeyNames[i]) = nil then
        begin
          vMatchFound := false;
          Break;
        end;

        if IrregularView then vValue := IrregularFieldValues[vKeyNames[i]]
          else vValue := FieldValues[vKeyNames[i]];

        if not ValuesMatch(vValue, GetArrayElement(KeyValues, i), Options) then
        begin
          vMatchFound := false;
          Break;
        end;

      end;

      if vMatchFound then
      begin
        Result := true;
        Exit;
      end;
      
      Next;
    end;

    // record not found: restore location in the dataset 
    GotoBookmark(vBookMark);
  finally
    FreeBookmark(vBookmark);
  end;
  
end;

function TWmiDataSet.GetCurrentObject: ISWbemObject;
var
  vInterfaceHolder: TInterfaceHolder;
begin
  Result := nil;
  if Active then
  begin
    vInterfaceHolder := TInterfaceHolder(ActiveBuffer);
    if vInterfaceHolder <> nil then Result := vInterfaceHolder.WbemObject
      else Result := nil;
   end;   
end;

function TWmiDataSet.GetBookmarkFlag(Buffer: PChar): TBookmarkFlag;
begin
  result := bfCurrent;
end;

procedure TWmiDataSet.InternalCancel;
var
  vObject: ISWbemObject;
  vNewObj: ISWbemObject;
  vPath: ISWbemObjectPath;
  vPathStr: WideString;
  vHolder: TInterfaceHolder;

begin
  inherited;
  vHolder := TInterfaceHolder(ActiveBuffer);
  vObject := vHolder.WbemObject;

  if (vObject = nil) or (Connection = nil) then Exit;
  WmiCheck(vObject.Get_Path_(vPath));
  WmiCheck(vPath.Get_Path(vPathStr));
  WmiCheck(Connection.WmiServices.Get(vPathStr, 0, nil, vNewObj));

  // the two references to the object exist:
  // 1) The object in an internal buffer that TDataSet maintains
  // 2) The object in a buffer that TWmiDataSet maintains
  // I have to refresh both.
  vHolder.WbemObject := vNewObj;
  TInterfaceHolder(FData.FDataBuffer[vHolder.Index]).WbemObject := vNewObj;
end;

procedure TWmiDataSet.InternalEdit;
begin
  inherited;

end;

procedure TWmiDataSet.InternalInsert;
begin
  inherited;
  // Insertion is not supported. Only a small number of WMI classes have
  // an ability to be instantiated in a generic way. Some of them
  // have Create method with custom parameters, like Win32_Share.Create
  // Some of them cannot create a new instances at all, like Win32_UserAccount. 
  DatabaseError(SDataSetOpen);
end;

procedure TWmiDataSet.InternalPost;
var
  vObject: ISWbemObject;
  vPath: ISWbemObjectPath;
begin
  // must not call "inherited". In Delphi 5 it is abstract - craches. 
  // inherited
  vObject := TInterfaceHolder(ActiveBuffer).WbemObject;
  if vObject = nil then DatabaseError(SRecordNotFound);
  WmiCheck(vObject.Put_(wbemChangeFlagCreateOrUpdate, nil, vPath));
end;


procedure TWmiDataSet.CreateFields;
var
  i: integer;
begin
  inherited;
  for i := 0 to Fields.Count - 1 do
  begin
    // if DisplayWith is zero, the DBGrid will use
    // Size field to calculate width. Size may be large.
    // I specify "1" as width, so DBGrid will set
    // with of the column to the with of its caption.  
    Fields[i].DisplayWidth := 1;
  end;
end;

procedure TWmiDataSet.InternalAddRecord(Buffer: Pointer; Append: Boolean);
begin
  // must not call "inherited". In Delphi 5 it is abstract - craches. 
  // inherited

  // Insertion is not supported. Only a small number of WMI classes have
  // an ability to be instantiated in a generic way. Some of them
  // have Create method with custom parameters, like Win32_Share.Create
  // Some of them cannot create a new instances at all, line Win32_UserAccount. 
  DatabaseError(SDataSetOpen);
end;

procedure TWmiDataSet.InternalDelete;
var
  vObject: ISWbemObject;
  vHolder: TInterfaceHolder;
begin
  // must not call "inherited". In Delphi 5 it is abstract - craches. 
  // inherited

  vHolder := TInterfaceHolder(ActiveBuffer);
  vObject := vHolder.WbemObject;
  if vObject = nil then DatabaseError(SRecordNotFound);
  WmiCheck(vObject.Delete_(0, nil));

  vHolder.WbemObject := nil;
  FData.DeleteRecord(vHolder.Index);
end;

procedure TWmiDataSet.ClearBuffers;
begin
  inherited;
  if FData <> nil then FData.First;
end;

function TWmiDataSet.GetWmiObject: ISWbemObject;
begin
  Result := CurrentObject;
end;

function TWmiDataSet.GetImplementingComponent: TComponent;
begin
  Result := self;
end;

function TWmiDataSet.GetWmiServices: ISWbemServices;
begin
  if Connection <> nil then
    Result := Connection.WmiServices
    else Result := nil;
end;

{ TWmiDataBuffer }
constructor TWmiDataBuffer.Create(AWmiData: IEnumVariant;
  IsUniDirectional: boolean);
begin
  inherited Create;
  FWmiData := AWmiData;
  FUniDirectional := IsUniDirectional;
  FAllRetrieved := false;
  FRecord := nil;
  FDataBuffer := TList.Create;

  // I have to read the first record to set EOF properly.
  Next;
  FBof := true;
  FBufferIndex := 0;
  if GetRecord <> nil then
  begin
    FEof := false;
    FBeforeFirstRecord := true;
  end;
end;

destructor TWmiDataBuffer.Destroy;
var
  vHolder: TInterfaceHolder;
begin
  while (Count > 0) do
  begin
    vHolder := TInterfaceHolder(FDataBuffer[0]);
    vHolder.Free;
    FDataBuffer.Delete(0);
  end;
  FDataBuffer.Free;
  inherited;
end;

function TWmiDataBuffer.GetRecord: ISWbemObject;
begin
  if FRecord = nil then Result := nil
    else Result := FRecord.WbemObject;
end;

procedure TWmiDataBuffer.SetBufferIndex(AValue: integer);
begin
  while (not EOF) and (Count <= AValue) do Next;
  if (AValue < Count) then
  begin
    FBufferIndex := AValue;
    FRecord      := TInterfaceHolder(FDataBuffer[AValue]);
    FEOF         := FAllRetrieved and (AValue = Count - 1);
  end else
  begin
    FBufferIndex := Count - 1;
    FRecord      := TInterfaceHolder(FDataBuffer[FBufferIndex]);
    FEOF         := true;
  end;
  FBOF := AValue = 0;
end;


procedure TWmiDataBuffer.Next;
var
  vOleVar: OleVariant;
  vFetchedCount: cardinal;
begin
  if FBeforeFirstRecord then
  begin
    FBeforeFirstRecord := false;
  end else
  begin
    if FBufferIndex < Count - 1 then
    begin
      Inc(FBufferIndex);
      FRecord := TInterfaceHolder(FDataBuffer[FBufferIndex]);
    end else
    begin
      WmiCheck(FWmiData.Next(1, vOleVar, vFetchedCount));
      if vFetchedCount > 0 then
      begin
        FRecord := TInterfaceHolder.Create(nil, Count);
        FRecord.WbemObject := IUnknown(vOleVar) as SWBemObject;
        vOleVar := Unassigned;
        FDataBuffer.Add(FRecord);
        Inc(FBufferIndex);
        FBof := false;
      end else
      begin
        FRecord := nil;
        FAllRetrieved := true; 
        FEof := true;
      end;
    end;
  end;
end;

procedure TWmiDataBuffer.Prev;
begin
  if FBeyondLastRecord then
  begin
    FBeyondLastRecord := false;
  end else
  begin
    if FBufferIndex > 0 then
    begin
      Dec(FBufferIndex);
      FRecord := TInterfaceHolder(FDataBuffer[FBufferIndex]);
    end else
    begin
      FRecord := nil;
      FBof := true;
    end;
  end;  
end;

{ TInterfaceHolder }

procedure TInterfaceHolder.ClearCache;
begin
  FWbemObjectProperties := nil;
  while FCache.Count > 0 do
  begin
    FCache.Objects[0].Free;
    FCache.Delete(0);
  end;
end;

constructor TInterfaceHolder.Create(AWbemObject: ISWbemObject; AIndex: integer);
begin
  inherited Create;
  FWbemObject := AWbemObject;
  FIndex := AIndex;
  FCache := TStringList.Create;
  FCache.Sorted := true;
end;

destructor TInterfaceHolder.Destroy;
begin
  ClearCache;
  FCache.Free;
  FWbemObject := nil;
  inherited;
end;

function TInterfaceHolder.GetPropertyValueByName(
  const AName: widestring): OleVariant;
var
  vIndex: integer;
  vProperty: ISWbemProperty;
begin
  vIndex := FCache.IndexOf(AName);
  if vIndex = -1 then
  begin
    WmiCheck(GetWbemObjectProperties.Item(AName, 0, vProperty));
    WmiCheck(vProperty.Get_Value(Result));
    FCache.AddObject(AName, TVariantHolder.Create(Result));
  end else
  begin
    Result := TVariantHolder(FCache.Objects[vIndex]).Value;
  end;
end;

(*
function TInterfaceHolder.GetPropertyValueByName(
  const AName: widestring): OleVariant;
var
  vPropEnum: IEnumVariant;
  vFetchedCount: cardinal;
  vOleVar: OleVariant;
  vProp: ISWbemProperty;
  vName: widestring;
  vIndex: integer;

begin
  if FCache.Count = 0 then
  begin
    if (FWbemObject <> nil) then
    begin
      vPropEnum := WmiGetObjectProperties(FWbemObject);
      while (vPropEnum.Next(1, vOleVar, vFetchedCount) = S_OK) do
      begin
        vProp    := IUnknown(vOleVar) as ISWBemProperty;
        vOleVar  := Unassigned;
        WmiCheck(vProp.Get_Name(vName));
        WmiCheck(vProp.Get_Value(vOleVar));
        FCache.AddObject(vName, TVariantHolder.Create(vOleVar));
      end;
    end;
  end;

  vIndex := FCache.IndexOf(AName);
  if vIndex <> -1 then
    Result := TVariantHolder(FCache.Objects[vIndex]).Value
    else Result := Unassigned;
end;
*)

function TInterfaceHolder.GetWbemObjectProperties: ISWbemPropertySet;
begin
  if (FWbemObject <> nil) and (FWbemObjectProperties = nil) then
  begin
      WmiCheck(FWbemObject.Get_Properties_(FWbemObjectProperties));
  end;
  Result := FWbemObjectProperties;
end;

procedure TInterfaceHolder.SetWbemObject(const Value: ISWbemObject);
begin
  FWbemObject := Value;
  ClearCache;
end;

procedure TWmiDataBuffer.First;
begin
  if Count > 0 then SetBufferIndex(0);
  FBof := true;
  // when TDataSet calls InternalFirst method,
  // it expects the dataset to move
  // "before the first record". To fix the situation,
  // TClientDataSet will call GetNextRecord immediately.
  FBeforeFirstRecord := true;
end;

procedure TWmiDataBuffer.Last;
begin
  while not EOF do Next;
  // when TDataSet calls InternalLast method,
  // it expects the dataset to move
  // "beyond the last record". To fix the situation,
  // TClientDataSet will call GetPrevRecord immediately.
  FBeyondLastRecord := true;
  FRecord := FDataBuffer[FDataBuffer.Count - 1];
end;

function TWmiDataBuffer.GetCount: integer;
begin
  Result := FDataBuffer.Count;
end;

procedure TWmiDataBuffer.DeleteRecord(AIndex: integer);
var
  i: integer;
begin
  if AIndex >= FDataBuffer.Count then Exit;

  TInterfaceHolder(FDataBuffer[AIndex]).WbemObject := nil;
  TInterfaceHolder(FDataBuffer[AIndex]).Free;
  FDataBuffer.Delete(AIndex);

  if FBufferIndex >= FDataBuffer.Count then Dec(FBufferIndex);
  if FDataBuffer.Count = 0 then
  begin
    FBof := true;
    FEof := true;
    FRecord := nil;
    FBufferIndex := 0;
  end else
  if FBufferIndex = 0 then
  begin
    FBof := true;
    FRecord := FDataBuffer[FBufferIndex];
  end else
  if FBufferIndex = FDataBuffer.Count - 1 then
  begin
    FEof := true;
    FRecord := FDataBuffer[FBufferIndex];
  end else
  begin
    FRecord := FDataBuffer[FBufferIndex];
  end;

  for i := AIndex to FDataBuffer.Count - 1 do
    TInterfaceHolder(FDataBuffer[i]).Index := i;
end;

function TWmiDataBuffer.GetRecordCount: integer;
var
  vIndex: integer;
begin
  if not FAllRetrieved then
  begin
    vIndex := FBufferIndex;
    while not EOF do Next;
    SetBufferIndex(vIndex);
  end;
  Result := FDataBuffer.Count;
end;

{ TWmiVariantField }

function TWmiVariantField.GetAsString: string;
begin
  Result := VariantToString(GetAsVariant);
end;

{ TWmiFieldDef }
constructor TWmiFieldDef.Create(Owner: TFieldDefs; const Name: string;
  DataType: TFieldType; Size: Integer; Required: Boolean; FieldNo: Integer;
  IsArray: boolean);
begin
  inherited Create(Owner, Name, DataType, Size, Required, FieldNo);
  FIsArray := IsArray;
end;


{ TWmiWideStringField }

function TWmiWideStringField.GetDataSize: Integer;
begin
  Result := Size + 2;
end;

procedure TWmiWideStringField.SetAsString(const Value: string);
begin
  SetAsWideString(Value);
end;

procedure TWmiWideStringField.SetAsWideString(const Value: WideString);
var
  TruncValue: WideString;
begin
  if Length(Value) > Size then
  begin
    TruncValue := Copy(Value, 1, Size);
    SetData(@TruncValue)
  end else
    SetData(@Value);
end;

{ TVariantHolder }

constructor TVariantHolder.Create(AValue: OleVariant);
begin
  inherited Create;
  FValue := AValue;
end;

end.
