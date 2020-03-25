import 'dart:io';

import 'package:task_manager/utils/secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final apiUrl = DotEnv().env['API_URL'];

class ApiCaller {
  post({String body, String route}) async {
    String token = await getJwtToken();
    var uri = Uri.http(apiUrl, route);
    print('POST $uri');
    http.Response response = await http.post(
      uri,
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: body,
    );
    // print('POST $uri ${response.body}');
    return response;
  }

  get({String route, Map<String, String> queryParams}) async {
    String token = await getJwtToken();
    var uri = Uri.http(apiUrl, route, queryParams);
    print('GET $uri');
    http.Response response = await http.get(
      uri,
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    print('GET $uri ${response.body}');
    return response;
  }

  put({String route, dynamic body}) async {
    String token = await getJwtToken();
    var uri = Uri.http(apiUrl, route);
    print('PUT $uri $body');
    http.Response response = await http.put(
      uri,
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: body,
    );
    // print('PUT $uri ${response.body}');
    return response;
  }
}

final apiCaller = ApiCaller();
