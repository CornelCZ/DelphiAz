(* $Id: MercCustControl.pas,v 1.25 2003/09/07 08:16:44 taiga Exp $ [MISCCSID] *)
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


unit MercCustControl;
        
interface
uses
 Windows, Messages, SysUtils, Db, DBTables, MercControl,
 Forms, Controls, Graphics, Grids, DBGrids, DBCtrls, StdCtrls, Mask;

 const
 MAXROWS         =2147483647 ;
 FAIL_TO_GET_CELL_VALUE ='Fail_TO_GET_CELL_VALUE';
 // Cust Recoding Retunr code copy from "cust_rec.h"
 SEND_LINE=0;
 KEEP_LINE=1;
 REPLACE_AND_SEND_LINE=2;
 REPLACE_AND_KEEP_LINE=3;
 CLEAN_UP=4;
 KEEP_LINE_NO_TIMEOUT=5;
 NO_PROCESS=6;
 REPLACE_AND_KEEP_LINE_NO_TIMEOUT=7;
 MIC_MAX_HEADER_LENGTH = 25;



type
TMercGrid = class (TMercControl)
  private
    function GetCellFromPoint( obj: TObject; p:Tpoint; var row, col: Longint ): Boolean;
    function GetCellParm( var row_str,col_str:string ): bool;
    function ToRowIdx(row_str:string ): Longint;
    function ToColIdx(col_str:string ): Longint;

  public
    function StringToWRString  (S:string):String;
    function StringToWRTitleString (S:string):String;
    function CellDataEx(row, col: Longint):string ; virtual;
    function CaptureTableEx(filename:string): boolean; virtual;
    function ToRowDrawGridIdx( row_str:string ): Longint; virtual;
    function RowCountEx :Integer ; virtual;
    function ColCountEx :Integer ; virtual;
    function GetSelectedRowEx:Integer ; virtual;
    function MakeCellVisbleEx(row, col: Longint): bool; virtual;

    function  Get_IsGrid :boolean ;
    function  Get_CellRect :string ;
    function  Get_Recording :string ;
    function  Get_MercRecReturn :Integer;
    function  Get_CellData :string ;
    procedure Set_CellData(Value: string);
    function  Get_RowCount :Integer ;
    function  Get_ColCount :Integer ;
    function  Get_SelectedCell :string ;
    function  Get_TableContent:boolean ;
    function GetAdditionalAllPropertyNameEx(var Count: Integer): string; override;

  published
     property IsGrid: boolean read Get_IsGrid;
     property CellRect: string read Get_CellRect;
     property Recording: string  read Get_Recording;
     property MercRecReturn: Integer  read Get_MercRecReturn;
     property CellData: string  read Get_CellData write Set_CellData;
     property RowCount: Integer read Get_RowCount ;
     property ColCount: Integer read Get_ColCount ;
     property SelectedCell: string read Get_SelectedCell;
     property TableContent: boolean read Get_TableContent;

  end;

TMercDBGrid = class (TMercGrid)
  private
         function GetStringFromTField(Field: TField):String;
  public
         function CellDataEx(row, col: Longint):string ;override;
         function RowCountEx :Integer ; override;
         function ColCountEx :Integer ; override;
         function ToRowDrawGridIdx( row_str:string ): Longint; override;
         function GetSelectedRowEx:Integer ; override;
         function CaptureTableEx(filename:string): boolean; override;
         function GetNotSupportObjectEx(obj:TObject;propname:string): TObject; override;
  published


  end;
TMercDBGridInplaceEdit = class (TMercControl)
  private
  public
        function  GetMercTag :string ;override;
        function  Get_Recording :string ;
        function  Get_MercDesc  :string ;

  published
        property Recording: string read Get_Recording;
        property MercDesc: string  read Get_MercDesc;

  end;

TMercPopupListbox = class (TMercControl)
  private
        function GetItemFromPoint(p:TPoint) :string ;
        function ItemToIndex(item:string):Integer;
  public
        function  Get_Recording :string ;
        function  Get_MercDesc  :string ;
        function  Get_MercHandle:HWND ;
        function  Get_ItemPoint :string ;
  published
        property Recording:string  read Get_Recording;
        property MercDesc: string  read Get_MercDesc;
        property MercHandle :HWND  read Get_MercHandle;
        property ItemPoint: string read Get_ItemPoint;
  end;

TMercStringGrid = class (TMercGrid)
  private

  public
        function CellDataEx(row, col: Longint):string ;override;
  published
  end;

TMercDBLookupComboBox = class (TMercControl)
  private
  public
        function  Get_Text :string ;
        function  Get_MercEOF :Boolean;
        function  GetAdditionalAllPropertyNameEx(var Count: Integer): string; override;
  published
        property Text: string read Get_Text;
        property MercEOF: Boolean read Get_MercEOF;

  end;

TMercDBLookupListBox = class (TMercControl)
  private
  public
        function  Get_Recording :string ;
        function  Get_MercHandle:HWND ;
        function  Get_Text :string ;
        function  GetAdditionalAllPropertyNameEx(var Count: Integer): string; override;

  published
        property Recording: string read Get_Recording;
        property MercHandle :HWND  read Get_MercHandle;
        property Text: string read Get_Text;

  end;


  TMicControlWrapper=class(TControl)
  // We use  TMicControlWrapper for access to
  // protected member caption of TControl descendants
  end;

TMercPanel = class (TMercControl)
  private
  function  GetObjectFromPoint(p:TPoint; var offset:TPoint) :string ;
  public
        function  Get_Recording :string ;
        function  Get_ControlRect :string ;
        function  GetControlIndex (objControl:TMicControlWrapper) :string ;

  published
        property Recording: string read Get_Recording;
        property ControlRect: string  read Get_ControlRect;

  end;

implementation

procedure CreateMercObject(obj:TObject;var MercObject :TMercControl);
begin
     MercObject:=nil;

     if (MercUnitManger.InheritsFrom(Obj,'TDBGrid')) then
        MercObject:=TMercDBGrid.Create(Application)
     else if (MercUnitManger.InheritsFrom(Obj,'TDBGridInplaceEdit')) then
       MercObject:=TMercDBGridInplaceEdit.Create(Application)
     else if (MercUnitManger.InheritsFrom(Obj,'TPopupListbox')) then
       MercObject:=TMercPopupListbox.Create(Application)
     else if (MercUnitManger.InheritsFrom(Obj,'TStringGrid')) then
       MercObject:=TMercStringGrid.Create(Application)
     else if (MercUnitManger.InheritsFrom(Obj,'TDBLookupComboBox')) then
       MercObject:=TMercDBLookupComboBox.Create(Application)
     else if (MercUnitManger.InheritsFrom(Obj,'TDBLookupListBox')) then  //TDBLookupListBox   TPopupDataList
       MercObject:=TMercDBLookupListBox.Create(Application)
     else if (MercUnitManger.InheritsFrom(Obj,'TPanel') or MercUnitManger.InheritsFrom(Obj,'TToolbar97')
       or MercUnitManger.InheritsFrom(Obj,'TToolBar') or MercUnitManger.InheritsFrom(Obj,'TActionToolBar') ) then
       MercObject:=TMercPanel.Create(Application);
end;
//////////////////////////////////////////////////////
//   implementation for Basic Grid Class
/////////////////////////////////////////////////////

function TMercGrid.StringToWRString  (S:string):String;
begin
	while Pos(#13, S) > 0 do
	    S[Pos(#13, S)] := ' ';
	while Pos(#10, S) > 0 do
	    S[Pos(#10, S)] := ' ';
	while Pos(#9, S) > 0 do
	    S[Pos(#9, S)] := ' ';
   	while Pos(#0, S) > 0 do
   		S[Pos(#0, S)] := ' ';
	Result :=S;
end;

function TMercGrid.StringToWRTitleString  (S:string):String;
begin
S:=StringToWRString(S);
while Pos(' ', S) > 0 do
    S[Pos(' ', S)] := '_';
Result :=S;
end;

function TMercGrid.GetCellFromPoint( obj: TObject; p:Tpoint; var row, col: Longint ): Boolean;
var
  rect: TRect;
  i, j: Integer;
begin
  Result := False;
  col :=-1;
  row :=-1;
   for i := 0 to TDrawGrid(obj).ColCount - 1 do
      begin
        for j := 0 to TDrawGrid(obj).RowCount - 1 do
        begin
          rect := TDrawGrid(obj).CellRect(i, j);
          if  ((rect.Top <= p.y) and (rect.Left <= p.x) and
              (rect.Bottom > p.y) and (rect.Right > p.x) ) then
               begin
                 col := i;
                 row := j;
                 Result := TRUE;
                 exit;
               end;

        end; // for j
    end; // for i
end;

function TMercGrid.GetCellParm( var row_str,col_str:string ): bool;
begin
  row_str:=FParam[1];
  col_str:=FParam[2];
  Result := True;
end;

function TMercGrid.RowCountEx() :Integer ;
begin
Result := TDrawGrid(FObject).RowCount;
end;
function TMercGrid.ColCountEx() :Integer ;
begin
Result := TDrawGrid(FObject).ColCount;
end;

function TMercGrid.GetSelectedRowEx():Integer ;
begin
Result := TDrawGrid(FObject).row;
end;

function TMercGrid.ToRowDrawGridIdx(row_str:string ): Longint;
begin
Result :=-1;
if (row_str[1]='#') then
   begin
      row_str[1]:=' ';
      Result :=mystrtoint(row_str);
      exit;
   end;
end;

function TMercGrid.ToRowIdx(row_str:string ): Longint;
begin
Result :=-1;
if (row_str[1]='#') then
   begin
      row_str[1]:=' ';
      Result :=mystrtoint(row_str);
      exit;
   end;
end;

function TMercGrid.ToColIdx(col_str:string ): Longint;
var
i:Integer;
begin
Result :=-1;
if (col_str[1]='#') then
   begin
      col_str[1]:=' ';
      Result :=mystrtoint(col_str);
      exit;
   end;

for i:=0 to ColCountEx() do
 if (CellDataEx(0,i)=col_str) then
    begin
         Result :=i;
    end;
end;

function TMercGrid.MakeCellVisbleEx(row, col: Longint): bool;
begin
     TDrawGrid(FObject).LeftCol :=  col ;
     Result:=True;
end;

function  TMercGrid.GetAdditionalAllPropertyNameEx(var Count: Integer): string;
begin
 Result := 'TableContent;';
 Count:=1;
end;

///////// property ////////////////

function  TMercGrid.Get_IsGrid() :boolean ;
begin
     Result := TRUE;
end;

function  TMercGrid.Get_CellRect() :string ;
var
row_str,col_str:string;
row,col:Longint;
rect: TRect;
begin
 Result := '0;0;0;0;;';
 GetCellParm(row_str,col_str);
 row:=ToRowDrawGridIdx(row_str);
 col:=ToColIdx(col_str);
 if ((row<0) or (col<0)) then exit;
 rect:=TDrawGrid(FObject).CellRect(col,row);
 if ((rect.Left=0) and (rect.Top=0)) then
    begin
         MakeCellVisbleEx(row,col);
         rect:=TDrawGrid(FObject).CellRect(col,row);
    end;
 Result :=inttostr(rect.Left)+';'+ inttostr(rect.Top)+';'+inttostr(rect.Right)+';'+inttostr(rect.Bottom)+';;';

end;
var
lest_click: DWORD;
IsDbClick :BOOL;
function  TMercGrid.Get_Recording() :string ;
  var
  Msg: TMessage;
  p:TPoint;
  row,col: Integer;
  row_str,col_str:string;
  begin
    Result := '';//'Recoding '+FParam[1]+'; Msg'+FParam[2]+';'+FParam[3]+';'+FParam[4] ;
  if (not (GetMessageParm(Msg))) then exit;

   if (Msg.Msg=WM_LBUTTONDOWN) then
         IsDbClick:= FALSE;

  if ( (Msg.Msg=WM_LBUTTONUP) or
       (Msg.Msg=WM_LBUTTONDBLCLK) ) then
     begin
     p.x:=LOWORD(Msg.lParam);
     p.y:=HIWORD(Msg.lParam);
     if (not (GetCellFromPoint(FObject,p,row,col))) then exit;
     row_str:='#'+inttostr(row);

     col_str:=CellDataEx(0,col);
     if ((Length(col_str)=0) or (Length(col_str) > MIC_MAX_HEADER_LENGTH)) then
        col_str:='#'+inttostr(col);

     if ((Msg.Msg=WM_LBUTTONDBLCLK) or
         ((GetTickCount()-lest_click)<500)) then
         begin
         Result := 'tbl_activate_cell ("%m","'+ row_str+'","'+col_str +'")';
         IsDbClick:= TRUE;
         end
     else
         if not (IsDbClick) then
           Result := 'tbl_set_selected_cell ("%m","'+ row_str+'","'+col_str +'")';
     lest_click:= GetTickCount();

     end;

end;

function  TMercGrid.Get_MercRecReturn :Integer;
begin
Result :=REPLACE_AND_KEEP_LINE;
end;

function TMercGrid.Get_CellData() :string ;
var
row_str,col_str:string;
row,col:Longint;
begin
 Result := ' ';
 GetCellParm(row_str,col_str);
 row:=ToRowIdx(row_str);
 col:=ToColIdx(col_str);
 if ((row<0) or (col<0)) then exit;
 Result :=CellDataEx(row,col);
end;

procedure TMercGrid.Set_CellData(Value: string);
begin
      Value := '-1'; // not implemnt
end;

function TMercGrid.CellDataEx(row, col: Longint):string ;
begin
Result :='';
end;

function  TMercGrid.Get_RowCount() :Integer ;
begin
     Result :=RowCountEx();
end;

function  TMercGrid.Get_ColCount() :Integer ;
begin
     Result :=ColCountEx();
end;

function  TMercGrid.Get_SelectedCell() :string ;
var
col_str,row_str:string;
begin
 row_str:='#'+inttostr(GetSelectedRowEx());
 col_str:=CellDataEx(0,TDrawGrid(FObject).col);
 if ((Length(col_str)=0) or (Length(col_str) > MIC_MAX_HEADER_LENGTH)) then
     col_str:='#'+inttostr(TDrawGrid(FObject).col);

 Result :=row_str+';'+col_str+';;';
end;

function  TMercGrid.CaptureTableEx(filename:string): boolean;
var
F : TextFile;
i,j: Integer;
line: string;
begin
Result :=True;
if (Length(filename)=0) then  exit;
AssignFile(F, fileName);
Rewrite(F);
for i:=0 to Get_RowCount() do
 begin
    line:='';
    for j:=0 to Get_ColCount() do
       line := line+ StringToWRString(CellDataEx(i,j)) + #9;
    line:=copy (line,1,Length(line)-2);  // remove the lest #9
    Writeln(F, line);
 end;
 CloseFile(F);
end;

function TMercGrid.Get_TableContent(): boolean;
var
filename:string;
begin
filename:=FParam[1];
Result :=CaptureTableEx(filename);
end;
//////////////////////////////////////////////////////
//   implementation for TDbGrid
/////////////////////////////////////////////////////

function  TMercDBGrid.RowCountEx() :Integer ;
var
  bookmark: TBookmark;
begin
   Result:= TDBGrid(FObject).DataSource.Dataset.RecordCount;
   if Result <= 0 then
   begin
      bookmark := TDBGrid(FObject).DataSource.Dataset.GetBookmark;
      TDBGrid(FObject).DataSource.Dataset.DisableControls;
      TDBGrid(FObject).DataSource.Dataset.First;
      if  (TDBGrid(FObject).DataSource.Dataset.EOF) then
          Result:=0
      else
      begin
        Result := Abs(TDBGrid(FObject).DataSource.Dataset.MoveBy(MAXROWS))+1;
        TDBGrid(FObject).DataSource.Dataset.EnableControls;
        TDBGrid(FObject).DataSource.Dataset.GotoBookmark( bookmark );
        TDBGrid(FObject).DataSource.Dataset.FreeBookmark( bookmark )
      end
   end
end;

function  TMercDBGrid.ColCountEx() :Integer ;
begin
    Result :=TDBGrid(FObject).FieldCount;
end;


  function TMercDBGrid.GetStringFromTField(Field: TField):String;
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


function TMercDBGrid.CellDataEx(row, col: Longint):string ;
  var
  T: TField;
  clmn: TColumn;
  bookmark: TBookmark;
  iRes: Integer;
  begin
     dec (col);       // the first colume is #1
     if (col<0) then exit;
     try
        begin
      if Assigned(TDBGrid(FObject).DataSource) then
       if Assigned(TDBGrid(FObject).DataSource.Dataset) then
       begin
       // if ( dgIndicator in TDBGrid(FObject).Options ) then
          if ( row = 0 ) then
             begin
              clmn := TDBGrid(FObject).Columns[Integer(col)];
              Result := StringToWRTitleString (clmn.Title.Caption);
             end
          else
            begin
            bookmark := TDBGrid(FObject).DataSource.Dataset.GetBookmark;
            TDBGrid(FObject).DataSource.Dataset.DisableControls;
            TDBGrid(FObject).DataSource.Dataset.First;
 			iRes:= TDBGrid(FObject).DataSource.Dataset.MoveBy(Integer(row - 1));

            // Check the range of rows and cols return the empty string, if the cell doesn't exist
            if((iRes = Integer(row - 1)) and
            	(TCustomDBGrid(FObject).FieldCount > Integer(col))) then
 	           begin
		            T := TCustomDBGrid(FObject).Fields[Integer(col)];
		            Result := GetStringFromTField(T);
	            end
            else
            	Result:= '';

            TDBGrid(FObject).DataSource.Dataset.EnableControls;
            TDBGrid(FObject).DataSource.Dataset.GotoBookmark( bookmark );
            TDBGrid(FObject).DataSource.Dataset.FreeBookmark( bookmark );
         end;
        end; // if Assigned(TDBGrid(obj).DataSource.Dataset)

  end; // try
  except
  end;
  end;


function TMercDBGrid.ToRowDrawGridIdx( row_str:string ): Longint;
var
row:Longint;
begin
 Result :=-1;
 if (row_str[1]<>'#') then exit;
 row_str[1]:=' ';
 row :=mystrtoint(row_str);
 if (row<0) then exit;

 //TDBGrid(FObject).DataSource.Dataset.DisableControls;
 TDBGrid(FObject).DataSource.Dataset.First;
 TDBGrid(FObject).DataSource.Dataset.MoveBy(row - 1);
 //TDBGrid(FObject).DataSource.Dataset.EnableControls;
 Result :=TDrawGrid(FObject).row;
end;

function TMercDBGrid.GetSelectedRowEx():Integer ;
var
bookmark: TBookmark;
begin
  bookmark := TDBGrid(FObject).DataSource.Dataset.GetBookmark;
  TDBGrid(FObject).DataSource.Dataset.DisableControls;
  Result := Abs(TDBGrid(FObject).DataSource.Dataset.MoveBy(-MAXROWS)) + 1;
  TDBGrid(FObject).DataSource.Dataset.EnableControls;
  TDBGrid(FObject).DataSource.Dataset.GotoBookmark( bookmark );
  TDBGrid(FObject).DataSource.Dataset.FreeBookmark( bookmark );
end;

function TMercDBGrid.CaptureTableEx(filename:string): boolean;
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
   if Assigned(TDBGrid(FObject).DataSource) then
     if Assigned(TDBGrid(FObject).DataSource.Dataset) then
       begin
            num_cols := TCustomDBGrid(FObject).FieldCount;
            line:='';
            for i:=1 to num_cols do
                 line := line+ CellDataEx(0,i) + #9;
            line:=copy (line,1,Length(line)-1);  // remove the lest #9
            Writeln(F, line);

            bookmark := TDBGrid(FObject).DataSource.Dataset.GetBookmark;
            TDBGrid(FObject).DataSource.Dataset.DisableControls;
            TDBGrid(FObject).DataSource.Dataset.First;
            while ( (not TDBGrid(FObject).DataSource.Dataset.EOF)) do
              begin
              line:='';
                  for i:=0 to num_cols-1 do
                  begin
                   T := TCustomDBGrid(FObject).Fields[i];
                   line := line + GetStringFromTField(T)+ #9;
                  end;
              line:=copy (line,1,Length(line)-1);  // remove the lest #9
              Writeln(F, line);
              TDBGrid(FObject).DataSource.Dataset.Next;
              end;
            TDBGrid(FObject).DataSource.Dataset.EnableControls;
            TDBGrid(FObject).DataSource.Dataset.GotoBookmark( bookmark );
            TDBGrid(FObject).DataSource.Dataset.FreeBookmark( bookmark );
     end; // if Assigned(TDBGrid(obj).DataSource.Dataset)
finally
CloseFile(F);
end; // try
end;

function  TMercDBGrid.GetNotSupportObjectEx(obj:TObject;propname:string): TObject;
var
idx,idx2,n:Integer;
s:string;
begin
n:=-1;
idx:=pos('[',propname);
 if (idx>0) then
 begin
  idx2:=pos(']',propname);
  s:=Copy(propname,idx+1,idx2-idx-1);
  Delete(propname,idx,Length(propname));
  n:=mystrtoint(s);
 end;
 try
 begin
  if (UpperCase(propname)='ITEMS') then Result:=TDBGridColumns(Obj).items[n]
  else Result := nil;
 end;
 except
 Result := nil;
 end;
end;

//////////////////////////////////////////////////////
//   implementation for TDBGridInplaceEdit
/////////////////////////////////////////////////////
var
GLestMecrString:string;
function  TMercDBGridInplaceEdit.Get_Recording() :string ;
  var
  Msg: TMessage;
  S:string;
  p:TPoint;
  begin
  Result :='';// 'TMercDBGridInplaceEdit '+FParam[1]+'; Msg'+FParam[2]+';'+FParam[3]+';'+FParam[4] ;
  if (not (GetMessageParm(Msg))) then exit;

  if ( Msg.Msg=WM_SETFOCUS) then
  begin
     GLestMecrString:=TCustomMaskEdit(FObject).Text;
     exit;
  end;


  if ( Msg.Msg=WM_KILLFOCUS) then
  begin
  s:=TCustomMaskEdit(FObject).Text;
  if (s<>GLestMecrString) then
     begin
     Result := 'dlph_edit_set ("%m","'+s+'")';
     end;
  end;

 if ( Msg.Msg=WM_LBUTTONUP) then
     begin
     p.x:=LOWORD(Msg.lParam);
     p.y:=HIWORD(Msg.lParam);
     s:=inttostr(p.x)+', '+ inttostr(p.y);
     Result := 'obj_mouse_click ("%m", '+s+')';
     end;
end;

function  TMercDBGridInplaceEdit.Get_MercDesc()  :string ;
var
name:string;
begin
   name:=GetObjectProperty(FObject,'parent.name');
   Result:='{class: object,MSW_class: TDBGridInplaceEdit,dlph_parent: '+name+',tag: "'+name+'.Cell"}';
end;

function  TMercDBGridInplaceEdit.GetMercTag() :string ;
begin
     Result :=GetObjectProperty(FObject,'parent.name');
     Result := Result+'.Cell';
end;

//////////////////////////////////////////////////////
//   implementation for TPopupListbox
/////////////////////////////////////////////////////

function  TMercPopupListbox.GetItemFromPoint(p:TPoint) :string ;
var
ItemNo : Integer;
begin
Result:='';
ItemNo := TCustomListBox(FObject).ItemAtPos(p, True);
if (ItemNo >= 0) then
    begin
    Result:=TCustomListBox(FObject).Items[ItemNo];
    end;
end;
function  TMercPopupListbox.Get_Recording() :string ;
var
Msg: TMessage;
p:TPoint;
s:string;
begin
  if (not (GetMessageParm(Msg))) then exit;
  Result :='';// 'TMercPopupListbox-> '+FParam[1]+'; Msg'+FParam[2]+';'+FParam[3]+';'+FParam[4] ;
  if ( Msg.Msg=WM_LBUTTONDOWN) then
     begin
     p.x:=LOWORD(Msg.lParam);
     p.y:=HIWORD(Msg.lParam);
     s:=GetItemFromPoint(p);
     Result := 'dlph_list_select_item ("%m","'+s+'")';
     end;
end;

function  TMercPopupListbox.Get_MercDesc()  :string ;
var
name:string;
obj:TObject;
begin
   obj:= TWinControl(FObject).Owner;
   name:=GetObjectProperty(obj,'parent.name');
   Result:='{class: object,MSW_class: TDBGridInplaceEdit,dlph_parent: '+name+',tag: "'+name+'.Cell"}';
end;

function  TMercPopupListbox.Get_MercHandle():HWND ;
var
obj:TWinControl;
begin
obj:=TWinControl( TWinControl(FObject).Owner);
Result:= obj.handle;
end;

function TMercPopupListbox.ItemToIndex(item:string):Integer;
var
Count,i:Integer;
begin
Result:=-1;
if (item[1]='#') then
   begin
      item[1]:=' ';
      Result :=mystrtoint(item)-1;
      exit;
   end;

Count := TCustomListBox(FObject).Items.Count;
for i:=0 to count do
    if (TCustomListBox(FObject).Items[i]=item) then
        begin
            Result:=i;
            Exit;
        end;

end;

function TMercPopupListbox.Get_ItemPoint() :string ;
var
item:string;
R:TRect;
ItemNo : Integer;
p1,p2:TPOINT;
begin
Result:='0;0';
item:=FParam[1];
ItemNo:=ItemToIndex(item);
if (ItemNo<0) then exit;
r:=TCustomListBox(FObject).ItemRect(ItemNo);
if ( (r.Left=0) and (r.Top=0)and (r.Right=0) and (r.Bottom=0)) then exit;
p1.x:=r.Left;
p1.y:=r.Top;
p2:=TControl(FObject).ClientToScreen(p1);
Result:= inttostr(p2.x)+';'+ inttostr(p2.y)
end;

//////////////////////////////////////////////////////
//   implementation for TStringGrid
/////////////////////////////////////////////////////
function TMercStringGrid.CellDataEx(row, col: Longint):string ;
begin
Result :=TStringGrid(FObject).Cells[col,row];
if (row=0) then Result:=StringToWRTitleString(Result);
end;

//////////////////////////////////////////////////////
//   implementation for TDBLookupComboBox
/////////////////////////////////////////////////////

function TMercDBLookupComboBox.Get_Text() :string ;
begin
Result :=TDBLookupComboBox(FObject).Text;
end;

function TMercDBLookupComboBox.Get_MercEOF() :Boolean ;
begin
try
 begin
 Result :=TDBLookupComboBox(FObject).ListSource.Dataset.EOF
 end; // try
 except
 Result :=FALSE;
 end;

end;

function  TMercDBLookupComboBox.GetAdditionalAllPropertyNameEx(var Count: Integer): string;
begin
 Result := 'Text;';
 Count:=1;
end;


//////////////////////////////////////////////////////
//   implementation for TDBLookupListBox
/////////////////////////////////////////////////////
function  TMercDBLookupListBox.Get_Recording() :string ;
  var
  Msg: TMessage;
  S:string;
  begin
  Result :='';//'TMercDBLookupListBox '+FParam[1]+'; Msg'+FParam[2]+';'+FParam[3]+';'+FParam[4] ;
  if (not (GetMessageParm(Msg))) then exit;
  if ( Msg.Msg=WM_LBUTTONUP) then
     begin
     S:=TDBLookupListBox(FObject).SelectedItem;
     Result := 'dlph_list_select_item ("%m","'+s+'")';
     end;

end;

function  TMercDBLookupListBox.Get_MercHandle():HWND ;
var
obj:TWinControl;
begin
if (FObject.InheritsFrom(TPopupDataList)) then  //TPopupDataList
   obj:=TWinControl( TWinControl(FObject).Owner)
else
   obj:=TWinControl(FObject);
   Result:= obj.handle;
end;

function TMercDBLookupListBox.Get_Text() :string ;
begin
Result :=TDBLookupListBox(FObject).SelectedItem;
end;

function  TMercDBLookupListBox.GetAdditionalAllPropertyNameEx(var Count: Integer): string;
begin
 Result := 'Text;';
 Count:=1;
end;

//////////////////////////////////////////////////////
//   implementation for TMercPanel
/////////////////////////////////////////////////////


function  TMercPanel.Get_Recording() :string ;
  var
  Msg: TMessage;
  p,offset:TPoint;
  S,S2:string;
  begin
  Result :='';//'TMercPanel '+FParam[1]+'; Msg'+FParam[2]+';'+FParam[3]+';'+FParam[4] ;
  if (not (GetMessageParm(Msg))) then exit;
  if ( Msg.Msg=WM_LBUTTONDOWN) then
     begin
     p.x:=LOWORD(Msg.lParam);
     p.y:=HIWORD(Msg.lParam);
     s:=GetObjectFromPoint(p,offset);
     s2:=inttostr(offset.x)+','+ inttostr(offset.y);
     if (Length(s)>0) then Result := 'dlph_panel_button_press ("%m","'+s+'",'+s2+')';
     end;
end;

function  TMercPanel.GetObjectFromPoint(p:TPoint;var offset:TPoint) :string ;
var
Control:TMicControlWrapper;
p2:TPoint;
begin
 Result :='';
 Control:=TMicControlWrapper(TWinControl(FObject).ControlAtPos(p,TRUE));

 if (Control<> nil ) then
 begin
  Result := Control.name;
  if (Result='') then
    Result:=Control.Caption;
    if (Result='') then
        Result:=GetControlIndex(control);
   
  // record #index
  // control.
  //  TMercPanel.Get_ControlRect() check replay fiunction and C the obj coordinates.
  // see if i can get the property from theer
  p2:=TWinControl(FObject).ClientToScreen(p);
  offset:=Control.ScreenToClient(p2);
  end;

end;

function  TMercPanel.GetControlIndex(objControl:TMicControlWrapper) :string ;
var
Control:TMicControlWrapper;
i:Integer;
index:Integer;
begin
// FObject live object
// casting to TWinControl(FObject)
index := 0;
for i:=0 to TWinControl(FObject).ControlCount-1 do
 begin
 Control:=TMicControlWrapper(TWinControl(FObject).Controls[i]);
 If (Control.Visible) then
  if (TMicControlWrapper(TWinControl(FObject).Controls[i])= objControl) then
    begin
       Result := '#' + inttostr(index);
       exit;
    end;
    index := index + 1;
 end;

end;


function  TMercPanel.Get_ControlRect() :string ;
var
Controlname, ItemName:string;
Control:TMicControlWrapper;
rect:TRect;
i:integer;
itemIndex,index:integer;
begin
Result :='';
Controlname:=FParam[1];

itemIndex :=-1;
if (Controlname[1]='#') then
   begin
      Controlname[1]:=' ';
      itemIndex := mystrtoint(Controlname);
   end;
index := 0;
for i:=0 to TWinControl(FObject).ControlCount-1 do
 begin
 Control:=TMicControlWrapper(TWinControl(FObject).Controls[i]);
 If (Control.Visible) then
  if (index = itemIndex) then
  begin
     rect:=Control.BoundsRect;
     Result :=inttostr(rect.Left)+';'+ inttostr(rect.Top)+';'+inttostr(rect.Right)+';'+inttostr(rect.Bottom)+';;';
     exit;
  end;
  index := index + 1;
 end;

for i:=0 to TWinControl(FObject).ControlCount-1 do
 begin
 Control:=TMicControlWrapper(TWinControl(FObject).Controls[i]);
 ItemName:='';
 ItemName:=Control.name;
 If (ItemName='') then
  ItemName:=Control.Caption;
 if (ItemName=Controlname) then
    begin
    rect:=Control.BoundsRect;
    Result :=inttostr(rect.Left)+';'+ inttostr(rect.Top)+';'+inttostr(rect.Right)+';'+inttostr(rect.Bottom)+';;';
    exit;
    end;
 end;

end;

initialization
  MercUnitManger.AddUnit(@CreateMercObject);
finalization


end.
