import 'dart:io';
import 'dart:math';
import 'package:b/enter/wait.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:b/enter/login.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../screen/job_screen.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => new _SignUpState();
}

class _SignUpState extends State<SignUp> {
  JobScreen jobScreen = new JobScreen();

  var kk1 = {
    "الامارات": ["دبي", "أبوظبي", "الشارقة", "عجمان", "الفجيرة"],
    "السعوديه": ["الرياض", "جده", "مكه", "المدينه", "الدمام"],
    "العراق": ["صنعاء", "بغداد", "اربيل", "بصرى", "الموصل"],
    "سوريا": ["دمشق", "حلب", "حمص", "حماه", "ادلب"],
    "فلسطين": ["حيفا", "يافا", "القدس", "الاقصى", "نابلس"],
    "مصر": ["القاهره", "الصعيد", "اسوان", "اسيوط", "سيناء"]
  };

  Widget fill_text(String b, String name, Icon, keyboardType) {
    return TextFormField(
        initialValue: jobScreen.d[b],
        keyboardType: keyboardType,
        onSaved: (val) {
          jobScreen.text.add(val);
        },
        decoration: InputDecoration(
          labelText: name,
          fillColor: Colors.white,
          filled: true,
          border: myinputborder(),
          enabledBorder: myinputborder(),
          focusedBorder: myfocusborder(),
        ),
        validator: (val) {
          if (val.isEmpty) return 'Please enter valid  number';

          return null;
        },
        onChanged: (val) {
          setState(() {
            jobScreen.d[b] = val;
          });
        });
  }

  Widget z(var v, String name, List<String> l) {
    return DropdownButton(
      dropdownColor: Colors.black,
      hint: Text(
        name,
        style: TextStyle(
            color: Colors.white, fontSize: 8, backgroundColor: Colors.black),
      ),
      items: l
          .map((e) => DropdownMenuItem(
                child: Text(
                  "$e",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    //  backgroundColor: Colors.black
                  ),
                ),
                value: e,
              ))
          .toList(),
      onChanged: (valu) {
        setState(() {
          jobScreen.d[v] = valu;

          if (v == "region")
            jobScreen.d['city'] = kk[jobScreen.d['region']][0];
          else if (v == "city") jobScreen.d['city'] = valu;
        });
      },
      elevation: 20,
      style: TextStyle(color: Colors.green, fontSize: 16),
      icon: Icon(
        Icons.arrow_drop_down_circle,
        color: Colors.black,
      ),
      iconDisabledColor: Colors.black,
      iconSize: 20,
      value: jobScreen.d[v],
    );
  }

  OutlineInputBorder myinputborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(200)),
        borderSide: BorderSide(
          color: Colors.greenAccent,
          width: 3,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(200)),
        borderSide: BorderSide(
          color: Colors.black,
          width: 3,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'signup',
        theme: ThemeData.light()
            .copyWith(primaryColor: Colors.indigo, accentColor: Colors.black),
        debugShowCheckedModeBanner: false,
        home: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                body: ListView(children: [
              Container(
                  child: Align(
                      child: SizedBox(
                height: 1780,
                width: 400,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Opacity(
                      opacity: 0.1,
                      child: Container(
                        color: Colors.grey[600],
                      ),
                    ),
                    Positioned(
                      top: -140,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.black87,
                      ),
                    ),
                    Positioned(
                      top: 72,
                      child: Card(
                        color: Colors.grey[600],
                        child: Container(
                          height: 70,
                          width: 380,
                          padding: EdgeInsets.only(top: 20),
                          margin: EdgeInsets.only(top: 50),
                        ),
                        elevation: 1,
                        shadowColor: Colors.red,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    Positioned(
                        top: 100,
                        child: Container(
                          width: 300,
                          child: Form(
                            key: jobScreen.formstate,
                            child: TextFormField(
                                initialValue: jobScreen.d["email"],
                                onSaved: (val) {
                                  jobScreen.myemail = val;
                                  jobScreen.d["email"] = val;
                                },
                                decoration: InputDecoration(
                                  labelText: "  الايميل *",
                                  fillColor: Colors.white,
                                  filled: true,

                                  border: myinputborder(),
                                  enabledBorder: myinputborder(),
                                  focusedBorder:
                                      myfocusborder(), //focused border
                                ),
                                validator: (val) {
                                  if (val.isEmpty)
                                    return 'ادخل ايميلا صحيحا';
                                  else if (val.length > 100)
                                    return "لا يمكن ان يكون بهذا الحجم";
                                  else if (val.length < 2)
                                    return "لا يمكن ان يكون اقل من حرفين";
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    jobScreen.d["email"] = val;
                                  });
                                }),
                          ),
                        )),
                    Positioned(
                      top: 230,
                      child: Card(
                        color: Colors.grey[600],
                        child: Container(
                          height: 70,
                          width: 380,
                          padding: EdgeInsets.only(top: 20),
                          margin: EdgeInsets.only(top: 50),
                        ),
                        elevation: 1,
                        shadowColor: Colors.red,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    Positioned(
                        top: 270,
                        child: Container(
                          width: 300,
                          child: Form(
                            key: jobScreen.formstate2,
                            child: TextFormField(
                                initialValue: jobScreen.d["password"],
                                onSaved: (val) {
                                  jobScreen.mypassword = val;
                                  jobScreen.d["password"] = val;
                                },
                                decoration: InputDecoration(
                                  labelText: "  كلمه المرور *",
                                  fillColor: Colors.white,
                                  filled: true,

                                  border: myinputborder(),
                                  //normal border
                                  enabledBorder: myinputborder(),
                                  //enabled border
                                  focusedBorder:
                                      myfocusborder(), //focused border
                                ),
                                validator: (val) {
                                  if (val.isEmpty)
                                    return 'ادخل كلمة مرور صحيحا';
                                  else if (val.length > 100)
                                    return "لا يمكن ان يكون بهذا الحجم";
                                  else if (val.length < 2)
                                    return "لا يمكن ان تكون اقل من حرفين";
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    jobScreen.d["password"] = val;
                                  });
                                }),
                          ),
                        )),
                    Positioned(
                      top: 400,
                      child: Card(
                        color: Colors.grey[600],
                        child: Container(
                          height: 70,
                          width: 380,
                          padding: EdgeInsets.only(top: 20),
                          margin: EdgeInsets.only(top: 50),
                        ),
                        elevation: 1,
                        shadowColor: Colors.red,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    Positioned(
                        top: 440,
                        child: Container(
                          width: 300,
                          child: Form(
                            key: jobScreen.formstate3,
                            child: fill_text(
                              "company",
                              '  اسم الشركه * ',
                              Icon(
                                Icons.dashboard,
                              ),
                              TextInputType.name,
                            ),
                          ),
                        )),
                    Positioned(
                      top: 570,
                      child: Card(
                        color: Colors.grey[600],
                        child: Container(
                          height: 70,
                          width: 380,
                          padding: EdgeInsets.only(top: 20),
                          margin: EdgeInsets.only(top: 50),
                        ),
                        elevation: 1,
                        shadowColor: Colors.red,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Positioned(
                      top: 620,
                      child: Container(
                        width: 300,
                        child: Form(
                          autovalidateMode: AutovalidateMode.always,
                          key: jobScreen.formstate4,
                          child: SizedBox(
                            width: 300,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.add_location_alt_rounded,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "المقر الرئيسي * :",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    z("region", "المدينه", [
                                      "السعوديه",
                                      "العراق",
                                      "سوريا",
                                      "فلسطين",
                                      "مصر",
                                      "الامارات"
                                    ]),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 740,
                      child: Card(
                        color: Colors.grey[600],
                        child: Container(
                          height: 70,
                          width: 380,
                          padding: EdgeInsets.only(top: 20),
                          margin: EdgeInsets.only(top: 50),
                        ),
                        elevation: 1,
                        shadowColor: Colors.red,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Positioned(
                      top: 780,
                      child: Container(
                        width: 300,
                        child: Form(
                          autovalidateMode: AutovalidateMode.always,
                          key: jobScreen.formstate5,
                          child: SizedBox(
                            width: 300,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.add_location_alt_rounded,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "المدينه *:  ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    z("city", "المدينه",
                                        kk1[jobScreen.d['region']]),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 910,
                      child: Card(
                        color: Colors.grey[600],
                        child: Container(
                          height: 70,
                          width: 380,
                          padding: EdgeInsets.only(top: 20),
                          margin: EdgeInsets.only(top: 50),
                        ),
                        elevation: 1,
                        shadowColor: Colors.red,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    Positioned(
                      top: 950,
                      child: Form(
                        autovalidateMode: AutovalidateMode.always,
                        key: jobScreen.formstate6,
                        child: SizedBox(
                          width: 300,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "الحجم *:",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  z(
                                    "size",
                                    "الحجم",
                                    [
                                      "أقل من 1000 موظف",
                                      " 5000 - 1000 موظف",
                                      "10000 - 5000 موظف",
                                      "15000 - 10000 موظف",
                                      "20000 - 15000 موظف",
                                      "25000 - 20000 موظف",
                                      "30000 - 25000 موظف",
                                      " أكبر من 30000  موظف"
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 1080,
                      child: Card(
                        color: Colors.grey[600],
                        child: Container(
                          height: 70,
                          width: 380,
                          padding: EdgeInsets.only(top: 20),
                          margin: EdgeInsets.only(top: 50),
                        ),
                        elevation: 1,
                        shadowColor: Colors.red,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    Positioned(
                        top: 1120,
                        child: Container(
                          width: 300,
                          child: Form(
                            key: jobScreen.formstate7,
                            child: fill_text(
                              "des",
                              ' الوصف *',
                              Icon(
                                Icons.ac_unit_sharp,
                                color: Colors.red,
                              ),
                              TextInputType.name,
                            ),
                          ),
                        )),
                    Positioned(
                      top: 1250,
                      child: Card(
                        color: Colors.grey[600],
                        child: Container(
                          height: 70,
                          width: 380,
                          padding: EdgeInsets.only(top: 20),
                          margin: EdgeInsets.only(top: 50),
                        ),
                        elevation: 1,
                        shadowColor: Colors.red,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    Positioned(
                        top: 1290,
                        child: Container(
                          width: 300,
                          child: Form(
                            key: jobScreen.formstate8,
                            child: fill_text("spe", ' التخصص *',
                                Icon(Icons.add_location), TextInputType.name),
                          ),
                        )),
                    Positioned(
                      top: 1420,
                      child: Card(
                        color: Colors.grey[600],
                        child: Container(
                          height: 70,
                          width: 380,
                          padding: EdgeInsets.only(top: 20),
                          margin: EdgeInsets.only(top: 50),
                        ),
                        elevation: 1,
                        shadowColor: Colors.red,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    Positioned(
                        top: 1460,
                        child: Container(
                          width: 300,
                          child: Form(
                            key: jobScreen.formstate9,
                            child: fill_text(
                              "phone",
                              'الهاتف*  ',
                              Icon(Icons.phone),
                              TextInputType.phone,
                            ),
                          ),
                        )),
                    Positioned(
                      top: 1510,
                      child: Container(
                        height: 50,
                        width: 380,
                        padding: EdgeInsets.only(top: 20, right: 20),
                        margin: EdgeInsets.only(top: 50),
                        child: Center(
                            child: Row(
                          children: [
                            Text(
                              "اذا كان لديك حساب ",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => new Login()));
                              },
                              child: Text(
                                "اضغط هنا",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 25),
                              ),
                            )
                          ],
                        )),
                      ),
                    ),
                    Positioned(
                      top: 1660,
                      child: Row(children: [
                        SizedBox(
                          width: 20.0,
                        ),
                        Container(
                            width: 180.00,
                            child: RaisedButton(
                                onPressed: () async {
                                  try {
                                    UserCredential userCredential =
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email: jobScreen.d["email"],
                                                password:
                                                    jobScreen.d["password"]);
                                    return await userCredential;
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      print(
                                          'The password provided is too weak.');
                                    } else if (e.code ==
                                        'email-already-in-use') {
                                      print(
                                          'The account already exists for that email.');
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                  await jobScreen.signupo(context);
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
                                        colors: [
                                          Colors.red,
                                          Colors.grey[600]
                                        ]),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: 300.0, minHeight: 50.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "انشاء حساب",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 26.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ))),
                        SizedBox(
                          width: 20.0,
                        ),
                      ]),
                    ),
                  ],
                ),
              )))
            ]))));
  }
}
