import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';

class TextFormFieldRounded extends StatefulWidget {
  final bool obscureText;
  final String hintText;
  final Function onSaved, validator;
  TextFormFieldRounded(
      {this.hintText,
      this.obscureText = false,
      this.onSaved,
      this.validator});

  @override
  _TextFormFieldRoundedState createState() => _TextFormFieldRoundedState();
}

class _TextFormFieldRoundedState extends State<TextFormFieldRounded> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      style: textStyleDefault,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      validator: widget.validator,
      onSaved: widget.onSaved,
    );
  }
}
