import 'package:b/screen/myEmploy.dart';
import 'package:b/screen/showUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stand.dart';

class show_user extends StatefulWidget {
  @override
  _show_userState createState() => _show_userState();
}

var item;
var item_id;
var batool;

class _show_userState extends State<show_user> {
  @override
  void initState() {
    item = new List();
    item_id = new List();
    batool = new List();

    getData();
    super.initState();
  }

  getData() async {
    CollectionReference t = FirebaseFirestore.instance.collection("users");
    await t.get().then((value) {
      if (value != null) {
        value.docs.forEach((element) {
          setState(() {
            batool.add(element.data());
          });
        });
      }
    });
  }

  Widget getimage(int i) {
    // setState(() {
    return CircleAvatar(
      backgroundColor: Theme.of(context).accentColor,
      radius: 40,
      backgroundImage: batool[i]['imageurl'] == "not"
          ? AssetImage("images/55.jpeg")
          : NetworkImage(batool[i]['imageurl']),
    );
    //});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            actions: [],
            title: Container(
              margin: EdgeInsets.only(top: 20, right: 60),
              child: Text(
                "كل الموظفين",
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 30),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(70.0),
              ),
            ),
          ),
        ),
        body:Stack(
          children: [
          Opacity(
          opacity: 0.4,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: new AssetImage("images/55.jpeg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Color(0xFFB71C1C), BlendMode.overlay))),
          ),
        ), batool.isEmpty
            ? Center(child: CircularProgressIndicator())
            : StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var doc = snapshot.data.docs;
                    return new ListView.builder(
                        itemCount: doc.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: InkWell(
                                child: Card(
                                  child: Container(
                                      margin: EdgeInsets.all(20),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                      child: Column(
                                                          children: <Widget>[
                                                        getimage(index),
                                                      ]))),
                                              Expanded(
                                                  flex: 2,
                                                  child: ListTile(
                                                    title: Text(
                                                      doc[index].data()[
                                                              'firstname'] +
                                                          "  " +
                                                          doc[index].data()[
                                                              'endname'],
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontSize: 25.0,
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      doc[index].data()[
                                                              'originalhome'] +
                                                          ", " +
                                                          doc[index].data()[
                                                              'placerecident'],
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.0,
                                                      ),
                                                    ),
                                                  ))
                                            ])
                                          ])),
                                  elevation: 8,
                                  shadowColor: Colors.green,
                                  shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                                onTap: () {
                                  item = new List();
                                  item_id = new List();
                                  item.add(doc[index].data());
                                  item_id.add(doc[index].id);

                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new show_detals(item, item_id)));
                                },
                              ),
                            ),
                          );
                        });
                  } else {
                    return LinearProgressIndicator();
                  }
                },
              )]));
  }
}
