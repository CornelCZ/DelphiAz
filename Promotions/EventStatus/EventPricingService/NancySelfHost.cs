using System;
using System.Reflection;
using System.IO;
using Nancy.Hosting.Self;
using WebFormsViewEngine;
using System.Security.Cryptography;
using System.Configuration;
using System.Diagnostics;

namespace EventPricingService
{
    public class NancySelfHost
    {
        NancyHost host;

        /// <summary>
        /// Start hosting Nancy service
        /// </summary>
        public void Start()
        {
            Trace.WriteLine("Service started.");

            string url = ConfigurationManager.AppSettings["url"];
            if (string.IsNullOrEmpty(url))
            {
                url = "http://localhost:50004";
            }
            Uri uri = new Uri(url);

            var provider = new RootPathProvider();
            string rootPath = provider.GetRootPath();
            string virtualPath = provider.GetVirtualPath();
            Trace.WriteLine($"{virtualPath} maps to {rootPath}");
            UpdateDll(rootPath);

            HostConfiguration config = new HostConfiguration();
            config.UrlReservations.CreateAutomatically = true; // do we want to do this?

            host = new NancyHost(uri, new Bootstrapper(), config);
            try
            {
                host.Start();
                Trace.WriteLine($"listening {uri.ToString()}...");
            }
            catch (Exception ex)
            {
                Trace.WriteLine(ex.ToString(), "ERROR");
            }
        }

        /// <summary>
        /// Stop hosting Nancy service
        /// </summary>
        public void Stop()
        {
            host.Stop();
            Trace.WriteLine("Service stopped.");
        }

        /// <summary>
        /// The HttpRuntime runs in its own appdomain, and will look for its codebase in the bin folder in the root of the virtual directory
        /// Therefore copy the dll executing the HttpRuntime into the expected location
        /// </summary>
        /// <param name="rootPath">The physical location of the virtual directory</param>
        void UpdateDll(string rootPath)
        {
            string webFormsViewEngineDll = "WebFormsViewEngine.dll";
            try
            {
                // get the path to the currently executing assembly
                string localPath = new Uri(Path.GetDirectoryName(Assembly.GetExecutingAssembly().CodeBase)).LocalPath;
                // get the path to the WebFormsViewEngine dll
                string webFormsViewEngineDllPath = Path.Combine(localPath, webFormsViewEngineDll);
                // copy the dll to the bin folder in the root of the virtual directory 
                if (File.Exists(webFormsViewEngineDllPath))
                {
                    // create virtual directory bin folder if it doesn't already exist
                    string virtualDirBinPath = Path.Combine(rootPath, "bin");
                    string virtualDirDllPath = Path.Combine(virtualDirBinPath, webFormsViewEngineDll);
                    if (!File.Exists(virtualDirDllPath))
                    {
                        // create the directory if it does not already exist
                        if (!Directory.Exists(virtualDirBinPath))
                        {
                            Directory.CreateDirectory(virtualDirBinPath);
                        }

                        // copy the dll to the bin folder if the file does not already exist
                        File.Copy(webFormsViewEngineDllPath, virtualDirDllPath);
                    }
                    else if (!CompareFiles(webFormsViewEngineDllPath, virtualDirDllPath))
                    {
                        // copy the dll to the bin folder, overwriting the existing file
                        File.Copy(webFormsViewEngineDllPath, virtualDirDllPath, true);
                    }
                }
            }
            catch (Exception ex)
            {
                Trace.WriteLine(ex.ToString(), "ERROR");
            }
        }

        /// <summary>
        /// Compares the md5 hashes of two files
        /// </summary>
        /// <param name="file1">The filepath of the first file to hash</param>
        /// <param name="file2">The filepath of the second file to hash</param>
        /// <returns>Boolean value indicating whether the two files have identical md5 hashes</returns>
        bool CompareFiles(string file1, string file2)
        {
            byte[] hash1 = Hash(file1);
            byte[] hash2 = Hash(file2);
            for (int i = 0; i < hash1.Length; i++)
            {
                if (hash1[i] != hash2[i])
                {
                    return false;
                }
            }
            return true;
        }

        /// <summary>
        /// Gets the MD5 hash of a given file
        /// </summary>
        /// <param name="file">The path of the file to hash</param>
        /// <returns>The file's md5 hash as a byte array</returns>
        byte[] Hash(string file)
        {
            using (var md5 = MD5.Create())
            {
                using (var stream = File.OpenRead(file))
                {
                    return md5.ComputeHash(stream);
                }
            }
        }
    }
}
