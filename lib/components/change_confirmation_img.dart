import 'package:flutter/material.dart';
import 'package:task_manager/models/user_details.dart';
import 'package:task_manager/screens/utils/image_capture.dart';
import 'package:task_manager/utils/secure_storage.dart';

class ChangeConfirmationImageComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return ImageCaptureScreen(
          label: 'Update Confirmation Image',
          onSuccess: (url) async {
            print('url: $url');
            final UserDetails user = await getUserFromToken();
            await patchAvatarUser(user.userId, url);
            Navigator.pop(context, url);
          },
          onFailed: () {
            Navigator.pop(context, null);
          },
        );
      },
    );
  }
}
