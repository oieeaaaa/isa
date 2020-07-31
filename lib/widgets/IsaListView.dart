import 'dart:io';

import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<void> fetchItems(date) async {
    final response = await dbIsa.getItems(date);

    // TODO: remove this later
    // for testing purposes only
    exportToCsv(response);

    setState(() {
      items = response;
    });
  }

  List<Widget> generateItems(data) {
    return data.map<Widget>((item) {
      return Column(children: [
        IsaListViewItem(item['id'], item['imageUrl'], item['name'] ?? 'N/A',
                item['price'].toString()) ??
            '0.00',
        SizedBox(height: 20),
      ]);
    }).toList();
  }

  void exportToCsv(data) async {
    DateFormat dateFormat = DateFormat.yMd();

    // convert map to list
    // because csv accepts nested list
    List<List<dynamic>> listItems = List.generate(data.length, (index) {
      return ([
        data[index]['id'],
        data[index]['name'],
        data[index]['price'],
        data[index]['customerName'],
        data[index]['customerContactNumber'],
        data[index]['notes'],
        dateFormat.format(DateTime.parse(data[index]['createdAt'])),
      ]);
    });

    // csv the first item on the list is the column header
    // the preceeding items are the values
    String csv = ListToCsvConverter().convert([
      [
        'ID',
        'Name',
        'Price',
        'Customer Name',
        'Customer Contact Number',
        'Notes',
        'Date Created'
      ],
      ...listItems,
    ]);

    final String dir = (await getApplicationSupportDirectory()).path;
    final String path = '$dir/report.csv';
    final File file = File(path);

    // TODO: send this file via email
    final report = await file.writeAsString(csv);

    print(report);
  }

  @override
  void initState() {
    super.initState();

    this.fetchItems(DateTime.now().toString());
  }
}
