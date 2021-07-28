import 'package:b/main.dart';
import 'package:b/screen/view.dart';
import 'package:b/stand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../jobs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String link_image;
  jobs jobk;
  var user;
  Map<String,dynamic> homePageData=new Map<String,dynamic>();

  getdata1() async {
    CollectionReference t = FirebaseFirestore.instance.collection("companies");
    user = await FirebaseAuth.instance.currentUser;

    await t.where("email_advance", isEqualTo: user.email).get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          Provider.of<MyProvider>(context, listen: false).setCompId(element.id);
          homePageData = element.data();
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
   // getdata1();
  }



  nnn()async{await getdata1() ;}
  @override
  Widget build(BuildContext context) {
    nnn();
    return homePageData.isEmpty
        ? CircularProgressIndicator()
        : ListView(children: [
            Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  FloatingActionButton(
                    heroTag:"tag1",
                    child: Icon(
                      Icons.account_balance,
                      color: Colors.indigo[300],
                      size: 30,
                    ),
                    backgroundColor: Colors.white,
                    onPressed: () {Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => ShowingData()));},
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  FloatingActionButton(
                    heroTag:"tag2",
                    child: Icon(
                      Icons.accessibility,
                      color: Colors.indigo[300],
                      size: 30,
                    ),
                    backgroundColor: Colors.white,
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  FloatingActionButton(
                    heroTag:"tag3",
                    child: Icon(
                      Icons.account_circle_rounded,
                      color: Colors.indigo[300],
                      size: 30,
                    ),
                    backgroundColor: Colors.white,
                    onPressed: () {},
                  ),
                ],
              ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                    color: Colors.deepPurple)),
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
                                    color: Colors.deepPurple)),
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
                elevation: 8,
                shadowColor: Colors.green,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ]);
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
                  color: Colors.deepPurple)),
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
                  color: Colors.deepPurple)),
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
            color: Colors.black,
          )),
    );
  }
}
