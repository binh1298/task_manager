import 'package:flutter/material.dart';
import 'package:task_manager/components/cards/card_user_list_item.dart';
import 'package:task_manager/components/labels/text_safe.dart';
import 'package:task_manager/components/scan_button.dart';
import 'package:task_manager/components/secondary_actions/secondary_action_delete_user.dart';
import 'package:task_manager/models/dashboard.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/snack_bar.dart';
import 'package:task_manager/utils/string_utils.dart';

class ViewDashboard extends StatefulWidget {
  @override
  _ViewDashboardState createState() => _ViewDashboardState();
}

class _ViewDashboardState extends State<ViewDashboard> {
  Future<Dashboard> dashboard;
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
      dashboard = fetchDashboard();
      usersDetailsList = fetchUsersDetailsList();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'CreateUser',
        child: Icon(Icons.person_add),
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
        child: ListView(
          children: <Widget>[
            FutureBuilder<Dashboard>(
              future: dashboard,
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
                        title: 'Scan QR to find Employee',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextSafeComponent(
                              text: 'Dashboard:',
                              style: textStyleHeading,
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: <Widget>[
                                TextSafeComponent(
                                  text: 'Number of Groups: ',
                                  style: textStyleTitle,
                                  textBoxWidth: null,
                                ),
                                TextSafeComponent(
                                  text: snapshot.data.groups.toString(),
                                  style: textStyleTitle,
                                  textBoxWidth: null,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            TextSafeComponent(
                              text: 'Number of Users:',
                              style: textStyleTitle,
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: snapshot.data.usersDashboardInfo
                                  .map(
                                    (usersDashboardInfo) => TextSafeComponent(
                                      label: capitalize(
                                          usersDashboardInfo.roleName),
                                      text: usersDashboardInfo.count.toString(),
                                      style: textStyleSubtitle,
                                    ),
                                  )
                                  .toList(),
                            ),
                            SizedBox(height: 20),
                            TextSafeComponent(
                              text: 'Number of Tasks:',
                              style: textStyleTitle,
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: snapshot.data.tasksDashboardInfo
                                  .map(
                                    (tasksDashboardInfo) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        TextSafeComponent(
                                          text: tasksDashboardInfo.taskStatus +
                                              ': ',
                                          style: textStyleSubtitle.copyWith(
                                              fontWeight: FontWeight.bold),
                                          color: getTaskStatusColor(
                                              tasksDashboardInfo.taskStatus),
                                          textBoxWidth: null,
                                        ),
                                        TextSafeComponent(
                                          text: tasksDashboardInfo.count
                                              .toString(),
                                          style: textStyleSubtitle,
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            FutureBuilder<List<UserDetails>>(
              future: usersDetailsList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data
                        .map(
                          (userDetail) => CardUserListItem(
                            userId: userDetail.userId,
                            fullname: userDetail.fullname,
                            role: userDetail.roleName,
                            // phoneNumber: userDetail.phoneNumber,
                            email: userDetail.email,
                            avatar: userDetail.avatar,
                            isDeleted: userDetail.isDeleted,
                            refreshList: refreshList,
                            secondaryAction: SecondaryActionDeleteUser(userDetail.isDeleted, userDetail.userId, refreshList),
                          ),
                        )
                        .toList(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
