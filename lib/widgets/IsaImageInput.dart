import 'package:flutter/material.dart';

// =========================================================================
// Isa ImageInput
// =========================================================================

class IsaImageInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
            ),
            child: Icon(Icons.camera_alt, size: 32),
          ),
          SizedBox(width: 20),
          OutlineButton(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {},
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
