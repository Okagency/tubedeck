// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get navChannels => 'ช่อง';

  @override
  String get navFeed => 'ฟีด';

  @override
  String get navFavorites => 'รายการโปรด';

  @override
  String get navPlaylists => 'เพลย์ลิสต์';

  @override
  String get navSettings => 'การตั้งค่า';

  @override
  String get settingsSectionFolders => 'โฟลเดอร์';

  @override
  String get settingsFolderManage => 'จัดการโฟลเดอร์';

  @override
  String get settingsFolderManageDesc => 'เพิ่ม แก้ไข ลบโฟลเดอร์';

  @override
  String get settingsSectionDisplay => 'การแสดงผล';

  @override
  String get settingsLanguage => 'ภาษา / Language';

  @override
  String get settingsLanguageSystem => 'ระบบ (System)';

  @override
  String get settingsChipLayout => 'รูปแบบโฟลเดอร์';

  @override
  String get settingsChipLayoutSingleLine => 'บรรทัดเดียว';

  @override
  String get settingsChipLayoutWrap => 'ตัดบรรทัด';

  @override
  String get chipLayoutToggleWrap => 'ดูโฟลเดอร์แบบหลายบรรทัด';

  @override
  String get chipLayoutToggleSingleLine => 'ดูโฟลเดอร์แบบบรรทัดเดียว';

  @override
  String get settingsFolderView => 'มุมมองโฟลเดอร์';

  @override
  String get settingsShowChannelCount => 'แสดงจำนวนช่อง';

  @override
  String get settingsShowVideoCount => 'แสดงจำนวนวิดีโอ';

  @override
  String get settingsFolderSizeLarge => 'ใหญ่';

  @override
  String get settingsFolderSizeSmall => 'เล็ก';

  @override
  String get settingsDefaultChannelSection => 'แท็บเปิด YouTube';

  @override
  String get settingsVideosPerChannel => 'วิดีโอต่อช่อง';

  @override
  String settingsVideosPerChannelCount(int count) {
    return '$count';
  }

  @override
  String get settingsCaptionDisplay => 'การแสดงคำบรรยาย';

  @override
  String get settingsCaptionShow => 'แสดง';

  @override
  String get settingsCaptionHide => 'ซ่อน';

  @override
  String get settingsChannelTapAction => 'การแตะช่อง';

  @override
  String get settingsChannelTapLatestVideos => 'ดูวิดีโอล่าสุด';

  @override
  String get settingsChannelTapOpenYoutube => 'เปิดใน YouTube';

  @override
  String get settingsVideoCardTapAction => 'การแตะการ์ดวิดีโอ';

  @override
  String get settingsVideoCardTapInAppPlayer => 'เล่นในแอป';

  @override
  String get settingsVideoCardTapOpenYoutube => 'เปิดใน YouTube';

  @override
  String get settingsVideoCardLayoutStyle => 'รูปแบบการ์ดวิดีโอ';

  @override
  String get settingsVideoCardLayoutHorizontal => 'การ์ดแนวนอน';

  @override
  String get settingsVideoCardLayoutVertical => 'การ์ดแนวตั้ง';

  @override
  String get settingsMenuOrder => 'ลำดับเมนู';

  @override
  String get settingsMenuOrderDesc => 'เปลี่ยนลำดับแถบนำทางด้านล่าง';

  @override
  String get settingsResetApp => 'รีเซ็ตแอป';

  @override
  String get settingsSectionData => 'ข้อมูล';

  @override
  String get settingsBackup => 'สำรองข้อมูล';

  @override
  String get settingsRestore => 'กู้คืนข้อมูล';

  @override
  String get settingsClearCache => 'ล้างแคชรูปภาพ';

  @override
  String get settingsSectionInfo => 'ข้อมูล';

  @override
  String get settingsVersion => 'เวอร์ชัน';

  @override
  String get settingsLicense => 'ใบอนุญาตโอเพนซอร์ส';

  @override
  String get settingsSectionAccount => 'บัญชี';

  @override
  String get settingsGoogleAccount => 'บัญชี Google';

  @override
  String get settingsNotLoggedIn => 'ยังไม่ได้เข้าสู่ระบบ';

  @override
  String get settingsLogout => 'ออกจากระบบ';

  @override
  String get addToFolder => 'เพิ่มในโฟลเดอร์';

  @override
  String get sectionSettings => 'แท็บเปิด YouTube';

  @override
  String subscriberCount(String count) {
    return '$count ผู้ติดตาม';
  }

  @override
  String channelsSelected(int count) {
    return 'เลือก $count ช่องแล้ว';
  }

  @override
  String itemsSelected(int count) {
    return 'เลือก $count รายการแล้ว';
  }

  @override
  String get timeJustNow => 'เมื่อสักครู่';

  @override
  String timeMinutesAgo(int count) {
    return '$count นาทีที่แล้ว';
  }

  @override
  String timeHoursAgo(int count) {
    return '$count ชั่วโมงที่แล้ว';
  }

  @override
  String timeDaysAgo(int count) {
    return '$count วันที่แล้ว';
  }

  @override
  String timeWeeksAgo(int count) {
    return '$count สัปดาห์ที่แล้ว';
  }

  @override
  String timeMonthsAgo(int count) {
    return '$count เดือนที่แล้ว';
  }

  @override
  String itemCount(int count) {
    return '$count รายการ';
  }

  @override
  String get deleteConfirmTitle => 'ยืนยันการลบ';

  @override
  String deleteSelectedVideosConfirm(int count) {
    return 'ลบวิดีโอที่เลือก $count รายการ?';
  }

  @override
  String get deleteFavoriteConfirm => 'ลบออกจากรายการโปรด?';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get delete => 'ลบ';

  @override
  String get selectAll => 'เลือกทั้งหมด';

  @override
  String get select => 'เลือก';

  @override
  String timeYearsAgo(int count) {
    return '$count ปีที่แล้ว';
  }

  @override
  String videoCount(int count) {
    return '$count วิดีโอ';
  }

  @override
  String channelCount(int count) {
    return '$count ช่อง';
  }

  @override
  String playlistCount(int count) {
    return 'โหลด $count เพลย์ลิสต์แล้ว';
  }

  @override
  String get removeFromFolder => 'ลบออกจากโฟลเดอร์';

  @override
  String get deleteChannel => 'ลบช่อง';

  @override
  String deleteChannelConfirm(String name) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการลบ $name อย่างถาวร?\nจะถูกลบออกจากทุกโฟลเดอร์';
  }

  @override
  String removeChannelConfirm(String name) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการลบ $name ออกจากโฟลเดอร์นี้?\nการติดตามจะยังคงอยู่';
  }

  @override
  String deleteChannelsConfirm(int count) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการลบ $count ช่องอย่างถาวร?\nจะถูกลบออกจากทุกโฟลเดอร์';
  }

  @override
  String removeChannelsConfirm(int count) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการลบ $count ช่องออกจากโฟลเดอร์นี้?\nการติดตามจะยังคงอยู่';
  }

  @override
  String get channelDeleted => 'ลบช่องแล้ว';

  @override
  String get removedFromFolder => 'ลบออกจากโฟลเดอร์แล้ว';

  @override
  String addedToFolder(String name) {
    return 'เพิ่มใน $name แล้ว';
  }

  @override
  String channelsDeleted(int count) {
    return 'ลบ $count ช่องแล้ว';
  }

  @override
  String channelsRemoved(int count) {
    return 'ลบ $count ช่องแล้ว';
  }

  @override
  String channelsAddedTo(int count, String name) {
    return 'เพิ่ม $count ช่องใน $name แล้ว';
  }

  @override
  String get cannotOpenChannel => 'ไม่สามารถเปิดช่องได้';

  @override
  String get pleaseSelectChannels => 'กรุณาเลือกช่อง';

  @override
  String get createFolderFirst => 'กรุณาสร้างโฟลเดอร์ก่อน';

  @override
  String get createCategoryFirst => 'กรุณาสร้างหมวดหมู่ก่อน';

  @override
  String get unsubscribed => 'ยกเลิกการติดตามแล้ว';

  @override
  String uploadedAgo(String time) {
    return 'อัปโหลด $time';
  }

  @override
  String sectionSettingsTitle(String title) {
    return '$title\nการตั้งค่าส่วน';
  }

  @override
  String useDefaultSection(String section) {
    return 'ใช้ค่าเริ่มต้น ($section)';
  }

  @override
  String get sectionSetToDefault => 'ตั้งส่วนเป็นค่าเริ่มต้นแล้ว';

  @override
  String sectionSetTo(String section) {
    return 'ตั้งเป็นส่วน $section แล้ว';
  }

  @override
  String get channelsUpdated => 'อัปเดตรายการช่องแล้ว';

  @override
  String get noSubscriptions => 'ไม่มีช่องที่ติดตาม';

  @override
  String get noSearchResults => 'ไม่พบผลการค้นหา';

  @override
  String get cannotLoadPlaylists => 'ไม่สามารถโหลดเพลย์ลิสต์ได้';

  @override
  String get retry => 'ลองอีกครั้ง';

  @override
  String get noPlaylists => 'ไม่มีเพลย์ลิสต์';

  @override
  String get noVideos => 'ไม่มีวิดีโอ';

  @override
  String get noFavorites => 'ไม่มีวิดีโอที่ชื่นชอบ';

  @override
  String get customOrder => 'ลำดับที่กำหนดเอง';

  @override
  String get alphabetical => 'ตามตัวอักษร';

  @override
  String get multiSelect => 'เลือกหลายรายการ';

  @override
  String get openInYoutube => 'เปิดใน YouTube';

  @override
  String get latestVideos => 'วิดีโอล่าสุด';

  @override
  String formatTenThousand(String count) {
    return '$countหมื่น';
  }

  @override
  String formatThousand(String count) {
    return '$countพัน';
  }

  @override
  String formatMillion(String count) {
    return '$countล้าน';
  }

  @override
  String get dialogLogoutTitle => 'ออกจากระบบ';

  @override
  String get dialogLogoutContent => 'คุณแน่ใจหรือไม่ว่าต้องการออกจากระบบ?';

  @override
  String get dialogResetAppTitle => 'รีเซ็ตแอป';

  @override
  String get dialogResetAppContent =>
      'ข้อมูลทั้งหมดจะถูกลบ รวมถึงการติดตาม โฟลเดอร์ รายการโปรด และเพลย์ลิสต์\n\nคุณต้องการรีเซ็ตแอปหรือไม่?';

  @override
  String get dialogResetAppSuccess => 'รีเซ็ตแอปแล้ว';

  @override
  String get dialogClearCacheTitle => 'ล้างแคช';

  @override
  String get dialogClearCacheContent =>
      'ล้างแคชรูปภาพ?\nรูปภาพจะถูกโหลดใหม่เมื่อรีสตาร์ทแอป';

  @override
  String get dialogClearCacheSuccess => 'ล้างแคชรูปภาพแล้ว';

  @override
  String get dialogClearCacheFailed => 'ล้างแคชล้มเหลว';

  @override
  String dialogBackupSuccess(String filePath) {
    return 'สำรองข้อมูลเสร็จสิ้น\nบันทึกที่: $filePath';
  }

  @override
  String get dialogBackupCancelled => 'ยกเลิกการสำรองข้อมูล';

  @override
  String get dialogBackupFailed => 'สำรองข้อมูลล้มเหลว';

  @override
  String get dialogRestoreTitle => 'กู้คืนข้อมูล';

  @override
  String get dialogRestoreContent =>
      'กู้คืนข้อมูลจากไฟล์สำรอง?\nลำดับการจัดเรียงและโฟลเดอร์ที่มีอยู่อาจเปลี่ยนแปลง';

  @override
  String get dialogRestoreSuccess => 'กู้คืนเสร็จสิ้น';

  @override
  String get dialogRestoreFailed => 'กู้คืนล้มเหลว';

  @override
  String get folderCreate => 'สร้างโฟลเดอร์';

  @override
  String get folderEdit => 'แก้ไขโฟลเดอร์';

  @override
  String get folderDelete => 'ลบโฟลเดอร์';

  @override
  String get folderName => 'ชื่อโฟลเดอร์';

  @override
  String get folderCreated => 'สร้างโฟลเดอร์แล้ว';

  @override
  String get folderUpdated => 'อัปเดตโฟลเดอร์แล้ว';

  @override
  String get folderDeleted => 'ลบโฟลเดอร์แล้ว';

  @override
  String folderDeleteConfirm(String name) {
    return 'ลบโฟลเดอร์ \"$name\"?';
  }

  @override
  String get folderManage => 'จัดการโฟลเดอร์';

  @override
  String get folderEmpty => 'ไม่มีโฟลเดอร์';

  @override
  String get folderCreateNew => 'สร้างโฟลเดอร์';

  @override
  String get create => 'สร้าง';

  @override
  String get edit => 'แก้ไข';

  @override
  String get sectionHome => 'หน้าแรก';

  @override
  String get sectionVideos => 'วิดีโอ';

  @override
  String get sectionShorts => 'Shorts';

  @override
  String get sectionLive => 'สด';

  @override
  String get sectionPodcasts => 'พอดแคสต์';

  @override
  String get sectionPlaylists => 'เพลย์ลิสต์';

  @override
  String get sectionCommunity => 'ชุมชน';

  @override
  String get confirm => 'ตกลง';

  @override
  String get errorUnknown => 'เกิดข้อผิดพลาดที่ไม่ทราบสาเหตุ';

  @override
  String get errorNetwork => 'กรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ต';

  @override
  String get errorUnauthorized => 'เซสชันหมดอายุ';

  @override
  String get errorQuotaExceeded =>
      'เกินโควต้า YouTube API รายวัน\nกรุณาลองอีกครั้งหลัง 17:00 น. (เวลาไทย) ของวันพรุ่งนี้';

  @override
  String get errorNotFound => 'ไม่พบข้อมูลที่ร้องขอ';

  @override
  String get errorTimeout => 'หมดเวลาการร้องขอ';

  @override
  String errorGeneric(String error) {
    return 'เกิดข้อผิดพลาด: $error';
  }

  @override
  String get appSubtitle => 'ตัวจัดการการติดตาม YouTube';

  @override
  String get loadingVideos => 'กำลังโหลดวิดีโอ...';

  @override
  String get allChannelsFilter => 'ติดตามแล้ว';

  @override
  String get showFolderFab => 'แสดงปุ่มโฟลเดอร์';

  @override
  String get hideFolderFab => 'ซ่อนปุ่มโฟลเดอร์';

  @override
  String get refreshSubscriptions => 'รีเฟรชการติดตาม';

  @override
  String get refreshPlaylists => 'รีเฟรชเพลย์ลิสต์';

  @override
  String get fetchSubscriptionsTitle => 'ไม่มีการติดตาม';

  @override
  String get fetchSubscriptionsMessage =>
      'คุณต้องการดึงการติดตาม YouTube ของคุณหรือไม่?';

  @override
  String get fetchSubscriptionsYes => 'ดึง';

  @override
  String get fetchSubscriptionsNo => 'ภายหลัง';

  @override
  String get createFolderDialogTitle => 'ไม่มีโฟลเดอร์';

  @override
  String get createFolderDialogMessage => 'คุณต้องการสร้างโฟลเดอร์หรือไม่?';

  @override
  String get createFolderDialogYes => 'สร้าง';

  @override
  String get createFolderDialogNo => 'ภายหลัง';

  @override
  String get createFolderDialogDontShowAgain => 'ไม่ต้องแสดงอีก';

  @override
  String get createFolderDialogManualGuide =>
      'คุณสามารถเพิ่มโฟลเดอร์ได้ภายหลังในการตั้งค่า > จัดการโฟลเดอร์';

  @override
  String get swipeEnabledDescription =>
      'เฉพาะโฟลเดอร์ที่เลือกเท่านั้นที่สามารถปัดเข้าถึงได้';

  @override
  String get filterByChannel => 'กรองตามช่อง';

  @override
  String get allChannels => 'ทั้งหมด';

  @override
  String get errorDetail => 'รายละเอียดข้อผิดพลาด';

  @override
  String get viewErrorMessage => 'ดูข้อความข้อผิดพลาด';

  @override
  String get sortDialogTitle => 'เรียงลำดับ';

  @override
  String get sortPlaylistOrder => 'ลำดับเพลย์ลิสต์';

  @override
  String get sortPlaylistOrderReverse => 'ลำดับเพลย์ลิสต์ (กลับด้าน)';

  @override
  String get sortNewest => 'ใหม่สุด';

  @override
  String get sortOldest => 'เก่าสุด';

  @override
  String get sortTitle => 'ชื่อ';

  @override
  String get loginSubtitle => 'จัดระเบียบการติดตาม YouTube\nของคุณอย่างอิสระ';

  @override
  String get loginWithGoogle => 'เข้าสู่ระบบด้วย Google';

  @override
  String get loggingIn => 'กำลังเข้าสู่ระบบ...';

  @override
  String get loginPermissionNotice => 'ต้องการสิทธิ์ในการอ่าน YouTube';

  @override
  String get loadingSubscriptions => 'กำลังโหลดการติดตาม...';

  @override
  String get loginFailed => 'เข้าสู่ระบบล้มเหลว';

  @override
  String get longPressReorder => 'กดค้าง: เรียงลำดับใหม่';

  @override
  String get longPressDelete => 'กดค้าง: ลบ';

  @override
  String get showDeleteConfirmation => 'แสดงการยืนยันการลบ';
}
