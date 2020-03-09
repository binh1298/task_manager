import 'package:task_manager/utils/secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final apiUrl = DotEnv().env['API_URL'];

class ApiCaller {
  post({String body, String route}) async {
    print('POST $apiUrl$route');
    String token = await getJwtToken();
    http.Response response = await http.post(
      '$apiUrl$route',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    // print('POST $apiUrl$route ${response.body}');
    return response;
  }

  get({String route}) async {
    print('GET $apiUrl$route');
    String token = await getJwtToken();
    http.Response response = await http.get(
      '$apiUrl$route',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    // print('GET $apiUrl$route ${response.body}');
    return response;
  }

  patch({String route, dynamic body}) async {
    print('PATCH $apiUrl$route');
    String token = await getJwtToken();
    http.Response response = await http.patch(
      '$apiUrl$route',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    // print('PATCH $apiUrl$route ${response.body}');
  }
}

final apiCaller = ApiCaller();
