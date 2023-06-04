import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:foodorder_app/config/colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.green[100],
        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        strokeWidth: 4.0,
      )),
    );
  }
}
