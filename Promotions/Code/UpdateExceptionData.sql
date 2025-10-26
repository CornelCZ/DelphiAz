SET NOCOUNT ON

SET DEADLOCK_PRIORITY LOW

BEGIN TRY

  -- for every Exception in #PromotionException and its "children" tables 
  -- the ID could already be present in PromotionException_repl if this is an edit or a copy
  -- an edit is present with same ExceptionID-PromotionID as this one, leave it alone;
  -- a copy or addition, if present, will be present with a diff PromotionID, an insert will give KV.
  -- For this last case a new ExceptionID must be generated and the "doubled" ID set to
  -- the new ID in #PromotionException and all its "children" tables

  DECLARE @oldid bigint, @newid bigint;

  DECLARE ExceptionCursor CURSOR FOR
     SELECT r.ExceptionID
     FROM PromotionException_Repl r JOIN #PromotionException t
     ON r.ExceptionID = t.ExceptionID AND r.PromotionID <> t.PromotionID;
  
  OPEN ExceptionCursor;
  
  FETCH NEXT FROM ExceptionCursor INTO @oldid;
  
  WHILE @@FETCH_STATUS = 0
  BEGIN
      BEGIN TRANSACTION
        exec ac_spGetTableIdNextValue 'PromotionException_Repl', @newid output

        UPDATE #PromotionException SET ExceptionID = @newid WHERE ExceptionID  = @oldid
        UPDATE #PromotionExceptionEventStatus SET ExceptionID = @newid WHERE ExceptionID  = @oldid
        UPDATE #PromotionExceptionTimeCycles SET ExceptionID = @newid WHERE ExceptionID  = @oldid
        UPDATE #PromotionExceptionSalesArea SET ExceptionID = @newid WHERE ExceptionID  = @oldid
      COMMIT TRANSACTION
  
      FETCH NEXT FROM ExceptionCursor INTO @oldid;
  END;
  
  CLOSE ExceptionCursor;
  DEALLOCATE ExceptionCursor;

  update #PromotionSaleGroup set PromotionID = -1


END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
  EXEC ac_spRethrowError -- Re raise the error so that it gets back to the Delphi runtime.
END CATCH

SET DEADLOCK_PRIORITY NORMAL

SET NOCOUNT OFF
