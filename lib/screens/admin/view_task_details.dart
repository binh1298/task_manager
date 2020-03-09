import 'package:flutter/material.dart';
import 'package:task_manager/models/task_details.dart';
import 'package:task_manager/style/style.dart';

class ViewTaskDetailsScreen extends StatefulWidget {
  final int taskId;

  ViewTaskDetailsScreen({this.taskId});
  @override
  _ViewTaskDetailsScreenState createState() => _ViewTaskDetailsScreenState();
}

class _ViewTaskDetailsScreenState extends State<ViewTaskDetailsScreen> {
  Future<TaskDetails> taskDetails;

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
          return Card(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  Text(snapshot.data.name)
                ],
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
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}
