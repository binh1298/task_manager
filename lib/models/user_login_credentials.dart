import 'dart:convert';
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
      route: '/login',
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['token'];
    } else {
      return null;
    }
  }
}
