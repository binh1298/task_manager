import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:task_manager/components/buttons/button_cancel.dart';
import 'package:task_manager/components/labels/icon_text.dart';
import 'package:task_manager/components/labels/text_safe.dart';
import 'package:task_manager/components/user_image_safe.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/style/style.dart';
import 'package:task_manager/utils/authorization.dart';
import 'package:task_manager/utils/string_utils.dart';

class ViewProfileScreen extends StatefulWidget {
  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  Future<UserDetails> userDetails;
  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    userDetails = fetchUserProfile(context);
  }

  Future<Null> refreshProfile() async {
    refreshKey.currentState?.show(atTop: true);
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      userDetails = fetchUserProfile(context);
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshProfile,
      key: refreshKey,
      child: FutureBuilder<UserDetails>(
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
                    GestureDetector(
                      onTap: () async {
                        final result = await Navigator.pushNamed(context, '/changeAvatar');
                        if(result) refreshProfile();
                      },
                      child: UserImageSafe(
                        imgUrl: snapshot.data.avatar,
                      ),
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
                    // IconTextComponent(
                    //   icon: Icons.phone,
                    //   text: '${snapshot.data.phoneNumber}',
                    //   style: textStyleSubtitle.copyWith(fontSize: 18),
                    // ),
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
                        logout(context);
                      },
                    )
                  ],
                ),
              ),
            );
          } else {
            return ListView(
              children: <Widget>[
                Center(child: Text('Can\'t find this user')),
              ],
            );
          }
        },
      ),
    );
  }
}
