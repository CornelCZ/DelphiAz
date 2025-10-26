unit uUser;

interface
uses
   SysUtils, Classes, Contnrs;

type

 TRole = class
  private
   fId:integer;
   fName:string;
  public
   constructor Create(aId:integer; aName:string);
   property Id:integer read fId;
   property Name:string read fName;
  end;


 TUserPosition = class
  private
   fId:integer;
   fName:string;
  public
   constructor Create(aId:integer; aName:string);
   property Id:integer read fId;
   property Name:string read fName;
  end;

 {$HINTS OFF}
 TRoleList = class(TObjectList)
  private
    function Extract(Item: TRole): TRole;
  protected
    function GetItems(Index: Integer): TRole;
    procedure SetItems(Index: Integer; ARole: TRole);
  public
    function Add(ARole: TRole): Integer;
    function Remove(ARole: TRole): Integer;
    function IndexOf(ARole: TRole): Integer;
    procedure Insert(Index: Integer; ARole: TRole);
    property Items[Index: Integer]: TRole read GetItems write SetItems; default;
    function AsSQLCheck: string;
  end;
  {$HINTS ON}

 TUser = class
  private
    fUserName : string;
    fPassword: string;
    fRoles: TRoleList;
    fId: Int64;
    fIsZonalUser:boolean;
    fUserPosition:TUserPosition;
  public
    constructor Create(aId:Int64; aUserName, aPassword:string);
    destructor Destroy();override;

    property UserName:string read fUserName;
    property Password:string read fPassword;
    property Roles:TRoleList read fRoles;
    property Id:Int64 read fId;
    property UserPosition:TUserPosition read fUserPosition write fUserPosition;
    property IsZonalUser:boolean read fIsZonalUser write fIsZonalUser;
 end;


implementation

{ TRoleList }

function TRoleList.Add(ARole: TRole): Integer;
begin
  Result := inherited Add(ARole);
end;

function TRoleList.AsSQLCheck: string;
var
  i: integer;
begin
  if Count = 0 then Result := ' in (-1) '
  else
  begin
    Result := ' in (';
    for i := 0 to Pred(Count) do
    begin
      result := result + inttostr(Items[i].fID);
      if i < Pred(Count) then
        result := result + ', ';
    end;
    Result := Result + ') ';
  end;
end;

function TRoleList.Extract(Item: TRole): TRole;
begin
  Result := TRole(inherited Extract(Item));
end;

function TRoleList.GetItems(Index: Integer): TRole;
begin
  Result := TRole(inherited Items[Index]);
end;

function TRoleList.IndexOf(ARole: TRole): Integer;
begin
  Result := inherited IndexOf(ARole);
end;

procedure TRoleList.Insert(Index: Integer; ARole: TRole);
begin
  inherited Insert(Index, ARole);
end;

function TRoleList.Remove(ARole: TRole): Integer;
begin
  Result := inherited Remove(ARole);
end;

procedure TRoleList.SetItems(Index: Integer; ARole: TRole);
begin
  inherited Items[Index] := ARole;
end;

{ TUser }

constructor TUser.Create(aId:Int64; aUserName, aPassword:string);
begin
 fId:=aId;
 fUserName:=aUserName;
 fPassword:=aPassword;
 fRoles:=TRoleList.Create();
end;

destructor TUser.Destroy;
begin
  fRoles.Free;
  inherited;
end;

{ TUserPosition }

constructor TUserPosition.Create(aId: integer; aName: string);
begin
 fId:=aId;
 fName:=aName;
end;

{ TRole }

constructor TRole.Create(aId: integer; aName: string);
begin
 fId:=aId;
 fName:=aName;
end;

end.
