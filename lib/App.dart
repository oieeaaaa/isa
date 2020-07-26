import 'package:flutter/material.dart';
import 'package:isa/helpers/dbProvider.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DBProvider dbIsa = DBProvider();

    // db initialization
    dbIsa.initDB().then((res) => print('DB connection established ✨'));

    dbIsa.getItems().then((res) => print(res));

    return Scaffold(
      appBar: AppBar(
          title: Text('ISA',
              style: TextStyle(
                fontFamily: 'Avenir',
                fontWeight: FontWeight.w700,
              ))),
      body: Center(
        child: Text('Inventory system application',
            style: TextStyle(
              fontFamily: 'Avenir',
            )),
      ),
    );
  }
}
