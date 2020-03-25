import 'package:flutter/material.dart';
import 'package:task_manager/components/image_task_safe.dart';
import 'package:task_manager/components/labels/text_safe.dart';
import 'package:task_manager/models/task_details.dart';
import 'package:task_manager/style/style.dart';

class SectionTaskDetailsOfAssigneeNotEditable extends StatelessWidget {
  final TaskDetails taskDetails;

  SectionTaskDetailsOfAssigneeNotEditable(this.taskDetails);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextSafeComponent(
          text: 'Handle Process:',
          style: textStyleTitle,
          textBoxWidth: textboxWidthLarge,
        ),
        TextSafeComponent(
          text: taskDetails.handleProcess,
          fallbackText: 'Haven\'t done yet',
        ),
        SizedBox(
          height: 20,
        ),
        TextSafeComponent(
          text: 'Confirmation Image:',
          style: textStyleTitle,
        ),
        (taskDetails.confirmationImg == null)
            ? TextSafeComponent(
                text: taskDetails.confirmationImg,
                fallbackText: 'Haven\'t done yet',
              )
            : ImageTaskSafe(
                imgUrl: taskDetails.confirmationImg,
              ),
        SizedBox(
          height: 20,
        ),
        TextSafeComponent(
          text: 'Submit Description',
          style: textStyleTitle,
          textBoxWidth: textboxWidthLarge,
        ),
        TextSafeComponent(
          text: taskDetails.submitDescription,
          fallbackText: 'Haven\t done yet',
        ),
      ],
    );
  }
}
