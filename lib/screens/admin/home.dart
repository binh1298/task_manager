import 'package:flutter/material.dart';
import 'package:task_manager/layouts/destination.dart';
import 'package:task_manager/screens/admin/view_employees.dart';
import 'package:task_manager/screens/admin/view_groups.dart';
import 'package:task_manager/screens/admin/view_profile.dart';
import 'package:task_manager/screens/admin/view_tasks.dart';
import 'package:task_manager/style/style.dart';
import '../../classes/destination.dart';

List<Destination> adminDestinations = <Destination>[
  Destination('Users', Icons.person, ViewEmployeesScreen()),
  Destination('Groups', Icons.group, ViewGroupScreen()),
  Destination('Tasks', Icons.event_note, ViewTasksScreen()),
  Destination('History', Icons.library_books, ViewTasksScreen()),
  Destination('Profile', Icons.person, ViewProfileScreen()),
];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _currentIndex,
          children: adminDestinations.map<Widget>((Destination destination) {
            return DestinationLayout(destination: destination);
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
              style: textStyleSubtitle,),
          );
        }).toList(),
      ),
    );
  }
}
