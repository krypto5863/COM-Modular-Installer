[Code]
function MoveDirFileRecurse(const GameDirectory: String; const SubDirs: Array of String; const ThingsToMove: Array of String): Boolean;
var
	I, I1, M : Integer;
	Path : String;
    Destination : String;
    DirectoriesToMove: Array of String;
begin

    for i1 := 0 to (GetArrayLength(SubDirs) - 1) do
	begin
        
        SetArrayLength(DirectoriesToMove, 0);
        Destination := AddBackslash(GameDirectory) + 'OldInstall\' + SubDirs[i1]
        Destination := RemoveBackslashUnlessRoot(Destination)

        for i := 0 to (GetArrayLength(ThingsToMove) - 1) do
        begin

            Path := AddBackslash(GameDirectory) + AddBackslash(SubDirs[i1]) + ThingsToMove[i];

            Log('Checking if path exists to move: ' + Path)

            if not DirExists(Path) AND not FileExists(Path) then
				continue;

            SetArrayLength(DirectoriesToMove, GetArrayLength(DirectoriesToMove) + 1);
            DirectoriesToMove[GetArrayLength(DirectoriesToMove) - 1] := Path;

        end;
        
        if (GetArrayLength(DirectoriesToMove) > 0) then
        begin
            if NOT ShellMoveMultiple(DirectoriesToMove, Destination) then
            begin

                Result := false;
                exit;

            end;
        end;

    end;
	
	result := true;
end;

function MoveOld(const GameDirectory: String; const SubDirs: Array of String): Boolean;
var
	ThingsToMove: Array of string;
	I, I1 : Integer;
	Path : String;
begin

	ThingsToMove := [
		'Sybaris',
		'BepinEX',
        'BepInEx_Shim_Backup',
		'i18nEx',
		'IMGUITranslationLoader',
		'scripts',
		'IMG',
        'ShaderServantPacks',
        'ML_temp',
		'doorstop_config.ini',
		'winhttp.dll',
		'version.dll',
		'opengl32.dll',
		'EngSybarisArcEditor.exe',
		'SybarisArcEditor.exe',
		'CMI Documentation',
		'CMI.ver',
		'COM3D2 DLC Checker.exe'
	];
	
	result := MoveDirFileRecurse(GameDirectory, SubDirs, ThingsToMove);
end;

function MoveOldMod(const GameDirectory: String; const SubDirs: Array of String): Boolean;
var
	ModsToMove: Array of string;
	I, I1 : Integer;
begin

	ModsToMove := [
		'MultipleMaidsPose',
		'Extra Desk Items',
		'Mirror_props',
		'PhotMot_Nei',
		'PhotoBG_NEI',
		'PhotoBG_OBJ_NEI',
		'Pose_sample',
		'[CMI]Uncensors',
		'[CMI]XTFutaAccessories',
		'[CMI]PosterLoader',
		'TextureUncensors',
		'EmotionalEars',
		'CinemacicBloom_StreakPmats(SceneCapture)'
	];

	result := MoveDirFileRecurse(GameDirectory, SubDirs, ModsToMove);
end;

function MoveOldConfigBack(const path: String): boolean;
var
    OldPath, NewPath: String;
	ConfigsToMove: array of string;
    SourcePaths, DestinationPaths: array of string;
	i : integer;
begin

	ConfigsToMove := [
		'Sybaris\UnityInjector\Config',
		'i18nEx',
		'BepinEx\Config'
	];

	for i := 0 to (GetArrayLength(ConfigsToMove) - 1) do
	begin

        OldPath := AddBackSlash(path) + 'OldInstall\' + ConfigsToMove[i]
        NewPath := AddBackSlash(path) + ConfigsToMove[i]
	
		if DirExists(OldPath) then
		begin
            SetArrayLength(SourcePaths, GetArrayLength(SourcePaths) + 1);
            SourcePaths[GetArrayLength(SourcePaths) - 1] := AddBackSlash(OldPath) + '*';

            SetArrayLength(DestinationPaths, GetArrayLength(DestinationPaths) + 1);
            DestinationPaths[GetArrayLength(DestinationPaths) - 1] := NewPath;
		end;	
	end;

    if NOT ShellCopyMultipleDest(SourcePaths, DestinationPaths) then
	begin
        Log('Failed to move files from ' + OldPath + ' to ' + NewPath)
		result := false;
		exit;
	end;

	result := true;
end;

{
function AppendCreationTimeToName(const Path: String): boolean;
var
    DateTime: String;
begin

	if NOT GetCreatedFileDate(Path, DateTime) then
	begin
        log('Could not get created file date for ' + path);
		result := false;
		exit;
	end;

	if NOT ShellRename(Path, Path + ' ' + DateTime) then
	begin
		log('Could not rename: ' + Path + ' to ' + ExtractFileName(Path) + ' ' + DateTime);
		result := false;
		exit;
	end;

	result := true;
end;
}
[/Code]