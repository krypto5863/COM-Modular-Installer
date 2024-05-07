[Code]
var
    IsEng: Boolean;
    IsCR: Boolean;

function GetIsEng(const path: String): Integer;
begin
	//2 is INM. 1 is R18. 0 is not Eng.
	if NOT FileExists(AddBackSlash(path) + 'localize.dat') then
	begin
		result := 0;
		exit;
	end;

	if FileExists(AddBackSlash(path) + 'GameData\system_en.arc') OR FileExists(AddBackSlash(path) + 'GameData\bg-en.arc') then
	begin
		result := 1;
		exit;
	end;

	result := 2;
end;

function GetIsEngSimple(const path: String): Boolean;
begin

    if IsEng then
    begin
        result := IsEng
        exit;
    end;

	//True is Eng, any type. False is not eng.
	if FileExists(AddBackslash(path) + 'localize.dat') then
	begin
		Result := true;
		exit;
	end;

	result := false;
end;

function GetIsCR(): Boolean;
begin
	Log('Checking GetIsCR');
	result := IsCR;
end;

function GetRandAbove(const range: Integer; const atOrBelow: Integer): Boolean;
begin
    result := Random(range) <= atOrBelow;
end;

Function FixComponents(): Boolean;
var
	NonCR: Array of string;
	NonEng: Array of string;
	CRComps: Array of string;
    Path: String;
begin
    
    Path := ExpandConstant('{app}')

	//If english version is detected, run the below code.
	if (GetIsEng(path) > 0) AND EngDisable then
	begin
		NonEng := [
			'i18nEx',
			'XUnity AutoTranslator',
			'Resource Redirector',
			CustomMessage('TranslationPlugs'),
			CustomMessage('ExtraTrans')
		];

		UncheckDisableComponents(NonEng);
	end;

	if IsCR then begin
		NonCR := [
            '1900 Poses for MPS',
            'AddModsSlider',
            'AddYotogiSliderSE2',
            'AdvancedMaterialModifier',
            'AllScene Version',
            'AlwaysColorChangeEX',
            'AutoConverter',
            'AutoEraseOutline',
            'BodyCategoryAdd',
            'ChoosyPreset',
            'ColorPaletteHelper',
            'ColorPresetNum',
            'DistortCorrect',
            'DressDamage',
            'EditBlinkStop Script',
            'EditBodyLoadFix',
            'EditMenuFilter',
            'EditMenuSelectedAnime',
            'EditModeHighlights',
            'EditSceneUndo',
            'ExtendedPresetManagement',
            'ExternalSaveData',
            'FaceType',
            'HalfUnDressing',
            'InOutAnimation',
            'LimitBreak2',
            'LoMobChara',
            'LoadEditedNPCs Script',
            'LookAtYourMaid',
            'LookAtYourMaster',
            'MaidLoader',
            'MaidVoicePitch',
            'MeidoPhotoStudio',
            'Mirror Props',
            'ModLoader',
            'ModRefresh',
            'Modding Extensions',
            'ModExt',
            'MoreRandomNames Script',
            'MtAccelerator',
            'PersonalizedEditSceneSettings',
            'Quick Edit Scene Script',
            'RGBPalette',
            'SlimeShader',
            'SKAccelerator',
            'ShapeAnimator',
            'ShapekeyMaster',
            'ShaderServant',
            'ShiftClickExplorer',
            'ShortMenuLoader',
            'ShortMenuVanillaDatabase',
            'ShortStartLoader',
            'UndressUtil',
            'VibeYourMaid',
            'VoiceNormalizer',
            'Wrap Mode Extend Script',
            'XTFutaAccessories',
            'XTFutaBody',
            'XTMasterSlave+',
            'YotogiUtil',
            CustomMessage('AddMoreBG'),
            CustomMessage('ExtraUncensorMale'),
            CustomMessage('Uncensor'),
            CustomMessage('UncensorMale')
		];

        UncheckDisableComponents(NonCR);

		exit;
	end;

	//Otherwise if not CR
	CRComps := [
		'GearMenuFix'
	];

	UncheckDisableComponents(CRComps);

end;

Function HandleNutakuSerialization(const GamePath: String): Boolean;
begin

  If NOT FileExists(AddBackslash(GamePath) + 'serialize_storage_config.cfg') then
  begin
	result := true;
	exit;
  end;

  if (MsgBox(CustomMessage('SerializePrompt'), mbConfirmation, MB_YESNO) = MrNO) then
  begin
		Result := true;
		exit;
	end;

	if NOT DeleteFile(AddBackslash(GamePath) + 'serialize_storage_config.cfg') then
	begin
		MsgBox(FmtMessage(CustomMessage('SerializeDeleteFail'),[GamePath]) , mbCriticalError, MB_OK);
		result := false;
		exit;
	end;

	if NOT DirExists(ExpandConstant('{userdocs}\KISS\COM3D2')) then
	begin
		result := true;
		exit;
	end;

	if NOT ShellCopy(ExpandConstant('{userdocs}\KISS\COM3D2\*'), GamePath) then
	begin
		MsgBox(FmtMessage(CustomMessage('SerializeCopyFail'),[ExpandConstant('{userdocs}\KISS\COM3D2')]) , mbCriticalError, MB_OK);
		result := false;
		exit;
	end;

  result := true;
end;

var
	CurrentImageIndex: Integer;
procedure SetBanner(const Sender: TObject);
var
	Images: Array of string;
begin
	Images := [
		'Rabbit.bmp',
		'Kite.bmp',
		'kry.bmp',
		'pain.bmp',
        'joco.bmp',
        'shin.bmp'
	];

	if (Sender = nil) then
	begin
		CurrentImageIndex := Random(GetArrayLength(Images));
	end
	else
	begin
		if (CurrentImageIndex = GetArrayLength(Images) - 1) then
		begin
			CurrentImageIndex := 0;
		end
		else
		begin
			CurrentImageIndex := CurrentImageIndex + 1;
		end;
	end;

	Log(Images[CurrentImageIndex] + ' was selected as a banner from ' + IntToStr(GetArrayLength(Images)) + ' choices...');

	if not FileExists(ExpandConstant('{tmp}\') + Images[CurrentImageIndex]) then
	begin
		ExtractTemporaryFile(Images[CurrentImageIndex]);
	end;

	WizardForm.WizardBitmapImage2.Bitmap.LoadFromFile(ExpandConstant('{tmp}\') + Images[CurrentImageIndex]);
end;
[/Code]