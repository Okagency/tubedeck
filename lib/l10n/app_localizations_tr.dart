// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get navChannels => 'Kanallar';

  @override
  String get navFeed => 'Akış';

  @override
  String get navFavorites => 'Favoriler';

  @override
  String get navPlaylists => 'Çalma Listeleri';

  @override
  String get navSettings => 'Ayarlar';

  @override
  String get settingsSectionFolders => 'Klasörler';

  @override
  String get settingsFolderManage => 'Klasörleri yönet';

  @override
  String get settingsFolderManageDesc => 'Klasör ekle, düzenle, sil';

  @override
  String get settingsSectionDisplay => 'Görünüm';

  @override
  String get settingsLanguage => 'Dil / Language';

  @override
  String get settingsLanguageSystem => 'Sistem (System)';

  @override
  String get settingsChipLayout => 'Klasör düzeni';

  @override
  String get settingsChipLayoutSingleLine => 'Tek satır';

  @override
  String get settingsChipLayoutWrap => 'Kaydır';

  @override
  String get chipLayoutToggleWrap => 'Kaydırmalı görünüm';

  @override
  String get chipLayoutToggleSingleLine => 'Tek satır görünüm';

  @override
  String get settingsFolderView => 'Klasör görünümü';

  @override
  String get settingsShowChannelCount => 'Kanal sayısını göster';

  @override
  String get settingsShowVideoCount => 'Video sayısını göster';

  @override
  String get settingsFolderSizeLarge => 'Büyük';

  @override
  String get settingsFolderSizeSmall => 'Küçük';

  @override
  String get settingsDefaultChannelSection => 'YouTube sekmesi';

  @override
  String get settingsVideosPerChannel => 'Kanal başına video';

  @override
  String settingsVideosPerChannelCount(int count) {
    return '$count';
  }

  @override
  String get settingsCaptionDisplay => 'Altyazı gösterimi';

  @override
  String get settingsCaptionShow => 'Göster';

  @override
  String get settingsCaptionHide => 'Gizle';

  @override
  String get settingsChannelTapAction => 'Kanal dokunma eylemi';

  @override
  String get settingsChannelTapLatestVideos => 'Son videoları görüntüle';

  @override
  String get settingsChannelTapOpenYoutube => 'YouTube\'da aç';

  @override
  String get settingsVideoCardTapAction => 'Video kartı dokunma eylemi';

  @override
  String get settingsVideoCardTapInAppPlayer => 'Uygulama içi oynatıcı';

  @override
  String get settingsVideoCardTapOpenYoutube => 'YouTube\'da aç';

  @override
  String get settingsVideoCardLayoutStyle => 'Video kartı düzeni';

  @override
  String get settingsVideoCardLayoutHorizontal => 'Yatay kart';

  @override
  String get settingsVideoCardLayoutVertical => 'Dikey kart';

  @override
  String get settingsMenuOrder => 'Menü sırası';

  @override
  String get settingsMenuOrderDesc => 'Alt navigasyon sırasını değiştir';

  @override
  String get settingsResetApp => 'Uygulamayı sıfırla';

  @override
  String get settingsSectionData => 'Veri';

  @override
  String get settingsBackup => 'Veri yedekle';

  @override
  String get settingsRestore => 'Veri geri yükle';

  @override
  String get settingsClearCache => 'Görsel önbelleğini temizle';

  @override
  String get settingsSectionInfo => 'Bilgi';

  @override
  String get settingsVersion => 'Sürüm';

  @override
  String get settingsLicense => 'Açık kaynak lisansları';

  @override
  String get settingsSectionAccount => 'Hesap';

  @override
  String get settingsGoogleAccount => 'Google Hesabı';

  @override
  String get settingsNotLoggedIn => 'Giriş yapılmadı';

  @override
  String get settingsLogout => 'Çıkış yap';

  @override
  String get addToFolder => 'Klasöre ekle';

  @override
  String get sectionSettings => 'YouTube sekmesi';

  @override
  String subscriberCount(String count) {
    return '$count abone';
  }

  @override
  String channelsSelected(int count) {
    return '$count kanal seçildi';
  }

  @override
  String itemsSelected(int count) {
    return '$count seçildi';
  }

  @override
  String get timeJustNow => 'Şimdi';

  @override
  String timeMinutesAgo(int count) {
    return '$count dk önce';
  }

  @override
  String timeHoursAgo(int count) {
    return '$count sa önce';
  }

  @override
  String timeDaysAgo(int count) {
    return '$count gün önce';
  }

  @override
  String timeWeeksAgo(int count) {
    return '$count hf önce';
  }

  @override
  String timeMonthsAgo(int count) {
    return '$count ay önce';
  }

  @override
  String itemCount(int count) {
    return '$count öğe';
  }

  @override
  String get deleteConfirmTitle => 'Silmeyi onayla';

  @override
  String deleteSelectedVideosConfirm(int count) {
    return '$count seçili video silinsin mi?';
  }

  @override
  String get deleteFavoriteConfirm => 'Favorilerden kaldırılsın mı?';

  @override
  String get cancel => 'İptal';

  @override
  String get delete => 'Sil';

  @override
  String get selectAll => 'Tümünü seç';

  @override
  String get select => 'Seç';

  @override
  String timeYearsAgo(int count) {
    return '$count yıl önce';
  }

  @override
  String videoCount(int count) {
    return '$count video';
  }

  @override
  String channelCount(int count) {
    return '$count kanal';
  }

  @override
  String playlistCount(int count) {
    return '$count çalma listesi yüklendi';
  }

  @override
  String get removeFromFolder => 'Klasörden kaldır';

  @override
  String get deleteChannel => 'Kanalı sil';

  @override
  String deleteChannelConfirm(String name) {
    return '$name tamamen silinsin mi?\nTüm klasörlerden kaldırılacak.';
  }

  @override
  String removeChannelConfirm(String name) {
    return '$name bu klasörden kaldırılsın mı?\nAboneliklerinizde kalacak.';
  }

  @override
  String deleteChannelsConfirm(int count) {
    return '$count kanal tamamen silinsin mi?\nTüm klasörlerden kaldırılacaklar.';
  }

  @override
  String removeChannelsConfirm(int count) {
    return '$count kanal bu klasörden kaldırılsın mı?\nAboneliklerinizde kalacaklar.';
  }

  @override
  String get channelDeleted => 'Kanal silindi';

  @override
  String get removedFromFolder => 'Klasörden kaldırıldı';

  @override
  String addedToFolder(String name) {
    return '$name klasörüne eklendi';
  }

  @override
  String channelsDeleted(int count) {
    return '$count kanal silindi';
  }

  @override
  String channelsRemoved(int count) {
    return '$count kanal kaldırıldı';
  }

  @override
  String channelsAddedTo(int count, String name) {
    return '$count kanal $name klasörüne eklendi';
  }

  @override
  String get cannotOpenChannel => 'Kanal açılamıyor';

  @override
  String get pleaseSelectChannels => 'Lütfen kanal seçin';

  @override
  String get createFolderFirst => 'Lütfen önce bir klasör oluşturun';

  @override
  String get createCategoryFirst => 'Lütfen önce bir kategori oluşturun';

  @override
  String get unsubscribed => 'Abonelik iptal edildi';

  @override
  String uploadedAgo(String time) {
    return '$time yüklendi';
  }

  @override
  String sectionSettingsTitle(String title) {
    return '$title\nBölüm ayarları';
  }

  @override
  String useDefaultSection(String section) {
    return 'Varsayılanı kullan ($section)';
  }

  @override
  String get sectionSetToDefault => 'Bölüm varsayılana ayarlandı';

  @override
  String sectionSetTo(String section) {
    return '$section bölümüne ayarlandı';
  }

  @override
  String get channelsUpdated => 'Kanal listesi güncellendi';

  @override
  String get noSubscriptions => 'Abone olunan kanal yok';

  @override
  String get noSearchResults => 'Sonuç yok';

  @override
  String get cannotLoadPlaylists => 'Çalma listeleri yüklenemiyor';

  @override
  String get retry => 'Tekrar dene';

  @override
  String get noPlaylists => 'Çalma listesi yok';

  @override
  String get noVideos => 'Video yok';

  @override
  String get noFavorites => 'Favori video yok';

  @override
  String get customOrder => 'Özel sıralama';

  @override
  String get alphabetical => 'Alfabetik';

  @override
  String get multiSelect => 'Çoklu seçim';

  @override
  String get openInYoutube => 'YouTube\'da aç';

  @override
  String get latestVideos => 'Son videolar';

  @override
  String formatTenThousand(String count) {
    return '${count}B';
  }

  @override
  String formatThousand(String count) {
    return '${count}B';
  }

  @override
  String formatMillion(String count) {
    return '${count}Mn';
  }

  @override
  String get dialogLogoutTitle => 'Çıkış yap';

  @override
  String get dialogLogoutContent => 'Çıkış yapmak istediğinizden emin misiniz?';

  @override
  String get dialogResetAppTitle => 'Uygulamayı sıfırla';

  @override
  String get dialogResetAppContent =>
      'Abonelikler, klasörler, favoriler ve çalma listeleri dahil tüm veriler silinecek.\n\nUygulamayı sıfırlamak istiyor musunuz?';

  @override
  String get dialogResetAppSuccess => 'Uygulama sıfırlandı.';

  @override
  String get dialogClearCacheTitle => 'Önbelleği temizle';

  @override
  String get dialogClearCacheContent =>
      'Görsel önbelleği temizlensin mi?\nGörseller uygulama yeniden başlatıldığında yüklenecek.';

  @override
  String get dialogClearCacheSuccess => 'Görsel önbelleği temizlendi.';

  @override
  String get dialogClearCacheFailed => 'Önbellek temizlenemedi';

  @override
  String dialogBackupSuccess(String filePath) {
    return 'Yedekleme tamamlandı.\nKaydedildi: $filePath';
  }

  @override
  String get dialogBackupCancelled => 'Yedekleme iptal edildi.';

  @override
  String get dialogBackupFailed => 'Yedekleme başarısız';

  @override
  String get dialogRestoreTitle => 'Veri geri yükle';

  @override
  String get dialogRestoreContent =>
      'Veriler yedekten geri yüklensin mi?\nMevcut sıralama ve klasörler değişebilir.';

  @override
  String get dialogRestoreSuccess => 'Geri yükleme tamamlandı.';

  @override
  String get dialogRestoreFailed => 'Geri yükleme başarısız';

  @override
  String get folderCreate => 'Klasör oluştur';

  @override
  String get folderEdit => 'Klasörü düzenle';

  @override
  String get folderDelete => 'Klasörü sil';

  @override
  String get folderName => 'Klasör adı';

  @override
  String get folderCreated => 'Klasör oluşturuldu.';

  @override
  String get folderUpdated => 'Klasör güncellendi.';

  @override
  String get folderDeleted => 'Klasör silindi.';

  @override
  String folderDeleteConfirm(String name) {
    return '\"$name\" klasörü silinsin mi?';
  }

  @override
  String get folderManage => 'Klasörleri yönet';

  @override
  String get folderEmpty => 'Klasör yok';

  @override
  String get folderCreateNew => 'Klasör oluştur';

  @override
  String get create => 'Oluştur';

  @override
  String get edit => 'Düzenle';

  @override
  String get sectionHome => 'Ana Sayfa';

  @override
  String get sectionVideos => 'Videolar';

  @override
  String get sectionShorts => 'Shorts';

  @override
  String get sectionLive => 'Canlı';

  @override
  String get sectionPodcasts => 'Podcast';

  @override
  String get sectionPlaylists => 'Çalma Listeleri';

  @override
  String get sectionCommunity => 'Topluluk';

  @override
  String get confirm => 'Tamam';

  @override
  String get errorUnknown => 'Bilinmeyen bir hata oluştu.';

  @override
  String get errorNetwork => 'Lütfen internet bağlantınızı kontrol edin.';

  @override
  String get errorUnauthorized => 'Oturum süresi doldu.';

  @override
  String get errorQuotaExceeded =>
      'YouTube API günlük kotası aşıldı.\nLütfen yarın saat 17:00\'den (Kore saati) sonra tekrar deneyin.';

  @override
  String get errorNotFound => 'İstenen veriler bulunamadı.';

  @override
  String get errorTimeout => 'İstek zaman aşımına uğradı.';

  @override
  String errorGeneric(String error) {
    return 'Bir hata oluştu: $error';
  }

  @override
  String get appSubtitle => 'YouTube Abonelik Yöneticisi';

  @override
  String get loadingVideos => 'Videolar yükleniyor...';

  @override
  String get allChannelsFilter => 'Abone';

  @override
  String get showFolderFab => 'Klasör butonunu göster';

  @override
  String get hideFolderFab => 'Klasör butonunu gizle';

  @override
  String get refreshSubscriptions => 'Abonelikleri yenile';

  @override
  String get refreshPlaylists => 'Çalma listelerini yenile';

  @override
  String get fetchSubscriptionsTitle => 'Abonelik Yok';

  @override
  String get fetchSubscriptionsMessage =>
      'YouTube aboneliklerinizi almak ister misiniz?';

  @override
  String get fetchSubscriptionsYes => 'Al';

  @override
  String get fetchSubscriptionsNo => 'Daha Sonra';

  @override
  String get createFolderDialogTitle => 'Klasör Yok';

  @override
  String get createFolderDialogMessage => 'Klasör oluşturmak ister misiniz?';

  @override
  String get createFolderDialogYes => 'Oluştur';

  @override
  String get createFolderDialogNo => 'Daha Sonra';

  @override
  String get createFolderDialogDontShowAgain => 'Bir daha gösterme';

  @override
  String get createFolderDialogManualGuide =>
      'Klasörleri daha sonra Ayarlar > Klasörleri yönet bölümünden ekleyebilirsiniz.';

  @override
  String get swipeEnabledDescription =>
      'Yalnızca işaretli klasörlere kaydırarak erişilebilir';

  @override
  String get filterByChannel => 'Kanala göre filtrele';

  @override
  String get allChannels => 'Tümü';

  @override
  String get errorDetail => 'Hata detayları';

  @override
  String get viewErrorMessage => 'Hata mesajını görüntüle';

  @override
  String get sortDialogTitle => 'Sırala';

  @override
  String get sortPlaylistOrder => 'Liste sırası';

  @override
  String get sortPlaylistOrderReverse => 'Liste sırası (ters)';

  @override
  String get sortNewest => 'En yeni';

  @override
  String get sortOldest => 'En eski';

  @override
  String get sortTitle => 'Başlık';

  @override
  String get loginSubtitle => 'YouTube aboneliklerinizi\nözgürce düzenleyin';

  @override
  String get loginWithGoogle => 'Google ile giriş yap';

  @override
  String get loggingIn => 'Giriş yapılıyor...';

  @override
  String get loginPermissionNotice => 'YouTube okuma izni gerekli';

  @override
  String get loadingSubscriptions => 'Abonelikler yükleniyor...';

  @override
  String get loginFailed => 'Giriş başarısız.';

  @override
  String get longPressReorder => 'Uzun basma: Yeniden sırala';

  @override
  String get longPressDelete => 'Uzun basma: Sil';

  @override
  String get showDeleteConfirmation => 'Silme onayı göster';
}
