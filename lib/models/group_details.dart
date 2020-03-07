import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_manager/classes/api_routes.dart';
import 'package:task_manager/utils/api_caller.dart';

class GroupDetails {
  String groupName, managerName, managerId;

  GroupDetails({this.groupName, this.managerName, this.managerId});

  factory GroupDetails.fromJson(dynamic json) {
    return GroupDetails(
      groupName: json['name'] as String,
      managerName: json['managerName'] as String,
      managerId: json['managerId'] as String,
    );
  }
}

Future<GroupDetails> fetchGroupDetails(groupId) async {
  final http.Response response = await apiCaller.get(
      route: createAdminRoute('${apiRoutes.getGroups}/$groupId'));

  if (response.statusCode == 200) {
    var groupDetailsJson = json.decode(response.body)['group'];
    return GroupDetails.fromJson(groupDetailsJson);
  } else
    return null;
}

Future<List<GroupDetails>> fetchGroupDetailsList() async {
  final http.Response response =
      await apiCaller.get(route: createAdminRoute(apiRoutes.getGroups));

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
