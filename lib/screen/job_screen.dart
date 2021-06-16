import 'dart:math';

import 'package:b/screen/My_profile.dart';
import 'package:b/screen/post.dart';
import 'package:b/screen/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'chance.dart';
import 'edit.dart';

final jobReference = FirebaseFirestore.instance.collection("companies");
List< dynamic> koko= [  HomePage(),Post(),AddJop(),JobScreenEdit(),ShowingData()
];
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
  var image = ImagePicker();
  var imagename;
  int h = 0;
  List<String> text = new List();
  Map<String, dynamic> d = {
    "email":"",
    "password":"",
    "company":"",
    "region":"",
    "city":"",
    "size":"",
    "des":"",
    "spe":"",
    "phone":"",

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

    //if (
   // formdata.validate()
      //   formdata2.validate() &&
      //   formdata3.validate() &&
      //   formdata4.validate() &&
      //   formdata5.validate() &&
      //   formdata6.validate() &&
      //   formdata7.validate() &&
      //   formdata8.validate() &&
      //   formdata9.validate()) {
      // await formdata.save();
      // await formdata2.save();
      // await formdata3.save();
      // await formdata4.save();
      // await formdata5.save();
      // await formdata6.save();
      // await formdata7.save();
      // await formdata8.save();
      // await formdata9.save();

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
        'specialization': d["spe"],
        'email_advance': user.email,
        'description': d["des"],
        'size_company': d["size"],
        'phone': d["phone"],
        'link_image': "link of image",
      });

      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => koko.elementAt(0)));
    }
  }
//}
