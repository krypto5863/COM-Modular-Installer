[Code]
	//Calls for function that facilitate version checking from C# DLL
	function VersionCheck(path: WideString; gver: Integer): Integer;
	external 'CMIHelper@files:CMIHelper.dll stdcall delayload';
	//This functions checks if the game is INM or not.
	function INMCheck(path: WideString): Boolean;
	external 'CMIHelperIN@files:CMIHelper.dll stdcall delayload';
	//This function checks for game type, eng or JP.
	function TypeCheck(path: WideString): Boolean;
	external 'CMIHelperT@files:CMIHelper.dll stdcall delayload';
	//This function moves old files into the OldInstall Folder during install
	function MoveOld(path: WideString): Boolean;
	external 'CMIHelperM@files:CMIHelper.dll stdcall delayload';
	//This function moves old mods into the old install folder during install
	function MoveOldMod(path: WideString): Boolean;
	external 'CMIHelperMO@files:CMIHelper.dll stdcall delayload';
	//Renames the oldinstall folder to prevent overwriting on subsequent runs.
	function RenameOldInstall(path: WideString): Boolean;
	external 'CMIHelperOR@files:CMIHelper.dll stdcall delayload';
	//This function removes the read-only flag from all files in the game folder.
	procedure RemoveRO(path: WideString);
	external 'CMIHelperRO@files:CMIHelper.dll stdcall delayload';
	//Try to move config files back
	function ReturnConfig(path: WideString): Boolean;
	external 'CMIHelperRC@files:CMIHelper.dll stdcall delayload';
	//SeralizeConfig Handling
	function HandleSer(path: WideString; dpath: WideString): Boolean;
	external 'CMIHelperHS@files:CMIHelper.dll stdcall delayload';
	//Checks if a url is a valid site that can be reached
	function SiteValid(url: WideString): Boolean;
	external 'CMIHelperWE@files:CMIHelper.dll stdcall delayload';
	//Find File in Preset
	function IsInPreset(path: WideString; entry: WideString; out strout: WideString): Integer;
	external 'CMIHelperPR@files:CMIHelper.dll stdcall delayload';
	//Read manifests and decide if an update for an asset file is in order
	function IsAssetOld(path: WideString; tpath: WideString; file: WideString; version: WideString): Boolean;
	external 'CMIHelperUA@files:CMIHelper.dll stdcall delayload';
	//Read manifests and decide if the installer is outdated or not
	function IsInstallerOld(tpath: WideString; version: WideString): Boolean;
	external 'CMIHelperCI@files:CMIHelper.dll stdcall delayload';
	procedure FetchLRelease(site: WideString; out dlink: WideString);
	external 'CMIHelperFLR@files:CMIHelper.dll stdcall delayload';

	function GameFileExists(DirName: String): Boolean;
	begin
		MsgBox('We are checking if the file exists: ' + DirName , mbInformation, MB_OK);
			Result := FileExists(DirName)
	end;

	function StrSplit(Text: String; Separator: String): TArrayOfString;
	var
		i, p: Integer;
		Dest: TArrayOfString; 
	begin
		i := 0;
		repeat
			SetArrayLength(Dest, i+1);
			p := Pos(Separator,Text);
			if p > 0 then begin
				Dest[i] := Copy(Text, 1, p-1);
				Text := Copy(Text, p + Length(Separator), Length(Text));
				i := i + 1;
			end else begin
				Dest[i] := Text;
				Text := '';
			end;
		until Length(Text)=0;
		Result := Dest
	end;

	procedure ApplyCustomPreset(path: String);
	var
			I: Integer;
			list: TArrayOfString;
			lstring: String;
			outstr: WideString; 
	begin

		lstring := '|'

		for I := 0 to Wizardform.ComponentsList.items.count-1 do
		begin
			lstring := lstring + Wizardform.ComponentsList.ItemCaption[I] + '|'
		end;
		
		if IsInPreset(path + '\' + PresetFile,lstring,outstr) = 0 then
		begin
			exit
		end;

		list := StrSplit(outstr,'|')

		for I := 0 to Length(List)-1 do
		begin
			Wizardform.ComponentsList.Checked[StrToInt(list[I])] := true 
		end;
	end;

	procedure SaveCustomPreset(path: String);
	var
			I: Integer;
	begin
		if (FileExists(path + '\' + PresetFile)) then
		begin
			if (MsgBox('It appears you already have a preset here for your component selections. Should we overwrite it with your current selection? Whatever you selected will still be applied, the selection simply will not be saved for the next time', mbConfirmation, MB_YESNO)) = IDYES then
			begin
				DeleteFile(path + '\' + PresetFile);
			end else begin
				exit;
			end;
		end;

		for I := 0 to Wizardform.ComponentsList.items.count-1 do
		begin
			if Wizardform.ComponentsList.Checked[I] = true then
			begin
				SaveStringToFile(path + '\' + PresetFile,Wizardform.ComponentsList.ItemCaption[I] + #13#10, True);
			end;
		end;
	end;

	function IsEng(path: String): Integer;
	begin
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

	procedure DownloadUpdate(MinVer: Integer);
	var
	i : Integer;
	lv : Integer;
	SiteSt: String;
	site : String;
	ErrorCode: Integer;
	begin
	
	if MsgBox('Would you like us to try to download the latest update and run the updater? You will still need to follow the instructions in the installer that shows up, and this way of updating is not as safe or as reliable as manually updating.' + #13#10#13#10 + 'The update may take a while to download as the download itself can be around 3GBs in size (usually downloads within a few minutes, though may take more depending on your internet connection) so be patient.', mbInformation, MB_YESNO) = MrNO then
	begin				
		exit;
	end;
	
	if (IsEng(WizardForm.DirEdit.Text)) = 1 then
	begin
		MinVer := 1000;
		i := MinVer/10+20
		SiteSt := 'http://7.242.238.202.static.iijgio.jp/com3d2_up'
	end else
	begin
		i := MinVer/10+20;
		SiteST := 'http://p2-dl0.kisskiss.tv/com3d2/update/com3d2_up'
	end;

		while (i >= MinVer/10) do
		begin

			//MsgBox('testing: ' + 'http://p2-dl0.kisskiss.tv/com3d2/update/com3d2_up' + IntToStr(i) + '.zip', mbInformation, MB_OK);
			if (SiteValid(SiteSt + IntToStr(i) + '.zip') = true) AND (lv <= 0) then
			begin
				lv := i;
				//MsgBox('Returning update ' + IntToStr(lv) + ' as latest', mbInformation, MB_OK);
			end
			else if (lv > 0) then
			begin
				site :=  SiteSt + IntToStr(lv) + '.zip';
				break;
			end;
			
		i := i-1;	
		end;

		if (CompareText(site,'') <> 0) AND (lv > 0) then
		begin
			DownloadPage.Clear;
			
			//DownloadPage.Add('http://p2-dl0.kisskiss.tv/com3d2/update/com3d2_up152.zip', 'COMUpdate.zip', '');
			
			//MsgBox('downloading from: ' + site, mbInformation, MB_OK);
			DownloadPage.Add(site, 'COMUpdate.zip', '');
			
			DownloadPage.Show;
			try
				try
					DownloadPage.Download;
				except
					//SuppressibleMsgBox(AddPeriod(GetExceptionMessage), mbCriticalError, MB_OK, IDOK);
				end;
			finally
			
				DoUnZip(ExpandConstant('{tmp}\COMUpdate.zip'),ExpandConstant('{tmp}\COMUpdate'));
			
				shellExec('', ExpandConstant('{tmp}\COMUpdate\com3d2_up'+ IntToStr(lv) +'\update.exe'), '', '', SW_SHOW, ewWaitUntilTerminated, ErrorCode);
			
				DownloadPage.Hide;
			end;
		end
		else begin
		MsgBox('Something went wrong while trying to reach the download site. It is recommended you manually update your game instead.', mbCriticalError, MB_OK)
		end;
	end;

	function ComponentSelected(name: String): Boolean;
	var
		I: Integer;
		res: Boolean; 
	begin

		res := false;

		for I := 0 to Wizardform.ComponentsList.items.count-1 do
		begin
			if Wizardform.ComponentsList.Checked[I] = true then
			begin
				//MsgBox('Component was selected name of: ' + Wizardform.ComponentsList.ItemCaption[I], mbInformation, MB_OK);
				if (CompareText(Wizardform.ComponentsList.ItemCaption[I], name) = 0) then
				begin
					//MsgBox('Component was selected, returning true', mbInformation, MB_OK);
					res := true
					break;
				end
			end;
		end;	
		result := res
	end;
	
	function GetComponentIndex(name: String): Integer;
	var
		I: Integer;
	begin

		for I := 0 to Wizardform.ComponentsList.items.count-1 do
		begin
			//MsgBox('Component was selected name of: ' + Wizardform.ComponentsList.ItemCaption[I], mbInformation, MB_OK);
			if (CompareText(Wizardform.ComponentsList.ItemCaption[I], name) = 0) then
			begin
				//MsgBox('Component was selected, returning true', mbInformation, MB_OK);
				result := I
				exit;
			end
		end;	
		result := -1;
	end;
	
	procedure DownloadAssets();
	
	var
	pre : WideString;
	suf : WideString;
	dlink: WideString;
  (*
		i : Integer;
		Mnfst: String;
		Load: String;
		LoadSite: String;
		Pat: String;
		PatSite: String;
		Plug: String;
		PlugSite: String;
		Misc: String;
		MiscSite: String;
	*)	
	begin
	
	(*	
	Mnfst := 'manifest.txt'
	Load := 'Loader.casf'
	LoadSite := 'https://github.com/krypto5863/COM-Modular-Installer/raw/master/Assets/Loader.casf'
	Pat := 'Patcher.casf'
	PatSite := 'https://github.com/krypto5863/COM-Modular-Installer/raw/master/Assets/Patchers.casf'
	Plug := 'Plugin.casf'
	PlugSite := 'https://github.com/krypto5863/COM-Modular-Installer/raw/master/Assets/Plugins.casf'
	Misc := 'Misc.casf'
	MiscSite := 'https://github.com/krypto5863/COM-Modular-Installer/raw/master/Assets/Misc.casf'
	*)
	
	
		DownloadPage.Clear();
		
		(*		
		if (FileExists(ExpandConstant('{src}\' + Mnfst)))then
			begin
			//Primary Assets			
			if (FileExists(ExpandConstant('{src}\' + Load))) then
			begin			
				if (IsAssetOld(ExpandConstant('{src}'),ExpandConstant('{tmp}'),'Loader','null')) then
				begin
					DeleteFile(ExpandConstant('{src}\' + Load))
					DownloadPage.Add(LoadSite, Load, '');
				end			
			end
			else
			begin
				DownloadPage.Add(LoadSite, Load, '');
			end;
			
			if (FileExists(ExpandConstant('{src}\' + Pat))) then
			begin			
				if (IsAssetOld(ExpandConstant('{src}'),ExpandConstant('{tmp}'),'Patcher','null')) then
				begin
					DeleteFile(ExpandConstant('{src}\' + Pat))
					DownloadPage.Add(PatSite, Pat, '');
				end			
			end
			else
			begin
				DownloadPage.Add(PatSite, Pat, '');
			end;
			
			if (FileExists(ExpandConstant('{src}\' + Plug))) then
			begin			
				if (IsAssetOld(ExpandConstant('{src}'),ExpandConstant('{tmp}'),'Plugin','null')) then
				begin
					DeleteFile(ExpandConstant('{src}\' + Plug))
					DownloadPage.Add(PlugSite, Plug, '');
				end			
			end
			else
			begin
				DownloadPage.Add(PlugSite, Plug, '');
			end;
			
			if (FileExists(ExpandConstant('{src}\' + Misc))) then
			begin			
				if (IsAssetOld(ExpandConstant('{src}'),ExpandConstant('{tmp}'),'Misc','null')) then
				begin
					DeleteFile(ExpandConstant('{src}\' + Misc))
					DownloadPage.Add(MiscSite, Misc, '');
				end			
			end
			else
			begin
				DownloadPage.Add(MiscSite, Misc, '');
			end;
		end 
		else
		begin
			DeleteFile(ExpandConstant('{src}\' + Load))
			DownloadPage.Add(LoadSite, Load, '');
			
			DeleteFile(ExpandConstant('{src}\' + Pat))
			DownloadPage.Add(PatSite, Pat, '');
			
			DeleteFile(ExpandConstant('{src}\' + Plug))
			DownloadPage.Add(PlugSite, Plug, '');
			
			DeleteFile(ExpandConstant('{src}\' + Misc))
			DownloadPage.Add(MiscSite, Misc, '');
		end;
		*)
		
		//External Assets
		
		pre := 'https://api.github.com/repos/'
		suf := '/releases/latest'
		
	//These links are all version specific and an attempt is made to fetch them dynamically.	
		if (ComponentSelected('ConfigurationManager')) then
		begin		
			FetchLRelease(pre + 'BepInEx/BepInEx.ConfigurationManager' + suf, dlink);
		
			DownloadPage.Add(dlink, 'ConfigManager.zip', '');
		end;
		
		if (ComponentSelected('FPSCounter')) then
		begin
			FetchLRelease(pre + 'ManlyMarco/FPSCounter' + suf, dlink);
		
			DownloadPage.Add(dlink, 'FPSCounter.zip', '');
		end;
		
		//These have more conditions and require version specific links and care.
		(*
		if (ComponentSelected('RuntimeUnityEditor')) then
		begin
			DownloadPage.Add('https://github.com/ManlyMarco/RuntimeUnityEditor/releases/download/v2.2.1/RuntimeUnityEditor_BepInEx5_v2.2.1.zip', 'RuntimeUnityEditor.zip', '');
		end;
		
		if (ComponentSelected('MuteInBackground')) then
		begin
			DownloadPage.Add('https://github.com/BepInEx/BepInEx.Utility/releases/download/r5/BepInEx.MuteInBackground.v1.1.zip', 'MuteInBackground.zip', '');
		end;
		*)
		
		if (ComponentSelected('InputHotkeyBlock')) then
		begin
			DownloadPage.Add('https://github.com/DeathWeasel1337/COM3D2_Plugins/releases/download/v2/COM3D2.InputHotkeyBlock.v1.1.zip', 'InputHotkeyBlock.zip', '');
		end;
		
		if (ComponentSelected('FixEyeMov')) then
		begin
			DownloadPage.Add('https://github.com/01010101lzy/gettapped/releases/download/fixeyemov-0.1.1/FixEyeMov.com3d2-0.1.1.zip', 'FixEyeMov.zip', '');
		end;
	
	//These are latest releases and require no looking after
	
	 	if (ComponentSelected('GraphicsSettings')) then
		begin
			DownloadPage.Add('https://github.com/BepInEx/BepInEx.GraphicsSettings/releases/latest/download/GraphicsSettings.dll', 'GraphicsSettings.dll', '');
		end;
			
		if (ComponentSelected('DLC Checker (Kry Fork)')) then
		begin
			DownloadPage.Add('https://github.com/krypto5863/COM3D2_DLC_Checker/releases/latest/download/COM3D2_DLC_Checker.exe', 'COM3D2 DlC Checker.exe', '');
		end;
		
		if (ComponentSelected('Maid Fiddler (Dangerous!)')) then
		begin
			DownloadPage.Add('https://github.com/denikson/COM3D2.MaidFiddler/releases/latest/download/MaidFiddlerSetup.exe', 'MFInstall.exe', '');
		end;
		
		DownloadPage.Show;
		try
			try
				DownloadPage.Download;
			except
				MsgBox('We failed to download files for some of the components selected. Please ensure that you are connected to the internet and have a functioning connection before trying again. Otherwise, you can continue the installation, the missing assets simply will not be installed.' , mbInformation, MB_OK);
				//SuppressibleMsgBox(AddPeriod(GetExceptionMessage), mbCriticalError, MB_OK, IDOK);
			end;
		finally
			DownloadPage.Hide;
		end;
		
		if FileExists(ExpandConstant('{tmp}') + '\InputHotkeyBlock.zip')then
		begin
			DoUnzip(ExpandConstant('{tmp}') + '\InputHotkeyBlock.zip', ExpandConstant('{tmp}'))
		end;
		
		if FileExists(ExpandConstant('{tmp}') + '\ConfigManager.zip')then
		begin
			DoUnzip(ExpandConstant('{tmp}') + '\ConfigManager.zip', ExpandConstant('{tmp}'))
		end;
		
		if FileExists(ExpandConstant('{tmp}') + '\FixEyeMov.zip')then
		begin
			DoUnzip(ExpandConstant('{tmp}') + '\FixEyeMov.zip', ExpandConstant('{tmp}'))
		end;
		
		if FileExists(ExpandConstant('{tmp}') + '\FPSCounter.zip')then
		begin
			DoUnzip(ExpandConstant('{tmp}') + '\FPSCounter.zip', ExpandConstant('{tmp}'))
		end;
		
		(*
		if FileExists(ExpandConstant('{tmp}') + '\RuntimeUnityEditor.zip')then
		begin
			DoUnzip(ExpandConstant('{tmp}') + '\RuntimeUnityEditor.zip', ExpandConstant('{tmp}'))
		end;
		*)
		
		(*
		if FileExists(ExpandConstant('{tmp}') + '\MuteInBackground.zip')then
		begin
			DoUnzip(ExpandConstant('{tmp}') + '\MuteInBackground.zip', ExpandConstant('{tmp}'))
		end;
		*)
		
		(*		
		if (FileExists(ExpandConstant('{src}\' + Mnfst)) = false) AND (FileExists(ExpandConstant('{tmp}\' + Mnfst))) then
		begin
			FileCopy(ExpandConstant('{tmp}\' + Mnfst),ExpandConstant('{src}\' + Mnfst), False)
		end;
		
		if (FileExists(ExpandConstant('{src}\' + Load)) = false) AND (FileExists(ExpandConstant('{tmp}\' + Load))) then
		begin
			FileCopy(ExpandConstant('{tmp}\' + Load),ExpandConstant('{src}\' + Load), False)
		end;
		
		if (FileExists(ExpandConstant('{src}\' + Pat)) = false) AND (FileExists(ExpandConstant('{tmp}\' + Pat))) then
		begin
			FileCopy(ExpandConstant('{tmp}\' + Pat),ExpandConstant('{src}\' + Pat), False)
		end;
		
		if (FileExists(ExpandConstant('{src}\' + Plug)) = false) AND (FileExists(ExpandConstant('{tmp}\' + Plug))) then
		begin
			FileCopy(ExpandConstant('{tmp}\' + Plug),ExpandConstant('{src}\' + Plug), False)
		end;
		
		if (FileExists(ExpandConstant('{src}\' + Misc)) = false) AND (FileExists(ExpandConstant('{tmp}\' + Misc))) then
		begin
			FileCopy(ExpandConstant('{tmp}\' + Misc),ExpandConstant('{src}\' + Misc), False)
		end;

//Extract asset files for usage.		
		if (FileExists(ExpandConstant('{src}\' + Load))) then
		begin
			DoUnzip(ExpandConstant('{src}\' + Load),ExpandConstant('{tmp}'))
		end;
		
		if (FileExists(ExpandConstant('{src}\' + Pat))) then
		begin
			DoUnzip(ExpandConstant('{src}\' + Pat),ExpandConstant('{tmp}'))
		end;
		
		if (FileExists(ExpandConstant('{src}\' + Plug))) then
		begin
			DoUnzip(ExpandConstant('{src}\' + Plug),ExpandConstant('{tmp}'))
		end;
		
		if (FileExists(ExpandConstant('{src}\' + Misc))) then
		begin
			DoUnzip(ExpandConstant('{src}\' + Misc),ExpandConstant('{tmp}'))
		end;
		*)
	end;
[/Code]