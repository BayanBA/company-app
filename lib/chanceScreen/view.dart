import 'package:b/chanceScreen/detals.dart';
import 'package:b/search.dart';
import 'package:b/stand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowingData extends StatefulWidget {
  @override
  _ShowingDataState createState() => _ShowingDataState();
}

class _ShowingDataState extends State<ShowingData> {
  var lis = new List();
  var list = new List();


  CollectionReference comp;

  getData() async {
    comp = FirebaseFirestore.instance.collection("companies").doc(Provider.of<MyProvider>(context, listen: false).company_id).collection("chance");
    await comp.get().then((value) {
      if (value != null) {
        value.docs.forEach((element) {
          comp.doc(element.id).update({"id": element.id});
        });
      }
    });

    await comp.get().then((value) {
      if (value != null) {
        value.docs.forEach((element) {
          setState(() {
            lis.add(element.data());
          });
        });
      }
    });
    for(int i=0;i<lis.length;i++)
      this.list.add(lis.elementAt(i)["title"]);

  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget done() {

    return ListView.separated(
        itemBuilder: (context, i) {
          return Dismissible(
            onDismissed: (direction) async {
              await comp.doc(lis[i]["id"]).delete();
            },
            key: UniqueKey(),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      Provider.of<MyProvider>(context,listen: false).data=lis[i];
                     return Detals();}));
              },
              child: ListTile(
                title: Text(lis[i]["title"]),
                subtitle: Text(lis[i]["dateOfPublication"]),
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
        itemCount: lis.length);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
        body: Center(
          child: lis.isEmpty
              ? CircularProgressIndicator()
              : StreamBuilder(
                  stream: comp.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      return Text(("Errorrrrrrrrr"));
                    else if (snapshot.connectionState == ConnectionState.waiting)
                      return CircularProgressIndicator();
                    else
                      return done();
                  }),
        ));
  }
}
