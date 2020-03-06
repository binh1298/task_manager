import 'package:flutter/material.dart';
import 'package:task_manager/components/card_user_profile.dart';
import 'package:task_manager/components/scan_button.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/utils/snack_bar.dart';

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
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/createUser');
          if (result != null && result) {
            refreshList();
            showInfoSnackBar(context, 'Created User Successfully!');
          }
        },
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        key: refreshKey,
        child: FutureBuilder<List<UserDetails>>(
          future: usersDetailsList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  ScanButton(
                    context: context,
                    onSuccessScan: (barcode) {
                      Navigator.pushNamed(context, '/viewUserDetail',
                          arguments: barcode);
                    },
                  ),
                  Expanded(
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      children: snapshot.data
                          .map(
                            (userDetail) => CardUserProfile(
                              userId: userDetail.userId,
                              fullname: userDetail.fullname,
                              role: userDetail.roleName,
                              phoneNumber: userDetail.phoneNumber,
                              email: userDetail.email,
                              avatar: userDetail.avatar,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
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
