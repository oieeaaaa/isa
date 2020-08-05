import 'dart:convert';

import 'package:flutter/material.dart';

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
  final imageBytes;

  // if this exists it means
  // that we are on edit form
  // else it will be on add form
  final int id;

  ItemForm([this.id, this.imageBytes]);

  @override
  _ItemFormState createState() => _ItemFormState();
}

// =========================================================================
// Item FormState
// =========================================================================

class _ItemFormState extends State<ItemForm> {
  DBProvider dbIsa = DBProvider();
  var image;
  final _itemFormKey = GlobalKey<FormState>();

  // Ctrl stands for Controller
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController quantityCtrl = TextEditingController.fromValue(
      TextEditingValue(text: '1')); // with an initial value
  TextEditingController customerNameCtrl = TextEditingController();
  TextEditingController customerContactNumberCtrl = TextEditingController();
  TextEditingController notesCtrl = TextEditingController();

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
            margin: EdgeInsets.only(left: 30, right: 30),
            child: ListView(
              children: <Widget>[
                // go back
                IsaGoBack(),

                SizedBox(height: 40),

                // product details
                heading('Product details'),

                SizedBox(height: 20),

                // image input
                IsaImageInput(widget.id, image),

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

                SizedBox(height: 20),

                // quantity
                TextFormField(
                  controller: quantityCtrl,
                  style: Theme.of(context).textTheme.bodyText1,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: inputDecoration('Quantity'),
                ),

                SizedBox(height: 40),

                // customer information
                heading('Customer Information'),

                SizedBox(height: 20),

                // customer's full name
                TextFormField(
                  controller: customerNameCtrl,
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

                SizedBox(height: 30),

                // on save
                if (widget.id == null)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 142,
                      height: 50,
                      child: FlatButton(
                        splashColor: Colors.white.withAlpha(100),
                        color: Theme.of(context).primaryColor,
                        onPressed: handleSave,
                        child: Text('Add',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.white)),
                      ),
                    ),
                  ),

                // on update/delete
                if (widget.id != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 142,
                        height: 50,
                        child: FlatButton(
                          splashColor: Colors.white.withAlpha(100),
                          color: Theme.of(context).primaryColor,
                          onPressed: handleUpdate,
                          child: Text('Update',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(color: Colors.white)),
                        ),
                      ),
                      Container(
                        width: 142,
                        height: 50,
                        child: FlatButton(
                          splashColor: Colors.white.withAlpha(100),
                          color: Theme.of(context).accentColor,
                          onPressed: handleDelete,
                          child: Text('Delete',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),

                // margin bottom
                SizedBox(height: 30),
              ],
            ),
          ),
        ));
  }

  String contactNumberValidator(String text) {
    if (text.length == 0) return null;

    if (text.length != 11) {
      return 'Contact number digits must be equal to 11';
    }

    return null;
  }

  void handleSave() async {
    if (_itemFormKey.currentState.validate()) {
      var encodedImage;

      if (image != null) {
        encodedImage = base64.encode(image);
      }

      Item data = Item(
        // required fields
        nameCtrl.text,
        DateTime.now().toString(),

        // optional fields
        priceCtrl.text != '' ? double.parse(priceCtrl.text) : null,
        encodedImage,
        quantityCtrl.text != '' ? double.parse(quantityCtrl.text) : null,
        customerNameCtrl.text,
        customerContactNumberCtrl.text,
        notesCtrl.text,
      );

      var result = await dbIsa.insertItem(data);

      if (result != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => App()));
      }
    }
  }

  void handleUpdate() async {
    if (_itemFormKey.currentState.validate()) {
      var encodedImage;

      if (image != null) {
        encodedImage = base64.encode(image);
      }

      Item data = Item.withId(
        // required fields
        widget.id,
        nameCtrl.text,

        // optional fields
        priceCtrl.text != '' ? double.parse(priceCtrl.text) : null,
        encodedImage,
        quantityCtrl.text != '' ? double.parse(quantityCtrl.text) : null,
        customerNameCtrl.text,
        customerContactNumberCtrl.text,
        notesCtrl.text,
      );

      var result = await dbIsa.updateItem(data);

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
            title: Text(
                (result != null)
                    ? 'Updated ${nameCtrl.text} ✅'
                    : 'Failed to update ${nameCtrl.text} ☹️',
                style: Theme.of(context).textTheme.bodyText2)),
      );
    }
  }

  void handleDelete() async {
    var result = await dbIsa.deleteItem(widget.id);

    if (result != null) {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Deleted ${nameCtrl.text} 🔥'),
        ),
      );

      // go back
      Navigator.push(context, MaterialPageRoute(builder: (context) => App()));
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.id != null) {
      dbIsa.getItem(widget.id).then((result) {
        nameCtrl.text = result['name'];
        priceCtrl.text =
            result['price'] != null ? result['price'].toString() : '';
        quantityCtrl.text = result['quantity'].toString();
        customerNameCtrl.text = result['customerName'];
        customerContactNumberCtrl.text = result['customerContactNumber'];
        notesCtrl.text = result['notes'];

        setState(() {
          image = widget.imageBytes != null
              ? widget.imageBytes
              : Base64Decoder().convert(result['imageUrl']);
        });
      });
    } else if (widget.imageBytes != null) {
      setState(() {
        image = widget.imageBytes;
      });
    } else {
      return;
    }
  }

  String nameValidator(String text) {
    if (text.isEmpty) {
      return 'Product name is required.';
    }

    return null;
  }
}
