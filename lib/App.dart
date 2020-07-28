import 'package:flutter/material.dart';
import 'package:isa/helpers/dbProvider.dart';

import './screens/ItemForm.dart';
import './widgets/IsaAppBar.dart';
import './widgets/IsaListView.dart';

// =========================================================================
// App
// =========================================================================

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DBProvider dbIsa = DBProvider();

    void navigateToItemForm() async {
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => ItemForm()));
    }

    // db initialization
    dbIsa.initDB().then((res) => print('DB connection established ✨'));

    return Scaffold(
        appBar: IsaAppBar(title: 'ISA'),
        floatingActionButton: FloatingActionButton(
          onPressed: navigateToItemForm,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.add, color: Colors.white),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          child: IsaListView(),
        ));
  }
}
