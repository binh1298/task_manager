import 'package:flutter/material.dart';
import 'package:task_manager/classes/view_navigation_observer.dart';
import 'package:task_manager/screens/admin/create_user.dart';
import '../classes/destination.dart';

class DestinationLayout extends StatefulWidget {
  final Destination destination;
  final VoidCallback onNavigation;

  DestinationLayout({Key key, this.destination, this.onNavigation}) : super(key: key);

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
          default:
            body = CreateUserScreen();
            break;
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: Text(settings.name == '/' ? widget.destination.title : title),
              ),
              body: body,
            );
          },
        );
      },
    );
  }
}
