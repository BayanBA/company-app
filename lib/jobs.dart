class jobs {
  String _id;
  String _size_company;
  String _email_advance;
  String _region;
  String _city;
  String _specialization;
  String _company;
  String _description;
  String _link_image;
  String _phone;

  jobs(
      this._id,
      this._region,
      this._city,
      this._specialization,
      this._company,
      this._description,
      this._email_advance,
      this._size_company,
      this._link_image,
      this._phone);

  jobs.map(dynamic obj) {
    this._city = obj['city'];
    this._region = obj['region'];
    this._specialization = obj['specialization'];
    this._company = obj['company'];
    this._size_company = obj['size_company'];
    this._email_advance = obj['email_advance'];
    this._link_image = obj['link_image'];
    this._phone = obj['phone'];
    this._description = obj['description'];
  }

  String get id => _id;

  String get city => _city;

  String get specialization => _specialization;

  String get region => _region;

  String get company => _company;

  String get size_company => _size_company;

  String get email_advance => _email_advance;

  String get link_image => _link_image;

  String get phone => _phone;

  String get description => _description;
}
