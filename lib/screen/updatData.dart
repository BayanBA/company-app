import 'package:b/stand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detals.dart';

class UpdatData extends StatefulWidget {

  @override
  _UpdatDataState createState() => _UpdatDataState();
}

class _UpdatDataState extends State<UpdatData> {
  GlobalKey<FormState> ff = new GlobalKey<FormState>();
  CollectionReference comp = FirebaseFirestore.instance.collection("company");
  var data;
  Map<String, dynamic> d;

  editData() async {
    data =Provider.of<MyProvider>(context,listen: false).data;
    d=data;
  }


  var total = new List();
  double val = 0;
  var r = 0;
  var unik = 0;

  my() {
    if (unik == 0) {
      total.add(x("title", "العنوان:", ".......", Icon(Icons.title), 0,data["title"]));
      total.add(x("age", "العمر:", ".......", Icon(Icons.person), 0,data["age"]));
      total.add(x("workTime", "عدد ساعات العمل:", ".......", Icon(Icons.alarm_on_sharp), 0,data["workTime"]));
      total.add(x("salary", "الراتب:", ".......", Icon(Icons.money), 0,data["salary"]));
      total.add(Column(children: [
        Row(
          children: [
            Icon(Icons.account_tree),
            SizedBox(
              width: 10,
            ),
            Text("عدد المهارات المطلوبة :"),
            SizedBox(
              width: 10,
            ),
            z("skillNum", "المهارات", [1, 2, 3, 4, 5]),
          ],
        ),
        ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(8),
            itemCount: d["skillNum"],
            itemBuilder: (context, i) {
              return x("skill", "المهارة", "........", Icon(Icons.api), 1,data["skill"]);
            })
      ]));
      total.add(Column(children: [
        Row(
          children: [
            Icon(Icons.language),
            SizedBox(
              width: 10,
            ),
            Text("اللغات المطلوبة :"),
            SizedBox(
              width: 10,
            ),
            z("langNum", "اللغات", [1, 2, 3, 4]),
          ],
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: d["langNum"],
            itemBuilder: (context, i) {
              return x(
                  "lang", "اللغة", "........", Icon(Icons.leak_add_rounded), 2,data["lang"]);
            })
      ]));
      total.add(Row(
        children: [
          Icon(Icons.wc),
          SizedBox(
            width: 10,
          ),
          Text("الجنس :"),
          SizedBox(
            width: 10,
          ),
          z("gender", "الجنس", ["ذكر", "أنثى", "لا يهم"])
        ],
      ));
      total.add(Row(
        children: [
          Icon(Icons.edit),
          SizedBox(
            width: 10,
          ),
          Text("المستوى لبعلمي :"),
          SizedBox(
            width: 10,
          ),
          z("degree", "شهادة",
              ["لا يهم", "اعدادي", "ثانوي", "جامعي", "ماستر", "دوكتورا"])
        ],
      ));
      total.add(Column(children: [
        Row(
          children: [
            Icon(Icons.local_florist),
            SizedBox(
              width: 10,
            ),
            Text("المستوى الوظيفي :"),
            SizedBox(
              width: 10,
            ),
            z("level", "المستوى", ["مبتدأ", "متمرس", "خبير"])
          ],
        ),
        q(d["level"])
      ]));
      total.add(Row(
        children: [
          Icon(Icons.account_tree),
          SizedBox(
            width: 10,
          ),
          Text("عدد الشواغر:"),
          SizedBox(
            width: 10,
          ),
          z("Vacancies", "شواغر", [
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
            13,
            14,
            15,
            16,
            17,
            18,
            19,
            20
          ]),
        ],
      ));
      total.add(IconButton(icon: Icon(Icons.add), onPressed: uplod),);

      unik = 1;
    }

    r = total.length - 1;
    return total[val as int];
  }



  @override
  void initState() {
    editData();
    super.initState();
  }

  var list = new List();
  var list1 = new List();

  Stander stan = new Stander();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("معلومات فرصة العمل"),
      ),
      body: data == null
          ? Text("hyhyhyhhy")
          : SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: ff,
                child:
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    x("title", "العنوان:", ".......", Icon(Icons.title), 0,
                        data["title"]),
                    x("age", "العمر:", ".......", Icon(Icons.person), 0,
                        data["age"]),
                    x("workTime", "عدد ساعات العمل:", ".......",
                        Icon(Icons.alarm_on_sharp), 0, data["workTime"]),
                    x("salary", "الراتب:", ".......", Icon(Icons.money), 0,
                        data["salary"]),
                    Row(
                      children: [
                        Icon(Icons.account_tree),
                        SizedBox(
                          width: 10,
                        ),
                        Text("عدد المهارات المطلوبة :"),
                        SizedBox(
                          width: 10,
                        ),
                        z("skillNum", "المهارات", [1, 2, 3, 4, 5]),
                      ],
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: data["skillNum"],
                        itemBuilder: (context, i) {
                          return x("skill", "المهارة", "........",
                              Icon(Icons.api), 1, data["skill"][i]);
                        }),
                    Row(
                      children: [
                        Icon(Icons.language),
                        SizedBox(
                          width: 10,
                        ),
                        Text("اللغات المطلوبة :"),
                        SizedBox(
                          width: 10,
                        ),
                        z("langNum", "اللغات", [1, 2, 3, 4]),
                      ],
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: data["langNum"],
                        itemBuilder: (context, i) {
                          return x("lang", "اللغة", "........",
                              Icon(Icons.leak_add_rounded), 2, data["lang"][i]);
                        }),
                    Row(
                      children: [
                        Icon(Icons.wc),
                        SizedBox(
                          width: 10,
                        ),
                        Text("الجنس :"),
                        SizedBox(
                          width: 10,
                        ),
                        z("gender", "الجنس", ["ذكر", "أنثى", "لا يهم"])
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(
                          width: 10,
                        ),
                        Text("المستوى لبعلمي :"),
                        SizedBox(
                          width: 10,
                        ),
                        z("degree", "شهادة", [
                          "لا يهم",
                          "اعدادي",
                          "ثانوي",
                          "جامعي",
                          "ماستر",
                          "دوكتورا"
                        ])
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.account_tree),
                        SizedBox(
                          width: 10,
                        ),
                        Text("عدد الشواغر:"),
                        SizedBox(
                          width: 10,
                        ),
                        z("Vacancies", "شواغر", [
                          1,
                          2,
                          3,
                          4,
                          5,
                          6,
                          7,
                          8,
                          9,
                          10,
                          11,
                          12,
                          13,
                          14,
                          15,
                          16,
                          17,
                          18,
                          19,
                          20
                        ]),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.local_florist),
                        SizedBox(
                          width: 10,
                        ),
                        Text("المستوى الوظيفي :"),
                        SizedBox(
                          width: 10,
                        ),
                        z("level", "المستوى", ["مبتدأ", "متمرس", "خبير"])
                      ],
                    ),
                    q(d["level"]),
                    IconButton(icon: Icon(Icons.add), onPressed: uplod),
                  ],
                ),
              ),
            ),
    );
  }

  Widget x(bbb, String name, String hint, Icon c, int i, var sav) {
    return TextFormField(
      initialValue: sav,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.lightGreen,
              width: 2,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.deepPurple,
              width: 2,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.pink,
              width: 2,
            )),
        contentPadding: EdgeInsets.all(15),
        labelText: name,
        labelStyle: TextStyle(fontSize: 20),
        prefixIcon: c,
        hintText: hint,
      ),
      validator: (val) {
        if (val.isEmpty) {
          return "هذا الحقل مطلوب";
        } else if (val.length < 5) {
          return "الكلمة قصيرة جدا";
        } else
          return null;
      },
      keyboardType: TextInputType.text,
      onSaved: (val) {
        if (i == 1)
          list.add(val);
        else if (i == 2)
          list1.add(val);
        else
          d[bbb] = val;
      },
    );
  }

  Widget z(var v, String name, List<dynamic> l) {
    return DropdownButton(
      hint: Text(name),
      items: l
          .map((e) => DropdownMenuItem(
                child: Text("$e"),
                value: e,
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          d[v] = val;
        });
      },
      value: d[v],
    );
  }

  Widget q(String name) {
    if (name == "خبير")
      return x("expir", "عدد سنوات الخبرة:", ".......",
          Icon(Icons.auto_awesome), 0, data["expir"]);
    return Text("");
  }

  void uplod() {
    var fo = ff.currentState;
    fo.save();
    var v = FirebaseFirestore.instance.collection("companies").doc(Provider.of<MyProvider>(context, listen: false).company_id).collection("chance");

    stan.title = d["title"];
    stan.age = d["age"];
    stan.skillNum = d["skillNum"];
    stan.skill = list;
    stan.salary = d["salary"];
    stan.workTime = d["workTime"];
    stan.langNum = d["langNum"];
    stan.expir = d["expir"];
    stan.gender = d["gender"];
    stan.degree = d["degree"];
    stan.level = d["level"];
    stan.Vacancies = d["Vacancies"];
    stan.lang = list1;
    //DateTime date = DateTime.now();
    //stan.dateOfPublication = Jiffy(date).fromNow();
    v.doc(data["id"]).update({
      "title": stan.title,
      "age": stan.age,
      "salary": stan.salary,
      "workTime": stan.workTime,
      "langNum": stan.langNum,
      "lang": stan.lang,
      "skillNum": stan.skillNum,
      "skill": stan.skill,
      "expir": stan.expir,
      "gender": stan.gender,
      "degree": stan.degree,
      "level": stan.level,
      "Vacancies": stan.Vacancies,
    });

    Provider.of<MyProvider>(context,listen: false).data=d;

     Navigator.of(context)
       .pushReplacement(MaterialPageRoute(builder: (context) => Detals()));
  }
}
