import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/utils/api_routes.dart';
import 'package:task_manager/models/task_query_params.dart';
import 'package:task_manager/utils/api_caller.dart';
import 'package:task_manager/utils/snack_bar.dart';

class TaskDetails {
  int id, sourceTaskId, judgeScore;
  String name,
      requirement,
      handleProcess,
      judgeId,
      judgeComment,
      status,
      judgeStatus,
      creatorId,
      assigneeId,
      confirmationImg,
      submitDescription;
  String judgeCommentAt, beginAt, endAt, createdAt, updatedAt;
  String creatorFullname, judgeFullname, assigneeFullname;

  TaskDetails({
    this.createdAt,
    this.assigneeId,
    this.beginAt,
    this.confirmationImg,
    this.creatorId,
    this.endAt,
    this.handleProcess,
    this.submitDescription,
    this.id,
    this.judgeComment,
    this.judgeCommentAt,
    this.judgeId,
    this.judgeScore,
    this.name,
    this.requirement,
    this.sourceTaskId,
    this.status,
    this.judgeStatus,
    this.updatedAt,
    this.creatorFullname,
    this.assigneeFullname,
    this.judgeFullname,
  });

  TaskDetails.clone(TaskDetails oldDetails) : this(
    createdAt: oldDetails.createdAt,
    assigneeId: oldDetails.assigneeId,
    beginAt: oldDetails.beginAt,
    confirmationImg: oldDetails.confirmationImg,
    creatorId: oldDetails.creatorId,
    endAt: oldDetails.endAt,
    handleProcess: oldDetails.handleProcess,
    submitDescription: oldDetails.submitDescription,
    id: oldDetails.id,
    judgeComment: oldDetails.judgeComment,
    judgeCommentAt: oldDetails.judgeCommentAt,
    judgeId: oldDetails.judgeId,
    judgeScore: oldDetails.judgeScore,
    name: oldDetails.name,
    requirement: oldDetails.requirement,
    sourceTaskId: oldDetails.sourceTaskId,
    status: oldDetails.status,
    judgeStatus: oldDetails.judgeStatus,
    updatedAt: oldDetails.updatedAt,
    creatorFullname: oldDetails.creatorFullname,
    assigneeFullname: oldDetails.assigneeFullname,
    judgeFullname: oldDetails.judgeFullname,
  );

  factory TaskDetails.fromJson(dynamic json) {
    return TaskDetails(
      id: json['id'] as int,
      name: json['name'] as String,
      sourceTaskId: json['sourceTaskId'] as int,
      status: json['status'] as String,
      judgeStatus: json['judgeStatus'] as String,
      beginAt: json['beginAt'] as String,
      endAt: json['endAt'] as String,
      requirement: json['requirement'] as String,
      handleProcess: json['handleProcess'] as String,
      submitDescription: json['submitDescription'] as String,
      judgeComment: json['judgeComment'] as String,
      judgeCommentAt: json['judgeCommentAt'] as String,
      judgeScore: json['judgeScore'] as int,
      judgeId: json['judgeId'] as String,
      creatorId: json['creatorId'] as String,
      assigneeId: json['assigneeId'] as String,
      confirmationImg: json['confirmationImg'] as String,
      //Addons
      creatorFullname: json['creatorFullname'] as String,
      assigneeFullname: json['assigneeFullname'] as String,
      judgeFullname: json['judgeFullname'] as String,
    );
  }
  Future<bool> createTask(BuildContext context) async {
    final http.Response response = await apiCaller.post(
        route: await createRoleRoute(apiRoutes.createTask),
        body: jsonEncode(<String, String>{
          'name': name,
          'requirement': requirement,
          'judgeId': judgeId,
          'assigneeId': assigneeId,
          'beginAt': beginAt,
          'endAt': endAt,
          'taskStatus': status,
          'sourceTaskId': sourceTaskId?.toString(),
        }));
    bool success = response.statusCode == 201;
    print(response.body);
    if (success) {
      print(json.decode(response.body)['task']);
    } else {
      showErrorSnackBar(context, json.decode(response.body)['message']);
    }
    return success;
  }

  Future<bool> updateTask(BuildContext context, int taskId) async {
    print('gege $status');
    final http.Response response = await apiCaller.put(
        route: '${await createRoleRoute(apiRoutes.updateTask)}/$taskId',
        body: jsonEncode(<String, dynamic>{
          'name': name,
          'requirement': requirement,
          'handleProcess': handleProcess,
          'judgeId': judgeId,
          'judgeComment': judgeComment,
          'judgeScore': judgeScore,
          'assigneeId': assigneeId,
          'beginAt': beginAt,
          'endAt': endAt,
          'taskStatus': status,
          'judgeStatus': judgeStatus,
          'confirmationImg': confirmationImg,
          'submitDescription': submitDescription,
        }));
    bool success = response.statusCode == 200;
    print(response.body);
    if (success) {
      print(json.decode(response.body)['task']);
    } else {
      showErrorSnackBar(context, json.decode(response.body)['message']);
    }
    return success;
  }
}

Future<TaskDetails> fetchTaskDetails(int taskId) async {
  final http.Response response = await apiCaller.get(
      route: await createRoleRoute('${apiRoutes.getTasks}/$taskId'));
  print(response.body);
  if (response.statusCode == 200) {
    var taskDetailsJson = json.decode(response.body)['task'];
    return TaskDetails.fromJson(taskDetailsJson);
  } else
    return null;
}

Future<List<TaskDetails>> fetchTasksList(
  String route,
  TaskQueryParams taskQueryParams,
) async {
  final http.Response response =
      await apiCaller.get(route: route, queryParams: taskQueryParams?.toMap());
  if (response.statusCode == 200) {
    var userDetailsListJson = json.decode(response.body)['tasks'] as List;
    return userDetailsListJson
        .map((userDetails) => TaskDetails.fromJson(userDetails))
        .toList();
  } else {
    return null;
  }
}

Future<List<TaskDetails>> fetchTasksToJudge(TaskQueryParams taskQueryParams) async {
  return fetchTasksList(await createRoleRoute(apiRoutes.getTasksToJudge), taskQueryParams);
}

Future<List<TaskDetails>> fetchTasksToSubmit(TaskQueryParams taskQueryParams) async {
  return fetchTasksList(await createRoleRoute(apiRoutes.getTasksToSubmit), taskQueryParams);
}

Future<List<TaskDetails>> fetchTaskHistory(TaskQueryParams taskQueryParams) async {
  return fetchTasksList(await createRoleRoute(apiRoutes.getTasksHistory), taskQueryParams);
}