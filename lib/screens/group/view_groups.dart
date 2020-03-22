import 'package:flutter/material.dart';
import 'package:task_manager/components/cards/card_group_list_item.dart';
import 'package:task_manager/models/group_details.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/utils/secure_storage.dart';
import 'package:task_manager/utils/snack_bar.dart';
import 'package:task_manager/utils/string_utils.dart';

class ViewGroupsScreen extends StatefulWidget {
  @override
  _ViewGroupsScreenState createState() => _ViewGroupsScreenState();
}

class _ViewGroupsScreenState extends State<ViewGroupsScreen> {
  Future<List<GroupDetails>> groupDetailsList;
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
      groupDetailsList = fetchGroupDetailsList();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserDetails>(
      future: getUserFromToken(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            floatingActionButton: snapshot.data.roleName == RoleNames.admin
                ? FloatingActionButton(
                    heroTag: 'CreateGroups',
                    child: Icon(Icons.group_add),
                    onPressed: () async {
                      final result =
                          await Navigator.pushNamed(context, '/createGroup');
                      if (result != null) {
                        refreshList();
                        showInfoSnackBar(
                            context, 'Created Group Successfully!');
                      }
                    },
                  )
                : null,
            body: RefreshIndicator(
              onRefresh: refreshList,
              key: refreshKey,
              child: FutureBuilder<List<GroupDetails>>(
                future: groupDetailsList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      children: snapshot.data
                          .map(
                            (groupDetail) => CardGroupListItem(
                              managerName: groupDetail.managerName,
                              groupName: groupDetail.groupName,
                              groupId: groupDetail.groupId,
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
        } else {
          return Text('You don\'t have the right to view this page');
        }
      },
    );
  }
}
