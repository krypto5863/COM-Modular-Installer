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

	function IsEng(path: String): Boolean;
	begin
		if (FileExists(path + '\GameData\product.arc')) OR (FileExists(path + '\GameData\language.arc')) then
		begin
			result := true
		end
		else begin
			result := false
		end;
	end;

	procedure DownloadUpdate(MinVer: Integer);
	var
	i : Integer;
	lv : Integer;
	site : String;
	ErrorCode: Integer;
	begin					
		i := MinVer/10+20;

		while (i >= MinVer/10) do
		begin

			//MsgBox('testing: ' + 'http://p2-dl0.kisskiss.tv/com3d2/update/com3d2_up' + IntToStr(i) + '.zip', mbInformation, MB_OK);
			if (SiteValid('http://p2-dl0.kisskiss.tv/com3d2/update/com3d2_up' + IntToStr(i) + '.zip') = true) AND (lv <= 0) then
			begin
				lv := i;
				//MsgBox('Returning update ' + IntToStr(lv) + ' as latest', mbInformation, MB_OK);
			end
			else if (lv > 0) then
			begin
				site :=  'http://p2-dl0.kisskiss.tv/com3d2/update/com3d2_up' + IntToStr(lv) + '.zip';
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
					SuppressibleMsgBox(AddPeriod(GetExceptionMessage), mbCriticalError, MB_OK, IDOK);
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
	
	procedure DownloadAssets();
	var
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
		
	begin
	
	Mnfst := 'manifest.txt'
	Load := 'Loader.casf'
	LoadSite := 'https://github.com/krypto5863/COM-Modular-Installer/raw/master/Assets/Loader.casf'
	Pat := 'Patcher.casf'
	PatSite := 'https://github.com/krypto5863/COM-Modular-Installer/raw/master/Assets/Patchers.casf'
	Plug := 'Plugin.casf'
	PlugSite := 'https://github.com/krypto5863/COM-Modular-Installer/raw/master/Assets/Plugins.casf'
	Misc := 'Misc.casf'
	MiscSite := 'https://github.com/krypto5863/COM-Modular-Installer/raw/master/Assets/Misc.casf'
	
		DownloadPage.Clear();
		
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
		
		//External Assets	
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
				SuppressibleMsgBox(AddPeriod(GetExceptionMessage), mbCriticalError, MB_OK, IDOK);
			end;
		finally
			DownloadPage.Hide;
		end;
		
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
	end;
[/Code]