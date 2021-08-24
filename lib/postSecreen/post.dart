import 'package:b/postSecreen/viewPost.dart';
import 'package:b/main.dart';
import 'package:b/screen/My_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../stand.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  var title;
  var sav;
  var users_noti;
  GlobalKey<FormState> ff = new GlobalKey<FormState>();
  GlobalKey<FormState> ff1 = new GlobalKey<FormState>();

  @override
  void initState() {
    getdata1();

    super.initState();
  }

  String u;
  String id_post;
  var token;
  String name_comp;
  var userr;
  var follow = new List();
  var my_lis = new List();
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  getdata1() async {
    CollectionReference t = FirebaseFirestore.instance.collection("companies");
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
  }

  sendMessage(String title, String body, int i, String u, String c) async {
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
            'num': "1",
          },
          'to': await my_lis.elementAt(i),
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(90.0),
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
                              Color(0xFF212121), BlendMode.overlay))),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Form(
                      key: ff1,
                      child: Container(
                        margin: EdgeInsets.only(left: 22, right: 22),
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                topRight: Radius.circular(50.0),
                                bottomLeft: Radius.circular(50.0),
                                bottomRight: Radius.circular(50.0))),
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 20, right: 20, top: 8, bottom: 8),
                          padding:
                              EdgeInsets.only(left: 20, bottom: 10, right: 20),
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50.0),
                                  topRight: Radius.circular(50.0),
                                  bottomLeft: Radius.circular(50.0),
                                  bottomRight: Radius.circular(50.0))),
                          child: TextFormField(
                            initialValue: title,
                            onSaved: (val) {
                              title = val;
                            },
                            onChanged: (val) {
                              title = val;
                            },
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                            },
                            decoration: InputDecoration(
                              hintText: 'العنوان',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Form(
                            key: ff,
                            child: Container(
                              margin: EdgeInsets.only(left: 22, right: 22),
                              height: 500,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50.0),
                                      topRight: Radius.circular(50.0),
                                      bottomLeft: Radius.circular(50.0),
                                      bottomRight: Radius.circular(50.0))),
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 5),
                                padding: EdgeInsets.only(
                                    left: 20, bottom: 10, right: 30, top: 20),
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50.0),
                                        topRight: Radius.circular(50.0),
                                        bottomLeft: Radius.circular(50.0),
                                        bottomRight: Radius.circular(50.0))),
                                child: TextFormField(
                                  initialValue: sav,
                                  onSaved: (val) {
                                    sav = val;
                                  },
                                  onChanged: (val) {
                                    sav = val;
                                  },
                                  onEditingComplete: () {
                                    FocusScope.of(context).unfocus();
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'المنشور',
                                  ),
                                  maxLines: 30,
                                ),
                              ),
                            ))),
                  ),
                  Container(
                    width: 150,
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).accentColor
                          ]),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Container(
                      width: 10,
                      //constraints:
                      //BoxConstraints(maxWidth: 100.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          addpost(context);
                        },
                        child: Text(
                          "نشر",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.0,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ])));
  }

  var num;

  saving() async {
    my_lis = new List();
    var v = await FirebaseFirestore.instance
        .collection("companies")
        .doc(Provider.of<MyProvider>(context, listen: false).company_id)
        .collection("Post");

    var n = await FirebaseFirestore.instance
        .collection("number")
        .doc("aLOUXiw8hVsNqdzEsjF5")
        .get()
        .then((value) {
      num = value.data()["num"];
    });
    num = num + 1;

    await FirebaseFirestore.instance
        .collection("number")
        .doc("aLOUXiw8hVsNqdzEsjF5")
        .update({"num": num});

    v.add({
      "myPost": sav,
      "id": "",
      "title": title,
      "num": num,
      "date": Timestamp.now(),
      'date_publication': {
        'day': DateTime.now().day,
        'month': DateTime.now().month,
        'year': DateTime.now().year,
        'hour': DateTime.now().hour,
      }
    });

    await v.where("num", isEqualTo: num).get().then((value) {
      if (value != null) {
        value.docs.forEach((element) {
          v.doc(element.id).update({"id": element.id});
          id_post = element.id;
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
                "id": id_post,
                "id_company": u,
                "title": 'بوست',
                "body": "تم نشر بوست من قبل الشركه  ${name_comp} ",
                'date_publication': {
                  'day': DateTime.now().day,
                  'month': DateTime.now().month,
                  'year': DateTime.now().year,
                  'hour': DateTime.now().hour,
                },
                'num': 1,
              });
              my_lis.add(element.data()['token']);
            }
          }
        });
      });
    });
    for (int i = 0; i < my_lis.length; i++)
      sendMessage(
          "بوست", "تم نشر بوست من قبل الشركه  ${name_comp}", i, u, id_post);
  }

  addpost(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Column(
                    children: [
                      Text(
                        "هل تريد نشر المنشور ",
                        style: TextStyle(
                            color: Colors.black, fontStyle: FontStyle.italic),
                      ),
                    ],
                  )),
              content: Container(
                height: 20,
              ),
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal[50],
                      onPrimary: Colors.black,
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                    ),
                    onPressed: () => setState(() {
                      Navigator.of(context).pop();
                    }),
                    child: Text(
                      "لا",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal[50],
                      onPrimary: Colors.black,
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                    ),
                    onPressed: () {
                      saving();
                      setState(() {
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text(
                      '  نعم',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ]);
        });
  }
}
