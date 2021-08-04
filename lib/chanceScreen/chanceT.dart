import 'package:b/chanceScreen/chance.dart';
import 'package:b/chanceScreen/chanceV.dart';
import 'package:b/chanceScreen/view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_stepper/stepper.dart';
import 'package:b/stand.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChanceT extends StatefulWidget {
  @override
  _ChanceTState createState() => _ChanceTState();
}

class _ChanceTState extends State<ChanceT> {
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
    "age": "لا يهم",
    "salary": "أقل من 100000",
    "workTime": "3 - 5",
    "langNum": "لا يهم",
    "skillNum": "",
    "quizList": [],
    "expir": "",
    "quizNum": 5,
    "describsion":"",
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
    stan.skillNum = d["skillNum"];
    stan.salary = d["salary"];
    stan.workTime = d["workTime"];
    stan.langNum = _filters;
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
      SizedBox(
        width: 300,
        child: Row(
          children: [
            Icon(Icons.person),
            SizedBox(
              width: 10,
            ),
            Text("العمر :"),
            SizedBox(
              width: 10,
            ),
            z("age", "العمر", ["أقل من 20", "20 - 25", "25 - 30", "30 - 35", "35 - 40", "40 - 45", "45 - 50", "أكبر من 50", "لا يهم"])
          ],
        ),
      ),
      // Form(
      //   autovalidateMode: AutovalidateMode.always,
      //   key: k2,
      //   child: SizedBox(
      //       width: 300,
      //       child:
      //       x("age", "العمر:", ".......", Icon(Icons.person), k2, _index)),
      // ),
      SizedBox(
        width: 300,
        child: Row(
          children: [
            Icon(Icons.alarm_on_sharp),
            SizedBox(
              width: 10,
            ),
            Text("عدد ساعات العمل :"),
            SizedBox(
              width: 10,
            ),
            z("workTime", "عدد ساعات العمل", ["3 - 5", "5 - 8", "8 -10", "10 -12","غير ذلك"])
          ],
        ),
      ),
      // Form(
      //   autovalidateMode: AutovalidateMode.always,
      //   key: k3,
      //   child: SizedBox(
      //       width: 300,
      //       child: x("workTime", "عدد ساعات العمل:", ".......",
      //           Icon(Icons.alarm_on_sharp), k3, _index)),
      // ),
      SizedBox(
        width: 300,
        child: Row(
          children: [
            Icon(Icons.money),
            SizedBox(
              width: 10,
            ),
            Text("الراتب :"),
            SizedBox(
              width: 10,
            ),
            z("salary", "الراتب", ["أقل من 100000", "100000 - 300000", "300000 - 500000", "500000 - 700000", "700000 - 1000000", "1000000 - 1500000", "1500000 - 2000000", "أكبر من ذلك"])
          ],
        ),
      ),
      // Form(
      //   autovalidateMode: AutovalidateMode.always,
      //   key: k4,
      //   child: SizedBox(
      //       width: 300,
      //       child: x(
      //           "salary", "الراتب:", ".......", Icon(Icons.money), k4, _index)),
      // ),
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
        child:chipList(),
      ),
      // Form(
      //   autovalidateMode: AutovalidateMode.always,
      //   key: k7,
      //   child: SizedBox(
      //       width: 300,
      //       child: x("langNum", "اللغات:", ".......", Icon(Icons.language), k7,
      //           _index)),
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

  bool _animate = false;
  bool _defaultInteractions = true;
  double _arcRatio = 0.5;
  charts.ArcLabelPosition _arcLabelPosition = charts.ArcLabelPosition.auto;
  charts.BehaviorPosition _titlePosition = charts.BehaviorPosition.bottom;
  charts.BehaviorPosition _legendPosition = charts.BehaviorPosition.start;

  // Data to render.
  List<_CostsData> data = [
    _CostsData('العنوان', 10),
    _CostsData('العمر', 10),
    _CostsData('الساعات', 10),
    _CostsData('الراتب', 10),
    _CostsData('المهارات', 10),
    _CostsData('اللغات', 10),
    _CostsData('المستوى', 10),
  ];

  @override
  Widget build(BuildContext context) {
    final _colorPalettes =
    charts.MaterialPalette.getOrderedPalettes(this.data.length);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
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
        body: Stack(
          children: [
            Opacity(
              opacity: 0.4,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: new AssetImage("images/55.jpeg"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Color(0xFF5C6000), BlendMode.overlay))),
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
        floatingActionButton: Row(
          children: [
            SizedBox(
              width: 30,
            ),
            FloatingActionButton(
              child: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.indigo[300],
                size: 30,
              ),
              backgroundColor: Colors.white,
              onPressed: () {Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new AddJop()));},
            ),
            SizedBox(
              width: 70,
            ),
            FloatingActionButton(
              child: Icon(
                Icons.attribution_outlined,
                color: Colors.indigo[300],
                size: 30,
              ),
              backgroundColor: Colors.white,
              onPressed: () {Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new ChanceT()));},
            ),
            SizedBox(
              width: 70,
            ),
            FloatingActionButton(
              child: Icon(
                Icons.volunteer_activism,
                color: Colors.indigo[300],
                size: 30,
              ),
              backgroundColor: Colors.white,
              onPressed: () {Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new ChanceV()));},
            ),
          ],
        ),
      ),
    );
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

  var _filters = [''];

  chip_desgin(lan1,lan){
    return FilterChip(
      backgroundColor: Colors.purple,
      avatar: CircleAvatar(
        backgroundColor: Colors.cyan,
        child: Text(lan.toUpperCase(),style: TextStyle(color: Colors.white),),
      ),
      label: Text(lan1,),
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

