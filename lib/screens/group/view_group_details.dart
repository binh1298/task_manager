import 'package:flutter/material.dart';
import 'package:task_manager/components/cards/card_group_details.dart';
import 'package:task_manager/components/cards/card_list_container.dart';
import 'package:task_manager/components/labels/text_safe.dart';
import 'package:task_manager/components/list/user_list.dart';
import 'package:task_manager/components/scan_button.dart';
import 'package:task_manager/models/group_details.dart';
import 'package:task_manager/models/group_member.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/secure_storage.dart';
import 'package:task_manager/utils/snack_bar.dart';
import 'package:task_manager/utils/string_utils.dart';

class ViewGroupDetailsScreen extends StatefulWidget {
  final int groupId;

  ViewGroupDetailsScreen({this.groupId});
  @override
  _ViewGroupDetailsScreenState createState() => _ViewGroupDetailsScreenState();
}

class _ViewGroupDetailsScreenState extends State<ViewGroupDetailsScreen> {
  Future<GroupDetails> groupDetails;
  Future<List<UserDetails>> groupMembers;
  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    groupDetails = fetchGroupDetails(widget.groupId);
    groupMembers = fetchGroupMembersDetailsList(widget.groupId);
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: true);
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      groupMembers = fetchGroupMembersDetailsList(widget.groupId);
    });

    return null;
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
                // phoneNumber: snapshot.data.phoneNumber,
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
        SizedBox(
          height: 10,
        ),
        CardListContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextSafeComponent(
                text: 'Members:',
                style: textStyleTitle,
              ),
            ],
          ),
        ),
        ListOfUsersInAGroup(
          groupId: widget.groupId,
          usersDetailsList: groupMembers,
          refreshList: refreshList,
        ),
        FutureBuilder<UserDetails>(
          future: getUserFromToken(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return snapshot.data.roleName == RoleNames.admin 
              ? ScanButton(
                context: context,
                onSuccessScan: (userId) async {
                  bool success = await addGroupMember(widget.groupId, userId);
                  if(success) {
                    refreshList();
                    showInfoSnackBar(context, 'Added user successfull');
                  } else {
                    showErrorSnackBar(context, 'Can\'t add this user');
                  }
                },
                title: 'Scan QR to Add Member',
              )
              : SizedBox(height: 0,);
            } else {
              return SizedBox(height: 0,);
            }
          },
        )
      ],
    );
  }
}
