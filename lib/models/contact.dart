

class Contact {
  static final String contactTable = 'contacts';
  static final String idColumn = 'id';
  static final String nameColumn = 'name';
  static final String emailColumn = 'email';
  static final String phoneColumn = 'phone';
  static final String imageColumn = 'image';

  int _id;
  String _name;
  String _email;
  String _phone;
  String _image;


  Contact();

  get id => _id;
  set id(int id) => this._id = id;

  get name => _name;
  set name(String name) => this._name = name;

  get email => _email;
  set email(String email) => this._email = email;

  get phone => _phone;
  set phone(String phone) => this._phone = phone;

  get image => _image;
  set image(String image) => this._image = image;

  Contact.fromMap(Map map) {
    _id = map[idColumn];
    _name = map[nameColumn];
    _email = map[emailColumn];
    _phone = map[phoneColumn];
    _image = map[imageColumn];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      nameColumn: _name,
      emailColumn: _email,
      phoneColumn: _phone,
      imageColumn: _image
    };
    if (_id != null)
      map[idColumn] = _id;
    return map;
  }

  @override
  String toString() {
    return 'Contact(id: $_id, name: $_name, email: $_email, phone: $_phone, image: $_image)';
  }
}