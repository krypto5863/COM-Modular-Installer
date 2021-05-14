[Code]
	procedure InitializeWizard();
  var
		Value: String;
		ErrorCode: Integer;
		FreeSpace, TotalSpace: Cardinal;
  begin

  	OGEvent :=  WizardForm.TypesCombo.OnChange;
		WizardForm.TypesCombo.OnChange := @TypesComboChange;
		PresetFile := 'Custom.CMIType';
		
		if (GetSpaceOnDisk(ExpandConstant('{tmp}'),True, FreeSpace, TotalSpace)) AND (FreeSpace < 5000) then
		begin
      MsgBox('We detected that your AppData containing partition(Typically your C drive) does not have enough free space for cache. Please clear a minimum of 5 GiBs to install CMI: '  + IntToStr(FreeSpace) + 'MB', mbCriticalError, MB_OK)
      abort
		end;
    
    DownloadPage := CreateDownloadPage(SetupMessage(msgWizardPreparing), SetupMessage(msgPreparingDesc), @OnDownloadProgress);

 		if (SiteValid('https://raw.githubusercontent.com/krypto5863/COM-Modular-Installer/master/Assets/manifest.txt')) then
		begin
		DownloadTemporaryFile('https://raw.githubusercontent.com/krypto5863/COM-Modular-Installer/master/Assets/manifest.txt','manifest.txt','',nil);
		end;
		
		if (IsInstallerOld(ExpandConstant('{tmp}'),'{#MyAppVersion}')) then
		begin
			MsgBox('This installer is outdated and likely incompatible with new assets/versions! You may continue the download but you continue at your own risk!' , mbCriticalError, MB_OK);
		end;  
		
		MsgBox('If you paid for CMI or downloaded it from anywhere that is not the official GitHub page, than you have been scammed or misled!' , mbInformation, MB_OK);

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
[/Code]