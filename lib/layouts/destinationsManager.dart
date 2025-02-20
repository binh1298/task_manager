import 'package:flutter/material.dart';
import 'package:task_manager/classes/view_navigation_observer.dart';
import 'package:task_manager/components/change_avatar_component.dart';
import 'package:task_manager/components/change_confirmation_img.dart';
import 'package:task_manager/screens/group/view_group_details.dart';
import 'package:task_manager/screens/not_found_screen.dart';
import 'package:task_manager/screens/task/create_task.dart';
import 'package:task_manager/screens/task/view_task_details.dart';
import 'package:task_manager/screens/user/view_user_details.dart';
import 'package:task_manager/utils/secure_storage.dart';
import '../classes/destination.dart';

class DestinationLayoutManager extends StatefulWidget {
  final Destination destination;
  final VoidCallback onNavigation;

  DestinationLayoutManager({Key key, this.destination, this.onNavigation})
      : super(key: key);

  @override
  _DestinationLayoutManagerState createState() =>
      _DestinationLayoutManagerState();
}

class _DestinationLayoutManagerState extends State<DestinationLayoutManager> {
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
          case '/changeAvatar':
            title = 'Change Avatar';
            body = ChangeAvatarComponent();
            break;
          case '/viewUserDetail':
            title = 'View User Detail';
            body = ViewUserDetailsScreen(userId: settings.arguments);
            break;
          case '/viewGroupDetails':
            title = 'View Group Detail';
            body = ViewGroupDetailsScreen(groupId: settings.arguments);
            break;
          case '/createTask':
            title = 'Create Task';
            body = CreateTaskScreen(sourceTaskId: settings.arguments);
            break;
          case '/viewTaskDetails':
            title = 'View Task Detail';
            body = ViewTaskDetailsScreen(taskId: settings.arguments);
            break;
          case '/updateConfirmationImg':
            title = 'Update Confirmation Img';
            body = ChangeConfirmationImageComponent();
            break;
          default:
            body = NotFoundScreen();
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
