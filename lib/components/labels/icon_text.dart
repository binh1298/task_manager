import 'package:flutter/material.dart';
import 'package:task_manager/components/labels/text_safe.dart';

class IconTextComponent extends StatelessWidget {
  final String text;
  final IconData icon;
  final TextStyle style;
  final Color color;
  final double textBoxWidth;
  final String fallbackText;
  IconTextComponent({this.fallbackText, this.text, this.icon, this.style, this.textBoxWidth, this.color});

  @override
  Widget build(BuildContext context) { 
    return Row(
      children: <Widget>[
        Icon(icon),
        SizedBox(
          width: 5.0,
        ),
        TextSafeComponent(
          text: text,
          style: style,
          color: color,
          fallbackText: fallbackText,
          textBoxWidth: textBoxWidth,
        ),
      ],
    );
  }
}
