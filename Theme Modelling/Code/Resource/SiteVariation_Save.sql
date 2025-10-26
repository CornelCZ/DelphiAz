SET NOCOUNT ON

BEGIN TRY
  DECLARE @EffectiveDate datetime = <EffectiveDate>

  IF OBJECT_ID('tempdb..#ThemeSiteVariation') IS NOT NULL
    DROP TABLE #ThemeSiteVariation

  CREATE TABLE #ThemeSiteVariation(
    [SiteCode] int NOT NULL,
    [PanelID] int NOT NULL,
    [VariationPanelName] varchar(50) NOT NULL,
    [VariationPanelID] int NULL,
    PRIMARY KEY ([SiteCode], [PanelID]))

  INSERT #ThemeSiteVariation (SiteCode, PanelId, VariationPanelName)
  SELECT SiteCode, PanelId, VariationPanelName
  FROM #EditSiteVariations
     UNPIVOT
       (VariationPanelName FOR PanelId IN (<CrosstabColumnList>)) x

  UPDATE a
  SET VariationPanelId = ISNULL(b.VariationPanelId, -1)
  FROM #ThemeSiteVariation a
    LEFT JOIN #VariationPanelLookup b
      ON a.PanelId = b.ParentPanelId AND a.VariationPanelName = b.VariationPanelName
	
	--The UNPIVOT does not respect NULLs so we need to reinject any records that have
	--had their variation panel unassigned.  VariationPanelName not important at this point.
	INSERT #ThemeSiteVariation (SiteCode, PanelId, VariationPanelName, VariationPanelID)
	SELECT tsv.SiteCode, tsv.PanelID, '<n/a>', -1
	FROM ThemeSiteVariation tsv 
	LEFT JOIN #ThemeSiteVariation tsv_temp
		ON tsv.SiteCode = tsv_temp.SiteCode AND tsv.PanelID = tsv_temp.PanelID
	WHERE tsv.VariationPanelID <> -1 AND tsv_temp.SiteCode IS NULL

  DELETE #themesitevariation
  FROM #themesitevariation edit
  JOIN (
    SELECT tsv.* FROM ThemeSiteVariation tsv
    JOIN (
      SELECT sitecode, panelid, max(effectivedate) as effectivedate
      FROM ThemeSiteVariation
      WHERE effectivedate = @EffectiveDate
      GROUP BY sitecode, panelid
    ) sub1 ON tsv.sitecode = sub1.sitecode AND tsv.panelid = sub1.panelid AND tsv.effectivedate = sub1.effectivedate
  ) sub2 ON edit.sitecode = sub2.sitecode AND edit.panelid = sub2.panelid AND edit.variationpanelid = sub2.variationpanelid


  BEGIN TRANSACTION

  DELETE ThemeSiteVariation
  FROM ThemeSiteVariation a
  JOIN #ThemeSiteVariation b
    ON a.sitecode = b.sitecode AND a.panelid = b.panelid AND a.effectivedate = @EffectiveDate

  DELETE #themesitevariation
  FROM #themesitevariation edit
  JOIN (
    SELECT tsv.* FROM ThemeSiteVariation tsv
    JOIN (
      SELECT sitecode, panelid, max(effectivedate) as effectivedate
      FROM ThemeSiteVariation
      WHERE effectivedate < @EffectiveDate
      GROUP BY sitecode, panelid
    ) sub1 ON tsv.sitecode = sub1.sitecode AND tsv.panelid = sub1.panelid AND tsv.effectivedate = sub1.effectivedate
  ) sub2 ON edit.sitecode = sub2.sitecode AND edit.panelid = sub2.panelid AND edit.variationpanelid = sub2.variationpanelid


  -- Delete rows from master table that represent a future change *after* the effective date to the same panel. In other
  -- words the temp table row is bringing forward this existing future change.
  DELETE ThemeSiteVariation
  FROM ThemeSiteVariation tsv
  JOIN (
    SELECT sitecode, panelid, MIN(Effectivedate) as Effectivedate
    FROM ThemeSiteVariation
    WHERE Effectivedate > @EffectiveDate
    GROUP BY SiteCode, PanelId
  ) sub1 ON tsv.sitecode = sub1.sitecode AND tsv.panelid = sub1.panelid AND tsv.effectivedate = sub1.effectivedate
  JOIN #themesitevariation edit
    ON tsv.sitecode = edit.sitecode AND tsv.panelid = edit.panelid AND tsv.variationpanelid = edit.variationpanelid


  INSERT ThemeSiteVariation (SiteCode, PanelId, EffectiveDate, VariationPanelId)
  SELECT SiteCode, PanelId, @EffectiveDate, VariationPanelId
  FROM #ThemeSiteVariation

  TRUNCATE TABLE #EditSiteVariations_Backup
  INSERT #EditSiteVariations_Backup SELECT * FROM #EditSiteVariations

  COMMIT TRANSACTION

  DROP TABLE #ThemeSiteVariation
END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
  ROLLBACK TRANSACTION
  EXEC ac_spRethrowError
END CATCH

SET NOCOUNT OFF
