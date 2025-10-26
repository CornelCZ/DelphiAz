unit uStructureUtils;

(*
 * Unit contains the utilities and classes for representing the structure of
 * the organization in Prizm and for manipulating trees containing that structure
 * information.
 *
 * Author: Hamish Martin, Edesix
 *)

interface

uses ComCtrls, DB;

type
  // Represents the level of an object in the organization.
  TStructureLevel = (slGlobal, slCompany, slArea, slSite, slSalesArea, slPos);

  // See function TTreeSelection.getConfigTableFilter for a description.
  FilterConfigTableOption = (rctsSelection,rctsChildren,rctsDeleted);
  FilterConfigTableOptions = set of FilterConfigTableOption;

  // Tree selection - represents a selection in the organization tree,
  // e.g. a company, a sales area, etc.
  TTreeSelection = class
    // The node in the tree control corresponding to this object.
    treeNode: TTreeNode;
    // The parent selection, e.g. the site for a sales area.  For a company, this is nil.
    parent: TTreeSelection;
    // The level of this node.
    level: TStructureLevel;
    // The code for this object - index into the company, area, site, etc. table.
    code: Integer;
    // The name of this object, as specified in the config table.
    name: string;

    // Get a SQL expression suitable for selecting just this item & or its children from
    // the config table.  The result can be used e.g. as the 'where' clause of a SQL select.
    //
    // The options can be combined to control which rows from the config table
    // will be returned by the query:
    //
    // rctsSelection - this indicates that the row corresponding to this object
    //                 will be included in the result
    // rctsChildren - this indicates that rows corresponding to children of
    //                this object will be included in the result
    // rctsDeleted - this indicates that deleted rows will be included in the
    //               result.
    function getConfigTableFilter( options: FilterConfigTableOptions ): string;
    // Sets the 'code' fields in the dataset to match this object.  E.g. if
    // called for a site, this will set the 'site code', 'area code' and
    // 'company code' columns in the table.  Config table must be in edit mode
    // before this is called.
    procedure setConfigTableCodeColumns( dataset: TDataSet );
    // Sets the 'name' fields in the dataset to match this object.  E.g. if
    // called for a site, this will set the 'site name', 'area name' and
    // 'company name' columns in the table.  Config table must be in edit mode
    // before this is called.
    procedure setConfigTableNameColumns( dataset: TDataSet );
    // Determines if this object is a child/grandchild/etc.
    // of the 'sel' node.
    function isChildOf( sel: TTreeSelection ): boolean;
  end;

  // Convert a level into a string suitable for display, e.g. 'company'
  function structureLevelToString(level: TStructureLevel): string;
  // Return the textual name of the config table column corresponding to the name
  // of a particular level, e.g. for slCompany, it returns 'company name'.
  function getConfigTableNameFieldNameForLevel( level: TStructureLevel ): string;
  // Return the textual name of the config table column corresponding to the code
  // of a particular level, e.g. for slCompany, it returns 'company code'.
  function getConfigTableCodeFieldNameForLevel( level: TStructureLevel ): string;

implementation

uses SysUtils;
 
{ TTreeSelection }

// Get a SQL expression suitable for selecting just this item & or its children from
// the config table.  The result can be used e.g. as the 'where' clause of a SQL select.
function TTreeSelection.getConfigTableFilter( options: FilterConfigTableOptions ): string;
var
  ret : string;
begin
  ret := '[' + getConfigTableCodeFieldNameForLevel( level ) + '] = ' + IntToStr( code );

  // Filtering by parent codes is not in theory necessary, but is a good idea, since it
  // allows the query to be better optimized.
  if Assigned( parent ) then
    ret := ret + ' and ' + parent.getConfigTableFilter( [rctsChildren,rctsSelection,rctsDeleted] );

  // Filter out children if necessary
  if (level <> slPos) and not (rctsChildren in options) then
    ret := ret + ' and [' + getConfigTableCodeFieldNameForLevel( Succ(level) ) + '] IS NULL';

  // Filter out the node itself if necessary
  if (level <> slPos) and not (rctsSelection in options) then
    ret := ret + ' and [' + getConfigTableCodeFieldNameForLevel( Succ(level) ) + '] IS NOT NULL';

  // Filter out deleted rows if necessary
  if not (rctsDeleted in options) then
    ret := ret + ' AND ISNULL([deleted],'''') <> ''Y''';

  Result := ret;
end;

procedure TTreeSelection.setConfigTableCodeColumns( dataset: TDataSet );
begin
  dataset.FieldByName(getConfigTableCodeFieldNameForLevel(level)).AsInteger := code;
  if Assigned( parent ) then parent.setConfigTableCodeColumns( dataset );
end;

procedure TTreeSelection.setConfigTableNameColumns;
begin
  dataset.FieldByName(getConfigTableNameFieldNameForLevel(level)).AsString := name;
  if Assigned( parent ) then parent.setConfigTableNameColumns( dataset );
end;

function TTreeSelection.isChildOf(sel: TTreeSelection): boolean;
begin
  if sel = nil then
    Result := true
  else if parent = sel then
    Result := true
  else if Ord( level ) <= Ord( sel.level ) then
    Result := false
  else
    Result := parent.isChildOf( sel );
end;


function structureLevelToString(level: TStructureLevel): string;
begin
  case level of
    slCompany: Result := 'company';
    slArea: Result := 'area';
    slSite: Result := 'site';
    slSalesArea: Result := 'sales area';
    slPos: Result := 'POS';
  else
    Result := '?';
  end;
end;

function getConfigTableNameFieldNameForLevel( level: TStructureLevel ): string;
begin
  case level of
    slCompany:
      Result := 'Company Name';
    slArea:
      Result := 'Area Name';
    slSite:
      Result := 'Site Name';
    slSalesArea:
      Result := 'Sales Area Name';
    slPos:
      Result := 'POS Name';
  end;
end;

function getConfigTableCodeFieldNameForLevel( level: TStructureLevel ): string;
begin
  case level of
    slCompany:
      Result := 'Company Code';
    slArea:
      Result := 'Area Code';
    slSite:
      Result := 'Site Code';
    slSalesArea:
      Result := 'Sales Area Code';
    slPos:
      Result := 'POS Code';
  end;
end;

end.
