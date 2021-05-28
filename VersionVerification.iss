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
	if FileExists(DirName + '{#WrongTarget}') then
	begin
		 MsgBox(CustomMessage('CMDetected'), mbCriticalError, MB_OK)
		 result := false
		 exit;
	end;
	
	if (FileExists(DirName + '{#TargetApp}') = false) then
		begin
		if MsgBox(CustomMessage('NotaGameDir'), mbConfirmation, MB_YESNO) = IDYES then
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
		MsgBox(CustomMessage('ImproperUpdate'), mbCriticalError, MB_OK)
		result := false;
	end;  
		
	if StringContains(DirName, 'Downloads') then
	begin
		MsgBox(CustomMessage('IsInDownloads'), mbCriticalError, MB_OK)
		result := false
	end;
	
	if (StringContains(DirName, 'Program Files') = True) AND (StringContains(DirName, 'Steam') = False) then
	begin
	  MsgBox(CustomMessage('IsInProgramFiles'), mbCriticalError, MB_OK)
		result := false
	end;

#if LMMT == false	
	//Checks if the game is not INM version. If it's not, installation continues.
	if IsEng(DirName) = 2 then
	begin
		MsgBox(CustomMessage('IsINM'), mbCriticalError, MB_OK);
		result := false;
	end;
#endif
	
	if FileExists(DirName + '\update.lst') = false AND FileExists(DirName + '{#TargetApp}') then
	begin	
		MsgBox(CustomMessage('MissingUpdateLst'), mbCriticalError, MB_OK);	
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
		MsgBox(FmtMessage(CustomMessage('VersionFetchLoadFail'), File), mbCriticalError, MB_OK);
		result := false;
		exit;
	end;	
	
	while (GetArrayLength(s) > i) AND (StringContains(s[i], LineToFetch) = false) do
	begin
		i := i+1
	end;
	
	if (i = GetArrayLength(s)) OR (StringContains(s[i], LineToFetch) = false) then
	begin
		MsgBox(FmtMessage(CustomMessage('VersionFetchNoVersion'), [LineToFetch]), mbCriticalError, MB_OK);
		result := false;
		exit;
	end;
	
	line := s[i];
	
	if StringChangeEx(line, LineToFetch + ',', '', true) <= 0 then
  begin
    MsgBox(CustomMessage('VersionFetchLineCleanFail'), mbCriticalError, MB_OK);
		result := false
		exit;
  end;
	
	version := StrToIntDef(line, 0);
	
	if (version = 0) then
	begin
		MsgBox(CustomMessage('VersionFetchParseFail'), mbCriticalError, MB_OK);
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
	VersionString: String;
begin
	
  if MsgBox(CustomMessage('UpdatePrompt'), mbInformation, MB_YESNO) = MrNO then
  begin	
#if LMMT == false		
    if (IsEng(Dir)) = 0 then
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
  end;

#if LMMT == false
		
  if (IsEng(Dir)) = 1 then
  begin
    i := MinVer/10+100;
    SiteSt := ExpandConstant('{#UpdateFetch2}{#UpdateFile}')
  end else
  begin
    i := MinVer/10+100;
    SiteST := ExpandConstant('{#UpdateFetch1}{#UpdateFile}')
  end;
#else
    i := MinVer/10+10;
    SiteSt := ExpandConstant('{#UpdateFetch1}{#UpdateFile}')
#endif

  while (i >= MinVer/10) AND (Length(site) <= 0) do
  begin
#if LMMT == false
    if (i >= MaxVer/10) then
    begin
      i := i-1;
      continue;
    end;
#endif

    Log('Testing: ' + Format(SiteSt, [IntToStr(i), BitString, '.zip']));
    if (SiteValid(Format(SiteSt, [IntToStr(i), BitString, '.zip'])) = true) then
    begin
      pointversion:= 10;

      while pointversion > 0 do
      begin
				Log('Testing point: ' + Format(SiteSt, [IntToStr(i)+ '.' + IntToStr(pointversion), BitString, '.zip']));
        if (SiteValid(Format(SiteSt, [IntToStr(i)+ '.' + IntToStr(pointversion), BitString, '.zip'])) = true) AND (i*10 + pointversion > MinVer) then
        begin
          site :=  Format(SiteSt, [IntToStr(i)+ '.' + IntToStr(pointversion), BitString, '.zip'])
					VersionString := IntToStr(i) + '.' + IntToStr(pointversion);
          break;
        end
        else if (i*10 > MinVer) then
        begin
          site := Format(SiteSt, [IntToStr(i), BitString, '.zip']);
					VersionString := IntToStr(i);
        end;
        pointversion := pointversion-1;
      end;
      Log(site + ' as latest');
    end;		
    i := i-1;	
  end;
	
	if (CompareText(site,'') = 0) AND (Length(site) <= 0) then
	begin
    MsgBox(CustomMessage('UpdateFetchFail'), mbCriticalError, MB_OK)
		exit;
	end;
	
	DownloadPage.Clear;
	DownloadPage.Show;
	
	if (FileExists(ExpandConstant('{tmp}\COMUpdate.zip')) = false) AND (DirExists(ExpandConstant('{tmp}\COMUpdate')) = false) then			
		DownloadPage.Add(site, 'COMUpdate.zip', '');
		try
			try
				DownloadPage.Download;
			except
				//SuppressibleMsgBox(AddPeriod(GetExceptionMessage), mbCriticalError, MB_OK, IDOK);
			end;
		finally
	end;
	
	if (DirExists(ExpandConstant('{tmp}\COMUpdate')) = false) then
	begin				
		DoUnZip(ExpandConstant('{tmp}\COMUpdate.zip'),ExpandConstant('{tmp}\COMUpdate'));			
	end;
		
	shellExec('', ExpandConstant('{tmp}\COMUpdate\' + Format('{#UpdateFile}', [VersionString, BitString, '']) +'\update.exe'), '', '', SW_SHOW, ewWaitUntilTerminated, ErrorCode);		
			
	DownloadPage.Hide;
end;

function VerifyVersion(const Dir: String; const MinimumVersion: Integer; const UnsupportedVersion: Integer): Boolean;
var
	Version: Integer;
	LineTarget: String;
begin
	if (EmptyFolder = false) then
	begin
		if(VersionFetch(WizardForm.DirEdit.Text + '\update.lst', Version, Format('{#Assembly}', [BitString]))) then
		begin
			if (Version < MinimumVersion) then
			begin
			
#if LMMT == false	
        if (IsCR) AND (Version < UnsupportedVersion)then
        begin
          MsgBox(FmtMessage(CustomMessage('GameUnsupported1'),[IntToStr(UnsupportedVersion), IntToStr(Version) + ' ' + bitString]), mbCriticalError, MB_OK);
					Result := false;
					exit;
        end;
#endif
			
				MsgBox(FmtMessage(CustomMessage('GameOutdated'),[IntToStr(MinimumVersion), IntToStr(Version) + ' ' + bitString]), mbCriticalError, MB_OK);

#if LMMT == false	
        if (IsEng(Dir) = 1)then
        begin
          VersionFetch(Dir + '\update.lst', Version, '{#TargetApp}')
        end;
#endif
				DownloadUpdate(Version, UnsupportedVersion, Dir);
				Result := false;
				exit;
			end; 
#if LMMT == false			
			if NOT (IsCR) AND (Version >= UnsupportedVersion) then
			begin
				MsgBox(FmtMessage(CustomMessage('GameUnsupported'),[IntToStr(UnsupportedVersion),IntToStr(Version)]), mbCriticalError, MB_OK);
				Result := false;
				exit;
			end;
#endif
      
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
		MsgBox(FmtMessage(CustomMessage('StorageSpaceLow2'),IntToStr(FreeSpace1)), mbCriticalError, MB_OK)
		Result := false;
		exit;
	end;
		
	if VerifyPath(WizardForm.DirEdit.Text) = false then
	begin
		Result := false;
		exit;
	end;

#if LMMT == true
	log('Now noting the bits down...')
	NoteBits(WizardForm.DirEdit.Text);
#endif
		
  if (EmptyFolder = false) AND (VerifyVersion(WizardForm.DirEdit.Text, MinimumVersion, {#UnsupportedVersion}) = false) then
	begin
		Result := false;
		exit;
	end;

	//MsgBox('We should be returning true', mbInformation, MB_OK);
	//Small advisory, hope users follow it.
	MsgBox(CustomMessage('EnsureGameClosed'), mbInformation, MB_OK);
	Result := true			 
end;
[/Code]