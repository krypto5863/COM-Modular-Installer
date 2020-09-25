using System.Windows.Forms;

namespace CMIHelper
{
    class CMD
    {

        public static bool Move(string src, string trg)
        {

            var res = DialogResult.OK;

            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/c move /y " +
                '\u0022' + src + '\u0022' +
                " " +
                '\u0022' + trg + '\u0022';

            startInfo.UseShellExecute = false;
            startInfo.Verb = "runas";
            startInfo.RedirectStandardOutput = true;
            startInfo.RedirectStandardError = true;
            startInfo.CreateNoWindow = true;
            process.StartInfo = startInfo;

            do
            {

                res = DialogResult.OK;

                process.Start();


                string err = process.StandardError.ReadToEnd();
                string line = process.StandardOutput.ReadToEnd();
                process.WaitForExit();
#if DEBUG
            System.Windows.Forms.MessageBox.Show(startInfo.Arguments + "\n\n" + line, "DEBUG", MessageBoxButtons.OK, MessageBoxIcon.Information);
#endif
                if (line.Contains("0"))
                {
                    res = System.Windows.Forms.MessageBox.Show("We failed to move the file at " + src + "\n\n" + err + "\n\nClose all open windows and try again. Otherwise, you can ignore it or abort the installation. Ignoring could cause problems with the installation!", "Error while moving!", MessageBoxButtons.AbortRetryIgnore, MessageBoxIcon.Error);
                    if (res == DialogResult.Abort)
                    {
                        return false;
                    }
                }
            } while (res == DialogResult.Retry);

            return true;
        }

        public static void Copy(string src, string trg)
        {

            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/c xcopy " +
                '\u0022' + src + '\u0022' +
                " " +
                '\u0022' + trg + '\u0022' +
                " /y /s /c /i";

            startInfo.UseShellExecute = false;
            //startInfo.Verb = "runas";
            //startInfo.RedirectStandardOutput = true;
            //startInfo.RedirectStandardError = true;
            startInfo.CreateNoWindow = true;
            process.StartInfo = startInfo;


            process.Start();
            process.WaitForExit();
        }


        public static bool MakeDir(string dir)
        {

            var res = DialogResult.OK;

            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/c mkdir " +
                '\u0022' + dir + '\u0022';

            startInfo.UseShellExecute = false;
            startInfo.Verb = "runas";
            startInfo.RedirectStandardOutput = true;
            startInfo.RedirectStandardError = true;
            startInfo.CreateNoWindow = true;
            process.StartInfo = startInfo;

            do
            {

                res = DialogResult.OK;

                process.Start();


                string err = process.StandardError.ReadToEnd();
                string line = process.StandardOutput.ReadToEnd();
                process.WaitForExit();
#if DEBUG
            System.Windows.Forms.MessageBox.Show(startInfo.Arguments + "\n\n" + line, "DEBUG", MessageBoxButtons.OK, MessageBoxIcon.Information);
#endif
                if (!err.Equals("") && err != null)
                {
                    res = System.Windows.Forms.MessageBox.Show("We failed to create the directory " + dir + "\n\n" + err + "\n\nClose all open windows and try again. Otherwise, you can ignore it or abort the installation. Ignoring could cause problems with the installation!", "Error while making the directory!", MessageBoxButtons.AbortRetryIgnore, MessageBoxIcon.Error);
                    if (res == DialogResult.Abort)
                    {
                        return false;
                    }
                }
            } while (res == DialogResult.Retry);

            return true;
        }

        public static bool Rename(string src, string trg)
        {

            var res = DialogResult.OK;

            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/c rename " +
                '\u0022' + src + '\u0022' +
                " " +
                '\u0022' + trg + '\u0022';

            startInfo.UseShellExecute = false;
            startInfo.Verb = "runas";
            startInfo.RedirectStandardOutput = true;
            startInfo.RedirectStandardError = true;
            startInfo.CreateNoWindow = true;
            process.StartInfo = startInfo;

            do
            {

                res = DialogResult.OK;

                process.Start();


                string err = process.StandardError.ReadToEnd();
                string line = process.StandardOutput.ReadToEnd();
                process.WaitForExit();
#if DEBUG
            System.Windows.Forms.MessageBox.Show(startInfo.Arguments + "\n\n" + line, "DEBUG", MessageBoxButtons.OK, MessageBoxIcon.Information);
#endif
                if (!err.Equals("") && err != null)
                {
                    res = System.Windows.Forms.MessageBox.Show("We failed to rename the directory " + src + "\n\n" + err + "\n\nClose all open windows and try again. Otherwise, you can ignore it or abort the installation. Ignoring could cause problems with the installation!", "Error while making the directory!", MessageBoxButtons.AbortRetryIgnore, MessageBoxIcon.Error);
                    if (res == DialogResult.Abort)
                    {
                        return false;
                    }
                }
            } while (res == DialogResult.Retry);

            return true;
        }

    }
}
