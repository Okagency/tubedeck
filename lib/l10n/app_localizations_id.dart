// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get navChannels => 'Saluran';

  @override
  String get navFeed => 'Feed';

  @override
  String get navFavorites => 'Favorit';

  @override
  String get navPlaylists => 'Playlist';

  @override
  String get navSettings => 'Pengaturan';

  @override
  String get settingsSectionFolders => 'Folder';

  @override
  String get settingsFolderManage => 'Kelola folder';

  @override
  String get settingsFolderManageDesc => 'Tambah, edit, hapus folder';

  @override
  String get settingsSectionDisplay => 'Tampilan';

  @override
  String get settingsLanguage => 'Bahasa / Language';

  @override
  String get settingsLanguageSystem => 'Sistem (System)';

  @override
  String get settingsChipLayout => 'Tata letak folder';

  @override
  String get settingsChipLayoutSingleLine => 'Satu baris';

  @override
  String get settingsChipLayoutWrap => 'Bungkus';

  @override
  String get chipLayoutToggleWrap => 'Lihat dengan bungkus';

  @override
  String get chipLayoutToggleSingleLine => 'Lihat satu baris';

  @override
  String get settingsFolderView => 'Tampilan folder';

  @override
  String get settingsShowChannelCount => 'Tampilkan jumlah saluran';

  @override
  String get settingsShowVideoCount => 'Tampilkan jumlah video';

  @override
  String get settingsFolderSizeLarge => 'Besar';

  @override
  String get settingsFolderSizeSmall => 'Kecil';

  @override
  String get settingsDefaultChannelSection => 'Tab buka YouTube';

  @override
  String get settingsVideosPerChannel => 'Video per saluran';

  @override
  String settingsVideosPerChannelCount(int count) {
    return '$count';
  }

  @override
  String get settingsCaptionDisplay => 'Tampilan teks';

  @override
  String get settingsCaptionShow => 'Tampilkan';

  @override
  String get settingsCaptionHide => 'Sembunyikan';

  @override
  String get settingsChannelTapAction => 'Aksi ketuk saluran';

  @override
  String get settingsChannelTapLatestVideos => 'Lihat video terbaru';

  @override
  String get settingsChannelTapOpenYoutube => 'Buka di YouTube';

  @override
  String get settingsVideoCardTapAction => 'Aksi ketuk kartu video';

  @override
  String get settingsVideoCardTapInAppPlayer => 'Pemutar dalam aplikasi';

  @override
  String get settingsVideoCardTapOpenYoutube => 'Buka di YouTube';

  @override
  String get settingsVideoCardLayoutStyle => 'Tata letak kartu video';

  @override
  String get settingsVideoCardLayoutHorizontal => 'Kartu horizontal';

  @override
  String get settingsVideoCardLayoutVertical => 'Kartu vertikal';

  @override
  String get settingsMenuOrder => 'Urutan menu';

  @override
  String get settingsMenuOrderDesc => 'Ubah urutan navigasi bawah';

  @override
  String get settingsResetApp => 'Reset aplikasi';

  @override
  String get settingsSectionData => 'Data';

  @override
  String get settingsBackup => 'Cadangkan data';

  @override
  String get settingsRestore => 'Pulihkan data';

  @override
  String get settingsClearCache => 'Hapus cache gambar';

  @override
  String get settingsSectionInfo => 'Informasi';

  @override
  String get settingsVersion => 'Versi';

  @override
  String get settingsLicense => 'Lisensi open source';

  @override
  String get settingsSectionAccount => 'Akun';

  @override
  String get settingsGoogleAccount => 'Akun Google';

  @override
  String get settingsNotLoggedIn => 'Belum masuk';

  @override
  String get settingsLogout => 'Keluar';

  @override
  String get addToFolder => 'Tambah ke folder';

  @override
  String get sectionSettings => 'Tab buka YouTube';

  @override
  String subscriberCount(String count) {
    return '$count pelanggan';
  }

  @override
  String channelsSelected(int count) {
    return '$count saluran dipilih';
  }

  @override
  String itemsSelected(int count) {
    return '$count dipilih';
  }

  @override
  String get timeJustNow => 'Baru saja';

  @override
  String timeMinutesAgo(int count) {
    return '$count menit lalu';
  }

  @override
  String timeHoursAgo(int count) {
    return '$count jam lalu';
  }

  @override
  String timeDaysAgo(int count) {
    return '$count hari lalu';
  }

  @override
  String timeWeeksAgo(int count) {
    return '$count minggu lalu';
  }

  @override
  String timeMonthsAgo(int count) {
    return '$count bulan lalu';
  }

  @override
  String itemCount(int count) {
    return '$count item';
  }

  @override
  String get deleteConfirmTitle => 'Konfirmasi hapus';

  @override
  String deleteSelectedVideosConfirm(int count) {
    return 'Hapus $count video yang dipilih?';
  }

  @override
  String get deleteFavoriteConfirm => 'Hapus dari favorit?';

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Hapus';

  @override
  String get selectAll => 'Pilih semua';

  @override
  String get select => 'Pilih';

  @override
  String timeYearsAgo(int count) {
    return '$count tahun lalu';
  }

  @override
  String videoCount(int count) {
    return '$count video';
  }

  @override
  String channelCount(int count) {
    return '$count saluran';
  }

  @override
  String playlistCount(int count) {
    return '$count playlist dimuat';
  }

  @override
  String get removeFromFolder => 'Hapus dari folder';

  @override
  String get deleteChannel => 'Hapus saluran';

  @override
  String deleteChannelConfirm(String name) {
    return 'Hapus $name sepenuhnya?\nAkan dihapus dari semua folder.';
  }

  @override
  String removeChannelConfirm(String name) {
    return 'Hapus $name dari folder ini?\nAkan tetap ada di langganan Anda.';
  }

  @override
  String deleteChannelsConfirm(int count) {
    return 'Hapus $count saluran sepenuhnya?\nAkan dihapus dari semua folder.';
  }

  @override
  String removeChannelsConfirm(int count) {
    return 'Hapus $count saluran dari folder ini?\nAkan tetap ada di langganan Anda.';
  }

  @override
  String get channelDeleted => 'Saluran dihapus';

  @override
  String get removedFromFolder => 'Dihapus dari folder';

  @override
  String addedToFolder(String name) {
    return 'Ditambahkan ke $name';
  }

  @override
  String channelsDeleted(int count) {
    return '$count saluran dihapus';
  }

  @override
  String channelsRemoved(int count) {
    return '$count saluran dihapus';
  }

  @override
  String channelsAddedTo(int count, String name) {
    return '$count saluran ditambahkan ke $name';
  }

  @override
  String get cannotOpenChannel => 'Tidak dapat membuka saluran';

  @override
  String get pleaseSelectChannels => 'Silakan pilih saluran';

  @override
  String get createFolderFirst => 'Silakan buat folder terlebih dahulu';

  @override
  String get createCategoryFirst => 'Silakan buat kategori terlebih dahulu';

  @override
  String get unsubscribed => 'Berhenti berlangganan';

  @override
  String uploadedAgo(String time) {
    return 'diunggah $time';
  }

  @override
  String sectionSettingsTitle(String title) {
    return '$title\nPengaturan bagian';
  }

  @override
  String useDefaultSection(String section) {
    return 'Gunakan default ($section)';
  }

  @override
  String get sectionSetToDefault => 'Bagian diatur ke default';

  @override
  String sectionSetTo(String section) {
    return 'Diatur ke bagian $section';
  }

  @override
  String get channelsUpdated => 'Daftar saluran diperbarui';

  @override
  String get noSubscriptions => 'Tidak ada saluran berlangganan';

  @override
  String get noSearchResults => 'Tidak ada hasil';

  @override
  String get cannotLoadPlaylists => 'Tidak dapat memuat playlist';

  @override
  String get retry => 'Coba lagi';

  @override
  String get noPlaylists => 'Tidak ada playlist';

  @override
  String get noVideos => 'Tidak ada video';

  @override
  String get noFavorites => 'Tidak ada video favorit';

  @override
  String get customOrder => 'Urutan kustom';

  @override
  String get alphabetical => 'Abjad';

  @override
  String get multiSelect => 'Pilih banyak';

  @override
  String get openInYoutube => 'Buka di YouTube';

  @override
  String get latestVideos => 'Video terbaru';

  @override
  String formatTenThousand(String count) {
    return '${count}rb';
  }

  @override
  String formatThousand(String count) {
    return '${count}rb';
  }

  @override
  String formatMillion(String count) {
    return '${count}jt';
  }

  @override
  String get dialogLogoutTitle => 'Keluar';

  @override
  String get dialogLogoutContent => 'Yakin ingin keluar?';

  @override
  String get dialogResetAppTitle => 'Reset aplikasi';

  @override
  String get dialogResetAppContent =>
      'Semua data akan dihapus, termasuk langganan, folder, favorit, dan playlist.\n\nApakah Anda ingin mereset aplikasi?';

  @override
  String get dialogResetAppSuccess => 'Aplikasi telah direset.';

  @override
  String get dialogClearCacheTitle => 'Hapus cache';

  @override
  String get dialogClearCacheContent =>
      'Hapus cache gambar?\nGambar akan dimuat ulang saat aplikasi dimulai ulang.';

  @override
  String get dialogClearCacheSuccess => 'Cache gambar dihapus.';

  @override
  String get dialogClearCacheFailed => 'Gagal menghapus cache';

  @override
  String dialogBackupSuccess(String filePath) {
    return 'Pencadangan selesai.\nDisimpan di: $filePath';
  }

  @override
  String get dialogBackupCancelled => 'Pencadangan dibatalkan.';

  @override
  String get dialogBackupFailed => 'Pencadangan gagal';

  @override
  String get dialogRestoreTitle => 'Pulihkan data';

  @override
  String get dialogRestoreContent =>
      'Pulihkan data dari cadangan?\nUrutan dan folder yang ada dapat berubah.';

  @override
  String get dialogRestoreSuccess => 'Pemulihan selesai.';

  @override
  String get dialogRestoreFailed => 'Pemulihan gagal';

  @override
  String get folderCreate => 'Buat folder';

  @override
  String get folderEdit => 'Edit folder';

  @override
  String get folderDelete => 'Hapus folder';

  @override
  String get folderName => 'Nama folder';

  @override
  String get folderCreated => 'Folder dibuat.';

  @override
  String get folderUpdated => 'Folder diperbarui.';

  @override
  String get folderDeleted => 'Folder dihapus.';

  @override
  String folderDeleteConfirm(String name) {
    return 'Hapus folder \"$name\"?';
  }

  @override
  String get folderManage => 'Kelola folder';

  @override
  String get folderEmpty => 'Tidak ada folder';

  @override
  String get folderCreateNew => 'Buat folder';

  @override
  String get create => 'Buat';

  @override
  String get edit => 'Edit';

  @override
  String get sectionHome => 'Beranda';

  @override
  String get sectionVideos => 'Video';

  @override
  String get sectionShorts => 'Shorts';

  @override
  String get sectionLive => 'Siaran langsung';

  @override
  String get sectionPodcasts => 'Podcast';

  @override
  String get sectionPlaylists => 'Playlist';

  @override
  String get sectionCommunity => 'Komunitas';

  @override
  String get confirm => 'OK';

  @override
  String get errorUnknown => 'Terjadi kesalahan yang tidak diketahui.';

  @override
  String get errorNetwork => 'Silakan periksa koneksi internet Anda.';

  @override
  String get errorUnauthorized => 'Sesi telah kedaluwarsa.';

  @override
  String get errorQuotaExceeded =>
      'Kuota harian API YouTube terlampaui.\nSilakan coba lagi setelah jam 5 sore (waktu Korea) besok.';

  @override
  String get errorNotFound => 'Data yang diminta tidak ditemukan.';

  @override
  String get errorTimeout => 'Permintaan habis waktu.';

  @override
  String errorGeneric(String error) {
    return 'Terjadi kesalahan: $error';
  }

  @override
  String get appSubtitle => 'Pengelola langganan YouTube';

  @override
  String get loadingVideos => 'Memuat video...';

  @override
  String get allChannelsFilter => 'Berlangganan';

  @override
  String get showFolderFab => 'Tampilkan tombol folder';

  @override
  String get hideFolderFab => 'Sembunyikan tombol folder';

  @override
  String get refreshSubscriptions => 'Segarkan langganan';

  @override
  String get refreshPlaylists => 'Segarkan playlist';

  @override
  String get fetchSubscriptionsTitle => 'Tidak Ada Langganan';

  @override
  String get fetchSubscriptionsMessage =>
      'Apakah Anda ingin mengambil langganan YouTube Anda?';

  @override
  String get fetchSubscriptionsYes => 'Ambil';

  @override
  String get fetchSubscriptionsNo => 'Nanti';

  @override
  String get createFolderDialogTitle => 'Tidak Ada Folder';

  @override
  String get createFolderDialogMessage => 'Apakah Anda ingin membuat folder?';

  @override
  String get createFolderDialogYes => 'Buat';

  @override
  String get createFolderDialogNo => 'Nanti';

  @override
  String get createFolderDialogDontShowAgain => 'Jangan tampilkan lagi';

  @override
  String get createFolderDialogManualGuide =>
      'Anda dapat menambahkan folder nanti di Pengaturan > Kelola folder.';

  @override
  String get swipeEnabledDescription =>
      'Hanya folder yang dicentang yang dapat diakses dengan menggeser';

  @override
  String get filterByChannel => 'Filter berdasarkan saluran';

  @override
  String get allChannels => 'Semua';

  @override
  String get errorDetail => 'Detail kesalahan';

  @override
  String get viewErrorMessage => 'Lihat pesan kesalahan';

  @override
  String get sortDialogTitle => 'Urutkan';

  @override
  String get sortPlaylistOrder => 'Urutan playlist';

  @override
  String get sortPlaylistOrderReverse => 'Urutan playlist (terbalik)';

  @override
  String get sortNewest => 'Terbaru';

  @override
  String get sortOldest => 'Terlama';

  @override
  String get sortTitle => 'Judul';

  @override
  String get loginSubtitle => 'Atur langganan YouTube\nAnda dengan bebas';

  @override
  String get loginWithGoogle => 'Masuk dengan Google';

  @override
  String get loggingIn => 'Sedang masuk...';

  @override
  String get loginPermissionNotice => 'Diperlukan izin baca YouTube';

  @override
  String get loadingSubscriptions => 'Memuat langganan...';

  @override
  String get loginFailed => 'Login gagal.';

  @override
  String get longPressReorder => 'Tekan lama: Urutkan ulang';

  @override
  String get longPressDelete => 'Tekan lama: Hapus';

  @override
  String get showDeleteConfirmation => 'Tampilkan konfirmasi hapus';
}
