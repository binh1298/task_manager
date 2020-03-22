import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_manager/components/labels/icon_text.dart';
import 'package:task_manager/components/labels/text_safe.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/snack_bar.dart';
import 'package:task_manager/utils/string_utils.dart';

class CardTaskListItem extends StatelessWidget {
  final int id, sourceTaskId, judgeScore;
  final String name,
      requirement,
      handleProcess,
      judgeId,
      judgeComment,
      status,
      creatorId,
      assigneeId,
      creatorFullname,
      judgeFullname,
      assigneeFullname,
      judgeStatus,
      confirmationImg;
  final String judgeCommentAt, beginAt, endAt, createdAt, updatedAt;
  final Function refreshList;
  CardTaskListItem(
      {this.createdAt,
      this.assigneeId,
      this.beginAt,
      this.confirmationImg,
      this.creatorId,
      this.creatorFullname,
      this.judgeFullname,
      this.assigneeFullname,
      this.endAt,
      this.handleProcess,
      this.id,
      this.judgeComment,
      this.judgeCommentAt,
      this.judgeId,
      this.judgeScore,
      this.name,
      this.requirement,
      this.sourceTaskId,
      this.status,
      this.judgeStatus,
      this.updatedAt,
      this.refreshList});

  @override
  Widget build(BuildContext context) {
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
                icon: Icons.event_note,
                text: name,
                style: textStyleTitle,
              ),
              IconTextComponent(
                icon: Icons.trending_up,
                text: status,
                style: textStyleSubtitle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                color: getTaskStatusColor(status),
              ),
              TextSafeComponent(
                label: 'Creator',
                text: creatorFullname,
                textBoxWidth: textboxWidthLarge,
                style: textStyleSubtitle,
              ),
              TextSafeComponent(
                label: 'Judge',
                text: judgeFullname,
                textBoxWidth: textboxWidthLarge,
                style: textStyleSubtitle,
              ),
              TextSafeComponent(
                label: 'Assignee',
                text: assigneeFullname,
                textBoxWidth: textboxWidthLarge,
                style: textStyleSubtitle,
              ),
              IconTextComponent(
                icon: Icons.access_time,
                text: 'Start Date: ${formatDate(beginAt)}',
                style: textStyleSubtitle,
              ),
              IconTextComponent(
                icon: Icons.access_alarm,
                text: 'End Date: ${formatDate(endAt)}',
                style: textStyleSubtitle,
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
          caption: 'Details',
          color: colorPrimary,
          icon: Icons.account_circle,
          onTap: () {
            Navigator.pushNamed(context, '/viewTaskDetails', arguments: id);
          },
        ),
        if (status == TaskStatus.failed && judgeStatus == JudgeStatus.judged)
          IconSlideAction(
            caption: 'Create Task',
            color: colorAccept,
            icon: Icons.add,
            onTap: () async {
              final result = await Navigator.pushNamed(context, '/createTask', arguments: id);
              if (result != null) {
                showInfoSnackBar(context, 'Created Task Successfully!');
              }
            },
          ),

        // IconSlideAction(
        //   caption: isDeleted ? 'Undelete' : 'Delete',
        //   color: isDeleted ? colorAccept : colorWarning,
        //   icon: Icons.delete,
        //   onTap: () async {
        //     bool success = await deleteUser(userId, !isDeleted);
        //     if(success) {
        //       showInfoSnackBar(context, '${isDeleted ? 'Undelete' : 'Delete'} user successfully');
        //     } else {
        //       showErrorSnackBar(context, 'Something went wrong while delete user');
        //     }
        //     refreshList();
        //   },
        // ),
      ],
    );
  }
}
