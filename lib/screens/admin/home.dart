import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:task_manager/layouts/destination.dart';
import 'package:task_manager/screens/admin/view_groups.dart';
import 'package:task_manager/screens/admin/view_profile.dart';
import 'package:task_manager/screens/admin/view_tasks.dart';
import 'package:task_manager/screens/admin/view_users.dart';
import 'package:task_manager/style/style.dart';
import '../../classes/destination.dart';

List<Destination> adminDestinations = <Destination>[
  Destination('Users', Icons.person, ViewUsersScreen()),
  Destination('Groups', Icons.group, ViewGroupsScreen()),
  Destination('Tasks', Icons.event_note, ViewTasksScreen()),
  Destination('History', Icons.library_books, ViewTasksScreen()),
  Destination('Profile', Icons.person, ViewProfileScreen()),
];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin<HomeScreen> {
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
            _hide.forward();
            break;
          case ScrollDirection.reverse:
            _hide.reverse();
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
            children: adminDestinations.map<Widget>((Destination destination) {
              return DestinationLayout(
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
            items: adminDestinations.map((Destination destination) {
              return BottomNavigationBarItem(
                backgroundColor: colorPrimary,
                icon: Icon(destination.iconData),
                title: Text(
                  destination.title,
                  style: textStyleSubtitle,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
