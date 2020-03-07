import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:task_manager/components/icon_text.dart';
import 'package:task_manager/components/text_safe.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/string_utils.dart';

class ViewUserProfileScreen extends StatefulWidget {
  final String userId;

  ViewUserProfileScreen({this.userId});
  @override
  _ViewUserProfileScreenState createState() => _ViewUserProfileScreenState();
}

class _ViewUserProfileScreenState extends State<ViewUserProfileScreen> {
  Future<UserDetails> userDetails;

  @override
  void initState() {
    super.initState();
    userDetails = fetchUserDetails(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserDetails>(
      future: userDetails,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Card(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  Image(
                    image: NetworkImage(snapshot.data.avatar),
                  ),
                  SizedBox(height: 20),
                  TextSafeComponent(
                    text: 'Name: ${snapshot.data.fullname}',
                    style: textStyleTitle,
                  ),
                  TextSafeComponent(
                    text: 'Role: ${capitalize(snapshot.data.roleName)}',
                    style: textStyleTitle,
                  ),
                  SizedBox(height: 10),
                  IconTextComponent(
                    icon: Icons.email,
                    text: '${snapshot.data.email}',
                    style: textStyleSubtitle.copyWith(fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  IconTextComponent(
                    icon: Icons.phone,
                    text: '${snapshot.data.phoneNumber}',
                    style: textStyleSubtitle.copyWith(fontSize: 18),
                  ),
                  Center(
                    child: QrImage(
                      data: snapshot.data.userId,
                      size: 200,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Text(
              'Can\'t find this user',
              style: textStyleHeading,
            ),
          );
        }
      },
    );
  }
}
