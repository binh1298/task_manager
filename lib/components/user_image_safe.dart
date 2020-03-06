import 'package:flutter/material.dart';

class UserImageSafe extends StatelessWidget {
  final String imgUrl;
  UserImageSafe({this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: (imgUrl != null)
          ? NetworkImage(imgUrl)
          : AssetImage('lib/assets/images/defaultAvatar.png'),
    );
  }
}
