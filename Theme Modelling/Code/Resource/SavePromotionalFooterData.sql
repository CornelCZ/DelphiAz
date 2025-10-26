SET NOCOUNT ON

update #PromotionalFooter set Id = @PromotionalFooterID where Id = -1
update #PromotionalFooterSaleGroup set PromotionalFooterID = @PromotionalFooterID where PromotionalFooterID = -1
update #PromotionalFooterSalesArea set PromotionalFooterID = @PromotionalFooterID where PromotionalFooterID = -1
update #PromotionalFooterPromotionTriggers set PromotionalFooterID = @PromotionalFooterID where PromotionalFooterID = -1
--update #PromotionalFooterTimeCycles set PromotionalFooterID = @PromotionalFooterID where PromotionalFooterID = -1

if exists (select * from PromotionalFooter where id = @PromotionalFooterID)
  update PromotionalFooter
    set
      Name = tp.Name,
      Description = tp.Description,
      Priority = tp.Priority,
      SeparateFromReceipt = tp.SeparateFromReceipt,
      PrintFrequency = tp.PrintFrequency,
      Status = tp.Status,
      StartDate = tp.StartDate,
      EndDate = tp.EndDate,
      Barcode = tp.Barcode,
      EPoSNotificationText = tp.EPoSNotificationText,
      PrintMultipleFooters = tp.PrintMultipleFooters,
	  PrintWithSlipType = tp.PrintWithSlipType,
	  CampaignID = case when tp.PrintVoucherCode = 1 then tp.CampaignID	else null end
  from (select * from #PromotionalFooter) tp
  where PromotionalFooter.Id = @PromotionalFooterID
else
  insert PromotionalFooter
  select Id, Name, [Description], [Priority], SeparateFromReceipt, PrintFrequency, [Status],
      StartDate, EndDate, Barcode, EPoSNotificationText, PrintMultipleFooters, PrintWithSlipType, case when PrintVoucherCode = 1 then CampaignID	else null end as CampaignID
 from #PromotionalFooter

-- save footer text
DECLARE @PrintVoucerCode bit
SELECT  @PrintVoucerCode = PrintVoucherCode from #PromotionalFooter pf where pf.ID = @PromotionalFooterID

DELETE PromotionalFooterText WHERE PromotionalFooterID = @PromotionalFooterID

INSERT PromotionalFooterText
SELECT @PromotionalFooterID, pft.*
FROM #PromotionalFooterText pft
WHERE (ISNULL([Text],'') <> '') or (AppendSurveyCode = 1) or ((AppendVoucherCode = 1) and (@PrintVoucerCode = 1))
-- end of footer text save

delete PromotionalFooterSalesArea where PromotionalFooterID = @PromotionalFooterID

insert PromotionalFooterSalesArea 
select distinct PromotionalFooterID, SalesAreaID, AllowSiteFooterOverride 
from #PromotionalFooterSalesArea 

--Match prospective product groups to pre-existing groups (if any)
if OBJECT_ID('tempdb.dbo.#TempProductGrouping') IS NOT NULL
  drop table [#TempProductGrouping]

create table #TempProductGrouping
(
  GroupingType smallint NOT NULL,
  GroupingTypeTargetId bigint NOT NULL
)

declare @SaleGroupId int
declare @ProductGrouping int
declare SaleGroupCursor cursor for 
select SaleGroupId
from #PromotionalFooterSaleGroup

open SaleGroupCursor
fetch next from SaleGroupCursor into @SaleGroupId

while @@FETCH_STATUS = 0 
begin
  delete from #TempProductGrouping
   
  insert #TempProductGrouping
  select GroupingType, GroupingtypetargetId
  from #PromotionalFooterSaleGroupDetail
  where SaleGroupId = @SaleGroupId  
   
  exec spGetProductGrouping @ProductGrouping OUT

  update #PromotionalFooterSaleGroup                                                 
  set ProductGroupingId = @ProductGrouping
  where SaleGroupId = @SaleGroupId
  
  fetch next from SaleGroupCursor into @SaleGroupId
end

close SaleGroupCursor
deallocate SaleGroupCursor

delete PromotionalFooterSaleGroup where PromotionalFooterId = @PromotionalFooterID

insert PromotionalFooterSaleGroup select * from #PromotionalFooterSaleGroup

DECLARE @NewTimeCycles TABLE (DisplayOrder tinyint, TimeCycleId bigint)
DECLARE @DisplayOrder tinyint, @TimeCycleId bigint, @ValidDays varchar(7), @StartTime datetime, @EndTime datetime

DECLARE NewTimeCycles CURSOR LOCAL STATIC FORWARD_ONLY READ_ONLY FOR
SELECT DisplayOrder, ValidDays, dbo.fn_TimeFromDateTime(StartTime), dbo.fn_TimeFromDateTime(EndTime)
FROM #PromotionalFooterTimeCycles ORDER BY DisplayOrder

OPEN NewTimeCycles
FETCH NEXT FROM NewTimeCycles INTO @DisplayOrder, @ValidDays, @StartTime, @EndTime

WHILE (@@Fetch_Status = 0)
BEGIN
  EXEC Theme_GetTimeCycle @ValidDays, @StartTime, @EndTime, @TimeCycleId OUTPUT

  INSERT @NewTimeCycles
  SELECT @DisplayOrder, @TimeCycleId
  WHERE @TimeCycleId NOT IN (SELECT TimeCycleId FROM @NewTimeCycles)

  FETCH NEXT FROM NewTimeCycles INTO @DisplayOrder, @ValidDays, @StartTime, @EndTime
END

CLOSE NewTimeCycles
DEALLOCATE NewTimeCycles

delete PromotionalFooterTimeCycles where PromotionalFooterId = @PromotionalFooterID

INSERT PromotionalFooterTimeCycles
SELECT @PromotionalFooterId, TimeCycleId, DisplayOrder
FROM @NewTimeCycles

-- Delete existing promotion trigger if promotionFooterID has changed (new record will be inserted in next step)
DELETE PromotionalFooterPromotionTriggers
  WHERE PromotionID IN (	SELECT pfpt.PromotionID as ID
							FROM PromotionalFooterPromotionTriggers pfpt
							INNER JOIN #PromotionalFooterPromotionTriggers temp
							ON pfpt.PromotionID = temp.PromotionID
							WHERE pfpt.PromotionalFooterId <> temp.PromotionalFooterId )

-- - add new records & newly altered records
INSERT INTO PromotionalFooterPromotionTriggers (PromotionalFooterId, PromotionID)
	SELECT temp.PromotionalFooterID, temp.PromotionID 
			FROM #PromotionalFooterPromotionTriggers temp
			LEFT OUTER JOIN PromotionalFooterPromotionTriggers pfpt
			ON temp.PromotionID = pfpt.PromotionID
			WHERE pfpt.PromotionalFooterID IS NULL

-- then delete removed records
DELETE PromotionalFooterPromotionTriggers 
  WHERE PromotionID IN (	SELECT pfpt.PromotionID as ID
							FROM PromotionalFooterPromotionTriggers pfpt
							LEFT OUTER JOIN #PromotionalFooterPromotionTriggers temp
							ON pfpt.PromotionID = temp.PromotionID
							WHERE temp.PromotionalFooterID IS NULL)

SET NOCOUNT OFF