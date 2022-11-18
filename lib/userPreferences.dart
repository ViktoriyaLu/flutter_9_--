import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  //переменная для сохранения preferences
  static SharedPreferences? _preferences;

  //ключ для текстового поля
  var _keyUsername = 'username';
  var _keyPassword = "password";

  //инициализация preferences
  Future init() async => _preferences = await SharedPreferences.getInstance();

  // задаем username   нашему ключу
  Future setUsername(String username) async =>
      await _preferences?.setString(_keyUsername, username);
  Future setPassword(String password) async =>
      await _preferences?.setString(_keyUsername, password);

  //читае наш username, password
  String? getUsername() => _preferences?.getString(_keyUsername);
  String? getPassword() => _preferences?.getString(_keyPassword);

  //удаляем наш username, password
  Future<bool>? deleteUsername() => _preferences?.remove(_keyUsername);
  Future<bool>? deletePassword() => _preferences?.remove(_keyPassword);
}
