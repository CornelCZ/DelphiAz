SET NOCOUNT ON

DELETE SitePromotionalFooterOverrideSAMap
FROM SitePromotionalFooterOverrideSAMap o
INNER JOIN #SalesAreaOverrideMappings m
  ON o.PromotionalFooterID = m.PromotionalFooterID
    AND o.SalesAreaID = m.SalesAreaID 
WHERE m.OverrideID = 0

DELETE SitePromotionalFooterOverrideSAMap
FROM SitePromotionalFooterOverrideSAMap o
INNER JOIN #SalesAreaOverrideMappings m
  ON o.PromotionalFooterID = m.PromotionalFooterID
    AND o.SalesAreaID = m.SalesAreaID 
WHERE m.OverrideID <> o.OverrideID

INSERT SitePromotionalFooterOverrideSAMap
SELECT DISTINCT a.SiteID, s.PromotionalFooterID, s.OverrideID, s.SalesAreaID
FROM ac_SalesArea a RIGHT OUTER JOIN #SalesAreaOverrideMappings s
  ON a.ID = S.SalesAreaID
WHERE NOT EXISTS
  (SELECT m.*
   FROM SitePromotionalFooterOverrideSAMap m
   WHERE m.PromotionalFooterID = s.PromotionalFooterID
   AND m.OverrideID = s.OverrideID
   AND m.SalesAreaID = s.SalesAreaID)
AND s.OverrideID <> 0

SET NOCOUNT OFF
