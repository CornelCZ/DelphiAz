SET NOCOUNT ON

IF object_id('tempdb..#CrossTabColumns') IS NOT NULL
  DROP TABLE #CrossTabColumns

IF object_id('tempdb..#VariationPanelLookup') IS NOT NULL
  DROP TABLE #VariationPanelLookup


CREATE TABLE #CrossTabColumns (ColumnID int identity(1, 1), ActualID int, Name varchar(50), SafeName varchar(50), primary key(ColumnID))
INSERT #CrossTabColumns (ActualID, Name, SafeName)
SELECT DISTINCT a.panelid, name, dbo.fnGetSafeSQLColumnName(b.Name)
FROM ThemePanelVariation a
  JOIN ThemePanel b ON a.panelid = b.PanelId
ORDER BY Name

CREATE TABLE #VariationPanelLookup (ParentPanelId int, VariationPanelName varchar(50), VariationPanelId int, PRIMARY KEY (ParentPanelId, VariationPanelName))

INSERT #VariationPanelLookup
SELECT a.PanelId, b.Name, a.VariationPanelID FROM ThemePanelVariation a join ThemePanel b on a.VariationPanelID = b.PanelId

SET NOCOUNT OFF
