import 'package:b/chanceScreen/detals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stand.dart';
import 'applicantsDetals.dart';

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
    CollectionReference t = FirebaseFirestore.instance.collection("users");
    await t.get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          if (Provider.of<MyProvider>(context, listen: false)
              .data1
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
                                    return Detals();
                                  }));
                                },
                              )
                            ],
                          ),
                        )
                  : Column(children: [
                      Center(
                        child: Card(
                          child: Text(
                              Provider.of<MyProvider>(context, listen: false)
                                  .chanceName),
                          borderOnForeground: true,
                          color: Colors.lightGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: user.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                child: Text(user.elementAt(index)["firstname"] +
                                    user.elementAt(index)["endname"]),
                                onTap: () {
                                  items_id=new List();
                                   items_id.add(user.elementAt(index)["id"]);
                                  item=new List();
                                  item.add(user.elementAt(index));
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (context) {
                                    return ApplicantsDetals(item,items_id);

                                  }));
                                },
                              );
                            }),
                      ),
                    ])
            ])));
  }
}
