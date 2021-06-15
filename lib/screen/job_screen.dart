import 'dart:math';

import 'package:b/screen/My_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';

//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

final jobReference = FirebaseFirestore.instance.collection("companies");

class JobScreen {
  var formdata;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  var mypassword, myemail;

  File file;
  String urlk;
  List<String> data_save = new List();
  var image = ImagePicker();
  var imagename;
  int h = 0;
  List<String> text = new List();

  Widget fill_text(String name, String hint, Icon, keyboardType) {
    return TextFormField(
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
      validator: validateName,
    );
  }

  String validateName(String value) {
    if (value.isEmpty) return 'هذا الحقل مطلوب';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    return null;
  }

  signupo(context) async {
    formdata = formstate.currentState;

    if (formdata.validate()) {
      await formdata.save();

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: myemail, password: mypassword);
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
      //CircularProgressIndicator();
      await jobReference.add({
        'company': text.elementAt(0),
        'region': text.elementAt(1),
        'city': text.elementAt(2),
        'specialization': text.elementAt(3),
        'email_advance': user.email,
        'description': text.elementAt(4),
        'size_company': text.elementAt(5),

        'phone': text.elementAt(6),
        'link_image': "link of image",
      });

      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new HomePage()));
    }
  }
}
