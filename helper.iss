[Code]
//Checks if a given string contains another given string.
function StringContains(const string: WideString; const substring: WideString): Boolean;
external 'CMIHelperSC@{#HelperDLLCodes}';
//This function compares versions, returns if comparison was successful and puts the result to an out
function VersionCompare(const VersionOld: WideString; const VersionNew: WideString; out res: Integer): Boolean;
external 'CMIHelperIVOT@{#HelperDLLCodes}';
//Will get a Directories creation time. Mostly used to change name of OldInstall directory.
function GetDirectoryCreationTime(const path: WideString; out time: WideString): Boolean;
external 'CMIHelperGDCT@{#HelperDLLCodes}';
//Find file in directory and sub directories...
function FindFile(const file: WideString; const directory: WideString; out path: WideString): Boolean;
external 'CMIHelperFF@{#HelperDLLCodes}';

procedure FetchUpdateFile(const site: WideString; out file: WideString);
external 'CMIHelperGLU@{#HelperDLLCodes}';
{
//Attempts to dynamically fetch a file given a search string, some modders use non-standard names. This goes through several releases, not just the latest. If the version string is empty though, just goes through the latest
procedure FetchDRelease(const site: WideString; const searchString: WideString; const version: WideString; out dlink: WideString);
external 'CMIHelperGHRF@files:CMIHelper.dll stdcall delayload';
//Tries to fetch the latest version of a repo. Used for CMI update checking.
procedure FetchLVersion(const site: WideString; out version: WideString);
external 'CMIHelperFLV@files:CMIHelper.dll stdcall delayload';
}

Function Copy(const Source: String; const Destination: String): Boolean;
var
	ResultCode: Integer;
	Args: String;
begin

	args := '/y /s /c /i';

	ShellExec('', ExpandConstant('{sys}\cmd.exe'),
	'/c xcopy' +
	' "' + Source + '" ' +
	' "' + Destination + '" ' +
	args,
	'', SW_SHOW, ewWaitUntilTerminated, ResultCode);

	if (ResultCode <> 0) then
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

	args := '/y';

	ShellExec('', ExpandConstant('{sys}\cmd.exe'),
	'/c move ' +
	args +
	' "' + Source + '" ' +
	' "' + Destination + '" ',
	'', SW_SHOW, ewWaitUntilTerminated, ResultCode);

	if (ResultCode <> 0) then
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
	'', SW_SHOW, ewWaitUntilTerminated, ResultCode);

	if (ResultCode <> 0) then
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
	Command: String;
begin

	Args := '-r';
	Args2 := '/s /d';
	Command := '/c attrib ' + args + ' "' + Target + '\*.*" ' + args2;

	ShellExec('', ExpandConstant('{cmd}'), Command, '', SW_SHOW, ewWaitUntilTerminated, ResultCode);

	if (ResultCode <> 0) then
	begin
		Log('Move failed when invoking command: ' + Command);

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

	if FileExists(path) = false then
	begin
		exit;
	end;

	if LoadStringsFromFile(path, Preset) = false then
	begin
		MsgBox(FmtMessage(CustomMessage('CannotLoadPreset'), [path]), mbCriticalError, MB_OK);
		exit;
	end;

	for Index := 0 to (Wizardform.ComponentsList.items.count-1) do
	begin
		while (GetArrayLength(Preset) > Line) do
		begin

			if (CompareText(Preset[Line], Wizardform.ComponentsList.ItemCaption[Index]) = 0) then
			begin

				Wizardform.ComponentsList.Checked[Index] := true;
				break;

			end;

			Line := Line+1;

		end;

		Line := 0;
	end;

end;

Function SaveCustomPreset(const path: String): Boolean;
var
	I: Integer;
begin

	if FileExists(path + '\' + PresetFile) then
	begin

		if (MsgBox(CustomMessage('ConfirmPresetSave'), mbConfirmation, MB_YESNO) = IDNO) then
		begin
			result := true;
			exit;
		end;

		if NOT DeleteFile(path + '\' + PresetFile) then
		begin
			result := false;
			exit;
		end;

	end;

	for I := 0 to Wizardform.ComponentsList.items.count-1 do
	begin

		if NOT Wizardform.ComponentsList.Checked[I] then
		begin
			continue;
		end;

		if NOT SaveStringToFile(path + '\' + PresetFile,Wizardform.ComponentsList.ItemCaption[I] + #13#10, True) then
		begin

			result := false;
			exit;

		end;

	end;

	result := true;
end;

function IsEmptyFolder(): Boolean;
begin
	Result := EmptyFolder;
end;

function GetComponentIndex(const name: String): Integer;
var
	I: Integer;
begin

	for I := 0 to (Wizardform.ComponentsList.items.count-1) do
	begin

		if (CompareText(Wizardform.ComponentsList.ItemCaption[I], name) = 0) then
		begin
			result := I;
			exit;
		end;

	end;

	result := -1;

end;

function GetTypeIndex(const name: String): Integer;
var
	I: Integer;
begin

	for I := 0 to (Wizardform.TypesCombo.items.count - 1) do
	begin

		if (CompareText(Wizardform.TypesCombo.Items[I], name) = 0) then
		begin
			result := I;
			exit;
		end;

	end;

	result := -1;

end;


procedure RemoveComponent(component: string);
var
	index: Integer;
begin
	index := GetComponentIndex(component);

	if (index = -1) then
	begin
		Log('Failed to fetch index for component: ' + component);
		exit;
	end;

	Wizardform.ComponentsList.CheckItem(GetComponentIndex(component), coUncheck);
	Wizardform.ComponentsList.ItemEnabled[GetComponentIndex(component)] := false;
end;

procedure RemoveType(itype: string);
begin
	Wizardform.ComponentsList.Checked[GetTypeIndex(itype)] := false;
	Wizardform.ComponentsList.Items.Delete(GetTypeIndex(itype));
	WizardForm.TypesCombo.ItemIndex := 0;
end;

function StringFetch(const File: string; out FetchedString: String; const LineToFetch: String): Boolean;
var
	i: Integer;
	s: array of string;
	line: string;
begin

	i := 0;

	if NOT FileExists(File) then
	begin
		result := false;
		exit;
	end;

	if NOT LoadStringsFromFile(File, s) then
	begin
		Log(FmtMessage(CustomMessage('VersionFetchLoadFail'), [File]));
		result := false;
		exit;
	end;

	while (GetArrayLength(s) > i) AND NOT StringContains(s[i], LineToFetch) do
	begin
		i := i + 1;
	end;

	if (i = GetArrayLength(s)) OR NOT StringContains(s[i], LineToFetch) then
	begin
		Log('String containing that string could not be found...');
		result := false;
		exit;
	end;

	line := s[i];

	if (StringChangeEx(line, LineToFetch, '', true) <= 0) then
	begin
		Log(CustomMessage('VersionFetchLineCleanFail'));
		result := false;
		exit;
	end;

	FetchedString := line;

	result := true;
end;
[/Code]