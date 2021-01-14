import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile.dart';
import '../models/cacheConfig.dart';
import 'dart:convert';
import '../service/cache.dart';
import '../service/request.dart';

class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();
  static bool get isRelease => bool.fromEnvironment('dart.vm.product');
  static NetCache netCache = NetCache();
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString('profile');
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxCount = 100
      ..maxAge = 3600;
    Request.init();
  }

  static saveProfile() =>
      _prefs.setString('profile', jsonEncode(profile.toJson()));
}
