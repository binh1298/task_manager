import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/utils/snack_bar.dart';
import 'package:task_manager/style/style.dart';

class ScanButton extends StatelessWidget {
  final BuildContext context;
  final Function onSuccessScan;
  final String title;
  ScanButton({this.context, this.onSuccessScan, this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: RaisedButton(
              color: colorPrimary,
              textColor: colorTextButton,
              splashColor: Colors.blueGrey,
              onPressed: scan,
              child: Text(title),
            ),
          ),
        ],
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      onSuccessScan(barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        showErrorSnackBar(context, 'Please grant the camera permission!');
      } else {
        showErrorSnackBar(context, 'Unknown error: $e');
      }
    } on FormatException {
      print('User returned using the "back"-button before scanning anything.');
    } catch (e) {
      showErrorSnackBar(context, 'Unknown error: $e');
    }
  }
}
