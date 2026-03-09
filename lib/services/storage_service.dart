import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../utils/constants.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  SharedPreferences? _prefs;
  final _secureStorage = const FlutterSecureStorage();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ========== SharedPreferences ==========

  Future<bool> setString(String key, String value) async {
    return await _prefs!.setString(key, value);
  }

  String? getString(String key) {
    return _prefs!.getString(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs!.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs!.getBool(key);
  }

  Future<bool> setInt(String key, int value) async {
    return await _prefs!.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs!.getInt(key);
  }

  Future<bool> remove(String key) async {
    return await _prefs!.remove(key);
  }

  Future<bool> clear() async {
    return await _prefs!.clear();
  }

  // ========== Secure Storage ==========

  Future<void> writeSecure(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> readSecure(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> deleteSecure(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> clearSecure() async {
    await _secureStorage.deleteAll();
  }

  // ========== Auth Token Management ==========

  Future<void> saveAccessToken(String token) async {
    await writeSecure(Constants.keyAccessToken, token);
  }

  Future<String?> getAccessToken() async {
    return await readSecure(Constants.keyAccessToken);
  }

  Future<void> saveRefreshToken(String token) async {
    await writeSecure(Constants.keyRefreshToken, token);
  }

  Future<String?> getRefreshToken() async {
    return await readSecure(Constants.keyRefreshToken);
  }

  Future<void> saveTokenExpiry(DateTime expiry) async {
    await writeSecure(Constants.keyTokenExpiry, expiry.toIso8601String());
  }

  Future<DateTime?> getTokenExpiry() async {
    final expiryStr = await readSecure(Constants.keyTokenExpiry);
    if (expiryStr == null) return null;
    return DateTime.tryParse(expiryStr);
  }

  Future<void> clearTokens() async {
    await deleteSecure(Constants.keyAccessToken);
    await deleteSecure(Constants.keyRefreshToken);
    await deleteSecure(Constants.keyTokenExpiry);
  }

  // ========== User Settings ==========

  Future<void> setLoggedIn(bool value) async {
    await setBool(Constants.keyIsLoggedIn, value);
  }

  bool isLoggedIn() {
    return getBool(Constants.keyIsLoggedIn) ?? false;
  }

  Future<void> setUserEmail(String email) async {
    await setString(Constants.keyUserEmail, email);
  }

  String? getUserEmail() {
    return getString(Constants.keyUserEmail);
  }

  Future<void> setThemeMode(String mode) async {
    await setString(Constants.keyThemeMode, mode);
  }

  String getThemeMode() {
    return getString(Constants.keyThemeMode) ?? 'system';
  }

  Future<void> setAutoRefreshInterval(String interval) async {
    await setString(Constants.keyAutoRefreshInterval, interval);
  }

  String getAutoRefreshInterval() {
    return getString(Constants.keyAutoRefreshInterval) ?? 'threeHours';
  }

  Future<void> setLastSyncTime(DateTime time) async {
    await setString(Constants.keyLastSyncTime, time.toIso8601String());
  }

  DateTime? getLastSyncTime() {
    final timeStr = getString(Constants.keyLastSyncTime);
    if (timeStr == null) return null;
    return DateTime.tryParse(timeStr);
  }

  // ========== Logout ==========

  Future<void> logout() async {
    await clearTokens();
    await setLoggedIn(false);
    await remove(Constants.keyUserEmail);
  }
}
