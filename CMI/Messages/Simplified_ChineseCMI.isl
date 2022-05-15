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
IsGameCR=你正在安装CMI的游戏版本是 3.X 或更高版本吗？ 换而言之，它是支持KCES (CRES) 的版本(COM3D2.5)吗？%n%n 需要注意的是，英文版游戏不支持KCES（也就是没有3.X版本），并且CMI与 1.09 及以下的游戏版本不兼容。

GameIsCRWarning=请注意，如果你的游戏版本是COM3D2.5的版本（指的是可以连携KCES，并且游戏版本是3.X的版本），它只支持有限的MOD或插件。你可能发现一些在非 KCES (CRES) 版本上可用的插件在这些版本上不可用，甚至会遇到插件开发者尚未纠正的错误。 请悉知！

ScamWarning=如果大兄弟你为下载 CMI 付了钱，或者从任何非官方 GitHub 的渠道下载了它。那么你的安装副本非常有可能携带病毒，并且你很可能已经成为盗版软件的受害者，请及时拨打110报警或12315进行维权。

StorageSpaceLow=检测到你包含AppData的分区（通常在你计算机的C盘）没有足够的可用空间进行缓存。请至少留出 5 GB 的空间来安装 CMI！目前AppData的分区剩余 %1MB
StorageSpaceLow2=你选择安装CMI的硬盘分区没有足够的空间来安装 CMI。 请至少留出 5 GB 的空间以便将 CMI 安装到此目录！目前你的分区剩余 %1MB

OutdatedInstaller=这个安装程序已过时，它可能与你目前的新版本不兼容！ 你可以继续安装，但是风险自负！

ReadmeRead=如何让人类在安装程序前阅读说明书是一件至今人类都没有解决的难题。如果你不读它，你可能会遗漏掉很多有用的信息。
ReadmeExit=所以我还是建议你先去读一下说明书然后再来安装CMI，相信能找到CMI安装包的你应该有一定水平的英文阅读能力。

EnglishVersionAlert=如果你的游戏不是英文版本的话请立刻退出安装程序并阅读安装说明！%n%n 发现英文版游戏副本！作为告知，建议使用日文版游戏副本，因为英文版游戏没有日文版那样功能齐全亦或者支持全面。

EnglishVersionCompatibility=自动翻译插件和其相关组件可能与你的英文版游戏不兼容。%n%n 是否应该禁用这些组件以保证你的英文游戏副本不受影响？（推荐！）

CRVersionAlert=如果你的游戏副本不是 COM3D2.5 （KCES连携版） 版本的游戏的话请立刻退出安装程序并阅读安装说明！%n%n找到了 COM3D2.5 （KCES连携版） 的版本！ 请注意，COM3D2.5版本不像标准版本（COM3D2）那样功能完整或受支持！ 某些组件为了你游戏的正常运行将被禁用！

CMDetected=你选择的游戏文件夹是 CM3D2 而不是 COM3D2！ CMI 不兼容 CM3D2！对于 CM3D2，请你使用 Legacy Meido Modular Toolbox (LMMT)

NotaGameDir=这看起来不是 COM3D2的目录！ 但是你仍然可以继续安装，这样做有可能会安装到错误的目录，一些功能也会失效。 你确定要继续吗？

ImproperUpdate=检测到游戏副本更新的方式不正确！（通常是通过简单的复制/粘贴 更新文件 到游戏目录的行为进行更新）这样升级方式非常的不安全和不规范，这样做会导致你的游戏无法正常运行。%n%n鉴于此 CMI 的安装进程将终止，因为如果继续安装，你将会遇到更多的错误。 请重新安装您的游戏并正确的进行更新后（将 更新文件 或 DLC文件 解压到一个空目录中并使用官方提供的 update.exe 或 selector.exe进行安装）再安装CMI。

IsInDownload=你的游戏似乎位于Windows默认的'下载'目录中，这可能会导致 UAC 出现问题并导致 CMI 安装不正确！ 请把它移到其他的地方（例如：C:/KISS/COM3D2）

IsInProgramFiles=你的游戏似乎位于Program Files目录中，这可能会导致 UAC 出现问题并导致 CMI 安装不正确！ 请把它移到其他的地方（例如：C:/KISS/COM3D2）

IsINM=我们检测到了INM版本（COM3D2的非R18发行版 It's a Night Magic 简称INM版）！ 由于INM版的技术差异，CMI 不支持INM版游戏。%n%n如果你要使用 CMI，请安装 R18/成人内容补充补丁。%n%n如果你的游戏版本不是INM版，那么您可能将英文版的DLC安装到了你的日文版游戏中，请参阅说明书中有关修复游戏的部分。

GameOutdated=你的游戏版本过旧,请升级你的游戏.%n%n最低版本需求: %1%n%n你的游戏版本: %2

GameUpdateNotSupported=无法通过安装程序更新游戏的KCES版本，因为它需要额外的步骤。 请手动更新您的游戏。

MissingUpdateLst=虽然这是游戏的文件夹，但没有找到 Update.lst 文件！这非常严重！%n%n请你立即更新游戏并确保其正常运行后，再尝试安装 CMI。

VersionFetchLoadFail=无法从 %1 读取字符串！

VersionFetchNoVersion=虽然我们设法找到了 Update.lst 文件，但找不到包含：%1 的行！ 如果您使用的是日文版，这可能是一个真正的问题！ 请立即更新！

VersionFetchLineCleanFail=无法清理包含解析所需版本的行...请更新你的游戏并重试。 或者将你游戏目录中的 update.lst 文件提交给开发人员。

VersionFetchParseFail=解析游戏版本时出错...请更新您的游戏并重试。 或者将此问题报告给开发人员。

UpdatePrompt=是否希望尝试下载最新的更新程序并进行安装？因为下载过程可能不稳定，所以通常不建议这样做。 完成后你需要按照显示的安装程序中的说明进行操作，这里仍旧建议通过手动下载的方式进行更新。%n%n下载更新可能需要一段时间，因为更新程序在Kiss 的下载服务器上，大小约为 3GB 左右，下载过程可能会非常慢，请耐心等待。%n%n选择'否'将会打开更新下载网站。

UpdateFetchFail=要么你的游戏版本已经是最新的了，要么你是英文版用户但需要等待一个新的游戏更新，也可能是我们未能获取更新。%n%n如果你认为你的游戏不是最新版，建议你手动更新你的游戏。

DownloadFinish=正在执行已下载完成的任务，请等待…
DownloadWPercent=%1 MBs 中的 %2 MBs 已下载 = %3%%
DownloadNoPercent=%1 MBs 已下载
ExtractingCaption=正在解压 %1. 请等待…

EnsureGameClosed=请确保没有打开任何COM3D2游戏的文件夹或运行游戏，否则安装将失败！

GameTypeChangedExit=由于禁用组件对安装程序所做的更改，安装程序需要重新运行才能恢复这些更改，并允许你安全地使用之前的页面。 你想现在退出安装程序吗？

CannotLoadPreset=读取预设文件失败于 %1

ConfirmPresetSave=已经存在一个关于你选择安装组件的预设列表，是否使用当前的选择覆盖它作为新的预设？ 如果不覆盖预设，你目前选择的所有内容仍将被安装，但是不会被保存成预设列表被下一次安装过程所读取。

TypeCompact=最基础的安装
TypeFull=更趋近于 Noctsoul 的合集包
TypeEng=含有自动翻译功能的合集包（注意，默认英语翻译）
TypeNoTr=不含有自动翻译功能的合集包
TypePic=我是摄影君
TypeHen=我只想冲，我不想拍照用
TypeSelf=CMI作者的预设
TypeCustom=自定义安装
TypePreset=使用预设
TypeNone=啥都不装

ModLoader=Mod Loader (几乎所有东西都需要它)
BepinEx=BepInEX (推荐使用！)
Sybaris=Sybaris 2.1 (不推荐！如果你不知道你在做什么请不要勾选！)
TranslationPlugs=Translation Plugins （翻译插件）
ExtraTrans=Extra Translations （额外的翻译）
IMGUITrans=Plugin Translations （插件翻译）
EmoEarsAhoge=Ahoge meshes
EmoEarsMod=Ear and tail meshes （耳朵和尾巴）
NPRLightConfig=Lightweight Config （轻量化设定）
PluginExt=PluginExt (很多插件都需要它，推荐安装)
PNGPlaceExtraPNG=More PNGs 
MiscFiles=Miscelleanous Files （其他文件）
StudioPoses=1900+ Poses for Studio Mode （Studio Mode中的1900+个姿势文件）
AddMoreBG=Add More Game BGs to Photo Mode (And MM) （添加更多的游戏背景到拍照模式和MM插件中）
Uncensor=Uncensored Vanilla Textures （解码的贴图）
UncensorMale=Male Penis Replacer （JJ替换）
ExtraUncensorMale=More Penis Variants （解码）
BodyReplacers=Body Replacers （身体替换）
ExternalFiles=External Files （额外的文件）
MaidFiddler=Maid Fiddler (有冲突!)

FixRegistry=修复注册表中的安装目录
Clean=清理任务
CleanGroup=安装前要执行的清理任务
MoveOld=将旧的安装文件移到备份的旧文件夹中
MoveOldMods=移动所有旧的MOD到备份的旧文件夹中（这也会移动你保存的所有MM插件中的姿势）
PlaceConfigBack=还原配置文件（警告！这可能会覆盖掉你更新的配置。不建议！）
DeleteOld=删除以前安装的插件 (警告！这个操作不可逆！你将丢失任何以前安装的 SYBARIS 或 BEPINEX 文件夹和其中的插件！！！)
DeleteOldMods=删除所有旧的MOD（这也会删除你保存的所有MM插件中的姿势）
DeleteOldInstalls=删除所有旧的插件
RemoveReadOnly=把所有文件去掉'只读'的文件属性
RemoveReadOnlyGroup=由于Windows错误地设置了只读的文件属性，导致许多用户遇到问题。 这个选项试图解决这个问题，尽管由于权限、UAC 或其他因素，它可能无法正确的去掉'只读'文件属性，你可以手动地完成这项工作。

MoveOldExcep=尝试将旧插件移动到备份的旧文件夹时出现异常！请确保没有打开任何游戏应用程序，并且游戏目录里没有任何文件或文件夹被打开或占用！我们将退出以确保游戏文件的安全！有关故障排除步骤，请参阅自述文件！

MoveOldModExcep=尝试将旧MOD移动到备份的旧文件夹时出现异常！请确保没有打开任何游戏应用程序，并且游戏目录里没有任何文件或文件夹被打开或占用！我们将退出以确保游戏文件的安全！有关故障排除步骤，请参阅自述文件！

CannotRenameOld='OldInstall'文件夹无法重命名，但安装已完成。因为错误是无害的，所以我们不会中止安装程序。下次运行 CMI 时，它应该会自动被重命名。

AssetDownloadFailed=未能成功下载某些选定组件，请确保您已连接到 Internet 并且连接正常，然后重试。 选择“是”重新尝试下载。 按“否”，您可以继续安装，但会跳过下载失败的组件。

SerializePrompt=我们注意到有一个文件 (serialize_storage_config.cfg)将你的存档数据放置在了'文档'的目录中。通常它会被删除，但保留它也无所谓。 我们要不要删除这个文件并将您的存档数据移回游戏文件夹中？

SerializeDeleteFail=因为未知原因导致删除 %1\serialize_storage_config.cfg 失败！
SerializeCopyFail=因为未知原因导致在 %1 的地方拷贝失败!

MFInstall=等待 Maid Fiddler 安装程序完成。（用户必须按照打开的安装程序进行操作！）

Survey=打开 CMI 的反馈调查

OfficialPage=打开CMI的官方下载地址