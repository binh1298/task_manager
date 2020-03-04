import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';

class TextFormFieldComponent extends StatelessWidget {
  final bool obscureText;
  final String hintText, title;
  final Function onSaved, validator;

  TextFormFieldComponent(
      {this.hintText,
      this.title,
      this.obscureText = false,
      this.onSaved,
      this.validator});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${title}:',
            style: textStyleTitle,
          ),
          TextFormField(
            obscureText: obscureText,
            style: textStyleSubtitle,
            validator: validator,
            onSaved: onSaved,
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}