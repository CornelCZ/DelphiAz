unit uProductTagFilterFrame;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, uTagSelection, uTag, ADODB, uDataTree, uBaseTagFilterFrame;

type
  TProductTagFilterFrame = class(TBaseTagFilterFrame)
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

function TProductTagFilterFrame.ItemName: string;
begin
  Result := 'Product';
end;

function TProductTagFilterFrame.ItemTreeLevel: integer;
begin
  Result := 3;
end;

function TProductTagFilterFrame.TagType: TTagContext;
begin
  Result := tcProduct;
end;

function TProductTagFilterFrame.SQLToSelectFilteredIds: string;
begin
  Result :=
    'SELECT cast((EntityCode - 10000000000.0) as int) ' +
    'FROM Products ' +
    'WHERE ISNULL(Deleted, ''N'') = ''N'' AND ' +
      'EntityCode IN ( ' +
        'SELECT pt.EntityCode  ' +
        'FROM ProductTag pt ' +
         'JOIN #Tags t ON pt.TagId = t.TagId ' +
        'GROUP BY pt.EntityCode ' +
        'HAVING COUNT(pt.TagId) = (SELECT COUNT(TagId) from #Tags))'
end;

end.
