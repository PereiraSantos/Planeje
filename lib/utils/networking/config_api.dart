import 'package:dio/dio.dart';

class ConfigApi {
  final _dio = Dio();
  String? _host;
  int? _port;

  Dio get dio => _dio;

  int? get port => _port;

  String? get host => _host;

  set host(String value) => _host = value;

  set port(int value) => _port = value;
}
