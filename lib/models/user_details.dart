import 'dart:convert';
import 'package:task_manager/classes/api_routes.dart';
import 'package:task_manager/utils/api_caller.dart';
import 'package:http/http.dart' as http;

class UserDetails {
  String userId, username, avatar, email, fullname, phoneNumber, roleName;

  UserDetails(
      {this.email = '',
      this.fullname = '',
      this.phoneNumber = '',
      this.username = '',
      this.avatar = '', 
      this.roleName = '',
      this.userId = ''
      });

  factory UserDetails.fromJson(dynamic json) {
    return UserDetails(
      avatar: json['avatar'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      fullname: json['fullname'] as String,
      phoneNumber: json['phoneNumber'] as String,
      roleName: json['roleName'] as String,
    );
  }
}

Future<List<UserDetails>> fetchUsersDetailsList() async {
  final http.Response response =
      await apiCaller.get(route: apiRoutes.createAdminRoute(apiRoutes.getUsers));
  if (response.statusCode == 200) {
    var userDetailsListJson = json.decode(response.body)['result'] as List;
    return userDetailsListJson.map((userDetails) => UserDetails.fromJson(userDetails)).toList();
  } else {
    return null;
  }
}
