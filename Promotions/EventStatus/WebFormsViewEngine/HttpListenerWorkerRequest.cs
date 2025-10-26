using System;
using System.Web;
using System.Linq;
using System.IO;

namespace WebFormsViewEngine
{
    /// <summary>
    /// HttpWorkerRequest implementation for POST requests
    /// </summary>
    public class HttpListenerWorkerRequest : HttpWorkerRequest
    {
        ProxyRequest request;
        ProxyResponse response;

        string virtualDir;
        string physicalDir;

        public HttpListenerWorkerRequest(ProxyRequest request, ProxyResponse response, string virtualDir, string physicalDir)
        {
            this.request = request;
            this.response = response;
            this.virtualDir = virtualDir;
            this.physicalDir = physicalDir;
        }

        public override void EndOfRequest()
        {
            response.data = response.stream.ToArray();
            response.Dispose(); // close the stream now it's written to the data buffer
        }

        public override void FlushResponse(bool finalFlush) => response.stream.Flush();

        public override string GetHttpVerbName() => request.HttpVerbName;

        public override string GetHttpVersion() => request.HttpVersion;

        public override string GetLocalAddress() => request.LocalAddress;

        public override int GetLocalPort() => request.LocalPort;

        public override string GetQueryString() => request.QueryString;

        public override string GetRawUrl() => request.RawUrl;

        public override string GetRemoteAddress() => request.RemoteAddress;

        public override int GetRemotePort() => request.RemotePort;

        public override string GetUriPath() => request.UriPath;


        // ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        public override void SendKnownResponseHeader(int index, string value) => response.headers.Add(HttpWorkerRequest.GetKnownResponseHeaderName(index), value);

        public override void SendResponseFromMemory(byte[] data, int length) => response.stream.Write(data, 0, length);

        public override void SendStatus(int statusCode, string statusDescription)
        {
            response.StatusCode = statusCode;
            response.ReasonPhrase = statusDescription;
        }

        public override void SendUnknownResponseHeader(string name, string value) => response.headers.Add(name, value);

        public override void SendResponseFromFile(IntPtr handle, long offset, long length) { }

        public override void SendResponseFromFile(string filename, long offset, long length) { }

        public override void CloseConnection() { }

        public override string GetAppPath() => virtualDir;

        public override string GetAppPathTranslated() => physicalDir;

        public override int ReadEntityBody(byte[] buffer, int size) => request.stream.Read(buffer, 0, size);

        public override string GetUnknownRequestHeader(string name) => request.headers[name];

        public override string[][] GetUnknownRequestHeaders() =>
            (from string name in request.headers
             where GetKnownRequestHeaderIndex(name) == -1
             select new string[] { name, request.headers[name] }).ToArray();

        public override string GetKnownRequestHeader(int index)
        {
            switch (index)
            {
                case HeaderUserAgent: return request.UserAgent;
                default: return request.headers[GetKnownRequestHeaderName(index)];
            }
        }

        public override string GetServerVariable(string name)
        {
            switch (name)
            {
                case "HTTPS": return request.IsSecure ? "on" : "off";
                case "HTTP_USER_AGENT": return request.headers["UserAgent"];
                default: return null;
            }
        }

        public override string GetFilePath()
        {
            // TODO: this is a hack
            string path = request.RawUrl;
            string aspx = ".aspx";
            string asmx = ".asmx";
            int i;

            i = path.IndexOf(aspx);
            if (i > -1)
            {
                return path.Substring(0, i + aspx.Length);
            }

            i = path.IndexOf(asmx);
            if (i > -1)
            {
                return path.Substring(0, i + asmx.Length);
            }

            return path;
        }

        public override string GetFilePathTranslated() => physicalDir + GetFilePath().Substring(virtualDir.Length).Replace('/', '\\');

        public override string GetPathInfo()
        {
            string filePath = GetFilePath();
            string localPath = request.RawUrl;
            if (filePath.Length == localPath.Length)
            {
                return string.Empty;
            }
            return localPath.Substring(filePath.Length);
        }
    }

}
