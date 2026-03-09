import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import 'storage_service.dart';
import 'database_service.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: AppConfig.youtubeScopes,
  );

  final StorageService _storage = StorageService();
  final DatabaseService _db = DatabaseService();
  GoogleSignInAccount? _currentUser;
  auth.AuthClient? _authClient;

  GoogleSignInAccount? get currentUser => _currentUser;
  auth.AuthClient? get authClient => _authClient;
  bool get isSignedIn => _currentUser != null;

  /// 초기화 - 저장된 로그인 상태 확인
  Future<bool> initialize() async {
    try {
      await _googleSignIn.signInSilently();
      _currentUser = _googleSignIn.currentUser;

      if (_currentUser != null) {
        // 사용자별 DB로 전환
        await _db.setCurrentUser(_currentUser!.email);
        await _createAuthClient();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Google 로그인
  Future<bool> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) return false;

      _currentUser = account;
      // 사용자별 DB로 전환
      await _db.setCurrentUser(account.email);
      await _createAuthClient();
      await _storage.setLoggedIn(true);
      await _storage.setUserEmail(account.email);

      return true;
    } catch (error) {
      return false;
    }
  }

  /// AuthClient 생성
  Future<void> _createAuthClient() async {
    if (_currentUser == null) return;

    final authentication = await _currentUser!.authentication;
    final accessToken = authentication.accessToken;
    final idToken = authentication.idToken;

    if (accessToken == null) {
      throw Exception('Failed to get access token');
    }

    // 토큰 저장
    await _storage.saveAccessToken(accessToken);
    if (idToken != null) {
      await _storage.saveRefreshToken(idToken);
    }

    // AuthClient 생성
    final credentials = auth.AccessCredentials(
      auth.AccessToken(
        'Bearer',
        accessToken,
        DateTime.now().toUtc().add(const Duration(hours: 1)),
      ),
      null, // refresh token은 Google Sign-In이 자동 관리
      AppConfig.youtubeScopes,
    );

    _authClient = auth.authenticatedClient(http.Client(), credentials);
  }

  /// 토큰 갱신
  Future<bool> refreshToken() async {
    try {
      if (_currentUser == null) return false;

      // Google Sign-In이 자동으로 토큰 갱신 처리
      final authentication = await _currentUser!.authentication;
      final accessToken = authentication.accessToken;

      if (accessToken == null) return false;

      await _storage.saveAccessToken(accessToken);
      await _createAuthClient();

      return true;
    } catch (e) {
      return false;
    }
  }

  /// 로그아웃
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _storage.logout();
      // DB 연결 해제
      await _db.close();
      _currentUser = null;
      _authClient?.close();
      _authClient = null;
    } catch (error) {
      // 로그아웃 에러 무시
    }
  }

  /// 연결 해제 (앱 권한 완전 취소)
  Future<void> disconnect() async {
    try {
      await _googleSignIn.disconnect();
      await _storage.logout();
      // DB 연결 해제
      await _db.close();
      _currentUser = null;
      _authClient?.close();
      _authClient = null;
    } catch (error) {
      // 연결 해제 에러 무시
    }
  }

  void dispose() {
    _authClient?.close();
  }
}
