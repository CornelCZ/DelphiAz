unit uEditJobSecurity;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, DB, ADODB;

const NULL_JOB_CODE = '-22222';

type
  TEditJobSecurity = class(TForm)
    clbRoles: TCheckListBox;
    Button1: TButton;
    Button2: TButton;
    qRun: TADOQuery;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure clbRolesClickCheck(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SetAllocatedJobs;
  private
    procedure LoadRoles;
    procedure LoadButtonSecurity(ButtonSecurityId: integer);
    procedure CreateTempTables;
    function SaveButtonSecurity: Integer;
    procedure SaveRoles;
    { Private declarations }
  public
    { Public declarations }
    ButtonID, ButtonSecurityId: integer;
  end;

var
  EditJobSecurity: TEditJobSecurity;

implementation

uses uADO, uAztecLog;

{$R *.dfm}

procedure TEditJobSecurity.FormShow(Sender: TObject);
begin
  //TODO: So much of this seems to be cribbed directly from uEditTimedJobSecurity!
  //Time does not allow me the luxury of pulling out the common stuff so I have
  //left the duiplications in place. :-(

  Log('Form Show ' + Caption);

  //See the comment in uEditTimeSecurity for an explanation: search for H E R E   B E  D R A G O N S
  if ButtonSecurityId = -2 then
    ButtonSecurityId := 0;

  LoadRoles;

  LoadButtonSecurity(ButtonSecurityId);
end;

procedure TEditJobSecurity.Button1Click(Sender: TObject);
begin
  ButtonClicked(Sender);
  SaveRoles;
  ButtonSecurityId := SaveButtonSecurity;
  modalresult := mrOk;
end;

procedure TEditJobSecurity.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Log('Form Close ' + Caption);
end;

procedure TEditJobSecurity.clbRolesClickCheck(Sender: TObject);
begin
  if clbRoles.checked[clbroles.ItemIndex] then
     Log('Role ' + clbRoles.Items[clbRoles.ItemIndex] + ' Added')
   else
     Log('Role ' + clbRoles.Items[clbRoles.ItemIndex] + ' removed')
end;

procedure TEditJobSecurity.LoadRoles;
begin
  Log('Load possible FoH roles.');
  // Load FoH roles
  with qRun do
  begin
    SQL.text := 'select distinct Id, Name from ac_Role where deleted = 0 and RoleTypeId = 1 and Id <> ' + NULL_JOB_CODE;
    Open;
    clbRoles.clear;
    while not qRun.Eof do
    begin
      clbRoles.AddItem(qRun.fieldbyname('name').asstring, TObject(qRun.fieldbyname('id').asinteger));
      Next;
    end;
    Close;
  end;
end;

procedure TEditJobSecurity.LoadButtonSecurity(ButtonSecurityId: integer);
begin
  Log('Load button security.');

  with qRun do
  begin
    Close;
    SQL.Clear;

    SQL.Add('declare @ButtonSecurityId int');
    SQL.Add('set @ButtonSecurityId = ' + IntToStr(ButtonSecurityId));
    SQL.Add('delete from #SecurityTypeRoles');
    SQL.Add('');
    SQL.Add('if @ButtonSecurityId = 0');
              //No button security set, give the default security all jobs.
    SQL.Add(' insert #SecurityTypeRoles');
    SQL.Add(' select bstl.Id, sub.RoleId');
    SQL.Add(' from ButtonSecurityTypeLookup bstl');
    SQL.Add(' cross join (select distinct Id as RoleId from ac_Role where deleted = 0 and RoleTypeId = 1 and Id <> ' + NULL_JOB_CODE + ') sub');
    SQL.Add(' where bstl.Id = 0;');
    SQL.Add('else');
    SQL.Add('begin');
    SQL.Add(' insert #SecurityTypeRoles');
    SQL.Add(' select bs.SecurityTypeId, RoleId');
    SQL.Add(' from ButtonSecurity bs');
    SQL.Add(' join ThemeTask tt on bs.TaskId = tt.TaskId');
    SQL.Add(' where bs.Id = @ButtonSecurityId and bs.SecurityTypeID = 0;');
    SQL.Add('');
              //Add in all the roles if the TaskID is 0 (ZERO).
    SQL.Add(' insert #SecurityTypeRoles');
    SQL.Add(' select sub2.SecurityTypeID, sub2.RoleId');
    SQL.Add(' from #SecurityTypeRoles str');
    SQL.Add(' right join (select bs.SecurityTypeId, sub.RoleId');
    SQL.Add('            from ButtonSecurity bs');
    SQL.Add('            cross join (select distinct Id as RoleId from ac_Role where deleted = 0 and RoleTypeId = 1 and Id <> ' + NULL_JOB_CODE + ') sub');
    SQL.Add('            where bs.TaskId = 0 and  bs.Id = @ButtonSecurityId) sub2');
    SQL.Add(' on str.SecurityTypeID = sub2.SecurityTypeId');
    SQL.Add(' where str.SecurityTypeId is null;');
              //Add in a dummy record if no roles are required for a partic. security type.
    SQL.Add(' insert #SecurityTypeRoles');
    SQL.Add(' select SecurityTypeID, -1');
    SQL.Add(' from ButtonSecurity bs');
    SQL.Add(' where Id = @ButtonSecurityId and  bs.SecurityTypeID = 0 and TaskId = -1;');
    SQL.Add('end');
    ExecSQL;
  end;

  dmado.adoqFoHRoles.Requery();

  SetAllocatedJobs;
end;

procedure TEditJobSecurity.CreateTempTables;
begin
  with qRun do
  begin
    Close;
    SQL.Add('if object_id(''tempdb..#SecurityTypeRoles'') is not null');
    SQL.Add(' drop table #SecurityTypeRoles');
    SQL.Add('create table #SecurityTypeRoles (');
    SQL.Add(' SecurityTypeId tinyint,');
    SQL.Add(' RoleId int,');
    SQL.Add(' primary key (SecurityTypeId, RoleID))');
    ExecSQL;
  end;
end;


procedure TEditJobSecurity.FormCreate(Sender: TObject);
begin
  qRun.Connection := uADO.dmADO.AztecConn;
  CreateTempTables;
  dmADO.adoqFoHRoles.Open;
end;

procedure TEditJobSecurity.SaveRoles;
var
  i: integer;
  UpdateQuery: string;
  UpdatQueryTemplate: String;
begin
  UpdateQuery := 'declare @temproles table (SecurityTypeId smallint, RoleId int)';
  UpdatQueryTemplate := 'insert @temproles values (%d, %d)';

  for i := 0 to clbRoles.Items.Count - 1 do
  begin
    if clbRoles.Checked[i] then
      UpdateQuery := UpdateQuery + #13#10 +
                     Format(UpdatQueryTemplate, [0, Integer(clbRoles.Items.Objects[i])]);
  end;

  UpdateQuery := UpdateQuery + #13#10 +
                 'merge #SecurityTypeRoles as target' + #13#10 +
                 'using @temproles as source' +#13#10 +
                 '  on target.SecurityTypeId = source.SecurityTypeId and target.RoleId = source.RoleID' + #13#10 +
                 'when not matched by target then' + #13#10 +
                 '  insert (SecurityTypeId, RoleId) values (source.SecurityTypeId, source.RoleId)' + #13#10 +
                 'when not matched by source and target.SecurityTypeId = 0 then' + #13#10 +
                 '  delete;';

  with qRun do
  begin
    Close;
    SQL.Text := UpdateQuery;
    ExecSQL;
  end;

  dmADO.adoqFoHRoles.Requery();
end;

function TEditJobSecurity.SaveButtonSecurity: Integer;
var
  NewSecurityId: integer;
begin
  NewSecurityId := -2;
  with dmADO.adoqSaveButtonSecurity do
  begin
    Close;
    Parameters.ParamByName('TotalRoles').value := clbRoles.Items.count;
    Open;
    if not EOF then
    begin
      if not FieldByName('Output').IsNull then
      begin
        NewSecurityId := FieldByName('Output').AsInteger;
      end;
    end;
  end;

  //See the comment in uEditTimeSecurity for an explanation: search for H E R E   B E  D R A G O N S
  if NewSecurityId = 0 then
    NewSecurityId := -2;
  Result := NewSecurityId;
end;

procedure TEditJobSecurity.SetAllocatedJobs;
var
  i: Integer;
begin
  Assert(dmADO.adoqFoHRoles.Active,'adoqFoHRoles dataset not open');
  for i := 0 to pred(clbRoles.Items.Count) do
  begin
    clbRoles.checked[i] := dmADO.adoqFoHRoles.Locate('SecurityTypeId;RoleId', VarArrayOf([0, cardinal(clbRoles.Items.Objects[i])]), []);
  end;
end;

end.
