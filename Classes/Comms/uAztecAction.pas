{ Mike Palmer
  (c) Copyright Zonal Retail Data Systems Ltd. All Rights Reserved }

unit uAztecAction;

interface

uses uCommon,Contnrs, wmiConnection, uAztecComputer;

type
  TAztecAction=class;

  TAztecActionEditor=function(var AAction:TAztecAction):boolean;

  TAztecAction=class(TObject)
  private
    FActionEditor:TAztecActionEditor;
  public
    constructor Create; virtual;
    destructor Destroy;override;
    function ExecuteAndLog(Computer : TAztecComputer):boolean;
    function Execute(Computer : TAztecComputer; var AResultString:string):boolean; virtual; abstract;
    property ActionEditor:TAztecActionEditor read FActionEditor write FActionEditor;
  protected
    FActionDescription:string;
    FOverview:string;
    FFirstAction:boolean;
    FTerminate:boolean;
    FImageIndex:integer;
    FConnectionNeeded:boolean;
  published
    property Overview:string read FOverview write FOverview;
    property ActionDescription:string read FActionDescription write FActionDescription;
    property ImageIndex:integer read FImageIndex write FImageIndex;
    property WMIConnectionNeeded:boolean read FConnectionNeeded default FALSE;
    property FirstAction:boolean read FFirstAction;
    property TerminateSequenceOnError:boolean read FTerminate;
  end;

  TAztecActionList=class(TObjectList)
  public
    procedure DeleteAction(const AIndex:integer);
    procedure AddAction(AAction:TAztecAction);
    procedure InsertAction(AAction:TAztecAction;const AIndex:integer);
    procedure SwapActions(const AIndex1, AIndex2:integer);
  end;

implementation

uses SysUtils;

{ TAztecActionList }

procedure TAztecActionList.InsertAction(AAction:TAztecAction;const AIndex:integer);
begin
  Insert(AIndex, AAction);
end;

procedure TAztecActionList.AddAction(AAction:TAztecAction);
begin
  Add(AAction);
end;

procedure TAztecActionList.DeleteAction(const AIndex: integer);
begin
  Delete(AIndex);
end;

procedure TAztecActionList.SwapActions(const AIndex1, AIndex2: integer);
begin
  if (not TAztecAction(Items[AIndex1]).FFirstAction) and
     (not TAZtecAction(Items[AIndex2]).FFirstAction) then
     Exchange(AIndex1, AIndex2);
end;

{ TAztecAction }

constructor TAztecAction.Create;
begin
  inherited;
  FFirstAction:=FALSE;
  FActionEditor:=nil;
  FTerminate:=FALSE;
  FConnectionNeeded:=FALSE;
end;

destructor TAztecAction.Destroy;
begin
  inherited;
end;

function TAztecAction.ExecuteAndLog(Computer : TAztecComputer):boolean;
var
  ResultString : string;
begin
  try
    if WMIConnectionNeeded then
      Computer.WMIConnection.Connected := true;
    Result := Execute(Computer, ResultString);
  except
    on E: Exception do
      begin
        Result := false;
        ResultString := FActionDescription +',-,Failed,Exception: '+E.Message;
      end;
  end;
  Computer.WriteToLogFile(ResultString);
end;

end.










