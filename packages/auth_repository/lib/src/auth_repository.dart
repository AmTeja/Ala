// ignore_for_file: avoid_dynamic_calls

import 'dart:async';
import 'dart:convert';

import 'package:api_client/api_client.dart';
import 'package:auth_repository/src/auth_exception.dart';
import 'package:auth_repository/src/model/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Enum to represent the status of the authentication.
enum AuthenticationStatus {
  /// the status of the authentication is unknown,
  unknown,

  /// the user is authenticated.
  authenticated,

  /// the user is not authenticated.
  unauthenticated
}

/// {@template auth_repository}
/// Auth Repostiory to handle user authentication.
/// {@endtemplate}
class AuthRepository {
  /// {@macro auth_repository}
  AuthRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final _controller = StreamController<AuthenticationStatus>();

  /// Returns a [Stream] of [AuthenticationStatus].
  /// Emits [AuthenticationStatus.unknown] when the status is unknown.
  /// Emits [AuthenticationStatus.authenticated] when the user is authenticated.
  /// Emits [AuthenticationStatus.unauthenticated] when the user is not
  /// authenticated.
  Stream<AuthenticationStatus> get status async* {
    await _secureStorage.read(key: 'access_token').then((value) {
      if (value != null) {
        _controller.add(AuthenticationStatus.authenticated);
      } else {
        _controller.add(AuthenticationStatus.unauthenticated);
      }
    });
    yield* _controller.stream;
  }

  /// Returns a [User] if the user is authenticated.
  /// Returns null if the user is not authenticated.
  /// Throws a [AuthException] if an error occurs.

  Future<User?> getUser() async {
    try {
      final response = await _apiClient.get('/users/me');
      if (response.statusCode == 401) {
        _controller.add(AuthenticationStatus.unauthenticated);
        return null;
      }
      final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;
      return User.fromJson(decodedBody);
    } on Exception catch (e) {
      throw AuthException.fromException(e);
    }
  }

  /// Returns a [User] from the access token.
  Future<User> getUserFromToken({required Map<String, dynamic> claims}) async =>
      User.fromClaims(claims);

  /// Logs out the user.
  Future<void> logout() async {
    await _secureStorage.deleteAll();
  }

  /// Returns a [Map] containing the access token and refresh token if the login
  /// is successful.
  /// Returns null if the login is unsuccessful.
  /// Throws a [AuthException] if an error occurs.
  /// [username] is the username of the user.
  /// [password] is the password of the user.
  Future<Map<String, String>?> login({
    required String username,
    required String password,
  }) async {
    final data = {
      'username': username,
      'password': password,
    };
    final response = await _apiClient.post(
      '/login',
      data: data,
    );
    if (response.statusCode == 200) {
      _controller.add(AuthenticationStatus.authenticated);
      final decodedBodyData = jsonDecode(response.body) as Map<String, dynamic>;
      final accessToken = decodedBodyData['data']['access_token'].toString();
      final refreshToken = decodedBodyData['data']['refresh_token'].toString();
      return {
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };
    } else if (response.statusCode == 400) {
      _controller.add(AuthenticationStatus.unauthenticated);
      throw AuthException.fromException(
        Exception(
          (jsonDecode(response.body) as Map<String, dynamic>)['message']
              as String,
        ),
      );
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
      throw AuthException.fromException(Exception('Unknown Error'));
    }
  }

  /// Signs up a user.
  Future<void> signUp({
    required String username,
    required String password,
    required String email,
    required String bio,
    required String avatar,
  }) async {
    final data = {
      'username': username,
      'password': password,
      'email': email,
      'bio': bio,
      'avatar': avatar,
    };
    print(data);
    final response = await _apiClient.post(
      '/register',
      data: data,
    );
    if (response.statusCode == 201) {
      return;
    } else if (response.statusCode == 400) {
      print(response.body);
      throw AuthException.fromException(
        Exception(
          (jsonDecode(response.body) as Map<String, dynamic>)['message']
              as String,
        ),
      );
    } else {
      throw AuthException.fromException(Exception('Unknown Error'));
    }
  }

  ///Refresh the access token.
  Future<void> refreshToken() async {
    final refreshToken = await _secureStorage.read(key: 'refresh_token');
    final data = {
      'refresh_token': refreshToken,
    };
    final response = await _apiClient.post(
      '/refresh',
      data: data,
    );
    final accessToken = jsonDecode(response.body)['data']['access_token'];
    await _secureStorage.write(
      key: 'access_token',
      value: accessToken.toString(),
    );
  }

  /// Disposes of the [_controller].
  void dispose() {
    _controller.close();
  }
}
