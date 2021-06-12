
import 'package:b/jobs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class ListViewjobs extends StatefulWidget {
  @override
  _myprofile createState() => new _myprofile();
}

class _myprofile extends State<ListViewjobs> {
  jobs jobk;
  File file;
  var url;
  //var image = ImagePicker();
  var imagename;

  getdata() async {
    CollectionReference t = await FirebaseFirestore.instance.collection("companies");
    var user =await FirebaseAuth.instance.currentUser;

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


  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        //drawer: mydrawer(),
        body:  SingleChildScrollView(
          child: Center(
            child:
            Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: 80,
                          child: InkWell(
                            child: Center(
                                child: Hero(
                                  tag: 'my-hero-animation-tag',
                                  child: CircleAvatar(
                                    radius: 90,
                                    backgroundImage: url == null
                                        ? AssetImage('images/3.png')
                                        : NetworkImage(url),
                                  ),
                                )),
                            onTap: () => _showSecondPage(context),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text('الملف الشخصي',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0,
                                  color: Colors.orange)),
                        )
                      ],
                    ),

                    _formUI(jobk),

                    Column(
                      children: <Widget>[
                        SizedBox(
                          width: 200,
                          height: 140,
                        ),
                        FloatingActionButton(
                            child: Icon(
                              Icons.camera,
                              color: Colors.red,
                            ),
                            backgroundColor: Colors.deepOrange,
                            onPressed: () {
                              //showBottomSheet(context);
                            })
                      ],
                    ),
                    //backgroundColor: Colors.orangeAccent,
                  ],
                )),
          ),
        ),
      ),

    );
    //_body(context)
  }

  void _showSecondPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => Scaffold(
        appBar: AppBar(
          title: Text(""),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Center(
          child: Hero(
            tag: "",
            child: url == null ? AssetImage('images/3.png') : NetworkImage(url),
          ),
        ),
      ),
    ));
  }

  _formUI(position) {
    return new Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 40.0),
          _email(position),
          SizedBox(height: 12.0),
          _mobile(position),
          SizedBox(height: 12.0),
          _birthDate(position),
          SizedBox(height: 12.0),
          _gender(position),
          SizedBox(height: 12.0),
        ],
      ),
    );
  }

  _email(position) {
    return Row(children: <Widget>[
      _prefixIcon(Icons.email),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('  الايميل ',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.0,
                  color: Colors.green)),
          SizedBox(height: 1),
          Text(position.email_advance)
        ],
      )
    ]);
  }

  _mobile(position) {
    return Row(children: <Widget>[
      _prefixIcon(Icons.phone),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('  رقم الهاتف',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.0,
                  color: Colors.green)),
          SizedBox(height: 1),
          Text(position.phone)
        ],
      )
    ]);
  }

  _birthDate(position) {
    return Row(children: <Widget>[
      _prefixIcon(Icons.date_range),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('   المنطقه',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.0,
                  color: Colors.green)),
          SizedBox(height: 1),
          Text(position.region)
        ],
      )
    ]);
  }

  _gender(position) {
    return Row(children: <Widget>[
      _prefixIcon(Icons.person),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('  اسم الشركه ',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.0,
                  color: Colors.green)),
          SizedBox(height: 1),
          Text(position.name_job)
        ],
      )
    ]);
  }

  _prefixIcon(IconData iconData) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
      child: Container(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          margin: const EdgeInsets.only(right: 8.0),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                  bottomRight: Radius.circular(10.0))),
          child: Icon(
            iconData,
            size: 20,
            color: Colors.black,
          )),
    );
  }
}
