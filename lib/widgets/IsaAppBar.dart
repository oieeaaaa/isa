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
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Align(
            alignment: Alignment.topLeft,
            child: Text(title,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.white))));
  }
}
