import 'package:b/chanceScreen/detals.dart';
import 'package:b/chanceScreen/detalsT.dart';
import 'package:b/chanceScreen/detalsV.dart';
import 'package:b/screen/showUser.dart';
import 'package:b/screen/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stand.dart';

class Acceptable extends StatefulWidget {
  @override
  _AcceptableState createState() => _AcceptableState();
}

class _AcceptableState extends State<Acceptable> {
  List user = new List();
  var items_id;
  var item;
  int num = 0;

  getData() async {
    await FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          if (Provider.of<MyProvider>(context, listen: false)
              .data1["accepted"]
              .contains(element.id)) user.add(element.data());
        });
      });
      num = 1;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
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
              user.isEmpty
                  ? num == 0
                      ? CircularProgressIndicator()
                      : Center(
                          child: Column(
                            children: [
                              Text("لم يتم قبول أحد بعد"),
                              InkWell(
                                child: Text("تفقد المنشور"),
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return Provider.of<MyProvider>(context,
                                                    listen: false)
                                                .data1["chanceId"] ==
                                            0
                                        ? Detals()
                                        : Provider.of<MyProvider>(context,
                                                        listen: false)
                                                    .data1["chanceId"] ==
                                                1
                                            ? DetalsV()
                                            : DetalsT();
                                  }));
                                },
                              )
                            ],
                          ),
                        )
                  : Column(children: [

                      Expanded(
                        child: ListView.builder(
                            itemCount: user.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  child: InkWell(
                                    child: Card(
                                      child: Container(
                                        margin: EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(children: [
                                              Text(
                                                user.elementAt(
                                                    index)['firstname'],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                " " +
                                                    user.elementAt(
                                                        index)['endname'],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ]),
                                            Row(children: [
                                              Text("   " +
                                                  user.elementAt(
                                                      index)['gender']),
                                              Text(" , " +
                                                  user.elementAt(
                                                      index)['originalhome']),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      elevation: 8,
                                      shadowColor: Colors.green,
                                      shape: BeveledRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    onTap: () {
                                      item = new List();
                                      item_id = new List();
                                      item.add(user.elementAt(index));
                                      item_id.add(user.elementAt(index)["id"]);

                                      Provider.of<MyProvider>(context,
                                              listen: false)
                                          .setUser(2);
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new show_detals(
                                                      item, item_id)));
                                    },
                                  ),
                                ),
                              );
                            }),
                      ),
                    ])
            ])));
  }
}
