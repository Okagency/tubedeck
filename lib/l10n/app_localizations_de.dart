// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get navChannels => 'Kanäle';

  @override
  String get navFeed => 'Feed';

  @override
  String get navFavorites => 'Favoriten';

  @override
  String get navPlaylists => 'Playlists';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get settingsSectionFolders => 'Ordner';

  @override
  String get settingsFolderManage => 'Ordner verwalten';

  @override
  String get settingsFolderManageDesc =>
      'Ordner hinzufügen, bearbeiten, löschen';

  @override
  String get settingsSectionDisplay => 'Anzeige';

  @override
  String get settingsLanguage => 'Sprache / Language';

  @override
  String get settingsLanguageSystem => 'System (System)';

  @override
  String get settingsChipLayout => 'Ordnerlayout';

  @override
  String get settingsChipLayoutSingleLine => 'Einzeilig';

  @override
  String get settingsChipLayoutWrap => 'Umbruch';

  @override
  String get chipLayoutToggleWrap => 'Umbruchansicht';

  @override
  String get chipLayoutToggleSingleLine => 'Einzeilige Ansicht';

  @override
  String get settingsFolderView => 'Ordneransicht';

  @override
  String get settingsShowChannelCount => 'Kanalanzahl anzeigen';

  @override
  String get settingsShowVideoCount => 'Videoanzahl anzeigen';

  @override
  String get settingsFolderSizeLarge => 'Groß';

  @override
  String get settingsFolderSizeSmall => 'Klein';

  @override
  String get settingsDefaultChannelSection => 'YouTube-Tab öffnen';

  @override
  String get settingsVideosPerChannel => 'Videos pro Kanal';

  @override
  String settingsVideosPerChannelCount(int count) {
    return '$count';
  }

  @override
  String get settingsCaptionDisplay => 'Untertitelanzeige';

  @override
  String get settingsCaptionShow => 'Anzeigen';

  @override
  String get settingsCaptionHide => 'Ausblenden';

  @override
  String get settingsChannelTapAction => 'Kanal-Tipp-Aktion';

  @override
  String get settingsChannelTapLatestVideos => 'Neueste Videos anzeigen';

  @override
  String get settingsChannelTapOpenYoutube => 'In YouTube öffnen';

  @override
  String get settingsVideoCardTapAction => 'Videokarten-Tipp-Aktion';

  @override
  String get settingsVideoCardTapInAppPlayer => 'In-App-Player';

  @override
  String get settingsVideoCardTapOpenYoutube => 'In YouTube öffnen';

  @override
  String get settingsVideoCardLayoutStyle => 'Videokarten-Layout';

  @override
  String get settingsVideoCardLayoutHorizontal => 'Horizontale Karte';

  @override
  String get settingsVideoCardLayoutVertical => 'Vertikale Karte';

  @override
  String get settingsMenuOrder => 'Menüreihenfolge';

  @override
  String get settingsMenuOrderDesc =>
      'Reihenfolge der unteren Navigationsleiste ändern';

  @override
  String get settingsResetApp => 'App zurücksetzen';

  @override
  String get settingsSectionData => 'Daten';

  @override
  String get settingsBackup => 'Daten sichern';

  @override
  String get settingsRestore => 'Daten wiederherstellen';

  @override
  String get settingsClearCache => 'Bildcache leeren';

  @override
  String get settingsSectionInfo => 'Information';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsLicense => 'Open-Source-Lizenzen';

  @override
  String get settingsSectionAccount => 'Konto';

  @override
  String get settingsGoogleAccount => 'Google-Konto';

  @override
  String get settingsNotLoggedIn => 'Nicht angemeldet';

  @override
  String get settingsLogout => 'Abmelden';

  @override
  String get addToFolder => 'Zu Ordner hinzufügen';

  @override
  String get sectionSettings => 'YouTube-Tab öffnen';

  @override
  String subscriberCount(String count) {
    return '$count Abonnenten';
  }

  @override
  String channelsSelected(int count) {
    return '$count Kanäle ausgewählt';
  }

  @override
  String itemsSelected(int count) {
    return '$count ausgewählt';
  }

  @override
  String get timeJustNow => 'Gerade eben';

  @override
  String timeMinutesAgo(int count) {
    return 'vor $count Min.';
  }

  @override
  String timeHoursAgo(int count) {
    return 'vor $count Std.';
  }

  @override
  String timeDaysAgo(int count) {
    return 'vor $count T.';
  }

  @override
  String timeWeeksAgo(int count) {
    return 'vor $count W.';
  }

  @override
  String timeMonthsAgo(int count) {
    return 'vor $count Mon.';
  }

  @override
  String itemCount(int count) {
    return '$count Elemente';
  }

  @override
  String get deleteConfirmTitle => 'Löschen bestätigen';

  @override
  String deleteSelectedVideosConfirm(int count) {
    return '$count ausgewählte Videos löschen?';
  }

  @override
  String get deleteFavoriteConfirm => 'Aus Favoriten entfernen?';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get selectAll => 'Alle auswählen';

  @override
  String get select => 'Auswählen';

  @override
  String timeYearsAgo(int count) {
    return 'vor $count J.';
  }

  @override
  String videoCount(int count) {
    return '$count Videos';
  }

  @override
  String channelCount(int count) {
    return '$count Kanäle';
  }

  @override
  String playlistCount(int count) {
    return '$count Playlists geladen';
  }

  @override
  String get removeFromFolder => 'Aus Ordner entfernen';

  @override
  String get deleteChannel => 'Kanal löschen';

  @override
  String deleteChannelConfirm(String name) {
    return 'Möchten Sie $name wirklich vollständig löschen?\nWird aus allen Ordnern entfernt.';
  }

  @override
  String removeChannelConfirm(String name) {
    return 'Möchten Sie $name wirklich aus diesem Ordner entfernen?\nDas Abonnement bleibt bestehen.';
  }

  @override
  String deleteChannelsConfirm(int count) {
    return 'Möchten Sie wirklich $count Kanäle vollständig löschen?\nSie werden aus allen Ordnern entfernt.';
  }

  @override
  String removeChannelsConfirm(int count) {
    return 'Möchten Sie wirklich $count Kanäle aus diesem Ordner entfernen?\nDie Abonnements bleiben bestehen.';
  }

  @override
  String get channelDeleted => 'Kanal gelöscht';

  @override
  String get removedFromFolder => 'Aus Ordner entfernt';

  @override
  String addedToFolder(String name) {
    return 'Zu $name hinzugefügt';
  }

  @override
  String channelsDeleted(int count) {
    return '$count Kanäle gelöscht';
  }

  @override
  String channelsRemoved(int count) {
    return '$count Kanäle entfernt';
  }

  @override
  String channelsAddedTo(int count, String name) {
    return '$count Kanäle zu $name hinzugefügt';
  }

  @override
  String get cannotOpenChannel => 'Kanal kann nicht geöffnet werden';

  @override
  String get pleaseSelectChannels => 'Bitte Kanäle auswählen';

  @override
  String get createFolderFirst => 'Bitte zuerst einen Ordner erstellen';

  @override
  String get createCategoryFirst => 'Bitte zuerst eine Kategorie erstellen';

  @override
  String get unsubscribed => 'Nicht abonniert';

  @override
  String uploadedAgo(String time) {
    return 'Hochgeladen $time';
  }

  @override
  String sectionSettingsTitle(String title) {
    return '$title\nBereichseinstellungen';
  }

  @override
  String useDefaultSection(String section) {
    return 'Standard verwenden ($section)';
  }

  @override
  String get sectionSetToDefault => 'Bereich auf Standard gesetzt';

  @override
  String sectionSetTo(String section) {
    return 'Auf $section Bereich gesetzt';
  }

  @override
  String get channelsUpdated => 'Kanalliste aktualisiert';

  @override
  String get noSubscriptions => 'Keine abonnierten Kanäle';

  @override
  String get noSearchResults => 'Keine Suchergebnisse';

  @override
  String get cannotLoadPlaylists => 'Playlists können nicht geladen werden';

  @override
  String get retry => 'Wiederholen';

  @override
  String get noPlaylists => 'Keine Playlists';

  @override
  String get noVideos => 'Keine Videos';

  @override
  String get noFavorites => 'Keine favorisierten Videos';

  @override
  String get customOrder => 'Benutzerdefinierte Reihenfolge';

  @override
  String get alphabetical => 'Alphabetisch';

  @override
  String get multiSelect => 'Mehrfachauswahl';

  @override
  String get openInYoutube => 'In YouTube öffnen';

  @override
  String get latestVideos => 'Neueste Videos';

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
  String get dialogLogoutTitle => 'Abmelden';

  @override
  String get dialogLogoutContent => 'Möchten Sie sich wirklich abmelden?';

  @override
  String get dialogResetAppTitle => 'App zurücksetzen';

  @override
  String get dialogResetAppContent =>
      'Alle Daten werden gelöscht, einschließlich Abonnements, Ordner, Favoriten und Playlists.\n\nMöchten Sie die App zurücksetzen?';

  @override
  String get dialogResetAppSuccess => 'Die App wurde zurückgesetzt.';

  @override
  String get dialogClearCacheTitle => 'Cache leeren';

  @override
  String get dialogClearCacheContent =>
      'Bildcache leeren?\nBilder werden beim Neustart der App neu geladen.';

  @override
  String get dialogClearCacheSuccess => 'Bildcache geleert.';

  @override
  String get dialogClearCacheFailed => 'Cache leeren fehlgeschlagen';

  @override
  String dialogBackupSuccess(String filePath) {
    return 'Sicherung abgeschlossen.\nGespeichert unter: $filePath';
  }

  @override
  String get dialogBackupCancelled => 'Sicherung abgebrochen.';

  @override
  String get dialogBackupFailed => 'Sicherung fehlgeschlagen';

  @override
  String get dialogRestoreTitle => 'Daten wiederherstellen';

  @override
  String get dialogRestoreContent =>
      'Daten aus Sicherungsdatei wiederherstellen?\nBestehende Sortierung und Ordner können geändert werden.';

  @override
  String get dialogRestoreSuccess => 'Wiederherstellung abgeschlossen.';

  @override
  String get dialogRestoreFailed => 'Wiederherstellung fehlgeschlagen';

  @override
  String get folderCreate => 'Ordner erstellen';

  @override
  String get folderEdit => 'Ordner bearbeiten';

  @override
  String get folderDelete => 'Ordner löschen';

  @override
  String get folderName => 'Ordnername';

  @override
  String get folderCreated => 'Ordner erstellt.';

  @override
  String get folderUpdated => 'Ordner aktualisiert.';

  @override
  String get folderDeleted => 'Ordner gelöscht.';

  @override
  String folderDeleteConfirm(String name) {
    return 'Ordner \"$name\" löschen?';
  }

  @override
  String get folderManage => 'Ordner verwalten';

  @override
  String get folderEmpty => 'Keine Ordner';

  @override
  String get folderCreateNew => 'Ordner erstellen';

  @override
  String get create => 'Erstellen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get sectionHome => 'Startseite';

  @override
  String get sectionVideos => 'Videos';

  @override
  String get sectionShorts => 'Shorts';

  @override
  String get sectionLive => 'Live';

  @override
  String get sectionPodcasts => 'Podcasts';

  @override
  String get sectionPlaylists => 'Playlists';

  @override
  String get sectionCommunity => 'Community';

  @override
  String get confirm => 'OK';

  @override
  String get errorUnknown => 'Ein unbekannter Fehler ist aufgetreten.';

  @override
  String get errorNetwork => 'Bitte überprüfen Sie Ihre Internetverbindung.';

  @override
  String get errorUnauthorized => 'Anmeldung abgelaufen.';

  @override
  String get errorQuotaExceeded =>
      'YouTube API-Tageskontingent überschritten.\nBitte versuchen Sie es morgen nach 17 Uhr (MEZ) erneut.';

  @override
  String get errorNotFound => 'Die angeforderten Daten wurden nicht gefunden.';

  @override
  String get errorTimeout => 'Zeitüberschreitung bei der Anfrage.';

  @override
  String errorGeneric(String error) {
    return 'Ein Fehler ist aufgetreten: $error';
  }

  @override
  String get appSubtitle => 'YouTube-Abonnement-Manager';

  @override
  String get loadingVideos => 'Videos werden geladen...';

  @override
  String get allChannelsFilter => 'Abonniert';

  @override
  String get showFolderFab => 'Ordnerschaltfläche anzeigen';

  @override
  String get hideFolderFab => 'Ordnerschaltfläche ausblenden';

  @override
  String get refreshSubscriptions => 'Abonnements aktualisieren';

  @override
  String get refreshPlaylists => 'Playlists aktualisieren';

  @override
  String get fetchSubscriptionsTitle => 'Keine Abonnements';

  @override
  String get fetchSubscriptionsMessage =>
      'Möchten Sie Ihre YouTube-Abonnements abrufen?';

  @override
  String get fetchSubscriptionsYes => 'Abrufen';

  @override
  String get fetchSubscriptionsNo => 'Später';

  @override
  String get createFolderDialogTitle => 'Keine Ordner';

  @override
  String get createFolderDialogMessage => 'Möchten Sie einen Ordner erstellen?';

  @override
  String get createFolderDialogYes => 'Erstellen';

  @override
  String get createFolderDialogNo => 'Später';

  @override
  String get createFolderDialogDontShowAgain => 'Nicht mehr anzeigen';

  @override
  String get createFolderDialogManualGuide =>
      'Sie können Ordner später unter Einstellungen > Ordner verwalten hinzufügen.';

  @override
  String get swipeEnabledDescription =>
      'Nur markierte Ordner sind per Wischen erreichbar';

  @override
  String get filterByChannel => 'Nach Kanal filtern';

  @override
  String get allChannels => 'Alle';

  @override
  String get errorDetail => 'Fehlerdetails';

  @override
  String get viewErrorMessage => 'Fehlermeldung anzeigen';

  @override
  String get sortDialogTitle => 'Sortieren';

  @override
  String get sortPlaylistOrder => 'Playlist-Reihenfolge';

  @override
  String get sortPlaylistOrderReverse => 'Playlist-Reihenfolge (umgekehrt)';

  @override
  String get sortNewest => 'Neueste';

  @override
  String get sortOldest => 'Älteste';

  @override
  String get sortTitle => 'Titel';

  @override
  String get loginSubtitle =>
      'Organisieren Sie Ihre YouTube-\nAbonnements frei';

  @override
  String get loginWithGoogle => 'Mit Google anmelden';

  @override
  String get loggingIn => 'Anmeldung läuft...';

  @override
  String get loginPermissionNotice => 'YouTube-Leseberechtigung erforderlich';

  @override
  String get loadingSubscriptions => 'Abonnements werden geladen...';

  @override
  String get loginFailed => 'Anmeldung fehlgeschlagen.';

  @override
  String get longPressReorder => 'Lange drücken: Sortieren';

  @override
  String get longPressDelete => 'Lange drücken: Löschen';

  @override
  String get showDeleteConfirmation => 'Löschbestätigung anzeigen';
}
