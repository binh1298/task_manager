import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/screens/admin/home.dart';
import 'package:task_manager/screens/login.dart';
import 'package:task_manager/utils/secure_storage.dart';
void main() async {
  await DotEnv().load('.env');
  String token = await getJwtToken();
  final userJson = parseJwt(token);
  final UserDetails user = UserDetails.fromJson(userJson);
  runApp(MyApp(user: user));
}
class MyApp extends StatelessWidget {
  final UserDetails user;
  MyApp({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      initialRoute: (user != null && user.roleName == 'admin') ? '/admin' : '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/admin': (context) => HomeScreen(),

        // Admin
        // '/userList': (context) => ViewUsersScreen(),
        // '/viewUserInfo': (context) => ViewUserInfo(),
        // '/createUser': (context) => CreateUserScreen(),
        // '/createGroup': (context) => CreateGroupScreen(),
        
      },
    );
  }
}