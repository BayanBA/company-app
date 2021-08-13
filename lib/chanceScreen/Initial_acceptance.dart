import 'package:b/chanceScreen/proGamer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stand.dart';

class InitialAcceptance extends StatefulWidget {
  @override
  _InitialAcceptanceState createState() => _InitialAcceptanceState();
}

class _InitialAcceptanceState extends State<InitialAcceptance> {
  var list = new List();

  //var listOfDate = new List();
  var map = new Map();
  CollectionReference comp;

  getdata() async {
    CollectionReference t = FirebaseFirestore.instance.collection("companies");
    var user = await FirebaseAuth.instance.currentUser;

    await t.where("email_advance", isEqualTo: user.email).get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          Provider.of<MyProvider>(context, listen: false).setCompId(element.id);
        });
      });
    });

    comp = await FirebaseFirestore.instance
        .collection("companies")
        .doc(Provider.of<MyProvider>(context, listen: false).company_id)
        .collection("chance");
    comp.get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          list.add(element.data());
          //listOfDate.add(element.data()["dateOfPublication"]);
          map[element.data()["title"]] = element.data()["accepted"];
        });
      });
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  Widget done() {
    return ListView.separated(
        itemBuilder: (context, i) {
          return Dismissible(
            onDismissed: (direction) async {
              // await comp.doc(lis[i]["id"]).delete();
            },
            key: UniqueKey(),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.black38,
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading:
                        Icon(Icons.apartment, size: 50, color: Colors.white),
                    title: Text(list.elementAt(i)["title"],
                        style: TextStyle(color: Colors.white)),
                    subtitle: Text(
                        list
                                .elementAt(i)["date_publication"]['day']
                                .toString() +
                            "/" +
                            list
                                .elementAt(i)["date_publication"]['month']
                                .toString() +
                            "/" +
                            list
                                .elementAt(i)["date_publication"]['year']
                                .toString(),
                        style: TextStyle(color: Colors.white)),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Provider.of<MyProvider>(context, listen: false)
                              .data1 = map[list.elementAt(i)["title"]];
                          Provider.of<MyProvider>(context, listen: false).data =
                              list.elementAt(i);
                          Provider.of<MyProvider>(context, listen: false)
                              .setChanceName(list.elementAt(i)["title"]);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return ProGamer();
                          }));
                        },
                        child: Text(
                          "تفاصيل",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, i) {
          return Divider(
            height: 2,
            color: Colors.amber,
            thickness: 3,
          );
        },
        itemCount: list.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: list.isEmpty
          ? CircularProgressIndicator()
          : StreamBuilder(
              stream: comp.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return Text(("Errorrrrrrrrr"));
                else if (snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();
                else
                  return done();
              }),
    );
  }
}
