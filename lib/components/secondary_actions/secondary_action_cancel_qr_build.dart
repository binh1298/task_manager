import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_manager/style/style.dart';

class SecondaryActionCancelQrBuild extends StatelessWidget {
  final cancelBuild;

  SecondaryActionCancelQrBuild(this.cancelBuild);
  @override
  IconSlideAction build(BuildContext context) {
    return IconSlideAction(
      caption: 'Cancel',
      color: colorAccept,
      icon: Icons.delete,
      onTap: () async {
        cancelBuild();
      },
    );
  }
}
