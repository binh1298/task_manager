import 'package:flutter/material.dart';
import 'package:task_manager/components/cards/card_task_list_item.dart';
import 'package:task_manager/models/task_details.dart';
import 'package:task_manager/utils/snack_bar.dart';

class ViewTasksScreen extends StatefulWidget {
  @override
  _ViewTasksScreenState createState() => _ViewTasksScreenState();
}

class _ViewTasksScreenState extends State<ViewTasksScreen> {
  Future<List<TaskDetails>> tasksDetailsList;
  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: true);
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      tasksDetailsList = fetchTasksList();
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
