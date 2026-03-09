class FavoriteVideo {
  final String videoId;
  final String channelId;
  final String title;
  final String channelTitle;
  final String? description;
  final String? thumbnailUrl;
  final DateTime publishedAt;
  final int sortOrder;
  final DateTime createdAt;

  FavoriteVideo({
    required this.videoId,
    required this.channelId,
    required this.title,
    required this.channelTitle,
    this.description,
    this.thumbnailUrl,
    required this.publishedAt,
    required this.sortOrder,
    required this.createdAt,
  });

  factory FavoriteVideo.fromDatabase(Map<String, dynamic> map) {
    return FavoriteVideo(
      videoId: map['video_id'] as String,
      channelId: map['channel_id'] as String,
      title: map['title'] as String,
      channelTitle: map['channel_title'] as String,
      description: map['description'] as String?,
      thumbnailUrl: map['thumbnail_url'] as String?,
      publishedAt: DateTime.parse(map['published_at'] as String),
      sortOrder: map['sort_order'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  static Map<String, dynamic> toDatabase(FavoriteVideo favorite) {
    return {
      'video_id': favorite.videoId,
      'channel_id': favorite.channelId,
      'title': favorite.title,
      'channel_title': favorite.channelTitle,
      'description': favorite.description,
      'thumbnail_url': favorite.thumbnailUrl,
      'published_at': favorite.publishedAt.toIso8601String(),
      'sort_order': favorite.sortOrder,
      'created_at': favorite.createdAt.toIso8601String(),
    };
  }

  FavoriteVideo copyWith({
    String? videoId,
    String? channelId,
    String? title,
    String? channelTitle,
    String? description,
    String? thumbnailUrl,
    DateTime? publishedAt,
    int? sortOrder,
    DateTime? createdAt,
  }) {
    return FavoriteVideo(
      videoId: videoId ?? this.videoId,
      channelId: channelId ?? this.channelId,
      title: title ?? this.title,
      channelTitle: channelTitle ?? this.channelTitle,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      publishedAt: publishedAt ?? this.publishedAt,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
