import 'package:flutter/material.dart';

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
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.1449275362,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
            ),
            child: Image(
              width: 60,
              height: 60,
              image: NetworkImage(this.imageUrl),
            ),
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
            child: Text('₱${this.price.toString()}',
                textAlign: TextAlign.end,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 18)),
          ),
        ]);
  }
}
