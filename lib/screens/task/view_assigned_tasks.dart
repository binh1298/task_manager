import 'package:flutter/material.dart';
import 'package:task_manager/components/cards/card_task_list_item.dart';
import 'package:task_manager/components/form_query_tasks.dart';
import 'package:task_manager/models/task_details.dart';
import 'package:task_manager/models/task_query_params.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/snack_bar.dart';
import 'package:task_manager/utils/string_utils.dart';

class AssignedTasksScreen extends StatefulWidget {
  @override
  _AssignedTasksScreenState createState() => _AssignedTasksScreenState();
}

class _AssignedTasksScreenState extends State<AssignedTasksScreen> {
  TaskQueryParams _taskQueryParams;
  Future<List<TaskDetails>> tasksDetailsList;
  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    tasksDetailsList = fetchTasksToSubmit(_taskQueryParams);
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: true);
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      tasksDetailsList = fetchTasksToSubmit(_taskQueryParams);
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'CreateTask',
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/createTask');
          if (result != null) {
            refreshList();
            showInfoSnackBar(context, 'Created Task Successfully!');
          }
        },
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        key: refreshKey,
        child: FutureBuilder<List<TaskDetails>>(
          future: tasksDetailsList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  FormQueryTasks((TaskQueryParams taskQueryParams) {
                    setState(() {
                      _taskQueryParams = taskQueryParams;
                    });
                    refreshList();
                  }, TaskTypesForQuery.judge),
                  (snapshot.data.length > 0)
                      ? Column(
                          children: snapshot.data
                              .map(
                                (taskDetails) => CardTaskListItem(
                                  id: taskDetails.id,
                                  name: taskDetails.name,
                                  sourceTaskId: taskDetails.sourceTaskId,
                                  status: taskDetails.status,
                                  judgeFullname: taskDetails.judgeFullname,
                                  creatorFullname: taskDetails.creatorFullname,
                                  assigneeFullname: taskDetails.assigneeFullname,
                                  beginAt: taskDetails.beginAt,
                                  endAt: taskDetails.endAt,
                                  refreshList: refreshList,
                                ),
                              )
                              .toList(),
                        )
                      : Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                                child: Text(
                              'No Task Found',
                              style: textStyleTitle,
                            )),
                          ],
                        ),
                ],
              );
            } else if (snapshot.hasError) {
              return ListView(
                children: <Widget>[
                  Center(
                    child: Text('${snapshot.error}'),
                  ),
                ],
              );
            }
            return ListView(
              children: <Widget>[
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
