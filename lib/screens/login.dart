import 'package:flutter/material.dart';
import 'package:task_manager/components/button_confirm.dart';
import 'package:task_manager/components/text_field_rounded.dart';
import 'package:task_manager/style/style.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Container(
                    height: 200.0,
                    child: Image.asset('lib/assets/images/logo.png'),
                  ),
                ),
                Text(
                  "Task Manager",
                  style: textStyleHeading
                ),
                SizedBox(height: 45.0),
                TextFieldRounded(hintText: 'Email'),
                SizedBox(height: 25.0),
                TextFieldRounded(hintText: 'Password'),
                SizedBox(
                  height: 35.0,
                ),
                ButtonConfirmComponent(
                  text: 'Login',
                  onPressed: () async {
                    Navigator.pushReplacementNamed(context, '/admin');
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
