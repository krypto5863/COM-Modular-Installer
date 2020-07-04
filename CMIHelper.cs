using RGiesecke.DllExport;
using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace CMIHelper
{
    public class CMIHelper
    {
        [DllExport("CMIHelper", CallingConvention = CallingConvention.StdCall)]
        public static bool VersionCheck([MarshalAs(UnmanagedType.BStr)] string path, int ver)
        {
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
                                return true;
                            }
                            else
                            {
                                System.Windows.Forms.MessageBox.Show("Your game is outdated! Update your game!\n\nYour game version was successfully checked and you are not on an acceptable version!\n\nExpected Version: " + ver + " or higher\nFound Version: " + ngver, "Game is outdated! Update!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                                return false;
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
                return false;
            }

            if (File.Exists(@path + @"\update.lst") && File.Exists(@path + @"\COM3D2x64.exe"))
            {
                System.Windows.Forms.MessageBox.Show("While we managed to find the Update.lst file, the assembly version could not be found! If you are on the Japanese version, this is a real problem! Please update immediately!", "Version Check Failed!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }

            var result = System.Windows.Forms.MessageBox.Show("This does not appear to be a COM3d2 Directory! We can still continue the installation but you may be installing to the wrong directory. Do we continue anyways?", "Wrong Directory!", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
            // If the no button was pressed ...
            if (result == DialogResult.No)
            {
                return false;
            }
            if (result == DialogResult.Yes)
            {
                return true;
            }
            return false;
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
            if (File.Exists(@path + @"\GameData\product.arc") || File.Exists(@path + @"\GameData\language.arc"))
            {
                if (!File.Exists(@path + @"\GameData\system_en.arc") && !File.Exists(@path + @"\GameData\bg-en.arc"))
                {
                    System.Windows.Forms.MessageBox.Show("INM was found! Modular does not officially support INM due to known incompatibilities. Please install the R18(Adult) patch if you wish to use this installer.", "INM was found!", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return false;
                }
            }
            //System.Windows.Forms.MessageBox.Show("Game type was checked! JP version was found!!", "Caption Here!", MessageBoxButtons.OK);
            return true;
        }

        [DllExport("CMIHelperT", CallingConvention = CallingConvention.StdCall)]
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
        }

        [DllExport("CMIHelperM", CallingConvention = CallingConvention.StdCall)]
        public static bool MoveOld([MarshalAs(UnmanagedType.BStr)] string path)
        {
            List<string> corefiles = new List<string>();
            corefiles.Add(@"\Sybaris");
            corefiles.Add(@"\BepinEX");
            corefiles.Add(@"\i18nEx");
            corefiles.Add(@"\IMGUITranslationLoader");
            corefiles.Add(@"\scripts");
            corefiles.Add(@"\doorstop_config.ini");
            corefiles.Add(@"\winhttp.dll");
            corefiles.Add(@"\version.dll");
            corefiles.Add(@"\opengl32.dll");
            corefiles.Add(@"\EngSybarisArcEditor.exe");
            corefiles.Add(@"\CMI Documentation");

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

                if (Directory.Exists(path + @"\OldInstall " + DateTime.Now.ToString("MM.dd.yyyy.h.mm")))
                {
                    res = CMD.Rename(path + @"\OldInstall", "OldInstall " + DateTime.Now.ToString("MM.dd.yyyy.h.mm.ss"));
                }
                else
                {
                    res = CMD.Rename(path + @"\OldInstall", "OldInstall " + DateTime.Now.ToString("MM.dd.yyyy.h.mm"));
                }

                if (res == false)
                {
                    return false;
                }

            }
            return true;
        }
    }
}