using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Hosting;
using System.IO;
using Nancy;
using Nancy.ViewEngines;
using System.Threading;
using System.Threading.Tasks;
using System.Runtime.Remoting.Lifetime;
using System.Diagnostics;

namespace WebFormsViewEngine
{

    /// <summary>
    /// Implements Nancy.IViewEngine to host ASP.NET Web Forms
    /// </summary>
    public class WebFormsViewEngine : IViewEngine
    {
        static HttpListenerWrapper listener;

        /// <summary>
        /// ASP.NET file extensions supported by the httpruntime (should be all appropriate file extensions not just aspx and asmx)
        /// </summary>
        public IEnumerable<string> Extensions => new string[] { "aspx", "asmx" };

        /// <summary>
        /// Initializes a new appdomain for the httpruntime via a wrapper object
        /// </summary>
        /// <param name="context"></param>
        public void Initialize(ViewEngineStartupContext context)
        {
            var provider = new RootPathProvider();
            string rootPath = provider.GetRootPath();
            string virtualPath = provider.GetVirtualPath();
            listener = ApplicationHost.CreateApplicationHost(typeof(HttpListenerWrapper), virtualPath, rootPath) as HttpListenerWrapper;
            listener.Configure(virtualPath, rootPath);
            listener.Register();
        }

        /// <summary>
        /// Renders ASP.NET pages 
        /// </summary>
        /// <param name="viewLocationResult"></param>
        /// <param name="model"></param>
        /// <param name="renderContext">contains the request</param>
        /// <returns>The rendered ASP.NET page</returns>
        public Response RenderView(ViewLocationResult viewLocationResult, dynamic model, IRenderContext renderContext)
        {
            Trace.WriteLine($"{renderContext.Context.Request.Method} {renderContext.Context.Request.Url} {renderContext.Context.Request.ProtocolVersion}", "INFO");

            try
            {
                // create a proxy request from the Nancy request to be serialized across the httpruntime appdomain
                using (ProxyRequest request = new ProxyRequest(renderContext))
                {
                    // get the proxy response back from httpruntime appdomain
                    using (ProxyResponse response = listener.ProcessRequest(request))
                    {
                        // create the Nancy response from the proxy response
                        var nancyResponse = response.NancyResponse();
                        Trace.WriteLine($"{(int)nancyResponse.StatusCode} {nancyResponse.StatusCode.ToString()}", "INFO");
                        return nancyResponse;
                    }
                }
            }
            catch(Exception ex)
            {
                Trace.WriteLine($"RenderView error : {ex.ToString()}", "ERROR");

                return new Response
                {
                    StatusCode = HttpStatusCode.InternalServerError,
                    ReasonPhrase = ex.Message
                };
            }
        }

    }
}
