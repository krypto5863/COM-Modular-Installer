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

		[DllExport("CMIHelperM", CallingConvention = CallingConvention.StdCall)]
		public static bool MoveOld([MarshalAs(UnmanagedType.BStr)] string path)
		{
			List<string> corefiles = new List<string>();
			corefiles.Add(@"\Sybaris");
			corefiles.Add(@"\BepinEX");
			corefiles.Add(@"\i18nEx");
			corefiles.Add(@"\IMGUITranslationLoader");
			corefiles.Add(@"\scripts");
			corefiles.Add(@"\IMG");
			corefiles.Add(@"\doorstop_config.ini");
			corefiles.Add(@"\winhttp.dll");
			corefiles.Add(@"\version.dll");
			corefiles.Add(@"\opengl32.dll");
			corefiles.Add(@"\EngSybarisArcEditor.exe");
			corefiles.Add(@"\SybarisArcEditor.exe");
			corefiles.Add(@"\CMI Documentation");
			corefiles.Add(@"\CMI.ver");
			corefiles.Add(@"\COM3D2 DlC Checker.exe");

			if (!Directory.Exists(path + @"\Oldinstall"))
			{
				if (!CMD.MakeDir(path + @"\Oldinstall"))
				{
					return false;
				}
			}

			foreach (string file in corefiles)
			{
				if (Directory.Exists(path + file) || File.Exists(path + file))
				{
					if (!CMD.Move(path + file, path + @"\Oldinstall" + file))
					{
						return false;
					}
				}
			}
			return true;
		}

		[DllExport("CMIHelperMO", CallingConvention = CallingConvention.StdCall)]
		public static bool MoveOldMod([MarshalAs(UnmanagedType.BStr)] string path)
		{
			List<string> corefiles = new List<string>();
			corefiles.Add(@"\MultipleMaidsPose");
			corefiles.Add(@"\Extra Desk Items");
			corefiles.Add(@"\Mirror_props");
			corefiles.Add(@"\PhotMot_Nei");
			corefiles.Add(@"\PhotoBG_NEI");
			corefiles.Add(@"\PhotoBG_OBJ_NEI");
			corefiles.Add(@"\Pose_sample");
			corefiles.Add(@"\[CMI]Uncensors");
			corefiles.Add(@"\[CMI]XTFutaAccessories");
			corefiles.Add(@"\[CMI]PosterLoader\");
			corefiles.Add(@"\TextureUncensors");
			corefiles.Add(@"\EmotionalEars");
			corefiles.Add(@"\CinemacicBloom_StreakPmats(SceneCapture)");


			if (!Directory.Exists(path + @"\Oldinstall\Mod"))
			{
				if (!CMD.MakeDir(path + @"\Oldinstall\Mod"))
				{
					return false;
				}
			}
			foreach (string file in corefiles)
			{
				if (Directory.Exists(path + @"\Mod" + file) || File.Exists(path + @"\Mod" + file))
				{
					if (!CMD.Move(path + @"\Mod" + file, path + @"\Oldinstall\Mod" + file))
					{
						return false;
					}
				}
			}
			return true;
		}

		[DllExport("CMIHelperOR", CallingConvention = CallingConvention.StdCall)]
		public static bool RenameOldInstall([MarshalAs(UnmanagedType.BStr)] string path)
		{
			if (Directory.Exists(path + @"\OldInstall"))
			{
				bool res = true;

				DateTime ct = Directory.GetCreationTime(path + @"\OldInstall");

				if (Directory.Exists(path + @"\OldInstall " + ct.ToString("MM.dd.yyyy.h.mm")))
				{
					res = CMD.Rename(path + @"\OldInstall", "OldInstall " + ct.ToString("MM.dd.yyyy.h.mm.ss"));
				}
				else
				{
					res = CMD.Rename(path + @"\OldInstall", "OldInstall " + ct.ToString("MM.dd.yyyy.h.mm"));
				}

				if (res == false)
				{
					return false;
				}
			}
			return true;
		}

		[DllExport("CMIHelperRO", CallingConvention = CallingConvention.StdCall)]
		public static void RemoveRO([MarshalAs(UnmanagedType.BStr)] string path)
		{
			try
			{
				var di = new DirectoryInfo(path);

				foreach (var f in di.GetFiles("*", SearchOption.AllDirectories))
				{
					f.Attributes &= ~FileAttributes.ReadOnly;
				}
			}
			catch
			{
				System.Windows.Forms.MessageBox.Show("We ran into an error while attempting to remove read-only in the path: " + path + "\n\nYou may continue the installation, though you will have to manually remove the read-only flag from your game folder.", "Error while removing Read-Only", MessageBoxButtons.OK, MessageBoxIcon.Error);
			}
		}

		[DllExport("CMIHelperRC", CallingConvention = CallingConvention.StdCall)]
		public static void ReturnConfig([MarshalAs(UnmanagedType.BStr)] string path)
		{
			if (Directory.Exists(path + "\\OldInstall\\Sybaris\\Unityinjector\\Config"))
			{
				CMD.Copy(path + "\\OldInstall\\Sybaris\\Unityinjector\\Config", path + "\\Sybaris\\Unityinjector\\Config");
			}

			if (Directory.Exists(path + "\\OldInstall\\i18nEx") && Directory.Exists(path + "\\i18nEx"))
			{
				CMD.Copy(path + "\\OldInstall\\i18nEx", path + "\\i18nEx");
			}

			if (Directory.Exists(path + "\\OldInstall\\BepinEx\\Config") && Directory.Exists(path + "\\BepinEx"))
			{
				CMD.Copy(path + "\\OldInstall\\BepinEx\\Config", path + "\\BepinEx\\Config");
			}
		}

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

		[DllExport("CMIHelperCI", CallingConvention = CallingConvention.StdCall)]
		public static bool CheckInstaller([MarshalAs(UnmanagedType.BStr)] string tpath, [MarshalAs(UnmanagedType.BStr)] string version)
		{
			string newversion = "0.0.0";

			if (File.Exists(tpath + @"\manifest.txt"))
			{

				string[] lines;

				lines = File.ReadAllLines(tpath + @"\manifest.txt");
				foreach (string line in lines)
				{
					//System.Windows.Forms.MessageBox.Show(line, "debug", MessageBoxButtons.OK);
					if (line.Contains("Installer"))
					{
						newversion = line.Replace("Installer:", "");
						break;
					}
				}

				if (Version.Parse(version) < Version.Parse(newversion))
				{
					//System.Windows.Forms.MessageBox.Show(version + " | " + newversion, "debug", MessageBoxButtons.OK);
					return true;
				}
				else
				{
					return false;
				}
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