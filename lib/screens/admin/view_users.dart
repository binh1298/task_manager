import 'package:flutter/material.dart';
import 'package:task_manager/components/card_user_profile.dart';
import 'package:task_manager/models/user_details.dart';

class ViewUsersScreen extends StatefulWidget {
  @override
  _ViewUsersScreenState createState() => _ViewUsersScreenState();
}

class _ViewUsersScreenState extends State<ViewUsersScreen> {
  Future<List<UserDetails>> usersDetailsList;
  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: true);
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      usersDetailsList = fetchUsersDetailsList();
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
          future: usersDetailsList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
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
              return ListView(
                children: <Widget>[
                  Center(
                    child: Text('${snapshot.error}'),
                  ),
                ],
              );
            }
            return ListView(
              children: <Widget>[
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
