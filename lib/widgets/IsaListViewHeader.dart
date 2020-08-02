import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

// =========================================================================
// Isa ListViewHeader
// =========================================================================

class IsaListViewHeader extends StatefulWidget {
  final fetchItems;
  final sendReport;

  IsaListViewHeader(this.fetchItems, this.sendReport);

  @override
  _IsaListViewHeaderState createState() => _IsaListViewHeaderState();
}

// =========================================================================
// Isa ListViewHeader State
// =========================================================================

class _IsaListViewHeaderState extends State<IsaListViewHeader> {
  List<DateTime> selectedRange = [
    DateTime.now(),
    (DateTime.now()).add(Duration(days: 7))
  ];

  // date select handler
  void handleSelectDateRange() async {
    final List<DateTime> range = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: selectedRange[0],
        initialLastDate: selectedRange[1],
        firstDate: DateTime(2020),
        lastDate: DateTime(2050));

    if (range != null) {
      widget.fetchItems([...range]);

      setState(() {
        selectedRange = range;
      });
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
                '${dateFormat.format(selectedRange[0]).toString()} - ${dateFormat.format(selectedRange[1]).toString()}',
                style: Theme.of(context).textTheme.bodyText2),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            onPressed: handleSelectDateRange,
          ),
          Spacer(),
          IconButton(
            constraints: BoxConstraints(maxHeight: 36),
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.print),
            onPressed: () => widget.sendReport(selectedRange),
          )
        ],
      ),
    );
  }
}
