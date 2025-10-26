unit uSimpleLocalise;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids, Wwdbigrd, Wwdbgrid;

  type TControlCrack = class(TControl);

  procedure LocaliseForm(Input: TComponent);
  function LocaliseString(Input: string):string;

  function LocaliseString_NoCheck(Input: string):string;
  procedure LocaliseText(Input: TControl); overload;
  procedure LocaliseText(Input: TDBGrid); overload;
  procedure LocaliseText(Input: TwwDBGrid); overload;
  // NeedToLocalise: Currently returns TRUE if in US mode.
  //   May be an enum in future.
  function NeedToLocalise: boolean;


  type TLocaliseVersion = (lvVersionOne, lvVersionTwo);

var
  //PW: 15/04/2008 Default version is now 2 which has more keywords and
  //handles all-upper, all-lower and mixed case phrases better.
  LocaliseVersion: TLocaliseVersion = lvVersionTwo;

implementation

uses Registry, ppCtrls;

function NeedToLocalise: boolean;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey('Control Panel\International', False);
    if Reg.ReadString('Locale') = '00000409' then
      Result := True
    else
      Result := False ;
  finally
    Reg.Free;
  end;
end;

procedure LocaliseForm(Input: TComponent);
var
  i: integer;
begin
  if NeedToLocalise then
  with Input do
  begin
    if Input is TCustomForm then
      TCustomForm(Input).Caption := localisestring(TCustomForm(Input).Caption);
    for i := 0 to pred(componentcount) do
    begin
      if components[i] is TDBGrid then
      begin
        LocaliseText(TDBGrid(components[i]));
      end
      else
      if components[i] is TwwDBGrid then
      begin
        LocaliseText(TwwDBGrid(components[i]));
      end
      else
      if components[i] is TControl then
      begin
        LocaliseText(TControl(components[i]));
      end
      else
      if components[i] is TppLabel then
        TppLabel(components[i]).Caption := LocaliseString(TppLabel(components[i]).Caption);
    end;
  end;
end;

function LocaliseString(Input: string): string;
begin
  if NeedToLocalise then
    Result := LocaliseString_NoCheck(Input)
  else
    Result := Input;
end;

procedure LocaliseText(Input: TControl);
begin
  TControlCrack(Input).Caption := LocaliseString(TControlCrack(Input).Caption);
end;

procedure LocaliseText(Input: TDBGrid);
var
  i: integer;
begin
  for i := 0 to pred(Input.Columns.Count) do
  begin
    Input.Columns[i].Title.Caption := LocaliseString(Input.Columns[i].Title.Caption);
  end;
end;

procedure LocaliseText(Input: TwwDBGrid);
var
  i,j: integer;
  TabPos: array[0..3] of integer;
  TmpDisplayText: string;
begin
  for i := 0 to pred(Input.GetColCount) do
  begin
    Input.Columns[i].DisplayLabel := LocaliseString(Input.Columns[i].DisplayLabel);
    input.Update;
  end;
  for i := 0 to pred(Input.Selected.Count) do
  begin
    TmpDisplayText := input.Selected[i];
    TabPos[0] := 0;
    for j := 1 to 3 do
    begin
      TabPos[j] := TabPos[j-1] + Pos(#9, Copy(TmpDisplayText, TabPos[j-1]+1, Length(TmpDisplayText)));
    end;
    if (TabPos[2] <> 0) and (TabPos[3] <> 0) then
    begin
      input.Selected[i] := Copy(TmpDisplayText, 1, TabPos[2]) +
        LocaliseString(Copy(TmpDisplayText, TabPos[2]+1, TabPos[3]-TabPos[2]-1)) +
        Copy(TmpDisplayText, TabPos[3], Length(TmpDisplayText));
    end
  end;
end;

function LocaliseString_NoCheck_V1(Input: string): string;
const
  LocalisePatterns: array [1..5] of string =	('Sales Area', 		'Delivery Notes',	'Delivery Note',	' VAT', 'Favour');
  LocaliseDataUS: array [1..5] of string = 		('Profit Center',	'Orders', 				'Invoice', 				' Sales Tax', 'Favor');
var
  NeedsLocalised: boolean;
  i: integer;
begin
  NeedsLocalised := false;
  result := input;
  for i := low(LocalisePatterns) to high(LocalisePatterns) do
    NeedsLocalised := NeedsLocalised or (Pos(lowercase(LocalisePatterns[i]), lowercase(input)) <> 0);
  if NeedsLocalised then
  begin
    for i := low(LocalisePatterns) to high(LocalisePatterns) do
    begin
      // Replace all-lower instances with all-lower localised data
      result := stringreplace(result, lowercase(LocalisePatterns[i]), lowercase(LocaliseDataUS[i]), [rfReplaceAll]);
      // replace mixed case instances with case defined in localised data
      result := stringreplace(result, LocalisePatterns[i], LocaliseDataUS[i], [rfIgnoreCase, rfReplaceAll]);
    end;
  end;
end;

function LocaliseString_NoCheck_V2(Input: string): string;
// TODO: Use 3rd party localisation system
const
  USReplacements: array [0..35] of string = (
    'on-sale', 'Eat In',
    'off-sale', 'To Go',
    'sort code', 'Route ID',
    'vat rate', 'Tax Rate',
    'vat number', 'Tax ID Number',
    ' vat', ' Sales Tax',
    'sales area', 'Profit Center',
    'delivery notes', 'Orders',
    'delivery note', 'Invoice',
    'theme modelling', 'Theme Modeling',
    'thememodelling', 'ThemeModeling',
    'colour', 'Color',
    'customised', 'Customized',
    'bill', 'Check',
    'account', 'Check',
    'customise', 'Customize',
    'favour', 'Favor',
    'centre', 'Center'
  );
var
  NeedsLocalised: boolean;
  i: integer;
begin
  NeedsLocalised := false;
  result := input;
  for i := low(USReplacements) to high(USReplacements) div 2 do
    NeedsLocalised := NeedsLocalised or (Pos(lowercase(USReplacements[i*2]), lowercase(input)) <> 0);
  if NeedsLocalised then
  begin
    for i := low(USReplacements) to high(USReplacements) div 2 do
    begin
      // Replace all-lower instances with all-lower localised data
      result := stringreplace(result, lowercase(USReplacements[i*2]), lowercase(USReplacements[1+i*2]), [rfReplaceAll]);
      // Replace all-upper instances with all-upperlocalised data
      result := stringreplace(result, uppercase(USReplacements[i*2]), uppercase(USReplacements[1+i*2]), [rfReplaceAll]);
      // replace mixed case instances with case defined in localised data
      result := stringreplace(result, USReplacements[i*2], USReplacements[1+i*2], [rfIgnoreCase, rfReplaceAll]);
    end;
  end;
end;

function LocaliseString_NoCheck(Input: string): string;
begin
  if LocaliseVersion = lvVersionOne then
    Result := LocaliseString_NoCheck_V1(Input)
  else
    Result := LocaliseString_NoCheck_V2(Input);
end;

end.

