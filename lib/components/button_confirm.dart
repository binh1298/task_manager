import 'package:flutter/material.dart';
import 'package:task_manager/style/style.dart';

class ButtonConfirmComponent extends StatefulWidget {
  final Function onPressed;
  final String text;

  ButtonConfirmComponent({this.onPressed, this.text});

  @override
  _ButtonConfirmComponentState createState() => _ButtonConfirmComponentState();
}

class _ButtonConfirmComponentState extends State<ButtonConfirmComponent> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: widget.onPressed,
        child: Text(widget.text,
            textAlign: TextAlign.center,
            style: textStyleDefault.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}