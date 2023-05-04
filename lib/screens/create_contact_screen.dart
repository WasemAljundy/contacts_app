import 'package:database_flutter/get/contact_getx_controller.dart';
import 'package:database_flutter/helpers/helpers.dart';
import 'package:database_flutter/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateContactScreen extends StatefulWidget {
  const CreateContactScreen({Key? key}) : super(key: key);

  @override
  State<CreateContactScreen> createState() => _CreateContactScreenState();
}

class _CreateContactScreenState extends State<CreateContactScreen> with Helpers {

  late TextEditingController _nameTextController;
  late TextEditingController _numberTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTextController = TextEditingController();
    _numberTextController = TextEditingController();
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
        title: Text(AppLocalizations.of(context)!.create_contact),
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        children: [
          Text(
            AppLocalizations.of(context)!.enter_new_contact_details,
            style: const TextStyle(
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
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.name,
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
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.number,
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
            onPressed: () async => await performCreate(),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 50),
            ),
            child: Text(
              AppLocalizations.of(context)!.save,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }


  Future<void> performCreate() async {
    if (checkData()) {
      await create();
    }
  }

  bool checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _numberTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, message: AppLocalizations.of(context)!.enter_required_data, error: true);
    return false;
  }

  Contact get contact {
    Contact c = Contact();
    c.name = _nameTextController.text;
    c.phone = _numberTextController.text;
    return c;
  }

  Future<void> create() async {
    bool created = await ContactGetxController.to.createContact(contact);
    if(created) clear();
    String message = created ? 'Created Successfully' : 'Create Failed!';
    showSnackBar(context: context, message: message, error: !created);
  }



  void clear() {
    _nameTextController.text = '';
    _numberTextController.text = '';
  }

}
