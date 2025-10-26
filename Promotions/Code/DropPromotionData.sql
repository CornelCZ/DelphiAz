SET NOCOUNT ON

DROP TABLE #Promotion
DROP TABLE #PromotionModTime

DROP TABLE #PromotionException
DROP TABLE #PromotionExceptionEventStatus
DROP TABLE #PromotionExceptionSalesArea
DROP TABLE #PromotionExceptionTimeCycles

DROP TABLE #PromotionPrices
DROP TABLE #PromotionSaleGroup
DROP TABLE #PromotionSaleGroupDetail
DROP TABLE #PromotionSalesArea
DROP TABLE #PromotionSalesAreaRewardPrice
DROP TABLE #PromotionEventStatus
DROP TABLE #PromotionTimeCycles
DROP TABLE #PromotionTimeCycles_saved
DROP TABLE #PromotionPortionPriceMapping


if object_id('tempdb..#promotionexceptionaddproducts') is not null
  DROP TABLE #promotionexceptionaddproducts
if object_id('tempdb..#promotionexceptionremoveproducts') is not null
  DROP TABLE #promotionexceptionremoveproducts

if object_id('tempdb..#PromotionSaleGroupDetailWithExceptions') is not null
  DROP TABLE #PromotionSaleGroupDetailWithExceptions

SET NOCOUNT OFF