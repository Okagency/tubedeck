// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navChannels => 'Channels';

  @override
  String get navFeed => 'Feed';

  @override
  String get navFavorites => 'Favorites';

  @override
  String get navPlaylists => 'Playlists';

  @override
  String get navSettings => 'Settings';

  @override
  String get settingsSectionFolders => 'Folders';

  @override
  String get settingsFolderManage => 'Manage Folders';

  @override
  String get settingsFolderManageDesc => 'Add, edit, delete folders';

  @override
  String get settingsSectionDisplay => 'Display';

  @override
  String get settingsLanguage => 'Language / 언어';

  @override
  String get settingsLanguageSystem => 'System (시스템 설정)';

  @override
  String get settingsChipLayout => 'Folder Layout';

  @override
  String get settingsChipLayoutSingleLine => 'Single Line';

  @override
  String get settingsChipLayoutWrap => 'Wrap';

  @override
  String get chipLayoutToggleWrap => 'View Wrap Layout';

  @override
  String get chipLayoutToggleSingleLine => 'View Single Line';

  @override
  String get settingsFolderView => 'Folder View';

  @override
  String get settingsShowChannelCount => 'Show Channel Count';

  @override
  String get settingsShowVideoCount => 'Show Video Count';

  @override
  String get settingsFolderSizeLarge => 'Large';

  @override
  String get settingsFolderSizeSmall => 'Small';

  @override
  String get settingsDefaultChannelSection => 'YouTube Open Tab';

  @override
  String get settingsVideosPerChannel => 'Videos per Channel';

  @override
  String settingsVideosPerChannelCount(int count) {
    return '$count';
  }

  @override
  String get settingsCaptionDisplay => 'Caption Display';

  @override
  String get settingsCaptionShow => 'Show';

  @override
  String get settingsCaptionHide => 'Hide';

  @override
  String get settingsChannelTapAction => 'Channel Tap Action';

  @override
  String get settingsChannelTapLatestVideos => 'View Latest Videos';

  @override
  String get settingsChannelTapOpenYoutube => 'Open in YouTube';

  @override
  String get settingsVideoCardTapAction => 'Video Card Tap Action';

  @override
  String get settingsVideoCardTapInAppPlayer => 'In-App Player';

  @override
  String get settingsVideoCardTapOpenYoutube => 'Open in YouTube';

  @override
  String get settingsVideoCardLayoutStyle => 'Video Card Layout';

  @override
  String get settingsVideoCardLayoutHorizontal => 'Horizontal Card';

  @override
  String get settingsVideoCardLayoutVertical => 'Vertical Card';

  @override
  String get settingsMenuOrder => 'Menu Order';

  @override
  String get settingsMenuOrderDesc => 'Change bottom navigation bar order';

  @override
  String get settingsResetApp => 'Reset App';

  @override
  String get settingsSectionData => 'Data';

  @override
  String get settingsBackup => 'Backup Data';

  @override
  String get settingsRestore => 'Restore Data';

  @override
  String get settingsClearCache => 'Clear Image Cache';

  @override
  String get settingsSectionInfo => 'Information';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsLicense => 'Open Source Licenses';

  @override
  String get settingsSectionAccount => 'Account';

  @override
  String get settingsGoogleAccount => 'Google Account';

  @override
  String get settingsNotLoggedIn => 'Not logged in';

  @override
  String get settingsLogout => 'Logout';

  @override
  String get addToFolder => 'Add to Folder';

  @override
  String get sectionSettings => 'YouTube Open Tab';

  @override
  String subscriberCount(String count) {
    return '$count subscribers';
  }

  @override
  String channelsSelected(int count) {
    return '$count channels selected';
  }

  @override
  String itemsSelected(int count) {
    return '$count selected';
  }

  @override
  String get timeJustNow => 'Just now';

  @override
  String timeMinutesAgo(int count) {
    return '${count}m ago';
  }

  @override
  String timeHoursAgo(int count) {
    return '${count}h ago';
  }

  @override
  String timeDaysAgo(int count) {
    return '${count}d ago';
  }

  @override
  String timeWeeksAgo(int count) {
    return '${count}w ago';
  }

  @override
  String timeMonthsAgo(int count) {
    return '${count}mo ago';
  }

  @override
  String itemCount(int count) {
    return '$count items';
  }

  @override
  String get deleteConfirmTitle => 'Delete';

  @override
  String deleteSelectedVideosConfirm(int count) {
    return 'Delete $count selected videos?';
  }

  @override
  String get deleteFavoriteConfirm => 'Remove from favorites?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get selectAll => 'Select All';

  @override
  String get select => 'Select';

  @override
  String timeYearsAgo(int count) {
    return '${count}y ago';
  }

  @override
  String videoCount(int count) {
    return '$count videos';
  }

  @override
  String channelCount(int count) {
    return '$count channels';
  }

  @override
  String playlistCount(int count) {
    return '$count playlists loaded';
  }

  @override
  String get removeFromFolder => 'Remove from Folder';

  @override
  String get deleteChannel => 'Delete Channel';

  @override
  String deleteChannelConfirm(String name) {
    return 'Are you sure you want to completely delete $name?\nIt will be removed from all folders.';
  }

  @override
  String removeChannelConfirm(String name) {
    return 'Are you sure you want to remove $name from this collection?\nIt will remain in your subscriptions.';
  }

  @override
  String deleteChannelsConfirm(int count) {
    return 'Are you sure you want to completely delete $count channels?\nThey will be removed from all folders.';
  }

  @override
  String removeChannelsConfirm(int count) {
    return 'Are you sure you want to remove $count channels from this collection?\nThey will remain in your subscriptions.';
  }

  @override
  String get channelDeleted => 'Channel deleted';

  @override
  String get removedFromFolder => 'Removed from folder';

  @override
  String addedToFolder(String name) {
    return 'Added to $name';
  }

  @override
  String channelsDeleted(int count) {
    return '$count channels deleted';
  }

  @override
  String channelsRemoved(int count) {
    return '$count channels removed';
  }

  @override
  String channelsAddedTo(int count, String name) {
    return '$count channels added to $name';
  }

  @override
  String get cannotOpenChannel => 'Cannot open channel';

  @override
  String get pleaseSelectChannels => 'Please select channels';

  @override
  String get createFolderFirst => 'Please create a folder first';

  @override
  String get createCategoryFirst => 'Please create a category first';

  @override
  String get unsubscribed => 'Unsubscribed';

  @override
  String uploadedAgo(String time) {
    return 'uploaded $time';
  }

  @override
  String sectionSettingsTitle(String title) {
    return '$title\nOpen Tab Settings';
  }

  @override
  String useDefaultSection(String section) {
    return 'Use default ($section)';
  }

  @override
  String get sectionSetToDefault => 'Section set to default';

  @override
  String sectionSetTo(String section) {
    return 'Set to $section section';
  }

  @override
  String get channelsUpdated => 'Channel list updated';

  @override
  String get noSubscriptions => 'No subscribed channels';

  @override
  String get noSearchResults => 'No search results';

  @override
  String get cannotLoadPlaylists => 'Cannot load playlists';

  @override
  String get retry => 'Retry';

  @override
  String get noPlaylists => 'No playlists';

  @override
  String get noVideos => 'No videos';

  @override
  String get noFavorites => 'No favorited videos';

  @override
  String get customOrder => 'Custom order';

  @override
  String get alphabetical => 'Alphabetical';

  @override
  String get multiSelect => 'Multi select';

  @override
  String get openInYoutube => 'Open in YouTube';

  @override
  String get latestVideos => 'Latest videos';

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
  String get dialogLogoutTitle => 'Logout';

  @override
  String get dialogLogoutContent => 'Are you sure you want to logout?';

  @override
  String get dialogResetAppTitle => 'Reset App';

  @override
  String get dialogResetAppContent =>
      'All data will be deleted including subscriptions, folders, favorites, and playlists.\n\nDo you want to reset the app?';

  @override
  String get dialogResetAppSuccess => 'App has been reset.';

  @override
  String get dialogClearCacheTitle => 'Clear Cache';

  @override
  String get dialogClearCacheContent =>
      'Clear image cache?\nImages will be reloaded when you restart the app.';

  @override
  String get dialogClearCacheSuccess => 'Image cache cleared.';

  @override
  String get dialogClearCacheFailed => 'Failed to clear cache';

  @override
  String dialogBackupSuccess(String filePath) {
    return 'Backup completed.\nSaved to: $filePath';
  }

  @override
  String get dialogBackupCancelled => 'Backup cancelled.';

  @override
  String get dialogBackupFailed => 'Backup failed';

  @override
  String get dialogRestoreTitle => 'Restore Data';

  @override
  String get dialogRestoreContent =>
      'Restore data from backup file?\nExisting sort order and folders may be changed.';

  @override
  String get dialogRestoreSuccess => 'Restore completed.';

  @override
  String get dialogRestoreFailed => 'Restore failed';

  @override
  String get folderCreate => 'Create Folder';

  @override
  String get folderEdit => 'Edit Folder';

  @override
  String get folderDelete => 'Delete Folder';

  @override
  String get folderName => 'Folder name';

  @override
  String get folderCreated => 'Folder created.';

  @override
  String get folderUpdated => 'Folder updated.';

  @override
  String get folderDeleted => 'Folder deleted.';

  @override
  String folderDeleteConfirm(String name) {
    return 'Delete \"$name\" folder?';
  }

  @override
  String get folderManage => 'Manage Folders';

  @override
  String get folderEmpty => 'No folders';

  @override
  String get folderCreateNew => 'Create folder';

  @override
  String get create => 'Create';

  @override
  String get edit => 'Edit';

  @override
  String get sectionHome => 'Home';

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
  String get errorUnknown => 'An unknown error occurred.';

  @override
  String get errorNetwork => 'Please check your internet connection.';

  @override
  String get errorUnauthorized => 'Login has expired.';

  @override
  String get errorQuotaExceeded =>
      'YouTube API daily quota exceeded.\nPlease try again after 5 PM (Korea time) tomorrow.';

  @override
  String get errorNotFound => 'The requested data could not be found.';

  @override
  String get errorTimeout => 'Request timed out.';

  @override
  String errorGeneric(String error) {
    return 'An error occurred: $error';
  }

  @override
  String get appSubtitle => 'YouTube Subscription Manager';

  @override
  String get loadingVideos => 'Loading videos...';

  @override
  String get allChannelsFilter => 'Subscribed';

  @override
  String get showFolderFab => 'Show Folder Button';

  @override
  String get hideFolderFab => 'Hide Folder Button';

  @override
  String get refreshSubscriptions => 'Refresh Subscriptions';

  @override
  String get refreshPlaylists => 'Refresh Playlists';

  @override
  String get fetchSubscriptionsTitle => 'No Subscriptions';

  @override
  String get fetchSubscriptionsMessage =>
      'Would you like to fetch your YouTube subscriptions?';

  @override
  String get fetchSubscriptionsYes => 'Fetch';

  @override
  String get fetchSubscriptionsNo => 'Later';

  @override
  String get createFolderDialogTitle => 'No Folders';

  @override
  String get createFolderDialogMessage => 'Would you like to create a folder?';

  @override
  String get createFolderDialogYes => 'Create';

  @override
  String get createFolderDialogNo => 'Later';

  @override
  String get createFolderDialogDontShowAgain => 'Don\'t show again';

  @override
  String get createFolderDialogManualGuide =>
      'You can add folders later in Settings > Manage Folders.';

  @override
  String get swipeEnabledDescription =>
      'Only checked folders are accessible via swipe';

  @override
  String get filterByChannel => 'Filter by Channel';

  @override
  String get allChannels => 'All';

  @override
  String get errorDetail => 'Error Details';

  @override
  String get viewErrorMessage => 'View error message';

  @override
  String get sortDialogTitle => 'Sort';

  @override
  String get sortPlaylistOrder => 'Playlist Order';

  @override
  String get sortPlaylistOrderReverse => 'Playlist Order (Reverse)';

  @override
  String get sortNewest => 'Newest';

  @override
  String get sortOldest => 'Oldest';

  @override
  String get sortTitle => 'Title';

  @override
  String get loginSubtitle => 'Organize your YouTube\nsubscriptions freely';

  @override
  String get loginWithGoogle => 'Sign in with Google';

  @override
  String get loggingIn => 'Signing in...';

  @override
  String get loginPermissionNotice => 'YouTube read permission required';

  @override
  String get loadingSubscriptions => 'Loading subscriptions...';

  @override
  String get loginFailed => 'Login failed.';

  @override
  String get longPressReorder => 'Long press: Reorder';

  @override
  String get longPressDelete => 'Long press: Delete';

  @override
  String get showDeleteConfirmation => 'Show delete confirmation';
}
