import 'package:flutter/material.dart';
import 'package:task_manager/components/cards/card_user_list_item.dart';
import 'package:task_manager/components/secondary_actions/secondary_action_remove_from_group.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/string_utils.dart';

class ListOfUsersInAGroup extends StatelessWidget {
  final int groupId;
  final Future<List<UserDetails>> usersDetailsList;
  final Function refreshList;
  ListOfUsersInAGroup({this.groupId, this.usersDetailsList, this.refreshList});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserDetails>>(
      future: usersDetailsList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            print(snapshot.data);
            return Column(
              children: snapshot.data
                  .map(
                    (userDetail) => CardUserListItem(
                      userId: userDetail.userId,
                      fullname: userDetail.fullname,
                      role: userDetail.roleName != null ? userDetail.roleName : RoleNames.employee,
                      // phoneNumber: userDetail.phoneNumber,
                      email: userDetail.email,
                      avatar: userDetail.avatar,
                      isDeleted: userDetail.isDeleted,
                      refreshList: refreshList,
                      secondaryAction: SecondaryActionRemoveFromGroup(userDetail.userId, groupId, refreshList),
                    ),
                  )
                  .toList(),
            );
          } else {
            return Center(
              child: Text('This group has no member yet!' , style: textStyleSubtitle,),
            );
          }
        } else if (snapshot.hasError) {
          return Column(
            children: <Widget>[
              Center(
                child: Text('${snapshot.error}'),
              ),
            ],
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: <Widget>[
              Center(
                child: Text('${snapshot.error}'),
              ),
            ],
          );
        }
        return Column(
          children: <Widget>[
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        );
      },
    );
  }
}
