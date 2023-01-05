import 'dart:convert';

import 'package:api_client/src/config/api_config.dart';
import 'package:http/http.dart' as http;

/// {@template api_client}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class ApiClient {
  /// {@macro api_client}

  ApiClient({required ApiConfig config})
      : _config = config,
        _client = http.Client();

  final ApiConfig _config;
  final http.Client _client;

  /// Returns a [http.Response].
  /// [path] is the path of the API.
  Future<http.Response> get(String path, {String? accessToken}) async {
    final response = await _client.get(
      Uri.parse('${_config.baseUrl}$path'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${accessToken ?? _config.accessToken}'
      },
    );
    return response;
  }

  /// Returns a [http.Response].
  /// [path] is the path of the API.
  /// [data] is the data to be sent to the API.
  Future<http.Response> post(
    String path, {
    String? accessToken,
    required Map<String, dynamic> data,
  }) async {
    final response = await _client.post(
      Uri.parse('${_config.baseUrl}$path'),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_config.accessToken}'
      },
    );
    return response;
  }
}
