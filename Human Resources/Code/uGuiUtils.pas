unit uGuiUtils;

interface

uses StdCtrls, Controls, ComCtrls, DBCtrls, wwDBDatetimepicker, wwDBComb, wwDBLook, wwDBEdit, wwDBGrid, Mask,
     Buttons, DateUtils, SysUtils, Classes;

{ The following procedures are used to set a TControl's read only property and set its colours accordingly.
  Ideally this would have required a single procedure with a TControl as an argument. However the
  TControl.Color property is protected and so cannot be set on this ancestor class. Hence the need
  for one overloaded procedure for each child class. }
procedure SetControlReadOnly(AControl : TDateTimePicker; const ReadOnly : Boolean); overload;
procedure SetControlReadOnly(AControl : TwwDBDateTimePicker; const ReadOnly : Boolean); overload;
procedure SetControlReadOnly(AControl : TMaskEdit; const ReadOnly : Boolean); overload;
procedure SetControlReadOnly(AControl : TwwDBLookupCombo; const ReadOnly : Boolean); overload;
procedure SetControlReadOnly(AControl : TComboBox; const ReadOnly : Boolean); overload;
procedure SetControlReadOnly(AControl : TwwDBComboBox; const ReadOnly : Boolean); overload;
procedure SetControlReadOnly(AControl : TDBLookupComboBox; const ReadOnly : Boolean); overload;
procedure SetControlReadOnly(AControl : TDBComboBox; const ReadOnly : Boolean); overload;
procedure SetControlReadOnly(AControl : TEdit; const ReadOnly : Boolean); overload;
procedure SetControlReadOnly(AControl : TDBEdit; const ReadOnly : Boolean); overload;
procedure SetControlReadOnly(AControl : TwwDBEdit; const ReadOnly : Boolean); overload;
procedure SetControlReadOnly(AControl : TDBMemo; const ReadOnly : Boolean); overload;
procedure SetControlReadOnly(AControl : TwwDBGrid; const ReadOnly : Boolean); overload;

function GetControlReadOnly(AControl : TControl): Boolean; overload;
function GetControlReadOnly(AControl : TDateTimePicker): Boolean; overload;
function GetControlReadOnly(AControl : TwwDBDateTimePicker): Boolean; overload;
function GetControlReadOnly(AControl : TMaskEdit): Boolean; overload;
function GetControlReadOnly(AControl : TwwDBLookupCombo): Boolean; overload;
function GetControlReadOnly(AControl : TComboBox): Boolean; overload;
function GetControlReadOnly(AControl : TwwDBComboBox): Boolean; overload;
function GetControlReadOnly(AControl : TDBLookupComboBox): Boolean; overload;
function GetControlReadOnly(AControl : TDBComboBox): Boolean; overload;
function GetControlReadOnly(AControl : TEdit): Boolean; overload;
function GetControlReadOnly(AControl : TDBEdit): Boolean; overload;
function GetControlReadOnly(AControl : TwwDBEdit): Boolean; overload;
function GetControlReadOnly(AControl : TDBMemo): Boolean; overload;
function GetControlReadOnly(AControl : TwwDBGrid): Boolean; overload;
function GetControlReadOnly(AControl : TBitBtn): Boolean; overload;

function GetComponentTextValue(AControl : TComponent) : String;

procedure SetFocus(ctl: TWinControl);

implementation

uses Graphics, DBGrids, wwDbiGrd;

{ The following procedures are used to set a TControl's read only property and set its colours accordingly.
  Ideally this would have required a single procedure with a TControl as an argument. However the
  TControl.Color property is protected and so cannot be set on this ancestor class. Hence the need
  for one overloaded procedure for each child class. }
procedure SetControlReadOnly(AControl : TComboBox; const ReadOnly : Boolean);
begin
  AControl.Enabled := not ReadOnly;

  if ReadOnly then
  begin
    AControl.Color := clBtnFace;
    AControl.Font.Color := clBtnText;
  end
  else
  begin
    AControl.Color := clWindow;
    AControl.Font.Color := clWindowText;
  end;
end;

procedure SetControlReadOnly(AControl : TwwDBComboBox; const ReadOnly : Boolean);
begin
  AControl.ReadOnly := ReadOnly;
  AControl.Enabled := not ReadOnly;

  if ReadOnly then
  begin
    AControl.Color := clBtnFace;
    AControl.Font.Color := clBtnText;
  end
  else
  begin
    AControl.Color := clWindow;
    AControl.Font.Color := clWindowText;
  end;
end;

procedure SetControlReadOnly(AControl : TwwDBLookupCombo; const ReadOnly : Boolean);
begin
  AControl.ReadOnly := ReadOnly;
  AControl.Enabled := not ReadOnly;

  if ReadOnly then
  begin
    AControl.Color := clBtnFace;
    AControl.Font.Color := clBtnText;
  end
  else
  begin
    AControl.Color := clWindow;
    AControl.Font.Color := clWindowText;
  end;
end;

procedure SetControlReadOnly(AControl : TDBComboBox; const ReadOnly : Boolean);
begin
  AControl.ReadOnly := ReadOnly;
  AControl.Enabled := not ReadOnly;

  if ReadOnly then
  begin
    AControl.Color := clBtnFace;
    AControl.Font.Color := clBtnText;
  end
  else
  begin
    AControl.Color := clWindow;
    AControl.Font.Color := clWindowText;
  end;
end;

procedure SetControlReadOnly(AControl : TDBLookupComboBox; const ReadOnly : Boolean);
begin
  AControl.ReadOnly := ReadOnly;
  AControl.Enabled := not ReadOnly;

  if ReadOnly then
  begin
    AControl.Color := clBtnFace;
    AControl.Font.Color := clBtnText;
  end
  else
  begin
    AControl.Color := clWindow;
    AControl.Font.Color := clWindowText;
  end;
end;

procedure SetControlReadOnly(AControl : TMaskEdit; const ReadOnly : Boolean);
begin
  AControl.ReadOnly := ReadOnly;

  if ReadOnly then
  begin
    AControl.Color := clBtnFace;
    AControl.Font.Color := clBtnText;
  end
  else
  begin
    AControl.Color := clWindow;
    AControl.Font.Color := clWindowText;
  end;
end;

procedure SetControlReadOnly(AControl : TDateTimePicker; const ReadOnly : Boolean);
begin
  AControl.Enabled := not ReadOnly;

  if ReadOnly then
  begin
    AControl.Color := clBtnFace;
    AControl.Font.Color := clBtnText;
  end
  else
  begin
    AControl.Color := clWindow;
    AControl.Font.Color := clWindowText;
  end;
end;


procedure SetControlReadOnly(AControl : TDBEdit; const ReadOnly : Boolean);
begin
  AControl.ReadOnly := ReadOnly;

  if ReadOnly then
  begin
    AControl.Color := clBtnFace;
    AControl.Font.Color := clBtnText;
  end
  else
  begin
    AControl.Color := clWindow;
    AControl.Font.Color := clWindowText;
  end;
end;

procedure SetControlReadOnly(AControl : TEdit; const ReadOnly : Boolean);
begin
  AControl.ReadOnly := ReadOnly;

  if ReadOnly then
  begin
    AControl.Color := clBtnFace;
    AControl.Font.Color := clBtnText;
  end
  else
  begin
    AControl.Color := clWindow;
    AControl.Font.Color := clWindowText;
  end;
end;

procedure SetControlReadOnly(AControl : TwwDBEdit; const ReadOnly : Boolean);
begin
  AControl.ReadOnly := ReadOnly;

  if ReadOnly then
  begin
    AControl.Color := clBtnFace;
    AControl.Font.Color := clBtnText;
  end
  else
  begin
    AControl.Color := clWindow;
    AControl.Font.Color := clWindowText;
  end;
end;

procedure SetControlReadOnly(AControl : TwwDBDateTimePicker; const ReadOnly : Boolean);
begin
  AControl.ReadOnly := ReadOnly;
  AControl.Enabled := not ReadOnly;

  if ReadOnly then
  begin
    AControl.Color := clBtnFace;
    AControl.Font.Color := clBtnText;
  end
  else
  begin
    AControl.Color := clWindow;
    AControl.Font.Color := clWindowText;
  end;
end;

procedure SetControlReadOnly(AControl : TDBMemo; const ReadOnly : Boolean);
begin
  AControl.ReadOnly := ReadOnly;

  if ReadOnly then
  begin
    AControl.Color := clBtnFace;
    AControl.Font.Color := clBtnText;
  end
  else
  begin
    AControl.Color := clWindow;
    AControl.Font.Color := clWindowText;
  end;
end;

procedure SetControlReadOnly(AControl : TwwDBGrid; const ReadOnly : Boolean);
begin
  AControl.ReadOnly := ReadOnly;

  if ReadOnly then
  begin
    AControl.Color := clBtnFace;
    AControl.Font.Color := clBtnText;
    AControl.Options := [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect];
  end
  else
  begin
    AControl.Color := clWindow;
    AControl.Font.Color := clWindowText;
    AControl.Options := [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete];
  end;
end;




function GetControlReadOnly(AControl : TComboBox): Boolean;
begin
  Result := not (AControl.Enabled);
end;

function GetControlReadOnly(AControl : TwwDBComboBox): Boolean;
begin
  Result := AControl.ReadOnly;
end;

function GetControlReadOnly(AControl : TwwDBLookupCombo): Boolean;
begin
  Result := AControl.ReadOnly;
end;

function GetControlReadOnly(AControl : TDBLookupComboBox): Boolean;
begin
  Result := AControl.ReadOnly;
end;

function GetControlReadOnly(AControl: TDBComboBox): Boolean;
begin
  Result := AControl.ReadOnly;
end;

function GetControlReadOnly(AControl : TMaskEdit): Boolean;
begin
  Result := AControl.ReadOnly;
end;

function GetControlReadOnly(AControl : TDateTimePicker): Boolean;
begin
  Result := not (AControl.Enabled);
end;


function GetControlReadOnly(AControl : TDBEdit): Boolean;
begin
  Result := AControl.ReadOnly;
end;

function GetControlReadOnly(AControl : TEdit): Boolean;
begin
  Result := AControl.ReadOnly;
end;

function GetControlReadOnly(AControl : TwwDBEdit): Boolean;
begin
  Result := AControl.ReadOnly;
end;

function GetControlReadOnly(AControl : TwwDBDateTimePicker): Boolean;
begin
  Result := AControl.ReadOnly;
end;

function GetControlReadOnly(AControl : TDBMemo): Boolean;
begin
  Result := AControl.ReadOnly;
end;

function GetControlReadOnly(AControl : TwwDBGrid): Boolean;
begin
  Result := AControl.ReadOnly;
end;

function GetControlReadOnly(AControl: TBitBtn): Boolean;
begin
  Result := not (AControl.Enabled);
end;

function GetControlReadOnly(AControl : TControl): Boolean;
begin
  Result := TRUE;

  if (AControl is TDateTimePicker) then
    Result := GetControlReadOnly(TDateTimePicker(AControl))
  else if (AControl is TwwDBDateTimePicker) then
    Result := GetControlReadOnly(TwwDBDateTimePicker(AControl))
  else if (AControl is TMaskEdit) then
    Result := GetControlReadOnly(TMaskEdit(AControl))
  else if (AControl is TwwDBLookupCombo) then
    Result := GetControlReadOnly(TwwDBLookupCombo(AControl))
  else if (AControl is TComboBox) then
    Result := GetControlReadOnly(TComboBox(AControl))
  else if (AControl is TDBComboBox) then
    Result := GetControlReadOnly(TDBComboBox(AControl))
  else if (AControl is TwwDBComboBox) then
    Result := GetControlReadOnly(TwwDBComboBox(AControl))
  else if (AControl is TDBLookupComboBox) then
    Result := GetControlReadOnly(TDBLookupComboBox(AControl))
  else if (AControl is TEdit) then
    Result := GetControlReadOnly(TEdit(AControl))
  else if (AControl is TDBEdit) then
    Result := GetControlReadOnly(TDBEdit(AControl))
  else if (AControl is TwwDBEdit) then
    Result := GetControlReadOnly(TwwDBEdit(AControl))
  else if (AControl is TDBMemo) then
    Result := GetControlReadOnly(TDBMemo(AControl))
  else if (AControl is TwwDBGrid) then
    Result := GetControlReadOnly(TwwDBGrid(AControl))
  else if (AControl is TBitBtn) then
    Result := GetControlReadOnly(TBitBtn(AControl));
end;


function GetComponentTextValue(AControl : TComponent) : String;
begin
  Result := '';

  if (AControl is TDateTimePicker) then
  begin
    if TDateTimePicker(AControl).DateTime <> 0 then
      Result := DateTimeToStr(TDateTimePicker(AControl).DateTime)
  end
  else if (AControl is TwwDBDateTimePicker) then
  begin
    if TwwDBDateTimePicker(AControl).DateTime <> 0 then
      Result := DateTimeToStr(TwwDBDateTimePicker(AControl).DateTime)
  end
  else if (AControl is TMaskEdit) then
    Result := TMaskEdit(AControl).Text
  else if (AControl is TwwDBLookupCombo) then
    Result := TwwDBLookupCombo(AControl).Text
  else if (AControl is TComboBox) then
    Result := TComboBox(AControl).Text
  else if (AControl is TDBComboBox) then
    Result := TDBComboBox(AControl).Text
  else if (AControl is TwwDBComboBox) then
    Result := TwwDBComboBox(AControl).Text
  else if (AControl is TDBLookupComboBox) then
    Result := TDBLookupComboBox(AControl).Text
  else if (AControl is TEdit) then
    Result := TEdit(AControl).Text
  else if (AControl is TDBEdit) then
    Result := TDBEdit(AControl).Text
  else if (AControl is TwwDBEdit) then
    Result := TwwDBEdit(AControl).Text
  else if (AControl is TDBMemo) then
    Result := TDBMemo(AControl).Text;
end;

//Stolen brazenly from ..\..\Common Files\uGUIUtils.pas.  Had to steal it
//because this unit shares the same name as the aforementioned
//unit, so I cannot import it to use this proc...
procedure SetFocus( ctl: TWinControl );
var
  child, parent: TWinControl;
begin
  try
    // If control is within a tabbed dialog, switch to the correct tab
    child := ctl;
    parent := ctl.Parent;
    while parent <> nil do begin
      if (parent is TPageControl) and (child is TTabSheet) then
        TPageControl(parent).ActivePage := TTabSheet( child );
      child := parent;
      parent := child.Parent;
    end;

    // Now set focus to the control
    ctl.SetFocus;
  except else
    // Ignore all exceptions
  end;
end;

end.
