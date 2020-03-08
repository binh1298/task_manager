import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';

class TextFormFieldRounded extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final Function onSaved, validator;
  TextFormFieldRounded(
      {this.hintText,
      this.obscureText = false,
      this.onSaved,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      style: textStyleDefault,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}