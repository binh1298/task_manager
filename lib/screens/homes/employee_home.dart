import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:task_manager/layouts/destinationsEmployee.dart';
import 'package:task_manager/screens/admin/view_personal_tasks.dart';
import 'package:task_manager/screens/admin/view_profile.dart';
import 'package:task_manager/screens/view_assigned_tasks.dart';
import 'package:task_manager/style/style.dart';
import '../../classes/destination.dart';

List<Destination> employeeDestinations = <Destination>[
  Destination('Assigned Tasks', Icons.library_books, AssignedTasksScreen()),
  Destination('My Tasks', Icons.event_note, PersonalTasksScreen()),
  Destination('Profile', Icons.person, ViewProfileScreen()),
];

class EmployeeHomeScreen extends StatefulWidget {
  @override
  _EmployeeHomeScreenState createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen>
    with TickerProviderStateMixin<EmployeeHomeScreen> {
  int _currentIndex = 1;
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
            children: employeeDestinations.map<Widget>((Destination destination) {
              return DestinationLayoutEmployee(
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
            items: employeeDestinations.map((Destination destination) {
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
