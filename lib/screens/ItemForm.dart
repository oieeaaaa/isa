import 'package:flutter/material.dart';

import '../widgets/IsaAppBar.dart';
import '../widgets/IsaGoBack.dart';
import '../widgets/IsaImageInput.dart';

// =========================================================================
// Item form
// =========================================================================

class ItemForm extends StatefulWidget {
  @override
  _ItemFormState createState() => _ItemFormState();
}

// =========================================================================
// Item form state
// =========================================================================

class _ItemFormState extends State<ItemForm> {
  final _itemFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // inputDecoration
    InputDecoration inputDecoration(String label) {
      return InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: Theme.of(context).accentColor),
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).accentColor, width: 1),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: OutlineInputBorder(
          //borderSide: BorderSide(
          //color: Theme.of(context).primaryColor, width: 1),
          borderRadius: BorderRadius.zero,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      );
    }

    // heading
    Widget heading(String title) {
      return Text(title,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: Theme.of(context).accentColor));
    }

    return Scaffold(
        appBar: IsaAppBar(title: 'ISA'),
        body: Form(
          key: _itemFormKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: ListView(
              children: <Widget>[
                // go back
                IsaGoBack(),

                SizedBox(height: 40),

                // product details
                heading('Product details'),

                SizedBox(height: 20),

                // image input
                IsaImageInput(),

                SizedBox(height: 20),

                // name
                TextFormField(
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: inputDecoration('Name'),
                ),

                SizedBox(height: 20),

                // price
                Row(
                  children: <Widget>[
                    Container(
                      width: 177,
                      child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText1,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: inputDecoration('Price'),
                      ),
                    ),
                    SizedBox(width: 20),
                    Text('Php',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Theme.of(context).primaryColor))
                  ],
                ),

                SizedBox(height: 40),

                // customer information
                heading('Customer Information'),

                SizedBox(height: 20),

                // customer's full name
                TextFormField(
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: inputDecoration('Full name'),
                ),

                SizedBox(height: 20),

                // contact number
                TextFormField(
                  style: Theme.of(context).textTheme.bodyText1,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: inputDecoration('Contact number'),
                ),

                SizedBox(height: 40),

                // notes
                heading('Notes'),

                SizedBox(height: 20),

                // notes input
                TextFormField(
                  minLines: 8,
                  maxLines: 10,
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: inputDecoration(''),
                ),

                SizedBox(height: 40),

                // save button
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: 142,
                    height: 50,
                    child: FlatButton(
                      splashColor: Colors.white.withAlpha(100),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {},
                      child: Text('Save',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
