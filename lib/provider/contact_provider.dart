import 'package:database_flutter/database/controllers/contact_db_controllers.dart';
import 'package:database_flutter/models/contact.dart';
import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier {

  List<Contact> contacts = <Contact>[];
  final ContactDbController _contactDbController = ContactDbController();

  // CRUD
  Future<void> read() async {
    contacts = await _contactDbController.read();
    notifyListeners();
  }

  Future<bool> create(Contact contact) async {
    int newRowId = await _contactDbController.create(contact);
    if (newRowId != 0) {
      contact.id = newRowId;
      contacts.add(contact);
      notifyListeners();
    }
    return newRowId != 0;
  }

  Future<bool> delete(int id) async {
    bool deleted = await _contactDbController.delete(id);
    if (deleted) {
      int index = contacts.indexWhere((element) => element.id == id);
      if (index != -1) {
        contacts.removeAt(index);
        notifyListeners();
      }
    }
    return deleted;
  }

  Future<bool> update(Contact contact) async {
    bool updated = await _contactDbController.update(contact);
    if (updated) {
      int index = contacts.indexWhere((element) => element.id == contact.id);
      if (index != -1) {
        contacts[index] = contact;
        notifyListeners();
      }
    }
    return updated;
  }
}