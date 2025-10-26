SET NOCOUNT ON

update #PromotionalFooter set Id = -1
update #PromotionalFooterSalesArea set PromotionalFooterID = -1
update #PromotionalFooterSaleGroup set PromotionalFooterID = -1
update #PromotionalFooterSaleGroupDetail set PromotionalFooterID = -1
update #PromotionalFooterSaleGroupDetail_temp set PromotionalFooterID = -1

SET NOCOUNT OFF
