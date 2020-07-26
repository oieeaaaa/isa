import 'package:flutter/material.dart';

// =========================================================================
// IsaAppBar
// =========================================================================

class IsaAppBar extends StatefulWidget implements PreferredSizeWidget {
  IsaAppBar({Key key, this.title})
      : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  final Size preferredSize;
  final String title;

  @override
  _IsaAppBarState createState() => _IsaAppBarState();
}

// =========================================================================
// IsaAppBar State
// =========================================================================
class _IsaAppBarState extends State<IsaAppBar> {
  String get title => widget.title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Align(
            alignment: Alignment.topLeft,
            child: Text(title,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white,
                ))));
  }
}
