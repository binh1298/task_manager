import 'package:flutter/material.dart';
import 'package:task_manager/components/card_user_profile.dart';
import 'package:task_manager/models/user_details.dart';

class ViewEmployeesScreen extends StatefulWidget {
  @override
  _ViewEmployeesScreenState createState() => _ViewEmployeesScreenState();
}

class _ViewEmployeesScreenState extends State<ViewEmployeesScreen> {
  Future<List<UserDetails>> userDetailsList;
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      userDetailsList = fetchUsersDetailsList();
    });

    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'CreateUser',
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/createUser');
        },
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        key: refreshKey,
        child: FutureBuilder<List<UserDetails>>(
          future: userDetailsList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                padding: const EdgeInsets.all(8),
                children: snapshot.data
                    .map(
                      (userDetail) => CardUserProfileComponent(
                        fullname: userDetail.fullname,
                        role: userDetail.roleName,
                        phoneNumber: userDetail.phoneNumber,
                        email: userDetail.email,
                        avatar: userDetail.avatar,
                      ),
                    )
                    .toList(),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
