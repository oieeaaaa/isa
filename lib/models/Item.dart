class Item {
  // =========================================================================
  // FIELDS
  // =========================================================================

  // item details
  int _id;
  String _name;
  double _price;
  String _imageUrl;
  double _quantity;

  // customer information
  String _customerName;
  String _customerContactNumber;

  // miscellaneous
  String _notes;
  String _createdAt;

  // =========================================================================
  // CONSTRUCTORS
  // =========================================================================

  // without id
  Item(this._name, this._createdAt,
      [this._price,
      this._imageUrl,
      this._quantity,
      this._customerName,
      this._customerContactNumber,
      this._notes]);

  // with id
  Item.withId(this._id, this._name,
      [this._price,
      this._imageUrl,
      this._quantity,
      this._customerName,
      this._customerContactNumber,
      this._notes]);

  // =========================================================================
  // GETTERS
  // =========================================================================

  int get id => _id;
  String get name => _name;
  double get price => _price;
  String get imageUrl => _imageUrl;
  double get quantity => _quantity;
  String get customerName => _customerName;
  String get customerContactNumber => _customerContactNumber;
  String get notes => _notes;
  String get createdAt => _createdAt;

  // =========================================================================
  // SETTERS
  // =========================================================================

  set name(String newName) {
    if (newName.length <= 255) {
      _name = newName;
    }
  }

  set price(double newPrice) {
    if (newPrice > 0) {
      _price = newPrice;
    }
  }

  set customerName(String newCustomerName) {
    if (newCustomerName.length <= 255) {
      _customerName = newCustomerName;
    }
  }

  set customerContactNumber(String newCustomerContactNumber) {
    // 11 is equal to the total length of contact number in PH
    // If the app will be internationalize this has to change
    if (newCustomerContactNumber.length == 11) {
      _customerContactNumber = newCustomerContactNumber;
    }
  }

  // =========================================================================
  // HELPERS
  // =========================================================================

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': _name,
      'price': _price,
      'imageUrl': _imageUrl,
      'quantity': _quantity,
      'customerName': _customerName,
      'customerContactNumber': _customerContactNumber,
      'notes': _notes,
      'createdAt': _createdAt,
    };

    if (_id != null) {
      map['id'] = _id;
    }

    return map;
  }

  Item.fromObject(dynamic o) {
    this._id = o['id'];
    this._name = o['name'];
    this._price = o['price'];
    this._imageUrl = o['imageUrl'];
    this._quantity = o['quantity'];
    this._customerName = o['customerName'];
    this._customerContactNumber = o['customerContactNumber'];
    this._notes = o['notes'];
    this._createdAt = o['createdAt'];
  }
}
