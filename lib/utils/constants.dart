class Constants {
  // SharedPreferences Keys
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUserEmail = 'user_email';
  static const String keyThemeMode = 'theme_mode';
  static const String keyAutoRefreshInterval = 'auto_refresh_interval';
  static const String keyLastSyncTime = 'last_sync_time';
  static const String keyDefaultChannelSection = 'default_channel_section';
  static const String keyVideosPerChannel = 'videos_per_channel';
  static const String keyEnableCaption = 'enable_caption';
  static const String keyChipLayoutSingleLine = 'chip_layout_single_line';
  static const String keyLatestVideosChipLayoutSingleLine = 'latest_videos_chip_layout_single_line';
  static const String keyChannelTapAction = 'channel_tap_action';
  static const String keyVideoCardTapAction = 'video_card_tap_action';
  static const String keyVideoCardLayoutStyle = 'video_card_layout_style';
  static const String keyLatestVideosLayout = 'latest_videos_layout';
  static const String keyFavoritesLayout = 'favorites_layout';
  static const String keyChannelVideosLayout = 'channel_videos_layout';
  static const String keyPlaylistVideosLayout = 'playlist_videos_layout';
  static const String keyLatestVideosTapAction = 'latest_videos_tap_action';
  static const String keyFavoritesTapAction = 'favorites_tap_action';
  static const String keyChannelVideosTapAction = 'channel_videos_tap_action';
  static const String keyPlaylistVideosTapAction = 'playlist_videos_tap_action';
  static const String keyNavOrder = 'nav_order';
  static const String keyShowCollectionFab = 'show_collection_fab';
  static const String keyHideCreateCollectionDialog = 'hide_create_collection_dialog';
  static const String keySwipeEnabledCollections = 'swipe_enabled_collections';
  static const String keyShowCollectionChannelCount = 'show_collection_channel_count';
  static const String keyCollectionSizeLarge = 'collection_size_large';
  static const String keyLatestVideosShowVideoCount = 'latest_videos_show_video_count';
  static const String keyLatestVideosCollectionSizeLarge = 'latest_videos_collection_size_large';
  static const String keyPlaylistVideosSortOrders = 'playlist_videos_sort_orders';
  static const String keyFavoriteLongTapMode = 'favorite_long_tap_mode';
  static const String keyFavoriteDeleteConfirm = 'favorite_delete_confirm';

  // Secure Storage Keys
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyTokenExpiry = 'token_expiry';

  // Collection Colors (ARGB)
  static const List<int> collectionColors = [
    0xFFF44336, // Red
    0xFFE91E63, // Pink
    0xFF9C27B0, // Purple
    0xFF673AB7, // Deep Purple
    0xFF3F51B5, // Indigo
    0xFF2196F3, // Blue
    0xFF03A9F4, // Light Blue
    0xFF00BCD4, // Cyan
    0xFF009688, // Teal
    0xFF4CAF50, // Green
    0xFF8BC34A, // Light Green
    0xFFCDDC39, // Lime
    0xFFFFEB3B, // Yellow
    0xFFFFC107, // Amber
    0xFFFF9800, // Orange
    0xFFFF5722, // Deep Orange
  ];

  // Default Values
  static const int defaultCollectionColor = 0xFF2196F3;
  static const String allChannelsFilterId = 'all';
  static const String allChannelsFilterName = '구독';

  // Animation
  static const Duration dragAnimationDuration = Duration(milliseconds: 200);
  static const double dragOpacity = 0.7;
  static const double dragScale = 1.05;

  // UI
  static const int maxCollectionChipsToShow = 3;
  static const int shimmerItemCount = 10;
}
