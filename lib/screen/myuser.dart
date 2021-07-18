class user {
  String _carrer;
  String _ename;
  String _fname;
  String _home;
  String _exper;
  String _skill;
  String _level;
  String _work;


  user(
      this._carrer,
      this._ename,
      this._exper,
      this._home,
      this._level,
      this._fname,
      this._skill,
      this._work,
      );

  user.map(dynamic obj) {
    this._carrer = obj['carrer_level'];
    this._ename = obj['endname'];
    this._exper = obj['experience_year'];
    this._home = obj['originalhome'];
    this._level = obj['scientific_level'];
    this._fname = obj['firstname'];
    this._skill = obj['skill'];
    this._work = obj['work_field'];
  }

  String get carrer => _carrer;

  String get endname => _ename;

  String get firstname => _fname;

  String get experince => _exper;

  String get level => _level;

  String get home => _home;

  String get skill => _skill;

  String get work => _work;


}
