unit uADO_SwipeRange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dADOAbstract, ADODB, DB, DBClient, StrUtils;

const
  VIRTUAL_DEVICE_LIMIT = 3;

type
  TdmADO_SwipeRange = class(TdmADOAbstract)
    qRun: TADOQuery;
    qGenerateRanges: TADOQuery;
    procedure DataModuleCreate(Sender: TObject); override;
  private
    { Private declarations }
  public
    { Public declarations }
    Logon_Name: string;
  end;

var
  dmADO_SwipeRange: TdmADO_SwipeRange;
  MutexHandle: THandle;


implementation

uses useful, uSimpleLocalise, uAztecLog,
  uDatabaseVersion, uGlobals;

{$R *.dfm}

procedure BatchExecute(batch: TStrings; query: TADOQuery);
var
  line_no, p: integer;
  curline: string;
  DBDestination: string;
begin
  query.SQL.clear;
  for line_no := 1 to pred(batch.count) do
  begin
    curline := batch.Strings[line_no];

    p := pos('FILENAME = ', CurLine);

    if p > 0 then
      CurLine := Copy(CurLine, 1, 15) + DBDestination + Copy(CurLine, 65, 15);

    if lowercase(trim(curline)) = 'go' then
    begin
      query.ExecSQL;
      query.sql.clear;
    end
    else
      query.sql.add(curline);
  end;
  if query.SQL.Count > 0 then
    query.ExecSQL;
end;

procedure TdmADO_SwipeRange.DataModuleCreate(Sender: TObject);
var
  ModuleVersion, MinDBVersion: array[0..25] of char;
begin
  inherited;

  if LoadString(hInstance, 12, ModuleVersion, sizeof(ModuleVersion)) = 0 then
  begin
    ShowMessage('Unable to load version information.' + #13 +
      'Aztec Theme Modelling will now terminate');
    Halt;
  end;

  if LoadString(hInstance, 13, MinDBVersion, sizeof(MinDBVersion)) = 0 then
  begin
    ShowMessage('Unable to load version information.' + #13 +
      'Aztec Theme Modelling will now terminate');
    Halt;
  end;

  sleep(10);
end;






end.
