Unit CommPropEditors;

interface
{$I DEFINE.INC}

Uses
  Windows, Classes, SysUtils, Controls,
{$IFDEF Delphi5}
  contnrs,
{$ENDIF}
{$IFDEF Delphi6}
  DesignIntf, DesignEditors,
{$ELSE}
  DsgnIntf,
{$ENDIF}
  TypInfo, NTSelectionList;


type
  TDwordAsSetProperty = class;

  // this class is an ansestor of classes
  // that are used at design time to represent
  // integer value as a set of flags (named constants).
  // Desendants should add published properties of
  // type boolean, each property corresponds to
  // one flag that may be set in the integer value.
  // name of the property should be the name of flag.  
  TDwordDummy = class(TComponent)
  private
  protected
    Editor: TDwordAsSetProperty;
    FDWORDValue: DWORD;
    procedure  SetDWORDValue(AValue: DWORD);
    procedure  ChangeBit(IfSet: boolean; Bit: DWORD);
  public
    property DWORDValue: DWORD read FDWORDValue write SetDWORDValue;
  end;


  // this class is an abstract ansestor for property editors
  // that display integer value as a set of constants.
  // the descendants must override GetDummyComponent method
  // to return one of the descendants of TDwordDummy class.
  TDwordAsSetProperty = class(TIntegerProperty)
  private
    DummyComponent: TDwordDummy;
  public
    destructor Destroy; override;
    function   GetAttributes: TPropertyAttributes; override;
    function   GetValue: string; override;
    procedure  SetValue(const Value: string); override;
{$IFDEF Delphi6}
    procedure  GetProperties(Proc: TGetPropProc); override;
{$ELSE}
    procedure  GetProperties(Proc: TGetPropEditProc); override;
{$ENDIF}
   procedure  SetDWORD(AValue: DWORD);
   function   GetDummyComponent: TDWORDDummy; virtual; abstract;
  end;


  TIntegerLookupProperty = class (TIntegerProperty)
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
    function GetValue: string; override;
    // this method has to fill in the AList parameter.
    // Its Items property should get string descriptions
    // of integer values. Its Objects property should store
    // integers, and NOT objects.
    procedure GetLookupData(AList: TStrings; AIsUpperCase: boolean); virtual; abstract;
  end;

type
  TDWORDToNameFunction = function(aValue: DWORD): string;

  // This function builds human readable string that is
  // "or" combination of names of idividual flags
  // that are present in AValue parameter.
  // ANameFunction parameter is a pointer to a function
  // that knows names of individual constants   
  function GetElementName(AValue: DWORD; ANameFunction: TDWORDToNameFunction): string;
   
implementation

procedure AddWord(var Res: string; AWord: string);
begin if Res <> '' then Res := Res + ' or '; Res := Res + AWord; end;

function GetElementName(AValue: DWORD; ANameFunction: TDWORDToNameFunction): string;
var
  vMask: dword;
  i: integer;
begin
  vMask := 1;
  Result := '';
  
  for i := 0 to 31 do
  begin
    if (AValue and vMask) > 0 then AddWord(Result, ANameFunction(AValue and vMask));
    vMask := vMask * 2;
  end;

  if Result = '' then Result := '0';
end;


{ TDwordDummy }

procedure TDwordDummy.ChangeBit(IfSet: boolean; Bit: DWORD);
begin
  if IfSet then DWORDValue := FDWORDValue or Bit
    else DWORDValue := FDWORDValue and not Bit;
end;

procedure TDwordDummy.SetDWORDValue(AValue: DWORD);
begin
  if FDWORDValue = AValue then Exit;
  FDWORDValue := AValue;
  if Editor <> nil then Editor.SetDWORD(FDWORDValue);
end;


{ TDwordAsSetProperty }
destructor TDwordAsSetProperty.Destroy;
begin
  DummyComponent.Free;
  DummyComponent := nil;
  inherited;
end;

function   TDwordAsSetProperty.GetAttributes: TPropertyAttributes;
begin Result := [paSubProperties, paReadOnly]; end;

function   TDwordAsSetProperty.GetValue: string;
begin
  if DummyComponent <> nil then DummyComponent.FDWORDValue := GetOrdValue;
end;


procedure  TDwordAsSetProperty.SetValue(const Value: string);
begin
end;

procedure  TDwordAsSetProperty.SetDWORD(AValue: DWORD);
begin
  SetOrdValue(AValue);
end;

{$IFDEF Delphi6}
procedure  TDwordAsSetProperty.GetProperties(Proc: TGetPropProc);
{$ELSE}
procedure  TDwordAsSetProperty.GetProperties(Proc: TGetPropEditProc);
{$ENDIF}
var
  ChildList: TNTSelectionList;
begin
  ChildList := TNTSelectionList.Create;
  if DummyComponent = nil then DummyComponent := GetDummyComponent;
  DummyComponent.Editor := Self;
  DummyComponent.FDWORDValue := GetOrdValue;
  ChildList.Add(DummyComponent);

  GetComponentProperties(ChildList, [tkEnumeration], Designer, Proc);
  {$IFNDEF Delphi5}
  ChildList.Free;
  {$ENDIF}
end;

{ TIntegerLookupProperty }

function TIntegerLookupProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TIntegerLookupProperty.GetValues(Proc: TGetStrProc); 
var
  vList: TStrings;
  i: integer;
begin
  vList := TStringList.Create;
  try
    GetLookupData(vList, false);
    for i := 0 to vList.Count - 1 do
      Proc(vList[i]);
  finally
    vList.Free;
  end;
end;

procedure TIntegerLookupProperty.SetValue(const Value: string); 
var
  vList: TStrings;
  i: integer;
begin
  vList := TStringList.Create;
  try
    GetLookupData(vList, true);
    i := vList.IndexOf(UpperCase(trim(value)));
    if i <> -1 then SetOrdValue(Longint(vList.Objects[i]))
      else SetOrdValue(StrToInt(Value));
  finally
    vList.Free;
  end;
end;

function TIntegerLookupProperty.GetValue: string;
var
  vValue: DWORD;
  i: integer;
  vList: TStrings;
begin
  vValue := GetOrdValue;
  vList := TStringList.Create;
  try
    GetLookupData(vList, true);
    i := vList.IndexOfObject(TObject(Pointer(vValue)));
    if i <> -1 then Result := vList[i]
      else Result := IntToStr(vValue);
  finally
    vList.Free;
  end;
end;



end.
   
