import 'package:flutter/material.dart';
import 'package:task_manager/components/buttons/button_confirm.dart';
import 'package:task_manager/components/dropdowns/drop_down_button.dart';
import 'package:task_manager/components/form_fields/text_form_field.dart';
import 'package:task_manager/components/image_task_safe.dart';
import 'package:task_manager/components/labels/icon_text.dart';
import 'package:task_manager/components/labels/text_safe.dart';
import 'package:task_manager/components/sections/section_task_details_of_assignee_not_editable.dart';
import 'package:task_manager/components/sections/section_task_details_of_judge_not_editable.dart';
import 'package:task_manager/models/task_details.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/form_field_validator.dart';
import 'package:task_manager/utils/secure_storage.dart';
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
                      label: 'Judge',
                      text: snapshot.data.judgeFullname,
                    ),
                    TextSafeComponent(
                      label: 'Assignee',
                      text: snapshot.data.assigneeFullname,
                    ),
                    SizedBox(height: 10),
                    DropdownFormFieldComponent(
                      initialValue: snapshot.data.status,
                      options: updatatableTaskStatusesForJudge,
                      title: 'Status:',
                      style: textStyleTitle,
                      updateState: (String value) {
                        setState(() {
                          _taskUpdateDetails.status = value;
                        });
                      },
                    ),
                    FutureBuilder<UserDetails>(
                        future: getUserFromToken(),
                        builder: (context, snapshotUser) {
                          if (snapshotUser.hasData) {
                            if (snapshotUser.data.userId ==
                                snapshot.data.judgeId) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  DropdownFormFieldComponent(
                                    options: judgeStatuses,
                                    title: 'Judge Status:',
                                    style: textStyleTitle,
                                    updateState: (String value) {
                                      setState(() {
                                        _taskUpdateDetails.judgeStatus = value;
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
                                      return validateFormField(
                                          value, 'requirement', 5);
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
                                    initialValue: snapshot.data.judgeComment,
                                    title: 'Judge\'s comment',
                                    textInputType: TextInputType.multiline,
                                    onSaved: (value) {
                                      setState(() {
                                        _taskUpdateDetails.requirement = value;
                                      });
                                    },
                                  ),
                                  IconTextComponent(
                                    icon: Icons.access_alarm,
                                    text: formatDate(
                                        snapshot.data.judgeCommentAt),
                                    fallbackText: 'Not commented yet',
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormFieldComponent(
                                    initialValue: snapshot.data.judgeScore !=
                                            null
                                        ? snapshot.data.judgeScore.toString()
                                        : null,
                                    title: 'Score',
                                    textInputType: TextInputType.number,
                                    onSaved: (value) {
                                      setState(() {
                                        _taskUpdateDetails.judgeScore = value;
                                      });
                                    },
                                    validator: (value) {
                                      return validateFormField(
                                          value, 'score', 0);
                                    },
                                  ),
                                ],
                              );
                            } else {
                              return SectionTaskDetailsOfJudgeNotEditable(
                                  _taskUpdateDetails);
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide()),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FutureBuilder<UserDetails>(
                      future: getUserFromToken(),
                      builder: (context, snapshotUser) {
                        if (snapshotUser.hasData) {
                          if (snapshotUser.data.userId ==
                              snapshot.data.assigneeId) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormFieldComponent(
                                  initialValue: snapshot.data.handleProcess,
                                  title: 'Handle Process',
                                  textInputType: TextInputType.multiline,
                                  onSaved: (value) {
                                    setState(() {
                                      _taskUpdateDetails.handleProcess = value;
                                    });
                                  },
                                ),
                                TextSafeComponent(
                                  text: 'Confirmation Image:',
                                  style: textStyleTitle,
                                ),
                                ImageTaskSafe(
                                  imgUrl: _taskUpdateDetails.confirmationImg,
                                ),
                                RaisedButton(
                                  color: colorPrimary,
                                  textColor: colorTextButton,
                                  splashColor: Colors.blueGrey,
                                  onPressed: () async {
                                    final url = await Navigator.pushNamed(
                                      context,
                                      '/updateConfirmationImg',
                                    );
                                    if (url != null) {
                                      setState(() {
                                        _taskUpdateDetails.confirmationImg =
                                            url;
                                      });
                                    }
                                  },
                                  child: Text('Submit Image'),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormFieldComponent(
                                  initialValue: snapshot.data.submitDescription,
                                  title: 'Submit Description',
                                  textInputType: TextInputType.multiline,
                                  onSaved: (value) {
                                    setState(() {
                                      _taskUpdateDetails.submitDescription =
                                          value;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            );
                          } else {
                            return SectionTaskDetailsOfAssigneeNotEditable(
                                _taskUpdateDetails);
                          }
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    ButtonConfirmComponent(
                      text: 'Update Task',
                      onPressed: () async {
                        final form = _updateTaskFormKey.currentState;
                        if (!form.validate()) return;
                        // TODO: Validate for roles
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
