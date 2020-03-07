import 'package:flutter/material.dart';
import 'package:task_manager/components/button_confirm.dart';
import 'package:task_manager/components/date_form_field.dart';
import 'package:task_manager/components/drop_down_button.dart';
import 'package:task_manager/components/scan_button_to_build_user_card.dart';
import 'package:task_manager/components/text_form_field.dart';
import 'package:task_manager/models/task_details.dart';
import 'package:task_manager/models/user_credentials.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/form_field_validator.dart';
import 'package:task_manager/utils/snack_bar.dart';
import 'package:task_manager/utils/string_utils.dart';

class CreateTaskScreen extends StatefulWidget {
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _createTaskFormKey = GlobalKey<FormState>();
  final _taskCreateDetails = TaskDetails();
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
                    'Create new Task',
                    style: textStyleHeading,
                  ),
                ),
                Form(
                  key: _createTaskFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormFieldComponent(
                          title: 'Task Name',
                          onSaved: (value) {
                            setState(() {
                              _taskCreateDetails.name = value;
                            });
                          },
                          validator: (value) {
                            return validateFormField(value, 'task name', 5);
                          }),
                      TextFormFieldComponent(
                        title: 'Requirement',
                        onSaved: (value) {
                          setState(() {
                            _taskCreateDetails.requirement = value;
                          });
                        },
                        validator: (value) {
                          return validateFormField(value, 'requirement', 5);
                        },
                        textInputType: TextInputType.multiline,
                      ),
                      DateFormField(
                        label: 'Start Date',
                        onSaved: (value) {
                          setState(() {
                            print(value);
                            _taskCreateDetails.beginAt = value;
                          });
                        },
                      ),
                      DateFormField(
                        label: 'End Date',
                        onSaved: (value) {
                          setState(() {
                            _taskCreateDetails.endAt = value;
                          });
                        },
                      ),
                      // ScanButtonToBuildUserCard()
                      Container(
                        alignment: Alignment.bottomRight,
                        child: ButtonConfirmComponent(
                          text: 'Create Task',
                          onPressed: () async {
                            final form = _createTaskFormKey.currentState;
                            if (form.validate()) {
                              form.save();
                              // bool success =
                              //     await _taskCreateDetails.createTask(context);
                              // if (success) {
                              //   Navigator.pop(context, true);
                              // } else {}
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
