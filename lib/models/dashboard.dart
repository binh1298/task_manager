import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_manager/utils/api_routes.dart';
import 'package:task_manager/utils/api_caller.dart';

class UsersDashboardInfo {
  String roleName;
  int count;
  UsersDashboardInfo(this.roleName, this.count);

  factory UsersDashboardInfo.fromJson(dynamic json) {
    return UsersDashboardInfo(
      json['roleName'] as String,
      json['count'] as int,
    );
  }
}

class TasksDashboardInfo {
  String taskStatus;
  int count;
  TasksDashboardInfo(this.taskStatus, this.count);

  factory TasksDashboardInfo.fromJson(dynamic json) {
    return TasksDashboardInfo(
      json['taskStatus'] as String,
      json['count'] as int,
    );
  }
}

class Dashboard {
  List<UsersDashboardInfo> usersDashboardInfo;
  List<TasksDashboardInfo> tasksDashboardInfo;
  int groups;

  Dashboard(this.usersDashboardInfo, this.tasksDashboardInfo, this.groups);
  factory Dashboard.fromJson(dynamic json) {
    var listOfUsersJson = json['users'] as List;
    var listOfTasksJson = json['tasks'] as List;

    List<UsersDashboardInfo> listOfUsersDashboardInfo = listOfUsersJson.map(
        (usersDashboardInfo) =>
            UsersDashboardInfo.fromJson(usersDashboardInfo)).toList();
    List<TasksDashboardInfo> listOfTasksDashboardInfo = listOfTasksJson.map(
        (tasksDashboardInfo) =>
            TasksDashboardInfo.fromJson(tasksDashboardInfo)).toList();

    return Dashboard(
      listOfUsersDashboardInfo,
      listOfTasksDashboardInfo,
      json['groups'],
    );
  }
}

Future<Dashboard> fetchDashboard() async {
  http.Response response = await apiCaller.get(route: await createRoleRoute(apiRoutes.dashboard));
  if(response.statusCode != 200) return null;
  Dashboard dashboard = Dashboard.fromJson(json.decode(response.body));
  return dashboard;
}