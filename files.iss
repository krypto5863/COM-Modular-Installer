#define bep "{app}\bepinEx"
#define bepp "{app}\bepinEx\plugins"
#define syb "{app}\Sybaris"
#define plug "{app}\Sybaris\UnityInjector"
#define ucfg "{app}\Sybaris\UnityInjector\config"
#define ibep "Loader\BepinEX"
#define isyb "Loader\Sybaris"
#define iPatch "Patchers"
#define iPlugin "Plugins"
#define iMisc "Misc"
#define mod "{app}\Mod"

[Files]

//Loader Section
Source: "{#ibep}\Core\*"; DestDir: "{app}"; Components: Loader/bepinEX; Flags: ignoreversion recursesubdirs createallsubdirs

	Source: "{#ibep}\UpCheck\*"; DestDir: "{#bepp}"; Components: Loader/bepinEX/UpCheck; Flags: ignoreversion recursesubdirs recursesubdirs createallsubdirs

	Source: "{#ibep}\FPSUnlock\*"; DestDir: "{#bepp}"; Components: Loader/bepinEX/FPSUn; Flags: ignoreversion recursesubdirs recursesubdirs createallsubdirs
	 
	Source: "{#ibep}\ScriptLoader\Core\ScriptLoader.dll"; DestDir: "{#bepp}"; Components: Loader/bepinEX/scriptloader; Flags: ignoreversion recursesubdirs createallsubdirs 
		Source: "{#ibep}\ScriptLoader\Scripts\add_subs_to_old_yotogi.cs"; DestDir: "{app}\scripts"; Components: Loader/bepinEX/scriptloader/oldsubs; Flags: ignoreversion recursesubdirs createallsubdirs 
		Source: "{#ibep}\ScriptLoader\Scripts\dump_game_info.cs"; DestDir: "{app}\scripts"; Components: Loader/bepinEX/scriptloader/dumpinfo; Flags: ignoreversion recursesubdirs createallsubdirs 
		Source: "{#ibep}\ScriptLoader\Scripts\editable_names.cs"; DestDir: "{app}\scripts"; Components: Loader/bepinEX/scriptloader/editname; Flags: ignoreversion recursesubdirs createallsubdirs 
		Source: "{#ibep}\ScriptLoader\Scripts\enable_scout_mode.cs"; DestDir: "{app}\scripts"; Components: Loader/bepinEX/scriptloader/enascout; Flags: ignoreversion recursesubdirs createallsubdirs 
		Source: "{#ibep}\ScriptLoader\Scripts\error_texture_placeholder.cs"; DestDir: "{app}\scripts"; Components: Loader/bepinEX/scriptloader/errtex; Flags: ignoreversion recursesubdirs createallsubdirs 
		Source: "{#ibep}\ScriptLoader\Scripts\load_small_thumbs.cs"; DestDir: "{app}\scripts"; Components: Loader/bepinEX/scriptloader/thumbs; Flags: ignoreversion recursesubdirs createallsubdirs 
		Source: "{#ibep}\ScriptLoader\Scripts\quick_edit_scene.cs"; DestDir: "{app}\scripts"; Components: Loader/bepinEX/scriptloader/quickedit; Flags: ignoreversion recursesubdirs createallsubdirs 
		Source: "{#ibep}\ScriptLoader\Scripts\report_dupes.cs"; DestDir: "{app}\scripts"; Components: Loader/bepinEX/scriptloader/redupe; Flags: ignoreversion recursesubdirs createallsubdirs 
		Source: "{#ibep}\ScriptLoader\Scripts\wrap_mode_extend.cs"; DestDir: "{app}\scripts"; Components: Loader/bepinEX/scriptloader/wrapmode; Flags: ignoreversion recursesubdirs createallsubdirs 

	Source: "{#ibep}\i18nEx\core\*"; DestDir: "{app}"; Components: Loader/bepinEX/Translations/i18nEx; Flags: ignoreversion recursesubdirs createallsubdirs
		Source: "Loader\extratranslations\*"; DestDir: "{app}"; Components: Loader/bepinEX/Translations/i18nEx/extrans; Flags: ignoreversion recursesubdirs createallsubdirs 
	Source: "{#ibep}\ResourceRedirector\*"; DestDir: "{#bep}"; Components: Loader/bepinEX/Translations/Resredir; Flags: ignoreversion recursesubdirs createallsubdirs
		Source: "{#ibep}\Xuat\*"; DestDir: "{#bepp}"; Components: Loader/bepinEX/Translations/resredir/xuat; Flags: ignoreversion recursesubdirs createallsubdirs 



Source: "{#isyb}\Core\*"; DestDir: "{app}"; Components: Loader/Sybaris; Flags: ignoreversion recursesubdirs createallsubdirs 
	Source: "{#isyb}\i18nEx\*"; DestDir: "{app}"; Components: Loader/Sybaris/Translations/i18nEx; Flags: ignoreversion recursesubdirs createallsubdirs
		Source: "Loader\extratranslations\*"; DestDir: "{app}"; Components: Loader/Sybaris/Translations/i18nEx/extrans; Flags: ignoreversion recursesubdirs createallsubdirs 
	Source: "{#isyb}\Xuat\*"; DestDir: "{#plug}"; Components: Loader/Sybaris/Translations/xuat; Flags: ignoreversion recursesubdirs createallsubdirs 

;Patchers
Source: "{#IPatch}\addscreen\*"; DestDir: "{#syb}"; Components: Patchers/addscreen; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPatch}\allprivate\*"; DestDir: "{#syb}"; Components: Patchers/allprivate; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPatch}\AutoConverter\*"; DestDir: "{#syb}"; Components: Patchers/autocon; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPatch}\BodyCategoryAdd\*"; DestDir: "{#syb}"; Components: Patchers/bodycat; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPatch}\CacheEdit\*"; DestDir: "{#syb}"; Components: Patchers/cacheedit; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPatch}\ccfix\*"; DestDir: "{#syb}"; Components: Patchers/ccfix; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPatch}\blinkstop\*"; DestDir: "{#syb}"; Components: Patchers/blinkstop; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPatch}\ExternalSave\*"; DestDir: "{#syb}"; Components: Patchers/extsave; Flags: ignoreversion recursesubdirs createallsubdirs 
  Source: "{#IPlugin}\MaidVoice\*"; DestDir: "{#syb}"; Components: Patchers/extsave/maidvoice; Flags: ignoreversion recursesubdirs createallsubdirs 
    Source: "{#IPlugin}\AddMod\*"; DestDir: "{#syb}"; Components: Patchers/extsave/maidvoice/addmod; Flags: ignoreversion recursesubdirs createallsubdirs 
      Source: "{#IPlugin}\Lashalpha\*"; DestDir: "{#syb}"; Components: Patchers/extsave/maidvoice/addmod/eyelashesalpha; Flags: ignoreversion recursesubdirs 
      Source: "{#IPlugin}\Seperateeye\*"; DestDir: "{#syb}"; Components: Patchers/extsave/maidvoice/addmod/seperateeye; Flags: ignoreversion recursesubdirs 
      Source: "{#IPlugin}\distortcorrect\*"; DestDir: "{#syb}"; Components: Patchers/extsave/maidvoice/addmod/distort; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPatch}\FaceType\*"; DestDir: "{#syb}"; Components: Patchers/facetype; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPatch}\FastFade\*"; DestDir: "{#syb}"; Components: Patchers/fastfade; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPatch}\IMGUITranslator\Sybaris\*"; DestDir: "{#syb}"; Components: Patchers/imgui; Flags: ignoreversion recursesubdirs createallsubdirs 
	Source: "{#IPatch}\IMGUITranslator\IMGUITranslationLoader\*"; DestDir: "{app}\IMGUITranslationLoader"; Components: Patchers/imgui/translations; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPatch}\ModLoader\Sybaris\*"; DestDir: "{#syb}"; Components: Patchers/modloader; Flags: ignoreversion recursesubdirs createallsubdirs 
  Source: "{#IPatch}\ModLoader\Mod\*"; DestDir: "{#mod}"; Components: Patchers/modloader; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPatch}\NameExt\*"; DestDir: "{#syb}"; Components: Patchers/namext; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPatch}\NeighUnce\*"; DestDir: "{#syb}"; Components: Patchers/neighuncen; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPatch}\ntrlight\*"; DestDir: "{#syb}"; Components: Patchers/ntrlight; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPatch}\QuickEdit\*"; DestDir: "{#syb}"; Components: Patchers/QuickEdit; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPatch}\rgbpal\*"; DestDir: "{#syb}"; Components: Patchers/rgbpal; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPatch}\saveset\*"; DestDir: "{#syb}"; Components: Patchers/saveset; Flags: ignoreversion recursesubdirs createallsubdirs 


;Plugins
Source: "{#IPlugin}\boneslide\*"; DestDir: "{#syb}"; Components: plugins/boneslide; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\addyot\*"; DestDir: "{#syb}"; Components: plugins/addyot; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\ACCex\*"; DestDir: "{#syb}"; Components: plugins/accex; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\eraseout\*"; DestDir: "{#syb}"; Components: plugins/eraseout; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\cameracon\*"; DestDir: "{#syb}"; Components: plugins/cameracon; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\camerautil\*"; DestDir: "{#syb}"; Components: plugins/camerautil; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\hudclock\*"; DestDir: "{#plug}"; Components: plugins/hudclock; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\colorhelp\*"; DestDir: "{#syb}"; Components: plugins/colorhelp; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\conwindow\*"; DestDir: "{#syb}"; Components: plugins/conwindow; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\nyou\*"; DestDir: "{#syb}"; Components: plugins/nyou; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\dancecamadjust\*"; DestDir: "{#syb}"; Components: plugins/dancecamadjust; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\derim\*"; DestDir: "{#syb}"; Components: plugins/derim; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\dressdam\*"; DestDir: "{#syb}"; Components: plugins/dressdam; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\editmenufilt\*"; DestDir: "{#syb}"; Components: plugins/editmenufilt; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\editselanime\*"; DestDir: "{#syb}"; Components: plugins/editselanim; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\editundo\*"; DestDir: "{#syb}"; Components: plugins/editundo; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\emoears\norm\COM3D2.EmotionalEars.Plugin.dll"; DestDir: "{#plug}"; Components: plugins/emoears; Flags: ignoreversion 
	Source: "{#IPlugin}\emoears\aho\Mod\*"; DestDir: "{#mod}\EmotionalEars"; Components: plugins/emoears/aho; Flags: ignoreversion recursesubdirs createallsubdirs 
	Source: "{#IPlugin}\emoears\norm\Mod\*"; DestDir: "{#mod}\EmotionalEars"; Components: plugins/emoears/mod; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\extendrender\norm\*"; DestDir: "{#syb}"; Components: plugins/extendrender; Flags: ignoreversion recursesubdirs createallsubdirs 
  Source: "{#IPlugin}\extendrender\optional\*"; DestDir: "{#ucfg}"; Components: plugins/extendrender/config; Flags: ignoreversion recursesubdirs createallsubdirs 
;Source: "{#IPlugin}\futa\*"; DestDir: "{#syb}"; Components: plugins/futa; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#IPlugin}\facecon\*"; DestDir: "{#syb}"; Components: plugins/facecon; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\freeapp\*"; DestDir: "{#syb}"; Components: plugins/freeapp; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\freedress\*"; DestDir: "{#syb}"; Components: plugins/freedress; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\halfundress\*"; DestDir: "{#syb}"; Components: plugins/halfundress; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\InOut\*"; DestDir: "{#syb}"; Components: plugins/inout; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\lookmaid\*"; DestDir: "{#syb}"; Components: plugins/lookmaid; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\lookmaster\*"; DestDir: "{#syb}"; Components: plugins/lookmaster; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\mirrorprops\Sybaris\*"; DestDir: "{#syb}"; Components: plugins/mirror; Flags: ignoreversion recursesubdirs createallsubdirs 
  Source: "{#IPlugin}\mirrorprops\Mod\*"; DestDir: "{#mod}"; Components: plugins/mirror; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\MTAcc\Norm\*"; DestDir: "{#syb}"; Components: plugins/mtacc; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\MTAcc\AllScene\*"; DestDir: "{#plug}"; Components: plugins/mtacc/AllScene; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\MM\*"; DestDir: "{#syb}"; Components: plugins/MM; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\NormExcite\*"; DestDir: "{#syb}"; Components: plugins/normexcite; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\notecolor\*"; DestDir: "{#syb}"; Components: plugins/notecolor; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\objexp\*"; DestDir: "{#syb}"; Components: plugins/objexp; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\partsedit\*"; DestDir: "{#syb}"; Components: plugins/partsedit; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\personaledit\*"; DestDir: "{#syb}"; Components: plugins/personaledit; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\plugmanage\*"; DestDir: "{#syb}"; Components: plugins/plugmanage; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\pluginext\*"; DestDir: "{#syb}"; Components: plugins/pluginext; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\pngplace\core\*"; DestDir: "{#plug}"; Components: plugins/pngplace; Flags: ignoreversion recursesubdirs createallsubdirs 
	Source: "{#IPlugin}\PngPlace\ExtraPNGs\*"; DestDir: "{#ucfg}"; Components: plugins/pngplace/expng; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\propitem\*"; DestDir: "{#syb}"; Components: plugins/propitem; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\rythmoption\*"; DestDir: "{#syb}"; Components: plugins/rhythmoption; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\scenecap\Norm\*"; DestDir: "{#syb}"; Components: plugins/scenecap; Flags: ignoreversion recursesubdirs createallsubdirs 
  Source: "{#IPlugin}\scenecap\Modpmats\*"; DestDir: "{#mod}"; Components: plugins/scenecap/mpmats; Flags: ignoreversion recursesubdirs createallsubdirs 
	Source: "{#IPlugin}\scenecap\VR\*"; DestDir: "{#syb}"; Components: plugins/scenecap/VR; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\seieki\*"; DestDir: "{#syb}"; Components: plugins/seieki; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\shaderchange\*"; DestDir: "{#syb}"; Components: plugins/shaderchange; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\shapeanim\*"; DestDir: "{#syb}"; Components: plugins/shapeanimator/norm; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\shapeanimdoc\*"; DestDir: "{#syb}"; Components: plugins/shapeanimator/doc; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\SKAcc\*"; DestDir: "{#syb}"; Components: plugins/SKAcc; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\skillcomshort\*"; DestDir: "{#syb}"; Components: plugins/skillcomshort; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\slimeshade\*"; DestDir: "{#syb}"; Components: plugins/slimeshade; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\smoothanim\*"; DestDir: "{#syb}"; Components: plugins/smoothanim; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\toukascreen\*"; DestDir: "{#syb}"; Components: plugins/toukascreen; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\ureye\*"; DestDir: "{#syb}"; Components: plugins/ureye; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\vibemaid\*"; DestDir: "{#syb}"; Components: plugins/vibemaid; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\voicenormalizer\*"; DestDir: "{#syb}"; Components: plugins/voicenorm; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\xtms\*"; DestDir: "{#syb}"; Components: plugins/xtms; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IPlugin}\yotutil\*"; DestDir: "{#syb}"; Components: plugins/yotutil; Flags: ignoreversion recursesubdirs createallsubdirs 

;Misc Files

//The files here are fetched dynamically as needed from the internet.
Source: "{tmp}\COM3D2 DlC Checker.exe"; DestDir: "{app}"; Components: ext/dlccheck; Flags: external 
//These Files are fetched locally.
Source: "{#IMisc}\SybArc\*"; DestDir: "{app}"; Components: misc/sybarc; Flags: recursesubdirs 
Source: "{#IMisc}\MMPoses\*"; DestDir: "{#mod}"; Components: plugins/mm/mmposes; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IMisc}\MMPoses\MultipleMaidsPose\*"; DestDir: "{app}\PhotoModeData\MyPose"; Components: misc/mmposes; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IMisc}\MoreBGsNei\*"; DestDir: "{#mod}\PhotoBG_NEI"; Components: misc/bgnei; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IMisc}\TextureUncensors\FemaleSkinUncensor\*"; DestDir: "{#mod}\[CMI]Uncensors\FemaleSkinUncensor"; Components: misc/uncensor; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IMisc}\TextureUncensors\MaleReplacer\*"; DestDir: "{#mod}\[CMI]Uncensors\MaleUncensor\"; Components: misc/uncensormale; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IMisc}\TextureUncensors\DLCMaleReplacer\*"; DestDir: "{#mod}\[CMI]Uncensors\MaleUncensor\"; Components: misc/uncensormale; Flags: ignoreversion recursesubdirs  createallsubdirs; Check:FileExists(ExpandConstant('{app}\GameData\parts_dlc219.arc'))
Source: "{#IMisc}\TextureUncensors\MoreMaleUncensor\*"; DestDir: "{#mod}\[CMI]Uncensors\MaleUncensor\"; Components: misc/extrauncensormale; Flags: ignoreversion  recursesubdirs createallsubdirs
Source: "{#IMisc}\TextureUncensors\DLCMoreMaleUncensor\*"; DestDir: "{#mod}\[CMI]Uncensors\MaleUncensor\"; Components: misc/extrauncensormale; Flags: ignoreversion  recursesubdirs createallsubdirs; Check:FileExists(ExpandConstant('{app}\GameData\parts_dlc219.arc'))
Source: "{#IMisc}\TextureUncensors\body_analkupa\*"; DestDir: "{#mod}\[CMI]Uncensors\body_analkupa"; Components: misc/body/analkupa; Flags: ignoreversion recursesubdirs createallsubdirs 
Source: "{#IMisc}\TextureUncensors\lomob\*"; DestDir: "{#mod}\[CMI]Uncensors\LoMobBody"; Components: misc/body/LoMobBody; Flags: ignoreversion recursesubdirs createallsubdirs 

//Unrelated to files.
Source: "Documentation\CMI_Readme.pdf"; DestDir: "{app}\CMI Documentation"; Flags: isreadme nocompression
Source: "Documentation\MM_Readme.txt"; DestDir: "{app}\CMI Documentation"; Components:plugins/MM; Flags: isreadme
Source: "Documentation\DeRim_Readme.txt"; DestDir: "{app}\CMI Documentation"; Components:plugins/derim; Flags: isreadme

[/Files]