import 'package:flutter/material.dart';
import 'package:task_manager/components/buttons/button_confirm.dart';
import 'package:task_manager/components/dropdowns/drop_down_button.dart';
import 'package:task_manager/components/form_fields/text_form_field.dart';
import 'package:task_manager/components/labels/icon_text.dart';
import 'package:task_manager/components/labels/text_safe.dart';
import 'package:task_manager/models/task_details.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/form_field_validator.dart';
import 'package:task_manager/utils/snack_bar.dart';
import 'package:task_manager/utils/string_utils.dart';

class ViewTaskDetailsScreen extends StatefulWidget {
  final int taskId;

  ViewTaskDetailsScreen({this.taskId});
  @override
  _ViewTaskDetailsScreenState createState() => _ViewTaskDetailsScreenState();
}

class _ViewTaskDetailsScreenState extends State<ViewTaskDetailsScreen> {
  Future<TaskDetails> taskDetails;
  final _updateTaskFormKey = GlobalKey<FormState>();
  TaskDetails _taskUpdateDetails = TaskDetails();

  @override
  void initState() {
    super.initState();
    taskDetails = fetchTaskDetails(widget.taskId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TaskDetails>(
      future: taskDetails,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _taskUpdateDetails = snapshot.data;
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _updateTaskFormKey,
                child: ListView(
                  children: <Widget>[
                    TextSafeComponent(
                      label: 'Task',
                      text: '${snapshot.data.name}',
                      style: textStyleTitle,
                    ),
                    TextSafeComponent(
                      label: 'Source task',
                      text: snapshot.data.sourceTaskId.toString(),
                      onTap: () {
                        showInfoSnackBar(context, 'Hello');
                      },
                      fallbackText: 'Not assigned',
                    ),
                    TextSafeComponent(
                      label: 'Creator',
                      text: snapshot.data.creatorFullname,
                    ),
                    TextSafeComponent(
                      label: 'Assignee',
                      text: snapshot.data.assigneeFullname,
                    ),
                    SizedBox(height: 10),
                    DropdownFormFieldComponent(
                      options: updatatableTaskStatusesForManager,
                      title: 'Status:',
                      style: textStyleTitle,
                      updateState: (String value) {
                        setState(() {
                          _taskUpdateDetails.status = value;
                        });
                      },
                    ),
                    TextFormFieldComponent(
                      initialValue: snapshot.data.requirement,
                      title: 'Requirement',
                      textInputType: TextInputType.multiline,
                      onSaved: (value) {
                        setState(() {
                          _taskUpdateDetails.requirement = value;
                        });
                      },
                      validator: (value) {
                        return validateFormField(value, 'requirement', 5);
                      },
                    ),
                    Row(
                      children: <Widget>[
                        IconTextComponent(
                          icon: Icons.notifications,
                          text: formatDate(snapshot.data.beginAt),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconTextComponent(
                          icon: Icons.notifications_off,
                          text: formatDate(snapshot.data.endAt),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormFieldComponent(
                      initialValue: snapshot.data.handleProcess,
                      title: 'Handle Process',
                      textInputType: TextInputType.multiline,
                      onSaved: (value) {
                        setState(() {
                          _taskUpdateDetails.requirement = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormFieldComponent(
                      initialValue: snapshot.data.judgeComment,
                      title: 'Judge\'s comment',
                      textInputType: TextInputType.multiline,
                      onSaved: (value) {
                        setState(() {
                          _taskUpdateDetails.requirement = value;
                        });
                      },
                    ),
                    Row(
                      children: <Widget>[
                        IconTextComponent(
                          icon: Icons.access_alarm,
                          text: formatDate(snapshot.data.judgeCommentAt),
                          fallbackText: 'Not yet',
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconTextComponent(
                          icon: Icons.assignment_turned_in,
                          text: snapshot.data.judgeScore.toString(),
                          fallbackText: 'Not yet',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonConfirmComponent(
                      text: 'Update Task',
                      onPressed: () async {
                        final form = _updateTaskFormKey.currentState;
                          if (!form.validate()) return;
                          form.save();
                          bool success =
                              await _taskUpdateDetails.updateTask(context);
                          if (success) {
                            Navigator.pop(context, true);
                          } else {}
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Can\'t find this Task ${snapshot.error}',
              style: textStyleHeading,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
