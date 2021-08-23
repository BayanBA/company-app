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
  GlobalKey<FormState> ff = new GlobalKey<FormState>();
  GlobalKey<FormState> ff1 = new GlobalKey<FormState>();
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
                  : ListView(children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    key: ff1,
                    child: Container(
                      margin: EdgeInsets.only(left: 22, right: 22),
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.0),
                              topRight: Radius.circular(50.0),
                              bottomLeft:Radius.circular(50.0) ,
                              bottomRight: Radius.circular(50.0))),
                      child: Container(
                        margin:
                        EdgeInsets.only(left: 20, right: 20,top:8,bottom: 8),
                        padding:
                        EdgeInsets.only(left: 20, bottom: 10,right: 20),
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                topRight: Radius.circular(50.0),
                                bottomLeft:Radius.circular(50.0) ,
                                bottomRight:
                                Radius.circular(50.0))),
                        child: TextFormField(
                          initialValue: data["title"],
                          onSaved: (val) {
                            data["title"] = val;
                          },
                          onChanged: (val) {
                            data["title"] = val;
                          },
                          onEditingComplete: (){
                            FocusScope.of(context).unfocus();
                          },
                          decoration: InputDecoration(

                            hintText: 'العنوان',
                          ),
                        ),
                      ),
                    ),
                  ),),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Form(
                        key: ff,
                        child: Container(
                          margin: EdgeInsets.only(left: 22, right: 22),
                          height: 500,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50.0),
                                  topRight: Radius.circular(50.0),
                                  bottomLeft:Radius.circular(50.0) ,
                                  bottomRight: Radius.circular(50.0))),
                          child: Container(
                            margin:
                            EdgeInsets.only(left: 20, right: 20,top:10,bottom: 5),
                            padding:
                            EdgeInsets.only(left: 20, bottom: 10,right: 30,top: 20),
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0),
                                    bottomLeft:Radius.circular(50.0) ,
                                    bottomRight:
                                    Radius.circular(50.0))),
                            child: TextFormField(
                              initialValue: data["myPost"],
                              onSaved: (val) {
                                data["myPost"] = val;
                              },
                              onChanged: (val) {
                                data["myPost"] = val;
                              },
                              onEditingComplete: (){
                                FocusScope.of(context).unfocus();
                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(

                                hintText: 'المنشور',
                              ),
                              maxLines: 30,
                            ),
                          ),
                        ))),
              ])
            ])));
  }
}
