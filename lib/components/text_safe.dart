import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';
// In order to use this you have to always set maxwidth for the parent

class TextSafeComponent extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color color;
  TextSafeComponent(
      {this.text,
      this.style,
      this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      child: Text(
        text == null ? 'Unknown' : text,
        overflow: TextOverflow.ellipsis,
        maxLines: 5,
        style: style != null ? style.copyWith(color: color) : textStyleDefault.copyWith(color: color),
      ),
    );
  }
}
