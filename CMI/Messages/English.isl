; *** Inno Setup version 6.1.0+ English messages ***
;
; To download user-contributed translations of this file, go to:
;   https://jrsoftware.org/files/istrans/
;
; Note: When translating this text, do not add periods (.) to the end of
; messages that didn't have them already, because on those messages Inno
; Setup adds the periods automatically (appending a period would result in
; two periods being displayed).

; %1-%9: These are parameters that are replaced when loaded.
; %n: New line character.
[Messages]

WizardSelectDir=Select Game Location
SelectDirLabel3=Please select your COM3D2 install directory below! Example: C:\KISS\COM3D2
SelectDirDesc=Where is your game located?

[CustomMessages]

;Startup Messages
IsGameCR=Is this version of COM to which we are installing today 1.56 or higher? In other words, is it a CR-Edit version?
GameIsCRWarning=Keep in mind, CR-Edit versions (AKA 1.56+ versions) have diminished mod and plugin support. You may find several plugins are unavailable on these versions that are available on none CR-Edit versions and you may even find bugs that have not yet been corrected by plugin devs. You have been warned!

ScamWarning=If you paid for CMI or downloaded it from anywhere that is not the official GitHub page, than you have been scammed or misled!
StorageSpaceLow=We detected that your AppData containing partition(Typically your C drive) does not have enough free space for cache. Please clear a minimum of 5 GiBs to install CMI. You Have %1MBs
StorageSpaceLow2=The drive holding the path you have selected does not contain enough space to safely install CMI. Please clear a minimum of 5 GiBs to install CMI to this directory: You have %1MBs
OutdatedInstaller=This installer is outdated and likely incompatible with new assets/versions! You may continue the installation but you continue at your own risk!
ReadmeRead=Did you read the readme? Failure to read it will void you any chance of receiving support
ReadmeExit=Go back and read it before installing CMI

EnglishVersionAlert=If you are not on an English version of the game quit the install right now and refer to the readme!!%n%nEnglish version was found!! Be advised, English versions are not as feature full or as supported as the Japanese version!
EnglishVersionCompatibility=Translation plugins and related components can be harmful or incompatible to your English game.%n%nShould we disable these components in order to keep you safe? (Recommended)

CMDetected=This is CM3D2 not COM3D2! CMI was not made for CM3D2! For CM3D2, please use Legacy Meido Modular Toolbox (LMMT)
NotaGameDir=This does not appear to be a COM3d2 Directory! We can still continue the installation but you may be installing to the wrong directory, some functions will also be rendered ineffectual. Do we continue anyways?
ImproperUpdate=We have detected that this game instance was updated improperly!(Usually by a drag and drop process) This is completely unsafe and WILL break your game.%n%nDue to this CMI will not install as you may encounter further errors and bugs if we continue. Please reinstall your game and update CORRECTLY (By placing the update/DLC files in an empty directory and using the provided update.exe or selector.exe) to continue.
IsInDownload=It seems your game is located in the Downloads directory, this can cause issues with UAC and lead to improper CMI installs! Please move it somewhere safer (Example: C:/KISS/COM3D2)
IsInProgramFiles=It seems your game is located in the Program Files directory, this can cause issues with UAC and lead to improper CMI installs! Please move it somewhere safer (Example: C:/KISS/COM3D2)
IsINM=We have detected INM! INM is not supported by CMI due to technical differences.%n%nTo use CMI, please install the R18/Adult Content Supplement Patch.%n%nIf your are not actually on an INM version of the game, then you have likely installed Eng DLC/files into your japanese game. Please refer to the readme on repair instructions.

GameOutdated=Your game is outdated! Please update it immediately.%n%nMinimum Version: %1%n%nFound Version: %2
GameUnsupported=Your game is on a version that is not supported by the current CR selection! Plase restart the installer and select the proper option, in this case being YES, when asked if your game is a CR version!%n%nUnsupported Version:%1 or Newer%n%nFound Version:%2
GameUnsupported1=Your game is on a version that is not supported by the current CR selection! Plase restart the installer and select the proper option, in this case being NO, when asked if your game is a CR version!%n%nSupported Version:%1 or Newer%n%nFound Version:%2

MissingUpdateLst=While this appears to be a game folder, there is no Update.lst file! This is very bad!%n%nPlease update your game immediately and ensure that your game is functioning before attempting to install CMI again.
VersionFetchLoadFail=Could not load strings from %1
VersionFetchNoVersion=While we managed to find the Update.lst file, the line containing: %1 could not be found! If you are on the Japanese version, this is can be a real problem! Please update immediately!
VersionFetchLineCleanFail=Could not clean the line containing the version we need in order to parse... Please update your game and try again. Otherwise, report this to the dev with your update.lst file'
VersionFetchParseFail=An error occurred while parsing the version number... Please update your game and try again. Otherwise, report this to the dev.

UpdatePrompt=Would you like us to try to download the latest update and run the updater? This generally is not recommended, as it can be unstable. You will still need to follow the instructions in the installer that shows up, and this way of updating is not as safe or as reliable as manually updating.%n%nThe update may take a while to download as the download itself can be around 3GBs in size and Kiss servers can be VERY slow so be patient.%n%nPressing no will open the update download website.
UpdateFetchFail=Either you are already on the latest version available to you and you need to wait for a new game update(English Users) or we failed to fetch updates.%n%nIt is recommended you manually update your game instead if you believe that you are not on the latest available version for your game.

DownloadFinish=Performing download finished tasks. Standby...
DownloadWPercent=%1 MBs of %2 MBs done = %3%%
DownloadNoPercent=%1 MBs done
ExtractingCaption=Now extracting %1. Please standby...

EnsureGameClosed=Please ensure no game folders or game instances are open or you will have a bad install!

GameTypeChangedExit=Due to changes made to the installer when disabling components, the installer needs to be restarted in order to revert these changes and allow you to safely use previous pages. Would you like to quit the installer now?

CannotLoadPreset=Failed to load preset file at %1
ConfirmPresetSave=It appears you already have a preset here for your component selections. Should we overwrite it with your current selection? Whatever you selected will still be applied, the selection simply will not be saved for the next time

TypeCompact=Basic Install
TypeFull=Similar to Noctsoul's AIO
TypeEng=Non-Japanese Localizations AIO-Like
TypeNoTr=No Translations AIO-Like
TypePic=I just take pictures
TypeHen=I just play, I don't take pictures
TypeSelf=My Selections
TypeCustom=Okay, make your own choices
TypePreset=Custom Preset
TypeNone=I want nothing!

ModLoader=Mod Loader (Required for just about everything)
BepinEx=BepInEX (Recommended)
Sybaris=Sybaris 2.1 (Not Recommended, JUST DON'T USE IT)
TranslationPlugs=Translation Plugins
ExtraTrans=Extra Translations
IMGUITrans=Plugin Translations
EmoEarsAhoge=Ahoge meshes
EmoEarsMod=Ear and tail meshes
NPRLightConfig=Lightweight Config
PluginExt=PluginExt (Required by a few other plugins. Recommended)
PNGPlaceExtraPNG=More PNGs
MiscFiles=Miscelleanous Files
StudioPoses=1900+ Poses for Studio Mode
AddMoreBG=Add More Game BGs to Photo Mode(And MM)
Uncensor=Uncensored Vanilla Textures
UncensorMale=Male Penis Replacer
ExtraUncensorMale=More Penis Variants
BodyReplacers=Body Replacers
ExternalFiles=External Files
MaidFiddler=Maid Fiddler (Dangerous!)

FixRegistry=Fix Registry Directory
Clean=Cleaning Tasks
CleanGroup=Cleaning tasks to execute before installing
MoveOld=Move old installations to old folder
MoveOldMods=Also move installer installed Mods (This will also move any saved MM poses)
PlaceConfigBack=Place configurations back (Warning! This can overwrite updated configs. Not suggested)
DeleteOld=Delete previous installations (WARNING: VERY DESTRUCTIVE, YOU WILL LOSE ANY SYBARIS OR BEPINEX FOLDERS)
DeleteOldMods=Delete any mods installed by the Installer too(This will delete all of your saved MM Poses too)
DeleteOldInstalls=Delete any old installs aswell
RemoveReadOnly=Remove Read-Only Flag On All Files
RemoveReadOnlyGroup=Many users experience issues thanks to irroneously set Read-Only flags by the system. This tries to fix that, though due to permissions, UAC or other factors, it may not always work. It can always be done manually, however

MoveOldExcep=An exception was tossed while trying to move the old installation to the old folder! Ensure that no game application is open and that none of the files or folders are open anywhere!! We are quitting to keep your data safe! Refer to the readme for troubleshooting steps!!!
MoveOldModExcep=An exception was tossed while trying to move the old mods to the old folder! Ensure that no game application is open and that none of the files or folders are open anywhere!! We are quitting to keep your data safe! Refer to the readme for troubleshooting steps!!!
CannotRenameOld=The OldInstall folder could not be renamed but the installation is already complete. As a result, we will not abort as the error is harmless. It should be automatically renamed the next time CMI is run.

AssetDownloadFailed=We failed to download files for some of the components selected. Please ensure that you are connected to the internet and have a functioning connection before trying again. Otherwise, you can continue the installation, the missing assets simply will not be installed.

SerializePrompt=We noticed you have a file that causes save data to be placed in the user Documents directory (serialize_storage_config.cfg). Normally this is removed, but it does not hurt to leave it. Shall we remove this file and place your savedata back in the game folder?'
SerializeDeleteFail=Failed to delete the file at %1\serialize_storage_config.cfg for an unknown reason!
SerializeCopyFail=Failed to copy the files at %1 for an unknown reason!

MFInstall=Waiting for Maid Fiddler installer to finish... (Users must follow the installer that opens!)

Survey=Open the Feedback Survey for CMI