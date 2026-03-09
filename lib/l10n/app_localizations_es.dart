// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get navChannels => 'Canales';

  @override
  String get navFeed => 'Feed';

  @override
  String get navFavorites => 'Favoritos';

  @override
  String get navPlaylists => 'Listas';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get settingsSectionFolders => 'Carpetas';

  @override
  String get settingsFolderManage => 'Gestionar carpetas';

  @override
  String get settingsFolderManageDesc => 'Añadir, editar, eliminar carpetas';

  @override
  String get settingsSectionDisplay => 'Pantalla';

  @override
  String get settingsLanguage => 'Idioma / Language';

  @override
  String get settingsLanguageSystem => 'Sistema (System)';

  @override
  String get settingsChipLayout => 'Diseño de carpeta';

  @override
  String get settingsChipLayoutSingleLine => 'Una línea';

  @override
  String get settingsChipLayoutWrap => 'Ajustar';

  @override
  String get chipLayoutToggleWrap => 'Ver con ajuste';

  @override
  String get chipLayoutToggleSingleLine => 'Ver en línea';

  @override
  String get settingsFolderView => 'Vista de carpeta';

  @override
  String get settingsShowChannelCount => 'Mostrar cantidad de canales';

  @override
  String get settingsShowVideoCount => 'Mostrar cantidad de videos';

  @override
  String get settingsFolderSizeLarge => 'Grande';

  @override
  String get settingsFolderSizeSmall => 'Pequeño';

  @override
  String get settingsDefaultChannelSection => 'Pestaña de YouTube';

  @override
  String get settingsVideosPerChannel => 'Videos por canal';

  @override
  String settingsVideosPerChannelCount(int count) {
    return '$count';
  }

  @override
  String get settingsCaptionDisplay => 'Mostrar subtítulos';

  @override
  String get settingsCaptionShow => 'Mostrar';

  @override
  String get settingsCaptionHide => 'Ocultar';

  @override
  String get settingsChannelTapAction => 'Acción al tocar canal';

  @override
  String get settingsChannelTapLatestVideos => 'Ver últimos videos';

  @override
  String get settingsChannelTapOpenYoutube => 'Abrir en YouTube';

  @override
  String get settingsVideoCardTapAction => 'Acción al tocar video';

  @override
  String get settingsVideoCardTapInAppPlayer => 'Reproductor integrado';

  @override
  String get settingsVideoCardTapOpenYoutube => 'Abrir en YouTube';

  @override
  String get settingsVideoCardLayoutStyle => 'Diseño de tarjeta de video';

  @override
  String get settingsVideoCardLayoutHorizontal => 'Tarjeta horizontal';

  @override
  String get settingsVideoCardLayoutVertical => 'Tarjeta vertical';

  @override
  String get settingsMenuOrder => 'Orden del menú';

  @override
  String get settingsMenuOrderDesc => 'Cambiar orden de navegación';

  @override
  String get settingsResetApp => 'Restablecer aplicación';

  @override
  String get settingsSectionData => 'Datos';

  @override
  String get settingsBackup => 'Copia de seguridad';

  @override
  String get settingsRestore => 'Restaurar datos';

  @override
  String get settingsClearCache => 'Limpiar caché de imágenes';

  @override
  String get settingsSectionInfo => 'Información';

  @override
  String get settingsVersion => 'Versión';

  @override
  String get settingsLicense => 'Licencias de código abierto';

  @override
  String get settingsSectionAccount => 'Cuenta';

  @override
  String get settingsGoogleAccount => 'Cuenta de Google';

  @override
  String get settingsNotLoggedIn => 'No conectado';

  @override
  String get settingsLogout => 'Cerrar sesión';

  @override
  String get addToFolder => 'Añadir a carpeta';

  @override
  String get sectionSettings => 'Pestaña de YouTube';

  @override
  String subscriberCount(String count) {
    return '$count suscriptores';
  }

  @override
  String channelsSelected(int count) {
    return '$count canales seleccionados';
  }

  @override
  String itemsSelected(int count) {
    return '$count seleccionados';
  }

  @override
  String get timeJustNow => 'Ahora';

  @override
  String timeMinutesAgo(int count) {
    return 'hace $count min';
  }

  @override
  String timeHoursAgo(int count) {
    return 'hace $count h';
  }

  @override
  String timeDaysAgo(int count) {
    return 'hace $count d';
  }

  @override
  String timeWeeksAgo(int count) {
    return 'hace $count sem';
  }

  @override
  String timeMonthsAgo(int count) {
    return 'hace $count mes';
  }

  @override
  String itemCount(int count) {
    return '$count elementos';
  }

  @override
  String get deleteConfirmTitle => 'Confirmar eliminación';

  @override
  String deleteSelectedVideosConfirm(int count) {
    return '¿Eliminar $count videos seleccionados?';
  }

  @override
  String get deleteFavoriteConfirm => '¿Quitar de favoritos?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get selectAll => 'Seleccionar todo';

  @override
  String get select => 'Seleccionar';

  @override
  String timeYearsAgo(int count) {
    return 'hace $count año(s)';
  }

  @override
  String videoCount(int count) {
    return '$count videos';
  }

  @override
  String channelCount(int count) {
    return '$count canales';
  }

  @override
  String playlistCount(int count) {
    return '$count listas cargadas';
  }

  @override
  String get removeFromFolder => 'Quitar de carpeta';

  @override
  String get deleteChannel => 'Eliminar canal';

  @override
  String deleteChannelConfirm(String name) {
    return '¿Eliminar completamente $name?\nSe eliminará de todas las carpetas.';
  }

  @override
  String removeChannelConfirm(String name) {
    return '¿Quitar $name de esta carpeta?\nSeguirá en tus suscripciones.';
  }

  @override
  String deleteChannelsConfirm(int count) {
    return '¿Eliminar completamente $count canales?\nSe eliminarán de todas las carpetas.';
  }

  @override
  String removeChannelsConfirm(int count) {
    return '¿Quitar $count canales de esta carpeta?\nSeguirán en tus suscripciones.';
  }

  @override
  String get channelDeleted => 'Canal eliminado';

  @override
  String get removedFromFolder => 'Quitado de la carpeta';

  @override
  String addedToFolder(String name) {
    return 'Añadido a $name';
  }

  @override
  String channelsDeleted(int count) {
    return '$count canales eliminados';
  }

  @override
  String channelsRemoved(int count) {
    return '$count canales quitados';
  }

  @override
  String channelsAddedTo(int count, String name) {
    return '$count canales añadidos a $name';
  }

  @override
  String get cannotOpenChannel => 'No se puede abrir el canal';

  @override
  String get pleaseSelectChannels => 'Por favor selecciona canales';

  @override
  String get createFolderFirst => 'Por favor crea una carpeta primero';

  @override
  String get createCategoryFirst => 'Por favor crea una categoría primero';

  @override
  String get unsubscribed => 'Desuscrito';

  @override
  String uploadedAgo(String time) {
    return 'subido $time';
  }

  @override
  String sectionSettingsTitle(String title) {
    return '$title\nAjustes de sección';
  }

  @override
  String useDefaultSection(String section) {
    return 'Usar predeterminado ($section)';
  }

  @override
  String get sectionSetToDefault => 'Sección establecida por defecto';

  @override
  String sectionSetTo(String section) {
    return 'Establecido a sección $section';
  }

  @override
  String get channelsUpdated => 'Lista de canales actualizada';

  @override
  String get noSubscriptions => 'Sin canales suscritos';

  @override
  String get noSearchResults => 'Sin resultados';

  @override
  String get cannotLoadPlaylists => 'No se pueden cargar las listas';

  @override
  String get retry => 'Reintentar';

  @override
  String get noPlaylists => 'Sin listas de reproducción';

  @override
  String get noVideos => 'Sin videos';

  @override
  String get noFavorites => 'Sin videos favoritos';

  @override
  String get customOrder => 'Orden personalizado';

  @override
  String get alphabetical => 'Alfabético';

  @override
  String get multiSelect => 'Selección múltiple';

  @override
  String get openInYoutube => 'Abrir en YouTube';

  @override
  String get latestVideos => 'Últimos videos';

  @override
  String formatTenThousand(String count) {
    return '${count}K';
  }

  @override
  String formatThousand(String count) {
    return '${count}K';
  }

  @override
  String formatMillion(String count) {
    return '${count}M';
  }

  @override
  String get dialogLogoutTitle => 'Cerrar sesión';

  @override
  String get dialogLogoutContent => '¿Seguro que quieres cerrar sesión?';

  @override
  String get dialogResetAppTitle => 'Restablecer aplicación';

  @override
  String get dialogResetAppContent =>
      'Se eliminarán todos los datos, incluyendo suscripciones, carpetas, favoritos y listas de reproducción.\n\n¿Desea restablecer la aplicación?';

  @override
  String get dialogResetAppSuccess => 'La aplicación ha sido restablecida.';

  @override
  String get dialogClearCacheTitle => 'Limpiar caché';

  @override
  String get dialogClearCacheContent =>
      '¿Limpiar caché de imágenes?\nLas imágenes se recargarán al reiniciar la app.';

  @override
  String get dialogClearCacheSuccess => 'Caché de imágenes limpiado.';

  @override
  String get dialogClearCacheFailed => 'Error al limpiar caché';

  @override
  String dialogBackupSuccess(String filePath) {
    return 'Copia de seguridad completada.\nGuardado en: $filePath';
  }

  @override
  String get dialogBackupCancelled => 'Copia de seguridad cancelada.';

  @override
  String get dialogBackupFailed => 'Error en copia de seguridad';

  @override
  String get dialogRestoreTitle => 'Restaurar datos';

  @override
  String get dialogRestoreContent =>
      '¿Restaurar datos desde la copia de seguridad?\nEl orden y carpetas existentes pueden cambiar.';

  @override
  String get dialogRestoreSuccess => 'Restauración completada.';

  @override
  String get dialogRestoreFailed => 'Error en restauración';

  @override
  String get folderCreate => 'Crear carpeta';

  @override
  String get folderEdit => 'Editar carpeta';

  @override
  String get folderDelete => 'Eliminar carpeta';

  @override
  String get folderName => 'Nombre de carpeta';

  @override
  String get folderCreated => 'Carpeta creada.';

  @override
  String get folderUpdated => 'Carpeta actualizada.';

  @override
  String get folderDeleted => 'Carpeta eliminada.';

  @override
  String folderDeleteConfirm(String name) {
    return '¿Eliminar carpeta \"$name\"?';
  }

  @override
  String get folderManage => 'Gestionar carpetas';

  @override
  String get folderEmpty => 'Sin carpetas';

  @override
  String get folderCreateNew => 'Crear carpeta';

  @override
  String get create => 'Crear';

  @override
  String get edit => 'Editar';

  @override
  String get sectionHome => 'Inicio';

  @override
  String get sectionVideos => 'Videos';

  @override
  String get sectionShorts => 'Shorts';

  @override
  String get sectionLive => 'En vivo';

  @override
  String get sectionPodcasts => 'Podcasts';

  @override
  String get sectionPlaylists => 'Listas';

  @override
  String get sectionCommunity => 'Comunidad';

  @override
  String get confirm => 'OK';

  @override
  String get errorUnknown => 'Ocurrió un error desconocido.';

  @override
  String get errorNetwork => 'Por favor verifica tu conexión a internet.';

  @override
  String get errorUnauthorized => 'La sesión ha expirado.';

  @override
  String get errorQuotaExceeded =>
      'Cuota diaria de API de YouTube excedida.\nPor favor intenta después de las 5 PM (hora de Corea) mañana.';

  @override
  String get errorNotFound => 'No se encontraron los datos solicitados.';

  @override
  String get errorTimeout => 'La solicitud expiró.';

  @override
  String errorGeneric(String error) {
    return 'Ocurrió un error: $error';
  }

  @override
  String get appSubtitle => 'Gestor de suscripciones de YouTube';

  @override
  String get loadingVideos => 'Cargando videos...';

  @override
  String get allChannelsFilter => 'Suscrito';

  @override
  String get showFolderFab => 'Mostrar botón de carpeta';

  @override
  String get hideFolderFab => 'Ocultar botón de carpeta';

  @override
  String get refreshSubscriptions => 'Actualizar suscripciones';

  @override
  String get refreshPlaylists => 'Actualizar listas';

  @override
  String get fetchSubscriptionsTitle => 'Sin suscripciones';

  @override
  String get fetchSubscriptionsMessage =>
      '¿Desea obtener sus suscripciones de YouTube?';

  @override
  String get fetchSubscriptionsYes => 'Obtener';

  @override
  String get fetchSubscriptionsNo => 'Más tarde';

  @override
  String get createFolderDialogTitle => 'Sin carpetas';

  @override
  String get createFolderDialogMessage => '¿Desea crear una carpeta?';

  @override
  String get createFolderDialogYes => 'Crear';

  @override
  String get createFolderDialogNo => 'Más tarde';

  @override
  String get createFolderDialogDontShowAgain => 'No mostrar de nuevo';

  @override
  String get createFolderDialogManualGuide =>
      'Puede añadir carpetas más tarde en Ajustes > Gestionar carpetas.';

  @override
  String get swipeEnabledDescription =>
      'Solo las carpetas marcadas son accesibles al deslizar';

  @override
  String get filterByChannel => 'Filtrar por canal';

  @override
  String get allChannels => 'Todos';

  @override
  String get errorDetail => 'Detalles del error';

  @override
  String get viewErrorMessage => 'Ver mensaje de error';

  @override
  String get sortDialogTitle => 'Ordenar';

  @override
  String get sortPlaylistOrder => 'Orden de lista';

  @override
  String get sortPlaylistOrderReverse => 'Orden inverso de lista';

  @override
  String get sortNewest => 'Más recientes';

  @override
  String get sortOldest => 'Más antiguos';

  @override
  String get sortTitle => 'Título';

  @override
  String get loginSubtitle =>
      'Organiza libremente tus\nsuscripciones de YouTube';

  @override
  String get loginWithGoogle => 'Iniciar sesión con Google';

  @override
  String get loggingIn => 'Iniciando sesión...';

  @override
  String get loginPermissionNotice =>
      'Se requiere permiso de lectura de YouTube';

  @override
  String get loadingSubscriptions => 'Cargando suscripciones...';

  @override
  String get loginFailed => 'Error de inicio de sesión.';

  @override
  String get longPressReorder => 'Pulsación larga: Reordenar';

  @override
  String get longPressDelete => 'Pulsación larga: Eliminar';

  @override
  String get showDeleteConfirmation => 'Mostrar confirmación al eliminar';
}
