import 'package:flutter/material.dart';
import 'package:task_manager/components/buttons/button_confirm.dart';
import 'package:task_manager/components/drop_down_button_role.dart';
import 'package:task_manager/components/text_form_field.dart';
import 'package:task_manager/models/user_credentials.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/form_field_validator.dart';
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
                          title: 'Fullname',
                          onSaved: (value) {
                            setState(() {
                              _userCreateCredentials.fullname = value;
                            });
                          },
                          validator: (value) {
                            return validateFormField(value, 'fullname', 5);
                          }),
                      TextFormFieldComponent(
                        title: 'Username',
                        onSaved: (value) {
                          setState(() {
                            _userCreateCredentials.username = value;
                          });
                        },
                        validator: (value) {
                          return validateFormField(value, 'username', 5);
                        },
                      ),
                      TextFormFieldComponent(
                        title: 'Email',
                        onSaved: (value) {
                          setState(() {
                            _userCreateCredentials.email = value;
                          });
                        },
                        validator: (value) {
                          String validation =
                              validateFormField(value, 'email', 5);
                          if (validation != null) return validation;
                          if (!isEmail(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      TextFormFieldComponent(
                        obscureText: true,
                        title: 'Password',
                        onSaved: (value) {
                          setState(() {
                            _userCreateCredentials.password = value;
                          });
                        },
                        validator: (value) {
                          return validateFormField(value, 'password', 5);
                        },
                      ),
                      TextFormFieldComponent(
                        obscureText: true,
                        title: 'Confirm Password',
                        onSaved: (value) {
                          setState(() {
                            _userCreateCredentials.confirmPassword = value;
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
                                } else {}
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
