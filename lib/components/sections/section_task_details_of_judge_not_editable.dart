import 'package:flutter/material.dart';
import 'package:task_manager/components/labels/icon_text.dart';
import 'package:task_manager/components/labels/text_safe.dart';
import 'package:task_manager/models/task_details.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/string_utils.dart';

class SectionTaskDetailsOfJudgeNotEditable extends StatelessWidget {
  final TaskDetails taskDetails;

  SectionTaskDetailsOfJudgeNotEditable(this.taskDetails);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextSafeComponent(
          label: 'Judge Status',
          text: taskDetails.judgeStatus,
          labelStyle: textStyleTitle,
        ),
        SizedBox(
          height: 20,
        ),
        TextSafeComponent(
          label: 'Requirement',
          text: taskDetails.requirement,
          labelStyle: textStyleTitle,
          textBoxWidth: textboxWidthLarge,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: <Widget>[
            IconTextComponent(
              icon: Icons.notifications,
              text: formatDate(taskDetails.beginAt),
            ),
            SizedBox(
              width: 10,
            ),
            IconTextComponent(
              icon: Icons.notifications_off,
              text: formatDate(taskDetails.endAt),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        TextSafeComponent(
          label: 'Judge\'s comment',
          text: taskDetails.judgeComment,
          fallbackText: 'Judge has not commented yet',
          labelStyle: textStyleTitle,
          textBoxWidth: textboxWidthLarge,
        ),
        SizedBox(
          height: 20,
        ),
        IconTextComponent(
          icon: Icons.access_alarm,
          text: formatDate(taskDetails.judgeCommentAt),
          fallbackText: 'Not commented yet',
        ),
        SizedBox(
          height: 20,
        ),
        TextSafeComponent(
          label: 'Score',
          text: taskDetails.judgeScore != null
              ? taskDetails.judgeScore.toString()
              : null,
          fallbackText: 'Not scored yet',
        )
      ],
    );
  }
}
