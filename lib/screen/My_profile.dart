import 'dart:convert';

import 'package:b/chanceScreen/chance.dart';
import 'package:b/postSecreen/viewPost.dart';
import 'package:b/chanceScreen/view.dart';
import 'package:b/screen/employbottom.dart';
import 'package:b/screen/savedUser.dart';
import 'package:b/screen/showUser.dart';
import 'package:b/screen/users.dart';
import 'package:b/stand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../jobs.dart';
import 'notification.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String link_image;
  jobs jobk;
  var userr;
  var token;
  var follow = new List();
  String u;
  var my_lis = new List();
  Map<String, dynamic> homePageData = new Map<String, dynamic>();

  getdata1() async {
    CollectionReference t = FirebaseFirestore.instance.collection("companies");
    userr = await FirebaseAuth.instance.currentUser;

    await t.where("email_advance", isEqualTo: userr.email).get().then((value) {
      value.docs.forEach((element) {
        Provider.of<MyProvider>(context, listen: false).setCompId(element.id);
        setState(() {
          homePageData = element.data();
          u = element.id;
        });
      });
    });
  }

  var counter = 0;
  var my = new List();

  ss() async {
    var v = FirebaseFirestore.instance
        .collection("companies")
        .doc(u)
        .collection("notification");

    await v.get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          if (DateTime.now().year.toString() ==
                  element.data()["date_publication"]['year'].toString() &&
              DateTime.now().month.toString() ==
                  (element.data()["date_publication"]['month'].toString())) {
            if (DateTime.now().day.toInt() >=
                    element.data()["date_publication"]['day'] &&
                element.data()['date_publication']['day'] >
                    (DateTime.now().day.toInt() - 7)) my.add(element.data());
          }
        });
      });
    });
  }

  kk() async {
    await ss();
  }

  //  dd() {
  //    var v = FirebaseFirestore.instance
  //        .collection("number")
  //   kk();
  //   if(my.length>)
  //   // return new Stack(
  //   //   children: <Widget>[
  //   //     Container(
  //   //       margin: EdgeInsets.only(top: 10),
  //   //       child: IconButton(
  //   //           icon: Icon(Icons.notifications),
  //   //           iconSize: 40,
  //   //           color: Colors.yellow,
  //   //           onPressed: () {
  //   //             setState(() {
  //   //               counter = 0;
  //   //
  //   //               Navigator.push(
  //   //                   context,
  //   //                   new MaterialPageRoute(
  //   //                       builder: (context) => notifcation()));
  //   //             });
  //   //           }),
  //   //     ),
  //   //     counter != 0
  //   //         ? new Positioned(
  //   //             right: 11,
  //   //             top: 15,
  //   //             child: new Container(
  //   //               // padding: EdgeInsets.all(2),
  //   //               decoration: new BoxDecoration(
  //   //                 color: Colors.red,
  //   //                 borderRadius: BorderRadius.circular(20),
  //   //               ),
  //   //               constraints: BoxConstraints(
  //   //                 minWidth: 20,
  //   //                 minHeight: 20,
  //   //               ),
  //   //               child: Text(
  //   //                 '$counter',
  //   //                 style: TextStyle(
  //   //                   color: Colors.white,
  //   //                   fontSize: 15,
  //   //                 ),
  //   //                 textAlign: TextAlign.center,
  //   //               ),
  //   //             ),
  //   //           )
  //   //         : new Container()
  //   //   ],
  //   // );
  // }

  @override
  void initState() {
    getmessage();

    super.initState();
  }

  nnn() async {
    await getdata1();
  }

  getmessage() async {
    String ui;
    var user = FirebaseFirestore.instance.collection("users");
    var lis = new List();
    await FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      ui = message.data['user_Id'];
      await user.get().then((value) {
        value.docs.forEach((element) {
          setState(() {
            if (message.data['user_Id'] == element.id) lis.add(element.data());
          });
        });
      });
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => show_detals(lis, ui)));
    });
  }
  Widget getimage() {

    return CircleAvatar(
      backgroundColor: Theme.of(context).accentColor,
      radius: 150,
      backgroundImage:  homePageData['link_image'] =='not'?
      AssetImage("images/bb.jpg")
          :  NetworkImage(homePageData['link_image'])
    );
    //});
  }
  @override
  Widget build(BuildContext context) {
    nnn();

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(120.0),
              child: AppBar(
                actions: [],
                title: Center(
                  child: Text(" "),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(70.0),
                  ),
                ),
              ),
            ),
            body: Stack(children: [
              Positioned(
                top: 40,
                left: 50,
                child:
                    getimage(),



              ),
              Positioned(
                top: 250,
                left: -300,
                child: CircleAvatar(
                  radius: 500,
                  backgroundColor:
                      Theme.of(context).accentColor.withOpacity(0.5),
                ),
              ),
              homePageData.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView(children: [
                      SizedBox(
                        height: 250,
                      ),


                      Container(
                        margin: EdgeInsets.only(right: 20, top: 90),
                        child: Column(
                          children: [
                            Row(children: <Widget>[
                              _prefixIcon(Icons.account_balance),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('   الوصف العام:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  SizedBox(height: 1),
                                  Text("     " + homePageData['description'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18.0,
                                          color: Colors.black))
                                ],
                              )
                            ]),
                            Row(children: <Widget>[
                              _prefixIcon(Icons.account_circle_sharp),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('   اسم الشركه:  ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  SizedBox(height: 1),
                                  Text("     " + homePageData['company'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18.0,
                                          color: Colors.black))
                                ],
                              )
                            ]),
                          ],
                        ),
                      ),
                    ]),
            ]),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerTop,
            floatingActionButton: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      FloatingActionButton(
                        heroTag: "tag1",
                        child: Icon(
                          Icons.wallet_travel_outlined,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                        backgroundColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => ShowingData()));
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      FloatingActionButton(
                        heroTag: "tag2",
                        child: Icon(
                          Icons.padding,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                        backgroundColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => ShowingPost()));
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      FloatingActionButton(
                        heroTag: "tag3",
                        child: Icon(
                          Icons.face,
                          color: Theme.of(context).primaryColor,
                          size: 35,
                        ),
                        backgroundColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => navigator()));
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      FloatingActionButton(
                        heroTag: "tag4",
                        child: Icon(
                          Icons.favorite_border,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                        backgroundColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => saves()));
                        },
                      ),
                      SizedBox(
                        width: 22,
                      ),
                      FloatingActionButton(
                        heroTag: "tag5",
                        child: Icon(
                          //notifications_on_outlined
                          Icons.notifications_none,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                        backgroundColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => notifcation()));
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ]))));
  }

  _formUI(position) {
    return new Container(
        child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.black.withOpacity(0.009999),
      shadowColor: Colors.blueAccent.withOpacity(0.09),
      semanticContainer: true,
      borderOnForeground: true,
      elevation: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20.0),
          _company(position),
          SizedBox(height: 12.0),
          _description(position),
        ],
      ),
    ));
  }

  _size(position) {
    return Row(children: <Widget>[
      _prefixIcon(Icons.accessibility_new),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('  حجم الشركه: ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Theme.of(context).primaryColor)),
          SizedBox(height: 1),
          Text("     " + position.size_company,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18.0,
                  color: Colors.black))
        ],
      )
    ]);
  }

  _description(position) {
    return Row(children: <Widget>[
      _prefixIcon(Icons.account_balance),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('   الوصف العام:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Theme.of(context).primaryColor)),
          SizedBox(height: 1),
          Text("     " + position.description,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18.0,
                  color: Colors.black))
        ],
      )
    ]);
  }

  _place(position) {
    return Row(children: <Widget>[
      _prefixIcon(Icons.add_location_alt),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('   المقر الرئيسي:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.deepPurple)),
          SizedBox(height: 1),
          Text("     " + position.region,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18.0,
                  color: Colors.black))
        ],
      )
    ]);
  }

  _company(position) {
    return Row(children: <Widget>[
      _prefixIcon(Icons.account_circle_sharp),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('   اسم الشركه:  ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.deepPurple)),
          SizedBox(height: 1),
          Text("     " + position.company,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18.0,
                  color: Colors.black))
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
              color: Colors.brown.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                  bottomRight: Radius.circular(10.0))),
          child: Icon(
            iconData,
            size: 25,
            color: Theme.of(context).primaryColor,
          )),
    );
  }
}
