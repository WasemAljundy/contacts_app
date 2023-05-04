import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.textEditingController,
    required this.hint,
    required this.prefixIcon,
    this.textInputType = TextInputType.name,
  });

  final TextEditingController textEditingController;
  final String hint;
  final IconData prefixIcon;
  final TextInputType textInputType;


  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(prefixIcon),
        enabledBorder: outLineBorder(),
        focusedBorder: outLineBorder(color: Colors.blue)
      ),
    );
  }

  OutlineInputBorder outLineBorder ({Color color = Colors.grey}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: color,
      ),
      borderRadius: BorderRadius.circular(10),
    );

  }
}


