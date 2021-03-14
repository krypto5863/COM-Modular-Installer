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
		[DllExport("CMIHelper", CallingConvention = CallingConvention.StdCall)]
		public static int VersionCheck([MarshalAs(UnmanagedType.BStr)] string path, int ver)
		{

			//0 is fail, no update. 1 is success. 2 is empty folder. 3 is update required.

			if (path.Contains(@"\Downloads"))
			{
				System.Windows.Forms.MessageBox.Show("It seems your game is located in the Downloads directory, this can cause issues with UAC and lead to improper CMI installs! Please move it somewhere safer (Example: C:/KISS/COM3D2)", "Unsafe Game Location", MessageBoxButtons.OK, MessageBoxIcon.Error);
				return 0;
			}
			else if (path.Contains(@"Program Files") && path.Contains(@"Steam") == false)
			{
				System.Windows.Forms.MessageBox.Show("It seems your game is located in the Program Files directory, this can cause issues with UAC and lead to improper CMI installs! Please move it somewhere safer (Example: C:/KISS/COM3D2)", "Unsafe Game Location", MessageBoxButtons.OK, MessageBoxIcon.Error);
				return 0;
			}

			//path = @"D:\KISS\COM3D2";
			//System.Windows.Forms.MessageBox.Show("Starting function with params"+@path+" "+ver, "Caption Here!", MessageBoxButtons.OK);
			string file = @"COM3D2x64_Data\Managed\Assembly-CSharp.dll";
			if (File.Exists(@path + @"\update.lst") && File.Exists(@path + @"\COM3D2x64.exe"))
			{

				string[] lines = File.ReadAllLines(@path + @"\update.lst");
				//System.Windows.Forms.MessageBox.Show("Trying to read " + @path + @"\update.lst", "Caption Here!", MessageBoxButtons.OK);
				// System.Windows.Forms.MessageBox.Show("This is the first string: " + lines[0], "Caption Here!", MessageBoxButtons.OK);
				foreach (string line in lines)
				{
					if (line.Contains(file))
					{
						string gver = line;
						//System.Windows.Forms.MessageBox.Show("We found the line!", "Caption Here!", MessageBoxButtons.OK);
						try
						{

							String res = gver.Remove(0, 43);
							//System.Windows.Forms.MessageBox.Show(res, "Caption Here!", MessageBoxButtons.OK);
							int ngver = Int32.Parse(res);


							if (ver <= ngver)
							{
								System.Windows.Forms.MessageBox.Show("Your game version was successfully checked and you are on an acceptable version!\n\nFound Version: " + ngver, "Version Check Success!", MessageBoxButtons.OK, MessageBoxIcon.Information);
								return 1;
							}
							else
							{
								System.Windows.Forms.MessageBox.Show("Your game is outdated! Update your game!\n\nYour game version was successfully checked and you are not on an acceptable version!\n\nExpected Version: " + ver + " or higher\nFound Version: " + ngver, "Game is outdated! Update!", MessageBoxButtons.OK, MessageBoxIcon.Error);
								return 3;
							}
						}
						catch (FormatException)
						{
							System.Windows.Forms.MessageBox.Show("Whoops, an exception was thrown..", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
						}
					}
				}
			}

			if (File.Exists(@path + @"\CM3D2.exe"))
			{
				System.Windows.Forms.MessageBox.Show("This is CM3D2 not COM3D2! CMI was not made for CM3D2! For CM3D2, please use Legacy Meido's Modular Toolbox (LMMT)", "Wrong Game!", MessageBoxButtons.OK, MessageBoxIcon.Error);
				return 0;
			}

			if (File.Exists(@path + @"\update.lst") && File.Exists(@path + @"\COM3D2x64.exe"))
			{
				System.Windows.Forms.MessageBox.Show("While we managed to find the Update.lst file, the assembly version could not be found! If you are on the Japanese version, this is a real problem! Please update immediately!", "Version Check Failed!", MessageBoxButtons.OK, MessageBoxIcon.Error);
				return 3;
			}

			if (!File.Exists(@path + @"\update.lst") && File.Exists(@path + @"\COM3D2x64.exe"))
			{
				System.Windows.Forms.MessageBox.Show("While this appears to be a game folder, there is no Update.lst file! This is very bad!\n\nPlease update your game immediately and ensure that your game is functioning before attempting to install CMI again.", "Missing Update.lst", MessageBoxButtons.OK, MessageBoxIcon.Error);
				return 3;
			}

			var result = System.Windows.Forms.MessageBox.Show("This does not appear to be a COM3d2 Directory! We can still continue the installation but you may be installing to the wrong directory, some functions will also be rendered ineffectual. Do we continue anyways?", "Wrong Directory!", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
			// If the no button was pressed ...
			if (result == DialogResult.No)
			{
				return 0;
			}
			if (result == DialogResult.Yes)
			{
				return 2;
			}
			return 0;
		}

		//[DllExport("CMIHelperC", CallingConvention = CallingConvention.StdCall)]
		//public static bool ConfigReplace([MarshalAs(UnmanagedType.BStr)] string path)
		//{
		//    if (File.Exists(@path + @"\Sybaris\Unityinjector\Config"))
		//    {
		//        try
		//        {
		//            CopyDirectory(){ }
		//        }
		//        catch (IOException)
		//        {

		//        }

		//    }
		//}

		[DllExport("CMIHelperIN", CallingConvention = CallingConvention.StdCall)]
		public static bool INMCheck([MarshalAs(UnmanagedType.BStr)] string path)
		{

			string msg = "We found some files that belong in INM but other files are missing indicating this is actually a JP game!\n\nThis is possibly dangerous and if you have not installed english version DLC and your game is not of any english version, please fix your game now... Otherwise, if your game is an english version, then you are missing files! In any case, refer to the readme on fixing instructions and continue at your own risk!";

			if (File.Exists(@path + @"\GameData\product.arc") && File.Exists(@path + @"\GameData\language.arc"))
			{
				if (!File.Exists(@path + @"\GameData\system_en.arc") && !File.Exists(@path + @"\GameData\bg-en.arc"))
				{
					if (File.Exists(@path + @"\localize.dat"))
					{
						System.Windows.Forms.MessageBox.Show("INM was found! Modular does not officially support INM due to known incompatibilities. Please install the R18(Adult) patch if you wish to use this installer. If your game is not actually INM, please refer to the readme for a fix.", "INM was found!", MessageBoxButtons.OK, MessageBoxIcon.Error);
						return false;
					}
					else
					{
						System.Windows.Forms.MessageBox.Show(msg, "Possible use of INM files in JP Game!", MessageBoxButtons.OK, MessageBoxIcon.Error);
						return true;
					}
				}
				else if (!File.Exists(@path + @"\GameData\system_en.arc") ^ !File.Exists(@path + @"\GameData\bg-en.arc"))
				{
					System.Windows.Forms.MessageBox.Show(msg, "Possible use of INM files in JP Game!", MessageBoxButtons.OK, MessageBoxIcon.Error);
					return true;
				}
			}
			else if (File.Exists(@path + @"\GameData\product.arc") || File.Exists(@path + @"\GameData\language.arc"))
			{
				System.Windows.Forms.MessageBox.Show(msg, "Possible use of INM files in JP Game!", MessageBoxButtons.OK, MessageBoxIcon.Error);
				return true;
			}
			//System.Windows.Forms.MessageBox.Show("Game type was checked! JP version was found!!", "Caption Here!", MessageBoxButtons.OK);
			return true;
		}

		/*		[DllExport("CMIHelperT", CallingConvention = CallingConvention.StdCall)]
				public static bool TypeCheck([MarshalAs(UnmanagedType.BStr)] string path)
				{
					//path = @"D:\KISS\COM3D2";
					if (File.Exists(@path + @"\GameData\product.arc") || File.Exists(@path + @"\GameData\language.arc"))
					{
						System.Windows.Forms.MessageBox.Show("If you are not on an English version of the game quit the install right now and refer to the readme!!\n\nEnglish version was found!! Be advised, English versions are not as feature full or as supported as the Japanese version!", "English!", MessageBoxButtons.OK, MessageBoxIcon.Warning);
						var result = System.Windows.Forms.MessageBox.Show("Some components here can be harmful or incompatible to your English game. Should we disable these components in order to keep you safe?", "Disable components?", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
						if (result == DialogResult.No)
						{
							return true;
						}
						else if (result == DialogResult.Yes)
						{
							return false;
						}
					}
					//System.Windows.Forms.MessageBox.Show("Game type was checked! JP version was found!!", "Caption Here!", MessageBoxButtons.OK);
					return true;
				}*/

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

		[DllExport("CMIHelperPR", CallingConvention = CallingConvention.StdCall)]
		public static int IsInPreset([MarshalAs(UnmanagedType.BStr)] string path, [MarshalAs(UnmanagedType.BStr)] string ent, [MarshalAs(UnmanagedType.BStr)] out string strout)
		{

			ent = ent.Remove(ent.Length - 1, 1);

			string[] opt = ent.Split('|');

			string res = "";


			//System.Windows.Forms.MessageBox.Show("Was Called for " + ent, "debug", MessageBoxButtons.OK);
			try
			{
				if (File.Exists(path))
				{

					string[] lines = File.ReadAllLines(path);
					foreach (string o in opt)
					{
						foreach (string s in lines)
						{
							//System.Windows.Forms.MessageBox.Show("Comparing " + s + " to " + ent, "debug", MessageBoxButtons.OK);
							if (s.Equals(o))
							{
								//System.Windows.Forms.MessageBox.Show("Was equal!", "debug", MessageBoxButtons.OK);
								res += (Array.IndexOf(opt, o) - 1 + "|");
							}
						}
					}
				}
			}
			catch (Exception e)
			{
				System.Windows.Forms.MessageBox.Show("Encountered an error while reading the CMI Preset File! Delete the CMI Preset file in your game folder if the error persists!\n\n" + e.ToString(), "Error Reading the CMI Preset!", MessageBoxButtons.OK, MessageBoxIcon.Error);
			}
			res = res.Remove(res.Length - 1, 1);
			strout = res;

			//System.Windows.Forms.MessageBox.Show("returning " + strout, "debug", MessageBoxButtons.OK);

			if (res.Count() == 0)
			{
				return 0;
			}

			return 1;
		}
		[DllExport("CMIHelperRC", CallingConvention = CallingConvention.StdCall)]
		public static void ReturnConfig([MarshalAs(UnmanagedType.BStr)] string path)
		{

			//FileInfo[] files;

			if (Directory.Exists(path + "\\OldInstall\\Sybaris\\Unityinjector\\Config"))
			{

				//System.Windows.Forms.MessageBox.Show("Fetching files for config", "debug", MessageBoxButtons.OK);

				//files = Directory.GetFiles(path + "\\OldInstall\\Sybaris\\Unityinjector\\Config", "*", SearchOption.AllDirectories).Select(x => new FileInfo(x)).ToArray();

				//System.Windows.Forms.MessageBox.Show("Fetched!", "debug", MessageBoxButtons.OK);

				CMD.Copy(path + "\\OldInstall\\Sybaris\\Unityinjector\\Config", path + "\\Sybaris\\Unityinjector\\Config");
			}

			if (Directory.Exists(path + "\\OldInstall\\i18nEx") && Directory.Exists(path + "\\i18nEx"))
			{

				//System.Windows.Forms.MessageBox.Show("Fetching files for i18nEx", "debug", MessageBoxButtons.OK);

				//files = Directory.GetFiles(path + "\\OldInstall\\i18nEx", "*", SearchOption.AllDirectories).Select(x => new FileInfo(x)).ToArray();

				//System.Windows.Forms.MessageBox.Show("Both paths exist, putting i18nex stuff back.", "debug", MessageBoxButtons.OK);

				CMD.Copy(path + "\\OldInstall\\i18nEx", path + "\\i18nEx");
			}

			if (Directory.Exists(path + "\\OldInstall\\BepinEx\\Config") && Directory.Exists(path + "\\BepinEx"))
			{

				//System.Windows.Forms.MessageBox.Show("Fetching files for i18nEx", "debug", MessageBoxButtons.OK);

				//files = Directory.GetFiles(path + "\\OldInstall\\i18nEx", "*", SearchOption.AllDirectories).Select(x => new FileInfo(x)).ToArray();

				//System.Windows.Forms.MessageBox.Show("Both paths exist, putting i18nex stuff back.", "debug", MessageBoxButtons.OK);

				CMD.Copy(path + "\\OldInstall\\BepinEx\\Config", path + "\\BepinEx\\Config");
			}
		}

		[DllExport("CMIHelperHS", CallingConvention = CallingConvention.StdCall)]
		public static bool HandleSer([MarshalAs(UnmanagedType.BStr)] string path, [MarshalAs(UnmanagedType.BStr)] string dpath)
		{
			if (System.Windows.Forms.MessageBox.Show("We noticed you have a file that causes save data to be placed in the user's Documents directory (serialize_storage_config.cfg). Normally this is removed, but it doesn't hurt to leave it. Shall we remove this file and place your savedata back in the game folder?", "serialize_storage_config.cfg was found!", MessageBoxButtons.YesNo, MessageBoxIcon.Warning) == DialogResult.Yes)
			{
				try
				{
					File.Delete(path + "\\serialize_storage_config.cfg");
				}
				catch
				{
					System.Windows.Forms.MessageBox.Show("Encountered an error while deleting serialize_storage_config.cfg. Things will be left as they were!", "Error!", MessageBoxButtons.OK, MessageBoxIcon.Error);
					return false;
				}
				CMD.Copy(dpath + "\\KISS\\COM3D2", path);
			}
			return true;
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

		[DllExport("CMIHelperUA", CallingConvention = CallingConvention.StdCall)]
		public static bool UpdateAssets([MarshalAs(UnmanagedType.BStr)] string path, [MarshalAs(UnmanagedType.BStr)] string tpath, [MarshalAs(UnmanagedType.BStr)] string file, [MarshalAs(UnmanagedType.BStr)] string version)
		{

			string oldversion = "";
			string newversion = "";

			if (File.Exists(path + @"\manifest.txt") && File.Exists(tpath + @"\manifest.txt"))
			{

				string[] lines;

				if (version.Equals("null"))
				{
					lines = File.ReadAllLines(path + @"\manifest.txt");
					foreach (string line in lines)
					{
						if (line.Contains(file))
						{
							oldversion = line.Replace(file + ":", "");
							break;
						}
					}
				}
				else
				{
					oldversion = version;
				}

				lines = File.ReadAllLines(tpath + @"\manifest.txt");
				foreach (string line in lines)
				{
					//System.Windows.Forms.MessageBox.Show(line, "debug", MessageBoxButtons.OK);
					if (line.Contains(file))
					{
						newversion = line.Replace(file + ":", "");
						break;
					}
				}

				if (Version.Parse(oldversion) < Version.Parse(newversion))
				{
					//System.Windows.Forms.MessageBox.Show(oldversion + " | " + newversion, "debug", MessageBoxButtons.OK);
					return true;
				}
				else
				{
					return false;
				}
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