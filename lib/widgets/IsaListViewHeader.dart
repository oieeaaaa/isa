import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:provider/provider.dart';

import '../main.dart';

// =========================================================================
// Isa ListViewHeader
// =========================================================================

class IsaListViewHeader extends StatefulWidget {
  final itemsLength;
  final fetchItems;
  final sendReport;

  IsaListViewHeader(this.fetchItems, this.sendReport, this.itemsLength);

  @override
  _IsaListViewHeaderState createState() => _IsaListViewHeaderState();
}

// =========================================================================
// Isa ListViewHeader State
// =========================================================================

class _IsaListViewHeaderState extends State<IsaListViewHeader> {
  // date select handler
  void handleSelectDateRange() async {
    final List<DateTime> range = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate:
            Provider.of<MainModel>(context, listen: false).selectedRange[0],
        initialLastDate:
            Provider.of<MainModel>(context, listen: false).selectedRange[1],
        firstDate: DateTime(2020),
        lastDate: DateTime(2050));

    if (range != null) {
      widget.fetchItems([...range]);

      Provider.of<MainModel>(context, listen: false).updateSelectedRange(range);
    }
  }

  // on print
  void onPrint() {
    if (widget.itemsLength == 0) {
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text('No items in the queue'),
        ),
      );
    } else {
      widget.sendReport(
          Provider.of<MainModel>(context, listen: false).selectedRange);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat.yMd();

    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 47),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Date:'),
          SizedBox(width: 10),
          OutlineButton(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(14),
            child: Text(
                '${dateFormat.format(Provider.of<MainModel>(context, listen: false).selectedRange[0]).toString()} - ${dateFormat.format(Provider.of<MainModel>(context, listen: false).selectedRange[1]).toString()}',
                style: Theme.of(context).textTheme.bodyText2),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            onPressed: handleSelectDateRange,
          ),
          Spacer(),
          IconButton(
            constraints: BoxConstraints(maxHeight: 36),
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.print),
            onPressed: onPrint,
          )
        ],
      ),
    );
  }
}
