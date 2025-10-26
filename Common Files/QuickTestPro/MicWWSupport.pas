{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M+,N+,O-,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$ifdef VER150}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$endif}

unit MicWWSupport;

interface
uses
  AgentExtensibilitySDK,
  Windows, Messages, SysUtils, Classes, DBTables, Db,
  Wwdbigrd, Wwdbgrid,  Wwdatsrc,  Wwtable,
  Forms, Controls, Graphics, Dialogs, StdCtrls, Grids;


type
  TMicAOWwDBGrid = class (TCustomGridAOBase)
    public
      function GetCellDataEx(row, column: Longint):string ;override;
      procedure SetCellDataEx(row, column: Longint; Value: String); override;
      function RowCountEx :Integer ; override;
      function ColCountEx :Integer ; override;
      function GridIdxToVisibleRowNum( row_str:string ): Longint; override;
      function GetSelectedRowEx:Integer ; override;
      function CaptureTableEx(filename:string): boolean; override;
  end;

                                   

implementation
const
  MAXROWS = 2147483647;

//////////////////////////////////////////////////////
//   implementation for TwwDBGrid
/////////////////////////////////////////////////////

function  TMicAOWwDBGrid.RowCountEx() :Integer ;
var
  bookmark: TBookmark;
begin
   bookmark := TwwDBGrid(FObject).DataSource.Dataset.GetBookmark;
   TwwDBGrid(FObject).DataSource.Dataset.DisableControls;
   TwwDBGrid(FObject).DataSource.Dataset.First;
   if  (TwwDBGrid(FObject).DataSource.Dataset.EOF) then
         Result:=0
    else
    begin
    Result := Abs(TwwDBGrid(FObject).DataSource.Dataset.MoveBy(MAXROWS))+1;
    TwwDBGrid(FObject).DataSource.Dataset.EnableControls;
    TwwDBGrid(FObject).DataSource.Dataset.GotoBookmark( bookmark );
    TwwDBGrid(FObject).DataSource.Dataset.FreeBookmark( bookmark );
    end;
end;

function  TMicAOWwDBGrid.ColCountEx() :Integer ;
begin
    Result :=TwwDBGrid(FObject).FieldCount;
end;


procedure TMicAOWwDBGrid.SetCellDataEx(row, column: Longint; Value: String);
  var
  T: TField;
  bookmark: TBookmark;
  begin
     dec (column);       // the first colume is #1
     if (column<0) then exit;
     try
        begin
      if Assigned(TwwDBGrid(FObject).DataSource) then
       if Assigned(TwwDBGrid(FObject).DataSource.Dataset) then
       begin
       // if ( dgIndicator in TDBGrid(FObject).Options ) then
//          if ( row = 0 ) then
//             begin
//              TwwCustomDBGrid(FObject).Columns[Integer(column)];
//              end
 //         else
            begin
            bookmark := TwwDBGrid(FObject).DataSource.Dataset.GetBookmark;
            TwwDBGrid(FObject).DataSource.Dataset.DisableControls;
            TwwDBGrid(FObject).DataSource.Dataset.First;
            TwwDBGrid(FObject).DataSource.Dataset.MoveBy(Integer(row - 1));
            T := TwwCustomDBGrid(FObject).Fields[Integer(column)];
            TwwDBGrid(FObject).DataSource.Dataset.Edit;
  		      SetStringToTField(T, Value);
            TwwDBGrid(FObject).DataSource.Dataset.EnableControls;
            TwwDBGrid(FObject).DataSource.Dataset.GotoBookmark( bookmark );
            TwwDBGrid(FObject).DataSource.Dataset.FreeBookmark( bookmark );
         end;
        end; // if Assigned(TDBGrid(obj).DataSource.Dataset)

  end; // try
  except
  end;
end;


function TMicAOWwDBGrid.GetCellDataEx(row, column: Longint):string ;
  var
  T: TField;
  s: string;
  bookmark: TBookmark;

  begin
     dec (column);       // the first colume is #1
     if (column<0) then exit;
     try
        begin
      if Assigned(TwwDBGrid(FObject).DataSource) then
       if Assigned(TwwDBGrid(FObject).DataSource.Dataset) then
       begin
       // if ( dgIndicator in TwwDBGrid(FObject).Options ) then
          if ( row = 0 ) then
             begin


             s :=TwwCustomDBGrid(FObject).Fields[Integer(column)].FieldName;
             Result := ReplaceIllegalCharacters(s);
             end
          else
            begin
            bookmark := TwwDBGrid(FObject).DataSource.Dataset.GetBookmark;
            TwwDBGrid(FObject).DataSource.Dataset.DisableControls;
            TwwDBGrid(FObject).DataSource.Dataset.First;
            TwwDBGrid(FObject).DataSource.Dataset.MoveBy(Integer(row - 1));
            T := TwwCustomDBGrid(FObject).Fields[Integer(column)];
            Result := GetStringFromTField(T);
            TwwDBGrid(FObject).DataSource.Dataset.EnableControls;
            TwwDBGrid(FObject).DataSource.Dataset.GotoBookmark( bookmark );
            TwwDBGrid(FObject).DataSource.Dataset.FreeBookmark( bookmark );
         end;
        end; // if Assigned(TwwDBGrid(obj).DataSource.Dataset)

  end; // try
  except
  end;
  end;


function TMicAOWwDBGrid.GridIdxToVisibleRowNum( row_str:string ): Longint;
var
row:Longint;
begin
 Result :=-1;
 if (row_str[1]<>'#') then exit;
 row_str[1]:=' ';
 row :=MicStrToInt(row_str);
 if (row<0) then exit;

 //TwwDBGrid(FObject).DataSource.Dataset.DisableControls;
 TwwDBGrid(FObject).DataSource.Dataset.First;
 TwwDBGrid(FObject).DataSource.Dataset.MoveBy(row - 1);
 //TwwDBGrid(FObject).DataSource.Dataset.EnableControls;
 Result :=TDrawGrid(FObject).row;
end;

function TMicAOWwDBGrid.GetSelectedRowEx():Integer ;
var
bookmark: TBookmark;
begin
  bookmark := TwwDBGrid(FObject).DataSource.Dataset.GetBookmark;
  TwwDBGrid(FObject).DataSource.Dataset.DisableControls;
  Result := Abs(TwwDBGrid(FObject).DataSource.Dataset.MoveBy(-MAXROWS)) + 1;
  TwwDBGrid(FObject).DataSource.Dataset.EnableControls;
  TwwDBGrid(FObject).DataSource.Dataset.GotoBookmark( bookmark );
  TwwDBGrid(FObject).DataSource.Dataset.FreeBookmark( bookmark );
end;

function TMicAOWwDBGrid.CaptureTableEx(filename:string): boolean;
var
F : TextFile;
num_cols,i: Integer;
line: string;
bookmark: TBookmark;
T: TField;
begin
Result :=True;
if (Length(filename)=0) then  exit;
AssignFile(F, fileName);
Rewrite(F);
try
   if Assigned(TwwDBGrid(FObject).DataSource) then
     if Assigned(TwwDBGrid(FObject).DataSource.Dataset) then
       begin
            num_cols := TwwCustomDBGrid(FObject).FieldCount;
            line:='';
            for i:=1 to num_cols do
                 line := line+ GetCellDataEx(0,i) + #9;
            line:=copy (line,1,Length(line)-1);  // remove the lest #9
            Writeln(F, line);

            bookmark := TwwDBGrid(FObject).DataSource.Dataset.GetBookmark;
            TwwDBGrid(FObject).DataSource.Dataset.DisableControls;
            TwwDBGrid(FObject).DataSource.Dataset.First;
            while ( (not TwwDBGrid(FObject).DataSource.Dataset.EOF)) do
              begin
              line:='';
                  for i:=0 to num_cols-1 do
                    begin
                      T := TwwCustomDBGrid(FObject).Fields[i];
                      line := line + GetStringFromTField(T)+ #9;
                      end;
              line:=copy (line,1,Length(line)-1);  // remove the lest #9
              Writeln(F, line);
              TwwDBGrid(FObject).DataSource.Dataset.Next;
              end;
            TwwDBGrid(FObject).DataSource.Dataset.EnableControls;
            TwwDBGrid(FObject).DataSource.Dataset.GotoBookmark( bookmark );
            TwwDBGrid(FObject).DataSource.Dataset.FreeBookmark( bookmark );
     end; // if Assigned(TwwDBGrid(obj).DataSource.Dataset)
finally
CloseFile(F);
end; // try
end;

function GridVCLObj2AO(obj:TObject;var AgentObject :TMicAO):HRESULT; stdcall;
begin
     Result:= S_OK;

     if (IsInheritFrom(Obj,'TwwDBGrid')) then
       AgentObject:=TMicAOWwDBGrid.Create
     else
       Result:= S_FALSE;
end;

begin
  AddExtensibilityServer(@GridVCLObj2AO);
end.
