import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_manager/utils/api_routes.dart';
import 'package:task_manager/utils/api_caller.dart';

class GroupDetails {
  int groupId;
  String groupName;
  String createdAt;
  bool isDeleted;
  String managerName,
      managerId,
      username,
      avatar,
      email,
      fullname,
      // phoneNumber,
      roleName;
  int roleId;

  GroupDetails(
      {this.groupName,
      this.groupId,
      this.managerName,
      this.managerId,
      this.isDeleted,
      this.avatar,
      this.createdAt, 
      this.email,
      this.fullname,
      // this.phoneNumber,
      this.roleId,
      this.roleName,
      this.username});

  factory GroupDetails.fromJson(dynamic json) {
    return GroupDetails(
      groupId: json['id'] as int,
      groupName: json['name'] as String,
      managerId: json['managerId'] as String,
      isDeleted: json['isDeleted'] as bool,
      email: json['email'] as String,
      fullname: json['fullname'] as String,
      // phoneNumber: json['phoneNumber'] as String,
      roleId: json['roleId'] as int,
      roleName: json['roleName'] as String,
      //Add ons
      username: json['username'] as String,
      managerName: json['fullname'] as String,
      avatar: json['avatar'] as String,
    );
  }

  Future<GroupDetails> createGroup() async {
    final http.Response response = await apiCaller.post(
      route: await createRoleRoute(apiRoutes.createGroup),
      body: jsonEncode(
        <String, dynamic>{
          'name': groupName,
          'managerId': managerId,
        },
      ),
    );
    if (response.statusCode == 201) {
      var groupDetailsJson = json.decode(response.body)['group'];
      return GroupDetails.fromJson(groupDetailsJson);
    } else
      return null;
  }
}

Future<GroupDetails> fetchGroupDetails(groupId) async {
  final http.Response response = await apiCaller.get(
      route: await createRoleRoute('${apiRoutes.getGroups}/$groupId'));
  if (response.statusCode == 200) {
    var groupDetailsJson = json.decode(response.body)['result'];
    return GroupDetails.fromJson(groupDetailsJson);
  } else
    return null;
}

Future<List<GroupDetails>> fetchGroupDetailsList() async {
  final http.Response response =
      await apiCaller.get(route: await createRoleRoute(apiRoutes.getGroups));

  // GroupDetails test1 = GroupDetails(groupName: 'test', numberOfMembers: 10, managerName: 'test manager');
  // GroupDetails test2 = GroupDetails(groupName: 'test', numberOfMembers: 10, managerName: 'test manager');
  // GroupDetails test3 = GroupDetails(groupName: 'test', numberOfMembers: 10, managerName: 'test manager');
  // List<GroupDetails> test = new List<GroupDetails>();

  // test.add(test1);
  // test.add(test2);
  // test.add(test3);
  // return test;

  if (response.statusCode == 200) {
    var groupDetailsListJson = json.decode(response.body)['result'] as List;
    return groupDetailsListJson
        .map((groupDetails) => GroupDetails.fromJson(groupDetails))
        .toList();
  } else
    return null;
}
