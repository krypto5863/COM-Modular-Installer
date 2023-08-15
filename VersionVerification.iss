[Code]
Function VerifyPath(const DirName: String): Boolean;
begin
	//the result is intially true. If none of the checks are met, it passes true back. However, if any checks are met, it flips the switch to false but still does every other check. This is meant to point out all issues in a setup first run instead of forcing users to run multiple times a new issue crops up.
	result := true;
	EmptyFolder:= false;

	//Due to INNOs cancer code. I've been splitting checks into code blocks to improve readability.
	if FileExists(DirName + '{#WrongTarget}') then
	begin
		MsgBox(CustomMessage('CMDetected'), mbCriticalError, MB_OK);
		result := false;
		exit;
	end;

	if NOT FileExists(DirName + '{#TargetApp}') then
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
	if FileExists(DirName + '\update.exe') OR FileExists(DirName + '\selector.exe') OR DirExists(DirName + '\data') then
	begin
		MsgBox(CustomMessage('ImproperUpdate'), mbCriticalError, MB_OK);
		result := false;
	end;

	if StringContains(DirName, '\Downloads\') then
	begin
		MsgBox(CustomMessage('IsInDownload'), mbCriticalError, MB_OK);
		result := false;
	end;

	if StringContains(DirName, '\Program Files') AND NOT StringContains(DirName, '\steamapps\') then
	begin
		MsgBox(CustomMessage('IsInProgramFiles'), mbCriticalError, MB_OK);
		result := false;
	end;

#if LMMT == false
	//Checks if the game is not INM version. If it's not, installation continues.
	if (IsEng(DirName) = 2) then
	begin
		MsgBox(CustomMessage('IsINM'), mbCriticalError, MB_OK);
		result := false;
	end;
#endif

	if NOT FileExists(DirName + '\update.lst') AND FileExists(DirName + '{#TargetApp}') then
	begin
		MsgBox(CustomMessage('MissingUpdateLst'), mbCriticalError, MB_OK);
		result := false;
	end;

	if FileExists(DirName + '\COM3D2x64_Data\Managed\ReiPatcher.exe') OR DirExists(DirName + '\ReiPatcher') then
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

procedure DownloadUpdate(const MinVer: Integer; const MaxVer: Integer; const Dir: String);
var
	JPUpLinks: Array of string;
	EngUpLinks: Array of string;

	i : Integer;
	pointversion : Integer;
	SiteSt: String;
	site : WideString;
	siteTemp : WideString;
	ErrorCode: Integer;
	VersionString: String;
	TempString: String;

	FoundFile: WideString;
begin

	JPUpLinks := [
		'https://p2-dl0.kisskiss.tv/com3d2/update/',
		'https://p2-dl1.kisskiss.tv/com3d2/update/',
		'https://p2-res2.rcw.bz/',
		'https://p2-res1.rcw.bz/'
	];

	EngUpLinks := [
		'https://p2w-res1.rcw.bz/'
	];


	if MsgBox(CustomMessage('UpdatePrompt'), mbInformation, MB_YESNO) = MrNO then
	begin
	  
	#if LMMT == false
		if IsCR then
		begin
			ShellExec('open', '{#UpdateSite3}', '', '', SW_SHOW, ewNoWait, ErrorCode);
		end
		else if (IsEng(Dir) = 0) then
		begin
			ShellExec('open', '{#UpdateSite1}', '', '', SW_SHOW, ewNoWait, ErrorCode);
		end
		else
		begin
			ShellExec('open', '{#UpdateSite2}', '', '', SW_SHOW, ewNoWait, ErrorCode);
		end;
		
	#else
		ShellExec('open', '{#UpdateSite1}', '', '', SW_SHOW, ewNoWait, ErrorCode);
	#endif

		exit;
		
	end
	else
	begin
		if IsCR then
		begin
			MsgBox(CustomMessage('GameUpdateNotSupported'), mbInformation, MB_OK);
			ShellExec('open', '{#UpdateSite3}', '', '', SW_SHOW, ewNoWait, ErrorCode);
			exit;
		end;
	end;
	
	if (IsEng(Dir) = 0) then SiteTemp := '{#UpdateSite1}' else SiteTemp := '{#UpdateSite2}';

	FetchUpdateFile(SiteTemp, site);

	if (IsEng(Dir) = 0) then site := JPUpLinks[Random(GetArrayLength(JPUpLinks))] + site else site := EngUpLinks[Random(GetArrayLength(EngUpLinks))] + site;

	DownloadPage.Clear;
	DownloadPage.Show;

	if NOT FileExists(ExpandConstant('{src}\COMUpdate.zip')) = false AND NOT DirExists(ExpandConstant('{src}\COMUpdate')) then
	
		DownloadPage.Add(site, ExpandConstant('{src}\COMUpdate.zip'), '');
		
		try
			DownloadPage.Download;
		except
		begin
		end;
	end;

	if NOT DirExists(ExpandConstant('{src}\COMUpdate')) then
	begin
		DoUnZip(ExpandConstant('{src}\COMUpdate.zip'),ExpandConstant('{src}\COMUpdate'));
	end;

	FindFile('update.exe', ExpandConstant('{src}\COMUpdate'), FoundFile);

	log(FoundFile);

	shellExec('', FoundFile, '', '', SW_SHOW, ewWaitUntilTerminated, ErrorCode);

	DownloadPage.Hide;
end;

function VerifyVersion(const Dir: String; const MinimumVersion: Integer; const CRStartVersion: Integer; CRMinimumVersion: Integer): Boolean;
var
	Version: Integer;
	LineTarget: String;
begin
	
	IsCR := false;
	
	if NOT VersionFetch(WizardForm.DirEdit.Text + '\update.lst', Version, Format('{#Assembly}', [BitString])) then
	begin
		result := false;
		exit;
	end;
	
	Log('Fetched version: ' + IntToStr(Version));
	Log('Minimum version: ' + IntToStr(MinimumVersion));

#if LMMT == false	
	if (Version >= CRStartVersion) then
	begin
	
		IsCR := true;
	
		if (Version < CRMinimumVersion) then
		begin
			MsgBox(FmtMessage(CustomMessage('GameOutdated'),[IntToStr(CRMinimumVersion), IntToStr(Version) + ' ' + bitString]), mbCriticalError, MB_OK);
			Result := false;
			exit;
		end;
		
		result := true;
		exit;
	
	end;
#endif

	if (Version < MinimumVersion) then
	begin
	
		Log('Should show outdated message...');
		MsgBox(FmtMessage(CustomMessage('GameOutdated'),[IntToStr(MinimumVersion), IntToStr(Version) + ' ' + bitString]), mbCriticalError, MB_OK);

#if LMMT == false
		if (IsEng(Dir) = 1) then
		begin
			VersionFetch(Dir + '\update.lst', Version, '{#AppLine}');
		end;
#endif

		DownloadUpdate(Version, CRStartVersion, Dir);
		Result := false;
		exit;
		
	end;
	
	Result := true;
end;

function NextButtonClick(const CurPageID: Integer): Boolean;
var
	FreeSpace1, TotalSpace1: Cardinal;
begin

	//Prevents code from running if not on the directory selection page
	if (CurPageID <> wpSelectDir) then
	begin
		result := true;
		exit;
	end;

	//MsgBox('Found Space: ' + IntToStr(FreeSpace1), mbCriticalError, MB_OK)
	if GetSpaceOnDisk(WizardForm.DirEdit.Text, True, FreeSpace1, TotalSpace1) and (FreeSpace1 < 5000) then
	begin
		MsgBox(FmtMessage(CustomMessage('StorageSpaceLow2'),[IntToStr(FreeSpace1)]), mbCriticalError, MB_OK);
		Result := false;
		exit;
	end;

    try 
        if NOT VerifyPath(WizardForm.DirEdit.Text)then
        begin
            Result := false;
            exit;
        end;

    #if LMMT == true
        log('Now noting the bits down...');
        NoteBits(WizardForm.DirEdit.Text);
    #endif

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