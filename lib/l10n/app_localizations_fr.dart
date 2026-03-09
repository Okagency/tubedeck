// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get navChannels => 'Chaînes';

  @override
  String get navFeed => 'Fil';

  @override
  String get navFavorites => 'Favoris';

  @override
  String get navPlaylists => 'Playlists';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get settingsSectionFolders => 'Dossiers';

  @override
  String get settingsFolderManage => 'Gérer les dossiers';

  @override
  String get settingsFolderManageDesc =>
      'Ajouter, modifier, supprimer des dossiers';

  @override
  String get settingsSectionDisplay => 'Affichage';

  @override
  String get settingsLanguage => 'Langue / Language';

  @override
  String get settingsLanguageSystem => 'Système (System)';

  @override
  String get settingsChipLayout => 'Disposition des dossiers';

  @override
  String get settingsChipLayoutSingleLine => 'Une ligne';

  @override
  String get settingsChipLayoutWrap => 'Retour à la ligne';

  @override
  String get chipLayoutToggleWrap => 'Vue avec retour à la ligne';

  @override
  String get chipLayoutToggleSingleLine => 'Vue sur une ligne';

  @override
  String get settingsFolderView => 'Vue dossier';

  @override
  String get settingsShowChannelCount => 'Afficher le nombre de chaînes';

  @override
  String get settingsShowVideoCount => 'Afficher le nombre de vidéos';

  @override
  String get settingsFolderSizeLarge => 'Grand';

  @override
  String get settingsFolderSizeSmall => 'Petit';

  @override
  String get settingsDefaultChannelSection => 'Onglet YouTube';

  @override
  String get settingsVideosPerChannel => 'Vidéos par chaîne';

  @override
  String settingsVideosPerChannelCount(int count) {
    return '$count';
  }

  @override
  String get settingsCaptionDisplay => 'Affichage des sous-titres';

  @override
  String get settingsCaptionShow => 'Afficher';

  @override
  String get settingsCaptionHide => 'Masquer';

  @override
  String get settingsChannelTapAction => 'Action au toucher de chaîne';

  @override
  String get settingsChannelTapLatestVideos => 'Voir les dernières vidéos';

  @override
  String get settingsChannelTapOpenYoutube => 'Ouvrir dans YouTube';

  @override
  String get settingsVideoCardTapAction => 'Action au toucher de carte vidéo';

  @override
  String get settingsVideoCardTapInAppPlayer => 'Lecteur intégré';

  @override
  String get settingsVideoCardTapOpenYoutube => 'Ouvrir dans YouTube';

  @override
  String get settingsVideoCardLayoutStyle => 'Disposition des cartes vidéo';

  @override
  String get settingsVideoCardLayoutHorizontal => 'Carte horizontale';

  @override
  String get settingsVideoCardLayoutVertical => 'Carte verticale';

  @override
  String get settingsMenuOrder => 'Ordre du menu';

  @override
  String get settingsMenuOrderDesc =>
      'Modifier l\'ordre de la barre de navigation';

  @override
  String get settingsResetApp => 'Réinitialiser l\'application';

  @override
  String get settingsSectionData => 'Données';

  @override
  String get settingsBackup => 'Sauvegarder les données';

  @override
  String get settingsRestore => 'Restaurer les données';

  @override
  String get settingsClearCache => 'Vider le cache d\'images';

  @override
  String get settingsSectionInfo => 'Informations';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsLicense => 'Licences open source';

  @override
  String get settingsSectionAccount => 'Compte';

  @override
  String get settingsGoogleAccount => 'Compte Google';

  @override
  String get settingsNotLoggedIn => 'Non connecté';

  @override
  String get settingsLogout => 'Déconnexion';

  @override
  String get addToFolder => 'Ajouter au dossier';

  @override
  String get sectionSettings => 'Onglet YouTube';

  @override
  String subscriberCount(String count) {
    return '$count abonnés';
  }

  @override
  String channelsSelected(int count) {
    return '$count chaînes sélectionnées';
  }

  @override
  String itemsSelected(int count) {
    return '$count sélectionnés';
  }

  @override
  String get timeJustNow => 'À l\'instant';

  @override
  String timeMinutesAgo(int count) {
    return 'il y a $count min';
  }

  @override
  String timeHoursAgo(int count) {
    return 'il y a $count h';
  }

  @override
  String timeDaysAgo(int count) {
    return 'il y a $count j';
  }

  @override
  String timeWeeksAgo(int count) {
    return 'il y a $count sem';
  }

  @override
  String timeMonthsAgo(int count) {
    return 'il y a $count mois';
  }

  @override
  String itemCount(int count) {
    return '$count éléments';
  }

  @override
  String get deleteConfirmTitle => 'Confirmer la suppression';

  @override
  String deleteSelectedVideosConfirm(int count) {
    return 'Supprimer les $count vidéos sélectionnées ?';
  }

  @override
  String get deleteFavoriteConfirm => 'Retirer des favoris ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get selectAll => 'Tout sélectionner';

  @override
  String get select => 'Sélectionner';

  @override
  String timeYearsAgo(int count) {
    return 'il y a $count an(s)';
  }

  @override
  String videoCount(int count) {
    return '$count vidéos';
  }

  @override
  String channelCount(int count) {
    return '$count chaînes';
  }

  @override
  String playlistCount(int count) {
    return '$count playlists chargées';
  }

  @override
  String get removeFromFolder => 'Retirer du dossier';

  @override
  String get deleteChannel => 'Supprimer la chaîne';

  @override
  String deleteChannelConfirm(String name) {
    return 'Voulez-vous vraiment supprimer définitivement $name ?\nElle sera retirée de tous les dossiers.';
  }

  @override
  String removeChannelConfirm(String name) {
    return 'Voulez-vous vraiment retirer $name de ce dossier ?\nL\'abonnement sera conservé.';
  }

  @override
  String deleteChannelsConfirm(int count) {
    return 'Voulez-vous vraiment supprimer définitivement $count chaînes ?\nElles seront retirées de tous les dossiers.';
  }

  @override
  String removeChannelsConfirm(int count) {
    return 'Voulez-vous vraiment retirer $count chaînes de ce dossier ?\nLes abonnements seront conservés.';
  }

  @override
  String get channelDeleted => 'Chaîne supprimée';

  @override
  String get removedFromFolder => 'Retiré du dossier';

  @override
  String addedToFolder(String name) {
    return 'Ajouté à $name';
  }

  @override
  String channelsDeleted(int count) {
    return '$count chaînes supprimées';
  }

  @override
  String channelsRemoved(int count) {
    return '$count chaînes retirées';
  }

  @override
  String channelsAddedTo(int count, String name) {
    return '$count chaînes ajoutées à $name';
  }

  @override
  String get cannotOpenChannel => 'Impossible d\'ouvrir la chaîne';

  @override
  String get pleaseSelectChannels => 'Veuillez sélectionner des chaînes';

  @override
  String get createFolderFirst => 'Veuillez d\'abord créer un dossier';

  @override
  String get createCategoryFirst => 'Veuillez d\'abord créer une catégorie';

  @override
  String get unsubscribed => 'Désabonné';

  @override
  String uploadedAgo(String time) {
    return 'Mis en ligne $time';
  }

  @override
  String sectionSettingsTitle(String title) {
    return '$title\nParamètres de section';
  }

  @override
  String useDefaultSection(String section) {
    return 'Utiliser par défaut ($section)';
  }

  @override
  String get sectionSetToDefault => 'Section définie par défaut';

  @override
  String sectionSetTo(String section) {
    return 'Défini sur la section $section';
  }

  @override
  String get channelsUpdated => 'Liste des chaînes mise à jour';

  @override
  String get noSubscriptions => 'Aucune chaîne abonnée';

  @override
  String get noSearchResults => 'Aucun résultat';

  @override
  String get cannotLoadPlaylists => 'Impossible de charger les playlists';

  @override
  String get retry => 'Réessayer';

  @override
  String get noPlaylists => 'Aucune playlist';

  @override
  String get noVideos => 'Aucune vidéo';

  @override
  String get noFavorites => 'Aucune vidéo favorite';

  @override
  String get customOrder => 'Ordre personnalisé';

  @override
  String get alphabetical => 'Alphabétique';

  @override
  String get multiSelect => 'Sélection multiple';

  @override
  String get openInYoutube => 'Ouvrir dans YouTube';

  @override
  String get latestVideos => 'Dernières vidéos';

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
  String get dialogLogoutTitle => 'Déconnexion';

  @override
  String get dialogLogoutContent => 'Voulez-vous vraiment vous déconnecter ?';

  @override
  String get dialogResetAppTitle => 'Réinitialiser l\'application';

  @override
  String get dialogResetAppContent =>
      'Toutes les données seront supprimées, y compris les abonnements, dossiers, favoris et playlists.\n\nVoulez-vous réinitialiser l\'application ?';

  @override
  String get dialogResetAppSuccess => 'L\'application a été réinitialisée.';

  @override
  String get dialogClearCacheTitle => 'Vider le cache';

  @override
  String get dialogClearCacheContent =>
      'Vider le cache d\'images ?\nLes images seront rechargées au redémarrage de l\'application.';

  @override
  String get dialogClearCacheSuccess => 'Cache d\'images vidé.';

  @override
  String get dialogClearCacheFailed => 'Échec du vidage du cache';

  @override
  String dialogBackupSuccess(String filePath) {
    return 'Sauvegarde terminée.\nEnregistré dans : $filePath';
  }

  @override
  String get dialogBackupCancelled => 'Sauvegarde annulée.';

  @override
  String get dialogBackupFailed => 'Échec de la sauvegarde';

  @override
  String get dialogRestoreTitle => 'Restaurer les données';

  @override
  String get dialogRestoreContent =>
      'Restaurer les données depuis le fichier de sauvegarde ?\nL\'ordre de tri et les dossiers existants peuvent être modifiés.';

  @override
  String get dialogRestoreSuccess => 'Restauration terminée.';

  @override
  String get dialogRestoreFailed => 'Échec de la restauration';

  @override
  String get folderCreate => 'Créer un dossier';

  @override
  String get folderEdit => 'Modifier le dossier';

  @override
  String get folderDelete => 'Supprimer le dossier';

  @override
  String get folderName => 'Nom du dossier';

  @override
  String get folderCreated => 'Dossier créé.';

  @override
  String get folderUpdated => 'Dossier mis à jour.';

  @override
  String get folderDeleted => 'Dossier supprimé.';

  @override
  String folderDeleteConfirm(String name) {
    return 'Supprimer le dossier « $name » ?';
  }

  @override
  String get folderManage => 'Gérer les dossiers';

  @override
  String get folderEmpty => 'Aucun dossier';

  @override
  String get folderCreateNew => 'Créer un dossier';

  @override
  String get create => 'Créer';

  @override
  String get edit => 'Modifier';

  @override
  String get sectionHome => 'Accueil';

  @override
  String get sectionVideos => 'Vidéos';

  @override
  String get sectionShorts => 'Shorts';

  @override
  String get sectionLive => 'En direct';

  @override
  String get sectionPodcasts => 'Podcasts';

  @override
  String get sectionPlaylists => 'Playlists';

  @override
  String get sectionCommunity => 'Communauté';

  @override
  String get confirm => 'OK';

  @override
  String get errorUnknown => 'Une erreur inconnue s\'est produite.';

  @override
  String get errorNetwork => 'Veuillez vérifier votre connexion Internet.';

  @override
  String get errorUnauthorized => 'La session a expiré.';

  @override
  String get errorQuotaExceeded =>
      'Quota quotidien de l\'API YouTube dépassé.\nVeuillez réessayer demain après 17h (heure de Paris).';

  @override
  String get errorNotFound => 'Les données demandées n\'ont pas été trouvées.';

  @override
  String get errorTimeout => 'La requête a expiré.';

  @override
  String errorGeneric(String error) {
    return 'Une erreur s\'est produite : $error';
  }

  @override
  String get appSubtitle => 'Gestionnaire d\'abonnements YouTube';

  @override
  String get loadingVideos => 'Chargement des vidéos...';

  @override
  String get allChannelsFilter => 'Abonné';

  @override
  String get showFolderFab => 'Afficher le bouton Dossier';

  @override
  String get hideFolderFab => 'Masquer le bouton Dossier';

  @override
  String get refreshSubscriptions => 'Actualiser les abonnements';

  @override
  String get refreshPlaylists => 'Actualiser les playlists';

  @override
  String get fetchSubscriptionsTitle => 'Aucun abonnement';

  @override
  String get fetchSubscriptionsMessage =>
      'Voulez-vous récupérer vos abonnements YouTube ?';

  @override
  String get fetchSubscriptionsYes => 'Récupérer';

  @override
  String get fetchSubscriptionsNo => 'Plus tard';

  @override
  String get createFolderDialogTitle => 'Aucun dossier';

  @override
  String get createFolderDialogMessage => 'Voulez-vous créer un dossier ?';

  @override
  String get createFolderDialogYes => 'Créer';

  @override
  String get createFolderDialogNo => 'Plus tard';

  @override
  String get createFolderDialogDontShowAgain => 'Ne plus afficher';

  @override
  String get createFolderDialogManualGuide =>
      'Vous pouvez ajouter des dossiers plus tard dans Paramètres > Gérer les dossiers.';

  @override
  String get swipeEnabledDescription =>
      'Seuls les dossiers cochés sont accessibles par balayage';

  @override
  String get filterByChannel => 'Filtrer par chaîne';

  @override
  String get allChannels => 'Toutes';

  @override
  String get errorDetail => 'Détails de l\'erreur';

  @override
  String get viewErrorMessage => 'Voir le message d\'erreur';

  @override
  String get sortDialogTitle => 'Trier';

  @override
  String get sortPlaylistOrder => 'Ordre de la playlist';

  @override
  String get sortPlaylistOrderReverse => 'Ordre inverse de la playlist';

  @override
  String get sortNewest => 'Plus récents';

  @override
  String get sortOldest => 'Plus anciens';

  @override
  String get sortTitle => 'Titre';

  @override
  String get loginSubtitle => 'Organisez librement vos\nabonnements YouTube';

  @override
  String get loginWithGoogle => 'Se connecter avec Google';

  @override
  String get loggingIn => 'Connexion en cours...';

  @override
  String get loginPermissionNotice => 'Autorisation de lecture YouTube requise';

  @override
  String get loadingSubscriptions => 'Chargement des abonnements...';

  @override
  String get loginFailed => 'Échec de la connexion.';

  @override
  String get longPressReorder => 'Appui long: Réorganiser';

  @override
  String get longPressDelete => 'Appui long: Supprimer';

  @override
  String get showDeleteConfirmation =>
      'Afficher la confirmation de suppression';
}
