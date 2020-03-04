import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_manager/classes/api_routes.dart';
import 'package:task_manager/utils/api_caller.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/utils/secure_storage.dart';
import 'package:task_manager/utils/snack_bar.dart';

class UserLoginCredentials {
  String username = '';
  String password = '';

  login(BuildContext context) async {
    final http.Response response = await apiCaller.post(
      body: jsonEncode(
        <String, String>{
          'username': username,
          'password': password,
        },
      ),
      route: apiRoutes.login,
    );
    bool success = response.statusCode == 200;
    if (success) {
      setJwtToken(json.decode(response.body)['token']);
    } else {
      showErrorSnackBar(context, json.decode(response.body)['message']);
    }
    return success;
  }
}

class UserCreateCredentials {
  String username;
  String password;
  String email;
  String confirmPassword;
  int roleId = 0;

  bool comparePassword() {
    return confirmPassword == password;
  }

  Future<bool> createUser(BuildContext context) async {
    final http.Response response = await apiCaller.post(
      route: apiRoutes.createAdminRoute(apiRoutes.createUsers),
      body: jsonEncode(
        <String, dynamic>{
          'username': username,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
          'roleId': roleId
        },
      ),
    );
    bool success = response.statusCode == 201;
    if (success) {
      print(json.decode(response.body)['userId']);
    } else {
      showErrorSnackBar(context, json.decode(response.body)['message']);
    }
    return success;
  }
}
