delete ac_PromotionPriorityTemplateOrder
where TemplateId = @TemplateID

update ac_SitePriorityTemplate
set PriorityTemplateId = 1
where PriorityTemplateId = @TemplateID

update ac_PromotionPriorityTemplate
set Deleted = 1
where Id = @TemplateID