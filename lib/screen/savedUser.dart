import 'package:b/screen/showUser.dart';
import 'package:b/screen/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stand.dart';


class saves extends StatefulWidget {
  @override
  _savesState createState() => _savesState();
}
class _savesState extends State<saves> {
  var my = new List();
  var id = new List();
  var batool=new List();

  CollectionReference favor;
  CollectionReference user;


  dd() async {

    CollectionReference ref =FirebaseFirestore.instance.collection("companies");
    var userr = await FirebaseAuth.instance.currentUser;


   var v = FirebaseFirestore.instance
        .collection("companies")
        .doc(Provider.of<MyProvider>(context, listen: false).company_id)
        .collection("favorite");



    user = FirebaseFirestore.instance.collection("users");
    await v.get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          v.doc(element.id).update({"idb": element.id});

          my.add(element.data());
        });
      });
    });
    await user.get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          for (int i = 0; i < my.length; i++) {
            if (element.id == my.elementAt(i)['id']) {
              id.add(element.id);
              batool.add(element.data());
            }

          }
        });
      });
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
  void initState() {
    dd();
    super.initState();
  }

  Widget build(BuildContext context) {

    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            actions: [],
            title: Container(
              margin: EdgeInsets.only(top:20,right: 60),
              child: Text("الموظفون لدي",style: TextStyle(color: Theme.of(context).accentColor,fontSize: 30),),
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
            ),
            batool.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                itemCount: batool.length,
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
                                              child:
                                              Column(children: <Widget>[
                                                getimage(index),
                                              ]))),
                                      Expanded(
                                          flex: 2,
                                          child: ListTile(
                                            title: Text(
                                              batool.elementAt(index)['firstname'] +
                                                  "  " +
                                                  batool.elementAt(index)['endname'],
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 25.0,
                                              ),
                                            ),
                                            subtitle: Text(
                                              batool.elementAt(index)[
                                              'originalhome'] +
                                                  ", " +
                                                  batool.elementAt(index)[
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
                          item.add(batool.elementAt(index));
                          item_id.add(batool.elementAt(index)["id"]);

                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                  new show_detals(item, item_id)));
                        },
                      ),
                    ),
                  );
                }) ,
          ],
        )

    ))
    ;

  }


}
