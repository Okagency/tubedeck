import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/collection.dart';
import '../services/database_service.dart';
import 'channels_provider.dart';

final collectionsProvider =
    StateNotifierProvider<CollectionsNotifier, CollectionsState>((ref) {
  return CollectionsNotifier(ref.read(databaseServiceProvider));
});

class CollectionsState {
  final List<Collection> collections;
  final bool isLoading;
  final String? errorMessage;

  CollectionsState({
    this.collections = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  CollectionsState copyWith({
    List<Collection>? collections,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CollectionsState(
      collections: collections ?? this.collections,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class CollectionsNotifier extends StateNotifier<CollectionsState> {
  final DatabaseService _db;
  final _uuid = const Uuid();

  CollectionsNotifier(this._db) : super(CollectionsState());

  /// 컬렉션 목록 로드
  Future<void> loadCollections() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final collections = await _db.getAllCollections();
      state = state.copyWith(
        collections: collections,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 컬렉션 생성
  Future<void> createCollection(String name, int colorCode) async {
    try {
      final collection = Collection(
        id: _uuid.v4(),
        name: name,
        colorCode: colorCode,
        displayOrder: state.collections.length,
        createdAt: DateTime.now(),
      );

      await _db.insertCollection(collection);

      final collections = [...state.collections, collection];
      state = state.copyWith(collections: collections);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// 컬렉션 수정
  Future<void> updateCollection(
      String id, String name, int colorCode) async {
    try {
      final collection = state.collections.firstWhere((c) => c.id == id);
      final updated = collection.copyWith(
        name: name,
        colorCode: colorCode,
      );

      await _db.updateCollection(updated);

      final collections = state.collections.map((c) {
        return c.id == id ? updated : c;
      }).toList();

      state = state.copyWith(collections: collections);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// 컬렉션 삭제
  Future<void> deleteCollection(String id) async {
    try {
      await _db.deleteCollection(id);

      final collections = state.collections.where((c) => c.id != id).toList();
      state = state.copyWith(collections: collections);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// 컬렉션 순서 변경
  Future<void> reorderCollections(int oldIndex, int newIndex) async {
    final collections = List<Collection>.from(state.collections);

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final collection = collections.removeAt(oldIndex);
    collections.insert(newIndex, collection);

    // 즉시 UI 업데이트
    state = state.copyWith(collections: collections);

    // DB 업데이트
    try {
      await _db.updateCollectionDisplayOrder(collections);
    } catch (e) {
      // 실패 시 원래 상태로 복구
      await loadCollections();
    }
  }

  /// 컬렉션의 채널 수 가져오기
  Future<int> getChannelCount(String collectionId) async {
    try {
      return await _db.getCollectionChannelCount(collectionId);
    } catch (e) {
      return 0;
    }
  }

  /// 상태 초기화 (로그아웃 시)
  void clear() {
    state = CollectionsState();
  }
}
