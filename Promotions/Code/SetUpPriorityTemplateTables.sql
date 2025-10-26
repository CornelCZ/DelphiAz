if object_id('tempdb..#PriorityTemplate') is not null
  drop table #PriorityTemplate

if object_id('tempdb..#SiteTemplate') is not null
  drop table #SiteTemplate

if object_id('tempdb..#PriorityTemplateOrder') is not null
  drop table #PriorityTemplateOrder

create table #PriorityTemplate (
  Id integer,
  Name varchar(50),
  AutoPriorityModeId tinyint,
  Primary key (Id))

create table #SiteTemplate (
  SiteId integer,
  Primary key (SiteId))

create table #PriorityTemplateOrder (
  TemplateID integer, 
  PromotionID bigint, 
  Priority integer,
  Primary key (TemplateID, PromotionID))
