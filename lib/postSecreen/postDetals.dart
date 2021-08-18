import 'dart:async';

import 'package:b/postSecreen/postUpdate.dart';
import 'package:b/stand.dart';
import 'package:b/chanceScreen/updatData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostDetals extends StatefulWidget {
  @override
  _PostDetalsState createState() => _PostDetalsState();
}

class _PostDetalsState extends State<PostDetals> {
  var data = new Map<String, dynamic>();
  var comp;

  getData() async {
    comp = FirebaseFirestore.instance
        .collection("companies")
        .doc(Provider.of<MyProvider>(context, listen: false).company_id)
        .collection("Post");

    await comp.get().then((value) {
      if (value != null) {
        value.docs.forEach((element) {
          setState(() {
            if (element.id ==
                Provider.of<MyProvider>(context, listen: false).data["id"])
              data = element.data();
          });
        });
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //data = Provider.of<MyProvider>(context, listen: false).data;
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
              data.isEmpty
                  ? CircularProgressIndicator()
                  : StreamBuilder(
                      stream: comp.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError)
                          return Text(("Errorrrrrrrrr"));
                        else if (snapshot.connectionState ==
                            ConnectionState.waiting)
                          return CircularProgressIndicator();
                        else
                          return ListView(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    data["title"],
                                    style: TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: Colors.black38,
                                    elevation: 10,
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        data["myPost"],
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                              ),
                              Center(
                                child: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return PostUpdate();
                                    }));
                                    setState(() {
                                      data = Provider.of<MyProvider>(context,
                                              listen: false)
                                          .data;
                                    });
                                  },
                                ),
                              )
                            ],
                          );
                      }),
            ])));
  }
}
