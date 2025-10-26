SET NOCOUNT ON

IF OBJECT_ID('TempDB..#SiteFootersWithOverrides') IS NOT NULL
  DROP TABLE [#SiteFootersWithOverrides]

IF OBJECT_ID('TempDB..#SiteFooterOverrides') IS NOT NULL
  DROP TABLE [#SiteFooterOverrides]

IF OBJECT_ID('TempDB..#SalesAreaOverrideMappings') IS NOT NULL
  DROP TABLE [#SalesAreaOverrideMappings]

CREATE TABLE #SiteFootersWithOverrides
(
  [PromotionalFooterID] [int] NOT NULL,
  [FooterName] Varchar(40) NOT NULL
  PRIMARY KEY (PromotionalFooterId)
)

CREATE TABLE #SiteFooterOverrides
(
  [PromotionalFooterID] [int] NOT NULL,
  [OverrideID] [int] NOT NULL,
  [OverrideName] Varchar(40) NOT NULL
--  PRIMARY KEY (PromotionalFooterId, OverrideID)
)

CREATE TABLE #SalesAreaOverrideMappings
(
  [PromotionalFooterID] [int] NOT NULL,
  [SalesAreaID] [int] NOT NULL,
  [OverrideID] [int] NOT NULL,
  [SalesAreaName] Varchar(20)
  PRIMARY KEY (PromotionalFooterId, SalesAreaID)
)

INSERT #SiteFootersWithOverrides
SELECT DISTINCT p.ID, p.Name
FROM SitePromotionalFooterOverride o
INNER JOIN PromotionalFooter p 
  ON p.ID = o.PromotionalFooterID
LEFT OUTER JOIN PromotionalFooterSalesArea s
  ON s.PromotionalFooterID = p.ID
WHERE p.[Status] = 0
AND s.AllowSiteFooterOverride = 1
AND p.Name IS NOT NULL

INSERT #SiteFooterOverrides
SELECT a.PromotionalFooterID, a.OverrideID, a.OverrideName FROM
(
  SELECT DISTINCT PromotionalFooterID, OverrideID, OverrideName
  FROM SitePromotionalFooterOverride
  UNION
  SELECT DISTINCT PromotionalFooterID, 0 AS OverrideID,
    'Default' AS OverrideName
  FROM SitePromotionalFooterOverride
) a JOIN #SiteFootersWithOverrides sfo ON sfo.PromotionalFooterID = a.PromotionalFooterID
WHERE sfo.FooterName IS NOT NULL


INSERT #SalesAreaOverrideMappings
SELECT a.PromotionalFooterID, a.SalesAreaID, a.OverrideID, s.Name AS SalesAreaName 
FROM
(
  -- first get all sales area allowed to have overrides but not yet set
  SELECT DISTINCT 
    p.PromotionalFooterID, 0 AS OverrideID, p.SalesAreaID
  FROM PromotionalFooterSalesArea p
  WHERE p.SalesAreaID NOT IN 
    (SELECT s.SalesAreaID
     FROM SitePromotionalFooterOverrideSAMap s
     WHERE s.PromotionalFooterID = p.PromotionalFooterID
     AND s.SalesAreaID = p.SalesAreaID)
  AND p.AllowSiteFooterOverride = 1
  UNION
  -- next get all sales areas that have overrides but exclude those no longer allowed 
  -- to have overrides
  SELECT DISTINCT m.PromotionalFooterID, m.OverrideID, m.SalesAreaID
  FROM SitePromotionalFooterOverrideSAMap m
  WHERE m.SalesAreaID IN
    (SELECT p2.SalesAreaID
     FROM PromotionalFooterSalesArea p2
     WHERE p2.PromotionalFooterID = m.PromotionalFooterID
     AND p2.AllowSiteFooterOverride = 1)
) a LEFT OUTER JOIN ac_SalesArea s
  ON a.SalesAreaID = s.ID JOIN #SiteFootersWithOverrides sfo ON sfo.PromotionalFooterID = a.PromotionalFooterID
WHERE sfo.FooterName IS NOT NULL 

SET NOCOUNT OFF
