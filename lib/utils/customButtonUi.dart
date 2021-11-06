import 'package:flutter/material.dart';

class CustomButonUi extends StatelessWidget {
  final String buttonText;
  CustomButonUi(this.buttonText);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.all(12.0),
      child: Text(
        "$buttonText",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
