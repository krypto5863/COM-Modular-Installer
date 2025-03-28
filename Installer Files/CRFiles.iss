#define iCRPlugin "Installer Files\CR Components\UnityInjector"
#define iCRBep 'Installer Files\CR Components\BepInEx'

[Registry]

Root: HKCU; Subkey: "{#JapRegistryCR}"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Check: NOT IsEmptyFolder() AND GetIsCR() AND NOT GetIsEngSimple(ExpandConstant('{app}')); Tasks:reg
Root: HKCU; Subkey: "{#EnglishRegistryCR}"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Check: NOT IsEmptyFolder() AND GetIsCR() AND GetIsEngSimple(ExpandConstant('{app}')); Tasks:reg

[Files]
Source: "{#iCRBep}\Core\*"; DestDir: "{app}"; Flags: {#stdFlags}; Check: GetIsCR()
Source: "{#iCRBep}\GearFix\*"; DestDir: "{#beppa}"; Flags: {#stdFlags}; Check: GetIsCR()

Source: "{#iCRbep}\BodyCategoryAdd\*"; DestDir: "{#bepp}"; Components: bepinexPlugs/bodycat; Flags: {#stdFlags}

Source: "{#iCRbep}\CMIUpdateChecker\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/UpCheck; Flags: {#stdFlags}; Check: GetIsCR()

Source: "{#iCRbep}\i18nEx\core\*"; DestDir: "{app}"; Components:bepinexPlugs/Translations/i18nEx; Flags: {#stdFlags}; Check: GetIsCR()
    Source: "{#iCRbep}\i18nEx\extraTranslations\*"; DestDir: "{app}\i18nEx"; Components:bepinexPlugs/Translations/i18nEx/extrans; Flags: {#stdFlags}; Check: GetIsCR()

    
Source: "{#ICRBep}\ExtendedErrorHandling\*"; DestDir: "{#bepp}"; Components: bepinexPlugs/ExErrorHandle; Flags: {#stdFlags}; Check: GetIsCR()
    
Source: "{#ICRBep}\MaidLoader\*"; DestDir: "{#bepp}"; Components: bepinexPlugs/MaidLoader; Flags: {#stdFlags}; Check: GetIsCR()

Source: "{#ICRBep}\ShaderServant\*"; DestDir: "{#bepp}"; Components: bepinexPlugs/ShaderServant; Flags: {#stdFlags}; Check: GetIsCR()

Source: "{#ICRBep}\ShortMenuLoader\*"; DestDir: "{#bepp}"; Components: bepinexPlugs/ShortMenu; Flags: {#stdFlags}; Check: GetIsCR()

Source: "{#iCRbep}\SliderDelimiter\*"; DestDir: "{#bepp}"; Components: bepinexPlugs/SliderDelimiter; Flags: {#stdFlags}

Source: "{#ICRBep}\TimeDependentPhysics\*"; DestDir: "{#bepp}"; Components:bepinexPlugs/TimeDependentPhysics; Flags: {#stdFlags}; Check: GetIsCR()


Source: "{#ICRPlugin}\AlwaysColorChange\*"; DestDir: "{#plug}"; Components: plugins/accex; Flags: {#stdFlags}; Check: GetIsCR()
Source: "{#ICRPlugin}\NormalizeExcite\*"; DestDir: "{#plug}"; Components: plugins/normexcite; Flags: {#stdFlags}; Check: GetIsCR()
Source: "{#ICRPlugin}\EditSceneUndo\*"; DestDir: "{#plug}"; Components: plugins/editundo; Flags: {#stdFlags}; Check: GetIsCR()
Source: "{#ICRPlugin}\ExtendRenderingRange"; DestDir: "{#plug}"; Components: plugins/extendrender; Flags: {#stdFlags}; Check: GetIsCR()
Source: "{#ICRPlugin}\LookAtYourMaster"; DestDir: "{#plug}"; Components: plugins/LookMaster; Flags: {#stdFlags}; Check: GetIsCR()
Source: "{#ICRPlugin}\PartsEdit\*"; DestDir: "{#plug}"; Components: plugins/partsedit; Flags: {#stdFlags}; Check: GetIsCR()
Source: "{#ICRPlugin}\PluginManager\*"; DestDir: "{#plug}"; Components: plugins/plugmanage; Flags: {#stdFlags}; Check: GetIsCR()
Source: "{#ICRPlugin}\ObjectExplorer\*"; DestDir: "{#plug}"; Components: plugins/objexp; Flags: {#stdFlags}; Check: GetIsCR()
Source: "{#ICRPlugin}\YotogiUtil\*"; DestDir: "{#plug}"; Components: plugins/yotutil; Flags: {#stdFlags}; Check: GetIsCR()
[/Files]