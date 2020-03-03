import 'package:flutter/material.dart';

class TextSafeComponent extends StatefulWidget {
  final String text;
  final TextStyle style;

  TextSafeComponent({this.text, this.style});
  @override
  _TextSafeComponentState createState() => _TextSafeComponentState();
}

class _TextSafeComponentState extends State<TextSafeComponent> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text == null ? 'Unknown' : widget.text,
      style: widget.style,
    );
  }
}
