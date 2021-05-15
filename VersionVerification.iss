[Code]
//Calls for function that facilitate version checking from C# DLL
function VersionCheck(const path: WideString; const gver: Integer): Integer;
external 'CMIHelper@files:CMIHelper.dll stdcall delayload';

Function VerifyPath(const DirName: String): Boolean;
begin
	//the result is intially true. If none of the checks are met, it passes true back. However, if any checks are met, it flips the switch to false but still does every other check. This is meant to point out all issues in a setup first run instead of forcing users to run multiple times a new issue crops up. 
	result := true;
	EmptyFolder:= false;
	
	//Due to INNOs cancer code. I've been splitting checks into code blocks to improve readability.
	if FileExists(DirName + '\CM3D2.exe') then
	begin
		 MsgBox('This is CM3D2 not COM3D2! CMI was not made for CM3D2! For CM3D2, please use Legacy Meido Modular Toolbox (LMMT)', mbCriticalError, MB_OK)
		 result := false
		 exit;
	end;
	
	if (FileExists(DirName + '\COM3d2x64.exe') = false) then
		begin
		if MsgBox('This does not appear to be a COM3d2 Directory! We can still continue the installation but you may be installing to the wrong directory, some functions will also be rendered ineffectual. Do we continue anyways?', mbConfirmation, MB_YESNO) = IDYES then
		begin
			EmptyFolder := true;
			result := true;
			exit;
		end;
	
		result := false;
		exit;
	end;
  
  //Quits if the users are found to have updated their game incorrectly. This should help bring more awareness to incorrect updating and stop people from blaming CMI if they update incorrectly and then install CMI.
	if (FileExists(DirName + '\update.exe')) OR (FileExists(DirName + '\selector.exe')) OR (DirExists(DirName + '\data')) then
  begin
		MsgBox('We have detected that this game instance was updated improperly!(Usually by a drag and drop process) This is completely unsafe and WILL break your game.' + #13#10#13#10 + 'Due to this CMI will not install as you may encounter further errors and bugs if we continue. Please reinstall your game and update CORRECTLY (By placing the update/DLC files in an empty directory and using the provided update.exe or selector.exe) to continue.', mbCriticalError, MB_OK)
		result := false;
	end;  
		
	if StringContains(DirName, 'Downloads') then
	begin
		MsgBox('It seems your game is located in the Downloads directory, this can cause issues with UAC and lead to improper CMI installs! Please move it somewhere safer (Example: C:/KISS/COM3D2)', mbCriticalError, MB_OK)
		result := false
	end;
	
	if (StringContains(DirName, 'Program Files') = True) AND (StringContains(DirName, 'Steam') = False) then
	begin
	  MsgBox('It seems your game is located in the Program Files directory, this can cause issues with UAC and lead to improper CMI installs! Please move it somewhere safer (Example: C:/KISS/COM3D2)', mbCriticalError, MB_OK)
		result := false
	end;
	
	//Checks if the game is not INM version. If it's not, installation continues.
	if IsEng(DirName) = 2 then
	begin
		MsgBox('We have detected INM! INM is not supported by CMI due to technical differences.' + #13#10#13#10 + 'To use CMI, please install the R18/Adult Content Supplement Patch.' + #13#10#13#10 + 'If your are not actually on an INM version of the game, then you have likely installed Eng DLC/files into your japanese game. Please refer to the readme on repair instructions.', mbCriticalError, MB_OK);
		result := false;
	end;
	
	if FileExists(DirName + '\update.lst') = false AND FileExists(DirName + '\COM3d2x64.exe') then
	begin	
		MsgBox('While this appears to be a game folder, there is no Update.lst file! This is very bad!' + #13#10#13#10 + 'Please update your game immediately and ensure that your game is functioning before attempting to install CMI again.', mbCriticalError, MB_OK);	
    result := false;
	end;	
end;

function VersionFetch(const File: string; out version: Integer; const LineToFetch: String): Boolean;
var
	i: Integer;
	s: array of string;
	line: string;
begin

	i := 0;
	
	if (FileExists(File) = false) then
	begin
		result := false;
		exit;
	end;

	if LoadStringsFromFile(File, s) = false then
	begin
		MsgBox('Could not load strings from ' + File, mbCriticalError, MB_OK);
		result := false;
		exit;
	end;	
	
	while (GetArrayLength(s) > i) AND (StringContains(s[i], LineToFetch) = false) do
	begin
		i := i+1
	end;
	
	if (i = GetArrayLength(s)) OR (StringContains(s[i], LineToFetch) = false) then
	begin
		MsgBox('While we managed to find the Update.lst file, the line containing: ' + LineToFetch + ' could not be found! If you are on the Japanese version, this is can be a real problem! Please update immediately!', mbCriticalError, MB_OK);
		result := false;
		exit;
	end;
	
	line := s[i];
	
	if StringChangeEx(line, LineToFetch + ',', '', true) <= 0 then
  begin
    MsgBox('Could not clean the line containing the version we need in order to parse... Please update your game and try again. Otherwise, report this to the dev with your update.lst file', mbCriticalError, MB_OK);
		result := false
		exit;
  end;
	
	version := StrToIntDef(line, 0);
	
	if (version = 0) then
	begin
		MsgBox('An error occurred while parsing the version number... Please update your game and try again. Otherwise, report this to the dev.', mbCriticalError, MB_OK);
		result := false
		exit;
	end;
	
	result := true;	
end;


procedure DownloadUpdate(const MinVer: Integer; const MaxVer: Integer; const Dir: String);
var
	i : Integer;
	pointversion : Integer;
	SiteSt: String;
	site : String;
	ErrorCode: Integer;
begin
	
  if MsgBox('Would you like us to try to download the latest update and run the updater? This generally is not recommended, as it can be unstable. You will still need to follow the instructions in the installer that shows up, and this way of updating is not as safe or as reliable as manually updating.' + #13#10#13#10 + 'The update may take a while to download as the download itself can be around 3GBs in size and Kiss servers can be VERY slow so be patient.' + #13#10#13#10 + 'Pressing no will open the update download website.', mbInformation, MB_YESNO) = MrNO then
  begin	
	
    if (IsEng(Dir)) = 1 then
    begin
      ShellExec('open', 'https://com3d2.world/r18/update/', '', '', SW_SHOW, ewNoWait, ErrorCode);
    end else
    begin
      ShellExec('open', 'https://com3d2.jp/update/', '', '', SW_SHOW, ewNoWait, ErrorCode);
    end;			
    exit;
  end;
	
  if (IsEng(Dir)) = 1 then
  begin
    i := MinVer/10+100;
    SiteSt := 'http://7.242.238.202.static.iijgio.jp/com3d2_up'
  end else
  begin
    i := MinVer/10+100;
    SiteST := 'http://p2-dl0.kisskiss.tv/com3d2/update/com3d2_up'
  end;

  while (i >= MinVer/10) AND (Length(site) <= 0) do
  begin
    if (i >= MaxVer/10) then
    begin
      i := i-1;
      continue;
    end;

    //MsgBox('testing: ' + 'http://p2-dl0.kisskiss.tv/com3d2/update/com3d2_up' + IntToStr(i) + '.zip', mbInformation, MB_OK);
    if (SiteValid(SiteSt + IntToStr(i) + '.zip') = true) then
    begin
      pointversion:= 10;

      while pointversion > 0 do
      begin
        if (SiteValid(SiteSt + IntToStr(i) + '.' + IntToStr(pointversion) + '.zip') = true) AND (i*10 + pointversion > MinVer) then
        begin
          site :=  SiteSt + IntToStr(i) + '.' + IntToStr(pointversion) + '.zip';
          break;
        end
        else if (i*10 > MinVer) then
        begin
          site :=  SiteSt + IntToStr(i) + '.zip';
        end;
        pointversion := pointversion-1;
      end;
      //MsgBox('Returning update ' + IntToStr(lv) + ' as latest', mbInformation, MB_OK);
    end;		
    i := i-1;	
  end;		
  //MsgBox(site + ' : ' +  IntToStr(lv), mbCriticalError, MB_OK);

  if (CompareText(site,'') <> 0) AND (Length(site) > 0) then
  begin
    DownloadPage.Clear;
			
    //DownloadPage.Add('http://p2-dl0.kisskiss.tv/com3d2/update/com3d2_up152.zip', 'COMUpdate.zip', '');
			
    //MsgBox('downloading from: ' + site, mbInformation, MB_OK);
    DownloadPage.Add(site, 'COMUpdate.zip', '');
			
    DownloadPage.Show;
    try
      try
        DownloadPage.Download;
      except
        //SuppressibleMsgBox(AddPeriod(GetExceptionMessage), mbCriticalError, MB_OK, IDOK);
      end;
    finally
			
    DoUnZip(ExpandConstant('{tmp}\COMUpdate.zip'),ExpandConstant('{tmp}\COMUpdate'));
			
		shellExec('', ExpandConstant('{tmp}\COMUpdate\com3d2_up'+ IntToStr(i) +'\update.exe'), '', '', SW_SHOW, ewWaitUntilTerminated, ErrorCode);
			
		DownloadPage.Hide;
		end;
	end
	else begin
    MsgBox('Either you are already on the latest version available to you and you need to wait for a new game update(English Users) or we failed to fetch updates.' + #13#10#13#10 + 'It is recommended you manually update your game instead if you believe that you are not on the latest available version for your game.', mbCriticalError, MB_OK)
	end;
end;

function VerifyVersion(const Dir: String; const MinimumVersion: Integer; const UnsupportedVersion: Integer): Boolean;
var
	Version: Integer;
begin
	if (EmptyFolder = false) then
	begin
		if(VersionFetch(WizardForm.DirEdit.Text + '\update.lst', Version, 'COM3D2x64_Data\Managed\Assembly-CSharp.dll')) then
		begin
			if (Version < MinimumVersion) then
			begin
				MsgBox('Your game is outdated! Please update it immediately.' + #13#10#13#10 + 'Minimum Version:' + IntToStr(MinimumVersion) + #13#10 + 'Found Version:' + IntToStr(Version), mbCriticalError, MB_OK);

        if (IsEng(Dir) = 1)then
        begin
          VersionFetch(Dir + '\update.lst', Version, 'COM3D2x64.exe')
        end;

				DownloadUpdate(Version, UnsupportedVersion, Dir);
				Result := false;
				exit;
			end 
			else if (Version >= UnsupportedVersion) then
			begin
				MsgBox('Your game is on a version that is not supported! Either downgrade or get a version of CMI that is compatible!' + #13#10#13#10 + 'Unsupported Version:' + IntToStr(UnsupportedVersion) + ' or Newer' + #13#10 + 'Found Version:' + IntToStr(Version), mbCriticalError, MB_OK);
				Result := false;
				exit;
			end;
      
      result := true;
		end
		else begin
			Result := false;
			exit;
		end
	end;
end;

function NextButtonClick(const CurPageID: Integer): Boolean;
var
	FreeSpace1, TotalSpace1: Cardinal;
begin
	//Prevents code from running if not on the directory selection page
	if CurPageID <> wpSelectDir then
	begin		
		result := true
		exit;
	end;	
		
	//MsgBox('Found Space: ' + IntToStr(FreeSpace1), mbCriticalError, MB_OK)			
	if (GetSpaceOnDisk(WizardForm.DirEdit.Text, True, FreeSpace1, TotalSpace1)) and (FreeSpace1 < 5000) then
	begin
		MsgBox('The drive holding the path you have selected does not contain enough space to safely install CMI. Please clear a minimum of 5 GiBs to install CMI to this directory: ' + IntToStr(FreeSpace1) + 'MB', mbCriticalError, MB_OK)
		Result := false;
		exit;
	end;
		
	if VerifyPath(WizardForm.DirEdit.Text) = false then
	begin
		Result := false;
		exit;
	end;
		
   if (EmptyFolder = false) AND (VerifyVersion(WizardForm.DirEdit.Text, {#MinimumVersion}, {#UnsupportedVersion}) = false) then
	begin
		Result := false;
		exit;
	end;

	//MsgBox('We should be returning true', mbInformation, MB_OK);
	//Small advisory, hope users follow it.
	MsgBox('Please ensure no game folders or game instances are open or you will have a bad install!', mbInformation, MB_OK);
	Result := true			 
end;
[/Code]