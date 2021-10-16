; *** Inno Setup version 6.1.0+ English messages ***
;
; To download user-contributed translations of this file, go to:
;   https://jrsoftware.org/files/istrans/
;
; Note: When translating this text, do not add periods (.) to the end of
; messages that didn't have them already, because on those messages Inno
; Setup adds the periods automatically (appending a period would result in
; two periods being displayed).
[Messages]

WizardSelectDir=Seleccionar ubicación del juego 
SelectDirLabel3=Seleccione su directorio de instalación de COM3D2 a continuación. Ejemplo: C:\KISS\COM3D2 
SelectDirDesc=¿Dónde está ubicado tu juego? 

[CustomMessages]

;Startup Messages
GameIsCRWarning=Tenga en cuenta que las versiones de CR-Edit (también conocidas como versiones 3,0+ o COM3D2.5) tienen menos compatibilidad con mods y plugins. Puede encontrar que varios plugins no están disponibles en estas versiones que están disponibles en versiónes no CR-Edit e incluso puede encontrar errores que aún no han sido corregidos por los desarrolladores de plugins. ¡Usted ha sido advertido! 


ScamWarning=Si pagó por CMI o lo descargó desde cualquier lugar que no sea la página oficial de GitHub, ¡puede ser que ha sido estafado o engañado!
StorageSpaceLow=Detectamos que su partición que contiene AppData (normalmente su disco C) no tiene suficiente espacio libre para el caché. Borre un mínimo de 5 GiB para instalar CMI. Usted Tiene %1MBs
StorageSpaceLow2=La unidad que contiene la ruta que ha seleccionado no contiene suficiente espacio para instalar CMI de forma segura. Borre un mínimo de 5 GiB para instalar CMI en este directorio. Usted tiene %1MBs 
OutdatedInstaller=¡Este instalador está desactualizado y probablemente sea incompatible con nuevos archivos y versiones! Puede continuar con la instalación, pero continúa bajo su propio riesgo 
ReadmeRead=¿Leíste el archivo Readme? No leerlo anulará cualquier posibilidad de recibir asistencia
ReadmeExit=Regrese y léalo antes de instalar CMI

EnglishVersionAlert=Si no tienes una versión en inglés del juego, sal de la instalación ahora mismo y consulta el archivo readme!!%n%n¡¡Se encontró la versión en inglés!! Tenga en cuenta que las versiones en inglés no son tan completas ni tan compatibles como la versión japonesa. 
EnglishVersionCompatibility=Los plugins de traducción y los componentes relacionados pueden ser dañinos o incompatibles con tu juego de inglés.%n%n¿Deberíamos deshabilitar estos componentes para mantenerte a salvo? (Recomendado)
CRVersionAlert=Si no tienes una versión CR (COM3D2.5) del juego, sal de la instalación ahora mismo y consulta el archivo readme.%n%n¡¡Se encontró la versión CR!!Tenga en cuenta que las versiones CR no son tan completas ni tan compatibles como la versión estándar. ¡Algunos componentes se desactivarán por su seguridad! 

CMDetected=¡Esto es CM3D2, no COM3D2! ¡CMI no se hizo para CM3D2! Para CM3D2, utilice Legacy Meido Modular Toolbox (LMMT) 
NotaGameDir=¡Esto no parece ser un directorio COM3D2! Aún podemos continuar con la instalación, pero es posible que esté instalando en el directorio incorrecto, algunas funciones también se volverán ineficaces. ¿Seguimos de todos modos? 
ImproperUpdate=¡Hemos detectado que esta instancia del juego se actualizó incorrectamente! (Por lo general, mediante un proceso de arrastrar y soltar). Esto es completamente inseguro y PODRÁ romper el juego.%n%nDebido a que CMI no se instalará, ya que puede encontrar más errores y errores si Seguir. Vuelve a instalar tu juego y actualiza CORRECTAMENTE (colocando los archivos de actualización / DLC en un directorio vacío y usando el update.exe o selector.exe provisto) para continuar.
IsInDownload=Parece que tu juego se encuentra en el directorio de descargas, ¡esto puede causar problemas con UAC y provocar instalaciones incorrectas de CMI! Muévalo a un lugar más seguro (Ejemplo: C:/KISS/COM3D2) 
IsInProgramFiles=Parece que su juego está ubicado en el directorio Archivos de programa, ¡esto puede causar problemas con UAC y provocar instalaciones incorrectas de CMI! Muévalo a un lugar más seguro (Ejemplo: C:/KISS/COM3D2)
IsINM=¡Hemos detectado INM! INM no es compatible con CMI debido a diferencias técnicas.%n%nPara usar CMI, instale el parche complementario de contenido para adultos/R18.%n%nSi no tiene una versión INM del juego, es probable que haya instalado Eng DLC/archivos en su juego japonés. Consulte el archivo readme sobre las instrucciones de reparación. 

GameOutdated=¡Tu juego está desactualizado! Actualícelo inmediatamente.%n%nVersión mínima:%1%n%nVersión encontrada:%2
GameUpdateNotSupported=No podemos actualizar las versiones CR-edit del juego a través del instalador porque requiere pasos adicionales. Actualiza tu juego manualmente.

MissingUpdateLst=Aunque parece ser una carpeta de juegos, ¡no hay ningún archivo Update.lst! ¡Esto es muy malo!%n%nActualiza su juego inmediatamente y asegúrese de que funciona antes de intentar instalar CMI nuevamente.
VersionFetchLoadFail=No se pudieron cargar las lineas de %1 
VersionFetchNoVersion=Aunque logramos encontrar el archivo Update.lst, ¡no se pudo encontrar la línea que contiene:%1! Si está en la versión japonesa, ¡esto puede ser un problema grande! ¡Actualice inmediatamente! 
VersionFetchLineCleanFail=No se pudo limpiar la línea que contiene la versión que necesitamos para analizar ... Actualiza tu juego y vuelve a intentarlo. De lo contrario, informe de esto al desarrollador con su archivo update.lst 
VersionFetchParseFail=Se produjo un error al analizar el número de versión ... Actualiza tu juego y vuelve a intentarlo. De lo contrario, informe de esto al dev. 

UpdatePrompt=¿Le gustaría que intentemos descargar la última actualización y ejecutar el actualizador? Por lo general, esto no se recomienda, ya que puede ser inestable. Aún tendrá que seguir las instrucciones del instalador que aparece, y esta forma de actualización no es tan segura ni tan confiable como la actualización manual.%n%nLa actualización puede tardar un poco en descargarse, ya que la descarga en sí puede ser de alrededor de 3GB de tamaño y los servidores de Kiss pueden ser MUY lentos, así que tenga paciencia.%n%nPulsar no abrirá el sitio web de descarga de actualizaciones. 
UpdateFetchFail=O ya tienes la última versión disponible y necesitas esperar una nueva actualización del juego (usuarios en inglés) o no pudimos obtener las actualizaciones.%n%nSe recomienda que actualices manualmente tu juego si crees que no estás en la última versión disponible para tu juego. 

DownloadFinish=Realizando tareas de descarga finales. Por favor espere... 
DownloadWPercent=%1 MBs de %2 MBs terminados = %3%%
DownloadNoPercent=%1 MBs descargado
ExtractingCaption=Ahora extrayendo %1. Por favor espere... 

EnsureGameClosed=¡Asegúrese de que no haya carpetas de juegos o instancias de juegos abiertas o tendrá una instalación incorrecta! 

GameTypeChangedExit=Debido a los cambios realizados en el instalador al deshabilitar los componentes, es necesario reiniciar el instalador para revertir estos cambios y permitirle utilizar de forma segura las páginas anteriores. ¿Le gustaría salir del instalador ahora? 

CannotLoadPreset=No se pudo cargar el preajuste en %1 
ConfirmPresetSave=Parece que ya tiene un preajuste aquí para sus selecciones de componentes. ¿Deberíamos sobrescribirlo con su selección actual? Lo que haya seleccionado se seguirá aplicando, la selección simplemente no se guardará para la próxima vez si seleciona no 

TypeCompact=Instalación básica 
TypeFull=Similar al AIO de Noctsoul
TypeEng=Localizaciones no japonesas similares a AIO 
TypeNoTr=Sin traducciones AIO
TypePic=Solo tomo fotos 
TypeHen=Yo solo juego, no tomo fotos 
TypeSelf=Mis selecciones 
TypeCustom=Está bien, toma tus propias decisiones 
TypePreset=Preajuste personalizado 
TypeNone=¡No quiero nada! 

ModLoader=Mod Loader (necesario para casi todo) 
BepinEx=BepInEX (recomendado) 
Sybaris=Sybaris 2.1 (No recomendado, NO LO USE) 
TranslationPlugs=Plugins de Traducción 
ExtraTrans=Traducciones Adicionales(Ingles)
IMGUITrans=Traducciones de Plugins(Ingles)
EmoEarsAhoge=Ahoge 
EmoEarsMod=Orejas y colas 
NPRLightConfig=Configuración ligera 
PluginExt=PluginExt (requerido por algunos otros complementos. Recomendado) 
PNGPlaceExtraPNG=Más PNGs 
MiscFiles=Archivos misceláneos
StudioPoses=1900+ poses para el modo de estudio
AddMoreBG=Agregar más BG del juego al modo estudio (y MM)
Uncensor=Texturas de vainilla sin censura 
UncensorMale=Reemplazo de pene
ExtraUncensorMale=Más variantes de pene 
BodyReplacers=Reemplazos de cuerpo
ExternalFiles=Archivos externos 
MaidFiddler=Maid Fiddler (Peligroso!)

FixRegistry=Corregir directorio de registro 
Clean=Tareas de limpieza 
CleanGroup=Tareas de limpieza a ejecutar antes de la instalación 
MoveOld=Mover instalaciones antiguas a la carpeta antigua 
MoveOldMods=También mueva los Mods instalados por el instalador (Esto también moverá las poses MM guardadas) 
PlaceConfigBack=Vuelva a colocar las configuraciones (¡Advertencia! Esto puede sobrescribir las configuraciones actualizadas. No sugerido)
DeleteOld=Eliminar instalaciones anteriores (ADVERTENCIA: MUY DESTRUCTIVO, PERDERÁS CUALQUIER CARPETA SYBARIS O BEPINEX)
DeleteOldMods=Elimine también las modificaciones instaladas por el instalador (esto también eliminará todas sus poses MM guardadas) 
DeleteOldInstalls=Elimina también las instalaciones antiguas 
RemoveReadOnly=Eliminar la marca de solo lectura en todos los archivos 
RemoveReadOnlyGroup=Muchos usuarios tienen problemas gracias a que el sistema establece de manera irónica los indicadores de solo lectura. Esto intenta solucionar eso, aunque debido a permisos, UAC u otros factores, es posible que no siempre funcione. Siempre se puede hacer manualmente, sin embargo.

MoveOldExcep=Se lanzó una excepción al intentar mover la instalación anterior a la carpeta anterior. ¡Asegúrese de que no haya ninguna aplicación de juego abierta y que ninguno de los archivos o carpetas esté abierto en ningún lugar! ¡Vamos a terminar la instalación para mantener sus datos seguros! Consulte el archivo readme para conocer los pasos de solución de problemas. 
MoveOldModExcep=¡Se lanzó una excepción al intentar mover los mods antiguos a la carpeta anterior! ¡Asegúrese de que no haya ninguna aplicación de juego abierta y que ninguno de los archivos o carpetas esté abierto en ningún lugar! ¡Vamos a terminar la instalación para mantener sus datos seguros! Consulte el archivo readme para conocer los pasos de solución de problemas. 
CannotRenameOld=No se pudo cambiar el nombre de la carpeta OldInstall, pero la instalación ya está completa. Como resultado, no abortaremos ya que el error es inofensivo. Debería cambiarse el nombre automáticamente la próxima vez que se ejecute CMI.

AssetDownloadFailed=No pudimos descargar archivos para algunos de los componentes seleccionados. Asegúrese de estar conectado a Internet y de tener una conexión que funcione antes de volver a intentarlo. De lo contrario, puede continuar con la instalación, los activos que faltan simplemente no se instalarán.

SerializePrompt=Notamos que tiene un archivo que hace que los datos guardados se coloquen en el directorio Documentos del usuario (serialize_storage_config.cfg). Normalmente esto se quita, pero no está de más dejarlo. ¿Eliminamos este archivo y volvemos a colocar tus datos guardados en la carpeta del juego? 
SerializeDeleteFail=No se pudo eliminar el archivo en %1\serialize_storage_config.cfg por una razón desconocida. 
SerializeCopyFail=No se pudieron copiar los archivos en %1 por un motivo desconocido. 

MFInstall=Esperando a que finalice el instalador de Maid Fiddler ... (¡Los usuarios deben seguir el instalador que se abre!) 

Survey=Abra la encuesta de comentarios para CMI 