// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get navChannels => 'Canali';

  @override
  String get navFeed => 'Feed';

  @override
  String get navFavorites => 'Preferiti';

  @override
  String get navPlaylists => 'Playlist';

  @override
  String get navSettings => 'Impostazioni';

  @override
  String get settingsSectionFolders => 'Cartelle';

  @override
  String get settingsFolderManage => 'Gestisci cartelle';

  @override
  String get settingsFolderManageDesc => 'Aggiungi, modifica, elimina cartelle';

  @override
  String get settingsSectionDisplay => 'Visualizzazione';

  @override
  String get settingsLanguage => 'Lingua / Language';

  @override
  String get settingsLanguageSystem => 'Sistema (System)';

  @override
  String get settingsChipLayout => 'Layout cartella';

  @override
  String get settingsChipLayoutSingleLine => 'Linea singola';

  @override
  String get settingsChipLayoutWrap => 'A capo';

  @override
  String get chipLayoutToggleWrap => 'Vista a capo';

  @override
  String get chipLayoutToggleSingleLine => 'Vista linea singola';

  @override
  String get settingsFolderView => 'Vista cartella';

  @override
  String get settingsShowChannelCount => 'Mostra numero canali';

  @override
  String get settingsShowVideoCount => 'Mostra numero video';

  @override
  String get settingsFolderSizeLarge => 'Grande';

  @override
  String get settingsFolderSizeSmall => 'Piccolo';

  @override
  String get settingsDefaultChannelSection => 'Scheda YouTube';

  @override
  String get settingsVideosPerChannel => 'Video per canale';

  @override
  String settingsVideosPerChannelCount(int count) {
    return '$count';
  }

  @override
  String get settingsCaptionDisplay => 'Visualizzazione sottotitoli';

  @override
  String get settingsCaptionShow => 'Mostra';

  @override
  String get settingsCaptionHide => 'Nascondi';

  @override
  String get settingsChannelTapAction => 'Azione tocco canale';

  @override
  String get settingsChannelTapLatestVideos => 'Visualizza ultimi video';

  @override
  String get settingsChannelTapOpenYoutube => 'Apri in YouTube';

  @override
  String get settingsVideoCardTapAction => 'Azione tocco scheda video';

  @override
  String get settingsVideoCardTapInAppPlayer => 'Player integrato';

  @override
  String get settingsVideoCardTapOpenYoutube => 'Apri in YouTube';

  @override
  String get settingsVideoCardLayoutStyle => 'Layout scheda video';

  @override
  String get settingsVideoCardLayoutHorizontal => 'Scheda orizzontale';

  @override
  String get settingsVideoCardLayoutVertical => 'Scheda verticale';

  @override
  String get settingsMenuOrder => 'Ordine menu';

  @override
  String get settingsMenuOrderDesc => 'Modifica ordine barra di navigazione';

  @override
  String get settingsResetApp => 'Reimposta app';

  @override
  String get settingsSectionData => 'Dati';

  @override
  String get settingsBackup => 'Backup dati';

  @override
  String get settingsRestore => 'Ripristina dati';

  @override
  String get settingsClearCache => 'Svuota cache immagini';

  @override
  String get settingsSectionInfo => 'Informazioni';

  @override
  String get settingsVersion => 'Versione';

  @override
  String get settingsLicense => 'Licenze open source';

  @override
  String get settingsSectionAccount => 'Account';

  @override
  String get settingsGoogleAccount => 'Account Google';

  @override
  String get settingsNotLoggedIn => 'Non connesso';

  @override
  String get settingsLogout => 'Esci';

  @override
  String get addToFolder => 'Aggiungi a cartella';

  @override
  String get sectionSettings => 'Scheda YouTube';

  @override
  String subscriberCount(String count) {
    return '$count iscritti';
  }

  @override
  String channelsSelected(int count) {
    return '$count canali selezionati';
  }

  @override
  String itemsSelected(int count) {
    return '$count selezionati';
  }

  @override
  String get timeJustNow => 'Adesso';

  @override
  String timeMinutesAgo(int count) {
    return '$count min fa';
  }

  @override
  String timeHoursAgo(int count) {
    return '$count ore fa';
  }

  @override
  String timeDaysAgo(int count) {
    return '$count g fa';
  }

  @override
  String timeWeeksAgo(int count) {
    return '$count sett fa';
  }

  @override
  String timeMonthsAgo(int count) {
    return '$count mesi fa';
  }

  @override
  String itemCount(int count) {
    return '$count elementi';
  }

  @override
  String get deleteConfirmTitle => 'Conferma eliminazione';

  @override
  String deleteSelectedVideosConfirm(int count) {
    return 'Eliminare $count video selezionati?';
  }

  @override
  String get deleteFavoriteConfirm => 'Rimuovere dai preferiti?';

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String get selectAll => 'Seleziona tutto';

  @override
  String get select => 'Seleziona';

  @override
  String timeYearsAgo(int count) {
    return '$count anni fa';
  }

  @override
  String videoCount(int count) {
    return '$count video';
  }

  @override
  String channelCount(int count) {
    return '$count canali';
  }

  @override
  String playlistCount(int count) {
    return '$count playlist caricate';
  }

  @override
  String get removeFromFolder => 'Rimuovi da cartella';

  @override
  String get deleteChannel => 'Elimina canale';

  @override
  String deleteChannelConfirm(String name) {
    return 'Eliminare completamente $name?\nVerrà rimosso da tutte le cartelle.';
  }

  @override
  String removeChannelConfirm(String name) {
    return 'Rimuovere $name da questa cartella?\nResterà nelle tue iscrizioni.';
  }

  @override
  String deleteChannelsConfirm(int count) {
    return 'Eliminare completamente $count canali?\nVerranno rimossi da tutte le cartelle.';
  }

  @override
  String removeChannelsConfirm(int count) {
    return 'Rimuovere $count canali da questa cartella?\nResteranno nelle tue iscrizioni.';
  }

  @override
  String get channelDeleted => 'Canale eliminato';

  @override
  String get removedFromFolder => 'Rimosso dalla cartella';

  @override
  String addedToFolder(String name) {
    return 'Aggiunto a $name';
  }

  @override
  String channelsDeleted(int count) {
    return '$count canali eliminati';
  }

  @override
  String channelsRemoved(int count) {
    return '$count canali rimossi';
  }

  @override
  String channelsAddedTo(int count, String name) {
    return '$count canali aggiunti a $name';
  }

  @override
  String get cannotOpenChannel => 'Impossibile aprire il canale';

  @override
  String get pleaseSelectChannels => 'Seleziona dei canali';

  @override
  String get createFolderFirst => 'Crea prima una cartella';

  @override
  String get createCategoryFirst => 'Crea prima una categoria';

  @override
  String get unsubscribed => 'Iscrizione annullata';

  @override
  String uploadedAgo(String time) {
    return 'caricato $time';
  }

  @override
  String sectionSettingsTitle(String title) {
    return '$title\nImpostazioni sezione';
  }

  @override
  String useDefaultSection(String section) {
    return 'Usa predefinito ($section)';
  }

  @override
  String get sectionSetToDefault => 'Sezione impostata come predefinita';

  @override
  String sectionSetTo(String section) {
    return 'Impostato su sezione $section';
  }

  @override
  String get channelsUpdated => 'Elenco canali aggiornato';

  @override
  String get noSubscriptions => 'Nessun canale iscritto';

  @override
  String get noSearchResults => 'Nessun risultato';

  @override
  String get cannotLoadPlaylists => 'Impossibile caricare le playlist';

  @override
  String get retry => 'Riprova';

  @override
  String get noPlaylists => 'Nessuna playlist';

  @override
  String get noVideos => 'Nessun video';

  @override
  String get noFavorites => 'Nessun video preferito';

  @override
  String get customOrder => 'Ordine personalizzato';

  @override
  String get alphabetical => 'Alfabetico';

  @override
  String get multiSelect => 'Selezione multipla';

  @override
  String get openInYoutube => 'Apri in YouTube';

  @override
  String get latestVideos => 'Ultimi video';

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
  String get dialogLogoutTitle => 'Esci';

  @override
  String get dialogLogoutContent => 'Vuoi davvero uscire?';

  @override
  String get dialogResetAppTitle => 'Reimposta app';

  @override
  String get dialogResetAppContent =>
      'Tutti i dati verranno eliminati, inclusi iscrizioni, cartelle, preferiti e playlist.\n\nVuoi reimpostare l\'app?';

  @override
  String get dialogResetAppSuccess => 'L\'app è stata reimpostata.';

  @override
  String get dialogClearCacheTitle => 'Svuota cache';

  @override
  String get dialogClearCacheContent =>
      'Svuotare la cache delle immagini?\nLe immagini verranno ricaricate al riavvio dell\'app.';

  @override
  String get dialogClearCacheSuccess => 'Cache immagini svuotata.';

  @override
  String get dialogClearCacheFailed => 'Impossibile svuotare la cache';

  @override
  String dialogBackupSuccess(String filePath) {
    return 'Backup completato.\nSalvato in: $filePath';
  }

  @override
  String get dialogBackupCancelled => 'Backup annullato.';

  @override
  String get dialogBackupFailed => 'Backup fallito';

  @override
  String get dialogRestoreTitle => 'Ripristina dati';

  @override
  String get dialogRestoreContent =>
      'Ripristinare i dati dal backup?\nL\'ordine e le cartelle esistenti potrebbero cambiare.';

  @override
  String get dialogRestoreSuccess => 'Ripristino completato.';

  @override
  String get dialogRestoreFailed => 'Ripristino fallito';

  @override
  String get folderCreate => 'Crea cartella';

  @override
  String get folderEdit => 'Modifica cartella';

  @override
  String get folderDelete => 'Elimina cartella';

  @override
  String get folderName => 'Nome cartella';

  @override
  String get folderCreated => 'Cartella creata.';

  @override
  String get folderUpdated => 'Cartella aggiornata.';

  @override
  String get folderDeleted => 'Cartella eliminata.';

  @override
  String folderDeleteConfirm(String name) {
    return 'Eliminare la cartella \"$name\"?';
  }

  @override
  String get folderManage => 'Gestisci cartelle';

  @override
  String get folderEmpty => 'Nessuna cartella';

  @override
  String get folderCreateNew => 'Crea cartella';

  @override
  String get create => 'Crea';

  @override
  String get edit => 'Modifica';

  @override
  String get sectionHome => 'Home';

  @override
  String get sectionVideos => 'Video';

  @override
  String get sectionShorts => 'Shorts';

  @override
  String get sectionLive => 'Dal vivo';

  @override
  String get sectionPodcasts => 'Podcast';

  @override
  String get sectionPlaylists => 'Playlist';

  @override
  String get sectionCommunity => 'Community';

  @override
  String get confirm => 'OK';

  @override
  String get errorUnknown => 'Si è verificato un errore sconosciuto.';

  @override
  String get errorNetwork => 'Controlla la tua connessione internet.';

  @override
  String get errorUnauthorized => 'La sessione è scaduta.';

  @override
  String get errorQuotaExceeded =>
      'Quota giornaliera API YouTube superata.\nRiprova dopo le 17:00 (ora coreana) domani.';

  @override
  String get errorNotFound => 'I dati richiesti non sono stati trovati.';

  @override
  String get errorTimeout => 'Richiesta scaduta.';

  @override
  String errorGeneric(String error) {
    return 'Si è verificato un errore: $error';
  }

  @override
  String get appSubtitle => 'Gestore iscrizioni YouTube';

  @override
  String get loadingVideos => 'Caricamento video...';

  @override
  String get allChannelsFilter => 'Iscritto';

  @override
  String get showFolderFab => 'Mostra pulsante cartella';

  @override
  String get hideFolderFab => 'Nascondi pulsante cartella';

  @override
  String get refreshSubscriptions => 'Aggiorna iscrizioni';

  @override
  String get refreshPlaylists => 'Aggiorna playlist';

  @override
  String get fetchSubscriptionsTitle => 'Nessuna Iscrizione';

  @override
  String get fetchSubscriptionsMessage =>
      'Vuoi recuperare le tue iscrizioni YouTube?';

  @override
  String get fetchSubscriptionsYes => 'Recupera';

  @override
  String get fetchSubscriptionsNo => 'Più tardi';

  @override
  String get createFolderDialogTitle => 'Nessuna Cartella';

  @override
  String get createFolderDialogMessage => 'Vuoi creare una cartella?';

  @override
  String get createFolderDialogYes => 'Crea';

  @override
  String get createFolderDialogNo => 'Più tardi';

  @override
  String get createFolderDialogDontShowAgain => 'Non mostrare più';

  @override
  String get createFolderDialogManualGuide =>
      'Puoi aggiungere cartelle più tardi in Impostazioni > Gestisci cartelle.';

  @override
  String get swipeEnabledDescription =>
      'Solo le cartelle selezionate sono accessibili tramite scorrimento';

  @override
  String get filterByChannel => 'Filtra per canale';

  @override
  String get allChannels => 'Tutti';

  @override
  String get errorDetail => 'Dettagli errore';

  @override
  String get viewErrorMessage => 'Visualizza messaggio di errore';

  @override
  String get sortDialogTitle => 'Ordina';

  @override
  String get sortPlaylistOrder => 'Ordine playlist';

  @override
  String get sortPlaylistOrderReverse => 'Ordine playlist (inverso)';

  @override
  String get sortNewest => 'Più recenti';

  @override
  String get sortOldest => 'Più vecchi';

  @override
  String get sortTitle => 'Titolo';

  @override
  String get loginSubtitle =>
      'Organizza liberamente le tue\niscrizioni YouTube';

  @override
  String get loginWithGoogle => 'Accedi con Google';

  @override
  String get loggingIn => 'Accesso in corso...';

  @override
  String get loginPermissionNotice =>
      'Richiesta autorizzazione lettura YouTube';

  @override
  String get loadingSubscriptions => 'Caricamento iscrizioni...';

  @override
  String get loginFailed => 'Accesso non riuscito.';

  @override
  String get longPressReorder => 'Pressione lunga: Riordina';

  @override
  String get longPressDelete => 'Pressione lunga: Elimina';

  @override
  String get showDeleteConfirmation => 'Mostra conferma eliminazione';
}
