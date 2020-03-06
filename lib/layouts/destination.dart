import 'package:flutter/material.dart';
import 'package:task_manager/classes/view_navigation_observer.dart';
import 'package:task_manager/screens/admin/create_group.dart';
import 'package:task_manager/screens/admin/create_user.dart';
import 'package:task_manager/screens/admin/view_group_details.dart';
import 'package:task_manager/screens/admin/view_user_profile.dart';
import 'package:task_manager/utils/secure_storage.dart';
import '../classes/destination.dart';

class DestinationLayout extends StatefulWidget {
  final Destination destination;
  final VoidCallback onNavigation;

  DestinationLayout({Key key, this.destination, this.onNavigation})
      : super(key: key);

  @override
  _DestinationLayoutState createState() => _DestinationLayoutState();
}

class _DestinationLayoutState extends State<DestinationLayout> {
  String title = '';
  @override
  Widget build(BuildContext context) {
    return Navigator(
      observers: <NavigatorObserver>[
        ViewNavigatorObserver(widget.onNavigation),
      ],
      onGenerateRoute: (RouteSettings settings) {
        Widget body;
        switch (settings.name) {
          case '/':
            body = widget.destination.component;
            break;
          case '/createUser':
            title = 'Create User';
            body = CreateUserScreen();
            break;
          case '/viewUserDetail':
            title = 'View User Detail';
            body = ViewUserProfileScreen(userId: settings.arguments);
            break;
          case '/createGroup':
            title = 'Create Group';
            body = CreateGroupScreen();
            break;
          case 'viewGroupDetail':
            title = 'View Group Detail';
            body = ViewGroupDetailsScreen(groupId: settings.arguments);
            break;
          default:
            body = CreateUserScreen();
            break;
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return FutureBuilder(
              future: getJwtToken(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(settings.name == '/'
                          ? widget.destination.title
                          : title),
                    ),
                    body: body,
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error);
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
        );
      },
    );
  }
}
