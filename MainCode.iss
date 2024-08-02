[Code]
//GlobalVariables
var
	PresetFile: String;
	OriginalTypeComboChangedEvent: TNotifyEvent;
	OriginalResizeEvent: TNotifyEvent;
	ChangeBannerButton: TNewButton;
    EngDisable: Boolean;
[/Code]

//The following script contains a bunch of helper functions and methods. They were moved out so better track could be kept.
#include "Helpers.iss"
//Functions to help work with the game's differences.
#include "COM3D2Helpers.iss"
//More helper functions for handling the backing up of previous installs.
#include "OldInstallHandler.iss"
//This version and path verification are such a lengthy and careful process, I've overhauled it and moved it to a seperate "class".
#include "VersionVerification.iss"
//Collection of code blocks that are delegated an event and deal with it.
#include "DelegateCode.iss"

[Code]
procedure InitializeWizard();
var
	PathValue: String;
	ErrorCode: Integer;
	Readme: String;
begin

	Log('Initial setup is beginning...')

	OriginalTypeComboChangedEvent := WizardForm.TypesCombo.OnChange
	WizardForm.TypesCombo.OnChange := @TypesComboChange
	OriginalResizeEvent :=  WizardForm.OnResize
	WizardForm.OnResize := @OnResize
	PresetFile := 'Custom.{#ShortName}Type'

	SetBanner(nil)

	Log('Done setting up some events and a variable...')


	if (MsgBox(CustomMessage('ScamWarning') + #13#10#13#10 + CustomMessage('ReadmeRead'), mbConfirmation, MB_YESNO) = IDNO) then
	begin

		MsgBox(CustomMessage('ReadmeExit'), mbCriticalError, MB_OK)

		if (ActiveLanguage = 'chinesesimplified') then readme := '{#ShortName}_Readme_Chinese.pdf' else readme := '{#ShortName}_Readme.pdf';

		ExtractTemporaryFile(readme)
		ShellExecAsOriginalUser('open', AddQuotes(ExpandConstant('{tmp}\' + readme)), '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode)
		abort

	end;

	ChangeBannerButton := TNewButton.Create(WizardForm)
	ChangeBannerButton.Parent := WizardForm.WizardBitmapImage2.Parent
	ChangeBannerButton.Caption := '→'
	ChangeBannerbutton.Left := 0
	ChangeBannerbutton.Top := 0
	ChangeBannerButton.Anchors := [akRight]
	ChangeBannerButton.Width := 20
	ChangeBannerButton.Height := 20
	ChangeBannerButton.OnClick := @SetBanner

	//Tries to find the path of the game via the registry and if it suceeds, pushes it to the value var.
	if RegQueryStringValue(HKEY_CURRENT_USER, '{#JapRegistry}','InstallPath', PathValue) then
	//Sets the wizard dir field to default to what is found in the registry
	begin
		WizardForm.DirEdit.Text := (PathValue)
	end
	else if RegQueryStringValue(HKEY_CURRENT_USER, '{#JapRegistryCR}','InstallPath', PathValue) then
	begin
		WizardForm.DirEdit.Text := (PathValue)
	end
	else if RegQueryStringValue(HKEY_CURRENT_USER, '{#EnglishRegistry}','InstallPath', PathValue) then
	//Sets the wizard dir field to default to what is found in the registry if the JP path isn't found but the ENG path is.
	begin
		WizardForm.DirEdit.Text := (PathValue)
	end
    //Maybe CR is the key so just check it.
    else if RegQueryStringValue(HKEY_CURRENT_USER, '{#EnglishRegistryCR}','InstallPath', PathValue) then
	begin
		WizardForm.DirEdit.Text := (PathValue)
	end
	//If no registry key is found, it will blank the field to force users to select their path.
	else
	begin
		WizardForm.DirEdit.Text := ''
	end;
end;

procedure CurPageChanged(const CurPageID: Integer);
var
    Path: string;
begin
	//Only run the code if wizard is on the components page
	if (CurPageID <> wpSelectComponents) then
		exit;

    Path := ExpandConstant('{app}')

	if IsCR then
		MsgBox(CustomMessage('CRVersionAlert'), mbInformation, MB_OK);

	if (GetIsEng(path) > 0) AND NOT EngDisable then
		if (MsgBox(CustomMessage('EnglishVersionAlert') + #13#10#13#10 + CustomMessage('EnglishVersionCompatibility'), mbInformation, MB_YESNO) = IDYES) then
			EngDisable := true;

	FixComponents();
end;


function BackButtonClick(const CurPageID: Integer): Boolean;
begin

	if (CurPageID <> wpSelectComponents) then
	begin

		result := true;
		exit;

	end;

	if (MsgBox(CustomMessage('GameTypeChangedExit'), mbConfirmation, MB_YESNO) = IDYES) then
	begin
		Abort;
	end;

end;

procedure InstallOps();
var
    Path, OldInstallPath: String;
begin
	Log('Beginning Install Ops!');

    Path := ExpandConstant('{app}') 

	//Saves any custom selections to components on install.
	if (CompareText(WizardSetupType(false),'custom') = 0) then
	begin
	
		while NOT SaveCustomPreset(path) do
		begin
		
			case SuppressibleMsgBox('We encountered an error while trying to save the custom preset...', mbError, MB_ABORTRETRYIGNORE, IDIGNORE) of
				IDIGNORE: break;
				IDABORT: abort;
			end;
			
		end;
		
	end;

	//Starts by removing the Read-Only flag if applicable.
	if WizardIsTaskSelected('readonly') then
	begin
    
        WizardForm.StatusLabel.Caption := 'Removing read-only flags in the game directory! This can take a while...';
	
		while NOT RemoveReadonlyRecursive(path) do
		begin
		
			case SuppressibleMsgBox('We encountered an error while trying to remove readonly from your application directory...', mbError, MB_ABORTRETRYIGNORE, IDIGNORE) of
				IDIGNORE: break;
				IDABORT: abort;
			end;
			
		end;
		
	end;

	//Will now begin the move old install to backup folder if task was selected.
	if WizardIsTaskSelected('clean/moveold') then
	begin
        
        WizardForm.StatusLabel.Caption := 'Backing up old installations...';

        OldInstallPath := AddBackSlash(path) + 'OldInstall'
	
		while DirExists(OldInstallPath) AND NOT AppendToName(OldInstallPath, GetDateTimeString('ddddd.h.nn.ss', '.', '.')) do
		begin
		
			case SuppressibleMsgBox('Encountered an issue while attempting to rename OldInstall folder.', mbError, MB_ABORTRETRYIGNORE, IDIGNORE) of
				IDIGNORE: break;
				IDABORT: abort;
			end;
			
		end;

		while NOT MoveOld(path, ['']) do
		begin
		
			case SuppressibleMsgBox(CustomMessage('MoveOldExcep'), mbError, MB_ABORTRETRYIGNORE, IDIGNORE) of
				IDIGNORE: break;
				IDABORT: abort;
			end;
			
		end;
		
	end;
	
	Log('Moving old mods...')

	if WizardIsTaskSelected('clean/moveold/mods') then
	begin

        WizardForm.StatusLabel.Caption := 'Backing up old mods...';

		while NOT MoveOldMod(path, ['{#ModDir}']) do
		begin
		
			case SuppressibleMsgBox(CustomMessage('MoveOldModExcep'), mbError, MB_ABORTRETRYIGNORE, IDIGNORE) of
				IDIGNORE: break;
				IDABORT: abort;
			end;
			
		end;
	end;
	
	Log('Install ops done!')
end;

procedure PostInstallOps();
var
    OldInstallPath, Path: String;
begin
    Path := expandConstant('{app}');

	HandleNutakuSerialization(path);

	if WizardIsTaskSelected('clean/moveold/config') then
	begin

        WizardForm.StatusLabel.Caption := 'Copying configuration files back...';
	
		while NOT MoveOldConfigBack(path) do
		begin
			case SuppressibleMsgBox('Encountered an issue while attempting to copy your old configs back...', mbError, MB_ABORTRETRYIGNORE, IDIGNORE) of
				IDIGNORE: break;
				IDABORT: abort;
			end;
		end;
		
	end;

    OldInstallPath := AddBackSlash(path) + 'OldInstall'

	while DirExists(OldInstallPath) AND NOT AppendToName(OldInstallPath, GetDateTimeString('ddddd.h.nn.ss', '.', '.')) do
	begin
		case SuppressibleMsgBox(CustomMessage('CannotRenameOld'), mbError, MB_ABORTRETRYIGNORE, IDIGNORE) of
			IDIGNORE: break;
			IDABORT: abort;
		end;
	end;

	if WizardIsTaskSelected('readonly') then
	begin
        WizardForm.StatusLabel.Caption := 'Removing readonly (again). This can take a while...';

		while NOT RemoveReadonlyRecursive(path) do
		begin
			// Display a message box
			case SuppressibleMsgBox('We encountered an error while trying to remove readonly from your application directory...', mbError, MB_ABORTRETRYIGNORE, IDIGNORE) of
				IDIGNORE: break;
				IDABORT: abort;
			end;
		end;
	end;

    //Creates a little file to help ID versions only when some component is installed.
    if (Length(WizardSelectedComponents(false)) <> 0) then
        SaveStringToFile(AddBackSlash(path) + '{#ShortName}.ver','{#MyAppVersion}', False);
end;

procedure CurStepChanged(const CurStep: TSetupStep);
begin
	case CurStep of
		ssinstall: InstallOps();
		ssPostInstall: PostInstallOps();
	end;
end;
[/Code]