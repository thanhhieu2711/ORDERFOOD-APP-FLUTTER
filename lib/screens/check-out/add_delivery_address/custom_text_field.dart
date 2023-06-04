import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController? controller;
  String? labelText;
  TextInputType? keyboardType;
  CustomTextField({this.labelText, this.controller, this.keyboardType});
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
    );
  }
}
