unit uADO;

interface

uses
  SysUtils, Classes, DB, ADODB, Forms, dADOAbstract;

type
  TdmADO = class(TdmADOAbstract)
    cmdCreateTempTables: TADOCommand;
  private
    { Private declarations }
    procedure BuildAndExecuteCreateTempTablesCommand;
  protected
    procedure CreateTempTables; override;
    procedure LogError(Error: string); override;
  public
    { Public declarations }
  end;

var
  dmADO: TdmADO;

implementation

uses ulog;

{$R *.dfm}

procedure TdmADO.CreateTempTables;
begin
  BuildAndExecuteCreateTempTablesCommand;
end;

procedure TdmADO.LogError(Error: string);
begin
  Log.Event(Error);
end;

// Because of a bug in Resource DLL wizard which cannot create localized versions
// of TdmADO because the CommandText of cmdCreateTempTables was too long, we have
// to set the value at runtime.  Why are all these tables being created at startup
// anyway?
procedure TdmADO.BuildAndExecuteCreateTempTablesCommand;
begin
  cmdCreateTempTables.CommandText :=
    'CREATE TABLE [dbo].[#EmpAtTmp] (' + #13#10#9 +
    '[SiteCode] [smallint] NOT NULL ,' + #13#10#9 +
    '[UserId] [bigint] NOT NULL ,' + #13#10#9 +
    '[LName] [varchar] (20) collate database_default NULL ,' + #13#10#9 +
    '[FName] [varchar] (20) collate database_default NULL ,' + #13#10#9 +
    '[D1] [nvarchar] (2) collate database_default NOT NULL  DEFAULT ('#39#39') ,' + #13#10#9 +
    '[D2] [nvarchar] (2) collate database_default NOT NULL  DEFAULT ('#39#39') ,' + #13#10#9 +
    '[D3] [nvarchar] (2) collate database_default NOT NULL  DEFAULT ('#39#39') ,' + #13#10#9 +
    '[D4] [nvarchar] (2) collate database_default NOT NULL  DEFAULT ('#39#39') ,' + #13#10#9 +
    '[D5] [nvarchar] (2) collate database_default NOT NULL DEFAULT ('#39#39') ,' + #13#10#9 +
    '[D6] [nvarchar] (2) collate database_default NOT NULL  DEFAULT ('#39#39') ,' + #13#10#9 +
    '[D7] [nvarchar] (2) collate database_default NOT NULL  DEFAULT ('#39#39')' + #13#10 +
    ') ON [PRIMARY]';

  cmdCreateTempTables.Execute;


  cmdCreateTempTables.CommandText :=
    'CREATE TABLE [dbo].[#vrfyschd] (' + #13#10#9 +
    '[Name] [varchar] (20) collate database_default NOT NULL ,' + #13#10#9 +
    '[UserId] [bigint] NOT NULL ,' + #13#10#9 +
    '[KSchIn] [datetime] NOT NULL ,' + #13#10#9 +
    '[Shift] [smallint] NULL ,' + #13#10#9 +
    '[Schin] [varchar] (5) collate database_default NULL ,' + #13#10#9 +
    '[Schout] [varchar] (5) collate database_default NULL ,' + #13#10#9 +
    '[Clockin] [varchar] (5) collate database_default NULL ,' + #13#10#9 +
    '[Clockout] [varchar] (5) collate database_default NULL ,' + #13#10#9 +
    '[AccIn] [varchar] (5) collate database_default NULL ,' + #13#10#9 +
    '[AccOut] [varchar] (5) collate database_default NULL ,' + #13#10#9 +
    '[Fname] [varchar] (20) collate database_default NULL ,' + #13#10#9 +
    '[FWorked] [float] NULL ,' + #13#10#9 +
    '[Worked] [varchar] (5) collate database_default NULL ,' + #13#10#9 +
    '[Break] [varchar] (5) collate database_default NULL ,' + #13#10#9 +
    '[RoleId] [int] NULL ,' + #13#10#9 +
    '[WRoleId] [int] NULL ,' + #13#10#9 +
    '[WorkedPayFrequencyId] [int] NULL ,' + #13#10#9 +
    '[WorkedPaySchemeId] [int] NULL ,' + #13#10#9 +
    '[WorkedPaySchemeVersionId] [int] NULL ,' + #13#10#9 +
    '[WorkedUserPayRateOverrideVersionId] [int] NULL ,' + #13#10#9 +
    '[RateMod] [varchar] (1) collate database_default NULL ,' + #13#10#9 +
    '[RateMod2] [varchar] (1) collate database_default NULL ,' + #13#10#9 +
    '[Confirmed] [varchar] (1) collate database_default NULL ,' + #13#10#9 +
    '[Visible] [varchar] (1) collate database_default NULL ,' + #13#10#9 +
    '[Added] [smallint] NULL ,' + #13#10#9 +
    '[BsDate] [datetime] NULL ' + #13#10 +
    ') ON [PRIMARY]';

  cmdCreateTempTables.Execute;

  cmdCreateTempTables.CommandText :=
    'CREATE TABLE [dbo].[#empshift] (' + #13#10#9 +
    '[Site] [smallint] NOT NULL ,' + #13#10#9 +
    '[UserId] [bigint] NOT NULL ,' + #13#10#9 +
    '[ClockIn] [datetime] NOT NULL ,' + #13#10#9 +
    '[ClockOut] [datetime] NULL ,' + #13#10#9 +
    '[RoleId] [int] NULL ,' + #13#10#9 +
    '[Break] [datetime] NULL ,' + #13#10 +
    '[ClockedPaySchemeVersionId] int NULL ,' + #13#10 +
    '[ClockedUserPayRateOverrideVersionID] int NULL' + #13#10 +
    ') ON [PRIMARY]';

  cmdCreateTempTables.Execute;

  cmdCreateTempTables.CommandText :=
    'CREATE TABLE [dbo].[#matching] (' + #13#10#9 +
    '[Site] [smallint] NOT NULL ,' + #13#10#9 +
    '[UserId] [bigint] NOT NULL ,' + #13#10#9 +
    '[SchIn] [datetime] NOT NULL ,' + #13#10#9 +
    '[ClockIn] [datetime] NOT NULL ,' + #13#10#9 +
    '[ClockOut] [datetime] NULL ,' + #13#10#9 +
    '[FIn] [float] NULL ,' + #13#10#9 +
    '[FOut] [float] NULL ,' + #13#10#9 +
    '[RoleId] [int] NULL ,' + #13#10#9 +
    '[FBreak] [float] NULL ,' + #13#10 +
    '[ClockedPaySchemeVersionId] [int] NULL ,' + #13#10 +
    '[ClockedUserPayRateOverrideVersionID] [int] NULL' + #13#10 +
    ') ON [PRIMARY]';

  cmdCreateTempTables.Execute;


  cmdCreateTempTables.CommandText :=
    'CREATE TABLE [dbo].[#schbatch] (' + #13#10#9 +
    '[Site] [smallint] NOT NULL ,' + #13#10#9 + 
    '[UserId] [bigint] NOT NULL ,' + #13#10#9 +
    '[Schin] [datetime] NOT NULL ,' + #13#10#9 +
    '[Schout] [datetime] NULL ,' + #13#10#9 + 
    '[ClockIn] [datetime] NULL ,' + #13#10#9 + 
    '[ClockOut] [datetime] NULL ,' + #13#10#9 + 
    '[AccIn] [datetime] NULL ,' + #13#10#9 +
    '[AccOut] [datetime] NULL ,' + #13#10#9 + 
    '[Fworked] [float] NULL ,' + #13#10#9 + 
    '[Worked] [datetime] NULL ,' + #13#10#9 + 
    '[FBreak] [float] NULL ,' + #13#10#9 + 
    '[Break] [datetime] NULL ,' + #13#10#9 + 
    '[RoleId] [int] NULL ,' + #13#10#9 +
    '[WRoleId] [int] NULL ,' + #13#10#9 +
    '[Shift] [smallint] NULL DEFAULT (1) ,' + #13#10#9 +
    '[Confirmed] [varchar] (1) collate database_default NULL ,' + #13#10#9 +
    '[SFlag] [varchar] (6) collate database_default NULL DEFAULT ('#39'ZZ-999'#39') ,' + #13#10 +
    '[ClockedPaySchemeVersionId] [int] NULL ,' + #13#10 +
    '[ClockedUserPayRateOverrideVersionID] [int] NULL' + #13#10 +
    ') ON [PRIMARY]';

  cmdCreateTempTables.Execute;

  cmdCreateTempTables.CommandText :=
    'CREATE TABLE [dbo].[#rpWkPay] (' + #13#10#9 +
    '[Site] [smallint] NOT NULL ,' + #13#10#9 +
    '[SEC] [float] NOT NULL ,' + #13#10#9 +
    '[SchIn] [datetime] NOT NULL ,' + #13#10#9 +
    '[SchOut] [datetime] NULL ,' + #13#10#9 +
    '[BsDate] [datetime] NULL ,' + #13#10#9 +
    '[Worked] [datetime] NULL ,' + #13#10#9 +
    '[Break] [datetime] NULL ,' + #13#10#9 +
    '[WrkMin] [int] NULL DEFAULT (0) ,' + #13#10#9 +
    '[WrkMinOT] [int] NULL  DEFAULT (0),' + #13#10#9 +
    '[JobId] [smallint] NULL ,' + #13#10#9 +
    '[Shift] [smallint] NULL ,' + #13#10#9 +
    '[NRate] [float] NULL  DEFAULT (0),' + #13#10#9 +
    '[ORate] [float] NULL  DEFAULT (0),' + #13#10#9 +
    '[PayType] [smallint] NULL ,' + #13#10#9 +
    '[NPay] [float] NULL  DEFAULT (0),' + #13#10#9 +
    '[OPay] [float] NULL  DEFAULT (0),' + #13#10#9 +
    '[CFlag] [varchar] (1) collate database_default NULL ,' + #13#10#9 +
    '[TotMin] [int] NULL  DEFAULT (0),' + #13#10#9 +
    '[OTMin] [int] NULL  DEFAULT (0)' + #13#10 +
    ') ON [PRIMARY]';
  cmdCreateTempTables.Execute;

  cmdCreateTempTables.CommandText :=
    'CREATE TABLE [dbo].[#schunmch] (' + #13#10#9 +
    '[Site] [smallint] NOT NULL ,' + #13#10#9 +
    '[UserId] [bigint] NOT NULL ,' + #13#10#9 +
    '[Schin] [datetime] NOT NULL ,' + #13#10#9 +
    '[Schout] [datetime] NULL ,' + #13#10#9 +
    '[ClockIn] [datetime] NULL ,' + #13#10#9 +
    '[ClockOut] [datetime] NULL ,' + #13#10#9 +
    '[AccIn] [datetime] NULL ,' + #13#10#9 +
    '[AccOut] [datetime] NULL ,' + #13#10#9 +
    '[FWorked] [float] NULL ,' + #13#10#9 +
    '[Worked] [datetime] NULL ,' + #13#10#9 +
    '[FBreak] [float] NULL ,' + #13#10#9 +
    '[Break] [datetime] NULL ,' + #13#10#9 +
    '[RoleId] [int] NULL ,' + #13#10#9 +
    '[WRoleId] [int] NULL ,' + #13#10#9 +
    '[Shift] [smallint] NULL DEFAULT (1),' + #13#10#9 +
    '[Confirmed] [varchar] (1) collate database_default NULL DEFAULT ('#39'N'#39'),' + #13#10#9 +
    '[Rec] [smallint] NULL DEFAULT (1),' + #13#10#9 +
    '[Visible] [varchar] (1) collate database_default NULL DEFAULT ('#39'N'#39'),' + #13#10#9 +
    '[SFlag] [varchar] (6) collate database_default NULL DEFAULT ('#39'ZZ-999'#39'),' + #13#10 +
    '[ClockedPaySchemeVersionId] [int] NULL,' + #13#10 +
    '[ClockedUserPayRateOverrideVersionID] [int] NULL' + #13#10 +
    ') ON [PRIMARY]';

  cmdCreateTempTables.Execute;

  cmdCreateTempTables.CommandText :=
    'create table [dbo].[#RateOverrides] ( ' +
    '  [BandType] [int] NOT NULL, ' +
    '  [OverriddenPayRate] [money] NOT NULL, ' +
    '  [OldOverriddenPayRate] [money] NOT NULL, ' +
    '  [BasePayRate] [money] NOT NULL) ON [PRIMARY]';

  cmdCreateTempTables.Execute;

  cmdCreateTempTables.CommandText :=
    'CREATE UNIQUE CLUSTERED INDEX [PK_RateOverrides] ON [dbo].[#RateOverrides]  ' + #13#10#9 +
    '([BandType]) ON [PRIMARY]';

  cmdCreateTempTables.Execute;

  cmdCreateTempTables.CommandText :=
    'CREATE UNIQUE CLUSTERED INDEX [PK_EmpAtTmp] ON [dbo].[#EmpAtTmp]  ' + #13#10#9 +
    '([SiteCode],[UserId])  ON [PRIMARY]';

  cmdCreateTempTables.Execute;

  cmdCreateTempTables.CommandText :=
    'CREATE UNIQUE CLUSTERED INDEX [PK_VrfySchd] ON [dbo].[#vrfyschd]  ' + #13#10#9 +
    '([Name],[UserId],[KSchIn])  ON [PRIMARY] ' + #13#10#13#10 +
    'CREATE UNIQUE CLUSTERED INDEX [PK_empshift] ON [dbo].[#empshift]  ' +#13#10#9 +
    '([Site],[UserId],[ClockIn])  ON [PRIMARY] ' + #13#10#13#10 +
    'CREATE UNIQUE CLUSTERED INDEX [PK_matching] ON [dbo].[#matching]  ' + #13#10#9 +
    '([Site],[UserId],[SchIn],[ClockIn])  ON [PRIMARY] ' + #13#10#13#10 +
    'CREATE UNIQUE CLUSTERED INDEX [PK_#rpWkPay] ON [dbo].[#rpWkPay]  ' + #13#10#9 +
    '([Site],[SEC],[SchIn])  ON [PRIMARY]';

  cmdCreateTempTables.Execute;

  cmdCreateTempTables.CommandText :=
    'CREATE UNIQUE CLUSTERED INDEX [PK_schbatch] ON [dbo].[#schbatch]  ' + #13#10#9 +
    '([Site],[UserId],[Schin])  ON [PRIMARY]' + #13#10#13#10 +
    'CREATE UNIQUE CLUSTERED INDEX [PK_schunmch] ON [dbo].[#schunmch]  ' + #13#10#9 +
    '([Site],[UserId],[Schin])  ON [PRIMARY] ';

  cmdCreateTempTables.Execute;

end;

end.
