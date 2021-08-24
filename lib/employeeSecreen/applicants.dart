import 'package:b/screen/showUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stand.dart';

class Applicants extends StatefulWidget {
  @override
  _ApplicantsState createState() => _ApplicantsState();
}

class _ApplicantsState extends State<Applicants> {
  Map<String, Map<String, dynamic>> lis =
      new Map<String, Map<String, dynamic>>();
  var data1;
  var comp;
  var Sort_lis = new List();
  var Sort_lis1 = new List();

  var map = new Map<dynamic, String>();

  getData() async {
    comp = FirebaseFirestore.instance.collection("users");

    await comp.get().then((value) {
      if (value != null) {
        value.docs.forEach((element) {
          setState(() {
            if (data1["Presenting_A_Job"].contains(
                element.id)) if (data1["quiz"] == 1 || data1["quiz"] == 2) {
              if (data1["quiz_result"][element.id] >= 50) {
                map[data1["quiz_result"][element.id]] = element.id;
                lis[element.id] = element.data();
              }
            } else if (data1["quiz"] == 0) {
              lis[element.id] = element.data();
              Sort_lis.add(element.id);
            }
          });
        });
      }
    });

    if (data1["quiz"] == 1 || data1["quiz"] == 2) {
      var sortV = data1["quiz_result"].values.toList()..sort();
      for (var i in sortV) {
        for (var j in map.keys) {
          if (j == i) {
            Sort_lis1.add(map[j]);
          }
        }
      }
      for (int i = Sort_lis1.length - 1; i >= 0; i--)
        Sort_lis.add(Sort_lis1.elementAt(i));
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data1 = Provider.of<MyProvider>(context, listen: false).data;
    return Directionality(
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
              Center(
                child: lis.isEmpty
                    ? data1["Presenting_A_Job"].isEmpty
                        ? Center(
                            child: Text("لا يوجد متقدمين"),
                          )
                        : CircularProgressIndicator()
                    : StreamBuilder(
                        stream: comp.snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError)
                            return Text(("Errorrrrrrrrr"));
                          else if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return CircularProgressIndicator();
                          else
                            return A_user(context);
                        }),
              )
            ])));
  }

  var item, item_id;

  Widget A_user(context) {
    return Sort_lis.isEmpty
        ? Center(
            child: Text("لا يوجد متقدمين"),
          )
        : ListView.builder(
            itemCount: Sort_lis.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: InkWell(
                    child: Card(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text(
                                lis[Sort_lis.elementAt(index)]['firstname'],
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Text(
                                " " + lis[Sort_lis.elementAt(index)]['endname'],
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ]),
                            Row(children: [
                              Text("   " +
                                  lis[Sort_lis.elementAt(index)]['gender']),
                              Text(" , " +
                                  lis[Sort_lis.elementAt(index)]
                                      ['originalhome']),
                            ]),
                            (data1["quiz"] == 1 || data1["quiz"] == 2)
                                ? ButtonBar(
                                    children: <Widget>[
                                      Text(
                                          "${data1["quiz_result"][Sort_lis.elementAt(index)]}" +
                                              "%"),
                                    ],
                                  )
                                : ButtonBar(
                                    children: <Widget>[
                                      Text("لا يوجد اختبار"),
                                    ],
                                  )
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
                      item_id = new List();
                      item.add(lis[Sort_lis.elementAt(index)]);
                      item_id.add(Sort_lis.elementAt(index));

                      Provider.of<MyProvider>(context, listen: false)
                          .setUser(1);
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
  }
}
