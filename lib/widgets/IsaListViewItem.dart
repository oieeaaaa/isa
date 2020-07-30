import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:convert';

// =========================================================================
// Isa ListView Item
// =========================================================================

class IsaListViewItem extends StatelessWidget {
  final imageUrl;
  final name;
  final price;

  IsaListViewItem(this.imageUrl, this.name, this.price);

  @override
  Widget build(BuildContext context) {
    Uint8List _bytesImage;

    if (this.imageUrl != null) {
      _bytesImage = Base64Decoder().convert(this.imageUrl);
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.1449275362,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
            ),
            child: (this.imageUrl != null)
                ? Image.memory(
                    _bytesImage,
                    width: 60,
                    height: 60,
                  )
                : Icon(Icons.camera_alt),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.38647343,
            child: Text(this.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 18)),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.193236715,
            child: Text('${this.price.toString()}',
                textAlign: TextAlign.end,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 18)),
          ),
        ]);
  }
}
