unit NTSelectionList;
{$I DEFINE.INC}

interface

Uses Windows, Classes,
{$IFDEF Delphi6}
  DesignIntf, DesignWindows;
{$ELSE}
  DsgnIntf, Dsgnwnds;
{$ENDIF}


type
{$IFDEF Delphi6}
  TNTSelectionList = class (TDesignerSelections)
  public
    function Add(const Item: TPersistent): Integer; 
{$ELSE}
  {$IFDEF Delphi5}
  TNTSelectionList = class (TDesignerSelectionList)
  {$ELSE}
  TNTSelectionList = class(TComponentList)
  {$ENDIF}
{$ENDIF}

  end;

implementation

{$IFDEF Delphi6}
function TNTSelectionList.Add(const Item: TPersistent): Integer;
begin
  Result := inherited Add(Item);
end;
{$ENDIF}

end.


