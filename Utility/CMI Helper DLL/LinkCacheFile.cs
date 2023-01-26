using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace CMIHelper
{
	internal static class LinkCacheFile
	{
		public static Dictionary<string, (string, DateTimeOffset)> CachedJsonResponses;
		static LinkCacheFile()
		{
			if (File.Exists(Environment.CurrentDirectory + "\\CMILinkCache.json"))
			{
				CmiHelper.Log($"CMILinkCache is found! " + Environment.CurrentDirectory + "\\CMILinkCache.json");

				var jsonFile = File.ReadAllText(Environment.CurrentDirectory + "\\CMILinkCache.json");
				var cachedObject = JsonConvert.DeserializeObject<Dictionary<string, (string, DateTimeOffset)>>(jsonFile);
				CachedJsonResponses = cachedObject;
				return;
			}

			CachedJsonResponses = new Dictionary<string, (string, DateTimeOffset)>();
		}

		public static void AddResponse(string site, string response)
		{
			CachedJsonResponses[site] = (response, DateTimeOffset.Now);
			File.WriteAllText(Environment.CurrentDirectory + "\\CMILinkCache.json", JsonConvert.SerializeObject((CachedJsonResponses)));
		}
	}
}
