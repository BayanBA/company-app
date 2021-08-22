import 'package:b/chatSecreen/chat.dart';
import 'package:b/screen/My_profile.dart';
import 'package:b/screen/savedUser.dart';
import 'package:b/screen/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../stand.dart';

class show_detals extends StatefulWidget {
  var items;
  var items_id;

  show_detals(this.items, this.items_id);

  @override
  _show_detalsState createState() => _show_detalsState();
}

class _show_detalsState extends State<show_detals> {
  int i = 0;

  setData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(item_id.elementAt(0))
        .collection("chat")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data()["comp_id"] ==
            Provider.of<MyProvider>(context, listen: false).company_id) i = 1;
      });
      if (i == 0)
        FirebaseFirestore.instance
            .collection("users")
            .doc(item_id.elementAt(0))
            .collection("chat")
            .add({
          "comp_id": Provider.of<MyProvider>(context, listen: false).company_id,
          "help": 1
        });
      FirebaseFirestore.instance
          .collection("users")
          .doc(item_id.elementAt(0))
          .collection("chat")
          .where("comp_id",
              isEqualTo:
                  Provider.of<MyProvider>(context, listen: false).company_id)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          Provider.of<MyProvider>(context, listen: false)
              .setDocUser(element.id);
          Provider.of<MyProvider>(context, listen: false)
              .setUserId(item_id.elementAt(0));
        });
      });
    });
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

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
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.redAccent, Colors.pinkAccent])),
                    child: Container(
                      width: double.infinity,
                      height: 350.0,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage("images/bb.jpg"),
                              radius: 50.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "${widget.items.elementAt(0)['firstname']}" +
                                  " " +
                                  "${widget.items.elementAt(0)['endname']}",
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5.0),
                              clipBehavior: Clip.antiAlias,
                              color: Colors.white,
                              elevation: 5.0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 22.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "المتابعين",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "${widget.items.elementAt(0)['num_follow'].length}" +
                                                " " +
                                                "شخص",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.pinkAccent,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "الخبرة",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "${widget.items.elementAt(0)['experience_year']}" +
                                                " " +
                                                "سنوات",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.pinkAccent,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "مراسلة",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          InkWell(
                                            child: Text(
                                              "اضغط هنا",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.pinkAccent,
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          Chat()));
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              "الجنس و تاريخ الميلاد:",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 28.0),
                            ),
                            Flexible(
                              child: Text(
                                "   " +
                                    "${widget.items.elementAt(0)['gender']}" +
                                    " \n " +
                                    "${widget.items.elementAt(0)['date']['month']}" +
                                    "/" +
                                    "${widget.items.elementAt(0)['date']['day']}" +
                                    "/" +
                                    "${widget.items.elementAt(0)['date']['year']}",
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "المستوى العلمي:",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 28.0),
                            ),
                            Flexible(
                              child: Text(
                                "   " +
                                    "${widget.items.elementAt(0)['scientific_level']}",
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "اللغات:",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 28.0),
                            ),
                            Flexible(
                              child: Text(
                                "   " +
                                    "${widget.items.elementAt(0)['language']}",
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "المهارات:",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 28.0),
                            ),
                            Flexible(
                              child: Text(
                                "   " + "${widget.items.elementAt(0)['skill']}",
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "الأعمال السابقة:",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 28.0),
                            ),
                            Flexible(
                              child: Text(
                                "   " +
                                    "${widget.items.elementAt(0)['work_field']}",
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "الموطن و مكان العمل:",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 28.0),
                            ),
                            Flexible(
                              child: Text(
                                "   " +
                                    "${widget.items.elementAt(0)['originalhome']}" +
                                    " - " +
                                    "${widget.items.elementAt(0)['worksite']}",
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "الهاتف:",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 28.0),
                            ),
                            Flexible(
                              child: Text(
                                "   " + "${widget.items.elementAt(0)['phone']}",
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "الايميل:",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontStyle: FontStyle.normal,
                              fontSize: 28.0),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          "${widget.items.elementAt(0)['gmail']}",
                          style: TextStyle(
                            fontSize: 22.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: 300.00,
                  child: RaisedButton(
                      onPressed: () async {
                        var n = new List();
                        n = widget.items.elementAt(0)['num_follow'];
                        if (!n.contains(
                            Provider.of<MyProvider>(context, listen: false)
                                .company_id)) {
                          await FirebaseFirestore.instance
                              .collection("companies")
                              .doc(Provider.of<MyProvider>(context,
                                      listen: false)
                                  .company_id)
                              .collection("favorite")
                              .add({
                            'id': widget.items_id.elementAt(0),
                          });
                          n.add(Provider.of<MyProvider>(context, listen: false)
                              .company_id);
                          Fluttertoast.showToast(
                              msg: "تمت المتابعة",
                              backgroundColor: Colors.black54,
                              textColor: Colors.white,
                              toastLength: Toast.LENGTH_SHORT);
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(widget.items_id.elementAt(0))
                              .update({"num_follow": n});
                          setState(() {
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg: "تمت متابعته مسبقاً",
                              backgroundColor: Colors.black54,
                              textColor: Colors.white,
                              toastLength: Toast.LENGTH_SHORT);
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      elevation: 0.0,
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [Colors.redAccent, Colors.pinkAccent]),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "متابعة",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26.0,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
