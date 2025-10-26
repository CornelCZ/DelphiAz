{ Mike Palmer
  (c) Copyright Zonal Retail Data Systems Ltd. All Rights Reserved }

unit uAztecSoftware;

interface

uses uCommon, uAztecAction, uAztecComputer;

type
  TAztecModuleVersion=class(TAztecAction)
  private
    FModule:string;
    FVersion:string;
    function GetAztecModuleVersion(Computer : TAztecComputer):string;
  public
    constructor Create(const AModule:string); reintroduce;
    function Execute(Computer : TAztecComputer; var AResultString:string):boolean; override;
  published
    property Module:string read FModule write FModule;
    property Version:string read FVersion;
  end;

implementation

uses SysUtils, ADODB;

{ TAztecModuleVersion }

function TAztecModuleVersion.GetAztecModuleVersion(Computer : TAztecComputer):string;
var
  ADOConnection:TADOConnection;
  ADODataSet:TADODataSet;
begin
  Computer.Progress('Connecting',0);
  ADOConnection:=TADOConnection.Create(nil);
  try
    ADOConnection.ConnectionString:='Provider=SQLOLEDB.1;Password=southpark;Persist Security Info=True;'+
        'User ID=zonal;Initial Catalog=Aztec;Data Source='+Computer.WMIConnection.MachineName;
    ADOConnection.KeepConnection:=TRUE;
    ADOConnection.LoginPrompt:=FALSE;

    ADODataSet:=TADODataSet.Create(nil);
    Computer.Progress('Connected',25);
    with ADODataset do
    try
      Connection:= ADOConnection;
      CommandType:= cmdText;
      CommandText:= 'Select * from ModuleVersion where [ModuleID]='+QuotedStr(FModule);
      Computer.Progress('Executing SQL',50);
      Open;
      if ADODataSet.RecordCount = 1 then
         Result:=FieldByName('ProductVersion').AsString+'.'+FieldByName('MajorVersion').AsString+'.'+
                 FieldByName('MinorVersion').AsString+'.'+FieldByName('Revision').AsString;
      Close;
    finally
      FreeAndNil(ADODataSet);
      Computer.Progress('SQL Complete',75);
    end;
  finally
    FreeAndNil(ADOConnection);
    Computer.Progress('Complete',100);
  end;
end;

function TAztecModuleVersion.Execute(Computer : TAztecComputer; var AResultString:string): boolean;
begin
  FVersion:=GetAztecModuleVersion(Computer);
  result:=TRUE;
end;

constructor TAztecModuleVersion.Create(const AModule:string);
begin
  inherited Create;
  FModule:=AModule;
  FActionDescription:='Get Aztec Module Details';
end;

end.
