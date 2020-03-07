import 'package:flutter/material.dart';
import 'package:task_manager/components/button_confirm.dart';
import 'package:task_manager/components/scan_button_to_build_user_card.dart';
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
                      ScanButtonToBuildUserCard(
                        roleName: 'Manager or Admin',
                        fetchDetail: (userId) {
                          return fetchManagerOrAdminDetails(userId);
                        },
                        onSuccessBuild: (userId) {
                          _groupCreateDetails.managerId = userId;
                        },
                        onFailedBuild: () {
                          _groupCreateDetails.managerId = null;
                        },
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: ButtonConfirmComponent(
                          text: 'Create Group',
                          onPressed: () async {
                            final form = _createGroupFormKey.currentState;
                            if (form.validate()) {
                              form.save();
                              if (_groupCreateDetails.managerId == null) {
                                showErrorSnackBar(
                                    context, 'You have to set a manager!');
                              } else {
                                GroupDetails groupDetails =
                                    await _groupCreateDetails.createGroup();
                                if (groupDetails != null) {
                                  Navigator.pop(context, groupDetails);
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
