set nocount on

declare @BillFooterID int
set @BillFooterID = @BillFooterID_in

update #BillFooterOverride set Id = @BillFooterID where Id = -1

begin try

	begin tran

	-- todo this could be replaced by a merge statement
	if exists (select * from ThemeBillFooterOverride where id = @BillFooterID)
		update ThemeBillFooterOverride
			set
				[Name] = tp.[Name],
				[Description] = tp.[Description]
		from (select * from #BillFooterOverride) tp
		where ThemeBillFooterOverride.Id = @BillFooterID
	else
		insert ThemeBillFooterOverride select * from #BillFooterOverride
	  
	delete ThemeBillFooterOverrideText where FooterId = @BillFooterID

	insert ThemeBillFooterOverrideText
	select @BillFooterID, LineNumber, Alignment, [Text], Bold, DoubleWidth, DoubleHeight
	from #BillFooterTextOverride
	where (isnull([Text],'') <> '')

	commit tran

end try
begin catch
  if @@TRANCOUNT > 0 rollback transaction
  exec ac_spRethrowError -- Re raise the error so that it gets back to the Delphi runtime.
end catch
 
set nocount off
