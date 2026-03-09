import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/favorite_video.dart';
import '../services/database_service.dart';
import 'channels_provider.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, FavoritesState>((ref) {
  return FavoritesNotifier(ref.read(databaseServiceProvider));
});

class FavoritesState {
  final List<FavoriteVideo> favorites;
  final bool isLoading;
  final String? errorMessage;

  FavoritesState({
    this.favorites = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  FavoritesState copyWith({
    List<FavoriteVideo>? favorites,
    bool? isLoading,
    String? errorMessage,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class FavoritesNotifier extends StateNotifier<FavoritesState> {
  final DatabaseService _db;

  FavoritesNotifier(this._db) : super(FavoritesState());

  /// 즐겨찾기 로드
  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final favorites = await _db.getAllFavorites();
      state = state.copyWith(favorites: favorites, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 즐겨찾기 여부 확인
  Future<bool> isFavorite(String videoId) async {
    return await _db.isFavorite(videoId);
  }

  /// 즐겨찾기 추가
  Future<void> addFavorite({
    required String videoId,
    required String channelId,
    required String title,
    required String channelTitle,
    String? description,
    String? thumbnailUrl,
    required DateTime publishedAt,
  }) async {
    try {
      final favorite = FavoriteVideo(
        videoId: videoId,
        channelId: channelId,
        title: title,
        channelTitle: channelTitle,
        description: description,
        thumbnailUrl: thumbnailUrl,
        publishedAt: publishedAt,
        sortOrder: 0, // DB에서 자동으로 설정됨
        createdAt: DateTime.now(),
      );

      await _db.addFavorite(favorite);
      await loadFavorites();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// 즐겨찾기 삭제
  Future<void> removeFavorite(String videoId) async {
    try {
      await _db.removeFavorite(videoId);
      await loadFavorites();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// 즐겨찾기 토글
  Future<bool> toggleFavorite({
    required String videoId,
    required String channelId,
    required String title,
    required String channelTitle,
    String? description,
    String? thumbnailUrl,
    required DateTime publishedAt,
  }) async {
    final isFav = await isFavorite(videoId);
    if (isFav) {
      await removeFavorite(videoId);
      return false;
    } else {
      await addFavorite(
        videoId: videoId,
        channelId: channelId,
        title: title,
        channelTitle: channelTitle,
        description: description,
        thumbnailUrl: thumbnailUrl,
        publishedAt: publishedAt,
      );
      return true;
    }
  }

  /// 순서 변경
  Future<void> reorderFavorites(int oldIndex, int newIndex) async {
    try {
      final favorites = List<FavoriteVideo>.from(state.favorites);

      if (newIndex > oldIndex) {
        newIndex -= 1;
      }

      final item = favorites.removeAt(oldIndex);
      favorites.insert(newIndex, item);

      state = state.copyWith(favorites: favorites);
      await _db.updateFavoritesSortOrder(favorites);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// 상태 초기화 (로그아웃 시)
  void clear() {
    state = FavoritesState();
  }
}
