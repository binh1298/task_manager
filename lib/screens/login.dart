import 'package:flutter/material.dart';
import 'package:task_manager/components/button_confirm.dart';
import 'package:task_manager/components/text_form_field_rounded.dart';
import 'package:task_manager/models/user_credentials.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/secure_storage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _userCredentials = UserLoginCredentials();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Builder(
              builder: (context) => Form(
                key: _loginFormKey,
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
                    Text("Task Manager", style: textStyleHeading),
                    SizedBox(height: 45.0),
                    TextFormFieldRounded(
                      hintText: 'Username',
                      onSaved: (username) {
                        setState(() {
                          _userCredentials.username = username;
                        });
                      },
                      validator: (username) {
                        if (username.isEmpty)
                          return 'Please enter your username';
                      },
                    ),
                    SizedBox(height: 25.0),
                    TextFormFieldRounded(
                      obscureText: true,
                      hintText: 'Password',
                      onSaved: (password) {
                        setState(() {
                          _userCredentials.password = password;
                        });
                      },
                      validator: (password) {
                        if (password.isEmpty)
                          return 'Please enter your password';
                      },
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    ButtonConfirmComponent(
                      text: 'Login',
                      onPressed: () async {
                        final form = _loginFormKey.currentState;
                        if (form.validate()) {
                          form.save();
                          String token = await _userCredentials.login();
                          if (token != null) {
                            setJwtToken(token);
                            Navigator.pushReplacementNamed(context, '/admin');
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Invalid Username or Password'),
                            ));
                          }
                        }
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
        ),
      ),
    );
  }
}
