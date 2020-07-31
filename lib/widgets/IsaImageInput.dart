import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../screens/TakePictureScreen.dart';

// =========================================================================
// Isa ImageInput
// =========================================================================

class IsaImageInput extends StatelessWidget {
  final imageBytes;
  final int id;

  IsaImageInput(this.id, this.imageBytes);

  @override
  Widget build(BuildContext context) {
    // navigate to TakePictureScreen
    void navigateToTakePictureScreen() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return Consumer<MainModel>(builder: (context, main, child) {
            return TakePictureScreen(id: this.id, camera: main.camera);
          });
        }),
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
              child: (this.imageBytes == null)
                  ? Icon(Icons.camera_alt, size: 32)
                  : FittedBox(
                      fit: BoxFit.cover, child: Image.memory(imageBytes))),
          SizedBox(width: 20),
          OutlineButton(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
            onPressed: navigateToTakePictureScreen,
            child: Text(this.id == null ? 'Capture Image' : 'Update Image',
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
