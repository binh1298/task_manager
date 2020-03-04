import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/utils/snack_bar.dart';

class ScanButton extends StatefulWidget {
  final BuildContext context;
  final Function onSuccessScan;
  ScanButton({this.context, this.onSuccessScan});
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanButton> {
  String barcode = "";

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
              color: Colors.blue,
              textColor: Colors.white,
              splashColor: Colors.blueGrey,
              onPressed: scan,
              child: const Text('Scan QR to find Employee'),
            ),
          ),
        ],
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      widget.onSuccessScan(barcode);
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
