#define bep "{app}\bepinEx"
#define bepp "{app}\bepinEx\plugins"
#define beppa "{app}\bepinEx\patchers"
#define syb "{app}\Sybaris"
#define plug "{app}\Sybaris\UnityInjector"
#define ucfg "{app}\Sybaris\UnityInjector\config"
#define ucfg "{app}\Sybaris\UnityInjector\config"
#define mod "{app}\Mod"

#define ibep 'Installer Files\Components\Loader\BepinEX'
#define iloader 'Installer Files\Components\Loader'
#define isyb "Installer Files\Components\Loader\Sybaris"
#define iPatch "Installer Files\Components\Patchers"
#define iPlugin "Installer Files\Components\Plugins"
#define iMisc "Installer Files\Components\Misc"
#define iDocumentation "Installer Files\Documentation"

#define stdFlags 'ignoreversion recursesubdirs createallsubdirs'

[Files]

;Core
Source: "{#ibep}\Core\*"; DestDir: "{app}"; Flags: {#stdFlags};
Source: "{#IPlugin}\pluginext\*"; DestDir: "{#syb}"; Flags: {#stdFlags}
Source: "{#IPatch}\Mono.Cecil.Inject\*"; DestDir: "{#syb}"; Flags: {#stdFlags}
Source: "{#ibep}\COM3D2.API\*"; DestDir: "{#bepp}";  Flags: {#stdFlags}
Source: "{#ibep}\CM3D2.Toolkit\*"; DestDir: "{#bepp}"; Flags: {#stdFlags}
Source: "{#ibep}\COM3D2.CornerMessage\*"; DestDir: "{#bepp}"; Flags: {#stdFlags}
Source: "{#ibep}\System.Threading\*"; DestDir: "{#bepp}"; Flags: {#stdFlags}
Source: "{#ibep}\CM3D2.Serialization\*"; DestDir: "{#bepp}"; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Core\ScriptLoader.dll"; DestDir: "{#bepp}"; Flags: {#stdFlags}

;ModLoader
Source: "{#IPatch}\ModLoader\Mod\*"; DestDir: "{#mod}"; Components: ModExt; Flags: {#stdFlags}
    Source: "{#IPatch}\ModLoader\Sybaris\*"; DestDir: "{#syb}"; Components: ModExt/modloader; Flags: {#stdFlags}
    Source: "{#ibep}\COM3D2.MaidLoader\*"; DestDir: "{#bepp}"; Components:ModExt/MaidLoader; Flags: {#stdFlags}

;Bepinex
Source: "{#ibep}\COM3D2.AddYotogiSliderSE\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/addyot; Flags: {#stdFlags}
Source: "{#ibep}\COM3D2.AdvancedMaterialModifier\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/AdvMatMod; Flags: {#stdFlags}
Source: "{#ibep}\COM3D2.AutoSave\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/autosave; Flags: {#stdFlags}
Source: "{#ibep}\CamConEx\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/cameracon; Flags: {#stdFlags}
Source: "{#ibep}\COM3D2.ColorPresetNum\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/colorpresetnum; Flags: {#stdFlags}
Source: "{#ibep}\ConfigurationManager\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/ConfigMan; Flags: {#stdFlags}
Source: "{#ibep}\COM3D2.CheatMenu\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/cheatMenu; Flags: {#stdFlags}
Source: "{#ibep}\COM3D2.ChoosyPreset\*"; DestDir: "{app}"; Components:bepinexPlugs/choosypreset; Flags: {#stdFlags}
Source: "{#ibep}\UpCheck\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/UpCheck; Flags: {#stdFlags}
Source: "{#ibep}\COM3D2.EditBodyLoadFix\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/EditBodyLoadFix; Flags: {#stdFlags}
Source: "{#ibep}\COM3D2.ExtendedErrorHandling\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/ExErrorHandle; Flags: {#stdFlags}
Source: "{#ibep}\COM3D2.ExtendedPresetManagement\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/ExPresetMan; Flags: {#stdFlags}
Source: "{#ibep}\FPSUnlock\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/FPSUn; Flags: {#stdFlags}
Source: "{#ibep}\FPSCounter\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/FPSCount; Flags: {#stdFlags}
Source: "{#ibep}\COM3D2.InputHotkeyBlock\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/InBlock; Flags: {#stdFlags}
Source: "{#ibep}\MeidoPhoto\*"; DestDir: "{#bep}"; Components:bepinexPlugs/MeidoPhoto; Flags: {#stdFlags}
    Source: "{#IMisc}\MMPoses\MultipleMaidsPose\*"; DestDir: "{app}\bepinex\config\MeidoPhotoStudio\Presets\Custom Poses\CMI 1900 Poses"; Components:bepinexPlugs/MeidoPhoto/Poses; Flags: {#stdFlags} solidbreak
Source: "{#ibep}\ModRef\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/modref; Flags: {#stdFlags}
Source: "{#ibep}\COM3D2.ShaderServant\*"; DestDir: "{app}"; Components:bepinexPlugs/ShaderServant; Flags: {#stdFlags}
Source: "{#ibep}\COM3D2.ShapekeyMaster\*"; DestDir: "{app}"; Components:bepinexPlugs/ShapekeyMaster; Flags: {#stdFlags}
Source: "{#ibep}\COM3D2.ShiftClickExplorer\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/ShiftClick; Flags: {#stdFlags}
Source: "{#ibep}\COM3D2.ShortMenuLoader\*"; DestDir: "{app}"; Components:bepinexPlugs/ShortMenu; Flags: {#stdFlags}
Source: "{#ibep}\COM3D2.ShortMenuVanillaDatabase\*"; DestDir: "{app}"; Components:bepinexPlugs/ShortVanilla; Flags: {#stdFlags}
Source: "{#ibep}\COM3D2.ShortStartLoader\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/ShortStart; Flags: {#stdFlags}
Source: "{#ibep}\i18nEx\core\*"; DestDir: "{app}"; Components:bepinexPlugs/Translations/i18nEx; Flags: {#stdFlags}
    Source: "{#ibep}\i18nEx\extraTranslations\*"; DestDir: "{app}\i18nEx"; Components:bepinexPlugs/Translations/i18nEx/extrans; Flags: {#stdFlags}
Source: "{#ibep}\ResourceRedirector\*"; DestDir: "{#bep}"; Components:bepinexPlugs/Translations/Resredir; Flags: {#stdFlags}
    Source: "{#ibep}\Xuat\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/Translations/resredir/xuat; Flags: {#stdFlags}
Source: "{#ibep}\COM3D2.TimeDependentPhysics\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/TimeDependentPhysics; Flags: {#stdFlags}
Source: "{#ibep}\COM3D2.UndressUtil\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/UndressUtil; Flags: {#stdFlags}

;Scripts
Source: "{#ibep}\ScriptLoader\Scripts\all_maids_in_private_mode.cs"; DestDir: "{app}\scripts"; Components:scripts/allprivate; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\add_subs_to_old_yotogi.cs"; DestDir: "{app}\scripts"; Components:scripts/oldsubs; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\CharacterEditSortRedux.cs"; DestDir: "{app}\scripts"; Components:scripts/charactersortredux; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\dump_game_info.cs"; DestDir: "{app}\scripts"; Components:scripts/dumpinfo; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\editable_names.cs"; DestDir: "{app}\scripts"; Components:scripts/editname; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\editBlinkStop.cs"; DestDir: "{app}\scripts"; Components:scripts/blinkstop; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\enable_scout_mode.cs"; DestDir: "{app}\scripts"; Components:scripts/enascout; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\EventCharacterListFix.cs"; DestDir: "{app}\scripts"; Components:scripts/EventCharacterListFix; Flags: {#stdFlags}
;Source: "{#ibep}\ScriptLoader\Scripts\fastFade.cs"; DestDir: "{app}\scripts"; Components:scripts/fastfade; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\freeGuest.cs"; DestDir: "{app}\scripts"; Components:scripts/freeguest; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\ForceScheduleEvents.cs"; DestDir: "{app}\scripts"; Components:scripts/ForceSchedule; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\InvertLearntStat.cs"; DestDir: "{app}\scripts"; Components:scripts/InvertLearntStat; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\load_small_thumbs.cs"; DestDir: "{app}\scripts"; Components:scripts/thumbs; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\loadeditedNPCs.cs"; DestDir: "{app}\scripts"; Components:scripts/loadeditednpcs; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\MemoriesModeUnlock.cs"; DestDir: "{app}\scripts"; Components:scripts/unlockmemories; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\MoreRandomNames.cs"; DestDir: "{app}\scripts"; Components:scripts/morenames; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\nameExtender.cs"; DestDir: "{app}\scripts"; Components:scripts/nameext; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\NoMoanSubs.cs"; DestDir: "{app}\scripts"; Components:scripts/NoMoanSubs; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\quick_edit_scene.cs"; DestDir: "{app}\scripts"; Components:scripts/quickedit; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\QuickWorkSchedule.cs"; DestDir: "{app}\scripts"; Components:scripts/quickworkschedule; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\saveSettingsInGame.cs"; DestDir: "{app}\scripts"; Components:scripts/savesettings; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\skipStartLogo.cs"; DestDir: "{app}\scripts"; Components:scripts/skiplogo; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\report_dupes.cs"; DestDir: "{app}\scripts"; Components:scripts/redupe; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\unlock_all_skills.cs"; DestDir: "{app}\scripts"; Components:scripts/unlockskills; Flags: {#stdFlags}
Source: "{#ibep}\ScriptLoader\Scripts\wrap_mode_extend.cs"; DestDir: "{app}\scripts"; Components:scripts/wrapmode; Flags: {#stdFlags}

;Patchers
Source: "{#IPatch}\AutoConverter\*"; DestDir: "{#syb}"; Components: Patchers/autocon; Flags: {#stdFlags}
Source: "{#IPatch}\BodyCategoryAdd\*"; DestDir: "{#syb}"; Components: Patchers/bodycat; Flags: {#stdFlags}
Source: "{#IPatch}\ExternalSave\*"; DestDir: "{#syb}"; Components: Patchers/extsave; Flags: {#stdFlags}
Source: "{#IPlugin}\MaidVoice\*"; DestDir: "{#syb}"; Components: Patchers/extsave/maidvoice; Flags: {#stdFlags}
	Source: "{#IPlugin}\AddMod\*"; DestDir: "{#syb}"; Components: Patchers/extsave/maidvoice/addmod; Flags: {#stdFlags}
		Source: "{#IPlugin}\distortcorrect\*"; DestDir: "{#syb}"; Components: Patchers/extsave/maidvoice/addmod/distort; Flags: {#stdFlags}
Source: "{#IPatch}\FaceType\*"; DestDir: "{#syb}"; Components: Patchers/facetype; Flags: {#stdFlags}
Source: "{#IPatch}\IMGUITranslator\Sybaris\*"; DestDir: "{#syb}"; Components: Patchers/imgui; Flags: {#stdFlags}
	Source: "{#IPatch}\IMGUITranslator\IMGUITranslationLoader\*"; DestDir: "{app}\IMGUITranslationLoader"; Components: Patchers/imgui/translations; Flags: {#stdFlags}
Source: "{#IPatch}\NeighUnce\*"; DestDir: "{#syb}"; Components: Patchers/neighuncen; Flags: {#stdFlags}
Source: "{#IPatch}\ntrlight\*"; DestDir: "{#syb}"; Components: Patchers/ntrlight; Flags: {#stdFlags}
Source: "{#IPatch}\rgbpal\*"; DestDir: "{#syb}"; Components: Patchers/rgbpal; Flags: {#stdFlags}


;Plugins
Source: "{#IPlugin}\ACCex\*"; DestDir: "{#syb}"; Components: plugins/accex; Flags: {#stdFlags}
Source: "{#IPlugin}\camerautil\*"; DestDir: "{#syb}"; Components: plugins/camerautil; Flags: {#stdFlags}
Source: "{#IPlugin}\colorhelp\*"; DestDir: "{#syb}"; Components: plugins/colorhelp; Flags: {#stdFlags}
Source: "{#IPlugin}\conwindow\*"; DestDir: "{#syb}"; Components: plugins/conwindow; Flags: {#stdFlags}
Source: "{#IPlugin}\dancecamadjust\*"; DestDir: "{#syb}"; Components: plugins/dancecamadjust; Flags: {#stdFlags}
Source: "{#IPlugin}\dressdam\*"; DestDir: "{#syb}"; Components: plugins/dressdam; Flags: {#stdFlags}
Source: "{#IPlugin}\editmenufilt\*"; DestDir: "{#syb}"; Components: plugins/editmenufilt; Flags: {#stdFlags}
Source: "{#IPlugin}\editselanime\*"; DestDir: "{#syb}"; Components: plugins/editselanim; Flags: {#stdFlags}
Source: "{#IPlugin}\editundo\*"; DestDir: "{#syb}"; Components: plugins/editundo; Flags: {#stdFlags}
Source: "{#IPlugin}\extendrender\norm\*"; DestDir: "{#syb}"; Components: plugins/extendrender; Flags: {#stdFlags}
	Source: "{#IPlugin}\extendrender\optional\*"; DestDir: "{#ucfg}"; Components: plugins/extendrender/config; Flags: {#stdFlags}
Source: "{#IPlugin}\InOut\*"; DestDir: "{#syb}"; Components: plugins/inout; Flags: {#stdFlags}
Source: "{#IPlugin}\mirrorprops\Sybaris\*"; DestDir: "{#syb}"; Components: plugins/mirror; Flags: {#stdFlags}
	Source: "{#IPlugin}\mirrorprops\Mod\*"; DestDir: "{#mod}"; Components: plugins/mirror; Flags: {#stdFlags}
Source: "{#IPlugin}\MTAcc\Norm\*"; DestDir: "{#syb}"; Components: plugins/mtacc; Flags: {#stdFlags}
Source: "{#IPlugin}\MTAcc\AllScene\*"; DestDir: "{#plug}"; Components: plugins/mtacc/AllScene; Flags: {#stdFlags}
Source: "{#IPlugin}\NormExcite\*"; DestDir: "{#syb}"; Components: plugins/normexcite; Flags: {#stdFlags}
Source: "{#IPlugin}\objexp\*"; DestDir: "{#syb}"; Components: plugins/objexp; Flags: {#stdFlags}
Source: "{#IPlugin}\partsedit\*"; DestDir: "{#syb}"; Components: plugins/partsedit; Flags: {#stdFlags}
Source: "{#IPlugin}\personaledit\*"; DestDir: "{#syb}"; Components: plugins/personaledit; Flags: {#stdFlags}
Source: "{#IPlugin}\plugmanage\*"; DestDir: "{#syb}"; Components: plugins/plugmanage; Flags: {#stdFlags}

Source: "{#IPlugin}\halfundress\*"; DestDir: "{#syb}"; Components: plugins/halfundress; Flags: {#stdFlags}
Source: "{#IPlugin}\limitBreak\*"; DestDir: "{#syb}"; Components: plugins/limitBreak; Flags: {#stdFlags}
Source: "{#IPlugin}\lookmaid\*"; DestDir: "{#syb}"; Components: plugins/lookmaid; Flags: {#stdFlags}
Source: "{#IPlugin}\lookmaster\*"; DestDir: "{#syb}"; Components: plugins/lookmaster; Flags: {#stdFlags}
Source: "{#IPlugin}\notecolor\*"; DestDir: "{#syb}"; Components: plugins/notecolor; Flags: {#stdFlags}
Source: "{#IPlugin}\rythmoption\*"; DestDir: "{#syb}"; Components: plugins/rhythmoption; Flags: {#stdFlags}
Source: "{#IPlugin}\xtms\Core\*"; DestDir: "{#syb}"; Components: plugins/xtms; Flags: {#stdFlags}
	Source: "{#IPlugin}\xtms\XTFuta\*"; DestDir: "{#mod}\[CMI]Uncensors"; Components: plugins/xtms/XTFutaBody; Flags: {#stdFlags}
		Source: "{#IPlugin}\xtms\XTFutaAccessories\*"; DestDir: "{#mod}\[CMI]XTFutaAccessories"; Components: plugins/xtms/XTFutaAccessories; Flags: {#stdFlags}
			
Source: "{#IPlugin}\pngplace\core\*"; DestDir: "{#plug}"; Components: plugins/pngplace; Flags: {#stdFlags}
	Source: "{#IPlugin}\PngPlace\ExtraPNGs\*"; DestDir: "{#ucfg}"; Components: plugins/pngplace/expng; Flags: {#stdFlags}
Source: "{#IPlugin}\scenecap\Norm\*"; DestDir: "{#syb}"; Components: plugins/scenecap; Flags: {#stdFlags}
	Source: "{#IPlugin}\scenecap\Modpmats\*"; DestDir: "{#mod}"; Components: plugins/scenecap/mpmats; Flags: {#stdFlags}
	Source: "{#IPlugin}\scenecap\VR\*"; DestDir: "{#syb}"; Components: plugins/scenecap/VR; Flags: {#stdFlags}
Source: "{#IPlugin}\seieki\*"; DestDir: "{#syb}"; Components: plugins/seieki; Flags: {#stdFlags}
Source: "{#IPlugin}\shaderchange\*"; DestDir: "{#syb}"; Components: plugins/shaderchange; Flags: {#stdFlags}
Source: "{#IPlugin}\SKAcc\*"; DestDir: "{#syb}"; Components: plugins/SKAcc; Flags: {#stdFlags}
Source: "{#IPlugin}\slimeshade\*"; DestDir: "{#syb}"; Components: plugins/slimeshade; Flags: {#stdFlags}
Source: "{#IPlugin}\texload\core\*"; DestDir: "{#plug}"; Components: plugins/texload; Flags: {#stdFlags}
	Source: "{#IPlugin}\texload\postload\*"; DestDir: "{app}"; Components: plugins/texload/postload; Flags: {#stdFlags}
Source: "{#IPlugin}\toukascreen\*"; DestDir: "{#syb}"; Components: plugins/toukascreen; Flags: {#stdFlags}
Source: "{#IPlugin}\voicenormalizer\*"; DestDir: "{#syb}"; Components: plugins/voicenorm; Flags: {#stdFlags}
Source: "{#IPlugin}\yotutil\*"; DestDir: "{#syb}"; Components: plugins/yotutil; Flags: {#stdFlags}

;;Tools
Source: "{#iMisc}\COM3D2_DLC_Checker\*"; DestDir: "{app}"; Components: tools/dlccheck; Flags: recursesubdirs createallsubdirs solidbreak
Source: "{#IMisc}\SybArc\*"; DestDir: "{app}"; Components: tools/sybarc; Flags: recursesubdirs

;Mods
Source: "{#IMisc}\MMPoses\MultipleMaidsPose\*"; DestDir: "{app}\PhotoModeData\MyPose"; Components: mods/mmposes; Flags: {#stdFlags} solidbreak
Source: "{#IMisc}\MoreBGsNei\*"; DestDir: "{#mod}\PhotoBG_NEI"; Components: mods/bgnei; Flags: {#stdFlags} solidbreak
Source: "{#IMisc}\TextureUncensors\FemaleSkinUncensor\*"; DestDir: "{#mod}\[CMI]Uncensors\FemaleSkinUncensor"; Components: mods/uncensor; Flags: {#stdFlags} solidbreak
Source: "{#IMisc}\TextureUncensors\MaleReplacer\*"; DestDir: "{#mod}\[CMI]Uncensors\MaleUncensor\"; Components: mods/uncensormale; Flags: {#stdFlags} solidbreak
Source: "{#IMisc}\TextureUncensors\DLCMaleReplacer\*"; DestDir: "{#mod}\[CMI]Uncensors\MaleUncensor\"; Components: mods/uncensormale; Flags: {#stdFlags} solidbreak; Check:FileExists(ExpandConstant('{app}\GameData\parts_dlc219.arc'))
Source: "{#IMisc}\TextureUncensors\MoreMaleUncensor\*"; DestDir: "{#mod}\[CMI]Uncensors\MaleUncensor\"; Components: mods/extrauncensormale; Flags: {#stdFlags} solidbreak
Source: "{#IMisc}\TextureUncensors\DLCMoreMaleUncensor\*"; DestDir: "{#mod}\[CMI]Uncensors\MaleUncensor\"; Components: mods/extrauncensormale; Flags: {#stdFlags} solidbreak; Check:FileExists(ExpandConstant('{app}\GameData\parts_dlc219.arc'))
Source: "{#IMisc}\TextureUncensors\lomob\*"; DestDir: "{#mod}\[CMI]Uncensors\LoMobBody"; Components: mods/LoMobBody; Flags: {#stdFlags}
Source: "{#IMisc}\TextureUncensors\lomob\LOmobchara_extra_v1_beta\model\underhair.model"; DestDir: "{#mod}\[CMI]Uncensors\LoMobBody\LOmobchara_extra_v1_beta\model"; DestName: "underhair_en.model"; Components: mods/LoMobBody; Flags: {#stdFlags}; Check: GetIsEngSimple(ExpandConstant('{app}'));

//Unrelated to files.
Source: "{#IDocumentation}\CMI_Readme.pdf"; DestDir: "{app}\CMI Documentation"; Flags: isreadme nocompression
Source: "{#IDocumentation}\CMI_Readme_Chinese.pdf"; DestDir: "{app}\CMI Documentation"; Flags: isreadme nocompression; Languages: chinesesimplified
Source: "{#IDocumentation}\MPS_readme.html"; DestDir: "{app}\CMI Documentation"; Components:bepinexPlugs/meidophoto; Flags: isreadme
Source: "{#IDocumentation}\PosterLoader_Readme.txt"; DestDir: "{app}\CMI Documentation"; Components:plugins/texload/postload; Flags: isreadme

[/Files]

#include "Installer Files\CRFiles.iss"