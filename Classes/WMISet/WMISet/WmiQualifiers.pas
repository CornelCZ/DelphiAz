unit WmiQualifiers;

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
  WmiErr, DB, DBConsts;


type
  TWmiQualifiers = class;
  TWmiQualifier = class;

  TWmiQualifier = class(TCollectionItem)
  private
    FIsAmended: wordbool;
    FIsLocal: wordbool;
    FIsOverridable: wordbool;
    FName: widestring;
    FPropagatesToInstance: wordbool;
    FPropagatesToSubclass: wordbool;
    FValue: OleVariant;
    procedure SetIsAmended(Value: wordbool);
    procedure SetIsLocal(const Value: wordbool);
    procedure SetIsOverridable(const Value: wordbool);
    procedure SetName(const Value: widestring);
    procedure SetPropagatesToInstance(const Value: wordbool);
    procedure SetPropagatesToSubclass(const Value: wordbool);
    procedure SetValue(const Value: OleVariant);
    function  GetValue: OleVariant;
    function  IsDesignTime: boolean;
  protected
    function  GetDisplayName: string; override;
  public
    constructor Create(ACollection: TCollection; AQualifier: ISWbemQualifier); reintroduce;
    function  GetVariantValue: OleVariant;
  published
    property IsAmended: wordbool read FIsAmended write SetIsAmended;
    property IsLocal: wordbool read FIsLocal write SetIsLocal;
    property IsOverridable: wordbool read FIsOverridable write SetIsOverridable;
    property Name: widestring read FName write SetName;
    property PropagatesToInstance: wordbool read FPropagatesToInstance write SetPropagatesToInstance;
    property PropagatesToSubclass: wordbool read FPropagatesToSubclass write SetPropagatesToSubclass;
    property Value: OleVariant read GetValue write SetValue;
  end;

  TWmiQualifiers = class(TCollection)
    FOwner: TPersistent;
    function GetItem(Index: Integer): TWmiQualifier;
    procedure SetItem(Index: Integer; Value: TWmiQualifier);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(Owner: TPersistent);
    function FindQualifier(const Value: string): TWmiQualifier;
    property Items[Index: Integer]: TWmiQualifier read GetItem write SetItem; default;
  end;

implementation

{ TWmiQualifier }
function TWmiQualifier.GetDisplayName: string;
begin
  Result := Name;
end;

function TWmiQualifier.IsDesignTime: boolean;
var
  vQualifiers: TWmiQualifiers;
  vGrandParent: TComponent;
begin
  vQualifiers := TWmiQualifiers(Collection);
  vGrandParent := TComponent(vQualifiers.FOwner);
  Result := csDesigning in vGrandParent.ComponentState;
end;

function TWmiQualifier.GetValue: OleVariant;
begin
  if IsDesignTime then
    Result := WmiUtil.VariantToString(FValue)
    else Result := FValue;
end;

procedure TWmiQualifier.SetIsAmended(Value: wordbool); begin end;
procedure TWmiQualifier.SetIsLocal(const Value: wordbool); begin end;
procedure TWmiQualifier.SetIsOverridable(const Value: wordbool);begin end;
procedure TWmiQualifier.SetName(const Value: widestring); begin end;
procedure TWmiQualifier.SetPropagatesToInstance(const Value: wordbool); begin end;
procedure TWmiQualifier.SetPropagatesToSubclass(const Value: wordbool); begin end;
procedure TWmiQualifier.SetValue(const Value: OleVariant); begin end;

function TWmiQualifier.GetVariantValue: OleVariant;
begin
  Result := FValue;
end;

constructor TWmiQualifier.Create(ACollection: TCollection;
  AQualifier: ISWbemQualifier);
begin
  inherited Create(ACollection);
  WmiCheck(AQualifier.Get_Name(FName));
  WmiCheck(AQualifier.Get_Value(FValue));
  WmiCheck(AQualifier.Get_IsLocal(FIsLocal));
  WmiCheck(AQualifier.Get_PropagatesToSubclass(FPropagatesToSubclass));
  WmiCheck(AQualifier.Get_IsOverridable(FIsOverridable));
  WmiCheck(AQualifier.Get_IsAmended(FIsAmended));
end;

{ TWmiQualifiers }

constructor TWmiQualifiers.Create(Owner: TPersistent);
begin
  inherited Create(TWmiQualifier);
  FOwner := Owner;
end;

function TWmiQualifiers.FindQualifier(const Value: string): TWmiQualifier;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := TWmiQualifier(inherited Items[I]);
    if AnsiCompareText(Result.Name, Value) = 0 then Exit;
  end;
  Result := nil;
end;

function TWmiQualifiers.GetItem(Index: Integer): TWmiQualifier;
begin
  Result := TWmiQualifier(inherited Items[Index]);
end;

function TWmiQualifiers.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TWmiQualifiers.SetItem(Index: Integer;
  Value: TWmiQualifier);
begin
  inherited SetItem(Index, TCollectionItem(Value));
end;

end.
