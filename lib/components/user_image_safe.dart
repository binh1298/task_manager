import 'package:flutter/material.dart';
import 'package:task_manager/style/resouces.dart';

class UserImageSafe extends StatelessWidget {
  final String imgUrl;
  UserImageSafe({this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: (imgUrl != null)
          ? NetworkImage(imgUrl)
          : AssetImage(fallBackAvatarUrl),
    );
  }
}
