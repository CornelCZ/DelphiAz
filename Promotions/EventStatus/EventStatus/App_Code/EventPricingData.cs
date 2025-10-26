using System;
using System.Data.SqlClient;

namespace EventStatus
{
    /// <summary>
    /// Summary description for EventPricingData
    /// </summary>
    public class EventPricingData
    {
        public EventPricingController parent;
        public EventPricingData()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        private void PopulateList(string SQLStatement, SelectionItemList ItemList)
        {
            SqlConnection Conn;
            SqlCommand Cmd;
            Conn = new SqlConnection(parent.GetAztecConnectionString());
            Conn.Open();
            Cmd = new SqlCommand(SQLStatement, Conn);
            SqlDataReader Rdr = Cmd.ExecuteReader();
            ItemList.Clear();
            while (Rdr.Read())
            {
                if (Rdr["DisplayName"] == DBNull.Value)
                    ItemList.Add(new SelectionItem((long)Rdr["ID"], "Unnamed"));
                else
                    ItemList.Add(new SelectionItem((long)Rdr["ID"], (string)Rdr["DisplayName"]));
            }
            Rdr.Close();
            Conn.Close();
        }

        private void PopulateList(string SQLStatement, LabelItemList ItemList)
        {
            SqlConnection Conn;
            SqlCommand Cmd;
            Conn = new SqlConnection(parent.GetAztecConnectionString());
            Conn.Open();
            Cmd = new SqlCommand(SQLStatement, Conn);
            SqlDataReader Rdr = Cmd.ExecuteReader();
            ItemList.Clear();
            while (Rdr.Read())
            {
                ItemList.Add(new LabelItem((string)Rdr["LabelText"]));
            }
            Rdr.Close();
            Conn.Close();
        }


        public void ExecuteCommand(string Command)
        {
            SqlConnection Conn;
            SqlCommand Cmd;
            Conn = new SqlConnection(parent.GetAztecConnectionString());
            Conn.Open();
            Cmd = new SqlCommand(Command, Conn);
            // todo exception page for this app?!?
            Cmd.ExecuteNonQuery();
        }

        public Boolean IsChangePending()
        {
            SqlConnection Conn;
            SqlCommand Cmd;
            Boolean TmpResult;
            Conn = new SqlConnection(parent.GetAztecConnectionString());
            Conn.Open();
            Cmd = new SqlCommand(
                @"select * from promotiontariffchange 
                where SiteCode = dbo.fnGetSiteCode() and ChangeTime is null"
            , Conn);
            SqlDataReader Rdr = Cmd.ExecuteReader();
            TmpResult = Rdr.HasRows;
            Rdr.Close();
            Conn.Close();
            return (TmpResult || parent.EPState == EventPricingAppState.SendInProgress);
        }

        public void GetSalesAreaStatus(LabelItemList ItemList)
        {
            PopulateList(
                @"
                declare @TmpSalesAreaStatus table (SiteCode int, SalesAreaID int, TariffID bigint, LabelText varchar(1024))

                insert @TmpSalesAreaStatus
                select sub.*, QuoteName([Sales Area Name], '""') + ' : ' + TariffNames.Name
                from (
                  select a.SiteCode, a.SalesAreaID, IsNull(b.SelectedTariff, -1) as TariffID
                  from 
                  ( 
                    select distinct [Site Code] as SiteCode, [Sales Area Code] as SalesAreaID from Config 
                    where [Sales Area Code] is not null
                      and [Site Code] = dbo.fnGetSiteCode()
                      and (Deleted is null or Deleted = 'N')
                  ) a
                  left outer join PromotionCurrentTariff b
                    on a.SiteCode = b.SiteCode and a.SalesAreaID = b.SalesAreaID
                ) sub
                join SalesArea on sub.SalesAreaID = SalesArea.[Sales Area Code]
                join (
                  Select PromotionID as TariffID, Name from Promotion
                  union
                  select -1, 'Standard'
                ) TariffNames on sub.TariffID = TariffNames.TariffID

                -- fiddly in SQL: group names where not all groups are selected
				declare @SiteCode int, @SalesAreaID int
				declare GroupTextLoop cursor for
				select sub.SiteCode, sub.SalesAreaID
				from
				(
				  select a.SiteCode, a.SalesAreaID, a.SelectedTariff, count(*) as SelectedGroups
				  from PromotionCurrentTariff a
				  join PromotionCurrentTariffGroup b
				    on a.SiteCode = b.SiteCode
				    and a.SalesAreaID = b.SalesAreaID
				  group by a.SiteCode, a.SalesAreaID, a.SelectedTariff
				) sub
				join
				(		
				  select a.PromotionID as TariffID, count(*) as TotalGroups
                  from Promotion a 
				  join PromotionSaleGroup b on a.PromotionID = b.PromotionID
                  where PromoTypeID = 4
				  group by a.PromotionID
				) sub2 on sub.SelectedTariff = sub2.TariffID 
					and sub.SelectedGroups <> sub2.TotalGroups
				open GroupTextLoop
				fetch next from GroupTextLoop into @Sitecode, @SalesAreaID
				while @@fetch_status = 0
				begin
				  declare @TmpStr varchar(1024)
				  set @TmpStr = ' ('
				  select @TmpStr = @TmpStr + Name + ', ' 
				  from PromotionCurrentTariff a
				  join PromotionCurrentTariffGroup b 
				    on a.SiteCode = b.SiteCode and a.SalesAreaID = b.SalesAreaID
				  join PromotionSaleGroup c 
				    on a.SelectedTariff = c.PromotionID and b.SelectedGroup = c.SaleGroupID
				  where a.SiteCode = @SiteCode and a.SalesAreaId = @SalesAreaID
				  order by c.SaleGroupID

				  set @TmpStr = Left(@TmpStr, Len(@TmpStr)-1) + ')' 
				  update @TmpSalesAreaStatus
				  set LabelText = LabelText + @TmpStr
				  from @TmpSalesAreaStatus
			      where SiteCode = @SiteCode and SalesAreaID = @SalesAreaID
				  fetch next from GroupTextLoop into @Sitecode, @SalesAreaID
				end
				close GroupTextLoop
				deallocate GroupTextLoop
                select LabelText from @TmpSalesAreaStatus order by LabelText
                ", ItemList);
        }

        public void GetTariffsList(SelectionItemList ItemList)
        {
            PopulateList(
                @"select a.PromotionID as ID, a.Name as DisplayName 
                from Promotion a 
                join PromotionSalesArea b on a.PromotionID = b.PromotionID 
                join (
                  select distinct [Site Code] as SiteCode, [Sales Area Code] as SalesAreaID from Config 
                  where [Sales Area Code] is not null
                        and [Site Code] = dbo.fnGetSiteCode()
                        and (Deleted is null or Deleted = 'N')
                ) c on b.SalesAreaID = c.SalesAreaID 
                and c.SiteCode = dbo.fnGetSiteCode() 
                where PromoTypeID = 4 and Status = 0 
                union
				select top 1 -1, 'Standard'
				from PromotionCurrentTariff
				where SiteCode = dbo.fnGetSiteCode()
			      and SelectedTariff <> -1", ItemList
            ); 
        }
        public void GetTariffDetails(long TariffID, SelectionItemList TariffGroups, SelectionItemList SalesAreas)
        {
            PopulateList(
                string.Format("select cast(SaleGroupID as bigint) as ID, Name as DisplayName from PromotionSaleGroup where PromotionID = {0}", TariffID),
                TariffGroups    
            );
            PopulateList(
                string.Format(
                    @"select cast(a.SalesAreaID as bigint) as ID, c.[Sales Area Name] as DisplayName
                    from PromotionSalesArea a
                    join (
                      select distinct [Sales Area Code] as SalesAreaID from Config 
                      where [Sales Area Code] is not null
                        and [Site Code] = dbo.fnGetSiteCode()
                        and (Deleted is null or Deleted = 'N')
                    ) b on a.SalesAreaID = b.SalesAreaID
                    join SalesArea c
                      on a.SalesAreaID = c.[Sales Area Code]
                    where PromotionID = {0}
                    union 
                    select cast(a.SalesAreaID as bigint) as ID, c.[Sales Area Name] as DisplayName
                    from (
                      select distinct [Sales Area Code] as SalesAreaID from Config 
                      where [Sales Area Code] is not null
                        and [Site Code] = dbo.fnGetSiteCode()
                        and (Deleted is null or Deleted = 'N')
                    ) a
                    join SalesArea c
                      on a.SalesAreaID = c.[Sales Area Code]
                    where {0} = -1", TariffID
                ), SalesAreas
            );
            SelectionItemList TariffSalesAreas = new SelectionItemList();
            PopulateList(
                string.Format(
                    @"select cast(SalesAreaID as bigint) as ID, '' as DisplayName
                    from PromotionCurrentTariff 
                    where SelectedTariff = {0} and SiteCode = dbo.fnGetSiteCode()", TariffID
                ), TariffSalesAreas
            );
            if (TariffSalesAreas.Count > 0)
            {
                foreach (SelectionItem i in SalesAreas)
                {
                    if (TariffSalesAreas.Contains(i))
                        i.ItemSelected = true;
                    else
                        i.ItemSelected = false;
                }
            }
        }
       

    }

}