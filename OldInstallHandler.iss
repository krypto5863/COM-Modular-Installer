[Code]
function MoveOld(const GameDirectory: String): Boolean;
var
  ThingsToMove: Array of string;
  I : Integer;
begin

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

  if (DirExists(GameDirectory + '\OldInstall') = false) then
  begin
    if (CreateDir(GameDirectory + '\OldInstall') = false) then
    begin
      result := false;
      exit;
    end
  end;

  for i := 0 to GetArrayLength(ThingsToMove) - 1 do
  begin
    if (DirExists(GameDirectory + ThingsToMove[i])) OR (FileExists(GameDirectory + ThingsToMove[i])) then
    begin

      Log('Moving: ' + GameDirectory + ThingsToMove[i])

      if Move(GameDirectory + ThingsToMove[i], GameDirectory + '\OldInstall' + ThingsToMove[i]) = false then
      begin
        result := false;
        exit;
      end
    end
  end;
  
  result := true; 
end;

function MoveOldMod(const GameDirectory: String): Boolean;
var
  ModsToMove: Array of string;
  I : Integer;
begin

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

  if (DirExists(GameDirectory + '\OldInstall\Mod') = false) then
  begin
    if (CreateDir(GameDirectory + '\OldInstall\Mod') = false) then
    begin
      result := false;
      exit;
    end
  end;

  for i := 0 to GetArrayLength(ModsToMove) - 1 do
  begin
    if (DirExists(GameDirectory + '\Mod' + ModsToMove[i])) OR (FileExists(GameDirectory + '\Mod' + ModsToMove[i])) then
    begin

      Log('Moving: ' + GameDirectory + '\Mod' + ModsToMove[i])

      if Move(GameDirectory + '\Mod' + ModsToMove[i], GameDirectory + '\OldInstall\Mod' + ModsToMove[i]) = false then
      begin
        result := false;
        exit;
      end
    end
  end;
  
  result := true; 
end;

function MoveOldConfigBack(const path: String): boolean;
var
  ConfigsToMove: array of string;
  i : integer;
begin
  ConfigsToMove := [
    '\Sybaris\UnityInjector\Config',
    '\i18nEx',
    '\BepinEx\Config'
  ]

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