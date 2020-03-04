import 'package:flutter/material.dart';
import 'package:task_manager/components/card_group_component.dart';
import 'package:task_manager/models/group_details.dart';

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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'CreateGroups',
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/createGroup');
        },
      ),
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
                      (userDetail) => CardGroupDetail(
                        managerName: userDetail.managerName,
                        groupName: userDetail.groupName,
                        numberOfMembers: userDetail.numberOfMembers,
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
