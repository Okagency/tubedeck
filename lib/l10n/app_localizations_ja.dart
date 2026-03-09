// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get navChannels => 'チャンネル';

  @override
  String get navFeed => 'フィード';

  @override
  String get navFavorites => 'お気に入り';

  @override
  String get navPlaylists => '再生リスト';

  @override
  String get navSettings => '設定';

  @override
  String get settingsSectionFolders => 'フォルダ';

  @override
  String get settingsFolderManage => 'フォルダ管理';

  @override
  String get settingsFolderManageDesc => 'フォルダの追加・編集・削除';

  @override
  String get settingsSectionDisplay => '表示';

  @override
  String get settingsLanguage => '言語 / Language';

  @override
  String get settingsLanguageSystem => 'システム設定 (System)';

  @override
  String get settingsChipLayout => 'フォルダ配置';

  @override
  String get settingsChipLayoutSingleLine => '1行';

  @override
  String get settingsChipLayoutWrap => '折り返し';

  @override
  String get chipLayoutToggleWrap => 'フォルダ折り返し表示';

  @override
  String get chipLayoutToggleSingleLine => 'フォルダ1行表示';

  @override
  String get settingsFolderView => 'フォルダ表示';

  @override
  String get settingsShowChannelCount => 'チャンネル数を表示';

  @override
  String get settingsShowVideoCount => '動画数を表示';

  @override
  String get settingsFolderSizeLarge => '大きい';

  @override
  String get settingsFolderSizeSmall => '小さい';

  @override
  String get settingsDefaultChannelSection => 'YouTube開くタブ';

  @override
  String get settingsVideosPerChannel => 'チャンネルごとの動画数';

  @override
  String settingsVideosPerChannelCount(int count) {
    return '$count本';
  }

  @override
  String get settingsCaptionDisplay => '字幕表示';

  @override
  String get settingsCaptionShow => '表示';

  @override
  String get settingsCaptionHide => '非表示';

  @override
  String get settingsChannelTapAction => 'チャンネルタップ動作';

  @override
  String get settingsChannelTapLatestVideos => '最新動画を表示';

  @override
  String get settingsChannelTapOpenYoutube => 'YouTubeで開く';

  @override
  String get settingsVideoCardTapAction => '動画カードタップ動作';

  @override
  String get settingsVideoCardTapInAppPlayer => 'アプリ内再生';

  @override
  String get settingsVideoCardTapOpenYoutube => 'YouTubeで開く';

  @override
  String get settingsVideoCardLayoutStyle => '動画カードレイアウト';

  @override
  String get settingsVideoCardLayoutHorizontal => '横型カード';

  @override
  String get settingsVideoCardLayoutVertical => '縦型カード';

  @override
  String get settingsMenuOrder => 'メニュー順序';

  @override
  String get settingsMenuOrderDesc => '下部ナビゲーションバーの順序変更';

  @override
  String get settingsResetApp => 'アプリをリセット';

  @override
  String get settingsSectionData => 'データ';

  @override
  String get settingsBackup => 'データバックアップ';

  @override
  String get settingsRestore => 'データ復元';

  @override
  String get settingsClearCache => '画像キャッシュをクリア';

  @override
  String get settingsSectionInfo => '情報';

  @override
  String get settingsVersion => 'バージョン';

  @override
  String get settingsLicense => 'オープンソースライセンス';

  @override
  String get settingsSectionAccount => 'アカウント';

  @override
  String get settingsGoogleAccount => 'Googleアカウント';

  @override
  String get settingsNotLoggedIn => 'ログインしていません';

  @override
  String get settingsLogout => 'ログアウト';

  @override
  String get addToFolder => 'フォルダに追加';

  @override
  String get sectionSettings => 'YouTube開くタブ';

  @override
  String subscriberCount(String count) {
    return '登録者 $count人';
  }

  @override
  String channelsSelected(int count) {
    return '$countチャンネル選択中';
  }

  @override
  String itemsSelected(int count) {
    return '$count件選択中';
  }

  @override
  String get timeJustNow => 'たった今';

  @override
  String timeMinutesAgo(int count) {
    return '$count分前';
  }

  @override
  String timeHoursAgo(int count) {
    return '$count時間前';
  }

  @override
  String timeDaysAgo(int count) {
    return '$count日前';
  }

  @override
  String timeWeeksAgo(int count) {
    return '$count週間前';
  }

  @override
  String timeMonthsAgo(int count) {
    return '$countヶ月前';
  }

  @override
  String itemCount(int count) {
    return '$count件';
  }

  @override
  String get deleteConfirmTitle => '削除確認';

  @override
  String deleteSelectedVideosConfirm(int count) {
    return '選択した$count本の動画を削除しますか？';
  }

  @override
  String get deleteFavoriteConfirm => 'お気に入りから削除しますか？';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get selectAll => 'すべて選択';

  @override
  String get select => '選択';

  @override
  String timeYearsAgo(int count) {
    return '$count年前';
  }

  @override
  String videoCount(int count) {
    return '$count本の動画';
  }

  @override
  String channelCount(int count) {
    return '$countチャンネル';
  }

  @override
  String playlistCount(int count) {
    return '$count件の再生リストを読み込み済み';
  }

  @override
  String get removeFromFolder => 'フォルダから削除';

  @override
  String get deleteChannel => 'チャンネルを削除';

  @override
  String deleteChannelConfirm(String name) {
    return '$nameを完全に削除しますか？\nすべてのフォルダからも削除されます。';
  }

  @override
  String removeChannelConfirm(String name) {
    return '$nameをこのフォルダから削除しますか？\n登録は維持されます。';
  }

  @override
  String deleteChannelsConfirm(int count) {
    return '選択した$countチャンネルを完全に削除しますか？\nすべてのフォルダからも削除されます。';
  }

  @override
  String removeChannelsConfirm(int count) {
    return '選択した$countチャンネルをこのフォルダから削除しますか？\n登録は維持されます。';
  }

  @override
  String get channelDeleted => 'チャンネルを削除しました';

  @override
  String get removedFromFolder => 'フォルダから削除しました';

  @override
  String addedToFolder(String name) {
    return '$nameに追加しました';
  }

  @override
  String channelsDeleted(int count) {
    return '$countチャンネルを削除しました';
  }

  @override
  String channelsRemoved(int count) {
    return '$countチャンネルを削除しました';
  }

  @override
  String channelsAddedTo(int count, String name) {
    return '$countチャンネルを$nameに追加しました';
  }

  @override
  String get cannotOpenChannel => 'チャンネルを開けません';

  @override
  String get pleaseSelectChannels => 'チャンネルを選択してください';

  @override
  String get createFolderFirst => '先にフォルダを作成してください';

  @override
  String get createCategoryFirst => '先にカテゴリを作成してください';

  @override
  String get unsubscribed => '未登録';

  @override
  String uploadedAgo(String time) {
    return '$timeにアップロード';
  }

  @override
  String sectionSettingsTitle(String title) {
    return '$title\nセクション設定';
  }

  @override
  String useDefaultSection(String section) {
    return 'デフォルト使用 ($section)';
  }

  @override
  String get sectionSetToDefault => 'セクションをデフォルトに設定しました';

  @override
  String sectionSetTo(String section) {
    return '$sectionセクションに設定しました';
  }

  @override
  String get channelsUpdated => 'チャンネルリストを更新しました';

  @override
  String get noSubscriptions => '登録チャンネルがありません';

  @override
  String get noSearchResults => '検索結果がありません';

  @override
  String get cannotLoadPlaylists => '再生リストを読み込めません';

  @override
  String get retry => '再試行';

  @override
  String get noPlaylists => '再生リストがありません';

  @override
  String get noVideos => '動画がありません';

  @override
  String get noFavorites => 'お気に入りの動画がありません';

  @override
  String get customOrder => 'カスタム順序';

  @override
  String get alphabetical => 'あいうえお順';

  @override
  String get multiSelect => '複数選択';

  @override
  String get openInYoutube => 'YouTubeで開く';

  @override
  String get latestVideos => '最新動画';

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
  String get dialogLogoutTitle => 'ログアウト';

  @override
  String get dialogLogoutContent => 'ログアウトしますか？';

  @override
  String get dialogResetAppTitle => 'アプリをリセット';

  @override
  String get dialogResetAppContent =>
      '登録チャンネル、フォルダ、お気に入り、再生リストを含むすべてのデータが削除されます。\n\nアプリをリセットしますか？';

  @override
  String get dialogResetAppSuccess => 'アプリがリセットされました。';

  @override
  String get dialogClearCacheTitle => 'キャッシュをクリア';

  @override
  String get dialogClearCacheContent =>
      '画像キャッシュをクリアしますか？\nアプリを再起動すると画像が再読み込みされます。';

  @override
  String get dialogClearCacheSuccess => '画像キャッシュをクリアしました。';

  @override
  String get dialogClearCacheFailed => 'キャッシュのクリアに失敗しました';

  @override
  String dialogBackupSuccess(String filePath) {
    return 'バックアップが完了しました。\n保存先: $filePath';
  }

  @override
  String get dialogBackupCancelled => 'バックアップがキャンセルされました。';

  @override
  String get dialogBackupFailed => 'バックアップに失敗しました';

  @override
  String get dialogRestoreTitle => 'データ復元';

  @override
  String get dialogRestoreContent =>
      'バックアップファイルからデータを復元しますか？\n既存の並び順とフォルダが変更される場合があります。';

  @override
  String get dialogRestoreSuccess => '復元が完了しました。';

  @override
  String get dialogRestoreFailed => '復元に失敗しました';

  @override
  String get folderCreate => 'フォルダ作成';

  @override
  String get folderEdit => 'フォルダ編集';

  @override
  String get folderDelete => 'フォルダ削除';

  @override
  String get folderName => 'フォルダ名';

  @override
  String get folderCreated => 'フォルダを作成しました。';

  @override
  String get folderUpdated => 'フォルダを更新しました。';

  @override
  String get folderDeleted => 'フォルダを削除しました。';

  @override
  String folderDeleteConfirm(String name) {
    return '「$name」フォルダを削除しますか？';
  }

  @override
  String get folderManage => 'フォルダ管理';

  @override
  String get folderEmpty => 'フォルダがありません';

  @override
  String get folderCreateNew => 'フォルダを作成';

  @override
  String get create => '作成';

  @override
  String get edit => '編集';

  @override
  String get sectionHome => 'ホーム';

  @override
  String get sectionVideos => '動画';

  @override
  String get sectionShorts => 'ショート';

  @override
  String get sectionLive => 'ライブ';

  @override
  String get sectionPodcasts => 'ポッドキャスト';

  @override
  String get sectionPlaylists => '再生リスト';

  @override
  String get sectionCommunity => 'コミュニティ';

  @override
  String get confirm => 'OK';

  @override
  String get errorUnknown => '不明なエラーが発生しました。';

  @override
  String get errorNetwork => 'インターネット接続を確認してください。';

  @override
  String get errorUnauthorized => 'ログインの有効期限が切れました。';

  @override
  String get errorQuotaExceeded =>
      'YouTube APIの1日の制限を超えました。\n明日の午前9時（日本時間）以降に再試行してください。';

  @override
  String get errorNotFound => 'リクエストされたデータが見つかりませんでした。';

  @override
  String get errorTimeout => 'リクエストがタイムアウトしました。';

  @override
  String errorGeneric(String error) {
    return 'エラーが発生しました: $error';
  }

  @override
  String get appSubtitle => 'YouTube登録チャンネル管理';

  @override
  String get loadingVideos => '動画を読み込み中...';

  @override
  String get allChannelsFilter => '登録済み';

  @override
  String get showFolderFab => 'フォルダボタンを表示';

  @override
  String get hideFolderFab => 'フォルダボタンを非表示';

  @override
  String get refreshSubscriptions => '登録チャンネルを更新';

  @override
  String get refreshPlaylists => '再生リストを更新';

  @override
  String get fetchSubscriptionsTitle => '登録チャンネルがありません';

  @override
  String get fetchSubscriptionsMessage => 'YouTubeの登録チャンネルを取得しますか？';

  @override
  String get fetchSubscriptionsYes => '取得';

  @override
  String get fetchSubscriptionsNo => '後で';

  @override
  String get createFolderDialogTitle => 'フォルダがありません';

  @override
  String get createFolderDialogMessage => 'フォルダを作成しますか？';

  @override
  String get createFolderDialogYes => '作成';

  @override
  String get createFolderDialogNo => '後で';

  @override
  String get createFolderDialogDontShowAgain => '次から表示しない';

  @override
  String get createFolderDialogManualGuide => '設定 > フォルダ管理で後から追加できます。';

  @override
  String get swipeEnabledDescription => 'チェックしたフォルダのみスワイプで移動できます';

  @override
  String get filterByChannel => 'チャンネルで絞り込み';

  @override
  String get allChannels => 'すべて';

  @override
  String get errorDetail => 'エラー詳細';

  @override
  String get viewErrorMessage => 'エラーメッセージを表示';

  @override
  String get sortDialogTitle => '並べ替え';

  @override
  String get sortPlaylistOrder => '再生リスト順';

  @override
  String get sortPlaylistOrderReverse => '再生リスト逆順';

  @override
  String get sortNewest => '最新順';

  @override
  String get sortOldest => '古い順';

  @override
  String get sortTitle => 'タイトル順';

  @override
  String get loginSubtitle => 'YouTubeの登録チャンネルを\n自由に整理しましょう';

  @override
  String get loginWithGoogle => 'Googleでログイン';

  @override
  String get loggingIn => 'ログイン中...';

  @override
  String get loginPermissionNotice => 'YouTubeの読み取り権限が必要です';

  @override
  String get loadingSubscriptions => '登録チャンネルを読み込み中...';

  @override
  String get loginFailed => 'ログインに失敗しました。';

  @override
  String get longPressReorder => '長押し: 並べ替え';

  @override
  String get longPressDelete => '長押し: 削除';

  @override
  String get showDeleteConfirmation => '削除時に確認メッセージを表示';
}
