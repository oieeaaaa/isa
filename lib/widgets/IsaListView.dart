import 'package:flutter/material.dart';
import './IsaListViewHeader.dart';
import './IsaListViewItem.dart';
import '../helpers/dbProvider.dart';

// =========================================================================
// Isa ListView
// =========================================================================

class IsaListView extends StatelessWidget {
  generateItems(data) {
    return data.map<Widget>((item) {
      print(item);
      return Column(children: [
        IsaListViewItem('https://bit.ly/32YvgYy', item['name'] ?? 'N/A',
                item['price'].toString()) ??
            '0.00',
        SizedBox(height: 20),
      ]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    DBProvider dbIsa = DBProvider();

    return ListView(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IsaListViewHeader('image', 0.1449275362),
          IsaListViewHeader('name', 0.38647343),
          IsaListViewHeader('price', 0.193236715, TextAlign.end),
        ]),
        SizedBox(height: 20),
        FutureBuilder(
          future: dbIsa.getItems(),
          builder: (context, snapshot) {
            List<Widget> children;

            if (snapshot.connectionState == ConnectionState.done) {
              children = generateItems(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }

            return Column(
              children: children,
            );
          },
        )
      ],
    );
  }
}
