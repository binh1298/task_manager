import 'package:flutter/material.dart';
import 'package:task_manager/components/card_user_profile.dart';

class ViewEmployeesScreen extends StatefulWidget {
  @override
  _ViewEmployeesScreenState createState() => _ViewEmployeesScreenState();
}

class _ViewEmployeesScreenState extends State<ViewEmployeesScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        CardUserProfile(
          fullname: 'Phạm Đức Bình',
          role: 'Manager',
          phoneNumber: '3127826121',
          email: 'binh1298@gmail.com',
        )
    ],
    );
  }
}