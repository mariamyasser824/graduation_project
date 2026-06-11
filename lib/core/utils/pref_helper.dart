import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static const String _accessTokenKey = "access_token";
  static const String _refreshTokenKey = "refresh_token";
  static const String _hasChildKey = "has_child";
  static const String _userTypeKey = "user_type";
  static const String _userIdKey = "user_id";
  static const String _onBoardingKey = "onboarding_seen";
  static const String _childIdKey = "child_id";

  /// Save Access
  static Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
  }

  /// Save Refresh
  static Future<void> saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, token);
  }

  /// Get Access
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  /// Get Refresh
  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  /// Clear All
  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
  }

  static Future<void> saveUserType(String type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userTypeKey, type);
  }

  static Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTypeKey);
  }

  //
  static Future<void> saveUserId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, id);
  }

  /// Save hasChild Flag

  static Future<void> saveChildId(String? id) async {
    final prefs = await SharedPreferences.getInstance();
    if (id != null && id.isNotEmpty) {
      await prefs.setString(_childIdKey, id);
    } else {
      await prefs.remove(_childIdKey);
    }
  }

  static Future<String?> getChildId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_childIdKey);
  }

  //
  static Future<void> setOnBoardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onBoardingKey, true);
  }

  static Future<bool> getOnBoardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onBoardingKey) ?? false;
  }
}
