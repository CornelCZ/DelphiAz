set nocount on

create table #BillFooterOverride
(
  [Id] int,
  [Name] varchar(40),
  [Description] varchar(250)
)

create table #BillFooterTextOverride
(
  [LineNumber] smallint,
  [Alignment] smallint,
  [Text] nvarchar(40),
  [Bold] bit DEFAULT 0,
  [DoubleWidth] bit DEFAULT 0,
  [DoubleHeight] bit DEFAULT (0)
)

declare @BillFooterID int
set @BillFooterID = @BillFooterID_in

if (@BillFooterID = -1)
	insert #BillFooterOverride
	select -1, '', ''
else
	insert #BillFooterOverride
	select [ID], [Name], [Description]
	from ThemeBillFooterOverride
	where ID = @BillFooterID

declare @LineCount integer
declare @Generator table (Line integer)
set @LineCount = 15 
 
insert @Generator values(1) 
while @@ROWCOUNT > 0 
begin 
  insert @Generator
  select g.Line + sub.MaxRowNum from @Generator g
  cross join 
  (select MAX(Line) as MaxRowNum from @Generator) sub
  where
    g.line <= @LineCount - sub.MaxRowNum
end

insert #BillFooterTextOverride (LineNumber, Alignment, [Text], Bold, DoubleWidth, DoubleHeight)
select g.Line, (select Id from ThemeAlignLookup where value = 'Centre'), '', 0, 0, 0
from @Generator g
 
update #BillFooterTextOverride
  set
    Alignment = a.Alignment,
    Text = a.Text,
    Bold = a.Bold,
    DoubleWidth = a.DoubleWidth,
    DoubleHeight = a.DoubleHeight
from
  (select LineNumber, Alignment, [Text], Bold, DoubleWidth, DoubleHeight
   from ThemeBillFooterOverrideText
   where FooterID = @BillFooterID) a
where #BillFooterTextOverride.LineNumber = a.LineNumber

set nocount off
