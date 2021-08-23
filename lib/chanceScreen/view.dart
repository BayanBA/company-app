import 'package:b/chanceScreen/detals.dart';
import 'package:b/chanceScreen/detalsV.dart';
import 'package:b/search.dart';
import 'package:b/stand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detalsT.dart';

class ShowingData extends StatefulWidget {
  @override
  _ShowingDataState createState() => _ShowingDataState();
}

var list=new List();

class _ShowingDataState extends State<ShowingData> {

  getdata()async{
   await FirebaseFirestore.instance
        .collection("companies")
        .doc(Provider.of<MyProvider>(context, listen: false)
        .company_id)
        .collection("chance").get().then((value){
          value.docs.forEach((element) {
            list.add(element.data()["title"]);
          });
    });
  }
  void initState() {
    getdata();
    super.initState();
  }


  CollectionReference comp;

  Widget done(lis) {
    return ListView.builder(
        itemBuilder: (context, i) {
          return Dismissible(
              onDismissed: (direction) async {
                await comp.doc(lis[i]["id"]).delete();
              },
              key: UniqueKey(),
              child:
              Padding(
                padding: const EdgeInsets.only(top:20,right: 8,left: 8),
                child: Container(
                  margin: EdgeInsets.only(left: 24, right: 24),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          bottomRight: Radius.circular(50.0))),
                  child: Container(
                      margin: EdgeInsets.only(left: 22, right: 22),
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.0),
                              bottomRight: Radius.circular(50.0))),
                      child:
                      Container(
                        margin:
                        EdgeInsets.only(left: 20, right: 20,top:2,bottom: 2),
                        padding:
                        EdgeInsets.only(left: 20, bottom: 10),
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                bottomRight:
                                Radius.circular(50.0))),
                        child:
                        InkWell(
                          child: ListTile(
                            leading: Icon(
                              Icons.apartment,
                              size: 50,
                              color: Colors.lime,
                            ),
                            title: Text(lis[i]["title"],
                                style: TextStyle(color: Colors.black)),
                            subtitle: Text(
                                lis[i]["date_publication"]['day'].toString() +
                                    "/" +
                                    lis[i]["date_publication"]['month'].toString() +
                                    "/" +
                                    lis[i]["date_publication"]['year'].toString(),
                                style: TextStyle(color: Colors.black)),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              Provider.of<MyProvider>(context, listen: false).data =
                                  lis[i].data();
                              return lis[i]["chanceId"] == 0
                                  ? Detals()
                                  : lis[i]["chanceId"] == 1
                                  ? DetalsV()
                                  : DetalsT();
                            }));
                          },
                        ),

                      )),
                ),
              )
          );
        },
        // separatorBuilder: (context, i) {
        //   return SizedBox(
        //     height: 10,
        //   );
        // },
        itemCount: lis.length);
  }
  //
  // Widget done(lis) {
  //   return ListView.separated(
  //       itemBuilder: (context, i) {
  //         return Dismissible(
  //           onDismissed: (direction) async {
  //             await comp.doc(lis[i]["id"]).delete();
  //           },
  //           key: UniqueKey(),
  //           child: Card(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(15.0),
  //             ),
  //             color: Colors.black38,
  //             elevation: 10,
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 ListTile(
  //                   leading:
  //                       Icon(Icons.apartment, size: 50, color: Colors.white),
  //                   title: Text(lis[i]["title"],
  //                       style: TextStyle(color: Colors.white)),
  //                 ),
  //                 InkWell(
  //                   onTap: () {
  //                     Navigator.of(context)
  //                         .push(MaterialPageRoute(builder: (context) {
  //                       Provider.of<MyProvider>(context, listen: false).data =
  //                           lis[i].data();
  //                       return lis[i]["chanceId"] == 0
  //                           ? Detals()
  //                           : lis[i]["chanceId"] == 1
  //                               ? DetalsV()
  //                               : DetalsT();
  //                     }));
  //                   },
  //                   child: Text(
  //                     "تعديل",
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                     ),
  //                     textAlign: TextAlign.right,
  //                   ),
  //                 ),
  //                 ButtonBar(
  //                   children: <Widget>[
  //                     Text(
  //                         lis[i]["date_publication"]['day'].toString() +
  //                             "/" +
  //                             lis[i]["date_publication"]['month'].toString() +
  //                             "/" +
  //                             lis[i]["date_publication"]['year'].toString(),
  //                         style: TextStyle(color: Colors.white)),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //       separatorBuilder: (context, i) {
  //         return Divider(
  //           height: 2,
  //           color: Colors.amber,
  //           thickness: 3,
  //         );
  //       },
  //       itemCount: lis.length);
  // }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100.0),
              child: AppBar(
                actions: [
                  IconButton(
                    tooltip: 'Search',
                    icon: const Icon(Icons.search),
                    onPressed: () async {
                      await showSearch(
                          context: context,
                          delegate: datasearch(list)

                      );
                    }

    ),
                ],
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
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("companies")
                        .doc(Provider.of<MyProvider>(context, listen: false)
                            .company_id)
                        .collection("chance")
                        .orderBy("date", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {


                        if(snapshot.connectionState==ConnectionState.waiting)
                        return CircularProgressIndicator();
                        else if (snapshot.data== null)
                      return Center(
                      child: Text("لم يتم نشر أي فرصة"),
                      );
                      else if (snapshot.hasData)
                        return done(snapshot.data.docs);
                      else
                        return CircularProgressIndicator();
                    }),
              )
            ])));
  }
}
