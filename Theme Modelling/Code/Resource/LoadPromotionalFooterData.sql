set nocount on

create table #PromotionalFooter
(
  Id int not null,
  Name varchar(40) not null,
  [Description] varchar(256) null,
  Priority int not null,
  SeparateFromReceipt bit not null default 0,
  PrintFrequency int not null default 0,
  [Status] int not null,
  StartDate datetime not null,
  EndDate datetime null,
  Barcode varchar(25) null,
  EPoSNotificationText varchar(50) null,
  PrintMultipleFooters bit not null default 0,
  PrintWithSlipType tinyint not null default 1,
  PrintVoucherCode bit not null default 0,		
  CampaignID int null,
  primary key(Id)
)

insert #PromotionalFooter
select Id, Name, [Description], [Priority], SeparateFromReceipt, PrintFrequency, [Status], StartDate, EndDate,
  Barcode, EPoSNotificationText, PrintMultipleFooters, PrintWithSlipType, case when CampaignID is null then 0 else 1 end as PrintVoucherCode, CampaignID
from PromotionalFooter
where Id = @PromotionalFooterID

--select LMDT
--into #PromotionalFooterModTime
--from PromotionalFooter_repl
--where Id = @PromotionalFooterID

create table #PromotionalFooterSalesArea
(
	[PromotionalFooterId] [int] NOT NULL,
	[SalesAreaId] [int] NOT NULL,
	[AllowSiteFooterOverride] [bit] NOT NULL default (1),
  primary key(PromotionalFooterId, SalesAreaId)
)

insert #PromotionalFooterSalesArea
select p.PromotionalFooterID, p.SalesAreaID, p.AllowSiteFooterOverride
from PromotionalFooterSalesArea p
left outer join ac_salesarea s on p.SalesAreaID = s.[ID]
where p.PromotionalFooterID = @PromotionalFooterID and s.[id] is not null

create table #PromotionalFooterSaleGroup
(
  PromotionalFooterID int NOT NULL,
  SaleGroupID smallint NOT NULL,
  Name varchar(30) NULL,
  SaleGroupType tinyint NOT NULL,
  Value float NOT NULL,
  ProductGroupingId int NOT NULL,
  primary key (PromotionalFooterID, SaleGroupID) 
)

insert #PromotionalFooterSaleGroup
select *
from PromotionalFooterSaleGroup
where PromotionalFooterId = @PromotionalFooterID

create table #PromotionalFooterSaleGroupDetail
(
  PromotionalFooterId int NOT NULL,
  SaleGroupId smallint NOT NULL,
  GroupingType tinyint NOT NULL,
  GroupingTypeTargetId bigint NOT NULL,
  primary key (PromotionalFooterId, SaleGroupId, GroupingType, GroupingTypeTargetId) 
) 

--Load a temporary version of the rationalised product selections...
select pfsg.PromotionalFooterId, pfsg.SaleGroupId, pg.GroupingType, pg.GroupingTypeTargetId
into #PromotionalFooterSaleGroupDetail_temp
from ProductGrouping pg
join PromotionalFooterSaleGroup pfsg
on pfsg.ProductGroupingId = pg.Id
where pfsg.PromotionalFooterId = @PromotionalFooterId

--...and then flatten them into a list of portion inclusions for the 
--initial tree view loading.
--Add in portion inclusions
insert #PromotionalFooterSaleGroupDetail
select t.PromotionalFooterId, t.SaleGroupId, t.GroupingType, t.GroupingTypeTargetId
from #PromotionalFooterSaleGroupDetail_temp t
where t.GroupingType = 4

--Add in product inclusions
insert #PromotionalFooterSaleGroupDetail
select t.PromotionalFooterId, t.SaleGroupId, t.GroupingType, d.Level5Id
from #PromotionalFooterSaleGroupDetail_temp t
join ##ProductTree_Data d
on t.GroupingTypeTargetId - 10000000000 = d.Level4Id
where t.GroupingType = 3

--Add in sub-category inclusions
insert #PromotionalFooterSaleGroupDetail
select t.PromotionalFooterId, t.SaleGroupId, t.GroupingType, d.Level5Id
from #PromotionalFooterSaleGroupDetail_temp t
join ##ProductTree_Data d
on t.GroupingTypeTargetId = d.Level3Id
where t.GroupingType = 2

--Add in category inclusions
insert #PromotionalFooterSaleGroupDetail
select t.PromotionalFooterId, t.SaleGroupId, t.GroupingType, d.Level5Id
from #PromotionalFooterSaleGroupDetail_temp t
join ##ProductTree_Data d
on t.GroupingTypeTargetId = d.Level2Id
where t.GroupingType = 1

--Add in division inclusions
insert #PromotionalFooterSaleGroupDetail
select t.PromotionalFooterId, t.SaleGroupId, t.GroupingType, d.Level5Id
from #PromotionalFooterSaleGroupDetail_temp t
join ##ProductTree_Data d
on t.GroupingTypeTargetId = d.Level1Id
where t.GroupingType = 0

-- get footer text
create table #PromotionalFooterText(
	[LineNumber] [smallint] NOT NULL, 
	[Text] [nvarchar](40) NULL, 
	[Bold] [bit] NOT NULL, 
	[DoubleSize] [bit] NOT NULL,
	[AppendSurveyCode] [bit] NOT NULL,
	[AppendVoucherCode] [bit] NOT NULL,
	primary key([LineNumber]) 
)

--Build a table with line numbers 
declare @LineCount integer
declare @Generator table (Line integer)
set @LineCount = 30 
 
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

insert #PromotionalFooterText (LineNumber, Text, Bold, DoubleSize, AppendSurveyCode, AppendVoucherCode)
select g.Line, '', 0, 0, 0, 0
from @Generator g
 
update #PromotionalFooterText
  set
    Text = a.Text,
    Bold = a.Bold,
    DoubleSize = a.DoubleSize,
    AppendSurveyCode = a.AppendSurveyCode,
		AppendVoucherCode = a.AppendVoucherCode
from
  (select LineNumber, Text, Bold, DoubleSize, AppendSurveyCode, AppendVoucherCode
   from PromotionalFooterText
   where PromotionalFooterID = @PromotionalFooterID) a
where #PromotionalFooterText.LineNumber = a.LineNumber

create table #SitePromotionalFooterOverride(
	[SiteCode] [int] NOT NULL,
	[OverrideID] [int] NOT NULL,
	[OverrideName] varchar(100) NOT NULL,
	primary key([SiteCode], [OverrideID])
)

create table #SitePromotionalFooterTextOverride(
	[SiteCode] [int] NOT NULL,
	[OverrideID] [int] NOT NULL,
	[LineNumber] [smallint] NOT NULL,
	[Text] [nvarchar](40) NULL, 
	[Bold] [bit] NOT NULL, 
	[DoubleSize] [bit] NOT NULL,
	[AppendSurveyCode] [bit] NOT NULL,
	[AppendVoucherCode] [bit] NOT NULL,
	primary key([SiteCode], [OverrideID], [LineNumber])
)

create table #SitePromotionalFooterOverrideSAMap(
	[SiteCode] int NOT NULL,
	[OverrideID] int NOT NULL,
	[SalesAreaID] int NOT NULL,
	primary key([SiteCode], [OverrideID], [SalesAreaID]) 
)

if @LoadSiteData = 1
begin
	insert #SitePromotionalFooterOverride([SiteCode], [OverrideID], [OverrideName])
	select SiteCode, OverrideID, OverrideName
	from SitePromotionalFooterOverride
	where PromotionalFooterID = @PromotionalFooterID

	insert #SitePromotionalFooterTextOverride ([SiteCode], [OverrideID], [LineNumber], [Bold], [DoubleSize], [AppendSurveyCode], [AppendVoucherCode])
	select spfto.[SiteCode], spfto.[OverrideID], g.Line, 0, 0, 0, 0
	from (select distinct [SiteCode], [OverrideID]
				from SitePromotionalFooterTextOverride
				where PromotionalFooterID = @PromotionalFooterID) spfto
	cross join @Generator g

	update #SitePromotionalFooterTextOverride
		set 
			Text = a.Text,
			Bold = IsNull(a.Bold,0),
			DoubleSize = IsNull(a.DoubleSize,0),
			AppendSurveyCode = IsNull(a.AppendSurveyCode,0),
			AppendVoucherCode = ISNull(a.AppendVoucherCode,0)
	from
		(select [SiteCode], [OverrideID], LineNumber, Text, Bold, DoubleSize, AppendSurveyCode, AppendVoucherCode
		 from SitePromotionalFooterTextOverride 
		 where PromotionalFooterID = @PromotionalFooterID) a 
	where #SitePromotionalFooterTextOverride.[OverrideID] = a.[OverrideID]
	and #SitePromotionalFooterTextOverride.LineNumber = a.LineNumber
	and #SitePromotionalFooterTextOverride.SiteCode = a.SiteCode

	insert #SitePromotionalFooterOverrideSAMap (SiteCode, OverrideID, SalesAreaID)
	select SiteCode, OverrideID, SalesAreaID
	from SitePromotionalFooterOverrideSAMap sa
	where sa.PromotionalFooterID = @PromotionalFooterID
end
-- end of footer text

create table #PromotionalFooterTimeCycles (
  DisplayOrder int identity(1,1) primary key,
  ValidDays varchar(7),
  StartTime datetime,
  EndTime datetime)

create table #PromotionalFooterTimeCycles_saved (
  DisplayOrder int primary key,
  ValidDays varchar(7),
  StartTime datetime,
  EndTime datetime)

set identity_insert #PromotionalFooterTimeCycles on

insert #PromotionalFooterTimeCycles (DisplayOrder, ValidDays, StartTime, EndTime)
select a.DisplayOrder, b.ValidDays, b.StartTime, b.EndTime
from PromotionalFooterTimeCycles a
     inner join ThemeTimeCycle b on a.TimeCycleId = b.TimeCycleId
where a.PromotionalFooterId = @PromotionalFooterID

set identity_insert #PromotionalFooterTimeCycles off

create table #PromotionalFooterPromotionTriggers (
  PromotionalFooterID int,
  PromotionID bigint,
  OriginalPromotionalFooterID int,
  primary key(PromotionalFooterID, PromotionID)
)

insert #PromotionalFooterPromotionTriggers (PromotionalFooterID, PromotionID, OriginalPromotionalFooterID) 
select PromotionalFooterID, PromotionID, PromotionalFooterID
from PromotionalFooterPromotionTriggers a

if @PromotionalFooterID = -1
begin
  insert #PromotionalFooter
  (Id, Name, Description, Priority, SeparateFromReceipt, PrintFrequency, Status, StartDate, EndDate, BarCode, EPoSNotificationText, PrintMultipleFooters, PrintWithSlipType, CampaignID)
  select -1, '', '', 0, 0, 0, 0, convert(int, getdate()), null, null, '', 0, 1, null
end

set nocount off
