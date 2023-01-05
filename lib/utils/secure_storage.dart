import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _accessToken = 'access_token';
  static const _refreshToken = 'refresh_token';

  // Save access token and refresh token
  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _accessToken, value: accessToken);
    await _storage.write(key: _refreshToken, value: refreshToken);
  }

  // Get access token
  static Future<String?> getAccessToken() async {
    return _storage.read(key: _accessToken);
  }

  // Get refresh token
  static Future<String?> getRefreshToken() async {
    return _storage.read(key: _refreshToken);
  }

  // Delete access token and refresh token
  static Future<void> deleteTokens() async {
    await _storage.delete(key: _accessToken);
    await _storage.delete(key: _refreshToken);
  }
}
