import 'package:shared_preferences/shared_preferences.dart';

class ConfigHostApi {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  Future<void> saveHost(String host, int port) async {
    await prefs.setString('host', host);
    await prefs.setInt('port', port);
  }

  Future<String> getHost() async {
    return await prefs.getString('host') ?? 'http://';
  }

  Future<int> getPort() async {
    return await prefs.getInt('port') ?? 8080;
  }
}
