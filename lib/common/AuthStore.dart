import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStore extends ChangeNotifier {
  static SharedPreferences _preferences;

  static AuthStore _authStore;

  AuthStore._();

  static Future<AuthStore> getInstance() async {
    if (_authStore == null) {
      _preferences = await SharedPreferences.getInstance();
      _authStore = AuthStore._();
    }
    return _authStore;
  }

  bool isLoggedIn() {
    return _preferences.getBool(KEY_BOOL_LOGGED_IN);
  }

  Future setLogin(bool login) async {
    await _preferences.setBool(KEY_BOOL_LOGGED_IN, login);
    if (!login) {
      await FirebaseAuth.instance.signOut();
    }
    notifyListeners();
  }

  Future<FirebaseUser> getUser() async {
    return await FirebaseAuth.instance.currentUser();
  }

  static const String KEY_BOOL_LOGGED_IN = "login";
}
