SET NOCOUNT ON

if object_id('tempdb..#EditSiteVariations') is not null
  drop table #EditSiteVariations

if object_id('tempdb..#EditSiteVariations_Backup') is not null
  drop table #EditSiteVariations_Backup

if object_id('tempdb..#EditSiteVariations_Changes') is not null
  drop table #EditSiteVariations_Changes

CREATE TABLE #EditSiteVariations (
   SiteCode int not null,
   SiteName varchar (20),
   SiteRef varchar(10),
   AreaName varchar(20),
   <CrosstabColumnCreateList>,
   PRIMARY KEY (SiteCode)
  )

SELECT top 0 * INTO #EditSiteVariations_Backup from #EditSiteVariations
CREATE UNIQUE CLUSTERED INDEX IX_ESVBK_Site on #EditSiteVariations_Backup (SiteCode) --TODO Is this used?

SET NOCOUNT OFF
