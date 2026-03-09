import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import '../models/channel.dart';
import '../l10n/app_localizations.dart';

/// 네비게이션 아이템
enum NavItem {
  home,
  latestVideos,
  favorites,
  playlists,
  settings,
}

extension NavItemExtension on NavItem {
  String getDisplayName(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      // Fallback to English if localization not available
      return displayName;
    }

    switch (this) {
      case NavItem.home:
        return l10n.navChannels;
      case NavItem.latestVideos:
        return l10n.navFeed;
      case NavItem.favorites:
        return l10n.navFavorites;
      case NavItem.playlists:
        return l10n.navPlaylists;
      case NavItem.settings:
        return l10n.navSettings;
    }
  }

  // Fallback for places without context
  String get displayName {
    switch (this) {
      case NavItem.home:
        return 'Channels';
      case NavItem.latestVideos:
        return 'Feed';
      case NavItem.favorites:
        return 'Favorites';
      case NavItem.playlists:
        return 'Playlists';
      case NavItem.settings:
        return 'Settings';
    }
  }

  IconData get icon {
    switch (this) {
      case NavItem.home:
        return Icons.subscriptions;
      case NavItem.latestVideos:
        return Icons.dynamic_feed;
      case NavItem.favorites:
        return Icons.bookmark;
      case NavItem.playlists:
        return Icons.video_library;
      case NavItem.settings:
        return Icons.settings;
    }
  }

  static NavItem? fromString(String? value) {
    if (value == null) return null;
    return NavItem.values.firstWhere(
      (e) => e.name == value,
      orElse: () => NavItem.home,
    );
  }
}

/// 채널 탭 액션
enum ChannelTapAction {
  latestVideos,
  openYoutube,
}

extension ChannelTapActionExtension on ChannelTapAction {
  String get displayName {
    switch (this) {
      case ChannelTapAction.latestVideos:
        return '최신 영상 보기';
      case ChannelTapAction.openYoutube:
        return '유튜브에서 열기';
    }
  }
}

/// 영상 카드 탭 액션
enum VideoCardTapAction {
  inAppPlayer,
  openYoutube,
}

extension VideoCardTapActionExtension on VideoCardTapAction {
  String get displayName {
    switch (this) {
      case VideoCardTapAction.inAppPlayer:
        return '인앱 재생';
      case VideoCardTapAction.openYoutube:
        return '유튜브에서 열기';
    }
  }
}

/// 기본 채널 섹션 프로바이더
final defaultChannelSectionProvider =
    StateNotifierProvider<DefaultChannelSectionNotifier, ChannelSection>((ref) {
  return DefaultChannelSectionNotifier();
});

class DefaultChannelSectionNotifier extends StateNotifier<ChannelSection> {
  DefaultChannelSectionNotifier() : super(ChannelSection.home) {
    _loadDefaultSection();
  }

  Future<void> _loadDefaultSection() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sectionString = prefs.getString(Constants.keyDefaultChannelSection);
      state = ChannelSectionExtension.fromString(sectionString);
    } catch (e) {
      state = ChannelSection.home;
    }
  }

  Future<void> setDefaultSection(ChannelSection section) async {
    state = section;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.keyDefaultChannelSection, section.name);
    } catch (e) {
      // 에러 무시
    }
  }

  String get displayName => state.displayName;
}

/// 채널당 영상 개수 프로바이더
final videosPerChannelProvider =
    StateNotifierProvider<VideosPerChannelNotifier, int>((ref) {
  return VideosPerChannelNotifier();
});

class VideosPerChannelNotifier extends StateNotifier<int> {
  bool _isLoaded = false;

  VideosPerChannelNotifier() : super(3) {
    _loadVideosPerChannel();
  }

  Future<void> _loadVideosPerChannel() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final count = prefs.getInt(Constants.keyVideosPerChannel) ?? 3;
      state = count;
    } catch (e) {
      state = 1;
    }
    _isLoaded = true;
  }

  /// 설정이 로드될 때까지 대기
  Future<int> ensureLoaded() async {
    if (_isLoaded) return state;

    // 로딩이 완료될 때까지 대기 (최대 1초)
    for (int i = 0; i < 20; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      if (_isLoaded) return state;
    }
    return state;
  }

  Future<void> setVideosPerChannel(int count) async {
    state = count;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(Constants.keyVideosPerChannel, count);
    } catch (e) {
      // 에러 무시
    }
  }

  String get displayName => '$state개';
}

/// 자막 표시 프로바이더
final enableCaptionProvider =
    StateNotifierProvider<EnableCaptionNotifier, bool>((ref) {
  return EnableCaptionNotifier();
});

class EnableCaptionNotifier extends StateNotifier<bool> {
  EnableCaptionNotifier() : super(false) {
    _loadEnableCaption();
  }

  Future<void> _loadEnableCaption() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final enabled = prefs.getBool(Constants.keyEnableCaption) ?? false;
      state = enabled;
    } catch (e) {
      state = false;
    }
  }

  Future<void> setEnableCaption(bool enabled) async {
    state = enabled;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(Constants.keyEnableCaption, enabled);
    } catch (e) {
      // 에러 무시
    }
  }

  String get displayName => state ? '표시' : '숨김';
}

/// 칩 레이아웃 프로바이더 - 구독 화면용 (한줄/줄바꿈)
final chipLayoutSingleLineProvider =
    StateNotifierProvider<ChipLayoutSingleLineNotifier, bool>((ref) {
  return ChipLayoutSingleLineNotifier();
});

class ChipLayoutSingleLineNotifier extends StateNotifier<bool> {
  ChipLayoutSingleLineNotifier() : super(true) {
    _loadChipLayout();
  }

  Future<void> _loadChipLayout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final singleLine = prefs.getBool(Constants.keyChipLayoutSingleLine) ?? true;
      state = singleLine;
    } catch (e) {
      state = true;
    }
  }

  Future<void> setChipLayoutSingleLine(bool singleLine) async {
    state = singleLine;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(Constants.keyChipLayoutSingleLine, singleLine);
    } catch (e) {
      // 에러 무시
    }
  }

  String get displayName => state ? '한줄' : '줄바꿈';
}

/// 칩 레이아웃 프로바이더 - 새영상 화면용 (한줄/줄바꿈)
final latestVideosChipLayoutSingleLineProvider =
    StateNotifierProvider<LatestVideosChipLayoutSingleLineNotifier, bool>((ref) {
  return LatestVideosChipLayoutSingleLineNotifier();
});

class LatestVideosChipLayoutSingleLineNotifier extends StateNotifier<bool> {
  LatestVideosChipLayoutSingleLineNotifier() : super(true) {
    _loadChipLayout();
  }

  Future<void> _loadChipLayout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final singleLine = prefs.getBool(Constants.keyLatestVideosChipLayoutSingleLine) ?? true;
      state = singleLine;
    } catch (e) {
      state = true;
    }
  }

  Future<void> setChipLayoutSingleLine(bool singleLine) async {
    state = singleLine;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(Constants.keyLatestVideosChipLayoutSingleLine, singleLine);
    } catch (e) {
      // 에러 무시
    }
  }
}

/// 채널 탭 액션 프로바이더
final channelTapActionProvider =
    StateNotifierProvider<ChannelTapActionNotifier, ChannelTapAction>((ref) {
  return ChannelTapActionNotifier();
});

class ChannelTapActionNotifier extends StateNotifier<ChannelTapAction> {
  ChannelTapActionNotifier() : super(ChannelTapAction.latestVideos) {
    _loadChannelTapAction();
  }

  Future<void> _loadChannelTapAction() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final actionString = prefs.getString(Constants.keyChannelTapAction);
      if (actionString == 'openYoutube') {
        state = ChannelTapAction.openYoutube;
      } else {
        state = ChannelTapAction.latestVideos;
      }
    } catch (e) {
      state = ChannelTapAction.latestVideos;
    }
  }

  Future<void> setChannelTapAction(ChannelTapAction action) async {
    state = action;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.keyChannelTapAction, action.name);
    } catch (e) {
      // 에러 무시
    }
  }

  String get displayName => state.displayName;
}

/// 영상 카드 탭 액션 프로바이더
final videoCardTapActionProvider =
    StateNotifierProvider<VideoCardTapActionNotifier, VideoCardTapAction>((ref) {
  return VideoCardTapActionNotifier();
});

class VideoCardTapActionNotifier extends StateNotifier<VideoCardTapAction> {
  VideoCardTapActionNotifier() : super(VideoCardTapAction.openYoutube) {
    _loadVideoCardTapAction();
  }

  Future<void> _loadVideoCardTapAction() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final actionString = prefs.getString(Constants.keyVideoCardTapAction);
      if (actionString == 'inAppPlayer') {
        state = VideoCardTapAction.inAppPlayer;
      } else {
        state = VideoCardTapAction.openYoutube;
      }
    } catch (e) {
      state = VideoCardTapAction.openYoutube;
    }
  }

  Future<void> setVideoCardTapAction(VideoCardTapAction action) async {
    state = action;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.keyVideoCardTapAction, action.name);
    } catch (e) {
      // 에러 무시
    }
  }

  String get displayName => state.displayName;
}

/// 영상 카드 레이아웃 스타일
enum VideoCardLayoutStyle {
  horizontal,
  vertical,
}

extension VideoCardLayoutStyleExtension on VideoCardLayoutStyle {
  String get displayName {
    switch (this) {
      case VideoCardLayoutStyle.horizontal:
        return '가로 카드';
      case VideoCardLayoutStyle.vertical:
        return '세로 카드';
    }
  }
}

/// 영상 카드 레이아웃 스타일 프로바이더
final videoCardLayoutStyleProvider =
    StateNotifierProvider<VideoCardLayoutStyleNotifier, VideoCardLayoutStyle>((ref) {
  return VideoCardLayoutStyleNotifier();
});

class VideoCardLayoutStyleNotifier extends StateNotifier<VideoCardLayoutStyle> {
  VideoCardLayoutStyleNotifier() : super(VideoCardLayoutStyle.vertical) {
    _loadVideoCardLayoutStyle();
  }

  Future<void> _loadVideoCardLayoutStyle() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final styleString = prefs.getString(Constants.keyVideoCardLayoutStyle);
      if (styleString == 'horizontal') {
        state = VideoCardLayoutStyle.horizontal;
      } else {
        state = VideoCardLayoutStyle.vertical;
      }
    } catch (e) {
      state = VideoCardLayoutStyle.vertical;
    }
  }

  Future<void> setVideoCardLayoutStyle(VideoCardLayoutStyle style) async {
    state = style;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.keyVideoCardLayoutStyle, style.name);
    } catch (e) {
      // 에러 무시
    }
  }

  String get displayName => state.displayName;
}

/// 2번 화면 (새영상) 레이아웃 프로바이더
final latestVideosLayoutProvider =
    StateNotifierProvider<LatestVideosLayoutNotifier, VideoCardLayoutStyle>((ref) {
  return LatestVideosLayoutNotifier();
});

class LatestVideosLayoutNotifier extends StateNotifier<VideoCardLayoutStyle> {
  LatestVideosLayoutNotifier() : super(VideoCardLayoutStyle.vertical) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final styleString = prefs.getString(Constants.keyLatestVideosLayout);
      if (styleString == 'horizontal') {
        state = VideoCardLayoutStyle.horizontal;
      } else {
        state = VideoCardLayoutStyle.vertical;
      }
    } catch (e) {
      state = VideoCardLayoutStyle.vertical;
    }
  }

  Future<void> setLayout(VideoCardLayoutStyle style) async {
    state = style;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.keyLatestVideosLayout, style.name);
    } catch (e) {
      // 에러 무시
    }
  }

  Future<void> reset() async {
    await setLayout(VideoCardLayoutStyle.vertical);
  }
}

/// 3번 화면 (북마크) 레이아웃 프로바이더
final favoritesLayoutProvider =
    StateNotifierProvider<FavoritesLayoutNotifier, VideoCardLayoutStyle>((ref) {
  return FavoritesLayoutNotifier();
});

class FavoritesLayoutNotifier extends StateNotifier<VideoCardLayoutStyle> {
  FavoritesLayoutNotifier() : super(VideoCardLayoutStyle.vertical) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final styleString = prefs.getString(Constants.keyFavoritesLayout);
      if (styleString == 'horizontal') {
        state = VideoCardLayoutStyle.horizontal;
      } else {
        state = VideoCardLayoutStyle.vertical;
      }
    } catch (e) {
      state = VideoCardLayoutStyle.vertical;
    }
  }

  Future<void> setLayout(VideoCardLayoutStyle style) async {
    state = style;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.keyFavoritesLayout, style.name);
    } catch (e) {
      // 에러 무시
    }
  }

  Future<void> reset() async {
    await setLayout(VideoCardLayoutStyle.vertical);
  }
}

/// 11번 화면 (채널안 영상리스트) 레이아웃 프로바이더
final channelVideosLayoutProvider =
    StateNotifierProvider<ChannelVideosLayoutNotifier, VideoCardLayoutStyle>((ref) {
  return ChannelVideosLayoutNotifier();
});

class ChannelVideosLayoutNotifier extends StateNotifier<VideoCardLayoutStyle> {
  ChannelVideosLayoutNotifier() : super(VideoCardLayoutStyle.vertical) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final styleString = prefs.getString(Constants.keyChannelVideosLayout);
      if (styleString == 'horizontal') {
        state = VideoCardLayoutStyle.horizontal;
      } else {
        state = VideoCardLayoutStyle.vertical;
      }
    } catch (e) {
      state = VideoCardLayoutStyle.vertical;
    }
  }

  Future<void> setLayout(VideoCardLayoutStyle style) async {
    state = style;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.keyChannelVideosLayout, style.name);
    } catch (e) {
      // 에러 무시
    }
  }

  Future<void> reset() async {
    await setLayout(VideoCardLayoutStyle.vertical);
  }
}

/// 41번 화면 (재생목록 영상리스트) 레이아웃 프로바이더
final playlistVideosLayoutProvider =
    StateNotifierProvider<PlaylistVideosLayoutNotifier, VideoCardLayoutStyle>((ref) {
  return PlaylistVideosLayoutNotifier();
});

class PlaylistVideosLayoutNotifier extends StateNotifier<VideoCardLayoutStyle> {
  PlaylistVideosLayoutNotifier() : super(VideoCardLayoutStyle.vertical) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final styleString = prefs.getString(Constants.keyPlaylistVideosLayout);
      if (styleString == 'horizontal') {
        state = VideoCardLayoutStyle.horizontal;
      } else {
        state = VideoCardLayoutStyle.vertical;
      }
    } catch (e) {
      state = VideoCardLayoutStyle.vertical;
    }
  }

  Future<void> setLayout(VideoCardLayoutStyle style) async {
    state = style;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.keyPlaylistVideosLayout, style.name);
    } catch (e) {
      // 에러 무시
    }
  }

  Future<void> reset() async {
    await setLayout(VideoCardLayoutStyle.vertical);
  }
}

/// 2번 화면 (새영상) 탭 액션 프로바이더
final latestVideosTapActionProvider =
    StateNotifierProvider<LatestVideosTapActionNotifier, VideoCardTapAction>((ref) {
  return LatestVideosTapActionNotifier();
});

class LatestVideosTapActionNotifier extends StateNotifier<VideoCardTapAction> {
  LatestVideosTapActionNotifier() : super(VideoCardTapAction.openYoutube) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final actionString = prefs.getString(Constants.keyLatestVideosTapAction);
      if (actionString == 'inAppPlayer') {
        state = VideoCardTapAction.inAppPlayer;
      } else {
        state = VideoCardTapAction.openYoutube;
      }
    } catch (e) {
      state = VideoCardTapAction.openYoutube;
    }
  }

  Future<void> setTapAction(VideoCardTapAction action) async {
    state = action;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.keyLatestVideosTapAction, action.name);
    } catch (e) {
      // 에러 무시
    }
  }

  Future<void> reset() async {
    await setTapAction(VideoCardTapAction.openYoutube);
  }
}

/// 3번 화면 (북마크) 탭 액션 프로바이더
final favoritesTapActionProvider =
    StateNotifierProvider<FavoritesTapActionNotifier, VideoCardTapAction>((ref) {
  return FavoritesTapActionNotifier();
});

class FavoritesTapActionNotifier extends StateNotifier<VideoCardTapAction> {
  FavoritesTapActionNotifier() : super(VideoCardTapAction.openYoutube) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final actionString = prefs.getString(Constants.keyFavoritesTapAction);
      if (actionString == 'inAppPlayer') {
        state = VideoCardTapAction.inAppPlayer;
      } else {
        state = VideoCardTapAction.openYoutube;
      }
    } catch (e) {
      state = VideoCardTapAction.openYoutube;
    }
  }

  Future<void> setTapAction(VideoCardTapAction action) async {
    state = action;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.keyFavoritesTapAction, action.name);
    } catch (e) {
      // 에러 무시
    }
  }

  Future<void> reset() async {
    await setTapAction(VideoCardTapAction.openYoutube);
  }
}

/// 11번 화면 (채널안 영상리스트) 탭 액션 프로바이더
final channelVideosTapActionProvider =
    StateNotifierProvider<ChannelVideosTapActionNotifier, VideoCardTapAction>((ref) {
  return ChannelVideosTapActionNotifier();
});

class ChannelVideosTapActionNotifier extends StateNotifier<VideoCardTapAction> {
  ChannelVideosTapActionNotifier() : super(VideoCardTapAction.openYoutube) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final actionString = prefs.getString(Constants.keyChannelVideosTapAction);
      if (actionString == 'inAppPlayer') {
        state = VideoCardTapAction.inAppPlayer;
      } else {
        state = VideoCardTapAction.openYoutube;
      }
    } catch (e) {
      state = VideoCardTapAction.openYoutube;
    }
  }

  Future<void> setTapAction(VideoCardTapAction action) async {
    state = action;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.keyChannelVideosTapAction, action.name);
    } catch (e) {
      // 에러 무시
    }
  }

  Future<void> reset() async {
    await setTapAction(VideoCardTapAction.openYoutube);
  }
}

/// 41번 화면 (재생목록 영상리스트) 탭 액션 프로바이더
final playlistVideosTapActionProvider =
    StateNotifierProvider<PlaylistVideosTapActionNotifier, VideoCardTapAction>((ref) {
  return PlaylistVideosTapActionNotifier();
});

class PlaylistVideosTapActionNotifier extends StateNotifier<VideoCardTapAction> {
  PlaylistVideosTapActionNotifier() : super(VideoCardTapAction.openYoutube) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final actionString = prefs.getString(Constants.keyPlaylistVideosTapAction);
      if (actionString == 'inAppPlayer') {
        state = VideoCardTapAction.inAppPlayer;
      } else {
        state = VideoCardTapAction.openYoutube;
      }
    } catch (e) {
      state = VideoCardTapAction.openYoutube;
    }
  }

  Future<void> setTapAction(VideoCardTapAction action) async {
    state = action;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.keyPlaylistVideosTapAction, action.name);
    } catch (e) {
      // 에러 무시
    }
  }

  Future<void> reset() async {
    await setTapAction(VideoCardTapAction.openYoutube);
  }
}

/// 네비게이션 순서 프로바이더
final navOrderProvider =
    StateNotifierProvider<NavOrderNotifier, List<NavItem>>((ref) {
  return NavOrderNotifier();
});

class NavOrderNotifier extends StateNotifier<List<NavItem>> {
  // 네비게이션 바에 표시되는 항목들 (settings 제외)
  static const List<NavItem> defaultOrder = [
    NavItem.home,
    NavItem.latestVideos,
    NavItem.favorites,
    NavItem.playlists,
  ];

  NavOrderNotifier() : super(defaultOrder) {
    _loadNavOrder();
  }

  Future<void> _loadNavOrder() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final orderString = prefs.getStringList(Constants.keyNavOrder);
      if (orderString != null) {
        final order = orderString
            .map((e) => NavItemExtension.fromString(e))
            .whereType<NavItem>()
            .where((item) => item != NavItem.settings) // settings 제외
            .toList();
        if (order.length == defaultOrder.length) {
          state = order;
        }
      }
    } catch (e) {
      state = defaultOrder;
    }
  }

  Future<void> setNavOrder(List<NavItem> order) async {
    // settings가 포함되어 있으면 제거
    final filteredOrder = order.where((item) => item != NavItem.settings).toList();
    state = filteredOrder;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        Constants.keyNavOrder,
        filteredOrder.map((e) => e.name).toList(),
      );
    } catch (e) {
      // 에러 무시
    }
  }

  Future<void> resetToDefault() async {
    await setNavOrder(defaultOrder);
  }
}

/// 현재 네비게이션 인덱스 프로바이더
final currentNavIndexProvider = StateProvider<int>((ref) => 0);

/// 컬렉션 관리 플로팅 버튼 표시 프로바이더
/// null = 로딩 중 (FAB 숨김), true = 표시, false = 숨김
final showCollectionFabProvider =
    StateNotifierProvider<ShowCollectionFabNotifier, bool?>((ref) {
  return ShowCollectionFabNotifier();
});

class ShowCollectionFabNotifier extends StateNotifier<bool?> {
  ShowCollectionFabNotifier() : super(null) {
    _loadShowCollectionFab();
  }

  Future<void> _loadShowCollectionFab() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final show = prefs.getBool(Constants.keyShowCollectionFab) ?? true;
      state = show;
    } catch (e) {
      state = true;
    }
  }

  Future<void> setShowCollectionFab(bool show) async {
    state = show;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(Constants.keyShowCollectionFab, show);
    } catch (e) {
      // 에러 무시
    }
  }

  Future<void> toggle() async {
    await setShowCollectionFab(!(state ?? true));
  }
}

/// 컬렉션 생성 다이얼로그 숨김 프로바이더
final hideCreateCollectionDialogProvider =
    StateNotifierProvider<HideCreateCollectionDialogNotifier, bool>((ref) {
  return HideCreateCollectionDialogNotifier();
});

class HideCreateCollectionDialogNotifier extends StateNotifier<bool> {
  bool _isLoaded = false;

  HideCreateCollectionDialogNotifier() : super(false) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hide = prefs.getBool(Constants.keyHideCreateCollectionDialog) ?? false;
      state = hide;
    } catch (e) {
      state = false;
    }
    _isLoaded = true;
  }

  /// 설정이 로드될 때까지 대기
  Future<bool> ensureLoaded() async {
    if (_isLoaded) return state;

    // 로딩이 완료될 때까지 대기 (최대 1초)
    for (int i = 0; i < 20; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      if (_isLoaded) return state;
    }
    return state;
  }

  Future<void> setHide(bool hide) async {
    state = hide;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(Constants.keyHideCreateCollectionDialog, hide);
    } catch (e) {
      // 에러 무시
    }
  }
}

/// 스와이프 활성화된 컬렉션 ID 목록 프로바이더
final swipeEnabledCollectionsProvider =
    StateNotifierProvider<SwipeEnabledCollectionsNotifier, Set<String>>((ref) {
  return SwipeEnabledCollectionsNotifier();
});

class SwipeEnabledCollectionsNotifier extends StateNotifier<Set<String>> {
  bool _isLoaded = false;

  SwipeEnabledCollectionsNotifier() : super({}) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(Constants.keySwipeEnabledCollections);
      if (list != null) {
        state = list.toSet();
      } else {
        // 기본값: 구독(all)은 스와이프 활성화
        state = {Constants.allChannelsFilterId};
      }
    } catch (e) {
      state = {Constants.allChannelsFilterId};
    }
    _isLoaded = true;
  }

  /// 로딩이 완료될 때까지 대기 후 현재 상태 반환
  Future<Set<String>> ensureLoaded() async {
    if (_isLoaded) return state;

    // 로딩이 완료될 때까지 대기 (최대 1초)
    for (int i = 0; i < 20; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      if (_isLoaded) return state;
    }
    return state;
  }

  Future<void> toggleCollection(String collectionId) async {
    final newSet = Set<String>.from(state);
    if (newSet.contains(collectionId)) {
      newSet.remove(collectionId);
    } else {
      newSet.add(collectionId);
    }
    state = newSet;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        Constants.keySwipeEnabledCollections,
        newSet.toList(),
      );
    } catch (e) {
      // 에러 무시
    }
  }

  Future<void> setEnabled(String collectionId, bool enabled) async {
    final newSet = Set<String>.from(state);
    if (enabled) {
      newSet.add(collectionId);
    } else {
      newSet.remove(collectionId);
    }
    state = newSet;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        Constants.keySwipeEnabledCollections,
        newSet.toList(),
      );
    } catch (e) {
      // 에러 무시
    }
  }

  bool isEnabled(String collectionId) {
    return state.contains(collectionId);
  }
}

/// 컬렉션 채널수 표시 프로바이더
final showCollectionChannelCountProvider =
    StateNotifierProvider<ShowCollectionChannelCountNotifier, bool>((ref) {
  return ShowCollectionChannelCountNotifier();
});

class ShowCollectionChannelCountNotifier extends StateNotifier<bool> {
  ShowCollectionChannelCountNotifier() : super(true) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final show = prefs.getBool(Constants.keyShowCollectionChannelCount) ?? true;
      state = show;
    } catch (e) {
      state = true;
    }
  }

  Future<void> setShowChannelCount(bool show) async {
    state = show;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(Constants.keyShowCollectionChannelCount, show);
    } catch (e) {
      // 에러 무시
    }
  }

  Future<void> toggle() async {
    await setShowChannelCount(!state);
  }
}

/// 컬렉션 크기 프로바이더 (true = 크게, false = 작게)
final collectionSizeLargeProvider =
    StateNotifierProvider<CollectionSizeLargeNotifier, bool>((ref) {
  return CollectionSizeLargeNotifier();
});

class CollectionSizeLargeNotifier extends StateNotifier<bool> {
  CollectionSizeLargeNotifier() : super(true) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final large = prefs.getBool(Constants.keyCollectionSizeLarge) ?? true;
      state = large;
    } catch (e) {
      state = true;
    }
  }

  Future<void> setLarge(bool large) async {
    state = large;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(Constants.keyCollectionSizeLarge, large);
    } catch (e) {
      // 에러 무시
    }
  }

  Future<void> toggle() async {
    await setLarge(!state);
  }
}

/// 새영상 화면 영상수 표시 프로바이더
final latestVideosShowVideoCountProvider =
    StateNotifierProvider<LatestVideosShowVideoCountNotifier, bool>((ref) {
  return LatestVideosShowVideoCountNotifier();
});

class LatestVideosShowVideoCountNotifier extends StateNotifier<bool> {
  LatestVideosShowVideoCountNotifier() : super(false) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final show = prefs.getBool(Constants.keyLatestVideosShowVideoCount) ?? false;
      state = show;
    } catch (e) {
      state = false;
    }
  }

  Future<void> setShowVideoCount(bool show) async {
    state = show;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(Constants.keyLatestVideosShowVideoCount, show);
    } catch (e) {
      // 에러 무시
    }
  }

  Future<void> toggle() async {
    await setShowVideoCount(!state);
  }
}

/// 새영상 화면 컬렉션 크기 프로바이더 (true = 크게, false = 작게)
final latestVideosCollectionSizeLargeProvider =
    StateNotifierProvider<LatestVideosCollectionSizeLargeNotifier, bool>((ref) {
  return LatestVideosCollectionSizeLargeNotifier();
});

/// 재생목록 영상 정렬 순서
enum PlaylistVideosSortOrder {
  playlistOrder, // YouTube 재생목록 순서 (기본값)
  playlistOrderReverse, // 재생목록 역순
  newest, // 최신순
  oldest, // 오래된순
  title, // 제목순
}

extension PlaylistVideosSortOrderExtension on PlaylistVideosSortOrder {
  String getDisplayName(AppLocalizations? l10n) {
    if (l10n == null) return displayName;

    switch (this) {
      case PlaylistVideosSortOrder.playlistOrder:
        return l10n.sortPlaylistOrder;
      case PlaylistVideosSortOrder.playlistOrderReverse:
        return l10n.sortPlaylistOrderReverse;
      case PlaylistVideosSortOrder.newest:
        return l10n.sortNewest;
      case PlaylistVideosSortOrder.oldest:
        return l10n.sortOldest;
      case PlaylistVideosSortOrder.title:
        return l10n.sortTitle;
    }
  }

  String get displayName {
    switch (this) {
      case PlaylistVideosSortOrder.playlistOrder:
        return 'Playlist Order';
      case PlaylistVideosSortOrder.playlistOrderReverse:
        return 'Playlist Order (Reverse)';
      case PlaylistVideosSortOrder.newest:
        return 'Newest';
      case PlaylistVideosSortOrder.oldest:
        return 'Oldest';
      case PlaylistVideosSortOrder.title:
        return 'Title';
    }
  }

  static PlaylistVideosSortOrder fromString(String? value) {
    if (value == null) return PlaylistVideosSortOrder.playlistOrder;
    return PlaylistVideosSortOrder.values.firstWhere(
      (e) => e.name == value,
      orElse: () => PlaylistVideosSortOrder.playlistOrder,
    );
  }
}

/// 재생목록별 영상 정렬 순서 프로바이더
final playlistVideosSortOrdersProvider =
    StateNotifierProvider<PlaylistVideosSortOrdersNotifier, Map<String, PlaylistVideosSortOrder>>((ref) {
  return PlaylistVideosSortOrdersNotifier();
});

class PlaylistVideosSortOrdersNotifier extends StateNotifier<Map<String, PlaylistVideosSortOrder>> {
  PlaylistVideosSortOrdersNotifier() : super({}) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(Constants.keyPlaylistVideosSortOrders);
      if (jsonString != null) {
        final Map<String, dynamic> jsonMap = Map<String, dynamic>.from(
          Map.castFrom(jsonDecode(jsonString))
        );
        final orders = <String, PlaylistVideosSortOrder>{};
        for (final entry in jsonMap.entries) {
          orders[entry.key] = PlaylistVideosSortOrderExtension.fromString(entry.value as String?);
        }
        state = orders;
      }
    } catch (e) {
      state = {};
    }
  }

  PlaylistVideosSortOrder getSortOrder(String playlistId) {
    return state[playlistId] ?? PlaylistVideosSortOrder.playlistOrder;
  }

  Future<void> setSortOrder(String playlistId, PlaylistVideosSortOrder sortOrder) async {
    final newState = Map<String, PlaylistVideosSortOrder>.from(state);
    newState[playlistId] = sortOrder;
    state = newState;

    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonMap = <String, String>{};
      for (final entry in state.entries) {
        jsonMap[entry.key] = entry.value.name;
      }
      await prefs.setString(Constants.keyPlaylistVideosSortOrders, jsonEncode(jsonMap));
    } catch (e) {
      // 에러 무시
    }
  }

  Future<void> setAllSortOrders(Map<String, PlaylistVideosSortOrder> orders) async {
    state = orders;

    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonMap = <String, String>{};
      for (final entry in orders.entries) {
        jsonMap[entry.key] = entry.value.name;
      }
      await prefs.setString(Constants.keyPlaylistVideosSortOrders, jsonEncode(jsonMap));
    } catch (e) {
      // 에러 무시
    }
  }

  Future<void> reset() async {
    state = {};
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(Constants.keyPlaylistVideosSortOrders);
    } catch (e) {
      // 에러 무시
    }
  }
}

class LatestVideosCollectionSizeLargeNotifier extends StateNotifier<bool> {
  LatestVideosCollectionSizeLargeNotifier() : super(true) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final large = prefs.getBool(Constants.keyLatestVideosCollectionSizeLarge) ?? true;
      state = large;
    } catch (e) {
      state = true;
    }
  }

  Future<void> setLarge(bool large) async {
    state = large;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(Constants.keyLatestVideosCollectionSizeLarge, large);
    } catch (e) {
      // 에러 무시
    }
  }

  Future<void> toggle() async {
    await setLarge(!state);
  }
}

/// 롱탭 모드: 순서정렬 또는 삭제
enum FavoriteLongTapMode {
  reorder, // 순서정렬 (기본)
  delete,  // 즐겨찾기 제거
}

extension FavoriteLongTapModeExtension on FavoriteLongTapMode {
  static FavoriteLongTapMode fromString(String? value) {
    if (value == 'delete') return FavoriteLongTapMode.delete;
    return FavoriteLongTapMode.reorder;
  }
}

/// 3번 화면 (북마크) 롱탭 모드 프로바이더
final favoriteLongTapModeProvider =
    StateNotifierProvider<FavoriteLongTapModeNotifier, FavoriteLongTapMode>((ref) {
  return FavoriteLongTapModeNotifier();
});

class FavoriteLongTapModeNotifier extends StateNotifier<FavoriteLongTapMode> {
  FavoriteLongTapModeNotifier() : super(FavoriteLongTapMode.reorder) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final modeString = prefs.getString(Constants.keyFavoriteLongTapMode);
      state = FavoriteLongTapModeExtension.fromString(modeString);
    } catch (e) {
      state = FavoriteLongTapMode.reorder;
    }
  }

  Future<void> setMode(FavoriteLongTapMode mode) async {
    state = mode;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.keyFavoriteLongTapMode, mode.name);
    } catch (e) {
      // 에러 무시
    }
  }

  Future<void> toggle() async {
    final newMode = state == FavoriteLongTapMode.reorder
        ? FavoriteLongTapMode.delete
        : FavoriteLongTapMode.reorder;
    await setMode(newMode);
  }

  Future<void> reset() async {
    await setMode(FavoriteLongTapMode.reorder);
  }
}

/// 3번 화면 (북마크) 삭제 시 확인 메시지 표시 여부 프로바이더
final favoriteDeleteConfirmProvider =
    StateNotifierProvider<FavoriteDeleteConfirmNotifier, bool>((ref) {
  return FavoriteDeleteConfirmNotifier();
});

class FavoriteDeleteConfirmNotifier extends StateNotifier<bool> {
  FavoriteDeleteConfirmNotifier() : super(true) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final confirm = prefs.getBool(Constants.keyFavoriteDeleteConfirm) ?? true;
      state = confirm;
    } catch (e) {
      state = true;
    }
  }

  Future<void> setConfirm(bool confirm) async {
    state = confirm;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(Constants.keyFavoriteDeleteConfirm, confirm);
    } catch (e) {
      // 에러 무시
    }
  }

  Future<void> toggle() async {
    await setConfirm(!state);
  }

  Future<void> reset() async {
    await setConfirm(true);
  }
}
