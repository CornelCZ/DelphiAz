using System;
using System.Configuration;
using System.Diagnostics;
using System.IO;

namespace EventPricingService
{
    public static class Log
    {
        public static void Init()
        {
            string path = ConfigurationManager.AppSettings["logPath"];
            string defaultPath = @"C:\Program Files (x86)\Zonal\Aztec\Log\AztecEventPricingService.log";
            Trace.Listeners.Clear();
            Trace.Listeners.Add(new LogTraceListener(new ValidatePath().Validate(path, defaultPath)));
            Trace.AutoFlush = true;
        }
    }

    class LogTraceListener : TextWriterTraceListener
    {
        string dir;

        public LogTraceListener(string path)
            : base(path)
        {
            dir = Path.GetDirectoryName(path);
        }

        /// <summary>
        /// Writes a message to the log. Defaults to INFO
        /// </summary>
        /// <param name="message">The message to write</param>
        public override void WriteLine(string message)
        {
            WriteLine(message, "INFO");
        }

        /// <summary>
        /// Writes a message to the log.
        /// </summary>
        /// <param name="message">The message to write</param>
        /// <param name="category">The logging level</param>
        public override void WriteLine(string message, string category)
        {
            message = $"{DateTime.Now.ToString()}\t{category}\t{message}";

            Console.WriteLine(message);

            try
            {
                if (!Directory.Exists(dir)) // create directory if it doesn't exist
                {
                    Directory.CreateDirectory(dir);
                }

                base.WriteLine(message);
            }
            catch (Exception ex)
            {
                // write to log failed
                Console.WriteLine(ex.ToString());
            }
        }
    }

    class ValidatePath
    {
        /// <summary>
        /// Validates the given path or defaults to the defaultPath
        /// </summary>
        /// <param name="path">The path to validate</param>
        /// <param name="defaultPath"></param>
        /// <returns></returns>
        public string Validate(string path, string defaultPath)
        {
            path = Validate(path);

            if (string.IsNullOrEmpty(path)) // invalid path - use the default path
            {
                path = defaultPath;
            }
            else if (string.IsNullOrEmpty(Path.GetExtension(path))) // valid path without filename - use the default path filename
            {
                path = Path.Combine(path, Path.GetFileName(defaultPath));
            }

            return path;
        }

        /// <summary>
        /// Validates the given path
        /// </summary>
        /// <param name="path">The path to validate</param>
        /// <returns>The path if it is valid or null</returns>
        private string Validate(string path)
        {
            if (string.IsNullOrEmpty(path))
            {
                return path;
            }

            Uri u;
            try
            {
                u = new Uri(path);
            }
            catch (UriFormatException)
            {
                return null;
            }

            if (!u.IsFile)
            {
                return null;
            }

            if (!Directory.Exists(Path.GetPathRoot(path)))
            {
                return null;
            }

            return u.LocalPath;
        }
    }
}
