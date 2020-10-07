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
[/Code]

//The following script file has a rather large function for using 7zip to unzip files via the installer. It was moved to a seperate script to make things easier.
#include "unzip.iss"
//The following script contains a bunch of helper functions and methods. They were moved out so better track could be kept.
#include "helper.iss"

[Code]
	var
		path: WideString;
		OGEvent: TNotifyEvent;
		verOutcome: Integer;
		MinVer: Integer;
	procedure TypesComboChange(Sender: TObject);
	//var
		//TypeEntry: TSetupTypeEntry;
	begin
		//TypeEntry := TypesCombo.Items.Objects[TypesCombo.ItemIndex];
			if (CompareText(WizardForm.TypesCombo.Items.Strings[WizardForm.TypesCombo.ItemIndex],'Custom Preset') = 0) then
			begin
				OGEvent(Sender);
				if (FileExists(path + '\' + PresetFile)) then
				begin
					ApplyCustomPreset(path);
				end;
			end else begin
				OGEvent(Sender);
			end;
	end;

	function OnDownloadProgress(const Url, Filename: string; const Progress, ProgressMax: Int64): Boolean;
	begin
		if ProgressMax <> 0 then
			Log(Format('  %d of %d bytes done.', [Progress, ProgressMax]))
		else
			Log(Format('  %d bytes done.', [Progress]));
		Result := True;
	end;

	procedure InitializeWizard();
	var
		Value: String;
		ErrorCode: Integer;
	begin
		DownloadPage := CreateDownloadPage(SetupMessage(msgWizardPreparing), SetupMessage(msgPreparingDesc), @OnDownloadProgress);
		OGEvent :=  WizardForm.TypesCombo.OnChange;
		WizardForm.TypesCombo.OnChange := @TypesComboChange;
		PresetFile := 'Custom.CMIType';
		
		
		if (SiteValid('https://raw.githubusercontent.com/krypto5863/COM-Modular-Installer/master/Assets/manifest.txt')) then
		begin
		DownloadTemporaryFile('https://raw.githubusercontent.com/krypto5863/COM-Modular-Installer/master/Assets/manifest.txt','manifest.txt','',nil);
		end;
		
		if (IsInstallerOld(ExpandConstant('{tmp}'),'{#MyAppVersion}')) then
		begin
			MsgBox('This installer is outdated and likely incompatible with new assets/versions! You may continue the download but you continue at your own risk!' , mbCriticalError, MB_OK);
		end;

		if MsgBox('Did you read the readme? Failure to read it will void you any chance of receiving support.', mbConfirmation, MB_YESNO) = IDNO then
		begin
			MsgBox('Go back and read it before installing CMI.', mbCriticalError, MB_OK)
			ExtractTemporaryFile('CMI_Readme.pdf');
			ShellExecAsOriginalUser('open',
			AddQuotes(ExpandConstant('{tmp}\CMI_Readme.pdf')), '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
			abort
		end;

	//Tries to find the path of the game via the registry and if it suceeds, pushes it to the value var.
		if RegQueryStringValue(HKEY_CURRENT_USER, 'Software\KISS\カスタムオーダーメイド3D2','InstallPath', Value) then
		//Sets the wizard dir field to default to what is found in the registry
		begin
			WizardForm.DirEdit.Text := (Value);
		end
		else if RegQueryStringValue(HKEY_CURRENT_USER, 'Software\KISS\CUSTOM ORDER MAID3D 2','InstallPath', Value) then
		//Sets the wizard dir field to default to what is found in the registry if the JP path isn't found but the ENG path is.
		begin
			WizardForm.DirEdit.Text := (Value);
		end
		//If no registry key is found, it will blank the field to force users to select their path.
		else
		begin
			WizardForm.DirEdit.Text := '';
		end;
	end;

	procedure CurPageChanged(CurPageID: Integer);
	begin
	//Only run the code if wizard is on the components page
		if CurPageID=wpSelectComponents then
		begin
			//Saves path to global var.
			path := ExpandConstant('{app}');
			//Quits if the users are found to have updated their game incorrectly. This should help bring more awareness to incorrect updating and stop people from blaming CMI if they update incorrectly and then install CMI.
			if (FileExists(path + '\update.exe')) OR (FileExists(path + '\selector.exe')) OR (DirExists(path + '\data')) then
			begin
				MsgBox('We have detected that this game instance was updated improperly!(Usually by a drag and drop process) This is completely unsafe and WILL break your game.' + #13#10#13#10 + 'Due to this CMI will not install as you may encounter further errors and bugs if we continue. Please reinstall your game and update CORRECTLY (By placing the update/DLC files in an empty directory and using the provided update.exe or selector.exe) to continue.', mbCriticalError, MB_OK)
				abort;
			end;
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
					//When an entry is deleted, any higher entries cascade down. Thus we just delete the same entry multiple times.
					Wizardform.TypesCombo.Items.Delete(2);
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
			begin
			if verOutcome = 2 then
			begin
				Wizardform.TasksList.ItemEnabled[0] := false
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
			if (EngDisable = true) then
			begin
				if MsgBox('Due to changes made to the installer when disabling components for english versions, the installer needs to be restarted in order to revert these changes and allow you to safely use previous pages. Would you like to quit the installer now?', mbConfirmation, MB_YESNO) = IDYES then
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

	function NextButtonClick(CurPageID: Integer): Boolean;
	begin
		//Prevents code from running if not on the directory selection page
		if CurPageID = wpSelectDir then
		begin
			//Checks if the game is not INM version. If it's not, installation continues.
			if IsEng(WizardForm.DirEdit.Text) < 2 then
			begin
				//Checks the version of the game but also checks if the install folder has a game instance and lets the installer know for future reference.
				MinVer := 1480
				verOutcome := VersionCheck(WizardForm.DirEdit.Text,MinVer)
				if verOutcome >= 1 then
				begin
					//MsgBox('We should be returning true', mbInformation, MB_OK);
					//Small advisory, hope users follow it.
					MsgBox('Please ensure no game folders or game instances are open or you will have a bad install!', mbInformation, MB_OK);
					Result := true
				end 
				else 
				begin
					//MsgBox('We should be returning false', mbInformation, MB_OK);
					DownloadUpdate(MinVer);
					Result := false
				end;                                                                          
			end
			else begin
				MsgBox('We have detected INM! INM is not supported by CMI due to technical differences.' + #13#10#13#10 + 'To use CMI, please install the R18/Adult Content Supplement Patch.' + #13#10#13#10 + 'If your are not actually on an INM version of the game, then you have likely installed Eng DLC/files into your japanese game. Please refer to the readme on repair instructions.', mbCriticalError, MB_OK);
			end;
		end
		 
		else if (CurPageID = wpSelectComponents) then
		begin
			Result := true
		end else begin
		//MsgBox('Default' + path, mbInformation, MB_OK);
		//If not on the correct page, just default to true.
		Result := true;
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
					if RenameOldInstall(path) = false then
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

					if FileExists(path + '\' + 'serialize_storage_config.cfg') then 
					begin
					HandleSer(path, ExpandConstant('{userdocs}'))
					end;

					if WizardForm.TasksList.Checked[5] then
					begin
						ReturnConfig(path)
					end;

					if RenameOldInstall(path) = false then
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