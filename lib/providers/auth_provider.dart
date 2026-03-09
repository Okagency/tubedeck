import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import '../services/youtube_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final youtubeServiceProvider = Provider<YouTubeService>((ref) {
  return YouTubeService();
});

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.read(authServiceProvider),
    ref.read(youtubeServiceProvider),
  );
});

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? userEmail;
  final String? errorMessage;

  AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.userEmail,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    String? userEmail,
    String? errorMessage,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      userEmail: userEmail ?? this.userEmail,
      errorMessage: errorMessage,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;
  final YouTubeService _youtubeService;

  AuthNotifier(this._authService, this._youtubeService) : super(AuthState());

  Future<void> initialize() async {
    state = state.copyWith(isLoading: true);

    try {
      final isSignedIn = await _authService.initialize();

      if (isSignedIn && _authService.authClient != null) {
        _youtubeService.setAuthClient(_authService.authClient!);
        state = state.copyWith(
          isAuthenticated: true,
          isLoading: false,
          userEmail: _authService.currentUser?.email,
        );
      } else {
        state = state.copyWith(
          isAuthenticated: false,
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isAuthenticated: false,
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<bool> signIn() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final success = await _authService.signIn();

      if (success && _authService.authClient != null) {
        _youtubeService.setAuthClient(_authService.authClient!);
        state = state.copyWith(
          isAuthenticated: true,
          isLoading: false,
          userEmail: _authService.currentUser?.email,
        );
        return true;
      } else {
        state = state.copyWith(
          isAuthenticated: false,
          isLoading: false,
          errorMessage: '로그인에 실패했습니다.',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isAuthenticated: false,
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _youtubeService.dispose();
    state = AuthState();
  }

  /// 토큰 갱신 및 YouTubeService 업데이트
  Future<bool> refreshTokenAndUpdateClient() async {
    try {
      final success = await _authService.refreshToken();
      if (success && _authService.authClient != null) {
        _youtubeService.setAuthClient(_authService.authClient!);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    _authService.dispose();
    _youtubeService.dispose();
    super.dispose();
  }
}
