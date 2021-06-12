
class jobs {
  String _id;
  String _name_advance;
  String _email_advance;
  String _name_job;
  String _region;
  String _company;
  String _description;
  String _type_image;
  String _phone;
  // String _owner;

  jobs(this._id,  this._region, this._company, this._description,
      this._email_advance, this._name_advance,this._type_image,this._name_job,this._phone);

  jobs.map(dynamic obj) {
    this._name_job = obj['name_job'];
    this._region = obj['region'];
    this._company = obj['company'];
    this._description = obj['description'];
    this._name_advance = obj['name_advance'];
    this._email_advance = obj['email_advance'];
    this._type_image = obj['type_image'];
    this._phone = obj['phone'];
    // this._owner = obj['owner'];

  }

  String get id => _id;
  String get name_advance => _name_advance;
  String get email_advance => _email_advance;
  String get name_job => _name_job;
  String get region => _region;
  String get company => _company;
  String get type_image => _type_image;
  String get phone => _phone;
  // String get owner => _owner;
  String get description => _description;


}
