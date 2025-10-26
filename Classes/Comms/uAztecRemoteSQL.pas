{ Mike Palmer
  (c) Copyright Zonal Retail Data Systems Ltd. All Rights Reserved }

unit uAztecRemoteSQL;

interface

uses uCommon, uAztecAction, uAztecComputer, Classes;

type
  TAztecRemoteSQL=class(TAztecAction)
  private
    FSQL:TStringList;
    FPort:integer;
    function ExecuteRemoteSQL(Computer : TAztecComputer; out Detail: string):boolean;
  public
    constructor Create; reintroduce;
    destructor Destroy;override;
    function Execute(Computer: TAztecComputer; var AResultString:string):boolean; override;
  published
    property SQL:TStringList read FSQL write FSQL;
    property Port:integer read FPort write FPort;
  end;

  TAztecModuleID = (
     amDatabase {DB},
     amFinance {AZFS},
     amAccessControl {AZAA},
     amArchiveUtility{AZAU},
     amAuditChecker {AZAC},
     amAuditReader {AZAR},
     amBaseData {AZBD},
     amComms {AZCM},
     amCommsSystem {AZCS},
     amController {AZCC},
     amEPOSManager {AZEM},
     amHumanResource {AZES},
     amiStock {AZIS},
     amLaunchControl {AZLC},
     amProductModelling {AZPM},
     amPromotions {AZPP},
     amPurchasing {AZDS},
     amRestrictedStock {AZRE},
     amServiceWatch {AZSW},
     amSiteSelect {AZSL},
     amSpotCheck {AZSP},
     amStandardPricing {AZBP},
     amStocks {AZSA},
     amThemeModelling {AZTM},
     amTillReports {AZTR},
     amToolbar {AZGU});

  TAztecGetModuleVersion = class(TAztecAction)
  private
    FAztecModule:TAztecModuleID;
    FVersion:string;
    FPort:integer;
    function OpenRemoteSQL(Computer : TAztecComputer):boolean;
    function GetModuleID:string;
  public
    constructor Create(AModuleID:TAztecModuleID); reintroduce;
    function Execute(Computer: TAztecComputer; var AResultString:string):boolean; override;
  published
    property ModuleID:TAztecModuleID read FAztecModule write FAztecModule;
    property Version:string read FVersion write FVersion;
    property Port:integer read FPort write FPort;

  end;

const AZTEC_MODULE_ID_TEXT:array[amDatabase..amToolbar] of shortstring =
      ('DB','AZFS','AZAA','AZAU','AZAC','AZAR','AZBD','AZCM','AZCS','AZCC','AZEM','AZES','AZIS','AZLC',
       'AZPM','AZPP','AZDS','AZRE','AZSW','AZSL','AZSP','AZBP','AZSA','AZTM','AZTR','AZGU');

const AZTEC_MODULE_NAME:array[amDatabase..amToolbar] of shortstring =
      ('Database','Finance','Access Control','Archive Utility','Audit Checker','Audit Reader',
       'Base Data','Comms','Comms System','Controller','EPOS Manager','Human Resource',
       'iStock','Launch Control','Product Modelling','Promotions','Purchasing',
       'Restricted Stock','Service Watch','Site Select','Spot Check','Standard Pricing',
       'Stocks','Theme Modelling','Till Reports','Toolbar');

implementation

uses SysUtils, ADODB, Dialogs, DB, uAztecDatabaseUtils, Variants;

{ TAztecModuleVersion }

function TAztecRemoteSQL.ExecuteRemoteSQL(Computer : TAztecComputer; out Detail: string):boolean;
var
  ADOConnection:TADOConnection;
  ADODataSet:TADOCommand;
  TempSQLList: TStringList;
  i:Integer;
  ComputerName:string;
  recordsAffected:Integer;

  procedure FillInDetailFromRecordset( recordset: _Recordset );
  const
    MAX_DETAIL_ROWS = 5;
  var
    ADODataSet:TADODataSet;
    row, col : Integer;
  begin
    if (recordset = nil) or ((recordset.State and 1) = 0) then
    begin
      Detail := IntToStr(recordsAffected)+' rows affected';
    end
    else
    begin
      Detail := '';
      ADODataSet := TADODataSet.Create(nil);
      try
        // Dump out the contents of this recordset in ugly, CSV format
        ADODataSet.Recordset := recordset;
        row := 1;
        while (not ADODataSet.EOF) and (row <= MAX_DETAIL_ROWS) do
        begin
          if row > 1 then
            detail := detail + '|';
          for col := 0 to ADODataSet.FieldCount - 1 do
          begin
            if col > 0 then
              detail := detail + ',';
            detail := detail + ADODataSet.Fields[col].AsString;
          end;
          ADODataSet.Next;
          Inc(row);
        end;

        if not ADODataSet.EOF then
        begin
          if ADODataSet.RecordCount > MAX_DETAIL_ROWS then
            Detail := Detail + '...('+IntToStr(ADODataSet.RecordCount-MAX_DETAIL_ROWS)+' more rows)'
          else
            Detail := Detail + '...';
        end;
      finally
        ADODataSet.Free;
      end;
    end;
  end;

begin
  ComputerName:=Computer.WMIConnection.MachineName;
  Computer.Progress('Connecting',0);
  ADOConnection:=TADOConnection.Create(nil);
  TempSQLList := TStringList.Create;
  try
    ADOConnection.ConnectionString:='Provider=SQLOLEDB.1;Password='+ZONAL_ACCESS_PASSWORD+';Persist Security Info=True;'+
        'User ID=zonalaccess;Initial Catalog=Aztec;Data Source='+ComputerName+','+IntToStr(FPort);
    ADOConnection.KeepConnection:=TRUE;
    ADOConnection.LoginPrompt:=FALSE;
    try
      ADOConnection.Connected:=TRUE;
    except
      if FPort=1433 then
         FPort:=2433;
      ADOConnection.ConnectionString:='Provider=SQLOLEDB.1;Password='+ZONAL_ACCESS_PASSWORD+';Persist Security Info=True;'+
      'User ID=zonalaccess;Initial Catalog=Aztec;Data Source='+ComputerName+','+IntToStr(FPort);
      ADOConnection.Connected:=TRUE;
    end;

    ADODataSet:=TADOCommand.Create(nil);
    Result:=TRUE;
    with ADODataset do
    try
      CommandTimeout := 600;
      Connection:=ADOConnection;
      CommandType:=cmdText;
      ParamCheck := FALSE;
      Computer.Progress('Executing SQL',50);

      for i := 0 to FSQL.Count -1 do
      begin
        if UpperCase(Trim(FSQL[i])) = 'GO' then
        begin
          try
            FillInDetailFromRecordset(Execute(recordsAffected,Null));
          except
            on E : Exception do
            begin
              Detail := E.Message;
              Result:=FALSE;
              Break;
            end;
          else
            Detail := 'Unknown error';
            Result:=FALSE;
            Break;
          end;
          CommandText := '';
          TempSQLList.Clear;
        end
        else
        begin
          TempSQLList.Add(FSQL[i]);
          CommandText := TempSQLList.Text;
        end;
      end;
      if Length(CommandText) > 0 then
      begin
        try
          FillInDetailFromRecordset(Execute(recordsAffected,Null));
        except
          on E : Exception do
          begin
            Detail := E.Message;
            Result:=FALSE;
          end;
        else
            Detail := 'Unknown error';
            Result:=FALSE;
        end;
        CommandText := '';
      end;
    finally
      FreeAndNil(ADODataSet);
      Computer.Progress('SQL Complete',75);
    end;
  finally
    FreeAndNil(ADOConnection);
    TempSQLList.Free;
    Computer.Progress('Complete',100);
  end;
end;

function TAztecRemoteSQL.Execute(Computer: TAztecComputer; var AResultString:string): boolean;
var
  Detail : string;
begin
  Result:=ExecuteRemoteSQL(Computer, Detail);
  AResultString:=FActionDescription+','+'SQL'+','+BooleanToString(Result)+','+Detail;
end;

constructor TAztecRemoteSQL.Create;
begin
  inherited Create;
  FActionDescription:='Remote SQL';
  FSQL:=TStringList.Create;
  FPort:=1433;
end;

destructor TAztecRemoteSQL.Destroy;
begin
  FreeAndNil(FSQL);
  inherited;
end;

{ TAztecGetModuleVersion }

constructor TAztecGetModuleVersion.Create(AModuleID:TAztecModuleID);
begin
  inherited Create;
  FActionDescription:='Get Aztec Module Version';
  FAztecModule:=AModuleID;
  FPort:=1433;
end;

function TAztecGetModuleVersion.Execute(Computer: TAztecComputer; var AResultString:string): boolean;
begin
  FVersion := '';
  Result:=OpenRemoteSQL(Computer);
  AResultString:=FActionDescription+','+AZTEC_MODULE_NAME[FAztecModule]+','+BooleanToString(Result)+','+FVersion;
end;

function TAztecGetModuleVersion.GetModuleID: string;
begin
  Result:=AZTEC_MODULE_ID_TEXT[FAztecModule];
end;

function TAztecGetModuleVersion.OpenRemoteSQL(Computer : TAztecComputer): boolean;
var
  ADOConnection : TADOConnection;
  ADODataSet    : TADODataSet;
  ComputerName  : string;
begin
  ComputerName:=Computer.WMIConnection.MachineName;
  Computer.Progress('Connecting', 0);
  ADOConnection := TADOConnection.Create(nil);

  try
    Result := FALSE;
    ADOConnection.ConnectionString:='Provider=SQLOLEDB.1;Password=southpark;Persist Security Info=True;'+
        'User ID=zonal;Initial Catalog=Aztec;Data Source='+ComputerName+','+IntToStr(FPort);
    ADOConnection.KeepConnection := TRUE;
    ADOConnection.LoginPrompt := FALSE;
    try
      ADOConnection.Connected:=TRUE;
    except
      if FPort=1433 then
         FPort:=2433;
      ADOConnection.ConnectionString:='Provider=SQLOLEDB.1;Password=southpark;Persist Security Info=True;'+
      'User ID=zonal;Initial Catalog=Aztec;Data Source='+ComputerName+','+IntToStr(FPort);
    end;
    ADODataSet := TADODataSet.Create(nil);

    with ADODataset do
    try
      Connection  := ADOConnection;
      CommandType := cmdText;
      ParamCheck := FALSE;
      Computer.Progress('Opening SQL', 50);

      CommandText := 'select * from ModuleVersion where ModuleID = ' + QuotedStr(GetModuleID);
      Open;
      if RecordCount > 0 then
      begin
        Result:=TRUE;
        FVersion:=FieldByName('ProductVersion').AsString+'.'+FieldByName('MajorVersion').AsString+
          '.'+FieldByName('MinorVersion').AsString+'.'+FieldByName('Revision').AsString;
      end;
      Close;
    finally
      FreeAndNil(ADODataSet);
      Computer.Progress('SQL Complete',75);
    end;
  finally
    FreeAndNil(ADOConnection);
    Computer.Progress('Complete', 100);
  end;
end;

end.
