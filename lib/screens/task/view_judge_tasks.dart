import 'package:flutter/material.dart';
import 'package:task_manager/components/cards/card_task_list_item.dart';
import 'package:task_manager/components/form_query_tasks.dart';
import 'package:task_manager/models/task_details.dart';
import 'package:task_manager/models/task_query_params.dart';
import 'package:task_manager/utils/snack_bar.dart';

class ViewJudgeTasksScreen extends StatefulWidget {
  @override
  _ViewJudgeTasksScreenState createState() => _ViewJudgeTasksScreenState();
}

class _ViewJudgeTasksScreenState extends State<ViewJudgeTasksScreen> {
  Future<List<TaskDetails>> tasksDetailsList;
  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  Future<Null> refreshList({TaskQueryParams taskQueryParams}) async {
    refreshKey.currentState?.show(atTop: true);
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      tasksDetailsList = fetchTasksToJudge(taskQueryParams);
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
              return Column(
                children: <Widget>[
                  FormQueryTasks((TaskQueryParams taskQueryParams) { 
                    refreshList(taskQueryParams: taskQueryParams);
                  }),
                  Expanded(
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      children: snapshot.data
                          .map(
                            (taskDetails) => CardTaskListItem(
                              id: taskDetails.id,
                              name: taskDetails.name,
                              sourceTaskId: taskDetails.sourceTaskId,
                              status: taskDetails.status,
                              beginAt: taskDetails.beginAt,
                              endAt: taskDetails.endAt,
                              refreshList: refreshList,
                            ),
                          )
                          .toList(),
                    ),
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
