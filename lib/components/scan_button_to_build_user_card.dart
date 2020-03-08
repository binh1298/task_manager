import 'package:flutter/material.dart';
import 'package:task_manager/components/cards/card_user_profile.dart';
import 'package:task_manager/components/scan_button.dart';
import 'package:task_manager/models/user_details.dart';

class ScanButtonToBuildUserCard extends StatefulWidget {
  final String roleName;
  final Function fetchDetail;
  final Function onSuccessBuild, onFailedBuild;
  ScanButtonToBuildUserCard({this.onSuccessBuild, this.onFailedBuild, this.roleName, this.fetchDetail});

  @override
  _ScanButtonToBuildUserCardState createState() =>
      _ScanButtonToBuildUserCardState();
}

class _ScanButtonToBuildUserCardState extends State<ScanButtonToBuildUserCard> {
  String userId;

  Widget buildUserCard(userId) {
    if (userId != null) {
      return FutureBuilder<UserDetails>(
        future: widget.fetchDetail(userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            widget.onSuccessBuild(userId);
            return CardUserProfile(
              userId: snapshot.data.userId,
              fullname: snapshot.data.fullname,
              role: snapshot.data.roleName,
              phoneNumber: snapshot.data.phoneNumber,
              email: snapshot.data.email,
              avatar: snapshot.data.avatar,
              isDeleted: snapshot.data.isDeleted,
            );
          } else if (snapshot.hasError) {
            widget.onFailedBuild();
            return Text('User is not found!');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            widget.onFailedBuild();
            return Text('User is not found or unavailable');
          } else {
            widget.onFailedBuild();
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    } else {
      return Text('Please scan QR to find ${widget.roleName}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildUserCard(userId),
        ScanButton(
          context: context,
          onSuccessScan: (barcode) {
            setState(() {
              userId = barcode;
            });
          },
          title: 'Scan QR to find ${widget.roleName}',
        ),
      ],
    );
  }
}
