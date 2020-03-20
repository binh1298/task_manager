import 'package:flutter/material.dart';
import 'package:task_manager/components/buttons/button_confirm.dart';
import 'package:task_manager/components/cards/card_list_container.dart';
import 'package:task_manager/components/dropdowns/drop_down_button.dart';
import 'package:task_manager/components/form_fields/date_form_field.dart';
import 'package:task_manager/components/form_fields/text_form_field.dart';
import 'package:task_manager/models/task_query_params.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/snack_bar.dart';
import 'package:task_manager/utils/string_utils.dart';

class FormQueryTasks extends StatefulWidget {
  final Function onSearch;

  FormQueryTasks(this.onSearch);
  @override
  _FormQueryTasksState createState() => _FormQueryTasksState();
}

class _FormQueryTasksState extends State<FormQueryTasks> {
  final _formKeyQueryTasks = GlobalKey<FormState>();
  final TaskQueryParams _taskQueryParams = TaskQueryParams(status: taskStatuses[0]);
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
                          print(value);
                          _taskQueryParams.from = formatDate(value?.toString());
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
                          print(value);
                          _taskQueryParams.to = formatDate(value?.toString());
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
                      _taskQueryParams.status = value;
                    });
                  },
                  options: taskStatuses,
                ),
                TextFormFieldComponent(
                    title: 'Fullname',
                    onSaved: (value) {
                      setState(() {
                        _taskQueryParams.fullname = value;
                      });
                    }),
                ButtonConfirmComponent(
                  text: 'Search',
                  onPressed: () async {
                    final form = _formKeyQueryTasks.currentState;
                    if (!form.validate()) return;
                    form.save();
                    print('gaga $_taskQueryParams');
                    if (_taskQueryParams.from != null &&
                        _taskQueryParams.to != null) {
                      DateTime beginAt = DateTime.parse(_taskQueryParams.from);
                      DateTime endAt = DateTime.parse(_taskQueryParams.to);
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
