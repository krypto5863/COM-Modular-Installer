using RGiesecke.DllExport;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace CMIHelper
{
	public class CMIHelper
	{
		[DllExport("CMIHelperSC", CallingConvention = CallingConvention.StdCall)]
		public static bool StringContains([MarshalAs(UnmanagedType.BStr)] string mainstring, [MarshalAs(UnmanagedType.BStr)] string substring) 
		{
			return mainstring.Contains(substring);
		}

		[DllExport("CMIHelperIVOT", CallingConvention = CallingConvention.StdCall)]
		public static bool IsVersionOlderThan([MarshalAs(UnmanagedType.BStr)] string VersionOld, [MarshalAs(UnmanagedType.BStr)] string VersionNew, out int Result)
		{
			try 
			{
				if (Version.Parse(VersionOld) < Version.Parse(VersionNew))
				{
					Result = 0;
					return true;
				}
				else if (Version.Parse(VersionOld) == Version.Parse(VersionNew))
				{
					Result = 1;
					return true;
				}
				else if (Version.Parse(VersionOld) > Version.Parse(VersionNew))
				{
					Result = 2;
					return true;
				}
			}
			catch 
			{
			}
			Result = 0;
			return false;
		}

		[DllExport("CMIHelperGDCT", CallingConvention = CallingConvention.StdCall)]
		public static bool GetDirectoryCreationTime([MarshalAs(UnmanagedType.BStr)] string file, [MarshalAs(UnmanagedType.BStr)] out string time) 
		{

			try
			{
				DateTime ct = Directory.GetCreationTime(file);

				time = ct.ToString("MM.dd.yyyy.h.mm.ss");
			}
			catch 
			{
				time = "";
				
				return false;
			}

			return true;
			}

		//\/\/\/\/ Old Larger Helper Code \/\/\/\/\/

		[DllExport("CMIHelperWE", CallingConvention = CallingConvention.StdCall)]
		public static bool SiteValid([MarshalAs(UnmanagedType.BStr)] string url)
		{
			try
			{
				// Creates an HttpWebRequest for the specified URL.
				HttpWebRequest myHttpWebRequest = (HttpWebRequest)WebRequest.Create(url);
				// Sends the HttpWebRequest and waits for a response.
				HttpWebResponse myHttpWebResponse = (HttpWebResponse)myHttpWebRequest.GetResponse();

				//System.Windows.Forms.MessageBox.Show("Reponse was: " + myHttpWebResponse.StatusCode.ToString(), "Debug", MessageBoxButtons.OK, MessageBoxIcon.Information);

				if (myHttpWebResponse.StatusCode == HttpStatusCode.OK)
				{
					Console.WriteLine("\r\nResponse Status Code is OK and StatusDescription is: {0}",
										 myHttpWebResponse.StatusDescription);
					return true;
				}
				// Releases the resources of the response.
				myHttpWebResponse.Close();
			}
			catch (WebException e)
			{
				Console.WriteLine("\r\nWebException Raised. The following error occurred : {0}", e.Status);
				return false;
			}
			catch (Exception e)
			{
				Console.WriteLine("\nThe following Exception was raised : {0}", e.Message);
				return false;
			}

			return false;
		}

		[DllExport("CMIHelperFLR", CallingConvention = CallingConvention.StdCall)]
		public static void FetchLatestRelease([MarshalAs(UnmanagedType.BStr)] string site,[MarshalAs(UnmanagedType.BStr)] out string h)
		{
			//System.Windows.Forms.MessageBox.Show("trying to download string from: " + site, "debug", MessageBoxButtons.OK);

			h = "null";

			try
			{
				ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
				WebClient webClient = new WebClient();
				webClient.Headers.Add("User-Agent: Other");

				string[] textFromFile = webClient.DownloadString(site).Split(',');


				//System.Windows.Forms.MessageBox.Show("String downloaded" + site, "debug", MessageBoxButtons.OK);

				foreach (string s in textFromFile)
				{
					//System.Windows.Forms.MessageBox.Show(s, "debug", MessageBoxButtons.OK);

					if (s.Contains("browser_download_url"))
					{
						h = s.Replace("\"browser_download_url\":\"", "");
						h = h.Replace("\"}]", "");
						break;
					}
				}

			}
			catch (Exception e)
			{
				System.Windows.Forms.MessageBox.Show(e.ToString(), "Error", MessageBoxButtons.OK);
				throw;
			}
		}
	}
}