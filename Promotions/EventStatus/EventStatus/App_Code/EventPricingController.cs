using System;
using System.Diagnostics;
using System.Web.UI;
using System.Threading;
using System.Globalization;

namespace EventStatus
{
    public enum EventPricingAppState
    {
        Uninitialised, SelectTariff, SelectGroups, SelectSalesAreas,
        ConfirmChangeDetails, SendInProgress, SendFailed, SendComplete, InternalError
    }

    public class LabelItem 
    {
        private string Text;
        public string LabelText { get { return Text; } }
        public LabelItem(string Text)
        {
            this.Text = Text;
        }
    }
    public class LabelItemList: System.Collections.Generic.List<LabelItem> { };

    public class SelectionItem
    {
        private long ID;
        private string DisplayName;
        private bool Selected;
        public long ItemID { get { return ID; } }
        public string ItemText { get { return DisplayName; } }
        public bool ItemSelected { get { return Selected; } set { Selected = value; } }  
        public SelectionItem(long ID, string DisplayName)
        {
            this.ID = ID;
            this.DisplayName = DisplayName;
            this.Selected = true;
        }
        public override bool Equals(object obj)
        {
            return ((obj is SelectionItem) && ((obj as SelectionItem).ItemID == this.ItemID));
        }
        public override int GetHashCode()
        {
            return base.GetHashCode();
        }
       
    }
    public class SelectionItemList : System.Collections.Generic.List<SelectionItem> 
    {
        public bool IsOneSelected()
        {
            return Exists(
                delegate(SelectionItem item) 
                { 
                    return item.ItemSelected == true; 
                }
            );
        }
        public string AsSeparatedIDList(string Separator)
        {
            string t = "";
            foreach (SelectionItem i in this) 
            {
                if (i.ItemSelected == true)
                    t += string.Format("{0}{1}", i.ItemID, Separator);        
            }
            if (t.Length > 0)
                t = t.Substring(0, t.Length - Separator.Length);
            return t;
        }

        public string AsSeparatedList(string Separator)
        {
            string t = "";
            foreach (SelectionItem i in this)
            {
                if (i.ItemSelected == true)
                    t += string.Format("\"{0}\"{1}", i.ItemText, Separator);
            }
            if (t.Length > 0)
                t = t.Substring(0, t.Length - Separator.Length);
            return t;
        }

    };

    /// <summary>
    /// Summary description for EventPricingController
    /// </summary>
    public class EventPricingController
    {
        public static EventPricingData Data;
        public static SystemSettings SysSettings;

        public Int32 ClientTerminalID;
        public Int64 ClientEmployeeID;
        public String LastError;
        private Thread ApplyChangeThread;
        
        private SelectionItemList Tariffs;
        private long SelectedTariff;
        private SelectionItemList TariffGroups;
        private SelectionItemList SalesAreas;

        // These methods use by ObjDataSource, internal so that the ASP pages
        // can't accidentally be hooked up to this class.
        internal SelectionItemList GetTariffs() { return Tariffs; }
        internal SelectionItemList GetTariffGroups() { return TariffGroups; }
        internal SelectionItemList GetSalesAreas() { return SalesAreas; }
        internal LabelItemList GetSalesAreaStatus()
        {
            LabelItemList t = new LabelItemList();
            Data.GetSalesAreaStatus(t);
            return t;
        }
        

        public EventPricingAppState EPState;
	    public EventPricingController()
	    {
            SysSettings = new SystemSettings();
            Data = new EventPricingData();
            Data.parent = this;

            Tariffs = new SelectionItemList();
            TariffGroups = new SelectionItemList();
            SalesAreas = new SelectionItemList();

            EPState = EventPricingAppState.Uninitialised;
	    }
     
        public void Initialise()
        {
            if (EPState == EventPricingAppState.Uninitialised
                || EPState == EventPricingAppState.SendComplete
                || EPState == EventPricingAppState.SendFailed
                || EPState == EventPricingAppState.InternalError)
            {
                EPState = EventPricingAppState.SelectTariff;
            }
            Data.GetTariffsList(Tariffs);
        }

       /* public bool NeedToLocalise()
        {
            return SysSettings.NeedToLocalise();
        }*/

        public void LocalisePage(Page ThePage)
        {
            String CultureTag = SysSettings.GetCultureTag();
            ThePage.Culture = CultureTag;
            ThePage.UICulture = CultureTag;
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(CultureTag);
            Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture(CultureTag);
        }

        public void HandleError(String ErrorText)
        {
            LastError = ErrorText;
            EPState = EventPricingAppState.InternalError;
        }

        public string GetAztecConnectionString()
        {
            return SysSettings.GetAztecConnectionString();
        }

        public bool AreTariffsDefined()
        {
            return (Tariffs.Count > 0);
        }


        public void SelectTariff(long TariffID)
        {
            SelectedTariff = TariffID;
            Data.GetTariffDetails(TariffID, TariffGroups, SalesAreas);

            if (TariffGroups.Count > 1)
                EPState = EventPricingAppState.SelectGroups;
            else if (SalesAreas.Count > 1)
                EPState = EventPricingAppState.SelectSalesAreas;
            else 
                EPState = EventPricingAppState.ConfirmChangeDetails;
        }

        public void ToggleGroup(int GroupID)
        {
            foreach (SelectionItem i in TariffGroups) {
              if (i.ItemID == GroupID)
                  i.ItemSelected = !i.ItemSelected;
            }
        }
        public void ConfirmGroups()
        {
            if (TariffGroups.IsOneSelected())
            {
                if (SalesAreas.Count > 1)
                    EPState = EventPricingAppState.SelectSalesAreas;
                else
                    EPState = EventPricingAppState.ConfirmChangeDetails;
            }
            else
                EPState = EventPricingAppState.SelectGroups;
        }
        public void ToggleSalesArea(int SalesAreaID)
        {
            foreach (SelectionItem i in SalesAreas)
            {
                if (i.ItemID == SalesAreaID)
                    i.ItemSelected = !i.ItemSelected;
            }
        }
        public void ConfirmSalesAreas()
        {
            if (SalesAreas.IsOneSelected())
            {
                EPState = EventPricingAppState.ConfirmChangeDetails;
            }
            else
            {
                EPState = EventPricingAppState.SelectSalesAreas;
            };
        }

        private void ApplyChanges()
        {
            try
            {
                Thread.Sleep(100);
                Data.ExecuteCommand(
                    @"declare @SiteCode int
                    set @SiteCode = dbo.fnGetSiteCode()
                    EXEC Promotion_RevertTariffAtEOD @SiteCode"
                );
                Data.ExecuteCommand(GetStoredProcParams());
                using (Process p = new Process())
                {
                    p.StartInfo.FileName = SysSettings.GetThemeModellingPath();
                    p.StartInfo.Arguments = @"-autosend";
                    p.StartInfo.WorkingDirectory = SysSettings.GetAztecDirectory();
                    if (p.Start())
                    {
                        //p.PriorityClass = ProcessPriorityClass.BelowNormal;
                        p.WaitForExit();
                        if (p.ExitCode == 0)
                        {
                            EPState = EventPricingAppState.SendComplete;
                        }
                        else
                        {
                            EPState = EventPricingAppState.SendFailed;
                        }
                    }
                    else
                    {
                        EPState = EventPricingAppState.SendFailed; // theme send failed to start
                    }
                }
            }
            catch (Exception E)
            {
                HandleError(E.Message + "<BR><BR>"+ E.StackTrace);
                // Seemed to have problems using the (much nicer) backgroundworker helper class.
                // It blocked response.redurect while the thread was running.
            }
        }

        public void ConfirmChange()
        {
            EPState = EventPricingAppState.SendInProgress;
            if ((ApplyChangeThread == null) || (ApplyChangeThread.ThreadState == System.Threading.ThreadState.Stopped))
            {
                ApplyChangeThread = new Thread(this.ApplyChanges);
                ApplyChangeThread.Start();
            }
            else
                throw new Exception("Update thread already running");
        }
        public string GetSelectedTariff()
        {
            string TariffName = "";
            foreach (SelectionItem i in Tariffs)
                if (i.ItemID == SelectedTariff)
                    TariffName = i.ItemText;

            string GroupDetails = TariffGroups.AsSeparatedList(", ");

            if (GroupDetails.Length == 0)
                return TariffName;
            else
                return string.Format("{0} ({1})", TariffName, GroupDetails);
        }
        public string GetSelectedSalesAreas()
        {
            return SalesAreas.AsSeparatedList(", ");
        }

        public string GetStoredProcParams()
        {
            if (ClientEmployeeID == 0)
                ClientEmployeeID = -1;
            return string.Format(
                "exec Promotion_RequestTariffChange {0}, {1}, '{2}', '{3}'",
                ClientEmployeeID, SelectedTariff, SalesAreas.AsSeparatedIDList(" "), TariffGroups.AsSeparatedIDList(" ")
            );
        }

        public void GoBack()
        {
            if (EPState == EventPricingAppState.SendComplete || EPState == EventPricingAppState.SendFailed || EPState == EventPricingAppState.InternalError)
                EPState = EventPricingAppState.SelectTariff;
            if (EPState == EventPricingAppState.ConfirmChangeDetails)
                EPState = EventPricingAppState.SelectSalesAreas;
            else if (EPState == EventPricingAppState.SelectSalesAreas)
                EPState = EventPricingAppState.SelectGroups;
            else if (EPState == EventPricingAppState.SelectGroups)
                EPState = EventPricingAppState.SelectTariff;
            if (EPState == EventPricingAppState.SelectSalesAreas && SalesAreas.Count <= 1)
                EPState = EventPricingAppState.SelectGroups;
            if (EPState == EventPricingAppState.SelectGroups && TariffGroups.Count <= 1)
                EPState = EventPricingAppState.SelectTariff;
        }

    };


    // oh dear this is rubbish - orrible class that reads from a static member of globalclass
    // this was the only way I found to hook up an ObjectDataSource to part of a non static class
    public class RepeaterDataSource
    {
        public SelectionItemList GetTariffGroups() { return GlobalClass.Controller.GetTariffGroups(); }
        public SelectionItemList GetSalesAreas() { return GlobalClass.Controller.GetSalesAreas(); }
        public LabelItemList GetSalesAreaStatus() { return GlobalClass.Controller.GetSalesAreaStatus(); }
        public SelectionItemList GetTariffs() { return GlobalClass.Controller.GetTariffs(); }

    }


}
