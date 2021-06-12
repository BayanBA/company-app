
import 'package:b/jobs.dart';
import 'package:b/stand.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'My_profile.dart';

final jobReference = FirebaseFirestore.instance.collection("companies");

class JobScreenEdit extends StatefulWidget {




  State<StatefulWidget> createState() => new _JobsScreenEditState();
}

class _JobsScreenEditState extends State<JobScreenEdit> {
  jobs jobk;
  File file;
  String urlk;
  //var image = ImagePicker();
  var imagename;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();


  List<String> text;

  @override
  void initState() {
    super.initState();
    text = new List();
    date();
  }

  Widget fill_text(String name, String hint, Icon, keyboardType, String sav) {
    return TextFormField(
        initialValue: sav,
        keyboardType: keyboardType,
        onSaved: (val) {
          text.add(val);
        },
        decoration: InputDecoration(
          fillColor: Colors.brown.withOpacity(0.3),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(style: BorderStyle.solid),
          ),
          hintText: hint,
          labelText: name,
          prefixIcon: Icon,
        ),
        validator: _validateName);
  }
  share() async {
    var formdata = formstate.currentState;

    if (formdata.validate()) {
      formdata.save();


      var user = FirebaseAuth.instance.currentUser;
      print(user.email);
      print("kk");
      await jobReference
          .where("email_advance", isEqualTo: user.email)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          DocumentReference d = FirebaseFirestore.instance
              .collection("companies")
              .doc(element.id);

          d.update({
            'name_job': text.elementAt(0),
            'region':  text.elementAt(1),
            'email_advance': text.elementAt(2),
            'name_advance': text.elementAt(3),
            'description': text.elementAt(4),
            'phone':  text.elementAt(5),
          }).then(
                (value) {
              Navigator.push(
                  this.context,
                  new MaterialPageRoute(
                      builder: (context) => new ListViewjobs()));
            },
          );
        });
      });
    }
  }


  date() async {
    CollectionReference t = await FirebaseFirestore.instance.collection("companies");
    var user = await FirebaseAuth.instance.currentUser;

    await t.where("email_advance", isEqualTo: user.email).get().then((value) {
      value.docs.forEach(
            (element) {
          setState(() {
            String k2 = element.data()['name_advance'];
            String k3 = element.data()['email_advance'];
            String k4 = element.data()['name_job'];
            String k5 = element.data()['region'];
            String k6 = element.data()['description'];
            String k8 = element.data()['phone'];
            jobk = new jobs('', k5, "", k6, k3, k2, "", k4, k8);
          });
        },
      );
    });
  }

  var prov;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'jobs',
      theme: ThemeData.light()
          .copyWith(primaryColor: Colors.cyan, accentColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Container(
              child: SingleChildScrollView(
                child: Form(
                  key: formstate,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 30, left: 15, bottom: 10, right: 15),
                    // padding: EdgeInsets.all(40),
                    child: Column(
                      //heightFactor: 1000,

                      children: [
                        fill_text(
                            'name_job',
                            '...',
                            Icon(
                              Icons.dashboard,
                            ),
                            TextInputType.name,
                            jobk.name_job),
                        SizedBox(height: 24.0),
                        fill_text('region', '...', Icon(Icons.add_location),
                            TextInputType.name, jobk.name_advance),
                        SizedBox(height: 24.0),
                        fill_text('email_advance', '...', Icon(Icons.email),
                            TextInputType.emailAddress, jobk.email_advance),
                        SizedBox(height: 24.0),
                        fill_text('name_advance', '...', Icon(Icons.nature),
                            TextInputType.name, jobk.name_advance),
                        SizedBox(height: 24.0),
                        fill_text(
                            'description',
                            '...',
                            Icon(Icons.ac_unit_sharp),
                            TextInputType.name,
                            jobk.description),
                        SizedBox(height: 24.0),
                        fill_text('phone', '...', Icon(Icons.phone),
                            TextInputType.phone, jobk.phone),
                        SizedBox(height: 24.0),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 150.0, top: 40.0, right: 150),
                          child: RaisedButton(
                            child: Text('تعديل'),
                            onPressed: () async => share(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _validateName(String value) {
    if (value.isEmpty) return 'هذا الحقل مطلوب';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');

    return null;
  }
}
