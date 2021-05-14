[Files]

	//Bringing the file reference for the DLL here to keep code stuff together.
	Source:"Utility\DLL\CMIHelper.dll"; DestDir: "{tmp}"; Permissions: everyone-full; Flags: dontcopy deleteafterinstall nocompression noencryption

[/Files]

[Code]
	//GlobalVariables
	var
		PresetFile: String;
		DownloadPage: TDownloadWizardPage;
		EngDisable: Boolean;
		EmptyFolder: Boolean;
    path: WideString;
		OGEvent: TNotifyEvent;
[/Code]
//The following script contains a bunch of helper functions and methods. They were moved out so better track could be kept.
#include "helper.iss"
//The following script contains a bunch of helper functions and methods. They were moved out so better track could be kept.
#include "OldInstallHandler.iss"
//KeyValueLists Expandable
#include "AssetDownloadHandler.iss"
//This version and path verification are such a lengthy and careful process, I've overhauled it and moved it to a seperate "class". 
#include "VersionVerification.iss"
//Handle Serialized files
#include "serializeHandler.iss"
//Collection of code blocks that are delegated an event and deal with it.
#include "DelegateCode.iss"
//Handles the wizard initialization event.
#include "InitializeWizard.iss"

[Code]
	procedure CurPageChanged(CurPageID: Integer);
	begin
	//Only run the code if wizard is on the components page
		if CurPageID=wpSelectComponents then
		begin
			//Saves path to global var.
			path := ExpandConstant('{app}');
			//If english version is detected, run the below code.
			if (IsEng(path) > 0) AND (EngDisable <> true) then
			begin
				MsgBox('If you are not on an English version of the game quit the install right now and refer to the readme!!'+ #13#10#13#10 +'English version was found!! Be advised, English versions are not as feature full or as supported as the Japanese version!', mbInformation, MB_OK)
				if (MsgBox('Some components here can be harmful or incompatible to your English game. Should we disable these components in order to keep you safe?', mbConfirmation, MB_YESNO) = IDYES) then
				begin
					//Unchecks the components for English version
					Wizardform.ComponentsList.Checked[GetComponentIndex('Translation Plugins')] := false
					Wizardform.ComponentsList.Checked[GetComponentIndex('i18nEx')] := false
					Wizardform.ComponentsList.Checked[GetComponentIndex('Resource Redirector')] := false
					Wizardform.ComponentsList.Checked[GetComponentIndex('XUnity AutoTranslator')] := false
					//Grays out components that shouldn't be used on english version
					Wizardform.ComponentsList.ItemEnabled[GetComponentIndex('Translation Plugins')] := false
					Wizardform.ComponentsList.ItemEnabled[GetComponentIndex('i18nEx')] := false
					Wizardform.ComponentsList.ItemEnabled[GetComponentIndex('Extra Translations')] := false
					Wizardform.ComponentsList.ItemEnabled[GetComponentIndex('Resource Redirector')] := false
					Wizardform.ComponentsList.ItemEnabled[GetComponentIndex('XUnity AutoTranslator')] := false
					//Syb Section
					Wizardform.ComponentsList.ItemEnabled[GetComponentIndex('Translation Plugins (Syb)')] := false
					Wizardform.ComponentsList.ItemEnabled[GetComponentIndex('i18nEx (Syb)')] := false
					Wizardform.ComponentsList.ItemEnabled[GetComponentIndex('Extra Translations (Syb)')] := false
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
		if CurPageID = wpSelectTasks then
		if CurPageID = wpSelectTasks then
			begin
			if EmptyFolder then
			begin
				Wizardform.TasksList.ItemEnabled[0] := false
				Wizardform.TasksList.Checked[0] := false
				Wizardform.TasksList.ItemEnabled[5] := false
				Wizardform.TasksList.Checked[10] := false
				Wizardform.TasksList.ItemEnabled[10] := false
			end;
		end;
	end;
	
	function BackButtonClick(CurPageID: Integer): Boolean;
	begin
		if CurPageID = wpSelectComponents then
		begin		
			if (EngDisable = true) OR (EmptyFolder) then
			begin
				if MsgBox('Due to changes made to the installer when disabling components, the installer needs to be restarted in order to revert these changes and allow you to safely use previous pages. Would you like to quit the installer now?', mbConfirmation, MB_YESNO) = IDYES then
				begin
					Abort;
				end;				
			end else begin
				result := true;
			end;
		end else
		begin
			result := true;
		end;
	end;

	procedure CurStepChanged(CurStep: TSetupStep);
	begin
		case CurStep of
			ssInstall:
			begin
			
				DownloadAssets()					

				//Saves any custom selections to components on install.
				if (CompareText(WizardForm.TypesCombo.Items.Strings[WizardForm.TypesCombo.ItemIndex],'Custom Preset') = 0) then 
				begin
					SaveCustomPreset(path)
				end else if (CompareText(WizardForm.TypesCombo.Items.Strings[WizardForm.TypesCombo.ItemIndex],'Okay, make your own choices') = 0) then
				begin
					SaveCustomPreset(path)
				end;

				//Starts by removing the Read-Only flag if applicable.
				if WizardForm.TasksList.Checked[10] then
				begin
					RemoveRO(path)
				end;
				//Will now begin the move old install to backup folder if task was selected.
				if WizardForm.TasksList.Checked[3] then
				begin
					//MsgBox('File moving was selected', mbInformation, MB_OK);
					if (DirExists(path + '\OldInstall')) AND (AppendCreationTimeToName(path + '\OldInstall') = false) then
					begin
						abort                   
					end;

					if MoveOld(path) = false then
					begin
						MsgBox('An exception was tossed while trying to move the old installation to the old folder! Ensure that no game application is open and that none of the files or folders are open anywhere!! We are quitting to keep your data safe! Refer to the readme for troubleshooting steps!!!', mbCriticalError, MB_OK);
						abort       
					end;

				end;
				if WizardForm.TasksList.Checked[4] then
					begin
						//MsgBox('mod moving was chosen', mbInformation, MB_OK);
						//Checks if mod moving was selected and if so will execute that.
						if MoveOldMod(path) = false then
						begin
							MsgBox('An exception was tossed while trying to move the old mods to the old folder! Ensure that no game application is open and that none of the files or folders are open anywhere!! We are quitting to keep your data safe! Refer to the readme for troubleshooting steps!!!', mbCriticalError, MB_OK);
							abort
						end;
					end;//Mod Move
				end;                                                                               
			end;//Case
			case CurStep of
				ssPostInstall:
				begin
				
					if Wizardform.TasksList.Checked[0] then
					begin
						if (FileExists(path + '\GameData\system_en.arc')) then
						begin
							RegWriteStringValue(HKEY_CURRENT_USER, 'Software\KISS\CUSTOM ORDER MAID3D 2', 'InstallPath', path);
							RegWriteDWordValue(HKEY_CURRENT_USER, 'Software\KISS\CUSTOM ORDER MAID3D 2', 'DskSht', 1);
						end
						else
						begin
							RegWriteStringValue(HKEY_CURRENT_USER, 'Software\KISS\カスタムオーダーメイド3D2', 'InstallPath', path);
							RegWriteDWordValue(HKEY_CURRENT_USER, 'Software\KISS\カスタムオーダーメイド3D2', 'DskSht', 1);
						end;	
					end;

					HandleSer(path)

					if WizardForm.TasksList.Checked[5] then
					begin
						MoveOldConfigBack(path)
					end;

					if (DirExists(path + '\OldInstall')) AND (AppendCreationTimeToName(path + '\OldInstall') = false) then
					begin
						MsgBox('The OldInstall folder could not be renamed but the installation is already complete. As a result, we will not abort as the error is harmless. It should be automatically renamed the next time CMI is run', mbInformation, MB_OK);
					end;

					if WizardForm.TasksList.Checked[10] then
					begin
						RemoveRO(path)
					end;

					SaveStringToFile(path + '\CMI.ver','{#MyAppVersion}', False);
					
				end;
			end;
		end;//First begin

	//This whole fucking function is to correctly remove the created temp file and the CMIHelper.dll after install because Inno doesn't like .Net Assemblies.
	procedure DeinitializeSetup();
	var
		FilePath: string;
		BatchPath: string;
		S: TArrayOfString;
		ResultCode: Integer;
	begin
		FilePath := ExpandConstant('{tmp}\CMIHelper.dll');
		if not FileExists(FilePath) then
		begin
			Log(Format('File %s does not exist', [FilePath]));
		end
			else
		begin
			BatchPath :=
				ExpandConstant('{%TEMP}\') +
				'delete_' + ExtractFileName(ExpandConstant('{tmp}')) + '.bat';
			SetArrayLength(S, 7);
			S[0] := ':loop';
			S[1] := 'del "' + FilePath + '"';
			S[2] := 'if not exist "' + FilePath + '" goto end';
			S[3] := 'goto loop';
			S[4] := ':end';
			S[5] := 'rd "' + ExpandConstant('{tmp}') + '"';
			S[6] := 'del "' + BatchPath + '"';
			if not SaveStringsToFile(BatchPath, S, False) then
			begin
				Log(Format('Error creating batch file %s to delete %s', [BatchPath, FilePath]));
			end
				else
			if not Exec(BatchPath, '', '', SW_HIDE, ewNoWait, ResultCode) then
			begin
				Log(Format('Error executing batch file %s to delete %s', [BatchPath, FilePath]));
			end
				else
			begin
				Log(Format('Executed batch file %s to delete %s', [BatchPath, FilePath]));
			end;
		end;
	end;
//end.//Code end. Fuck Pascal.
[/Code]