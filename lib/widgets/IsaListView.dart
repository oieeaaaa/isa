import 'dart:io';

import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

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
  List items = [];
  DateFormat dateFormat = DateFormat.yMMMd();

  TextEditingController emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        IsaListViewHeader(this.fetchItems, this.sendReport),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IsaListViewHeading('image', 0.1449275362),
          IsaListViewHeading('name', 0.38647343),
          IsaListViewHeading('price', 0.193236715, TextAlign.end),
        ]),
        SizedBox(height: 20),
        if (items.length != 0) ...generateItems(items),
        if (items.length == 0)
          Text('No available items here',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 20, color: Theme.of(context).accentColor)),
      ],
    );
  }

  Future<void> fetchItems(date) async {
    final response = await dbIsa.getItems(date);

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

  Future sendToEmail() async {
    // convert map to list
    // because csv accepts nested list
    List<List<dynamic>> listItems = List.generate(items.length, (index) {
      return ([
        items[index]['id'],
        items[index]['name'],
        items[index]['price'],
        items[index]['quantity'],
        items[index]['customerName'],
        items[index]['customerContactNumber'],
        items[index]['notes'],
        dateFormat.format(DateTime.parse(items[index]['createdAt'])),
      ]);
    });

    // csv the first item on the list is the column header
    // the preceeding items are the values
    String csv = ListToCsvConverter().convert([
      // csv headers
      [
        'ID',
        'Name',
        'Price',
        'Quantity',
        'Customer Name',
        'Customer Contact Number',
        'Notes',
        'Date Created'
      ],

      // csv values
      ...listItems,
    ]);

    final String dir = (await getApplicationSupportDirectory()).path;
    final String path = '$dir/report.csv';
    final File file = File(path);

    // write the data
    await file.writeAsString(csv);

    final Email email = Email(
      body: 'See the attachment',
      subject: 'Sales report',
      recipients: [emailCtrl.text],
      attachmentPaths: [path],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);

      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Text('Email is sent to ${emailCtrl.text} ✅',
                    style: Theme.of(context).textTheme.bodyText1));
          });
    } catch (error) {
      print(error.toString());
    }

    setState(() {
      emailCtrl.text = '';
    });

    Navigator.of(context).pop();
  }

  void sendReport(List<DateTime> selectedRange) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              contentPadding: EdgeInsets.only(top: 30, left: 20, right: 20),
              titlePadding: EdgeInsets.only(left: 20, right: 20, top: 30),
              actionsPadding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Send Report:',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 24)),
                  SizedBox(height: 20),
                  Text('Start Date: ${dateFormat.format(selectedRange[0])}',
                      style: Theme.of(context).textTheme.bodyText2),
                  SizedBox(height: 10),
                  Text('End Date: ${dateFormat.format(selectedRange[1])}',
                      style: Theme.of(context).textTheme.bodyText2),
                ],
              ),
              content: Container(
                width: MediaQuery.of(context).size.width * 0.8550724638,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('To:', style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(height: 10),
                    TextField(
                        controller: emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor, width: 1),
                            borderRadius: BorderRadius.zero,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                        )),
                    SizedBox(height: 196),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.28,
                            height: 50,
                            child: FlatButton(
                              splashColor: Colors.red.withAlpha(50),
                              color: Colors.transparent,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                          color:
                                              Theme.of(context).accentColor)),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.28,
                            height: 50,
                            child: FlatButton(
                              splashColor: Colors.white.withAlpha(100),
                              color: Theme.of(context).primaryColor,
                              onPressed: sendToEmail,
                              child: Text('Send',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(color: Colors.white)),
                            ),
                          )
                        ]),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    this.fetchItems([DateTime.now(), (DateTime.now()).add(Duration(days: 7))]);
  }
}
