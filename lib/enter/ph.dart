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

class Ph extends StatefulWidget {
  var company,region,city,spe,des,size,phone;
  Ph(this.company,this.region,this.city,this.spe,this.des,this.size,this.phone);
  @override
  _PhState createState() => _PhState();
}

class _PhState extends State<Ph> {
  var imagepicker = ImagePicker(), photo;
  Reference refstorage;
  File file;
  var nameImage, url;
  var rr;

  @override
  Widget build(BuildContext context) {
    return  Directionality(
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
          body:
          Stack(children: [
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
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Text("???????? ???????? ???????????? ????????????"+"\n"+"???? ???????? ??????????",style: TextStyle(fontSize: 30),),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child:  InkWell(
                        child: CircleAvatar(
                            backgroundImage:
                            photo != null ? FileImage(photo) : null,
                            radius: 100,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Column(children: [
                                    InkWell(
                                      child: Text("?????????? ???? ???????????? "),
                                      onTap: () async {
                                        var picker = await imagepicker.getImage(
                                            source: ImageSource.gallery);
                                        if (picker != null) {
                                          print("&&&&&&&&&&&&&&&&&");
                                          file = File(picker.path);
                                          print("&&&&&&&&&&&&&&&&&");

                                          var nameImage = basename(picker.path);
                                          var random = Random().nextInt(10000);
                                          nameImage = "$random$nameImage";
                                          refstorage = await FirebaseStorage.instance
                                              .ref()
                                              .child("photo")
                                              .child("$nameImage");
                                          setState(() {
                                            photo = file;
                                          });
                                        }
                                      },
                                    )
                                  ]),
                                );
                              });
                        }),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 180.00,
                    child: RaisedButton(
                        onPressed: () async {
                          await refstorage.putFile(file);
                          url = await refstorage.getDownloadURL();
                          rr=url;
                          var user = await FirebaseAuth.instance.currentUser;
                          var num;

                          var n = await FirebaseFirestore.instance
                              .collection("number")
                              .doc("aLOUXiw8hVsNqdzEsjF5")
                              .get()
                              .then((value) {
                            num = value.data()["num"];
                          });
                          num = num + 1;

                          await FirebaseFirestore.instance
                              .collection("number")
                              .doc("aLOUXiw8hVsNqdzEsjF5")
                              .update({"num": num});


                          await FirebaseFirestore.instance.collection("oner").doc(
                              "DPi7T09bNPJGI0lBRqx4").collection("new_company").add({
                            'company': widget.company,
                            'region': widget.region,
                            'city': widget.city,
                            'followers': [],
                            "bayan": num,
                            "batool":0,
                            "all_accepted":[],
                            'specialization': widget.spe,
                            'email_advance': user.email,
                            'description': widget.des,
                            'size_company': widget.size,
                            'phone': widget.phone,
                            'link_image': "not",
                            "image_url":rr
                          });

                          Fluttertoast.showToast(
                              msg: "???? ?????????? ???????? ??????????",
                              backgroundColor: Colors.black54,
                              textColor: Colors.white,
                              toastLength: Toast.LENGTH_LONG);
                          Navigator.pushReplacement(context,
                              new MaterialPageRoute(builder: (context) => Wait()));

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
                                  Colors.orangeAccent
                                ]),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 300.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "??????????",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            )
          ]),
        ));

  }
}
