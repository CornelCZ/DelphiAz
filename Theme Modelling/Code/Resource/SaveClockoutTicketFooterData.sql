set nocount on

declare @ClockoutTicketFooterID int
set @ClockoutTicketFooterID = @ClockoutTicketFooterID_in

update #ClockoutTicketFooterOverride set Id = @ClockoutTicketFooterID where Id = -1

begin try

	begin tran

	if exists (select * from ThemeClockOutTicketFooterOverride where id = @ClockoutTicketFooterID)
		update ThemeClockOutTicketFooterOverride
			set
				[Name] = tp.[Name],
				[Description] = tp.[Description]
		from (select * from #ClockoutTicketFooterOverride) tp
		where ThemeClockOutTicketFooterOverride.Id = @ClockoutTicketFooterID
	else
		insert ThemeClockOutTicketFooterOverride select * from #ClockoutTicketFooterOverride
	  
	delete ThemeClockOutTicketFooterTextOverride where OverrideID = @ClockoutTicketFooterID

	insert ThemeClockOutTicketFooterTextOverride
	select @ClockoutTicketFooterID, LineNumber, LineType, [Text], Bold, DoubleSize
	from #ClockoutTicketFooterTextOverride
	where (isnull([Text],'') <> '') or (LineType = 1)
	
	commit tran

end try
begin catch
  if @@TRANCOUNT > 0 rollback transaction
  exec ac_spRethrowError -- Re raise the error so that it gets back to the Delphi runtime.
end catch
 
set nocount off
