import 'package:b/screen/view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_stepper/stepper.dart';
import 'package:b/stand.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AddJop extends StatefulWidget {
  @override
  _AddJopState createState() => _AddJopState();
}

class _AddJopState extends State<AddJop> {
  GlobalKey<FormState> k1 = new GlobalKey<FormState>();
  GlobalKey<FormState> k2 = new GlobalKey<FormState>();
  GlobalKey<FormState> k3 = new GlobalKey<FormState>();
  GlobalKey<FormState> k4 = new GlobalKey<FormState>();
  GlobalKey<FormState> k5 = new GlobalKey<FormState>();
  GlobalKey<FormState> k6 = new GlobalKey<FormState>();
  GlobalKey<FormState> k7 = new GlobalKey<FormState>();

  Map<String, dynamic> d = {
    "id": "",
    "title": "",
    "quiz": false,
    "age": "",
    "salary": "",
    "workTime": "",
    "langNum": "",
    "skillNum": "",
    "quizList": [],
    "expir": "",
    "quizNum": 5,
    "gender": "لا يهم",
    "degree": "لا يهم",
    "level": "مبتدأ",
    "Vacancies": 1,
    "dateOfPublication": "",
  };

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
              border:Border.all(color:Colors.deepPurpleAccent,width: 2,) ,
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
                Icon(
                  Icons.account_tree,
                ),
                Icon(
                  Icons.language,
                ),
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
      return x("expir", "عدد سنوات الخبرة:", ".......",
          Icon(Icons.auto_awesome), k, i);
    return Text("");
  }

  void uplod() {
    var v = FirebaseFirestore.instance
        .collection("companies")
        .doc(Provider.of<MyProvider>(context, listen: false).company_id)
        .collection("chance");

    stan.title = d["title"];
    stan.age = d["age"];
    stan.skillNum = d["skillNum"];
    stan.salary = d["salary"];
    stan.workTime = d["workTime"];
    stan.langNum = d["langNum"];
    stan.level = d["level"];
    stan.level == "خبير" ? stan.expir = d["expir"] : stan.expir = "";
    stan.gender = d["gender"];
    stan.degree = d["degree"];

    stan.Vacancies = d["Vacancies"];
    DateTime date = DateTime.now();
    stan.dateOfPublication = Jiffy(date).fromNow();
    v.add({
      "id": "",
      "title": stan.title,
      "age": stan.age,
      "salary": stan.salary,
      "workTime": stan.workTime,
      "langNum": stan.langNum,
      "skillNum": stan.skillNum,
      "expir": stan.expir,
      "gender": stan.gender,
      "degree": stan.degree,
      "level": stan.level,
      "Vacancies": stan.Vacancies,
      "dateOfPublication": Jiffy(date).fromNow(),
      "list": ""
    });
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ShowingData()));
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
        key: k2,
        child: SizedBox(
            width: 300,
            child:
                x("age", "العمر:", ".......", Icon(Icons.person), k2, _index)),
      ),
      Form(
        autovalidateMode: AutovalidateMode.always,
        key: k3,
        child: SizedBox(
            width: 300,
            child: x("workTime", "عدد ساعات العمل:", ".......",
                Icon(Icons.alarm_on_sharp), k3, _index)),
      ),
      Form(
        autovalidateMode: AutovalidateMode.always,
        key: k4,
        child: SizedBox(
            width: 300,
            child: x(
                "salary", "الراتب:", ".......", Icon(Icons.money), k4, _index)),
      ),
      Form(
        autovalidateMode: AutovalidateMode.always,
        key: k6,
        child: SizedBox(
            width: 300,
            child: x("skillNum", "المهارات:", ".......",
                Icon(Icons.account_tree), k6, _index)),
      ),
      Form(
        autovalidateMode: AutovalidateMode.always,
        key: k7,
        child: SizedBox(
            width: 300,
            child: x("langNum", "اللغات:", ".......", Icon(Icons.language), k7,
                _index)),
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
              q(d["level"], k5, _index),
            ],
          ),
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

  bool _animate = true;
  bool _defaultInteractions = true;
  double _arcRatio = 0.5;
  charts.ArcLabelPosition _arcLabelPosition = charts.ArcLabelPosition.auto;
  charts.BehaviorPosition _titlePosition = charts.BehaviorPosition.bottom;
  charts.BehaviorPosition _legendPosition = charts.BehaviorPosition.start;

  // Data to render.
  List<_CostsData> data = [
    _CostsData('العنوان', 0),
    _CostsData('العمر', 0),
    _CostsData('الساعات', 0),
    _CostsData('الراتب', 0),
    _CostsData('المهارات', 0),
    _CostsData('اللغات', 0),
    _CostsData('المستوى', 0),
  ];

  @override
  Widget build(BuildContext context) {
    final _colorPalettes =
        charts.MaterialPalette.getOrderedPalettes(this.data.length);
    return Scaffold(
        appBar: AppBar(
          title: Text("معلومات فرصة العمل"),
        ),
        body: Stack(
          children: [
            Opacity(
              opacity: 0.4,
              child: Container(
                decoration: BoxDecoration(

                    image: DecorationImage(
                  image: new AssetImage("images/55.jpeg"),
                  fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Color(0xFF5C6BC0), BlendMode.overlay)
                )),
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
            ),
          ],
        ));
  }

  edit(int i) {
    setState(() {
      data[i].cost = 100;
    });
  }
}

class _CostsData {
  final String category;
  int cost;

  _CostsData(this.category, this.cost);
}
