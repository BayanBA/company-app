import 'dart:math';

import 'package:b/main.dart';
import 'package:b/screen/My_profile.dart';
import 'package:b/chanceScreen/post.dart';
import 'package:b/chanceScreen/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  // var image = ImagePicker();
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
    "size": "",
    "token":"",
    "des": "",
    "spe": "",
    "phone": "",
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

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: d["email"], password: d["password"]);
      return await userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    var user = await FirebaseAuth.instance.currentUser;
    await jobReference.add({
      'company': d["company"],
      'region': d["region"],
      'city': d["city"],
      'followers':[],
      'specialization': d["spe"],
      'email_advance': user.email,
      'description': d["des"],
      'size_company': d["size"],
      'phone': d["phone"],
      'link_image': "not",
    });

    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => FirstRoute()));


  }

}
