// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get navChannels => 'القنوات';

  @override
  String get navFeed => 'الخلاصة';

  @override
  String get navFavorites => 'المفضلة';

  @override
  String get navPlaylists => 'قوائم التشغيل';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get settingsSectionFolders => 'المجلدات';

  @override
  String get settingsFolderManage => 'إدارة المجلدات';

  @override
  String get settingsFolderManageDesc => 'إضافة، تعديل، حذف المجلدات';

  @override
  String get settingsSectionDisplay => 'العرض';

  @override
  String get settingsLanguage => 'اللغة / Language';

  @override
  String get settingsLanguageSystem => 'النظام (System)';

  @override
  String get settingsChipLayout => 'تخطيط المجلد';

  @override
  String get settingsChipLayoutSingleLine => 'سطر واحد';

  @override
  String get settingsChipLayoutWrap => 'التفاف';

  @override
  String get chipLayoutToggleWrap => 'عرض مع التفاف';

  @override
  String get chipLayoutToggleSingleLine => 'عرض سطر واحد';

  @override
  String get settingsFolderView => 'عرض المجلد';

  @override
  String get settingsShowChannelCount => 'إظهار عدد القنوات';

  @override
  String get settingsShowVideoCount => 'إظهار عدد الفيديوهات';

  @override
  String get settingsFolderSizeLarge => 'كبير';

  @override
  String get settingsFolderSizeSmall => 'صغير';

  @override
  String get settingsDefaultChannelSection => 'علامة تبويب يوتيوب';

  @override
  String get settingsVideosPerChannel => 'فيديوهات لكل قناة';

  @override
  String settingsVideosPerChannelCount(int count) {
    return '$count';
  }

  @override
  String get settingsCaptionDisplay => 'عرض الترجمة';

  @override
  String get settingsCaptionShow => 'إظهار';

  @override
  String get settingsCaptionHide => 'إخفاء';

  @override
  String get settingsChannelTapAction => 'إجراء النقر على القناة';

  @override
  String get settingsChannelTapLatestVideos => 'عرض أحدث الفيديوهات';

  @override
  String get settingsChannelTapOpenYoutube => 'فتح في YouTube';

  @override
  String get settingsVideoCardTapAction => 'إجراء النقر على الفيديو';

  @override
  String get settingsVideoCardTapInAppPlayer => 'المشغل المدمج';

  @override
  String get settingsVideoCardTapOpenYoutube => 'فتح في YouTube';

  @override
  String get settingsVideoCardLayoutStyle => 'تخطيط بطاقة الفيديو';

  @override
  String get settingsVideoCardLayoutHorizontal => 'بطاقة أفقية';

  @override
  String get settingsVideoCardLayoutVertical => 'بطاقة عمودية';

  @override
  String get settingsMenuOrder => 'ترتيب القائمة';

  @override
  String get settingsMenuOrderDesc => 'تغيير ترتيب شريط التنقل';

  @override
  String get settingsResetApp => 'إعادة ضبط التطبيق';

  @override
  String get settingsSectionData => 'البيانات';

  @override
  String get settingsBackup => 'نسخ احتياطي';

  @override
  String get settingsRestore => 'استعادة البيانات';

  @override
  String get settingsClearCache => 'مسح ذاكرة التخزين المؤقت';

  @override
  String get settingsSectionInfo => 'المعلومات';

  @override
  String get settingsVersion => 'الإصدار';

  @override
  String get settingsLicense => 'تراخيص المصدر المفتوح';

  @override
  String get settingsSectionAccount => 'الحساب';

  @override
  String get settingsGoogleAccount => 'حساب Google';

  @override
  String get settingsNotLoggedIn => 'غير مسجل الدخول';

  @override
  String get settingsLogout => 'تسجيل الخروج';

  @override
  String get addToFolder => 'إضافة إلى مجلد';

  @override
  String get sectionSettings => 'علامة تبويب يوتيوب';

  @override
  String subscriberCount(String count) {
    return '$count مشترك';
  }

  @override
  String channelsSelected(int count) {
    return '$count قنوات محددة';
  }

  @override
  String itemsSelected(int count) {
    return '$count محدد';
  }

  @override
  String get timeJustNow => 'الآن';

  @override
  String timeMinutesAgo(int count) {
    return 'منذ $count دقيقة';
  }

  @override
  String timeHoursAgo(int count) {
    return 'منذ $count ساعة';
  }

  @override
  String timeDaysAgo(int count) {
    return 'منذ $count يوم';
  }

  @override
  String timeWeeksAgo(int count) {
    return 'منذ $count أسبوع';
  }

  @override
  String timeMonthsAgo(int count) {
    return 'منذ $count شهر';
  }

  @override
  String itemCount(int count) {
    return '$count عنصر';
  }

  @override
  String get deleteConfirmTitle => 'تأكيد الحذف';

  @override
  String deleteSelectedVideosConfirm(int count) {
    return 'حذف $count فيديو محدد؟';
  }

  @override
  String get deleteFavoriteConfirm => 'إزالة من المفضلة؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get selectAll => 'تحديد الكل';

  @override
  String get select => 'تحديد';

  @override
  String timeYearsAgo(int count) {
    return 'منذ $count سنة';
  }

  @override
  String videoCount(int count) {
    return '$count فيديو';
  }

  @override
  String channelCount(int count) {
    return '$count قناة';
  }

  @override
  String playlistCount(int count) {
    return '$count قائمة تشغيل محملة';
  }

  @override
  String get removeFromFolder => 'إزالة من المجلد';

  @override
  String get deleteChannel => 'حذف القناة';

  @override
  String deleteChannelConfirm(String name) {
    return 'حذف $name نهائياً؟\nسيتم إزالتها من جميع المجلدات.';
  }

  @override
  String removeChannelConfirm(String name) {
    return 'إزالة $name من هذا المجلد؟\nستبقى في اشتراكاتك.';
  }

  @override
  String deleteChannelsConfirm(int count) {
    return 'حذف $count قناة نهائياً؟\nسيتم إزالتها من جميع المجلدات.';
  }

  @override
  String removeChannelsConfirm(int count) {
    return 'إزالة $count قناة من هذا المجلد؟\nستبقى في اشتراكاتك.';
  }

  @override
  String get channelDeleted => 'تم حذف القناة';

  @override
  String get removedFromFolder => 'تمت الإزالة من المجلد';

  @override
  String addedToFolder(String name) {
    return 'تمت الإضافة إلى $name';
  }

  @override
  String channelsDeleted(int count) {
    return 'تم حذف $count قناة';
  }

  @override
  String channelsRemoved(int count) {
    return 'تمت إزالة $count قناة';
  }

  @override
  String channelsAddedTo(int count, String name) {
    return 'تمت إضافة $count قناة إلى $name';
  }

  @override
  String get cannotOpenChannel => 'لا يمكن فتح القناة';

  @override
  String get pleaseSelectChannels => 'يرجى تحديد القنوات';

  @override
  String get createFolderFirst => 'يرجى إنشاء مجلد أولاً';

  @override
  String get createCategoryFirst => 'يرجى إنشاء فئة أولاً';

  @override
  String get unsubscribed => 'تم إلغاء الاشتراك';

  @override
  String uploadedAgo(String time) {
    return 'تم الرفع $time';
  }

  @override
  String sectionSettingsTitle(String title) {
    return '$title\nإعدادات القسم';
  }

  @override
  String useDefaultSection(String section) {
    return 'استخدام الافتراضي ($section)';
  }

  @override
  String get sectionSetToDefault => 'تم ضبط القسم كافتراضي';

  @override
  String sectionSetTo(String section) {
    return 'تم الضبط على قسم $section';
  }

  @override
  String get channelsUpdated => 'تم تحديث قائمة القنوات';

  @override
  String get noSubscriptions => 'لا توجد اشتراكات';

  @override
  String get noSearchResults => 'لا توجد نتائج';

  @override
  String get cannotLoadPlaylists => 'لا يمكن تحميل قوائم التشغيل';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get noPlaylists => 'لا توجد قوائم تشغيل';

  @override
  String get noVideos => 'لا توجد فيديوهات';

  @override
  String get noFavorites => 'لا توجد فيديوهات مفضلة';

  @override
  String get customOrder => 'ترتيب مخصص';

  @override
  String get alphabetical => 'أبجدي';

  @override
  String get multiSelect => 'تحديد متعدد';

  @override
  String get openInYoutube => 'فتح في YouTube';

  @override
  String get latestVideos => 'أحدث الفيديوهات';

  @override
  String formatTenThousand(String count) {
    return '$countألف';
  }

  @override
  String formatThousand(String count) {
    return '$countألف';
  }

  @override
  String formatMillion(String count) {
    return '$countمليون';
  }

  @override
  String get dialogLogoutTitle => 'تسجيل الخروج';

  @override
  String get dialogLogoutContent => 'هل تريد تسجيل الخروج؟';

  @override
  String get dialogResetAppTitle => 'إعادة ضبط التطبيق';

  @override
  String get dialogResetAppContent =>
      'سيتم حذف جميع البيانات، بما في ذلك الاشتراكات والمجلدات والمفضلة وقوائم التشغيل.\n\nهل تريد إعادة ضبط التطبيق؟';

  @override
  String get dialogResetAppSuccess => 'تمت إعادة ضبط التطبيق.';

  @override
  String get dialogClearCacheTitle => 'مسح ذاكرة التخزين المؤقت';

  @override
  String get dialogClearCacheContent =>
      'مسح ذاكرة التخزين المؤقت للصور؟\nسيتم إعادة تحميل الصور عند إعادة تشغيل التطبيق.';

  @override
  String get dialogClearCacheSuccess => 'تم مسح ذاكرة التخزين المؤقت للصور.';

  @override
  String get dialogClearCacheFailed => 'فشل مسح ذاكرة التخزين المؤقت';

  @override
  String dialogBackupSuccess(String filePath) {
    return 'اكتمل النسخ الاحتياطي.\nتم الحفظ في: $filePath';
  }

  @override
  String get dialogBackupCancelled => 'تم إلغاء النسخ الاحتياطي.';

  @override
  String get dialogBackupFailed => 'فشل النسخ الاحتياطي';

  @override
  String get dialogRestoreTitle => 'استعادة البيانات';

  @override
  String get dialogRestoreContent =>
      'استعادة البيانات من النسخة الاحتياطية؟\nقد يتغير الترتيب والمجلدات الموجودة.';

  @override
  String get dialogRestoreSuccess => 'اكتملت الاستعادة.';

  @override
  String get dialogRestoreFailed => 'فشلت الاستعادة';

  @override
  String get folderCreate => 'إنشاء مجلد';

  @override
  String get folderEdit => 'تعديل المجلد';

  @override
  String get folderDelete => 'حذف المجلد';

  @override
  String get folderName => 'اسم المجلد';

  @override
  String get folderCreated => 'تم إنشاء المجلد.';

  @override
  String get folderUpdated => 'تم تحديث المجلد.';

  @override
  String get folderDeleted => 'تم حذف المجلد.';

  @override
  String folderDeleteConfirm(String name) {
    return 'حذف مجلد \"$name\"؟';
  }

  @override
  String get folderManage => 'إدارة المجلدات';

  @override
  String get folderEmpty => 'لا توجد مجلدات';

  @override
  String get folderCreateNew => 'إنشاء مجلد';

  @override
  String get create => 'إنشاء';

  @override
  String get edit => 'تعديل';

  @override
  String get sectionHome => 'الرئيسية';

  @override
  String get sectionVideos => 'فيديوهات';

  @override
  String get sectionShorts => 'Shorts';

  @override
  String get sectionLive => 'بث مباشر';

  @override
  String get sectionPodcasts => 'بودكاست';

  @override
  String get sectionPlaylists => 'قوائم تشغيل';

  @override
  String get sectionCommunity => 'المجتمع';

  @override
  String get confirm => 'موافق';

  @override
  String get errorUnknown => 'حدث خطأ غير معروف.';

  @override
  String get errorNetwork => 'يرجى التحقق من اتصالك بالإنترنت.';

  @override
  String get errorUnauthorized => 'انتهت صلاحية الجلسة.';

  @override
  String get errorQuotaExceeded =>
      'تم تجاوز الحصة اليومية لـ YouTube API.\nيرجى المحاولة بعد الساعة 5 مساءً (بتوقيت كوريا) غداً.';

  @override
  String get errorNotFound => 'لم يتم العثور على البيانات المطلوبة.';

  @override
  String get errorTimeout => 'انتهت مهلة الطلب.';

  @override
  String errorGeneric(String error) {
    return 'حدث خطأ: $error';
  }

  @override
  String get appSubtitle => 'مدير اشتراكات YouTube';

  @override
  String get loadingVideos => 'جاري تحميل الفيديوهات...';

  @override
  String get allChannelsFilter => 'مشترك';

  @override
  String get showFolderFab => 'إظهار زر المجلد';

  @override
  String get hideFolderFab => 'إخفاء زر المجلد';

  @override
  String get refreshSubscriptions => 'تحديث الاشتراكات';

  @override
  String get refreshPlaylists => 'تحديث قوائم التشغيل';

  @override
  String get fetchSubscriptionsTitle => 'لا توجد اشتراكات';

  @override
  String get fetchSubscriptionsMessage =>
      'هل تريد جلب اشتراكات YouTube الخاصة بك؟';

  @override
  String get fetchSubscriptionsYes => 'جلب';

  @override
  String get fetchSubscriptionsNo => 'لاحقاً';

  @override
  String get createFolderDialogTitle => 'لا توجد مجلدات';

  @override
  String get createFolderDialogMessage => 'هل تريد إنشاء مجلد؟';

  @override
  String get createFolderDialogYes => 'إنشاء';

  @override
  String get createFolderDialogNo => 'لاحقاً';

  @override
  String get createFolderDialogDontShowAgain => 'لا تظهر مرة أخرى';

  @override
  String get createFolderDialogManualGuide =>
      'يمكنك إضافة مجلدات لاحقاً في الإعدادات > إدارة المجلدات.';

  @override
  String get swipeEnabledDescription =>
      'المجلدات المحددة فقط يمكن الوصول إليها بالتمرير';

  @override
  String get filterByChannel => 'تصفية حسب القناة';

  @override
  String get allChannels => 'الكل';

  @override
  String get errorDetail => 'تفاصيل الخطأ';

  @override
  String get viewErrorMessage => 'عرض رسالة الخطأ';

  @override
  String get sortDialogTitle => 'ترتيب';

  @override
  String get sortPlaylistOrder => 'ترتيب القائمة';

  @override
  String get sortPlaylistOrderReverse => 'ترتيب القائمة (عكسي)';

  @override
  String get sortNewest => 'الأحدث';

  @override
  String get sortOldest => 'الأقدم';

  @override
  String get sortTitle => 'العنوان';

  @override
  String get loginSubtitle => 'نظّم اشتراكاتك في\nYouTube بحرية';

  @override
  String get loginWithGoogle => 'تسجيل الدخول باستخدام Google';

  @override
  String get loggingIn => 'جارٍ تسجيل الدخول...';

  @override
  String get loginPermissionNotice => 'يلزم إذن قراءة YouTube';

  @override
  String get loadingSubscriptions => 'جارٍ تحميل الاشتراكات...';

  @override
  String get loginFailed => 'فشل تسجيل الدخول.';

  @override
  String get longPressReorder => 'ضغط مطول: إعادة الترتيب';

  @override
  String get longPressDelete => 'ضغط مطول: حذف';

  @override
  String get showDeleteConfirmation => 'إظهار تأكيد الحذف';
}
