import 'package:b/chanceScreen/chanceT.dart';
import 'package:b/chanceScreen/chanceV.dart';
import 'package:b/chanceScreen/questionAnswere.dart';
import 'package:b/chanceScreen/truefalse.dart';
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
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';
import 'package:http/http.dart' as http;

class UpdatDataT extends StatefulWidget {
  @override
  _UpdatDataState createState() => _UpdatDataState();
}

class _UpdatDataState extends State<UpdatDataT> {
  GlobalKey<FormState> k1 = new GlobalKey<FormState>();
  GlobalKey<FormState> k2 = new GlobalKey<FormState>();
  GlobalKey<FormState> k3 = new GlobalKey<FormState>();
  GlobalKey<FormState> k4 = new GlobalKey<FormState>();
  GlobalKey<FormState> k5 = new GlobalKey<FormState>();
  GlobalKey<FormState> k6 = new GlobalKey<FormState>();
  GlobalKey<FormState> k7 = new GlobalKey<FormState>();
  GlobalKey<FormState> k8 = new GlobalKey<FormState>();

  Map<String, dynamic> d;

  var data11;
  var _filters;

  editData() async {
    data11 = Provider.of<MyProvider>(context, listen: false).data;
    d = data11;
  }

  String u;
  var token;
  var userr;
  var follow = new List();
  var my_lis = new List();
  CollectionReference comp;
  String name_comp;

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

    await t.doc(u).update({'token': token}).then((value) {});
    // print(my_lis.length);
  }

  sendMessage(String title, String body, int i, String u, String c, String num) async {
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

  @override
  void initState() {
    editData();
    getdata1();
    super.initState();
  }

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
                  Icons.alarm_on_sharp,
                ),
                Icon(
                  Icons.account_tree,
                ),
                Icon(
                  Icons.language,
                ),
                Icon(
                  Icons.star_purple500_outlined,
                ),
                Icon(
                  Icons.wc,
                ),
                Icon(
                  Icons.edit,
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
        } else if (valu.length < 5) {
          return "الكلمة قصيرة جدا";
        } else
          return null;
      },
      keyboardType: TextInputType.text,
      onChanged: (v) {
        setState(() {
          d[bbb] = v;
        });
      },
      onSaved: (valu) {
        d[bbb] = valu;
      },
      onEditingComplete: () {
        _index++;
        drow(k, i);
      },
    );
  }

  drow(var k, int i) {
    var kk = k.currentState;
    if (kk.validate()) edit(i);
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

  Widget q(String name, var k, int i) {
    if (name == "خبير")
      return SizedBox(
        width: 300,
        child: Row(
          children: [
            Icon(Icons.auto_awesome),
            SizedBox(
              width: 10,
            ),
            Text("ععدد سنوات الخبرة:"),
            SizedBox(
              width: 10,
            ),
            z("expir", "عدد سنوات الخبرة",
                ['1', '2', '3', '4', '5', '6', '7', '8', 'اكثر من ذلك'])
          ],
        ),
      );
    return Text("");
  }

  void uplod() async {
    var users_noti;
    CollectionReference users = FirebaseFirestore.instance.collection("users");

    var v = FirebaseFirestore.instance
        .collection("companies")
        .doc(Provider.of<MyProvider>(context, listen: false).company_id)
        .collection("chance");

    stan.title = d["title"];
    stan.skillNum = d["skillNum"];
    stan.workTime = d["workTime"];
    stan.langNum = _filters;
    stan.specialties = d["specialties"];
    stan.gender = d["gender"];
    stan.degree = d["degree"];
    stan.describsion = d["describsion"];
    stan.Vacancies = d["Vacancies"];

    v.doc(d["id"]).update({
      "title": stan.title,
      "specialties": stan.specialties,
      "skillNum": stan.skillNum,
      "Presenting_A_Job": [],
      "workTime": stan.workTime,
      "langNum": stan.langNum,
      "describsion": stan.describsion,
      "gender": stan.gender,
      "degree": stan.degree,
      "Vacancies": stan.Vacancies,
      "date_publication": {
        'day': DateTime.now().day,
        'month': DateTime.now().month,
        'year': DateTime.now().year,
      },
    });
    Provider.of<MyProvider>(context, listen: false).data = d;
    Navigator.of(context).pop();
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
                "id": d['id'],
                "id_company": u,
                "title": 'فرصه',
                "body": "تم تعديل فرصه من قبل الشركه  ${name_comp} ",
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
      sendMessage("فرصه", "تم تعديل فرصه من قبل الشركه  ${name_comp} ", i, u,
          d['id'], "2");
  }

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
      SizedBox(
        width: 300,
        child: Row(
          children: [
            Icon(Icons.alarm_on_sharp),
            SizedBox(
              width: 10,
            ),
            Text("عدد ساعات التدريب :"),
            SizedBox(
              width: 10,
            ),
            z("workTime", "عدد ساعات التدريب",
                ["أقل من ساعتين", "أكثر من ساعتين"])
          ],
        ),
      ),
      Form(
        autovalidateMode: AutovalidateMode.always,
        key: k6,
        child: SizedBox(
            width: 300,
            child: x("skillNum", "المهارات:", ".......",
                Icon(Icons.account_tree), k6, _index)),
      ),
      SizedBox(
        width: 300,
        child: chipList(),
      ),
      SizedBox(
        width: 300,
        child: Row(
          children: [
            Icon(Icons.star_purple500_outlined),
            SizedBox(
              width: 10,
            ),
            Text("التخصص المستهدف :"),
            SizedBox(
              width: 10,
            ),
            z("specialties", "التخصص المستهدف", [
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
            ])
          ],
        ),
      ),
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
            Text("المستوى العلمي :"),
            SizedBox(
              width: 10,
            ),
            z("degree", "شهادة", [
              'تعليم ابتدائي',
              'تعليم اعدادي',
              'تعليم ثانوي',
              'شهادة جامعية',
              'شهادة دبلوم',
              'شهادة ماجستير',
              'شهادة دكتوراه',
              'لا يهم'
            ])
          ],
        ),
      ),
      SizedBox(
        width: 300,
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            IconButton(
                color: Colors.amber,
                iconSize: 50,
                onPressed: () {
                  setState(() {
                    d["Vacancies"] >= 30
                        ? Fluttertoast.showToast(
                        msg: "العدد كبير جدا",
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_LONG)
                        : d["Vacancies"]++;
                  });
                },
                icon: Icon(Icons.add)),
            SizedBox(
              width: 30,
            ),
            Text(
              "${d["Vacancies"]}",
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
                    d["Vacancies"] <= 1
                        ? Fluttertoast.showToast(
                        msg: "لا يمكن ان يكون العدد اقل من 1",
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_LONG)
                        : d["Vacancies"]--;
                  });
                },
                icon: Icon(Icons.minimize_outlined)),
          ],
        ),
      ),
      SizedBox(
        width: 300,
        child: Column(
          children: [
            IconButton(icon: Icon(Icons.add), onPressed: uplod),
          ],
        ),
      ),
    ];
    return aa[_index];
  }

  bool _animate = false;
  bool _defaultInteractions = true;
  double _arcRatio = 0.5;
  charts.ArcLabelPosition _arcLabelPosition = charts.ArcLabelPosition.auto;
  charts.BehaviorPosition _titlePosition = charts.BehaviorPosition.bottom;
  charts.BehaviorPosition _legendPosition = charts.BehaviorPosition.start;

  // Data to render.
  List<_CostsData> data = [
    _CostsData('العنوان', 10),
    _CostsData('الوصف', 10),
    _CostsData('الساعات', 10),
    _CostsData('الراتب', 10),
    _CostsData('المهارات', 10),
    _CostsData('اللغات', 10),
    _CostsData('المستوى', 10),
  ];

  @override
  Widget build(BuildContext context) {
    _filters = d["langNum"];
    final _colorPalettes =
    charts.MaterialPalette.getOrderedPalettes(this.data.length);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100.0),
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
                        // Add title.
                        // charts.ChartTitle(
                        //   'Dummy costs breakup',
                        //   behaviorPosition: this._titlePosition,
                        // ),
                        // Add legend. ("Datum" means the "X-axis" of each data point.)
                        charts.DatumLegend(
                          position: this._legendPosition,
                          desiredMaxRows: 4,
                        ),
                      ],
                    ),
                  ),

                  //..._controlWidgets(),
                ],
              )
            ])));
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
        chip_desgin('غير ذلك', "h"),
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
            _filters.removeWhere((String name) {
              return name == lan1;
            });
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
