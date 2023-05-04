import 'package:database_flutter/get/contact_getx_controller.dart';
import 'package:database_flutter/helpers/helpers.dart';
import 'package:database_flutter/models/contact.dart';
import 'package:flutter/material.dart';

class UpdateContactScreen extends StatefulWidget {
  const UpdateContactScreen({Key? key, required this.contact}) : super(key: key);

  final Contact contact;

  @override
  State<UpdateContactScreen> createState() => _UpdateContactScreenState();
}

class _UpdateContactScreenState extends State<UpdateContactScreen> with Helpers {
  late TextEditingController _nameTextController;
  late TextEditingController _numberTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTextController = TextEditingController(text: widget.contact.name);
    _numberTextController = TextEditingController(text: widget.contact.phone);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameTextController.dispose();
    _numberTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Contact'),
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        children: [
          const Text(
            'Update the contact details',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: _nameTextController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: 'Name',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _numberTextController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Number',
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () async => await performUpdate(),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 50),
            ),
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }


  Future<void> performUpdate() async {
    if (checkData()) {
      await update();
    }
  }

  bool checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _numberTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, message: 'Enter required data!', error: true);
    return false;
  }

  Contact get contact {
    Contact c = widget.contact;
    c.name = _nameTextController.text;
    c.phone = _numberTextController.text;
    return c;
  }

  Future<void> update() async {
    bool updated = await ContactGetxController.to.updateContact(contact);
    String message = updated ? 'Updated Successfully' : 'Updated Failed!';
    showSnackBar(context: context, message: message, error: !updated);
    if(updated) Navigator.pop(context);

  }


}
