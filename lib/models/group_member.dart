import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_manager/utils/api_routes.dart';
import 'package:task_manager/utils/api_caller.dart';

class GroupMember {
  int groupMemberId;
  String memberId;
  String createdAt, updatedAt;

  GroupMember(
      {this.createdAt, this.groupMemberId, this.memberId, this.updatedAt});

  factory GroupMember.fromJson(dynamic json) {
    return GroupMember(
      groupMemberId: json['groupMemberId'] as int,
      memberId: json['memberId'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
}

Future<bool> addGroupMember(int groupId, String userId) async {
  http.Response response = await apiCaller.post(
    route: await createRoleRoute(apiRoutes.addGroupMember),
    body: jsonEncode(
      <String, dynamic>{
        'groupId': groupId,
        'memberId': userId,
      },
    ),
  );
  return (response.statusCode == 201);
}
