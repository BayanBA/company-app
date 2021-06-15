import 'dart:math';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../jobs.dart';
import 'My_profile.dart';


class JobScreenEdit extends StatefulWidget {



  State<StatefulWidget> createState() => new _JobsScreenEditState();
}

class _JobsScreenEditState extends State<JobScreenEdit>
  with SingleTickerProviderStateMixin {
  jobs jobk;
  var dym;
  File image;
  File file;
  var url;
  var urlk;
  var imagepicker = ImagePicker();
  var imagename;
  String link_image;
  final jobReference = FirebaseFirestore.instance.collection("companies");
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  List<String> text;
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

                      setState(() {
                        dym = file;
                      });

                      var rand = Random().nextInt(100000);
                      var imagename = "$rand" + basename(picked.path);
                      var ref =
                      FirebaseStorage.instance.ref("images/$imagename");
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

                      // setState(() {
                      //   dym = file;
                      // });

                      Navigator.of(context).pop();
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
                      var ref =
                      FirebaseStorage.instance.ref("images/$imagename");
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

                      setState(() {
                        dym = file;
                      });
                      Navigator.of(context).pop();
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
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    text = new List();
    date();
    SystemChrome.setEnabledSystemUIOverlays([]);
    _controller = AnimationController(vsync: this);
  }

  Widget fill_text(String name, String hint, Icon, keyboardType, String sav) {
    return

      TextFormField(
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
      await jobReference
          .where("email_advance", isEqualTo: user.email)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          DocumentReference d = FirebaseFirestore.instance
              .collection("companies")
              .doc(element.id);

          d.update({
            'company': text.elementAt(0),
            'region': text.elementAt(1),
            'city': text.elementAt(2),
            'specialization': text.elementAt(3),
            'email_advance': user.email,
            'size_company': text.elementAt(4),
            'description': text.elementAt(5),
            'phone': text.elementAt(6),
            'link_image': "link of image",
          }).then(
                (value) {
              Navigator.push(
                  this.context,
                  new MaterialPageRoute(
                      builder: (context) => new HomePage()));
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
            String k2 = element.data()['size_company'];
            String k3 = element.data()['email_advance'];
            String k4 = element.data()['company'];
            String k888 = element.data()['city'];
            String k111 = element.data()['specialization'];
            String k5 = element.data()['region'];
            String k6 = element.data()['description'];
            String k8 = element.data()['phone'];
            String k222= element.data()['link_image'];
            link_image= element.data()['link_image'];
            jobk = new jobs('', k5,k888,k111, k4, k6, k3, k2, k8,k222);
          });
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.white,

            body: ListView(children:
            [Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CustomPaint(
                          painter: ArcPainter(type: PaintType.right),
                          child: FloatingActionButton(
                              child: Icon(
                                Icons.add_a_photo_sharp,
                                size: 50,
                                color: Colors.black,
                              ),
                              backgroundColor: Color(0xffA562FF),
                              onPressed: () {
                                showBottomSheet(context);
                              })),
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
                                    colors: [Color(0xffFE7227), Color(0xffFEA120)],
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
                                    colors: [Color(0xffB767FC), Color(0xffD765FB)],
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
                                  colors: [Color(0xff3DD92E), Color(0xff8BFB6B)]),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 30),
                                    color: Color(0xFF3DD92E).withAlpha(100),
                                    blurRadius: 40)
                              ],
                            ),
                            child: InkWell(
                              //showBottomSheet(context),
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage:
                                     NetworkImage(
                                          link_image==null?  CircularProgressIndicator(): link_image,

                                        ),
                                    )

                            )),
                        Positioned(
                          height: 35,
                          width: 35,
                          top: 40,
                          left: 40,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    colors: [Color(0xff0894FF), Color(0xff05BFFA)],
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
                            'اسم الشركه',
                            '...',
                            Icon(
                              Icons.dashboard,
                            ),
                            TextInputType.name,
                            jobk.company),
                        SizedBox(height: 24.0),


                        fill_text('المقر الرئيسي', '...', Icon(Icons.add_location),
                            TextInputType.name, jobk.region),

                        SizedBox(height: 24.0),

                        fill_text('المدينه', '...', Icon(Icons.add_location),
                            TextInputType.name, jobk.city),

                        SizedBox(height: 24.0),
                        fill_text('الايميل', '...', Icon(Icons.email),
                            TextInputType.emailAddress, jobk.email_advance),
                        SizedBox(height: 24.0),


                        fill_text('حجم الشركه', '...', Icon(Icons.nature),
                            TextInputType.name, jobk.size_company),
                        SizedBox(height: 24.0),

                        fill_text('الوصف', '...', Icon(Icons.ac_unit_sharp),
                            TextInputType.name,
                            jobk.description),

                        SizedBox(height: 24.0),

                        fill_text('التخصص', '...', Icon(Icons.ac_unit_sharp),
                            TextInputType.name,
                            jobk.specialization),

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
        ],),
      ),
    );
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

