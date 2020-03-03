import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:task_manager/screens/admin/home.dart';
import 'package:task_manager/screens/login.dart';
void main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      initialRoute: '/login',
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