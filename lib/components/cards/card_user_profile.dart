import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_manager/components/icon_text.dart';
import 'package:task_manager/components/text_safe.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/style/resouces.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/snack_bar.dart';
import 'package:task_manager/utils/string_utils.dart';

class CardUserProfile extends StatelessWidget {
  final String userId, fullname, role, email, phoneNumber, avatar;
  final bool isDeleted;
  final Function refreshList;
  CardUserProfile(
      {Key key,
      this.userId,
      this.fullname,
      this.role,
      this.email,
      this.phoneNumber,
      this.isDeleted,
      this.refreshList,
      this.avatar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  text: capitalize(role),
                  style: textStyleSubtitle,
                ),
                SizedBox(
                  height: 8.0,
                ),
                IconTextComponent(
                  icon: Icons.email,
                  text: email,
                ),
                IconTextComponent(
                  icon: Icons.phone,
                  text: phoneNumber,
                ),IconTextComponent(
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
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Details',
          color: colorPrimary,
          icon: Icons.account_circle,
          onTap: () {
            Navigator.pushNamed(context, '/viewUserDetail', arguments: userId);
          },
        ),
        IconSlideAction(
          caption: isDeleted ? 'Undelete' : 'Delete',
          color: isDeleted ? colorAccept : colorWarning,
          icon: Icons.delete,
          onTap: () async {
            bool success = await deleteUser(userId, !isDeleted);
            if(success) {
              showInfoSnackBar(context, '${isDeleted ? 'Undelete' : 'Delete'} user successfully');
            } else {
              showErrorSnackBar(context, 'Something went wrong while delete user');
            }
            refreshList();
          },
        ),
      ],
    );
  }
}
