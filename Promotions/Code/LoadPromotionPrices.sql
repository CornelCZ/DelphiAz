-- Fill in calculated prices
-- Runs code based on spRefreshPromotionPrices, with the following changes;
--   Uses Temp tables (as for the above view)
--   Does not check promotion status
--   Uses ##TariffPriceCache rather than calling sp_TariffPrices
--   It removes prices for "remember calculation" groups but also calculates non-remembered
--   calculations, the results of which are discarded if the user has already entered prices
--   Also "calculates" prices for price entry, which are used as default values
--   PW; Also, restriction to only the current site is removed..

/* test stubs
select * into #promotion from ##promotion
select * into #PromotionSalesArea from ##promotionsalesarea
select * into #promotionsalegroup from ##promotionsalegroup
select * into #promotionsalegroupdetail from ##promotionsalegroupdetail
select * into #promotionprices from ##promotionprices
select * into #promotionexception from ##promotionexception

select * into #promotionexceptionsalesarea from ##promotionexceptionsalesarea*/

SET NOCOUNT ON

if object_id('tempdb..#LatestSelection') is not null
  DROP TABLE #LatestSelection

declare @PromotionId bigint = <PromotionId>

declare @CurrDate datetime
set @CurrDate = getdate()

-- Place the latest selection of products, sales groups and sales areas into #LatestSelection
SELECT sa.SiteCode, sa.SalesAreaID, sgd.SaleGroupID, sgd.ProductID, sgd.PortionTypeID
INTO #LatestSelection
FROM #PromotionSaleGroupDetail sgd
CROSS JOIN #PromotionSalesArea sa

-- Remove prices for products/sales areas that have been removed
DELETE #PromotionPrices
FROM #PromotionPrices pp
LEFT OUTER JOIN #LatestSelection latest ON
      pp.PromotionId = @PromotionId   -- #PromotionPrices will only contain data for one PromotionId, but including PromotionId in JOIN ensures index is used
  AND pp.SaleGroupID = latest.SaleGroupID
  AND pp.ProductID = latest.ProductID
  AND pp.PortionTypeID = latest.PortionTypeID
  AND pp.SalesAreaID = latest.SalesAreaID
WHERE latest.ProductID IS NULL

-- Remove prices for sales groups whose price must be recalculated from the tariff price
DELETE #PromotionPrices
FROM #PromotionPrices
JOIN #PromotionSaleGroup ON
  #PromotionPrices.PromotionID = #PromotionSaleGroup.PromotionID
  AND #PromotionPrices.SaleGroupID = #PromotionSaleGroup.SaleGroupID
WHERE CalculationType in (1, 2, 3, 4, 5) and RememberCalculation = 1

-- Add tariff prices
IF EXISTS(SELECT * FROM #PromotionPrices WHERE TariffPrice IS NULL)
BEGIN
  UPDATE #PromotionPrices
  SET
    #PromotionPrices.TariffPrice = IsNull(TariffPrices.TariffPrice, 0)
  FROM #PromotionPrices a
  JOIN ##TariffPriceCache TariffPrices
    ON TariffPrices.SalesAreaCode = a.SalesAreaID
    AND TariffPrices.ProductID = a.ProductID
    AND TariffPRices.PortionTypeID = a.PortionTypeID
END

-- Recalculate prices for calculation types 1-4
-- Which are...
--   1 - Price increase by fixed amount
--   2 - Price decrease by fixed amount
--   3 - Price increase by percentage
--   4 - Price decrease by percentage


-- Note that the WHERE clause in this query does not include 'and RememberCalculation = 1', whereas the WHERE clause in the
-- DELETE #PromotionPrices query above does. So you may wonder why this query does not fail with key violations when it tries
-- to insert rows for sales groups with RememberCalculation = 0.
-- The answer lies in the fact that the unique index added to #PromotionPrices by LoadPromotionData.sql uses the IGNORE_DUP_KEY
-- attribute. This causes any attempt to add a duplicate row to be ignored rather than fail the query.
-- You may then wonder how an edit to the promo price calculation for a sales group will cause the prices to be updated by this
-- query if a row already exists. The answer is that when a price calculation is edited all rows in #PromotionPrices for the
-- affected sales group are deleted by TPromotionWizard.UpdateGroupPrices()
INSERT #PromotionPrices
(SiteCode, PromotionID, SaleGroupID, ProductID, PortionTypeID, SalesAreaID, TariffPrice, Price)
select latest.SiteCode, @PromotionID, latest.SaleGroupID, latest.ProductID, latest.PortionTypeID,
  latest.SalesAreaID,
  IsNull(TariffPrice, 0),
  CASE WHEN psg.CalculationType = 1 THEN IsNull(TariffPrice, 0) + psg.CalculationValue ELSE
  CASE WHEN psg.CalculationType = 2 THEN IsNull(TariffPrice, 0) - psg.CalculationValue ELSE
  CASE WHEN psg.CalculationType = 3 THEN (IsNull(TariffPrice, 0) / 100) * (100 + psg.CalculationValue) ELSE
  (IsNull(TariffPrice, 0) / 100) * (100 - IsNull(psg.CalculationValue, 0)) END END END
from #LatestSelection latest
join #PromotionSaleGroup psg ON latest.SaleGroupID = psg.SaleGroupID
left outer join ##TariffPriceCache TariffPrices
  on TariffPrices.SalesAreaCode = latest.SalesAreaID
  and TariffPrices.ProductID = latest.ProductID
  and TariffPRices.PortionTypeID = latest.PortionTypeID
where (psg.CalculationType in (1, 2, 3, 4) or psg.CalculationType IS NULL)


--Recalculate the price based on any portion-price mappings that the user defined
update p1
set Price =
	case when m.CalculationType = 1 then IsNull(p2.Price, 0) + m.CalculationValue else
  case when m.CalculationType = 2 then IsNull(p2.Price, 0) - m.CalculationValue else
  case when m.CalculationType = 3 then (IsNull(p2.Price, 0) / 100) * (100 + m.CalculationValue) else
  (IsNull(p2.Price, 0) / 100) * (100 - IsNull(m.CalculationValue, 0)) end end end
from #PromotionPrices p1
join #PromotionPortionPriceMapping m
on m.SaleGroupID = p1.SaleGroupID and m.TargetPortionTypeID = p1.PortionTypeID
  and m.PromotionID = p1.PromotionID
join #PromotionPrices p2
on p1.PromotionID = p2.promotionId and p1.SaleGroupId = p2.SaleGroupId
	and p1.ProductID = p2.ProductID and p2.PortionTypeID = m.SourcePortionTypeID
  and p2.PortionTypeID = m.SourcePortionTypeID
  and p1.SalesAreaId = p2.SalesAreaId;

if exists (select * from #PromotionSaleGroup where CalculationType = 5)
begin;
    -- Calculate banded prices
    WITH BandedPrices (SalesAreaId, ProductId, PortionTypeID, Band, Price)
    AS
    (
        SELECT sam.SalesAreaId, x.ProductId, x.PortionTypeID, x.Band, x.Price
        FROM 
           (SELECT sa.Id as SalesAreaId, sm.Currentmatrix
            FROM ac_salesarea sa JOIN SiteMatrix sm on sa.SiteId = sm.SiteCode
            WHERE sa.Deleted = 0) sam
           JOIN
           (SELECT MatrixId, ProductId, PortionTypeId, Band, Price,
	          ROW_NUMBER() OVER(PARTITION BY MatrixId, ProductId, PortionTypeId, Band ORDER BY StartDate DESC) AS [StartDateOrder]
	        FROM PBandVal
            WHERE StartDate <= @CurrDate
              AND Deleted = 0
              AND Band IN (SELECT DISTINCT CalculationBand FROM #PromotionSaleGroup WHERE CalculationType = 5)
            ) x
            ON sam.CurrentMatrix = x.MatrixID
        WHERE StartDateOrder = 1
    )
    INSERT #PromotionPrices (SiteCode, PromotionID, SaleGroupID, ProductID, PortionTypeID, SalesAreaID, TariffPrice, Price)
    SELECT latest.SiteCode, @PromotionId, latest.SaleGroupID, latest.ProductID, latest.PortionTypeID, latest.SalesAreaID, z.Price, z.Price
    FROM #LatestSelection latest
    JOIN #PromotionSaleGroup psg ON
        latest.SaleGroupID = psg.SaleGroupID
        and psg.CalculationType = 5
    LEFT OUTER JOIN BandedPrices z ON
        z.ProductId = latest.ProductID
        AND z.PortionTypeID = latest.PortionTypeID
        AND z.SalesAreaId = latest.SalesAreaID
        AND z.Band = psg.CalculationBand;


    -- Again, if a band has been specified, but a portion does not have a price,
    -- calculate the price based on the PortionPriceFactor.
    -- Also update null prices to be zero if not already done
    WITH BandedPricesForStandardPortion (SalesAreaId, ProductId, Band, Price)
    AS
    (
        SELECT sam.SalesAreaId, x.ProductId, x.Band, x.Price
        FROM 
           (SELECT sa.Id as SalesAreaId, sm.Currentmatrix
            FROM ac_salesarea sa JOIN SiteMatrix sm on sa.SiteId = sm.SiteCode) sam
           JOIN
           (SELECT MatrixId, ProductId, Band, Price,
	          ROW_NUMBER() OVER(PARTITION BY MatrixId, ProductId, PortionTypeId, Band ORDER BY StartDate DESC) AS [StartDateOrder]
	        FROM PBandVal
            WHERE StartDate <= @CurrDate
              AND Deleted = 0
              AND PortionTypeId = 1
              AND Band IN (SELECT DISTINCT CalculationBand FROM #PromotionSaleGroup WHERE CalculationType = 5)
            ) x
            ON sam.CurrentMatrix = x.MatrixID
        WHERE StartDateOrder = 1
    )
    UPDATE #PromotionPrices
    SET Price = dbo.fn_PriceFromPriceFactor(b.Price, pt.PriceFactor),
        TariffPrice = dbo.fn_PriceFromPriceFactor(b.Price, pt.PriceFactor)
    FROM
        #PromotionPrices pp
          JOIN
        #PromotionSaleGroup psg
        ON pp.SaleGroupID = psg.SaleGroupID and psg.CalculationType = 5
          JOIN
        BandedPricesForStandardPortion b 
        ON b.Band = psg.CalculationBand and b.SalesAreaId = pp.SalesAreaID and b.ProductId = pp.ProductId
          JOIN
        ac_PortionType pt
        ON pt.Id = pp.PortionTypeID
    WHERE pp.Price IS NULL
      AND pp.PortionTypeID <> 1
end

UPDATE #PromotionPrices
SET Price = 0 where Price IS NULL
UPDATE #PromotionPrices
SET TariffPrice = 0 where TariffPrice IS NULL

if object_id('tempdb..#LatestSelection') is not null
  DROP TABLE #LatestSelection
SET NOCOUNT OFF