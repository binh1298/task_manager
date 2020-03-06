import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';
// In order to use this you have to always set maxwidth for the parent

class TextSafeComponent extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double textBoxWidth;
  TextSafeComponent({this.text, this.style, this.textBoxWidth = textboxWidthMedium});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: textBoxWidth,
      child: Text(
        (text == null || text == 'null') ? 'Unknown' : text,
        overflow: TextOverflow.ellipsis,
        maxLines: 5,
        style: style,
      ),
    );
  }
}
