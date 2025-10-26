SET NOCOUNT ON

create table ##ProductTree_Names
(
  ID int identity(1,1),
  Name varchar(60) COLLATE DATABASE_DEFAULT
)

insert ##ProductTree_Names select Name
from (
select [division name] as Name from division
union
select [category name] as Name from category
union
select [sub-category name] as Name from subcategory
where subcategory.deleted is null or subcategory.deleted = 'N'
union
select products.[Extended RTL Name] + ISNULL(' (' + products.[Retail Description] + ')', '')
from products
where (Products.Deleted is null or Products.deleted = 'N')
  and (Products.[Entity Type] in ('Recipe', 'Strd.Line')) 
union
select portiontype.[portiontypename] as portionname
from portions 
join portiontype on portions.portiontypeid = portiontype.portiontypeid
) a 
order by Name

create table ##ProductTree_data
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

insert ##ProductTree_Data
select 
  division.[index no] as Level1ID,
  category.[index no] as Level2ID,
  subcategory.[index no] as Level3ID,
  cast((portions.[entitycode] - 10000000000.0) as int) as Level4ID,
  portions.[portionid] as Level5ID, 
  divisionname.ID as Level1Name,
  categoryname.ID as Level2Name,
  subcategoryname.ID as Level3Name,
  productname.ID as Level4Name,
  portionname.ID as Level5Name
from portions
join portiontype on portions.portiontypeid = portiontype.portiontypeid
join ##ProductTree_Names portionname on portiontype.portiontypename = portionname.Name
join products on portions.entitycode = products.entitycode
join ##ProductTree_Names productname on products.[Extended RTL Name] + ISNULL(' (' + products.[Retail Description] + ')', '') = productname.Name
join subcategory on products.[sub-category name] = subcategory.[sub-category name]
join ##ProductTree_Names subcategoryname on subcategory.[sub-category name] = subcategoryname.Name
join category on subcategory.[category index] = category.[index no]
join ##ProductTree_Names categoryname on category.[category name] = categoryname.Name
join division on category.[division index] = division.[index no]
join ##ProductTree_Names divisionname on division.[division name] = divisionname.Name
where (products.deleted is null or products.deleted = 'N')
and Products.[Entity Type] in ('Recipe', 'Strd.Line')
  and (subcategory.deleted is null or subcategory.deleted = 'N')
  -- PW fix for unsupported "site products" with massive entity codes
  and portions.entitycode < 19999999999.0
order by division.[division name], category.[category name], 
  subcategory.[sub-category name], products.[extended rtl name],
  portiontype.[portiontypename]

SET NOCOUNT OFF