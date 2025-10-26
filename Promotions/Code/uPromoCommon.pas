unit uPromoCommon;

interface

uses
  Messages, CheckLst, SysUtils, Controls, DBCtrls, Wwdbigrd,
  Wwdbgrid, ComCtrls, StdCtrls, Graphics;

const
  TIMAGE_TAG_ZONAL_Z_BIG = 101;
  TIMAGE_TAG_ZONAL_Z_SMALL = 102;
  UM_INITFOCUS = WM_USER;
  PANE_RESIZE_LEFT_OFFSET = -27;
  PANE_RESIZE_MIDDLE_OFFSET = -12;
  PANE_RESIZE_RIGHT_OFFSET = 20;
  ALL_SITES       = '<All Sites>';
  ALL_PROMOTIONS  = '<ALL Promotions>';

type
  TPromotionMode = (pmMaster, pmSite);

  TDataModified = packed record
    SalesAreaSelectionChanged: boolean;
    SalesAreaSelectionUnProcessed: boolean;
    ProductGroupSelection: array of boolean;
  end;

  TReportType = (rtPromotionUsage, rtSiteUsage);

function ValidDaysStrFromCheckboxes(ValidDaysCheckboxes: TCheckListBox): string;
function ValidDaysDisplay(ValidDays: string): string;
procedure DisablePromotionControls(ParentControl: TWinControl);

implementation

// Return a string representation that corresponds to the days of the week that are
// selected on the 'Activation Details' page of the promotion wizards.
// '1' = Monday,... '7' = Sunday. E.g. if Monday and Friday are selected this function will return '15'
function ValidDaysStrFromCheckboxes(ValidDaysCheckboxes: TCheckListBox): string;
var day: integer;
begin
  Result := '';
  for day := 1 to 7 do
    if ValidDaysCheckboxes.Checked[day-1] then
    begin
      Result := Result + IntToStr(day);
    end;
end;


function ValidDaysDisplay(ValidDays: string): string;
const DAY_NAME: array[1..7] of string = ('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun');
var
  ValidDaysDisplay: string;
  i: integer;
  MaxIndex: integer;
begin
  ValidDaysDisplay := '';

  i := 1;
  while i < 8 do
  begin
    if Pos(IntToStr(i), ValidDays) <> 0 then
    begin
      MaxIndex := i;
      while MaxIndex < 8 do
      begin
        if Pos(InttoStr(MaxIndex+1), ValidDays) = 0 then
          break;
        inc(MaxIndex);
      end;

      if (i <> MaxIndex) then
      begin
        ValidDaysDisplay := ValidDaysDisplay +
          Format('%s-%s,', [DAY_NAME[i], DAY_NAME[MaxIndex]]);
        i := MaxIndex+1;
      end
      else
        ValidDaysDisplay := ValidDaysDisplay + Format('%s,', [DAY_NAME[i]]);
    end;
    i := i + 1;
  end;

  Result := Copy(ValidDaysDisplay, 1, Length(ValidDaysDisplay)-1);
end;

procedure DisablePromotionControls(ParentControl: TWinControl);
var
  i: Integer;
begin
  with ParentControl do
  begin
    for i := 0 to ControlCount - 1 do
    begin
      //Handle special non-containers
      if Controls[i] is TwwDBGrid then
        TwwDBGrid(Controls[i]).ReadOnly := True
      else if Controls[i] is TTreeView then
        TTreeView(Controls[i]).ReadOnly := True
      else if Controls[i] is TListBox then
        TListBox(Controls[i]).Enabled := True
      else if Controls[i] is TComboBox then
        TComboBox(Controls[i]).Enabled := True
      else begin
        //Handle container objects and controls we want disabled
        if Controls[i] is TWinControl then
          if TWinControl(Controls[i]).ControlCount > 0 then
            DisablePromotionControls(TWinControl(Controls[i]));

        if Controls[i] is TGroupBox then
          TGroupBox(Controls[i]).Font.Color := clGrayText;

        if Controls[i] is TPageControl then
          TPageControl(Controls[i]).Enabled := True
        else if Controls[i] is TTabSheet then
          TTabSheet(Controls[i]).Enabled := True
        else if Controls[i] is TTabControl then
          TTabControl(Controls[i]).Enabled := True
        else if Controls[i] is TGroupBox then
          TGroupBox(Controls[i]).Enabled := True
        else
          Controls[i].Enabled := False;
      end;
    end;

    Enabled := True;
  end;
end;

end.
