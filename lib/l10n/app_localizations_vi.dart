// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get navChannels => 'Kênh';

  @override
  String get navFeed => 'Bảng tin';

  @override
  String get navFavorites => 'Yêu thích';

  @override
  String get navPlaylists => 'Danh sách phát';

  @override
  String get navSettings => 'Cài đặt';

  @override
  String get settingsSectionFolders => 'Thư mục';

  @override
  String get settingsFolderManage => 'Quản lý thư mục';

  @override
  String get settingsFolderManageDesc => 'Thêm, sửa, xóa thư mục';

  @override
  String get settingsSectionDisplay => 'Hiển thị';

  @override
  String get settingsLanguage => 'Ngôn ngữ / Language';

  @override
  String get settingsLanguageSystem => 'Hệ thống (System)';

  @override
  String get settingsChipLayout => 'Bố cục thư mục';

  @override
  String get settingsChipLayoutSingleLine => 'Một dòng';

  @override
  String get settingsChipLayoutWrap => 'Xuống dòng';

  @override
  String get chipLayoutToggleWrap => 'Xem dạng xuống dòng';

  @override
  String get chipLayoutToggleSingleLine => 'Xem dạng một dòng';

  @override
  String get settingsFolderView => 'Chế độ xem thư mục';

  @override
  String get settingsShowChannelCount => 'Hiển thị số lượng kênh';

  @override
  String get settingsShowVideoCount => 'Hiển thị số lượng video';

  @override
  String get settingsFolderSizeLarge => 'Lớn';

  @override
  String get settingsFolderSizeSmall => 'Nhỏ';

  @override
  String get settingsDefaultChannelSection => 'Tab mở YouTube';

  @override
  String get settingsVideosPerChannel => 'Video mỗi kênh';

  @override
  String settingsVideosPerChannelCount(int count) {
    return '$count';
  }

  @override
  String get settingsCaptionDisplay => 'Hiển thị phụ đề';

  @override
  String get settingsCaptionShow => 'Hiện';

  @override
  String get settingsCaptionHide => 'Ẩn';

  @override
  String get settingsChannelTapAction => 'Hành động chạm kênh';

  @override
  String get settingsChannelTapLatestVideos => 'Xem video mới nhất';

  @override
  String get settingsChannelTapOpenYoutube => 'Mở trong YouTube';

  @override
  String get settingsVideoCardTapAction => 'Hành động chạm thẻ video';

  @override
  String get settingsVideoCardTapInAppPlayer => 'Trình phát trong ứng dụng';

  @override
  String get settingsVideoCardTapOpenYoutube => 'Mở trong YouTube';

  @override
  String get settingsVideoCardLayoutStyle => 'Bố cục thẻ video';

  @override
  String get settingsVideoCardLayoutHorizontal => 'Thẻ ngang';

  @override
  String get settingsVideoCardLayoutVertical => 'Thẻ dọc';

  @override
  String get settingsMenuOrder => 'Thứ tự menu';

  @override
  String get settingsMenuOrderDesc => 'Thay đổi thứ tự thanh điều hướng dưới';

  @override
  String get settingsResetApp => 'Đặt lại ứng dụng';

  @override
  String get settingsSectionData => 'Dữ liệu';

  @override
  String get settingsBackup => 'Sao lưu dữ liệu';

  @override
  String get settingsRestore => 'Khôi phục dữ liệu';

  @override
  String get settingsClearCache => 'Xóa bộ nhớ đệm hình ảnh';

  @override
  String get settingsSectionInfo => 'Thông tin';

  @override
  String get settingsVersion => 'Phiên bản';

  @override
  String get settingsLicense => 'Giấy phép nguồn mở';

  @override
  String get settingsSectionAccount => 'Tài khoản';

  @override
  String get settingsGoogleAccount => 'Tài khoản Google';

  @override
  String get settingsNotLoggedIn => 'Chưa đăng nhập';

  @override
  String get settingsLogout => 'Đăng xuất';

  @override
  String get addToFolder => 'Thêm vào thư mục';

  @override
  String get sectionSettings => 'Tab mở YouTube';

  @override
  String subscriberCount(String count) {
    return '$count người đăng ký';
  }

  @override
  String channelsSelected(int count) {
    return 'Đã chọn $count kênh';
  }

  @override
  String itemsSelected(int count) {
    return 'Đã chọn $count';
  }

  @override
  String get timeJustNow => 'Vừa xong';

  @override
  String timeMinutesAgo(int count) {
    return '$count phút trước';
  }

  @override
  String timeHoursAgo(int count) {
    return '$count giờ trước';
  }

  @override
  String timeDaysAgo(int count) {
    return '$count ngày trước';
  }

  @override
  String timeWeeksAgo(int count) {
    return '$count tuần trước';
  }

  @override
  String timeMonthsAgo(int count) {
    return '$count tháng trước';
  }

  @override
  String itemCount(int count) {
    return '$count mục';
  }

  @override
  String get deleteConfirmTitle => 'Xác nhận xóa';

  @override
  String deleteSelectedVideosConfirm(int count) {
    return 'Xóa $count video đã chọn?';
  }

  @override
  String get deleteFavoriteConfirm => 'Xóa khỏi yêu thích?';

  @override
  String get cancel => 'Hủy';

  @override
  String get delete => 'Xóa';

  @override
  String get selectAll => 'Chọn tất cả';

  @override
  String get select => 'Chọn';

  @override
  String timeYearsAgo(int count) {
    return '$count năm trước';
  }

  @override
  String videoCount(int count) {
    return '$count video';
  }

  @override
  String channelCount(int count) {
    return '$count kênh';
  }

  @override
  String playlistCount(int count) {
    return 'Đã tải $count danh sách phát';
  }

  @override
  String get removeFromFolder => 'Xóa khỏi thư mục';

  @override
  String get deleteChannel => 'Xóa kênh';

  @override
  String deleteChannelConfirm(String name) {
    return 'Bạn có chắc muốn xóa hoàn toàn $name?\nSẽ bị xóa khỏi tất cả thư mục.';
  }

  @override
  String removeChannelConfirm(String name) {
    return 'Bạn có chắc muốn xóa $name khỏi thư mục này?\nĐăng ký sẽ được giữ lại.';
  }

  @override
  String deleteChannelsConfirm(int count) {
    return 'Bạn có chắc muốn xóa hoàn toàn $count kênh?\nSẽ bị xóa khỏi tất cả thư mục.';
  }

  @override
  String removeChannelsConfirm(int count) {
    return 'Bạn có chắc muốn xóa $count kênh khỏi thư mục này?\nĐăng ký sẽ được giữ lại.';
  }

  @override
  String get channelDeleted => 'Đã xóa kênh';

  @override
  String get removedFromFolder => 'Đã xóa khỏi thư mục';

  @override
  String addedToFolder(String name) {
    return 'Đã thêm vào $name';
  }

  @override
  String channelsDeleted(int count) {
    return 'Đã xóa $count kênh';
  }

  @override
  String channelsRemoved(int count) {
    return 'Đã xóa $count kênh';
  }

  @override
  String channelsAddedTo(int count, String name) {
    return 'Đã thêm $count kênh vào $name';
  }

  @override
  String get cannotOpenChannel => 'Không thể mở kênh';

  @override
  String get pleaseSelectChannels => 'Vui lòng chọn kênh';

  @override
  String get createFolderFirst => 'Vui lòng tạo thư mục trước';

  @override
  String get createCategoryFirst => 'Vui lòng tạo danh mục trước';

  @override
  String get unsubscribed => 'Đã hủy đăng ký';

  @override
  String uploadedAgo(String time) {
    return 'Đã tải lên $time';
  }

  @override
  String sectionSettingsTitle(String title) {
    return '$title\nCài đặt mục';
  }

  @override
  String useDefaultSection(String section) {
    return 'Sử dụng mặc định ($section)';
  }

  @override
  String get sectionSetToDefault => 'Đã đặt mục về mặc định';

  @override
  String sectionSetTo(String section) {
    return 'Đã đặt thành mục $section';
  }

  @override
  String get channelsUpdated => 'Đã cập nhật danh sách kênh';

  @override
  String get noSubscriptions => 'Không có kênh đã đăng ký';

  @override
  String get noSearchResults => 'Không có kết quả tìm kiếm';

  @override
  String get cannotLoadPlaylists => 'Không thể tải danh sách phát';

  @override
  String get retry => 'Thử lại';

  @override
  String get noPlaylists => 'Không có danh sách phát';

  @override
  String get noVideos => 'Không có video';

  @override
  String get noFavorites => 'Không có video yêu thích';

  @override
  String get customOrder => 'Thứ tự tùy chỉnh';

  @override
  String get alphabetical => 'Theo bảng chữ cái';

  @override
  String get multiSelect => 'Chọn nhiều';

  @override
  String get openInYoutube => 'Mở trong YouTube';

  @override
  String get latestVideos => 'Video mới nhất';

  @override
  String formatTenThousand(String count) {
    return '${count}N';
  }

  @override
  String formatThousand(String count) {
    return '${count}K';
  }

  @override
  String formatMillion(String count) {
    return '${count}Tr';
  }

  @override
  String get dialogLogoutTitle => 'Đăng xuất';

  @override
  String get dialogLogoutContent => 'Bạn có chắc muốn đăng xuất?';

  @override
  String get dialogResetAppTitle => 'Đặt lại ứng dụng';

  @override
  String get dialogResetAppContent =>
      'Tất cả dữ liệu sẽ bị xóa, bao gồm đăng ký, thư mục, yêu thích và danh sách phát.\n\nBạn có muốn đặt lại ứng dụng không?';

  @override
  String get dialogResetAppSuccess => 'Ứng dụng đã được đặt lại.';

  @override
  String get dialogClearCacheTitle => 'Xóa bộ nhớ đệm';

  @override
  String get dialogClearCacheContent =>
      'Xóa bộ nhớ đệm hình ảnh?\nHình ảnh sẽ được tải lại khi khởi động lại ứng dụng.';

  @override
  String get dialogClearCacheSuccess => 'Đã xóa bộ nhớ đệm hình ảnh.';

  @override
  String get dialogClearCacheFailed => 'Xóa bộ nhớ đệm thất bại';

  @override
  String dialogBackupSuccess(String filePath) {
    return 'Sao lưu hoàn tất.\nĐã lưu tại: $filePath';
  }

  @override
  String get dialogBackupCancelled => 'Đã hủy sao lưu.';

  @override
  String get dialogBackupFailed => 'Sao lưu thất bại';

  @override
  String get dialogRestoreTitle => 'Khôi phục dữ liệu';

  @override
  String get dialogRestoreContent =>
      'Khôi phục dữ liệu từ tệp sao lưu?\nThứ tự sắp xếp và thư mục hiện có có thể bị thay đổi.';

  @override
  String get dialogRestoreSuccess => 'Khôi phục hoàn tất.';

  @override
  String get dialogRestoreFailed => 'Khôi phục thất bại';

  @override
  String get folderCreate => 'Tạo thư mục';

  @override
  String get folderEdit => 'Sửa thư mục';

  @override
  String get folderDelete => 'Xóa thư mục';

  @override
  String get folderName => 'Tên thư mục';

  @override
  String get folderCreated => 'Đã tạo thư mục.';

  @override
  String get folderUpdated => 'Đã cập nhật thư mục.';

  @override
  String get folderDeleted => 'Đã xóa thư mục.';

  @override
  String folderDeleteConfirm(String name) {
    return 'Xóa thư mục \"$name\"?';
  }

  @override
  String get folderManage => 'Quản lý thư mục';

  @override
  String get folderEmpty => 'Không có thư mục';

  @override
  String get folderCreateNew => 'Tạo thư mục';

  @override
  String get create => 'Tạo';

  @override
  String get edit => 'Sửa';

  @override
  String get sectionHome => 'Trang chủ';

  @override
  String get sectionVideos => 'Video';

  @override
  String get sectionShorts => 'Shorts';

  @override
  String get sectionLive => 'Trực tiếp';

  @override
  String get sectionPodcasts => 'Podcast';

  @override
  String get sectionPlaylists => 'Danh sách phát';

  @override
  String get sectionCommunity => 'Cộng đồng';

  @override
  String get confirm => 'OK';

  @override
  String get errorUnknown => 'Đã xảy ra lỗi không xác định.';

  @override
  String get errorNetwork => 'Vui lòng kiểm tra kết nối internet.';

  @override
  String get errorUnauthorized => 'Phiên đăng nhập đã hết hạn.';

  @override
  String get errorQuotaExceeded =>
      'Đã vượt quá hạn ngạch YouTube API hàng ngày.\nVui lòng thử lại sau 17:00 (giờ Việt Nam) ngày mai.';

  @override
  String get errorNotFound => 'Không tìm thấy dữ liệu được yêu cầu.';

  @override
  String get errorTimeout => 'Yêu cầu đã hết thời gian.';

  @override
  String errorGeneric(String error) {
    return 'Đã xảy ra lỗi: $error';
  }

  @override
  String get appSubtitle => 'Quản lý đăng ký YouTube';

  @override
  String get loadingVideos => 'Đang tải video...';

  @override
  String get allChannelsFilter => 'Đã đăng ký';

  @override
  String get showFolderFab => 'Hiển thị nút thư mục';

  @override
  String get hideFolderFab => 'Ẩn nút thư mục';

  @override
  String get refreshSubscriptions => 'Làm mới đăng ký';

  @override
  String get refreshPlaylists => 'Làm mới danh sách phát';

  @override
  String get fetchSubscriptionsTitle => 'Không Có Đăng Ký';

  @override
  String get fetchSubscriptionsMessage =>
      'Bạn có muốn lấy đăng ký YouTube của mình không?';

  @override
  String get fetchSubscriptionsYes => 'Lấy';

  @override
  String get fetchSubscriptionsNo => 'Để Sau';

  @override
  String get createFolderDialogTitle => 'Không có thư mục';

  @override
  String get createFolderDialogMessage => 'Bạn có muốn tạo thư mục không?';

  @override
  String get createFolderDialogYes => 'Tạo';

  @override
  String get createFolderDialogNo => 'Để sau';

  @override
  String get createFolderDialogDontShowAgain => 'Không hiển thị lại';

  @override
  String get createFolderDialogManualGuide =>
      'Bạn có thể thêm thư mục sau trong Cài đặt > Quản lý thư mục.';

  @override
  String get swipeEnabledDescription =>
      'Chỉ các thư mục được chọn mới có thể vuốt để truy cập';

  @override
  String get filterByChannel => 'Lọc theo kênh';

  @override
  String get allChannels => 'Tất cả';

  @override
  String get errorDetail => 'Chi tiết lỗi';

  @override
  String get viewErrorMessage => 'Xem thông báo lỗi';

  @override
  String get sortDialogTitle => 'Sắp xếp';

  @override
  String get sortPlaylistOrder => 'Thứ tự danh sách';

  @override
  String get sortPlaylistOrderReverse => 'Thứ tự danh sách (đảo ngược)';

  @override
  String get sortNewest => 'Mới nhất';

  @override
  String get sortOldest => 'Cũ nhất';

  @override
  String get sortTitle => 'Tiêu đề';

  @override
  String get loginSubtitle => 'Sắp xếp tự do các đăng ký\nYouTube của bạn';

  @override
  String get loginWithGoogle => 'Đăng nhập bằng Google';

  @override
  String get loggingIn => 'Đang đăng nhập...';

  @override
  String get loginPermissionNotice => 'Cần quyền đọc YouTube';

  @override
  String get loadingSubscriptions => 'Đang tải đăng ký...';

  @override
  String get loginFailed => 'Đăng nhập thất bại.';

  @override
  String get longPressReorder => 'Nhấn giữ: Sắp xếp lại';

  @override
  String get longPressDelete => 'Nhấn giữ: Xóa';

  @override
  String get showDeleteConfirmation => 'Hiển thị xác nhận xóa';
}
