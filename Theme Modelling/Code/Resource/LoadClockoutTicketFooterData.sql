set nocount on

create table #ClockoutTicketFooterOverride
(
  [ID] int,
  [Name] varchar(40),
  [Description] varchar(250)
)

create table #ClockoutTicketFooterTextOverride
(
  [LineNumber] smallint,
  [LineType] tinyint,
  [Text] nvarchar(40),
  [Bold] bit DEFAULT 0,
  [DoubleSize] bit DEFAULT 0,
  [LineNumberSeq] int--,
  --primary key(LineNumber, LineType)
)

declare @ClockoutTicketFooterID int
set @ClockoutTicketFooterID = @ClockoutTicketFooterID_in

if (@ClockoutTicketFooterID = -1)
	insert #ClockoutTicketFooterOverride
	select -1, '', ''
else
	insert #ClockoutTicketFooterOverride
	select [ID], [Name], [Description]
	from ThemeClockOutTicketFooterOverride
	where ID = @ClockoutTicketFooterID

--If we are creating a new footer then base it upon the default version
if (@ClockoutTicketFooterID = -1)
	set @ClockoutTicketFooterID = 1

insert #ClockoutTicketFooterTextOverride
select LineNumber, LineType, [Text], Bold, DoubleSize, null
from ThemeClockOutTicketFooterTextOverride 
where OverrideId = @ClockoutTicketFooterID

--Put in the blanks required for the 'top' part of the footer
declare @MaxId int
select @MaxId = max(LineNumber) from #ClockoutTicketFooterTextOverride where LineType = 0
if @MaxId > 0 
begin
	;with CTE as (
			select 1 as LineNumber
			union all
			select LineNumber + 1 from CTE where LineNumber < @MaxID
			)
	
	insert #ClockoutTicketFooterTextOverride ([LineNumber], [LineType], [Text], [Bold], [DoubleSize])
	select cte.LineNumber, 0, null, 0, 0 from CTE
	left join #ClockoutTicketFooterTextOverride t on t.LineNumber = CTE.LineNumber and t.LineType = 0
	where t.LineNumber is null
end

--Put in the blanks required for the 'bottom' part of the footer
select @MaxId = max(LineNumber) from #ClockoutTicketFooterTextOverride where LineType = 2
if @MaxId > 0 
begin
	;with CTE as (
			select 1 as LineNumber
			union all
			select LineNumber + 1 from CTE where LineNumber < @MaxID
			)
	insert #ClockoutTicketFooterTextOverride ([LineNumber], [LineType], [Text], [Bold], [DoubleSize])
	select cte.LineNumber, 2, null, 0, 0 from CTE
	left join #ClockoutTicketFooterTextOverride t on t.LineNumber = CTE.LineNumber and t.LineType = 2
	where t.LineNumber is null
end



set nocount off
