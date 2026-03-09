// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get navChannels => '频道';

  @override
  String get navFeed => '动态';

  @override
  String get navFavorites => '收藏';

  @override
  String get navPlaylists => '播放列表';

  @override
  String get navSettings => '设置';

  @override
  String get settingsSectionFolders => '文件夹';

  @override
  String get settingsFolderManage => '管理文件夹';

  @override
  String get settingsFolderManageDesc => '添加、编辑、删除文件夹';

  @override
  String get settingsSectionDisplay => '显示';

  @override
  String get settingsLanguage => '语言 / Language';

  @override
  String get settingsLanguageSystem => '系统设置 (System)';

  @override
  String get settingsChipLayout => '文件夹布局';

  @override
  String get settingsChipLayoutSingleLine => '单行';

  @override
  String get settingsChipLayoutWrap => '换行';

  @override
  String get chipLayoutToggleWrap => '文件夹换行显示';

  @override
  String get chipLayoutToggleSingleLine => '文件夹单行显示';

  @override
  String get settingsFolderView => '文件夹视图';

  @override
  String get settingsShowChannelCount => '显示频道数';

  @override
  String get settingsShowVideoCount => '显示视频数';

  @override
  String get settingsFolderSizeLarge => '大';

  @override
  String get settingsFolderSizeSmall => '小';

  @override
  String get settingsDefaultChannelSection => 'YouTube打开标签';

  @override
  String get settingsVideosPerChannel => '每个频道的视频数';

  @override
  String settingsVideosPerChannelCount(int count) {
    return '$count个';
  }

  @override
  String get settingsCaptionDisplay => '字幕显示';

  @override
  String get settingsCaptionShow => '显示';

  @override
  String get settingsCaptionHide => '隐藏';

  @override
  String get settingsChannelTapAction => '频道点击操作';

  @override
  String get settingsChannelTapLatestVideos => '查看最新视频';

  @override
  String get settingsChannelTapOpenYoutube => '在YouTube中打开';

  @override
  String get settingsVideoCardTapAction => '视频卡片点击操作';

  @override
  String get settingsVideoCardTapInAppPlayer => '应用内播放';

  @override
  String get settingsVideoCardTapOpenYoutube => '在YouTube中打开';

  @override
  String get settingsVideoCardLayoutStyle => '视频卡片布局';

  @override
  String get settingsVideoCardLayoutHorizontal => '横向卡片';

  @override
  String get settingsVideoCardLayoutVertical => '纵向卡片';

  @override
  String get settingsMenuOrder => '菜单顺序';

  @override
  String get settingsMenuOrderDesc => '更改底部导航栏顺序';

  @override
  String get settingsResetApp => '重置应用';

  @override
  String get settingsSectionData => '数据';

  @override
  String get settingsBackup => '备份数据';

  @override
  String get settingsRestore => '恢复数据';

  @override
  String get settingsClearCache => '清除图片缓存';

  @override
  String get settingsSectionInfo => '信息';

  @override
  String get settingsVersion => '版本';

  @override
  String get settingsLicense => '开源许可证';

  @override
  String get settingsSectionAccount => '账户';

  @override
  String get settingsGoogleAccount => 'Google账户';

  @override
  String get settingsNotLoggedIn => '未登录';

  @override
  String get settingsLogout => '退出登录';

  @override
  String get addToFolder => '添加到文件夹';

  @override
  String get sectionSettings => 'YouTube打开标签';

  @override
  String subscriberCount(String count) {
    return '$count 订阅者';
  }

  @override
  String channelsSelected(int count) {
    return '已选择 $count 个频道';
  }

  @override
  String itemsSelected(int count) {
    return '已选择 $count 项';
  }

  @override
  String get timeJustNow => '刚刚';

  @override
  String timeMinutesAgo(int count) {
    return '$count分钟前';
  }

  @override
  String timeHoursAgo(int count) {
    return '$count小时前';
  }

  @override
  String timeDaysAgo(int count) {
    return '$count天前';
  }

  @override
  String timeWeeksAgo(int count) {
    return '$count周前';
  }

  @override
  String timeMonthsAgo(int count) {
    return '$count个月前';
  }

  @override
  String itemCount(int count) {
    return '$count 项';
  }

  @override
  String get deleteConfirmTitle => '删除确认';

  @override
  String deleteSelectedVideosConfirm(int count) {
    return '删除选中的 $count 个视频？';
  }

  @override
  String get deleteFavoriteConfirm => '从收藏中移除？';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get selectAll => '全选';

  @override
  String get select => '选择';

  @override
  String timeYearsAgo(int count) {
    return '$count年前';
  }

  @override
  String videoCount(int count) {
    return '$count 个视频';
  }

  @override
  String channelCount(int count) {
    return '$count 个频道';
  }

  @override
  String playlistCount(int count) {
    return '已加载 $count 个播放列表';
  }

  @override
  String get removeFromFolder => '从文件夹移除';

  @override
  String get deleteChannel => '删除频道';

  @override
  String deleteChannelConfirm(String name) {
    return '确定要完全删除 $name 吗？\n将从所有文件夹中移除。';
  }

  @override
  String removeChannelConfirm(String name) {
    return '确定要从此文件夹中移除 $name 吗？\n订阅将保留。';
  }

  @override
  String deleteChannelsConfirm(int count) {
    return '确定要完全删除 $count 个频道吗？\n将从所有文件夹中移除。';
  }

  @override
  String removeChannelsConfirm(int count) {
    return '确定要从此文件夹中移除 $count 个频道吗？\n订阅将保留。';
  }

  @override
  String get channelDeleted => '频道已删除';

  @override
  String get removedFromFolder => '已从文件夹中移除';

  @override
  String addedToFolder(String name) {
    return '已添加到 $name';
  }

  @override
  String channelsDeleted(int count) {
    return '已删除 $count 个频道';
  }

  @override
  String channelsRemoved(int count) {
    return '已移除 $count 个频道';
  }

  @override
  String channelsAddedTo(int count, String name) {
    return '已将 $count 个频道添加到 $name';
  }

  @override
  String get cannotOpenChannel => '无法打开频道';

  @override
  String get pleaseSelectChannels => '请选择频道';

  @override
  String get createFolderFirst => '请先创建文件夹';

  @override
  String get createCategoryFirst => '请先创建分类';

  @override
  String get unsubscribed => '未订阅';

  @override
  String uploadedAgo(String time) {
    return '$time上传';
  }

  @override
  String sectionSettingsTitle(String title) {
    return '$title\n版块设置';
  }

  @override
  String useDefaultSection(String section) {
    return '使用默认 ($section)';
  }

  @override
  String get sectionSetToDefault => '已设为默认版块';

  @override
  String sectionSetTo(String section) {
    return '已设为 $section 版块';
  }

  @override
  String get channelsUpdated => '频道列表已更新';

  @override
  String get noSubscriptions => '没有订阅的频道';

  @override
  String get noSearchResults => '没有搜索结果';

  @override
  String get cannotLoadPlaylists => '无法加载播放列表';

  @override
  String get retry => '重试';

  @override
  String get noPlaylists => '没有播放列表';

  @override
  String get noVideos => '没有视频';

  @override
  String get noFavorites => '没有收藏的视频';

  @override
  String get customOrder => '自定义顺序';

  @override
  String get alphabetical => '按字母顺序';

  @override
  String get multiSelect => '多选';

  @override
  String get openInYoutube => '在YouTube中打开';

  @override
  String get latestVideos => '最新视频';

  @override
  String formatTenThousand(String count) {
    return '$count万';
  }

  @override
  String formatThousand(String count) {
    return '$count千';
  }

  @override
  String formatMillion(String count) {
    return '$count百万';
  }

  @override
  String get dialogLogoutTitle => '退出登录';

  @override
  String get dialogLogoutContent => '确定要退出登录吗？';

  @override
  String get dialogResetAppTitle => '重置应用';

  @override
  String get dialogResetAppContent => '所有数据将被删除，包括订阅、文件夹、收藏和播放列表。\n\n是否要重置应用？';

  @override
  String get dialogResetAppSuccess => '应用已重置。';

  @override
  String get dialogClearCacheTitle => '清除缓存';

  @override
  String get dialogClearCacheContent => '清除图片缓存？\n重启应用后将重新加载图片。';

  @override
  String get dialogClearCacheSuccess => '图片缓存已清除。';

  @override
  String get dialogClearCacheFailed => '清除缓存失败';

  @override
  String dialogBackupSuccess(String filePath) {
    return '备份完成。\n保存位置: $filePath';
  }

  @override
  String get dialogBackupCancelled => '备份已取消。';

  @override
  String get dialogBackupFailed => '备份失败';

  @override
  String get dialogRestoreTitle => '恢复数据';

  @override
  String get dialogRestoreContent => '从备份文件恢复数据？\n现有的排序和文件夹可能会被更改。';

  @override
  String get dialogRestoreSuccess => '恢复完成。';

  @override
  String get dialogRestoreFailed => '恢复失败';

  @override
  String get folderCreate => '创建文件夹';

  @override
  String get folderEdit => '编辑文件夹';

  @override
  String get folderDelete => '删除文件夹';

  @override
  String get folderName => '文件夹名称';

  @override
  String get folderCreated => '文件夹已创建。';

  @override
  String get folderUpdated => '文件夹已更新。';

  @override
  String get folderDeleted => '文件夹已删除。';

  @override
  String folderDeleteConfirm(String name) {
    return '删除「$name」文件夹？';
  }

  @override
  String get folderManage => '管理文件夹';

  @override
  String get folderEmpty => '没有文件夹';

  @override
  String get folderCreateNew => '创建文件夹';

  @override
  String get create => '创建';

  @override
  String get edit => '编辑';

  @override
  String get sectionHome => '主页';

  @override
  String get sectionVideos => '视频';

  @override
  String get sectionShorts => '短视频';

  @override
  String get sectionLive => '直播';

  @override
  String get sectionPodcasts => '播客';

  @override
  String get sectionPlaylists => '播放列表';

  @override
  String get sectionCommunity => '社区';

  @override
  String get confirm => '确定';

  @override
  String get errorUnknown => '发生未知错误。';

  @override
  String get errorNetwork => '请检查网络连接。';

  @override
  String get errorUnauthorized => '登录已过期。';

  @override
  String get errorQuotaExceeded => '已超出YouTube API每日配额。\n请在明天下午5点（北京时间）后重试。';

  @override
  String get errorNotFound => '未找到请求的数据。';

  @override
  String get errorTimeout => '请求超时。';

  @override
  String errorGeneric(String error) {
    return '发生错误: $error';
  }

  @override
  String get appSubtitle => 'YouTube订阅管理';

  @override
  String get loadingVideos => '正在加载视频...';

  @override
  String get allChannelsFilter => '已订阅';

  @override
  String get showFolderFab => '显示文件夹按钮';

  @override
  String get hideFolderFab => '隐藏文件夹按钮';

  @override
  String get refreshSubscriptions => '刷新订阅';

  @override
  String get refreshPlaylists => '刷新播放列表';

  @override
  String get fetchSubscriptionsTitle => '没有订阅';

  @override
  String get fetchSubscriptionsMessage => '是否获取YouTube订阅频道？';

  @override
  String get fetchSubscriptionsYes => '获取';

  @override
  String get fetchSubscriptionsNo => '稍后';

  @override
  String get createFolderDialogTitle => '没有文件夹';

  @override
  String get createFolderDialogMessage => '是否创建文件夹？';

  @override
  String get createFolderDialogYes => '创建';

  @override
  String get createFolderDialogNo => '稍后';

  @override
  String get createFolderDialogDontShowAgain => '不再显示';

  @override
  String get createFolderDialogManualGuide => '您可以稍后在设置 > 管理文件夹中添加文件夹。';

  @override
  String get swipeEnabledDescription => '仅选中的文件夹可通过滑动访问';

  @override
  String get filterByChannel => '按频道筛选';

  @override
  String get allChannels => '全部';

  @override
  String get errorDetail => '错误详情';

  @override
  String get viewErrorMessage => '查看错误信息';

  @override
  String get sortDialogTitle => '排序';

  @override
  String get sortPlaylistOrder => '播放列表顺序';

  @override
  String get sortPlaylistOrderReverse => '播放列表倒序';

  @override
  String get sortNewest => '最新';

  @override
  String get sortOldest => '最旧';

  @override
  String get sortTitle => '标题';

  @override
  String get loginSubtitle => '自由整理您的\nYouTube订阅频道';

  @override
  String get loginWithGoogle => '使用Google登录';

  @override
  String get loggingIn => '登录中...';

  @override
  String get loginPermissionNotice => '需要YouTube读取权限';

  @override
  String get loadingSubscriptions => '正在加载订阅频道...';

  @override
  String get loginFailed => '登录失败。';

  @override
  String get longPressReorder => '长按: 排序';

  @override
  String get longPressDelete => '长按: 删除';

  @override
  String get showDeleteConfirmation => '删除时显示确认消息';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get navChannels => '頻道';

  @override
  String get navFeed => '動態';

  @override
  String get navFavorites => '收藏';

  @override
  String get navPlaylists => '播放清單';

  @override
  String get navSettings => '設定';

  @override
  String get settingsSectionFolders => '資料夾';

  @override
  String get settingsFolderManage => '管理資料夾';

  @override
  String get settingsFolderManageDesc => '新增、編輯、刪除資料夾';

  @override
  String get settingsSectionDisplay => '顯示';

  @override
  String get settingsLanguage => '語言 / Language';

  @override
  String get settingsLanguageSystem => '系統設定 (System)';

  @override
  String get settingsChipLayout => '收藏佈局';

  @override
  String get settingsChipLayoutSingleLine => '單行';

  @override
  String get settingsChipLayoutWrap => '換行';

  @override
  String get chipLayoutToggleWrap => '資料夾換行顯示';

  @override
  String get chipLayoutToggleSingleLine => '資料夾單行顯示';

  @override
  String get settingsFolderView => '資料夾顯示';

  @override
  String get settingsShowChannelCount => '顯示頻道數';

  @override
  String get settingsShowVideoCount => '顯示影片數';

  @override
  String get settingsFolderSizeLarge => '大';

  @override
  String get settingsFolderSizeSmall => '小';

  @override
  String get settingsDefaultChannelSection => 'YouTube開啟分頁';

  @override
  String get settingsVideosPerChannel => '每個頻道的影片數';

  @override
  String settingsVideosPerChannelCount(int count) {
    return '$count部';
  }

  @override
  String get settingsCaptionDisplay => '字幕顯示';

  @override
  String get settingsCaptionShow => '顯示';

  @override
  String get settingsCaptionHide => '隱藏';

  @override
  String get settingsChannelTapAction => '頻道點擊動作';

  @override
  String get settingsChannelTapLatestVideos => '查看最新影片';

  @override
  String get settingsChannelTapOpenYoutube => '在YouTube中開啟';

  @override
  String get settingsVideoCardTapAction => '影片卡片點擊動作';

  @override
  String get settingsVideoCardTapInAppPlayer => '應用程式內播放';

  @override
  String get settingsVideoCardTapOpenYoutube => '在YouTube中開啟';

  @override
  String get settingsVideoCardLayoutStyle => '影片卡片佈局';

  @override
  String get settingsVideoCardLayoutHorizontal => '橫向卡片';

  @override
  String get settingsVideoCardLayoutVertical => '縱向卡片';

  @override
  String get settingsMenuOrder => '選單順序';

  @override
  String get settingsMenuOrderDesc => '變更底部導覽列順序';

  @override
  String get settingsResetApp => '重設應用程式';

  @override
  String get settingsSectionData => '資料';

  @override
  String get settingsBackup => '備份資料';

  @override
  String get settingsRestore => '還原資料';

  @override
  String get settingsClearCache => '清除圖片快取';

  @override
  String get settingsSectionInfo => '資訊';

  @override
  String get settingsVersion => '版本';

  @override
  String get settingsLicense => '開放原始碼授權';

  @override
  String get settingsSectionAccount => '帳戶';

  @override
  String get settingsGoogleAccount => 'Google帳戶';

  @override
  String get settingsNotLoggedIn => '尚未登入';

  @override
  String get settingsLogout => '登出';

  @override
  String get addToFolder => '加入資料夾';

  @override
  String get sectionSettings => 'YouTube開啟分頁';

  @override
  String subscriberCount(String count) {
    return '$count 訂閱者';
  }

  @override
  String channelsSelected(int count) {
    return '已選取 $count 個頻道';
  }

  @override
  String itemsSelected(int count) {
    return '已選取 $count 項';
  }

  @override
  String get timeJustNow => '剛剛';

  @override
  String timeMinutesAgo(int count) {
    return '$count分鐘前';
  }

  @override
  String timeHoursAgo(int count) {
    return '$count小時前';
  }

  @override
  String timeDaysAgo(int count) {
    return '$count天前';
  }

  @override
  String timeWeeksAgo(int count) {
    return '$count週前';
  }

  @override
  String timeMonthsAgo(int count) {
    return '$count個月前';
  }

  @override
  String itemCount(int count) {
    return '$count 項';
  }

  @override
  String get deleteConfirmTitle => '刪除確認';

  @override
  String deleteSelectedVideosConfirm(int count) {
    return '刪除選取的 $count 部影片？';
  }

  @override
  String get deleteFavoriteConfirm => '從收藏中移除？';

  @override
  String get cancel => '取消';

  @override
  String get delete => '刪除';

  @override
  String get selectAll => '全選';

  @override
  String get select => '選取';

  @override
  String timeYearsAgo(int count) {
    return '$count年前';
  }

  @override
  String videoCount(int count) {
    return '$count 部影片';
  }

  @override
  String channelCount(int count) {
    return '$count 個頻道';
  }

  @override
  String playlistCount(int count) {
    return '已載入 $count 個播放清單';
  }

  @override
  String get removeFromFolder => '從資料夾中移除';

  @override
  String get deleteChannel => '刪除頻道';

  @override
  String deleteChannelConfirm(String name) {
    return '確定要完全刪除 $name 嗎？\n將從所有資料夾中移除。';
  }

  @override
  String removeChannelConfirm(String name) {
    return '確定要從此資料夾中移除 $name 嗎？\n訂閱將保留。';
  }

  @override
  String deleteChannelsConfirm(int count) {
    return '確定要完全刪除 $count 個頻道嗎？\n將從所有資料夾中移除。';
  }

  @override
  String removeChannelsConfirm(int count) {
    return '確定要從此資料夾中移除 $count 個頻道嗎？\n訂閱將保留。';
  }

  @override
  String get channelDeleted => '頻道已刪除';

  @override
  String get removedFromFolder => '已從資料夾中移除';

  @override
  String addedToFolder(String name) {
    return '已加入 $name';
  }

  @override
  String channelsDeleted(int count) {
    return '已刪除 $count 個頻道';
  }

  @override
  String channelsRemoved(int count) {
    return '已移除 $count 個頻道';
  }

  @override
  String channelsAddedTo(int count, String name) {
    return '已將 $count 個頻道加入 $name';
  }

  @override
  String get cannotOpenChannel => '無法開啟頻道';

  @override
  String get pleaseSelectChannels => '請選取頻道';

  @override
  String get createFolderFirst => '請先建立資料夾';

  @override
  String get createCategoryFirst => '請先建立分類';

  @override
  String get unsubscribed => '未訂閱';

  @override
  String uploadedAgo(String time) {
    return '$time上傳';
  }

  @override
  String sectionSettingsTitle(String title) {
    return '$title\n區塊設定';
  }

  @override
  String useDefaultSection(String section) {
    return '使用預設 ($section)';
  }

  @override
  String get sectionSetToDefault => '已設為預設區塊';

  @override
  String sectionSetTo(String section) {
    return '已設為 $section 區塊';
  }

  @override
  String get channelsUpdated => '頻道清單已更新';

  @override
  String get noSubscriptions => '沒有訂閱的頻道';

  @override
  String get noSearchResults => '沒有搜尋結果';

  @override
  String get cannotLoadPlaylists => '無法載入播放清單';

  @override
  String get retry => '重試';

  @override
  String get noPlaylists => '沒有播放清單';

  @override
  String get noVideos => '沒有影片';

  @override
  String get noFavorites => '沒有收藏的影片';

  @override
  String get customOrder => '自訂順序';

  @override
  String get alphabetical => '按字母順序';

  @override
  String get multiSelect => '多選';

  @override
  String get openInYoutube => '在YouTube中開啟';

  @override
  String get latestVideos => '最新影片';

  @override
  String formatTenThousand(String count) {
    return '$count萬';
  }

  @override
  String formatThousand(String count) {
    return '$count千';
  }

  @override
  String formatMillion(String count) {
    return '$count百萬';
  }

  @override
  String get dialogLogoutTitle => '登出';

  @override
  String get dialogLogoutContent => '確定要登出嗎？';

  @override
  String get dialogResetAppTitle => '重設應用程式';

  @override
  String get dialogResetAppContent =>
      '所有資料將被刪除，包括訂閱、資料夾、收藏和播放清單。\n\n是否要重設應用程式？';

  @override
  String get dialogResetAppSuccess => '應用程式已重設。';

  @override
  String get dialogClearCacheTitle => '清除快取';

  @override
  String get dialogClearCacheContent => '清除圖片快取？\n重新啟動應用程式後將重新載入圖片。';

  @override
  String get dialogClearCacheSuccess => '圖片快取已清除。';

  @override
  String get dialogClearCacheFailed => '清除快取失敗';

  @override
  String dialogBackupSuccess(String filePath) {
    return '備份完成。\n儲存位置: $filePath';
  }

  @override
  String get dialogBackupCancelled => '備份已取消。';

  @override
  String get dialogBackupFailed => '備份失敗';

  @override
  String get dialogRestoreTitle => '還原資料';

  @override
  String get dialogRestoreContent => '從備份檔案還原資料？\n現有的排序和資料夾可能會被變更。';

  @override
  String get dialogRestoreSuccess => '還原完成。';

  @override
  String get dialogRestoreFailed => '還原失敗';

  @override
  String get folderCreate => '建立資料夾';

  @override
  String get folderEdit => '編輯資料夾';

  @override
  String get folderDelete => '刪除資料夾';

  @override
  String get folderName => '資料夾名稱';

  @override
  String get folderCreated => '資料夾已建立。';

  @override
  String get folderUpdated => '資料夾已更新。';

  @override
  String get folderDeleted => '資料夾已刪除。';

  @override
  String folderDeleteConfirm(String name) {
    return '刪除「$name」資料夾？';
  }

  @override
  String get folderManage => '管理資料夾';

  @override
  String get folderEmpty => '沒有資料夾';

  @override
  String get folderCreateNew => '建立資料夾';

  @override
  String get create => '建立';

  @override
  String get edit => '編輯';

  @override
  String get sectionHome => '首頁';

  @override
  String get sectionVideos => '影片';

  @override
  String get sectionShorts => '短影片';

  @override
  String get sectionLive => '直播';

  @override
  String get sectionPodcasts => 'Podcast';

  @override
  String get sectionPlaylists => '播放清單';

  @override
  String get sectionCommunity => '社群';

  @override
  String get confirm => '確定';

  @override
  String get errorUnknown => '發生未知錯誤。';

  @override
  String get errorNetwork => '請檢查網路連線。';

  @override
  String get errorUnauthorized => '登入已過期。';

  @override
  String get errorQuotaExceeded => '已超出YouTube API每日配額。\n請在明天下午5點（台灣時間）後重試。';

  @override
  String get errorNotFound => '找不到請求的資料。';

  @override
  String get errorTimeout => '請求逾時。';

  @override
  String errorGeneric(String error) {
    return '發生錯誤: $error';
  }

  @override
  String get appSubtitle => 'YouTube訂閱管理';

  @override
  String get loadingVideos => '正在載入影片...';

  @override
  String get allChannelsFilter => '已訂閱';

  @override
  String get showFolderFab => '顯示資料夾按鈕';

  @override
  String get hideFolderFab => '隱藏資料夾按鈕';

  @override
  String get refreshSubscriptions => '重新整理訂閱';

  @override
  String get refreshPlaylists => '重新整理播放清單';

  @override
  String get fetchSubscriptionsTitle => '沒有訂閱';

  @override
  String get fetchSubscriptionsMessage => '是否取得您的YouTube訂閱頻道？';

  @override
  String get fetchSubscriptionsYes => '取得';

  @override
  String get fetchSubscriptionsNo => '稍後';

  @override
  String get createFolderDialogTitle => '沒有資料夾';

  @override
  String get createFolderDialogMessage => '是否建立資料夾？';

  @override
  String get createFolderDialogYes => '建立';

  @override
  String get createFolderDialogNo => '稍後';

  @override
  String get createFolderDialogDontShowAgain => '不再顯示';

  @override
  String get createFolderDialogManualGuide => '您可以稍後在設定 > 管理資料夾中新增資料夾。';

  @override
  String get swipeEnabledDescription => '僅勾選的資料夾可透過滑動存取';

  @override
  String get filterByChannel => '依頻道篩選';

  @override
  String get allChannels => '全部';

  @override
  String get errorDetail => '錯誤詳情';

  @override
  String get viewErrorMessage => '查看錯誤訊息';

  @override
  String get sortDialogTitle => '排序';

  @override
  String get sortPlaylistOrder => '播放清單順序';

  @override
  String get sortPlaylistOrderReverse => '播放清單倒序';

  @override
  String get sortNewest => '最新';

  @override
  String get sortOldest => '最舊';

  @override
  String get sortTitle => '標題';

  @override
  String get loginSubtitle => '自由整理您的\nYouTube訂閱頻道';

  @override
  String get loginWithGoogle => '使用Google登入';

  @override
  String get loggingIn => '登入中...';

  @override
  String get loginPermissionNotice => '需要YouTube讀取權限';

  @override
  String get loadingSubscriptions => '正在載入訂閱頻道...';

  @override
  String get loginFailed => '登入失敗。';

  @override
  String get longPressReorder => '長按: 排序';

  @override
  String get longPressDelete => '長按: 刪除';

  @override
  String get showDeleteConfirmation => '刪除時顯示確認訊息';
}
