unit uWizardManager;
interface

uses
  ComCtrls, StdCtrls, Forms, Controls;

type
  TWizardDirection = (wdNext, wdBack);

  TEnterPageProc = procedure(Page: TTabSheet; Direction : TWizardDirection) of object;

  TLeavePageProc = procedure(Page: TTabSheet; Direction : TWizardDirection) of object;

  TWizardManager = Class
  private
    CurrentPage: Integer;
    OnEnterPage: TEnterPageProc;
    OnLeavePage: TLeavePageProc;
    NextButton: TButton;
    PreviousButton: TButton;
    WizardControl: TPageControl;
    function MoveToPage(PageIndex: integer): TModalResult;
    function FindTab(PageControl: TPageControl; CurrentTabIndex: integer; GoForward: boolean): integer;
    procedure UpdateNavigationButtons;
  public
    WizardName: String;
    constructor Create(WizardControl: TPageControl; NextButton, PreviousButton: TButton; EnterPageProc: TEnterPageProc; LeavePageProc: TLeavePageProc);
    function NextPageExecute(Sender: TObject): TModalResult;
    function PrevPageExecute(Sender: TObject): TModalResult;
  end;

implementation

// TODO: CMc - remove reliance on the couple of Promotions specific things in here so that
// we can re-use it for wizards elsewhere in Aztec (Theme Modelling?)

uses
  uAztecLog, udmPromotions, useful;

{ TWizardManager }

constructor TWizardManager.Create(WizardControl: TPageControl; NextButton,
  PreviousButton: TButton; EnterPageProc: TEnterPageProc;
  LeavePageProc: TLeavePageProc);
var
  i : Integer;
begin
  self.WizardControl := WizardControl;
  self.NextButton := NextButton;
  self.PreviousButton := PreviousButton;
  self.OnEnterPage := EnterPageProc;
  self.OnLeavePage := LeavePageProc;
  WizardName := 'Wizard';
  WizardControl.ActivePage := nil;
  for i := 0 to Pred(WizardControl.PageCount) do
    WizardControl.Pages[i].TabVisible := False;
  MoveToPage(FindTab(WizardControl, -1, True));

end;

function TWizardManager.FindTab(PageControl: TPageControl;
  CurrentTabIndex: integer; GoForward: boolean): integer;
var
  i: integer;
begin
  // Navigate through the page list - pages with enabled set to false
  // are ignored.
  // PageControl has similar functionality but uses the TabVisible property,
  // therefore it is limited to having tabs in use when functioning in a
  // Wizard-like manner. In effect this code replaces the PageControl management
  // of the active page.
  Result := -1;
  if GoForward then
  begin
    for i := CurrentTabIndex+1 to Pred(PageControl.PageCount) do
      if PageControl.Pages[i].Enabled then
      begin
        Result := i;
        break;
      end;
  end
  else
  begin
    for i := CurrentTabIndex-1 downto 0 do
      if PageControl.Pages[i].Enabled then
      begin
        Result := i;
        break;
      end;
  end;
end;

function TWizardManager.MoveToPage(PageIndex: integer): TModalResult;
begin
  CurrentPage := PageIndex;
  WizardControl.ActivePageIndex := PageIndex;
  if PageIndex = -1 then
  begin
    // Wizard is now finished
    result := mrOk;
  end
  else
  begin
    UpdateNavigationButtons;
    result := mrNone;
  end;
end;

procedure TWizardManager.UpdateNavigationButtons;
var
  PrevTabIndex, NextTabIndex: integer;
begin
  // Find the previous and next tab numbers, tells us what the state of the
  // back and next/finish buttons should be
  PrevTabIndex := FindTab(WizardControl, CurrentPage, False);
  NextTabIndex := FindTab(WizardControl, CurrentPage, True);

  if PrevTabIndex <> -1 then
    PreviousButton.Enabled := True
  else
    PreviousButton.Enabled := False;

  if NextTabIndex <> -1 then
    NextButton.Caption := 'Next'
  else
    NextButton.Caption := 'Finish';
end;

function TWizardManager.NextPageExecute(Sender: TObject): TModalResult;
var
  ActivePageIndex: integer;
begin
  Log(WizardName, 'Next Button Clicked');

  ActivePageIndex := WizardControl.ActivePageIndex;
  dmPromotions.BeginHourglass;
  try
    // NB:on leave page needs direction added to it
    OnLeavePage(WizardControl.ActivePage, wdNext);
    // Force TabSheet hide event to fire before the new one shows
    WizardControl.ActivePageIndex := -1;
    result := MoveToPage(FindTab(WizardControl, ActivePageIndex, True));
    if WizardControl.Visible then
      useful.ProcessPaintMessages;
    OnEnterPage(WizardControl.ActivePage, wdNext);
  finally
    dmPromotions.EndHourglass;
  end;
end;

function TWizardManager.PrevPageExecute(Sender: TObject): TModalResult;
var
  ActivePageIndex: integer;
begin
  Log(WizardName, 'Back Button Clicked');
  // Save and clear the current active page
  // This is so it can change the available pages and have this
  // affect the FindTab call
  ActivePageIndex := WizardControl.ActivePageIndex;
  dmPromotions.BeginHourglass;
  try
    OnLeavePage(WizardControl.ActivePage, wdBack);
    WizardControl.ActivePageIndex := -1;
    result := MoveToPage(FindTab(WizardControl, ActivePageIndex, False));
    // Cheat, as we are not handling the page entry via events
    if WizardControl.Visible then
      useful.ProcessPaintMessages;
    OnEnterPage(WizardControl.ActivePage, wdBack);
  finally
    dmPromotions.EndHourglass;
  end;
end;

end.
