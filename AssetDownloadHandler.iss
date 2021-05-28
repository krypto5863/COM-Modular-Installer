//The following script file has a rather large function for using 7zip to unzip files via the installer. It was moved to a seperate script to make things easier.

[Code]
type
  AssetRecord = record
    Name: string;
    Link: string;
    Output: string;
    File: string;
    FetchL: Boolean;
end;

TListOfAssets = array of AssetRecord;

function TryGetAssetIndexByName(const ListOfAssets: TListOfAssets; const Name: string; out Value: integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to GetArrayLength(ListOfAssets) - 1 do
    if ListOfAssets[I].Name = Name then
    begin
      Result := True;
      Value := I;
      Exit;
    end;
end;

procedure AddToListOfAssets(var ListOfAssets: TListOfAssets; const Name: String; const Link: String; const Output: String; const File: String; const FetchL: Boolean);
var
  I: Integer;
begin
  SetArrayLength(ListOfAssets, GetArrayLength(ListOfAssets) + 1)

  ListOfAssets[GetArrayLength(ListOfAssets) - 1].Name := Name;
  ListOfAssets[GetArrayLength(ListOfAssets) - 1].Link := Link;
  ListOfAssets[GetArrayLength(ListOfAssets) - 1].Output := Output;
  ListOfAssets[GetArrayLength(ListOfAssets) - 1].File := File;
  ListOfAssets[GetArrayLength(ListOfAssets) - 1].FetchL := FetchL;
end;

procedure DownloadAssets();
var
  pre : WideString;
	suf : WideString;
	dlink: WideString;
  links: TListOfAssets;
  I: integer; 
begin
	DownloadPage.Clear();
		
	pre := 'https://api.github.com/repos/'
	suf := '/releases/latest'
  
	 
  //These links are all version specific and an attempt is made to fetch them dynamically.
  AddToListOfAssets(links , 'Loader/bepinEX/ConfigMan', pre + 'BepInEx/BepInEx.ConfigurationManager' + suf, '' ,'ConfigManager.zip', true);
  AddToListOfAssets(links , 'Loader/bepinEX/FPSCount', pre + 'ManlyMarco/FPSCounter' + suf, '' ,'FPSCounter.zip', true);
  //These have more conditions and require version specific links and care.
  AddToListOfAssets(links , 'Loader/bepinEX/MuteBack', 'https://github.com/BepInEx/BepInEx.Utility/releases/download/r6/BepInEx.MuteInBackground.v1.1.zip', '' ,'MuteInBackground.zip', false);
  AddToListOfAssets(links , 'Loader/bepinEX/RunUniEdit', 'https://github.com/ManlyMarco/RuntimeUnityEditor/releases/download/v2.4/RuntimeUnityEditor_BepInEx5_v2.4.zip', '' ,'RuntimeUnityEditor.zip', false);
#if LMMT == false
	AddToListOfAssets(links , 'Loader/bepinEX/InBlock', 'https://github.com/DeathWeasel1337/COM3D2_Plugins/releases/download/v5/COM3D2.InputHotkeyBlock.v1.2.zip', '' ,'InputHotkeyBlock.zip', false);
  AddToListOfAssets(links , 'Loader/bepinEX/FixEyeMov', 'https://github.com/01010101lzy/gettapped/releases/download/fixeyemov-0.2.0-alpha.3/FixEyeMov.com3d2-v0.2.0-alpha.3.zip', '' ,'FixEyeMov.zip', false);
  //These can be fetched straight from the latest releases.
  AddToListOfAssets(links , 'Loader/bepinEX/ExPresetMan', 'https://github.com/krypto5863/COM3D2.ExtendedPresetManagement/releases/latest/download/COM3D2.ExtendedPresetManagement.dll', 'BepInEx\plugins\' ,'COM3D2.ExtendedPresetManagement.dll', false);
  AddToListOfAssets(links , 'Loader/bepinEX/ShortMenu', 'https://github.com/krypto5863/COM3D2.ShortMenuLoader/releases/latest/download/ShortMenuLoader.zip', '' ,'ShortMenuLoader.zip', false);
  AddToListOfAssets(links , 'ext/dlccheck', 'https://github.com/krypto5863/COM3D2_DLC_Checker/releases/latest/download/COM3D2_DLC_Checker.exe', '' ,'COM3D2 DLC Checker.exe', false);
  AddToListOfAssets(links , 'ext/maidfiddle', 'https://github.com/denikson/COM3D2.MaidFiddler/releases/latest/download/MaidFiddlerSetup.exe', '' ,'MFInstall.exe', false);
	
	if IsCR then
	begin
		AddToListOfAssets(links , 'Loader/bepinEX/AdvMatMod', 'https://github.com/krypto5863/COM3d2-AdvancedMaterialModifier/releases/download/1.1.3/COM3D2.AdvancedMaterialModifier.Plugin.dll', 'BepInEx\plugins\' ,'COM3D2.AdvancedMaterialModifier.Plugin.dll', false);
	end else
		AddToListOfAssets(links , 'Loader/bepinEX/AdvMatMod', 'https://github.com/krypto5863/COM3d2-AdvancedMaterialModifier/releases/download/1.2.2.1/COM3D2.AdvancedMaterialModifier.Plugin.dll', 'BepInEx\plugins\' ,'COM3D2.AdvancedMaterialModifier.Plugin.dll', false);
	begin
	end;
#endif

  for  i := 0 to GetArrayLength(links) - 1 do
  begin
    if (WizardIsComponentSelected(links[i].Name)) then
    begin
      
      if (links[i].FetchL) then
      begin   
        FetchLRelease(links[i].Link, dlink);
      end 
      else
      begin
        dlink := links[i].Link
      end;
		
      DownloadPage.Add(dlink, links[i].Output + links[i].File, '');
    end;
  end;
	
  DownloadPage.Show;
	try
		try
			DownloadPage.Download;
		except
			MsgBox(CustomMessage('AssetDownloadFailed'), mbInformation, MB_OK);
			//SuppressibleMsgBox(AddPeriod(GetExceptionMessage), mbCriticalError, MB_OK, IDOK);
		end;
	finally
		DownloadPage.Hide;
	end;

  for  i := 0 to GetArrayLength(links) - 1 do
  begin
    if (StringContains(links[i].File, '.zip')) AND (FileExists(ExpandConstant('{tmp}\') + links[i].File)) then
    begin
      DoUnzip(ExpandConstant('{tmp}\') + links[i].File, ExpandConstant('{tmp}'))
    end;
  end;
end;
[/Code]