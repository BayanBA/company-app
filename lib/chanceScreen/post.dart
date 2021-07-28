import 'package:b/chanceScreen/viewPost.dart';
import 'package:b/main.dart';
import 'package:b/screen/My_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

import '../stand.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  var save;
  var title;
  GlobalKey<FormState> ff = new GlobalKey<FormState>();
  GlobalKey<FormState> ff1 = new GlobalKey<FormState>();

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
                onSaved: (val) {
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

  saving() {
    var fo = ff.currentState;
    var fo1 = ff1.currentState;
    fo.save();
    fo1.save();
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
