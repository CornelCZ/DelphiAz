/*--  ver 1.0 230830 GJG

Add missing records

*/

SET NOCOUNT ON

SET DEADLOCK_PRIORITY LOW

BEGIN TRY

  BEGIN TRANSACTION
	declare @SiteCode int = dbo.fnGetSiteCode()
    declare @SalesAreaID int 
		

   select @SalesAreaID = pea.SiteCode
      from   #PromotionExceptionSalesArea pea

   if (IsNull(@SalesAreaID,0) = 0)
    set @SalesAreaID = 1
	

   INSERT      INTO #PromotionExceptionSalesArea (SiteCode, ExceptionId, SalesAreaId) 
   SELECT      @siteCode, e.ExceptionId, @SalesAreaID
   FROM		   #PromotionException e 
   LEFT JOIN   #PromotionExceptionSalesArea a   ON e.ExceptionID = a.ExceptionID
   WHERE	   a.ExceptionID IS NULL   


  COMMIT TRANSACTION

END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
  EXEC ac_spRethrowError -- Re raise the error so that it gets back to the Delphi runtime.
END CATCH

SET DEADLOCK_PRIORITY NORMAL

SET NOCOUNT OFF

