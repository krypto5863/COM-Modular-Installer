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
                                System.Windows.Forms.MessageBox.Show("Your game version was successfully checked and you are on an acceptable version!", "Version Check Success!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                return true;
                            }
                            else
                            {
                                System.Windows.Forms.MessageBox.Show("Your game version was successfully checked and you are not on an acceptable version! Please update your game and try again.", "Version Check Failed!", MessageBoxButtons.OK, MessageBoxIcon.Error);
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


        [DllExport("CMIHelperT", CallingConvention = CallingConvention.StdCall)]
        public static bool TypeCheck([MarshalAs(UnmanagedType.BStr)] string path)
        {
            //path = @"D:\KISS\COM3D2";
            if (File.Exists(@path + @"\GameData\product.arc") || File.Exists(@path + @"\GameData\language.arc"))
            {
                System.Windows.Forms.MessageBox.Show("English version was found!! Be advised, English versions are not as feature full or as supported as the Japanese version! Some components will be disabled for your safety!", "English!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;   
            }
            //System.Windows.Forms.MessageBox.Show("Game type was checked! JP version was found!!", "Caption Here!", MessageBoxButtons.OK);
            return true;
        }

        [DllExport("CMIHelperM", CallingConvention = CallingConvention.StdCall)]
        public static bool MoveOld ([MarshalAs(UnmanagedType.BStr)] string path)
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

            foreach (string file in corefiles)
            {
                if (Directory.Exists(path + file))
                {
                    try
                    {
                        Directory.Move(path + file, path + @"\Oldinstall" + file);
                    }
                    catch (Exception IOException)
                    {
                        return false;//If an exception is caught, the program fail safes and aborts the installation
                    }
                }
                if (File.Exists(path + file))
                {
                    try
                    {
                        File.Move(path + file, path + @"\Oldinstall" + file);
                    }
                    catch (Exception IOException)
                    {
                        return false;//If an exception is caught, the program fail safes and aborts the installation.
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

            foreach (string file in corefiles)
            {
                if (Directory.Exists(path + @"\Mod" + file))
                {
                    try
                    {
                        Directory.Move(path + @"\Mod" + file, path + @"\Oldinstall\Mod" + file);
                    }
                    catch (Exception IOException)
                    {
                        return false;//If an exception is caught, the program fail safes and aborts the installation
                    }
                }
                if (File.Exists(path + @"\Mod" + file))
                {
                    try
                    {
                        File.Move(path + @"\Mod" + file, path + @"\Oldinstall\Mod" + file);
                    }
                    catch (Exception IOException)
                    {
                        return false;//If an exception is caught, the program fail safes and aborts the installation.
                    }
                }
            }
            return true;
        }
    }
}
