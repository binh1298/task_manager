import 'package:flutter/material.dart';
import 'package:task_manager/components/button_confirm.dart';
import 'package:task_manager/components/drop_down_button.dart';
import 'package:task_manager/components/text_form_field.dart';
import 'package:task_manager/models/user_credentials.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/snack_bar.dart';
import 'package:task_manager/utils/string_utils.dart';

class CreateUserScreen extends StatefulWidget {
  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _createUserFormKey = GlobalKey<FormState>();
  final _userCreateCredentials = UserCreateCredentials();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Create new User',
                    style: textStyleHeading,
                  ),
                ),
                Form(
                  key: _createUserFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormFieldComponent(
                        title: 'Username',
                        onSaved: (username) {
                          setState(() {
                            _userCreateCredentials.username = username;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a username!';
                          }
                          if (value.length < 5) {
                            return 'Username has to be longer than 5 characters without spaces';
                          }
                          return null;
                        },
                      ),
                      TextFormFieldComponent(
                        title: 'Email',
                        onSaved: (email) {
                          setState(() {
                            _userCreateCredentials.email = email;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter an email!';
                          }
                          if (!isEmail(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      TextFormFieldComponent(
                        obscureText: true,
                        title: 'Password',
                        onSaved: (password) {
                          setState(() {
                            _userCreateCredentials.password = password;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a valid password!';
                          }

                          if (value.length < 5) {
                            return 'Password has to be longer than 5 characters';
                          }
                          return null;
                        },
                      ),
                      TextFormFieldComponent(
                        obscureText: true,
                        title: 'Confirm Password',
                        onSaved: (confirmPassword) {
                          setState(() {
                            _userCreateCredentials.confirmPassword =
                                confirmPassword;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a valid password!';
                          }
                          return null;
                        },
                      ),
                      DropdownButtonRole(
                        updateState: (int roleId) {
                          setState(() {
                            _userCreateCredentials.roleId = roleId;
                          });
                        },
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: ButtonConfirmComponent(
                          text: 'Create User',
                          onPressed: () async {
                            final form = _createUserFormKey.currentState;
                            if (form.validate()) {
                              form.save();
                              if (!_userCreateCredentials.comparePassword()) {
                                showErrorSnackBar(context,
                                    'Password have to match Confirm Password');
                              } else {
                                bool success = await _userCreateCredentials
                                    .createUser(context);
                                if (success) {
                                  Navigator.pop(context, true);
                                } else {
                                  
                                }
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
