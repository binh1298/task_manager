import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_manager/models/group_member.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/snack_bar.dart';

class SecondaryActionRemoveFromGroup extends StatelessWidget {
  final String userId;
  final int groupId;
  final Function refreshList;

  SecondaryActionRemoveFromGroup(this.userId, this.groupId, this.refreshList);
  @override
  IconSlideAction build(BuildContext context) {
    return IconSlideAction(
      caption: 'Remove',
      color: colorWarning,
      icon: Icons.delete,
      onTap: () async {
        bool success = await deleteGroupMember(groupId, userId);
        if (success) {
          showInfoSnackBar(context, 'Remove user successfully');
        } else {
          showErrorSnackBar(context, 'Something went wrong while remove user');
        }
        refreshList();
      },
    );
  }
}
