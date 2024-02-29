#define iCRPlugin "CMI\#CREdit\Plugins"
#define iCRPatch "CMI\#CREdit\Patchers"
#define iCRbep 'CMI\#CREdit\Loader\BepinEX'
#define JapRegistryCR "Software\KISS\カスタムオーダーメイド3D2.5"

[Registry]

Root: HKCU; Subkey: "{#JapRegistryCR}"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Check: NOT IsEmptyFolder() AND GetIsCR() AND NOT IsEngSimple(ExpandConstant('{app}')); Tasks:reg

[Files]

Source: "{#iCRbep}\GearFix\*"; DestDir: "{#beppa}"; Components:bepinexPlugs/GearFix; Flags: ignoreversion recursesubdirs createallsubdirs; Check: GetIsCR()

;Source: "{#ICRPatch}\ExternalSave\*"; DestDir: "{#syb}"; Components: Patchers/extsave; Flags: ignoreversion recursesubdirs createallsubdirs; Check: GetIsCR()
	;Source: "{#ICRPlugin}\MaidVoice\*"; DestDir: "{#syb}"; Components: Patchers/extsave/maidvoice; Flags: ignoreversion recursesubdirs createallsubdirs; Check: GetIsCR()
		;Source: "{#ICRPlugin}\AddMod\*"; DestDir: "{#syb}"; Components: Patchers/extsave/maidvoice/addmod; Flags: ignoreversion recursesubdirs createallsubdirs; Check: GetIsCR()
			;Source: "{#ICRPlugin}\distortcorrect\*"; DestDir: "{#syb}"; Components: Patchers/extsave/maidvoice/addmod/distort; Flags: ignoreversion recursesubdirs createallsubdirs; Check: GetIsCR()

;Source: "{#ICRPatch}\FaceType\*"; DestDir: "{#syb}"; Components: Patchers/facetype; Flags: ignoreversion recursesubdirs createallsubdirs; Check: GetIsCR()

;Source: "{#ICRPlugin}\ACCex\*"; DestDir: "{#syb}"; Components: plugins/accex; Flags: ignoreversion recursesubdirs createallsubdirs; Check: GetIsCR()
Source: "{#ICRPlugin}\scenecap\Norm\*"; DestDir: "{#syb}"; Components: plugins/scenecap; Flags: ignoreversion recursesubdirs createallsubdirs; Check: GetIsCR()
Source: "{#ICRPlugin}\MTAcc\Norm\*"; DestDir: "{#syb}"; Components: plugins/mtacc; Flags: ignoreversion recursesubdirs createallsubdirs; Check: GetIsCR()
Source: "{#ICRPlugin}\MTAcc\AllScene\*"; DestDir: "{#plug}"; Components: plugins/mtacc/AllScene; Flags: ignoreversion recursesubdirs createallsubdirs; Check: GetIsCR()
Source: "{#ICRPlugin}\InOut\*"; DestDir: "{#syb}"; Components: plugins/inout; Flags: ignoreversion recursesubdirs createallsubdirs; Check: GetIsCR()
Source: "{#ICRPlugin}\yotutil\*"; DestDir: "{#syb}"; Components: plugins/yotutil; Flags: ignoreversion recursesubdirs createallsubdirs; Check: GetIsCR()
;Source: "{#ICRPlugin}\slimeshade\*"; DestDir: "{#syb}"; Components: plugins/slimeshade; Flags: ignoreversion recursesubdirs createallsubdirs; Check: GetIsCR()
Source: "{#ICRPlugin}\partsedit\*"; DestDir: "{#syb}"; Components: plugins/partsedit; Flags: ignoreversion recursesubdirs createallsubdirs; Check: GetIsCR()
;Source: "{#ICRPlugin}\shapeanim\*"; DestDir: "{#syb}"; Components: plugins/shapeanimator/norm; Flags: ignoreversion recursesubdirs createallsubdirs; Check: GetIsCR()
[/Files]