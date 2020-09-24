#define bep "{app}\bepinEx"
#define bepp "{{#bep}}\plugins"
#define syb "{app}\Sybaris"
#define plug "{{#syb}}\UnityInjector"
#define ucfg "{{#plug}}\config"
#define ibep "Loader\BepinEX"
#define isyb "Loader\Sybaris"
#define mod "{app}\Mod"

[Files]

//Loader Section
Source: "{#ibep}\Core\*"; DestDir: "{app}"; Components: Loader/bepinEX; Flags: ignoreversion recursesubdirs createallsubdirs
	Source: "{#ibep}\i18nEx\*"; DestDir: "{app}"; Components: Loader/bepinEX/Translations/i18nEx; Flags: ignoreversion recursesubdirs createallsubdirs
	Source: "{#ibep}\ResourceRedirector\*"; DestDir: "{#bep}"; Components: Loader/bepinEX/Translations/Resredir; Flags: ignoreversion recursesubdirs createallsubdirs
		Source: "{#ibep}\Xuat\*"; DestDir: "{#bepp}"; Components: Loader/bepinEX/Translations/resredir/xuat; Flags: ignoreversion recursesubdirs createallsubdirs
	Source: "{#ibep}\FPSUnlock\*"; DestDir: "{#bepp}"; Components: Loader/bepinEX/FPSUn; Flags: ignoreversion recursesubdirs recursesubdirs createallsubdirs
	Source: "{#ibep}\ScriptLoader\ScriptLoader.dll"; DestDir: "{#bepp}"; Components: Loader/bepinEX/scriptloader; Flags: ignoreversion recursesubdirs createallsubdirs
		Source: "{#ibep}\ScriptLoader\Scripts\add_subs_to_old_yotogi.cs"; DestDir: "{app}\scripts"; Components: Loader/bepinEX/scriptloader/oldsubs; Flags: ignoreversion recursesubdirs createallsubdirs
		Source: "{#ibep}\ScriptLoader\Scripts\dump_game_info.cs"; DestDir: "{app}\scripts"; Components: Loader/bepinEX/scriptloader/dumpinfo; Flags: ignoreversion recursesubdirs createallsubdirs
		Source: "{#ibep}\ScriptLoader\Scripts\editable_names.cs"; DestDir: "{app}\scripts"; Components: Loader/bepinEX/scriptloader/editname; Flags: ignoreversion recursesubdirs createallsubdirs
		Source: "{#ibep}\ScriptLoader\Scripts\enable_scout_mode.cs"; DestDir: "{app}\scripts"; Components: Loader/bepinEX/scriptloader/enascout; Flags: ignoreversion recursesubdirs createallsubdirs
		Source: "{#ibep}\ScriptLoader\Scripts\error_texture_placeholder.cs"; DestDir: "{app}\scripts"; Components: Loader/bepinEX/scriptloader/errtex; Flags: ignoreversion recursesubdirs createallsubdirs
		Source: "{#ibep}\ScriptLoader\Scripts\load_small_thumbs.cs"; DestDir: "{app}\scripts"; Components: Loader/bepinEX/scriptloader/thumbs; Flags: ignoreversion recursesubdirs createallsubdirs
		Source: "{#ibep}\ScriptLoader\Scripts\quick_edit_scene.cs"; DestDir: "{app}\scripts"; Components: Loader/bepinEX/scriptloader/quickedit; Flags: ignoreversion recursesubdirs createallsubdirs
		Source: "{#ibep}\ScriptLoader\Scripts\report_dupes.cs"; DestDir: "{app}\scripts"; Components: Loader/bepinEX/scriptloader/redupe; Flags: ignoreversion recursesubdirs createallsubdirs
		Source: "{#ibep}\ScriptLoader\Scripts\wrap_mode_extend.cs"; DestDir: "{app}\scripts"; Components: Loader/bepinEX/scriptloader/wrapmode; Flags: ignoreversion recursesubdirs createallsubdirs



Source: "{#isyb}\Core\*"; DestDir: "{app}"; Components: Loader/Sybaris; Flags: ignoreversion recursesubdirs createallsubdirs
	Source: "{#isyb}\i18nEx\*"; DestDir: "{app}"; Components: Loader/Sybaris/Translations/i18nEx; Flags: ignoreversion recursesubdirs createallsubdirs
	Source: "{#isyb}\Xuat\*"; DestDir: "{#plug}"; Components: Loader/Sybaris/Translations/xuat; Flags: ignoreversion recursesubdirs createallsubdirs

;Patchers
Source: "Patchers\addscreen\*"; DestDir: "{#syb}"; Components: Patchers/addscreen; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Patchers\allprivate\*"; DestDir: "{#syb}"; Components: Patchers/allprivate; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Patchers\AutoConverter\*"; DestDir: "{#syb}"; Components: Patchers/autocon; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Patchers\BodyCategoryAdd\*"; DestDir: "{#syb}"; Components: Patchers/bodycat; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Patchers\CacheEdit\*"; DestDir: "{#syb}"; Components: Patchers/cacheedit; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Patchers\ccfix\*"; DestDir: "{#syb}"; Components: Patchers/ccfix; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Patchers\blinkstop\*"; DestDir: "{#syb}"; Components: Patchers/blinkstop; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Patchers\ExternalSave\*"; DestDir: "{#syb}"; Components: Patchers/extsave; Flags: ignoreversion recursesubdirs createallsubdirs
  Source: "Plugins\MaidVoice\*"; DestDir: "{#syb}"; Components: Patchers/extsave/maidvoice; Flags: ignoreversion recursesubdirs createallsubdirs
    Source: "Plugins\AddMod\*"; DestDir: "{#syb}"; Components: Patchers/extsave/maidvoice/addmod; Flags: ignoreversion recursesubdirs createallsubdirs
      Source: "Plugins\Lashalpha\*"; DestDir: "{#syb}"; Components: Patchers/extsave/maidvoice/addmod/eyelashesalpha; Flags: ignoreversion recursesubdirs
      Source: "Plugins\Seperateeye\*"; DestDir: "{#syb}"; Components: Patchers/extsave/maidvoice/addmod/seperateeye; Flags: ignoreversion recursesubdirs
      Source: "Plugins\distortcorrect\*"; DestDir: "{#syb}"; Components: Patchers/extsave/maidvoice/addmod/distort; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Patchers\FaceType\*"; DestDir: "{#syb}"; Components: Patchers/facetype; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Patchers\FastFade\*"; DestDir: "{#syb}"; Components: Patchers/fastfade; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Patchers\IMGUITranslator\Sybaris\*"; DestDir: "{#syb}"; Components: Patchers/imgui; Flags: ignoreversion recursesubdirs createallsubdirs
	Source: "Patchers\IMGUITranslator\IMGUITranslationLoader\*"; DestDir: "{app}\IMGUITranslationLoader"; Components: Patchers/imgui/translations; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Patchers\ModLoader\Sybaris\*"; DestDir: "{#syb}"; Components: Patchers/modloader; Flags: ignoreversion recursesubdirs createallsubdirs
  Source: "Patchers\ModLoader\Mod\*"; DestDir: "{#mod}"; Components: Patchers/modloader; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Patchers\NameExt\*"; DestDir: "{#syb}"; Components: Patchers/namext; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Patchers\NeighUnce\*"; DestDir: "{#syb}"; Components: Patchers/neighuncen; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Patchers\ntrlight\*"; DestDir: "{#syb}"; Components: Patchers/ntrlight; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Patchers\QuickEdit\*"; DestDir: "{#syb}"; Components: Patchers/QuickEdit; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Patchers\rgbpal\*"; DestDir: "{#syb}"; Components: Patchers/rgbpal; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Patchers\saveset\*"; DestDir: "{#syb}"; Components: Patchers/saveset; Flags: ignoreversion recursesubdirs createallsubdirs


;Plugins
Source: "Plugins\boneslide\*"; DestDir: "{#syb}"; Components: plugins/boneslide; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\addyot\*"; DestDir: "{#syb}"; Components: plugins/addyot; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\ACCex\*"; DestDir: "{#syb}"; Components: plugins/accex; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\eraseout\*"; DestDir: "{#syb}"; Components: plugins/eraseout; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\cameracon\*"; DestDir: "{#syb}"; Components: plugins/cameracon; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\camerautil\*"; DestDir: "{#syb}"; Components: plugins/camerautil; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\hudclock\*"; DestDir: "{#plug}"; Components: plugins/hudclock; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\colorhelp\*"; DestDir: "{#syb}"; Components: plugins/colorhelp; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\conwindow\*"; DestDir: "{#syb}"; Components: plugins/conwindow; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\nyou\*"; DestDir: "{#syb}"; Components: plugins/nyou; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\dancecamadjust\*"; DestDir: "{#syb}"; Components: plugins/dancecamadjust; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\derim\*"; DestDir: "{#syb}"; Components: plugins/derim; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\dressdam\*"; DestDir: "{#syb}"; Components: plugins/dressdam; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\editmenufilt\*"; DestDir: "{#syb}"; Components: plugins/editmenufilt; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\editselanime\*"; DestDir: "{#syb}"; Components: plugins/editselanim; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\editundo\*"; DestDir: "{#syb}"; Components: plugins/editundo; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\emoears\norm\COM3D2.EmotionalEars.Plugin.dll"; DestDir: "{#plug}"; Components: plugins/emoears; Flags: ignoreversion
	Source: "Plugins\emoears\aho\Mod\*"; DestDir: "{#mod}\EmotionalEars"; Components: plugins/emoears/aho; Flags: ignoreversion recursesubdirs createallsubdirs
	Source: "Plugins\emoears\norm\Mod\*"; DestDir: "{#mod}\EmotionalEars"; Components: plugins/emoears/mod; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\extendrender\norm\*"; DestDir: "{#syb}"; Components: plugins/extendrender; Flags: ignoreversion recursesubdirs createallsubdirs
  Source: "Plugins\extendrender\optional\*"; DestDir: "{#ucfg}"; Components: plugins/extendrender/config; Flags: ignoreversion recursesubdirs createallsubdirs
;Source: "Plugins\futa\*"; DestDir: "{#syb}"; Components: plugins/futa; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\facecon\*"; DestDir: "{#syb}"; Components: plugins/facecon; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\freeapp\*"; DestDir: "{#syb}"; Components: plugins/freeapp; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\freedress\*"; DestDir: "{#syb}"; Components: plugins/freedress; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\halfundress\*"; DestDir: "{#syb}"; Components: plugins/halfundress; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\InOut\*"; DestDir: "{#syb}"; Components: plugins/inout; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\lookmaid\*"; DestDir: "{#syb}"; Components: plugins/lookmaid; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\lookmaster\*"; DestDir: "{#syb}"; Components: plugins/lookmaster; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\mirrorprops\Sybaris\*"; DestDir: "{#syb}"; Components: plugins/mirror; Flags: ignoreversion recursesubdirs createallsubdirs
  Source: "Plugins\mirrorprops\Mod\*"; DestDir: "{#mod}"; Components: plugins/mirror; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\MTAcc\Norm\*"; DestDir: "{#syb}"; Components: plugins/mtacc; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\MTAcc\AllScene\*"; DestDir: "{#plug}"; Components: plugins/mtacc/AllScene; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\MM\*"; DestDir: "{#syb}"; Components: plugins/MM; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\NormExcite\*"; DestDir: "{#syb}"; Components: plugins/normexcite; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\notecolor\*"; DestDir: "{#syb}"; Components: plugins/notecolor; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\objexp\*"; DestDir: "{#syb}"; Components: plugins/objexp; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\partsedit\*"; DestDir: "{#syb}"; Components: plugins/partsedit; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\personaledit\*"; DestDir: "{#syb}"; Components: plugins/personaledit; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\plugmanage\*"; DestDir: "{#syb}"; Components: plugins/plugmanage; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\pluginext\*"; DestDir: "{#syb}"; Components: plugins/pluginext; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\pngplace\core\*"; DestDir: "{#plug}"; Components: plugins/pngplace; Flags: ignoreversion recursesubdirs createallsubdirs
	Source: "Plugins\PngPlace\ExtraPNGs\*"; DestDir: "{#ucfg}"; Components: plugins/pngplace/expng; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\propitem\*"; DestDir: "{#syb}"; Components: plugins/propitem; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\rythmoption\*"; DestDir: "{#syb}"; Components: plugins/rhythmoption; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\scenecap\Norm\*"; DestDir: "{#syb}"; Components: plugins/scenecap; Flags: ignoreversion recursesubdirs createallsubdirs 
  Source: "Plugins\scenecap\Modpmats\*"; DestDir: "{#mod}"; Components: plugins/scenecap/mpmats; Flags: ignoreversion recursesubdirs createallsubdirs
	Source: "Plugins\scenecap\VR\*"; DestDir: "{#syb}"; Components: plugins/scenecap/VR; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\seieki\*"; DestDir: "{#syb}"; Components: plugins/seieki; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\shaderchange\*"; DestDir: "{#syb}"; Components: plugins/shaderchange; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\shapeanim\*"; DestDir: "{#syb}"; Components: plugins/shapeanimator/norm; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\shapeanimdoc\*"; DestDir: "{#syb}"; Components: plugins/shapeanimator/doc; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\SKAcc\*"; DestDir: "{#syb}"; Components: plugins/SKAcc; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\skillcomshort\*"; DestDir: "{#syb}"; Components: plugins/skillcomshort; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\slimeshade\*"; DestDir: "{#syb}"; Components: plugins/slimeshade; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\smoothanim\*"; DestDir: "{#syb}"; Components: plugins/smoothanim; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\toukascreen\*"; DestDir: "{#syb}"; Components: plugins/toukascreen; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\ureye\*"; DestDir: "{#syb}"; Components: plugins/ureye; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\vibemaid\*"; DestDir: "{#syb}"; Components: plugins/vibemaid; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\voicenormalizer\*"; DestDir: "{#syb}"; Components: plugins/voicenorm; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\xtms\*"; DestDir: "{#syb}"; Components: plugins/xtms; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Plugins\yotutil\*"; DestDir: "{#syb}"; Components: plugins/yotutil; Flags: ignoreversion recursesubdirs createallsubdirs

;Misc Files

//The files here are fetched dynamically as needed from the internet.
Source: "{tmp}\COM3D2 DlC Checker.exe"; DestDir: "{app}"; Components: misc/dlccheck; Flags: external
Source: "{tmp}\FemaleSkinUncensor\*"; DestDir: "{#mod}\[CMI]Uncensors\FemaleSkinUncensor"; Components: misc/uncensor; Flags: external ignoreversion recursesubdirs createallsubdirs
//These Files are fetched locally.
Source: "Misc\extratranslations\*"; DestDir: "{app}"; Components: misc/extrans; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Misc\SybArc\*"; DestDir: "{app}"; Components: misc/sybarc; Flags: recursesubdirs
Source: "Misc\MMPoses\*"; DestDir: "{#mod}"; Components: plugins/mm/mmposes; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Misc\MMPoses\MultipleMaidsPose\*"; DestDir: "{app}\PhotoModeData\MyPose"; Components: misc/mmposes; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Misc\MoreBGsNei\*"; DestDir: "{#mod}\PhotoBG_NEI"; Components: misc/bgnei; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Misc\TextureUncensors\MaleReplacer\*"; DestDir: "{#mod}\[CMI]Uncensors\MaleUncensor\"; Components: misc/uncensormale; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Misc\TextureUncensors\DLCMaleReplacer\*"; DestDir: "{#mod}\[CMI]Uncensors\MaleUncensor\"; Components: misc/uncensormale; Flags: ignoreversion recursesubdirs createallsubdirs; Check:FileExists(ExpandConstant('{app}\GameData\parts_dlc219.arc'))
Source: "Misc\TextureUncensors\MoreMaleUncensor\*"; DestDir: "{#mod}\[CMI]Uncensors\MaleUncensor\"; Components: misc/extrauncensormale; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Misc\TextureUncensors\DLCMoreMaleUncensor\*"; DestDir: "{#mod}\[CMI]Uncensors\MaleUncensor\"; Components: misc/extrauncensormale; Flags: ignoreversion recursesubdirs createallsubdirs; Check:FileExists(ExpandConstant('{app}\GameData\parts_dlc219.arc'))
Source: "Misc\TextureUncensors\body_analkupa\*"; DestDir: "{#mod}\[CMI]Uncensors\body_analkupa"; Components: misc/body/analkupa; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "Misc\TextureUncensors\lomob\*"; DestDir: "{#mod}\[CMI]Uncensors\LoMobBody"; Components: misc/body/LoMobBody; Flags: ignoreversion recursesubdirs createallsubdirs

//Unrelated to files.
Source: "Documentation\CMI_Readme.pdf"; DestDir: "{app}\CMI Documentation"; Flags: isreadme
Source: "Documentation\MM_Readme.txt"; DestDir: "{app}\CMI Documentation"; Components:plugins/MM; Flags: isreadme
Source: "Documentation\DeRim_Readme.txt"; DestDir: "{app}\CMI Documentation"; Components:plugins/derim; Flags: isreadme

[/Files]