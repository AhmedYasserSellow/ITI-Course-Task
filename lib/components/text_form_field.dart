import 'package:flutter/material.dart';

Widget myTextFormField(
    {required validate,
    required String label,
    required IconData prefix,
    required BuildContext context,
    required Color color,
    bool isHidden = false,
    bool isEnabled = true,
    Color focusColor = Colors.blue,
    Color labelColor = Colors.grey,
    Widget? suffix,
    TextEditingController? controller}) {
  return TextFormField(
    controller: controller,
    enabled: isEnabled,
    textInputAction: TextInputAction.next,
    obscureText: isHidden,
    validator: validate,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: focusColor, width: 2.0),
      ),
      labelStyle: TextStyle(color: labelColor),
      labelText: label,
      prefixIcon: Icon(
        prefix,
        color: color,
      ),
      suffixIcon: suffix,
      border: const OutlineInputBorder(),
    ),
  );
}
