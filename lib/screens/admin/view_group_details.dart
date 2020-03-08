import 'package:flutter/material.dart';
import 'package:task_manager/components/cards/card_group_details.dart';
import 'package:task_manager/models/group_details.dart';
import 'package:task_manager/style/style.dart';

class ViewGroupDetailsScreen extends StatefulWidget {
  final int groupId;

  ViewGroupDetailsScreen({this.groupId});
  @override
  _ViewGroupDetailsScreenState createState() => _ViewGroupDetailsScreenState();
}

class _ViewGroupDetailsScreenState extends State<ViewGroupDetailsScreen> {
  Future<GroupDetails> groupDetails;

  @override
  void initState() {
    super.initState();
    groupDetails = fetchGroupDetails(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        FutureBuilder<GroupDetails>(
          future: groupDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CardGroupDetails(
                avatar: snapshot.data.avatar,
                email: snapshot.data.email,
                fullname: snapshot.data.fullname,
                groupName: snapshot.data.groupName,
                managerId: snapshot.data.managerId,
                phoneNumber: snapshot.data.phoneNumber,
                roleName: snapshot.data.roleName,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Can\'t find this Group ${snapshot.error}',
                  style: textStyleHeading,
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }
}
