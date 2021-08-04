import 'package:b/chanceScreen/viewPost.dart';
import 'package:b/main.dart';
import 'package:b/screen/My_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

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

  editData() async {
    data = Provider.of<MyProvider>(context, listen: false).data;
    d = data;
  }

  @override
  void initState() {
    editData();
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
                      child: TextFormField(
                        initialValue: data["title"],
                        onSaved: (val) {
                          data["title"] = val;
                        },
                        onChanged: (val) {
                          data["title"] = val;
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
                    child: Form(
                      key: ff,
                      child: Container(
                        child: TextFormField(
                          initialValue: data["myPost"],
                          onSaved: (val) {
                            data["myPost"] = val;
                          },
                          onChanged: (val) {
                            data["myPost"] = val;
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
                    )),
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

  saving() {
    var user = FirebaseAuth.instance.currentUser;
    var v = FirebaseFirestore.instance
        .collection("companies")
        .doc(Provider.of<MyProvider>(context, listen: false).company_id)
        .collection("Post");

    v.doc(data["id"]).update({
      "myPost": data["myPost"],
      "title": data["title"],
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
                        Provider.of<MyProvider>(context, listen: false)
                            .data = data;
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
