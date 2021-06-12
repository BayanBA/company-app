import 'dart:math';
import 'package:b/screen/My_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

final jobReference = FirebaseFirestore.instance.collection("companies");

class JobScreen {

  var formdata;
  GlobalKey<FormState> formstate=new GlobalKey<FormState>();
  var  mypassword, myemail;

  File file;
  String urlk;
  List<String> data_save=new List();
  //var image = ImagePicker();
  var imagename;
  int h = 0;
  List<String> text= new List();

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
      validator:validateName,
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
        'name_job':text.elementAt(0),
        'region': text.elementAt(1),
        'email_advance': user.email,
        'name_advance': text.elementAt(2),
        'description': text.elementAt(3),
        'phone': text.elementAt(4),
        //'type_image': imagename,
      });

      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
              new ListViewjobs()));

    }

  }

  // showBottomSheet(context) {
  //   return showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return Container(
  //           padding: EdgeInsets.all(20),
  //           height: 180,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 "Please Choose Image",
  //                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
  //               ),
  //               InkWell(
  //                 onTap: () async {
  //                   var picked = await ImagePicker()
  //                       .getImage(source: ImageSource.gallery);
  //                   if (picked != null) {
  //                     file = File(picked.path);
  //                     var rand = Random().nextInt(100000);
  //                     var imagename = "$rand" + basename(picked.path);
  //                     var ref =
  //                     FirebaseStorage.instance.ref("images/$imagename");
  //                     await ref.putFile(file);
  //                     urlk = await ref.getDownloadURL();
  //                     print(url);
  //                     print(
  //                         "==================================================");
  //
  //                     Navigator.of(context).pop();
  //                   }
  //                 },
  //                 child: Container(
  //                     width: double.infinity,
  //                     padding: EdgeInsets.all(10),
  //                     child: Row(
  //                       children: [
  //                         Icon(
  //                           Icons.photo_outlined,
  //                           size: 30,
  //                         ),
  //                         SizedBox(width: 20),
  //                         Text(
  //                           "From Gallery",
  //                           style: TextStyle(fontSize: 20),
  //                         )
  //                       ],
  //                     )),
  //               ),
  //               InkWell(
  //                 onTap: () async {
  //                   var picked = await ImagePicker()
  //                       .getImage(source: ImageSource.camera);
  //                   if (picked != null) {
  //                     file = File(picked.path);
  //                     var rand = Random().nextInt(100000);
  //                     var imagename = "$rand" + basename(picked.path);
  //                     var ref =
  //                     FirebaseStorage.instance.ref("images/$imagename");
  //                     await ref.putFile(file);
  //                     var url = await ref.getDownloadURL();
  //                     Navigator.of(context).pop();
  //                   }
  //                 },
  //                 child: Container(
  //                     width: double.infinity,
  //                     padding: EdgeInsets.all(10),
  //                     child: Row(
  //                       children: [
  //                         Icon(
  //                           Icons.camera,
  //                           size: 30,
  //                         ),
  //                         SizedBox(width: 20),
  //                         Text(
  //                           "From Camera",
  //                           style: TextStyle(fontSize: 20),
  //                         )
  //                       ],
  //                     )),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

}

