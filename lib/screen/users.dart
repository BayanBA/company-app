import 'package:b/screen/showUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class show_user extends StatefulWidget {
  @override
  _show_userState createState() => _show_userState();
}

var item;
CollectionReference t = FirebaseFirestore.instance.collection("users");

class _show_userState extends State<show_user> {
  @override
  @override
  void initState() {
    item = new List();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var doc = snapshot.data.docs;
            return new ListView.builder(
                itemCount: doc.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        //print(doc[index].documentID);
                      },
                      child: Card(
                        child: Container(
                          margin: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text(
                                  doc[index].data()['firstname'],
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                Text(
                                  " " + doc[index].data()['endname'],
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ]),
                              Row(children: [
                                Text("   " + doc[index].data()['gender']),
                                Text(" , " + doc[index].data()['originalhome']),
                                Text(
                                    "                                                      "),
                                IconButton(
                                  onPressed: () {
                                    // print();
                                    item = new List();
                                    item.add(doc[index].data());
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new show_detals(item)));
                                  },
                                  icon: Icon(Icons.arrow_forward_ios),
                                  iconSize: 30,
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
                  );
                });
          } else {
            return LinearProgressIndicator();
          }
        },
      ),
    );
  }
}
