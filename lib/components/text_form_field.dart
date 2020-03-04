import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';

class TextFormFieldComponent extends StatefulWidget {
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
  _TextFormFieldComponentState createState() => _TextFormFieldComponentState();
}

class _TextFormFieldComponentState extends State<TextFormFieldComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${widget.title}:',
            style: textStyleTitle,
          ),
          TextFormField(
            obscureText: widget.obscureText,
            style: textStyleSubtitle,
            validator: widget.validator,
            onSaved: widget.onSaved,
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
