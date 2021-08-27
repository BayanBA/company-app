import 'dart:convert';

import 'package:b/chanceScreen/chance.dart';
import 'package:b/employeeSecreen/Initial_acceptance.dart';
import 'package:b/postSecreen/postDetals.dart';
import 'package:b/postSecreen/viewPost.dart';
import 'package:b/chanceScreen/view.dart';
import 'package:b/screen/employbottom.dart';
import 'package:b/screen/savedUser.dart';
import 'package:b/screen/showUser.dart';
import 'package:b/stand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'notification.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userr;
  var token;
  var follow = new List();
  var batool1;
  var aseel = 0;
  String u;
  Map<String, dynamic> homePageData = new Map<String, dynamic>();

  getdata1() async {
    CollectionReference t = FirebaseFirestore.instance.collection("companies");
    userr = await FirebaseAuth.instance.currentUser;
    await t.where("email_advance", isEqualTo: userr.email).get().then((value) {
      value.docs.forEach((element) {
        Provider.of<MyProvider>(context, listen: false).setCompId(element.id);
        setState(() {
          u = element.id;
          homePageData = element.data();
          batool1.add(element.data());
        });
      });
    });
  }

  // deletedata(context) async {
  //   CollectionReference t = FirebaseFirestore.instance.collection("companies");
  //   var user = FirebaseAuth.instance.currentUser;
  //   await t.where("email_advance", isEqualTo: user.email).get().then((value) {
  //     value.docs.forEach((element) {
  //       setState(() {
  //         DocumentReference d = FirebaseFirestore.instance
  //             .collection("companies")
  //             .doc(element.id);
  //         d.delete();
  //       });
  //     });
  //   });
  //   await user.delete();
  //   Navigator.push(
  //       context, new MaterialPageRoute(builder: (context) => new Login()));
  // }
  //
  // deletAlart(context) async {
  //   await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //             shape: BeveledRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10)),
  //             title: Container(
  //                 margin: EdgeInsets.only(right: 20),
  //                 child: Column(
  //                   children: [
  //                     Text(
  //                       "هل انت متاكد من حذف الحساب",
  //                       style: TextStyle(
  //                           color: Theme.of(context).primaryColor,
  //                           fontStyle: FontStyle.italic),
  //                     ),
  //                   ],
  //                 )),
  //             content: Container(
  //               height: 20,
  //             ),
  //             actions: <Widget>[
  //               Container(
  //                 margin: EdgeInsets.only(right: 30),
  //                 child: ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     primary: Theme.of(context).accentColor,
  //                     onPrimary: Colors.black,
  //                     shape: const BeveledRectangleBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(3))),
  //                   ),
  //                   onPressed: () => setState(() {
  //                     Navigator.of(context).pop();
  //                   }),
  //                   child: Text(
  //                     "لا",
  //                     style: TextStyle(color: Colors.black),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 margin: EdgeInsets.only(right: 30),
  //                 child: ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     primary: Theme.of(context).accentColor,
  //                     onPrimary: Colors.black,
  //                     shape: const BeveledRectangleBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(3))),
  //                   ),
  //                   onPressed: () => setState(() {
  //                     deletedata(context);
  //
  //                     Navigator.push(
  //                         context,
  //                         new MaterialPageRoute(
  //                             builder: (context) => new Login()));
  //                   }),
  //                   child: Text(
  //                     '  نعم',
  //                     style: TextStyle(color: Colors.black),
  //                   ),
  //                 ),
  //               )
  //             ]);
  //       });
  // }
  //
  // sign_out_Alart(context) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //             shape: BeveledRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10)),
  //             title: Container(
  //                 margin: EdgeInsets.only(right: 20),
  //                 child: Column(
  //                   children: [
  //                     Text(
  //                       "هل انت متاكد من تسجيل الخروج",
  //                       style: TextStyle(
  //                           color: Theme.of(context).primaryColor,
  //                           fontStyle: FontStyle.italic),
  //                     ),
  //                   ],
  //                 )),
  //             content: Container(
  //               height: 20,
  //             ),
  //             actions: <Widget>[
  //               Container(
  //                 margin: EdgeInsets.only(right: 30),
  //                 child: ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     primary: Theme.of(context).accentColor,
  //                     onPrimary: Colors.black,
  //                     shape: const BeveledRectangleBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(3))),
  //                   ),
  //                   onPressed: () => setState(() {
  //                     Navigator.of(context).pop();
  //                   }),
  //                   child: Text(
  //                     "لا",
  //                     style: TextStyle(color: Colors.black),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 margin: EdgeInsets.only(right: 30),
  //                 child: ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     primary: Theme.of(context).accentColor,
  //                     onPrimary: Colors.black,
  //                     shape: const BeveledRectangleBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(3))),
  //                   ),
  //                   onPressed: () {
  //                     //  await _signOut();
  //                     Navigator.push(
  //                         context,
  //                         new MaterialPageRoute(
  //                             builder: (context) => new Login()));
  //                   },
  //                   child: Text(
  //                     '  نعم',
  //                     style: TextStyle(color: Colors.black),
  //                   ),
  //                 ),
  //               )
  //             ]);
  //       });
  // }
  //
  // edit_Alart(context) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //             shape: BeveledRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10)),
  //             title: Container(
  //                 margin: EdgeInsets.only(right: 20),
  //                 child: Column(
  //                   children: [
  //                     Text(
  //                       "هل انت متأكد من التعديلات",
  //                       style: TextStyle(
  //                           color: Theme.of(context).primaryColor,
  //                           fontStyle: FontStyle.italic),
  //                     ),
  //                   ],
  //                 )),
  //             content: Container(
  //               height: 20,
  //             ),
  //             actions: <Widget>[
  //               Container(
  //                 margin: EdgeInsets.only(right: 30),
  //                 child: ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     primary: Theme.of(context).accentColor,
  //                     onPrimary: Colors.black,
  //                     shape: const BeveledRectangleBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(3))),
  //                   ),
  //                   onPressed: () => setState(() {
  //                     Navigator.of(context).pop();
  //                   }),
  //                   child: Text(
  //                     "لا",
  //                     style: TextStyle(color: Colors.black),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 margin: EdgeInsets.only(right: 30),
  //                 child: ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     primary: Theme.of(context).accentColor,
  //                     onPrimary: Colors.black,
  //                     shape: const BeveledRectangleBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(3))),
  //                   ),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //
  //                     print("((((((((((((((((((((((((((((((((((");
  //                     print(finsh);
  //                     setState(() {
  //                       share(context);
  //                     });
  //                   },
  //                   child: Text(
  //                     '  نعم',
  //                     style: TextStyle(color: Colors.black),
  //                   ),
  //                 ),
  //               )
  //             ]);
  //       });
  // }
  kk() async {
    await FirebaseMessaging.onMessage.listen((event) async {
      setState(() {
        aseel = 1;
      });
    });
  }

  void initState() {
    batool1 = new List();
    kk();
    //getdata1();
    getmessage();
    super.initState();
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
            if (message.data['user_Id'] == element.id) {
              lis.add(element.data());
              print(lis);
            }
          });
        });
      });
      if (message.data['num'] == "1")
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => show_detals(lis, ui)));
      else {
        print(message.data['post_Id']);

        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => PostDetals(message.data['post_Id'])));
      }
    });

    // var message = await FirebaseMessaging.instance.getInitialMessage();
    // ui = message.data['user_Id'];
    // await user.get().then((value) {
    //   value.docs.forEach((element) {
    //     setState(() {
    //
    //       if (message.data['user_Id'] == element.id) {
    //         lis.add(element.data());
    //         print(lis);
    //       }
    //     });
    //   });
    // });
    // if (message.data['num'] == "1")
    //   Navigator.push(context,
    //       new MaterialPageRoute(builder: (context) => show_detals(lis, ui)));
    // else {
    //   print(message.data['post_Id']);
    //
    //   Navigator.push(
    //       context,
    //       new MaterialPageRoute(
    //           builder: (context) => PostDetals(message.data['post_Id'])));
    // }
  }

  nn() async {
    await getdata1();
  }

  Widget build(BuildContext context) {
    nn();
    double size = 200;
    return
      // Consumer<ThemeNotifier>(
      //     builder: (context, theme, _) => MaterialApp(
      //         theme: theme.getTheme(),
      //         home:
      Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100.0),
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
              body:




              Stack(alignment: Alignment.center, children: [
                Positioned(
                  top: 250,
                  left: -300,
                  child: CircleAvatar(
                    radius: 500,
                    backgroundColor:
                    Theme.of(context).accentColor.withOpacity(0.1),
                  ),
                ),
                batool1.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                                child: CircleAvatar(
                                  backgroundColor:
                                  Theme.of(context).accentColor,
                                  radius: 150,
                                  backgroundImage: homePageData[
                                  'link_image'] ==
                                      "not"
                                      ? AssetImage("images/55.jpeg")
                                      : NetworkImage(
                                    homePageData['link_image'],
                                  ),
                                )),

                            SizedBox(
                              height: 20,
                            ),

                            // Container(height: 40),

                            Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20),
                                    padding: EdgeInsets.only(
                                        left: 20, bottom: 10),
                                    height: 50,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width,
                                    child: ListView(
                                      children: [
                                        Row(children: [
                                          _prefixIcon(Icons
                                              .perm_contact_cal_sharp),
                                          Text('   اسم الشركه : ',
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                  fontSize: 20.0,
                                                  color: Theme.of(
                                                      context)
                                                      .primaryColor)),
                                          Flexible(
                                            child: Text(
                                                "     " +
                                                    homePageData[
                                                    'company'],
                                                //batool1[index]['company'],
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .normal,
                                                    fontSize: 18.0,
                                                    color: Colors
                                                        .black)),
                                          ),
                                        ]),
                                      ],
                                    )
                                  // Flexible(

                                  // //SizedBox(height: 10),

                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20),
                                    height: 50,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width,
                                    child: Row(children: <Widget>[
                                      _prefixIcon(Icons
                                          .add_location_alt_rounded),

                                      Text('   موقع الشركه:',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 20.0,
                                              color: Theme.of(
                                                  context)
                                                  .primaryColor)),
                                      // SizedBox(height: 10),
                                      Text(
                                          "     " +
                                              homePageData[
                                              'region'],
                                          //batool1[index]['region'],
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.normal,
                                              fontSize: 18.0,
                                              color: Colors.black)),
                                    ])),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20),
                                    height: 50,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width,
                                    child: Row(
                                      children: [
                                        _prefixIcon(
                                            Icons.account_balance),
                                        Text('   الوصف العام:',
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 20.0,
                                                color: Theme.of(
                                                    context)
                                                    .primaryColor)),
                                        SizedBox(height: 10),
                                      ],
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 20, right: 40),
                                    height: MediaQuery.of(context)
                                        .size
                                        .height,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width,
                                    padding: EdgeInsets.only(
                                        left: 20, bottom: 10),
                                    child: ListView(children: [
                                      Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                  "     " +
                                                      homePageData[
                                                      'description'],
                                                  // batool1[index]['description'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                      fontSize:
                                                      18.0,
                                                      color: Colors
                                                          .black)),
                                            ),
                                          ]),
                                    ])),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            )
                          ],
                        ))
                  ],
                ),
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


  _prefixIcon(IconData iconData) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
      child: Container(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          margin: const EdgeInsets.only(right: 8.0),
          // decoration: BoxDecoration(
          //     color: Colors.brown.withOpacity(0.2),
          //     borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(30.0),
          //         bottomLeft: Radius.circular(30.0),
          //         topRight: Radius.circular(30.0),
          //         bottomRight: Radius.circular(10.0))),
          child: Icon(
            iconData,
            size: 30,
            color: Colors.black,
          )),
    );
  }
}
