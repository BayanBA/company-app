import 'package:b/chanceScreen/viewPost.dart';
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
  var save;
  var title;
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
            'id_post': c,
          },
          'to': await my_lis[i],
        }));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(
          padding: EdgeInsets.all(10),
          child:
            Form(
              key: ff1,
              child: Container(
                child: TextFormField(
                  initialValue: title,
                  onSaved: (val) {
                    title = val;
                  },
                  onChanged: (val) {
                    title = val;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.teal[50],
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(style: BorderStyle.solid),
                    ),
                    hintText: 'العنوان',
                  ),
                ),
              ),
            ),
          ),
      Padding(
          padding: EdgeInsets.all(10),
          child:
          Form(
            key: ff,
            child: Container(
              child: TextFormField(
                initialValue: save,
                onSaved: (val) {
                  save = val;
                },
                onChanged: (val) {
                  save = val;
                },
                decoration: InputDecoration(
                  fillColor: Colors.teal[50],
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.solid),
                  ),
                  hintText: 'المنشور',
                ),
                maxLines: 30,
              ),
            ),
          )
      ),
      FloatingActionButton(
        onPressed: () {
          addpost(context);
        },
        child: const Icon(Icons.navigation),
        backgroundColor: Colors.deepPurpleAccent,
      )
    ]);
  }

  saving() async{
    // var fo = ff.currentState;
    // var fo1 = ff1.currentState;
    // fo.save();
    // fo1.save();
    var user = FirebaseAuth.instance.currentUser;
    var v = FirebaseFirestore.instance
        .collection("companies")
        .doc(Provider.of<MyProvider>(context, listen: false).company_id)
        .collection("Post");
    v.add({
      "myPost": save,
      "id": "",
      "title": title,
      "dateOfPublication": Jiffy(DateTime.now()).fromNow()
    });


    await v.get().then((value) {
      if (value != null) {
        value.docs.forEach((element) {
          v.doc(element.id).update({"id": element.id});
          if (element.data()["title"] == title) id_post = element.id;

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
                "id_post":id_post,
                "id_company":u,
              });
            }
          }
        });
      });
    });

    for (int i = 0; i < my_lis.length; i++)
      sendMessage("بوست", "تم نشر بوست", i, u, id_post);

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
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => ShowingPost()));
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
