import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/components/icon_text.dart';
import 'package:task_manager/components/text_safe.dart';
import 'package:task_manager/style/style.dart';

class CardUserProfileComponent extends StatefulWidget {
  final String fullname, role, email, phoneNumber, avatar;

  CardUserProfileComponent(
      {Key key, this.fullname, this.role, this.email, this.phoneNumber, this.avatar})
      : super(key: key);

  @override
  _CardUserProfileComponentState createState() =>
      _CardUserProfileComponentState();
}

class _CardUserProfileComponentState extends State<CardUserProfileComponent> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CircleAvatar(
              radius: 40.0,
              backgroundImage: widget.avatar != null ? NetworkImage(widget.avatar) : AssetImage('lib/assets/images/defaultAvatar.png'),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 8.0,
              ),
              TextSafeComponent(
                text: widget.fullname,
                style: textStyleTitle,
              ),
              TextSafeComponent(
                text: widget.role,
                style: textStyleSubtitle,
              ),
              SizedBox(
                height: 8.0,
              ),
              IconTextComponent(
                icon: Icons.email,
                text: widget.email,
              ),
              IconTextComponent(
                icon: Icons.phone,
                text: widget.phoneNumber,
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
