import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_manager/classes/api_routes.dart';
import 'package:task_manager/utils/api_caller.dart';

class GroupDetails {
  String groupName, managerName;
  int numberOfMembers;

  GroupDetails({this.groupName, this.managerName, this.numberOfMembers});

  factory GroupDetails.fromJson(dynamic json) {
    return GroupDetails(
      groupName: json['groupName'] as String,
      managerName: json['managerName'] as String,
      numberOfMembers: json['numberOfMembers'] as int,
    );
  }
}

Future<List<GroupDetails>> fetchGroupDetailsList() async {
  final http.Response response = await apiCaller.get(route: apiRoutes.getGroups);

  GroupDetails test1 = GroupDetails(groupName: 'test', numberOfMembers: 10, managerName: 'test manager');
  GroupDetails test2 = GroupDetails(groupName: 'test', numberOfMembers: 10, managerName: 'test manager');
  GroupDetails test3 = GroupDetails(groupName: 'test', numberOfMembers: 10, managerName: 'test manager');
  List<GroupDetails> test = new List<GroupDetails>();

  test.add(test1);
  test.add(test2);
  test.add(test3);
  return test;
  // if (response.statusCode == 200) {
  //   var groupDetailsListJson = json.decode(response.body)['result'] as List;
  //   return groupDetailsListJson
  //       .map((groupDetails) => GroupDetails.fromJson(groupDetails));
  // }
}
