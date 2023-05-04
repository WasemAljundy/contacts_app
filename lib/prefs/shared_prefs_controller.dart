import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys {
  language,
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

  String get language => _sharedPreferences.getString(PrefKeys.language.toString()) ?? 'en';
}