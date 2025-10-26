SET NOCOUNT ON

DECLARE @LastEffectiveDate datetime = <LastEffectiveDate>
DECLARE @CurrentEffectiveDate datetime =  <CurrentEffectiveDate>
DECLARE @dataAlreadyLoaded bit = 0

IF EXISTS(SELECT * FROM #EditSiteVariations)
BEGIN
  -- If no change in effective date nothing to do.
  IF (@CurrentEffectiveDate = @LastEffectiveDate)
    SET @dataAlreadyLoaded = 1

  -- If effective date later than previous but no future changes exist up to the new date - nothing to do.
  IF (@CurrentEffectiveDate > @LastEffectiveDate) AND
  NOT EXISTS(
    SELECT * FROM ThemeSiteVariation
    WHERE EffectiveDate > @LastEffectiveDate and EffectiveDate <= @CurrentEffectiveDate)
    SET @dataAlreadyLoaded = 1
END

IF @dataAlreadyLoaded = 0
BEGIN
  IF OBJECT_ID('tempdb..#EditSiteVariations_EffectiveData') IS NOT NULL
    DROP TABLE #EditSiteVariations_EffectiveData

  CREATE TABLE #EditSiteVariations_EffectiveData (
    SiteCode int NOT NULL,
    PanelId int NOT NULL,
    VariationPanelId int NOT NULL,
    PRIMARY KEY (SiteCode, PanelId))

  -- Note This query is much faster than a PARTITION BY equivalent.
  INSERT #EditSiteVariations_EffectiveData (SiteCode, PanelId, VariationPanelId)
  SELECT a.SiteCode, a.PanelId, a.VariationPanelId
  FROM ThemeSiteVariation a
    JOIN
    (
      SELECT sitecode, panelid, max(effectivedate) as effectivedate
      FROM ThemeSiteVariation
      WHERE effectivedate <= @CurrentEffectiveDate
      GROUP BY sitecode, panelid
    ) b
    ON a.sitecode = b.sitecode and a.panelid = b.panelid and a.effectivedate = b.effectivedate


  TRUNCATE TABLE #EditSiteVariations

  INSERT #EditSiteVariations (SiteCode, <CrosstabColumnList>)
  SELECT SiteCode, <CrosstabColumnSelectList>
  FROM
      (
        SELECT a.SiteCode, a.PanelId, b.Name as VariationPanelName  --VariationPanelId
        FROM #EditSiteVariations_EffectiveData a LEFT JOIN ThemePanel b on a.VariationPanelId = b.PanelId
      ) x
    PIVOT
      (
        MAX(VariationPanelName)
        FOR PanelId in (<CrosstabColumnList>)
      ) p

  UPDATE a
  SET SiteName = b.Name,
      SiteRef = b.Reference,
      AreaName = c.Name
  FROM #EditSiteVariations a
    JOIN ac_Site b ON a.SiteCode = b.Id
    JOIN ac_Area c ON b.AreaId = c.Id

  TRUNCATE TABLE #EditSiteVariations_Backup
  INSERT #EditSiteVariations_Backup SELECT * FROM #EditSiteVariations

  DROP TABLE #EditSiteVariations_EffectiveData
END

SET NOCOUNT OFF
