SET NOCOUNT ON

-- save footer text
declare @SiteCode int
set @SiteCode = dbo.fnGetSiteCode()

update #SitePromotionalFooterOverride set SiteCode = @SiteCode where SiteCode= -1
update #SitePromotionalFooterTextOverride set SiteCode = @SiteCode where SiteCode= -1

delete SitePromotionalFooterOverride_Repl
where PromotionalFooterID = @PromotionalFooterID
and SiteCode = @SiteCode 

insert SitePromotionalFooterOverride_Repl (SiteCode, PromotionalFooterID, OverrideID, OverrideName)
select SiteCode, @PromotionalFooterID, OverrideID, OverrideName
from #SitePromotionalFooterOverride

delete SitePromotionalFooterTextOverride_Repl
where PromotionalFooterID = @PromotionalFooterID
and SiteCode = @SiteCode 

insert SitePromotionalFooterTextOverride_Repl (SiteCode, PromotionalFooterID, OverrideID, LineNumber, [Text], Bold, DoubleSize, AppendSurveyCode, AppendVoucherCode)
select SiteCode, @PromotionalFooterID, OverrideID, LineNumber, [Text], Bold, DoubleSize, AppendSurveyCode, AppendVoucherCode
from #SitePromotionalFooterTextOverride
where (isnull([Text],'') <> '') or (AppendSurveyCode = 1) or (AppendVoucherCode = 1)
-- end of footer text save

delete SitePromotionalFooterOverrideSAMap
from SitePromotionalFooterOverrideSAMap sam
left join #SitePromotionalFooterOverride fo
on  sam.PromotionalFooterID  = @PromotionalFooterId
and sam.OverrideID = fo.OverrideID
and sam.SiteCode = fo.SiteCode
where fo.OverrideID is null

SET NOCOUNT OFF