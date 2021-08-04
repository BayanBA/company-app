import 'package:b/screen/showUser.dart';
import 'package:b/screen/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  var lis=new List();

  CollectionReference favor;
  CollectionReference user;


  dd() async {
    favor = FirebaseFirestore.instance.collection("companies").doc("iWHfsiUuasdPyC5BZqoY").collection("favorite");
    user = FirebaseFirestore.instance.collection("users");
    await favor.get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          my.add(element.data());
          favor.doc(element.id).update({"idb": element.id});
        });
      });
    });
    await user.get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          for (int i = 0; i < my.length; i++) {
            if (element.id == my.elementAt(i)['id']) {
              setState(() {
                id.add(element.id);
                lis.add(element.data());
              });

            }

          }
        });
      });
    });
  }

  void initState() {
    dd();
    super.initState();
  }

  Widget done() {

    return ListView.separated(
        itemBuilder: (context, i) {
          return Dismissible(
            onDismissed: (direction) async {
              await favor.doc(my[i]["idb"]).delete();
            },
            key: UniqueKey(),
            child: InkWell(
              onTap: () {

                item = new List();
                item_id= new List();
                item.add(lis[i]);
                item_id.add("");
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      Provider.of<MyProvider>(context,listen: false).data=lis[i];
                      return show_detals(item,item_id);}));
              },
              child: ListTile(
                title: Text(lis[i]["firstname"]),
                subtitle: Text(lis[i]["endname"]),
              ),
            ),
          );
        },
        separatorBuilder: (context, i) {
          return Divider(
            height: 2,
            color: Colors.amber,
            thickness: 3,
          );
        },
        itemCount: id.length);

  }


  Widget build(BuildContext context) {

    return  lis.isEmpty
                  ? CircularProgressIndicator()
                  : StreamBuilder(
                  stream: user.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      return Text(("Errorrrrrrrrr"));
                    else if (snapshot.connectionState == ConnectionState.waiting)
                      return CircularProgressIndicator();
                    else
                      return done();
                  });
  }


}
