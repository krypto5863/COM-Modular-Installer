[Code]
  //Checks if a given string contains another given string.
  function StringContains(const string: WideString; const substring: WideString): Boolean;
  external 'CMIHelperSC@files:CMIHelper.dll stdcall delayload';
	//This function compares versions, returns if comparison was successful and puts the result to an out
	function VersionCompare(const VersionOld: WideString; const VersionNew: WideString; out res: Integer): Boolean;
	external 'CMIHelperIVOT@files:CMIHelper.dll stdcall delayload';
  //Will get a Directories creation time. Mostly used to change name of OldInstall directory.
  function GetDirectoryCreationTime(const path: WideString; out time: WideString): Boolean;
  external 'CMIHelperGDCT@files:CMIHelper.dll stdcall delayload';
	//This function moves old files into the OldInstall Folder during install
	//function MoveOld(path: WideString): Boolean;
	//external 'CMIHelperM@files:CMIHelper.dll stdcall delayload';
	//This function moves old mods into the old install folder during install
	//function MoveOldMod(const path: WideString): Boolean;
	//external 'CMIHelperMO@files:CMIHelper.dll stdcall delayload';
	//Renames the oldinstall folder to prevent overwriting on subsequent runs.
	//function RenameOldInstall(const path: WideString): Boolean;
	//external 'CMIHelperOR@files:CMIHelper.dll stdcall delayload';
	//This function removes the read-only flag from all files in the game folder.
	//procedure RemoveRO(const path: WideString);
	//external 'CMIHelperRO@files:CMIHelper.dll stdcall delayload';
	//Try to move config files back
	//function ReturnConfig(const path: WideString): Boolean;
	//external 'CMIHelperRC@files:CMIHelper.dll stdcall delayload';
	//Checks if a url is a valid site that can be reached
	function SiteValid(const url: WideString): Boolean;
	external 'CMIHelperWE@files:CMIHelper.dll stdcall delayload';
	//Read manifests and decide if the installer is outdated or not
	//function IsInstallerOld(const tpath: WideString; const version: WideString): Boolean;
	//external 'CMIHelperCI@files:CMIHelper.dll stdcall delayload';
  //Tries to fetch the latest github release of a downloaded plugin.
	procedure FetchLRelease(const site: WideString; out dlink: WideString);
	external 'CMIHelperFLR@files:CMIHelper.dll stdcall delayload';
  
  Function Copy(const Source: String; const Destination: String): Boolean;
  var
    ResultCode: Integer;
    Args: String;
  begin

    args := '/y /s /c /i'

    ShellExec('', ExpandConstant('{sys}\cmd.exe'), 
    '/c xcopy' + 
    ' "' + Source + '" ' + 
    ' "' + Destination + '" ' + 
    args,
    '', SW_SHOW, ewWaitUntilTerminated, ResultCode)

    if (ResultCode) <> 0 then
    begin
      result := false;
      exit;
    end;

    Result := true;
  end;

  Function Move(const Source: String; const Destination: String): Boolean;
  var
    ResultCode: Integer;
    Args: String;
  begin

    args := '/y'

    ShellExec('', ExpandConstant('{sys}\cmd.exe'), 
    '/c move ' + 
    args + 
    ' "' + Source + '" ' +
    ' "' + Destination + '" ',
    '', SW_SHOW, ewWaitUntilTerminated, ResultCode)

    if (ResultCode) <> 0 then
    begin
      Log('Move failed when invoking command: ' + 
			'/c move ' + 
			args + 
			' "' + Source + '" ' +
			' "' + Destination + '" ');
		
      result := false;
      exit;
    end;

    Result := true;
  end;

  Function Rename(const OldName: String; const NewName: String): Boolean;
  var
    ResultCode: Integer;
  begin

    ShellExec('', ExpandConstant('{sys}\cmd.exe'), 
    '/c rename' +  
    ' "' + OldName + '" ' +
    ' "' + NewName + '"',
    '', SW_SHOW, ewWaitUntilTerminated, ResultCode)

    if (ResultCode) <> 0 then
    begin
      Log('Rename failed on: ' + OldName);
      result := false;
      exit;
    end;

    Result := true;
  end;
	
	Function RemoveReadonlyRecursive(const Target: String): Boolean;
  var
    ResultCode: Integer;
    Args: String;
		Args2: String;
  begin

    args := '-r'
		args2 := '/s /d'

    ShellExec('', ExpandConstant('{cmd}'), 
    '/c attrib ' + 
    args + 
    ' "' + Target + '\*.*" ' +
		args2,
    '', SW_SHOW, ewWaitUntilTerminated, ResultCode)

    if (ResultCode) <> 0 then
    begin
      Log('Move failed when invoking command: ' + 
				'/c attrib ' + 
				args + 
				' "' + Target + '" ' +
				args2);
		
      result := false;
      exit;
    end;

    Result := true;
  end;

	procedure ApplyCustomPreset(const path: String);
	var
		Index: Integer;
    Line: Integer;
    Preset: array of string;
	begin

    if (FileExists(path) = false) then
    begin
      exit;
    end;

    if LoadStringsFromFile(path, Preset) = false then
    begin
      MsgBox(FmtMessage(CustomMessage('CannotLoadPreset'), path), mbCriticalError, MB_OK);
      exit;
    end;

		for Index := 0 to Wizardform.ComponentsList.items.count-1 do
		begin	
      while (GetArrayLength(Preset) > Line) do
      begin

        if CompareText(Preset[Line], Wizardform.ComponentsList.ItemCaption[Index]) = 0 then
        begin
          Wizardform.ComponentsList.Checked[Index] := true
          break;
        end;

        Line := Line+1
      end;
      Line := 0;
		end;

	end;

	Function SaveCustomPreset(const path: String): Boolean;
	var
		I: Integer;
	begin
		if (FileExists(path + '\' + PresetFile)) then
		begin
			if (MsgBox(CustomMessage('ConfirmPresetSave'), mbConfirmation, MB_YESNO)) = IDYES then
			begin
				if DeleteFile(path + '\' + PresetFile) = false then
				begin
					result := false;
					exit;
				end;
			end else begin
				result := true;
				exit;
			end;
		end;

		for I := 0 to Wizardform.ComponentsList.items.count-1 do
		begin
			if Wizardform.ComponentsList.Checked[I] = true then
			begin
				if SaveStringToFile(path + '\' + PresetFile,Wizardform.ComponentsList.ItemCaption[I] + #13#10, True) = false then
				begin
					result := false
					exit;
				end
			end;
		end;
		
		result := true;
	end;
	
	function IsEmptyFolder(): Boolean;
	begin
		Result := EmptyFolder;
	end;
{
	function ComponentSelected(const name: String): Boolean;
	var
		I: Integer;
		res: Boolean; 
	begin

		res := false;

		for I := 0 to Wizardform.ComponentsList.items.count-1 do
		begin
			if Wizardform.ComponentsList.Checked[I] = true then
			begin
				//MsgBox('Component was selected name of: ' + Wizardform.ComponentsList.ItemCaption[I], mbInformation, MB_OK);
				if (CompareText(Wizardform.ComponentsList.ItemCaption[I], name) = 0) then
				begin
					//MsgBox('Component was selected, returning true', mbInformation, MB_OK);
					res := true
					break;
				end
			end;
		end;	
		result := res
	end;
}	
	function GetComponentIndex(const name: String): Integer;
	var
		I: Integer;
	begin

		for I := 0 to Wizardform.ComponentsList.items.count-1 do
		begin
			//MsgBox('Component was selected name of: ' + Wizardform.ComponentsList.ItemCaption[I], mbInformation, MB_OK);
			if (CompareText(Wizardform.ComponentsList.ItemCaption[I], name) = 0) then
			begin
				//MsgBox('Component was selected, returning true', mbInformation, MB_OK);
				result := I
				exit;
			end
		end;	
		result := -1;
	end;
	
function StringFetch(const File: string; out FetchedString: String; const LineToFetch: String): Boolean;
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
		Log(FmtMessage(CustomMessage('VersionFetchLoadFail'), File));
		result := false;
		exit;
	end;	
	
	while (GetArrayLength(s) > i) AND (StringContains(s[i], LineToFetch) = false) do
	begin
		i := i+1
	end;
	
	if (i = GetArrayLength(s)) OR (StringContains(s[i], LineToFetch) = false) then
	begin
		Log('String containing that string could not be found...');
		result := false;
		exit;
	end;
	
	line := s[i];
	
	if StringChangeEx(line, LineToFetch, '', true) <= 0 then
  begin
    Log(CustomMessage('VersionFetchLineCleanFail'));
		result := false
		exit;
  end;
	
	FetchedString := line;
	
	result := true;	
end;
[/Code]