using Knyaz.Optimus;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Reflection;
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

		[DllExport("CMIHelperGLU", CallingConvention = CallingConvention.StdCall)]
		public static void FetchLatestGameUpdate([MarshalAs(UnmanagedType.BStr)] string url, [MarshalAs(UnmanagedType.BStr)] out string downloadLink)
		{
			var engine = EngineBuilder.New()
			.Build(); // Builds the Optimus engine.

			//Request the web page.
			var page = engine.OpenUrl(url);
			page.Wait();

			var document = page.Result.Document;
			var button = document.GetElementsByClassName("spec_in").First().GetElementsByTagName("p")[0];

			downloadLink = button.TextContent.Trim();
			engine.Dispose();
		}

		[DllExport("CMIHelperFLV", CallingConvention = CallingConvention.StdCall)]
		public static void FetchLatestGHVersion([MarshalAs(UnmanagedType.BStr)] string site, [MarshalAs(UnmanagedType.BStr)] out string version)
		{
			var url = "https://api.github.com/repos/" + site + "/releases/latest";

			version = "";

			try
			{
				ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
				WebClient webClient = new WebClient();
				webClient.Headers.Add("User-Agent: Other");

				var Release = JsonConvert.DeserializeObject<GHRest.Release>(webClient.DownloadString(url));

				version = Release.tag_name;
			}
			catch (Exception e)
			{
				System.Windows.Forms.MessageBox.Show(e.ToString(), "Error", MessageBoxButtons.OK);
			}
		}

		[DllExport("CMIHelperFLR", CallingConvention = CallingConvention.StdCall)]
		public static void FetchLatestGHRelease([MarshalAs(UnmanagedType.BStr)] string site, [MarshalAs(UnmanagedType.BStr)] string searchString, [MarshalAs(UnmanagedType.BStr)] out string downloadLink)
		{
			var url = "https://api.github.com/repos/" + site + "/releases/latest";

			downloadLink = "";

			try
			{
				ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
				WebClient webClient = new WebClient();
				webClient.Headers.Add("User-Agent: Other");

				var Release = JsonConvert.DeserializeObject<GHRest.Release>(webClient.DownloadString(url));

				foreach (var Asset in Release.assets)
				{
					if (String.IsNullOrWhiteSpace(searchString) || Asset.name.ToLower().Contains(searchString.ToLower()))
					{
						downloadLink = Asset.browser_download_url;
						return;
					}
				}
			}
			catch (Exception e)
			{
				System.Windows.Forms.MessageBox.Show(e.ToString(), "Error", MessageBoxButtons.OK);
			}
		}

		[DllExport("CMIHelperDF", CallingConvention = CallingConvention.StdCall)]
		public static void DynaFetchGHRelease([MarshalAs(UnmanagedType.BStr)] string site, [MarshalAs(UnmanagedType.BStr)] string searchString, [MarshalAs(UnmanagedType.BStr)] string version, [MarshalAs(UnmanagedType.BStr)] out string downloadLink)
		{
			var url = "https://api.github.com/repos/" + site + "/releases";

			downloadLink = "";

			try
			{
				ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
				WebClient webClient = new WebClient();
				webClient.Headers.Add("User-Agent: Other");

				var JsonFile = JArray.Parse(webClient.DownloadString(url));

				foreach (var release in JsonFile)
				{
					var DeSerAsset = release.ToObject<GHRest.Release>();

					if ((String.IsNullOrWhiteSpace(version) || version.Equals(DeSerAsset.tag_name)) == false)
					{
						continue;
					}

					foreach (var Asset in DeSerAsset.assets)
					{
						if (String.IsNullOrWhiteSpace(searchString) || Asset.name.ToLower().Contains(searchString.ToLower()))
						{
							downloadLink = Asset.browser_download_url;
							return;
						}
					}
				}
			}
			catch (Exception e)
			{
				System.Windows.Forms.MessageBox.Show(e.ToString(), "Error", MessageBoxButtons.OK);
			}
		}
	}
}