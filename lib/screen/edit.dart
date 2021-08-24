import 'dart:math';
import 'package:b/chatSecreen/chat.dart';
import 'package:b/enter/login.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../main.dart';
import '../stand.dart';

class JobScreenEdit extends StatefulWidget {
  State<StatefulWidget> createState() => new _JobsScreenEditState();
}

class _JobsScreenEditState extends State<JobScreenEdit> {
  var dym;
  dynamic image;
  File file = null;
  var url;
  var urlk;
  var imagepicker = ImagePicker();
  var imagename;
  String link_image;

  final jobReference = FirebaseFirestore.instance.collection("companies");

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  Map<String, dynamic> homePageData = new Map<String, dynamic>();

  showBottomSheet(context) async {
    var imagepicker = await ImagePicker();
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Please Choose Image",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () async {
                    var picked =
                    await imagepicker.getImage(source: ImageSource.gallery);
                    if (picked != null) {
                      file = File(picked.path);

                      var rand = Random().nextInt(100000);
                      var imagename = "$rand" + basename(picked.path);
                      Reference ref =
                      FirebaseStorage.instance.ref("images/$imagename");
                      setState(() {
                        image = file;
                      });
                      await ref.putFile(file);
                      var urlk = await ref.getDownloadURL();

                      var user = FirebaseAuth.instance.currentUser;
                      await jobReference
                          .where("email_advance", isEqualTo: user.email)
                          .get()
                          .then((value) {
                        value.docs.forEach((element) {
                          DocumentReference d = FirebaseFirestore.instance
                              .collection("companies")
                              .doc(element.id);

                          d.update({
                            'link_image': urlk,
                          });
                        });
                      });

                      // Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.photo_outlined,
                            size: 30,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "From Gallery",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () async {
                    var picked =
                    await imagepicker.getImage(source: ImageSource.camera);
                    if (picked != null) {
                      file = File(picked.path);
                      var rand = Random().nextInt(100000);
                      var imagename = "$rand" + basename(picked.path);
                      Reference ref =
                      FirebaseStorage.instance.ref("images/$imagename");
                      setState(() {
                        image = file;
                      });
                      await ref.putFile(file);
                      var url = await ref.getDownloadURL();
                      var user = FirebaseAuth.instance.currentUser;
                      await jobReference
                          .where("email_advance", isEqualTo: user.email)
                          .get()
                          .then((value) {
                        value.docs.forEach((element) {
                          DocumentReference d = FirebaseFirestore.instance
                              .collection("companies")
                              .doc(element.id);

                          d.update({
                            'link_image': url,
                          });
                        });
                      });

                      //Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera,
                            size: 30,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "From Camera",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      )),
                ),
              ],
            ),
          );
        });
  }

  Widget z(var v, String name, List<String> l) {
    return DropdownButton(
      hint: Text(
        name,
        style: TextStyle(
            color: Colors.black, fontSize: 5, backgroundColor: Colors.black),
      ),
      items: l
          .map((e) => DropdownMenuItem(
        child: Text(
          "$e",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        value: e,
      ))
          .toList(),
      onChanged: (valu) {
        setState(() {
          jobScreen.d[v] = valu;
          if (v == "region")
            jobScreen.d['region'] = homePageData['region'];
          else if (v == "city") jobScreen.d['city'] = valu;
          print(valu);
        });
      },
      elevation: 20,
      style: TextStyle(color: Colors.green, fontSize: 16),
      icon: Icon(Icons.arrow_drop_down_circle),
      iconDisabledColor: Colors.black,
      iconSize: 20,
      value: jobScreen.d[v],
    );
  }

  @override
  void initState() {
    super.initState();
    getdata1();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  var user;

  getdata1() async {
    CollectionReference t = FirebaseFirestore.instance.collection("companies");
    user = await FirebaseAuth.instance.currentUser;

    await t.where("email_advance", isEqualTo: user.email).get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          homePageData = element.data();
        });
      });
    });
  }

  deletedata(context) async {
    CollectionReference t = FirebaseFirestore.instance.collection("companies");
    var user = FirebaseAuth.instance.currentUser;
    await t.where("email_advance", isEqualTo: user.email).get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          DocumentReference d = FirebaseFirestore.instance
              .collection("companies")
              .doc(element.id);
          d.delete();
        });
      });
    });
    await user.delete();
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new Login()));
  }

  deletAlart(context) async {
    await showDialog(
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
                        "هل انت متاكد من حذف الحساب",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontStyle: FontStyle.italic),
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
                      primary: Theme.of(context).accentColor,
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
                      primary: Theme.of(context).accentColor,
                      onPrimary: Colors.black,
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                    ),
                    onPressed: () => setState(() {
                      deletedata(context);

                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Login()));
                    }),
                    child: Text(
                      '  نعم',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ]);
        });
  }

  sign_out_Alart(context) {
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
                        "هل انت متاكد من تسجيل الخروج",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontStyle: FontStyle.italic),
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
                      primary: Theme.of(context).accentColor,
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
                      primary: Theme.of(context).accentColor,
                      onPrimary: Colors.black,
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                    ),
                    onPressed: () {
                      //  await _signOut();
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Login()));
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

  edit_Alart(context) {
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
                        "هل انت متأكد من التعديلات",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontStyle: FontStyle.italic),
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
                      primary: Theme.of(context).accentColor,
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
                      primary: Theme.of(context).accentColor,
                      onPrimary: Colors.black,
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();

                      print("((((((((((((((((((((((((((((((((((");
                      print(finsh);
                      setState(() {
                        share(context);
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

  OutlineInputBorder myinputborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(200)),
        borderSide: BorderSide(
          color: Colors.black,
          width: 3,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(200)),
        borderSide: BorderSide(
          color: Colors.greenAccent,
          width: 3,
        ));
  }

  Widget fill_text(String name, Icon, keyboardType, String v,context) {
    return

      TextFormField(
        initialValue:homePageData[v] ,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),

          labelStyle: TextStyle(fontSize: 25,color:Colors.white),
          border: UnderlineInputBorder(),
          filled: true,
          icon: Icon,
          hintText: '....',
          labelText: name,
        ),
        onSaved: (val) {
          homePageData[v] = val;
        },
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
        },
        validator: _validateName,
      );




      // TextFormField(maxLines:3,
      //   initialValue: homePageData[v],
      //   decoration: InputDecoration(
      //       focusedBorder: OutlineInputBorder(
      //           borderRadius: BorderRadius.circular(15),
      //           borderSide: BorderSide(
      //             color: Colors.lightGreen,
      //             width: 2,
      //           )),
      //       enabledBorder: OutlineInputBorder(
      //           borderRadius: BorderRadius.circular(15),
      //           borderSide: BorderSide(
      //             color: Colors.deepPurple,
      //             width: 2,
      //           )),
      //       errorBorder: OutlineInputBorder(
      //           borderRadius: BorderRadius.circular(15),
      //           borderSide: BorderSide(
      //             color: Colors.pink,
      //             width: 2,
      //           )),
      //       contentPadding: EdgeInsets.all(15),
      //       labelText: name,
      //       labelStyle: TextStyle(fontSize: 40,color:Colors.white, ),
      //       prefixIcon: Icon,
      //       fillColor: Colors.black26,
      //       filled: true
      //   ),
      //   validator: _validateName,
      //   keyboardType: TextInputType.text,
      //
      //   onSaved: (val) {
      //     homePageData[v] = val;
      //   },
      //   onEditingComplete: () {
      //     FocusScope.of(context).unfocus();
      //   },
      // );





  }

  var finsh = 0;

  share(context) async {
    var formdata = formstate.currentState;

    if (formdata.validate()) {
      formdata.save();

      var user = FirebaseAuth.instance.currentUser;

      await jobReference
          .where("email_advance", isEqualTo: user.email)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          DocumentReference d = FirebaseFirestore.instance
              .collection("companies")
              .doc(element.id);

          d.update({
            'company': homePageData["company"],
            'region': homePageData["region"],
            'city': homePageData["city"],
            'followers': [],
            'size_company': homePageData["size_company"],
            'description': homePageData["description"],
            'specialization': homePageData["specialization"],
            'phone': homePageData["phone"],
            'link_image': "not",
          }).then((value) => finsh = 1);
        });
      });
    }
    finsh = 1;
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
            homePageData.isEmpty
                ? CircularProgressIndicator()
                : ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CustomPaint(
                              // painter: ArcPainter(type: PaintType.right),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.add_a_photo_sharp,
                                    size: 52,
                                  ),
                                  color: Colors.black,
                                  onPressed: () {
                                    showBottomSheet(context);
                                  }),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 300,
                          width: 300,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Positioned(
                                height: 100,
                                width: 100,
                                top: 10,
                                right: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffFE7227),
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                          colors: [
                                            Color(0xffFE7227),
                                            Color(0xffFEA120)
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xffFE7227),
                                            offset: Offset(0, 10),
                                            blurRadius: 20)
                                      ]),
                                ),
                              ),
                              Positioned(
                                height: 100,
                                width: 100,
                                bottom: 10,
                                left: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                          colors: [
                                            Color(0xffB767FC),
                                            Color(0xffD765FB)
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xffB767FC),
                                            offset: Offset(0, 10),
                                            blurRadius: 20)
                                      ]),
                                ),
                              ),
                              Container(
                                  height: 200,
                                  width: 200,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                        end: Alignment.topCenter,
                                        begin: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xff3DD92E),
                                          Color(0xff8BFB6B)
                                        ]),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 30),
                                          color: Color(0xFF3DD92E)
                                              .withAlpha(100),
                                          blurRadius: 40)
                                    ],
                                  ),
                                  child: InkWell(
                                    //showBottomSheet(context),
                                      child: CircleAvatar(
                                          radius: 100,
                                          backgroundImage: file != null
                                              ? FileImage(image)
                                              : NetworkImage(homePageData[
                                          'link_image'])
                                        // homePageData['link_image']

                                      ))),
                              Positioned(
                                height: 35,
                                width: 35,
                                top: 40,
                                left: 40,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                          colors: [
                                            Color(0xff0894FF),
                                            Color(0xff05BFFA)
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xff0894FF),
                                            offset: Offset(0, 5),
                                            blurRadius: 10)
                                      ]),
                                ),
                              ),
                              Positioned(
                                height: 15,
                                width: 15,
                                bottom: 40,
                                right: 40,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffFF3443),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xffFF3443),
                                            offset: Offset(0, 2),
                                            blurRadius: 5)
                                      ]),
                                ),
                              ),
                              Positioned(
                                height: 15,
                                width: 15,
                                bottom: 40,
                                right: 40,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffFF3443),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xffFF3443),
                                            offset: Offset(0, 2),
                                            blurRadius: 5)
                                      ]),
                                ),
                              ),
                              Positioned(
                                height: 50,
                                width: 30,
                                bottom: 5,
                                left: 170,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            offset: Offset(0, 10),
                                            blurRadius: 10)
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Form(
                      key: formstate,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 30, left: 15, bottom: 10, right: 15),
                        child: Column(
                          children: [
                            fill_text(
                                'اسم الشركه',
                                Icon(
                                  Icons.perm_contact_cal_sharp,
                                  color: Colors.black,
                                ),
                                TextInputType.name,
                                "company",context),
                            // SizedBox(height: 240.0),
                            // Container(
                            //   width: 300,
                            //   child: SizedBox(
                            //     width: 300,
                            //     child: Column(
                            //       children: [
                            //         Row(
                            //           children: [
                            //             Icon(
                            //               Icons.add_location_alt_rounded,
                            //               color: Colors.black,
                            //             ),
                            //             SizedBox(
                            //               width: 10,
                            //             ),
                            //             Text(
                            //               "المقر الرئيسي * :",
                            //               style: TextStyle(
                            //                   color: Colors.black87,
                            //                   fontSize: 20),
                            //             ),
                            //             SizedBox(
                            //               width: 10,
                            //             ),
                            //             z("region", "المدينه", nn),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(height: 240.0),
                            // Container(
                            //   width: 300,
                            //   child: SizedBox(
                            //     width: 300,
                            //     child: Column(
                            //       children: [
                            //         Row(
                            //           children: [
                            //             Icon(
                            //               Icons.add_location_alt_rounded,
                            //               color: Colors.black,
                            //             ),
                            //             SizedBox(
                            //               width: 10,
                            //             ),
                            //             Text(
                            //               "المدينه *:",
                            //               style: TextStyle(
                            //                   color: Colors.black87,
                            //                   fontSize: 20),
                            //             ),
                            //             SizedBox(
                            //               width: 10,
                            //             ),
                            //             z("city", "المدينه",
                            //                 kk[jobScreen.d['region']]),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 24.0),
                            fill_text(
                                'حجم الشركه',
                                Icon(
                                  Icons.nature,
                                  color: Colors.black,
                                ),
                                TextInputType.name,
                                "size_company",context),
                            SizedBox(height: 24.0),
                            fill_text(
                                'الوصف',
                                Icon(
                                  Icons.add_chart,
                                  color: Colors.black,
                                ),
                                TextInputType.name,
                                "description",context),
                            SizedBox(height: 24.0),
                            fill_text(
                                'التخصص',
                                Icon(
                                  Icons.ac_unit_sharp,
                                  color: Colors.black,
                                ),
                                TextInputType.name,
                                "specialization",context),
                            SizedBox(height: 24.0),
                            fill_text(
                                'الهاتف',
                                Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                ),
                                TextInputType.phone,
                                "phone",context),
                            SizedBox(height: 18.0),
                            // Container(
                            //   child: Row(children: [
                            //     IconButton(
                            //       color: Colors.black,
                            //       icon: Icon(
                            //         Icons.edit,
                            //         size: 40,
                            //       ),
                            //       onPressed: () async =>
                            //           await edit_Alart(context),
                            //     ),
                            //     IconButton(
                            //         color: Colors.black,
                            //         icon: Icon(
                            //           Icons.delete,
                            //           size: 40,
                            //         ),
                            //
                            //     IconButton(
                            //         color: Colors.black,
                            //         icon: Icon(
                            //           Icons.exit_to_app,
                            //           size: 40,
                            //         ),
                            //         onPressed: () async {
                            //           await sign_out_Alart(context);
                            //         }),
                            //   ]),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar( radius: 40,
                    backgroundColor: Colors.white,child: FlatButton(

                      child: Text("التعديل",style: TextStyle(fontSize: 20,color: Colors.black),

                        // color: Theme.of(context).primaryColor,

                      ),

                      onPressed: () async => await edit_Alart(context),


                    ),),
                  SizedBox(height: 18.0),


                ] )
          ]),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerTop,
          // floatingActionButton: Padding(
          //     padding: const EdgeInsets.all(4.0),
          //     child:
          //
          //         //scrollDirection: Axis.horizontal,
          //         Row(children: <Widget>[
          //       SizedBox(
          //         width: 40,
          //       ),
          //
          //       FloatingActionButton(
          //         heroTag: "tag44",
          //         child: Icon(
          //           Icons.edit,
          //           color: Theme.of(context).primaryColor,
          //           size: 40,
          //         ),
          //         backgroundColor: Colors.white,
          //         onPressed: () async => await edit_Alart(context),
          //       ),
          //
          //       SizedBox(
          //         width: 60,
          //       ),
          //       FloatingActionButton(
          //           heroTag: "tag55",
          //           child: Icon(
          //             Icons.delete,
          //             color: Theme.of(context).primaryColor,
          //             size: 40,
          //           ),
          //           backgroundColor: Colors.white,
          //           onPressed: () async {
          //             await deletAlart(context);
          //           }),
          //
          //       SizedBox(
          //         width: 60,
          //       ),
          //       FloatingActionButton(
          //           heroTag: "tag66",
          //           child: Icon(
          //             Icons.exit_to_app,
          //             color: Theme.of(context).primaryColor,
          //             size: 40,
          //           ),
          //           backgroundColor: Colors.white,
          //           onPressed: () async {
          //             await sign_out_Alart(context);
          //           }),
          //
          //       SizedBox(
          //         width: 40,
          //       ),
          //           FloatingActionButton(
          //               heroTag: "tag66",
          //               child: Icon(
          //                 Icons.mark_chat_read_outlined,
          //                 color: Theme.of(context).primaryColor,
          //                 size: 40,
          //               ),
          //               backgroundColor: Colors.white,
          //               onPressed: () async {
          //                 Provider.of<MyProvider>(context, listen: false).setChat(1);
          //                 Navigator.of(context).push(
          //                     MaterialPageRoute(builder: (context) {
          //                       return Chat();
          //                     }));
          //               }),
          //
          //       // ]),
          //     ]))
        ));
  }

  String _validateName(String value) {
    if (value.isEmpty) return 'هذا الحقل مطلوب';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');

    return null;
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

enum PaintType { left, right }

class ArcPainter extends CustomPainter {
  final PaintType type;

  ArcPainter({this.type});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xffFFC300)
      ..style = PaintingStyle.fill;
    if (type == PaintType.right) {
      paint.color = Color(0xffA562FF);
      canvas.drawCircle(Offset(20, 0), 60, paint);
    } else {
      canvas.drawCircle(Offset(-10, -10), 90, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
