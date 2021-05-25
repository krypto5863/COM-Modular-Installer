[Code]
function MoveOld(const GameDirectory: String; const SubDirs: Array of String): Boolean;
var
  ThingsToMove: Array of string;
  I, I1 : Integer;
begin

#if LMMT == false
  ThingsToMove := [
    '\Sybaris',
    '\BepinEX',
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
  for i := 0 to GetArrayLength(ThingsToMove) - 1 do
  begin
		for i1 := 0 to GetArrayLength(SubDirs) - 1 do
		begin
			if (DirExists(GameDirectory + SubDirs[i1] + ThingsToMove[i])) OR (FileExists(GameDirectory + SubDirs[i1] + ThingsToMove[i])) then
			begin
			
				if (DirExists(GameDirectory + '\OldInstall' + SubDirs[i1]) = false) then
				begin
					if (ForceDirectories(GameDirectory + '\OldInstall' + SubDirs[i1]) = false) then
					begin
						Log('Failed to make path in oldinstall in ' + GameDirectory + '\OldInstall' + SubDirs[i1])
						result := false;
						exit;
					end
				end;

				Log('Moving: ' + GameDirectory + SubDirs[i1] + ThingsToMove[i])

				if Move(GameDirectory + SubDirs[i1] + ThingsToMove[i], GameDirectory + '\OldInstall' + SubDirs[i1] + ThingsToMove[i]) = false then
				begin
					result := false;
					exit;
				end
			end
    end
  end;	 
  result := true; 
end;

function MoveOldMod(const GameDirectory: String; const SubDirs: Array of String): Boolean;
var
  ModsToMove: Array of string;
	ModDir: String;
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
  ]
#else
	  ModsToMove := [
    '\MultipleMaidsPose',
    '\[CMI]EmotionalEars',
    '\[CMI]VYM Files',
    '\[CMI]Uncensors'
  ]
#endif

  for i := 0 to GetArrayLength(ModsToMove) - 1 do
  begin
	  for i1 := 0 to GetArrayLength(SubDirs) - 1 do
		begin	
			Log('Looking in ' + GameDirectory  + SubDirs[i1] + ModsToMove[i])
	
			if (DirExists(GameDirectory  + SubDirs[i1] + ModsToMove[i])) OR (FileExists(GameDirectory + SubDirs[i1] + ModsToMove[i])) then
			begin
			
				if (DirExists(GameDirectory + '\OldInstall' + SubDirs[i1]) = false) then
				begin
					if (ForceDirectories(GameDirectory + '\OldInstall' + SubDirs[i1]) = false) then
					begin
						Log('Failed to make path in oldinstall in ' + GameDirectory + '\OldInstall' + SubDirs[i1])
						result := false;
						exit;
					end
				end;

				Log('Moving: ' + GameDirectory  + SubDirs[i1] + ModsToMove[i])

				if Move(GameDirectory  + SubDirs[i1] + ModsToMove[i], GameDirectory + '\OldInstall' + SubDirs[i1] + ModsToMove[i]) = false then
				begin
					result := false;
					exit;
				end				
			end;
    end
  end;
  
  result := true; 
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
  ]
#else
	  ConfigsToMove := [
    '\Sybaris\Plugins\UnityInjector\Config',
    '\BepinEx\Config'
  ]
#endif

  for i := 0 to GetArrayLength(ConfigsToMove) - 1 do
  begin
    if (DirExists(path + '\OldInstall' + ConfigsToMove[i])) AND (DirExists(path + ConfigsToMove[i])) then
    begin
      if Copy(path + '\OldInstall' + ConfigsToMove[i], path + ConfigsToMove[i]) = false then
      begin
        result := false
        exit;
      end
    end
  end; 

  result := true;
end;

function AppendCreationTimeToName(const path: String): boolean;
var
DateTime: WideString;
begin

  if GetDirectoryCreationTime(path, DateTime) = false then
  begin
    result := false;
    exit;
  end;

  if Rename(path, 'OldInstall ' + DateTime) = false then
  begin
    log('Could not rename: ' + path + ' to ' + path + ' ' + DateTime)
    result := false;
    exit;
  end;

  result := true;
end;
[/Code]