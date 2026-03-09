import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('th'),
    Locale('tr'),
    Locale('vi'),
    Locale('zh'),
    Locale('zh', 'TW'),
  ];

  /// Navigation menu label for channels screen
  ///
  /// In en, this message translates to:
  /// **'Channels'**
  String get navChannels;

  /// Navigation menu label for feed screen
  ///
  /// In en, this message translates to:
  /// **'Feed'**
  String get navFeed;

  /// Navigation menu label for favorites screen
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get navFavorites;

  /// Navigation menu label for playlists screen
  ///
  /// In en, this message translates to:
  /// **'Playlists'**
  String get navPlaylists;

  /// Navigation menu label for settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @settingsSectionFolders.
  ///
  /// In en, this message translates to:
  /// **'Folders'**
  String get settingsSectionFolders;

  /// No description provided for @settingsFolderManage.
  ///
  /// In en, this message translates to:
  /// **'Manage Folders'**
  String get settingsFolderManage;

  /// No description provided for @settingsFolderManageDesc.
  ///
  /// In en, this message translates to:
  /// **'Add, edit, delete folders'**
  String get settingsFolderManageDesc;

  /// No description provided for @settingsSectionDisplay.
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get settingsSectionDisplay;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language / 언어'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System (시스템 설정)'**
  String get settingsLanguageSystem;

  /// No description provided for @settingsChipLayout.
  ///
  /// In en, this message translates to:
  /// **'Folder Layout'**
  String get settingsChipLayout;

  /// No description provided for @settingsChipLayoutSingleLine.
  ///
  /// In en, this message translates to:
  /// **'Single Line'**
  String get settingsChipLayoutSingleLine;

  /// No description provided for @settingsChipLayoutWrap.
  ///
  /// In en, this message translates to:
  /// **'Wrap'**
  String get settingsChipLayoutWrap;

  /// No description provided for @chipLayoutToggleWrap.
  ///
  /// In en, this message translates to:
  /// **'View Wrap Layout'**
  String get chipLayoutToggleWrap;

  /// No description provided for @chipLayoutToggleSingleLine.
  ///
  /// In en, this message translates to:
  /// **'View Single Line'**
  String get chipLayoutToggleSingleLine;

  /// No description provided for @settingsFolderView.
  ///
  /// In en, this message translates to:
  /// **'Folder View'**
  String get settingsFolderView;

  /// No description provided for @settingsShowChannelCount.
  ///
  /// In en, this message translates to:
  /// **'Show Channel Count'**
  String get settingsShowChannelCount;

  /// No description provided for @settingsShowVideoCount.
  ///
  /// In en, this message translates to:
  /// **'Show Video Count'**
  String get settingsShowVideoCount;

  /// No description provided for @settingsFolderSizeLarge.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get settingsFolderSizeLarge;

  /// No description provided for @settingsFolderSizeSmall.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get settingsFolderSizeSmall;

  /// No description provided for @settingsDefaultChannelSection.
  ///
  /// In en, this message translates to:
  /// **'YouTube Open Tab'**
  String get settingsDefaultChannelSection;

  /// No description provided for @settingsVideosPerChannel.
  ///
  /// In en, this message translates to:
  /// **'Videos per Channel'**
  String get settingsVideosPerChannel;

  /// No description provided for @settingsVideosPerChannelCount.
  ///
  /// In en, this message translates to:
  /// **'{count}'**
  String settingsVideosPerChannelCount(int count);

  /// No description provided for @settingsCaptionDisplay.
  ///
  /// In en, this message translates to:
  /// **'Caption Display'**
  String get settingsCaptionDisplay;

  /// No description provided for @settingsCaptionShow.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get settingsCaptionShow;

  /// No description provided for @settingsCaptionHide.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get settingsCaptionHide;

  /// No description provided for @settingsChannelTapAction.
  ///
  /// In en, this message translates to:
  /// **'Channel Tap Action'**
  String get settingsChannelTapAction;

  /// No description provided for @settingsChannelTapLatestVideos.
  ///
  /// In en, this message translates to:
  /// **'View Latest Videos'**
  String get settingsChannelTapLatestVideos;

  /// No description provided for @settingsChannelTapOpenYoutube.
  ///
  /// In en, this message translates to:
  /// **'Open in YouTube'**
  String get settingsChannelTapOpenYoutube;

  /// No description provided for @settingsVideoCardTapAction.
  ///
  /// In en, this message translates to:
  /// **'Video Card Tap Action'**
  String get settingsVideoCardTapAction;

  /// No description provided for @settingsVideoCardTapInAppPlayer.
  ///
  /// In en, this message translates to:
  /// **'In-App Player'**
  String get settingsVideoCardTapInAppPlayer;

  /// No description provided for @settingsVideoCardTapOpenYoutube.
  ///
  /// In en, this message translates to:
  /// **'Open in YouTube'**
  String get settingsVideoCardTapOpenYoutube;

  /// No description provided for @settingsVideoCardLayoutStyle.
  ///
  /// In en, this message translates to:
  /// **'Video Card Layout'**
  String get settingsVideoCardLayoutStyle;

  /// No description provided for @settingsVideoCardLayoutHorizontal.
  ///
  /// In en, this message translates to:
  /// **'Horizontal Card'**
  String get settingsVideoCardLayoutHorizontal;

  /// No description provided for @settingsVideoCardLayoutVertical.
  ///
  /// In en, this message translates to:
  /// **'Vertical Card'**
  String get settingsVideoCardLayoutVertical;

  /// No description provided for @settingsMenuOrder.
  ///
  /// In en, this message translates to:
  /// **'Menu Order'**
  String get settingsMenuOrder;

  /// No description provided for @settingsMenuOrderDesc.
  ///
  /// In en, this message translates to:
  /// **'Change bottom navigation bar order'**
  String get settingsMenuOrderDesc;

  /// No description provided for @settingsResetApp.
  ///
  /// In en, this message translates to:
  /// **'Reset App'**
  String get settingsResetApp;

  /// No description provided for @settingsSectionData.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get settingsSectionData;

  /// No description provided for @settingsBackup.
  ///
  /// In en, this message translates to:
  /// **'Backup Data'**
  String get settingsBackup;

  /// No description provided for @settingsRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore Data'**
  String get settingsRestore;

  /// No description provided for @settingsClearCache.
  ///
  /// In en, this message translates to:
  /// **'Clear Image Cache'**
  String get settingsClearCache;

  /// No description provided for @settingsSectionInfo.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get settingsSectionInfo;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settingsVersion;

  /// No description provided for @settingsLicense.
  ///
  /// In en, this message translates to:
  /// **'Open Source Licenses'**
  String get settingsLicense;

  /// No description provided for @settingsSectionAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsSectionAccount;

  /// No description provided for @settingsGoogleAccount.
  ///
  /// In en, this message translates to:
  /// **'Google Account'**
  String get settingsGoogleAccount;

  /// No description provided for @settingsNotLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'Not logged in'**
  String get settingsNotLoggedIn;

  /// No description provided for @settingsLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settingsLogout;

  /// No description provided for @addToFolder.
  ///
  /// In en, this message translates to:
  /// **'Add to Folder'**
  String get addToFolder;

  /// No description provided for @sectionSettings.
  ///
  /// In en, this message translates to:
  /// **'YouTube Open Tab'**
  String get sectionSettings;

  /// No description provided for @subscriberCount.
  ///
  /// In en, this message translates to:
  /// **'{count} subscribers'**
  String subscriberCount(String count);

  /// No description provided for @channelsSelected.
  ///
  /// In en, this message translates to:
  /// **'{count} channels selected'**
  String channelsSelected(int count);

  /// No description provided for @itemsSelected.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String itemsSelected(int count);

  /// No description provided for @timeJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get timeJustNow;

  /// No description provided for @timeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}m ago'**
  String timeMinutesAgo(int count);

  /// No description provided for @timeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}h ago'**
  String timeHoursAgo(int count);

  /// No description provided for @timeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}d ago'**
  String timeDaysAgo(int count);

  /// No description provided for @timeWeeksAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}w ago'**
  String timeWeeksAgo(int count);

  /// No description provided for @timeMonthsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}mo ago'**
  String timeMonthsAgo(int count);

  /// No description provided for @itemCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String itemCount(int count);

  /// No description provided for @deleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteConfirmTitle;

  /// No description provided for @deleteSelectedVideosConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete {count} selected videos?'**
  String deleteSelectedVideosConfirm(int count);

  /// No description provided for @deleteFavoriteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites?'**
  String get deleteFavoriteConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAll;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @timeYearsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}y ago'**
  String timeYearsAgo(int count);

  /// No description provided for @videoCount.
  ///
  /// In en, this message translates to:
  /// **'{count} videos'**
  String videoCount(int count);

  /// No description provided for @channelCount.
  ///
  /// In en, this message translates to:
  /// **'{count} channels'**
  String channelCount(int count);

  /// No description provided for @playlistCount.
  ///
  /// In en, this message translates to:
  /// **'{count} playlists loaded'**
  String playlistCount(int count);

  /// No description provided for @removeFromFolder.
  ///
  /// In en, this message translates to:
  /// **'Remove from Folder'**
  String get removeFromFolder;

  /// No description provided for @deleteChannel.
  ///
  /// In en, this message translates to:
  /// **'Delete Channel'**
  String get deleteChannel;

  /// No description provided for @deleteChannelConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to completely delete {name}?\nIt will be removed from all folders.'**
  String deleteChannelConfirm(String name);

  /// No description provided for @removeChannelConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove {name} from this collection?\nIt will remain in your subscriptions.'**
  String removeChannelConfirm(String name);

  /// No description provided for @deleteChannelsConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to completely delete {count} channels?\nThey will be removed from all folders.'**
  String deleteChannelsConfirm(int count);

  /// No description provided for @removeChannelsConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove {count} channels from this collection?\nThey will remain in your subscriptions.'**
  String removeChannelsConfirm(int count);

  /// No description provided for @channelDeleted.
  ///
  /// In en, this message translates to:
  /// **'Channel deleted'**
  String get channelDeleted;

  /// No description provided for @removedFromFolder.
  ///
  /// In en, this message translates to:
  /// **'Removed from folder'**
  String get removedFromFolder;

  /// No description provided for @addedToFolder.
  ///
  /// In en, this message translates to:
  /// **'Added to {name}'**
  String addedToFolder(String name);

  /// No description provided for @channelsDeleted.
  ///
  /// In en, this message translates to:
  /// **'{count} channels deleted'**
  String channelsDeleted(int count);

  /// No description provided for @channelsRemoved.
  ///
  /// In en, this message translates to:
  /// **'{count} channels removed'**
  String channelsRemoved(int count);

  /// No description provided for @channelsAddedTo.
  ///
  /// In en, this message translates to:
  /// **'{count} channels added to {name}'**
  String channelsAddedTo(int count, String name);

  /// No description provided for @cannotOpenChannel.
  ///
  /// In en, this message translates to:
  /// **'Cannot open channel'**
  String get cannotOpenChannel;

  /// No description provided for @pleaseSelectChannels.
  ///
  /// In en, this message translates to:
  /// **'Please select channels'**
  String get pleaseSelectChannels;

  /// No description provided for @createFolderFirst.
  ///
  /// In en, this message translates to:
  /// **'Please create a folder first'**
  String get createFolderFirst;

  /// No description provided for @createCategoryFirst.
  ///
  /// In en, this message translates to:
  /// **'Please create a category first'**
  String get createCategoryFirst;

  /// No description provided for @unsubscribed.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribed'**
  String get unsubscribed;

  /// No description provided for @uploadedAgo.
  ///
  /// In en, this message translates to:
  /// **'uploaded {time}'**
  String uploadedAgo(String time);

  /// No description provided for @sectionSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'{title}\nOpen Tab Settings'**
  String sectionSettingsTitle(String title);

  /// No description provided for @useDefaultSection.
  ///
  /// In en, this message translates to:
  /// **'Use default ({section})'**
  String useDefaultSection(String section);

  /// No description provided for @sectionSetToDefault.
  ///
  /// In en, this message translates to:
  /// **'Section set to default'**
  String get sectionSetToDefault;

  /// No description provided for @sectionSetTo.
  ///
  /// In en, this message translates to:
  /// **'Set to {section} section'**
  String sectionSetTo(String section);

  /// No description provided for @channelsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Channel list updated'**
  String get channelsUpdated;

  /// No description provided for @noSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'No subscribed channels'**
  String get noSubscriptions;

  /// No description provided for @noSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No search results'**
  String get noSearchResults;

  /// No description provided for @cannotLoadPlaylists.
  ///
  /// In en, this message translates to:
  /// **'Cannot load playlists'**
  String get cannotLoadPlaylists;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noPlaylists.
  ///
  /// In en, this message translates to:
  /// **'No playlists'**
  String get noPlaylists;

  /// No description provided for @noVideos.
  ///
  /// In en, this message translates to:
  /// **'No videos'**
  String get noVideos;

  /// No description provided for @noFavorites.
  ///
  /// In en, this message translates to:
  /// **'No favorited videos'**
  String get noFavorites;

  /// No description provided for @customOrder.
  ///
  /// In en, this message translates to:
  /// **'Custom order'**
  String get customOrder;

  /// No description provided for @alphabetical.
  ///
  /// In en, this message translates to:
  /// **'Alphabetical'**
  String get alphabetical;

  /// No description provided for @multiSelect.
  ///
  /// In en, this message translates to:
  /// **'Multi select'**
  String get multiSelect;

  /// No description provided for @openInYoutube.
  ///
  /// In en, this message translates to:
  /// **'Open in YouTube'**
  String get openInYoutube;

  /// No description provided for @latestVideos.
  ///
  /// In en, this message translates to:
  /// **'Latest videos'**
  String get latestVideos;

  /// No description provided for @formatTenThousand.
  ///
  /// In en, this message translates to:
  /// **'{count}K'**
  String formatTenThousand(String count);

  /// No description provided for @formatThousand.
  ///
  /// In en, this message translates to:
  /// **'{count}K'**
  String formatThousand(String count);

  /// No description provided for @formatMillion.
  ///
  /// In en, this message translates to:
  /// **'{count}M'**
  String formatMillion(String count);

  /// No description provided for @dialogLogoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get dialogLogoutTitle;

  /// No description provided for @dialogLogoutContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get dialogLogoutContent;

  /// No description provided for @dialogResetAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset App'**
  String get dialogResetAppTitle;

  /// No description provided for @dialogResetAppContent.
  ///
  /// In en, this message translates to:
  /// **'All data will be deleted including subscriptions, folders, favorites, and playlists.\n\nDo you want to reset the app?'**
  String get dialogResetAppContent;

  /// No description provided for @dialogResetAppSuccess.
  ///
  /// In en, this message translates to:
  /// **'App has been reset.'**
  String get dialogResetAppSuccess;

  /// No description provided for @dialogClearCacheTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear Cache'**
  String get dialogClearCacheTitle;

  /// No description provided for @dialogClearCacheContent.
  ///
  /// In en, this message translates to:
  /// **'Clear image cache?\nImages will be reloaded when you restart the app.'**
  String get dialogClearCacheContent;

  /// No description provided for @dialogClearCacheSuccess.
  ///
  /// In en, this message translates to:
  /// **'Image cache cleared.'**
  String get dialogClearCacheSuccess;

  /// No description provided for @dialogClearCacheFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to clear cache'**
  String get dialogClearCacheFailed;

  /// No description provided for @dialogBackupSuccess.
  ///
  /// In en, this message translates to:
  /// **'Backup completed.\nSaved to: {filePath}'**
  String dialogBackupSuccess(String filePath);

  /// No description provided for @dialogBackupCancelled.
  ///
  /// In en, this message translates to:
  /// **'Backup cancelled.'**
  String get dialogBackupCancelled;

  /// No description provided for @dialogBackupFailed.
  ///
  /// In en, this message translates to:
  /// **'Backup failed'**
  String get dialogBackupFailed;

  /// No description provided for @dialogRestoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore Data'**
  String get dialogRestoreTitle;

  /// No description provided for @dialogRestoreContent.
  ///
  /// In en, this message translates to:
  /// **'Restore data from backup file?\nExisting sort order and folders may be changed.'**
  String get dialogRestoreContent;

  /// No description provided for @dialogRestoreSuccess.
  ///
  /// In en, this message translates to:
  /// **'Restore completed.'**
  String get dialogRestoreSuccess;

  /// No description provided for @dialogRestoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Restore failed'**
  String get dialogRestoreFailed;

  /// No description provided for @folderCreate.
  ///
  /// In en, this message translates to:
  /// **'Create Folder'**
  String get folderCreate;

  /// No description provided for @folderEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Folder'**
  String get folderEdit;

  /// No description provided for @folderDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete Folder'**
  String get folderDelete;

  /// No description provided for @folderName.
  ///
  /// In en, this message translates to:
  /// **'Folder name'**
  String get folderName;

  /// No description provided for @folderCreated.
  ///
  /// In en, this message translates to:
  /// **'Folder created.'**
  String get folderCreated;

  /// No description provided for @folderUpdated.
  ///
  /// In en, this message translates to:
  /// **'Folder updated.'**
  String get folderUpdated;

  /// No description provided for @folderDeleted.
  ///
  /// In en, this message translates to:
  /// **'Folder deleted.'**
  String get folderDeleted;

  /// No description provided for @folderDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\" folder?'**
  String folderDeleteConfirm(String name);

  /// No description provided for @folderManage.
  ///
  /// In en, this message translates to:
  /// **'Manage Folders'**
  String get folderManage;

  /// No description provided for @folderEmpty.
  ///
  /// In en, this message translates to:
  /// **'No folders'**
  String get folderEmpty;

  /// No description provided for @folderCreateNew.
  ///
  /// In en, this message translates to:
  /// **'Create folder'**
  String get folderCreateNew;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @sectionHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get sectionHome;

  /// No description provided for @sectionVideos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get sectionVideos;

  /// No description provided for @sectionShorts.
  ///
  /// In en, this message translates to:
  /// **'Shorts'**
  String get sectionShorts;

  /// No description provided for @sectionLive.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get sectionLive;

  /// No description provided for @sectionPodcasts.
  ///
  /// In en, this message translates to:
  /// **'Podcasts'**
  String get sectionPodcasts;

  /// No description provided for @sectionPlaylists.
  ///
  /// In en, this message translates to:
  /// **'Playlists'**
  String get sectionPlaylists;

  /// No description provided for @sectionCommunity.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get sectionCommunity;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get confirm;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred.'**
  String get errorUnknown;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection.'**
  String get errorNetwork;

  /// No description provided for @errorUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'Login has expired.'**
  String get errorUnauthorized;

  /// No description provided for @errorQuotaExceeded.
  ///
  /// In en, this message translates to:
  /// **'YouTube API daily quota exceeded.\nPlease try again after 5 PM (Korea time) tomorrow.'**
  String get errorQuotaExceeded;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'The requested data could not be found.'**
  String get errorNotFound;

  /// No description provided for @errorTimeout.
  ///
  /// In en, this message translates to:
  /// **'Request timed out.'**
  String get errorTimeout;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {error}'**
  String errorGeneric(String error);

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'YouTube Subscription Manager'**
  String get appSubtitle;

  /// No description provided for @loadingVideos.
  ///
  /// In en, this message translates to:
  /// **'Loading videos...'**
  String get loadingVideos;

  /// No description provided for @allChannelsFilter.
  ///
  /// In en, this message translates to:
  /// **'Subscribed'**
  String get allChannelsFilter;

  /// No description provided for @showFolderFab.
  ///
  /// In en, this message translates to:
  /// **'Show Folder Button'**
  String get showFolderFab;

  /// No description provided for @hideFolderFab.
  ///
  /// In en, this message translates to:
  /// **'Hide Folder Button'**
  String get hideFolderFab;

  /// No description provided for @refreshSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Refresh Subscriptions'**
  String get refreshSubscriptions;

  /// No description provided for @refreshPlaylists.
  ///
  /// In en, this message translates to:
  /// **'Refresh Playlists'**
  String get refreshPlaylists;

  /// No description provided for @fetchSubscriptionsTitle.
  ///
  /// In en, this message translates to:
  /// **'No Subscriptions'**
  String get fetchSubscriptionsTitle;

  /// No description provided for @fetchSubscriptionsMessage.
  ///
  /// In en, this message translates to:
  /// **'Would you like to fetch your YouTube subscriptions?'**
  String get fetchSubscriptionsMessage;

  /// No description provided for @fetchSubscriptionsYes.
  ///
  /// In en, this message translates to:
  /// **'Fetch'**
  String get fetchSubscriptionsYes;

  /// No description provided for @fetchSubscriptionsNo.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get fetchSubscriptionsNo;

  /// No description provided for @createFolderDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'No Folders'**
  String get createFolderDialogTitle;

  /// No description provided for @createFolderDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Would you like to create a folder?'**
  String get createFolderDialogMessage;

  /// No description provided for @createFolderDialogYes.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createFolderDialogYes;

  /// No description provided for @createFolderDialogNo.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get createFolderDialogNo;

  /// No description provided for @createFolderDialogDontShowAgain.
  ///
  /// In en, this message translates to:
  /// **'Don\'t show again'**
  String get createFolderDialogDontShowAgain;

  /// No description provided for @createFolderDialogManualGuide.
  ///
  /// In en, this message translates to:
  /// **'You can add folders later in Settings > Manage Folders.'**
  String get createFolderDialogManualGuide;

  /// No description provided for @swipeEnabledDescription.
  ///
  /// In en, this message translates to:
  /// **'Only checked folders are accessible via swipe'**
  String get swipeEnabledDescription;

  /// No description provided for @filterByChannel.
  ///
  /// In en, this message translates to:
  /// **'Filter by Channel'**
  String get filterByChannel;

  /// No description provided for @allChannels.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allChannels;

  /// No description provided for @errorDetail.
  ///
  /// In en, this message translates to:
  /// **'Error Details'**
  String get errorDetail;

  /// No description provided for @viewErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'View error message'**
  String get viewErrorMessage;

  /// No description provided for @sortDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sortDialogTitle;

  /// No description provided for @sortPlaylistOrder.
  ///
  /// In en, this message translates to:
  /// **'Playlist Order'**
  String get sortPlaylistOrder;

  /// No description provided for @sortPlaylistOrderReverse.
  ///
  /// In en, this message translates to:
  /// **'Playlist Order (Reverse)'**
  String get sortPlaylistOrderReverse;

  /// No description provided for @sortNewest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get sortNewest;

  /// No description provided for @sortOldest.
  ///
  /// In en, this message translates to:
  /// **'Oldest'**
  String get sortOldest;

  /// No description provided for @sortTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get sortTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Organize your YouTube\nsubscriptions freely'**
  String get loginSubtitle;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get loginWithGoogle;

  /// No description provided for @loggingIn.
  ///
  /// In en, this message translates to:
  /// **'Signing in...'**
  String get loggingIn;

  /// No description provided for @loginPermissionNotice.
  ///
  /// In en, this message translates to:
  /// **'YouTube read permission required'**
  String get loginPermissionNotice;

  /// No description provided for @loadingSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Loading subscriptions...'**
  String get loadingSubscriptions;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed.'**
  String get loginFailed;

  /// No description provided for @longPressReorder.
  ///
  /// In en, this message translates to:
  /// **'Long press: Reorder'**
  String get longPressReorder;

  /// No description provided for @longPressDelete.
  ///
  /// In en, this message translates to:
  /// **'Long press: Delete'**
  String get longPressDelete;

  /// No description provided for @showDeleteConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Show delete confirmation'**
  String get showDeleteConfirmation;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'id',
    'it',
    'ja',
    'ko',
    'pt',
    'ru',
    'th',
    'tr',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'TW':
            return AppLocalizationsZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'th':
      return AppLocalizationsTh();
    case 'tr':
      return AppLocalizationsTr();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
