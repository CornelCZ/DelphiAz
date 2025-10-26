(* $Id: MercWwControl.pas,v 1.5 2001/10/15 12:04:41 taiga Exp $ [MISCCSID] *)
{
    Copyright (c) 1999 by Mercury Interactive ltd

    All rights reserved.

    This software is a property of Mercury Interactive ltd.
    It may not be used, copied, or modified unless you have a written
    permission of Mercury Interactive stating otherwise.

    Under no conditions may this copyright notice may be modified or
    deleted from the software.

		Name               Date       Modification made
		-------------------------------------------------------
		Yuval Ben-Zvi      3/1999       Create
}

unit MercWwControl;

interface
uses
  Windows, Messages, SysUtils, Classes, DBTables, Db,
  MercControl,MercCustControl,
  Wwdbigrd, Wwdbgrid,  Wwdatsrc,  Wwtable,
  Forms, Controls, Graphics, Dialogs, StdCtrls, Grids;

type

TMercWwDBGrid = class (TMercGrid)
  private
         function GetStringFromTField(Field: TField):String;
  public
         function CellDataEx(row, col: Longint):string ;override;
         function RowCountEx :Integer ; override;
         function ColCountEx :Integer ; override;
         function ToRowDrawGridIdx( row_str:string ): Longint; override;
         function GetSelectedRowEx:Integer ; override;
         function CaptureTableEx(filename:string): boolean; override;
  published


  end;

TMercwwInplaceEdit = class (TMercControl)
  private
  public
        function  GetMercTag :string ;override;
        function  Get_Recording :string ;
        function  Get_MercDesc  :string ;

  published
        property Recording: string read Get_Recording;
        property MercDesc: string  read Get_MercDesc;

  end;
implementation

procedure CreateMercObject(obj:TObject;var MercObject :TMercControl);
begin

     MercObject:=nil;
     if (MercUnitManger.InheritsFrom(Obj,'TwwDBGrid')) then
       MercObject:=TMercWwDBGrid.Create(Application)
     else if (MercUnitManger.InheritsFrom(Obj,'TwwInplaceEdit')) then
       MercObject:=TMercwwInplaceEdit.Create(Application)

end;

//////////////////////////////////////////////////////
//   implementation for TwwDBGrid
/////////////////////////////////////////////////////

function  TMercWwDBGrid.RowCountEx() :Integer ;
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

function  TMercWwDBGrid.ColCountEx() :Integer ;
begin
    Result :=TwwDBGrid(FObject).FieldCount;
end;


  function TMercWwDBGrid.GetStringFromTField(Field: TField):String;
  begin
  try
   case Field.DataType  of
       ftMemo: Result := Field.AsString;
   else
       Result := Field.DisplayText;
  end;

   Result :=StringToWRString(Result);
 except
   Result := FAIL_TO_GET_CELL_VALUE;
   end;
end;


function TMercWwDBGrid.CellDataEx(row, col: Longint):string ;
  var
  T: TField;
  s: string;
  bookmark: TBookmark;

  begin
     dec (col);       // the first colume is #1
     if (col<0) then exit;
     try
        begin
      if Assigned(TwwDBGrid(FObject).DataSource) then
       if Assigned(TwwDBGrid(FObject).DataSource.Dataset) then
       begin
       // if ( dgIndicator in TwwDBGrid(FObject).Options ) then
          if ( row = 0 ) then
             begin


             s :=TwwCustomDBGrid(FObject).Fields[Integer(col)].FieldName;
             Result := StringToWRTitleString(s);
             end
          else
            begin
            bookmark := TwwDBGrid(FObject).DataSource.Dataset.GetBookmark;
            TwwDBGrid(FObject).DataSource.Dataset.DisableControls;
            TwwDBGrid(FObject).DataSource.Dataset.First;
            TwwDBGrid(FObject).DataSource.Dataset.MoveBy(Integer(row - 1));
            T := TwwCustomDBGrid(FObject).Fields[Integer(col)];
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


function TMercWwDBGrid.ToRowDrawGridIdx( row_str:string ): Longint;
var
row:Longint;
begin
 Result :=-1;
 if (row_str[1]<>'#') then exit;
 row_str[1]:=' ';
 row :=mystrtoint(row_str);
 if (row<0) then exit;

 //TwwDBGrid(FObject).DataSource.Dataset.DisableControls;
 TwwDBGrid(FObject).DataSource.Dataset.First;
 TwwDBGrid(FObject).DataSource.Dataset.MoveBy(row - 1);
 //TwwDBGrid(FObject).DataSource.Dataset.EnableControls;
 Result :=TDrawGrid(FObject).row;
end;

function TMercWwDBGrid.GetSelectedRowEx():Integer ;
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

function TMercWwDBGrid.CaptureTableEx(filename:string): boolean;
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
                 line := line+ CellDataEx(0,i) + #9;
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


//////////////////////////////////////////////////////
//   implementation for TwwDBGridInplaceEdit
/////////////////////////////////////////////////////
var
GLestMecrString:string;
function  TMercwwInplaceEdit.Get_Recording() :string ;
  var
  Msg: TMessage;
  S:string;
  begin
  Result :='';// 'TMercwwInplaceEdit '+FParam[1]+'; Msg'+FParam[2]+';'+FParam[3]+';'+FParam[4] ;
  if (not (GetMessageParm(Msg))) then exit;

  if ( Msg.Msg=WM_SETFOCUS) then
  begin
     GLestMecrString:=TwwInplaceEdit(FObject).Text;
     exit;
  end;


  if ( Msg.Msg=WM_KILLFOCUS) then
  begin
  s:=TwwInplaceEdit(FObject).Text;
  if (s<>GLestMecrString) then
     begin
     Result := 'dlph_edit_set ("%m","'+s+'")';
     end;
  end;
end;

function  TMercwwInplaceEdit.Get_MercDesc()  :string ;
var
name:string;
begin
   name:=GetObjectProperty(FObject,'parent.name');
   Result:='{class: object,MSW_class: TwwInplaceEdit,dlph_parent: '+name+',tag: "'+name+'.Cell"}';
end;

function  TMercwwInplaceEdit.GetMercTag() :string ;
begin
     Result :=GetObjectProperty(FObject,'parent.name');
     Result := Result+'.Cell';
end;



initialization
  MercUnitManger.AddUnit(@CreateMercObject);
finalization

end.
