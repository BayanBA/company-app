import 'package:b/postSecreen/postDetals.dart';
import 'package:b/screen/showUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stand.dart';

class notifcation extends StatefulWidget {
  @override
  _notifcationState createState() => _notifcationState();
}

class _notifcationState extends State<notifcation> {
  var my = new List();
  var id = new List();
  var lis = new List();
  var item=new List();
  var items_id=new List();
  String u;
  var k = 0;
  var v;
  var n;

  CollectionReference user;

  dd() async {
    CollectionReference ref =
    FirebaseFirestore.instance.collection("companies");
    CollectionReference num = FirebaseFirestore.instance.collection("number");

    var userr = await FirebaseAuth.instance.currentUser;
    await ref
        .where("email_advance", isEqualTo: userr.email)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        u = element.id;
        print(u);
      });
    });
    v = FirebaseFirestore.instance
        .collection("companies")
        .doc(u)
        .collection("notification");

    await v.get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          if (DateTime.now().year.toString() ==
              element.data()["date_publication"]['year'].toString() &&
              DateTime.now().month.toString() ==
                  (element.data()["date_publication"]['month'].toString())) {
            if (DateTime.now().day.toInt() >=
                element.data()["date_publication"]['day'] &&
                element.data()['date_publication']['day'] >
                    (DateTime.now().day.toInt() - 7)) my.add(element.data());
          }
        });
      });
    });

  }

  void initState() {
    dd();

    super.initState();
  }
  String h;
  @override
  Widget build(BuildContext context) {
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
          body: my.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
              itemCount: my.length,
              itemBuilder: (context, index) {
                return Column(
                    children: [Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          child: InkWell(
                            child: Container(

                                margin: EdgeInsets.all(10),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Expanded(
                                            child: ListTile(
                                                title: Text(
                                                  my[index]['title'],
                                                  style: TextStyle(
                                                    color: Theme.of(context).primaryColor,
                                                    fontSize: 22.0,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  my[index]['body'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                                leading:
                                                Column(children: <Widget>[
                                                  CircleAvatar(
                                                    backgroundColor:
                                                    Theme.of(context).accentColor,
                                                    radius: 25.0,
                                                    child: Text(
                                                      '${index + 1}',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 25.0,
                                                      ),
                                                    ),
                                                  ),
                                                ]))),

                                      ]),

                                    ])),
                          ),
                          onTap: () async{
                            items_id=new List();
                            item=new List();
                            items_id.add(my[index]['user_Id']);
                            if( my[index]['num']==1)
                            {
                              var user = FirebaseFirestore.instance.collection("users");
                              await user.get().then((value) {
                                value.docs.forEach((element) {
                                  setState(() {
                                    if (my[index]['user_Id'] == element.id )
                                    {item.add(element.data());
                                    print(item);}


                                  });
                                });
                              });

                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                      new show_detals(
                                          item, items_id)));}
                            else
                            {
                              var comp = FirebaseFirestore.instance
                                  .collection("companies")
                                  .doc(Provider.of<MyProvider>(context, listen: false).company_id)
                                  .collection("Post");

                              await comp.get().then((value) {
                                if (value != null) {
                                  value.docs.forEach((element) {
                                    if (my[index]['post_Id'] == element.id )
                                    {h=element.id;
                                    }

                                  });
                                }
                              });
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                      new PostDetals(
                                          h)));}

                          }
                      ),
                    ),
                      Divider(
                        height: 2,
                        color: Theme.of(context).primaryColor,
                        thickness: 3,
                      ),]
                );
              })),
    );
  }
}
