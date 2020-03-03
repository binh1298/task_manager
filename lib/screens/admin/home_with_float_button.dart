import 'package:flutter/material.dart';
import 'package:task_manager/layouts/destination.dart';
import 'package:task_manager/screens/admin/view_employees.dart';
import 'package:task_manager/screens/admin/view_groups.dart';
import 'package:task_manager/screens/admin/view_profile.dart';
import 'package:task_manager/screens/admin/view_tasks.dart';
import '../../classes/destination.dart';
import '../../components/button_navigation.dart';

List<Destination> adminDestinations = <Destination>[
  Destination('Users', Icons.person, ViewEmployeesScreen()),
  Destination('Groups', Icons.group, ViewGroupScreen()),
  Destination('Tasks', Icons.event_note, ViewTasksScreen()),
  Destination('Profile', Icons.person, ViewProfileScreen()),
];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ButtonNavigation(
                      title: adminDestinations[0].title,
                      iconData: adminDestinations[0].iconData,
                      isActive: _currentIndex == 0,
                      onPressed: () {
                        setState(() {
                          _currentIndex = 0;
                        });
                      },
                    ),
                    ButtonNavigation(
                      title: adminDestinations[1].title,
                      iconData: adminDestinations[1].iconData,
                      isActive: _currentIndex == 1,
                      onPressed: () {
                        setState(() {
                          _currentIndex = 1;
                        });
                      },
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    ButtonNavigation(
                      title: adminDestinations[2].title,
                      iconData: adminDestinations[2].iconData,
                      isActive: _currentIndex == 2,
                      onPressed: () {
                        setState(() {
                          _currentIndex = 2;
                        });
                      },
                    ),
                    ButtonNavigation(
                      title: adminDestinations[3].title,
                      iconData: adminDestinations[3].iconData,
                      isActive: _currentIndex == 3,
                      onPressed: () {
                        setState(() {
                          _currentIndex = 3;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}