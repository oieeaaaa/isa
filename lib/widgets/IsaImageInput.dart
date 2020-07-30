import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';

import '../screens/TakePictureScreen.dart';

// =========================================================================
// Isa ImageInput
// =========================================================================

class IsaImageInput extends StatelessWidget {
  final CameraDescription camera;
  final imagePath;

  IsaImageInput(this.camera, this.imagePath);

  @override
  Widget build(BuildContext context) {
    // navigate to TakePictureScreen
    void navigateToTakePictureScreen() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TakePictureScreen(camera: this.camera),
        ),
      );
    }

    return Container(
      child: Row(
        children: <Widget>[
          Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
              ),
              child: (this.imagePath == null)
                  ? Icon(Icons.camera_alt, size: 32)
                  : FittedBox(
                      fit: BoxFit.cover,
                      child: Image.file(File(this.imagePath)))),
          SizedBox(width: 20),
          OutlineButton(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
            onPressed: navigateToTakePictureScreen,
            child: Text('Capture Image',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Theme.of(context).primaryColor)),
          ),
        ],
      ),
    );
  }
}
