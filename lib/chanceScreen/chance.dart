import 'package:b/chanceScreen/chanceT.dart';
import 'package:b/chanceScreen/chanceV.dart';
import 'package:b/quizSecreen/questionAnswere.dart';
import 'package:b/quizSecreen/truefalse.dart';
import 'package:b/chanceScreen/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_stepper/stepper.dart';
import 'package:b/stand.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

class AddJop extends StatefulWidget {
  @override
  AddJopState createState() => AddJopState();
}

class AddJopState extends State<AddJop> {
  GlobalKey<FormState> k1 = new GlobalKey<FormState>();
  GlobalKey<FormState> k2 = new GlobalKey<FormState>();
  GlobalKey<FormState> k3 = new GlobalKey<FormState>();
  GlobalKey<FormState> k4 = new GlobalKey<FormState>();
  GlobalKey<FormState> k5 = new GlobalKey<FormState>();
  GlobalKey<FormState> k6 = new GlobalKey<FormState>();
  GlobalKey<FormState> k7 = new GlobalKey<FormState>();
  GlobalKey<FormState> k8 = new GlobalKey<FormState>();
  String u;
  String id_chance;
  var token;
  var userr;
  String name_comp;
  var follow = new List();
  var my_lis = new List();

  var aa = new List();
  Stander stan = new Stander();
  double val = 0;
  var r = 0;
  var unik = 0;
  int _index = 0;
  CollectionReference comp;
  var users_noti;
  bool _animate = false;
  bool _defaultInteractions = true;
  double _arcRatio = 0.5;
  charts.ArcLabelPosition _arcLabelPosition = charts.ArcLabelPosition.auto;
  charts.BehaviorPosition _titlePosition = charts.BehaviorPosition.bottom;
  charts.BehaviorPosition _legendPosition = charts.BehaviorPosition.start;
  var _filters = new List();
  List<_CostsData> data = [
    _CostsData('العنوان', 0),
    _CostsData('الوصف', 0),
    _CostsData('المهارات', 0),
    _CostsData('المستوى الوظيفي', 0),
    _CostsData('المستوى العلمي', 0),
    _CostsData('التخصص', 0),
    _CostsData('الجنس', 0),
    _CostsData('الساعات', 0),
    _CostsData('الراتب', 0),
    _CostsData('الشواغر', 0),
  ];

  void initState() {
    getdata1();
    super.initState();
  }

  Map<String, dynamic> d = {
    "id": "",
    "title": "",
    "quiz": false,
    "salary": "أقل من 100000",
    "workTime": "دوام جزئي",
    "specialties": "الترجمة",
    "langNum": [],
    "skillNum": "",
    "quizList": [],
    "describsion": "",
    "expir": "1",
    "quizNum": 5,
    "gender": "لا يهم",
    "degree": "لا يهم",
    "level": "مبتدأ",
    "Vacancies": 1,
    "date_publication": "",
  };

  getdata1() async {
    CollectionReference t = FirebaseFirestore.instance.collection("companies");
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    userr = await FirebaseAuth.instance.currentUser;

    await t.where("email_advance", isEqualTo: userr.email).get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          u = element.id;
          name_comp = element.data()['company'];
          follow = element.data()['followers'];
        });
      });
    });

    await FirebaseMessaging.instance.getToken().then((value) {
      token = value;
    });
  }

  sendMessage(
      String title, String body, int i, String u, String c, String num) async {
    var serverToken =
        "AAAAUnOn5ZE:APA91bGSkIL6DLpOfbulM_K3Yp5W1mlcp8F0IWu2mcKWloc4eQcF8C230XaHhXBfBYphuyp2P92dc_Js19rBEuU6UqPBGYOSjJfXsBJVmIu9TsLe44jaSOLDAovPTspwePb1gw7-1GNZ";
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: jsonEncode(<String, dynamic>{
          'notification': {
            'title': title.toString(),
            'body': body.toString(),
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'flutter notifcation_click',
            'id_company': u,
            'id': c,
            'num': num,
          },
          'to': await my_lis[i],
        }));
  }

  des() {
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
              //color: Colors.blueGrey,
              border: Border.all(
                color: Colors.deepPurpleAccent,
                width: 2,
              ),
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
                  Icons.wb_incandescent_outlined,
                ),
                Icon(
                  Icons.account_tree,
                ),
                Icon(
                  Icons.translate,
                ),
                Icon(
                  Icons.local_florist,
                ),
                Icon(
                  Icons.perm_contact_cal_outlined,
                ),
                Icon(
                  Icons.star_purple500_outlined,
                ),
                Icon(
                  Icons.wc,
                ),
                Icon(
                  Icons.alarm_on_sharp,
                ),
                Icon(
                  Icons.money,
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

  Widget x(bbb, String name, String hint, Icon c, var k, int i) {
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
        } else if (valu.length < 2) {
          return "الكلمة قصيرة جدا";
        } else
          return null;
      },
      keyboardType: TextInputType.text,
      onChanged: (v) {
        setState(() {
          d[bbb] = v;
          drow(k, i);
        });
      },
      onSaved: (valu) {
        d[bbb] = valu;
      },
      onEditingComplete: () {
        _index++;
        drow(k, i);
        FocusScope.of(context).unfocus();
      },
    );
  }

  drow(var k, int i) {
    var kk = k.currentState;
    if (kk.validate())
      edit(i);
    else
      data[i].cost = 0;
  }

  Widget z(var v, String name, List<dynamic> l, int i) {
    return DropdownButton(
      dropdownColor: Theme.of(context).accentColor,
      menuMaxHeight: 300,
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
      onTap: () {
        edit(i - 1);
      },
      value: d[v],
    );
  }

  Widget q(String name, var k, int i) {
    if (name == "خبير")
      return SizedBox(
        width: 300,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.auto_awesome),
                SizedBox(
                  width: 10,
                ),
                Text("عدد سنوات الخبرة:"),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            DropdownButton(
              menuMaxHeight: 300,
              hint: Text("عدد سنوات الخبرة"),
              items: ['1', '2', '3', '4', '5', '6', '7', '8', 'اكثر من 8']
                  .map((e) => DropdownMenuItem(
                        child: Text("$e"),
                        value: e,
                      ))
                  .toList(),
              onChanged: (valu) {
                setState(() {
                  d["expir"] = valu;
                });
              },
              onTap: () {
                edit(i);
              },
              value: d["expir"],
            )
          ],
        ),
      );
    return Text("");
  }

  var num;

  void uplod() async {
    var t = 15;
    for (int j = 0; j < data.length; j++) {
      if (data[j].cost != 100) {
        t = j;
        break;
      }
    }
    if (_filters.isEmpty) {
      Fluttertoast.showToast(
          msg: "تحقق من القيم المدخلة",
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT);
      setState(() {
        _index = 3;
      });
    }
    else if (t != 15) {
      Fluttertoast.showToast(
          msg: "تحقق من القيم المدخلة",
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT);
      setState(() {
        if(t<3)
          _index = t;
        else
          _index = t+1;

      });
    } else {
      Fluttertoast.showToast(
          msg: "تم نشر الفرصة",
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT);
      my_lis = new List();
      CollectionReference users =
          FirebaseFirestore.instance.collection("users");

      var v = FirebaseFirestore.instance
          .collection("companies")
          .doc(Provider.of<MyProvider>(context, listen: false).company_id)
          .collection("chance");

      var n = await FirebaseFirestore.instance
          .collection("number")
          .doc("aLOUXiw8hVsNqdzEsjF5")
          .get()
          .then((value) {
        num = value.data()["num"];
      });
      num = num + 1;

      FirebaseFirestore.instance
          .collection("number")
          .doc("aLOUXiw8hVsNqdzEsjF5")
          .update({"num": num});

      stan.title = d["title"];
      stan.skillNum = d["skillNum"];
      stan.salary = d["salary"];
      stan.workTime = d["workTime"];
      stan.langNum = _filters;
      stan.specialties = d["specialties"];
      stan.level = d["level"];
      stan.level == "خبير" ? stan.expir = d["expir"] : stan.expir = "";
      stan.gender = d["gender"];
      stan.degree = d["degree"];
      stan.describsion = d["describsion"];
      stan.Vacancies = d["Vacancies"];
      DateTime date = DateTime.now();
      v.add({
        "id": "",
        "Q": Provider.of<MyProvider>(context, listen: false).Q,
        "A": Provider.of<MyProvider>(context, listen: false).A,
        "Z": Provider.of<MyProvider>(context, listen: false).Z,
        "quiz": Provider.of<MyProvider>(context, listen: false).quiz,
        "title": stan.title,
        "Presenting_A_Job": [],
        "salary": stan.salary,
        "workTime": stan.workTime,
        "specialties": stan.specialties,
        "langNum": stan.langNum,
        "skillNum": stan.skillNum,
        "describsion": stan.describsion,
        "expir": stan.expir,
        "gender": stan.gender,
        "degree": stan.degree,
        "level": stan.level,
        "accepted": [],
        "Vacancies": stan.Vacancies,
        "date":Timestamp.now(),
        "date_publication": {
          'hour': DateTime.now().hour,
          'day': DateTime.now().day,
          'month': DateTime.now().month,
          'year': DateTime.now().year
        },
        "list": "",
        "chanceId": 0,
        "num": num
      });

      await v.where("num", isEqualTo: num).get().then((value) {
        if (value != null) {
          value.docs.forEach((element) {
            v.doc(element.id).update({"id": element.id});
            id_chance = element.id;
          });
        }
      });

      await users.get().then((value) {
        value.docs.forEach((element) {
          setState(() {
            for (int i = 0; i < follow.length; i++) {
              if (element.id == follow.elementAt(i)) {
                users_noti = FirebaseFirestore.instance
                    .collection("users")
                    .doc(follow.elementAt(i))
                    .collection("notifcation");
                users_noti.add({
                  "id": id_chance,
                  "id_company": u,
                  "title": 'فرصه ',
                  "body": "تم نشر فرصه من قبل الشركه  ${name_comp} ",
                  'date_publication': {
                    'day': DateTime.now().day,
                    'month': DateTime.now().month,
                    'year': DateTime.now().year,
                  },
                  'num': 2,
                });
                my_lis.add(element.data()['token']);
              }
            }
          });
        });
      });

      for (int i = 0; i < my_lis.length; i++)
        sendMessage("فرصه", "تم نشر فرصه من قبل الشركه  ${name_comp} ", i, u,
            id_chance, "2");

      d = {
        "id": "",
        "title": "",
       // "Qtime":
        "quiz": false,
        "salary": "أقل من 100000",
        "workTime": "دوام جزئي",
        "specialties": "الترجمة",
        "langNum": [],
        "skillNum": "",
        "quizList": [],
        "describsion": "",
        "quiz_result":{},
        "expir": "1",
        "quizNum": 5,
        "gender": "لا يهم",
        "degree": "لا يهم",
        "level": "مبتدأ",
        "Vacancies": 1,
        "date_publication": "",
      };
      for (int j = 0; j < data.length; j++) {
        data[j].cost = 0;
      }
      _filters=new List();
      Provider.of<MyProvider>(context, listen: false).setQtype(0);
    }
  }

  var help = 1;

  Widget getStep() {
    aa = [
      Form(
        autovalidateMode: AutovalidateMode.always,
        key: k1,
        child: Column(
          children: [
            Text("عنوان الفرصة:"),
            SizedBox(
              height: 100,
            ),
            SizedBox(
                width: 300,
                child: x("title", "العنوان:", ".......", Icon(Icons.title), k1,
                    _index)),
          ],
        ),
      ),
      Form(
        autovalidateMode: AutovalidateMode.always,
        key: k8,
        child: Column(
          children: [
            Text("الوصف"),
            SizedBox(
              height: 100,
            ),
            SizedBox(
                width: 300,
                child: x("describsion", "الوصف:", ".......",
                    Icon(Icons.wb_incandescent_outlined), k8, _index)),
          ],
        ),
      ),
      Form(
        autovalidateMode: AutovalidateMode.always,
        key: k6,
        child: Column(
          children: [
            Text("المهارات المطلوبة"),
            SizedBox(
              height: 100,
            ),
            SizedBox(
                width: 300,
                child: x("skillNum", "المهارات :", ".......",
                    Icon(Icons.account_tree), k6, _index)),
          ],
        ),
      ),
      Column(
        children: [
          Text("اللغات المطلوبة"),
          SizedBox(
            width: 300,
            child: chipList(),
          ),
        ],
      ),
      Form(
        autovalidateMode: AutovalidateMode.always,
        key: k5,
        child: SizedBox(
          width: 300,
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.local_florist),
                      SizedBox(
                        width: 10,
                      ),
                      Text("المستوى الوظيفي المطلوب:"),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  z("level", "المستوى", ["مبتدأ", "متمرس", "خبير"], _index)
                ],
              ),
              q(d["level"], k5, _index),
            ],
          ),
        ),
      ),
      SizedBox(
        width: 300,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.perm_contact_cal_outlined),
                SizedBox(
                  width: 10,
                ),
                Text("المستوى العلمي المطلوب :"),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            z(
                "degree",
                "شهادة",
                [
                  'تعليم ابتدائي',
                  'تعليم اعدادي',
                  'تعليم ثانوي',
                  'شهادة جامعية',
                  'شهادة دبلوم',
                  'شهادة ماجستير',
                  'شهادة دكتوراه',
                  'لا يهم'
                ],
                _index)
          ],
        ),
      ),
      SizedBox(
        width: 300,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.star_purple500_outlined),
                SizedBox(
                  width: 10,
                ),
                Text("التخصص المطلوب :"),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            z(
                "specialties",
                "التخصص المطلوب",
                [
                  'تكنولوجيا المعلومات',
                  'العلوم طبيعية',
                  'التعليم',
                  'الترجمة',
                  'تصيم غرافيكي وتحريك',
                  "سكرتاريا",
                  "صحافة",
                  "ادارة مشاريع",
                  "المحاسبة",
                  "الكيمياء والمخابر",
                  "الطب",
                  "الصيدلة",
                  "مجالات مختلفة"
                ],
                _index)
          ],
        ),
      ),
      SizedBox(
        width: 300,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.wc),
                SizedBox(
                  width: 10,
                ),
                Text("الجنس :"),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            z("gender", "الجنس", ["ذكر", "أنثى", "لا يهم"], _index)
          ],
        ),
      ),
      SizedBox(
        width: 300,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.alarm_on_sharp),
                SizedBox(
                  width: 10,
                ),
                Text("عدد ساعات العمل :"),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            z("workTime", "عدد ساعات العمل", ["دوام جزئي", "دوام كامل"], _index)
          ],
        ),
      ),
      SizedBox(
        width: 300,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.money),
                SizedBox(
                  width: 10,
                ),
                Text("الراتب :"),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            z(
                "salary",
                "الراتب",
                [
                  "أقل من 100000",
                  "100000 - 300000",
                  "300000 - 500000",
                  "500000 - 700000",
                  "700000 - 1000000",
                  "1000000 - 1500000",
                  "1500000 - 2000000",
                  "أكبر من 2000000"
                ],
                _index)
          ],
        ),
      ),
      SizedBox(
        width: 300,
        child: Column(
          children: [
            Text("عدد المظفين المطلوب"),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                IconButton(
                    color: Colors.amber,
                    iconSize: 50,
                    onPressed: () {
                      setState(() {
                        help >= 30
                            ? Fluttertoast.showToast(
                                msg: "العدد كبير جدا",
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                toastLength: Toast.LENGTH_SHORT)
                            : help++;
                      });
                    },
                    icon: Icon(Icons.add)),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "${help}",
                  style: TextStyle(fontSize: 50),
                ),
                SizedBox(
                  width: 30,
                ),
                IconButton(
                    color: Colors.amber,
                    iconSize: 50,
                    onPressed: () {
                      setState(() {
                        help <= 1
                            ? Fluttertoast.showToast(
                                msg: "لا يمكن ان يكون العدد اقل من 1",
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                toastLength: Toast.LENGTH_SHORT)
                            : help--;
                      });
                    },
                    icon: Icon(Icons.minimize_outlined)),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 85,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InkWell(
                    child: Text(
                      "تأكيد",
                      style: TextStyle(fontSize: 40),
                    ),
                    onTap: () {
                      d["Vacancies"] = help;
                      edit(_index - 1);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      SizedBox(
        width: 300,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: Text("هل تريد انشاء اختبار من نوع اختيار من متعدد")),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                    icon: Icon(Icons.post_add),
                    onPressed: () {
                      if (Provider.of<MyProvider>(context, listen: false)
                              .qtype ==
                          0) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => QuestionAnswer()));
                      } else if (Provider.of<MyProvider>(context, listen: false)
                              .qtype ==
                          1) {
                        return Fluttertoast.showToast(
                            msg: "لقد قمت بانشاء الاختبار بالفعل",
                            backgroundColor: Colors.black54,
                            textColor: Colors.white,
                            toastLength: Toast.LENGTH_SHORT);
                      } else {
                        return Fluttertoast.showToast(
                            msg: "لا يمكنك انشاء نوعين من الاختبارات",
                            backgroundColor: Colors.black54,
                            textColor: Colors.white,
                            toastLength: Toast.LENGTH_SHORT);
                      }
                    }),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Flexible(child: Text("أم تريد انشاء اختبار من نوع صح  أو غلط")),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                    icon: Icon(Icons.file_download_done),
                    onPressed: () {
                      if (Provider.of<MyProvider>(context, listen: false)
                              .qtype ==
                          0) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TrueFalse()));
                      } else if (Provider.of<MyProvider>(context, listen: false)
                              .qtype ==
                          2) {
                        return Fluttertoast.showToast(
                            msg: "لقد قمت بانشاء الاختبار بالفعل",
                            backgroundColor: Colors.black54,
                            textColor: Colors.white,
                            toastLength: Toast.LENGTH_SHORT);
                      } else {
                        return Fluttertoast.showToast(
                            msg: "لا يمكنك انشاء نوعين من الاختبارات",
                            backgroundColor: Colors.black54,
                            textColor: Colors.white,
                            toastLength: Toast.LENGTH_SHORT);
                      }
                    }),
              ],
            ),
            InkWell(
              child: Text("انشر الفرصة"),
              onTap: () {
                return Fluttertoast.showToast(
                    msg: "انقر نقراً مزدوجاً للتأكيد",
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    toastLength: Toast.LENGTH_SHORT);
              },
              onDoubleTap: uplod,
            )
          ],
        ),
      ),
    ];
    return aa[_index];
  }

  Widget build(BuildContext context) {
    final _colorPalettes =
        charts.MaterialPalette.getOrderedPalettes(this.data.length);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(120.0),
              child: AppBar(
                title: Center(
                  child: Text(" "),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(60.0),
                  ),
                ),
              ),
            ),
            body: Stack(children: [
              Opacity(
                opacity: 0.4,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: new AssetImage("images/55.jpeg"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Color(0xFF5C6BC0), BlendMode.overlay))),
                ),
              ),
              ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.8),
                          topLeft: Radius.circular(15.8)),
                    ),
                    child: des(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.8),
                          bottomRight: Radius.circular(15.8)),
                      //color: Colors.black12
                    ),
                    height: 300,
                    child: charts.PieChart(
                      [
                        charts.Series<_CostsData, String>(
                          id: 'Sales-1',
                          colorFn: (_, idx) => _colorPalettes[idx].shadeDefault,
                          domainFn: (_CostsData sales, _) => sales.category,
                          measureFn: (_CostsData sales, _) => sales.cost,
                          data: this.data,
                          // Set a label accessor to control the text of the arc label.
                          labelAccessorFn: (_CostsData row, _) =>
                              '${row.category}: ${row.cost}',
                        ),
                      ],
                      animate: this._animate,
                      defaultRenderer: new charts.ArcRendererConfig(
                        arcRatio: this._arcRatio,
                        arcRendererDecorators: [
                          charts.ArcLabelDecorator(
                              labelPosition: this._arcLabelPosition)
                        ],
                      ),
                      behaviors: [
                        charts.DatumLegend(
                          position: this._legendPosition,
                          desiredMaxRows: 6,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ]),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerTop,
            floatingActionButton: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      FloatingActionButton(
                        heroTag: "tag11",
                        child: Icon(
                          Icons.track_changes,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                        backgroundColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => ChanceT()));
                        },
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      FloatingActionButton(
                        heroTag: "tag22",
                        child: Icon(
                          Icons.verified_outlined,
                          color:  Theme.of(context).primaryColor,
                          size: 30,
                        ),
                        backgroundColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => ChanceV()));
                        },
                      ),
                      SizedBox(
                        width: 40,
                      ),
                    ]))));
  }

  edit(int i) {
    setState(() {
      data[i].cost = 100;
    });
  }

  chipList() {
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: <Widget>[
        chip_desgin('العربية', "A"),
        chip_desgin('الانكليزية', "E"),
        chip_desgin('الفرنسية', "F"),
        chip_desgin('الروسية', "R"),
        chip_desgin('الصينية', "CH"),
        chip_desgin('الألمانية', "AL"),
        chip_desgin('يابانية', "JA"),
      ],
    );
  }

  chip_desgin(lan1, lan) {
    return FilterChip(
      backgroundColor: Colors.purple,
      avatar: CircleAvatar(
        backgroundColor: Colors.cyan,
        child: Text(
          lan.toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      label: Text(
        lan1,
      ),
      selected: _filters.contains(lan1),
      selectedColor: Colors.purpleAccent,
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            _filters.add(lan1);
          } else {
            _filters.remove(lan1);
            // _filters.removeWhere((String name) {
            //   return name == lan1;
            // });
          }
        });
      },
    );
  }
}

class _CostsData {
  final String category;
  int cost;

  _CostsData(this.category, this.cost);
}
