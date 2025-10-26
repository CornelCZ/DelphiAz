unit UTotals;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TFTotals = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Emptotal: TCheckBox;
    Empcost: TCheckBox;
    Jobtotal: TCheckBox;
    Jobcost: TCheckBox;
    Daytotal: TCheckBox;
    Daycost: TCheckBox;
    Weektotal: TCheckBox;
    Weekcost: TCheckBox;
    ExpTake: TCheckBox;
    ExpTakePc: TCheckBox;
    procedure OKBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTotals: TFTotals;

implementation

uses dmodule1, uGlobals;

{$R *.DFM}


procedure TFTotals.OKBtnClick(Sender: TObject);
var
  i: integer;
  totstr: string;

begin
  totstr := '0000000000';
  for i := 0 to (Ftotals.controlcount - 1) do
  begin
    if Ftotals.controls[i] is tcheckbox then
    begin
      if tcheckbox(FTotals.controls[i]).checked = true then
        totstr[Ftotals.controls[i].tag] := '1';
    end;
  end;
  with dmod1.wwtsysvar do
  begin
    open;
    edit;
    fieldbyname('Totals').asstring := totstr;
    post;
    close;
  end;
end;

procedure TFTotals.FormShow(Sender: TObject);
var
  i: integer;
  totstr: string;

begin
  with dmod1.wwtsysvar do
  begin
    open;
    totstr := fieldbyname('Totals').asstring;
    close;
  end;
  for i := 0 to (Ftotals.controlcount - 1) do
  begin
    if Ftotals.controls[i] is tcheckbox then
    begin
      if copy(totstr, Ftotals.controls[i].tag, 1) = '1' then
        tcheckbox(FTotals.controls[i]).checked := true
      else
        tcheckbox(FTotals.controls[i]).checked := false;
    end;
  end;
end;

procedure TFTotals.FormCreate(Sender: TObject);
begin
  if HelpExists then
    setHelpContextID(self, EMP_SCHEDULE_TOTALS);
end;

end.
