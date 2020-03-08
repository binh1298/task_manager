import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_manager/components/labels/icon_text.dart';
import 'package:task_manager/style/style.dart';

class CardGroupDetail extends StatelessWidget {
  final String groupName, managerName;
  final int groupId;
  CardGroupDetail({
    Key key,
    this.groupId,
    this.groupName,
    this.managerName,
  }) : super(key: key);

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
                icon: Icons.list,
                text: 'Group: $groupName',
                style: textStyleTitle,
                textBoxWidth: textboxWidthLarge,
              ),
              SizedBox(
                height: 8.0,
              ),
              IconTextComponent(
                icon: Icons.person,
                text: 'Manager: $managerName',
                style: textStyleSubtitle,
                textBoxWidth: textboxWidthLarge,
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
