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

WizardSelectDir=Indiquer l'emplacement du jeu
SelectDirLabel3=Indiquer l'emplacement d'installation de COM3D2! Exemple: C:\KISS\COM3D2
SelectDirDesc=Où est installé votre jeu?

[CustomMessages]

;Startup Messages
IsGameCR=Votre version de COM3D2 est-elle supérieure ou égale à 3.0? Autrement dit, CR-Edit est-il installé?
GameIsCRWarning=Veuillez garder à l'esprit que les versions 3.0+ souffrent d'une prise en charge réduite des Mods et plugins. Certains plugins seront indisponibles et d'autres pourront avoir des bugs. Vous voilà prévenu!

ScamWarning=CMI est totalement gratuit, si vous l'avez téléchargé ailleur que sur GitHub vous vous êtes probablement fait avoir!
StorageSpaceLow=Votre dossier AppData (habituellement dans le dique C) n'a pas assez d'espace libre pour les fichiers temporaires. Libérer au minimum 5Gb. Vous avez %1MBs
StorageSpaceLow2=Espace insuffisant pour installer CMI. Veulliez libérer au moins 5 GiBs: Vous avez %1MBs
OutdatedInstaller=Cet installeur est dépassé et probablement incompatible avec les nouvelles versions. Vous pouvez continuer à vos propres riques!
ReadmeRead=Avez vous lu la documentation ? Il est fortement conseillé de la lire pour  répondre aux questions les plus courantes (en anglais)
ReadmeExit=Veuillez lire la documentation avant tout

EnglishVersionAlert=Si vous n'avez pas la version Anglaise, veuillez quitter l'installeur dés maintenant et vous référer à la documentation!!%n%nVersion anglais détectée!! Notez que la version Anglaise ne bénéfiecie pas encore de toutes les fonctionnalités de la Japonaise!
EnglishVersionCompatibility=Les plugins de traduction peuvent être incompatible avec votre version.%n%nVoulez vous les désactiver? (Recommandé)

CMDetected=Vous avez séléctionné CM3D2 et non COM3D2! CMI n'est PAS compatible avec CM3D2! Veuillez utiliser Legacy Meido Modular Toolbox (LMMT)
NotaGameDir=Ceci n'est pas un dossier COM3d2 valide! Vous pouvez tout de même continuer, mais vous installez probablement dans le mauvais dossier. Certaines fonctions seront aussi innéfectives. Continuer?
ImproperUpdate=Ce jeu n'a pas été correctement mis à jour!(Habituelement par glissé déposé) Cela causera des problèmes.%n%nCMI ne sera pas installé pour ne pas poser plus de problèmes. Veuillez réinstaller votre jeu et mettre à jour correctement (Extraire la mise à jour dans un dossier séparer et utiliser update.exe).
IsInDownload=Il semblerait que votre jeu soit installé dans le dossier téléchargement, cela peut poser quelques problèmes avec UAC et une mauvaise installation de CMI! Veuillez le déplacer dans un emplacement adapté (Exemple: C:/KISS/COM3D2)
IsInProgramFiles=Il semblerait que votre jeu soit installé dans le dossier programmes, cela peut poser quelques problèmes avec UAC et une mauvaise installation de CMI! Veuillez le déplacer dans un emplacement adapté (Exemple: C:/KISS/COM3D2)
IsINM=It's a NIght Magic détecté! INM n'est pas supporté par CMI en raison des différence techniques etre les jeux.%n%nVeuillez installé le patch R18/Adult.%n%nSi vous n'êtes pas sur la version INM, vous avez probablement installé un DLC anglais sur votre version Japonaise, veuillez lire la documentation (en anglais) pour réparer ça.

GameOutdated=Votre jeu n'est pas à jour! %n%nVersion Minimum: %1%n%nVersion actuelle: %2
GameUnsupported=La version de votre jeu n'est pas supportée par votre choix concernant CR-Edit. Veuillez relancer l'installeur et sélectionner l'autre option!%n%nVersion non supportée:%1 ou plus récent %n%nVersion détectée:%2
GameUnsupported1=La version de votre jeu n'est pas supportée par votre choix concernant CR-Edit. Veuillez relancer l'installeur et sélectionner l'autre option!%n%nVersion non supportée:%1 ou plus récent %n%nVersion détectée:%2

MissingUpdateLst=Quoique correct ce dossier ne contient pas le fichier Update.lst! C'est mauvais signe!%n%nVeuillez faire une mise à jour à nouveau et vérifier que le jeu se lance avant d'installer CMI.
VersionFetchLoadFail=Impossible de charger la chaîne de caractères depuis %1
VersionFetchNoVersion=La ligne %1 ne peut être trouvée dans Update.lst! Si vous êtes sur la version Japonaise, celà peut être un vrais problèmes! Veuillez mettre à jour à nouveau immédiatemement.
VersionFetchLineCleanFail=Erreur lors de la lecture de ligne, veuillez mettre à jour et tester à nouveau. Autrement veuillez en informer le developpeur (en anglais)
VersionFetchParseFail=Erreur lors de la lecture de version, veuillez mettre à jour et tester à nouveau. Autrement veuillez en informer le developpeur (en anglais)

UpdatePrompt=Voulez vous télécharger et installer la dernière mise à jour automatiquement? Ceci n'est pas recommandé car potentielement instable. Il est préférable de mettre à jour manuellement.%n%nLa mise à jour d'environ 3Go peut être (très) lente à télécharger. Cliquer sur Non ouvrira la page de mise à jour officielle.
UpdateFetchFail=Vous êtes déjà à jour et devez attendre qu'une nouvelle version sorte (Joueurs sur version Anglaise) ou la récupération de la mise à jour a échoué.%n%nIl est recommandé de mettre à jour manuellement si vous pensez ne pas être à jours.

DownloadFinish=Finalisation en cours. Patientez...
DownloadWPercent=%1 MBs de %2 MBs téléchargé = %3%%
DownloadNoPercent=%1 MBs téléchargé
ExtractingCaption=Extraction %1. Veuillez patienter...

EnsureGameClosed=Veuillez vous assurer que le jeu n'est pas lancé!

GameTypeChangedExit=En raison de changements, l'installeur doit redémarrer pour réactiver les composants en toute sécurité. Voulez vous quitter maintenant?

CannotLoadPreset=Chargement de sélection échoué à %1
ConfirmPresetSave=Il semblerait que vous ayez déjà une présélection. Remplacer par la sélection actuelle? Quoique vous choisissiez votre sélection actuelle sera installée, elle ne sera simplement pas sauvegardée pour la prochaine fois

TypeCompact=Installation Basique
TypeFull=Inspiré de Noctsoul's AIO
TypeEng=Non-Japanese version AIO
TypeNoTr=Aucune traductions
TypePic=Principalement pour la prise de photos
TypeHen=Principalement pour le Jeu
TypeSelf=Sélection du Doc
TypeCustom=Faites comme vous voulez
TypePreset=Présélection personelle
TypeNone=Je ne veux Rien!

ModLoader=Mod Loader (Requis pour énormément de choses)
BepinEx=BepInEX (Recommandé)
Sybaris=Sybaris 2.1 (Non Recommandé, NON VRAIMENT!)
TranslationPlugs=Plugins de traduction
ExtraTrans=Traductions supplémentaire
IMGUITrans=Traduction des plugins
EmoEarsAhoge=Mèche rebelle
EmoEarsMod=Oreille et queue
NPRLightConfig=Configuration light
PluginExt=PluginExt (Requis pour certains plugins. Recommandé)
PNGPlaceExtraPNG=Plus de PNG
MiscFiles=Divers
StudioPoses=1900+ Poses pour Studio et MPS
AddMoreBG=Plus de fonds pour Studio et MPS
Uncensor=Textures non censurées
UncensorMale=Penis non censuré
ExtraUncensorMale=Plus de choix de Penis 
BodyReplacers=Meilleur corps féminin
ExternalFiles=Fichiers externes
MaidFiddler=Maid Fiddler (Outil de triche Dangereux!)

FixRegistry=Réparer l'entrée du registre
Clean=Tâche de nettoyage
CleanGroup=Tâche de nettoyage avant installation
MoveOld=Sauvegarder l'ancienne installation
MoveOldMods=Déplacer les anciens mods (seulement ceux de CMI)
PlaceConfigBack=Récupérer les anciens paramètres de plugins (Non conseillé)
DeleteOld=Supprimer l'ancienne installation (ATTENTION: CELA SUPPRIMERA LA DEFINITIVEMENT)
DeleteOldMods=Supprimer les anciens mods(NON CONSEILLE)
DeleteOldInstalls=Supprimer les anciennes sauvegardes de plugins
RemoveReadOnly=Retirer le paramètre lecture-seule
RemoveReadOnlyGroup=Il est courant de rencontrer des erreurs causées par des fichiers en lecture-seule, CMI essaiera de corriger ça. Néanmoins certaines permission système peuvent l'en empècher, il faudra alors le faire manuellement

MoveOldExcep=Une erreur est survenue lors de la sauvegarde de l'ancienne instalation! Veuillez vous assurer que le jeu ne tourne pas et qu'un programme n'a accès aux dossiers du jeu. CMI va quitter pour conserver vos données!
MoveOldModExcep=Une erreur est survenue lors de la sauvegarde des anciens mods! Veuillez vous assurer que le jeu ne tourne pas et qu'un programme n'a accès aux dossiers du jeu. CMI va quitter pour conserver vos données!
CannotRenameOld=Le dossier de sauvegarde n'a pas put être renommé, cette erreur est sans conséquence et devrait être corrigée automatiquement la prochaine fois que CMI sera lancé.

AssetDownloadFailed=Téléchargement de certains composants échoué, vérifié que votre connexion internet fonctionne. Les dit composants ne seront pas installés

SerializePrompt=Vous avez un fichier (serialize_storage_config.cfg) qui change l'emplacement de sauvegarde du jeu pour Documents. Si vous le supprimé tout sera sauvegardé dans le dossier du jeu à la place. Les deux étant un choix valide, voulez vous le supprimer et copier vos sauvegardes dans le dossier du jeu?
SerializeDeleteFail=Suppression de %1\serialize_storage_config.cfg échouée pour des raisons inconnues
SerializeCopyFail=Copie des fichiers %1 échouée pour des raisons inconnues

MFInstall=En attente de l'installation de Maid Fiddler... (L'utilisateur doit suivre les instruction de l'installateur de MF)

Survey=Ouvrir l'enquête satisfactiond de CMI (en anglais)