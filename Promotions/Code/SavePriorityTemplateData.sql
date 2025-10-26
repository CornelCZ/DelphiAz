MERGE ac_PromotionPriorityTemplate AS TARGET
USING #PriorityTemplate AS SOURCE
ON TARGET.Id = SOURCE.Id
WHEN MATCHED AND (SOURCE.Name <> TARGET.Name OR SOURCE.AutoPriorityModeId <> TARGET.AutoPriorityModeId) THEN
UPDATE SET TARGET.Name = SOURCE.Name, TARGET.AutoPriorityModeId = SOURCE.AutoPriorityModeId
WHEN NOT MATCHED BY TARGET THEN
INSERT (Id, Name, AutoPriorityModeId)
VALUES (SOURCE.Id, SOURCE.Name, SOURCE.AutoPriorityModeId);

MERGE ac_SitePriorityTemplate AS TARGET
USING #SiteTemplate AS SOURCE
ON TARGET.SiteID = SOURCE.SiteID 
WHEN MATCHED AND TARGET.PriorityTemplateID <> @TemplateID THEN
UPDATE set TARGET.PriorityTemplateID = @TemplateID
WHEN NOT MATCHED BY SOURCE AND TARGET.PriorityTemplateID = @TemplateID THEN
UPDATE set TARGET.PriorityTemplateID = 1
--This last one shouldn't happen, but added for safety
WHEN NOT MATCHED BY TARGET THEN
INSERT (SiteId, PriorityTemplateID)
VALUES (SOURCE.SiteID, @TemplateID);

MERGE ac_PromotionPriorityTemplateOrder AS TARGET
USING #PriorityTemplateOrder AS SOURCE
ON TARGET.PromotionID = SOURCE.PromotionID AND TARGET.TemplateID = @TemplateID
WHEN MATCHED AND TARGET.Priority <> SOURCE.Priority THEN
UPDATE set TARGET.Priority = SOURCE.Priority
WHEN NOT MATCHED BY TARGET THEN
INSERT (TemplateID, PromotionID, Priority)
VALUES (@TemplateID, SOURCE.PromotionID, SOURCE.Priority);

