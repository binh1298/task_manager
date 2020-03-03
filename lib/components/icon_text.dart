import 'package:flutter/material.dart';
import 'package:task_manager/components/text_safe.dart';

class IconTextComponent extends StatefulWidget {
  final String text;
  final IconData icon;

  IconTextComponent({this.text, this.icon});

  @override
  _IconTextComponentState createState() => _IconTextComponentState();
}

class _IconTextComponentState extends State<IconTextComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(widget.icon),
        SizedBox(
          width: 5.0,
        ),
        TextSafeComponent(
          text: widget.text
        ),
      ],
    );
  }
}
