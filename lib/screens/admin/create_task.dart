import 'package:flutter/material.dart';
import 'package:task_manager/components/buttons/button_confirm.dart';
import 'package:task_manager/components/date_form_field.dart';
import 'package:task_manager/components/dropdowns/drop_down_button.dart';
import 'package:task_manager/components/scan_button_to_build_user_card.dart';
import 'package:task_manager/components/text_form_field.dart';
import 'package:task_manager/models/task_details.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/restart_app.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/form_field_validator.dart';
import 'package:task_manager/utils/secure_storage.dart';
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
  void initState() {
    super.initState();

    _taskCreateDetails.status = creatableTaskStatuses[0];

    getUserFromToken().then((user){
      _taskCreateDetails.judgeId = user.userId;
    }).catchError((onError){
      removeJwtToken();
      RestartWidget.restartApp(context);
    });

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
                            _taskCreateDetails.beginAt = value.toString();
                          });
                        },
                      ),
                      DateFormField(
                        label: 'End Date',
                        onSaved: (value) {
                          setState(() {
                            _taskCreateDetails.endAt = value.toString();
                          });
                        },
                      ),
                      DropdownFormFieldComponent(
                        title: 'Status: ',
                        updateState: (String value) {
                          setState(() {
                            _taskCreateDetails.status = value;
                          });
                        },
                        options: creatableTaskStatuses,
                      ),
                      ScanButtonToBuildUserCard(
                        roleName: 'assignee',
                        fetchDetail: (userId) {
                          return fetchManagerOrEmployeeDetails(userId);
                        },
                        onSuccessBuild: (userId) {
                          _taskCreateDetails.assigneeId = userId;
                        },
                        onFailedBuild: () {
                          _taskCreateDetails.assigneeId = null;
                        },
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: ButtonConfirmComponent(
                          text: 'Create Task',
                          onPressed: () async {
                            final form = _createTaskFormKey.currentState;
                            if (!form.validate()) return;

                            if (_taskCreateDetails.assigneeId == null) {
                              showErrorSnackBar(context, 'Assignee is mandatory!');
                              return;
                            }

                            form.save();
                            DateTime beginAt =
                                DateTime.parse(_taskCreateDetails.beginAt);
                            DateTime endAt =
                                DateTime.parse(_taskCreateDetails.endAt);
                            if (beginAt.compareTo(endAt) > 0) {
                              showErrorSnackBar(context,
                                  'Start Date has to come before End Date');
                              return;
                            }
                            bool success =
                                await _taskCreateDetails.createTask(context);
                            if (success) {
                              Navigator.pop(context, true);
                            } else {}
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
