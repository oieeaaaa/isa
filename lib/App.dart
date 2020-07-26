import 'package:flutter/material.dart';
import 'package:isa/helpers/dbProvider.dart';

import './widgets/IsaAppBar.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DBProvider dbIsa = DBProvider();

    // db initialization
    dbIsa.initDB().then((res) => print('DB connection established ✨'));

    return Scaffold(
      appBar: IsaAppBar(title: 'ISA'),
      body: Center(
        child: Text('Inventory system application',
            style: TextStyle(
              fontFamily: 'Avenir',
            )),
      ),
    );
  }
}
