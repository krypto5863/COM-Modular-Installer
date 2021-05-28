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
    ProgressOGEvent: TNotifyEvent;
		DownloadProgressLabel: TNewStaticText;
		x86bit: Boolean;
		x64bit: Boolean;
		bitString: String;
		MinimumVersion: Integer;
		IsCR: Boolean;
[/Code]
//#include "MyDownloadPage.iss"
//The following script contains a bunch of helper functions and methods. They were moved out so better track could be kept.
#include "helper.iss"

#if LMMT == true
//Functions exclusive to LMMT. Only really loaded if needed.
	#include "LMMT/LMMTExclusive.iss"
#elif LMMT == false
//Functions exclusive to LMMT. Only really loaded if needed.
	#include "CMI/CMIExclusive.iss"
#endif

//This zip is basically a library for unzipping zip files quickly.
#include "unzip.iss"
//The following script contains a bunch of helper functions and methods. They were moved out so better track could be kept.
#include "OldInstallHandler.iss"
//KeyValueLists Expandable
#include "AssetDownloadHandler.iss"
//This version and path verification are such a lengthy and careful process, I've overhauled it and moved it to a seperate "class". 
#include "VersionVerification.iss"
//Collection of code blocks that are delegated an event and deal with it.
#include "DelegateCode.iss"

[Code]
procedure InitializeWizard();
var
	Value: String;
	ErrorCode: Integer;
	FreeSpace, TotalSpace: Cardinal;
	ManifestVersion: String;
	VersionResult: Integer;	
begin

  OGEvent :=  WizardForm.TypesCombo.OnChange;
	WizardForm.TypesCombo.OnChange := @TypesComboChange;
	PresetFile := 'Custom.{#ShortName}Type';
		
	if (GetSpaceOnDisk(ExpandConstant('{tmp}'),True, FreeSpace, TotalSpace)) AND (FreeSpace < 5000) then
	begin
    MsgBox(FmtMessage(CustomMessage('StorageSpaceLow'), IntToStr(FreeSpace)), mbCriticalError, MB_OK)
    abort
	end;			
 
	try
		DownloadTemporaryFile('{#ManifestLink}','manifest.txt','',nil);
		
		if (StringFetch(ExpandConstant('{tmp}\manifest.txt'), ManifestVersion, 'CMI:')) then
		begin
	
			Log('Version fetch suceeded: ' + ManifestVersion)
	
			if VersionCompare('{#MyAppVersion}', ManifestVersion, VersionResult) then
			begin
		
				Log('Version compare returned: ' + IntToStr(VersionResult))
		
				if (VersionResult < 1) then
				begin
					MsgBox(CustomMessage('OutdatedInstaller') , mbCriticalError, MB_OK);
				end
			end
		end;
	except
		Log('Failed to vet the installer...')
	end;	
		
	MsgBox(CustomMessage('ScamWarning') , mbInformation, MB_OK);

	if MsgBox(CustomMessage('ReadmeRead'), mbConfirmation, MB_YESNO) = IDNO then
	begin
		MsgBox(CustomMessage('ReadmeExit'), mbCriticalError, MB_OK)
		ExtractTemporaryFile('{#ShortName}_Readme.pdf');
		ShellExecAsOriginalUser('open',
		AddQuotes(ExpandConstant('{tmp}\{#ShortName}_Readme.pdf')), '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
		abort
	end;	
	
  DownloadPage := CreateDownloadPage(SetupMessage(msgWizardPreparing), SetupMessage(msgPreparingDesc), @OnDownloadProgress);
		
	DownloadPage.ProgressBar.Top := DownloadPage.Msg2Label.Top + (DownloadPage.Msg2Label.Height * 3)
	DownloadPage.AbortButton.Top := DownloadPage.ProgressBar.Top + DownloadPage.AbortButton.Height
		
	DownloadProgressLabel := TNewStaticText.Create(WizardForm);
	DownloadProgressLabel.Parent := DownloadPage.Msg1Label.Parent;
	DownloadProgressLabel.Width := DownloadProgressLabel.Parent.Width - DownloadPage.Msg2Label.Height;
	DownloadProgressLabel.Left := DownloadPage.Msg2Label.Left;
	DownloadProgressLabel.Height := DownloadPage.Msg2Label.Height;
	DownloadProgressLabel.Top := DownloadPage.ProgressBar.Top - DownloadProgressLabel.Height;
	DownloadProgressLabel.Font.Assign(DownloadPage.Msg1Label.Font);
	DownloadProgressLabel.Caption := '';

	//Tries to find the path of the game via the registry and if it suceeds, pushes it to the value var.
	if RegQueryStringValue(HKEY_CURRENT_USER, '{#JapRegistry}','InstallPath', Value) then
	//Sets the wizard dir field to default to what is found in the registry
	begin
		WizardForm.DirEdit.Text := (Value);
	end
#if LMMT == false
	else if RegQueryStringValue(HKEY_CURRENT_USER, '{#EnglishRegistry}','InstallPath', Value) then
	//Sets the wizard dir field to default to what is found in the registry if the JP path isn't found but the ENG path is.
	begin
		WizardForm.DirEdit.Text := (Value);
	end
#endif			
	//If no registry key is found, it will blank the field to force users to select their path.
	else
	begin
		WizardForm.DirEdit.Text := '';
	end;
end;

procedure CurPageChanged(const CurPageID: Integer);
begin
//Only run the code if wizard is on the components page
	if CurPageID=wpSelectComponents then
	begin
		//Saves path to global var.
		path := ExpandConstant('{app}');
		
#if LMMT == false
		FixEngComponents()
#else
		FixBitComponents();
#endif
	end;
end;
	
	
function BackButtonClick(const CurPageID: Integer): Boolean;
begin
	if CurPageID = wpSelectComponents then
	begin		
		if (EngDisable = true) OR x86bit = false OR x64bit = false then
		begin
			if MsgBox(CustomMessage('GameTypeChangedExit'), mbConfirmation, MB_YESNO) = IDYES then
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

procedure CurStepChanged(const CurStep: TSetupStep);
begin
	case CurStep of ssInstall:
		begin			
			DownloadAssets()					

			//Saves any custom selections to components on install.
			if (CompareText(WizardSetupType(false),'custom') = 0) then 
			begin
				while SaveCustomPreset(path) = false do
				begin
					case SuppressibleMsgBox('We encountered an error while trying to save the custom preset...', mbError, MB_ABORTRETRYIGNORE, IDIGNORE) of 
						IDIGNORE: break;
						IDABORT: abort;
					end;
				end
			end;

			//Starts by removing the Read-Only flag if applicable.
			if WizardIsTaskSelected('readonly') then
			begin
				while RemoveReadOnlyRecursive(path) = false do
				begin
					case SuppressibleMsgBox('We encountered an error while trying to remove readonly from your application directory...', mbError, MB_ABORTRETRYIGNORE, IDIGNORE) of 
						IDIGNORE: break;
						IDABORT: abort;
					end;
				end				
			end;
				
			//Will now begin the move old install to backup folder if task was selected.
			if WizardIsTaskSelected('clean/moveold') then
			begin
				//MsgBox('File moving was selected', mbInformation, MB_OK);
				while (DirExists(path + '\OldInstall')) AND (AppendCreationTimeToName(path + '\OldInstall') = false) do
				begin
					case SuppressibleMsgBox('Encountered an issue while attempting to rename OldInstall folder.', mbError, MB_ABORTRETRYIGNORE, IDIGNORE) of 
						IDIGNORE: break;
						IDABORT: abort;
					end; 
				end;

				while MoveOld(path, ['', ExpandConstant('\Sybaris')]) = false do
				begin
					case SuppressibleMsgBox(CustomMessage('MoveOldExcep'), mbError, MB_ABORTRETRYIGNORE, IDIGNORE) of 
						IDIGNORE: break;
						IDABORT: abort;
					end; 
				end;
			end;
				
			if WizardIsTaskSelected('clean/moveold/mods') then
			begin
				//MsgBox('mod moving was chosen', mbInformation, MB_OK);
				//Checks if mod moving was selected and if so will execute that.
				while MoveOldMod(path, ['{#ModDir}']) = false do
				begin
					case SuppressibleMsgBox(CustomMessage('MoveOldModExcep'), mbError, MB_ABORTRETRYIGNORE, IDIGNORE) of 
						IDIGNORE: break;
						IDABORT: abort;
					end;
				end;
			end;//Mod Move		
		end;
	end;//Case
	
	case CurStep of ssPostInstall:
		begin
#if LMMT == false
			HandleSer(path)
#endif
			if WizardIsTaskSelected('clean/moveold/config') then
			begin
				while MoveOldConfigBack(path) = false do
				begin
					case SuppressibleMsgBox('Encountered an issue while attempting to copy your old configs back...', mbError, MB_ABORTRETRYIGNORE, IDIGNORE) of 
						IDIGNORE: break;
						IDABORT: abort;
					end;
				end
			end;

			while (DirExists(path + '\OldInstall')) AND (AppendCreationTimeToName(path + '\OldInstall') = false) do
			begin
				case SuppressibleMsgBox(CustomMessage('CannotRenameOld'), mbError, MB_ABORTRETRYIGNORE, IDIGNORE) of 
					IDIGNORE: break;
					IDABORT: abort;
				end;
			end;

			if WizardIsTaskSelected('readonly') then
			begin
				while RemoveReadOnlyRecursive(path) = false do
				begin
					// Display a message box
					case SuppressibleMsgBox('We encountered an error while trying to remove readonly from your application directory...', mbError, MB_ABORTRETRYIGNORE, IDIGNORE) of 
						IDIGNORE: break;
						IDABORT: abort;
					end;
				end
			end;
			SaveStringToFile(path + '\{#ShortName}.ver','{#MyAppVersion}', False);					
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
		FilePath := ExpandConstant('{tmp}\{#HelperDLL}');
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