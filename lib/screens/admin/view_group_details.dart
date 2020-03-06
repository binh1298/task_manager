import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:task_manager/components/icon_text.dart';
import 'package:task_manager/components/text_safe.dart';
import 'package:task_manager/components/user_image_safe.dart';
import 'package:task_manager/models/group_details.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/string_utils.dart';

class ViewGroupDetailsScreen extends StatefulWidget {
  final String groupId;

  ViewGroupDetailsScreen({this.groupId});
  @override
  _ViewGroupDetailsScreenState createState() => _ViewGroupDetailsScreenState();
}

class _ViewGroupDetailsScreenState extends State<ViewGroupDetailsScreen> {
  Future<GroupDetails> groupDetails;

  @override
  void initState() {
    super.initState();
    groupDetails = fetchGroupDetails(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GroupDetails>(
      future: groupDetails,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Card(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  // UserImageSafe(imgUrl: snapshot.data.avatar,),
                  // SizedBox(height: 20),
                  // TextSafeComponent(
                  //   text: '${snapshot.data.fullname}',
                  //   style: textStyleTitle,
                  // ),
                  // TextSafeComponent(
                  //   text: 'Role: ${capitalize(snapshot.data.roleName)}',
                  //   style: textStyleTitle,
                  // ),
                  // SizedBox(height: 10),
                  // IconTextComponent(
                  //   icon: Icons.email,
                  //   text: '${snapshot.data.email}',
                  //   style: textStyleSubtitle.copyWith(fontSize: 18),
                  // ),
                  // SizedBox(height: 5),
                  // IconTextComponent(
                  //   icon: Icons.phone,
                  //   text: '${snapshot.data.phoneNumber}',
                  //   style: textStyleSubtitle.copyWith(fontSize: 18),
                  // ),
                  // Center(
                  //   child: QrImage(
                  //     data: snapshot.data.userId,
                  //     size: 200,
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        } else {
          return Text('Can\'t find this user');
        }
      },
    );
  }
}
