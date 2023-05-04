
import 'package:database_flutter/database/controllers/contact_db_controllers.dart';
import 'package:database_flutter/models/contact.dart';
import 'package:get/get.dart';

class ContactGetxController extends GetxController{

  RxList<Contact> contacts = <Contact>[].obs;
  final ContactDbController _contactDbController = ContactDbController();

  static ContactGetxController get to => Get.find<ContactGetxController>();

  @override
  void onInit() {
    readContacts();
    super.onInit();
  }

  // CRUD
  Future<void> readContacts() async {
    contacts.value = await _contactDbController.read();
  }

  Future<bool> createContact(Contact contact) async {
    int newRowId = await _contactDbController.create(contact);
    if (newRowId != 0) {
      contact.id = newRowId;
      contacts.add(contact);
    }
    return newRowId != 0;
  }

  Future<bool> deleteContact(int id) async {
    bool deleted = await _contactDbController.delete(id);
    if (deleted) {
      int index = contacts.indexWhere((element) => element.id == id);
      if (index != -1) {
        contacts.removeAt(index);
      }
    }
    return deleted;
  }

  Future<bool> updateContact(Contact contact) async {
    bool updated = await _contactDbController.update(contact);
    if (updated) {
      int index = contacts.indexWhere((element) => element.id == contact.id);
      if (index != -1) {
        contacts[index] = contact;
      }
    }
    return updated;
  }

}