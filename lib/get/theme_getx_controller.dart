import 'package:database_flutter/prefs/shared_prefs_controller.dart';
import 'package:get/get.dart';

class ThemeGetxController extends GetxController {

  static ThemeGetxController get to => Get.find<ThemeGetxController>();
  RxBool darkTheme = false.obs;

  @override
  void onInit() {
    darkTheme.value = SharedPrefController().darkTheme;
    super.onInit();
  }


  void changeTheme() {
    darkTheme.value = darkTheme.value == false ? true : false;
    SharedPrefController().changeTheme(darkTheme: darkTheme.value);
  }
}