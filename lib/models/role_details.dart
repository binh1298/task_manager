import 'dart:convert';
import 'package:task_manager/utils/api_caller.dart';
import 'package:http/http.dart' as http;

class Role {
  String roleName;
  int roleId;

  Role({this.roleName, this.roleId});

  factory Role.fromJson(dynamic json) {
    return Role(
      roleName: json['roleName'] as String,
      roleId: json['roleId'] as int,
    );
  }
}

Future<List<Role>> fetchRolesList() async {
  final http.Response response = await apiCaller.get(route: '/');
  Role admin = Role(roleName: 'admin', roleId: 0);
  Role manager = Role(roleName: 'manager', roleId: 2);
  Role employee = Role(roleName: 'employee', roleId: 1);
  List<Role> roles = new List<Role>();
  roles.add(admin);
  roles.add(manager);
  roles.add(employee);
  return roles;
  if (response.statusCode == 200) {
    var rolesListJson = json.decode(response.body)['result'] as List;
    return rolesListJson.map((role) => Role.fromJson(role));
  } else
    return null;
}

List<Role> fetchRolesListSync() {
  Role admin = Role(roleName: 'admin', roleId: 0);
  Role manager = Role(roleName: 'manager', roleId: 2);
  Role employee = Role(roleName: 'employee', roleId: 1);
  List<Role> roles = new List<Role>();
  roles.add(admin);
  roles.add(manager);
  roles.add(employee);
  return roles;
}
