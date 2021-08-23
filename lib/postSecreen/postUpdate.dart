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

class PostUpdate extends StatefulWidget {
  @override
  _PostUpdateState createState() => _PostUpdateState();
}

class _PostUpdateState extends State<PostUpdate> {
  GlobalKey<FormState> ff = new GlobalKey<FormState>();
  GlobalKey<FormState> ff1 = new GlobalKey<FormState>();

  var data;
  Map<String, dynamic> d;
  String u;
  String id_edit;
  var token;
  var userr;
  String name_comp;
  var follow = new List();
  var my_lis = new List();
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  editData() async {
    data = Provider.of<MyProvider>(context, listen: false).data;
    d = data;
  }

  getdata1() async {
    CollectionReference t = FirebaseFirestore.instance.collection("companies");
    userr = await FirebaseAuth.instance.currentUser;

    await t.where("email_advance", isEqualTo: userr.email).get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          u = element.id;
          name_comp = element.data()["company"];
          follow = element.data()['followers'];
        });
      });
    });

    await FirebaseMessaging.instance.getToken().then((value) {
      token = value;
    });

    await t.doc(u).update({'token': token}).then((value) {});
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

  @override
  void initState() {
    editData();
    getdata1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              ListView(children: [
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
                              bottomLeft:Radius.circular(50.0) ,
                              bottomRight: Radius.circular(50.0))),
                      child: Container(
                        margin:
                        EdgeInsets.only(left: 20, right: 20,top:8,bottom: 8),
                        padding:
                        EdgeInsets.only(left: 20, bottom: 10,right: 20),
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                topRight: Radius.circular(50.0),
                                bottomLeft:Radius.circular(50.0) ,
                                bottomRight:
                                Radius.circular(50.0))),
                        child: TextFormField(
                          initialValue: data["title"],
                          onSaved: (val) {
                            data["title"] = val;
                          },
                          onChanged: (val) {
                            data["title"] = val;
                          },
                          onEditingComplete: (){
                            FocusScope.of(context).unfocus();
                          },
                          decoration: InputDecoration(

                            hintText: 'العنوان',
                          ),
                        ),
                      ),
                    ),
                  ),),
                Padding(
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
                                  bottomLeft:Radius.circular(50.0) ,
                                  bottomRight: Radius.circular(50.0))),
                          child: Container(
                            margin:
                            EdgeInsets.only(left: 20, right: 20,top:10,bottom: 5),
                            padding:
                            EdgeInsets.only(left: 20, bottom: 10,right: 30,top: 20),
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0),
                                    bottomLeft:Radius.circular(50.0) ,
                                    bottomRight:
                                    Radius.circular(50.0))),
                            child: TextFormField(
                              initialValue: data["myPost"],
                              onSaved: (val) {
                                data["myPost"] = val;
                              },
                              onChanged: (val) {
                                data["myPost"] = val;
                              },
                              onEditingComplete: (){
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
                FloatingActionButton(
                  onPressed: () {
                    addpost(context);
                  },
                  child: const Icon(Icons.navigation),
                  backgroundColor: Colors.deepPurpleAccent,
                )
              ])
            ])));
  }

  saving() async {
    var user = FirebaseAuth.instance.currentUser;
    var users_noti;
    var v = FirebaseFirestore.instance
        .collection("companies")
        .doc(Provider.of<MyProvider>(context, listen: false).company_id)
        .collection("Post");

    v.doc(data["id"]).update({
      "myPost": data["myPost"],
      "title": data["title"],
      "date":Timestamp.now(),
      'date_publication': {
        'day': DateTime.now().day,
        'month': DateTime.now().month,
        'year': DateTime.now().year,
        'hour': DateTime.now().hour,
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
                "id": data['id'],
                "id_company": u,
                "title": 'تعديل بوست ',
                "body": "تم تعديل بوست من قبل الشركه  ${name_comp} ",
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
          "تعديل بوست",
          "تم تعديل بوست من قبل الشركه  ${data['company']} ",
          i,
          u,
          data['id'],
          "1");
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
                        "هل تريد تعديل المنشور ",
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
                      setState(() {
                        saving();
                        Provider.of<MyProvider>(context, listen: false).data =
                            data;
                        print(Provider.of<MyProvider>(context, listen: false)
                            .data);
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
