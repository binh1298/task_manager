import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_manager/components/labels/icon_text.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/secure_storage.dart';
import 'package:task_manager/utils/string_utils.dart';

class CardGroupListItem extends StatelessWidget {
  final String groupName, managerName;
  final int groupId;
  CardGroupListItem({
    Key key,
    this.groupId,
    this.groupName,
    this.managerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserDetails>(
      future: getUserFromToken(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Card(
              elevation: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 8.0,
                    ),
                    IconTextComponent(
                      icon: Icons.list,
                      text: '$groupName',
                      style: textStyleTitle,
                      textBoxWidth: textboxWidthLarge,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    (snapshot.data.roleName != RoleNames.manager)
                        ? IconTextComponent(
                            icon: Icons.person,
                            text: 'Manager: $managerName',
                            style: textStyleSubtitle,
                            textBoxWidth: textboxWidthLarge,
                          )
                        : SizedBox(
                            height: 0,
                          ),
                    SizedBox(
                      height: 8.0,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              ),
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Detail',
                color: colorPrimary,
                icon: Icons.person,
                onTap: () {
                  Navigator.pushNamed(context, '/viewGroupDetails',
                      arguments: groupId);
                },
              ),
              // IconSlideAction(
              //   caption: 'Delete',
              //   color: Colors.red,
              //   icon: Icons.delete,
              //   onTap: () => print('Delete'),
              // ),
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
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
