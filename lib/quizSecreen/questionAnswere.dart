import 'package:b/chanceScreen/chance.dart';
import 'package:b/stand.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class QuestionAnswer extends StatefulWidget {
  @override
  _QuestionAnswerState createState() => _QuestionAnswerState();
}

List<String> data = [""];
List<String> answer = [""];
List<String> answer1 = ["", "", ""];
List<GlobalKey<FormState>> keymap = [new GlobalKey<FormState>()];
List<GlobalKey<FormState>> keymap1 = [
  new GlobalKey<FormState>(),
  new GlobalKey<FormState>(),
  new GlobalKey<FormState>()
];

class _QuestionAnswerState extends State<QuestionAnswer> {
  @override
  Widget build(BuildContext context) {
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
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Form(
                              key: keymap.elementAt(index),
                              child: _buildItem(index)),
                          Form(
                              key: keymap1.elementAt((index * 3)),
                              child: _buildItem1(index, "الجواب الصحيح",
                                  Icon(Icons.done), 1, (index * 3))),
                          Form(
                              key: keymap1.elementAt((index * 3) + 1),
                              child: _buildItem1(index, "أجوبة اضافية",
                                  Icon(Icons.clear), 2, ((index * 3) + 1))),
                          Form(
                              key: keymap1.elementAt((index * 3) + 2),
                              child: _buildItem1(index, "أجوبة اضافية",
                                  Icon(Icons.clear), 2, ((index * 3) + 2))),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0,bottom: 8,right: 100),
                  child: Row(
                    children: [
                      FloatingActionButton(
                        heroTag: "btn22",
                        child: Icon(Icons.add),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            data.add("");
                            answer.add("");
                            answer1.add("");
                            answer1.add("");
                            answer1.add("");
                            keymap.add(new GlobalKey<FormState>());
                            keymap1.add(new GlobalKey<FormState>());
                            keymap1.add(new GlobalKey<FormState>());
                            keymap1.add(new GlobalKey<FormState>());
                          });
                        },
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      FloatingActionButton(
                        heroTag: "btn11",
                        child: Text("حفظ"),
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          var e = 0;
                          var f = 0;
                          for (int i = 0; i < keymap.length; i++) {
                            var kk = keymap.elementAt(i).currentState;
                            if (!kk.validate()) {
                              e = 1;
                              Fluttertoast.showToast(
                                  msg: "تحقق من القيم المدخلة",
                                  backgroundColor: Colors.black54,
                                  textColor: Colors.white,
                                  toastLength: Toast.LENGTH_SHORT);
                              break;
                            }
                          }
                          for (int i = 0; i < keymap1.length; i++) {
                            var kk = keymap1.elementAt(i).currentState;
                            if (!kk.validate()) {
                              f = 1;
                              Fluttertoast.showToast(
                                  msg: "تحقق من القيم المدخلة",
                                  backgroundColor: Colors.black54,
                                  textColor: Colors.white,
                                  toastLength: Toast.LENGTH_SHORT);
                              break;
                            }
                          }
                          if (e != 1 && f != 1) {
                            Fluttertoast.showToast(
                                msg: "تم انشاء الاختبار",
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                toastLength: Toast.LENGTH_SHORT);
                            setState(() {
                              Provider.of<MyProvider>(context, listen: false)
                                  .setQtype(1);
                              Provider.of<MyProvider>(context, listen: false)
                                  .setListQA(data, answer, answer1);
                              Navigator.of(context).pop(MaterialPageRoute(
                                  builder: (context) => AddJop()));
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }

  Widget _buildItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: TextFormField(
        initialValue: data.elementAt(index),
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
          labelText: "أدخل السؤال",
          labelStyle: TextStyle(fontSize: 20),
          prefixIcon: Icon(Icons.question_answer_outlined),
          suffixIcon: IconButton(
            icon: Icon(Icons.delete_outlined),
            onPressed: () {
              setState(() {
                data.removeAt(index);
                answer.removeAt(index);
                answer1.removeAt((index * 3));
                answer1.removeAt((index * 3));
                answer1.removeAt((index * 3));
                keymap.removeAt(index);
                keymap1.removeAt((index * 3));
                keymap1.removeAt((index * 3));
                keymap1.removeAt((index * 3));
              });
            },
          ),
          hintText: "السؤال",
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
            data[index] = v;
          });
        },
        onSaved: (valu) {
          data[index] = valu;
        },
      ),
    );
  }

  Widget _buildItem1(int index, String lab, Icon ico, int i, int aa) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
      child: TextFormField(
        initialValue: answer1.elementAt(aa),
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
                color: Colors.orangeAccent,
                width: 2,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.pink,
                width: 2,
              )),
          contentPadding: EdgeInsets.all(15),
          labelText: lab,
          labelStyle: TextStyle(fontSize: 20),
          prefixIcon: ico,
          hintText: "الجواب",
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
            if (i == 1) answer[index] = v;
            answer1[aa] = v;
          });
        },
        onSaved: (valu) {
          if (i == 1) answer[index] = valu;
          answer1[aa] = valu;
        },
      ),
    );
  }
}
