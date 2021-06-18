[Code]
	function IsEng(const path: String): Integer;
	begin
		//2 is INM. 1 is R18. 0 is not Eng.
	
		if (FileExists(path + '\localize.dat')) then
		begin
			if ((FileExists(path + '\GameData\system_en.arc')) = false) AND ((FileExists(path + '\GameData\bg_en.arc')) = false) then
			begin
				result := 2;
			end else
			begin
				result := 1;
			end;
		end
		else
		begin
			result := 0;
		end;
	end;
	
function IsEngSimple(const path: String): Boolean;
begin
	//2 is INM. 1 is R18. 0 is not Eng.
	
	if (FileExists(path + '\localize.dat')) then
	begin
		Result := true;
	end
	else
	begin
		result := false;
	end;
end;
	
Function FixEngComponents(): Boolean;
begin
	//If english version is detected, run the below code.
	if (IsEng(path) > 0) AND (EngDisable <> true) then
	begin
		MsgBox(CustomMessage('EnglishVersionAlert'), mbInformation, MB_OK)
		if (MsgBox(CustomMessage('EnglishVersionCompatibility'), mbConfirmation, MB_YESNO) = IDYES) then
		begin
			//Unchecks the components for English version
			Wizardform.ComponentsList.Checked[GetComponentIndex(CustomMessage('TranslationPlugs'))] := false
			Wizardform.ComponentsList.Checked[GetComponentIndex('i18nEx')] := false
			Wizardform.ComponentsList.Checked[GetComponentIndex('Resource Redirector')] := false
			Wizardform.ComponentsList.Checked[GetComponentIndex('XUnity AutoTranslator')] := false
			//Grays out components that shouldn't be used on english version
			Wizardform.ComponentsList.ItemEnabled[GetComponentIndex(CustomMessage('TranslationPlugs'))] := false
			Wizardform.ComponentsList.ItemEnabled[GetComponentIndex('i18nEx')] := false
			Wizardform.ComponentsList.ItemEnabled[GetComponentIndex(CustomMessage('ExtraTrans'))] := false
			Wizardform.ComponentsList.ItemEnabled[GetComponentIndex('Resource Redirector')] := false
			Wizardform.ComponentsList.ItemEnabled[GetComponentIndex('XUnity AutoTranslator')] := false
			//Syb Section
			Wizardform.ComponentsList.ItemEnabled[GetComponentIndex(CustomMessage('TranslationPlugs') + ' (Syb)')] := false
			Wizardform.ComponentsList.ItemEnabled[GetComponentIndex('i18nEx (Syb)')] := false
			Wizardform.ComponentsList.ItemEnabled[GetComponentIndex(CustomMessage('ExtraTrans') + ' (Syb)')] := false
			Wizardform.ComponentsList.ItemEnabled[GetComponentIndex('XUnity AutoTranslator (Syb)')] := false
			//Removes types that could potentially install non-eng version components
			Wizardform.TypesCombo.Items.Delete(0);
			Wizardform.TypesCombo.Items.Delete(0);
			//When an entry is deleted, any higher entries cascade down. Thus we just delete the same entry multiple times.
			Wizardform.TypesCombo.Items.Delete(2);
			Wizardform.TypesCombo.Items.Delete(2);
			Wizardform.TypesCombo.Items.Delete(2);
			//Selects a functioning english type                        
			WizardForm.TypesCombo.ItemIndex := 0;
			//Updates checkboxes.
			EngDisable := true;																								
			//WizardForm.TypesCombo.OnChange(WizardForm.TypesCombo);
			//MsgBox('Debug!', mbInformation, MB_OK);
		end;
	end;
end;
	
	
Function HandleSer(const GamePath: String): Boolean;
begin

  If FileExists(GamePath + '\serialize_storage_config.cfg') = false then
  begin
    result := true
    exit;
  end;

  if MsgBox(CustomMessage('SerializePrompt'), mbConfirmation, MB_YESNO) = MrYES then
  begin
    if DeleteFile(GamePath + '\serialize_storage_config.cfg') = false then
    begin
      MsgBox(FmtMessage(CustomMessage('SerializeDeleteFail'),[GamePath]) , mbCriticalError, MB_OK);
      result := false;
      exit;
    end;

    if DirExists(ExpandConstant('{userdocs}\KISS\COM3D2')) then
    begin
      if Copy(ExpandConstant('{userdocs}\KISS\COM3D2'), GamePath) = false then
      begin
        MsgBox(FmtMessage(CustomMessage('SerializeCopyFail'),[ExpandConstant('{userdocs}\KISS\COM3D2')]) , mbCriticalError, MB_OK);
        result := false;
        exit;
      end;
    end;
  end;

  result := true;
end;

var
	IsCRAsked: Boolean;	
function GetIsCR(): Boolean;
begin

	Log('Checking GetIsCR');

	if (IsCRAsked = false) then
	begin
		case MsgBox(CustomMessage('IsGameCR'), mbInformation, MB_YESNO) of 
			IDYES: IsCR := true;
			IDNO: IsCR := false;
		end;
		
		if (IsCR) then
		begin
			MinimumVersion := {#CRMinimumVersion};
			SuppressibleMsgBox(CustomMessage('GameIsCRWarning'), mbInformation, MB_OK, IDOK);

		end
		else begin
			MinimumVersion := {#MinimumVersion};
		end;
		
		IsCRAsked := true;
	end;
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
	//WizardForm.WizardBitmapImage2.Stretch := false;
end;
[/Code]