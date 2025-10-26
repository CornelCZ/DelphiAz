unit uSiteTagFilterFrame;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, uTagSelection, uTag, ADODB, uDataTree, uBaseTagFilterFrame;

type
  TSiteTagFilterFrame = class(TBaseTagFilterFrame)
  private
  protected
    function ItemName: string; override;
    function ItemTreeLevel: integer; override;
    function TagType: TTagContext; override;
    function SQLToSelectFilteredIds: string; override;
  public
  end;

implementation

{$R *.dfm}

function TSiteTagFilterFrame.ItemName: string;
begin
  Result := 'Site';
end;

function TSiteTagFilterFrame.ItemTreeLevel: integer;
begin
  Result := 2;
end;

function TSiteTagFilterFrame.TagType: TTagContext;
begin
  Result := tcSite;
end;

function TSiteTagFilterFrame.SQLToSelectFilteredIds: string;
begin
  Result :=
    'SELECT Id FROM ac_Site ' +
    'WHERE Deleted = 0 AND ' +
    '  Id IN (' +
          'SELECT st.SiteID ' +
          'FROM ac_SiteTag st ' +
          ' JOIN #Tags t ON st.TagId = t.TagId ' +
          'GROUP BY st.SiteID ' +
          'HAVING COUNT(st.TagId) = (SELECT COUNT(TagId) from #Tags))';
end;



end.
