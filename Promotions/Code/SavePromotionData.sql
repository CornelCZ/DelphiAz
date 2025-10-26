/*-- remove invalid exception settings depending on whether this is an event or a promotion
if (select PromoTypeID from #Promotion) = 4
  update #PromotionException set StartDate = null, EndDate = null, TimeCycleID = null, ChangeEndDate = 0
else
  delete #PromotionExceptionEventStatus*/

SET NOCOUNT ON

SET DEADLOCK_PRIORITY LOW

BEGIN TRY
	declare @SiteCode int = dbo.fnGetSiteCode()

  update #Promotion set PromotionID = @PromotionID, SiteCode = @SiteCode where PromotionID = -1
  update #PromotionSaleGroup set PromotionID = @PromotionID, SiteCode = @SiteCode where PromotionID = -1
  update #PromotionSaleGroupDetail set PromotionID = @PromotionID, SiteCode = @SiteCode where PromotionID = -1
  update #PromotionPrices set PromotionID = @PromotionID, SiteCode = @SiteCode where PromotionID = -1
  update #PromotionSalesArea set PromotionID = @PromotionID, SiteCode = @SiteCode where PromotionID = -1
  update #PromotionSalesAreaRewardPrice set PromotionID = @PromotionID, SiteCode = @SiteCode where PromotionID = -1
  update #PromotionException set PromotionID = @PromotionID, SiteCode = @SiteCode where PromotionID = -1
  update #PromotionEventStatus set PromotionID = @PromotionID, SiteCode = @SiteCode where PromotionID = -1
  update #PromotionEventStatus set EnabledPromotionID = @PromotionID, SiteCode = @SiteCode where EnabledPromotionID = -1
  update #PromotionPortionPriceMapping Set PromotionID = @PromotionID, SiteCode = @SiteCode where PromotionID = -1

  -- Timed promotions have an implicit sale group quantity
  -- of 1.  Set it as such if we based this timed promo on another
  -- type that could have had a sale group quantity > 1
  if (select PromoTypeID from #promotion) = 1
          update #PromotionSaleGroup set Quantity = 1


  BEGIN TRANSACTION

  -- IMPORTANT The stored proc RefreshSitePrices relies on the fact that Promotion.LMDT is updated whenever any aspect
  -- of a promotion is edited. So, if you are tempted to remove this delete/reinsert of the Promotion record make sure
  -- you still update the LMDT! GDM 24/09/2015

  -- First, we need to disable the foreign key on the table which has one to Promotion - note that most other tables involving promotion
  -- don't have foreign keys to make this process easier...  
  ALTER TABLE ac_PromotionPriorityTemplateOrder NOCHECK CONSTRAINT FK_PromotionPriorityTemplateOrder_Promotion

  delete Promotion where PromotionId = @PromotionID

  -- The delete above cascaded to various detail tables.  As a consequence
  -- the after insert/update trigger on PromotionSaleGroup will not work correctly
  -- if we do not repopulate the PromotionSalesArea table first.
  insert Promotion select * from #Promotion

  -- reenable foreign key
  ALTER TABLE ac_PromotionPriorityTemplateOrder CHECK CONSTRAINT FK_PromotionPriorityTemplateOrder_Promotion

  insert PromotionSalesArea select * from #PromotionSalesArea 
  insert PromotionSaleGroup select * from #PromotionSaleGroup
  insert PromotionSaleGroupDetail select * from #PromotionSaleGroupDetail

  update #PromotionPrices set Price=TariffPrice where Price is null

  -- remove price entry prices that match tariff price
  if (select PromoTypeID from #Promotion) = 4
    delete #PromotionPrices where TariffPrice = Round(Price, 2)
  -- don't save any calculated prices
  insert PromotionPrices
  (SiteCode, PromotionID, SaleGroupID, ProductID, PortionTypeID, SalesAreaID, Price)
  select @SiteCode, PromotionID, SaleGroupID, ProductID, PortionTypeID, SalesAreaID, Round(Price, 2)
  from #PromotionPrices where SaleGroupID in (select SaleGroupID from #PromotionSaleGroup
  where RememberCalculation = 0)

  insert PromotionSalesAreaRewardPrice select * from #PromotionSalesAreaRewardPrice
  insert PromotionEventStatus select * from #PromotionEventStatus
  insert PromotionException select * from #PromotionException
  insert PromotionExceptionSalesArea select * from #PromotionExceptionSalesArea
  insert PromotionExceptionEventStatus select * from #PromotionExceptionEventStatus

  --Only push portion-price mappings back into the table if they are for suitable
  --calculation types i.e. Price/Value Increase/Decrease
  insert PromotionPortionPriceMapping
  select pppm.* from #PromotionPortionPriceMapping pppm
  join #PromotionSaleGroup psg
  on psg.PromotionID = pppm.PromotionId and psg.SaleGroupId = pppm.SaleGroupId
  where psg.CalculationType between 1 and 4

  -- Save any promotion time cycle changes that are held in #PromotionTimeCycles. Note if the valid days and start\end time
  -- haven't been changed the call to stored proc Theme_GetTimeCycle will return the same TimeCycleId as is already
  -- being used.
  DECLARE @NewTimeCycles TABLE (DisplayOrder tinyint, TimeCycleId bigint)
  DECLARE @DisplayOrder tinyint, @TimeCycleId bigint, @ValidDays varchar(7), @StartTime datetime, @EndTime datetime

  DECLARE NewTimeCycles CURSOR LOCAL STATIC FORWARD_ONLY READ_ONLY FOR
  SELECT DisplayOrder, ValidDays, dbo.fn_TimeFromDateTime(StartTime), dbo.fn_TimeFromDateTime(EndTime)
  FROM #PromotionTimeCycles ORDER BY DisplayOrder

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

  INSERT PromotionTimeCycles
  SELECT @SiteCode, @PromotionId, TimeCycleId, DisplayOrder
  FROM @NewTimeCycles
	
  -- Save any exception time cycle changes that are held in #PromotionExceptionTimeCycles.
  DECLARE @NewExceptionTimeCycles TABLE (SiteCode int, ExceptionId bigint, DisplayOrder tinyint, TimeCycleId bigint)
  DECLARE @ExceptionId bigint, @ExceptionSiteCode int

  DECLARE NewExceptionTimeCycles CURSOR LOCAL STATIC FORWARD_ONLY READ_ONLY FOR
  SELECT SiteCode, ExceptionId, DisplayOrder, ValidDays, dbo.fn_TimeFromDateTime(StartTime), dbo.fn_TimeFromDateTime(EndTime)
  FROM #PromotionExceptionTimeCycles ORDER BY DisplayOrder

  OPEN NewExceptionTimeCycles
  FETCH NEXT FROM NewExceptionTimeCycles INTO @ExceptionSiteCode, @ExceptionId, @DisplayOrder, @ValidDays, @StartTime, @EndTime

  WHILE (@@Fetch_Status = 0)
  BEGIN
    EXEC Theme_GetTimeCycle @ValidDays, @StartTime, @EndTime, @TimeCycleId OUTPUT

    INSERT @NewExceptionTimeCycles
    SELECT @ExceptionSiteCode, @ExceptionId, @DisplayOrder, @TimeCycleId
    WHERE NOT EXISTS
       (SELECT * FROM @NewExceptionTimeCycles WHERE ExceptionId = @ExceptionId AND SiteCode = @ExceptionSiteCode AND TimeCycleId = @TimeCycleId)

    FETCH NEXT FROM NewExceptionTimeCycles INTO @ExceptionSiteCode, @ExceptionId, @DisplayOrder, @ValidDays, @StartTime, @EndTime
  END

  CLOSE NewExceptionTimeCycles
  DEALLOCATE NewExceptionTimeCycles

  INSERT PromotionExceptionTimeCycles
  SELECT @SiteCode, ExceptionId, TimeCycleId, DisplayOrder
  FROM @NewExceptionTimeCycles

  COMMIT TRANSACTION

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
  EXEC ac_spRethrowError -- Re raise the error so that it gets back to the Delphi runtime.
END CATCH

SET DEADLOCK_PRIORITY NORMAL

SET NOCOUNT OFF