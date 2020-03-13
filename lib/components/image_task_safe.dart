import 'package:flutter/material.dart';

class ImageTaskSafe extends StatelessWidget {
  final String imgUrl;
  ImageTaskSafe({this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return (imgUrl != null)
        ? Image(
            image: NetworkImage(imgUrl),
          )
        : SizedBox(
            height: 0,
          );
  }
}
