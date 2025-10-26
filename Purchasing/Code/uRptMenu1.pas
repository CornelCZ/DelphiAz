unit uRptMenu1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfrmRptMenu1 = class(TForm)
    WeeklyRepBtn: TBitBtn;
    PeriodBtn: TBitBtn;
    uTurnBtn: TBitBtn;
    Label1: TLabel;
    procedure uTurnBtnClick(Sender: TObject);
    procedure WeeklyRepBtnClick(Sender: TObject);
    procedure WeeklyRepBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PeriodBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    //BttnPress: Integer;
  end;

var
  frmRptMenu1: TfrmRptMenu1;

implementation

uses
  U1WklyPurch, uDMWklyPrchRep, config, UReports, uGlobals, uMainMenu, uLog;

{$R *.DFM}

procedure TfrmRptMenu1.uTurnBtnClick(Sender: TObject);
begin
	//BttnPress := 3;
end;

procedure TfrmRptMenu1.WeeklyRepBtnClick(Sender: TObject);
begin
	//BttnPress := 1;
  frm1wklypurch := Tfrm1wklypurch.Create(Self);
  frm1wklypurch.ShowModal;
  frm1wklypurch.Free;
end;

procedure TfrmRptMenu1.WeeklyRepBtnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Shift = [ssRight,ssAlt,ssShift] then
  begin
    frmMainConfig := TfrmMainConfig.Create(Self);
    frmMainConfig.showmodal;
    frmMainConfig.Free;
  end;
end;

procedure TfrmRptMenu1.PeriodBtnClick(Sender: TObject);
begin

	//BttnPress := 2;
	//ShowMessage('Will display "Period Reports" screen when integrated'+#13+
  //									'with Purchase Module.');
  freports := tfreports.create(self);
  freports.windowstate := self.WindowState;
  freports.Top := self.Top;
  freports.Left := self.Left;
  freports.showmodal;
  freports.free;
end;

procedure TfrmRptMenu1.FormCreate(Sender: TObject);
begin
  log.event('Reports Menu Form opened');
  Caption := appGUIString + ' Reports Menu';
  if purchHelpExists then
    setHelpContextID(self, HLP_REPORTS_MENU);
end;

procedure TfrmRptMenu1.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  log.event('Reports Menu Form closed');
end;

end.
