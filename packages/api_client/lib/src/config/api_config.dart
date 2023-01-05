///{@template api_config}
/// Template for the API configuration.
/// {@endtemplate}
class ApiConfig {
  /// Creates a new instance of [ApiConfig].
  /// [baseUrl] is the base URL for the API.
  /// [accessToken] is the access token for the API.
  /// [refreshToken] is the refresh token for the API.
  /// {@macro api_config}
  factory ApiConfig.custom({
    required String baseUrl,
    String? accessToken,
    String? refreshToken,
  }) {
    _instance.baseUrl = baseUrl;
    _instance.accessToken = accessToken;
    _instance.refreshToken = refreshToken;
    return _instance;
  }
  ApiConfig._internal();

  static final ApiConfig _instance = ApiConfig._internal();

  /// {@macro api_config}
  factory ApiConfig() {
    return _instance;
  }

  /// The base URL for the API.
  String baseUrl = 'http://localhost:3000';

  /// The access token for the API.
  String? accessToken;

  /// The refresh token for the API.
  String? refreshToken;
}
