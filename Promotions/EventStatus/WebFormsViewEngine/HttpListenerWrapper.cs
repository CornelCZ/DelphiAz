using System;
using System.Diagnostics;
using System.Runtime.Remoting.Lifetime;
using System.Threading.Tasks;
using System.Web;

namespace WebFormsViewEngine
{
    /// <summary>
    /// Wrapper object for passing requests and responses across the httpruntime appdomain
    /// </summary>
    public class HttpListenerWrapper : MarshalByRefObject, ISponsor
    {
        string virtualDir;
        string physicalDir;

        /// <summary>
        /// Sets the physical and virtual directories
        /// </summary>
        /// <param name="virtualDir">The virtual directory</param>
        /// <param name="physicalDir">The physical mapping of the virtual directory</param>
        public void Configure(string virtualDir, string physicalDir)
        {
            this.virtualDir = virtualDir;
            this.physicalDir = physicalDir;
        }

        /// <summary>
        /// Process the request in the httpruntime
        /// </summary>
        /// <param name="request">The proxy request object serialized across the appdomain</param>
        /// <returns>The proxy response object</returns>
        public ProxyResponse ProcessRequest(ProxyRequest request) => ProcessRequestAsync(request).Result;

        /// <summary>
        /// Response.End will throw a ThreadAbort exception as part of its correct execution, therefore run in thread so there is a thread to abort
        /// (otherwise the ThreadAbort exception must be handled in web app)
        /// </summary>
        /// <param name="request">The proxy request object serialized across the appdomain</param>
        /// <returns>The proxy response object</returns>
        async Task<ProxyResponse> ProcessRequestAsync(ProxyRequest request)
        {
            return await Task.Run(() =>
            {
                using (ProxyResponse response = new ProxyResponse())
                {
                    try
                    {
                        HttpListenerWorkerRequest workerRequest = new HttpListenerWorkerRequest(request, response, virtualDir, physicalDir);
                        HttpRuntime.ProcessRequest(workerRequest);
                    }
                    catch (Exception ex)
                    {
                        Trace.WriteLine($"RenderView error : {ex.ToString()}", "ERROR");

                        response.StatusCode = 500;
                        response.ReasonPhrase = ex.Message;
                    }
                    return response;
                }
            });
        }

        /// <summary>
        /// Renews remote session for 20 minutes
        /// </summary>
        /// <param name="lease">The existing lifetime of the remote object</param>
        /// <returns>The timespan determining the renewed lease</returns>
        public TimeSpan Renewal(ILease lease) => new TimeSpan(0, 20, 0);

        /// <summary>
        /// Register with remoting lifetime lease to ensure remote object lifetime is kept renewed
        /// </summary>
        public void Register() => (InitializeLifetimeService() as ILease).Register(this);
    }
}
