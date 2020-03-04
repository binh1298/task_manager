import 'package:flutter/material.dart';
import 'package:task_manager/components/text_safe.dart';

class IconTextComponent extends StatelessWidget {
  final String text;
  final IconData icon;
  final TextStyle style;
  IconTextComponent({this.text, this.icon, this.style});

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
        ),
      ],
    );
  }
}
