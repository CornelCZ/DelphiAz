using Nancy;
using Nancy.Conventions;
using WebFormsViewEngine;

namespace EventPricingService
{
    public class MainModule : NancyModule
    {
        public MainModule()
        {
            string virtualPath = new RootPathProvider().GetVirtualPath();

            string[] views = new string[]
            {
                "SelectTariff.aspx",
                "SendInProgress.aspx",
                "InternalError.aspx",
                "ConfirmChangeDetails.aspx",
                "Preview.aspx",
                "SelectGroups.aspx",
                "SelectSalesAreas.aspx",
                "SendComplete.aspx",
                "SendFailed.aspx"
            };

            foreach(string view in views)
            {
                Get($"{virtualPath}{view}", args => View[view]);
            }
        }
    }

    public class Bootstrapper : DefaultNancyBootstrapper
    {
        protected override IRootPathProvider RootPathProvider => new RootPathProvider();

        protected override void ConfigureConventions(NancyConventions nancyConventions)
        {
            string virtualPath = new RootPathProvider().GetVirtualPath();
            nancyConventions.StaticContentsConventions.Add(StaticContentConventionBuilder.AddDirectory($"{virtualPath}Images", "Images"));
            nancyConventions.StaticContentsConventions.Add(StaticContentConventionBuilder.AddFile($"{virtualPath}EPOSStyle.css", "EPOSStyle.css"));
            base.ConfigureConventions(nancyConventions);
        }
    }
}
