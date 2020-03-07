import 'package:flutter/material.dart';
import 'package:task_manager/components/button_confirm.dart';
import 'package:task_manager/components/card_user_profile.dart';
import 'package:task_manager/components/scan_button.dart';
import 'package:task_manager/components/text_form_field.dart';
import 'package:task_manager/models/group_details.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/snack_bar.dart';

class CreateGroupScreen extends StatefulWidget {
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _createGroupFormKey = GlobalKey<FormState>();
  final _groupCreateDetails = GroupDetails();
  String _userId;
  bool foundManager = false;

  Widget buildManagerCard(userId) {
    if (userId != null) {
      return FutureBuilder<UserDetails>(
        future: fetchUserDetails(userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            foundManager = true;
            return CardUserProfile(
              userId: snapshot.data.userId,
              fullname: snapshot.data.fullname,
              role: snapshot.data.roleName,
              phoneNumber: snapshot.data.phoneNumber,
              email: snapshot.data.email,
              avatar: snapshot.data.avatar,
            );
          } else if (snapshot.hasError) {
            return Text('User is either not found or not a manager!');
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    } else {
      return Text('Please scan QR to find manager');
    }
  }

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
                    'Create new Group',
                    style: textStyleHeading,
                  ),
                ),
                Form(
                  key: _createGroupFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormFieldComponent(
                        title: 'Group Name',
                        onSaved: (groupName) {
                          setState(() {
                            _groupCreateDetails.groupName = groupName;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a group name!';
                          }
                          if (value.length < 3) {
                            return 'Group name has to be longer than 2 characters';
                          }
                          return null;
                        },
                      ),
                      Text(
                        'Manager:',
                        style: textStyleTitle,
                      ),
                      buildManagerCard(_userId),
                      ScanButton(
                        context: context,
                        onSuccessScan: (barcode) {
                          setState(() {
                            _userId = barcode;
                          });
                        },
                        title: 'Scan QR to find Manager',
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: ButtonConfirmComponent(
                          text: 'Create Group',
                          onPressed: () async {
                            final form = _createGroupFormKey.currentState;
                            if (form.validate()) {
                              form.save();
                              if (!foundManager) {
                                showErrorSnackBar(
                                    context, 'You have to set a manager!');
                              } else {
                                // if (!_groupCreateDetails.comparePassword()) {
                                //   showErrorSnackBar(context,
                                //       'Password have to match Confirm Password');
                                // } else {
                                //   bool success = await _groupCreateDetails
                                //       .createUser(context);
                                //   if (success) {
                                //     Navigator.pop(context, true);
                                //   } else {

                                //   }
                                // }
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
