// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get navChannels => 'चैनल';

  @override
  String get navFeed => 'फ़ीड';

  @override
  String get navFavorites => 'पसंदीदा';

  @override
  String get navPlaylists => 'प्लेलिस्ट';

  @override
  String get navSettings => 'सेटिंग्स';

  @override
  String get settingsSectionFolders => 'फ़ोल्डर';

  @override
  String get settingsFolderManage => 'फ़ोल्डर प्रबंधित करें';

  @override
  String get settingsFolderManageDesc => 'फ़ोल्डर जोड़ें, संपादित करें, हटाएं';

  @override
  String get settingsSectionDisplay => 'प्रदर्शन';

  @override
  String get settingsLanguage => 'भाषा / Language';

  @override
  String get settingsLanguageSystem => 'सिस्टम (System)';

  @override
  String get settingsChipLayout => 'फ़ोल्डर लेआउट';

  @override
  String get settingsChipLayoutSingleLine => 'एक पंक्ति';

  @override
  String get settingsChipLayoutWrap => 'रैप';

  @override
  String get chipLayoutToggleWrap => 'रैप व्यू देखें';

  @override
  String get chipLayoutToggleSingleLine => 'एक पंक्ति व्यू देखें';

  @override
  String get settingsFolderView => 'फ़ोल्डर दृश्य';

  @override
  String get settingsShowChannelCount => 'चैनल संख्या दिखाएं';

  @override
  String get settingsShowVideoCount => 'वीडियो संख्या दिखाएं';

  @override
  String get settingsFolderSizeLarge => 'बड़ा';

  @override
  String get settingsFolderSizeSmall => 'छोटा';

  @override
  String get settingsDefaultChannelSection => 'YouTube टैब';

  @override
  String get settingsVideosPerChannel => 'प्रति चैनल वीडियो';

  @override
  String settingsVideosPerChannelCount(int count) {
    return '$count';
  }

  @override
  String get settingsCaptionDisplay => 'कैप्शन प्रदर्शन';

  @override
  String get settingsCaptionShow => 'दिखाएं';

  @override
  String get settingsCaptionHide => 'छुपाएं';

  @override
  String get settingsChannelTapAction => 'चैनल टैप क्रिया';

  @override
  String get settingsChannelTapLatestVideos => 'नवीनतम वीडियो देखें';

  @override
  String get settingsChannelTapOpenYoutube => 'YouTube में खोलें';

  @override
  String get settingsVideoCardTapAction => 'वीडियो कार्ड टैप क्रिया';

  @override
  String get settingsVideoCardTapInAppPlayer => 'इन-ऐप प्लेयर';

  @override
  String get settingsVideoCardTapOpenYoutube => 'YouTube में खोलें';

  @override
  String get settingsVideoCardLayoutStyle => 'वीडियो कार्ड लेआउट';

  @override
  String get settingsVideoCardLayoutHorizontal => 'क्षैतिज कार्ड';

  @override
  String get settingsVideoCardLayoutVertical => 'लंबवत कार्ड';

  @override
  String get settingsMenuOrder => 'मेनू क्रम';

  @override
  String get settingsMenuOrderDesc => 'नीचे नेविगेशन बार का क्रम बदलें';

  @override
  String get settingsResetApp => 'ऐप रीसेट करें';

  @override
  String get settingsSectionData => 'डेटा';

  @override
  String get settingsBackup => 'डेटा बैकअप';

  @override
  String get settingsRestore => 'डेटा पुनर्स्थापित करें';

  @override
  String get settingsClearCache => 'इमेज कैश साफ़ करें';

  @override
  String get settingsSectionInfo => 'जानकारी';

  @override
  String get settingsVersion => 'संस्करण';

  @override
  String get settingsLicense => 'ओपन सोर्स लाइसेंस';

  @override
  String get settingsSectionAccount => 'खाता';

  @override
  String get settingsGoogleAccount => 'Google खाता';

  @override
  String get settingsNotLoggedIn => 'लॉग इन नहीं है';

  @override
  String get settingsLogout => 'लॉग आउट';

  @override
  String get addToFolder => 'फ़ोल्डर में जोड़ें';

  @override
  String get sectionSettings => 'YouTube टैब';

  @override
  String subscriberCount(String count) {
    return '$count सदस्य';
  }

  @override
  String channelsSelected(int count) {
    return '$count चैनल चुने गए';
  }

  @override
  String itemsSelected(int count) {
    return '$count चुने गए';
  }

  @override
  String get timeJustNow => 'अभी';

  @override
  String timeMinutesAgo(int count) {
    return '$count मिनट पहले';
  }

  @override
  String timeHoursAgo(int count) {
    return '$count घंटे पहले';
  }

  @override
  String timeDaysAgo(int count) {
    return '$count दिन पहले';
  }

  @override
  String timeWeeksAgo(int count) {
    return '$count सप्ताह पहले';
  }

  @override
  String timeMonthsAgo(int count) {
    return '$count महीने पहले';
  }

  @override
  String itemCount(int count) {
    return '$count आइटम';
  }

  @override
  String get deleteConfirmTitle => 'हटाने की पुष्टि करें';

  @override
  String deleteSelectedVideosConfirm(int count) {
    return '$count चुने गए वीडियो हटाएं?';
  }

  @override
  String get deleteFavoriteConfirm => 'पसंदीदा से हटाएं?';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएं';

  @override
  String get selectAll => 'सभी चुनें';

  @override
  String get select => 'चुनें';

  @override
  String timeYearsAgo(int count) {
    return '$count साल पहले';
  }

  @override
  String videoCount(int count) {
    return '$count वीडियो';
  }

  @override
  String channelCount(int count) {
    return '$count चैनल';
  }

  @override
  String playlistCount(int count) {
    return '$count प्लेलिस्ट लोड हुई';
  }

  @override
  String get removeFromFolder => 'फ़ोल्डर से हटाएं';

  @override
  String get deleteChannel => 'चैनल हटाएं';

  @override
  String deleteChannelConfirm(String name) {
    return '$name को पूरी तरह हटाएं?\nसभी फ़ोल्डरों से हटा दिया जाएगा।';
  }

  @override
  String removeChannelConfirm(String name) {
    return '$name को इस फ़ोल्डर से हटाएं?\nआपकी सदस्यता में रहेगा।';
  }

  @override
  String deleteChannelsConfirm(int count) {
    return '$count चैनल पूरी तरह हटाएं?\nसभी फ़ोल्डरों से हटा दिए जाएंगे।';
  }

  @override
  String removeChannelsConfirm(int count) {
    return '$count चैनल इस फ़ोल्डर से हटाएं?\nआपकी सदस्यता में रहेंगे।';
  }

  @override
  String get channelDeleted => 'चैनल हटाया गया';

  @override
  String get removedFromFolder => 'फ़ोल्डर से हटाया गया';

  @override
  String addedToFolder(String name) {
    return '$name में जोड़ा गया';
  }

  @override
  String channelsDeleted(int count) {
    return '$count चैनल हटाए गए';
  }

  @override
  String channelsRemoved(int count) {
    return '$count चैनल हटाए गए';
  }

  @override
  String channelsAddedTo(int count, String name) {
    return '$count चैनल $name में जोड़े गए';
  }

  @override
  String get cannotOpenChannel => 'चैनल नहीं खोल सकते';

  @override
  String get pleaseSelectChannels => 'कृपया चैनल चुनें';

  @override
  String get createFolderFirst => 'कृपया पहले एक फ़ोल्डर बनाएं';

  @override
  String get createCategoryFirst => 'कृपया पहले एक श्रेणी बनाएं';

  @override
  String get unsubscribed => 'सदस्यता रद्द';

  @override
  String uploadedAgo(String time) {
    return '$time अपलोड किया';
  }

  @override
  String sectionSettingsTitle(String title) {
    return '$title\nअनुभाग सेटिंग्स';
  }

  @override
  String useDefaultSection(String section) {
    return 'डिफ़ॉल्ट उपयोग करें ($section)';
  }

  @override
  String get sectionSetToDefault => 'अनुभाग डिफ़ॉल्ट पर सेट';

  @override
  String sectionSetTo(String section) {
    return '$section अनुभाग पर सेट';
  }

  @override
  String get channelsUpdated => 'चैनल सूची अपडेट हुई';

  @override
  String get noSubscriptions => 'कोई सदस्यता नहीं';

  @override
  String get noSearchResults => 'कोई परिणाम नहीं';

  @override
  String get cannotLoadPlaylists => 'प्लेलिस्ट लोड नहीं हो सकती';

  @override
  String get retry => 'पुनः प्रयास करें';

  @override
  String get noPlaylists => 'कोई प्लेलिस्ट नहीं';

  @override
  String get noVideos => 'कोई वीडियो नहीं';

  @override
  String get noFavorites => 'कोई पसंदीदा वीडियो नहीं';

  @override
  String get customOrder => 'कस्टम क्रम';

  @override
  String get alphabetical => 'वर्णानुक्रम';

  @override
  String get multiSelect => 'बहु चयन';

  @override
  String get openInYoutube => 'YouTube में खोलें';

  @override
  String get latestVideos => 'नवीनतम वीडियो';

  @override
  String formatTenThousand(String count) {
    return '$countहज़ार';
  }

  @override
  String formatThousand(String count) {
    return '$countहज़ार';
  }

  @override
  String formatMillion(String count) {
    return '$countमिलियन';
  }

  @override
  String get dialogLogoutTitle => 'लॉग आउट';

  @override
  String get dialogLogoutContent => 'क्या आप लॉग आउट करना चाहते हैं?';

  @override
  String get dialogResetAppTitle => 'ऐप रीसेट करें';

  @override
  String get dialogResetAppContent =>
      'सदस्यताएं, फ़ोल्डर, पसंदीदा और प्लेलिस्ट सहित सभी डेटा हटा दिए जाएंगे।\n\nक्या आप ऐप रीसेट करना चाहते हैं?';

  @override
  String get dialogResetAppSuccess => 'ऐप रीसेट हो गया।';

  @override
  String get dialogClearCacheTitle => 'कैश साफ़ करें';

  @override
  String get dialogClearCacheContent =>
      'इमेज कैश साफ़ करें?\nऐप रीस्टार्ट होने पर इमेज फिर से लोड होंगी।';

  @override
  String get dialogClearCacheSuccess => 'इमेज कैश साफ़ हो गया।';

  @override
  String get dialogClearCacheFailed => 'कैश साफ़ करने में विफल';

  @override
  String dialogBackupSuccess(String filePath) {
    return 'बैकअप पूरा हुआ।\nसहेजा गया: $filePath';
  }

  @override
  String get dialogBackupCancelled => 'बैकअप रद्द किया गया।';

  @override
  String get dialogBackupFailed => 'बैकअप विफल';

  @override
  String get dialogRestoreTitle => 'डेटा पुनर्स्थापित करें';

  @override
  String get dialogRestoreContent =>
      'बैकअप से डेटा पुनर्स्थापित करें?\nमौजूदा क्रम और फ़ोल्डर बदल सकते हैं।';

  @override
  String get dialogRestoreSuccess => 'पुनर्स्थापना पूर्ण।';

  @override
  String get dialogRestoreFailed => 'पुनर्स्थापना विफल';

  @override
  String get folderCreate => 'फ़ोल्डर बनाएं';

  @override
  String get folderEdit => 'फ़ोल्डर संपादित करें';

  @override
  String get folderDelete => 'फ़ोल्डर हटाएं';

  @override
  String get folderName => 'फ़ोल्डर का नाम';

  @override
  String get folderCreated => 'फ़ोल्डर बनाया गया।';

  @override
  String get folderUpdated => 'फ़ोल्डर अपडेट किया गया।';

  @override
  String get folderDeleted => 'फ़ोल्डर हटाया गया।';

  @override
  String folderDeleteConfirm(String name) {
    return '\"$name\" फ़ोल्डर हटाएं?';
  }

  @override
  String get folderManage => 'फ़ोल्डर प्रबंधित करें';

  @override
  String get folderEmpty => 'कोई फ़ोल्डर नहीं';

  @override
  String get folderCreateNew => 'फ़ोल्डर बनाएं';

  @override
  String get create => 'बनाएं';

  @override
  String get edit => 'संपादित करें';

  @override
  String get sectionHome => 'होम';

  @override
  String get sectionVideos => 'वीडियो';

  @override
  String get sectionShorts => 'Shorts';

  @override
  String get sectionLive => 'लाइव';

  @override
  String get sectionPodcasts => 'पॉडकास्ट';

  @override
  String get sectionPlaylists => 'प्लेलिस्ट';

  @override
  String get sectionCommunity => 'समुदाय';

  @override
  String get confirm => 'ठीक है';

  @override
  String get errorUnknown => 'एक अज्ञात त्रुटि हुई।';

  @override
  String get errorNetwork => 'कृपया अपना इंटरनेट कनेक्शन जांचें।';

  @override
  String get errorUnauthorized => 'सत्र समाप्त हो गया।';

  @override
  String get errorQuotaExceeded =>
      'YouTube API दैनिक कोटा पार हो गया।\nकृपया कल शाम 5 बजे (कोरिया समय) के बाद पुनः प्रयास करें।';

  @override
  String get errorNotFound => 'अनुरोधित डेटा नहीं मिला।';

  @override
  String get errorTimeout => 'अनुरोध का समय समाप्त।';

  @override
  String errorGeneric(String error) {
    return 'एक त्रुटि हुई: $error';
  }

  @override
  String get appSubtitle => 'YouTube सदस्यता प्रबंधक';

  @override
  String get loadingVideos => 'वीडियो लोड हो रहे हैं...';

  @override
  String get allChannelsFilter => 'सदस्य';

  @override
  String get showFolderFab => 'फ़ोल्डर बटन दिखाएं';

  @override
  String get hideFolderFab => 'फ़ोल्डर बटन छिपाएं';

  @override
  String get refreshSubscriptions => 'सदस्यताएं रीफ़्रेश करें';

  @override
  String get refreshPlaylists => 'प्लेलिस्ट रीफ़्रेश करें';

  @override
  String get fetchSubscriptionsTitle => 'कोई सदस्यता नहीं';

  @override
  String get fetchSubscriptionsMessage =>
      'क्या आप अपनी YouTube सदस्यताएं प्राप्त करना चाहते हैं?';

  @override
  String get fetchSubscriptionsYes => 'प्राप्त करें';

  @override
  String get fetchSubscriptionsNo => 'बाद में';

  @override
  String get createFolderDialogTitle => 'कोई फ़ोल्डर नहीं';

  @override
  String get createFolderDialogMessage => 'क्या आप फ़ोल्डर बनाना चाहते हैं?';

  @override
  String get createFolderDialogYes => 'बनाएं';

  @override
  String get createFolderDialogNo => 'बाद में';

  @override
  String get createFolderDialogDontShowAgain => 'फिर से न दिखाएं';

  @override
  String get createFolderDialogManualGuide =>
      'आप बाद में सेटिंग्स > फ़ोल्डर प्रबंधित करें में फ़ोल्डर जोड़ सकते हैं।';

  @override
  String get swipeEnabledDescription =>
      'केवल चेक किए गए फ़ोल्डर स्वाइप से एक्सेस किए जा सकते हैं';

  @override
  String get filterByChannel => 'चैनल के अनुसार फ़िल्टर';

  @override
  String get allChannels => 'सभी';

  @override
  String get errorDetail => 'त्रुटि विवरण';

  @override
  String get viewErrorMessage => 'त्रुटि संदेश देखें';

  @override
  String get sortDialogTitle => 'क्रमबद्ध करें';

  @override
  String get sortPlaylistOrder => 'प्लेलिस्ट क्रम';

  @override
  String get sortPlaylistOrderReverse => 'प्लेलिस्ट उलटा क्रम';

  @override
  String get sortNewest => 'नवीनतम';

  @override
  String get sortOldest => 'सबसे पुराना';

  @override
  String get sortTitle => 'शीर्षक';

  @override
  String get loginSubtitle =>
      'अपनी YouTube सदस्यताओं को\nस्वतंत्र रूप से व्यवस्थित करें';

  @override
  String get loginWithGoogle => 'Google से साइन इन करें';

  @override
  String get loggingIn => 'साइन इन हो रहा है...';

  @override
  String get loginPermissionNotice => 'YouTube पढ़ने की अनुमति आवश्यक है';

  @override
  String get loadingSubscriptions => 'सदस्यताएं लोड हो रही हैं...';

  @override
  String get loginFailed => 'लॉगिन विफल।';

  @override
  String get longPressReorder => 'लंबे समय तक दबाएं: क्रम बदलें';

  @override
  String get longPressDelete => 'लंबे समय तक दबाएं: हटाएं';

  @override
  String get showDeleteConfirmation => 'हटाने की पुष्टि दिखाएं';
}
