//The following script file has a rather large function for using 7zip to unzip files via the installer. It was moved to a seperate script to make things easier.
#include "unzip.iss"

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
  AddToListOfAssets(links , 'ConfigurationManager', pre + 'BepInEx/BepInEx.ConfigurationManager' + suf, '' ,'ConfigManager.zip', true);
  AddToListOfAssets(links , 'FPSCounter', pre + 'ManlyMarco/FPSCounter' + suf, '' ,'FPSCounter.zip', true);
  //These have more conditions and require version specific links and care.
  AddToListOfAssets(links , 'AdvancedMaterialModifier', 'https://github.com/krypto5863/COM3d2-AdvancedMaterialModifier/releases/download/1.2.2.1/COM3D2.AdvancedMaterialModifier.Plugin.dll', 'BepInEx\plugins\' ,'COM3D2.AdvancedMaterialModifier.Plugin.dll', false);
  AddToListOfAssets(links , 'FixEyeMov', 'https://github.com/01010101lzy/gettapped/releases/download/fixeyemov-0.2.0-alpha.3/FixEyeMov.com3d2-v0.2.0-alpha.3.zip', '' ,'FixEyeMov.zip', false);
  AddToListOfAssets(links , 'InputHotkeyBlock', 'https://github.com/DeathWeasel1337/COM3D2_Plugins/releases/download/v5/COM3D2.InputHotkeyBlock.v1.2.zip', '' ,'InputHotkeyBlock.zip', false);
  AddToListOfAssets(links , 'MuteInBackground', 'https://github.com/BepInEx/BepInEx.Utility/releases/download/r6/BepInEx.MuteInBackground.v1.1.zip', '' ,'MuteInBackground.zip', false);
  AddToListOfAssets(links , 'RuntimeUnityEditor', 'https://github.com/ManlyMarco/RuntimeUnityEditor/releases/download/v2.4/RuntimeUnityEditor_BepInEx5_v2.4.zip', '' ,'RuntimeUnityEditor.zip', false);
  //These can be fetched straight from the latest releases.
  AddToListOfAssets(links , 'ExtendedPresetManagement', 'https://github.com/krypto5863/COM3D2.ExtendedPresetManagement/releases/latest/download/COM3D2.ExtendedPresetManagement.dll', 'BepInEx\plugins\' ,'COM3D2.ExtendedPresetManagement.dll', false);
  AddToListOfAssets(links , 'ShortMenuLoader', 'https://github.com/krypto5863/COM3D2.ShortMenuLoader/releases/latest/download/ShortMenuLoader.zip', '' ,'ShortMenuLoader.zip', false);
  AddToListOfAssets(links , 'DLC Checker (Kry Fork)', 'https://github.com/krypto5863/COM3D2_DLC_Checker/releases/latest/download/COM3D2_DLC_Checker.exe', '' ,'COM3D2 DLC Checker.exe', false);
  AddToListOfAssets(links , 'Maid Fiddler (Dangerous!)', 'https://github.com/denikson/COM3D2.MaidFiddler/releases/latest/download/MaidFiddlerSetup.exe', '' ,'MFInstall.exe', false);

  for  i := 0 to GetArrayLength(links) - 1 do
  begin
    if (ComponentSelected(links[i].Name)) then
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
			MsgBox('We failed to download files for some of the components selected. Please ensure that you are connected to the internet and have a functioning connection before trying again. Otherwise, you can continue the installation, the missing assets simply will not be installed.' , mbInformation, MB_OK);
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