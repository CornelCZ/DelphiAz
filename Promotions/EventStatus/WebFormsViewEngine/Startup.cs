using System;
using System.IO;
using System.Reflection;
using System.Configuration;
using Owin;
using Microsoft.Owin;
using Nancy;

[assembly: OwinStartupAttribute(typeof(WebFormsViewEngine.Startup))]

namespace WebFormsViewEngine
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            app.UseNancy();
        }
    }

    public class RootPathProvider : IRootPathProvider
    {
        public string GetRootPath()
        {
            string rootPath = ConfigurationManager.AppSettings["rootPath"];
            if (string.IsNullOrEmpty(rootPath))
            {
                rootPath = @"C:\Program Files (x86)\Zonal\Aztec\Apache\htdocs\EventStatus";
            }
            return rootPath;
        }

        public string GetVirtualPath()
        {
            string virtualPath = ConfigurationManager.AppSettings["virtualPath"];
            if (string.IsNullOrEmpty(virtualPath))
            {
                virtualPath = "/Aztec/EventPricing/";
            }
            return virtualPath;
        }
    }
}
