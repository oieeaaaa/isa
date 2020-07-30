import 'package:flutter/material.dart';
import '../App.dart';

// =========================================================================
// Isa GoBack
// =========================================================================

class IsaGoBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => App())),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                width: 20,
                height: 1,
                child: Divider(color: Theme.of(context).primaryColor)),
            SizedBox(width: 15),
            Text('go back', style: Theme.of(context).textTheme.bodyText2),
          ],
        ),
      ),
    );
  }
}
