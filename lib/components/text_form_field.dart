import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';

class TextFormFieldComponent extends StatefulWidget {
  final String title;
  final Function validator;
  final TextEditingController controller;

  TextFormFieldComponent({this.title, this.validator, this.controller});
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
            controller: widget.controller,
            style: textStyleSubtitle,
            validator: widget.validator,
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
