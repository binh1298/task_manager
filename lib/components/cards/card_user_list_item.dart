import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_manager/components/labels/icon_text.dart';
import 'package:task_manager/components/labels/text_safe.dart';
import 'package:task_manager/style/resouces.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/string_utils.dart';

class CardUserListItem extends StatelessWidget {
  final String userId, fullname, role, email, phoneNumber, avatar;
  final bool isDeleted;
  final Function refreshList;
  final Widget secondaryAction;
  CardUserListItem(
      {Key key,
      this.userId,
      this.fullname,
      this.role,
      this.email,
      this.phoneNumber,
      this.isDeleted,
      this.refreshList,
      this.secondaryAction,
      this.avatar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var secondaryActions = <Widget>[
        IconSlideAction(
          caption: 'Details',
          color: colorPrimary,
          icon: Icons.account_circle,
          onTap: () {
            Navigator.pushNamed(context, '/viewUserDetail', arguments: userId);
          },
        ),
      ];
    if(secondaryAction != null) secondaryActions.add(secondaryAction);
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Card(
        elevation: 8.0,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CircleAvatar(
                radius: 40.0,
                backgroundImage: avatar != null
                    ? NetworkImage(avatar)
                    : AssetImage(fallBackAvatarUrl),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 8.0,
                ),
                TextSafeComponent(
                  text: fullname,
                  style: textStyleTitle,
                ),
                TextSafeComponent(
                  text: role != null ? capitalize(role) : 'Unknown',
                  style: textStyleSubtitle,
                ),
                SizedBox(
                  height: 8.0,
                ),
                IconTextComponent(
                  icon: Icons.email,
                  text: email,
                  textBoxWidth: textboxWidthMedium,
                ),
                IconTextComponent(
                  icon: Icons.flash_on,
                  text: getUserStatus(isDeleted),
                  color: getUserStatusColor(isDeleted),
                ),
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ],
        ),
      ),
      secondaryActions: secondaryActions,
    );
  }
}
