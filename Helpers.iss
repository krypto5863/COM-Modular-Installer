#include "ShellFileOperations.iss"

[Code]
var
    EmptyFolder: Boolean;
function IsEmptyFolder(): Boolean;
begin
	Result := EmptyFolder;
end;

Function StringContains(target, substring: String): Boolean;
begin

    target := AnsiLowercase(target)
    substring := AnsiLowercase(substring)

    result := (Pos(substring, target) > 0)

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

	ShellExec('', ExpandConstant('{cmd}'), Command, '', SW_HIDE, ewWaitUntilTerminated, ResultCode);

	if (ResultCode <> 0) then
	begin
		Log('Move failed when invoking command: ' + Command);

		result := false;
		exit;
	end;

	Result := true;
end;

function AppendToName(const Path: String; const Suffix: String): boolean;
begin

	if NOT ShellRename(Path, Path + ' ' + Suffix) then
	begin
		log('Could not rename: ' + Path + ' to ' + ExtractFileName(Path) + ' ' + Suffix);
		result := false;
		exit;
	end;

	result := true;
end;

{
type  
SYSTEMTIME = record 
  Year:         WORD; 
  Month:        WORD; 
  DayOfWeek:    WORD; 
  Day:          WORD; 
  Hour:         WORD; 
  Minute:       WORD; 
  Second:       WORD; 
  Milliseconds: WORD; 
end; 

function FileTimeToSystemTime(FileTime:TFileTime; var SystemTime:  SYSTEMTIME): Boolean; 
external 'FileTimeToSystemTime@kernel32.dll stdcall'; 

function GetCreatedFileDate(const FilePath : String; out DateTimeString : String) : Boolean;
var 
    FindRec: TFindRec;  
    SystemInfo: SYSTEMTIME;  
begin
    Try
        if NOT DirExists(FilePath) AND NOT FileExists(FilePath) then
        begin
            Log(FilePath + ' does not exist!')
            Result := false
            exit;
        end;

        if NOT FindFirst(FilePath, FindRec) then
        begin
            Log(FilePath + ' could not be found!')
            Result := false
            exit;
        end;

        Log('Returning CreationTime DateTimeString for ' + FilePath)

        FileTimeToSystemTime( FindRec.CreationTime, SystemInfo);
        DateTimeString:= format('%.2d.%.2d.%d.%d.%.2d.%.2d', [SystemInfo.Month, SystemInfo.Day, SystemInfo.Year, SystemInfo.Hour, SystemInfo.Minute, SystemInfo.Second])
        Result := true;

    Finally
        FindClose(FindRec);
    end;
end;
}

procedure ApplyCustomPreset(const path: String);
var
	ComponentIndex: Integer;
	LineIndex: Integer;
	Preset: array of string;
begin

	if NOT FileExists(path) then
	begin
		exit;
	end;

	if NOT LoadStringsFromFile(path, Preset) then
	begin
		MsgBox(FmtMessage(CustomMessage('CannotLoadPreset'), [path]), mbCriticalError, MB_OK);
		exit;
	end;

	for ComponentIndex := 0 to (Wizardform.ComponentsList.Items.Count - 1) do
	begin

		for LineIndex := 0 to (GetArrayLength(Preset) - 1) do
		begin

			if (CompareText(Preset[LineIndex], Wizardform.ComponentsList.ItemCaption[ComponentIndex]) = 0) then
			begin

				Wizardform.ComponentsList.Checked[ComponentIndex] := true;
				break;

			end;

		end;

	end;

end;

Function SaveCustomPreset(const path: String): Boolean;
var
    PresetPath: String;
    FileString: String;
	I: Integer;
begin

    PresetPath := AddBackSlash(path) + PresetFile

	if FileExists(PresetPath) then
	begin

		if (MsgBox(CustomMessage('ConfirmPresetSave'), mbConfirmation, MB_YESNO) = IDNO) then
		begin
			result := true;
			exit;
		end;

		if NOT DeleteFile(PresetPath) then
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

        FileString := FileString + Wizardform.ComponentsList.ItemCaption[I] + #13#10;

	end;
    
	if NOT SaveStringToFile(PresetPath, Trim(FileString), True) then
	begin
		result := false;
		exit;
	end;

	result := true;
end;

procedure UncheckDisableComponents(const components: Array of string);
var
	M, I: Integer;
    ToDisable: Array of integer;
begin

    for M := Wizardform.ComponentsList.Items.Count - 1 downto 0 do
    begin

        for I := 0 to (GetArrayLength(components)-1) do
        begin
            if (CompareText(Wizardform.ComponentsList.ItemCaption[M], components[I]) = 0) then
            begin
                
                SetArrayLength(ToDisable, GetArrayLength(ToDisable) + 1);
                ToDisable[GetArrayLength(ToDisable) - 1] := M;

                Wizardform.ComponentsList.ItemEnabled[M] := true;  

                if Wizardform.ComponentsList.Checked[M] AND NOT Wizardform.ComponentsList.CheckItem(M, councheck) then
                    Log('Failed to uncheck ' + Wizardform.ComponentsList.ItemCaption[M] + '!');
            
                break;

            end;
        end;

    end;

    for M := 0 to (GetArrayLength(ToDisable)-1) do
    begin
        Wizardform.ComponentsList.ItemEnabled[ToDisable[M]] := false;
    end;

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