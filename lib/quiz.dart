import 'package:b/quizQ.dart';
import 'package:b/stand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  QuizQ quizQ = new QuizQ();
  GlobalKey<FormState> ff = new GlobalKey<FormState>();
  Map<String,dynamic> data;
  var dataB;



  @override
  Widget build(BuildContext context) {
    data = Provider.of<MyProvider>(context, listen: true).data;
    dataB=Provider.of<MyProvider>(context, listen: false);
    print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
    print(data["id"]);

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          z([
            5,
            10,
            15,
            20,
            25,
            30,
            35,
            40,
            45,
            50,
            55,
            60,
            65,
            70,
            75,
            80,
            85,
            90,
            95,
            100
          ],"quizNum"),
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return buildColumn(i);
              },
              separatorBuilder: (context, i) {
                return Divider(
                  height: 2,
                  color: Colors.amber,
                  thickness: 3,
                );
              },
              itemCount: data["quizNum"])

          // IconButton(icon: Icon(Icons.plus_one), onPressed: buildColumn)
        ],
      )),
    );
  }

  var fo;

  Column buildColumn(int i) {
    print("${i}");
    return Column(
      children: [
        x(i,1),
        Row(
          children: [
            Icon(Icons.format_list_numbered_outlined),
            SizedBox(
              width: 10,
            ),
            Text("عدد الأجوبة :"),
            SizedBox(
              width: 10,
            ),
            z1([2, 3, 4, 5],i,4),
            Text("الجواب الصحيح"),
            //x(i,3),
            // ListView.builder(
            //      shrinkWrap: true,
            //      padding: EdgeInsets.all(8),
            //      itemCount: quizQ.num,
            //      itemBuilder: (context, i) {
            //        return x(2);
            //     }),
          ],
        ),
      ],
    );
  }

  Widget z(List<dynamic> l,var dat) {
    return DropdownButton(
      hint: Text("name"),
      items: l
          .map((e) => DropdownMenuItem(
        child: Text("$e"),
        value: e,
      ))
          .toList(),
      onChanged: (valu) {
        setState(() {
          //dat = valu;
          dataB.setDAta1(dat, valu);
        });
      },
      value: data[dat],
    );
  }

  Widget z1(List<dynamic> l,int i,int typ) {
    return DropdownButton(
      hint: Text("name"),
      items: l
          .map((e) => DropdownMenuItem(
        child: Text("$e"),
        value: e,
      ))
          .toList(),
      onChanged: (valu) {
        setState(() {
          dataB.setList(valu,i,typ);
          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
          print("${data["quizList"].elementAt(i).num}");
          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
        });
      },
      value: data["quizList"].elementAt(i).num,
    );
  }

  Widget x(int num0fq,int typ) {
    return TextFormField(
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
        labelText: "أدخل نص السؤال",
        labelStyle: TextStyle(fontSize: 20),
        prefixIcon: Icon(Icons.question_answer_outlined),
        hintText: "....",
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
      onSaved: (valu) {
          dataB.setList(valu,num0fq,typ);
      },
    );
  }

  void add() {
    var fo = ff.currentState;
    fo.save();
    var v = FirebaseFirestore.instance
        .collection("companies")
        .doc(Provider.of<MyProvider>(context, listen: false).company_id)
        .collection("chance");

    // v.doc(data["id"]).update({
    //   "quizList": list,
    // });
  }
}
