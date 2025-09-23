import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping/app/core/cache_manager.dart';

class HttpProvider with CacheManager {
  final Dio httpClient;

  HttpProvider({required this.httpClient});

  Future<Response> doPost(String url, dynamic data) {
    var endpoint = dotenv.env['BASEURL'].toString() + url;
    return httpClient.post(
      endpoint,
      data: data,
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
  }

  Future<Response> doPostFile(String url, dynamic data) {
    var endpoint = dotenv.env['BASEURL'].toString() + url;
    return httpClient.post(
      endpoint,
      data: data,
    );
  }

  Future<Response> doGetMap(String url, String data) {
    var endpoint = dotenv.env['URLGOONG'].toString() +
        url +
        'api_key=${dotenv.env['KEYGOONG']}';
    return httpClient.get(
      endpoint + data,
    );
  }
}
