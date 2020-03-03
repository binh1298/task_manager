import 'dart:convert';
import 'package:task_manager/classes/api_routes.dart';
import 'package:task_manager/utils/api_caller.dart';
import 'package:http/http.dart' as http;

class UserLoginCredentials {
  String username = '';
  String password = '';

  login() async {
    final http.Response response = await apiCaller.post(
      body: jsonEncode(
        <String, String>{
          'username': username,
          'password': password,
        },
      ),
      route: apiRoutes.login,
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['token'];
    } else {
      return null;
    }
  }
}

class UserCreateCredentials {
  String username;
  String password;
  String email;
  String confirmPassword;

  Future<bool> createUser() async {
    final http.Response response = await apiCaller.post(
      route: apiRoutes.createAdminRoute(apiRoutes.createUsers),
      body: jsonEncode(
        <String, String>{
          'username': username,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      ),
    );
    return (response.statusCode == 201);
  }
}