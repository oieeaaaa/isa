import 'package:flutter/material.dart';

import './IsaListViewHeader.dart';
import './IsaListViewHeading.dart';
import './IsaListViewItem.dart';
import '../helpers/dbProvider.dart';

// =========================================================================
// Isa ListView
// =========================================================================

class IsaListView extends StatefulWidget {
  @override
  _IsaListViewState createState() => _IsaListViewState();
}

// =========================================================================
// Isa ListView State
// =========================================================================

class _IsaListViewState extends State<IsaListView> {
  DBProvider dbIsa = DBProvider();
  List items;

  @override
  void initState() {
    super.initState();

    this.fetchItems(DateTime.now().toString());
  }

  Future<void> fetchItems(date) async {
    final response = await dbIsa.getItems(date);

    setState(() {
      items = response;
    });
  }

  generateItems(data) {
    return data.map<Widget>((item) {
      return Column(children: [
        IsaListViewItem(item['imageUrl'], item['name'] ?? 'N/A',
                item['price'].toString()) ??
            '0.00',
        SizedBox(height: 20),
      ]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        IsaListViewHeader(this.fetchItems),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IsaListViewHeading('image', 0.1449275362),
          IsaListViewHeading('name', 0.38647343),
          IsaListViewHeading('price', 0.193236715, TextAlign.end),
        ]),
        SizedBox(height: 20),
        if (items != null) ...generateItems(items)
      ],
    );
  }
}
