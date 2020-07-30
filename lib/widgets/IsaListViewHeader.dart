import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// =========================================================================
// Isa ListViewHeader
// =========================================================================

class IsaListViewHeader extends StatefulWidget {
  final fetchItems;

  IsaListViewHeader(this.fetchItems);

  @override
  _IsaListViewHeaderState createState() => _IsaListViewHeaderState();
}

// =========================================================================
// Isa ListViewHeader State
// =========================================================================

class _IsaListViewHeaderState extends State<IsaListViewHeader> {
  DateTime selectedDate = DateTime.now();

  // date select handler
  void handleSelectDate() async {
    DateTime newDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        initialDate: selectedDate,
        lastDate: DateTime.now());

    if (newDate != null) {
      widget.fetchItems(newDate.toString());

      setState(() {
        selectedDate = newDate;
      });
    }
  }

  // send report handler
  void handleSendReport() {
    print('Send report!');
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat.yMd();

    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 47),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.start,
        spacing: 20,
        runSpacing: 20,
        direction: Axis.horizontal,
        children: [
          Text('Date:'),
          OutlineButton(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 26),
            child: Text(dateFormat.format(selectedDate).toString(),
                style: Theme.of(context).textTheme.bodyText2),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            onPressed: handleSelectDate,
          ),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 26),
            color: Theme.of(context).accentColor,
            onPressed: handleSendReport,
            child: Text('Send Report',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
