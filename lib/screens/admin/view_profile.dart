import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:task_manager/components/button_cancel.dart';
import 'package:task_manager/components/icon_text.dart';
import 'package:task_manager/components/text_safe.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/restart_app.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/secure_storage.dart';
import 'package:task_manager/utils/string_utils.dart';

class ViewProfileScreen extends StatefulWidget {
  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  Future<UserDetails> userDetails;
  @override
  void initState() {
    super.initState();
    userDetails = fetchUserProfile();
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
                  SizedBox(
                    height: 20.0,
                  ),
                  ButtonCancelComponent(
                    text: 'Log out',
                    onPressed: () {
                      removeJwtToken();
                      RestartWidget.restartApp(context);
                    },
                  )
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
