import 'package:database_flutter/database/db_controller.dart';
import 'package:database_flutter/get/language_getx_controller.dart';
import 'package:database_flutter/prefs/shared_prefs_controller.dart';
import 'package:database_flutter/screens/create_contact_screen.dart';
import 'package:database_flutter/screens/launch_screen.dart';
import 'package:database_flutter/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPref();
  await DbController().initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  final LanguageGetxController _languageGetxController =
      Get.put<LanguageGetxController>(LanguageGetxController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(_languageGetxController.language.value),
        initialRoute: '/launch_screen',
        routes: {
          '/launch_screen': (context) => const LaunchScreen(),
          '/main_screen': (context) => const MainScreen(),
          '/create_contact_screen': (context) => const CreateContactScreen(),
        },
      );
    });
  }
}
