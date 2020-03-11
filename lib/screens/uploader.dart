import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Uploader extends StatefulWidget {
  final File file;
  final Function onSuccess, onFailed;
  final String label;
  Uploader({Key key, this.file, this.onSuccess, this.onFailed, this.label}) : super(key: key);
  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://task-manager-c8562.appspot.com');

  StorageUploadTask _uploadTask;
  void _startUpload() async {
    String filePath = 'images/${DateTime.now()}.png';

    setState(() async {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
      var dowurl = await (await _uploadTask.onComplete).ref.getDownloadURL();
      if(_uploadTask.isSuccessful) {
        widget.onSuccess(dowurl.toString());
      } else {
        widget.onFailed();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;
          double progressPercent =
              event != null ? event.bytesTransferred / event.totalByteCount : 0;
          return Column(
            children: [
              if (_uploadTask.isComplete) Text('Completed'),
              if (_uploadTask.isPaused)
                FlatButton(
                  child: Icon(Icons.play_arrow),
                  onPressed: _uploadTask.resume,
                ),
              if (_uploadTask.isInProgress)
                FlatButton(
                  child: Icon(Icons.pause),
                  onPressed: _uploadTask.pause,
                ),
              LinearProgressIndicator(
                value: progressPercent,
              ),
              Text('${(progressPercent * 100).toStringAsFixed(2)} %'),
            ],
          );
        },
      );
    } else {
      return FlatButton.icon(onPressed: _startUpload, icon: Icon(Icons.cloud_upload), label: Text(widget.label));
    }
  }
}
