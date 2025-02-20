import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/restart_app.dart';
import 'package:task_manager/screens/homes/admin_home.dart';
import 'package:task_manager/screens/homes/employee_home.dart';
import 'package:task_manager/screens/homes/manager_home.dart';
import 'package:task_manager/screens/login.dart';
import 'package:task_manager/utils/secure_storage.dart';

void main() async {
  await DotEnv().load('.env');
  UserDetails user = await getUserFromToken();
  print('user: $user');
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
    String initialRoute = '/login';
    if (user != null) {
      initialRoute = '/${user.roleName}';
    }
    print(initialRoute);
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initialRoute,
      routes: {
        '/admin': (context) => FutureBuilder<UserDetails>(
            future: getUserFromToken(),
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return AdminHomeScreen();
              else
                return LoginScreen();
            }),
        '/manager': (context) => FutureBuilder<UserDetails>(
            future: getUserFromToken(),
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return ManagerHomeScreen();
              else
                return LoginScreen();
            }),
        '/employee': (context) => FutureBuilder<UserDetails>(
            future: getUserFromToken(),
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return EmployeeHomeScreen();
              else
                return LoginScreen();
            }),
        '/login': (context) => LoginScreen(),
        // '/admin': (context) => AdminHomeScreen(),
        // '/manager': (context) => ManagerHomeScreen(),
        // '/employee': (context) => EmployeeHomeScreen(),
      },
    );
  }
}
