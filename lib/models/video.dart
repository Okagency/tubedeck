import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@freezed
class Video with _$Video {
  const factory Video({
    required String id,
    required String channelId,
    required String title,
    required String channelTitle,
    String? description,
    String? thumbnailUrl,
    required DateTime publishedAt,
    String? duration,
    int? viewCount,
    int? likeCount,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  factory Video.fromYouTubeApi(Map<String, dynamic> item) {
    final snippet = item['snippet'] as Map<String, dynamic>;
    final id = item['id'] is String
        ? item['id'] as String
        : (item['id'] as Map<String, dynamic>)['videoId'] as String;

    return Video(
      id: id,
      channelId: snippet['channelId'] as String,
      title: snippet['title'] as String,
      channelTitle: snippet['channelTitle'] as String,
      description: snippet['description'] as String?,
      thumbnailUrl: (snippet['thumbnails']?['high']?['url'] ??
          snippet['thumbnails']?['medium']?['url'] ??
          snippet['thumbnails']?['default']?['url']) as String?,
      publishedAt: DateTime.parse(snippet['publishedAt'] as String),
      duration: null, // Will be fetched separately if needed
      viewCount: null,
      likeCount: null,
    );
  }

  factory Video.fromDatabase(Map<String, dynamic> map) {
    return Video(
      id: map['id'] as String,
      channelId: map['channel_id'] as String,
      title: map['title'] as String,
      channelTitle: map['channel_title'] as String,
      description: map['description'] as String?,
      thumbnailUrl: map['thumbnail_url'] as String?,
      publishedAt: DateTime.parse(map['published_at'] as String),
      duration: map['duration'] as String?,
      viewCount: map['view_count'] as int?,
      likeCount: map['like_count'] as int?,
    );
  }

  static Map<String, dynamic> toDatabase(Video video) {
    return {
      'id': video.id,
      'channel_id': video.channelId,
      'title': video.title,
      'channel_title': video.channelTitle,
      'description': video.description,
      'thumbnail_url': video.thumbnailUrl,
      'published_at': video.publishedAt.toIso8601String(),
      'duration': video.duration,
      'view_count': video.viewCount,
      'like_count': video.likeCount,
    };
  }
}
