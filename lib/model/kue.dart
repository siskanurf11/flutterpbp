class Kue {
  String _image;
  String _name;
  String _description;
  int _price;
  int _stock;
  String _category;

  Kue({
    required String image,
    required String name,
    required String description,
    required int price,
    required int stock,
    required String category,
  })  : _image = image,
        _name = name,
        _description = description,
        _price = price,
        _stock = stock,
        _category = category;

  // =========================
  // GETTER
  // =========================

  String get image => _image;
  String get name => _name;
  String get description => _description;
  int get price => _price;
  int get stock => _stock;
  String get category => _category;

  // =========================
  // SETTER
  // =========================

  set image(String value) {
    _image = value;
  }

  set name(String value) {
    _name = value;
  }

  set description(String value) {
    _description = value;
  }

  set price(int value) {
    _price = value;
  }

  set stock(int value) {
    _stock = value;
  }

  set category(String value) {
    _category = value;
  }

  // =========================
  // FUNCTION
  // =========================

  bool isAvailable() {
    return _stock > 0;
  }

  String getStockInfo() {
    if (_stock > 0) {
      return 'Stok tersedia: $_stock';
    } else {
      return 'Stok habis';
    }
  }

  String getFormattedPrice() {
    String priceString = _price.toString();
    String result = '';

    for (int i = 0; i < priceString.length; i++) {
      if (i > 0 && (priceString.length - i) % 3 == 0) {
        result += '.';
      }

      result += priceString[i];
    }

    return 'Rp$result';
  }
}