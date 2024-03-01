// ignore_for_file: file_names

abstract class BaseApiService {
  final String baseUrl = "http://"; //LOCAL
  Future<dynamic> get(String url);

  Future<dynamic> post(String url,
      {Map<String, dynamic>? data = const {}, type});

  Future<dynamic> put(
    String url, {
    Map<String, dynamic>? data = const {},
  });
}
