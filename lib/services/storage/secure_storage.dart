import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // Create secure storage instance
  final _storage = const FlutterSecureStorage();

  static const _tokenKey = '!%TEWF5629536WTY#()()UTR!@#%^&*';

  /// Save token securely
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> saveUsername(String username) async {
    await _storage.write(key: _tokenKey, value: username);
  }

  Future<void> saveUserid(String userid) async {
    await _storage.write(key: _tokenKey, value: userid);
  }

  /// Read token
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<String?> getUsername() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<String?> getUserid() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<String?> getString() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Delete token (logout)
  Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
  }
}
