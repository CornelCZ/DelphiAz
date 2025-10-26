SET NOCOUNT ON

IF object_id('tempdb..<TableName>') IS NOT NULL
  DROP TABLE <TableName>

SELECT SiteCode, SiteRef, SiteName, AreaName, <CrosstabColumnSelectSafeNameList>
INTO <TableName>
FROM #EditSiteVariations
ORDER BY SiteRef ASC

SET NOCOUNT OFF
