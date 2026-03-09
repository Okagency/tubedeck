import 'package:freezed_annotation/freezed_annotation.dart';

part 'playlist.freezed.dart';
part 'playlist.g.dart';

@freezed
class Playlist with _$Playlist {
  const factory Playlist({
    required String id,
    required String title,
    String? description,
    String? thumbnailUrl,
    required int itemCount,
    DateTime? publishedAt,
  }) = _Playlist;

  factory Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);

  factory Playlist.fromYouTubeApi(Map<String, dynamic> json) {
    final snippet = json['snippet'] as Map<String, dynamic>;
    final contentDetails = json['contentDetails'] as Map<String, dynamic>?;

    return Playlist(
      id: json['id'] as String,
      title: snippet['title'] as String,
      description: snippet['description'] as String?,
      thumbnailUrl: (snippet['thumbnails']?['medium']?['url'] ??
          snippet['thumbnails']?['default']?['url']) as String?,
      itemCount: contentDetails?['itemCount'] as int? ?? 0,
      publishedAt: snippet['publishedAt'] != null
          ? DateTime.parse(snippet['publishedAt'] as String)
          : null,
    );
  }
}
