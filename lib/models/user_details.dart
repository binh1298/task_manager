import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:task_manager/utils/api_routes.dart';
import 'package:task_manager/utils/api_caller.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/utils/authorization.dart';

class UserDetails {
  String userId, username, avatar, email, fullname, roleName;
  bool isDeleted;

  UserDetails({
    this.email = '',
    this.fullname = '',
    // this.phoneNumber = '',
    this.username = '',
    this.avatar = '',
    this.roleName = '',
    this.userId = '',
    this.isDeleted = false,
  });

  factory UserDetails.fromJson(dynamic json) {
    return UserDetails(
      avatar: json['avatar'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      fullname: json['fullname'] as String,
      // phoneNumber: json['phoneNumber'] as String,
      roleName: json['roleName'] as String,
      isDeleted: json['isDeleted'] as bool,
    );
  }
}

// GET
Future<UserDetails> fetchUserDetails(String userId) async {
  final http.Response response = await apiCaller.get(
      route: '${await createRoleRoute(apiRoutes.getUserProfile)}/$userId');
  if (response.statusCode == 200) {
    var userDetailsJson = json.decode(response.body)['user'];
    return UserDetails.fromJson(userDetailsJson);
  } else
    return null;
}

Future<UserDetails> fetchManagerOrAdminDetails(String userId) async {
  final http.Response response = await apiCaller.get(
      route: '${await createRoleRoute(apiRoutes.getManagerOrAdminDetails)}/$userId');
  if (response.statusCode == 200) {
    var userDetailsJson = json.decode(response.body)['user'];
    return UserDetails.fromJson(userDetailsJson);
  } else
    return null;
}

Future<UserDetails> fetchManagerOrEmployeeDetails(String userId) async {
  final http.Response response = await apiCaller.get(
      route: '${await createRoleRoute(apiRoutes.getManagerOrEmployeeDetails)}/$userId');
  if (response.statusCode == 200) {
    var userDetailsJson = json.decode(response.body)['user'];
    return UserDetails.fromJson(userDetailsJson);
  } else
    return null;
}

Future<UserDetails> fetchUserProfile(BuildContext context) async {
  final http.Response response =
      await apiCaller.get(route: await createRoleRoute(apiRoutes.getUserProfile));
  if (response.statusCode == 200) {
    var userDetailsJson = json.decode(response.body)['user'];
    return UserDetails.fromJson(userDetailsJson);
  } else {
    logout(context);
    return null;
  }
}

Future<List<UserDetails>> fetchUsersDetailsList() async {
  final http.Response response =
      await apiCaller.get(route: await createRoleRoute(apiRoutes.getUsers));
  if (response.statusCode == 200) {
    var userDetailsListJson = json.decode(response.body)['result'] as List;
    return userDetailsListJson
        .map((userDetails) => UserDetails.fromJson(userDetails))
        .toList();
  } else {
    return null;
  }
}

Future<List<UserDetails>> fetchGroupMembersDetailsList(int groupId) async {
  final http.Response response =
      await apiCaller.get(route: await createRoleRoute('${apiRoutes.getGroupMembers}/$groupId'));
  if (response.statusCode == 200) {
    var userDetailsListJson = json.decode(response.body)['result'] as List;
    var userDetailsList = userDetailsListJson
        .map((userDetails) => UserDetails.fromJson(userDetails))
        .toList();
    return userDetailsList;
  } else {
    return null;
  }
}

// PATCH
Future<bool> deleteUser(String userId, bool newIsDeleted) async {
  final http.Response response = await apiCaller.patch(
    route: await createRoleRoute(apiRoutes.deleteUser),
    body: jsonEncode(
      <String, dynamic>{
        'userId': userId,
        'isDeleted': newIsDeleted,
      },
    ),
  );
  return response.statusCode == 200;
}

Future<bool> patchAvatarUser(String userId, String avatarUrl) async {
  final http.Response response = await apiCaller.patch(
    route: await createRoleRoute(apiRoutes.changeAvatar),
    body: jsonEncode(
      <String, dynamic>{
        'userId': userId,
        'avatarUrl': avatarUrl,
      },
    ),
  );
  return response.statusCode == 200;
}