import 'package:flutter/material.dart';
import 'package:task_manager/components/buttons/button_confirm.dart';
import 'package:task_manager/components/cards/card_list_container.dart';
import 'package:task_manager/components/dropdowns/drop_down_button.dart';
import 'package:task_manager/components/form_fields/date_form_field.dart';
import 'package:task_manager/components/scan_button_to_build_user_card.dart';
import 'package:task_manager/models/task_query_params.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/snack_bar.dart';
import 'package:task_manager/utils/string_utils.dart';

class FormQueryTasks extends StatefulWidget {
  final Function onSearch;
  final String searchType;
  FormQueryTasks(this.onSearch, this.searchType);
  @override
  _FormQueryTasksState createState() => _FormQueryTasksState();
}

class _FormQueryTasksState extends State<FormQueryTasks> {
  final _formKeyQueryTasks = GlobalKey<FormState>();
  final TaskQueryParams _taskQueryParams =
      TaskQueryParams(taskStatus: taskStatuses[0]);
  @override
  Widget build(BuildContext context) {
    return CardListContainer(
      child: ExpansionTile(
        title: Text(
          'Search:',
          style: textStyleTitle,
        ),
        children: <Widget>[
          Form(
            key: _formKeyQueryTasks,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    DateFormField(
                      label: 'From',
                      onSaved: (value) {
                        setState(() {
                          _taskQueryParams.beginAt = formatDate(value?.toString());
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    DateFormField(
                      label: 'To',
                      onSaved: (value) {
                        setState(() {
                          _taskQueryParams.endAt = formatDate(value?.toString());
                        });
                      },
                    ),
                  ],
                ),
                DropdownFormFieldComponent(
                  initialValue: taskStatuses[0],
                  title: 'Status: ',
                  updateState: (String value) {
                    setState(() {
                      _taskQueryParams.taskStatus = value;
                    });
                  },
                  options: taskStatusesToQuery,
                ),
                ScanButtonToBuildUserCard(
                  roleName: 'user',
                  fetchDetail: (userId) {
                    switch (widget.searchType) {
                      case TaskTypesForQuery.assignee:
                        return fetchAssignee(userId);
                        break;
                      case TaskTypesForQuery.judge:
                        return fetchJudge(userId);
                        break;
                      case TaskTypesForQuery.history:
                        return fetchUserForQueryHistory(userId);
                        break;
                      default:
                        return fetchAssignee(userId);
                    }
                  },
                  onSuccessBuild: (userId) {
                      _taskQueryParams.userId = userId;
                  },
                  onFailedBuild: () {
                      _taskQueryParams.userId = null;
                  },
                ),
                ButtonConfirmComponent(
                  text: 'Search',
                  onPressed: () async {
                    final form = _formKeyQueryTasks.currentState;
                    if (!form.validate()) return;
                    form.save();
                    if (_taskQueryParams.beginAt != null &&
                        _taskQueryParams.endAt != null) {
                      DateTime beginAt = DateTime.parse(_taskQueryParams.beginAt);
                      DateTime endAt = DateTime.parse(_taskQueryParams.endAt);
                      if (beginAt.compareTo(endAt) > 0) {
                        showErrorSnackBar(
                            context, 'From has to come before To');
                        return;
                      }
                    }
                    widget.onSearch(_taskQueryParams);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
