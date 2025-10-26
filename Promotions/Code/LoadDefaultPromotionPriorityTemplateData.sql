truncate table #PriorityTemplate
truncate table #SiteTemplate
truncate table #PriorityTemplateOrder

insert #PriorityTemplate values (-1, 'New Template', 0)

insert #PriorityTemplateOrder
  select -1, PromotionID, Priority
  from ac_PromotionPriorityTemplateOrder
  where TemplateId = 1