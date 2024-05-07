#define iCRPlugin "Installer Files\CR Components\Plugins"
#define iCRbep 'Installer Files\CR Components\Loader\BepinEX'

[Registry]

Root: HKCU; Subkey: "{#JapRegistryCR}"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Check: NOT IsEmptyFolder() AND GetIsCR() AND NOT GetIsEngSimple(ExpandConstant('{app}')); Tasks:reg
Root: HKCU; Subkey: "{#EnglishRegistryCR}"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Check: NOT IsEmptyFolder() AND GetIsCR() AND GetIsEngSimple(ExpandConstant('{app}')); Tasks:reg

[Files]

Source: "{#iCRbep}\GearFix\*"; DestDir: "{#beppa}"; Components:bepinexPlugs/GearFix; Flags: {#stdFlags}; Check: GetIsCR()

Source: "{#ICRPlugin}\scenecap\Norm\*"; DestDir: "{#syb}"; Components: plugins/scenecap; Flags: {#stdFlags}; Check: GetIsCR()
Source: "{#ICRPlugin}\partsedit\*"; DestDir: "{#syb}"; Components: plugins/partsedit; Flags: {#stdFlags}; Check: GetIsCR()
[/Files]