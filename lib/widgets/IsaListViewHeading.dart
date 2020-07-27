import 'package:flutter/material.dart';

// =========================================================================
// Isa ListView Header
// =========================================================================

class IsaListViewHeading extends StatelessWidget {
  final headerTitle;
  final widthPercent;
  final align;

  IsaListViewHeading(this.headerTitle, this.widthPercent, [this.align]);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * this.widthPercent,
      child: Text(this.headerTitle,
          textAlign: this.align != null ? this.align : TextAlign.start,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Theme.of(context).primaryColor)),
    );
  }
}
