import 'package:flutter/material.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/screens/utils/image_capture.dart';
import 'package:task_manager/utils/secure_storage.dart';

class ChangeAvatarComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return ImageCaptureScreen(
          label: 'Change Avatar',
          onSuccess: (url) async {
            print('url: $url');
            final UserDetails user = await getUserFromToken();
            bool success = await patchAvatarUser(user.userId, url);
            Navigator.pop(context, success);
          },
          onFailed: () {
            Navigator.pop(context, false);
          },
        );
      },
    );
  }
}
