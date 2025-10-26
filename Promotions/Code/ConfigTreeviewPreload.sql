SET NOCOUNT ON

create table ##ConfigTree_Names
(
  ID int identity(1,1),
  Name varchar(50) COLLATE DATABASE_DEFAULT
)

declare @BookingsTills table (SalesAreaID int, PosID int)
declare @NonBookingsTills table (SalesAreaID int, PosID int)
declare @BookingsOnlySalesAreas table (SalesAreaID int)
declare @BookingsHardwareType int
set @BookingsHardwareType = 11

insert @BookingsTills
select distinct SalesAreaID, ID from ac_pos
where ID in (select PosCode from ThemeEposDevice where HardwareType = @BookingsHardwareType)

insert @NonBookingsTills
select distinct SalesAreaID, ID from ac_Pos
where ID in (select PosCode from ThemeEposDevice where HardwareType <> @BookingsHardwareType)
and Deleted = 0

insert @NonBookingsTills
select distinct SalesAreaID, ID from ac_Pos
where ID not in (select POSCode from ThemeEposDevice where POSCode is not null)
and Deleted = 0

insert @BookingsOnlySalesAreas
select distinct ID from ac_SalesArea
where ID in (select SalesAreaId from @BookingsTills)
and ID not in (select SalesAreaId from @NonBookingsTills)

insert ##ConfigTree_Names select Name
from (
select Name from ac_Company where Deleted = 0
union
select Name from ac_Area where Deleted = 0
union 
select Name from ac_Site where Deleted = 0
union
select Name from ac_SalesArea
where Deleted = 0 and Id not in (select SalesAreaID from @BookingsOnlySalesAreas) 
) a
order by Name

create table ##ConfigTree_data
(
  Level1ID int,
  Level2ID int,
  Level3ID int,
  Level4ID int,
  Level1Name int,
  Level2Name int,
  Level3Name int,
  Level4Name int,
  primary key (Level1ID, Level2ID, Level3ID, Level4ID)
)

insert ##ConfigTree_Data
select c.Id as Level1Id, a.Id as Level2Id, si.Id as Level3Id, sa.Id as Level4Id,
  companyname.ID as Level1Name, areaname.ID as Level2Name, sitename.ID as Level3Name, salesareaname.ID as Level4Name
from ac_Company c
  join ac_Area a on c.Id = a.CompanyId 
  join ac_Site si on a.Id = si.AreaId
  join ac_SalesArea sa on si.Id = sa.SiteId
  join ##ConfigTree_Names companyname on c.Name = companyname.Name
  join ##ConfigTree_Names areaname on a.Name = areaname.Name
  join ##ConfigTree_Names sitename on si.Name = sitename.Name
  join ##ConfigTree_Names salesareaname on sa.Name = salesareaname.Name
where c.Deleted = 0 and a.Deleted = 0 and si.Deleted = 0 and sa.Deleted = 0
order by c.Name, a.Name, si.Name, sa.Name

SET NOCOUNT OFF
