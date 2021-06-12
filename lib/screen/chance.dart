
import 'package:b/screen/view.dart';
import 'package:im_stepper/stepper.dart';
import 'package:b/stand.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class AddJop extends StatefulWidget {
  @override
  _AddJopState createState() => _AddJopState();
}

class _AddJopState extends State<AddJop> {
  GlobalKey<FormState>k1 = new GlobalKey<FormState>();
  GlobalKey<FormState>k2 = new GlobalKey<FormState>();
  GlobalKey<FormState>k3 = new GlobalKey<FormState>();
  GlobalKey<FormState>k4 = new GlobalKey<FormState>();
  GlobalKey<FormState>k5 = new GlobalKey<FormState>();


  Map<String, dynamic> d = {
    "id": "",
    "title": "",
    "quiz": false,
    "age": "",
    "salary": "",
    "workTime": "",
    "langNum": 1,
    "lang": [],
    "skillNum": 1,
    "skill": [],
    "quizList": [],
    "expir": "",
    "quizNum": 5,
    "gender": "لا يهم",
    "degree": "لا يهم",
    "level": "مبتدأ",
    "Vacancies": 1,
    "dateOfPublication": "",
  };

  var list = new List();
  var list1 = new List();
  var total = new List();
  var aa = new List();
  Stander stan = new Stander();

  double val = 0;
  var r = 0;
  var unik = 0;

  int _index = 0;

  des() {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(15.8),
            ),
            child: IconStepper(
              activeStep: _index,
              steppingEnabled: true,
              stepRadius: 25.0,
              stepColor: Colors.white,
              activeStepBorderColor: Colors.green,
              activeStepColor: Colors.amber,
              lineColor: Colors.amberAccent,
              direction: Axis.vertical,
              icons: [
                Icon(
                  Icons.title,
                ),
                Icon(
                  Icons.person,
                ),
                Icon(
                  Icons.alarm_on_sharp,
                ),
                Icon(
                  Icons.money,
                ),
                // Icon(
                //   Icons.account_tree,
                // ),
                // Icon(
                //   Icons.language,
                // ),
                Icon(
                  Icons.wc,
                ),
                Icon(
                  Icons.edit,
                ),
                Icon(
                  Icons.local_florist,
                ),
                Icon(Icons.people_alt),
                Icon(Icons.logout),
              ],
              onStepReached: (value) {
                setState(() {
                  _index = value;
                });
              },
            )),
        Expanded(
            child: FittedBox(
              child: Center(
                child: getStep(),
              ),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("معلومات فرصة العمل"),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.8),
        ),
        child: des(),
      ),
    );
  }

  Widget x(bbb, String name, String hint, Icon c) {
    return TextFormField(
      initialValue: d[bbb],
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
      validator: (valu) {
        if (valu.isEmpty) {
          return "هذا الحقل مطلوب";
        } else if (valu.length < 5) {
          return "الكلمة قصيرة جدا";
        } else
          return null;
      },
      keyboardType: TextInputType.text,
      onChanged: (v){
        setState(() {
          d[bbb] = v;
        });
      },
      onSaved: (valu) {

          d[bbb] = valu;
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
      onChanged: (valu) {
        setState(() {
          d[v] = valu;
        });
      },
      value: d[v],
    );
  }

  Widget q(String name) {
    if (name == "خبير")
      return x(
          "expir", "عدد سنوات الخبرة:", ".......", Icon(Icons.auto_awesome));
    return Text("");
  }

  void uplod() {
    var kk1=k1.currentState;
    kk1.save();
    var kk2=k2.currentState;
    kk2.save();
    var kk3=k3.currentState;
    kk3.save();
    var kk4=k4.currentState;
    kk4.save();
    var kk5=k5.currentState;
    kk5.save();


    var v = FirebaseFirestore.instance
        .collection("companies")
        .doc(Provider.of<MyProvider>(context, listen: false).company_id)
        .collection("chance");

    stan.title = d["title"];
    stan.age = d["age"];
    //stan.skillNum = d["skillNum"];
    //stan.skill = list;
    stan.salary = d["salary"];
    stan.workTime = d["workTime"];
    //stan.langNum = d["langNum"];
    stan.expir = d["expir"];
    stan.gender = d["gender"];
    stan.degree = d["degree"];
    stan.level = d["level"];
    stan.Vacancies = d["Vacancies"];
    //stan.lang = list1;
    DateTime date = DateTime.now();
    stan.dateOfPublication = Jiffy(date).fromNow();
    v.add({
      "id": "",
      "title": stan.title,
      "age": stan.age,
      "salary": stan.salary,
      "workTime": stan.workTime,
      //"langNum": stan.langNum,
      //"lang": stan.lang,
      //"skillNum": stan.skillNum,
      //"skill": stan.skill,
      "expir": stan.expir,
      "gender": stan.gender,
      "degree": stan.degree,
      "level": stan.level,
      "Vacancies": stan.Vacancies,
      "dateOfPublication": Jiffy(date).fromNow(),
    });
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ShowingData()));
  }

  Widget getStep() {
    aa = [
      Form(
        autovalidateMode: AutovalidateMode.always,
        key: k1,
        child: SizedBox(
            width: 300,
            child: x("title", "العنوان:", ".......", Icon(Icons.title))),
      ),
      Form(
        autovalidateMode: AutovalidateMode.always,
        key: k2,
        child: SizedBox(
            width: 300,
            child: x("age", "العمر:", ".......", Icon(Icons.person))),
      ),
      Form(
        autovalidateMode: AutovalidateMode.always,
        key: k3,
        child: SizedBox(
            width: 300,
            child: x("workTime", "عدد ساعات العمل:", ".......",
                Icon(Icons.alarm_on_sharp))),
      ),
      Form(
        autovalidateMode: AutovalidateMode.always,
        key: k4,
        child: SizedBox(
            width: 300,
            child: x("salary", "الراتب:", ".......", Icon(Icons.money))),
      ),
      // SizedBox(
      //   width: 300,
      //   child: Column(
      //     children: [
      //       Row(
      //         children: [
      //           Icon(Icons.account_tree),
      //           SizedBox(
      //             width: 10,
      //           ),
      //           Text("عدد المهارات المطلوبة :"),
      //           SizedBox(
      //             width: 10,
      //           ),
      //           z("skillNum", "المهارات", [1, 2, 3, 4, 5]),
      //         ],
      //       ),
      //       ListView.builder(
      //           shrinkWrap: true,
      //           padding: EdgeInsets.all(8),
      //           itemCount: d["skillNum"],
      //           itemBuilder: (context, i) {
      //             return x("skill", "المهارة", "........", Icon(Icons.api));
      //           }),
      //     ],
      //   ),
      // ),
      // SizedBox(
      //   width: 300,
      //   child: Column(
      //     children: [
      //       Row(
      //         children: [
      //           Icon(Icons.language),
      //           SizedBox(
      //             width: 10,
      //           ),
      //           Text("اللغات المطلوبة :"),
      //           SizedBox(
      //             width: 10,
      //           ),
      //           z("langNum", "اللغات", [1, 2, 3, 4]),
      //         ],
      //       ),
      //       ListView.builder(
      //           shrinkWrap: true,
      //           itemCount: d["langNum"],
      //           itemBuilder: (context, i) {
      //             return x("lang", "اللغة", "........",
      //                 Icon(Icons.leak_add_rounded));
      //           }),
      //     ],
      //   ),
      // ),
      SizedBox(
        width: 300,
        child: Row(
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
      ),
      SizedBox(
        width: 300,
        child: Row(
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
        ),
      ),
      Form(
        autovalidateMode: AutovalidateMode.always,
        key: k5,
        child: SizedBox(
          width: 300,
          child: Column(
            children: [
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
            ],
          ),
        ),
      ),
      SizedBox(
        width: 300,
        child: Row(
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
      ),
      SizedBox(
        width: 300,
        child: Column(
          children: [
            IconButton(icon: Icon(Icons.add), onPressed: uplod),
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ShowingData()));
                }),
          ],
        ),
      ),
    ];
    return aa[_index];
  }
}
