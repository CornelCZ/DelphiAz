SET NOCOUNT ON

DECLARE @UseDefaultPanel varchar(10) = <USE_DEFAULT>

IF OBJECT_ID('tempdb..#ImportErrors') IS NOT NULL
  DROP TABLE #ImportErrors

IF OBJECT_ID('tempdb..#ImportUnPivot') IS NOT NULL
  DROP TABLE #ImportUnPivot

CREATE TABLE #ImportUnPivot (
  [SiteCode] int NOT NULL,
  [SafeName] varchar(50) NOT NULL,
  [VariationPanelName] varchar(50) NOT NULL)

CREATE NONCLUSTERED INDEX IX_#ImportUnPivot_SafeName ON #ImportUnPivot (SafeName)

INSERT #ImportUnPivot (SiteCode, SafeName, VariationPanelName)
SELECT SiteCode, SafeName, VariationPanelName
FROM <ImportTable>
    UNPIVOT
      (VariationPanelName FOR SafeName IN
        (<CrosstabColumnSafeNameList>)) x

SELECT a.SiteCode, b.ColumnId, b.Name, a.VariationPanelName
INTO #ImportErrors
FROM #ImportUnPivot a
  JOIN #CrossTabColumns b ON a.SafeName = b.SafeName
  LEFT JOIN #VariationPanelLookup c on b.ActualId = c.ParentPanelId AND a.VariationPanelName = c.VariationPanelName
WHERE a.VariationPanelName <> @UseDefaultPanel and c.VariationPanelId IS NULL

DROP TABLE #ImportUnPivot

SET NOCOUNT OFF
