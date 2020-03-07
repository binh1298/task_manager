import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/restart_app.dart';
import 'package:task_manager/screens/admin/home.dart';
import 'package:task_manager/screens/login.dart';
import 'package:task_manager/utils/secure_storage.dart';

void main() async {
  await DotEnv().load('.env');
  UserDetails user = await getUserFromToken();
  if (user != null)
    runApp(RestartWidget(
          child: MyApp(
        user: user,
      ),
    ));
  else
    runApp(RestartWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final UserDetails user;
  MyApp({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:
          (user != null && user.roleName == 'admin') ? '/admin' : '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/admin': (context) => HomeScreen(),
      },
    );
  }
}
