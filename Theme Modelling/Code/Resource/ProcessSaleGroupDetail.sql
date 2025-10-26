declare @SaleGroupId int
set @SaleGroupId = %SaleGroupId%
declare @PromotionalFooterId int
set @PromotionalFooterId = %PromotionalFooterId%

--Delete the prvious entries for the sale group.
delete from #PromotionalFooterSaleGroupDetail
where SaleGroupId = @SaleGroupId

--Extract the portions that need to be included
insert #PromotionalFooterSaleGroupDetail (PromotionalFooterId, SaleGroupId, GroupingType, GroupingTypeTargetId)
select @PromotionalFooterId, @SaleGroupId, 4, a.level5id from
[%temptable%] a
join
  (Select sub2.level4id from
   (select level4id, count(level5id) as count1 from [%temptable%]
    group by level4id) sub1
   join
   (select level4id, count(level5id) as count2 from [##ProductTree_Data]
    group by level4id) sub2
   on sub1.Level4id = sub2.level4id
   where count1 < count2) sub3
on a.Level4Id = sub3.level4id

delete from [%temptable%]
where level5id in (select GroupingTypeTargetId
                   from #PromotionalFooterSaleGroupDetail
                   where GroupingType = 4
                   and SaleGroupID = @SaleGroupId)

--Extract the products that need to be included
insert #PromotionalFooterSaleGroupDetail (PromotionalFooterId, SaleGroupId, GroupingType, GroupingTypeTargetId)
select distinct @PromotionalFooterId, @SaleGroupId, 3, a.level4id + 10000000000
from [%temptable%] a
join 
  (Select sub2.level3id from
   (select level3id, count(level4id) as count1 from
    (select distinct level, level1id, level2id, level3id, level4id
     from [%temptable%]) sub
    group by level3id) sub1
   join
   (select level3id, count(level4id) as count2 from
    (select distinct level1id, level2id, level3id, level4id
     from [##ProductTree_Data]) sub4
    group by level3id) sub2
   on sub1.Level3id = sub2.level3id
   where count1 < count2) sub3
on a.Level3Id = sub3.level3id

delete from [%temptable%]
where level4id in (select GroupingTypeTargetId - 10000000000
                   from #PromotionalFooterSaleGroupDetail
                   where GroupingType = 3
                   and SaleGroupID = @SaleGroupId)

--Extract the sub-cats that need to be included
insert #PromotionalFooterSaleGroupDetail (PromotionalFooterId, SaleGroupId, GroupingType, GroupingTypeTargetId)
select distinct @PromotionalFooterId, @SaleGroupId, 2, a.level3id
from [%temptable%] a
join
  (Select sub2.level2id from
   (select level2id, count(level3id) as count1 from
    (select distinct level, level1id, level2id, level3id
     from [%temptable%]) sub
    group by level2id) sub1
   join 
   (select level2id, count(level3id) as count2 from
    (select distinct level1id, level2id, level3id
     from [##ProductTree_Data]) sub4
    group by level2id) sub2
   on sub1.Level2id = sub2.level2id
   where count1 < count2) sub3
on a.Level2Id = sub3.level2id

delete from [%temptable%]
where level3id in (select GroupingTypeTargetId
                   from #PromotionalFooterSaleGroupDetail
                   where GroupingType = 2
                   and SaleGroupID = @SaleGroupId)

--Extract the cats that need to be included                   
insert #PromotionalFooterSaleGroupDetail (PromotionalFooterId, SaleGroupId, GroupingType, GroupingTypeTargetId)
select distinct @PromotionalFooterId, @SaleGroupID, 1, a.level2id
from [%temptable%] a
join 
  (Select sub2.level1id from
   (select level1id, count(level2id) as count1 from
    (select distinct level, level1id, level2id
     from [%temptable%]) sub
    group by level1id) sub1
   join
   (select level1id, count(level2id) as count2 from
    (select distinct level1id, level2id
     from [##ProductTree_Data]) sub4
    group by level1id) sub2
   on sub1.Level1id = sub2.level1id
   where count1 < count2) sub3
on a.Level1Id = sub3.level1id

delete from [%temptable%]
where level2id in (select GroupingTypeTargetId
                   from #PromotionalFooterSaleGroupDetail
                   where GroupingType = 1
                   and SaleGroupID = @SaleGroupId)
                   
-- If there is anything else left in the temp table then the whole division was selected
insert #PromotionalFooterSaleGroupDetail (PromotionalFooterId, SaleGroupId, GroupingType, GroupingTypeTargetId)
select distinct @PromotionalFooterId, @SaleGroupId, 0, a.level1id
from [%temptable%] a