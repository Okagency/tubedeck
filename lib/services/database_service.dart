import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../config/app_config.dart';
import '../models/channel.dart';
import '../models/collection.dart';
import '../models/video.dart';
import '../models/favorite_video.dart';
import '../models/playlist.dart';

class DatabaseService {
  static Database? _database;
  static String? _currentUserEmail;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// 현재 사용자 이메일 기반 DB 파일명 생성
  String _getDatabaseName() {
    if (_currentUserEmail == null || _currentUserEmail!.isEmpty) {
      return AppConfig.databaseName; // 기본 DB (마이그레이션용)
    }
    // 이메일에서 파일명으로 사용할 수 없는 문자 변환
    final sanitized = _currentUserEmail!
        .replaceAll('@', '_at_')
        .replaceAll('.', '_');
    return 'tubedeck_$sanitized.db';
  }

  /// 사용자 전환 시 DB 변경
  Future<void> setCurrentUser(String? email, {bool force = false}) async {
    if (!force && _currentUserEmail == email) return;

    // 기존 DB 닫기
    if (_database != null) {
      await _database!.close();
      _database = null;
    }

    _currentUserEmail = email;

    // 새 사용자의 DB 열기
    if (email != null) {
      _database = await _initDatabase();

      // 기존 데이터 마이그레이션 (최초 1회)
      await _migrateFromLegacyDb();
    }
  }

  /// 기존 DB(tubedeck.db)에서 사용자별 DB로 데이터 마이그레이션
  Future<void> _migrateFromLegacyDb() async {
    final databasesPath = await getDatabasesPath();
    final legacyDbPath = join(databasesPath, AppConfig.databaseName);
    final legacyDbFile = File(legacyDbPath);

    // 기존 DB가 없으면 마이그레이션 불필요
    if (!await legacyDbFile.exists()) return;

    // 현재 DB에 이미 데이터가 있으면 마이그레이션 불필요
    final currentChannelCount = await getChannelCount();
    if (currentChannelCount > 0) return;

    try {
      // 기존 DB 열기
      final legacyDb = await openDatabase(legacyDbPath, readOnly: true);

      // 기존 DB에 데이터가 있는지 확인
      final legacyChannelCount = Sqflite.firstIntValue(
        await legacyDb.rawQuery('SELECT COUNT(*) FROM channels'),
      ) ?? 0;

      if (legacyChannelCount == 0) {
        await legacyDb.close();
        return;
      }

      // 데이터 복사
      final db = await database;

      // 1. channels
      final channels = await legacyDb.query('channels');
      for (final channel in channels) {
        await db.insert('channels', channel, conflictAlgorithm: ConflictAlgorithm.ignore);
      }

      // 2. collections
      final collections = await legacyDb.query('collections');
      for (final collection in collections) {
        await db.insert('collections', collection, conflictAlgorithm: ConflictAlgorithm.ignore);
      }

      // 3. channel_collections
      final channelCollections = await legacyDb.query('channel_collections');
      for (final cc in channelCollections) {
        await db.insert('channel_collections', cc, conflictAlgorithm: ConflictAlgorithm.ignore);
      }

      // 4. collection_orders
      final collectionOrders = await legacyDb.query('collection_orders');
      for (final co in collectionOrders) {
        await db.insert('collection_orders', co, conflictAlgorithm: ConflictAlgorithm.ignore);
      }

      // 5. favorites
      final favorites = await legacyDb.query('favorites');
      for (final fav in favorites) {
        await db.insert('favorites', fav, conflictAlgorithm: ConflictAlgorithm.ignore);
      }

      // 6. playlist_orders
      final playlistOrders = await legacyDb.query('playlist_orders');
      for (final po in playlistOrders) {
        await db.insert('playlist_orders', po, conflictAlgorithm: ConflictAlgorithm.ignore);
      }

      await legacyDb.close();

      // 마이그레이션 완료 후 기존 DB 삭제 (다른 사용자에게 복사 방지)
      await legacyDbFile.delete();
    } catch (e) {
      // 마이그레이션 실패해도 앱은 정상 동작
    }
  }

  /// 현재 사용자 이메일 반환
  String? get currentUserEmail => _currentUserEmail;

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _getDatabaseName());

    return await openDatabase(
      path,
      version: AppConfig.databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // channels 테이블
    await db.execute('''
      CREATE TABLE channels (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        thumbnail_url TEXT,
        subscriber_count INTEGER,
        last_upload_date TEXT,
        uploads_playlist_id TEXT,
        sort_order INTEGER NOT NULL,
        is_subscribed INTEGER DEFAULT 1,
        default_section TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_channels_sort_order ON channels(sort_order)
    ''');

    // collections 테이블
    await db.execute('''
      CREATE TABLE collections (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        color_code INTEGER NOT NULL,
        display_order INTEGER NOT NULL,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_collections_display_order ON collections(display_order)
    ''');

    // channel_collections 테이블
    await db.execute('''
      CREATE TABLE channel_collections (
        channel_id TEXT NOT NULL,
        collection_id TEXT NOT NULL,
        PRIMARY KEY (channel_id, collection_id),
        FOREIGN KEY (channel_id) REFERENCES channels(id) ON DELETE CASCADE,
        FOREIGN KEY (collection_id) REFERENCES collections(id) ON DELETE CASCADE
      )
    ''');

    // collection_orders 테이블
    await db.execute('''
      CREATE TABLE collection_orders (
        collection_id TEXT NOT NULL,
        channel_id TEXT NOT NULL,
        sort_order INTEGER NOT NULL,
        PRIMARY KEY (collection_id, channel_id),
        FOREIGN KEY (collection_id) REFERENCES collections(id) ON DELETE CASCADE,
        FOREIGN KEY (channel_id) REFERENCES channels(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_collection_orders ON collection_orders(collection_id, sort_order)
    ''');

    // videos 테이블
    await db.execute('''
      CREATE TABLE videos (
        id TEXT PRIMARY KEY,
        channel_id TEXT NOT NULL,
        title TEXT NOT NULL,
        channel_title TEXT NOT NULL,
        description TEXT,
        thumbnail_url TEXT,
        published_at TEXT NOT NULL,
        duration TEXT,
        view_count INTEGER,
        like_count INTEGER,
        cached_at TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (channel_id) REFERENCES channels(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_videos_channel_id ON videos(channel_id)
    ''');

    await db.execute('''
      CREATE INDEX idx_videos_published_at ON videos(published_at DESC)
    ''');

    // video_cache_metadata 테이블 (컬렉션별 캐시 만료 시간 추적)
    await db.execute('''
      CREATE TABLE video_cache_metadata (
        cache_key TEXT PRIMARY KEY,
        last_fetched_at TEXT NOT NULL
      )
    ''');

    // playlist_orders 테이블 (재생목록 정렬)
    await db.execute('''
      CREATE TABLE playlist_orders (
        playlist_id TEXT PRIMARY KEY,
        sort_order INTEGER NOT NULL
      )
    ''');

    // playlists 테이블 (재생목록 캐시)
    await db.execute('''
      CREATE TABLE playlists (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        thumbnail_url TEXT,
        item_count INTEGER NOT NULL,
        published_at TEXT,
        cached_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // favorites 테이블 (즐겨찾기 영상)
    await db.execute('''
      CREATE TABLE favorites (
        video_id TEXT PRIMARY KEY,
        channel_id TEXT NOT NULL,
        title TEXT NOT NULL,
        channel_title TEXT NOT NULL,
        description TEXT,
        thumbnail_url TEXT,
        published_at TEXT NOT NULL,
        sort_order INTEGER NOT NULL,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_favorites_sort_order ON favorites(sort_order)
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Version 2: is_subscribed 필드 추가
      await db.execute('ALTER TABLE channels ADD COLUMN is_subscribed INTEGER DEFAULT 1');
    }
    if (oldVersion < 3) {
      // Version 3: videos 테이블 및 캐시 메타데이터 테이블 추가
      await db.execute('''
        CREATE TABLE videos (
          id TEXT PRIMARY KEY,
          channel_id TEXT NOT NULL,
          title TEXT NOT NULL,
          channel_title TEXT NOT NULL,
          description TEXT,
          thumbnail_url TEXT,
          published_at TEXT NOT NULL,
          duration TEXT,
          view_count INTEGER,
          like_count INTEGER,
          cached_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (channel_id) REFERENCES channels(id) ON DELETE CASCADE
        )
      ''');

      await db.execute('''
        CREATE INDEX idx_videos_channel_id ON videos(channel_id)
      ''');

      await db.execute('''
        CREATE INDEX idx_videos_published_at ON videos(published_at DESC)
      ''');

      await db.execute('''
        CREATE TABLE video_cache_metadata (
          cache_key TEXT PRIMARY KEY,
          last_fetched_at TEXT NOT NULL
        )
      ''');
    }
    if (oldVersion < 4) {
      // Version 4: uploads_playlist_id 필드 추가
      await db.execute('ALTER TABLE channels ADD COLUMN uploads_playlist_id TEXT');
    }
    if (oldVersion < 5) {
      // Version 5: default_section 필드 추가 (채널별 기본 섹션)
      await db.execute('ALTER TABLE channels ADD COLUMN default_section TEXT');
    }
    if (oldVersion < 6) {
      // Version 6: playlist_orders 테이블 추가 (재생목록 정렬)
      await db.execute('''
        CREATE TABLE playlist_orders (
          playlist_id TEXT PRIMARY KEY,
          sort_order INTEGER NOT NULL
        )
      ''');
    }
    if (oldVersion < 7) {
      // Version 7: favorites 테이블 추가 (즐겨찾기 영상)
      await db.execute('''
        CREATE TABLE favorites (
          video_id TEXT PRIMARY KEY,
          channel_id TEXT NOT NULL,
          title TEXT NOT NULL,
          channel_title TEXT NOT NULL,
          description TEXT,
          thumbnail_url TEXT,
          published_at TEXT NOT NULL,
          sort_order INTEGER NOT NULL,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      await db.execute('''
        CREATE INDEX idx_favorites_sort_order ON favorites(sort_order)
      ''');
    }
    if (oldVersion < 8) {
      // Version 8: playlists 테이블 추가 (재생목록 캐시)
      await db.execute('''
        CREATE TABLE playlists (
          id TEXT PRIMARY KEY,
          title TEXT NOT NULL,
          description TEXT,
          thumbnail_url TEXT,
          item_count INTEGER NOT NULL,
          published_at TEXT,
          cached_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');
    }
  }

  // ========== Channels CRUD ==========

  Future<List<Channel>> getAllChannels() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'channels',
      where: 'is_subscribed = ?',
      whereArgs: [1],
      orderBy: 'sort_order ASC',
    );
    return maps.map((map) => Channel.fromDatabase(map)).toList();
  }

  /// 모든 채널 조회 (구독 여부와 관계없이)
  Future<List<Channel>> getAllChannelsIncludingUnsubscribed() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'channels',
      orderBy: 'sort_order ASC',
    );
    return maps.map((map) => Channel.fromDatabase(map)).toList();
  }

  Future<Channel?> getChannelById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'channels',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return Channel.fromDatabase(maps.first);
  }

  Future<void> insertChannel(Channel channel) async {
    final db = await database;
    await db.insert(
      'channels',
      Channel.toDatabase(channel),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertChannels(List<Channel> channels) async {
    final db = await database;
    final batch = db.batch();

    // 기존 채널 ID 목록 가져오기 (구독 해지된 채널 포함, 재구독 시 중복 방지)
    final allExistingMaps = await db.query('channels');
    final allExisting = allExistingMaps.map((map) => Channel.fromDatabase(map)).toList();
    final existingIds = {for (var c in allExisting) c.id};
    final existingSortOrders = {for (var c in allExisting) c.id: c.sortOrder};

    // 현재 구독 중인 채널 수 (신규 채널 sort_order 계산용)
    final subscribedChannels = await getAllChannels();
    final subscribedCount = subscribedChannels.length;

    for (final channel in channels) {
      if (existingIds.contains(channel.id)) {
        // 기존 채널: sortOrder 유지하고 나머지 정보만 업데이트 (재구독 시 is_subscribed = 1로 복원)
        final channelData = Channel.toDatabase(channel);
        channelData['sort_order'] = existingSortOrders[channel.id]; // 기존 순서 유지
        channelData['is_subscribed'] = 1; // 재구독 시 활성화

        batch.update(
          'channels',
          channelData,
          where: 'id = ?',
          whereArgs: [channel.id],
        );
      } else {
        // 신규 채널: 맨 뒤에 추가
        final channelData = Channel.toDatabase(channel);
        channelData['sort_order'] = subscribedCount + channels.indexOf(channel);
        channelData['is_subscribed'] = 1; // 신규 구독 채널 활성화

        batch.insert(
          'channels',
          channelData,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }
    await batch.commit(noResult: true);
  }

  Future<void> updateChannel(Channel channel) async {
    final db = await database;
    await db.update(
      'channels',
      Channel.toDatabase(channel),
      where: 'id = ?',
      whereArgs: [channel.id],
    );
  }

  Future<void> deleteChannel(String id) async {
    final db = await database;
    await db.delete(
      'channels',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateChannelsSortOrder(List<Channel> channels) async {
    final db = await database;
    final batch = db.batch();
    for (int i = 0; i < channels.length; i++) {
      batch.update(
        'channels',
        {'sort_order': i},
        where: 'id = ?',
        whereArgs: [channels[i].id],
      );
    }
    await batch.commit(noResult: true);
  }

  /// 특정 채널의 정렬 순서 업데이트
  Future<void> updateChannelSortOrder(String channelId, int sortOrder) async {
    final db = await database;
    await db.update(
      'channels',
      {'sort_order': sortOrder},
      where: 'id = ?',
      whereArgs: [channelId],
    );
  }

  /// 채널 구독 상태 업데이트
  Future<void> updateChannelSubscriptionStatus(
      String channelId, bool isSubscribed) async {
    final db = await database;
    await db.update(
      'channels',
      {'is_subscribed': isSubscribed ? 1 : 0},
      where: 'id = ?',
      whereArgs: [channelId],
    );
  }

  /// 채널 기본 섹션 업데이트
  Future<void> updateChannelDefaultSection(
      String channelId, String? section) async {
    final db = await database;
    await db.update(
      'channels',
      {'default_section': section},
      where: 'id = ?',
      whereArgs: [channelId],
    );
  }

  // ========== Collections CRUD ==========

  Future<List<Collection>> getAllCollections() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'collections',
      orderBy: 'display_order ASC',
    );
    return maps.map((map) => Collection.fromDatabase(map)).toList();
  }

  Future<Collection?> getCollectionById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'collections',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return Collection.fromDatabase(maps.first);
  }

  Future<void> insertCollection(Collection collection) async {
    final db = await database;
    await db.insert(
      'collections',
      Collection.toDatabase(collection),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateCollection(Collection collection) async {
    final db = await database;
    await db.update(
      'collections',
      Collection.toDatabase(collection),
      where: 'id = ?',
      whereArgs: [collection.id],
    );
  }

  Future<void> deleteCollection(String id) async {
    final db = await database;
    await db.delete(
      'collections',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateCollectionDisplayOrder(
      List<Collection> collections) async {
    final db = await database;
    final batch = db.batch();
    for (int i = 0; i < collections.length; i++) {
      batch.update(
        'collections',
        {'display_order': i},
        where: 'id = ?',
        whereArgs: [collections[i].id],
      );
    }
    await batch.commit(noResult: true);
  }

  // ========== Channel-Collection Mapping ==========

  Future<List<String>> getCollectionIdsForChannel(String channelId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'channel_collections',
      columns: ['collection_id'],
      where: 'channel_id = ?',
      whereArgs: [channelId],
    );
    return maps.map((map) => map['collection_id'] as String).toList();
  }

  Future<List<Channel>> getChannelsInCollection(String collectionId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT c.* FROM channels c
      INNER JOIN channel_collections cc ON c.id = cc.channel_id
      LEFT JOIN collection_orders co ON cc.collection_id = co.collection_id AND c.id = co.channel_id
      WHERE cc.collection_id = ?
      ORDER BY COALESCE(co.sort_order, c.sort_order) ASC
    ''', [collectionId]);
    return maps.map((map) => Channel.fromDatabase(map)).toList();
  }

  Future<void> addChannelToCollection(
      String channelId, String collectionId) async {
    final db = await database;
    await db.insert(
      'channel_collections',
      {
        'channel_id': channelId,
        'collection_id': collectionId,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> removeChannelFromCollection(
      String channelId, String collectionId) async {
    final db = await database;
    await db.delete(
      'channel_collections',
      where: 'channel_id = ? AND collection_id = ?',
      whereArgs: [channelId, collectionId],
    );
  }

  // ========== Collection Orders ==========

  Future<void> updateCollectionChannelOrder(
      String collectionId, List<Channel> channels) async {
    final db = await database;
    final batch = db.batch();

    // 기존 순서 삭제
    batch.delete(
      'collection_orders',
      where: 'collection_id = ?',
      whereArgs: [collectionId],
    );

    // 새 순서 삽입
    for (int i = 0; i < channels.length; i++) {
      batch.insert(
        'collection_orders',
        {
          'collection_id': collectionId,
          'channel_id': channels[i].id,
          'sort_order': i,
        },
      );
    }

    await batch.commit(noResult: true);
  }

  /// 특정 컬렉션의 특정 채널 정렬 순서 업데이트
  Future<void> updateCollectionChannelSortOrder(
      String collectionId, String channelId, int sortOrder) async {
    final db = await database;

    // collection_orders에 이미 존재하는지 확인
    final existing = await db.query(
      'collection_orders',
      where: 'collection_id = ? AND channel_id = ?',
      whereArgs: [collectionId, channelId],
    );

    if (existing.isEmpty) {
      // 존재하지 않으면 삽입
      await db.insert(
        'collection_orders',
        {
          'collection_id': collectionId,
          'channel_id': channelId,
          'sort_order': sortOrder,
        },
      );
    } else {
      // 존재하면 업데이트
      await db.update(
        'collection_orders',
        {'sort_order': sortOrder},
        where: 'collection_id = ? AND channel_id = ?',
        whereArgs: [collectionId, channelId],
      );
    }
  }

  // ========== Utility ==========

  Future<int> getChannelCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM channels');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> getCollectionChannelCount(String collectionId) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM channel_collections WHERE collection_id = ?',
      [collectionId],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  // ========== Videos CRUD ==========

  /// 영상 목록 저장 (기존 영상은 삭제하고 새로 삽입)
  Future<void> cacheVideos(List<Video> videos, String cacheKey) async {
    final db = await database;
    final batch = db.batch();

    // 기존 영상 삭제 (전체 또는 특정 채널들의 영상만)
    if (cacheKey == 'all') {
      batch.delete('videos');
    } else {
      // 컬렉션별 캐시인 경우, 해당 컬렉션의 채널 영상만 삭제
      final channelIds = videos.map((v) => v.channelId).toSet().toList();
      for (final channelId in channelIds) {
        batch.delete('videos', where: 'channel_id = ?', whereArgs: [channelId]);
      }
    }

    // 새 영상 삽입
    for (final video in videos) {
      batch.insert('videos', Video.toDatabase(video), conflictAlgorithm: ConflictAlgorithm.replace);
    }

    // 캐시 메타데이터 업데이트
    batch.insert(
      'video_cache_metadata',
      {
        'cache_key': cacheKey,
        'last_fetched_at': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await batch.commit(noResult: true);
  }

  /// 캐시된 영상 목록 가져오기 (전체)
  Future<List<Video>> getCachedVideos() async {
    final db = await database;
    final maps = await db.query(
      'videos',
      orderBy: 'published_at DESC',
    );
    return maps.map((map) => Video.fromDatabase(map)).toList();
  }

  /// 캐시된 영상 목록 가져오기 (특정 채널들)
  Future<List<Video>> getCachedVideosForChannels(List<String> channelIds) async {
    if (channelIds.isEmpty) return [];

    final db = await database;
    final placeholders = List.filled(channelIds.length, '?').join(',');
    final maps = await db.query(
      'videos',
      where: 'channel_id IN ($placeholders)',
      whereArgs: channelIds,
      orderBy: 'published_at DESC',
    );
    return maps.map((map) => Video.fromDatabase(map)).toList();
  }

  /// 캐시가 유효한지 확인 (6시간 이내)
  Future<bool> isVideoCacheValid(String cacheKey, {Duration validDuration = const Duration(hours: 6)}) async {
    final db = await database;
    final maps = await db.query(
      'video_cache_metadata',
      where: 'cache_key = ?',
      whereArgs: [cacheKey],
    );

    if (maps.isEmpty) return false;

    final lastFetchedAt = DateTime.parse(maps.first['last_fetched_at'] as String);
    final now = DateTime.now();
    return now.difference(lastFetchedAt) < validDuration;
  }

  /// 캐시 초기화 (영상 데이터 삭제)
  Future<void> clearVideoCache() async {
    final db = await database;
    await db.delete('videos');
    await db.delete('video_cache_metadata');
  }

  Future<void> clearAllData() async {
    final db = await database;
    await db.delete('channels');
    await db.delete('collections');
    await db.delete('channel_collections');
    await db.delete('collection_orders');
    await db.delete('videos');
    await db.delete('video_cache_metadata');
    await db.delete('playlist_orders');
    await db.delete('favorites');
  }

  // ========== Playlist Orders ==========

  /// 재생목록 정렬 순서 가져오기
  Future<Map<String, int>> getPlaylistOrders() async {
    final db = await database;
    final maps = await db.query('playlist_orders');
    return {for (var map in maps) map['playlist_id'] as String: map['sort_order'] as int};
  }

  /// 재생목록 정렬 순서 저장
  Future<void> savePlaylistOrder(String playlistId, int sortOrder) async {
    final db = await database;
    await db.insert(
      'playlist_orders',
      {'playlist_id': playlistId, 'sort_order': sortOrder},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// 재생목록 정렬 순서 일괄 저장
  Future<void> savePlaylistOrders(Map<String, int> orders) async {
    final db = await database;
    final batch = db.batch();

    // 기존 데이터 삭제
    batch.delete('playlist_orders');

    // 새 데이터 삽입
    for (final entry in orders.entries) {
      batch.insert('playlist_orders', {
        'playlist_id': entry.key,
        'sort_order': entry.value,
      });
    }

    await batch.commit(noResult: true);
  }

  /// 삭제된 재생목록 정렬 데이터 정리
  Future<void> cleanupPlaylistOrders(List<String> validPlaylistIds) async {
    final db = await database;
    if (validPlaylistIds.isEmpty) {
      await db.delete('playlist_orders');
      return;
    }
    final placeholders = List.filled(validPlaylistIds.length, '?').join(',');
    await db.delete(
      'playlist_orders',
      where: 'playlist_id NOT IN ($placeholders)',
      whereArgs: validPlaylistIds,
    );
  }

  // ========== Playlists Cache ==========

  /// 캐시된 재생목록 조회
  Future<List<Playlist>> getCachedPlaylists() async {
    final db = await database;
    final maps = await db.query('playlists');
    return maps.map((map) => Playlist(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String?,
      thumbnailUrl: map['thumbnail_url'] as String?,
      itemCount: map['item_count'] as int,
      publishedAt: map['published_at'] != null
          ? DateTime.parse(map['published_at'] as String)
          : null,
    )).toList();
  }

  /// 재생목록 캐시 저장
  Future<void> cachePlaylists(List<Playlist> playlists) async {
    final db = await database;
    final batch = db.batch();

    // 기존 캐시 삭제
    batch.delete('playlists');

    // 새 데이터 삽입
    for (final playlist in playlists) {
      batch.insert('playlists', {
        'id': playlist.id,
        'title': playlist.title,
        'description': playlist.description,
        'thumbnail_url': playlist.thumbnailUrl,
        'item_count': playlist.itemCount,
        'published_at': playlist.publishedAt?.toIso8601String(),
      });
    }

    await batch.commit(noResult: true);
  }

  /// 재생목록 캐시 삭제
  Future<void> clearPlaylistsCache() async {
    final db = await database;
    await db.delete('playlists');
  }

  // ========== Favorites CRUD ==========

  /// 즐겨찾기 목록 가져오기
  Future<List<FavoriteVideo>> getAllFavorites() async {
    final db = await database;
    final maps = await db.query(
      'favorites',
      orderBy: 'sort_order ASC',
    );
    return maps.map((map) => FavoriteVideo.fromDatabase(map)).toList();
  }

  /// 즐겨찾기 여부 확인
  Future<bool> isFavorite(String videoId) async {
    final db = await database;
    final maps = await db.query(
      'favorites',
      where: 'video_id = ?',
      whereArgs: [videoId],
    );
    return maps.isNotEmpty;
  }

  /// 즐겨찾기 추가 (맨 위에 추가)
  Future<void> addFavorite(FavoriteVideo favorite) async {
    final db = await database;

    // 기존 모든 즐겨찾기의 sort_order를 1씩 증가
    await db.rawUpdate('UPDATE favorites SET sort_order = sort_order + 1');

    // 새 즐겨찾기를 맨 위(sort_order = 0)에 추가
    final favoriteWithOrder = favorite.copyWith(sortOrder: 0);

    await db.insert(
      'favorites',
      FavoriteVideo.toDatabase(favoriteWithOrder),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// 즐겨찾기 추가 (복원용 - 순서 유지)
  Future<void> addFavoriteForRestore(FavoriteVideo favorite) async {
    final db = await database;
    await db.insert(
      'favorites',
      FavoriteVideo.toDatabase(favorite),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// 즐겨찾기 삭제
  Future<void> removeFavorite(String videoId) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'video_id = ?',
      whereArgs: [videoId],
    );
  }

  /// 즐겨찾기 순서 업데이트
  Future<void> updateFavoritesSortOrder(List<FavoriteVideo> favorites) async {
    final db = await database;
    final batch = db.batch();
    for (int i = 0; i < favorites.length; i++) {
      batch.update(
        'favorites',
        {'sort_order': i},
        where: 'video_id = ?',
        whereArgs: [favorites[i].videoId],
      );
    }
    await batch.commit(noResult: true);
  }

  /// 즐겨찾기 개수 가져오기
  Future<int> getFavoritesCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM favorites');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
    _currentUserEmail = null;
  }
}
