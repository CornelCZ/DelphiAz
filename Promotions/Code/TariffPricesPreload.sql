SET NOCOUNT OFF

declare @StartDate smalldatetime 
set @StartDate = ROUND(convert(float, GetDate()-(select [rollover time] from timeout)), 0, 1) 

update SABands set CurrentBand = FutureBand, 
  FutureBand = NULL,
  DateOfChange = NULL,
  LMDT = getDate(),
  ModifiedBy = 'Future-To-Current',
  SentToTills = 0 
  where DateOfChange <= @StartDate

insert SABands 
(SalesAreaCode, SubCategoryCode, CurrentBand, LMDT, ModifiedBy)
select [Sales Area Code], [Index No], NULL, getDate(), 'StartUp'
from SalesArea sa, SubCateg sc
where SA.Deleted is NULL and sc.Deleted is NULL
and not exists (select * from SABands where SalesAreaCode = SA.[Sales Area Code]
                and SubCategoryCode = sc.[Index No])

delete from SABands
where not exists
  (select [Sales Area Code], [Index No]
   from SalesArea sa, SubCateg sc
   where SA.Deleted is NULL and sc.Deleted is NULL
   and SABands.SalesAreaCode = SA.[Sales Area Code]
   and SABands.SubCategoryCode = sc.[Index No])

if OBJECT_ID('tempdb..##ProductNameCache') is not null drop table ##ProductNameCache 

create table ##ProductNameCache (
  EntityCode bigint not null,
  [Extended RTL Name] varchar(50), 
  primary key (EntityCode)
)
insert ##ProductNameCache (EntityCode, [Extended RTL Name]) 
  select EntityCode, [Extended Rtl Name] 
  from products 
  where (Deleted <> 'Y' or Deleted is null)


if OBJECT_ID('tempdb..##TariffPriceCache') is not null drop table ##TariffPriceCache

create table ##TariffPriceCache (
	SalesAreaCode Int not null,
	ProductID     BigInt not null,
	PortionTypeID Int not null,
	TariffPrice   Money null
)

insert ##TariffPriceCache
exec sp_DelayTariffPrices @StartDate

alter table ##TariffPriceCache add primary key clustered ([SalesAreaCode], [ProductID], [PortionTypeID])


SET NOCOUNT OFF