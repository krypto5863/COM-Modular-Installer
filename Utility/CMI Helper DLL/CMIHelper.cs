using Knyaz.Optimus;
using System;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.InteropServices;

// ReSharper disable UnusedMember.Global

namespace CMIHelper
{
	public static class CmiHelper
	{
		private static readonly Engine MainEngine = EngineBuilder.New().Build();
		//private static DateTimeOffset _apiLimitResetTime;
		//private static bool _warnedOfLimit;

		static CmiHelper ()
		{
			Log("CMIHelper has initialized!");
			try
			{
				File.Delete(Environment.CurrentDirectory + "\\CMIHelperLog.txt");
			} 
			catch 
			{ 
				//Ignored, sorta like a TryDelete
			}
		}

		[DllExport("CMIHelperSC", CallingConvention = CallingConvention.StdCall)]
		public static bool StringContains([MarshalAs(UnmanagedType.BStr)] string mainString, [MarshalAs(UnmanagedType.BStr)] string substring)
		{
			var result = mainString.Contains(substring);
			Log($"{mainString} has {substring} == {result}");
			return mainString.Contains(substring);
		}

		[DllExport("CMIHelperIVOT", CallingConvention = CallingConvention.StdCall)]
		public static bool IsVersionOlderThan([MarshalAs(UnmanagedType.BStr)] string versionOld, [MarshalAs(UnmanagedType.BStr)] string versionNew, out int result)
		{
			try
			{
				if (Version.Parse(versionOld) < Version.Parse(versionNew))
				{
					result = 0;
					return true;
				}

				if (Version.Parse(versionOld) == Version.Parse(versionNew))
				{
					result = 1;
					return true;
				}

				if (Version.Parse(versionOld) > Version.Parse(versionNew))
				{
					result = 2;
					return true;
				}
			}
			catch
			{
				// ignored
			}

			result = 0;
			return false;
		}

		[DllExport("CMIHelperGDCT", CallingConvention = CallingConvention.StdCall)]
		public static bool GetDirectoryCreationTime([MarshalAs(UnmanagedType.BStr)] string file, [MarshalAs(UnmanagedType.BStr)] out string time)
		{
			try
			{
				var ct = Directory.GetCreationTime(file);

				time = ct.ToString("MM.dd.yyyy.h.mm.ss");
			}
			catch
			{
				time = "";

				return false;
			}

			return true;
		}

		[DllExport("CMIHelperFF", CallingConvention = CallingConvention.StdCall)]
		public static bool FindFile([MarshalAs(UnmanagedType.BStr)] string file, [MarshalAs(UnmanagedType.BStr)] string directory, [MarshalAs(UnmanagedType.BStr)] out string path)
		{
			var files = Directory.GetFiles(directory, file, SearchOption.AllDirectories);

			if (files.Length > 0)
			{
				path = files[0];
				return true;
			}

			path = null;
			return false;
		}

		[DllExport("CMIHelperWE", CallingConvention = CallingConvention.StdCall)]
		public static bool SiteValid([MarshalAs(UnmanagedType.BStr)] string url)
		{
			try
			{
				// Creates an HttpWebRequest for the specified URL.
				var myHttpWebRequest = (HttpWebRequest)WebRequest.Create(url);
				// Sends the HttpWebRequest and waits for a response.
				var myHttpWebResponse = (HttpWebResponse)myHttpWebRequest.GetResponse();

				if (myHttpWebResponse.StatusCode == HttpStatusCode.OK)
				{
					Console.WriteLine($"\r\nResponse Status Code is OK and StatusDescription is: {myHttpWebResponse.StatusDescription}");
					return true;
				}
				// Releases the resources of the response.
				myHttpWebResponse.Close();
			}
			catch (WebException e)
			{
				Log($"\r\nWebException Raised. The following error occurred : {e.Status}");
				return false;
			}
			catch (Exception e)
			{
				Log($"\nThe following Exception was raised : {e.Message}");
				return false;
			}

			return false;
		}

		[DllExport("CMIHelperGLU", CallingConvention = CallingConvention.StdCall)]
		public static void FetchLatestGameUpdate([MarshalAs(UnmanagedType.BStr)] string url, [MarshalAs(UnmanagedType.BStr)] out string downloadLink)
		{

			//Request the web page.
			var page = MainEngine.OpenUrl(url);
			if (page.Wait(10000) == false)
			{
				Log($"Timed out waiting for {url} to open.");
				downloadLink = string.Empty;
				return;
			}

			var document = page.Result.Document;
			var button = document.GetElementsByClassName("spec_in").First().GetElementsByTagName("p")[0];

			downloadLink = button.TextContent.Trim();

		}

		/*
		[DllExport("CMIHelperFLV", CallingConvention = CallingConvention.StdCall)]
		public static void FetchLatestGhVersion([MarshalAs(UnmanagedType.BStr)] string site, [MarshalAs(UnmanagedType.BStr)] out string version)
		{
			Log($"Fetching latest GH version of {site}");

			var url = "https://api.github.com/repos/" + site + "/releases/latest";

			version = "";

			try
			{
				var doesHaveMoreInQuota = HasMoreInQuota();

				GhRest.Release jsonFile;

				if ((LinkCacheFile.CachedJsonResponses.TryGetValue(url, out var result) && (DateTimeOffset.Now - result.Item2).TotalMinutes < 30) || doesHaveMoreInQuota == false)
				{
					Log("Loading cached API response!");

					jsonFile = JsonConvert.DeserializeObject<GhRest.Release>(result.Item1);
				}
				else if (doesHaveMoreInQuota)
				{
					Log("No cached responses! Grabbing!");

					ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
					var webClient = new WebClient();
					webClient.Headers.Add("User-Agent: Other");

					var jsonString = webClient.DownloadString(url);

					jsonFile = JsonConvert.DeserializeObject<GhRest.Release>(jsonString);

					Log("Fetched! Saving to cache...");

					LinkCacheFile.AddResponse(url, jsonString);
				}
				else
				{
					Log("No cached responses and no more quota! Failure!");
					return;
				}

				version = jsonFile.tag_name;
				Log($"Returning: {version}");
			}
			catch (Exception e)
			{
				MessageBox.Show(e.ToString(), "Error", MessageBoxButtons.OK);
			}
		}

		public static void GhReleaseFetch([MarshalAs(UnmanagedType.BStr)] string site, [MarshalAs(UnmanagedType.BStr)] string searchString, [MarshalAs(UnmanagedType.BStr)] string version, [MarshalAs(UnmanagedType.BStr)] out string downloadLink)
		{
			downloadLink = string.Empty;

			try
			{
				var myUri = new Uri($"https://github.com/{site}/releases"
									+ (string.IsNullOrEmpty(version) ? "" : $"/tag/{version}"));

				Log($"Opening URL: {myUri}");

				//Request the web page.
				var page = MainEngine.OpenUrl(myUri.AbsoluteUri);
				if (page.Wait(10000) == false)
				{
					Log($"Timed out waiting for {myUri} to open. Falling back to GitHub API");
					goto Timeout;
				}

				Log("URL loaded. Searching for elements.");

				//Get the document
				var document = page.Result.Document;

				MainEngine.DumpToFile($"C:\\SomeUnfullfilled.html");

				var hrefs = document.GetElementsByTagName("a")
					.Where(a => a.HasAttribute(("href")));

				Log("Link in document are as follows:");

				foreach (var link in hrefs)
				{
					Log(link.GetAttribute("href").Trim());
				}

				var releaseCards = document
					.GetElementsByTagName("div")
					.Where(t => t.HasAttribute("data-test-selector") && t.GetAttribute("data-test-selector").Equals("release-card"))
					.ToArray();

				if (!releaseCards.Any())
				{
					Log("Failure to fetch any release cards! Falling back to API!");
				}

				foreach (var releaseCard in releaseCards)
				{
					var assetsSection = releaseCard
						.GetElementsByTagName("div")
						.LastOrDefault(a => a.TextContent.Contains("Assets"));

					var assetLinks = assetsSection?
						.GetElementsByTagName("a")
						.Where(tl => tl.HasAttribute("href") && !tl.GetAttribute("href").Contains("/archive/refs/"))
						.ToArray();

					if (assetLinks != null && !assetLinks.Any())
					{
						continue;
					}

					var dlLink = "";

					if (!string.IsNullOrEmpty(searchString))
					{
						var linkNode = assetLinks?.FirstOrDefault(lt => lt.TextContent.Trim().Contains(searchString));

						if (linkNode != null)
						{
							dlLink = "https://" + myUri.Host + linkNode.GetAttribute("href");
						}
					}
					else
					{
						if (assetLinks != null)
						{
							dlLink = assetLinks
								.First()
								.GetAttribute("href");
						}

						dlLink = "https://" + myUri.Host + dlLink;
					}

					if (!string.IsNullOrEmpty(dlLink))
					{
						Log($"Element spotted... Returning {dlLink}");
						downloadLink = dlLink;
						return;
					}
				}
			}
			catch (Exception e)
			{
				Log($"\nThe following Exception was raised trying to crawl GitHub. Will fallback to official API : {e.Message}");
			}

			Timeout:

			if (!string.IsNullOrEmpty(downloadLink))
			{
				return;
			}

			Log("Failed to fetch versions dynamically! Falling back to API!");
			DynaFetchGhRelease(site, searchString, version, out downloadLink);
			Log($"API returns {downloadLink}");
			
		}

		//Was originally just a fallback but it's the functioning method again.
		[DllExport("CMIHelperGHRF", CallingConvention = CallingConvention.StdCall)]
		public static void DynaFetchGhRelease([MarshalAs(UnmanagedType.BStr)] string site, [MarshalAs(UnmanagedType.BStr)] string searchString, [MarshalAs(UnmanagedType.BStr)] string version, [MarshalAs(UnmanagedType.BStr)] out string downloadLink)
		{
			var url = "https://api.github.com/repos/" + site + "/releases";

			downloadLink = string.Empty;

			Log($"Dynamically fetching release in: {url}");

			try
			{
				var doesHaveMoreInQuota = HasMoreInQuota();

				JArray jsonFile;

				if ((LinkCacheFile.CachedJsonResponses.TryGetValue(url, out var result) && (DateTimeOffset.Now - result.Item2).TotalMinutes < 30) || doesHaveMoreInQuota == false)
				{
					jsonFile = JArray.Parse(result.Item1);
				}
				// ReSharper disable once ConditionIsAlwaysTrueOrFalse, it's capping.
				else if (doesHaveMoreInQuota)
				{
					ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
					var webClient = new WebClient();
					webClient.Headers.Add("User-Agent: Other");

					var jsonString = webClient.DownloadString(url);
					jsonFile = JArray.Parse(jsonString);

					LinkCacheFile.AddResponse(url, jsonString);
				}
				else
				{
					return;
				}

				foreach (var release in jsonFile)
				{
					var deSerAsset = release.ToObject<GhRest.Release>();

					if (string.IsNullOrWhiteSpace(version) == false && version.Equals(deSerAsset.tag_name) == false)
					{
						continue;
					}

					foreach (var asset in deSerAsset.assets)
					{
						if (!string.IsNullOrWhiteSpace(searchString) &&
							!asset.name.ToLower().Contains(searchString.ToLower()))
						{
							continue;
						}

						downloadLink = asset.browser_download_url;

						Log($"Returning: {downloadLink}");

						return;
					}
				}
			}
			catch (Exception e)
			{
				MessageBox.Show(e.ToString(), "Error", MessageBoxButtons.OK);
			}
		}

		public static bool HasMoreInQuota()
		{
			ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
			var webClient = new WebClient();
			webClient.Headers.Add("User-Agent: Other");

			var jsonFile = JsonConvert.DeserializeObject<APIRateLimitResponse>(webClient.DownloadString("https://api.github.com/rate_limit"));

			_apiLimitResetTime = DateTimeOffset.FromUnixTimeSeconds(jsonFile.resources.core.reset);

			if (jsonFile.resources.core.remaining <= 0)
			{
				if (_warnedOfLimit == false)
				{
					MessageBox.Show(
						$"You have reached the GitHub API limit! All online components will fail to properly download!\n\nThe limit resets at: {_apiLimitResetTime.ToLocalTime()}",
						"Error", MessageBoxButtons.OK);
					Log(
						$"User has hit the API Limit! Their limit will reset at {_apiLimitResetTime.ToLocalTime()}");
				}

				_warnedOfLimit = true;

				return false;
			}

			return true;
		}
		*/


		internal static void Log(string message)
		{
			File.AppendAllText(Environment.CurrentDirectory + "\\CMIHelperLog.txt", DateTimeOffset.Now + " :: " + message + "\n");
		}
	}
}