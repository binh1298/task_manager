import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_manager/components/icon_text.dart';
import 'package:task_manager/components/text_safe.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/string_utils.dart';

class CardUserProfile extends StatelessWidget {
  final String fullname, role, email, phoneNumber, avatar;
  final bool isDeleted;

  CardUserProfile(
      {Key key,
      this.fullname,
      this.role,
      this.email,
      this.phoneNumber,
      this.isDeleted,
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
                    : AssetImage('lib/assets/images/defaultAvatar.png'),
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
                  text: role,
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
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => print('Delete'),
        ),
      ],
    );
  }
}
