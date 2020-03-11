import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:task_manager/components/cards/card_list_container.dart';
import 'package:task_manager/components/labels/icon_text.dart';
import 'package:task_manager/components/labels/text_safe.dart';
import 'package:task_manager/components/user_image_safe.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/string_utils.dart';

class CardGroupDetails extends StatelessWidget {
  final String avatar,
      groupName,
      fullname,
      roleName,
      email,
      phoneNumber,
      managerId;
  CardGroupDetails(
      {this.managerId,
      this.avatar,
      this.email,
      this.fullname,
      this.roleName,
      this.groupName,
      this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return CardListContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserImageSafe(
            imgUrl: avatar,
          ),
          SizedBox(height: 20),
          TextSafeComponent(
            text: 'Group: ',
            style: textStyleHeading,
          ),
          TextSafeComponent(
            text: '$groupName',
            style: textStyleTitle,
          ),
          SizedBox(height: 20),
          TextSafeComponent(
            text: 'Manager: ',
            style: textStyleHeading,
          ),
          TextSafeComponent(
            text: '$fullname',
            style: textStyleTitle,
          ),
          TextSafeComponent(
            text: 'Role: ${capitalize(roleName)}',
            style: textStyleTitle,
          ),
          SizedBox(height: 10),
          IconTextComponent(
            icon: Icons.email,
            text: '$email',
            style: textStyleSubtitle.copyWith(fontSize: 18),
          ),
          SizedBox(height: 5),
          // IconTextComponent(
          //   icon: Icons.phone,
          //   text: '$phoneNumber',
          //   style: textStyleSubtitle.copyWith(fontSize: 18),
          // ),
          Center(
            child: QrImage(
              data: managerId,
              size: 200,
            ),
          ),
        ],
      ),
    );
  }
}
