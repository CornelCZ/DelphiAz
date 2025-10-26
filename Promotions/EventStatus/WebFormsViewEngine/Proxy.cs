using System;
using System.IO;
using System.Linq;
using System.Collections.Specialized;
using Nancy.ViewEngines;
using Nancy;

namespace WebFormsViewEngine
{

    [Serializable]
    public class Proxy : IDisposable
    {
        public NameValueCollection headers = new NameValueCollection();

        public MemoryStream stream = new MemoryStream();

        /// <summary>
        /// Dispose the memory stream
        /// </summary>
        public void Dispose()
        {
            if (stream != null)
            {
                stream.Dispose();
                stream = null;
            }
        }
    }

    [Serializable]
    public class ProxyResponse : Proxy
    {
        public string ContentType;

        public int StatusCode;

        public string ReasonPhrase;

        public byte[] data;

        public Response NancyResponse()
        {
            Response response = new Response()
            {
                Contents = stream => stream.Write(data, 0, data.Length),
                StatusCode = (HttpStatusCode)StatusCode,
                ReasonPhrase = ReasonPhrase
            };
            foreach (string key in headers)
            {
                response.Headers.Add(key, headers[key]);
            }
            return response;
        }
    }


    [Serializable]
    public class ProxyRequest : Proxy
    {
        public ProxyRequest(IRenderContext renderContext)
        {
            HttpVerbName = renderContext.Context.Request.Method;
            HttpVersion = renderContext.Context.Request.ProtocolVersion;
            LocalAddress = renderContext.Context.Request.Url.HostName;
            LocalPort = renderContext.Context.Request.Url.Port.HasValue ? renderContext.Context.Request.Url.Port.Value : 80;
            RemoteAddress = renderContext.Context.Request.UserHostAddress;
            QueryString = renderContext.Context.Request.Url.Query;
            UriPath = renderContext.Context.Request.Path;
            RawUrl = renderContext.Context.Request.Path;
            UserAgent = renderContext.Context.Request.Headers.UserAgent;
            IsSecure = renderContext.Context.Request.Url.IsSecure;
            renderContext.Context.Request.Body.CopyTo(stream);
            if (QueryString.Any() && QueryString[0] == '?')
            {
                QueryString = QueryString.Substring(1);
            }
            foreach (var header in renderContext.Context.Request.Headers)
            {
                headers.Add(header.Key, header.Value.First());
            }
        }

        public string HttpVerbName;

        public string HttpVersion;

        public string LocalAddress;

        public int LocalPort;

        public string RemoteAddress;

        public int RemotePort;

        public string QueryString;

        public string RawUrl;

        public string UriPath;

        public string UserAgent;

        public bool IsSecure;
    }

}
