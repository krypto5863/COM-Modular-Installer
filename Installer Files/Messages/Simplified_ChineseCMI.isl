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

WizardSelectDir=请选择游戏位置
SelectDirLabel3=请在下面选择你COM3D2的安装地址! 例如: C:\KISS\COM3D2
SelectDirDesc=你的游戏安装位置在哪?

[CustomMessages]

;Startup Messages
IsGameCR=你正在尝试安装CMI的游戏本体版本是 3.X 或更高版本吗？ 换而言之，它是支持联动CR (KCES-以下统称CR) 版本的游戏吗？%n%n 需要注意的是，英文版游戏不支持CR（也就是没有3.X版本），并且CMI与1.09 及以下的COM3D2版本不兼容。

GameIsCRWarning=请注意，如果你的游戏版本是COM3D2.5（指的是可以联动CR，游戏版本号是3.X），那么它并不能完全支持所有COM3D2的MOD或插件。你可能发现在COM3D2版本上可用的插件在COM3D2.5上不可用，甚至还会遇到插件开发者尚未纠正的错误。 请悉知！

ScamWarning=如果你为下载 CMI 的安装程序付了钱，或者从任何非官方 GitHub 的渠道下载了它，那么此安装副本非常有可能携带病毒，并且你很可能已经成为盗版软件的受害者，请及时拨打110报警或12315进行维权。

StorageSpaceLow=检测到此计算机包含AppData的分区（通常在计算机的C盘）没有足够的可用空间进行缓存。为了能正常安装请至少留出 5 GB 的可用空间用来安装 CMI！目前AppData所在分区的可用空间为 %1MB。

StorageSpaceLow2=你所选择安装CMI的硬盘分区没有足够的空间来安装 CMI。 请至少留出 5 GB 的可用空间以便将 CMI 安装到此目录！目前你的分区剩余 %1MB。

OutdatedInstaller=这个安装程序已过时，它可能与你目前的游戏不兼容！ 你可以继续安装，但是风险自负！

ReadmeRead=安装前请先阅读说明文档！事实上，已经有中文版的说明文档，你并不会因为看不懂英文而无从下手。如果不读它，你可能会遗漏掉很多有用的信息，按“否”结束安装并打开说明文档。注：说明文档中有可能遇到的问题的解决办法，以及安装插件列表中各个插件的作用和来源。列表中很多插件是没有办法仅凭插件名称就能知道它是做什么的。

ReadmeExit=所以请先阅读说明文档然后再进行安装CMI，支持文档将会在你点击之后打开。

EnglishVersionAlert=发现你选择安装CMI的游戏本体是COM3D2英文版！作为提示，英文版COM3D2没有日文版功能全面，建议换用日文版游戏进行游玩！%n%n 如果你正准备要安装CMI的游戏不是英文版本的话请立刻退出安装程序并阅读说明文档！

EnglishVersionCompatibility=自动翻译插件和其相关组件可能与你的英文版游戏不兼容。%n%n是否禁用这些组件以保证你的英文版游戏不受影响？（推荐！）

CRVersionAlert=发现你选择安装CMI的游戏本体是COM3D2.5 （可以联动CR）的版本！ 请注意，CMI对于COM3D2.5版本的支持度不像标准版本（COM3D2）那样完整！那些可能会导致游戏无法正常运行的组件将被禁用！%n%n如果你正准备安装CMI的游戏不是 COM3D2.5 （可以联动CR）的版本的话请立刻退出安装程序并阅读安装说明！

CMDetected=发现你选择安装CMI的目录是 CM3D2 的游戏目录而不是 COM3D2的游戏目录！ CMI 不兼容 CM3D2！对于 CM3D2，请你使用 Legacy Meido Modular Toolbox (LMMT)来获得插件支持。

NotaGameDir=在你选择安装CMI的目录中没有发现任何版本的COM3D2游戏！ 但你依旧可以选择继续安装，这样做可能会导致CMI安装到错误的目录，同时插件可能并不会生效。 你确定要继续安装吗？

ImproperUpdate=检测到你的游戏更新方式不正确！（通常是简单的“复制/粘贴” 更新文件到游戏目录的行为造成的这种问题）这样的升级方式非常不不规范，这会导致你的游戏无法正常运行！%n%n鉴于此， CMI 的安装进程将立刻终止，因为如果继续安装，你以后将会遇到更多的错误。请使用正确的方法重新安装你的游戏并正确安装更新后（将“更新”或“DLC”解压到一个空目录中并使用官方提供的 update.exe 或 selector.exe进行安装）再安装CMI。

IsInDownload=你的游戏似乎位于Windows默认的'下载'目录中，这会让UAC出现问题并导致 CMI 安装不正确！ 请把你的游戏移动到其他目录（例如：C:/KISS/COM3D2）

IsInProgramFiles=你的游戏似乎位于Program Files目录中，这会让UAC出现问题并导致 CMI 安装不正确！ 请把你的游戏移动到其他目录（例如：C:/KISS/COM3D2）

IsINM=发现你选择安装CMI的游戏本体是INM版本！（COM3D2的非R18发行版 It's a Night Magic 简称INM版）由于INM版的技术差异，CMI 不支持INM版游戏。%n%n如果你要使用 CMI，请给你的INM游戏安装 R18/成人内容补充补丁。%n%n如果你正准备安装CMI的游戏不是INM版，那么你可能将英文版的DLC安装到了你的日文版游戏中，请参阅说明文档中有关修复游戏的部分。

GameOutdated=你的游戏版本过旧,请升级你的游戏.%n%n最低版本需求: %1%n%n你的游戏版本: %2

GameUpdateNotSupported=无法通过安装程序更新游戏的CR（KCES）部分，因为它需要额外的步骤。请手动更新您的游戏。

MissingUpdateLst=虽然这是游戏本体的目录，但游戏目录没有找到 Update.lst 文件！这是一个严重的问题！%n%n请你立即更新游戏并确保其正常运行后，再尝试重新安装 CMI。

VersionFetchLoadFail=无法从 %1 读取字符串！

VersionFetchNoVersion=虽然我们找到了 Update.lst 文件，但找不到包含：%1 的行！ 如果您使用的是日文版，这是一个严重的问题！ 请立即更新你的游戏！

VersionFetchLineCleanFail=无法读取update.lst中关于游戏版本的信息...请更新你的游戏并重新运行CMI安装程序。如果问题依旧，请将你游戏目录中的 update.lst 文件提交给CMI开发人员。

VersionFetchParseFail=读取游戏版本时出错...请更新您的游戏并重试。或者将此问题报告给CMI开发人员。

UpdatePrompt=是否希望尝试下载最新的更新程序并进行安装？因为下载过程可能不稳定，所以通常不建议你这样做。 更新文件下载完成后你需要按照安装程序中显示的说明进行操作，这里仍旧建议通过手动下载的方式进行更新。%n%n下载更新可能需要一段时间，因为更新文件在Kiss 的下载服务器上，大小约为 3GB 左右。这个下载过程可能会非常慢，请耐心等待。%n%n选择'否'将会打开更新下载网站。

UpdateFetchFail=你的游戏版本目前已经是最新的了，或者你是英文版用户但安装程序所需的游戏更新还未发布，也可能是我们未能获取更新。%n%n如果你认为你的游戏不是最新版，建议你手动更新你的游戏。

DownloadFinish=正在执行已下载完成的任务，请等待…
DownloadWPercent=%1 MBs 中的 %2 MBs 已下载 = %3%%
DownloadNoPercent=%1 MBs 已下载。
ExtractingCaption=正在解压 %1 请等待…

EnsureGameClosed=在继续下一步安装前请确保没有打开任何COM3D2游戏的文件夹或运行游戏，否则安装将失败！

GameTypeChangedExit=由于不同的游戏版本会在安装程序中禁用不同的安装选项，为了正确显示之前的页面，安装程序需要重新运行才能恢复这些更改。 你想现在退出安装程序吗？

CannotLoadPreset=读取预设文件失败于 %1

ConfirmPresetSave=已经存在一个你之前选择安装组件的预设列表，是否使用你当前的选择覆盖它作为新的预设？ 如果不覆盖预设，你目前选择的所有内容仍将被安装，但是不会被保存成预设列表被下一次安装CMI的过程所读取。

TypeCompact=最低限度的安装预设
TypeFull=Noctsoul所用的预设
TypeEng=含有自动翻译功能的合集包（注意，默认英语翻译）
TypeNoTr=不含有自动翻译功能的合集包
TypePic=我是一个摄影君
TypeHen=我只想冲，我不想拍照用
TypeSelf=CMI开发者的预设
TypeCustom=自定义安装
TypePreset=使用预设（首次使用此模式安装将在游戏目录生成预设文件）
TypeNone=清空所有选项

ModLoader=Mod Loader (几乎所有东西都需要它)
BepinEx=BepInEX（推荐使用并且必选组件！）
Sybaris=Sybaris 2.1（不推荐！如果你不知道你在做什么请不要勾选！）
TranslationPlugs=Translation Plugins （翻译插件）
ExtraTrans=Extra Translations （额外的翻译）
IMGUITrans=Plugin Translations （翻译插件用的插件）
EmoEarsAhoge=Ahoge meshes（呆毛）
EmoEarsMod=Ear and tail meshes （耳朵和尾巴）
NPRLightConfig=Lightweight Config （轻量化设定）
PluginExt=PluginExt (插件配置文件输出路径修复)
PNGPlaceExtraPNG=More PNGs 
MiscFiles=Miscelleanous Files （其他文件）
StudioPoses=1900+ Poses for Studio Mode （Studio Mode中的1900+个姿势文件）
AddMoreBG=Add More Game BGs to Photo Mode (And MM) （添加更多的游戏背景到拍照模式和MaidoPhotoStudio插件中）
Uncensor=Uncensored Vanilla Textures （原版材质解码）
UncensorMale=Male Penis Replacer （去码JJ替换）
ExtraUncensorMale=More Penis Variants （更多JJ模型）
BodyReplacers=Body Replacers （身体模型替换）
ExternalFiles=External Files （额外的文件）
MaidFiddler=Maid Fiddler （修改器，但是和目前游戏有冲突！）

FixRegistry=修复注册表中的游戏安装位置
Clean=是否执行清理任务？
CleanGroup=安装前要执行的清理任务
MoveOld=将旧的安装文件移动到备份文件夹中
MoveOldMods=移动所有旧的插件到备份文件夹中（这也会移动你在MM插件中保存的所有自定义姿势）
PlaceConfigBack=还原配置文件（警告！这可能会覆盖掉你更新的配置。不建议！）
DeleteOld=直接删除以前安装的插件（警告！这个操作不可逆！这将删除掉所有以前安装的Sybaris或BeplnEx文件夹和其中的插件）
DeleteOldMods=删除CMI在MOD文件夹中安装的文件（此选项会删除你在MultipleMaids和MeidoPhotoStudio插件中保存的自定义姿势）
DeleteOldInstalls=删除游戏目录中所有的旧插件的备份文件夹
RemoveReadOnly=把所有文件去掉'只读'的文件属性
RemoveReadOnlyGroup=由于Windows错误地设置了只读的文件属性，导致许多用户遇到问题。 这个选项试图解决这个问题，尽管由于权限、UAC 或其他因素，它可能无法正确的去掉'只读'文件属性，你可以手动地完成这项工作。

MoveOldExcep=尝试将旧插件移动到备份的旧文件夹时出现异常！请确保没有打开任何游戏应用程序，并且游戏目录里没有任何文件或文件夹被打开或占用！我们将退出以确保游戏文件的安全！有关故障排除步骤，请查看说明文档！

MoveOldModExcep=尝试将旧MOD移动到备份的旧文件夹时出现异常！请确保没有打开任何游戏应用程序，并且游戏目录里没有任何文件或文件夹被打开或占用！我们将退出以确保游戏文件的安全！有关故障排除步骤，请查看说明文档！

CannotRenameOld=CMI的安装已完成，但'OldInstall'文件夹无法重命名。安装程序不会因此中止，因为无法重命名不会对游戏运行造成任何问题。在下次运行CMI的安装程序时，它应该会自动被重命名。

AssetDownloadFailed=未能成功下载某些选定的组件，请确保你的电脑已正确的连接到 Internet 后再进行重试。 选择“是”重试下载。 按“否”则跳过下载失败的组件继续安装。

SerializePrompt=我们发现有一个设置文件 (serialize_storage_config.cfg)将你的存档数据放置在了"文档"的目录中。通常你的存档数据应该保存在游戏目录内，但保留存档数据在"文档"中也不会造成任何问题。 是否删除这个文件并将你的存档数据移回游戏目录中？

SerializeDeleteFail=因为未知原因导致删除 %1\serialize_storage_config.cfg 失败！
SerializeCopyFail=因为未知原因导致在 %1 的位置复制失败!

MFInstall=等待 Maid Fiddler 安装程序完成。（用户必须按照打开的安装程序进行操作！）

Survey=打开 CMI 的反馈调查

OfficialPage=打开CMI的官方Github下载地址