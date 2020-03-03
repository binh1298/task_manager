import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';

class TextFieldRounded extends StatefulWidget {
  final bool obscureText;
  final String hintText;

  TextFieldRounded({this.hintText = '', this.obscureText = false});

  @override
  _TextFieldRoundedState createState() => _TextFieldRoundedState();
}

class _TextFieldRoundedState extends State<TextFieldRounded> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText,
      style: textStyleDefault,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
  }
}
