import 'package:shared_preferences/shared_preferences.dart';


class StorageService {
  late SharedPreferences prefs;

  Future _initPref() async {
    prefs = await SharedPreferences.getInstance();
  }

   Future saveViewedWalkthrough() async {
    await _initPref();
    await prefs.setBool('walkedThrough', true);
  }

  Future<bool> getViewedWalkthrough() async {
    await _initPref();
    return prefs.getBool('walkedThrough') ?? false;
  }

  Future saveToken(String token) async {
    await _initPref();
    await prefs.setString('@token', token);
  }

  Future<String> getToken() async {
    await _initPref();
    return prefs.getString('@token') ?? '';
  }

  Future removeToken() async {
    await _initPref();
    prefs.remove('@token');
  }
}
