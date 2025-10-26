unit UInsEmp;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, wwdblook, DB, DBTables, Wwtable, dialogs, Wwquery,
  ADODB;

type
  TfInsEmp = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
    btnOK: TBitBtn;
    BitBtn2: TBitBtn;
    Combo2: TwwDBLookupCombo;
    listQuery: TADOQuery;
    cbEmployeeJobLookup: TwwDBLookupCombo;
    lblEmployeeJob: TLabel;
    qryEmployeeJobs: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure Combo2CloseUp(Sender: TObject;
      LookupTable: TDataset; FillTable: TDataSet; modified: Boolean);
    procedure Combo2Enter(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    theNewEmp: Int64;
    RoleId: Integer;
  end;

var
  fInsEmp: TfInsEmp;

implementation

uses dmodule1, uSchedule, uADO, uGlobals;

{$R *.DFM}

procedure TfInsEmp.FormShow(Sender: TObject);
begin
  if RoleId <> -1 then
  begin
    lblEmployeeJob.Visible := FALSE;
    cbEmployeeJobLookup.Visible := FALSE;
  end;

  listQuery.Parameters.ParamByName('siteid').Value := uGlobals.SiteCode;
  listQuery.Parameters.ParamByName('roleid').Value := RoleId;
  listQuery.Open;

  if listquery.recordcount <> 0 then
  begin
    label1.caption := 'Schedule a new employee';
    btnOK.visible := true;
    combo2.visible := true;
    combo2.lookuptable := listquery;
    combo2.text := '';
    combo2.setfocus;
    combo2.dropdown;
  end
  else
  begin
    label1.caption := 'No employees assigned to this job';
    combo2.visible := false;
    btnOK.visible := false;
  end;
end;

procedure TfInsEmp.btnOKClick(Sender: TObject);
begin
  if combo2.text = '' then
  begin
    combo2.setfocus;
    combo2.dropdown;
    exit;
  end;

  if RoleId = -1 then
  begin
    if cbEmployeeJobLookup.text = '' then
    begin
      cbEmployeeJobLookup.setfocus;
      cbEmployeeJobLookup.dropdown;
      exit;
    end;
  end;

  theNewEmp := listquery.fieldbyname('Id').Value;
  modalresult := mrOK;
  fSchedule.initialiselabels;
  listquery.close;
end;

procedure TfInsEmp.Combo2CloseUp(Sender: TObject;
  LookupTable: TDataset; FillTable: TDataSet; modified: Boolean);
begin
  combo2.performsearch;
  btnOK.setfocus;
  if RoleId = -1 then
  begin
    qryEmployeeJobs.Close;
    qryEmployeeJobs.Parameters.ParamByName('userid').Value := listQuery.fieldbyname('id').Value;
    qryEmployeeJobs.Parameters.ParamByName('siteid').Value := uGlobals.SiteCode;
    qryEmployeeJobs.Open;
    cbEmployeeJobLookup.DropDown;
  end;
end;

procedure TfInsEmp.Combo2Enter(Sender: TObject);
begin
  (sender as Twwdblookupcombo).dropdown;
end;

procedure TfInsEmp.BitBtn2Click(Sender: TObject);
begin
  listquery.close;
  qryEmployeeJobs.Close;
end;

procedure TfInsEmp.FormCreate(Sender: TObject);
begin
  if HelpExists then
    setHelpContextID(self, EMP_INS_EMPLOYEE);
end;

end.

