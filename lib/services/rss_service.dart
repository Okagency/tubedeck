import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import '../models/video.dart';

/// RSS 피드 실패 예외
class RssException implements Exception {
  final String message;
  final int? statusCode;

  RssException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

/// RSS 피드를 통해 YouTube 영상을 가져오는 서비스 (API 할당량 사용 안함)
class RssService {
  static const String _rssBaseUrl = 'https://www.youtube.com/feeds/videos.xml';

  /// 단일 채널의 최신 영상 가져오기
  /// [throwOnError] - true면 에러 시 예외 발생, false면 빈 리스트 반환 (기본값: false)
  Future<List<Video>> fetchVideosFromChannel(
    String channelId,
    String channelTitle, {
    int maxResults = 1,
    bool throwOnError = false,
  }) async {
    try {
      final url = '$_rssBaseUrl?channel_id=$channelId';
      final response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw RssException('요청 시간 초과');
        },
      );

      if (response.statusCode != 200) {
        if (throwOnError) {
          throw RssException(
            'RSS 피드를 가져올 수 없습니다 (${response.statusCode})',
            statusCode: response.statusCode,
          );
        }
        return [];
      }

      final document = XmlDocument.parse(response.body);
      final entries = document.findAllElements('entry').take(maxResults);

      if (entries.isEmpty && throwOnError) {
        throw RssException('이 채널에는 공개된 영상이 없습니다');
      }

      final now = DateTime.now().toUtc();
      final videos = entries.map((entry) {
        final videoId = _extractVideoId(entry);
        final title = entry.findElements('title').first.innerText;
        final published = entry.findElements('published').first.innerText;
        final thumbnail = _extractThumbnail(entry, videoId);
        final description = _extractDescription(entry);
        final publishedAt = DateTime.parse(published).toUtc();

        // 예정된 영상(미래 날짜)은 제외 (1분 이상 미래인 경우)
        if (publishedAt.isAfter(now.add(const Duration(seconds: 60)))) {
          return null;
        }

        return Video(
          id: videoId,
          channelId: channelId,
          title: title,
          channelTitle: channelTitle,
          description: description,
          thumbnailUrl: thumbnail,
          publishedAt: publishedAt,
        );
      }).whereType<Video>().toList();

      // 업로드 시간 역순 정렬 (최신 영상이 상단)
      videos.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));

      return videos;
    } on RssException {
      rethrow;
    } catch (e) {
      if (throwOnError) {
        throw RssException('영상을 불러오는 중 오류 발생: $e');
      }
      return [];
    }
  }

  /// 여러 채널의 최신 영상 가져오기
  Future<List<Video>> fetchLatestVideosFromChannels(
    List<MapEntry<String, String>> channels, { // channelId, channelTitle pairs
    int maxResults = 1,
  }) async {
    final allVideos = <Video>[];

    // 병렬로 RSS 피드 가져오기 (10개씩 배치)
    const batchSize = 10;
    for (var i = 0; i < channels.length; i += batchSize) {
      final batch = channels.skip(i).take(batchSize);
      final futures = batch.map((channel) =>
          fetchVideosFromChannel(channel.key, channel.value, maxResults: maxResults));

      final results = await Future.wait(futures);
      for (final videos in results) {
        allVideos.addAll(videos);
      }
    }

    // 업로드 시간 역순 정렬 (최신 영상이 상단)
    allVideos.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));

    return allVideos;
  }

  /// entry에서 videoId 추출
  String _extractVideoId(XmlElement entry) {
    final videoIdElement = entry.findElements('yt:videoId').firstOrNull;
    if (videoIdElement != null) {
      return videoIdElement.innerText;
    }

    // fallback: link에서 추출
    final link = entry.findElements('link').first;
    final href = link.getAttribute('href') ?? '';
    final uri = Uri.tryParse(href);
    return uri?.queryParameters['v'] ?? '';
  }

  /// 썸네일 URL 추출
  String _extractThumbnail(XmlElement entry, String videoId) {
    // media:group > media:thumbnail 에서 추출
    final mediaGroup = entry.findElements('media:group').firstOrNull;
    if (mediaGroup != null) {
      final thumbnail = mediaGroup.findElements('media:thumbnail').firstOrNull;
      if (thumbnail != null) {
        return thumbnail.getAttribute('url') ?? '';
      }
    }

    // fallback: YouTube 기본 썸네일 URL
    return 'https://i.ytimg.com/vi/$videoId/hqdefault.jpg';
  }

  /// 설명(description) 추출
  String? _extractDescription(XmlElement entry) {
    // media:group > media:description 에서 추출
    final mediaGroup = entry.findElements('media:group').firstOrNull;
    if (mediaGroup != null) {
      final description = mediaGroup.findElements('media:description').firstOrNull;
      if (description != null) {
        return description.innerText;
      }
    }
    return null;
  }
}
