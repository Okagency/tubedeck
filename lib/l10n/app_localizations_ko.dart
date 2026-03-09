// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get navChannels => '구독';

  @override
  String get navFeed => '새 영상';

  @override
  String get navFavorites => '즐겨찾기';

  @override
  String get navPlaylists => '재생목록';

  @override
  String get navSettings => '설정';

  @override
  String get settingsSectionFolders => '폴더';

  @override
  String get settingsFolderManage => '폴더 관리';

  @override
  String get settingsFolderManageDesc => '폴더 추가, 수정, 삭제';

  @override
  String get settingsSectionDisplay => '표시';

  @override
  String get settingsLanguage => '언어 / Language';

  @override
  String get settingsLanguageSystem => '시스템 설정 (System)';

  @override
  String get settingsChipLayout => '폴더 배치';

  @override
  String get settingsChipLayoutSingleLine => '한줄';

  @override
  String get settingsChipLayoutWrap => '줄바꿈';

  @override
  String get chipLayoutToggleWrap => '폴더 줄바꿈 보기';

  @override
  String get chipLayoutToggleSingleLine => '폴더 한줄 보기';

  @override
  String get settingsFolderView => '폴더 보기';

  @override
  String get settingsShowChannelCount => '채널수 보기';

  @override
  String get settingsShowVideoCount => '영상수 보기';

  @override
  String get settingsFolderSizeLarge => '크게';

  @override
  String get settingsFolderSizeSmall => '작게';

  @override
  String get settingsDefaultChannelSection => '유튜브 열기 탭';

  @override
  String get settingsVideosPerChannel => '채널별 영상 개수';

  @override
  String settingsVideosPerChannelCount(int count) {
    return '$count개';
  }

  @override
  String get settingsCaptionDisplay => '자막 표시';

  @override
  String get settingsCaptionShow => '표시';

  @override
  String get settingsCaptionHide => '숨김';

  @override
  String get settingsChannelTapAction => '채널 탭 액션';

  @override
  String get settingsChannelTapLatestVideos => '최신 영상 보기';

  @override
  String get settingsChannelTapOpenYoutube => '유튜브에서 열기';

  @override
  String get settingsVideoCardTapAction => '영상 카드 탭 액션';

  @override
  String get settingsVideoCardTapInAppPlayer => '인앱 재생';

  @override
  String get settingsVideoCardTapOpenYoutube => '유튜브에서 열기';

  @override
  String get settingsVideoCardLayoutStyle => '영상 카드 레이아웃';

  @override
  String get settingsVideoCardLayoutHorizontal => '가로 카드';

  @override
  String get settingsVideoCardLayoutVertical => '세로 카드';

  @override
  String get settingsMenuOrder => '메뉴 순서';

  @override
  String get settingsMenuOrderDesc => '하단 네비게이션 바 순서 변경';

  @override
  String get settingsResetApp => '앱 초기화';

  @override
  String get settingsSectionData => '데이터';

  @override
  String get settingsBackup => '데이터 백업';

  @override
  String get settingsRestore => '데이터 복원';

  @override
  String get settingsClearCache => '이미지 캐시 삭제';

  @override
  String get settingsSectionInfo => '정보';

  @override
  String get settingsVersion => '버전';

  @override
  String get settingsLicense => '오픈소스 라이선스';

  @override
  String get settingsSectionAccount => '계정';

  @override
  String get settingsGoogleAccount => 'Google 계정';

  @override
  String get settingsNotLoggedIn => '로그인되지 않음';

  @override
  String get settingsLogout => '로그아웃';

  @override
  String get addToFolder => '폴더에 추가';

  @override
  String get sectionSettings => '유튜브 열기 탭';

  @override
  String subscriberCount(String count) {
    return '구독자 $count명';
  }

  @override
  String channelsSelected(int count) {
    return '$count개 채널 선택됨';
  }

  @override
  String itemsSelected(int count) {
    return '$count개 선택됨';
  }

  @override
  String get timeJustNow => '방금 전';

  @override
  String timeMinutesAgo(int count) {
    return '$count분 전';
  }

  @override
  String timeHoursAgo(int count) {
    return '$count시간 전';
  }

  @override
  String timeDaysAgo(int count) {
    return '$count일 전';
  }

  @override
  String timeWeeksAgo(int count) {
    return '$count주 전';
  }

  @override
  String timeMonthsAgo(int count) {
    return '$count개월 전';
  }

  @override
  String itemCount(int count) {
    return '$count개';
  }

  @override
  String get deleteConfirmTitle => '삭제 확인';

  @override
  String deleteSelectedVideosConfirm(int count) {
    return '선택한 $count개의 영상을 삭제하시겠습니까?';
  }

  @override
  String get deleteFavoriteConfirm => '즐겨찾기에서 삭제하시겠습니까?';

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get selectAll => '전체 선택';

  @override
  String get select => '선택';

  @override
  String timeYearsAgo(int count) {
    return '$count년 전';
  }

  @override
  String videoCount(int count) {
    return '$count개 영상';
  }

  @override
  String channelCount(int count) {
    return '$count개 채널';
  }

  @override
  String playlistCount(int count) {
    return '$count개 재생목록 로드 완료';
  }

  @override
  String get removeFromFolder => '폴더에서 제거';

  @override
  String get deleteChannel => '채널 삭제';

  @override
  String deleteChannelConfirm(String name) {
    return '$name을(를) 완전히 삭제하시겠습니까?\n모든 폴더에서도 제거됩니다.';
  }

  @override
  String removeChannelConfirm(String name) {
    return '$name을(를) 이 폴더에서 제거하시겠습니까?\n구독메뉴에는 유지됩니다.';
  }

  @override
  String deleteChannelsConfirm(int count) {
    return '선택한 $count개 채널을 완전히 삭제하시겠습니까?\n모든 폴더에서도 제거됩니다.';
  }

  @override
  String removeChannelsConfirm(int count) {
    return '선택한 $count개 채널을 이 폴더에서 제거하시겠습니까?\n구독메뉴에는 유지됩니다.';
  }

  @override
  String get channelDeleted => '채널이 삭제되었습니다';

  @override
  String get removedFromFolder => '폴더에서 제거되었습니다';

  @override
  String addedToFolder(String name) {
    return '$name에 추가되었습니다';
  }

  @override
  String channelsDeleted(int count) {
    return '$count개 채널이 삭제되었습니다';
  }

  @override
  String channelsRemoved(int count) {
    return '$count개 채널이 제거되었습니다';
  }

  @override
  String channelsAddedTo(int count, String name) {
    return '$count개 채널이 $name에 추가되었습니다';
  }

  @override
  String get cannotOpenChannel => '채널을 열 수 없습니다';

  @override
  String get pleaseSelectChannels => '채널을 선택해주세요';

  @override
  String get createFolderFirst => '먼저 폴더를 만들어주세요';

  @override
  String get createCategoryFirst => '먼저 카테고리를 만들어주세요';

  @override
  String get unsubscribed => '미구독';

  @override
  String uploadedAgo(String time) {
    return '$time 업로드';
  }

  @override
  String sectionSettingsTitle(String title) {
    return '$title\n열기 탭 설정';
  }

  @override
  String useDefaultSection(String section) {
    return '기본값 사용 ($section)';
  }

  @override
  String get sectionSetToDefault => '섹션이 기본값으로 설정되었습니다';

  @override
  String sectionSetTo(String section) {
    return '$section 섹션으로 설정되었습니다';
  }

  @override
  String get channelsUpdated => '채널 목록이 업데이트되었습니다';

  @override
  String get noSubscriptions => '구독 채널이 없습니다';

  @override
  String get noSearchResults => '검색 결과가 없습니다';

  @override
  String get cannotLoadPlaylists => '재생목록을 불러올 수 없습니다';

  @override
  String get retry => '다시 시도';

  @override
  String get noPlaylists => '재생목록이 없습니다';

  @override
  String get noVideos => '영상이 없습니다';

  @override
  String get noFavorites => '즐겨찾기한 영상이 없습니다';

  @override
  String get customOrder => '사용자 지정 순서';

  @override
  String get alphabetical => '가나다순';

  @override
  String get multiSelect => '멀티 선택';

  @override
  String get openInYoutube => '유튜브에서 열기';

  @override
  String get latestVideos => '최신 영상';

  @override
  String formatTenThousand(String count) {
    return '$count만';
  }

  @override
  String formatThousand(String count) {
    return '$count천';
  }

  @override
  String formatMillion(String count) {
    return '$count만';
  }

  @override
  String get dialogLogoutTitle => '로그아웃';

  @override
  String get dialogLogoutContent => '로그아웃하시겠습니까?';

  @override
  String get dialogResetAppTitle => '앱 초기화';

  @override
  String get dialogResetAppContent =>
      '구독 채널, 폴더, 즐겨찾기, 재생목록 등 모든 데이터가 삭제됩니다.\n\n앱을 초기화하시겠습니까?';

  @override
  String get dialogResetAppSuccess => '앱이 초기화되었습니다.';

  @override
  String get dialogClearCacheTitle => '캐시 삭제';

  @override
  String get dialogClearCacheContent =>
      '이미지 캐시를 삭제하시겠습니까?\n앱을 다시 시작하면 이미지가 다시 로드됩니다.';

  @override
  String get dialogClearCacheSuccess => '이미지 캐시가 삭제되었습니다.';

  @override
  String get dialogClearCacheFailed => '캐시 삭제에 실패했습니다';

  @override
  String dialogBackupSuccess(String filePath) {
    return '백업이 완료되었습니다.\n저장 위치: $filePath';
  }

  @override
  String get dialogBackupCancelled => '백업이 취소되었습니다.';

  @override
  String get dialogBackupFailed => '백업 실패';

  @override
  String get dialogRestoreTitle => '데이터 복원';

  @override
  String get dialogRestoreContent =>
      '백업 파일에서 데이터를 복원하시겠습니까?\n기존 정렬 순서와 폴더가 변경될 수 있습니다.';

  @override
  String get dialogRestoreSuccess => '복원이 완료되었습니다.';

  @override
  String get dialogRestoreFailed => '복원 실패';

  @override
  String get folderCreate => '폴더 생성';

  @override
  String get folderEdit => '폴더 수정';

  @override
  String get folderDelete => '폴더 삭제';

  @override
  String get folderName => '폴더 이름';

  @override
  String get folderCreated => '폴더가 생성되었습니다.';

  @override
  String get folderUpdated => '폴더가 수정되었습니다.';

  @override
  String get folderDeleted => '폴더가 삭제되었습니다.';

  @override
  String folderDeleteConfirm(String name) {
    return '\"$name\" 폴더를 삭제하시겠습니까?';
  }

  @override
  String get folderManage => '폴더 관리';

  @override
  String get folderEmpty => '폴더가 없습니다';

  @override
  String get folderCreateNew => '폴더 만들기';

  @override
  String get create => '생성';

  @override
  String get edit => '수정';

  @override
  String get sectionHome => '홈';

  @override
  String get sectionVideos => '동영상';

  @override
  String get sectionShorts => 'Shorts';

  @override
  String get sectionLive => '라이브';

  @override
  String get sectionPodcasts => '팟캐스트';

  @override
  String get sectionPlaylists => '재생목록';

  @override
  String get sectionCommunity => '게시물';

  @override
  String get confirm => '확인';

  @override
  String get errorUnknown => '알 수 없는 오류가 발생했습니다.';

  @override
  String get errorNetwork => '인터넷 연결을 확인해주세요.';

  @override
  String get errorUnauthorized => '로그인이 만료되었습니다.';

  @override
  String get errorQuotaExceeded =>
      'YouTube API 일일 할당량이 초과되었습니다.\n내일 오후 5시(한국 시간)에 다시 시도해주세요.';

  @override
  String get errorNotFound => '요청한 데이터를 찾을 수 없습니다.';

  @override
  String get errorTimeout => '요청 시간이 초과되었습니다.';

  @override
  String errorGeneric(String error) {
    return '오류가 발생했습니다: $error';
  }

  @override
  String get appSubtitle => 'YouTube 구독 채널 관리';

  @override
  String get loadingVideos => '영상을 가져오는 중...';

  @override
  String get allChannelsFilter => '구독';

  @override
  String get showFolderFab => '폴더 버튼 보이기';

  @override
  String get hideFolderFab => '폴더 버튼 숨기기';

  @override
  String get refreshSubscriptions => '구독 새로고침';

  @override
  String get refreshPlaylists => '재생목록 새로고침';

  @override
  String get fetchSubscriptionsTitle => '구독 채널 없음';

  @override
  String get fetchSubscriptionsMessage => 'YouTube 구독 채널을 가져올까요?';

  @override
  String get fetchSubscriptionsYes => '가져오기';

  @override
  String get fetchSubscriptionsNo => '나중에';

  @override
  String get createFolderDialogTitle => '폴더 없음';

  @override
  String get createFolderDialogMessage => '폴더를 추가하시겠습니까?';

  @override
  String get createFolderDialogYes => '추가하기';

  @override
  String get createFolderDialogNo => '나중에';

  @override
  String get createFolderDialogDontShowAgain => '다음부터 안보기';

  @override
  String get createFolderDialogManualGuide => '나중에 설정 > 폴더 관리에서 추가할 수 있습니다.';

  @override
  String get swipeEnabledDescription => '체크된 폴더만 스와이프로 이동합니다';

  @override
  String get filterByChannel => '채널별 보기';

  @override
  String get allChannels => '전체';

  @override
  String get errorDetail => '오류 상세';

  @override
  String get viewErrorMessage => '오류 메시지 보기';

  @override
  String get sortDialogTitle => '정렬';

  @override
  String get sortPlaylistOrder => '재생목록 순서';

  @override
  String get sortPlaylistOrderReverse => '재생목록 역순';

  @override
  String get sortNewest => '최신순';

  @override
  String get sortOldest => '오래된순';

  @override
  String get sortTitle => '제목순';

  @override
  String get loginSubtitle => 'YouTube 구독 채널을\n자유롭게 정리하세요';

  @override
  String get loginWithGoogle => 'Google로 로그인';

  @override
  String get loggingIn => '로그인 중...';

  @override
  String get loginPermissionNotice => 'YouTube 읽기 권한이 필요합니다';

  @override
  String get loadingSubscriptions => '구독 채널을 불러오는 중...';

  @override
  String get loginFailed => '로그인에 실패했습니다.';

  @override
  String get longPressReorder => '길게 누르기: 순서정렬';

  @override
  String get longPressDelete => '길게 누르기: 삭제';

  @override
  String get showDeleteConfirmation => '삭제시 확인메세지 표시';
}
