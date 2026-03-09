import 'package:googleapis/youtube/v3.dart' as yt;
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import '../config/app_config.dart';
import '../models/channel.dart';
import '../models/video.dart';
import '../models/playlist.dart';

class YouTubeService {
  yt.YouTubeApi? _youtubeApi;
  auth.AuthClient? _authClient;

  void setAuthClient(auth.AuthClient client) {
    _authClient = client;
    _youtubeApi = yt.YouTubeApi(_authClient!);
  }

  bool get isAuthenticated => _authClient != null && _youtubeApi != null;

  /// 구독 채널 목록 가져오기
  Future<List<Channel>> fetchSubscriptions() async {
    if (!isAuthenticated) {
      throw Exception('Not authenticated');
    }

    final List<Channel> channels = [];
    String? nextPageToken;
    int sortOrder = 0;

    do {
      final response = await _youtubeApi!.subscriptions.list(
        ['snippet', 'contentDetails'],
        mine: true,
        maxResults: AppConfig.maxChannelsPerRequest,
        pageToken: nextPageToken,
      );

      if (response.items == null || response.items!.isEmpty) {
        break;
      }

      // 채널 ID 수집
      final channelIds =
          response.items!.map((item) => item.snippet!.resourceId!.channelId!).toList();

      // 채널 상세 정보 가져오기
      final channelDetails = await _fetchChannelDetails(channelIds);

      // Channel 객체 생성
      for (final item in response.items!) {
        final channelId = item.snippet!.resourceId!.channelId!;
        final detail = channelDetails[channelId];

        if (detail != null) {
          channels.add(Channel(
            id: channelId,
            title: item.snippet!.title ?? '',
            thumbnailUrl: item.snippet!.thumbnails?.default_?.url,
            subscriberCount: detail.subscriberCount,
            lastUploadDate: detail.lastUploadDate,
            uploadsPlaylistId: detail.uploadsPlaylistId,
            sortOrder: sortOrder++,
            createdAt: DateTime.now(),
          ));
        }
      }

      nextPageToken = response.nextPageToken;
    } while (nextPageToken != null);

    return channels;
  }

  /// 채널 상세 정보 가져오기
  Future<Map<String, _ChannelDetail>> _fetchChannelDetails(
      List<String> channelIds) async {
    if (!isAuthenticated) {
      throw Exception('Not authenticated');
    }

    final Map<String, _ChannelDetail> details = {};

    // 50개씩 배치 처리
    for (int i = 0; i < channelIds.length; i += AppConfig.maxChannelsPerRequest) {
      final batch = channelIds.skip(i).take(AppConfig.maxChannelsPerRequest).toList();

      final response = await _youtubeApi!.channels.list(
        ['snippet', 'statistics', 'contentDetails'],
        id: batch,
      );

      if (response.items == null) continue;

      for (final channel in response.items!) {
        final channelId = channel.id!;
        final subscriberCount = int.tryParse(
          channel.statistics?.subscriberCount ?? '0',
        );

        // uploads playlist ID 가져오기
        final uploadsPlaylistId = channel.contentDetails?.relatedPlaylists?.uploads;

        // 최근 업로드 날짜는 나중에 필요 시 가져오기
        DateTime? lastUploadDate;

        details[channelId] = _ChannelDetail(
          subscriberCount: subscriberCount,
          lastUploadDate: lastUploadDate,
          uploadsPlaylistId: uploadsPlaylistId,
        );
      }
    }

    return details;
  }

  /// 최근 업로드 날짜 가져오기
  Future<DateTime?> _getLastUploadDate(String uploadsPlaylistId) async {
    try {
      final response = await _youtubeApi!.playlistItems.list(
        ['snippet'],
        playlistId: uploadsPlaylistId,
        maxResults: 1,
      );

      if (response.items == null || response.items!.isEmpty) return null;

      final publishedAt = response.items!.first.snippet?.publishedAt;
      return publishedAt;
    } catch (e) {
      // 최근 업로드 정보를 가져오는 데 실패해도 계속 진행
      return null;
    }
  }

  /// 증분 업데이트 - 신규/삭제된 채널 확인
  Future<SubscriptionDiff> checkSubscriptionChanges(
      List<String> existingChannelIds) async {
    final currentSubscriptions = await fetchSubscriptions();
    final currentChannelIds =
        currentSubscriptions.map((c) => c.id).toSet();
    final existingIds = existingChannelIds.toSet();

    final newChannels = currentSubscriptions
        .where((c) => !existingIds.contains(c.id))
        .toList();
    final deletedChannelIds =
        existingIds.where((id) => !currentChannelIds.contains(id)).toList();

    return SubscriptionDiff(
      newChannels: newChannels,
      deletedChannelIds: deletedChannelIds,
    );
  }

  /// 채널들의 최신 영상 가져오기 (playlistItems.list 사용으로 할당량 절감)
  Future<List<Video>> fetchVideosFromChannels(List<Channel> channels, {int maxResults = 10}) async {
    if (!isAuthenticated) {
      throw Exception('Not authenticated');
    }

    if (channels.isEmpty) {
      return [];
    }

    final List<Video> videos = [];

    // 각 채널의 최신 영상 가져오기 (playlistItems.list 사용 - 1 유닛만 소모)
    for (final channel in channels) {
      try {
        // uploads playlist ID가 없으면 스킵
        if (channel.uploadsPlaylistId == null) {
          continue;
        }

        final response = await _youtubeApi!.playlistItems.list(
          ['snippet'],
          playlistId: channel.uploadsPlaylistId!,
          maxResults: maxResults,
        );

        if (response.items != null) {
          for (final item in response.items!) {
            final snippet = item.snippet;
            if (snippet == null) continue;

            final videoId = snippet.resourceId?.videoId;
            if (videoId == null) continue;

            videos.add(Video(
              id: videoId,
              channelId: channel.id,
              title: snippet.title ?? '',
              channelTitle: channel.title,
              description: snippet.description,
              thumbnailUrl: snippet.thumbnails?.high?.url ??
                  snippet.thumbnails?.medium?.url ??
                  snippet.thumbnails?.default_?.url,
              publishedAt: snippet.publishedAt ?? DateTime.now(),
            ));
          }
        }
      } catch (e) {
        // 개별 채널 실패 시 계속 진행
      }
    }

    // 날짜순 정렬 (최신순)
    videos.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));

    return videos;
  }

  /// 사용자의 재생목록 가져오기
  Future<List<Playlist>> fetchPlaylists() async {
    if (!isAuthenticated) {
      throw Exception('Not authenticated');
    }

    final List<Playlist> playlists = [];
    String? nextPageToken;

    do {
      final response = await _youtubeApi!.playlists.list(
        ['snippet', 'contentDetails'],
        mine: true,
        maxResults: 50,
        pageToken: nextPageToken,
      );

      if (response.items == null || response.items!.isEmpty) {
        break;
      }

      for (final item in response.items!) {
        // 썸네일 URL 직접 추출
        final thumbnails = item.snippet?.thumbnails;
        final thumbnailUrl = thumbnails?.medium?.url ??
                            thumbnails?.default_?.url ??
                            thumbnails?.high?.url;

        playlists.add(Playlist.fromYouTubeApi({
          'id': item.id,
          'snippet': {
            'title': item.snippet?.title,
            'description': item.snippet?.description,
            'publishedAt': item.snippet?.publishedAt?.toIso8601String(),
            'thumbnails': {
              'medium': {'url': thumbnailUrl},
              'default': {'url': thumbnailUrl},
            },
          },
          'contentDetails': {
            'itemCount': item.contentDetails?.itemCount,
          },
        }));
      }

      nextPageToken = response.nextPageToken;
    } while (nextPageToken != null);

    return playlists;
  }

  /// 재생목록의 영상 가져오기
  Future<List<Video>> fetchPlaylistVideos(String playlistId) async {
    if (!isAuthenticated) {
      throw Exception('Not authenticated');
    }

    final List<Video> videos = [];
    String? nextPageToken;

    do {
      final response = await _youtubeApi!.playlistItems.list(
        ['snippet', 'contentDetails'],
        playlistId: playlistId,
        maxResults: 50,
        pageToken: nextPageToken,
      );

      if (response.items == null || response.items!.isEmpty) {
        break;
      }

      for (final item in response.items!) {
        final videoId = item.snippet?.resourceId?.videoId;
        if (videoId == null) continue;

        videos.add(Video(
          id: videoId,
          channelId: item.snippet?.channelId ?? '',
          title: item.snippet?.title ?? '',
          channelTitle: item.snippet?.channelTitle ?? '',
          description: item.snippet?.description,
          thumbnailUrl: item.snippet?.thumbnails?.medium?.url ??
              item.snippet?.thumbnails?.default_?.url,
          publishedAt: item.snippet?.publishedAt ?? DateTime.now(),
        ));
      }

      nextPageToken = response.nextPageToken;
    } while (nextPageToken != null);

    return videos;
  }

  void dispose() {
    try {
      _authClient?.close();
    } catch (e) {
      // dispose 에러 무시
    }
    _authClient = null;
    _youtubeApi = null;
  }
}

class _ChannelDetail {
  final int? subscriberCount;
  final DateTime? lastUploadDate;
  final String? uploadsPlaylistId;

  _ChannelDetail({
    this.subscriberCount,
    this.lastUploadDate,
    this.uploadsPlaylistId,
  });
}

class SubscriptionDiff {
  final List<Channel> newChannels;
  final List<String> deletedChannelIds;

  SubscriptionDiff({
    required this.newChannels,
    required this.deletedChannelIds,
  });
}
