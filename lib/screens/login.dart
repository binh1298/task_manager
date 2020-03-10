import 'package:flutter/material.dart';
import 'package:task_manager/components/buttons/button_confirm.dart';
import 'package:task_manager/components/form_fields/text_form_field_rounded.dart';
import 'package:task_manager/models/user_credentials.dart';
import 'package:task_manager/models/user_details.dart';
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
                        return null;
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
                        return null;
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
                          bool success = await _userCredentials.login(context);
                          if (success) {
                            UserDetails user = await getUserFromToken();
                            String roleName = user.roleName;
                            Navigator.pushReplacementNamed(
                                context, '/$roleName');
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
