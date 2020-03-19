import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';

class TextFormFieldComponent extends StatelessWidget {
  final bool obscureText;
  final TextInputType textInputType;
  final String hintText, title;
  final Function onSaved, validator;
  final String initialValue;
  TextFormFieldComponent(
      {this.hintText,
      this.initialValue,
      this.title,
      this.obscureText = false,
      this.onSaved,
      this.validator, this.textInputType});
  @override
  Widget build(BuildContext context) {
    int maxLines = 1;
    if(textInputType == TextInputType.multiline) maxLines = null;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$title:',
            style: textStyleTitle,
          ),
          TextFormField(
            initialValue: initialValue == null ? '' : initialValue,
            obscureText: obscureText,
            style: textStyleSubtitle,
            validator: validator,
            onSaved: onSaved,
            keyboardType: textInputType,
            maxLines: maxLines,
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}