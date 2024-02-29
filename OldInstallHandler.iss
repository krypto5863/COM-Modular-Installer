[Code]
function MoveDirFileRecurse(const GameDirectory: String; const SubDirs: Array of String; const ThingsToMove: Array of String): Boolean;
var
	I, I1 : Integer;
	Path : String;
begin
	for i := 0 to (GetArrayLength(ThingsToMove) - 1) do
	begin
		for i1 := 0 to (GetArrayLength(SubDirs) - 1) do
		begin
		
			Path := GameDirectory + SubDirs[i1] + ThingsToMove[i];
		
			if not DirExists(Path) AND not FileExists(Path) then
				continue;

			if NOT DirExists(GameDirectory + '\OldInstall' + SubDirs[i1]) then
			begin
				if NOT ForceDirectories(GameDirectory + '\OldInstall' + SubDirs[i1]) then
				begin
					Log('Failed to make path in oldinstall in ' + GameDirectory + '\OldInstall' + SubDirs[i1]);
					result := false;
					exit;
				end;
			end;

			Log('Moving: ' + Path);

			if NOT Move(Path, GameDirectory + '\OldInstall' + SubDirs[i1] + ThingsToMove[i]) then
			begin
				result := false;
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

	#if LMMT == false
	ThingsToMove := [
		'\Sybaris',
		'\BepinEX',
        '\BepInEx_Shim_Backup',
		'\i18nEx',
		'\IMGUITranslationLoader',
		'\scripts',
		'\IMG',
        '\ShaderServantPacks',
        '\ML_temp',
		'\doorstop_config.ini',
		'\winhttp.dll',
		'\version.dll',
		'\opengl32.dll',
		'\EngSybarisArcEditor.exe',
		'\SybarisArcEditor.exe',
		'\CMI Documentation',
		'\CMI.ver',
		'\COM3D2 DLC Checker.exe'
	];
	#else
	ThingsToMove := [
		'\Loader',
		'\Plugins',
		'\Poses',
		'\Preset',
		'\IgnoreMenus.txt',
		'\BepinEX',
        '\BepInEx_Shim_Backup',
		'\i18nEx',
		'\IMGUITranslationLoader',
		'\scripts',
		'\IMG',
		'\doorstop_config.ini',
		'\winhttp.dll',
		'\version.dll',
		'\opengl32.dll',
		'\EngSybarisArcEditor.exe',
		'\SybarisArcEditor.exe',
		'\LMMT Documentation',
		'\LMMT.ver',
		'\CM3D2 DLC Checker.exe'
	];
	#endif
	
	result := MoveDirFileRecurse(GameDirectory, SubDirs, ThingsToMove);
end;

function MoveOldMod(const GameDirectory: String; const SubDirs: Array of String): Boolean;
var
	ModsToMove: Array of string;
	I, I1 : Integer;
begin

#if LMMT == false
	ModsToMove := [
		'\MultipleMaidsPose',
		'\Extra Desk Items',
		'\Mirror_props',
		'\PhotMot_Nei',
		'\PhotoBG_NEI',
		'\PhotoBG_OBJ_NEI',
		'\Pose_sample',
		'\[CMI]Uncensors',
		'\[CMI]XTFutaAccessories',
		'\[CMI]PosterLoader',
		'\TextureUncensors',
		'\EmotionalEars',
		'\CinemacicBloom_StreakPmats(SceneCapture)'
	];
#else
	ModsToMove := [
		'\MultipleMaidsPose',
		'\[CMI]EmotionalEars',
		'\[CMI]VYM Files',
		'\[CMI]Uncensors'
	];
#endif

	result := MoveDirFileRecurse(GameDirectory, SubDirs, ModsToMove);
end;

function MoveOldConfigBack(const path: String): boolean;
var
	ConfigsToMove: array of string;
	i : integer;
begin

#if LMMT == false
	ConfigsToMove := [
		'\Sybaris\UnityInjector\Config',
		'\i18nEx',
		'\BepinEx\Config'
	];
#else
	ConfigsToMove := [
		'\Sybaris\Plugins\UnityInjector\Config',
		'\BepinEx\Config'
	];
#endif

	for i := 0 to (GetArrayLength(ConfigsToMove) - 1) do
	begin
	
		if DirExists(path + '\OldInstall' + ConfigsToMove[i]) AND DirExists(path + ConfigsToMove[i]) then
		begin
		
			if NOT Copy(path + '\OldInstall' + ConfigsToMove[i], path + ConfigsToMove[i]) then
			begin			
				result := false;
				exit;
			end;		
		end;	
	end;

	result := true;
end;

function AppendCreationTimeToName(const path: String): boolean;
var
DateTime: WideString;
begin
	if NOT GetDirectoryCreationTime(path, DateTime) then
	begin
		result := false;
		exit;
	end;

	if NOT Rename(path, 'OldInstall ' + DateTime) then
	begin
		log('Could not rename: ' + path + ' to ' + path + ' ' + DateTime);
		result := false;
		exit;
	end;

	result := true;
end;
[/Code]