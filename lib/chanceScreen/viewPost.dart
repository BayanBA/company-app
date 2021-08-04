import 'package:b/chanceScreen/detals.dart';
import 'package:b/chanceScreen/postDetals.dart';
import 'package:b/search.dart';
import 'package:b/stand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowingPost extends StatefulWidget {
  @override
  _ShowingPostState createState() => _ShowingPostState();
}

class _ShowingPostState extends State<ShowingPost> {
  var lis = new List();

  CollectionReference comp;

  getData() async {
    comp = FirebaseFirestore.instance
        .collection("companies")
        .doc(Provider.of<MyProvider>(context, listen: false).company_id)
        .collection("Post");
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
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.black38,
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.apartment,
                      size: 50,
                      color: Colors.white,
                    ),
                    title: Text(lis[i]["title"],
                        style: TextStyle(color: Colors.white)),
                    subtitle: Text(lis[i]["dateOfPublication"],
                        style: TextStyle(color: Colors.white)),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            Provider.of<MyProvider>(context, listen: false)
                                .data = lis[i];
                            return PostDetals();
                          }));
                        },
                        child: Text("تعديل",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
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
                            return done();
                        }),
              )
            ])));
  }
}
