SET NOCOUNT ON

update #Promotion set PromotionID = -1
update #PromotionSaleGroup set PromotionID = -1
update #PromotionSaleGroupDetail set PromotionID = -1
update #PromotionPrices set PromotionID = -1
update #PromotionSalesArea set PromotionID = -1
update #PromotionSalesAreaRewardPrice set PromotionID = -1
update #PromotionEventStatus set PromotionID = -1 where PromotionID = @PromotionID
update #PromotionEventStatus set EnabledPromotionID = -1 where EnabledPromotionID = @PromotionID
update #PromotionException set PromotionID = -1
update #PromotionPortionPriceMapping set PromotionID = -1

SET NOCOUNT OFF