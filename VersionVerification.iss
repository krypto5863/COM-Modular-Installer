#define TargetApp "COM3D2.exe"
#define WrongTarget 'CM3D2.exe'
#define Assembly "COM3D2x64_Data\Managed\Assembly-CSharp.dll"

#define UpdateSite1 "http://com3d2.jp/update/"
#define UpdateSite2 "https://com3d2.world/r18/update/"

[Code]
Function VerifyPath(const DirName: String): Boolean;
begin
	//the result is intially true. If none of the checks are met, it passes true back. However, if any checks are met, it flips the switch to false but still does every other check. This is meant to point out all issues in a setup first run instead of forcing users to run multiple times a new issue crops up.
	Result := true;
	EmptyFolder := false;
    IsEng := false;

	//Due to INNOs cancer code. I've been splitting checks into code blocks to improve readability.
	if FileExists(AddBackSlash(DirName) + '{#WrongTarget}') then
	begin
		MsgBox(CustomMessage('CMDetected'), mbCriticalError, MB_OK);
		result := false;
		exit;
	end;

	if NOT FileExists(AddBackSlash(DirName) + '{#TargetApp}') then
	begin		
		if (MsgBox(CustomMessage('NotaGameDir'), mbConfirmation, MB_YESNO) = IDYES) then
		begin
			EmptyFolder := true;
			result := true;
			exit;
		end;

		result := false;
		exit;
	end;

	//Quits if the users are found to have updated their game incorrectly. This should help bring more awareness to incorrect updating and stop people from blaming CMI if they update incorrectly and then install CMI.
	if FileExists(AddBackslash(DirName) + 'update.exe') OR FileExists(AddBackSlash(DirName) + 'selector.exe') OR DirExists(AddBackslash(DirName) + 'data') then
	begin
		MsgBox(CustomMessage('ImproperUpdate'), mbCriticalError, MB_OK);
		result := false;
	end;

	if StringContains(DirName, '\Downloads\') then
	begin
		MsgBox(CustomMessage('IsInDownload'), mbCriticalError, MB_OK);
		result := false;
	end;

	if StringContains(DirName, '\Program Files\') AND NOT StringContains(DirName, '\steamapps\') then
	begin
		MsgBox(CustomMessage('IsInProgramFiles'), mbCriticalError, MB_OK);
		result := false;
	end;

	//Checks if the game is not INM version. If it's not, installation continues.
	if (GetIsEng(DirName) = 2) then
	begin
		MsgBox(CustomMessage('IsINM'), mbCriticalError, MB_OK);
		result := false;
	end;

    IsEng := GetIsEngSimple(DirName)

	if NOT FileExists(AddBackSlash(DirName) + 'update.lst') AND FileExists(AddBackSlash(DirName) + '{#TargetApp}') then
	begin
		MsgBox(CustomMessage('MissingUpdateLst'), mbCriticalError, MB_OK);
		result := false;
	end;

	if FileExists(AddBackSlash(DirName) + 'COM3D2x64_Data\Managed\ReiPatcher.exe') OR DirExists(AddBackslash(DirName) + 'ReiPatcher') then
	begin
		MsgBox(CustomMessage('ReiPatcher'), mbCriticalError, MB_OK);
		result := false;
	end;
end;

function VersionFetch(const File: string; out version: Integer; const LineToFetch: String): Boolean;
var
	i: Integer;
	s: array of string;
	line: string;
begin

	i := 0

	if NOT LoadStringsFromFile(File, s) then
	begin
		MsgBox(FmtMessage(CustomMessage('VersionFetchLoadFail'), [File]), mbCriticalError, MB_OK);
		result := false;
		exit;
	end;

	while (GetArrayLength(s) > i) AND NOT StringContains(s[i], LineToFetch) do
	begin
		i := i+1;
	end;

	if (i = GetArrayLength(s)) OR NOT StringContains(s[i], LineToFetch) then
	begin
		MsgBox(FmtMessage(CustomMessage('VersionFetchNoVersion'), [LineToFetch]), mbCriticalError, MB_OK);
		result := false;
		exit;
	end;

	line := s[i]

	if (StringChangeEx(line, LineToFetch + ',', '', true) <= 0) then
	begin
		MsgBox(CustomMessage('VersionFetchLineCleanFail'), mbCriticalError, MB_OK);
		result := false;
		exit;
	end;

	version := StrToIntDef(line, 0)

	if (version = 0) then
	begin
		MsgBox(CustomMessage('VersionFetchParseFail'), mbCriticalError, MB_OK);
		result := false;
		exit;
	end;

	result := true;
end;

function VerifyVersion(const Dir: String; const MinimumVersion: Integer; const CRStartVersion: Integer; const CRMinimumVersion: Integer): Boolean;
var
    TargetMinimum: Integer;
	Version, I: Integer;
	LineTarget: String;
begin
	
	IsCR := false;
	
	if NOT VersionFetch(AddBackSlash(WizardForm.DirEdit.Text) + 'update.lst', Version, '{#Assembly}') then
	begin
		result := false;
		exit;
	end;
	
	Log('Fetched version: ' + IntToStr(Version));

	if (Version >= CRStartVersion) then
	begin	
		IsCR := true;
        TargetMinimum := CRMinimumVersion
    end
    else
    begin
        TargetMinimum := MinimumVersion 
    end;

    Log('Minimum version: ' + IntToStr(TargetMinimum));

	if (Version < TargetMinimum) then
	begin
	
		Log('Should show outdated message...');
		if MsgBox(FmtMessage(CustomMessage('GameOutdated'),[IntToStr(TargetMinimum), IntToStr(Version)]), mbCriticalError, MB_YESNO) = IDYES then
        begin

            if GetIsEngSimple(Dir) then
            begin
                ShellExec('open', '{#UpdateSite2}', '', '', SW_SHOW, ewNoWait, i)        
            end
            else
            begin
                ShellExec('open', '{#UpdateSite1}', '', '', SW_SHOW, ewNoWait, i)
            end;

        end;

		Result := false;
		exit;
		
	end;
	
	Result := true;
end;

function NextButtonClick(const CurPageID: Integer): Boolean;
begin

	//Prevents code from running if not on the directory selection page
	if (CurPageID <> wpSelectDir) then
	begin
		result := true;
		exit;
	end;

    try 
        if NOT VerifyPath(WizardForm.DirEdit.Text)then
        begin
            Result := false;
            exit;
        end;

        if NOT EmptyFolder AND NOT VerifyVersion(WizardForm.DirEdit.Text, {#MinimumVersion}, {#CRStartVersion}, {#CRMinimumVersion}) then
        begin
            Result := false;
            exit;
        end;
    except;
        MsgBox('We ran into a failure while trying to verify the selected directory, game version, and integrity. If you are on Linux this is normal. Install will continue as normal, it is up to you to make sure things are working fine.', mbInformation, MB_OK);
    end;

	//Small advisory, hope users follow it.
	MsgBox(CustomMessage('EnsureGameClosed'), mbInformation, MB_OK);
	Result := true;
end;
[/Code]