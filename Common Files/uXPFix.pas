unit uXPFix;

// Add this to project DPR to enable automatic building of resources
{$R '..\..\Common Files\XPFix.res' '..\..\Common Files\XPFix.rc'}


interface

type
  TXPFix = class(TObject)
    class procedure HandleActiveFormChange(Sender: TObject);
  end;

implementation

uses forms, windows, dialogs, sysutils, Controls;

const
  CYCaptionStd = 19;
  CXSizeFrameStd = 4;
  CYSizeFrameStd = 4;

class procedure TXPFix.HandleActiveFormChange(Sender: TObject);
var
  HeightAdjust, WidthAdjust, SBWidthAdjust, SBHeightAdjust: integer;
  i: integer;
begin
  if Assigned(Sender) and Assigned(TScreen(sender).ActiveForm) then
  begin
    with TScreen(sender).ActiveForm do
    begin
      if ((GetSystemMetrics(SM_CYCAPTION) <> CYCaptionStd) or
        (GetSystemMetrics(SM_CXSIZEFRAME) <> CXSizeFrameStd) or
	(GetSystemMetrics(SM_CYSIZEFRAME) <> CYSizeFrameStd))
        and (BorderStyle = bsSizeable) and (WindowState <> wsMaximized) then
      begin
        if Tag = 0 then
        begin
          Tag := 1;
          HeightAdjust := (GetSystemMetrics(SM_CYCAPTION) - CYCaptionStd) +
            (GetSystemMetrics(SM_CYSIZEFRAME) - CYSizeFrameStd)*2;
          WidthAdjust := (GetSystemMetrics(SM_CXSIZEFRAME) - CXSizeFrameStd)*2;

          // todo: forms with items near to the right border can get problems due to scrollbars
          // being visible as the form is initially resized.. only workaround at the moment is
          // to remove the scrollbars and include the scrollbar offset when moving the child
          // controls.

          if VertScrollBar.IsScrollBarVisible then
          begin
            VertScrollBar.Visible := false;
            SBWidthAdjust := -GetSystemMetrics(SM_CYVSCROLL);
          end
          else
            SBWidthAdjust := 0;

          if HorzScrollBar.IsScrollBarVisible then
          begin
            HorzScrollBar.Visible := false;
            SBHeightAdjust := -GetSystemMetrics(SM_CXHSCROLL);
          end
          else
            SBHeightAdjust := 0;

          for i := 0 to pred(ControlCount) do
            with Controls[i] do
            begin
              if akBottom in Anchors then
                if akTop in Anchors then
                begin
                  Height := Height - HeightAdjust + SBHeightAdjust;
                end
                else
                  Top := Top - HeightAdjust + SBHeightAdjust;

              if akRight in Anchors then
                if akLeft in Anchors then
                  Width := Width - WidthAdjust + SBWidthAdjust
                else
                  Left := Left - WidthAdjust + SBWidthAdjust;
            end;


          Width := Width + WidthAdjust;
          Height := Height + HeightAdjust;
          if Constraints.MinHeight <> 0 then
            Constraints.MinHeight := Constraints.MinHeight + HeightAdjust;
          if Constraints.MinWidth <> 0 then
            Constraints.MinWidth := Constraints.MinWidth + WidthAdjust;


        end;
      end;
    end;
  end;

end;

initialization
  screen.OnActiveFormChange := TXPFix.HandleActiveFormChange;
end.
