[Code]
function IsEng(const path: String): Integer;
begin
	//2 is INM. 1 is R18. 0 is not Eng.
	if NOT FileExists(path + '\localize.dat') then
	begin
		result := 0;
		exit;
	end;

	if FileExists(path + '\GameData\system_en.arc') OR FileExists(path + '\GameData\bg-en.arc') then
	begin
		result := 1;
		exit;
	end;

	result := 2;
end;

function IsEngSimple(const path: String): Boolean;
begin
	//True is Eng, any type. False is not eng.
	if FileExists(path + '\localize.dat') then
	begin
		Result := true;
		exit;
	end;

	result := false;
end;

Function FixComponents(): Boolean;
var
	NonCR: Array of string;
	NonEng: Array of string;
	CRComps: Array of string;
	I: Integer;
begin

	//If english version is detected, run the below code.
	if (IsEng(path) > 0) AND EngDisable then
	begin
		NonEng := [
			'i18nEx',
			'i18nEx (Syb)',
			'XUnity AutoTranslator',
			'XUnity AutoTranslator (Syb)',
			'Resource Redirector',
			CustomMessage('TranslationPlugs'),
			CustomMessage('TranslationPlugs') + ' (Syb)',
			CustomMessage('ExtraTrans'),
			CustomMessage('ExtraTrans') + ' (Syb)'
		];

		for I := 0 to (GetArrayLength(NonEng)-1) do
		begin
			RemoveComponent(NonEng[I]);
		end;
	end;

	if IsCR then begin
		NonCR := [
			'SmoothAnimation',
			'XTMasterSlave+',
			'XTFutaBody',
			'XTFutaAccessories',
			'Doc' + #39 + 's SA',
			'HalfUnDressing',
			CustomMessage('EmoEarsMod'),
			CustomMessage('EmoEarsAhoge'),
			'EmotionalEars(and tails)',
			'EditSceneUndo',
			'VibeYourMaid',
			'BodyCategoryAdd',
			'Wrap Mode Extend Script',
			'Error Texture Placeholder Script',
			'MeidoPhotoStudio',
			'1900 Poses for MPS',
			//'ExtendedErrorHandling',
			//'ShapekeyMaster',
			//'ShortMenuLoader',
			'ShortStartLoader',
			'AlwaysColorChangeEX',
			'AdvancedMaterialModifier'
		];

		for I := 0 to (GetArrayLength(NonCR)-1) do
		begin
			RemoveComponent(NonCR[I]);
		end;

		if Wizardform.ComponentsList.Checked[GetComponentIndex('ShapeAnimator')] then
		begin
			Wizardform.ComponentsList.CheckItem(GetComponentIndex('Standard SA'), coCheck);
		end;

		exit;
	end;

	//Otherwise if not CR
	CRComps := [
		'GearMenuFix'
	];

	for I := 0 to (GetArrayLength(CRComps)-1) do
	begin
		RemoveComponent(CRComps[I]);
	end;

end;

Function HandleSer(const GamePath: String): Boolean;
begin

  If NOT FileExists(GamePath + '\serialize_storage_config.cfg') then
  begin
	result := true;
	exit;
  end;

  if (MsgBox(CustomMessage('SerializePrompt'), mbConfirmation, MB_YESNO) = MrNO) then
  begin
		Result := true;
		exit;
	end;

	if NOT DeleteFile(GamePath + '\serialize_storage_config.cfg') then
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

	if NOT Copy(ExpandConstant('{userdocs}\KISS\COM3D2'), GamePath) then
	begin
		MsgBox(FmtMessage(CustomMessage('SerializeCopyFail'),[ExpandConstant('{userdocs}\KISS\COM3D2')]) , mbCriticalError, MB_OK);
		result := false;
		exit;
	end;

  result := true;
end;

var
	IsCRAsked: Boolean;
function GetIsCR(): Boolean;
begin
	Log('Checking GetIsCR');
	result := IsCR;
end;

var
	Choice: Integer;
procedure SetBanner(const Sender: TObject);
var
	Images: Array of string;
begin
	Images := [
		'Rabbit.bmp',
		'Kite.bmp',
		'kry.bmp',
		'pain.bmp'
	];

	if (Sender = nil) then
	begin
		Choice := Random(GetArrayLength(Images));
	end
	else
	begin
		if (Choice = GetArrayLength(Images) - 1) then
		begin
			Choice := 0;
		end
		else
		begin
			Choice := Choice + 1;
		end;
	end;

	Log(Images[Choice] + ' was selected as a banner from ' + IntToStr(GetArrayLength(Images)) + ' choices...');

	if not FileExists(ExpandConstant('{tmp}\') + Images[Choice]) then
	begin
		ExtractTemporaryFile(Images[Choice]);
	end;

	WizardForm.WizardBitmapImage2.Bitmap.LoadFromFile(ExpandConstant('{tmp}\') + Images[Choice]);
end;
[/Code]