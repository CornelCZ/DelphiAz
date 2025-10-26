unit uReports;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList;

type
  TReports = class(TForm)
    ReportActions: TActionList;
    SitePriceReport: TAction;
    ProductInPanelReport: TAction;
    CloseForm: TAction;
    lbDynamicMenuWarning: TLabel;
    procedure CloseFormExecute(Sender: TObject);
    procedure ProductInPanelReportExecute(Sender: TObject);
    procedure SitePriceReportExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ReportActionsExecute(Action: TBasicAction;
      var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure BuildMainMenu;
  end;

var
  Reports: TReports;

implementation

uses math, uShowSitePriceReport, uProductInPanelReport, uProductInPanelReportParams, uAztecLog,
  uFormNavigate;

{$R *.dfm}

procedure TReports.BuildMainMenu;
var
  NewTop, NewLeft, CloseTop, VisibleActionCount: integer;
  TempButton: TButton;
  i: integer;
begin
  NewTop := 0;
  NewLeft := 0;
  CloseTop := 0;
  VisibleActionCount := 0;
  for i := 0 to pred(ReportActions.ActionCount) do
    if TAction(ReportActions.Actions[i]).Visible then
      Inc(VisibleActionCount);
  for i := 0 to pred(ReportActions.ActionCount) do
  begin
    if TAction(ReportActions.Actions[i]).Visible and (ReportActions[i] <> CloseForm) then
    begin
      TempButton := TButton.Create(self);
      TempButton.Font.Size := 14;
      TempButton.Action := ReportActions.Actions[i];
      TempButton.Top := NewTop;
      TempButton.Width := 217+7;
      TempButton.Left := NewLeft;
      TempButton.Height := 41;
      NewTop := NewTop + TempButton.Height+7;
      TempButton.Parent := Self;
      if (i = Pred(VisibleActionCount div 2)) and (VisibleActionCount > 6) then
      begin
        CloseTop := NewTop;
        NewLeft := 217+7;
        NewTop := 0;
      end;
    end;
  end;
  // Add close button at the bottom
  CloseTop := Max(CloseTop, NewTop);
  TempButton := TButton.Create(self);
  TempButton.Font.Size := 14;
  TempButton.Action := CloseForm;
  TempButton.Top := CloseTop;
  TempButton.Width := Clientwidth;
  TempButton.Left := 0;
  TempButton.Height := 41;
  TempButton.Parent := Self;
end;

procedure TReports.CloseFormExecute(Sender: TObject);
begin
  Close;
end;

procedure TReports.ProductInPanelReportExecute(Sender: TObject);
begin
  with TProductInPanelReportParams.create(nil) do
  begin
    ShowModal;
    free;
  end;
end;

procedure TReports.SitePriceReportExecute(Sender: TObject);
begin
  with TShowSitePriceReport.create(nil) do
  begin
    showmodal;
    free;
  end;
end;

procedure TReports.FormCreate(Sender: TObject);
begin
  BuildMainMenu;
  RemoveControl(lbDynamicMenuWarning);
  lbDynamicMenuWarning.Free;
end;

procedure TReports.ReportActionsExecute(Action: TBasicAction;
  var Handled: Boolean);
begin
  if Action is TCustomAction then
  Log('User action: ' + TCustomAction(Action).Caption);
end;

procedure TReports.FormShow(Sender: TObject);
begin
  Log('Form Show ' + Caption);
end;

procedure TReports.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Nav.MoveBack;
end;

end.
