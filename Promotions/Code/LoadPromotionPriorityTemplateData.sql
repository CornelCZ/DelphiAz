truncate table #PriorityTemplate
truncate table #SiteTemplate
truncate table #PriorityTemplateOrder

insert #PriorityTemplate
  select  Id, Name, AutoPriorityModeId
  from ac_PromotionPriorityTemplate
  where Id = @TemplateID

insert #SiteTemplate
  select SiteID 
  from ac_SitePriorityTemplate
  where PriorityTemplateId = @TemplateID

insert #PriorityTemplateOrder
  select pto.TemplateID, pto.PromotionID, pto.Priority
  from ac_PromotionPriorityTemplateOrder pto
  join Promotion_Repl p
  on pto.PromotionId = p.PromotionID
  where TemplateId = @TemplateID
  and p.SiteCode = @siteCode