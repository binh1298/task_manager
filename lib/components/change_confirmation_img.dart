import 'package:flutter/material.dart';
import 'package:task_manager/screens/utils/image_capture.dart';

class ChangeConfirmationImageComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return ImageCaptureScreen(
          label: 'Update Confirmation Image',
          onSuccess: (url) async {
            print('url: $url');
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
