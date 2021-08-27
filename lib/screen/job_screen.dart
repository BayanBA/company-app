import 'dart:math';

import 'package:b/enter/ph.dart';
import 'package:b/main.dart';
import 'package:b/screen/My_profile.dart';
import 'package:b/postSecreen/post.dart';
import 'package:b/chanceScreen/view.dart';
import 'package:b/enter/wait.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

import '../chanceScreen/chance.dart';
import 'edit.dart';

final jobReference = FirebaseFirestore.instance.collection("companies");

class JobScreen {
  var formdata,
      formdata2,
      formdata3,
      formdata4,
      formdata5,
      formdata6,
      formdata7,
      formdata8,
      formdata9;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate2 = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate3 = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate4 = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate5 = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate6 = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate7 = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate8 = new GlobalKey<FormState>();
  GlobalKey<FormState> formstate9 = new GlobalKey<FormState>();

  var mypassword, myemail;

  File file;
  String urlk;
  List<String> data_save = new List();

  var imagename;
  int h = 0;
  List<String> text = new List();
  Map<String, dynamic> d = {
    "email": "",
    "password": "",
    "company": "",
    "region": "سوريا",
    "city": "دمشق",
    "token":"",
    "size": "أقل من 1000 موظف",
    "token":"",
    "des": "",
    "spe": "",
    "phone": "",
    "image_url":"not"
  };

  String validateName(String value) {
    if (value.isEmpty) return 'هذا الحقل مطلوب';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    return null;
  }

  signupo(context) async {
    formdata = formstate.currentState;
    formdata2 = formstate2.currentState;
    formdata3 = formstate3.currentState;
    formdata4 = formstate4.currentState;
    formdata5 = formstate5.currentState;
    formdata6 = formstate6.currentState;
    formdata7 = formstate7.currentState;
    formdata8 = formstate8.currentState;
    formdata9 = formstate9.currentState;
    // if (formdata.validate() && formdata2.validate() && formdata3.validate() &&
    //     formdata4.validate() && formdata5.validate() && formdata6.validate() &&
    //     formdata7.validate() && formdata8.validate() && formdata9.validate()){

      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (context) => Ph(d["company"],d["region"],d["city"],d["spe"],d["des"],d["size"],d["phone"])));


 // }
 //    else
 //      Fluttertoast.showToast(
 //          msg: "تحقق من لبقيم المدخلة",
 //          backgroundColor: Colors.black54,
 //          textColor: Colors.white,
 //          toastLength: Toast.LENGTH_LONG);



  }

}
