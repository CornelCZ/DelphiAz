SET NOCOUNT ON

IF OBJECT_ID('tempdb..#Promotion') IS NOT NULL
  drop table #Promotion

IF OBJECT_ID('tempdb..#PromotionModTime') IS NOT NULL
  drop table #PromotionModTime

IF OBJECT_ID('tempdb..#PromotionSaleGroup') IS NOT NULL
drop table #PromotionSaleGroup

IF OBJECT_ID('tempdb..##PromotionSaleGroupDetail') IS NOT NULL
  drop table #PromotionSaleGroupDetail

IF OBJECT_ID('tempdb..#PromotionPortionPriceMapping') IS NOT NULL
  drop table #PromotionPortionPriceMapping

IF OBJECT_ID('tempdb..#PromotionEventStatus') IS NOT NULL
  drop table #PromotionEventStatus

IF OBJECT_ID('tempdb..#PromotionPrices') IS NOT NULL
  drop table #PromotionPrices

IF OBJECT_ID('tempdb..#PromotionSalesArea') IS NOT NULL
  drop table #PromotionSalesArea

IF OBJECT_ID('tempdb..#PromotionTimeCycles') IS NOT NULL
  drop table #PromotionTimeCycles

IF OBJECT_ID('tempdb..#PromotionTimeCycles_saved') IS NOT NULL
  drop table #PromotionTimeCycles_saved

IF OBJECT_ID('tempdb..#PromotionException') IS NOT NULL
  drop table #PromotionException

IF OBJECT_ID('tempdb..#PromotionExceptionSalesArea') IS NOT NULL
  drop table #PromotionExceptionSalesArea

IF OBJECT_ID('tempdb..#PromotionExceptionEventStatus') IS NOT NULL
  drop table #PromotionExceptionEventStatus

IF OBJECT_ID('tempdb..#PromotionExceptionTimeCycles') IS NOT NULL
  drop table #PromotionExceptionTimeCycles

IF OBJECT_ID('tempdb..#PromotionSalesAreaRewardPrice') IS NOT NULL
  drop table #PromotionSalesAreaRewardPrice

IF OBJECT_ID('tempdb..#PromSaleGroupNulls') IS NOT NULL
  drop table #PromSaleGroupNulls



select *
into #Promotion
from Promotion
where PromotionId = @PromotionID

select LMDT 
into #PromotionModTime
from Promotion_Repl
where PromotionId = @PromotionID

select *
into #PromotionSaleGroup
from PromotionSaleGroup
where PromotionID = @PromotionID

create table #PromotionSaleGroupDetail (
  SiteCode int NOT NULL,
  PromotionID bigint NOT NULL,
  SaleGroupID smallint NOT NULL,
  ProductID bigint NOT NULL,
  PortionTypeID smallint NOT NULL,
  primary key (PromotionID, SaleGroupID, ProductID, PortionTypeID)
)

insert #PromotionSaleGroupDetail
(SiteCode, PromotionID, SaleGroupID, ProductID, PortionTypeID)
select *
from PromotionSaleGroupDetail
where PromotionID = @PromotionID

--Note the use of 'default -1' on the PromotionID.  This is used to circumvent the longstanding issue
--in the Delphi ADO implementation whereby a TLargeIntField cannot accept a -ve value.  If an attempt is
--made to do so the user is greeted by the opaque 'multiple-step operation generated errors. Check each status value.'
--error at runtime.  The alternative is to remove the longstanding convention of representing
--new promotions as having a -1 PromotionID.  See SavePromotionData.SQL for the pattern. Ideally we should remove the PromotionId
--column from all the temp tables used by the wizard.
create table #PromotionPortionPriceMapping (
  SiteCode int NOT NULL,
  PromotionID bigint NOT NULL DEFAULT -1,
  SaleGroupID smallint NOT NULL,
	SourcePortionTypeId smallint NOT NULL,
	TargetPortionTypeId smallint NOT NULL,
	CalculationType smallint NOT NULL,
	CalculationValue float NOT NULL,
  primary key (PromotionID, SaleGroupID, SourcePortionTypeId, TargetPortionTypeId)
)

insert #PromotionPortionPriceMapping
(SiteCode, PromotionID, SaleGroupID, SourcePortionTypeId, TargetPortionTypeId, CalculationType, CalculationValue)
select *
from PromotionPortionPriceMapping
where PromotionID = @PromotionID

select *
into #PromotionEventStatus
from PromotionEventStatus
where PromotionID = @PromotionID or EnabledPromotionID = @PromotionID

create table #PromotionPrices (
  SiteCode int NOT NULL,
  PromotionID bigint NOT NULL,
  SaleGroupID smallint NOT NULL,
  ProductID bigint NOT NULL,
  PortionTypeID smallint NOT NULL,
  SalesAreaID smallint NOT NULL,
  TariffPrice money null,
  Price money NULL,
)

-- Need a clustered index rather than PK to allow ignore_dup_key.
-- The ignore_dup_key attribute makes the queries to update rows in #PromotionPrices simpler. The rows we want to recalculate are
-- first deleted and then we can have an insert query that inserts all data not having to worry about keyviolations.
create unique clustered index IX_PromotionPrices on #PromotionPrices
(SiteCode, PromotionID, SaleGroupID, ProductID, PortionTypeID, SalesAreaID)
with IGNORE_DUP_KEY

insert #PromotionPrices
(SiteCode, PromotionID, SaleGroupID, ProductID, PortionTypeID, SalesAreaID, Price)
select * from PromotionPrices
where PromotionID = @PromotionID

select a.*
into #PromotionSalesArea
from PromotionSalesArea a
left outer join salesarea on SalesAreaID = [Sales Area Code]
where PromotionID = @PromotionID and salesarea.[Sales Area Code] is not null

create table #PromotionTimeCycles (
  DisplayOrder int identity(1,1) primary key,
  ValidDays varchar(7),
  StartTime datetime,
  EndTime datetime)

create table #PromotionTimeCycles_saved (
  DisplayOrder int primary key,
  ValidDays varchar(7),
  StartTime datetime,
  EndTime datetime)

SET IDENTITY_INSERT #PromotionTimeCycles ON

insert #PromotionTimeCycles (DisplayOrder, ValidDays, StartTime, EndTime)
select a.DisplayOrder, b.ValidDays, b.StartTime, b.EndTime
from PromotionTimeCycles a
     inner join ThemeTimeCycle b on a.TimeCycleId = b.TimeCycleId
where a.PromotionId = @PromotionID

SET IDENTITY_INSERT #PromotionTimeCycles OFF

/* Exceptions */

select * 
into #PromotionException 
from PromotionException 
where PromotionID = @PromotionID

select PromotionExceptionSalesArea.* 
into #PromotionExceptionSalesArea
from PromotionException 
join PromotionExceptionSalesArea
on PromotionException.ExceptionID = PromotionExceptionSalesArea.ExceptionID and PromotionException.SiteCode = PromotionExceptionSalesArea.SiteCode
where PromotionID = @PromotionID

select PromotionExceptionEventStatus.* into #PromotionExceptionEventStatus
from PromotionException
join PromotionExceptionEventStatus
on PromotionException.ExceptionID = PromotionExceptionEventStatus.ExceptionID and PromotionException.SiteCode = PromotionExceptionEventStatus.SiteCode
where PromotionId = @PromotionID

alter table #PromotionExceptionEventStatus
add primary key (ExceptionID, EnabledPromotionID)

create table #PromotionExceptionTimeCycles (
	SiteCode int,
  ExceptionId bigint,
  DisplayOrder int,
  ValidDays varchar(7),
  StartTime datetime,
  EndTime datetime,
  TimeCicleId bigint default 0,
  primary key (ExceptionId, DisplayOrder, TimeCicleId) )

insert #PromotionExceptionTimeCycles (SiteCode, ExceptionId, DisplayOrder, ValidDays, StartTime, EndTime, TimeCicleId)
select a.SiteCode, a.ExceptionId, b.DisplayOrder, c.ValidDays, c.StartTime, c.EndTime, b.TimeCycleId

from PromotionException a
  inner join PromotionExceptionTimeCycles b on a.ExceptionId = b.ExceptionId and a.SiteCode = b.SiteCode
  inner join ThemeTimeCycle c on b.TimeCycleId = c.TimeCycleId
where a.PromotionId = @PromotionID

create table #PromotionSalesAreaRewardPrice(
  SiteCode int NOT NULL,
  PromotionID bigint NOT NULL,
  SalesAreaID smallint NOT NULL,
  RewardPrice money NULL,
  primary key (PromotionID, SalesAreaID)
)

insert #PromotionSalesAreaRewardPrice
(SiteCode, PromotionID, SalesAreaID, RewardPrice)
select *
from PromotionSalesAreaRewardPrice
where PromotionID = @PromotionID

if @PromotionID = -1
begin
  insert #Promotion
    (SiteCode, PromotionId, Name, Description, PromoTypeID, EventOnly, StartDate, FavourCustomer, HideFromCustomer, Status, CardActivated, SwipeGroupID,
     CardRating, ValidWithAllPaymentMethods, ValidWithAllDiscounts, LoyaltyPromotion, LoyaltyPointsRequired, CanIncreasePrice, GroupItemsUnderPromotion,
     ReferenceRequired, ExtendedFlag, UserSelectsProducts)
  select @SiteCode, -1, '', '', 0, 0,convert(int, getdate()), 0, 0, 0, 0, 0, 0, 0, 0, 0, null, 1, 0, 0, 0, 0

  insert #PromotionSaleGroup
  (SiteCode, PromotionID, SaleGroupID, Quantity, RecipeChildrenMode, MakeChildrenFree, RememberCalculation)
  select @SiteCode, -1, 1, 1, 0, 0, 0
end
else
begin
  while exists(
    select max(salegroupid), count(*) 
    from #PromotionSaleGroup 
    having max(salegroupid) <> count(*)
   )
  begin
    declare @Pivot int
    -- Get a sale group that doesn't exist. Must exist at least one group with (nonexistent ID)+1
    select top 1 @Pivot = (SaleGroupID-1) from #PromotionSaleGroup 
    where SaleGroupID <> 1 and not(SaleGroupID -1 in (select SaleGroupID from #PromotionSaleGroup))

    update #PromotionSaleGroup set SaleGroupID = SaleGroupID-1 where SaleGroupID > @Pivot
    update #PromotionSaleGroupDetail set SaleGroupID = SaleGroupID-1 where SaleGroupID > @Pivot
    update #PromotionPrices set SaleGroupID = SaleGroupID-1 where SaleGroupID > @Pivot
  end
end

-- remove deleted sales areas
SET NOCOUNT OFF