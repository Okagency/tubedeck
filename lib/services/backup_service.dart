import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_service.dart';
import '../models/channel.dart';
import '../models/collection.dart';
import '../models/favorite_video.dart';
import '../utils/constants.dart';

/// 백업/복원 서비스
class BackupService {
  final DatabaseService _db;

  BackupService(this._db);

  /// 백업 데이터 생성
  Future<Map<String, dynamic>> createBackupData() async {
    // 1. 채널 전체 데이터 가져오기 (v2에서 추가) - 구독/구독 취소 모두 포함
    final db = await _db.database;
    final channelMaps = await db.query('channels', orderBy: 'sort_order ASC');
    final channels = channelMaps.map((map) => Channel.fromDatabase(map)).toList();
    final channelsData = channels.map((channel) {
      return {
        'id': channel.id,
        'title': channel.title,
        'thumbnailUrl': channel.thumbnailUrl,
        'subscriberCount': channel.subscriberCount,
        'lastUploadDate': channel.lastUploadDate?.toIso8601String(),
        'uploadsPlaylistId': channel.uploadsPlaylistId,
        'sortOrder': channel.sortOrder,
        'isSubscribed': channel.isSubscribed,
        'createdAt': channel.createdAt?.toIso8601String(),
        'defaultSection': channel.defaultSection, // 채널별 섹션 설정
      };
    }).toList();

    // 2. 채널 정렬 순서 (v1 호환용)
    final channelOrders = channels.map((channel) {
      return {
        'id': channel.id,
        'title': channel.title,
        'sortOrder': channel.sortOrder,
      };
    }).toList();

    // 2. 컬렉션 가져오기
    final collections = await _db.getAllCollections();
    final collectionsData = collections.map((collection) {
      return {
        'id': collection.id,
        'name': collection.name,
        'colorCode': collection.colorCode,
        'displayOrder': collection.displayOrder,
        'createdAt': collection.createdAt?.toIso8601String(),
      };
    }).toList();

    // 3. 컬렉션별 채널 매핑 가져오기
    final collectionChannels = <String, List<String>>{};
    for (final collection in collections) {
      final channels = await _db.getChannelsInCollection(collection.id);
      collectionChannels[collection.id] = channels.map((c) => c.id).toList();
    }

    // 4. 컬렉션별 채널 순서 가져오기
    final collectionOrders = <String, List<Map<String, dynamic>>>{};
    for (final collection in collections) {
      final orders = await db.query(
        'collection_orders',
        where: 'collection_id = ?',
        whereArgs: [collection.id],
        orderBy: 'sort_order ASC',
      );

      collectionOrders[collection.id] = orders.map((row) {
        return {
          'channelId': row['channel_id'] as String,
          'sortOrder': row['sort_order'] as int,
        };
      }).toList();
    }

    // 5. 재생목록 정렬 순서 가져오기 (v3에서 추가)
    final playlistOrders = await _db.getPlaylistOrders();
    final playlistOrdersData = playlistOrders.entries.map((entry) {
      return {
        'playlistId': entry.key,
        'sortOrder': entry.value,
      };
    }).toList();

    // 6. 즐겨찾기 가져오기 (v4에서 추가)
    final favorites = await _db.getAllFavorites();
    final favoritesData = favorites.map((fav) {
      return {
        'videoId': fav.videoId,
        'channelId': fav.channelId,
        'title': fav.title,
        'channelTitle': fav.channelTitle,
        'description': fav.description,
        'thumbnailUrl': fav.thumbnailUrl,
        'publishedAt': fav.publishedAt.toIso8601String(),
        'sortOrder': fav.sortOrder,
        'createdAt': fav.createdAt.toIso8601String(),
      };
    }).toList();

    // 7. 스와이프 활성화 컬렉션 가져오기 (v5에서 추가)
    final prefs = await SharedPreferences.getInstance();
    final swipeEnabledCollections = prefs.getStringList(Constants.keySwipeEnabledCollections) ?? [];

    // 8. 컬렉션 보기 설정 가져오기 (v6에서 추가)
    final showCollectionChannelCount = prefs.getBool(Constants.keyShowCollectionChannelCount) ?? true;
    final collectionSizeLarge = prefs.getBool(Constants.keyCollectionSizeLarge) ?? true;

    // 9. 새영상 화면 컬렉션 보기 설정 가져오기 (v7에서 추가)
    final latestVideosShowVideoCount = prefs.getBool(Constants.keyLatestVideosShowVideoCount) ?? false;
    final latestVideosCollectionSizeLarge = prefs.getBool(Constants.keyLatestVideosCollectionSizeLarge) ?? true;

    // 10. 칩 레이아웃 설정 가져오기 (v8에서 추가)
    final chipLayoutSingleLine = prefs.getBool(Constants.keyChipLayoutSingleLine) ?? true;
    final latestVideosChipLayoutSingleLine = prefs.getBool(Constants.keyLatestVideosChipLayoutSingleLine) ?? true;

    // 11. 재생목록 영상 정렬 순서 가져오기 (v9에서 추가)
    final playlistVideosSortOrdersJson = prefs.getString(Constants.keyPlaylistVideosSortOrders);

    // 12. 북마크 롱탭 모드 및 삭제 확인 설정 가져오기 (v10에서 추가)
    final favoriteLongTapMode = prefs.getString(Constants.keyFavoriteLongTapMode);
    final favoriteDeleteConfirm = prefs.getBool(Constants.keyFavoriteDeleteConfirm) ?? true;

    return {
      'version': 10,
      'exportedAt': DateTime.now().toIso8601String(),
      'channels': channelsData, // v2에서 추가: 채널 전체 데이터
      'channelOrders': channelOrders, // v1 호환용
      'collections': collectionsData,
      'collectionChannels': collectionChannels,
      'collectionOrders': collectionOrders,
      'playlistOrders': playlistOrdersData, // v3에서 추가: 재생목록 정렬 순서
      'favorites': favoritesData, // v4에서 추가: 즐겨찾기
      'swipeEnabledCollections': swipeEnabledCollections, // v5에서 추가: 스와이프 활성화 컬렉션
      'showCollectionChannelCount': showCollectionChannelCount, // v6에서 추가: 채널수 표시
      'collectionSizeLarge': collectionSizeLarge, // v6에서 추가: 컬렉션 크기
      'latestVideosShowVideoCount': latestVideosShowVideoCount, // v7에서 추가: 새영상 영상수 표시
      'latestVideosCollectionSizeLarge': latestVideosCollectionSizeLarge, // v7에서 추가: 새영상 컬렉션 크기
      'chipLayoutSingleLine': chipLayoutSingleLine, // v8에서 추가: 구독 화면 칩 레이아웃
      'latestVideosChipLayoutSingleLine': latestVideosChipLayoutSingleLine, // v8에서 추가: 새영상 화면 칩 레이아웃
      'playlistVideosSortOrders': playlistVideosSortOrdersJson, // v9에서 추가: 재생목록 영상 정렬 순서
      'favoriteLongTapMode': favoriteLongTapMode, // v10에서 추가: 북마크 롱탭 모드
      'favoriteDeleteConfirm': favoriteDeleteConfirm, // v10에서 추가: 북마크 삭제 확인
    };
  }

  /// 백업 파일로 저장 (SAF를 통해 사용자가 저장 위치 선택)
  Future<String?> exportToFile() async {
    try {
      // 백업 데이터 생성
      final backupData = await createBackupData();
      final jsonString = const JsonEncoder.withIndent('  ').convert(backupData);

      // 파일명 생성
      final timestamp = DateTime.now()
          .toIso8601String()
          .replaceAll(':', '-')
          .replaceAll('.', '-')
          .substring(0, 19);
      final fileName = 'tubedeck_backup_$timestamp.json';

      // SAF를 통해 저장 (Android/iOS는 bytes 필수)
      final bytes = utf8.encode(jsonString);
      final savePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Backup',
        fileName: fileName,
        type: FileType.any,
        bytes: Uint8List.fromList(bytes),
      );

      if (savePath == null) return null; // 사용자 취소

      return savePath;
    } catch (e) {
      rethrow;
    }
  }

  /// 백업 파일에서 복원 (사용자가 직접 파일 선택)
  Future<void> importFromFile() async {
    try {
      // 파일 선택기로 백업 파일 선택 (모든 기기 호환성을 위해 FileType.any 사용)
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        throw Exception('파일이 선택되지 않았습니다.');
      }

      final filePath = result.files.single.path;
      if (filePath == null) {
        throw Exception('파일 경로를 가져올 수 없습니다.');
      }

      // 파일 읽기
      final file = File(filePath);
      if (!await file.exists()) {
        throw Exception('파일이 존재하지 않습니다.');
      }

      final jsonString = await file.readAsString();

      // JSON 파싱
      final backupData = jsonDecode(jsonString) as Map<String, dynamic>;

      // 버전 확인
      final version = backupData['version'] as int?;
      if (version != 1 && version != 2 && version != 3 && version != 4 && version != 5 && version != 6 && version != 7 && version != 8 && version != 9 && version != 10) {
        throw Exception('Unsupported backup file version. (version: $version)');
      }

      // 복원 실행
      await _restoreBackupData(backupData);
    } catch (e) {
      rethrow;
    }
  }

  /// 백업 데이터 복원
  Future<void> _restoreBackupData(Map<String, dynamic> backupData) async {
    final version = backupData['version'] as int?;

    // 0. 기존 데이터 모두 삭제
    final existingCollections = await _db.getAllCollections();
    for (final collection in existingCollections) {
      await _db.deleteCollection(collection.id);
    }

    // 기존 채널 모두 삭제 (구독/구독 취소 모두 포함)
    final db = await _db.database;
    final channelMaps = await db.query('channels');
    final existingChannels = channelMaps.map((map) => Channel.fromDatabase(map)).toList();
    for (final channel in existingChannels) {
      await db.delete('channels', where: 'id = ?', whereArgs: [channel.id]);
    }

    // 1. 채널 데이터 복원 (v2 이상)
    if (version != null && version >= 2) {
      final channelsData = backupData['channels'] as List<dynamic>?;
      if (channelsData != null) {
        for (final channelData in channelsData) {
          final channel = Channel(
            id: channelData['id'] as String,
            title: channelData['title'] as String,
            thumbnailUrl: channelData['thumbnailUrl'] as String?,
            subscriberCount: channelData['subscriberCount'] as int?,
            lastUploadDate: channelData['lastUploadDate'] != null
                ? DateTime.parse(channelData['lastUploadDate'] as String)
                : null,
            uploadsPlaylistId: channelData['uploadsPlaylistId'] as String?,
            sortOrder: channelData['sortOrder'] as int,
            isSubscribed: channelData['isSubscribed'] as bool? ?? true,
            createdAt: channelData['createdAt'] != null
                ? DateTime.parse(channelData['createdAt'] as String)
                : null,
            defaultSection: channelData['defaultSection'] as String?, // 채널별 섹션 설정
          );

          await _db.insertChannel(channel);
        }
      }
    }

    // 2. 컬렉션 복원
    final collectionsData = backupData['collections'] as List<dynamic>?;
    if (collectionsData != null) {
      for (final collectionData in collectionsData) {
        final collection = Collection(
          id: collectionData['id'] as String,
          name: collectionData['name'] as String,
          colorCode: collectionData['colorCode'] as int,
          displayOrder: collectionData['displayOrder'] as int,
          createdAt: collectionData['createdAt'] != null
              ? DateTime.parse(collectionData['createdAt'] as String)
              : null,
        );

        await _db.insertCollection(collection);
      }
    }

    // 3. 채널 정렬 순서 복원 (v1 호환)
    if (version == 1) {
      final channelOrders = backupData['channelOrders'] as List<dynamic>?;
      if (channelOrders != null) {
        for (final orderData in channelOrders) {
          final channelId = orderData['id'] as String;
          final sortOrder = orderData['sortOrder'] as int;

          try {
            await _db.updateChannelSortOrder(channelId, sortOrder);
          } catch (e) {
            // 채널 순서 복원 실패 시 무시
          }
        }
      }
    }

    // 4. 컬렉션-채널 매핑 복원
    final collectionChannels =
        backupData['collectionChannels'] as Map<String, dynamic>?;
    final collectionOrders =
        backupData['collectionOrders'] as Map<String, dynamic>?;

    if (collectionChannels != null) {
      // 새 버전 백업 파일: collectionChannels 사용
      for (final entry in collectionChannels.entries) {
        final collectionId = entry.key;
        final channelIds = (entry.value as List<dynamic>).cast<String>();

        for (final channelId in channelIds) {
          try {
            await _db.addChannelToCollection(channelId, collectionId);
          } catch (e) {
            // 이미 존재하는 경우 무시
          }
        }
      }
    } else if (collectionOrders != null) {
      // 구 버전 백업 파일: collectionOrders에서 채널 목록 추출
      for (final entry in collectionOrders.entries) {
        final collectionId = entry.key;
        final orders = entry.value as List<dynamic>;

        for (final orderData in orders) {
          final channelId = orderData['channelId'] as String;

          try {
            await _db.addChannelToCollection(channelId, collectionId);
          } catch (e) {
            // 이미 존재하는 경우 무시
          }
        }
      }
    }

    // 5. 컬렉션별 채널 순서 복원
    if (collectionOrders != null) {
      for (final entry in collectionOrders.entries) {
        final collectionId = entry.key;
        final orders = entry.value as List<dynamic>;

        for (final orderData in orders) {
          final channelId = orderData['channelId'] as String;
          final sortOrder = orderData['sortOrder'] as int;

          try {
            await _db.updateCollectionChannelSortOrder(
              collectionId,
              channelId,
              sortOrder,
            );
          } catch (e) {
            // 컬렉션 채널 순서 복원 실패 시 무시
          }
        }
      }
    }

    // 6. 재생목록 정렬 순서 복원 (v3에서 추가)
    final playlistOrdersData = backupData['playlistOrders'] as List<dynamic>?;
    if (playlistOrdersData != null && playlistOrdersData.isNotEmpty) {
      final orders = <String, int>{};
      for (final orderData in playlistOrdersData) {
        final playlistId = orderData['playlistId'] as String;
        final sortOrder = orderData['sortOrder'] as int;
        orders[playlistId] = sortOrder;
      }

      await _db.savePlaylistOrders(orders);
    }

    // 7. 즐겨찾기 복원 (v4에서 추가)
    // 기존 즐겨찾기 삭제
    final existingFavorites = await _db.getAllFavorites();
    for (final fav in existingFavorites) {
      await _db.removeFavorite(fav.videoId);
    }

    final favoritesData = backupData['favorites'] as List<dynamic>?;
    if (favoritesData != null && favoritesData.isNotEmpty) {
      for (final favData in favoritesData) {
        final favorite = FavoriteVideo(
          videoId: favData['videoId'] as String,
          channelId: favData['channelId'] as String,
          title: favData['title'] as String,
          channelTitle: favData['channelTitle'] as String,
          description: favData['description'] as String?,
          thumbnailUrl: favData['thumbnailUrl'] as String?,
          publishedAt: DateTime.parse(favData['publishedAt'] as String),
          sortOrder: favData['sortOrder'] as int,
          createdAt: favData['createdAt'] != null
              ? DateTime.parse(favData['createdAt'] as String)
              : DateTime.now(),
        );

        await _db.addFavoriteForRestore(favorite);
      }
    }

    // 8. 스와이프 활성화 컬렉션 복원 (v5에서 추가)
    final swipeEnabledCollections = backupData['swipeEnabledCollections'] as List<dynamic>?;
    if (swipeEnabledCollections != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        Constants.keySwipeEnabledCollections,
        swipeEnabledCollections.cast<String>(),
      );
    }

    // 9. 컬렉션 보기 설정 복원 (v6에서 추가)
    final showCollectionChannelCount = backupData['showCollectionChannelCount'] as bool?;
    final collectionSizeLarge = backupData['collectionSizeLarge'] as bool?;
    if (showCollectionChannelCount != null || collectionSizeLarge != null) {
      final prefs = await SharedPreferences.getInstance();
      if (showCollectionChannelCount != null) {
        await prefs.setBool(Constants.keyShowCollectionChannelCount, showCollectionChannelCount);
      }
      if (collectionSizeLarge != null) {
        await prefs.setBool(Constants.keyCollectionSizeLarge, collectionSizeLarge);
      }
    }

    // 10. 새영상 화면 컬렉션 보기 설정 복원 (v7에서 추가)
    final latestVideosShowVideoCount = backupData['latestVideosShowVideoCount'] as bool?;
    final latestVideosCollectionSizeLarge = backupData['latestVideosCollectionSizeLarge'] as bool?;
    if (latestVideosShowVideoCount != null || latestVideosCollectionSizeLarge != null) {
      final prefs = await SharedPreferences.getInstance();
      if (latestVideosShowVideoCount != null) {
        await prefs.setBool(Constants.keyLatestVideosShowVideoCount, latestVideosShowVideoCount);
      }
      if (latestVideosCollectionSizeLarge != null) {
        await prefs.setBool(Constants.keyLatestVideosCollectionSizeLarge, latestVideosCollectionSizeLarge);
      }
    }

    // 11. 칩 레이아웃 설정 복원 (v8에서 추가)
    final chipLayoutSingleLine = backupData['chipLayoutSingleLine'] as bool?;
    final latestVideosChipLayoutSingleLine = backupData['latestVideosChipLayoutSingleLine'] as bool?;
    if (chipLayoutSingleLine != null || latestVideosChipLayoutSingleLine != null) {
      final prefs = await SharedPreferences.getInstance();
      if (chipLayoutSingleLine != null) {
        await prefs.setBool(Constants.keyChipLayoutSingleLine, chipLayoutSingleLine);
      }
      if (latestVideosChipLayoutSingleLine != null) {
        await prefs.setBool(Constants.keyLatestVideosChipLayoutSingleLine, latestVideosChipLayoutSingleLine);
      }
    }

    // 12. 재생목록 영상 정렬 순서 복원 (v9에서 추가)
    final playlistVideosSortOrdersJson = backupData['playlistVideosSortOrders'] as String?;
    if (playlistVideosSortOrdersJson != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.keyPlaylistVideosSortOrders, playlistVideosSortOrdersJson);
    }

    // 13. 북마크 롱탭 모드 및 삭제 확인 설정 복원 (v10에서 추가)
    final favoriteLongTapMode = backupData['favoriteLongTapMode'] as String?;
    final favoriteDeleteConfirm = backupData['favoriteDeleteConfirm'] as bool?;
    if (favoriteLongTapMode != null || favoriteDeleteConfirm != null) {
      final prefs = await SharedPreferences.getInstance();
      if (favoriteLongTapMode != null) {
        await prefs.setString(Constants.keyFavoriteLongTapMode, favoriteLongTapMode);
      }
      if (favoriteDeleteConfirm != null) {
        await prefs.setBool(Constants.keyFavoriteDeleteConfirm, favoriteDeleteConfirm);
      }
    }
  }

  /// 백업 파일 유효성 검사
  static Future<bool> validateBackupFile(File file) async {
    try {
      final jsonString = await file.readAsString();
      final data = jsonDecode(jsonString) as Map<String, dynamic>;

      // 버전 확인
      final version = data['version'] as int?;
      if (version != 1 && version != 2 && version != 3 && version != 4 && version != 5 && version != 6 && version != 7 && version != 8 && version != 9 && version != 10) {
        return false;
      }

      // 버전별 필수 필드 확인
      if (version == 1) {
        // v1: channelOrders, collections, collectionOrders 필수
        if (!data.containsKey('channelOrders') ||
            !data.containsKey('collections') ||
            !data.containsKey('collectionOrders')) {
          return false;
        }
      } else if (version == 2 || version == 3 || version == 4 || version == 5 || version == 6 || version == 7 || version == 8 || version == 9 || version == 10) {
        // v2, v3, v4, v5, v6, v7, v8, v9, v10: channels, collections 필수
        // v3에서 playlistOrders 추가 (선택적)
        // v4에서 favorites 추가 (선택적)
        // v5에서 swipeEnabledCollections 추가 (선택적)
        // v6에서 showCollectionChannelCount, collectionSizeLarge 추가 (선택적)
        // v7에서 latestVideosShowVideoCount, latestVideosCollectionSizeLarge 추가 (선택적)
        // v8에서 chipLayoutSingleLine, latestVideosChipLayoutSingleLine 추가 (선택적)
        // v9에서 playlistVideosSortOrders 추가 (선택적)
        // v10에서 favoriteLongTapMode, favoriteDeleteConfirm 추가 (선택적)
        if (!data.containsKey('channels') ||
            !data.containsKey('collections')) {
          return false;
        }
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
