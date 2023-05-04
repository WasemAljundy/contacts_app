import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys {
  language, darkTheme
}
class SharedPrefController {

  static final SharedPrefController _instance = SharedPrefController._internal();
  late SharedPreferences _sharedPreferences;

  SharedPrefController._internal();

  factory SharedPrefController() {
    return _instance;
  }

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setLanguages({required String language}) async {
    await _sharedPreferences.setString(PrefKeys.language.toString(), language);
  }

  Future<bool> changeTheme({required bool darkTheme}) async {
    return await _sharedPreferences.setBool(PrefKeys.darkTheme.toString(), darkTheme);
  }

  bool get darkTheme => _sharedPreferences.getBool(PrefKeys.darkTheme.toString()) ?? false;

  String get language => _sharedPreferences.getString(PrefKeys.language.toString()) ?? 'en';
}