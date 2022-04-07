//The following script file has a rather large function for using 7zip to unzip files via the installer. It was moved to a seperate script to make things easier.

[Code]
type
  AssetRecord = record
    Name: string;
    Link: string;
    Output: string;
    File: string;
    FetchL: Boolean;
    SearchString: string;
    Version: string;
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

procedure AddToListOfAssets(var ListOfAssets: TListOfAssets; const Name: String; const Link: String; const Output: String; const File: String; const FetchL: Boolean; const SearchString: String; const Version: String);
var
  I: Integer;
begin
  SetArrayLength(ListOfAssets, GetArrayLength(ListOfAssets) + 1)

  ListOfAssets[GetArrayLength(ListOfAssets) - 1].Name := Name;
  ListOfAssets[GetArrayLength(ListOfAssets) - 1].Link := Link;
  ListOfAssets[GetArrayLength(ListOfAssets) - 1].Output := Output;
  ListOfAssets[GetArrayLength(ListOfAssets) - 1].File := File;
  ListOfAssets[GetArrayLength(ListOfAssets) - 1].FetchL := FetchL;
  ListOfAssets[GetArrayLength(ListOfAssets) - 1].SearchString := SearchString;
  ListOfAssets[GetArrayLength(ListOfAssets) - 1].Version := Version;
end;

procedure DownloadAssets();
var
  pre : WideString;
	suf : WideString;
	dlink: WideString;
  links: TListOfAssets;
  I: integer;
  downloadDone: boolean;
begin
	DownloadPage.Clear();
  //These have more conditions and require version specific links and care.
  AddToListOfAssets(links , 'Loader/bepinEX/MuteBack', 'BepInEx/BepInEx.Utility', '' ,'MuteInBackground.zip', true, 'MuteInBackground', '');
  AddToListOfAssets(links , 'Loader/bepinEX/RunUniEdit', 'ManlyMarco/RuntimeUnityEditor', '' ,'RuntimeUnityEditor.zip', true, 'RuntimeUnityEditor', '');
	AddToListOfAssets(links , 'Loader/bepinEX/OptIMGUI', 'BepInEx/BepInEx.Utility', '' ,'BepInEx.OptimizeIMGUI.v1.0.zip', true, 'OptimizeIMGUI', '');
#if LMMT == false
	AddToListOfAssets(links , 'Loader/bepinEX/COM3D2API', 'DeathWeasel1337/COM3D2_Plugins', '' ,'COM3D2.API.v1.0.zip', true, 'COM3D2.API', '');
	AddToListOfAssets(links , 'Loader/bepinEX/CM3D2Toolkit', 'JustAGuest4168/CM3D2.Toolkit', 'BepInEx\plugins\' ,'CM3D2.Toolkit.Guest4168Branch.dll', true, 'CM3D2.Toolkit', '');
	AddToListOfAssets(links , 'Loader/bepinEX/InBlock', 'DeathWeasel1337/COM3D2_Plugins', '' ,'InputHotkeyBlock.zip', true, 'InputHotkeyBlock', '');
  AddToListOfAssets(links , 'Loader/bepinEX/FixEyeMov', '01010101lzy/gettapped/releases', '' ,'FixEyeMov.zip', true, 'FixEyeMov', '');
  //These can be fetched straight from the latest releases.
  AddToListOfAssets(links , 'Loader/bepinEX/addyot', 'Vin-meido/COM3D2.AddYotogiSliderSE.Plugin', '' ,'COM3D2.AddYotogiSliderSE2.Plugin.zip', false, 'COM3D2.AddYotogiSliderSE2.Plugin.zip', '');
  AddToListOfAssets(links , 'Loader/bepinEX/autosave', 'Pain-Brioche/COM3D2.AutoSave', 'BepInEx\plugins\' ,'COM3D2.AutoSave.dll', false, '', '');
  AddToListOfAssets(links , 'Loader/bepinEX/ConfigMan', 'BepInEx/BepInEx.ConfigurationManager', '' ,'ConfigManager.zip', false, '', '');
  AddToListOfAssets(links , 'Loader/bepinEX/FPSCount', 'ManlyMarco/FPSCounter', '' ,'FPSCounter.zip', false, '', '');
	AddToListOfAssets(links , 'Loader/bepinEX/ShiftClick', 'krypto5863/COM3D2.ShiftClickExplorer', 'BepInEx\plugins\' ,'COM3D2.ShiftClickExplorer.dll', false, '', '');
  AddToListOfAssets(links , 'Loader/bepinEX/COM3D2API/ShapekeyMaster', 'krypto5863/COM3D2.ShapekeyMaster', 'BepInEx\plugins\' ,'COM3D2.ShapekeyMaster.Plugin.dll', false, '', '');
  AddToListOfAssets(links , 'Loader/bepinEX/ShortMenu', 'krypto5863/COM3D2.ShortMenuLoader', '' ,'ShortMenuLoader.zip', false, '', '');
	AddToListOfAssets(links , 'Loader/bepinEX/CM3D2Toolkit/ShortVanilla', 'krypto5863/COM3D2.ShortMenuVanillaDatabase', '' ,'ShortMenuVanillaDatabase.zip', false, '', '');
	AddToListOfAssets(links , 'Loader/bepinEX/ExErrorHandle', 'krypto5863/COM3D2.ExtendedErrorHandling', 'BepInEx\plugins\' ,'COM3D2.ExtendedErrorHandling.dll', false, '', '');
	AddToListOfAssets(links , 'Loader/bepinEX/ExPresetMan', 'krypto5863/COM3D2.ExtendedPresetManagement', 'BepInEx\plugins\' ,'COM3D2.ExtendedPresetManagement.dll', false, '', '');
  AddToListOfAssets(links , 'Loader/bepinEX/UndressUtil', 'Vin-meido/COM3D2.UndressUtil', '' ,'COM3D2.UndressUtil.zip', false, 'COM3D2.UndressUtil.zip', '');
  AddToListOfAssets(links , 'ext/dlccheck', 'krypto5863/COM3D2_DLC_Checker', '' ,'COM3D2 DLC Checker.exe', false, '', '');
  AddToListOfAssets(links , 'ext/maidfiddle', 'denikson/COM3D2.MaidFiddler', '' ,'MFInstall.exe', false, '', '');

	
	if IsCR then
	begin
		AddToListOfAssets(links , 'Loader/bepinEX/AdvMatMod', 'krypto5863/COM3d2-AdvancedMaterialModifier', 'BepInEx\plugins\' ,'COM3D2.AdvancedMaterialModifier.Plugin.dll', true, '', '1.1.3');
	end else
		AddToListOfAssets(links , 'Loader/bepinEX/AdvMatMod', 'krypto5863/COM3d2-AdvancedMaterialModifier', 'BepInEx\plugins\' ,'COM3D2.AdvancedMaterialModifier.Plugin.dll', false, '', '');
	begin
	end;
#endif

  for  i := 0 to GetArrayLength(links) - 1 do
  begin
    if (WizardIsComponentSelected(links[i].Name)) then
    begin
      
      if (links[i].FetchL) then
      begin   
        FetchDRelease(links[i].Link, links[i].SearchString, links[i].Version, dlink);
      end 
      else
      begin
        FetchDRelease(links[i].Link, links[i].SearchString, '' , dlink);
      end;
		
      DownloadPage.Add(dlink, links[i].Output + links[i].File, '');
    end;
  end;
	
  DownloadPage.Show;

  while downloadDone = false do
  begin
    try
      try
        DownloadPage.Download;
        DownloadDone := true
      except
        if SuppressibleMsgBox(CustomMessage('AssetDownloadFailed'), mbError, MB_YESNO, IDNO) = IDNO then
        begin
          DownloadDone := true
        end
        else
        begin
          DownloadDone := false
        end
      end;
    finally
      DownloadPage.Hide;
    end
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