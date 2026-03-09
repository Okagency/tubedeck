import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../l10n/app_localizations.dart';

part 'channel.freezed.dart';
part 'channel.g.dart';

/// 채널 섹션 타입
enum ChannelSection {
  home,
  videos,
  shorts,
  live,
  podcasts,
  playlists,
  community,
}

@freezed
class Channel with _$Channel {
  const factory Channel({
    required String id,
    required String title,
    String? thumbnailUrl,
    int? subscriberCount,
    DateTime? lastUploadDate,
    String? uploadsPlaylistId,
    required int sortOrder,
    DateTime? createdAt,
    @Default(true) bool isSubscribed,
    String? defaultSection,
  }) = _Channel;

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);

  factory Channel.fromDatabase(Map<String, dynamic> map) {
    return Channel(
      id: map['id'] as String,
      title: map['title'] as String,
      thumbnailUrl: map['thumbnail_url'] as String?,
      subscriberCount: map['subscriber_count'] as int?,
      lastUploadDate: map['last_upload_date'] != null
          ? DateTime.parse(map['last_upload_date'] as String)
          : null,
      uploadsPlaylistId: map['uploads_playlist_id'] as String?,
      sortOrder: map['sort_order'] as int,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      isSubscribed: (map['is_subscribed'] as int?) == 1,
      defaultSection: map['default_section'] as String?,
    );
  }

  static Map<String, dynamic> toDatabase(Channel channel) {
    return {
      'id': channel.id,
      'title': channel.title,
      'thumbnail_url': channel.thumbnailUrl,
      'subscriber_count': channel.subscriberCount,
      'last_upload_date': channel.lastUploadDate?.toIso8601String(),
      'uploads_playlist_id': channel.uploadsPlaylistId,
      'sort_order': channel.sortOrder,
      'created_at': channel.createdAt?.toIso8601String(),
      'is_subscribed': channel.isSubscribed ? 1 : 0,
      'default_section': channel.defaultSection,
    };
  }
}

/// 채널 섹션 헬퍼
extension ChannelSectionExtension on ChannelSection {
  String get urlPath {
    switch (this) {
      case ChannelSection.home:
        return '';
      case ChannelSection.videos:
        return '/videos';
      case ChannelSection.shorts:
        return '/shorts';
      case ChannelSection.live:
        return '/streams';
      case ChannelSection.podcasts:
        return '/podcasts';
      case ChannelSection.playlists:
        return '/playlists';
      case ChannelSection.community:
        return '/community';
    }
  }

  /// Locale-aware display name
  String getDisplayName(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return displayName;

    switch (this) {
      case ChannelSection.home:
        return l10n.sectionHome;
      case ChannelSection.videos:
        return l10n.sectionVideos;
      case ChannelSection.shorts:
        return l10n.sectionShorts;
      case ChannelSection.live:
        return l10n.sectionLive;
      case ChannelSection.podcasts:
        return l10n.sectionPodcasts;
      case ChannelSection.playlists:
        return l10n.sectionPlaylists;
      case ChannelSection.community:
        return l10n.sectionCommunity;
    }
  }

  /// Fallback display name (English)
  String get displayName {
    switch (this) {
      case ChannelSection.home:
        return 'Home';
      case ChannelSection.videos:
        return 'Videos';
      case ChannelSection.shorts:
        return 'Shorts';
      case ChannelSection.live:
        return 'Live';
      case ChannelSection.podcasts:
        return 'Podcasts';
      case ChannelSection.playlists:
        return 'Playlists';
      case ChannelSection.community:
        return 'Community';
    }
  }

  static ChannelSection fromString(String? value) {
    if (value == null) return ChannelSection.home;
    return ChannelSection.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ChannelSection.home,
    );
  }
}
