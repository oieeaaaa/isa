import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import '../App.dart';
import '../helpers/dbProvider.dart';
import '../models/Item.dart';
import '../widgets/IsaAppBar.dart';
import '../widgets/IsaGoBack.dart';
import '../widgets/IsaImageInput.dart';

// =========================================================================
// Item Form
// =========================================================================

class ItemForm extends StatefulWidget {
  final imagePath;

  ItemForm([this.imagePath]);

  @override
  _ItemFormState createState() => _ItemFormState();
}

// =========================================================================
// Item FormState
// =========================================================================

class _ItemFormState extends State<ItemForm> {
  DBProvider dbIsa = DBProvider();
  final _itemFormKey = GlobalKey<FormState>();

  // Ctrl stands for Controller
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController customerFullNameCtrl = TextEditingController();
  TextEditingController customerContactNumberCtrl = TextEditingController();
  TextEditingController notesCtrl = TextEditingController();

  // name validator
  String nameValidator(String text) {
    if (text.isEmpty) {
      return 'Product name is required.';
    }

    return null;
  }

  // price validator
  String priceValidator(String text) {
    if (text.isEmpty) {
      return 'Price is required.';
    }

    return null;
  }

  // contact number validator
  String contactNumberValidator(String text) {
    if (text.length != 11) {
      return 'Contact number digits must be equal to 11';
    }

    return null;
  }

  // save handler
  void handleSave() async {
    if (_itemFormKey.currentState.validate()) {
      String imageUrl = '';

      if (widget.imagePath != null) {
        List<int> bytes = File(widget.imagePath).readAsBytesSync();
        imageUrl = base64.encode(bytes);
      }

      Item data = Item(
        // required fields
        nameCtrl.text,
        double.parse(priceCtrl.text),
        DateTime.now().toString(),

        // optional fields
        imageUrl,
        customerFullNameCtrl.text,
        customerContactNumberCtrl.text,
        notesCtrl.text,
      );

      dbIsa.insertItem(data).then((result) => {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => App()))
          });
    }
  }

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
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 50),
            child: ListView(
              children: <Widget>[
                // go back
                IsaGoBack(),

                SizedBox(height: 40),

                // product details
                heading('Product details'),

                SizedBox(height: 20),

                // image input
                IsaImageInput(widget.imagePath),

                SizedBox(height: 20),

                // name
                TextFormField(
                  controller: nameCtrl,
                  validator: nameValidator,
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
                        controller: priceCtrl,
                        validator: priceValidator,
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
                  controller: customerFullNameCtrl,
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: inputDecoration('Full name'),
                ),

                SizedBox(height: 20),

                // contact number
                TextFormField(
                  controller: customerContactNumberCtrl,
                  validator: contactNumberValidator,
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
                  controller: notesCtrl,
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
                      onPressed: handleSave,
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
