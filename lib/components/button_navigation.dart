import 'package:flutter/material.dart';

import '../style/style.dart';

class ButtonNavigation extends StatefulWidget {
  final String title;
  final Function onPressed;
  final IconData iconData;
  final bool isActive;

  const ButtonNavigation({
    Key key,
    this.title,
    this.onPressed,
    this.iconData,
    this.isActive,
  }) : super(key: key);

  @override
  _ButtonNavigationState createState() => _ButtonNavigationState();
}

class _ButtonNavigationState extends State<ButtonNavigation> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 40.0,
      onPressed: widget.onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            widget.iconData,
            color: widget.isActive ? colorPrimary : colorInactive,
          ),
          Text(
            widget.title,
            style: textStyleDefault.copyWith(
              color: widget.isActive ? colorPrimary : colorInactive,
            )
          )
        ],
      ),
    );
  }
}