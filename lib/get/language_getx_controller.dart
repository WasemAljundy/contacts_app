import 'package:database_flutter/prefs/shared_prefs_controller.dart';
import 'package:get/get.dart';

class LanguageGetxController extends GetxController {

  static LanguageGetxController get to => Get.find<LanguageGetxController>();
  RxString language = 'en'.obs;

  @override
  void onInit() {
    language.value = SharedPrefController().language;
    super.onInit();
  }


  void changeLanguage() {
    language.value = language.value == 'en' ? 'ar' : 'en';
    SharedPrefController().setLanguages(language: language.value);
  }
}