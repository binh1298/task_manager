import 'package:flutter/material.dart';
// In order to use this you have to always set maxwidth for the parent

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
    return Container(
      width: 220,
      child: Text(
        widget.text == null ? 'Unknown' : widget.text,
        overflow: TextOverflow.ellipsis,
        maxLines: 5,
        style: widget.style,
      ),
    );
  }
}
