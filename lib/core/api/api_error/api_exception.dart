import 'package:http/http.dart';

class ApiServerException implements Exception {
  Response? response;
  ApiServerException({
    this.response,
  });
}

class EmptyApiCacheException implements Exception {}

class OfflineApiException implements Exception {}
