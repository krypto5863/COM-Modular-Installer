[Code]
//Calls for function that facilitate version checking from C# DLL
function VersionCheck(path: WideString; gver: Integer): Integer;
external 'CMIHelper@files:CMIHelper.dll stdcall delayload';
function StringContains(string: WideString; substring: WideString): Boolean;
external 'CMIHelperSC@files:CMIHelper.dll stdcall delayload';

Function VerifyPath(DirName: String): Boolean;
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
		
	if StringContains(DirName, 'Downloads') then
	begin
		MsgBox('It seems your game is located in the Downloads directory, this can cause issues with UAC and lead to improper CMI installs! Please move it somewhere safer (Example: C:/KISS/COM3D2)', mbCriticalError, MB_OK)
		result := false
	end;
	
	if StringContains(DirName, 'Program Files') = True AND StringContains(DirName, 'Steam') = False then
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
	end;	
end;

function VersionFetch(File: string; out version: Integer): Boolean;
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
	
	while (StringContains(s[i], 'COM3D2x64_Data\Managed\Assembly-CSharp.dll') = false) AND (GetArrayLength(s) > i) do
	begin
		i := i+1
	end;
	
	if (i = GetArrayLength(s)) AND (StringContains(s[i], 'COM3D2x64_Data\Managed\Assembly-CSharp.dll') = false) then
	begin
		MsgBox('While we managed to find the Update.lst file, the assembly version could not be found! If you are on the Japanese version, this is a real problem! Please update immediately!', mbCriticalError, MB_OK);
		result := false;
		exit;
	end;
	
	line := s[i];
	
	StringChangeEx(line, 'COM3D2x64_Data\Managed\Assembly-CSharp.dll,', '', true)
	
	version := StrToIntDef(line, 0);
	
	if (version = 0) then
	begin
		MsgBox('An error occurred while parsing the version number... Report this to the dev.', mbCriticalError, MB_OK);
		result := false
		exit;
	end;
	
	result := true;	
end;

function VerifyVersion(Dir: String; MinimumVersion: Integer; UnsupportedVersion: Integer): Boolean;
var
	Version: Integer;
begin
	if (EmptyFolder = false) then
	begin
		if(VersionFetch(WizardForm.DirEdit.Text + '\update.lst', Version)) then
		begin
			if (Version < MinimumVersion) then
			begin
				MsgBox('Your game is outdated! Please update it immediately.' + #13#10#13#10 + 'Minimum Version:' + IntToStr({#MinimumVersion}) + #13#10 + 'Found Version:' + IntToStr(Version), mbCriticalError, MB_OK);
				DownloadUpdate(MinimumVersion, UnsupportedVersion);
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

function NextButtonClick(CurPageID: Integer): Boolean;
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