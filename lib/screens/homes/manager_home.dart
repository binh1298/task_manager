import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:task_manager/layouts/destinationsManager.dart';
import 'package:task_manager/screens/group/view_groups.dart';
import 'package:task_manager/screens/task/view_assigned_tasks.dart';
import 'package:task_manager/screens/task/view_judge_tasks.dart';
import 'package:task_manager/screens/task/view_task_history.dart';
import 'package:task_manager/screens/user/view_profile.dart';
import 'package:task_manager/style/style.dart';
import '../../classes/destination.dart';

List<Destination> managerDestinations = <Destination>[
  Destination('Groups', Icons.group, ViewGroupsScreen()),
  Destination('Assigned Tasks', Icons.event_note, AssignedTasksScreen()),
  Destination('My Tasks', Icons.event_note, ViewTaskHistoryScreen()),
  Destination('Judge Tasks', Icons.library_books, ViewJudgeTasksScreen()),
  Destination('Profile', Icons.person, ViewProfileScreen()),
];

class ManagerHomeScreen extends StatefulWidget {
  @override
  _ManagerHomeScreenState createState() => _ManagerHomeScreenState();
}

class _ManagerHomeScreenState extends State<ManagerHomeScreen>
    with TickerProviderStateMixin<ManagerHomeScreen> {
  int _currentIndex = 2;
  AnimationController _hide;

  @override
  void initState() {
    super.initState();
    _hide = AnimationController(vsync: this, duration: kThemeAnimationDuration);
  }

  @override
  void dispose() {
    _hide.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            // _hide.forward();
            break;
          case ScrollDirection.reverse:
            // _hide.reverse();
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: IndexedStack(
            index: _currentIndex,
            children: managerDestinations.map<Widget>((Destination destination) {
              return DestinationLayoutManager(
                destination: destination,
                onNavigation: () {
                  _hide.forward();
                },
              );
            }).toList(),
          ),
        ),
        bottomNavigationBar: SizeTransition(
          sizeFactor: _hide,
          axisAlignment: -1.0,
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            showUnselectedLabels: true,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            selectedItemColor: Colors.black,
            items: managerDestinations.map((Destination destination) {
              return BottomNavigationBarItem(
                backgroundColor: colorPrimary,
                icon: Icon(destination.iconData),
                title: Text(
                  destination.title,
                  style: textStyleSmall,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
