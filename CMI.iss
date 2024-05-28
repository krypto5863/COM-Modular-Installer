﻿; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "COM Modular Installer"
#define MyAppVersion "2.6.1"
#define MyAppURL "https://krypto5863.github.io/COM-Modular-Installer/"
#define MyAppUpdates "https://github.com/krypto5863/COM-Modular-Installer/releases"
#define MyAppSupport "https://github.com/krypto5863/COM-Modular-Installer/issues"

#define MinimumVersion 23400
#define CRMinimumVersion 33400
#define CRStartVersion 30000

#define JapRegistry "Software\KISS\カスタムオーダーメイド3D2"
#define JapRegistryCR "Software\KISS\カスタムオーダーメイド3D2.5"
#define EnglishRegistry "Software\KISS\CUSTOM ORDER MAID3D 2"
#define EnglishRegistryCR "Software\KISS\CUSTOM ORDER MAID3D 2.5"

#define ShortName "CMI"

#define SrcDir "Installer Files"
#define SrcDirFiles "Installer Files/Components"

#define ModDir "Mod"
[Setup]
OutputBaseFilename={#MyAppName} {#MyAppVersion}
OutputDir=Compiled_EXE

; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{8143E460-C581-40B8-9D11-2FFC2DD35ADF}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppSupport}
AppUpdatesURL={#MyAppUpdates}

PrivilegesRequired=admin
SetupLogging=yes
Uninstallable=yes
CreateUninstallRegKey=no

Compression=lzma2/ultra64
LZMAUseSeparateProcess=yes
;LZMANumBlockThreads=12
;LZMADictionarySize=1048576
;LZMANumFastBytes=273

DisableDirPage=no
DefaultDirName={#MyAppName}
DirExistsWarning=no
AppendDefaultDirName=no

LicenseFile={#SrcDir}\Documentation\license.txt
InfoBeforeFile={#SrcDir}\Documentation\info.txt

WizardStyle=modern
SetupIconFile={#SrcDir}\UI\icon.ico
WizardSmallImageFile={#SrcDir}\UI\icon.bmp
WizardSizePercent=150

//Banner Images.
[Files]
Source: "{#SrcDir}\UI\rabbit.bmp"; Flags: dontcopy
Source: "{#SrcDir}\UI\kite.bmp"; Flags: dontcopy
Source: "{#SrcDir}\UI\kry.bmp"; Flags: dontcopy
Source: "{#SrcDir}\UI\pain.bmp"; Flags: dontcopy
Source: "{#SrcDir}\UI\joco.bmp"; Flags: dontcopy
Source: "{#SrcDir}\UI\shin.bmp"; Flags: dontcopy
[/Files]

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl, {#SrcDir}\Messages\English.isl"
Name: "armenian"; MessagesFile: "compiler:Languages\Armenian.isl"
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
Name: "catalan"; MessagesFile: "compiler:Languages\Catalan.isl"
Name: "chinesesimplified"; MessagesFile: "{#SrcDir}\Messages\ChineseSimplifiedDefault.isl, {#SrcDir}\Messages\Simplified_ChineseCMI.isl"
Name: "corsican"; MessagesFile: "compiler:Languages\Corsican.isl"
Name: "czech"; MessagesFile: "compiler:Languages\Czech.isl"
Name: "danish"; MessagesFile: "compiler:Languages\Danish.isl"
Name: "dutch"; MessagesFile: "compiler:Languages\Dutch.isl"
Name: "finnish"; MessagesFile: "compiler:Languages\Finnish.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl, {#SrcDir}\Messages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "hebrew"; MessagesFile: "compiler:Languages\Hebrew.isl"
Name: "icelandic"; MessagesFile: "compiler:Languages\Icelandic.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"
Name: "norwegian"; MessagesFile: "compiler:Languages\Norwegian.isl"
Name: "polish"; MessagesFile: "compiler:Languages\Polish.isl"
Name: "portuguese"; MessagesFile: "compiler:Languages\Portuguese.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "slovak"; MessagesFile: "compiler:Languages\Slovak.isl"
Name: "slovenian"; MessagesFile: "compiler:Languages\Slovenian.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl, {#SrcDir}\Messages\Spanish.isl"
Name: "turkish"; MessagesFile: "compiler:Languages\Turkish.isl"
Name: "ukrainian"; MessagesFile: "compiler:Languages\Ukrainian.isl"

[Types]
Name:"compact"; Description:{cm:TypeCompact}
Name:"full"; Description:{cm:TypeFull}
Name:"eng"; Description:{cm:TypeEng}
Name:"notr"; Description:{cm:TypeNoTr}
Name:"pic"; Description:{cm:TypePic}
Name:"hen"; Description:{cm:TypeHen}
Name:"self"; Description:{cm:TypeSelf}
Name:"custom"; Description:{cm:TypeCustom}; Flags:iscustom
Name:"preset"; Description:{cm:TypePreset}
Name:"core"; Description:{cm:TypeCore}

[Components]

Name: ModExt; Description: Modding Extensions;
    Name: ModExt/MaidLoader; Description: MaidLoader; Flags: exclusive; Types: full compact eng notr pic hen self;
    Name: ModExt/modloader; Description: ModLoader; Flags: exclusive;

Name: bepinexPlugs; Description: BepInEx Plugins;
	Name: bepinexPlugs/addyot; Description: AddYotogiSliderSE2; Types: Full compact eng notr hen self;
	Name: bepinexPlugs/AdvMatMod; Description: AdvancedMaterialModifier; Types: self;
	Name: bepinexPlugs/autosave; Description: AutoSave; Types: Full eng notr hen self;
	Name: bepinexPlugs/cameracon; Description:CameraControlEx; Types:full pic eng notr self;
    Name: bepinexPlugs/cheatMenu; Description:CheatMenu;
	Name: bepinexPlugs/choosypreset; Description:ChoosyPreset; Types:full pic eng notr self;
    Name: bepinexPlugs/colorpresetnum; Description:ColorPresetNum;
	Name: bepinexPlugs/ConfigMan; Description: ConfigurationManager; Types: full notr compact eng pic self hen;
	Name: bepinexPlugs/UPCheck; Description: CMIUpdateChecker; Types: full notr compact eng pic self hen;
	Name: bepinexPlugs/EditBodyLoadFix; Description: EditBodyLoadFix; Types:full notr compact eng pic self hen;
    Name: bepinexPlugs/EditModeHighlights; Description: EditModeHighlights; Types:full notr eng pic self hen;
	Name: bepinexPlugs/ExErrorHandle; Description: ExtendedErrorHandling; Types:full notr compact eng pic self hen;
	Name: bepinexPlugs/ExPresetMan; Description: ExtendedPresetManagement; Types:full notr compact eng pic self hen;
	Name: bepinexPlugs/FPSCount; Description: FPSCounter; Types: self;
	Name: bepinexPlugs/FPSUn; Description: FPSUnlock; Types: self;
	Name: bepinexPlugs/GearFix; Description: GearMenuFix; Types:full notr compact eng pic self hen;
	Name: bepinexPlugs/InBlock; Description: InputHotkeyBlock; Types: full notr compact eng pic self hen;
	Name: bepinexPlugs/meidophoto; Description: MeidoPhotoStudio; Types: full notr eng pic self;
		Name: bepinexPlugs/meidophoto/Poses; Description: 1900 Poses for MPS; Flags: dontinheritcheck;
	Name: bepinexPlugs/modref; Description: ModRefresh; Types:full pic self eng notr;
    Name: bepinexPlugs/ShaderServant; Description: ShaderServant; Types: Full notr eng pic self hen;
	Name: bepinexPlugs/ShapekeyMaster; Description: ShapekeyMaster; Types: Full notr eng pic self hen;
	Name: bepinexPlugs/ShiftClick; Description: ShiftClickExplorer; Types: Full notr compact eng pic self hen;
	Name: bepinexPlugs/ShortMenu; Description: ShortMenuLoader; Types: Full notr compact eng pic self hen;
	Name: bepinexPlugs/ShortVanilla; Description: ShortMenuVanillaDatabase; Types: Full notr compact eng pic self hen;
	Name: bepinexPlugs/ShortStart; Description: ShortStartLoader; Types: Full notr compact eng pic self hen;

	Name: bepinexPlugs/Translations; Description:{cm:TranslationPlugs}; Types: Full compact pic self hen;
		Name: bepinexPlugs/Translations/i18nEx; Description: i18nEx;  Types: full compact pic self hen;
			Name: bepinexPlugs/Translations/i18nEx/extrans; Description:{cm:ExtraTrans}; Types:full compact self pic hen;
				
		Name: bepinexPlugs/Translations/resredir; Description: Resource Redirector;
			Name: bepinexPlugs/Translations/resredir/xuat; Description: XUnity AutoTranslator; Types: full compact pic self hen;

    Name: bepinexPlugs/TimeDependentPhysics; Description: TimeDependentPhysics; Types: Full notr compact eng pic self hen;
	Name: bepinexPlugs/UndressUtil; Description: UndressUtil; Types: Full notr compact eng pic self hen;
    
Name: Scripts; Description: ScriptLoader Scripts;
    Name: Scripts/oldsubs; Description: Add Subs to Old Yotogi Script;
    Name: Scripts/allprivate; Description: All Maids In Private Mode Script;
    Name: Scripts/charactersortredux; Description: Character Edit Sort Redux Script; Types: Full notr eng self hen;
    Name: Scripts/dumpinfo; Description: DumpGameInfo Script; Types: Full notr compact eng pic self hen;
    Name: Scripts/blinkstop; Description: EditBlinkStop Script; Types: Full notr eng pic self hen;
    Name: Scripts/editname; Description: EditableNames Script; Types: Full notr compact eng pic self hen;
    Name: Scripts/enascout; Description: Enable Scout Mode Script;
    Name: Scripts/eventcharacterlistfix; Description: EventCharacterListFix Script; Types: Full notr compact eng pic self hen;
    Name: Scripts/fastfade; Description: FastFade Script; Types: Full notr eng pic self hen;
    Name: Scripts/freeguest; Description: FreeGuest Script;
    Name: Scripts/forceschedule; Description: ForceScheduleEvents Script; 
    Name: Scripts/invertlearntstat; Description: InvertLearntStat Script;
    Name: Scripts/unlockmemories; Description: MemoriesModeUnlock Script;
    Name: Scripts/morenames; Description: MoreRandomNames Script; Types: Full eng hen;
    Name: Scripts/nameext; Description: NameExtender Script; Types: Full compact eng notr pic self hen;
    Name: Scripts/nomoansubs; Description: NoMoanSubs Script; Types: Full eng notr self hen;
    Name: Scripts/savesettings; Description: SaveSettingsInGame Script; Types: Full compact eng notr pic self hen;
    Name: Scripts/skiplogo; Description: SkipStartLogo Script; Types: Full notr compact eng pic self hen;
    Name: Scripts/loadeditednpcs; Description: LoadEditedNPCs Script; Types: Full eng notr self hen;
    Name: Scripts/thumbs; Description: Load Small Thumbs Script;
    Name: Scripts/quickedit; Description: Quick Edit Scene Script;
    Name: Scripts/quickworkschedule; Description: QuickWorkSchedule Script; Types: Full eng notr self hen;
    Name: Scripts/redupe; Description: Report Dupes Script; Types: Full compact eng notr pic self hen;
    Name: Scripts/unlockskills; Description: Unlock All Skills;
    Name: Scripts/wrapmode; Description: Wrap Mode Extend Script; Types: Full compact eng notr pic self hen;

Name: Patchers; Description: Sybaris Plugins;

	Name: Patchers/autocon; Description: AutoConverter; Types: full compact eng notr pic self hen;
	Name: Patchers/bodycat; Description: BodyCategoryAdd; Types: full compact eng notr pic self hen;
	Name: Patchers/extsave; Description: ExternalSaveData; Types: Full self pic eng notr hen; Flags: checkablealone;
	Name: Patchers/extsave/maidvoice; Description: MaidVoicePitch; Types: full self pic eng notr hen; Flags: checkablealone;
		Name: Patchers/extsave/maidvoice/addmod; Description: AddModsSlider; Types: full self pic eng notr hen; Flags: checkablealone;
			Name: Patchers/extsave/maidvoice/addmod/distort; Description: DistortCorrect; Types:full self pic eng notr hen; Flags: checkablealone;
	Name: Patchers/facetype; Description: FaceType; Types:full compact self pic eng notr hen;
	Name: Patchers/imgui; Description: IMGUITranslationLoader; types: full compact eng pic hen; Flags: checkablealone;
		Name: Patchers/imgui/translations; Description: {cm:IMGUITrans}; Types:full compact eng pic self hen;
	Name: Patchers/neighuncen; Description: NeighUncensor; Types: full compact eng notr pic self hen;
	Name: Patchers/ntrlight; Description: NTRLight; Types:;
	Name: Patchers/rgbpal; Description: RGBPalette;

Name: plugins; Description: Unityinjector Plugins;
	Name: plugins/accex; Description: AlwaysColorChangeEX; Types: full self pic eng notr hen;
	Name: plugins/camerautil; Description: CameraUtility; Types: Full pic self eng notr hen;
	Name: plugins/colorhelp; Description: ColorPaletteHelper; Types:full self pic eng notr hen;
	Name: plugins/conwindow; Description:ConsistentWindowPosition; Types:full self pic eng notr hen;
	Name: plugins/dancecamadjust; Description:DanceCameraAdjust;
	Name: plugins/dressdam; Description:DressDamage; Types:self pic;
	Name: plugins/editmenufilt; Description: EditMenuFilter; Types:full self pic eng notr hen;
	Name: plugins/editselanim; Description: EditMenuSelectedAnime; Types:full self pic eng notr hen;
	Name: plugins/editundo; Description:EditSceneUndo;
	Name: plugins/extendrender; Description:ExtendRenderingRange; Types:full eng notr self pic;
	Name: plugins/extendrender/config; Description:x10 Extend Config; Types:self; Flags:dontinheritcheck
	Name: plugins/halfundress; Description:HalfUnDressing; Types:full eng notr hen; Flags:dontinheritcheck;
	Name: plugins/inout; Description:InOutAnimation; Types:full eng notr self hen;
    Name: plugins/limitBreak; Description:LimitBreak2; Flags:dontinheritcheck
	Name: plugins/lookmaid; Description:LookAtYourMaid; Flags:dontinheritcheck
	Name: plugins/lookmaster; Description:LookAtYourMaster; Flags:dontinheritcheck
	Name: plugins/mirror; Description:Mirror Props; Types:full eng notr;
	Name: plugins/mtacc; Description: MtAccelerator;
		Name: plugins/mtacc/AllScene; Description: AllScene Version;
	Name: plugins/normexcite; Description:NormalizeExcite; Types:full eng notr self hen;
	Name: plugins/notecolor; Description:NoteColor; Types:full self eng notr hen; Flags:dontinheritcheck
	Name: plugins/objexp; Description:ObjectExplorer; Types:full self eng notr pic;
	Name: plugins/partsedit; Description:PartsEdit; Types:full pic self eng notr;
	Name: plugins/personaledit; Description:PersonalizedEditSceneSettings; Types:full pic self eng notr hen;
	Name: plugins/plugmanage; Description:PluginManager; Types:full pic eng notr;
	Name: plugins/rhythmoption; Description: RhythmExtraOption; Types:full eng notr self hen; Flags:dontinheritcheck
	Name: plugins/pngplace; Description:PNGPlacement; Types:full pic self eng notr; Flags: checkablealone;
	Name: plugins/pngplace/expng; Description:{cm:PNGPlaceExtraPNG}; Types:full self pic eng notr; Flags: dontinheritcheck
	Name: plugins/scenecap; Description:SceneCapture; Types:full pic self eng notr; Flags: checkablealone;
	Name: plugins/scenecap/mpmats; Description:Modified Pmats; Flags: dontinheritcheck
	Name: plugins/scenecap/VR; Description:VR Ini File; Flags: dontinheritcheck
	Name: plugins/seieki; Description:Seieki; Types:pic;
	Name: plugins/shaderchange; Description:ShaderChange; Types:full pic self eng notr;
	Name: plugins/SKAcc; Description:SKAccelerator; Types:full pic self eng notr hen;
	Name: plugins/slimeshade; Description:SlimeShader; Types:;
	Name: plugins/TexLoad; Description:TextureLoader; Types:self;
		Name: plugins/TexLoad/PostLoad; Description:PosterLoader; Types:self;
	Name: plugins/toukaScreen; Description:ToukaScreenShot; Types:full pic self eng notr;
	Name: plugins/voicenorm; Description:VoiceNormalizer; Types:full self eng notr hen;
	Name: plugins/xtms; Description:XTMasterSlave+; Types:full eng notr self hen; Flags:dontinheritcheck;
		Name: plugins/xtms/XTFutaBody; Description:XTFutaBody; Flags:dontinheritcheck
		Name: plugins/xtms/XTFutaAccessories; Description:XTFutaAccessories;
	Name: plugins/yotutil; Description:YotogiUtil; Types:full eng notr;

Name: Mods; Description:{cm:MiscFiles};
	Name:Mods/mmposes; Description:{cm:StudioPoses};
    Name:Mods/bgnei; Description:{cm:AddMoreBG}; Types:Full eng notr self pic;
	Name:Mods/uncensor; Description:{cm:Uncensor}; Types:full eng notr compact self pic hen;
	Name:Mods/uncensormale; Description:{cm:UncensorMale}; Types:full eng notr compact self pic hen;
	Name:Mods/extrauncensormale; Description:{cm:ExtraUncensorMale}; Types:full eng notr compact self pic hen;
	Name:Mods/LoMobBody; Description:LoMobChara; Types:full eng notr compact self pic hen;

Name: Tools; Description:Tools;
	Name:Tools/dlccheck; Description:DLC Checker (Kry Fork); Types:Full compact eng notr self pic;
	Name:Tools/sybarc; Description:Sybaris Arc Editor; Types:Full compact eng notr self pic;
    Name:Tools/presetStealer; Description:քʀɛֆɛȶֆȶɛǟʟɛʀ; Types:Full compact eng notr hen self pic custom preset core; flags: fixed; Check: GetRandAbove(100, 19)

[Tasks]

Name:reg; Description:{cm:FixRegistry}; Check: NOT IsEmptyFolder();

Name:clean; Description:{cm:Clean}; GroupDescription:{cm:CleanGroup}; Flags:unchecked
	Name:clean/moveold; Description:{cm:MoveOld}; Flags:checkablealone exclusive
		Name:clean/moveold/mods; Description:{cm:MoveOldMods}; Flags:unchecked dontinheritcheck
		Name:clean/moveold/config; Description:{cm:PlaceConfigBack}; Flags:unchecked dontinheritcheck; Check: NOT IsEmptyFolder();
	Name:clean/deleteold; Description:{cm:DeleteOld}; Flags:unchecked exclusive checkablealone
		Name:clean/deleteold/mods; Description:{cm:DeleteOldMods}; Flags:unchecked dontinheritcheck
		Name:clean/deleteold/old; Description: {cm:DeleteOldInstalls}; Flags:unchecked dontinheritcheck

Name:readonly; Description: {cm:RemoveReadOnly}; GroupDescription:{cm:RemoveReadOnlyGroup}; Check: NOT IsEmptyFolder();

[InstallDelete]

Type:filesandordirs; Name: "{app}\Sybaris"; Tasks:clean/deleteold;
Type:files; Name: "{app}\opengl32.dll"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "{app}\BepinEX"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "{app}\i18nEx"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "{app}\scripts"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "{app}\IMG"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "{app}\ShaderServantPacks"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "{app}\ML_temp"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "{app}\Bepinex_Shim_Backup"; Tasks:clean/deleteold;
Type:files; Name: "{app}\doorstop_config.ini"; Tasks:clean/deleteold;
Type:files; Name: "{app}\winhttp.dll"; Tasks:clean/deleteold;
Type:files; Name: "{app}\version.dll"; Tasks:clean/deleteold;
Type:files; Name: "{app}\EngSybarisArcEditor.exe"; Tasks:clean/deleteold;
Type:files; Name: "{app}\SybarisArcEditor.exe"; Tasks:clean/deleteold;
Type:files; Name: "{app}\COM3D2_DlC_Checker.exe"; Tasks:clean/deleteold;
Type:files; Name: "{app}\COM_NewListDLC.lst"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "{app}\IMGUITranslationLoader"; Tasks:clean/deleteold;
Type:filesandordirs; Name: "{app}\CMI Documentation"; Tasks:clean/deleteold;
Type:files; Name: "{app}\CMI.ver"; Tasks:clean/deleteold;

Type:filesandordirs; Name: "{app}\Mod\Extra Desk Items"; Tasks:clean/deleteold/mods;
Type:filesandordirs; Name: "{app}\Mod\Mirror_props"; Tasks:clean/deleteold/mods;
Type:filesandordirs; Name: "{app}\Mod\PhotMot_NEI"; Tasks:clean/deleteold/mods;
Type:filesandordirs; Name: "{app}\Mod\PhotoBG_NEI"; Tasks:clean/deleteold/mods;
Type:filesandordirs; Name: "{app}\Mod\PhotoBG_OBJ_NEI"; Tasks:clean/deleteold/mods;
Type:filesandordirs; Name: "{app}\Mod\Pose_sample"; Tasks:clean/deleteold/mods;
Type:filesandordirs; Name: "{app}\Mod\[CMI]Uncensors"; Tasks:clean/deleteold/mods;
Type:filesandordirs; Name: "{app}\Mod\[CMI]PosterLoader"; Tasks:clean/deleteold/mods;
Type:filesandordirs; Name: "{app}\Mod\[CMI]XTFutaAccessories"; Tasks:clean/deleteold/mods;
Type:filesandordirs; Name: "{app}\Mod\TextureUncensors"; Tasks:clean/deleteold/mods;
Type:filesandordirs; Name: "{app}\Mod\EmotionalEars"; Tasks:clean/deleteold/mods;
Type:filesandordirs; Name: "{app}\Mod\MultipleMaidsPose"; Tasks:clean/deleteold/mods;
Type:filesandordirs; Name: "{app}\Mod\CinemacicBloom_StreakPmats(SceneCapture)"; Tasks:clean/deleteold/mods;

Type:filesandordirs; Name: "{app}\OldInstall*"; Tasks:clean/deleteold/old;

[UninstallDelete]

Type:filesandordirs; Name: "{app}\Sybaris";
Type:files; Name: "{app}\opengl32.dll";
Type:filesandordirs; Name: "{app}\BepinEX";
Type:filesandordirs; Name: "{app}\i18nEx";
Type:filesandordirs; Name: "{app}\scripts";
Type:filesandordirs; Name: "{app}\IMG";
Type:filesandordirs; Name: "{app}\ShaderServantPacks";
Type:filesandordirs; Name: "{app}\ML_temp";
Type:filesandordirs; Name: "{app}\Bepinex_Shim_Backup";
Type:files; Name: "{app}\doorstop_config.ini";
Type:files; Name: "{app}\winhttp.dll";
Type:files; Name: "{app}\version.dll";
Type:files; Name: "{app}\EngSybarisArcEditor.exe";
Type:files; Name: "{app}\SybarisArcEditor.exe";
Type:files; Name: "{app}\COM3D2_DlC_Checker.exe";
Type:files; Name: "{app}\COM_NewListDLC.lst";
Type:filesandordirs; Name: "{app}\IMGUITranslationLoader";
Type:filesandordirs; Name: "{app}\CMI Documentation";
Type:files; Name: "{app}\CMI.ver";
Type:files; Name: "{app}\Custom.CMIType"

Type:filesandordirs; Name: "{app}\Mod\Extra Desk Items";
Type:filesandordirs; Name: "{app}\Mod\Mirror_props";
Type:filesandordirs; Name: "{app}\Mod\PhotMot_NEI";
Type:filesandordirs; Name: "{app}\Mod\PhotoBG_NEI";
Type:filesandordirs; Name: "{app}\Mod\PhotoBG_OBJ_NEI";
Type:filesandordirs; Name: "{app}\Mod\Pose_sample";
Type:filesandordirs; Name: "{app}\Mod\[CMI]Uncensors";
Type:filesandordirs; Name: "{app}\Mod\[CMI]PosterLoader";
Type:filesandordirs; Name: "{app}\Mod\[CMI]XTFutaAccessories";
Type:filesandordirs; Name: "{app}\Mod\TextureUncensors";
Type:filesandordirs; Name: "{app}\Mod\EmotionalEars";
Type:filesandordirs; Name: "{app}\Mod\MultipleMaidsPose";
Type:filesandordirs; Name: "{app}\Mod\CinemacicBloom_StreakPmats(SceneCapture)";

Type:filesandordirs; Name: "{app}\OldInstall*";

[Run]
;Filename: "https://forms.gle/PrXjqck2dQYMHvyY8"; Flags: shellexec runasoriginaluser postinstall; Description: {cm:Survey}
FileName: "https://discord.gg/custommaid"; Flags: shellexec runasoriginaluser postinstall; Description: Join Custom Maid Discord!
//Honeycome is worse than koi but the joke must go on...
FileName: "https://www.illgames.jp/product/honeycome/"; Flags: shellexec runasoriginaluser postinstall; Description: Get a better game!; Check: GetRandAbove(100, 9)
Filename: "https://krypto5863.github.io/COM-Modular-Installer/"; Flags: shellexec runasoriginaluser postinstall unchecked; Description: {cm:OfficialPage}

[Registry]
Root: HKCU; Subkey: "{#JapRegistry}"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Check: NOT IsEmptyFolder() AND NOT GetIsCR() AND NOT GetIsEngSimple(ExpandConstant('{app}')); Tasks:reg
Root: HKCU; Subkey: "{#EnglishRegistry}"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Check: NOT IsEmptyFolder() AND NOT GetIsCR() AND GetIsEngSimple(ExpandConstant('{app}')); Tasks:reg

//Very large, moved to secondary script to make management easier.
#include "Installer Files\Files.iss"
//Very large, moved to tertiary script to make management easier.
#include "MainCode.iss"