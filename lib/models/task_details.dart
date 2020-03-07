import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/classes/api_routes.dart';
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
      creatorId,
      assigneeId,
      confirmationImg;
  DateTime judgeCommentAt, beginAt, endAt, createdAt, updatedAt;

  TaskDetails(
      {this.createdAt,
      this.assigneeId,
      this.beginAt,
      this.confirmationImg,
      this.creatorId,
      this.endAt,
      this.handleProcess,
      this.id,
      this.judgeComment,
      this.judgeCommentAt,
      this.judgeId,
      this.judgeScore,
      this.name,
      this.requirement,
      this.sourceTaskId,
      this.status,
      this.updatedAt});

  Future<bool> createTask(BuildContext context) async {
    final http.Response response = await apiCaller.post(
      route: createAdminRoute(apiRoutes.createTask),
      body: jsonEncode(
        <String, String> {
          'name': name,
          'requirement': requirement,
          'judgeId': judgeId,
          'assigneeId' : assigneeId,
          'beginAt': beginAt.toString(),
          'endAt': endAt.toString(),
        }
      )
      
    );
    bool success = response.statusCode == 201;
    if (success) {
      print(json.decode(response.body)['task']);
    } else {
      showErrorSnackBar(context, json.decode(response.body)['message']);
    }
    return success;

  }
}


Future<List<TaskDetails>> fetchTasksList() {

}