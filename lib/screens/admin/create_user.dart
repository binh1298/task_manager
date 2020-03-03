import 'package:flutter/material.dart';
import 'package:task_manager/components/button_confirm.dart';
import 'package:task_manager/components/text_form_field.dart';
import 'package:task_manager/style/style.dart';

class CreateUserScreen extends StatefulWidget {
  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _createUserFormKey = GlobalKey<FormState>();
  
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a username!';
                          }
                          return null;
                        },
                      ),
                      TextFormFieldComponent(
                        title: 'Email',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter an email!';
                          }
                          return null;
                        },
                      ),
                      TextFormFieldComponent(
                        obscureText: true,
                        title: 'Password',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a valid password!';
                          }
                          return null;
                        },
                      ),
                      TextFormFieldComponent(
                        obscureText: true,
                        title: 'Confirm Password',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a valid password!';
                          }
                          return null;
                        },
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: ButtonConfirmComponent(
                          onPressed: () {
                            // Validate returns true if the form is valid, otherwise false.
                            if (_createUserFormKey.currentState.validate()) {
                              // print(createUserFormController.text);
                            }
                          },
                          text: 'Create User',
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
