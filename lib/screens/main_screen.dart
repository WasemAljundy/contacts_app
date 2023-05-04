import 'package:database_flutter/get/contact_getx_controller.dart';
import 'package:database_flutter/get/language_getx_controller.dart';
import 'package:database_flutter/get/theme_getx_controller.dart';
import 'package:database_flutter/helpers/helpers.dart';
import 'package:database_flutter/screens/update_contact_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with Helpers {

  @override
  void initState() {
    super.initState();
    Get.put<ContactGetxController>(ContactGetxController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.main),
        actions: [
          IconButton(
            onPressed: () {
              ThemeGetxController.to.changeTheme();
            },
            icon: const Icon(Icons.dark_mode_outlined),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Get.delete<ContactGetxController>();
              Navigator.pushReplacementNamed(context, '/launch_screen');
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/create_contact_screen');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => LanguageGetxController.to.changeLanguage(),
        child: const Icon(Icons.language),
      ),
      body: Obx(() {
        if (ContactGetxController.to.contacts.isNotEmpty) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: ContactGetxController.to.contacts.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateContactScreen(
                        contact: ContactGetxController.to.contacts[index]),
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.contact_mail_sharp,
                  color: Colors.blue,
                  size: 32,
                ),
                title: Text(
                  ContactGetxController.to.contacts[index].name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
                subtitle: Text(ContactGetxController.to.contacts[index].phone),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async =>
                      await delete(ContactGetxController.to.contacts[index].id),
                ),
              );
            },
          );
        } else {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning,
                  size: 80,
                  color: Colors.grey.shade400,
                ),
                Text(
                  AppLocalizations.of(context)!.no_data,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Future<void> delete(int id) async {
    // bool deleted = await _contactGetxController.deleteContact(id);
    bool deleted = await ContactGetxController.to.deleteContact(id);
    String message = deleted ? 'Deleted Successfully' : 'Deleted Failed!';
    showSnackBar(context: context, message: message, error: !deleted);
  }

// Single GetX controller

// body: GetX<ContactGetxController>(
//   builder: (controller) {
//     if (controller.contacts.isNotEmpty) {
//       return ListView.builder(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         itemCount: controller.contacts.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>
//                     UpdateContactScreen(contact: controller.contacts[index]),
//               ),
//             ),
//             contentPadding: EdgeInsets.zero,
//             leading: const Icon(
//               Icons.contact_mail_sharp,
//               color: Colors.blue,
//               size: 32,
//             ),
//             title: Text(
//               controller.contacts[index].name,
//               style: const TextStyle(
//                   fontWeight: FontWeight.bold, fontSize: 17),
//             ),
//             subtitle: Text(controller.contacts[index].phone),
//             trailing: IconButton(
//               icon: const Icon(Icons.delete, color: Colors.red),
//               onPressed: () async =>
//               await delete(controller.contacts[index].id),
//             ),
//           );
//         },
//       );
//     } else {
//       return Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               Icons.warning,
//               size: 80,
//               color: Colors.grey.shade400,
//             ),
//             Text(
//               'NO DATA!',
//               style: TextStyle(
//                 color: Colors.grey.shade400,
//                 fontSize: 22,
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//   },
// ),
}
