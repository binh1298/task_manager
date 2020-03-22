import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/snack_bar.dart';

class SecondaryActionDeleteUser extends StatelessWidget {
  final bool isDeleted;
  final String userId;
  final Function refreshList;

  SecondaryActionDeleteUser(this.isDeleted, this.userId, this.refreshList);
  @override
  IconSlideAction build(BuildContext context) {
    return IconSlideAction(
      caption: isDeleted ? 'Undelete' : 'Delete',
      color: isDeleted ? colorAccept : colorWarning,
      icon: Icons.delete,
      onTap: () async {
        bool success = await deleteUser(userId, !isDeleted);
        if (success) {
          showInfoSnackBar(context,
              '${isDeleted ? 'Undelete' : 'Delete'} user successfully');
        } else {
          showErrorSnackBar(context, 'Something went wrong while delete user');
        }
        refreshList();
      },
    );
  }
}
