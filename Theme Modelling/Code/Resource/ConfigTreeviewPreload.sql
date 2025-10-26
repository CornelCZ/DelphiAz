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

-- deleted flag ignored here for speed, should only contribute
-- a small percentage of unused names
insert ##ConfigTree_Names select Name
from (
select [company name] as Name from config
union
select [area name] as Name from config
union 
select [site name] as Name from config
union
select [sales area name] as Name from config
where [Sales Area Code] not in (select SalesAreaID from @BookingsOnlySalesAreas) 
union
select [pos name] as name from config
where [POS Code] not in (select PosID from @BookingsTills)
and [POS Code] in (select PosID from @NonBookingsTills)
) a
order by Name

create table ##ConfigTree_data
(
  Level1ID int,
  Level2ID int,
  Level3ID int,
  Level4ID int,
  Level5ID int,
  Level1Name int,
  Level2Name int,
  Level3Name int,
  Level4Name int,
  Level5Name int,
  primary key (Level1ID, Level2ID, Level3ID, Level4ID, Level5ID)
)

insert ##ConfigTree_Data
select 
  [company code] as Level1ID,
  [area code] as Level2ID,
  [site code] as Level3ID,
  [sales area code] as Level4ID,
  cast([POS Code] as integer) as Level5ID,
  companyname.ID as Level1Name,
  areaname.ID as Level2Name,
  sitename.ID as Level3Name,
  salesareaname.ID as Level4Name,
  posname.ID as Level5Name
from config
join ##ConfigTree_Names companyname on [company name] = companyname.Name
join ##ConfigTree_Names areaname on [area name] = areaname.Name
join ##ConfigTree_Names sitename on [site name] = sitename.Name
join ##ConfigTree_Names salesareaname on [sales area name] = salesareaname.Name
join ##ConfigTree_Names posname on [pos name] = posname.Name
where ([Deleted] is null or [Deleted] = 'N')
  and [company code] is not null
  and [area code] is not null
  and [site code] is not null
  and [sales area code] is not null
  and [pos code] is not null
order by [company name], [area name], [site name], [sales area name], [pos name]


SET NOCOUNT OFF