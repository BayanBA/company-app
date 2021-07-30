import 'package:b/screen/showUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class show_user extends StatefulWidget {
  @override
  _show_userState createState() => _show_userState();
}

var item;
var item_id;
CollectionReference t = FirebaseFirestore.instance.collection("users");

class _show_userState extends State<show_user> {
  @override
  @override
  void initState() {
    item = new List();
    item_id = new List();
    super.initState();
  }

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
              body: StreamBuilder<QuerySnapshot>(
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
                            child: GestureDetector(
                              // onTap: () {
                              //   //print(doc[index].documentID);
                              // },

                            child:InkWell(
                              child: Card(
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Text(
                                          doc[index].data()['firstname'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                        Text(

                                          " " + doc[index].data()['endname'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ]),
                                      Row(children: [
                                        Text("   " +

                                            doc[index].data()['gender']),
                                        Text(" , " +
                                            doc[index].data()['originalhome']),


                                      ]),
                                    ],
                                  ),
                                ),
                                elevation: 8,
                                shadowColor: Colors.green,
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              onTap: () {



                                item = new List();
                                item_id= new List();
                                    item.add(doc[index].data());
                                    item_id.add(doc[index].id);





                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new show_detals(item,item_id)));
                              },
                            ),
                            ),
                          );
                        });
                  } else {
                    return LinearProgressIndicator();
                  }
                },
              ),
            ));
  }
}
