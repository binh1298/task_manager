import 'package:flutter/material.dart';
import 'package:task_manager/components/cards/card_user_list_item.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/style/style.dart';

class ListOfUsers extends StatelessWidget {
  final Future<List<UserDetails>> usersDetailsList;

  ListOfUsers({this.usersDetailsList});

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
                      role: userDetail.roleName,
                      // phoneNumber: userDetail.phoneNumber,
                      email: userDetail.email,
                      avatar: userDetail.avatar,
                      isDeleted: userDetail.isDeleted,
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
