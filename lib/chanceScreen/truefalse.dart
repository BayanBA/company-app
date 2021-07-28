import 'package:b/chanceScreen/chance.dart';
import 'package:b/stand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrueFalse extends StatefulWidget {
  @override
  _TrueFalseState createState() => _TrueFalseState();
}

List<String> data = [""];
List<String> answer = ["1"];
List<GlobalKey<FormState>> keymap = [new GlobalKey<FormState>()];
List<GlobalKey<FormState>> keymap1 = [
  new GlobalKey<FormState>(),
  new GlobalKey<FormState>()
];

class _TrueFalseState extends State<TrueFalse> {
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
                          Padding(
                            padding:
                                EdgeInsets.only(left: 90, right: 90, top: 30),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                  child: Text("صح"),
                                ),
                                Radio(
                                    key: keymap1.elementAt((index * 2)),
                                    value: "1",
                                    groupValue: answer.elementAt(index),
                                    onChanged: (val) {
                                      setState(() {
                                        answer[index] = val;
                                      });
                                    }),
                                SizedBox(
                                  width: 50,
                                ),
                                SizedBox(
                                  width: 30,
                                  child: Text("خطأ"),
                                ),
                                Radio(
                                    key: keymap1.elementAt((index * 2) + 1),
                                    value: "2",
                                    groupValue: answer.elementAt(index),
                                    onChanged: (val) {
                                      setState(() {
                                        answer[index] = val;
                                      });
                                    }),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                FloatingActionButton(
                  heroTag: "btn2",
                  child: Icon(Icons.add),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      data.add("");
                      answer.add("1");
                      keymap.add(new GlobalKey<FormState>());
                      keymap1.add(new GlobalKey<FormState>());
                      keymap1.add(new GlobalKey<FormState>());
                    });
                  },
                ),
                FloatingActionButton(
                  heroTag: "btn1",
                  child: Icon(Icons.save),
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      Provider.of<MyProvider>(context, listen: false)
                          .setListTF(data, answer);
                      Navigator.of(context).pop(
                          MaterialPageRoute(builder: (context) => AddJop()));
                    });
                  },
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
                keymap.removeAt(index);
                keymap1.removeAt((index * 2));
                keymap1.removeAt((index * 2));
              });
            },
          ),
          hintText: "السؤال",
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
            data[index] = v;
          });
        },
        onSaved: (valu) {
          data[index] = valu;
        },
      ),
    );
  }
}
